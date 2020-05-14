Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA0AC433E0
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 20:36:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5A12065C
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 20:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqQpJERe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5A12065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4AB0687A76;
	Thu, 14 May 2020 20:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UuF3OEidAVbD; Thu, 14 May 2020 20:36:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9AF9587A53;
	Thu, 14 May 2020 20:36:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E27EC0863;
	Thu, 14 May 2020 20:36:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6803C016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 20:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9ACE08836A
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 20:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B9mUhpOxuZXy for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 20:36:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7FD9C8972A
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 20:36:05 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id x13so1872924pfn.11
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=McFSJB7HsIwhycgIHB7X1kIeZAvcAuEmliX4NQltzFU=;
 b=pqQpJEReLZpYwUZQWIgGAUmcsgMkgpjAeLyW1/1iYNBAnvXpGrOHV8iAoPAOdLiFIG
 H1qrzRHwDoSP0yC1MNqUPh3qTgyJ+8oEqzzyzhXHr4SHnq9u9qXEnRWJjGgeqwilAVil
 P3qr+R30kQ4GnI2hOFrDAhnRbH8Y05mnE+Zi/cso7Vg21Q/66uEZ2a0LhMrhTX1dxQ9Y
 VPa2AmG3FkHaoJlinyYVc73/dmLpsnPJFseWsApiZ7kErQpMNRyIEqLvyCX3SHSY8R7/
 l6Lv3hdl8aumVCuaaKzPiJ+LmLO8/npeV488C0GG3amWHNKHiCZZS2WM/d/Jpa3vEmQe
 cvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=McFSJB7HsIwhycgIHB7X1kIeZAvcAuEmliX4NQltzFU=;
 b=VY8zr1C3X92LMQtfA2VEwjn79RJa7nkeYFHhGDk9ZV0nThUp8hFBAgmvIJlyhbQmR7
 apqlg/kLIwoPS7PqXV6NRQcCjLVkOdqsN/CU2mqah7N+8ZOAHgHwh3VMOS+1laWPIf2k
 g20k0KPW1xlLQOC6IE4t/qyYDh0GwMFUoJnvzvFuS4iMU0nS3rUSkoiU75MTkXwbINXB
 /gDffzjnKb9jt4/wTO1I0Rh2q1BWlX1Hr5TaUU+LoVZMmwlYue3Xiho9FA8dCJEh8oSG
 3qZc2OsUTllRYhfO9YaLybL0/iz+uzSX6AwwPkaz/S90l2Jk0pnisj6Lm3C5XHb5KK6K
 IiFg==
X-Gm-Message-State: AOAM531jW+VsNAO6YdY86C1OZB2IuU0FSFzVGIZ7fBWpwkLof1su7aZ0
 eyWGqcfRHh3rpRHly3duHxHz2kSD0Hg=
X-Google-Smtp-Source: ABdhPJwKVXS6X4qpAkvwaENwakprdx3N54UWjg/skU1suyXAI3EjF3LRZlARYv8qTSuTIMqgkhZ3MQ==
X-Received: by 2002:a17:902:7c05:: with SMTP id
 x5mr114752pll.278.1589484859261; 
 Thu, 14 May 2020 12:34:19 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id v10sm16642902pjy.48.2020.05.14.12.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:34:18 -0700 (PDT)
From: bjorn.andersson@linaro.org
X-Google-Original-From: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Date: Thu, 14 May 2020 12:32:49 -0700
To: Thierry Reding <thierry.reding@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Message-ID: <20200514193249.GE279327@builder.lan>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200228025700.GA856087@builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228025700.GA856087@builder>
Cc: linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Thu 27 Feb 18:57 PST 2020, Bjorn Andersson wrote:

Rob, Will, we're reaching the point where upstream has enough
functionality that this is becoming a critical issue for us.

E.g. Lenovo Yoga C630 is lacking this and a single dts patch to boot
mainline with display, GPU, WiFi and audio working and the story is
similar on several devboards.

As previously described, the only thing I want is the stream mapping
related to the display controller in place, either with the CB with
translation disabled or possibly with a way to specify the framebuffer
region (although this turns out to mess things up in the display
driver...)

I did pick this up again recently and concluded that by omitting the
streams for the USB controllers causes an instability issue seen on one
of the controller to disappear. So I would prefer if we somehow could
have a mechanism to only pick the display streams and the context
allocation for this.


Can you please share some pointers/insights/wishes for how we can
conclude on this subject?


PS. The list of devices specified
https://lore.kernel.org/linux-arm-msm/cover.1587407458.git.saiprakash.ranjan@codeaurora.org/
covers this need as well, if that matters...

Thanks,
Bjorn

> On Mon 09 Dec 07:07 PST 2019, Thierry Reding wrote:
> 
> > From: Thierry Reding <treding@nvidia.com>
> > 
> 
> Sorry for the slow response on this, finally got the time to go through
> this in detail and try it out on some Qualcomm boards.
> 
> > On some platforms, the firmware will setup hardware to read from a given
> > region of memory. One such example is a display controller that is
> > scanning out a splash screen from physical memory.
> > 
> 
> This particular use case is the one that we need to figure out for
> Qualcomm devices as well; on some devices it's a simple splash screen
> (that on many devices can be disabled), but for others we have EFIFB
> on the display and no (sane) means to disable this.
> 
> > During Linux' boot process, the ARM SMMU will configure all contexts to
> > fault by default. This means that memory accesses that happen by an SMMU
> > master before its driver has had a chance to properly set up the IOMMU
> > will cause a fault. This is especially annoying for something like the
> > display controller scanning out a splash screen because the faults will
> > result in the display controller getting bogus data (all-ones on Tegra)
> > and since it repeatedly scans that framebuffer, it will keep triggering
> > such faults and spam the boot log with them.
> > 
> 
> As my proposed patches indicated, the Qualcomm platform boots with
> stream mapping setup for the hardware used by the bootloader, but
> relying on the associated context banks not being enabled.
> 
> USFCFG in SCR0 is set and any faults resulting of this will trap into
> secure world and the device will be reset.
> 
> > In order to work around such problems, scan the device tree for IOMMU
> > masters and set up a special identity domain that will map 1:1 all of
> > the reserved regions associated with them. This happens before the SMMU
> > is enabled, so that the mappings are already set up before translations
> > begin.
> > 
> > One thing that was pointed out earlier, and which I don't have a good
> > idea on how to solve it, is that the early identity domain is not
> > discarded. The assumption is that the standard direct mappings code of
> > the IOMMU framework will replace the early identity domain once devices
> > are properly attached to domains, but we don't have a good point in time
> > when it would be safe to remove the early identity domain.
> > 
> > One option that I can think of would be to create an early identity
> > domain for each master and inherit it when that master is attached to
> > the domain later on, but that seems rather complicated from an book-
> > keeping point of view and tricky because we need to be careful not to
> > map regions twice, etc.
> > 
> 
> The one concern I ran into with this approach (after resolving below
> issues) is that when the display driver probes a new domain will be
> created automatically and I get a stream of "Unhandled context fault" in
> the log until the driver has mapped the framebuffer in the newly
> allocated context.
> 
> This is normally not a problem, as we seem to be able to do this
> initialization in a few frames, but for the cases where the display
> driver probe defer this is a problem.
> 
> But at least these devices doesn't reboot, so this is way better than the
> current state.
> 
> > Any good ideas on how to solve this? It'd also be interesting to see if
> > there's a more generic way of doing this. I know that something like
> > this isn't necessary on earlier Tegra SoCs with the custom Tegra SMMU
> > because translations are only enabled when the devices are attached to a
> > domain. I'm not sure about other IOMMUs, but in the absence of a struct
> > device, I suspect that we can't really do anything really generic that
> > would work across drivers.
> > 
> 
> As I indicated above I managed to get this working on the boards we have
> that uses the arm-smmu driver.
> 
> ## SDM845
> Booting the SDM845 shows the following register stream mapping register
> content:
>   SMR(0): 0x80080880 S2CR(0): 0x0
>   SMR(1): 0x80080c80 S2CR(1): 0x0
>   SMR(2): 0x800f00a0 S2CR(2): 0x1
>   SMR(3): 0x800f00c0 S2CR(3): 0x1
>   SMR(4): 0x800f00e0 S2CR(4): 0x2
>   SMR(5): 0x800f0100 S2CR(5): 0x2
>   SMR(6): 0x0 S2CR(6): 0x0
>   SMR(7): 0x0 S2CR(7): 0x0
>   SMR(8): 0x0 S2CR(8): 0x200ff
>   SMR(9): 0x0 S2CR(9): 0x200ff
>   ...
> 
> Here stream 0 and 1 (SID 0x880 and 0xc80) are the display streams, the
> remainder are related to storage and USB - which afaict doesn't need to be
> maintained.
> 
> As the display uses context bank 0, using this as the identity bank results in
> a couple of occurrences of:
>   Unhandled context fault: fsr=0x402, iova=0x9da00000, fsynr=0x370020, cbfrsynra=0x880, cb=0
> 
> Which we survive, but as we reach arm_smmu_device_reset() to flush out the new
> stream mapping we start by writing S2CR(0) = 0, then SMR(0) = 0x800810a0. So
> until SMR(4) is written we're lacking a valid stream mapping for the display,
> and hence if the screen does refresh in during time period the device reboots.
> 
> 
> In addition to this, the iommu_iova_to_phys() you perform in the mapping loop
> results in a large number of "translation fault!" printouts from
> arm_smmu_iova_to_phys_hard().
> 
> ## SM8150
> Boots with the following stream mapping:
>   SMR(0): 0x800006a0 S2CR(0): 0x0
>   SMR(1): 0x800006c0 S2CR(1): 0x0
>   SMR(2): 0x80000300 S2CR(2): 0x1
>   SMR(3): 0x84200800 S2CR(3): 0x2
>   SMR(4): 0x0 S2CR(4): 0x0
>   SMR(5): 0x0 S2CR(5): 0x0
>   SMR(6): 0x0 S2CR(6): 0x200ff
>   SMR(7): 0x0 S2CR(7): 0x200ff
>   ...
> 
> Here stream 3 (sid 0x800) is the display stream.
> 
> Mapping the various memory regions into the first context works fine, but
> unless the display stream happens to be allocated to stream 3 (e.g. it always
> ends up in slot 1 with my current DT) the board reboots shortly after we start
> writing out the SMRs. I've not yet figured out why the board faults because of
> the move to an earlier SMR index. (Perhaps because we clear the previously used
> display SMR valid bit?)
> 
> 
> ## Conclusions
> Both of these platforms indicates that moving the stream mapping around is
> going to cause issues, so inspired by my proposal I added below snippet right
> before the call to arm_smmu_setup_identity(), in order to populate the stream
> mapping selection.
> 
> 	for (i = 0; i < smmu->num_mapping_groups; i++) {
> 		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> 		smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> 		smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> 		smmu->smrs[i].valid = !!(smr & ARM_SMMU_SMR_VALID);
> 	}
> 
> With this both boards boots fine, but I know Will had reservations wrt trusting
> these values. Perhaps we could use the read back values (with some sanity
> checking) only for setting up identity mapping?
> 
> 
> With this I also tested booting MSM8996 (the db820c board) and except for
> spending about 75 seconds printing below error in the kernel log during boot
> things seems to be functional.
> 
> [   96.670723] arm-smmu b40000.iommu: translation fault!
> [   96.675038] arm-smmu b40000.iommu: PAR = 0x300000203
> 
> 
> Removing the call to iommu_iova_to_phys() in the mapping loop (as I know
> that I don't have any memory regions with multiple clients) solves the
> log spamming and all three boards seems to be functional.
> 
> Regards,
> Bjorn
> 
> > Thierry
> > 
> > Thierry Reding (2):
> >   iommu: arm-smmu: Extract arm_smmu_of_parse()
> >   iommu: arm-smmu: Add support for early direct mappings
> > 
> >  drivers/iommu/arm-smmu.c | 195 +++++++++++++++++++++++++++++++++++++--
> >  drivers/iommu/arm-smmu.h |   2 +
> >  2 files changed, 189 insertions(+), 8 deletions(-)
> > 
> > -- 
> > 2.23.0
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
