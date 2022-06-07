Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59481C43334
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 03:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D709340136;
	Tue,  7 Jun 2022 03:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RPQCiEM6tMDb; Tue,  7 Jun 2022 03:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1ED44109B;
	Tue,  7 Jun 2022 03:23:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AF5BC0032;
	Tue,  7 Jun 2022 03:23:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50C86C002D;
 Tue,  7 Jun 2022 03:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AB4D60AC2;
 Tue,  7 Jun 2022 03:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qHUZi2qz2mJp; Tue,  7 Jun 2022 03:23:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BC8560AA4;
 Tue,  7 Jun 2022 03:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654572221; x=1686108221;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vzgEhhW4kNaICa/n+qlgLmF5Vog9iKUmfkdT1yy8unU=;
 b=MpwqUQuk+h3is80PAgwburn7zZoRTbiyXQv7uEIY08XrOI0sQ7unpggy
 6RrGcmxmnmKhXPm2R58xKse2UkjB7SHeuNUZR8yO4l7cV7pN4a9LcRT07
 pMvYPnIDRlFz5VHk24h7oVhViEci7b9i4jsuQYh623xp8+wWEdPivTghg
 BQBsb3IsvqQlFXEe3S0QJqT5OPeO0cLWlYzBdGN/uh3Oj6icHBPuaInW7
 6r5K31U+iDGGH4NMHFCeiNqF2WIp+WSPn/qElMZ0DVpPS+5fJyI2p2oIw
 0/QhfBVyz9ljJzqw3+mQU3PXJl6/53uYRqF4wftt13eyXeWUTsX6X7WmL w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="259303206"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; d="scan'208";a="259303206"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2022 20:23:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; d="scan'208";a="583980445"
Received: from zwang64-mobl1.ccr.corp.intel.com (HELO [10.249.174.202])
 ([10.249.174.202])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2022 20:23:29 -0700
Message-ID: <f81b8b8f-b811-3be2-5dda-139dc1bd7bdd@linux.intel.com>
Date: Tue, 7 Jun 2022 11:23:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, robin.murphy@arm.com,
 robdclark@gmail.com, m.szyprowski@samsung.com,
 krzysztof.kozlowski@linaro.org, agross@kernel.org,
 bjorn.andersson@linaro.org, matthias.bgg@gmail.com, heiko@sntech.de,
 orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
 wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <20220606061927.26049-2-nicolinc@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220606061927.26049-2-nicolinc@nvidia.com>
Cc: virtualization@lists.linux-foundation.org, thierry.reding@gmail.com,
 alim.akhtar@samsung.com, alyssa@rosenzweig.io, linux-s390@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, gerald.schaefer@linux.ibm.com,
 linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 dwmw2@infradead.org
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

On 2022/6/6 14:19, Nicolin Chen wrote:
> +/**
> + * iommu_attach_group - Attach an IOMMU group to an IOMMU domain
> + * @domain: IOMMU domain to attach
> + * @dev: IOMMU group that will be attached

Nit: @group: ...

> + *
> + * Returns 0 on success and error code on failure
> + *
> + * Specifically, -EMEDIUMTYPE is returned if the domain and the group are
> + * incompatible in some way. This indicates that a caller should try another
> + * existing IOMMU domain or allocate a new one.
> + */
>   int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
>   {
>   	int ret;

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
