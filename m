Return-Path: <SRS0=TI1w=FX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE07C4361B
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D8923BA9
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D8923BA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A9C9487AB4;
	Sat, 19 Dec 2020 00:49:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HhP0FDY1XSyl; Sat, 19 Dec 2020 00:49:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B49D87AB0;
	Sat, 19 Dec 2020 00:49:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C2D7C1787;
	Sat, 19 Dec 2020 00:49:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D395C0893
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 00:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 90B6F2E370
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 00:49:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nIrnPcGvoi6l for <iommu@lists.linux-foundation.org>;
 Sat, 19 Dec 2020 00:49:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 42CF12E36C
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 00:49:41 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id a12so4516814wrv.8
 for <iommu@lists.linux-foundation.org>; Fri, 18 Dec 2020 16:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=W9Mc2/GWr5kkacTx+E1IeeZWXaRdR++vErt47n1SNLg=;
 b=R+eqDby12/uJchHoxQosFb5oJxQ2lSj/i1TzYOX5VbClXGst/neR+OQpjuLe8VyZZB
 vc9Lt1i9UYSEbVx8IfI33Zv0KDFP4UPnt12CIZ54lxXxgrQKLl+VwWub3W6JGfcoTIsm
 kRotQJJ+/6TbT5HErQsKDOj1wJHBOfloZYh5y3jiXwfg/CElKxhqlZjtyjkooGrDxQSM
 BtWy17cXfLQgrBbtYVv+9eP5lfB4pMmb3AfRtbNvWgeFVIpoRaS3wFWaAKY6SR+dPT7i
 FMPabhjVOA3Zv5IR2+6CvRFOaXh+763Y/jWtFoLk4BgeliNaZARC6CWbU8YcmET0HOK0
 0BTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=W9Mc2/GWr5kkacTx+E1IeeZWXaRdR++vErt47n1SNLg=;
 b=iU0BL0x+XhBNckUcKFplNFt33qmbbV6bx5N7kMh9XXJZsoBo0P0Gtc9eqPpZSgniQY
 z5p3pBttbXcqCN/eQlha8m/LqS8fJ+Qwz0uA67uPm0GvgKjxb9If1rgutghB05KBaj2j
 t7B+6PiHQ1djMzi/9Eg3XsI4tyQ+EJbFNqV3W/bM160o5nVVfN3kslzlve22EQkB0ANO
 +VdnInd/XEKGkPGya0queLEX7xa12XX6V6eIE1mekvmqQqY+VrCUo9f1EOWqhoP6GqzD
 gMpq7ziYWtkngdnOVbMH1GMzrh7Qc52rX0k5wJTnHHxbvD2P4rDOfbqHa37qxvuzzw23
 DEvw==
X-Gm-Message-State: AOAM531e7zyuMb8/NCN2//vMBcc4jwXPnHIKVhO2r4YDyzqfQ6hJq6UO
 7PoeOke5IDlQDs1zd1Ur9pc=
X-Google-Smtp-Source: ABdhPJxeD9vRRRca3FcRcncNHLe5uRoBC9d/tFdNehA6hp4a47LRwjpF9WUxym9CR2X0N2wyOB2skg==
X-Received: by 2002:adf:ba46:: with SMTP id t6mr7068877wrg.168.1608338979318; 
 Fri, 18 Dec 2020 16:49:39 -0800 (PST)
Received: from localhost (pd9e5183e.dip0.t-ipconnect.de. [217.229.24.62])
 by smtp.gmail.com with ESMTPSA id j10sm15212978wmj.7.2020.12.18.16.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Dec 2020 16:49:37 -0800 (PST)
Date: Sat, 19 Dec 2020 01:49:36 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <X91OIMAROsbl2xT1@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <20200914220829.GA330122@bogus> <20200915123648.GA3496938@ulmo>
 <20200924112725.GA2486709@ulmo> <20201105164312.GD485884@ulmo>
 <483cd043-980e-81fb-cccb-385206a699df@arm.com>
 <20201106152548.GA767203@ulmo> <20201110193309.GB2303484@ulmo>
 <X9tyc3t2MgtiFwwb@ulmo>
 <CAL_JsqJqupMdr8vSWPTpYEGmcjKDqoKjMCYY-BvSLpxzkovx7Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJqupMdr8vSWPTpYEGmcjKDqoKjMCYY-BvSLpxzkovx7Q@mail.gmail.com>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============8514096956249416168=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8514096956249416168==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9MXLSNlP1Ly1uiUS"
Content-Disposition: inline


--9MXLSNlP1Ly1uiUS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 18, 2020 at 04:15:45PM -0600, Rob Herring wrote:
> On Thu, Dec 17, 2020 at 9:00 AM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Tue, Nov 10, 2020 at 08:33:09PM +0100, Thierry Reding wrote:
> > > On Fri, Nov 06, 2020 at 04:25:48PM +0100, Thierry Reding wrote:
> > > > On Thu, Nov 05, 2020 at 05:47:21PM +0000, Robin Murphy wrote:
> > > > > On 2020-11-05 16:43, Thierry Reding wrote:
> > > > > > On Thu, Sep 24, 2020 at 01:27:25PM +0200, Thierry Reding wrote:
> > > > > > > On Tue, Sep 15, 2020 at 02:36:48PM +0200, Thierry Reding wrot=
e:
> > > > > > > > On Mon, Sep 14, 2020 at 04:08:29PM -0600, Rob Herring wrote:
> > > > > > > > > On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding =
wrote:
> > > > > > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > > > > > >
> > > > > > > > > > Reserved memory regions can be marked as "active" if ha=
rdware is
> > > > > > > > > > expected to access the regions during boot and before t=
he operating
> > > > > > > > > > system can take control. One example where this is usef=
ul is for the
> > > > > > > > > > operating system to infer whether the region needs to b=
e identity-
> > > > > > > > > > mapped through an IOMMU.
> > > > > > > > >
> > > > > > > > > I like simple solutions, but this hardly seems adequate t=
o solve the
> > > > > > > > > problem of passing IOMMU setup from bootloader/firmware t=
o the OS. Like
> > > > > > > > > what is the IOVA that's supposed to be used if identity m=
apping is not
> > > > > > > > > used?
> > > > > > > >
> > > > > > > > The assumption here is that if the region is not active the=
re is no need
> > > > > > > > for the IOVA to be specified because the kernel will alloca=
te memory and
> > > > > > > > assign any IOVA of its choosing.
> > > > > > > >
> > > > > > > > Also, note that this is not meant as a way of passing IOMMU=
 setup from
> > > > > > > > the bootloader or firmware to the OS. The purpose of this i=
s to specify
> > > > > > > > that some region of memory is actively being accessed durin=
g boot. The
> > > > > > > > particular case that I'm looking at is where the bootloader=
 set up a
> > > > > > > > splash screen and keeps it on during boot. The bootloader h=
as not set up
> > > > > > > > an IOMMU mapping and the identity mapping serves as a way o=
f keeping the
> > > > > > > > accesses by the display hardware working during the transit=
ional period
> > > > > > > > after the IOMMU translations have been enabled by the kerne=
l but before
> > > > > > > > the kernel display driver has had a chance to set up its ow=
n IOMMU
> > > > > > > > mappings.
> > > > > > > >
> > > > > > > > > If you know enough about the regions to assume identity m=
apping, then
> > > > > > > > > can't you know if active or not?
> > > > > > > >
> > > > > > > > We could alternatively add some property that describes the=
 region as
> > > > > > > > requiring an identity mapping. But note that we can't make =
any
> > > > > > > > assumptions here about the usage of these regions because t=
he IOMMU
> > > > > > > > driver simply has no way of knowing what they are being use=
d for.
> > > > > > > >
> > > > > > > > Some additional information is required in device tree for =
the IOMMU
> > > > > > > > driver to be able to make that decision.
> > > > > > >
> > > > > > > Rob, can you provide any hints on exactly how you want to mov=
e this
> > > > > > > forward? I don't know in what direction you'd like to proceed.
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > do you have any suggestions on how to proceed with this? I'd li=
ke to get
> > > > > > this moving again because it's something that's been nagging me=
 for some
> > > > > > months now. It also requires changes across two levels in the b=
ootloader
> > > > > > stack as well as Linux and it takes quite a bit of work to make=
 all the
> > > > > > changes, so before I go and rewrite everything I'd like to get =
the DT
> > > > > > bindings sorted out first.
> > > > > >
> > > > > > So just to summarize why I think this simple solution is good e=
nough: it
> > > > > > tries to solve a very narrow and simple problem. This is not an=
 attempt
> > > > > > at describing the firmware's full IOMMU setup to the kernel. In=
 fact, it
> > > > > > is primarily targetted at cases where the firmware hasn't setup=
 an IOMMU
> > > > > > at all, and we just want to make sure that when the kernel take=
s over
> > > > > > and does want to enable the IOMMU, that all the regions that are
> > > > > > actively being accessed by non-quiesced hardware (the most typi=
cal
> > > > > > example would be a framebuffer scanning out a splat screen or a=
nimation,
> > > > > > but it could equally well be some sort of welcoming tone or mus=
ic being
> > > > > > played back) are described in device tree.
> > > > > >
> > > > > > In other words, and this is perhaps better answering your second
> > > > > > question: in addition to describing reserved memory regions, we=
 want to
> > > > > > add a bit of information here about the usage of these memory r=
egions.
> > > > > > Some memory regions may contain information that the kernel may=
 want to
> > > > > > use (such an external memory frequency scaling tables) and thos=
e I would
> > > > > > describe as "inactive" memory because it isn't being accessed by
> > > > > > hardware. The framebuffer in this case is the opposite and it i=
s being
> > > > > > actively accessed (hence it is marked "active") by hardware whi=
le the
> > > > > > kernel is busy setting everything up so that it can reconfigure=
 that
> > > > > > hardware and take over with its own framebuffer (for the consol=
e, for
> > > > > > example). It's also not so much that we know enough about the r=
egion to
> > > > > > assume it needs identity mapping. We don't really care about th=
at from
> > > > > > the DT point of view. In fact, depending on the rest of the sys=
tem
> > > > > > configuration, we may not need identity mapping (i.e. if none o=
f the
> > > > > > users of the reserved memory region are behind an IOMMU). But t=
he point
> > > > > > here is that the IOMMU drivers can use this "active" property to
> > > > > > determine that if a device is using an "active" region and it i=
s behind
> > > > > > an IOMMU, then it must identity map that region in order for the
> > > > > > hardware, which is not under the kernel's control yet, to be ab=
le to
> > > > > > continue to access that memory through an IOMMU mapping.
> > > > >
> > > > > Hmm, "active" is not a property of the memory itself, though, it'=
s really a
> > > > > property of the device accessing it. If several distinct devices =
share a
> > > > > carveout region, and for simplicity the bootloader marks it as ac=
tive
> > > > > because one of those devices happens to be using some part of it =
at boot, we
> > > > > don't really want to have to do all the reserved region setup for=
 all the
> > > > > other devices unnecessarily, when all that matters is not disrupt=
ing one of
> > > > > them when resetting the IOMMU.
> > > > >
> > > > > That leads to another possible hiccup - some bindings already hav=
e a defined
> > > > > meaning for a "memory-region" property. If we use that to point t=
o some
> > > > > small region for a temporary low-resolution bootsplash screen for=
 visibility
> > > > > to an IOMMU driver, the device's own driver might also interpret =
it as a
> > > > > private carveout from which it is expected to allocate everything=
, and thus
> > > > > could end up failing to work well or at all.
> > > > >
> > > > > I agree that we should only need a relatively simple binding, and=
 that
> > > > > piggybacking off reserved-memory nodes seems like an ideal way of=
 getting
> > > > > address range descriptions without too much extra complexity; the=
 tricky
> > > > > part is how best to associate those with the other information ne=
eded, which
> > > > > is really the "iommus" property of the relevant device, and how t=
o make it
> > > > > as generically discoverable as possible. Perhaps it might be work=
able to
> > > > > follow almost the same approach but with a dedicated property (e.=
g.
> > > > > "active-memory-region") that the IOMMU code can simply scan the D=
T for to
> > > > > determine relevant device nodes. Otherwise properties on the IOMM=
U node
> > > > > itself would seem the next most practical option.
> > > >
> > > > We did recently introduce a "memory-region-names" property that's u=
sed
> > > > to add context for cases where multiple memory regions are used. Pe=
rhaps
> > > > the simplest to address the above would be to describe the region as
> > > > active by naming it "active". That has the disadvantage of restrict=
ing
> > > > the number of active regions to 1, though I suspect that may even be
> > > > enough for the vast majority of cases where we need this. This woul=
d be
> > > > similar to how we use the "dma-mem" string in the "interconnect-nam=
es"
> > > > property to specify the "DMA parent" of a device node.
> > > >
> > > > Alternatively, we could perhaps support multiple occurrences of "ac=
tive"
> > > > in the "memory-region-names" property. Or we could add a bit of
> > > > flexibility by considering all memory regions whose names have an
> > > > "active-" prefix as being active.
> > > >
> > > > > We've also finally got things going on the IORT RMR side[1], whic=
h helps add
> > > > > a bit more shape to things too; beyond the actual firmware parsin=
g, DT and
> > > > > ACPI systems should definitely be converging on the same internal
> > > > > implementation in the IOMMU layer.
> > > >
> > > > Yeah, from a quick look at that series, this actually sounds really
> > > > close to what I'm trying to achieve here.
> > > >
> > > > The patch set that I have would nicely complement the code added to
> > > > iommu_dma_get_resv_regions() for RMR regions. It's not exactly the =
same
> > > > code, but it's basically the DT equivalent of
> > > > iort_dev_rmr_get_resv_regions().
> > >
> > > Hi Rob,
> > >
> > > what's your preference here for DT bindings? Do you want me to reuse =
the
> > > existing memory-region/memory-region-names properties, or do you want
> > > something completely separate?
>=20
> I think that's overloading memory-region-names as *-names is a name
> local to a binding to augment an index.
>=20
> >
> > Hi Rob,
> >
> > I've been thinking about this some more and I think I've come up with an
> > alternative that I think you might like better than what we discussed so
> > far.
> >
> > Rather than reusing memory-region-names and guessing from the name what
> > the intended purpose was, how about we add the concept of memory region
> > specifiers to describe additional properties of reserved memory regions
> > uses? This would allow us to address Robin's concerns about describing
> > what's essentially a device property within the reserved memory region.
> >
> > The way I imagine that this would work is that the reserved memory
> > regions would gain a new property, "#memory-region-cells", that defines
> > the number of cells that make up a reserved memory region specifier,
> > much like we have #clock-cells, #reset-cells, #pwm-cells, etc. Since
> > these specifier are defined where the regions are used, they would allow
> > us to encode information about that specific use, rather than properties
> > of the regions themselves.
> >
> > This should also allow for backwards-compatibility where a missing
> > #memory-region-cells would be interpreted as 0 specifier (i.e. no
> > additional data).
> >
> > Here's how this would look for the specific example that I want to
> > solve:
> >
> >         #define MEMORY_REGION_ACTIVE 0x1
> >
> >         / {
> >                 reserved-memory {
> >                         lut: lookup-table@96060000 {
> >                                 reg =3D <0x96060000 0x00010000>;
> >                                 #memory-region-cells =3D <1>;
> >                         };
> >
> >                         fbc: framebuffer@96070000 {
> >                                 reg =3D <0x96070000 0x800000>;
> >                                 #memory-region-cells =3D <1>;
> >                         };
> >                 };
> >
> >                 ...
> >
> >                 host1x@50000000 {
> >                         ...
> >
> >                         display@54200000 {
> >                                 ...
> >                                 memory-regions =3D <&fbc MEMORY_REGION_=
ACTIVE>,
> >                                                  <&lut MEMORY_REGION_AC=
TIVE>;
> >                                 ...
> >                         };
> >
> >                         ...
> >                 };
> >         };
> >
> > As you can see, the reserved memory region nodes only contain properties
> > that are immediately related to the regions themselves, whereas the
> > "active" attribute now applies only for the specific use of the region
> > within display@54200000.
> >
> > What do you think?
>=20
> When would these regions ever not be active? Isn't just the fact that
> you have the 'memory-regions' property enough to know that they are
> active (possibly combined with seeing the display h/w is already
> enabled)? I guess if the idea is to parse 'memory-regions' for the
> whole DT and find the active ones, you'd need the flag (and presumably
> an 'iommus' property too).

The memory-region property can also be used to provide reserved regions
of memory for a device to use. This could be a special carveout to make
sure the device doesn't run out of physical memory to allocate from as
regular CMA fragments, for example.

Or it could be some special block of memory that a device has to use.

The difference here is that the "active" memory region in this case is
actively being used while the device is booting, which isn't necessarily
the norm for reserved memory regions.

So this is kind of like "regulator-boot-on" but for display controllers
and memory regions.

The reason why we want this defined as part of the device tree is
because this information is needed at a point very early in the boot
process where no display driver has been loaded yet, so it's unknown
whether the display controller is enabled or not. Furthermore, the SMMU
driver needs this information, so it needs to be a somewhat standard DT
binding so that it can be parsed generically because there is no device
specific driver in play at the time.

> Do you have a usecase for this outside of the display enabled by
> bootloader? Because we already have the simple-framebuffer binding of
> which the memory region is just part of it. Wouldn't the presence of a
> memory region there imply it's active as well?

I don't know of a use-case other than display where this is needed right
now. However, I could imagine that something similar could be happening
for audio where a mobile device would be playing some welcome sound or
music in a loop during boot.

I don't think simple-framebuffer would work in this case either because
it usually doesn't contain the iommus property. But even if we made that
part of simple-framebuffer, it'd mean that the SMMU driver would have to
special-case depending on the simple-framebuffer compatible string, and
potentially any future similar bindings for other use-cases.

> Or maybe the iommu node(s) should just have a 'memory-regions' property?

I don't think that's enough information. We need to know for which
device this memory region is active so that it can be mapped for the
correct address space.

Thierry

--9MXLSNlP1Ly1uiUS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/dTh4ACgkQ3SOs138+
s6EDZQ//amoCkY1jKpjdW5legpDgVC1RI9KlPBwlCHGGiXM3nCiudAq3cT4/0MLq
dFVr6zatri9fAVC43uFIRClwzDSMgZlA6MR3P/Ng6L5DCr+mCdJYuXAHmmkpfqeu
BuBP4DWDfl2Cawfe+SUsche8GA2+yDAVSs2DJSF3yhviBeks87++MlrxdDvvPKY1
8lXro2Lrp+/XkoxdmEDiGMW8NP4+cSuO04ec4zfK0uCSlWbc9FDe71ZhwqeYrzDd
9XIwzlNSINuR4XE2QalNt10OMLTUOlr7t8+LwXPY3DDKKc4MRq7Q6Y+e66Z4PQOL
mQ0L8F9StrzpF/Dg7H0ss+udx/KY2wL2ViOXzWpZIUH43B+r89n3MHz11gG/7DUc
Z0OakJY47gnBrx6pSEsRHS7UafiDR+5jJjV8NC/4+qc5c9yz820EicCJu9FU0WW3
jWB/RQWuVPKQP3Y5WpMfOau82Pd2fClQFYi71Vk+d71Dur/1gJwgTPxAcg7JsIjF
KYROOAVHbo3PPs73WfKsyKZZgcptHMQxxu7dwF+XMK/kyMdJrbbhyswedFukiljy
8Sm+b90M+U4UIos632AMXuATEIkJcjzBCEJBsgJ/E9vt8Sg5UDzFPMOv0P8rZf03
ug1lkhX+3BbXd4JIviVKKe7ji4fCHMACwr6g6geSJZta366o4pA=
=Slcq
-----END PGP SIGNATURE-----

--9MXLSNlP1Ly1uiUS--

--===============8514096956249416168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8514096956249416168==--
