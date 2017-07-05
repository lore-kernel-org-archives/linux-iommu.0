From: Ray Jui via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 0/8] io-pgtable lock removal
Date: Wed, 5 Jul 2017 16:24:22 -0700
Message-ID: <5149280b-a214-249c-c5e2-3712b1f941d2@broadcom.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
	<458ad41d-6679-eeca-3c0f-13ccb6c933b6@codeaurora.org>
	<b7830be1-9a78-e29f-a29c-4798aaa28c0a@broadcom.com>
	<cdc1799b-f142-09ed-a7e5-d7fd2e70268f@arm.com>
	<e43ba1fe-696e-fabb-a800-52fadaa2fa93@broadcom.com>
	<20170628114609.GD11053@arm.com>
	<87d53115-3d80-5a3d-6632-c31986cb7018@broadcom.com>
	<20170704173155.GN22175@arm.com>
	<6814b246-22f0-bfaa-5002-a269b2735116@broadcom.com>
	<2d5f5ef3-32b1-76c6-6869-ff980557f8e8@broadcom.com>
	<20170705084143.GA9378@arm.com>
Reply-To: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170705084143.GA9378-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 7/5/17 1:41 AM, Will Deacon wrote:
> On Tue, Jul 04, 2017 at 06:45:17PM -0700, Ray Jui wrote:
>> Hi Will/Robin,
>>
>> Has anything functionally changed between PATCH v2 and v1? I'm seeing a
>> very different L2 throughput with v2 (in general a lot worse with v2 vs.
>> v1); however, I'm currently unable to reproduce the TLB sync timed out
>> issue with v2 (without the patch from Will's email).
>>
>> It could also be something else that has changed in my setup, but so far
>> I have not yet been able to spot anything wrong in the setup.
> 
> There were fixes, and that initially involved a DSB that was found to be
> expensive. The patches queued in -next should have that addressed, so please
> use those (or my for-joerg/arm-smmu/updates branch).
> 
> Will
> 

That was my bad yesterday. I was in a rush and the setup was incorrect.

I redo my Ethernet performance test with both PATCH v1 and v2 today, and
can confirm the performance is consistent between v1 and v2 as expected.

I also made sure the following message can still be reproduced with
patch set v2:

arm-smmu 64000000.mmu: TLB sync timed out -- SMMU may be deadlocked

Then I proceeded to apply your patch that attempt to fix the deadlock
issue. I also added a print to ensure I'm running the correct build with
your fix patch applied:

diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index cd8d7aa..01a6fa8 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -60,6 +60,7 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum
io_pgtable_fmt fmt,
        iop->cfg        = *cfg;

        atomic_set(&iop->tlb_sync_pending, 0);
+       pr_err("tlb sync pending cleared\n");
        return &iop->ops;
 }

root@bcm958742k:~# dmesg | grep tlb
[    6.495754] tlb sync pending cleared
[    6.509934] tlb sync pending cleared
[    6.510067] tlb sync pending cleared
[    6.510207] tlb sync pending cleared
[    9.864543] tlb sync pending cleared
[    9.874019] tlb sync pending cleared
[    9.979311] tlb sync pending cleared
[   39.616465] tlb sync pending cleared


However, with the fix patch, I can still see the deadlock message when I
have > 32 iperf TX threads active in the system:

root@bcm958742k:~# iperf -c 192.168.1.20 -P64
------------------------------------------------------------
Client connecting to 192.168.1.20, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[ 66] local 192.168.1.10 port 48802 connected with 192.168.1.20 port 5001
[  6] local 192.168.1.10 port 48680 connected with 192.168.1.20 port 5001
[ 22] local 192.168.1.10 port 48710 connected with 192.168.1.20 port 5001
[ 50] local 192.168.1.10 port 48770 connected with 192.168.1.20 port 5001
[ 32] local 192.168.1.10 port 48734 connected with 192.168.1.20 port 5001
[ 23] local 192.168.1.10 port 48716 connected with 192.168.1.20 port 5001
[ 21] local 192.168.1.10 port 48712 connected with 192.168.1.20 port 5001
[ 10] local 192.168.1.10 port 48688 connected with 192.168.1.20 port 5001
[ 56] local 192.168.1.10 port 48782 connected with 192.168.1.20 port 5001
[ 31] local 192.168.1.10 port 48732 connected with 192.168.1.20 port 5001
[ 63] local 192.168.1.10 port 48796 connected with 192.168.1.20 port 5001
[ 58] local 192.168.1.10 port 48786 connected with 192.168.1.20 port 5001
[ 19] local 192.168.1.10 port 48706 connected with 192.168.1.20 port 5001
[ 47] local 192.168.1.10 port 48764 connected with 192.168.1.20 port 5001
[ 25] local 192.168.1.10 port 48720 connected with 192.168.1.20 port 5001
[ 34] local 192.168.1.10 port 48738 connected with 192.168.1.20 port 5001
[ 64] local 192.168.1.10 port 48798 connected with 192.168.1.20 port 5001
[ 52] local 192.168.1.10 port 48774 connected with 192.168.1.20 port 5001
[ 59] local 192.168.1.10 port 48788 connected with 192.168.1.20 port 5001
[ 30] local 192.168.1.10 port 48730 connected with 192.168.1.20 port 5001
[ 65] local 192.168.1.10 port 48800 connected with 192.168.1.20 port 5001
[ 17] local 192.168.1.10 port 48702 connected with 192.168.1.20 port 5001
[ 20] local 192.168.1.10 port 48708 connected with 192.168.1.20 port 5001
[ 44] local 192.168.1.10 port 48758 connected with 192.168.1.20 port 5001
[ 55] local 192.168.1.10 port 48780 connected with 192.168.1.20 port 5001
[ 33] local 192.168.1.10 port 48736 connected with 192.168.1.20 port 5001
[ 62] local 192.168.1.10 port 48794 connected with 192.168.1.20 port 5001
[ 60] local 192.168.1.10 port 48790 connected with 192.168.1.20 port 5001
[ 14] local 192.168.1.10 port 48696 connected with 192.168.1.20 port 5001
[ 28] local 192.168.1.10 port 48726 connected with 192.168.1.20 port 5001
[ 53] local 192.168.1.10 port 48776 connected with 192.168.1.20 port 5001
[ 42] local 192.168.1.10 port 48754 connected with 192.168.1.20 port 5001
[ 16] local 192.168.1.10 port 48700 connected with 192.168.1.20 port 5001
[  3] local 192.168.1.10 port 48678 connected with 192.168.1.20 port 5001
[ 29] local 192.168.1.10 port 48728 connected with 192.168.1.20 port 5001
[ 27] local 192.168.1.10 port 48724 connected with 192.168.1.20 port 5001
[ 38] local 192.168.1.10 port 48746 connected with 192.168.1.20 port 5001
[ 13] local 192.168.1.10 port 48694 connected with 192.168.1.20 port 5001
[ 12] local 192.168.1.10 port 48692 connected with 192.168.1.20 port 5001
[ 41] local 192.168.1.10 port 48752 connected with 192.168.1.20 port 5001
[ 26] local 192.168.1.10 port 48722 connected with 192.168.1.20 port 5001
[ 11] local 192.168.1.10 port 48690 connected with 192.168.1.20 port 5001
[ 24] local 192.168.1.10 port 48718 connected with 192.168.1.20 port 5001
[ 15] local 192.168.1.10 port 48698 connected with 192.168.1.20 port 5001
[ 37] local 192.168.1.10 port 48744 connected with 192.168.1.20 port 5001
[ 36] local 192.168.1.10 port 48742 connected with 192.168.1.20 port 5001
[ 43] local 192.168.1.10 port 48756 connected with 192.168.1.20 port 5001
[ 48] local 192.168.1.10 port 48766 connected with 192.168.1.20 port 5001
[ 45] local 192.168.1.10 port 48760 connected with 192.168.1.20 port 5001
[ 35] local 192.168.1.10 port 48740 connected with 192.168.1.20 port 5001
[  7] local 192.168.1.10 port 48672 connected with 192.168.1.20 port 5001
[ 39] local 192.168.1.10 port 48748 connected with 192.168.1.20 port 5001
[ 40] local 192.168.1.10 port 48750 connected with 192.168.1.20 port 5001
[  8] local 192.168.1.10 port 48682 connected with 192.168.1.20 port 5001
[ 18] local 192.168.1.10 port 48704 connected with 192.168.1.20 port 5001
[  4] local 192.168.1.10 port 48674 connected with 192.168.1.20 port 5001
[ 46] local 192.168.1.10 port 48762 connected with 192.168.1.20 port 5001
[  5] local 192.168.1.10 port 48676 connected with 192.168.1.20 port 5001
[ 49] local 192.168.1.10 port 48768 connected with 192.168.1.20 port 5001
[ 54] local 192.168.1.10 port 48778 connected with 192.168.1.20 port 5001
[ 57] local 192.168.1.10 port 48784 connected with 192.168.1.20 port 5001
[ 51] local 192.168.1.10 port 48772 connected with 192.168.1.20 port 5001
[  9] local 192.168.1.10 port 48686 connected with 192.168.1.20 port 5001
[ 61] local 192.168.1.10 port 48792 connected with 192.168.1.20 port 5001
[  698.284709] arm-smmu 64000000.mmu: TLB sync timed out -- SMMU may be
deadlocked
[  699.386010] arm-smmu 64000000.mmu: TLB sync timed out -- SMMU may be
deadlocked
[  702.064900] arm-smmu 64000000.mmu: TLB sync timed out -- SMMU may be
deadlocked
[ ID] Interval       Transfer     Bandwidth
[ 26]  0.0-10.0 sec   544 MBytes   456 Mbits/sec
[  6]  0.0-10.0 sec   382 MBytes   320 Mbits/sec
[ 22]  0.0-10.1 sec   667 MBytes   556 Mbits/sec
[ 50]  0.0-10.1 sec   245 MBytes   204 Mbits/sec
[ 21]  0.0-10.1 sec   291 MBytes   242 Mbits/sec
[ 56]  0.0-10.1 sec   256 MBytes   213 Mbits/sec
[ 19]  0.0-10.0 sec  17.0 MBytes  14.2 Mbits/sec
[ 47]  0.0-10.0 sec   357 MBytes   299 Mbits/sec
[ 52]  0.0-10.1 sec   121 MBytes   101 Mbits/sec
[ 59]  0.0-10.0 sec   364 MBytes   304 Mbits/sec
[ 30]  0.0-10.0 sec   469 MBytes   391 Mbits/sec
[ 20]  0.0-10.0 sec   435 MBytes   364 Mbits/sec
[ 44]  0.0-10.0 sec   379 MBytes   317 Mbits/sec
[ 33]  0.0-10.0 sec   468 MBytes   392 Mbits/sec
[ 60]  0.0-10.0 sec   178 MBytes   149 Mbits/sec
[ 14]  0.0-10.1 sec   539 MBytes   449 Mbits/sec
[ 28]  0.0-10.1 sec  60.6 MBytes  50.5 Mbits/sec
[ 42]  0.0-10.1 sec   365 MBytes   304 Mbits/sec
[  3]  0.0-10.1 sec   109 MBytes  90.5 Mbits/sec
[ 29]  0.0-10.1 sec   473 MBytes   395 Mbits/sec
[ 38]  0.0-10.0 sec   254 MBytes   212 Mbits/sec
[ 13]  0.0-10.0 sec   523 MBytes   438 Mbits/sec
[ 12]  0.0-10.1 sec   182 MBytes   152 Mbits/sec
[ 11]  0.0-10.1 sec   130 MBytes   109 Mbits/sec
[ 15]  0.0-10.1 sec   174 MBytes   145 Mbits/sec
[ 43]  0.0-10.1 sec   399 MBytes   333 Mbits/sec
[ 48]  0.0-10.1 sec   543 MBytes   452 Mbits/sec
[ 45]  0.0-10.1 sec  69.1 MBytes  57.6 Mbits/sec
[ 35]  0.0-10.1 sec  54.0 MBytes  45.0 Mbits/sec
[  4]  0.0-10.0 sec   116 MBytes  97.4 Mbits/sec
[ 46]  0.0-10.1 sec   300 MBytes   250 Mbits/sec
[ 51]  0.0-10.1 sec  49.8 MBytes  41.5 Mbits/sec
[ 61]  0.0-10.1 sec   102 MBytes  85.0 Mbits/sec
[ 23]  0.0-10.1 sec  1.64 GBytes  1.39 Gbits/sec
[ 10]  0.0-10.1 sec   210 MBytes   174 Mbits/sec
[ 31]  0.0-10.1 sec  1.16 GBytes   988 Mbits/sec
[ 63]  0.0-10.1 sec   468 MBytes   389 Mbits/sec
[ 25]  0.0-10.1 sec   457 MBytes   381 Mbits/sec
[ 34]  0.0-10.1 sec   332 MBytes   276 Mbits/sec
[ 64]  0.0-10.1 sec   280 MBytes   233 Mbits/sec
[ 17]  0.0-10.1 sec   425 MBytes   354 Mbits/sec
[ 62]  0.0-10.1 sec   616 MBytes   513 Mbits/sec
[ 53]  0.0-10.1 sec   289 MBytes   241 Mbits/sec
[ 16]  0.0-10.1 sec   661 MBytes   550 Mbits/sec
[ 27]  0.0-10.1 sec   298 MBytes   249 Mbits/sec
[ 41]  0.0-10.1 sec  11.5 MBytes  9.57 Mbits/sec
[ 37]  0.0-10.1 sec   945 MBytes   786 Mbits/sec
[ 36]  0.0-10.1 sec   164 MBytes   136 Mbits/sec
[ 40]  0.0-10.1 sec   782 MBytes   650 Mbits/sec
[  8]  0.0-10.1 sec   883 MBytes   734 Mbits/sec
[ 18]  0.0-10.1 sec   140 MBytes   117 Mbits/sec
[  5]  0.0-10.1 sec   366 MBytes   305 Mbits/sec
[ 49]  0.0-10.1 sec   229 MBytes   191 Mbits/sec
[ 54]  0.0-10.1 sec   884 MBytes   736 Mbits/sec
[ 57]  0.0-10.1 sec  56.6 MBytes  47.1 Mbits/sec
[  9]  0.0-10.1 sec  72.8 MBytes  60.4 Mbits/sec
[ 66]  0.0-10.1 sec   170 MBytes   141 Mbits/sec
[ 32]  0.0-10.1 sec   201 MBytes   167 Mbits/sec
[ 58]  0.0-10.1 sec   381 MBytes   317 Mbits/sec
[ 65]  0.0-10.1 sec   373 MBytes   310 Mbits/sec
[ 55]  0.0-10.1 sec  98.0 MBytes  81.5 Mbits/sec
[ 24]  0.0-10.1 sec   292 MBytes   243 Mbits/sec
[  7]  0.0-10.1 sec  1.08 GBytes   918 Mbits/sec
[ 39]  0.0-10.1 sec  95.8 MBytes  79.6 Mbits/sec
[SUM]  0.0-10.1 sec  23.2 GBytes  19.7 Gbits/sec


I played with it a bit and can confirm if I have all interrupt affinity
set to CPU0, I then do not see this issue. This tells us that there
still seem to be a race somewhere, when multiple CPUs are involved?

Regards,

Ray
