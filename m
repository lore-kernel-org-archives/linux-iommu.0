From: Lutz Vieweg <lvml@5t9.de>
Subject: Re: AMD-Vi: Event logged IO_PAGE_FAULT - ixgbe
 Detected Tx Unit Hang - Reset adapter - master disable timed out
Date: Mon, 13 Jun 2016 19:46:37 +0200
Message-ID: <575EF17D.6020905@5t9.de>
References: <loom.20160606T232112-817@post.gmane.org>	<CAKgT0UfEGS_QzM1phGKRV1hDgcnAwX-BqMkyQ6KJUOv82_kCiA@mail.gmail.com>	<nj64hf$9v5$1@ger.gmane.org>	<CAKgT0UfKUkrsXqLm4KdjXgLZ6QXZp5Rf-yYA3pBSzc1=ghJ4CQ@mail.gmail.com>	<njbvjb$40r$1@ger.gmane.org>	<CAKgT0UeFM1jYTU83YFohxUHWuJeTYfWDpdFM2CDQCutmf_vXvA@mail.gmail.com>
	<20160613090803.GC29948@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <e1000-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20160613090803.GC29948@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=e1000-devel>
List-Post: <mailto:e1000-devel@lists.sourceforge.net>
List-Help: <mailto:e1000-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/e1000-devel>,
	<mailto:e1000-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: e1000-devel-bounces@lists.sourceforge.net
To: e1000-devel@lists.sourceforge.net
Cc: iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 06/13/2016 11:08 AM, Joerg Roedel wrote:
> On Thu, Jun 09, 2016 at 09:03:40AM -0700, Alexander Duyck wrote:
>>>> Jun  9 14:40:09 computer kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=04:00.0 domain=0x000e address=0x00000000000178c0 flags=0x0050]
>>>> Jun  9 14:40:09 computer kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=04:00.0 domain=0x000e address=0x0000000000017900 flags=0x0050]
>
> Some more context would be helpful. Which kernel version was the last
> that worked and with which version do you start to see these messages?

Two servers were running linux-4.4.2 for many months,
both with 10Gbase-T NICs connected to the same switch, without
any such outage.

Both servers were recently upgraded to linux-4.6.1, and one
of the servers so far twice showed this "IO_PAGE_FAULT" symptom
within a period of ~ 7 days.

The hardware of the two servers is the same except for the
model of the Intel 10Gbase-T NIC: The server with the two fails
runs a fairly new
  Intel Corporation Ethernet Controller 10-Gigabit X540-AT2 (rev 01)
while the other server (without symptoms so far) runs a much older
  Intel Corporation 82598EB 10-Gigabit AT Network Connection (rev 01)
both using the same ixgbe driver module.

(Since both servers are working as a shared-nothing-cluster, they
pretty much do the same.)

Regards,

Lutz Vieweg


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
_______________________________________________
E1000-devel mailing list
E1000-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/e1000-devel
To learn more about Intel&#174; Ethernet, visit http://communities.intel.com/community/wired
