Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C445EC433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 15:21:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C15923AC4
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 15:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C15923AC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4435187A29;
	Wed,  9 Dec 2020 15:21:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9wYorH-cl8Ch; Wed,  9 Dec 2020 15:21:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 375F187A3D;
	Wed,  9 Dec 2020 15:21:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D451C1DA2;
	Wed,  9 Dec 2020 15:21:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AEFAC013B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 08:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3B06E8773A
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 08:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2xIk2583-3TS for <iommu@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 08:06:39 +0000 (UTC)
X-Greylist: delayed 01:03:20 by SQLgrey-1.7.6
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EE3E98769E
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 08:06:38 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id t22so18120142ljk.0
 for <iommu@lists.linux-foundation.org>; Tue, 08 Dec 2020 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XF/scYns4rnWCahd4eLxZHPg0XavrYpCgynXjwRuQRQ=;
 b=BAp0uJHEOg1F+PuOm0Aa0FSMMLy4lAs/bjDrNUgtT3EIoLnELtr22FcDOtpn5WGK70
 Gm7GoypHw76coKsU7OHZ/dyWywsRjtT2o3IcqLJk5C7Bli8uxugicc33MDDKi/bhPrSa
 KJ60r/MNFWvnVX5b+0dEwj/hncjzMElxKOoKcOb62gFht4Bn3gEf1k5eofGu4AtikplG
 ztGE12B9tEFH9ky80AUDQMTOCQxhlufwHqIV7mTDXRcg2CGeDzD1N2DvL5MGpSUZHc/W
 m3zz+TwWtaIc8MMNJdwCsKPjdlSzSSMm3AeRSKNiFTY6DC/NTxAOqaYYAxlXOoVNwe+7
 Qz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XF/scYns4rnWCahd4eLxZHPg0XavrYpCgynXjwRuQRQ=;
 b=fe1W6YPHYRptRrHTh4sDAKLJxRx6JdOefpzjZJdGfAUYKyLFZhVmgOLXI7xl+HbD/w
 DohEXOUmYhwu3VZki3gfOlefsw8js1L46MjyXiLPAYXFuL+0G527uRePCwFJJFQsNoVk
 EBQwcsEuJxL3cvGRX9avKbb7jST5xafBiWSU3Y6ZRiLQa6LxqgvWlaKgvp1TCRIOyDFj
 0k2AYc6vDMVo/1HH7cqk0r2icgjdIozG03GmNrJV3x85wOqo8VQCMONKhbluFl/Ts2E2
 zD+ZXr0gF5QlVldgsZ34wS0SCLPyXL61wi7T7Le/2Oi3ZKtXP7FRauVddPUsItplGX06
 9ybA==
X-Gm-Message-State: AOAM531fHYb98Kwm5oYg5iU+u/xyR5guTUVSMbJSYDi6JktswgmhFZHL
 OkiH2qVkbvzSZLec+bayt33/CpY89XsA7KhkOjNPT0LU8hQ=
X-Google-Smtp-Source: ABdhPJyE8NZ6yWrc0vbDO+ir8oCTTD5SWkg6QzGTCX6hRbunid8e0Gzqf860QW/NPwtzM5aZrddkla6ML98jgiyE0I8=
X-Received: by 2002:a50:f307:: with SMTP id p7mr23213989edm.368.1607410996396; 
 Mon, 07 Dec 2020 23:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20201125155009.18453-1-laurentiu.tudor@nxp.com>
 <30296756-9b8d-4851-87f0-8c4bd41110e9@arm.com>
 <74e4f42a-83bf-fa88-a807-5c3a60aad4e6@nxp.com>
 <04a0e0d7-cf83-e0a1-78dc-034289e8d0e4@arm.com>
In-Reply-To: <04a0e0d7-cf83-e0a1-78dc-034289e8d0e4@arm.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Tue, 8 Dec 2020 08:02:39 +0100
Message-ID: <CABdtJHtiX_9iVCscQELH9ws2brFLRAvqG+Hpt2e+PDP+DsLBSA@mail.gmail.com>
Subject: Re: [PATCH] iommu: arm-smmu-impl: add NXP hook to preserve
 bootmappings
To: Robin Murphy <robin.murphy@arm.com>
X-Mailman-Approved-At: Wed, 09 Dec 2020 15:21:50 +0000
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Diana Madalina Craciun <diana.craciun@nxp.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
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

On Mon, Dec 7, 2020 at 7:12 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-12-02 10:29, Laurentiu Tudor wrote:
> > Hi Robin,
> >
> > Sorry for the late reply, we had a few days of over here. Comments inline.
> >
> > On 11/25/2020 8:10 PM, Robin Murphy wrote:
> >> On 2020-11-25 15:50, laurentiu.tudor@nxp.com wrote:
> >>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>
> >>> Add a NXP specific hook to preserve SMMU mappings present at
> >>> boot time (created by the boot loader). These are needed for
> >>> MC firmware present on some NXP chips to continue working
> >>> across kernel boot and SMMU initialization.
> >>>
> >>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>> ---
> >>>    drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 33 ++++++++++++++++++++++
> >>>    1 file changed, 33 insertions(+)
> >>>
> >>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> >>> b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> >>> index 7fed89c9d18a..ca07d9d4be69 100644
> >>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> >>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> >>> @@ -187,6 +187,36 @@ static const struct arm_smmu_impl
> >>> mrvl_mmu500_impl = {
> >>>        .reset = arm_mmu500_reset,
> >>>    };
> >>>    +static int nxp_cfg_probe(struct arm_smmu_device *smmu)
> >>> +{
> >>> +    int i, cnt = 0;
> >>> +    u32 smr;
> >>> +
> >>> +    for (i = 0; i < smmu->num_mapping_groups; i++) {
> >>> +        smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> >>> +
> >>> +        if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
> >>
> >> I bet this is fun over kexec...
> >
> > Right. I haven't even considered kexec.
> >
> >> Note that the Qualcomm special case got a bit of a free pass since it
> >> involves working around a totally broken hypervisor, plus gets to play
> >> the "nobody sane will run an enterprise distro on their phone" card to
> >> an extent; I don't think the likes of Layerscape kit get it quite so
> >> easy ;)
> >
> > I agree that this is not ideal, but the plan here was to have something
> > to boot vanilla kernel OOB on our chips, which is something on my mind
> > for quite a while now. I do realize that we won't get away with it
> > in the long run.
> >
> >>> +            smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> >>> +            smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> >>> +            smmu->smrs[i].valid = true;
> >>> +
> >>> +            smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> >>> +            smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> >>> +            smmu->s2crs[i].cbndx = 0xff;
> >>> +
> >>> +            cnt++;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> >>> +           cnt == 1 ? "" : "s");
> >>
> >> That gets you around the initial SMMU reset, but what happens for the
> >> arbitrarily long period of time between the MC device getting attached
> >> to a default domain and the MC driver actually probing and (presumably)
> >> being able to map and reinitialise its firmware?
> >
> > Perhaps I'm missing something, but won't the MC firmware live based on
> > this bypass mapping created by the bootloader and that gets preserved?
>
> All you're doing here is effectively forcing "arm-smmu.disable_bypass=0"
> for the specific streams identified by the boot-time SMR state. Once
> iommu_probe_device() gets called and the SMMU driver becomes aware of
> those streams, that initial state becomes moot.
>
> What I just now realise, however, is that in this specific case you
> probably do get away with it as a dirty trick because there is no
> visible association between the MC *platform device* and the SMMU. Thus
> as it stands today, nobody will be calling iommu_probe_device() for any
> of the relevant streams until the MC driver has probed and can start
> creating the fsl_mc_bus devices and interpreting the iommu-map -
> presumably by that point the platform driver has had plenty of time to
> quiesce DMA and grovel the physical address of the firmware region out
> of the hardware, such that it can then be remapped from the perspective
> of the new fsl_mc_bus device to continue.
>
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static const struct arm_smmu_impl nxp_impl = {
> >>> +    .cfg_probe = nxp_cfg_probe,
> >>> +};
> >>
> >> I believe you're mostly using MMU-500, so you probably don't want to
> >> simply throw out the relevant errata workarounds.
> >>
> >>>    struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device
> >>> *smmu)
> >>>    {
> >>> @@ -226,5 +256,8 @@ struct arm_smmu_device *arm_smmu_impl_init(struct
> >>> arm_smmu_device *smmu)
> >>>        if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
> >>>            smmu->impl = &mrvl_mmu500_impl;
> >>>    +    if (of_property_read_bool(np, "nxp,keep-boot-mappings"))
> >>> +        smmu->impl = &nxp_impl;
> >>
> >> Normally you'd get a "what about ACPI?" here, but given the number of
> >> calls and email threads we've had specifically about trying to make ACPI
> >> support for these platforms work, that gets upgraded to at least a "WHAT
> >> ABOUT ACPI!?" :P
> > I do have ACPI in mind, but for now I just wanted to have a
> > first impression on the approach. One idea I was pondering on was to
> > have this property in the MC node (quick reminder: MC is exposed as a NC
> > in ACPI, should be able to replicate the property in there too). In the
> > mean time, we are in collaboration with our partners on using RMRR by
> > adding support for it in the arm-smmu-v2 driver.
>
> I feel pretty confident in saying that nobody's going to agree to add a
> platform-specific property to IORT to describe one case of the exact
> thing that RMRs were specced out to deal with in general.
>
> >> But seriously, the case of device firmware in memory being active before
> >> handover to Linux is *literally* the original reason behind IORT RMRs.
> >> We already know we need a way to specify the equivalent thing for DT
> >> systems, such that both can be handled commonly. I really don't want to
> >> have to support a vendor-specific mechanism for not-even-fully-solving a
> >> completely generic issue, sorry.
> >>
> >
> > I remember that some months ago there was a proposal from nvidia [1] to
> > map per-device reserved memory into SMMU. Would it make sense to revive
> > it as it seemed a viable solution for our case too?
>
> Note that there's already been a newer spin on that. The discussion is
> spread around a few places ([1] and [2] at least), but I think it's
> clear that Thierry's case is just another flavour of the same overall
> problem, so if we can figure out robust DT bindings to convey the
> equivalent information to IORT RMRs then it largely all falls in together.
>
> Thanks,
> Robin.

Robin,

I have been working with Laurentiu on getting a proper implementation in place.
Based on the patchset you noted in [2] I have already added preliminary RMR
support to edk2 and have a working patchset for our HoneyComb using the LX2160a.

Laurentiu pointed me to the Nvidia patchset [1] which I had somehow missed in my
research.  That filled in quite a bit of the gap that [2] was missing
since it was
only implemented or the smmu_v3 driver.  I still need to finish merging the two
patchsets together for something fully functional but here are my observations.
If you have any preliminary input I would love to hear it.

 RMR's in ACPI and using the DT reserved_memory mappings seem to be
functionally achieving the same thing and just need different parsing methods
to collect the information.  Would there be objections to parsing DT and using
that to build the same rmr_list that was introduced in [2]?  Functionally we
are collecting the same information, the start address and length of the memory
region and then the SMMU IDs that are attached to it.

The main difference being that RMR's as you noted are spec'd for this so all
the information is neatly collected in the IORT table, while DT would require
parsing the reserved_memory regions tagged with the "active" property and
then loop through the devices to find the nodes using this memory region
and parsing out the SMMU information from that node.

Does this all seem reasonable?

Thanks,
Jon

>
> [1]
> https://lore.kernel.org/linux-iommu/20200904130000.691933-1-thierry.reding@gmail.com/
> [2]
> https://lore.kernel.org/linux-iommu/20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com/
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
