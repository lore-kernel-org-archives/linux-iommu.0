Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B28C4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 12:49:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA32561076
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 12:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA32561076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84DB7401F1;
	Mon,  9 Aug 2021 12:49:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OMAJaIKekCMc; Mon,  9 Aug 2021 12:49:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B84D401C3;
	Mon,  9 Aug 2021 12:49:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 106C5C0010;
	Mon,  9 Aug 2021 12:49:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91AF8C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 12:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73C2A60647
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 12:49:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWjLMRmRTbBJ for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 12:49:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0335D60598
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 12:49:37 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B53160FE3;
 Mon,  9 Aug 2021 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628513377;
 bh=DuWuffUzHWTlh5RyIppkfZJMBWUzwes3xWNKxmTLe/0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jk+7pKgZ+88oYQV9NkXW4+7DYuSYjjTwrgQJpOrttxXIl5tKNVCJEgrkyQdFPhMBz
 f+hMsHunXnbXXesw+l55zR366ZFmUEFCU46XuqwsX9p51Orqm4/orNB9V6uk/Qf427
 M8lkagHV1KbxaWYI5iHUprg2PxaP5mEWPsbx4edZ51DKNkwnlvb24ksb39kRyXaIUh
 R4mSwsA0e80ppbX3SHwNrX0m85MhDas0fjY1UT3lTv39wJhvOa8g5cqTbMM2vtoEbn
 CNkDkUHMlk+b6ei3yicYLMvxr7anZ9IQoNRNMXm/AvyXMBtyTtb5tMvU3WkqdmVQv3
 Yh+XgBvSP2Q1A==
Date: Mon, 9 Aug 2021 13:49:32 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 25/25] iommu: Allow enabling non-strict mode dynamically
Message-ID: <20210809124931.GA1097@willie-the-truck>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <22b044263f69e2bfe404c4379a435005ea58b3e2.1628094601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <22b044263f69e2bfe404c4379a435005ea58b3e2.1628094601.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
 iommu@lists.linux-foundation.org, rajatja@google.com,
 linux-arm-kernel@lists.infradead.org
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

On Wed, Aug 04, 2021 at 06:15:53PM +0100, Robin Murphy wrote:
> Allocating and enabling a flush queue is in fact something we can
> reasonably do while a DMA domain is active, without having to rebuild it
> from scratch. Thus we can allow a strict -> non-strict transition from
> sysfs without requiring to unbind the device's driver, which is of
> particular interest to users who want to make selective relaxations to
> critical devices like the one serving their root filesystem.
> 
> Disabling and draining a queue also seems technically possible to
> achieve without rebuilding the whole domain, but would certainly be more
> involved. Furthermore there's not such a clear use-case for tightening
> up security *after* the device may already have done whatever it is that
> you don't trust it not to do, so we only consider the relaxation case.
> 
> CC: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Actually think about concurrency, rework most of the fq data
>     accesses to be (hopefully) safe and comment it all
> ---
>  drivers/iommu/dma-iommu.c | 25 ++++++++++++++++++-------
>  drivers/iommu/iommu.c     | 16 ++++++++++++----
>  drivers/iommu/iova.c      |  9 ++++++---
>  3 files changed, 36 insertions(+), 14 deletions(-)

I failed to break this, so hopefully you've caught everything now.

Only thing I wasn't sure of is why we still need the smp_wmb() in
init_iova_flush_queue(). Can we remove it now that we have one before
assigning into the cookie?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
