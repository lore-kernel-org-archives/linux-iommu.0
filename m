Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D1CC433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 12:11:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4C820643
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 12:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DT+qVjbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4C820643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 64C2A86A1A;
	Mon, 18 May 2020 12:11:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U55ZeOKXOixl; Mon, 18 May 2020 12:11:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D9693868E1;
	Mon, 18 May 2020 12:11:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3FBDC0888;
	Mon, 18 May 2020 12:11:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16272C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 12:11:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 04A72885CA
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 12:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5woUqopumOLg for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 12:11:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F1A98885DC
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 12:11:33 +0000 (UTC)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04ICBUjx068823;
 Mon, 18 May 2020 07:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1589803890;
 bh=PvspkHCHgklIAa8UX8knX0bBRIv88ZmarBlCJ5WRq7Y=;
 h=Subject:To:References:From:Date:In-Reply-To;
 b=DT+qVjbXwu6cXfE0BHH8VsI8TUOU7ZTfWxriSmb3vuU5q7Z+QW0lppAEUPE0FsGRI
 la6hdJSDfSiN9hfwbKvaQ0uRrYYgrpNc37iA2mUDagooLGPDKhNKmgklXKoPyLHGyW
 O9ojyISH0d25lsFQwR5gaMaXsWag8X+Bbntc0sbQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04ICBU0q066180
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 May 2020 07:11:30 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 07:11:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 07:11:29 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04ICBSBK002503;
 Mon, 18 May 2020 07:11:28 -0500
Subject: Re: [PATCH] iommu/omap: Add registration for DT fwnode pointer
To: Tero Kristo <t-kristo@ti.com>, <iommu@lists.linux-foundation.org>,
 <joro@8bytes.org>
References: <20200424145828.3159-1-t-kristo@ti.com>
Message-ID: <6a505438-2d2e-27da-fa38-f3ac15832480@ti.com>
Date: Mon, 18 May 2020 15:11:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200424145828.3159-1-t-kristo@ti.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
From: Tero Kristo via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tero Kristo <t-kristo@ti.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 24/04/2020 17:58, Tero Kristo via iommu wrote:
> The fwnode pointer must be passed to the iommu core, so that the core
> can map the IOMMU towards device requests properly. Without this, some
> IOMMU clients like OMAP remoteproc will fail the iommu configuration
> multiple times with -EPROBE_DEFER, which will eventually be ignored with
> a kernel warning banner.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Hi Joerg,

I noticed this is still missing from next but there are some other OMAP 
iommu patches queued up (see the bug fix I just posted against -next.)

Whats the plan with this one?

-Tero

> ---
>   drivers/iommu/omap-iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 887fefcb03b4..934726e20b72 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1248,6 +1248,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
>   			goto out_group;
>   
>   		iommu_device_set_ops(&obj->iommu, &omap_iommu_ops);
> +		iommu_device_set_fwnode(&obj->iommu, &of->fwnode);
>   
>   		err = iommu_device_register(&obj->iommu);
>   		if (err)
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
