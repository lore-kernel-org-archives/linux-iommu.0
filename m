From: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH 1/1] intel-iommu: Disable DMA Remapping when
	intel_iommu=off
Date: Mon, 22 Apr 2013 14:31:18 +0900
Message-ID: <5174CB26.9060908@jp.fujitsu.com>
References: <1366441080-5937-1-git-send-email-wei@aristanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1366441080-5937-1-git-send-email-wei-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: wei-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

(2013/04/20 15:58), Wei Hu wrote:
> On a VT-d capable machine Linux will enable IOMMU by default. If it
> then kexec's a second kernel with intel_iommu=off, this second kernel
> will leave the DMA remapping engine on with no code handling it. The
> symptom is at least USB and SATA drives stop working. This patch fixes
> the problem by always disabling DMA remapping when intel_iommu=off.

Even when second kernel boots up with intel_iommu=on, dma-remapping need
to be disabled as well before it is initialized and enabled again in
init_dmars(). So, how about something like this?

        for_each_drhd_unit(drhd) {
                struct dmar_drhd_unit *drhd;
                if (drhd->ignored)
                        continue;

                iommu = drhd->iommu;
                if (iommu->gcmd & DMA_GCMD_TE)
                        iommu_disable_translation(iommu);
        }

Note, if you agree above code and fix your patch like this, you need
additinal fix to set iommu->gcmd flag sinse gcmd is always zero here.
See first hunk of this patch.
https://lkml.org/lkml/2013/3/20/707

Thanks,
Takao Indoh


> 
> Signed-off-by: Wei Hu <wei-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> ---
>   drivers/iommu/intel-iommu.c |    6 +++++-
>   1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 0099667..0b8f8bb 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3681,8 +3681,12 @@ int __init intel_iommu_init(void)
>   		return 	-ENODEV;
>   	}
>   
> -	if (no_iommu || dmar_disabled)
> +	if (no_iommu || dmar_disabled) {
> +		struct dmar_drhd_unit *drhd;
> +		for_each_drhd_unit(drhd)
> +			iommu_disable_translation(drhd->iommu);
>   		return -ENODEV;
> +	}
>   
>   	if (iommu_init_mempool()) {
>   		if (force_on)
> 
