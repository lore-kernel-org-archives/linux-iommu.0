Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912EBC433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 12:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26C0F60A80;
	Mon, 28 Feb 2022 12:47:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wh30iQRVESSQ; Mon, 28 Feb 2022 12:47:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EEB8960ACD;
	Mon, 28 Feb 2022 12:47:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0184C0033;
	Mon, 28 Feb 2022 12:47:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41253C001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30126409AD
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4aUACYmuGA3K for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 12:47:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C4184016E
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:47:19 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 622E44B0; Mon, 28 Feb 2022 13:47:16 +0100 (CET)
Date: Mon, 28 Feb 2022 13:47:15 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH 1/5] iommu/amd: Improve error handling for
 amd_iommu_init_pci
Message-ID: <YhzEU28x5FS1yAfw@8bytes.org>
References: <20220221045916.19701-1-vasant.hegde@amd.com>
 <20220221045916.19701-2-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220221045916.19701-2-vasant.hegde@amd.com>
Cc: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Feb 21, 2022 at 10:29:12AM +0530, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Add error messages to prevent silent failure.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 1eacd43cb436..770ac679b682 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1942,9 +1942,10 @@ static int __init amd_iommu_init_pci(void)
>  
>  	for_each_iommu(iommu) {
>  		ret = iommu_init_pci(iommu);
> -		if (ret)
> -			break;
> -
> +		if (ret) {
> +			pr_err("IOMMU:%d Failed to initialize!\n", iommu->index);

Please make that message "IOMMU%d: Failed to initialize IOMMU Hardware (error=%d)!\n".

> +			goto out;
> +		}
>  		/* Need to setup range after PCI init */
>  		iommu_set_cwwb_range(iommu);
>  	}
> @@ -1960,6 +1961,10 @@ static int __init amd_iommu_init_pci(void)
>  	 * active.
>  	 */
>  	ret = amd_iommu_init_api();
> +	if (ret) {
> +		pr_err("IOMMU: Failed to initialize api!\n");

And that "IOMMU: Failed to initialize IOMMU-API interface (error=%d)!\n"

> +		goto out;
> +	}
>  
>  	init_device_table_dma();
>  
> @@ -1969,6 +1974,7 @@ static int __init amd_iommu_init_pci(void)
>  	if (!ret)
>  		print_iommu_info();
>  
> +out:
>  	return ret;
>  }
>  
> -- 
> 2.27.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
