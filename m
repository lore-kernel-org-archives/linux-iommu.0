Return-Path: <SRS0=d63v=UZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD821C4646B
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 06:33:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B316B2085A
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 06:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jQKSqoT+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jQKSqoT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B316B2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 56700D13;
	Wed, 26 Jun 2019 06:33:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AA0D3C03
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 06:33:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 40BC882C
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 06:33:17 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E4FCB60AA8; Wed, 26 Jun 2019 06:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1561530796;
	bh=y47EEs3j4rFzzvuVXrP3J8qbvCWGuKExlUyEKd82I3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jQKSqoT+OGc8qK8Cb0iV+ye/w4DWERiv1kTftNL9AIgnn//NI911jxMDig+YJht0O
	YnwT3aDe/XWiP+7Mr36XIL10jnMh3o3aEXDtUm79gOIG39ZLp/q1WVMrtYj0EtvkMO
	3TUP3A5gdmO2R+drNSNvRhjCPL9n1GCgI0NboenE=
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
	[209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 43B106085C
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 06:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1561530796;
	bh=y47EEs3j4rFzzvuVXrP3J8qbvCWGuKExlUyEKd82I3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jQKSqoT+OGc8qK8Cb0iV+ye/w4DWERiv1kTftNL9AIgnn//NI911jxMDig+YJht0O
	YnwT3aDe/XWiP+7Mr36XIL10jnMh3o3aEXDtUm79gOIG39ZLp/q1WVMrtYj0EtvkMO
	3TUP3A5gdmO2R+drNSNvRhjCPL9n1GCgI0NboenE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43B106085C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f42.google.com with SMTP id e3so1564566edr.10
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 23:33:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVwIB/WjxB9Bk7AwQYdzTJ7VltYazGB6gV9B42czRqTACIz5ynh
	sSFh7rI2/RvNGQdk4ioC1zbaOgxOk06xOQNy4RE=
X-Google-Smtp-Source: APXvYqzcofv0J7lRvmc0VYLV63Qeh9E/WHjj9IAHvvhUT2XF9QKRxQkifiF3lHlmVsEOxNk/acWViwQ7ifuOVtKvPYA=
X-Received: by 2002:a17:906:6582:: with SMTP id x2mr2509409ejn.2.1561530795089;
	Tue, 25 Jun 2019 23:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-4-vivek.gautam@codeaurora.org>
	<20190614040520.GK22737@tuxbook-pro>
	<3e1f5e03-6448-8730-056d-fc47bdd71b3f@codeaurora.org>
	<20190618175218.GH4270@fuggles.cambridge.arm.com>
	<CAFp+6iEynLa=Jt_-oAwt4zmzxzhEXtWNCmghz6rFzcpQVGwrMg@mail.gmail.com>
	<20190624170348.7dncuc5qezqeyvq2@willie-the-truck>
	<CAFp+6iF0TQtAy2JFXk6zjX5GpjeLFesqPZV6ezbDXmc85yvMEA@mail.gmail.com>
	<20190625133924.fqq3y7p3i3fqem5p@willie-the-truck>
In-Reply-To: <20190625133924.fqq3y7p3i3fqem5p@willie-the-truck>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Wed, 26 Jun 2019 12:03:02 +0530
X-Gmail-Original-Message-ID: <CAFp+6iH-KzX7x1j8AAuKJcOP6v=fyP-yLvaeeE_Ly3oueu_ngg@mail.gmail.com>
Message-ID: <CAFp+6iH-KzX7x1j8AAuKJcOP6v=fyP-yLvaeeE_Ly3oueu_ngg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iommu/arm-smmu: Add support to handle Qcom's
	wait-for-safe logic
To: Will Deacon <will@kernel.org>
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

On Tue, Jun 25, 2019 at 7:09 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jun 25, 2019 at 12:34:56PM +0530, Vivek Gautam wrote:
> > On Mon, Jun 24, 2019 at 10:33 PM Will Deacon <will@kernel.org> wrote:
> > > Instead, I think this needs to be part of a separate file that is maintained
> > > by you, which follows on from the work that Krishna is doing for nvidia
> > > built on top of Robin's prototype patches:
> > >
> > > http://linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/smmu-impl
> >
> > Looking at this branch quickly, it seem there can be separate implementation
> > level configuration file that can be added.
> > But will this also handle separate page table ops when required in future.
>
> Nothing's set in stone, but having the implementation-specific code
> constrain the page-table format (especially wrt quirks) sounds reasonable to
> me. I'm currently waiting for Krishna to respin the nvidia changes [1] on
> top of this so that we can see how well the abstractions are holding up.

Sure. Would you want me to try Robin's branch and take out the qualcomm
related stuff to its own implementation? Or, would you like me to respin this
series so that you can take it in to enable SDM845 boards such as, MTP
and dragonboard to have a sane build - debian, etc. so people benefit
out of it.
Qualcomm stuff is lying in qcom-smmu and arm-smmu and may take some
time to stub out the implementation related details.
Let me know your take.

Thanks & regards
Vivek

>
> I certainly won't merge the stuff until we have a user.
>
> Will
>
> [1] https://lkml.kernel.org/r/1543887414-18209-1-git-send-email-vdumpa@nvidia.com
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
