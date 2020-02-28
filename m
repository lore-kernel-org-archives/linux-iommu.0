Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC05FC3F2C6
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 02:57:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FFF2469B
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 02:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+3gX3Cl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FFF2469B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3A92420437;
	Fri, 28 Feb 2020 02:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HnoAp7XDjCKB; Fri, 28 Feb 2020 02:57:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B524B203B8;
	Fri, 28 Feb 2020 02:57:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 829C4C1D80;
	Fri, 28 Feb 2020 02:57:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAE52C0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 02:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 945A786CFD
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 02:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NcyRBBi2y_mX for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 02:57:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6029385E85
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 02:57:04 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id d9so729147pgu.3
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rASt1j8T2my4BXnw+qq/JhwHqrPUkRKUBt8AYSRQGCE=;
 b=t+3gX3Clw8dFgzjzUq/Y8U+6dX2WfPjGQP4hkO0VPCaNXyT2IxS2+Lilxyf914uWWP
 dVni36ypbnkx2qnO2PNrn9TK1c74b/UHtp1o+qEmG4nrjvpuRNrfobs3sCXEAxffWk08
 DaSYJGEh16Pf9LlgnrdwAGaPdYDSVv7s2whH9KNKBEnpusXQL327ewmZIYNMVDGN80uT
 15Poy+KqPkgyOS5VhtiCL9aS5jYlwy/uoV4tbIIkVwD/ckO99WbpD1fjTlfi+03CaLfQ
 HxtAfNBAGxrRIKqkt2TBtp0nusoeHdLUJf6iX2wPlcj2ZaXNaNosMKHIyT3hq6+px9g3
 dLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rASt1j8T2my4BXnw+qq/JhwHqrPUkRKUBt8AYSRQGCE=;
 b=LIlOenJ5xqTSHYIzKANtkTu/BViC6x4eJIedfzLCjOgiRaODDTHKC/iLFyVditI1YT
 byUlCuAhqNRJWy/YIZf/UczzH8x1OT/YQ1LcPsz8LbRdKBxe2APkYrKXGlMBfAO443jt
 8dx8PsBe0Eg5rzHMzPIRTfCyDB2nTN+qjaaQgGFEG2Kx5AnhNOBI9bFb6Bmsz5/hwjtF
 sMRJhemEIKabMMF8Xb1Ig5Ibr8MPumRsEGR/dk3BlcmvT6BH5kx2+ODvgp+tvEhUENcc
 4DKQSFLJBuYnPQV69F37uUQ/Vjp9ICnEQpm5M19pwIN/H2a7sV8FoKtJCzrG8Xzl29ro
 5V0Q==
X-Gm-Message-State: APjAAAXAz01hgJPNEjNEOLcwbwZK17Pftkto39/ED7FXcimH+457oB5W
 rqp8lZ6mStSwU+2hdDFIMclWEA==
X-Google-Smtp-Source: APXvYqzcXXbb5r8K/K59vpg2+eEZtv4LjyQ9MnFfJCsT56TwF8dv8U50T5PUyzEDLnGKZpJkUs9TUg==
X-Received: by 2002:a63:3d0a:: with SMTP id k10mr2307261pga.233.1582858623570; 
 Thu, 27 Feb 2020 18:57:03 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id u4sm7884236pgu.75.2020.02.27.18.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 18:57:02 -0800 (PST)
Date: Thu, 27 Feb 2020 18:57:00 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Message-ID: <20200228025700.GA856087@builder>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191209150748.2471814-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Mon 09 Dec 07:07 PST 2019, Thierry Reding wrote:

> From: Thierry Reding <treding@nvidia.com>
> 

Sorry for the slow response on this, finally got the time to go through
this in detail and try it out on some Qualcomm boards.

> On some platforms, the firmware will setup hardware to read from a given
> region of memory. One such example is a display controller that is
> scanning out a splash screen from physical memory.
> 

This particular use case is the one that we need to figure out for
Qualcomm devices as well; on some devices it's a simple splash screen
(that on many devices can be disabled), but for others we have EFIFB
on the display and no (sane) means to disable this.

> During Linux' boot process, the ARM SMMU will configure all contexts to
> fault by default. This means that memory accesses that happen by an SMMU
> master before its driver has had a chance to properly set up the IOMMU
> will cause a fault. This is especially annoying for something like the
> display controller scanning out a splash screen because the faults will
> result in the display controller getting bogus data (all-ones on Tegra)
> and since it repeatedly scans that framebuffer, it will keep triggering
> such faults and spam the boot log with them.
> 

As my proposed patches indicated, the Qualcomm platform boots with
stream mapping setup for the hardware used by the bootloader, but
relying on the associated context banks not being enabled.

USFCFG in SCR0 is set and any faults resulting of this will trap into
secure world and the device will be reset.

> In order to work around such problems, scan the device tree for IOMMU
> masters and set up a special identity domain that will map 1:1 all of
> the reserved regions associated with them. This happens before the SMMU
> is enabled, so that the mappings are already set up before translations
> begin.
> 
> One thing that was pointed out earlier, and which I don't have a good
> idea on how to solve it, is that the early identity domain is not
> discarded. The assumption is that the standard direct mappings code of
> the IOMMU framework will replace the early identity domain once devices
> are properly attached to domains, but we don't have a good point in time
> when it would be safe to remove the early identity domain.
> 
> One option that I can think of would be to create an early identity
> domain for each master and inherit it when that master is attached to
> the domain later on, but that seems rather complicated from an book-
> keeping point of view and tricky because we need to be careful not to
> map regions twice, etc.
> 

The one concern I ran into with this approach (after resolving below
issues) is that when the display driver probes a new domain will be
created automatically and I get a stream of "Unhandled context fault" in
the log until the driver has mapped the framebuffer in the newly
allocated context.

This is normally not a problem, as we seem to be able to do this
initialization in a few frames, but for the cases where the display
driver probe defer this is a problem.

But at least these devices doesn't reboot, so this is way better than the
current state.

> Any good ideas on how to solve this? It'd also be interesting to see if
> there's a more generic way of doing this. I know that something like
> this isn't necessary on earlier Tegra SoCs with the custom Tegra SMMU
> because translations are only enabled when the devices are attached to a
> domain. I'm not sure about other IOMMUs, but in the absence of a struct
> device, I suspect that we can't really do anything really generic that
> would work across drivers.
> 

As I indicated above I managed to get this working on the boards we have
that uses the arm-smmu driver.

## SDM845
Booting the SDM845 shows the following register stream mapping register
content:
  SMR(0): 0x80080880 S2CR(0): 0x0
  SMR(1): 0x80080c80 S2CR(1): 0x0
  SMR(2): 0x800f00a0 S2CR(2): 0x1
  SMR(3): 0x800f00c0 S2CR(3): 0x1
  SMR(4): 0x800f00e0 S2CR(4): 0x2
  SMR(5): 0x800f0100 S2CR(5): 0x2
  SMR(6): 0x0 S2CR(6): 0x0
  SMR(7): 0x0 S2CR(7): 0x0
  SMR(8): 0x0 S2CR(8): 0x200ff
  SMR(9): 0x0 S2CR(9): 0x200ff
  ...

Here stream 0 and 1 (SID 0x880 and 0xc80) are the display streams, the
remainder are related to storage and USB - which afaict doesn't need to be
maintained.

As the display uses context bank 0, using this as the identity bank results in
a couple of occurrences of:
  Unhandled context fault: fsr=0x402, iova=0x9da00000, fsynr=0x370020, cbfrsynra=0x880, cb=0

Which we survive, but as we reach arm_smmu_device_reset() to flush out the new
stream mapping we start by writing S2CR(0) = 0, then SMR(0) = 0x800810a0. So
until SMR(4) is written we're lacking a valid stream mapping for the display,
and hence if the screen does refresh in during time period the device reboots.


In addition to this, the iommu_iova_to_phys() you perform in the mapping loop
results in a large number of "translation fault!" printouts from
arm_smmu_iova_to_phys_hard().

## SM8150
Boots with the following stream mapping:
  SMR(0): 0x800006a0 S2CR(0): 0x0
  SMR(1): 0x800006c0 S2CR(1): 0x0
  SMR(2): 0x80000300 S2CR(2): 0x1
  SMR(3): 0x84200800 S2CR(3): 0x2
  SMR(4): 0x0 S2CR(4): 0x0
  SMR(5): 0x0 S2CR(5): 0x0
  SMR(6): 0x0 S2CR(6): 0x200ff
  SMR(7): 0x0 S2CR(7): 0x200ff
  ...

Here stream 3 (sid 0x800) is the display stream.

Mapping the various memory regions into the first context works fine, but
unless the display stream happens to be allocated to stream 3 (e.g. it always
ends up in slot 1 with my current DT) the board reboots shortly after we start
writing out the SMRs. I've not yet figured out why the board faults because of
the move to an earlier SMR index. (Perhaps because we clear the previously used
display SMR valid bit?)


## Conclusions
Both of these platforms indicates that moving the stream mapping around is
going to cause issues, so inspired by my proposal I added below snippet right
before the call to arm_smmu_setup_identity(), in order to populate the stream
mapping selection.

	for (i = 0; i < smmu->num_mapping_groups; i++) {
		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
		smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
		smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
		smmu->smrs[i].valid = !!(smr & ARM_SMMU_SMR_VALID);
	}

With this both boards boots fine, but I know Will had reservations wrt trusting
these values. Perhaps we could use the read back values (with some sanity
checking) only for setting up identity mapping?


With this I also tested booting MSM8996 (the db820c board) and except for
spending about 75 seconds printing below error in the kernel log during boot
things seems to be functional.

[   96.670723] arm-smmu b40000.iommu: translation fault!
[   96.675038] arm-smmu b40000.iommu: PAR = 0x300000203


Removing the call to iommu_iova_to_phys() in the mapping loop (as I know
that I don't have any memory regions with multiple clients) solves the
log spamming and all three boards seems to be functional.

Regards,
Bjorn

> Thierry
> 
> Thierry Reding (2):
>   iommu: arm-smmu: Extract arm_smmu_of_parse()
>   iommu: arm-smmu: Add support for early direct mappings
> 
>  drivers/iommu/arm-smmu.c | 195 +++++++++++++++++++++++++++++++++++++--
>  drivers/iommu/arm-smmu.h |   2 +
>  2 files changed, 189 insertions(+), 8 deletions(-)
> 
> -- 
> 2.23.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
