From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] intel-iommu: Disable translation if already enabled
Date: Tue, 23 Apr 2013 14:49:27 +0200
Message-ID: <20130423124926.GC2589@8bytes.org>
References: <1366706103-2640-1-git-send-email-indou.takao@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1366706103-2640-1-git-send-email-indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wei-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 23, 2013 at 05:35:03PM +0900, Takao Indoh wrote:
> This patch disables translation(dma-remapping) before its initialization
> if it is already enabled.
> 
> This is needed for kexec/kdump boot. If dma-remapping is enabled in the
> first kernel, it need to be disabled before initializing its page table
> during second kernel boot. Wei Hu also reported that this is needed
> when second kernel boots with intel_iommu=off.
> 
> Basically iommu->gcmd is used to know whether translation is enabled or
> disabled, but it is always zero at boot time even when translation is
> enabled since iommu->gcmd is initialized without considering such a
> case. Therefor this patch synchronizes iommu->gcmd value with global
> command register when iommu structure is allocated.
> 
> Changelog:
> v2:
> - Change subject and patch description
> - Disable translation after dmar_table_init() so that it works when
>   intel_iommu=off is specified.
> 
> v1:
> https://lkml.org/lkml/2013/3/20/707
> 
> Signed-off-by: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> ---
>  drivers/iommu/dmar.c        |   11 ++++++++++-
>  drivers/iommu/intel-iommu.c |   15 +++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletions(-)

Looks good to me, applied to x86/vt-d, thanks Takao.
