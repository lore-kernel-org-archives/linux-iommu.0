Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E71AC5517A
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 15:49:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEEBE2078E
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 15:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnGsrrme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEBE2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 18DA5871AA;
	Thu,  5 Nov 2020 15:49:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N8SBPf-MMxuE; Thu,  5 Nov 2020 15:49:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 05DA384173;
	Thu,  5 Nov 2020 15:49:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDD1CC088B;
	Thu,  5 Nov 2020 15:49:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 642ECC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 15:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 529A684F48
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 15:49:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4TYmQ7aD6Jm1 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 15:49:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D486B845D6
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 15:49:32 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id w1so2027195edv.11
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 07:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=j969qGQzQwzgTzTPml9s2WsIOijqlv1E2Jp0DyWuo9s=;
 b=rnGsrrme4nm9C3GEK4cd9CoN6Q4HYLaq3lhlNEz8YGIjrPLafq4ItHN1dpgV9NSJwK
 KQwuIxIPj8xpWwpo//2pT+X+Umlj+Ud/ozgqmUi9CMLhrGPA8BtVI07Bk+LCeMCuekWb
 rUG+mWuEtW2mU/KsFUm+Jio4BSbU98jv/aPiTDULelEWNvDsqzDwOskN7W0SMx9MVCSD
 KfaE7fvUpjL0sOmoV34SE3WfKJt5uBSoaMa/dpLPr6V37mJ4XasvcwnroZOse0bu4I2H
 W/jk49K1KDapuRdtw2O/mjLzvJVk36Y7nNpK2A59oZW4icD5mYSQ41fiTBUYj6ML+WDR
 N8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=j969qGQzQwzgTzTPml9s2WsIOijqlv1E2Jp0DyWuo9s=;
 b=uhzrH9y4q8MLpiHH1UUNngmXuiUnkQKNK4dWSoOeC98DHsHYuMuGwTAA/cz4PcemHM
 cnFy5l5lq5ah5NwoafmVXIxrYSjuf16uVO1QlAZSacTKd023FZxdISbJOEljG4NgVFKy
 1lEhYLkH0Nawn2UfOZXqRDVQLlmh/VQnq9yNjBCtJV/UzOprTqSspcYeUu4h9Qq5Focm
 yZOsVFp9PDaUMl8cgj/PizkkZkWuYQBp/fGMLRbbH29mmjkBGYStfXGm9y5Rz54xP74X
 9JWdI7Qn4IwsxGPBg43nzY+0lAFYYcFKNIjyjwmuTaw5vpyT2lgSO6TAOOB01ej47YAd
 9ZLw==
X-Gm-Message-State: AOAM5301t9k9zAneTYsgFBDvEa6AAfplak8p/ipjEFK/d9aAKCSY0DWT
 J0qT1sZekGV5BJyZkwu8EMw=
X-Google-Smtp-Source: ABdhPJwGk41+HL8sv9fsfMXAHqgDD0f+8lyLCDQvIHkdbvPeP/bzkiZIGhuvIcLmfqg63DwYA0N1tA==
X-Received: by 2002:aa7:d858:: with SMTP id f24mr3180351eds.12.1604591371082; 
 Thu, 05 Nov 2020 07:49:31 -0800 (PST)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id f19sm1172377ejk.116.2020.11.05.07.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 07:49:29 -0800 (PST)
Date: Thu, 5 Nov 2020 16:49:28 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20201105154928.GA485884@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <d3d69cb4-b0f9-40b0-b526-52fdc1a4b876@gmail.com>
 <20200924140130.GA2527337@ulmo>
 <ba16b795-34df-8f8c-3376-3d629cc30f8b@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ba16b795-34df-8f8c-3376-3d629cc30f8b@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Will Deacon <will@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============7619167410842215103=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7619167410842215103==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 07:23:34PM +0300, Dmitry Osipenko wrote:
> 24.09.2020 17:01, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Sep 24, 2020 at 04:23:59PM +0300, Dmitry Osipenko wrote:
> >> 04.09.2020 15:59, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> From: Thierry Reding <treding@nvidia.com>
> >>>
> >>> Reserved memory regions can be marked as "active" if hardware is
> >>> expected to access the regions during boot and before the operating
> >>> system can take control. One example where this is useful is for the
> >>> operating system to infer whether the region needs to be identity-
> >>> mapped through an IOMMU.
> >>>
> >>> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >>> ---
> >>>  .../bindings/reserved-memory/reserved-memory.txt           | 7 +++++=
++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserv=
ed-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-=
memory.txt
> >>> index 4dd20de6977f..163d2927e4fc 100644
> >>> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memo=
ry.txt
> >>> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memo=
ry.txt
> >>> @@ -63,6 +63,13 @@ reusable (optional) - empty property
> >>>        able to reclaim it back. Typically that means that the operati=
ng
> >>>        system can use that region to store volatile or cached data th=
at
> >>>        can be otherwise regenerated or migrated elsewhere.
> >>> +active (optional) - empty property
> >>> +    - If this property is set for a reserved memory region, it indic=
ates
> >>> +      that some piece of hardware may be actively accessing this reg=
ion.
> >>> +      Should the operating system want to enable IOMMU protection fo=
r a
> >>> +      device, all active memory regions must have been identity-mapp=
ed
> >>> +      in order to ensure that non-quiescent hardware during boot can
> >>> +      continue to access the memory.
> >>> =20
> >>>  Linux implementation note:
> >>>  - If a "linux,cma-default" property is present, then Linux will use =
the
> >>>
> >>
> >> Hi,
> >>
> >> Could you please explain what devices need this quirk? I see that you'=
re
> >> targeting Tegra SMMU driver, which means that it should be some pre-T1=
86
> >> device.
> >=20
> > Primarily I'm looking at Tegra210 and later, because on earlier devices
> > the bootloader doesn't consistently initialize display. I know that it
> > does on some devices, but not all of them.
>=20
> AFAIK, all tablet devices starting with Tegra20 that have display panel
> are initializing display at a boot time for showing splash screen. This
> includes all T20/T30/T114 tablets that are already supported by upstream
> kernel.
>=20
> > This same code should also
> > work on Tegra186 and later (with an ARM SMMU) although the situation is
> > slightly more complicated there because IOMMU translations will fault by
> > default long before these identity mappings can be established.
> >=20
> >> Is this reservation needed for some device that has display
> >> hardwired to a very specific IOMMU domain at the boot time?
> >=20
> > No, this is only used to convey information about the active framebuffer
> > to the kernel. In practice the DMA/IOMMU code will use this information
> > to establish a 1:1 mapping on whatever IOMMU domain that was picked for
> > display.
> >=20
> >> If you're targeting devices that don't have IOMMU enabled by default at
> >> the boot time, then this approach won't work for the existing devices
> >> which won't ever get an updated bootloader.
> >=20
> > If the devices don't use an IOMMU, then there should be no problem. The
> > extra reserved-memory nodes would still be necessary to ensure that the
> > kernel doesn't reuse the framebuffer memory for the slab allocator, but
> > if no IOMMU is used, then the display controller accessing the memory
> > isn't going to cause problems other than perhaps scanning out data that
> > is no longer a framebuffer.
> >=20
> > There should also be no problem for devices with an old bootloader
> > because this code is triggered by the presence of a reserved-memory node
> > referenced via the memory-region property. Devices with an old
> > bootloader should continue to work as they did before. Although I
> > suppose they would start faulting once we enable DMA/IOMMU integration
> > for Tegra SMMU if they have a bootloader that does initialize display to
> > actively scan out during boot.
> >=20
> >> I think Robin Murphy already suggested that we should simply create
> >> a dummy "identity" IOMMU domain by default for the DRM/VDE devices and
> >> then replace it with an explicitly created domain within the drivers.
> >=20
> > I don't recall reading about that suggestion. So does this mean that for
> > certain devices we'd want to basically passthrough by default and then
> > at some point during boot take over with a properly managed IOMMU
> > domain?
>=20
> Yes, my understanding that this is what Robin suggested here:
>=20
> https://lore.kernel.org/linux-iommu/cb12808b-7316-19db-7413-b7f852a6f8ae@=
arm.com/
>=20
> > The primary goal here is to move towards using the DMA API rather than
> > the IOMMU API directly, so we don't really have the option of replacing
> > with an explicitly created domain. Unless we have code in the DMA/IOMMU
> > code that does this somehow.
> >=20
> > But I'm not sure what would be a good way to mark certain devices as
> > needing an identity domain by default. Do we still use the reserved-
> > memory node for that?
>=20
> The reserved-memory indeed shouldn't be needed for resolving the
> implicit IOMMU problem since we could mark certain devices within the
> kernel IOMMU driver.
>=20
> I haven't got around to trying to implement the implicit IOMMU support
> yet, but I suppose we could implement the def_domain_type() hook in the
> SMMU driver and then return IOMMU_DOMAIN_IDENTITY for the Display/VDE
> devices. Then the Display/VDE drivers will take over the identity domain
> and replace it with the explicit domain.

Actually, the plan (and part of the reason for this patch) is to
transition the display driver over to using the DMA API rather than
creating IOMMU domains explicitly.

Explicit IOMMU usage currently works around this prior to Tegra186
because IOMMU translations are not enabled until after the device has
been attached to the IOMMU, at which point a mapping will already have
been created. It's also part of the reason why we don't support DMA-
type domains yet on Tegra SMMU, because as soon as we do, this would
cause a fault storm during boot.

On Tegra186 this same problem exists because the driver does support DMA
type domains and hence the kernel will try to set those up for display
during early boot and before the driver has had a chance to set up
mappings (or quiesce the display hardware).

> > That would still require some sort of flag to
> > specify which reserved-memory regions would need this identity mapping
> > because, as was pointed out in earlier review, some devices may have
> > reserved-memory regions that are not meant to be identity mapped.
>=20
> Please note that the reserved-memory approach also creates problem for
> selection of a large CMA region if FB is located somewhere in a middle
> of DRAM.
>=20
> I already see that the FB's reserved-memory will break CMA for Nexus 7
> and Acer A500 because CMA area overlaps with the bootloader's FB :)
>=20
> Also keep in mind that initrd needs a location too and location usually
> hardwired in a bootloader. Hence it increases pressure on the CMA selecti=
on.

I do understand those issues, but there's really not a lot we can do
about it. It's wrong for CMA to overlap with the framebuffer from which
the display hardware just keeps scanning out, so all that these reserved
memory nodes do is actually fix a long-standing bug (depending on how
paranoid you are, you might even consider it a security hole).

For older devices that don't have a bootloader that properly defines
this memory as reserved, they should be able to continue to use a CMA
that overlaps with the framebuffer and work just like before.

> >> Secondly, all NVIDIA bootloaders are passing tegra_fbmem=3D... via
> >> kernel's cmdline with the physical location of the framebuffer in
> >> memory. Maybe we could support this option?
> >=20
> > I'm not a big fan of that command-line option, but I also realize that
> > for older bootloaders that's probably the only option we have. I don't
> > suppose all of the devices support U-Boot?
>=20
> Majority of devices in a wild don't use u-boot and they have a
> locked-down bootloader. Still it's possible to chain-load u-boot or
> bypass the "security" and replace the bootloader, but these approaches
> aren't widely supported because they take a lot of effort to be
> implemented and maintained.
>=20
> Even those devices that use proper u-boot usually never updating it and
> are running some ancient version. You can't ignore all those people :)

I'm not trying to ignore all those people, but at the same time I don't
think legacy devices about which we can't do much should prevent new
devices from doing the right thing and properly reserving memory that
the kernel isn't supposed to use.

You already suggested that we could choose an identity domain by default
for VDE and display for this. That sounds like a good compromise to me,
but I think we should do that only on platforms where we can't implement
this properly.

> > Because ideally we'd just
> > translate from tegra_fbmem=3D... to reserved-memory region there so that
> > we don't have to carry backwards-compatibility code for these purely
> > downstream bootloaders.
>=20
> IIRC, in the past Robin Murphy was suggesting to read out hardware state
> early during kernel boot in order to find what regions are in use by
> hardware.
>=20
> I think it should be easy to do for the display controller since we
> could check clock and PD states in order to decide whether DC's IO could
> be accessed and then read out the FB pointer and size. I guess it should
> take about hundred lines of code.
>=20
> But the easiest way should be to ignore this trouble for devices that
> have IOMMU disabled by default and simply allow display to show garbage.
> Nobody ever complained about this for the past 7+ years :)
>=20
> Hence implementing the dummy-identity domain support should be enough
> for solving the problem, at least this should work for pre-T186 devices.

I'd still like to do this properly at least on Tegra210 as well. It
should be possible to come up with a set of criteria where the dummy
identity domain should be used and where it shouldn't. I think that's
the easiest part of this and can easily be implemented as a couple-of-
lines quirk in some kernel driver.

Thierry

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+kHwQACgkQ3SOs138+
s6EWHRAAptQN1OiwrZQsHGA5W487jlnbZqPyRcfx2UOYugubI+gt58sGagpJOTJq
rSHcXSOUTd7caWc+z3sRj4SRaysAc5vzZOS6kzVQvVMDgKN0m8q9pNLPbnjjd/mA
k5c1ACMGz7FMAlhFYNeERCPjzqcOfuZ7Wj0St6z8bSvwi6MYgnZL6J6THuWSk6YO
kxU/aHKELXzpbbjD0v9VDKbwyXVrLELxdT4yHlaIc/dmU/PKWCJNkgtZEF7yNXkO
m9x6n4QDmbC43GJwKmffb7MZeWQX7HoF7G02tLqhhoGsD1ihiItCX0XZqMofYTmW
fZTQGjpLgYy23l8WpkRLPIXpf/5aG3hR0/zKPwWISCqw2E2qiwDlyF7Gy9JJVbYc
HVDEyN6xa1EHQAvyBbI/mmn2nzgGiKrTbHWjtLorACrKlyxzysD7VY6CGvE+qY22
rnaobxgihSM62r5I8aqlwGJ7OdyAKq9mg+EZkJo5swlMmSO7D7naEJNm2Etk50ey
ALnVDa1cjKgfPNM5eDCotxUM9yXeaPFSlIkHHpmWzv1ZgeTeatQ3F/23kcmChxdK
2KIIEeSm62WV+l+cyto6XoZenQBa6dhUqZn77QC9tuBTU7tgOvXgCBDygqglCLyE
ce/M2/vPbD7BuZmH2psFr1UQvctawqSpQ4AMlayZJtSAWZQUBKc=
=OS9Q
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

--===============7619167410842215103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7619167410842215103==--
