From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 11/13] iommu/amd: Don't copy GCR3 table root pointer
Date: Mon, 24 Jul 2017 07:53:13 +0800
Message-ID: <20170723235313.GB24530@x1>
References: <1500627551-12930-12-git-send-email-bhe@redhat.com>
	<201707240618.mJ6b2eHv%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201707240618.mJ6b2eHv%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/24/17 at 06:33am, kbuild test robot wrote:
> Hi Baoquan,
> 
> [auto build test WARNING on iommu/next]
> [also build test WARNING on v4.13-rc1]
> [cannot apply to next-20170721]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/Fix-the-on-flight-DMA-issue-on-system-with-amd-iommu/20170724-060048
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: x86_64-randconfig-x005-201730 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers//iommu/amd_iommu_v2.c: In function 'ppr_notifier':
> >> drivers//iommu/amd_iommu_v2.c:566:6: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      int ret;
>          ^~~
> 
> vim +/ret +566 drivers//iommu/amd_iommu_v2.c

Thanks, it should return NOTIFY_DONE anyway when ppr faults is handled
in kdump kernel since the GCR3 table root pointer has been made NULL
intentionally.

I will add this into patch 11/13 when repost need be done.


>From 742d8a51d8832e12884800840c4ebe802767d808 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Mon, 24 Jul 2017 07:48:10 +0800
Subject: [PATCH] iommu/amd: The ppr faults handled in kdump kernel should
 return NOTIFY_DONE

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 0245d414a7b3..e705fac89cb4 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -578,6 +578,7 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	dev_data = get_dev_data(&pdev->dev);
 
 	/* In kdump kernel pci dev is not initialized yet -> send INVALID */
+	ret = NOTIFY_DONE;
 	if (translation_pre_enabled(amd_iommu_rlookup_table[devid])
 		&& dev_data->defer_attach) {
 		amd_iommu_complete_ppr(pdev, iommu_fault->pasid,
@@ -585,7 +586,6 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 		goto out;
 	}
 
-	ret = NOTIFY_DONE;
 	dev_state = get_device_state(iommu_fault->device_id);
 	if (dev_state == NULL)
 		goto out;
-- 
2.5.5
