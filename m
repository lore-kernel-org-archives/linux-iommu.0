Return-Path: <SRS0=d63v=UZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACECDC48BD9
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BC521738
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVyyJTKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BC521738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3C423C86;
	Wed, 26 Jun 2019 14:48:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 25080C3A
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 14:48:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C9C80710
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 14:48:50 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A227A205C9;
	Wed, 26 Jun 2019 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561560530;
	bh=Q0fkJnt5Wk/wU807scvnJI4s4UA4UjwWKB0s0wc3Xm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVyyJTKAehLp05zG/pwe9Aa0/ZSb6jmhAh7fYWRrQXRe15i7Nde+lWOqOrHb21zCS
	I5b5iC0ODpC6vtRvyZwwNJHkjG6b2B82I8tgZ7I8FFj5w751IN+kgPwk5zvzxXWuut
	Ad9RXJbltpQ3GJ3YyUAXj1PB4wW1p/znSA1zDdnw=
Date: Wed, 26 Jun 2019 15:48:45 +0100
From: Will Deacon <will@kernel.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v3 3/4] iommu/arm-smmu: Add support to handle Qcom's
	wait-for-safe logic
Message-ID: <20190626144844.key3n6ueb6skgkp4@willie-the-truck>
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-4-vivek.gautam@codeaurora.org>
	<20190614040520.GK22737@tuxbook-pro>
	<3e1f5e03-6448-8730-056d-fc47bdd71b3f@codeaurora.org>
	<20190618175218.GH4270@fuggles.cambridge.arm.com>
	<CAFp+6iEynLa=Jt_-oAwt4zmzxzhEXtWNCmghz6rFzcpQVGwrMg@mail.gmail.com>
	<20190624170348.7dncuc5qezqeyvq2@willie-the-truck>
	<CAFp+6iF0TQtAy2JFXk6zjX5GpjeLFesqPZV6ezbDXmc85yvMEA@mail.gmail.com>
	<20190625133924.fqq3y7p3i3fqem5p@willie-the-truck>
	<CAFp+6iH-KzX7x1j8AAuKJcOP6v=fyP-yLvaeeE_Ly3oueu_ngg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFp+6iH-KzX7x1j8AAuKJcOP6v=fyP-yLvaeeE_Ly3oueu_ngg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	David Brown <david.brown@linaro.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	robh+dt <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Jun 26, 2019 at 12:03:02PM +0530, Vivek Gautam wrote:
> On Tue, Jun 25, 2019 at 7:09 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Jun 25, 2019 at 12:34:56PM +0530, Vivek Gautam wrote:
> > > On Mon, Jun 24, 2019 at 10:33 PM Will Deacon <will@kernel.org> wrote:
> > > > Instead, I think this needs to be part of a separate file that is maintained
> > > > by you, which follows on from the work that Krishna is doing for nvidia
> > > > built on top of Robin's prototype patches:
> > > >
> > > > http://linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/smmu-impl
> > >
> > > Looking at this branch quickly, it seem there can be separate implementation
> > > level configuration file that can be added.
> > > But will this also handle separate page table ops when required in future.
> >
> > Nothing's set in stone, but having the implementation-specific code
> > constrain the page-table format (especially wrt quirks) sounds reasonable to
> > me. I'm currently waiting for Krishna to respin the nvidia changes [1] on
> > top of this so that we can see how well the abstractions are holding up.
> 
> Sure. Would you want me to try Robin's branch and take out the qualcomm
> related stuff to its own implementation? Or, would you like me to respin this
> series so that you can take it in to enable SDM845 boards such as, MTP
> and dragonboard to have a sane build - debian, etc. so people benefit
> out of it.

I can't take this series without Acks on the firmware calling changes, and I
plan to send my 5.3 patches to Joerg at the end of the week so they get some
time in -next. In which case, I think it may be worth you having a play with
the branch above so we can get a better idea of any additional smmu_impl hooks
you may need.

> Qualcomm stuff is lying in qcom-smmu and arm-smmu and may take some
> time to stub out the implementation related details.

Not sure I follow you here. Are you talking about qcom_iommu.c?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
