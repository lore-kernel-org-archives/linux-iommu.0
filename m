Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07989C432C3
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 12:17:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1332073F
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 12:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYNZ18RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1332073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 68B7B855EA;
	Wed, 27 Nov 2019 12:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DhyUfiB-bwiC; Wed, 27 Nov 2019 12:17:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 75EEF850BE;
	Wed, 27 Nov 2019 12:17:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E811C1DDA;
	Wed, 27 Nov 2019 12:17:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2002CC0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 12:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 09BB8854D0
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 12:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2kecZTujgix8 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 12:17:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0D62C850BE
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 12:17:01 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id y5so7204458wmi.5
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 04:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RnRky8Bl3S2lcomEZC5a4BFOf4exYRLhp0v5+MG7omk=;
 b=uYNZ18REadWBmsDgk80hqsipEXRd2dZ3ccMIvKG8rtj7KZk38scWDhcPV+BM8GflG8
 pt6fVaqn3clylvslgABf5W/qTvpPLGGPnbD+SNa8D9Y2M8gUe1pDPGG+/LS/s7LgTLJZ
 dSwZ1NgRv/qxYbLYuTncBscZcdBaXx3AXQeAgu2ImD+8zMwnWuVJeFPOJqGDmShaTI9W
 /3ussT0pkb8HcOsZq7ToYaBv56ue9uQ8sdUysuYLu3xi2sFMnbEPgsQ/Ty6LzooQHGkR
 pB9N93bFt7d91x/dDweaEPOK722caTiod2+7Srgtz6Q2+w35k/NNCrDMqtX9lzAUa5od
 gmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RnRky8Bl3S2lcomEZC5a4BFOf4exYRLhp0v5+MG7omk=;
 b=MohiCQ5S4Q7Z6PbdA12GnczhrK/sKHPsQf97j3t5C1AkAxFZ3mIg0lLhtMJpCJ5Xrg
 CJyxlENgnRmceGens9cNlMSP2k50VRM1fqCBpwAAY0IAw/sjYiDSGCA6/ap9k8Z+yQjR
 EqMLCc3GqRxv/bAiTrOVCm82qRrbKmy2q/zvsEmCaakl40uN2DjlGt0ueX+OgAFgfUt4
 lN3obruta6EdL2Ia9luptdaXGB9wP92Jzu59Bi7SblqzBu2QS5uvZWA8btH82gJdhfD0
 +UoYzj0qv1snUvDmmvmAkhxAxBYpCzKcT1hZcInQlSfI+4fQa0z9m0JO4aaGIKtZobQr
 DZWQ==
X-Gm-Message-State: APjAAAVYcvoNztCfGeKMnlMKVXTpRLW7rGMptwT0OVbaXmRIFp94UujF
 IJ8VJi508XBr0jKyIzpWch8=
X-Google-Smtp-Source: APXvYqwPTmg81LfDOX9X9QPA/BzHgq1C5Zd75sVmVA4MZbdIh8iVV6GKg5LvFGVhQxjfxuCQJGc6mA==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr3964111wmi.118.1574857018984; 
 Wed, 27 Nov 2019 04:16:58 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id z64sm5534437wmg.30.2019.11.27.04.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 04:16:57 -0800 (PST)
Date: Wed, 27 Nov 2019 13:16:54 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
Message-ID: <20191126172910.GA2669319@ulmo>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
 <20190829111407.17191-3-thierry.reding@gmail.com>
 <1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com>
 <20190902145245.GC1445@ulmo>
 <20190917175950.wrwiqnh5bp62uy3c@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20190917175950.wrwiqnh5bp62uy3c@willie-the-truck>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6368784187237313081=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6368784187237313081==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 06:59:50PM +0100, Will Deacon wrote:
> On Mon, Sep 02, 2019 at 04:52:45PM +0200, Thierry Reding wrote:
> > On Mon, Sep 02, 2019 at 03:22:35PM +0100, Robin Murphy wrote:
> > > On 29/08/2019 12:14, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > For device tree nodes, use the standard of_iommu_get_resv_regions()
> > > > implementation to obtain the reserved memory regions associated wit=
h a
> > > > device.
> > >=20
> > > This covers the window between iommu_probe_device() setting up a defa=
ult
> > > domain and the device's driver finally probing and taking control, but
> > > iommu_probe_device() represents the point that the IOMMU driver first=
 knows
> > > about this device - there's still a window from whenever the IOMMU dr=
iver
> > > itself probed up to here where the "unidentified" traffic may have al=
ready
> > > been disrupted. Some IOMMU drivers have no option but to make the nec=
essary
> > > configuration during their own probe routine, at which point a struct=
 device
> > > for the display/etc. endpoint may not even exist yet.
> >=20
> > Yeah, I think I'm actually running into this issue with the ARM SMMU
> > driver. The above works fine with the Tegra SMMU driver, though, because
> > it doesn't touch the SMMU configuration until a device is attached to a
> > domain.
> >=20
> > For anything earlier than iommu_probe_device(), I don't see a way of
> > doing this generically. I've been working on a prototype to make these
> > reserved memory regions early on for ARM SMMU but I've been failing so
> > far. I think it would possibly work if we just switched the default for
> > stream IDs to be "bypass" if they have any devices that have reserved
> > memory regions, but again, this isn't quite working (yet).
>=20
> I think we should avoid the use of "bypass" outside of the IOMMU probe()
> routine if at all possible, since it leaves the thing wide open if we don=
't
> subsequently probe the master.
>=20
> Why can't we initialise a page-table early for StreamIDs with these
> reserved regions, and then join that up later on if we see a device with
> one of those StreamIDs attaching to a DMA domain? I suppose the nasty
> case would be attaching to a domain that already has other masters
> attached to it. Can we forbid that somehow for these devices? Otherwise,
> I think we'd have to transiently switch to bypass whilst switching page
> table.
>=20
> What problems did you run into trying to implement this?

I picked this up again and was trying to make this work with your
suggestion. Below is a rough draft and it seems to be working to some
degree. Here's an extract of the log when I run this on Jetson TX2:

	[    3.755328] arm-smmu 12000000.iommu: probing hardware configuration...
	[    3.762187] arm-smmu 12000000.iommu: SMMUv2 with:
	[    3.767137] arm-smmu 12000000.iommu:         stage 1 translation
	[    3.772806] arm-smmu 12000000.iommu:         stage 2 translation
	[    3.778471] arm-smmu 12000000.iommu:         nested translation
	[    3.784050] arm-smmu 12000000.iommu:         stream matching with 128 r=
egister groups
	[    3.791651] arm-smmu 12000000.iommu:         64 context banks (0 stage-=
2 only)
	[    3.798603] arm-smmu 12000000.iommu:         Supported page sizes: 0x61=
311000
	[    3.805460] arm-smmu 12000000.iommu:         Stage-1: 48-bit VA -> 48-b=
it IPA
	[    3.812310] arm-smmu 12000000.iommu:         Stage-2: 48-bit IPA -> 48-=
bit PA
	[    3.819159] arm-smmu 12000000.iommu: > arm_smmu_setup_identity(smmu=3Df=
fff0001eabcec80)
	[    3.827373] arm-smmu 12000000.iommu:   identity domain: ffff0001eaf8cae=
8 (ops: 0x0)
	[    3.835614] arm-smmu 12000000.iommu:   np: /ethernet@2490000
	[    3.841635] arm-smmu 12000000.iommu:   np: /sdhci@3400000
	[    3.847315] arm-smmu 12000000.iommu:   np: /sdhci@3420000
	[    3.852990] arm-smmu 12000000.iommu:   np: /sdhci@3440000
	[    3.858683] arm-smmu 12000000.iommu:   np: /sdhci@3460000
	[    3.864370] arm-smmu 12000000.iommu:   np: /hda@3510000
	[    3.869897] arm-smmu 12000000.iommu:   np: /usb@3530000
	[    3.875421] arm-smmu 12000000.iommu:   np: /pcie@10003000
	[    3.881109] arm-smmu 12000000.iommu:   np: /host1x@13e00000
	[    3.887012] arm-smmu 12000000.iommu:   np: /host1x@13e00000/display-hub=
@15200000/display@15200000
	[    3.896344] arm-smmu 12000000.iommu:     region: /reserved-memory/frame=
buffer@9607c000
	[    3.904707] arm-smmu 12000000.iommu:       [mem 0x9607c000-0x9687bfff]
	[    3.915719] arm-smmu 12000000.iommu:     /iommu@12000000: 1 arguments
	[    3.922487] arm-smmu 12000000.iommu:       0: 00000009
	[    3.927888] arm-smmu 12000000.iommu:       SID: 0009 MASK: 7f80
	[    3.934132] arm-smmu 12000000.iommu:       found index: 0
	[    3.939840] arm-smmu 12000000.iommu:   np: /host1x@13e00000/display-hub=
@15200000/display@15210000
	[    3.949183] arm-smmu 12000000.iommu:   np: /host1x@13e00000/display-hub=
@15200000/display@15220000
	[    3.958499] arm-smmu 12000000.iommu:   np: /host1x@13e00000/vic@15340000
	[    3.965557] arm-smmu 12000000.iommu:   np: /gpu@17000000
	[    3.971145] arm-smmu 12000000.iommu:   np: /bpmp
	[    3.976084] arm-smmu 12000000.iommu: < arm_smmu_setup_identity()
	[    3.982613] arm-smmu 12000000.iommu: > arm_smmu_write_sme(smmu=3Dffff00=
01eabcec80, idx=3D0)
	[    3.991072] arm-smmu 12000000.iommu:   ARM_SMMU_GR0_S2CR(0) < 00020000
	[    3.997922] arm-smmu 12000000.iommu:   ARM_SMMU_GR0_SMR(0) < ff800009
	[    4.004677] arm-smmu 12000000.iommu: < arm_smmu_write_sme()
	[    4.010528] arm-smmu 12000000.iommu: > arm_smmu_write_sme(smmu=3Dffff00=
01eabcec80, idx=3D1)
	[    4.018919] arm-smmu 12000000.iommu:   ARM_SMMU_GR0_S2CR(1) < 00020000
	[    4.025773] arm-smmu 12000000.iommu:   ARM_SMMU_GR0_SMR(1) < 00000000
	[    4.032543] arm-smmu 12000000.iommu: < arm_smmu_write_sme()
	...

There's a bunch of these, but idx=3D0 is the only one that's actually
populated because it corresponds to the display controller. However,
shortly after this I see a bunch of these:

	...
	[    7.588908] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x809; b=
oot with "arm-smmu.disable_bypass=3D0" to allow, but this may have security=
 implications
	[    7.589907] arm-smmu: > arm_smmu_of_xlate(dev=3Dffff0001eaecf010, args=
=3Dffff80001024bae8)
	[    7.603599] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0 0=
x00000000, GFSYNR1 0x00000809, GFSYNR2 0x00000000
	[    7.604218] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x1409; =
boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have securit=
y implications
	[    7.611956] arm-smmu: < arm_smmu_of_xlate() =3D 0
	[    7.622636] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0 0=
x00000000, GFSYNR1 0x00001409, GFSYNR2 0x00000000
	[    7.622658] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x1809; =
boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have securit=
y implications
	[    7.622662] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0 0=
x00000000, GFSYNR1 0x00001809, GFSYNR2 0x00000000
	[    7.622676] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x409; b=
oot with "arm-smmu.disable_bypass=3D0" to allow, but this may have security=
 implications
	[    7.637739] arm-smmu 12000000.iommu:   ARM_SMMU_GR0_S2CR(1) < 00000001
	[    7.642199] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0 0=
x00000000, GFSYNR1 0x00000409, GFSYNR2 0x00000000
	[    7.642216] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x9; boo=
t with "arm-smmu.disable_bypass=3D0" to allow, but this may have security i=
mplications
	[    7.642221] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0 0=
x00000000, GFSYNR1 0x00000009, GFSYNR2 0x00000000
	[    7.642237] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x1c09; =
boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have securit=
y implications
	[    7.652992] tegra-host1x 13e00000.host1x: Adding to iommu group 0
	[    7.667720] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0 0=
x00000000, GFSYNR1 0x00001c09, GFSYNR2 0x00000000
	[    7.667732] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x9; boo=
t with "arm-smmu.disable_bypass=3D0" to allow, but this may have security i=
mplications
	[    7.667736] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0 0=
x00000000, GFSYNR1 0x00000009, GFSYNR2 0x00000000
	[    7.667748] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x1809; =
boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have securit=
y implications
	[    7.667752] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0 0=
x00000000, GFSYNR1 0x00001809, GFSYNR2 0x00000000
	[    7.667765] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x9; boo=
t with "arm-smmu.disable_bypass=3D0" to allow, but this may have security i=
mplications
	[    7.678511] arm-smmu 12000000.iommu: > arm_smmu_write_sme(smmu=3Dffff00=
01eabcec80, idx=3D1)
	[    7.693158] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0 0=
x00000000, GFSYNR1 0x00000009, GFSYNR2 0x00000000
	[    7.693170] arm-smmu 12000000.iommu: Blocked unknown Stream ID 0x1009; =
boot with "arm-smmu.disable_bypass=3D0" to allow, but this may have securit=
y implications
	[    7.693174] arm-smmu 12000000.iommu:         GFSR 0x80000002, GFSYNR0 0=
x00000000, GFSYNR1 0x00001009, GFSYNR2 0x00000000

Note that stream ID 0x9 is TEGRA186_SID_NVDISPLAY, which is associated
with the display controllers. One of these display controllers is live
because it was turned on by the bootloader to show a splash screen.

What I don't really understand is why it thinks that that stream ID is
unknown. One possibility I see is that perhaps the S2CR(0) and/or SMR(0)
registers might have gotten overwritten, but I don't see where that may
happen.

The errors stop eventually when the display controller is hooked up
properly via the DMA API, but the whole purpose here is obviously to get
to that point much earlier.

Any ideas what I might be doing wrong? Any comments on the general
approach?

Thierry

--- >8 ---
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9b2f920ff2f8..13c7282560e6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -916,6 +916,7 @@ static void arm_smmu_write_smr(struct arm_smmu_device *=
smmu, int idx)
=20
 	if (!(smmu->features & ARM_SMMU_FEAT_EXIDS) && smr->valid)
 		reg |=3D SMR_VALID;
+	dev_info(smmu->dev, "  ARM_SMMU_GR0_SMR(%u) < %08x\n", idx, reg);
 	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_SMR(idx), reg);
 }
=20
@@ -929,14 +930,17 @@ static void arm_smmu_write_s2cr(struct arm_smmu_devic=
e *smmu, int idx)
 	if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs &&
 	    smmu->smrs[idx].valid)
 		reg |=3D S2CR_EXIDVALID;
+	dev_info(smmu->dev, "  ARM_SMMU_GR0_S2CR(%u) < %08x\n", idx, reg);
 	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
 }
=20
 static void arm_smmu_write_sme(struct arm_smmu_device *smmu, int idx)
 {
+	dev_info(smmu->dev, "> %s(smmu=3D%px, idx=3D%d)\n", __func__, smmu, idx);
 	arm_smmu_write_s2cr(smmu, idx);
 	if (smmu->smrs)
 		arm_smmu_write_smr(smmu, idx);
+	dev_info(smmu->dev, "< %s()\n", __func__);
 }
=20
 /*
@@ -1010,6 +1014,8 @@ static int arm_smmu_find_sme(struct arm_smmu_device *=
smmu, u16 id, u16 mask)
=20
 static bool arm_smmu_free_sme(struct arm_smmu_device *smmu, int idx)
 {
+	pr_info("> %s(smmu=3D%px, idx=3D%d)\n", __func__, smmu, idx);
+
 	if (--smmu->s2crs[idx].count)
 		return false;
=20
@@ -1017,6 +1023,7 @@ static bool arm_smmu_free_sme(struct arm_smmu_device =
*smmu, int idx)
 	if (smmu->smrs)
 		smmu->smrs[idx].valid =3D false;
=20
+	pr_info("< %s()\n", __func__);
 	return true;
 }
=20
@@ -1545,19 +1552,34 @@ static int arm_smmu_domain_set_attr(struct iommu_do=
main *domain,
 	return ret;
 }
=20
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *a=
rgs)
+static u32 arm_smmu_of_parse(struct device_node *np, const u32 *args,
+			     unsigned int count)
 {
-	u32 mask, fwid =3D 0;
+	u32 fwid =3D 0, mask;
=20
-	if (args->args_count > 0)
-		fwid |=3D FIELD_PREP(SMR_ID, args->args[0]);
+	if (count > 0)
+		fwid |=3D FIELD_PREP(SMR_ID, args[0]);
=20
-	if (args->args_count > 1)
-		fwid |=3D FIELD_PREP(SMR_MASK, args->args[1]);
-	else if (!of_property_read_u32(args->np, "stream-match-mask", &mask))
+	if (count > 1)
+		fwid |=3D FIELD_PREP(SMR_MASK, args[1]);
+	else if (!of_property_read_u32(np, "stream-match-mask", &mask))
 		fwid |=3D FIELD_PREP(SMR_MASK, mask);
=20
-	return iommu_fwspec_add_ids(dev, &fwid, 1);
+	return fwid;
+}
+
+static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *a=
rgs)
+{
+	u32 fwid;
+	int ret;
+
+	pr_info("> %s(dev=3D%px, args=3D%px)\n", __func__, dev, args);
+
+	fwid =3D arm_smmu_of_parse(args->np, args->args, args->args_count);
+	ret =3D iommu_fwspec_add_ids(dev, &fwid, 1);
+
+	pr_info("< %s() =3D %d\n", __func__, ret);
+	return ret;
 }
=20
 static void arm_smmu_get_resv_regions(struct device *dev,
@@ -1877,6 +1899,138 @@ static int arm_smmu_device_cfg_probe(struct arm_smm=
u_device *smmu)
 	return 0;
 }
=20
+static int arm_smmu_setup_identity(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_domain *identity;
+	struct device *dev =3D smmu->dev;
+	unsigned long page_size;
+	struct device_node *np;
+	int ret;
+
+	dev_info(dev, "> %s(smmu=3D%px)\n", __func__, smmu);
+
+	/* create early identity mapping */
+	smmu->identity =3D arm_smmu_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+	if (!smmu->identity) {
+		dev_err(dev, "failed to create identity domain\n");
+		return -ENOMEM;
+	}
+
+	dev_info(dev, "  identity domain: %px (ops: %ps)\n", smmu->identity, smmu=
->identity->ops);
+	smmu->identity->type =3D IOMMU_DOMAIN_UNMANAGED;
+	smmu->identity->ops =3D &arm_smmu_ops;
+
+	ret =3D arm_smmu_init_domain_context(smmu->identity, smmu);
+	if (ret < 0) {
+		dev_err(dev, "failed to initialize identity domain: %d\n", ret);
+		return ret;
+	}
+
+	page_size =3D 1UL << __ffs(smmu->identity->pgsize_bitmap);
+	identity =3D to_smmu_domain(smmu->identity);
+
+	for_each_node_with_property(np, "iommus") {
+		struct arm_smmu_smr *smrs =3D smmu->smrs;
+		struct of_phandle_iterator it;
+		struct of_phandle_args args;
+		unsigned int index =3D 0;
+		bool mapped =3D false;
+
+		dev_info(dev, "  np: %pOF\n", np);
+
+		/* parse memory regions and add them to the identity mapping */
+		of_for_each_phandle(&it, ret, np, "memory-region", NULL, 0) {
+			int prot =3D IOMMU_READ | IOMMU_WRITE;
+			dma_addr_t start, limit, iova;
+			struct resource res;
+
+			dev_info(dev, "    region: %pOF\n", it.node);
+
+			ret =3D of_address_to_resource(it.node, 0, &res);
+			if (ret < 0) {
+				continue;
+			}
+
+			/* XXX check that region is not empty? */
+			dev_info(dev, "      %pR\n", &res);
+
+			start =3D ALIGN(res.start, page_size);
+			limit =3D ALIGN(res.start + resource_size(&res), page_size);
+
+			for (iova =3D start; iova < limit; iova +=3D page_size) {
+				phys_addr_t phys;
+
+				phys =3D iommu_iova_to_phys(smmu->identity, iova);
+				if (phys) {
+					continue;
+				}
+
+				ret =3D iommu_map(smmu->identity, iova, iova,
+						page_size, prot);
+				if (ret < 0) {
+					dev_err(dev, "failed to map %pad: %d\n", &iova, ret);
+					continue;
+				}
+
+				mapped =3D true;
+			}
+		}
+
+		if (!mapped)
+			continue;
+
+		/* add stream IDs to the identity mapping */
+		while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
+						   index, &args)) {
+			unsigned int i, idx;
+			u16 sid, mask;
+			u32 fwid;
+
+			dev_info(dev, "    %pOF: %d arguments\n", args.np, args.args_count);
+
+			for (i =3D 0; i < args.args_count; i++)
+				dev_info(dev, "      %u: %08x\n", i, args.args[i]);
+
+			/* XXX check that args.np is the SMMU */
+			if (args.np !=3D smmu->dev->of_node) {
+				dev_info(dev, "      master %u is not one of ours: %pOF\n", index, arg=
s.np);
+				index++;
+				continue;
+			}
+
+			fwid =3D arm_smmu_of_parse(args.np, args.args, args.args_count);
+			sid =3D FIELD_GET(SMR_ID, fwid);
+			mask =3D FIELD_GET(SMR_MASK, fwid);
+
+			dev_info(dev, "      SID: %04x MASK: %04x\n", sid, mask);
+
+			ret =3D arm_smmu_find_sme(smmu, sid, mask);
+			if (ret < 0) {
+				dev_err(dev, "failed to find SME: %d\n", ret);
+				index++;
+				continue;
+			}
+
+			idx =3D ret;
+			dev_info(dev, "      found index: %u\n", idx);
+
+			if (smrs && smmu->s2crs[idx].count =3D=3D 0) {
+				smrs[idx].id =3D sid;
+				smrs[idx].mask =3D mask;
+				smrs[idx].valid =3D true;
+			}
+
+			smmu->s2crs[idx].count++;
+
+			//arm_smmu_write_sme(smmu, idx);
+			index++;
+		}
+	}
+
+	dev_info(dev, "< %s()\n", __func__);
+	return 0;
+}
+
 struct arm_smmu_match_data {
 	enum arm_smmu_arch_version version;
 	enum arm_smmu_implementation model;
@@ -1976,6 +2130,8 @@ static int arm_smmu_device_dt_probe(struct platform_d=
evice *pdev,
 	struct device *dev =3D &pdev->dev;
 	bool legacy_binding;
=20
+	pr_info("> %s(pdev=3D%px, smmu=3D%px)\n", __func__, pdev, smmu);
+
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
 		dev_err(dev, "missing #global-interrupts property\n");
@@ -2001,6 +2157,7 @@ static int arm_smmu_device_dt_probe(struct platform_d=
evice *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |=3D ARM_SMMU_FEAT_COHERENT_WALK;
=20
+	pr_info("< %s()\n", __func__);
 	return 0;
 }
=20
@@ -2118,6 +2275,10 @@ static int arm_smmu_device_probe(struct platform_dev=
ice *pdev)
 	if (err)
 		return err;
=20
+	err =3D arm_smmu_setup_identity(smmu);
+	if (err)
+		return err;
+
 	if (smmu->version =3D=3D ARM_SMMU_V2) {
 		if (smmu->num_context_banks > smmu->num_context_irqs) {
 			dev_err(dev,
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 6b6b877135de..001e60a3d18c 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -280,6 +280,8 @@ struct arm_smmu_device {
=20
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	struct iommu_domain		*identity;
 };
=20
 enum arm_smmu_context_fmt {

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3eaTIACgkQ3SOs138+
s6F8xBAAqYF5TB6VV5m5M/RzAqp0F1HX2hNUWe5mUyqsgKZiql6DO9RWo3cj6mCf
eCUbLlmntqiLNHKbs6ZEz2NJmKBT9e5gxzb1f/MKLy4+3hJz5AbdqdWZeTfpC1WM
ct3nY6xbXlERU8/JZJfWRoD2K/v8pD3mjbYF5E2MafZl2+ONWvtaKh2KJe5uwpxP
aogWNkIUj6z5XwODE7xm85hAIPPew6/MOIMH887T0quW+kQTdl61xz4vZcZCpvrF
w/+yb7tB30KPmhKQd8hZkVqBId7hd7702zfMVd1SmblHh8cCOY551WIFLwwPTKMJ
nBeWsLsRQMbVvl3tffDiza+1mwycmIp5Q0A6ApLnxEY6cru1lcSH8BAqBFhuk/i8
epSY5hPLHKnJ/xixldIJjvyt7is2itAMUMN7W1HyQtoZSCT9NeFxirRjyA6VM8QK
5wKoxOg3iTP8G47Rpthendu+5DaikrCesdsjFWUpDuA2gadYgcuAYt0vcuQUfTZT
J8t7yFxA9ZUGAdpnPsLN4APVcCjiLqEct5SXuIck63mdbPv2oTd/EhH+PcNF7koF
O5Q1Adrf8QaQFw52aITKM/hRBARM+lbokwfEVFYJNoZkVPMa8U7aBBONGyHZGLhD
CClkdhpDiZWJJpXikE3rqeZTuONxqfgOJSaY4nTpR3Rt1t+Fi4Y=
=wKEo
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

--===============6368784187237313081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6368784187237313081==--
