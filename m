Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB6FC433E1
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 10:53:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38B720747
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 10:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38B720747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8F61D2FCDA;
	Wed,  1 Jul 2020 10:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PrhjA49DAOCs; Wed,  1 Jul 2020 10:53:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C4DA926387;
	Wed,  1 Jul 2020 10:53:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E78FC0865;
	Wed,  1 Jul 2020 10:53:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B328C0733;
 Wed,  1 Jul 2020 10:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 52D6F8AC04;
 Wed,  1 Jul 2020 10:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03IVVzt2GxJ8; Wed,  1 Jul 2020 10:53:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8AA5B8AC02;
 Wed,  1 Jul 2020 10:53:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B597030E;
 Wed,  1 Jul 2020 03:53:12 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB9483F73C;
 Wed,  1 Jul 2020 03:53:08 -0700 (PDT)
Subject: Re: [PATCH v3 00/34] iommu: Move iommu_group setup to IOMMU core code
To: Qian Cai <cai@lca.pw>, Joerg Roedel <joro@8bytes.org>
References: <20200429133712.31431-1-joro@8bytes.org>
 <20200701004020.GA6221@lca.pw>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9b0ef27a-f249-a90b-9899-e53b946f83cc@arm.com>
Date: Wed, 1 Jul 2020 11:53:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701004020.GA6221@lca.pw>
Content-Language: en-GB
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Drake <drake@endlessm.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
 Andy Gross <agross@kernel.org>, jonathan.derrick@intel.com,
 linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2020-07-01 01:40, Qian Cai wrote:
> Looks like this patchset introduced an use-after-free on arm-smmu-v3.
> 
> Reproduced using mlx5,
> 
> # echo 1 > /sys/class/net/enp11s0f1np1/device/sriov_numvfs
> # echo 0 > /sys/class/net/enp11s0f1np1/device/sriov_numvfs
> 
> The .config,
> https://github.com/cailca/linux-mm/blob/master/arm64.config
> 
> Looking at the free stack,
> 
> iommu_release_device->iommu_group_remove_device
> 
> was introduced in 07/34 ("iommu: Add probe_device() and release_device()
> call-backs").

Right, iommu_group_remove_device can tear down the group and call 
->domain_free before the driver has any knowledge of the last device 
going away via the ->release_device call.

I guess the question is do we simply flip the call order in 
iommu_release_device() so drivers can easily clean up their internal 
per-device state first, or do we now want them to be robust against 
freeing domains with devices still nominally attached?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
