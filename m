Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D54EC48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 19:50:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A8161246
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 19:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A8161246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16B3960898;
	Tue, 15 Jun 2021 19:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NswtWHfMrViY; Tue, 15 Jun 2021 19:50:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E3D5560873;
	Tue, 15 Jun 2021 19:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD52BC000E;
	Tue, 15 Jun 2021 19:50:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B4C1C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 572A54015D
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:50:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RS0CyTRtgYQJ for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 19:50:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4867440133
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 19:50:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14BCA6128B;
 Tue, 15 Jun 2021 19:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623786635;
 bh=mArWVnYnQ6vLGF4/jXFA3EDckajI1UgQo8mIcx1O5ZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gp3kyyAH1Qs4tAACkkmh3LljxheC2CwXfAuW0NZ/NBAuKRtYK/syOIDj8HmnK5p6C
 X2hfYs6dZfSdrf5i7wlq802Ifw0a4uzQHZLseBvuieQYZFobKapi7DLmWwvcWDTGKK
 nfQ3WfSPwSrMDWSbu0D2x1DwII7R3AcopYWv/YsiCAbBUywpobjFBPEOO2FhbugX3f
 ucX/+IvX6ihNhNVlc1gt+4LoRhtSiWaRoQul2MAaoHM2pzOVTefqgwbCYkkhoxzAg+
 dnB2VFqFHMKzu8LuG0jcEjWGXOvsxLRUiik2/2RSuZEtJWN5vVElmAH9cp/0gnDF5i
 p9tONIgr6dJ8g==
Date: Tue, 15 Jun 2021 20:50:30 +0100
From: Will Deacon <will@kernel.org>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v3 3/9] iommu/arm-smmu: Implement ->probe_finalize()
Message-ID: <20210615195030.GA21783@willie-the-truck>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
 <20210603164632.1000458-4-thierry.reding@gmail.com>
 <CGME20210615180133eucas1p2563c2a173eca1fb5a1c5ccf654c23778@eucas1p2.samsung.com>
 <46e65ade-49cb-5437-5863-1f11ccc2205e@samsung.com>
 <BY5PR12MB376468558EB3330D64758210B3309@BY5PR12MB3764.namprd12.prod.outlook.com>
 <20210615182135.GA21481@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210615182135.GA21481@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Tue, Jun 15, 2021 at 07:21:35PM +0100, Will Deacon wrote:
> On Tue, Jun 15, 2021 at 06:12:13PM +0000, Krishna Reddy wrote:
> > > if (smmu->impl->probe_finalize)
> > 
> > The above is the issue. It should be updated as below similar to other instances impl callbacks.
> > if (smmu->impl && smmu->impl->probe_finalize)
> 
> I'll push a patch on top shortly...

Done:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-thierry/arm-smmu

I'll send this lot to Joerg tomorrow.

Thierry -- feel free to pull in the updated branch if you want the fix
sooner, as it may be a few days before this hits -next.

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
