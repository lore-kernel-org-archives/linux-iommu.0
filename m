Return-Path: <SRS0=hF+p=NZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180BDC433F5
	for <iommu@archiver.kernel.org>; Fri,  3 Sep 2021 15:36:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B877660F92
	for <iommu@archiver.kernel.org>; Fri,  3 Sep 2021 15:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B877660F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79D896157F;
	Fri,  3 Sep 2021 15:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QK1gSTOLw6Vx; Fri,  3 Sep 2021 15:36:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B76706156A;
	Fri,  3 Sep 2021 15:36:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9083BC001A;
	Fri,  3 Sep 2021 15:36:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC42C000E
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 15:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39D3A61570
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 15:36:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 72KYd7z7F4fu for <iommu@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 15:35:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 760F56156A
 for <iommu@lists.linux-foundation.org>; Fri,  3 Sep 2021 15:35:59 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 u15-20020a05600c19cf00b002f6445b8f55so3878128wmq.0
 for <iommu@lists.linux-foundation.org>; Fri, 03 Sep 2021 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3rwR7DXsNx01B6c7f3hOxo+YI2Np5GVLjVCErxzoc/o=;
 b=eZ4/IC/SSC0bII67kGZVWWg1M1XGfHa4mcGiA/F3mTuHwoP6+/hWCfRJvRPTy+ItpK
 sljPAw6QZHXusJ2lXYIuBR510ckTeZKzujM6BOpw9A24n+KqvGAUdY1QAtroJTyAH7uy
 KgQOmDo05kvTn+s+26x1zNKAcmv798gPiB1Wht51di+atki4KBg/RFsaj4E8OgM1Tsiy
 r9rmrzhcKZpplx7OEr0v5Z0wGw2CLv+bMHS90MSh8gTPJVjq5YitmGkWY+L0UGeCbKar
 OqEh5cEiBXJjOBMvidG1Hd556kGzoUTVBVfbOGezXyIIay6wS04mnw69UCvRPxLyTM9+
 iIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3rwR7DXsNx01B6c7f3hOxo+YI2Np5GVLjVCErxzoc/o=;
 b=rJbIELICJahPCRtnb6ngfNz5yDHlei/NfJK3xodXFsAdPI9LxqUXYfXBcz88qWiTzg
 snvcenUaIOng4qr10l3/TIV2Z7tb7rf8BA9+a7pbh0x2luNjhKPwTaI/hqLbpjrzhiST
 Qv9Ef0i3THt6Z/s8tSZjMAFFN5gzX5whbenNdlKL10k6NNMWlDxwawBGNjEj0EWSEcem
 cPTp8CITKqBIxnR/BtxQTfZWRcxRxicR17ki62fCV6Ss2wN5j7emX6uYo/BTd3OBHn9l
 3+ATHvkLK5yHI/dQZvkTqPEXKLObQ5hoZSsEG4fxpM90ja3bykPjOrsguPBq2s71wLIn
 Uwig==
X-Gm-Message-State: AOAM532y82/7ZhuCTau6oc95K7Cp3tnLNs93is96sN6MhjtzfoJ+rUPH
 rZucVsnKx3tTyxCB+Oo/5CM=
X-Google-Smtp-Source: ABdhPJwgST0fv2ehDQUbcqrvrfiHbijSaHuvbl4i+v9CujAS9Rfkb3JhO3uNT2mCAZJ4u0LC2XvPRg==
X-Received: by 2002:a05:600c:4e8b:: with SMTP id
 f11mr963008wmq.165.1630683357420; 
 Fri, 03 Sep 2021 08:35:57 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id c7sm4378018wmq.13.2021.09.03.08.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 08:35:56 -0700 (PDT)
Date: Fri, 3 Sep 2021 17:35:55 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: reserved-memory: Document memory
 region specifier
Message-ID: <YTJA2xARFuNUMgMc@orome.fritz.box>
References: <20210423163234.3651547-2-thierry.reding@gmail.com>
 <20210520220306.GA1976116@robh.at.kernel.org>
 <YLEgXyLBF8PEFNw2@orome.fritz.box>
 <YL+gHN4YZ4vt1vPk@orome.fritz.box>
 <YN4F/nH/9tDuWDnQ@orome.fritz.box>
 <7995b0ed-a277-ced1-b3d0-e0e7e02817a6@gmail.com>
 <YS+Ke4Ip0InHSnHR@orome.fritz.box>
 <CAL_Jsq+TQeb56UbrO1xKFSb1yo0d8U29DPynw3_jQ6gH6Peatw@mail.gmail.com>
 <YTIogpQDJjqJUTkG@orome.fritz.box>
 <CAL_JsqKG4+n_eNj+at3m7WuAbeJ1Kyi0mYD=8-MaVjfhzdPwkA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKG4+n_eNj+at3m7WuAbeJ1Kyi0mYD=8-MaVjfhzdPwkA@mail.gmail.com>
User-Agent: Mutt/2.1.2 (9a92dba0) (2021-08-24)
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 linux-tegra <linux-tegra@vger.kernel.org>, Dmitry Osipenko <digetx@gmail.com>,
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
Content-Type: multipart/mixed; boundary="===============5889013628618262721=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5889013628618262721==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gxF/5PXWXQVZERYl"
Content-Disposition: inline


--gxF/5PXWXQVZERYl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 03, 2021 at 09:36:33AM -0500, Rob Herring wrote:
> On Fri, Sep 3, 2021 at 8:52 AM Thierry Reding <thierry.reding@gmail.com> =
wrote:
> >
> > On Fri, Sep 03, 2021 at 08:20:55AM -0500, Rob Herring wrote:
> > > On Wed, Sep 1, 2021 at 9:13 AM Thierry Reding <thierry.reding@gmail.c=
om> wrote:
> > > >
> > > > On Fri, Jul 02, 2021 at 05:16:25PM +0300, Dmitry Osipenko wrote:
> > > > > 01.07.2021 21:14, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > > > On Tue, Jun 08, 2021 at 06:51:40PM +0200, Thierry Reding wrote:
> > > > > >> On Fri, May 28, 2021 at 06:54:55PM +0200, Thierry Reding wrote:
> > > > > >>> On Thu, May 20, 2021 at 05:03:06PM -0500, Rob Herring wrote:
> > > > > >>>> On Fri, Apr 23, 2021 at 06:32:30PM +0200, Thierry Reding wro=
te:
> > > > > >>>>> From: Thierry Reding <treding@nvidia.com>
> > > > > >>>>>
> > > > > >>>>> Reserved memory region phandle references can be accompanie=
d by a
> > > > > >>>>> specifier that provides additional information about how th=
at specific
> > > > > >>>>> reference should be treated.
> > > > > >>>>>
> > > > > >>>>> One use-case is to mark a memory region as needing an ident=
ity mapping
> > > > > >>>>> in the system's IOMMU for the device that references the re=
gion. This is
> > > > > >>>>> needed for example when the bootloader has set up hardware =
(such as a
> > > > > >>>>> display controller) to actively access a memory region (e.g=
=2E a boot
> > > > > >>>>> splash screen framebuffer) during boot. The operating syste=
m can use the
> > > > > >>>>> identity mapping flag from the specifier to make sure an IO=
MMU identity
> > > > > >>>>> mapping is set up for the framebuffer before IOMMU translat=
ions are
> > > > > >>>>> enabled for the display controller.
> > > > > >>>>>
> > > > > >>>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > > >>>>> ---
> > > > > >>>>>  .../reserved-memory/reserved-memory.txt       | 21 +++++++=
++++++++++++
> > > > > >>>>>  include/dt-bindings/reserved-memory.h         |  8 +++++++
> > > > > >>>>>  2 files changed, 29 insertions(+)
> > > > > >>>>>  create mode 100644 include/dt-bindings/reserved-memory.h
> > > > > >>>>
> > > > > >>>> Sorry for being slow on this. I have 2 concerns.
> > > > > >>>>
> > > > > >>>> First, this creates an ABI issue. A DT with cells in 'memory=
-region'
> > > > > >>>> will not be understood by an existing OS. I'm less concerned=
 about this
> > > > > >>>> if we address that with a stable fix. (Though I'm pretty sur=
e we've
> > > > > >>>> naively added #?-cells in the past ignoring this issue.)
> > > > > >>>
> > > > > >>> A while ago I had proposed adding memory-region*s* as an alte=
rnative
> > > > > >>> name for memory-region to make the naming more consistent wit=
h other
> > > > > >>> types of properties (think clocks, resets, gpios, ...). If we=
 added
> > > > > >>> that, we could easily differentiate between the "legacy" case=
s where
> > > > > >>> no #memory-region-cells was allowed and the new cases where i=
t was.
> > > > > >>>
> > > > > >>>> Second, it could be the bootloader setting up the reserved r=
egion. If a
> > > > > >>>> node already has 'memory-region', then adding more regions i=
s more
> > > > > >>>> complicated compared to adding new properties. And defining =
what each
> > > > > >>>> memory-region entry is or how many in schemas is impossible.
> > > > > >>>
> > > > > >>> It's true that updating the property gets a bit complicated, =
but it's
> > > > > >>> not exactly rocket science. We really just need to splice the=
 array. I
> > > > > >>> have a working implemention for this in U-Boot.
> > > > > >>>
> > > > > >>> For what it's worth, we could run into the same issue with an=
y new
> > > > > >>> property that we add. Even if we renamed this to iommu-memory=
-region,
> > > > > >>> it's still possible that a bootloader may have to update this=
 property
> > > > > >>> if it already exists (it could be hard-coded in DT, or it cou=
ld have
> > > > > >>> been added by some earlier bootloader or firmware).
> > > > > >>>
> > > > > >>>> Both could be addressed with a new property. Perhaps somethi=
ng like
> > > > > >>>> 'iommu-memory-region =3D <&phandle>;'. I think the 'iommu' p=
refix is
> > > > > >>>> appropriate given this is entirely because of the IOMMU bein=
g in the
> > > > > >>>> mix. I might feel differently if we had other uses for cells=
, but I
> > > > > >>>> don't really see it in this case.
> > > > > >>>
> > > > > >>> I'm afraid that down the road we'll end up with other cases a=
nd then we
> > > > > >>> might proliferate a number of *-memory-region properties with=
 varying
> > > > > >>> prefixes.
> > > > > >>>
> > > > > >>> I am aware of one other case where we might need something li=
ke this: on
> > > > > >>> some Tegra SoCs we have audio processors that will access mem=
ory buffers
> > > > > >>> using a DMA engine. These processors are booted from early fi=
rmware
> > > > > >>> using firmware from system memory. In order to avoid trashing=
 the
> > > > > >>> firmware, we need to reserve memory. We can do this using res=
erved
> > > > > >>> memory nodes. However, the audio DMA engine also uses the SMM=
U, so we
> > > > > >>> need to make sure that the firmware memory is marked as reser=
ved within
> > > > > >>> the SMMU. This is similar to the identity mapping case, but n=
ot exactly
> > > > > >>> the same. Instead of creating a 1:1 mapping, we just want tha=
t IOVA
> > > > > >>> region to be reserved (i.e. IOMMU_RESV_RESERVED instead of
> > > > > >>> IOMMU_RESV_DIRECT{,_RELAXABLE}).
> > > > > >>>
> > > > > >>> That would also fall into the IOMMU domain, but we can't reus=
e the
> > > > > >>> iommu-memory-region property for that because then we don't h=
ave enough
> > > > > >>> information to decide which type of reservation we need.
> > > > > >>>
> > > > > >>> We could obviously make iommu-memory-region take a specifier,=
 but we
> > > > > >>> could just as well use memory-regions in that case since we h=
ave
> > > > > >>> something more generic anyway.
> > > > > >>>
> > > > > >>> With the #memory-region-cells proposal, we can easily extend =
the cell in
> > > > > >>> the specifier with an additional MEMORY_REGION_IOMMU_RESERVE =
flag to
> > > > > >>> take that other use case into account. If we than also change=
 to the new
> > > > > >>> memory-regions property name, we avoid the ABI issue (and we =
gain a bit
> > > > > >>> of consistency while at it).
> > > > > >>
> > > > > >> Ping? Rob, do you want me to add this second use-case to the p=
atch
> > > > > >> series to make it more obvious that this isn't just a one-off =
thing? Or
> > > > > >> how do we proceed?
> > > > > >
> > > > > > Rob, given that additional use-case, do you want me to run with=
 this
> > > > > > proposal and send out an updated series?
> > > > >
> > > > >
> > > > > What about variant with a "descriptor" properties that will descr=
ibe
> > > > > each region:
> > > > >
> > > > > fb_desc: display-framebuffer-memory-descriptor {
> > > > >       needs-identity-mapping;
> > > > > }
> > > > >
> > > > > display@52400000 {
> > > > >       memory-region =3D <&fb ...>;
> > > > >       memory-region-descriptor =3D <&fb_desc ...>;
> > > > > };
> > > > >
> > > > > It could be a more flexible/extendible variant.
> > > >
> > > > This problem recently came up on #dri-devel again. Adding Alyssa and
> > > > Sven who are facing a similar challenge on their work on Apple M1 (=
if I
> > > > understood correctly). Also adding dri-devel for visibility since t=
his
> > > > is a very common problem for display in particular.
> > > >
> > > > On M1 the situation is slightly more complicated: the firmware will
> > > > allocate a couple of buffers (including the framebuffer) in high me=
mory
> > > > (> 4 GiB) and use the IOMMU to map that into an IOVA region below 4=
 GiB
> > > > so that the display hardware can access it. This makes it impossibl=
e to
> > > > bypass the IOMMU like we do on other chips (in particular to work a=
round
> > > > the fault-by-default policy of the ARM SMMU driver). It also means =
that
> > > > in addition to the simple reserved regions I mentioned we need for =
audio
> > > > use-cases and identity mapping use-cases we need for display on Teg=
ra,
> > > > we now also need to be able to convey physical to IOVA mappings.
> > > >
> > > > Fitting the latter into the original proposal sounds difficult. A q=
uick
> > > > fix would've been to generate a mapping table in memory and pass th=
at to
> > > > the kernel using a reserved-memory node (similar to what's done for
> > > > example on Tegra for the EMC frequency table on Tegra210) and mark =
it as
> > > > such using a special flag. But that then involves two layers of par=
sing,
> > > > which seems a bit suboptimal. Another way to shoehorn that into the
> > > > original proposal would've been to add flags for physical and virtu=
al
> > > > address regions and use pairs to pass them using special flags. Aga=
in,
> > > > this is a bit wonky because it needs these to be carefully parsed a=
nd
> > > > matched up.
> > > >
> > > > Another downside is that we now have a situation where some of these
> > > > regions are no longer "reserved-memory regions" in the traditional
> > > > sense. This would require an additional flag in the reserved-memory
> > > > region nodes to prevent the IOVA regions from being reserved. By the
> > > > way, this is something that would also be needed for the audio use-=
case
> > > > I mentioned before, because the physical memory at that address can
> > > > still be used by an operating system.
> > > >
> > > > A more general solution would be to draw a bit from Dmitry's propos=
al
> > > > and introduce a new top-level "iov-reserved-memory" node. This coul=
d be
> > > > modelled on the existing reserved-memory node, except that the phys=
ical
> > > > memory pages for regions represented by child nodes would not be ma=
rked
> > > > as reserved. Only the IOVA range described by the region would be
> > > > reserved subsequently by the IOMMU framework and/or IOMMU driver.
> > > >
> > > > The simplest case where we just want to reserve some IOVA region co=
uld
> > > > then be done like this:
> > > >
> > > >         iov-reserved-memory {
> > > >                 /*
> > > >                  * Probably safest to default to <2>, <2> here given
> > > >                  * that most IOMMUs support either > 32 bits of IAS
> > > >                  * or OAS.
> > > >                  */
> > > >                 #address-cells =3D <2>;
> > > >                 #size-cells =3D <2>;
> > > >
> > > >                 firmware: firmware@80000000 {
> > > >                         reg =3D <0 0x80000000 0 0x01000000>;
> > > >                 };
> > > >         };
> > > >
> > > >         audio@30000000 {
> > > >                 ...
> > > >                 iov-memory-regions =3D <&firmware>;
> > > >                 ...
> > > >         };
> > > >
> > > > Mappings could be represented by an IOV reserved region taking a
> > > > reference to the reserved-region that they map:
> > > >
> > > >         reserved-memory {
> > > >                 #address-cells =3D <2>;
> > > >                 #size-cells =3D <2>;
> > > >
> > > >                 /* 16 MiB of framebuffer at top-of-memory */
> > > >                 framebuffer: framebuffer@1,ff000000 {
> > > >                         reg =3D <0x1 0xff000000 0 0x01000000>;
> > > >                         no-map;
> > > >                 };
> > > >         };
> > > >
> > > >         iov-reserved-memory {
> > > >                 /* IOMMU supports only 32-bit output address space =
*/
> > > >                 #address-cells =3D <1>;
> > > >                 #size-cells =3D <1>;
> > > >
> > > >                 /* 16 MiB of framebuffer mapped to top of IOVA */
> > > >                 fb: fb@ff000000 {
> > > >                         reg =3D <0 0xff000000 0 0x01000000>;
> > > >                         memory-region =3D <&framebuffer>;
> > > >                 };
> > > >         };
> > > >
> > > >         display@40000000 {
> > > >                 ...
> > > >                 /* optional? */
> > > >                 memory-region =3D <&framebuffer>;
> > > >                 iov-memory-regions =3D <&fb>;
> > > >                 ...
> > > >         };
> > > >
> > > > It's interesting how identity mapped regions now become a trivial
> > > > special case of mappings. All that is needed is to make the reg pro=
perty
> > > > of the IOV reserved region correspond to the reg property of the no=
rmal
> > > > reserved region. Alternatively, as a small optimization for lazy pe=
ople
> > > > like me, we could just allow these cases to omit the reg property a=
nd
> > > > instead inherit it from the referenced reserved region.
> > > >
> > > > As the second example shows it might be convenient if memory-region
> > > > could be derived from iov-memory-regions. This could be useful for =
cases
> > > > where the driver wants to do something with the physical pages of t=
he
> > > > reserved region (such as mapping them and copying out the framebuff=
er
> > > > data to another buffer so that the reserved memory can be recycled)=
=2E If
> > > > we have the IOV reserved region, we could provide an API to extract=
 the
> > > > physical reserved region (if it exists). That way we could avoid
> > > > referencing it twice in DT. Then again, there's something elegant a=
bout
> > > > the explicit second reference to. It indicates the intent that we m=
ay
> > > > want to use the region for something other than just the IOV mappin=
g.
> > > >
> > > > Anyway, this has been long enough. Let me know what you think. Alys=
sa,
> > > > Sven, it'd be interesting to hear if you think this could work as a
> > > > solution to the problem on M1.
> > > >
> > > > Rob, I think you might like this alternative because it basically g=
ets
> > > > rid of all the points in the original proposal that you were concer=
ned
> > > > about. Let me know what you think.
> > >
> > > Couldn't we keep this all in /reserved-memory? Just add an iova
> > > version of reg. Perhaps abuse 'assigned-address' for this purpose. The
> > > issue I see would be handling reserved iova areas without a physical
> > > area. That can be handled with just a iova and no reg. We already have
> > > a no reg case.
> >
> > I had thought about that initially. One thing I'm worried about is that
> > every child node in /reserved-memory will effectively cause the memory
> > that it described to be reserved. But we don't want that for regions
> > that are "virtual only" (i.e. IOMMU reservations).
>=20
> By virtual only, you mean no physical mapping, just a region of
> virtual space, right? For that we'd have no 'reg' and therefore no
> (physical) reservation by the OS. It's similar to non-static regions.
> You need a specific handler for them. We'd probably want a compatible
> as well for these virtual reservations.

Yeah, these would be purely used for reserving regions in the IOVA so
that they won't be used by the IOVA allocator. Typically these would be
used for cases where those addresses have some special meaning.

Do we want something like:

	compatible =3D "iommu-reserved";

for these? Or would that need to be:

	compatible =3D "linux,iommu-reserved";

? There seems to be a mix of vendor-prefix vs. non-vendor-prefix
compatible strings in the reserved-memory DT bindings directory.

On the other hand, do we actually need the compatible string? Because we
don't really want to associate much extra information with this like we
do for example with "shared-dma-pool". The logic to handle this would
all be within the IOMMU framework. All we really need is for the
standard reservation code to skip nodes that don't have a reg property
so we don't reserve memory for "virtual-only" allocations.

> Are these being global in DT going to be a problem? Presumably we have
> a virtual space per IOMMU. We'd know which IOMMU based on a device's
> 'iommus' and 'memory-region' properties, but within /reserved-memory
> we wouldn't be able to distinguish overlapping addresses from separate
> address spaces. Or we could have 2 different IOVAs for 1 physical
> space. That could be solved with something like this:
>=20
> iommu-addresses =3D <&iommu1 <address cells> <size cells>>;

The only case that would be problematic would be if we have overlapping
physical regions, because that will probably trip up the standard code.

But this could also be worked around by looking at iommu-addresses. For
example, if we had something like this:

	reserved-memory {
		fb_dc0: fb@80000000 {
			reg =3D <0x80000000 0x01000000>;
			iommu-addresses =3D <0xa0000000 0x01000000>;
		};

		fb_dc1: fb@80000000 {
			reg =3D <0x80000000 0x01000000>;
			iommu-addresses =3D <0xb0000000 0x01000000>;
		};
	};

We could make the code identify that this is for the same physical
reservation (maybe make it so that reg needs to match exactly for this
to be recognized) but with different virtual allocations.

On a side-note: do we really need to repeat the size? I'd think if we
want mappings then we'd likely want them for the whole reservation.

I'd like to keep references to IOMMUs out of this because they would be
duplicated. We will only use these nodes if they are referenced by a
device node that also has an iommus property. Also, the IOMMU reference
itself isn't enough. We'd also need to support the complete specifier
because you can have things like SIDs in there to specify the exact
address space that a device uses.

Also, for some of these they may be reused independently of the IOMMU
address space. For example the Tegra framebuffer identity mapping can
be used by either of the 2-4 display controllers, each with (at least
potentially) their own address space. But we don't want to have to
describe the identity mapping separately for each display controller.

Another thing to consider is that these nodes will often be added by
firmware (e.g. firmware will allocate the framebuffer and set up the
corresponding reserved memory region in DT). Wiring up references like
this would get very complicated very quickly.

> Or the other way to do this is reuse 'iommus' property to define the
> mapping of each address entry to iommu.
>=20
> > Obviously we can fix that in Linux, but what about other operating
> > systems? Currently "reg" is a required property for statically allocated
> > regions (which all of these would be). Do you have an idea of how widely
> > that's used? What about other OSes, or bootloaders, what if they
> > encounter these nodes that don't have a "reg" property?
>=20
> Without 'reg', there must be a compatible that the client understands
> or the node should be ignored.
>=20
> My suspicion is that /reserved-memory is abused for all sorts of
> things downstream, but that's not really relevant here.

Yeah, my only concern was that we might break users of this that are not
sophisticated enough to handle the nuances that we'd introduce here. If
we can assume that nodes without a reg property will be ignored, then I
think that's good enough.

Thierry

--gxF/5PXWXQVZERYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmEyQNgACgkQ3SOs138+
s6HrJw//SxELmd8OPGHKl492Jr/RcWzB0CE8gaNddsnJQQQ+CvfMD89Hr8RUl8RV
KOT8jLjM46/fx8yeRXAE4xfLiA6vk/heyjYg1q7j2FyTnfmzZloSvUS8znvfcJTw
jjLv68F24pQxpuHpXP1schoNg5HCxFj/nNvewnzeSaZMuraXEuSnhYW+fYa92MBR
QeVjT99math6Z+YnuRIkStNADY6H06e3ljDZUScvLKFuhtjxGu5EKaI4L6Y2+w5K
urQluACZnS0y2810z9QsWDA88gWRiyYGiNTJHKGV5HAHzSjw5D5QXBv3q5embwxN
fcm+boda5jg2RNIujNdghYWEpuh2uVzWAXzioPEa9ausuUdiqH36mEsfQtXA6erE
s7gCz73L8jCdU27ICkcl5wRyY0l+dwooO3E6Fnh+B6mRAnOHrtv9iYLm9scgiDYk
GII53Hu9Q42yH6a10Zwe2PWU9hcTfco2nkwAvRZsnJSU5wu002bHF2rcJnBkuq5e
eWrz+HFXKgP5IvYv0ltyKPlpztuPgv06X+n+z4Ha7QgLen6HGSobVof/IOSfOAOD
qHVc/934wXUqc5qm8wFHzP60/RJKN9hL4MPP1SNhyZC9CXbdz3WR0ggguLP+rotv
hvuWLa0CLw6KVG8Dq8f1/cAmuk8ejVVB7hMfbnheYl2f2gUxz/0=
=OsO0
-----END PGP SIGNATURE-----

--gxF/5PXWXQVZERYl--

--===============5889013628618262721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5889013628618262721==--
