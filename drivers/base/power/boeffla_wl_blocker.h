/*
 * Author: andip71, 01.09.2017
 *
 * Version 1.1.0
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#define BOEFFLA_WL_BLOCKER_VERSION	"1.1.0"

#define LIST_WL_DEFAULT				"qcom_rx_wakelock;wlan;wlan_wow_wl;wlan_extscan_wl;netmgr_wl;NETLINK;IPA_WS;[timerfd];wlan_ipa;wlan_pno_wl;wcnss_filter_lock;hal_bluetooth_lock;epoll_InputReader_file;event4;epoll_InputReader_file:event4;IPCRTR_dsps_rx;epoll_healthd_file:NETLINK;epoll_healthd_epollfd;epoll_InputReader_file:event1;epoll_InputReader_file:event2;epoll_InputReader_epollfd;epoll_system_server_file:[timerfd8_system_server];epoll_system_server_file:[timerfd5_system_server];epoll_system_server_file:[timerfd6_system_server]"

#define LENGTH_LIST_WL				1000
#define LENGTH_LIST_WL_DEFAULT		502
#define LENGTH_LIST_WL_SEARCH		LENGTH_LIST_WL + LENGTH_LIST_WL_DEFAULT + 5
