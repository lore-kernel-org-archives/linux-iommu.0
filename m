Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5BCC433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 10:55:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC5020772
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 10:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgR12O8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC5020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6904C89502;
	Wed,  1 Jul 2020 10:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrc-nfd6mmzr; Wed,  1 Jul 2020 10:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 65ED08951F;
	Wed,  1 Jul 2020 10:55:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52E30C0865;
	Wed,  1 Jul 2020 10:55:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32AD3C0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 10:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2F1F28951F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 10:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y8wZH6rY6bEa for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 10:54:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B77A689502
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 10:54:58 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EBABC20772;
 Wed,  1 Jul 2020 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593600898;
 bh=kFLbdxE6sSIcNsnsddE2qZP4FZAiRNNpfl5wA+Xrld0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MgR12O8nRyvqokAVh6wbQMK5Ovx61t7pTRUxsEqpRRgDam5/Wioi2uTYGRtF0oUav
 o/j3NjcDMdGIPdHvroRHw/22S4Z24639UdcXlTEFTN86GEtAlsdP2Ra69RDntWcqHT
 NyOMy7+IXZOsU0q3rmsKRSXbY9aO+mEX1zvBlEZs=
Date: Wed, 1 Jul 2020 11:54:54 +0100
From: Will Deacon <will@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Message-ID: <20200701105453.GG14959@willie-the-truck>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200228025700.GA856087@builder>
 <20200514193249.GE279327@builder.lan>
 <CALAqxLVmomdKJCwh=e-PX+8-seDX0RXA81FzmG4sEyJmbXBh9A@mail.gmail.com>
 <20200527110343.GD11111@willie-the-truck>
 <20200602063210.GT11847@yoga>
 <a1f9ee83-66cd-1f04-3e78-3281b3cafd07@arm.com>
 <20200701074050.GO388985@builder.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200701074050.GO388985@builder.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 John Stultz <john.stultz@linaro.org>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Wed, Jul 01, 2020 at 12:40:50AM -0700, Bjorn Andersson wrote:
> On Wed 03 Jun 04:00 PDT 2020, Robin Murphy wrote:
> > at that point I'm inclined to suggest we give up and stop trying to
> > drive these things with arm-smmu. The XZR thing was bad enough, but if
> > they're not even going to pretend to implement the architecture correctly
> > then I'm not massively keen to continue tying the architectural driver in
> > further knots if innocent things like CONFIG_IOMMU_DEFAULT_PASSTHROUGH are
> > going to unexpectedly and catastrophically fail. We have qcom-iommu for
> > hypervisor-mediated SMMUs, and this new hypervisor behaviour sounds to me
> > more like "qcom-iommu++" with reassignable stream-to-context mappings,
> > rather than a proper Arm SMMU emulation.
> > 
> 
> I've been going through over and over, hoping to perhaps be able to
> evolve qcom_iommu into a qcom-iommu++, but afaict the new hypervisor is
> different enough that this isn't feasible. In particular, the platforms
> using qcom_iommu relies entirely on the hypervisor to configure stream
> mapping etc - and we can't even read most of the registers.
> 
> On the other hand I agree with you that we're messing around quite a bit
> with the arm-smmu driver, and I'm uncertain where we are on supporting
> the various GPU features, so I'm adding Jordan to the thread.
> 
> So, afaict we have the options of either shoehorning this too into the
> arm-smmu driver or we essentially fork arm-smmu.c to create a
> qcom-smmu.c.
> 
> While I don't fancy the code duplication, it would allow us to revert
> the Qualcomm quirks from arm-smmu and would unblock a number of
> activities that we have depending on getting the SMMU enabled on various
> platforms.

We added the impl hooks to cater for implementation differences, so I'd
still prefer to see this done as part of arm-smmu than introduce another
almost-the-same-but-not-quite IOMMU driver that has the lifetime of
a single SoC.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
