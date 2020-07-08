Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D480EC433DF
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 12:05:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A452E206C3
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 12:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H5xU6XpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A452E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 59F6087B1F;
	Wed,  8 Jul 2020 12:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ksvv9ft1Zuzf; Wed,  8 Jul 2020 12:05:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 568C187B0F;
	Wed,  8 Jul 2020 12:05:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38602C0893;
	Wed,  8 Jul 2020 12:05:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95A9EC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 12:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 90D2489695
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 12:05:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VwfKCR79Z+bD for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 12:05:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 712A189694
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 12:05:40 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f05b6290000>; Wed, 08 Jul 2020 05:03:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 08 Jul 2020 05:05:40 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 08 Jul 2020 05:05:40 -0700
Received: from [10.26.73.185] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 12:05:34 +0000
Subject: Re: [PATCH v10 2/5] iommu/arm-smmu: ioremap smmu mmio region before
 implementation init
To: Krishna Reddy <vdumpa@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <robh+dt@kernel.org>, <treding@nvidia.com>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-3-vdumpa@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <73aa8adb-2a62-f482-7a2f-cea3ad1c0d29@nvidia.com>
Date: Wed, 8 Jul 2020 13:05:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708050017.31563-3-vdumpa@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1594209833; bh=gxQcl9bpk0BxcF/j6fxcVpCc4kYEvyi3JouVPj5UA8g=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=H5xU6XpOQP6NJAMN7gju07RMXH67AVI2gqLWDfsLEEZfr2cFgxo9KyrW3mmXxKdqA
 deWyWZfoLZcaTKnbtZGNnLCnVwP2fXN6I2ITanKIxD1Cy0BmX4QTVENJVGeC8NPWeL
 XwBbIL2PlMMbVz/JYbolgVUXTnWRPNQ3zGaFMycCDhBFh7ZIFBNODIhogPsQKbB2RN
 jjMjQS5b/m534AJc5R4hjOhLA5E2OUmX+ZvIrOwQEtB5y7XI39PK2aUmsFyWP3dD5L
 lXdBMnFpn8steP4v3rQwcmAixPnhb+IOAIhdftl4dF+H/yvuZUHtY8eApCEPAz3xPy
 6KlCUsW6GOc6g==
Cc: snikam@nvidia.com, devicetree@vger.kernel.org, nicoleotsuka@gmail.com,
 mperttunen@nvidia.com, bhuntsman@nvidia.com, yhsu@nvidia.com,
 linux-kernel@vger.kernel.org, talho@nvidia.com,
 iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, praithatha@nvidia.com,
 linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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


On 08/07/2020 06:00, Krishna Reddy wrote:
> ioremap smmu mmio region before calling into implementation init.
> This is necessary to allow mapped address available during vendor
> specific implementation init.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  drivers/iommu/arm-smmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index d2054178df35..e03e873d3bca 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2120,10 +2120,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	smmu = arm_smmu_impl_init(smmu);
> -	if (IS_ERR(smmu))
> -		return PTR_ERR(smmu);
> -
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	ioaddr = res->start;
>  	smmu->base = devm_ioremap_resource(dev, res);
> @@ -2135,6 +2131,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	 */
>  	smmu->numpage = resource_size(res);
>  
> +	smmu = arm_smmu_impl_init(smmu);
> +	if (IS_ERR(smmu))
> +		return PTR_ERR(smmu);
> +
>  	num_irqs = 0;
>  	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
>  		num_irqs++;
> 


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
