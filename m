From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] x86: irq_remapping: Fix the regression of hpet irq
	remapping
Date: Thu, 25 Sep 2014 19:12:58 +0200
Message-ID: <20140925171258.GD28786@8bytes.org>
References: <1410946339-27764-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410946339-27764-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 17, 2014 at 05:32:19PM +0800, Yijing Wang wrote:
> Commit 71054d8841b4 ("x86, hpet: Introduce x86_msi_ops.setup_hpet_msi")
> introduced x86_msi_ops.setup_hpet_msi to setup hpet MSI irq 
> when irq remapping enabled. This caused a regression of 
> hpet MSI irq remapping.
> 
> Original code flow before commit 71054d8841b4:
> hpet_setup_msi_irq()
> 	arch_setup_hpet_msi()
> 		setup_hpet_msi_remapped()
> 			remap_ops->setup_hpet_msi()
> 				alloc_irte()
> 		msi_compose_msg()
> 		hpet_msi_write()
> 		...
> 
> Current code flow after commit 71054d8841b4:
> hpet_setup_msi_irq()
> 	x86_msi.setup_hpet_msi()
> 		setup_hpet_msi_remapped()
> 			intel_setup_hpet_msi()
> 				alloc_irte()
> 
> Currently, we only call alloc_irte() for hpet MSI, but
> do not composed and wrote its msg...
> 
> Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
> v1->v2: rename remap_ops->setup_hpet_msi to remap_ops->alloc_hpet_msi.
> ---
>  drivers/iommu/amd_iommu.c           |    4 ++--
>  drivers/iommu/intel_irq_remapping.c |    4 ++--
>  drivers/iommu/irq_remapping.c       |   11 +++++++++--
>  drivers/iommu/irq_remapping.h       |    2 +-
>  4 files changed, 14 insertions(+), 7 deletions(-)

Applied, thanks.
