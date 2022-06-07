Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99785C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 07:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42574613D8;
	Tue,  7 Jun 2022 07:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WbKY5gRINWTq; Tue,  7 Jun 2022 07:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 21C7F613E0;
	Tue,  7 Jun 2022 07:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1A39C0032;
	Tue,  7 Jun 2022 07:45:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AEFCC002D;
 Tue,  7 Jun 2022 07:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3EEE0404B3;
 Tue,  7 Jun 2022 07:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3xTo3PLPR3dx; Tue,  7 Jun 2022 07:45:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0658E404B0;
 Tue,  7 Jun 2022 07:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654587923; x=1686123923;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OSBO16dRCwR6Wb79tDIGbzqHZ301kVBrdpEBr6LRMRc=;
 b=kJ/SMtDtOrqSdwyfamDrDtOKESjtcJuLn4y/fsdWsbj1UE5ZsgpZr9dN
 TWYl3dMWB+svGopX9JWOVmFWA1ekB+oAsdfSALYSv9SQQgODkS1RTxOmL
 fT4K6SHbZcZULoTHcEewoc603UQGUoEWWRVfZkH8JwgSXrdgjoKlB0pnW
 /RL3dQTO9Zyog+7H8fG275Qr+addzbwSKZHL8Xkw70+f/WEwXE3sEoL/n
 3F8NiNRYnrz2ynrNVWbgkVhw1UFxPIElki0jM88QW2nZbtFmQBNu3UCxS
 1EQrtInjrOZ2upKqqzAbGpLMTW5lsbU87dTOzRnHq03iiXheego01SPN2 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="259381660"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; d="scan'208";a="259381660"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2022 00:44:55 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; d="scan'208";a="584086830"
Received: from zwang64-mobl1.ccr.corp.intel.com (HELO [10.249.174.202])
 ([10.249.174.202])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2022 00:44:45 -0700
Message-ID: <d357966b-7abd-f8f3-3ca7-3c99f5e075b9@linux.intel.com>
Date: Tue, 7 Jun 2022 15:44:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/5] Simplify vfio_iommu_type1 attach/detach routine
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
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220606061927.26049-1-nicolinc@nvidia.com>
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
> Worths mentioning the exact match for enforce_cache_coherency is removed
> with this series, since there's very less value in doing that since KVM
> won't be able to take advantage of it -- this just wastes domain memory.
> Instead, we rely on Intel IOMMU driver taking care of that internally.

After reading this series, I don't see that Intel IOMMU driver needs any
further change to support the new scheme. Did I miss anything?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
