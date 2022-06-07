Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0C3C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 12:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 956E66100D;
	Tue,  7 Jun 2022 12:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kKaFzGWHAfqB; Tue,  7 Jun 2022 12:42:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7AB5560FA5;
	Tue,  7 Jun 2022 12:42:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53F5EC0032;
	Tue,  7 Jun 2022 12:42:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C358C002D;
 Tue,  7 Jun 2022 12:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA903843F4;
 Tue,  7 Jun 2022 12:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UN-SMpSydSlA; Tue,  7 Jun 2022 12:42:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DCB0843EE;
 Tue,  7 Jun 2022 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654605766; x=1686141766;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7CnaOaKftZFuU6zS5ejOPSw/a0TRQ7MfLEcH+ST55pI=;
 b=npA/EwVLm80RPrCVVatUyQvh9x9gm5H6ghJ6dgiol7bnt46yPC4MAeIP
 hodIq74n82eCvLkbY6D4n1U5g+cmclFLiS1lWHbglspj33Yx0VXhpW1xu
 XXW9UHZ96K+9IXY9b2Fj6DgEmQ3WeVzrXk0/t33U8iB4Eu56WDtZMlNUm
 pxMK+4gZexYxZYaxfCiELvhZ9RnU5kjk71ZGLbc98m1622I3PzO/VRn3x
 XFvHXiaR2OZx8kR0okSiNW3ZGnzZm376te9757QJrrGqkayUVpgzKPh+f
 935LMOkD4M2Ww6r8zdK9pommUkbicGZ9Jd72qeSG0NnIawB8Rb10j8+x0 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="338101933"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; d="scan'208";a="338101933"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2022 05:42:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; d="scan'208";a="584184405"
Received: from zwang64-mobl1.ccr.corp.intel.com (HELO [10.249.174.202])
 ([10.249.174.202])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2022 05:42:34 -0700
Message-ID: <3d0b2863-bb4f-31e1-d54e-09ddf4762d43@linux.intel.com>
Date: Tue, 7 Jun 2022 20:42:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/5] Simplify vfio_iommu_type1 attach/detach routine
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220606061927.26049-1-nicolinc@nvidia.com>
 <d357966b-7abd-f8f3-3ca7-3c99f5e075b9@linux.intel.com>
 <20220607115820.GH1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220607115820.GH1343366@nvidia.com>
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, heiko@sntech.de,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, alim.akhtar@samsung.com,
 will@kernel.org, alyssa@rosenzweig.io, jean-philippe@linaro.org,
 linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, samuel@sholland.org,
 zhang.lyra@gmail.com, jernej.skrabec@gmail.com, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, wens@csie.org, agross@kernel.org,
 linux-arm-kernel@lists.infradead.org, orsonzhai@gmail.com,
 gerald.schaefer@linux.ibm.com, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, virtualization@lists.linux-foundation.org,
 dwmw2@infradead.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, baolin.wang7@gmail.com, robin.murphy@arm.com
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

On 2022/6/7 19:58, Jason Gunthorpe wrote:
> On Tue, Jun 07, 2022 at 03:44:43PM +0800, Baolu Lu wrote:
>> On 2022/6/6 14:19, Nicolin Chen wrote:
>>> Worths mentioning the exact match for enforce_cache_coherency is removed
>>> with this series, since there's very less value in doing that since KVM
>>> won't be able to take advantage of it -- this just wastes domain memory.
>>> Instead, we rely on Intel IOMMU driver taking care of that internally.
>>
>> After reading this series, I don't see that Intel IOMMU driver needs any
>> further change to support the new scheme. Did I miss anything?
> 
> You already did it :)

Just as I thought. Thank you!

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
