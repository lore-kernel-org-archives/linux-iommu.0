Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B7AC433EF
	for <iommu@archiver.kernel.org>; Fri,  7 Jan 2022 16:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 825A8605EC;
	Fri,  7 Jan 2022 16:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7J9OWnC4-SZR; Fri,  7 Jan 2022 16:04:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 31BE2605AC;
	Fri,  7 Jan 2022 16:04:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09EBBC0030;
	Fri,  7 Jan 2022 16:04:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A24BC001E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 16:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B2E4605AC
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 16:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BFNrRGkjUoKT for <iommu@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 16:04:30 +0000 (UTC)
X-Greylist: delayed 01:22:06 by SQLgrey-1.8.0
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC732605EC
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 16:04:30 +0000 (UTC)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 207EgHJ6097592;
 Fri, 7 Jan 2022 08:42:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1641566537;
 bh=84xH1S3boxkyVmLpM/dCun8ytu+7FFaeZjh0qwynxBc=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=rcI3bCZ2HHT3qZnYU8Msi+RdU3AMVH09+Ui3c+1oGS2Pr/OJkkCWRAyRQKZDFjppY
 AZD4xZ1rzd9JKmoE+lmyzniUWR5Tns6ZN2AZaPJLIIN39MlVkiQS8SdNmqFw1yfojM
 fQciHpSAIa12A4WRYDAeR6+I/wQgnt8MK6P1PxqM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 207EgHSP093470
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Jan 2022 08:42:17 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 7
 Jan 2022 08:42:17 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 7 Jan 2022 08:42:17 -0600
Received: from [10.249.36.164] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 207EgGC7124001;
 Fri, 7 Jan 2022 08:42:16 -0600
Subject: Re: [PATCH] iommu/omap: Fix missing put_device() call in
 omap_iommu_probe_device
To: Miaoqian Lin <linmq006@gmail.com>
References: <20220107080428.10873-1-linmq006@gmail.com>
Message-ID: <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
Date: Fri, 7 Jan 2022 08:42:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220107080428.10873-1-linmq006@gmail.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: "Nagalla, Hari" <hnagalla@ti.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
From: Suman Anna via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Miaoqian,

On 1/7/22 2:04 AM, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.

Thanks for catching this.

> Add the corresponding 'put_device()' in the error handling paths.

Also, need it in the regular path, not just in error handling path.

> 
> Fixes: ede1c2e7d4dc ("iommu/omap: Store iommu_dev pointer in arch_data")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/iommu/omap-iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 91749654fd49..cbc7ca5e890a 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1684,6 +1684,7 @@ static struct iommu_device *omap_iommu_probe_device(struct device *dev)
>  		oiommu = platform_get_drvdata(pdev);
>  		if (!oiommu) {
>  			of_node_put(np);
> +			put_device(&pdev->dev);

nit, doesn't matter for functionality, but prefer the put_device before
of_node_put().

regards
Suman

>  			kfree(arch_data);
>  			return ERR_PTR(-EINVAL);
>  		}
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
