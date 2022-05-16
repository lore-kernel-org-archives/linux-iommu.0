Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79278C433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 18:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A96A60C0F;
	Mon, 16 May 2022 18:30:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2KcWYqMp89i; Mon, 16 May 2022 18:30:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02472610D2;
	Mon, 16 May 2022 18:30:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A04C9C0032;
	Mon, 16 May 2022 18:30:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CE69C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 18:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BD1482C7D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 18:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T1Rg7-3pzWy2 for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 18:30:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6F5381678
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 18:30:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: dmitry.osipenko) with ESMTPSA id 23CA01F4384E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652725815;
 bh=Ix9DbNg5SW6/Hg8l/g6Ys0vE0Lf/VXFLJIOKJ19dQGg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FjDJqTm0OEMr8rsmzD3/IkYT9TAdBsknxHvCK67MfZONV1/a0jlh8dOpi8saYagHy
 qbYLoLlRsHmBfPBf36xMMLFif6L4kBU7N4hIvBLFD/Gqt54g3sk/y04xCCJUpiR6KF
 kuRRC0mn7c2VpC+UgmvtlJ9wnxFBqRP3WiFdfSLKQCNaI8f3Pd/suwiRwIbGLvICME
 kE7hRfojkQcNoUS9D+zUYYXETyn2BNSrNo19LtafS0EUKUmv87ObW+jfEN9BaWCosY
 IwfFl61xan+VwPmW9m+biKgveUSbwxoAi1+JybOeF1Dc09ALRGHY7GAfkqpWHlsXPq
 KWaByP9GPpHzw==
Message-ID: <b1f29af4-bc1c-f288-7960-870f1c68ec56@collabora.com>
Date: Mon, 16 May 2022 21:30:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 5/5] iommu/tegra-smmu: Support managed domains
Content-Language: en-US
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <20220512190052.1152377-1-thierry.reding@gmail.com>
 <20220512190052.1152377-6-thierry.reding@gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220512190052.1152377-6-thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sameer Pujar <spujar@nvidia.com>,
 iommu@lists.linux-foundation.org,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 linux-tegra@vger.kernel.org, Janne Grunau <j@jannau.net>
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

On 5/12/22 22:00, Thierry Reding wrote:
> -277,7 +278,9 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
>  {
>  	struct tegra_smmu_as *as;
>  
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_DMA &&
> +	    type != IOMMU_DOMAIN_IDENTITY)
>  		return NULL;

Shouldn't at least pre-210 SoCs be guarded from IOMMU_DOMAIN_DMA? I
don't think that DRM and VDE drivers will work as-is today.

-- 
Best regards,
Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
