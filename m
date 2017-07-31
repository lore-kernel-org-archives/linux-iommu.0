From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v8 10/13] iommu/amd: Allocate memory below 4G for dev
	table if translation pre-enabled
Date: Mon, 31 Jul 2017 12:21:53 +0200
Message-ID: <20170731102153.GK3431@suse.de>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
	<1500627551-12930-11-git-send-email-bhe@redhat.com>
	<20170727155550.GO3610@suse.de> <20170728090619.GM24304@x1>
	<20170731101530.GB29157@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170731101530.GB29157@x1>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Baoquan,

On Mon, Jul 31, 2017 at 06:15:30PM +0800, Baoquan He wrote:
> I plan to add GFP_DMA32 when allocate amd_iommu_dev_table in
> early_amd_iommu_init() as below. Then in kdump kernel we don't need to
> worry if the old amd_iommu_dev_table could be above 4G, right? And might
> not need to check if it's above 4G, right?
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 781a138..85d6445 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2436,7 +2436,8 @@ static int __init early_amd_iommu_init(void)
>  
>  	/* Device table - directly used by all IOMMUs */
>  	ret = -ENOMEM;
> -	amd_iommu_dev_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +	amd_iommu_dev_table = (void *)__get_free_pages(
> +				      GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
>  				      get_order(dev_table_size));
>  	if (amd_iommu_dev_table == NULL)
>  		goto out;

Yeah, adding GFP_DMA32 is right. But you still need to check it in the
kdump path. Not checking it would mean you trust the old kernel, but
since it paniced there is no reason to put any trust in what happened
before.



	Joerg
