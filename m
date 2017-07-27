From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v8 13/13] iommu/amd: Disable iommu only if amd_iommu=off
	is specified
Date: Thu, 27 Jul 2017 17:58:52 +0200
Message-ID: <20170727155852.GQ3610@suse.de>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
	<1500627551-12930-14-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1500627551-12930-14-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, root <root-U2nCED00ozjD7sV1v1AExoa7Q5UgA9Lkp8t6gq825lw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 21, 2017 at 04:59:11PM +0800, Baoquan He wrote:
> From: root <root-U2nCED00ozjD7sV1v1AExoa7Q5UgA9Lkp8t6gq825lw@public.gmane.org>

You probaly need to reset the author on this one.

> 
> It's ok to disable iommu in normal kernel. While there's no need
> to disable it in kdump kernel after the on-flight dma issue has
> heen fixed.
> 
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu_init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 8b4bac978062..880f693c809b 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2494,7 +2494,8 @@ static int __init early_amd_iommu_init(void)
>  		goto out;
>  
>  	/* Disable any previously enabled IOMMUs */
> -	disable_iommus();
> +	if (amd_iommu_disabled)
> +		disable_iommus();
>  
>  	if (amd_iommu_irq_remap)
>  		amd_iommu_irq_remap = check_ioapic_information();
> -- 
> 2.5.5
