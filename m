Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FC8C433F5
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 12:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 690BD4055F;
	Tue,  5 Apr 2022 12:16:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A6Q80uXK6GPm; Tue,  5 Apr 2022 12:16:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 99D90400F1;
	Tue,  5 Apr 2022 12:15:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A8F7C001D;
	Tue,  5 Apr 2022 12:15:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 044A2C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 12:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D534540265
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 12:15:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H9d01dktliXp for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 12:15:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0FD040255
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649160956; x=1680696956;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eLlXIWgzT4jg7igfmDa9mpSj+r1W/DMEJ9zt2e+BDk4=;
 b=BROFxVoaMdJ9K3TW78g89ECva9COhsR+KZdSIpNuB+CplyS31FqpO7KS
 f+Zm8dbgsvviWO1GUchRhbsi/1kokykUjP1y4U/EyTtDEw42dYU75wCu3
 3X5Ptdp6q1WLlWcrqBe32i5YI1H9KD68oIkJLwql2cLkbqBSRi8mKkK6b
 0nPcCcdUzoSG91pJYUKZu161QQ24tTkQX3sZC+RlsRxN/PZKY9fh7QPq0
 IVsopk/QFZ/K/+32GBkMd1ifAu9XYmQE9/ioSSCBc+yzhWPhx500Ml1cR
 NMAMur2fpbInQJex6lxim03Np6JG9U1SrmDYabBz4JwP8nZf9+TN1ntpT g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="241320006"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; d="scan'208";a="241320006"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2022 05:15:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; d="scan'208";a="505260917"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2022 05:15:51 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 05 Apr 2022 15:09:07 +0300
Date: Tue, 5 Apr 2022 15:09:07 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 3/4] thunderbolt: Make iommu_dma_protection more
 accurate
Message-ID: <YkwxY59ACqFF9jer@lahna>
References: <cover.1649089693.git.robin.murphy@arm.com>
 <b1f89ea2ad38221e0b75783357b9afb53087061d.1649089693.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b1f89ea2ad38221e0b75783357b9afb53087061d.1649089693.git.robin.murphy@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: michael.jamet@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, hch@lst.de
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

On Tue, Apr 05, 2022 at 11:41:03AM +0100, Robin Murphy wrote:
> Between me trying to get rid of iommu_present() and Mario wanting to
> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has shown
> that the iommu_dma_protection attribute is being far too optimistic.
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device(s)
> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> is tell us that memory was protected before the kernel was loaded, and
> prevent the user from disabling the intel-iommu driver entirely. While
> that lets us assume kernel integrity, what matters for actual runtime
> DMA protection is whether we trust individual devices, based on the
> "external facing" property that we expect firmware to describe for
> Thunderbolt ports.
> 
> It's proven challenging to determine the appropriate ports accurately
> given the variety of possible topologies, so while still not getting a
> perfect answer, by putting enough faith in firmware we can at least get
> a good bit closer. If we can see that any device near a Thunderbolt NHI
> has all the requisites for Kernel DMA Protection, chances are that it
> *is* a relevant port, but moreover that implies that firmware is playing
> the game overall, so we'll use that to assume that all Thunderbolt ports
> should be correctly marked and thus will end up fully protected.
> 
> CC: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
