Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A3C433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 08:58:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A8E60FD8
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 08:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A8E60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6757E84A0E;
	Thu,  1 Apr 2021 08:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FhcdHLNnR7l0; Thu,  1 Apr 2021 08:58:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6742784A03;
	Thu,  1 Apr 2021 08:58:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 526D0C000B;
	Thu,  1 Apr 2021 08:58:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81D2FC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 08:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62C584029B
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 08:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YPsoxpr3afCj for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 08:58:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51F0940296
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 08:58:02 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBF966023B;
 Thu,  1 Apr 2021 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617267480;
 bh=qO5GnDQBxqX1f7x9zAi73eBzkaFPHd3HL6PpBB85bdk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OMfEcbl8tYPuX5WDV/d/OgcbQ4JUHkcqvauo65fQCWGZLSdEOyJdCKSebhVJ5N139
 /fRmtaxVbip3YDuWsFYMDKtqOs4Xd6epo3gS2N5xpJGPgHVdEmamYy7AzcvpXEosP2
 qaAd6IDmnhCg0n7BzRjeM+uRDfm+lbEw99nW4yPoCwBO0cqaESOj+V5MerHHeW8TwP
 w/xULX4IvKezvZLKNY9Q++cRvNJE/SGXScv/NODcscd25v0fvpY8fZHzqK5YpQ/PLl
 VRd1Aqr7RG76L5N8GCV0LhxcM4vdJWBwAMaTWReNAjFSSH9L/gNBndS5BG4l0MiV54
 I1y0PfrhuBuIw==
Date: Thu, 1 Apr 2021 09:57:52 +0100
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v13 00/10] iommu: I/O page faults for SMMUv3
Message-ID: <20210401085752.GA8781@willie-the-truck>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <YGNdQ863Mohizx7A@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YGNdQ863Mohizx7A@myrica>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: vivek.gautam@arm.com, guohanjun@huawei.com, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org
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

On Tue, Mar 30, 2021 at 07:17:55PM +0200, Jean-Philippe Brucker wrote:
> On Tue, Mar 02, 2021 at 10:26:36AM +0100, Jean-Philippe Brucker wrote:
> > Add stall support to the SMMUv3 driver, along with a common I/O Page
> > Fault handler.
> 
> I only have review/ack tags and one assert_lockdep to add to this series.
> Should I send a v14 now or wait a little longer?  Just making sure we can
> get at least patches 1-6 in v5.13.

Easiest thing is probably to send a v14 containing just the patches
targetting v5.13, so that Joerg can queue them up.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
