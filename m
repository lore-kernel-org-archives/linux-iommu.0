Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D39BC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 04:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FD1F81A65;
	Fri,  1 Jul 2022 04:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FD1F81A65
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20210112.gappssmtp.com header.i=@ozlabs-ru.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7OyJBILU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUoOdQGh4Lcv; Fri,  1 Jul 2022 04:57:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D397B8244D;
	Fri,  1 Jul 2022 04:57:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D397B8244D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83460C0021;
	Fri,  1 Jul 2022 04:57:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 632E5C0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 04:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F5AA8244D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 04:57:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F5AA8244D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bp_XQGWsEXo4 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 04:57:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD49881A65
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD49881A65
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 04:57:39 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id go6so1559184pjb.0
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 21:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=NOQXYB9rVtqMbvMp0KZP/NXMDdG6KY+bHR2qpMf2XHA=;
 b=7OyJBILUprUR9iDklBoQBQpLducUR42bx72zwhlY9m+b9yAQyxIlMFxqW/mgn++w65
 We1HnbnuNAMJq0G5M7MVZJKumIbFt5Yu6Fu7sT75nBEKm5DUjjZED+5Wm8+8MnINDzdT
 ZzpBIYqeIwIoPpRtGWI29+G1yE0bsTTJ68Dcykscu1KNi9XSar7iMDAXIjdvLULCz0Os
 oSzd0c5eJ9bwTStTU1nD6NGsF4NtYXQ8gflxDZryr223QWBfGC4ByDBWiyt8IOcVpEau
 BWNhtKTVxZsFmm7CFh4GsvGg6H9RyoyzWVKbJtufFKmnTA3ABZYTQiI5WoSc7kaSKUx1
 sAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=NOQXYB9rVtqMbvMp0KZP/NXMDdG6KY+bHR2qpMf2XHA=;
 b=D4UFCSxDom5iDJuxAfc75KVJAIQSHYyhNHh43rkyvwBTSNm7dVojhNYYAwGIe9w++9
 FklWnszCeTBRVPzKAeghOpoyBGtloGdsXqmePyexQVwn6Z/BZ2Urrc6maHzNDatDlmGo
 i9yq9FvKrmg5ocXugOfy028yZ21RTjFDFbEKyBPnTTOKP5x4mxq/BkNUD6Zd3966R4dD
 S5VBZqKudDIAdQZNm1NFXcZgpTcHSdAZdPt1YsEhIP7wUa1ZasUTHMyWYLyjUMhwErwf
 3FuO5+de2zFMizs8ottOpWJMNcG9HUMdLXLSo34EAVYOvhxtwCYttNm4DOWUPg3fPxJq
 4d2g==
X-Gm-Message-State: AJIora9oVQxMQmZ/4jXQNw/D0pG2jiWliyvlGUaAzNA70qYNB7nwhugc
 4crgNVcU6fGK9jtr7h65bjfa0Q==
X-Google-Smtp-Source: AGRyM1sVGvDA3ns0++pkE+BFdtHLCQLsuxT1sVa57tgF9DUpwyoflMPLWsNwhMGEc9AtFWBtCnuoHA==
X-Received: by 2002:a17:902:b287:b0:16b:85cd:ef6b with SMTP id
 u7-20020a170902b28700b0016b85cdef6bmr18021195plr.8.1656651458842; 
 Thu, 30 Jun 2022 21:57:38 -0700 (PDT)
Received: from [10.61.2.177] (110-175-254-242.static.tpgi.com.au.
 [110.175.254.242]) by smtp.gmail.com with ESMTPSA id
 b7-20020a62cf07000000b0051835ccc008sm14562343pfg.115.2022.06.30.21.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jun 2022 21:57:38 -0700 (PDT)
Message-ID: <b39e78e4-05d3-8e83-cf40-be6de3a41909@ozlabs.ru>
Date: Fri, 1 Jul 2022 14:57:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2 4/4] vfio: Require that devices support DMA cache
 coherence
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Cornelia Huck <cohuck@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <4-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <4-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 4/8/22 01:23, Jason Gunthorpe via iommu wrote:
> IOMMU_CACHE means that normal DMAs do not require any additional coherency
> mechanism and is the basic uAPI that VFIO exposes to userspace. For
> instance VFIO applications like DPDK will not work if additional coherency
> operations are required.
> 
> Therefore check IOMMU_CAP_CACHE_COHERENCY like vdpa & usnic do before
> allowing an IOMMU backed VFIO device to be created.


This just broke VFIO on POWER which does not use iommu_ops.


> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/vfio/vfio.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index a4555014bd1e72..9edad767cfdad3 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -815,6 +815,13 @@ static int __vfio_register_dev(struct vfio_device *device,
>   
>   int vfio_register_group_dev(struct vfio_device *device)
>   {
> +	/*
> +	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
> +	 * restore cache coherency.
> +	 */
> +	if (!iommu_capable(device->dev->bus, IOMMU_CAP_CACHE_COHERENCY))
> +		return -EINVAL;
> +
>   	return __vfio_register_dev(device,
>   		vfio_group_find_or_alloc(device->dev));
>   }

-- 
Alexey
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
