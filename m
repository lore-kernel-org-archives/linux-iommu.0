Return-Path: <SRS0=GPww=FV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C00C4361B
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 15:00:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E942396F
	for <iommu@archiver.kernel.org>; Thu, 17 Dec 2020 15:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E942396F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0A0B587599;
	Thu, 17 Dec 2020 15:00:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wxvm73YqUsQK; Thu, 17 Dec 2020 15:00:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DA5EC8758A;
	Thu, 17 Dec 2020 15:00:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD561C0893;
	Thu, 17 Dec 2020 15:00:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E764C013B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 15:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7C4F887A5D
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 15:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m06c-wlctVCd for <iommu@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 15:00:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F34AE879C4
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 15:00:08 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id c5so23243872wrp.6
 for <iommu@lists.linux-foundation.org>; Thu, 17 Dec 2020 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0LSUgRDaR4RRp/a+CelWRHfYrIivkS3xSjoLwdPOs5Y=;
 b=daOHn2wJ3D6nGPXFnrU9jzmusWrPMOgOtzPTAw5N76BlueHywuKdDO8t5OeqMklgjd
 d+kMq4+cSGbpXJJnqSXxpcTrQDa2MEZ27h4LrG+hzCBEabhc2i8wSkSPmXjU24CXv213
 SHIgXd2rsgKmWRBcv/YtGA+a8yJeXEvio+mEWsh8fy++s3/PHE7dAIw9RhuTV3F5l0Ub
 5y4oGWpgmB/iwVw3cEoWL9DwQJhJJ3SUPLZ2z27B5Z915TlgRNyOYF4HJ80TVH//gOSh
 APCTtw7TryuGRoyJRt+eO07l43mwAvlA66wzDLzY4onWI8X+Xcj4r7olE7uBywyGjyJV
 NBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0LSUgRDaR4RRp/a+CelWRHfYrIivkS3xSjoLwdPOs5Y=;
 b=qKqLHSMvd5wUWtkGLjHoNx7QVQ242iSySweJvAkKWZ+//ZAsIQ5+8QVUmcxqfMr5NE
 TojDZ9FcSxSiVS40x+qzEb0O3XBP2Ags1GK29CLom1nnfAHG3y39/WsJMovVm6J2s5IK
 1QEIgCVyL222ZAIZ2/9mlDSYfDL+bJzGI0a1dAYyrBrGMM/kXQtAwBypytXBm+iPK9Jq
 gGJO4NX+IfAU7ix7ODugCM4ePEO0A27q++Mhg9m4olz8kr9YCQ0qTI9dydo9xZOD3n+m
 d4h2OpfeAocF/CaVnRu6Iy5w8JeC56vEhu+8A6FDGnflpVH1AnIwvMSJ+AA895OcWpdA
 XC5Q==
X-Gm-Message-State: AOAM532C6aILLeZGT20zjMg8f301Q2YSz085Itb7XG6RpnlZZhaZnq6m
 TiaqFMNhjQcZGfR/vnT8BwE=
X-Google-Smtp-Source: ABdhPJyr0oD+K4yZedYaqxElVG7nQh4K+CJMWaXdeTtAPs8N5hCu3ZEdxOC8eYVAZ0YaNe8jZJsG/Q==
X-Received: by 2002:a5d:4ccf:: with SMTP id c15mr44817096wrt.237.1608217207221; 
 Thu, 17 Dec 2020 07:00:07 -0800 (PST)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id h4sm8986737wrt.65.2020.12.17.07.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Dec 2020 07:00:05 -0800 (PST)
Date: Thu, 17 Dec 2020 16:00:03 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <X9tyc3t2MgtiFwwb@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <20200914220829.GA330122@bogus> <20200915123648.GA3496938@ulmo>
 <20200924112725.GA2486709@ulmo> <20201105164312.GD485884@ulmo>
 <483cd043-980e-81fb-cccb-385206a699df@arm.com>
 <20201106152548.GA767203@ulmo> <20201110193309.GB2303484@ulmo>
MIME-Version: 1.0
In-Reply-To: <20201110193309.GB2303484@ulmo>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============8112980559288411879=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8112980559288411879==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D/KyDYIMTRn6km9S"
Content-Disposition: inline


--D/KyDYIMTRn6km9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2020 at 08:33:09PM +0100, Thierry Reding wrote:
> On Fri, Nov 06, 2020 at 04:25:48PM +0100, Thierry Reding wrote:
> > On Thu, Nov 05, 2020 at 05:47:21PM +0000, Robin Murphy wrote:
> > > On 2020-11-05 16:43, Thierry Reding wrote:
> > > > On Thu, Sep 24, 2020 at 01:27:25PM +0200, Thierry Reding wrote:
> > > > > On Tue, Sep 15, 2020 at 02:36:48PM +0200, Thierry Reding wrote:
> > > > > > On Mon, Sep 14, 2020 at 04:08:29PM -0600, Rob Herring wrote:
> > > > > > > On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrot=
e:
> > > > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > > > >=20
> > > > > > > > Reserved memory regions can be marked as "active" if hardwa=
re is
> > > > > > > > expected to access the regions during boot and before the o=
perating
> > > > > > > > system can take control. One example where this is useful i=
s for the
> > > > > > > > operating system to infer whether the region needs to be id=
entity-
> > > > > > > > mapped through an IOMMU.
> > > > > > >=20
> > > > > > > I like simple solutions, but this hardly seems adequate to so=
lve the
> > > > > > > problem of passing IOMMU setup from bootloader/firmware to th=
e OS. Like
> > > > > > > what is the IOVA that's supposed to be used if identity mappi=
ng is not
> > > > > > > used?
> > > > > >=20
> > > > > > The assumption here is that if the region is not active there i=
s no need
> > > > > > for the IOVA to be specified because the kernel will allocate m=
emory and
> > > > > > assign any IOVA of its choosing.
> > > > > >=20
> > > > > > Also, note that this is not meant as a way of passing IOMMU set=
up from
> > > > > > the bootloader or firmware to the OS. The purpose of this is to=
 specify
> > > > > > that some region of memory is actively being accessed during bo=
ot. The
> > > > > > particular case that I'm looking at is where the bootloader set=
 up a
> > > > > > splash screen and keeps it on during boot. The bootloader has n=
ot set up
> > > > > > an IOMMU mapping and the identity mapping serves as a way of ke=
eping the
> > > > > > accesses by the display hardware working during the transitiona=
l period
> > > > > > after the IOMMU translations have been enabled by the kernel bu=
t before
> > > > > > the kernel display driver has had a chance to set up its own IO=
MMU
> > > > > > mappings.
> > > > > >=20
> > > > > > > If you know enough about the regions to assume identity mappi=
ng, then
> > > > > > > can't you know if active or not?
> > > > > >=20
> > > > > > We could alternatively add some property that describes the reg=
ion as
> > > > > > requiring an identity mapping. But note that we can't make any
> > > > > > assumptions here about the usage of these regions because the I=
OMMU
> > > > > > driver simply has no way of knowing what they are being used fo=
r.
> > > > > >=20
> > > > > > Some additional information is required in device tree for the =
IOMMU
> > > > > > driver to be able to make that decision.
> > > > >=20
> > > > > Rob, can you provide any hints on exactly how you want to move th=
is
> > > > > forward? I don't know in what direction you'd like to proceed.
> > > >=20
> > > > Hi Rob,
> > > >=20
> > > > do you have any suggestions on how to proceed with this? I'd like t=
o get
> > > > this moving again because it's something that's been nagging me for=
 some
> > > > months now. It also requires changes across two levels in the bootl=
oader
> > > > stack as well as Linux and it takes quite a bit of work to make all=
 the
> > > > changes, so before I go and rewrite everything I'd like to get the =
DT
> > > > bindings sorted out first.
> > > >=20
> > > > So just to summarize why I think this simple solution is good enoug=
h: it
> > > > tries to solve a very narrow and simple problem. This is not an att=
empt
> > > > at describing the firmware's full IOMMU setup to the kernel. In fac=
t, it
> > > > is primarily targetted at cases where the firmware hasn't setup an =
IOMMU
> > > > at all, and we just want to make sure that when the kernel takes ov=
er
> > > > and does want to enable the IOMMU, that all the regions that are
> > > > actively being accessed by non-quiesced hardware (the most typical
> > > > example would be a framebuffer scanning out a splat screen or anima=
tion,
> > > > but it could equally well be some sort of welcoming tone or music b=
eing
> > > > played back) are described in device tree.
> > > >=20
> > > > In other words, and this is perhaps better answering your second
> > > > question: in addition to describing reserved memory regions, we wan=
t to
> > > > add a bit of information here about the usage of these memory regio=
ns.
> > > > Some memory regions may contain information that the kernel may wan=
t to
> > > > use (such an external memory frequency scaling tables) and those I =
would
> > > > describe as "inactive" memory because it isn't being accessed by
> > > > hardware. The framebuffer in this case is the opposite and it is be=
ing
> > > > actively accessed (hence it is marked "active") by hardware while t=
he
> > > > kernel is busy setting everything up so that it can reconfigure that
> > > > hardware and take over with its own framebuffer (for the console, f=
or
> > > > example). It's also not so much that we know enough about the regio=
n to
> > > > assume it needs identity mapping. We don't really care about that f=
rom
> > > > the DT point of view. In fact, depending on the rest of the system
> > > > configuration, we may not need identity mapping (i.e. if none of the
> > > > users of the reserved memory region are behind an IOMMU). But the p=
oint
> > > > here is that the IOMMU drivers can use this "active" property to
> > > > determine that if a device is using an "active" region and it is be=
hind
> > > > an IOMMU, then it must identity map that region in order for the
> > > > hardware, which is not under the kernel's control yet, to be able to
> > > > continue to access that memory through an IOMMU mapping.
> > >=20
> > > Hmm, "active" is not a property of the memory itself, though, it's re=
ally a
> > > property of the device accessing it. If several distinct devices shar=
e a
> > > carveout region, and for simplicity the bootloader marks it as active
> > > because one of those devices happens to be using some part of it at b=
oot, we
> > > don't really want to have to do all the reserved region setup for all=
 the
> > > other devices unnecessarily, when all that matters is not disrupting =
one of
> > > them when resetting the IOMMU.
> > >=20
> > > That leads to another possible hiccup - some bindings already have a =
defined
> > > meaning for a "memory-region" property. If we use that to point to so=
me
> > > small region for a temporary low-resolution bootsplash screen for vis=
ibility
> > > to an IOMMU driver, the device's own driver might also interpret it a=
s a
> > > private carveout from which it is expected to allocate everything, an=
d thus
> > > could end up failing to work well or at all.
> > >=20
> > > I agree that we should only need a relatively simple binding, and that
> > > piggybacking off reserved-memory nodes seems like an ideal way of get=
ting
> > > address range descriptions without too much extra complexity; the tri=
cky
> > > part is how best to associate those with the other information needed=
, which
> > > is really the "iommus" property of the relevant device, and how to ma=
ke it
> > > as generically discoverable as possible. Perhaps it might be workable=
 to
> > > follow almost the same approach but with a dedicated property (e.g.
> > > "active-memory-region") that the IOMMU code can simply scan the DT fo=
r to
> > > determine relevant device nodes. Otherwise properties on the IOMMU no=
de
> > > itself would seem the next most practical option.
> >=20
> > We did recently introduce a "memory-region-names" property that's used
> > to add context for cases where multiple memory regions are used. Perhaps
> > the simplest to address the above would be to describe the region as
> > active by naming it "active". That has the disadvantage of restricting
> > the number of active regions to 1, though I suspect that may even be
> > enough for the vast majority of cases where we need this. This would be
> > similar to how we use the "dma-mem" string in the "interconnect-names"
> > property to specify the "DMA parent" of a device node.
> >=20
> > Alternatively, we could perhaps support multiple occurrences of "active"
> > in the "memory-region-names" property. Or we could add a bit of
> > flexibility by considering all memory regions whose names have an
> > "active-" prefix as being active.
> >=20
> > > We've also finally got things going on the IORT RMR side[1], which he=
lps add
> > > a bit more shape to things too; beyond the actual firmware parsing, D=
T and
> > > ACPI systems should definitely be converging on the same internal
> > > implementation in the IOMMU layer.
> >=20
> > Yeah, from a quick look at that series, this actually sounds really
> > close to what I'm trying to achieve here.
> >=20
> > The patch set that I have would nicely complement the code added to
> > iommu_dma_get_resv_regions() for RMR regions. It's not exactly the same
> > code, but it's basically the DT equivalent of
> > iort_dev_rmr_get_resv_regions().
>=20
> Hi Rob,
>=20
> what's your preference here for DT bindings? Do you want me to reuse the
> existing memory-region/memory-region-names properties, or do you want
> something completely separate?

Hi Rob,

I've been thinking about this some more and I think I've come up with an
alternative that I think you might like better than what we discussed so
far.

Rather than reusing memory-region-names and guessing from the name what
the intended purpose was, how about we add the concept of memory region
specifiers to describe additional properties of reserved memory regions
uses? This would allow us to address Robin's concerns about describing
what's essentially a device property within the reserved memory region.

The way I imagine that this would work is that the reserved memory
regions would gain a new property, "#memory-region-cells", that defines
the number of cells that make up a reserved memory region specifier,
much like we have #clock-cells, #reset-cells, #pwm-cells, etc. Since
these specifier are defined where the regions are used, they would allow
us to encode information about that specific use, rather than properties
of the regions themselves.

This should also allow for backwards-compatibility where a missing
#memory-region-cells would be interpreted as 0 specifier (i.e. no
additional data).

Here's how this would look for the specific example that I want to
solve:

	#define MEMORY_REGION_ACTIVE 0x1

	/ {
		reserved-memory {
			lut: lookup-table@96060000 {
				reg =3D <0x96060000 0x00010000>;
				#memory-region-cells =3D <1>;
			};

			fbc: framebuffer@96070000 {
				reg =3D <0x96070000 0x800000>;
				#memory-region-cells =3D <1>;
			};
		};

		...

		host1x@50000000 {
			...

			display@54200000 {
				...
				memory-regions =3D <&fbc MEMORY_REGION_ACTIVE>,
						 <&lut MEMORY_REGION_ACTIVE>;
				...
			};

			...
		};
	};

As you can see, the reserved memory region nodes only contain properties
that are immediately related to the regions themselves, whereas the
"active" attribute now applies only for the specific use of the region
within display@54200000.

What do you think?

Thierry

--D/KyDYIMTRn6km9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/bcnEACgkQ3SOs138+
s6En6xAAuxQGD36ndVdsCVjZCC71riYmRHpLvqHQCuyGX4SQ1fmORAcW1UBHAo6a
C3WNs9mfryE7K+20J8+XSptFo4EfCfrZVTRpbJcfFrgUjz66/4I2rQ/yC4OzbELD
ErU8CCOd7grT4QPn+fKBnx5AuznJrsj8FzDrSEGvrjitBqJl6BDCf9fENWMzCLXL
eBpahUg6t60r9XyT2HDdDZWevlIsEuHqlkHCBr28oCBeO9ODjlS7Eme1yVE/P6y3
/3bT6PF5mCoWhI9VI28n6oRZKAiNP4lgl7NQPElsPr+/tXakT85U+pfjkjx1EFlN
UcRVt9AKj1cBMy4oM7CN+a9lXtE9wvNswmUnjI/00Zk6xNoolQ8NrWO14gofAok9
i83YhS+7eQec3xFPMXXPcd1MwWI1D2QFBYeBDuGif985owmGrK0keaOPOiI2CIDS
E1MruIHkTZqWvPv0yFTI+/0UJSSwO4mUj5/E6alXHKgE+eLuipsFOHuDbAuCqSil
8Noaqq/le3gx/WO1JiwWudGz/DAhnXatbAzI2LGxsnbQVShittoW8h3QVx/9SJ80
EuXGvmlG77TMBZvI6VicpP+rZS4s26jau+pQxZxleym9ZexgM9OFyd8eYkskRZfT
uSYsbMi8SjjSzTIUNclMcPXYgXir9Q1InzpSkMhzLW5iQPiDwB8=
=h56e
-----END PGP SIGNATURE-----

--D/KyDYIMTRn6km9S--

--===============8112980559288411879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8112980559288411879==--
