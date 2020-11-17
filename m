Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB626C2D0E4
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 13:48:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C232468D
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 13:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6exzerX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C232468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 644DB204BF;
	Tue, 17 Nov 2020 13:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRibPtRX44oi; Tue, 17 Nov 2020 13:48:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 198E920344;
	Tue, 17 Nov 2020 13:48:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEEF7C0800;
	Tue, 17 Nov 2020 13:48:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6F02C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 13:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8AD8A86FC6
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 13:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xsUcbAi8YvHO for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 13:47:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 745CD86FC1
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 13:47:59 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id h21so3290024wmb.2
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 05:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wtRPmHgnz5X1Kb5wQe988YxeBIzauGayM+LxupkV9hU=;
 b=K6exzerX/Go7V6Q+x7FHPm4xpHTN9zwV+3KNS3M8AkytQWvrn4uJce020n04UP9PTm
 i0FZdnDeBf2cuK0V+XzlQAfuhjjTLm9YN/aX/rUNM6D7fib+zH7fQ0lGkpj6C6qlEbsX
 LPttGJve39Wv0RoocN4UDfCbrY/LD+h+BdGnLoDBfU/fHmKk5IsPJTBFFpUBps3BzouI
 o6lxWGoSMlFMEl00AapPCLUvp7x4YHvur3Q8dENYXw0rq2E6sTCbS1F9lg8RbqPSULOR
 iRN+JP4uUCyM7+96Sh7ST3EuEU+HWtlvYTV+mdFXf4TIVyaITFD+/OgR1FRwc87NnLN6
 R+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wtRPmHgnz5X1Kb5wQe988YxeBIzauGayM+LxupkV9hU=;
 b=EPM6BvR1C0dUiYKYYr2A66qPY3ynn6F3jkaXzrsKHeQqCfr0pPtKx+DhE5RmlsJESJ
 kxUDHT57UdRzaTCF5BuDT1fB4eogzCbBMYTU7aNHuIZuOD0UUGH7O2GLnNFOksiYl1zm
 1H6406uOjyd40DPELq3S2qrjz/EIlj24ni3+EmEM1P8VJSyAGM3LKay+FCrlZAAGFHf0
 9t3agX0/ylkVg+MZxlq7R9heReHSbjRjiRTThgNnza6bgUxTWuqJ4XveXQ6DP5zSZDR6
 4CZdVKltih9KifSC8PcDXiJU2mVLLpTFt38N6H1cl0gkCzYsuuBVJlg+snPW8bu8pgJ6
 fD5g==
X-Gm-Message-State: AOAM531TeQiu/3IbMh20AjoaPwzQvYsKHNbed/cesSRT7rKaZJZbmzWI
 KYe/AMnjGWNUVaab6zXOxPA=
X-Google-Smtp-Source: ABdhPJxUkbY+s0j/Ih+dPCP6czx7rsv21c1tFlLFkPICYayWqEzmgqz4lJIWMofYOMOBJQktU1rlHQ==
X-Received: by 2002:a1c:ddc4:: with SMTP id u187mr4693503wmg.55.1605620877837; 
 Tue, 17 Nov 2020 05:47:57 -0800 (PST)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id 30sm20901859wrd.88.2020.11.17.05.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 05:47:56 -0800 (PST)
Date: Tue, 17 Nov 2020 14:47:54 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v6 3/3] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
Message-ID: <20201117134754.GB2589875@ulmo>
References: <20201106042710.55979-1-john.stultz@linaro.org>
 <20201106042710.55979-3-john.stultz@linaro.org>
 <20201116155936.GE2224373@ulmo>
 <20201116163603.GA30507@willie-the-truck>
 <CALAqxLVDm923WRSB+DVxFacmEtmEPS7Qeq+rW_jbCDMNMWw9PQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALAqxLVDm923WRSB+DVxFacmEtmEPS7Qeq+rW_jbCDMNMWw9PQ@mail.gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jon Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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
Content-Type: multipart/mixed; boundary="===============0361093000988850736=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0361093000988850736==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 11:48:39AM -0800, John Stultz wrote:
> On Mon, Nov 16, 2020 at 8:36 AM Will Deacon <will@kernel.org> wrote:
> > On Mon, Nov 16, 2020 at 04:59:36PM +0100, Thierry Reding wrote:
> > > On Fri, Nov 06, 2020 at 04:27:10AM +0000, John Stultz wrote:
> > > Unfortunately, the ARM SMMU module will eventually end up being loaded
> > > once the root filesystem has been mounted (for example via SDHCI or
> > > Ethernet, both with using just plain, non-IOMMU-backed DMA API) and t=
hen
> > > initialize, configuring as "fault by default", which then results fro=
m a
> > > slew of SMMU faults from all the devices that have previously configu=
red
> > > themselves without IOMMU support.
> >
> > I wonder if fw_devlink=3Don would help here?
> >
> > But either way, I'd be more inclined to revert this change if it's caus=
ing
> > problems for !QCOM devices.
> >
> > Linus -- please can you drop this one (patch 3/3) for now, given that i=
t's
> > causing problems?
>=20
> Agreed. Apologies again for the trouble.
>=20
> I do feel like the probe timeout to handle optional links is causing a
> lot of the trouble here. I expect fw_devlink would solve this, but it
> may be awhile before it can be always enabled.  I may see about
> pushing the default probe timeout value to be a little further out
> than init (I backed away from my last attempt as I didn't want to
> cause long (30 second) delays for cases like NFS root, but maybe 2-5
> seconds would be enough to make things work better for everyone).

I think there are two problems here: 1) the deferred probe timeout can
cause a mismatch between what SMMU masters and the SMMU think is going
on and 2) a logistical problem of dealing with the SMMU driver being a
loadable module.

The second problem can be dealt with by shipping the module in the
initial ramdisk. That's a bit annoying, but perhaps the right thing to
do. At least on Tegra we need this because all the devices that carry
the root filesystem (Ethernet for NFS and SDHCI/USB/SATA/PCI for disk
boot) are SMMU masters and will start to fault once the SMMU driver is
loaded.

The first problem is trickier, but if the ARM SMMU driver is built as a
module and shipped in the initial ramdisk it should work. Like I said,
this is annoying because it makes the development a bit more complicated
than just rebuilding a kernel image and flashing it (or boot it straight
=66rom TFTP) because now everytime the ARM SMMU module is built the
initial ramdisk needs to be updated (and potentially flashed) as well.

Thierry

P.S.: Interestingly this is very similar to the problem that I've been
trying to address for display hardware that's left on by the bootloader.
Given that, one potential solution would be to somehow retrieve memory
allocations done by these devices and create identity mappings in the
ARM SMMU address spaces for such devices, much like we plan to do for
devices left on by the bootloader (like the display controller for
showing a boot splash). I suspect that it's not really worth doing this
for devices that are only initialized by the kernel because we have a
bit of control over when we enable them, so I'd prefer if we just kept
things reasonably simple and made sure the SMMU was either always used
by a device from the start or not at all. Dynamically switching between
SMMU and no-SMMU seems a bit eccentric.

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+z1IgACgkQ3SOs138+
s6F6ohAAneS0yFFBHoNDyOBvzWz0HOfTqXdo3x/QX0dAfVKc6bJ0Qe/RLBWwNpSY
UjiqerKccBGe8l7Bf+b6Bj6/vKDLeMfI6hUawI51x3w4pf3u8HPsVEvsTOtPuVrX
IEmw4B24/OCZCaYLlVB8a23JXGV8zSleTvHCUehX2eqCmhVF1/UAz2ZqVKt1WVNw
BoIejtEgEvUkAgC+K2xlEXkKwhQCwc1ZyT3O98Ckc0oBmQm9PjxDL+TvUsWJWPNY
Bu0TVlQCrq6arWhuu78Bo+IhayrMcCiHKSW5UHpmAYK+8nMSjQx7G2pz6iu11TTk
LOeUemfODzr38DlHswfFdaDhWnTs6e5bA/4To719EoVai89kld+Ch4vcC9LXunp5
ZPBmeX/pOBtcqt62YzkGFMMhMsD5+4ufGKK1rXZANisp9DMBThO7OKcCh/vXtE1T
INGW040P33ZB6rNT3cEziha7AUMO/MsbcvMM78cy79jzp6rKwhHM5JNJtQ6vKaOn
pXjCt8cRQH7OY+BmyDEBJQFqTAd8rmrvtRxr6lNEMpxea3fy3u0BP9FjTf2EgF6S
FVQ1suGBvbYueWsjSDOML9C/CYZHojAmUNyadmYmBwEKyd9NNHi9RRTteZpWESPS
/Psgw2xKXBu2mxWo1v+lv6lEH4m/aVlM0a8iMJT6yWL4SSPN6Bo=
=oG/d
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

--===============0361093000988850736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0361093000988850736==--
