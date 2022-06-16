Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9D4C43334
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 02:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DC7840C83;
	Thu, 16 Jun 2022 02:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H8xvo7lHkB6I; Thu, 16 Jun 2022 02:10:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4ADDD4031D;
	Thu, 16 Jun 2022 02:10:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13D61C0039;
	Thu, 16 Jun 2022 02:10:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99C60C002D;
 Thu, 16 Jun 2022 02:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71E6483FA3;
 Thu, 16 Jun 2022 02:10:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W0AfSgvooh3f; Thu, 16 Jun 2022 02:10:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2FA7C83E05;
 Thu, 16 Jun 2022 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655345408; x=1686881408;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=u/polTrCcfTR/bnfvj7XjWWQORpzgrJJNnRIhd6+LYo=;
 b=P+0A+/iK6GZbUUhqClL+aUDak1HYvB1LI64Nx1kFs1+8X68qK20YevxW
 61hCRBfC+52IZrkO2GjKAePw4NYX9wUGBgt7wrHb7Ox3dJE4qV84rd4Od
 xfBFh2oFTsboFHENTbNDaZ37M15Q9WvH2LCQ+ym7Z8zcKgMzvIlmyLnym
 ICq6BcsqqJOiTm2BcjHZ98TMRImE++fMqz5mVsjOPDbEVHJV3Mo+lHIl9
 uQbcEL06QJBS5X8NyS4xoYejzj55Mc6I76McH1Cwc3bGDsBx6umEStczt
 J82LY4NIN4zZ2hAWj4AwQXe60GG59ViF6pTlFJosDQ40F1bgGxoy1PF/9 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="304584109"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; d="scan'208";a="304584109"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 19:09:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; d="scan'208";a="831355596"
Received: from yuefengs-mobl.ccr.corp.intel.com (HELO [10.255.30.105])
 ([10.255.30.105])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2022 19:09:51 -0700
Message-ID: <0c0e6ec8-725d-93e8-44f1-db6c8a673a97@linux.intel.com>
Date: Thu, 16 Jun 2022 10:09:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/5] iommu: Return -EMEDIUMTYPE for incompatible domain
 and device/group
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, will@kernel.org,
 marcan@marcan.st, sven@svenpeter.dev, robin.murphy@arm.com,
 robdclark@gmail.com, matthias.bgg@gmail.com, orsonzhai@gmail.com,
 baolin.wang7@gmail.com, zhang.lyra@gmail.com, jean-philippe@linaro.org,
 alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com
References: <20220616000304.23890-1-nicolinc@nvidia.com>
 <20220616000304.23890-2-nicolinc@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220616000304.23890-2-nicolinc@nvidia.com>
Cc: jordan@cosmicpenguin.net, thierry.reding@gmail.com, alyssa@rosenzweig.io,
 linux-s390@vger.kernel.org, saiprakash.ranjan@codeaurora.org,
 kvm@vger.kernel.org, jonathanh@nvidia.com,
 linux-arm-kernel@lists.infradead.org, yangyingliang@huawei.com,
 gerald.schaefer@linux.ibm.com, linux-arm-msm@vger.kernel.org,
 christophe.jaillet@wanadoo.fr, linux-tegra@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, isaacm@codeaurora.org,
 cohuck@redhat.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
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

On 2022/6/16 08:03, Nicolin Chen wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 44016594831d..0dd13330fe12 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4323,7 +4323,7 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
>   		return -ENODEV;
>   
>   	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
> -		return -EOPNOTSUPP;
> +		return -EMEDIUMTYPE;
>   
>   	/* check if this iommu agaw is sufficient for max mapped address */
>   	addr_width = agaw_to_width(iommu->agaw);
> @@ -4331,10 +4331,10 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
>   		addr_width = cap_mgaw(iommu->cap);
>   
>   	if (dmar_domain->max_addr > (1LL << addr_width)) {
> -		dev_err(dev, "%s: iommu width (%d) is not "
> +		dev_dbg(dev, "%s: iommu width (%d) is not "
>   		        "sufficient for the mapped address (%llx)\n",
>   		        __func__, addr_width, dmar_domain->max_addr);
> -		return -EFAULT;
> +		return -EMEDIUMTYPE;
>   	}
>   	dmar_domain->gaw = addr_width;

Can we simply remove the dev_err()? As the return value has explicitly
explained the failure reason, putting a print statement won't help much.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
