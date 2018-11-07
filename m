From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix crash on early domain free
Date: Wed, 7 Nov 2018 13:22:52 +0000
Message-ID: <e4dcd8b2-768e-b11d-b6de-337b7e942050@arm.com>
References: <20181107131850.11584-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181107131850.11584-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2018-11-07 1:18 pm, Geert Uytterhoeven wrote:
> If iommu_ops.add_device() fails, iommu_ops.domain_free() is still
> called, leading to a crash, as the domain was only partially
> initialized:
> 
>      ipmmu-vmsa e67b0000.mmu: Cannot accommodate DMA translation for IOMMU page tables
>      sata_rcar ee300000.sata: Unable to initialize IPMMU context
>      iommu: Failed to add device ee300000.sata to group 0: -22
>      Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
>      ...
>      Call trace:
>       ipmmu_domain_free+0x1c/0xa0
>       iommu_group_release+0x48/0x68
>       kobject_put+0x74/0xe8
>       kobject_del.part.0+0x3c/0x50
>       kobject_put+0x60/0xe8
>       iommu_group_get_for_dev+0xa8/0x1f0
>       ipmmu_add_device+0x1c/0x40
>       of_iommu_configure+0x118/0x190
> 
> Fix this by checking if the domain's context already exists, before
> trying to destroy it.

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index c4114b92652eb0c9..a8b2c649c1d1f1b9 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -498,6 +498,9 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
>   
>   static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
>   {
> +	if (!domain->mmu)
> +		return;
> +
>   	/*
>   	 * Disable the context. Flush the TLB as required when modifying the
>   	 * context registers.
> 
