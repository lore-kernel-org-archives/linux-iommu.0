Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71A1C433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 11:02:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F6761354
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 11:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F6761354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C52A383AC7;
	Tue, 20 Apr 2021 11:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id urSY18Hp1lb7; Tue, 20 Apr 2021 11:02:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id C700B8387D;
	Tue, 20 Apr 2021 11:02:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADD8EC000F;
	Tue, 20 Apr 2021 11:02:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A320C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 11:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E637D4051A
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 11:02:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vjSTN90i_-4Z for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:02:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22E5840518
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 11:02:12 +0000 (UTC)
IronPort-SDR: +GLblNlAeWMPOciKofTKriJoH9bJ0NZ5eeJI4LLz1O2p+R/nK6Z6AsCaFlT/zMFYSMNUQv5dFV
 8p4nG4H9gobw==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="256799125"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; d="scan'208";a="256799125"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 04:02:10 -0700
IronPort-SDR: N9iqe5rW/vWlxZk0379oiq5CffC1Hbl+wY8nYTO3bqO3IjZx+G2xwnfFGXI0c4Jmv7UrdqGyQo
 SpkKMgYJjIOw==
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; d="scan'208";a="390958865"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 04:02:06 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
 by paasikivi.fi.intel.com (Postfix) with SMTP id B2A7922C62;
 Tue, 20 Apr 2021 13:56:40 +0300 (EEST)
Date: Tue, 20 Apr 2021 13:56:40 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bingbu Cao <bingbu.cao@linux.intel.com>
Subject: Re: [RESEND v2] iommu/vt-d: Use passthrough mode for the Intel IPUs
Message-ID: <20210420105640.GI3@paasikivi.fi.intel.com>
References: <1618886913-6594-1-git-send-email-bingbu.cao@intel.com>
 <YH6q+FCTQheO6FHi@smile.fi.intel.com>
 <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c9a0fc75-8b7b-e0ae-572e-8ca030a04537@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: rajatja@google.com, will@kernel.org, grundler@chromium.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 senozhatsky@chromium.org, iommu@lists.linux-foundation.org,
 bhelgaas@google.com, Bingbu Cao <bingbu.cao@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, dwmw2@infradead.org
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

Hi Bingbu,

On Tue, Apr 20, 2021 at 06:34:26PM +0800, Bingbu Cao wrote:
> Andy,
> 
> On 4/20/21 6:20 PM, Andy Shevchenko wrote:
> > On Tue, Apr 20, 2021 at 10:48:33AM +0800, Bingbu Cao wrote:
> >> Intel IPU(Image Processing Unit) has its own (IO)MMU hardware,
> >> The IPU driver allocates its own page table that is not mapped
> >> via the DMA, and thus the Intel IOMMU driver blocks access giving
> >> this error:
> >>
> >> DMAR: DRHD: handling fault status reg 3
> >> DMAR: [DMA Read] Request device [00:05.0] PASID ffffffff
> >>       fault addr 76406000 [fault reason 06] PTE Read access is not set
> >>
> >> As IPU is not an external facing device which is not risky, so use
> >> IOMMU passthrough mode for Intel IPUs.
> >>
> >> Fixes: 26f5689592e2 ("media: staging/intel-ipu3: mmu: Implement driver")
> >> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> >> ---
> >>  drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
> > 
> > This misses the changelog from v1 followed by the explanation why resent.
> > 
> I noticed there was a typo in the recipient list:
> stable.vger.kernel.org -> stable@vger.kernel.org
> 
> no code change for resent.

When you're submitting a patch and want it reach the stable kernels, you'll
need to add a Cc tag:

	Cc: stable@vger.kernel.org

But not actually add the address to cc. I dropped stable@vger address from
distribution.

Please change this for v3.

-- 
Kind regards,

Sakari Ailus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
