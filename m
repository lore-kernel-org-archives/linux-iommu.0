Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41F1C55ABD
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 19:33:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C45620678
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 19:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG8rarOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C45620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1DB0587202;
	Tue, 10 Nov 2020 19:33:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PRmZ2UCYhm7Q; Tue, 10 Nov 2020 19:33:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4AF0A870EF;
	Tue, 10 Nov 2020 19:33:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07168C088B;
	Tue, 10 Nov 2020 19:33:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12C15C016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 19:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EAD8C86410
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 19:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vWCFc92YIkYL for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 19:33:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7EF8486193
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 19:33:14 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id 19so2813169wmf.1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 11:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5mMVQMlAu/av9/BrtsRhGFbb3lLOqH9OnWPD2qStzFE=;
 b=bG8rarOe+fIadMkmq88JbIQRCyaAQwg/ZL4t/ZmDMnvQcARZdR/PLrPaxmgUmRaq3N
 tYdIwoOgsX3edTExlQdUzUi7OZz++ePMJXY3HBnIp1N/cyy/HgVkuUzIpGcRwQ/ROM5P
 OrAvxwG729nxrXk7oaBkISLjbz3RwufurLsuTF5qJ3K2hVHf5KuYcSZ91bHufCFV0f4R
 kNbez7y0WhYVO2b/5J3w1yCNyukUiB4DbpqAY2WSVgi7fbMhx5h82wpvoU0JvwZG6C77
 5CqAKIbS71SmPkfrtXxhcWVuu4bKxkftjrzrLxkPxRLzDiwAjsrk9HcFxqwDMvSlUu2Z
 PZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5mMVQMlAu/av9/BrtsRhGFbb3lLOqH9OnWPD2qStzFE=;
 b=X+b69mZaTjuyItRbs0I6xJHSUKlwnFc7fXkEE+3Xh02ar//IfmBsV3jc9bMdYftYm4
 QUnuDxUx4a9VihCIuHWGo4lRRswFnBF42UBeRsEq0qXU215y3ebpTU34HcqhmXDLYFRi
 4QFTtHQboHAJ3eg7ITim9o4VX582Od9tU2gfKu1iPp1e66vV2CszYNGuzIu7ve9AJGli
 A+qAMvfpwnamRp0obVsHYScV+kOETU2KYseGAhaTesMXZ4lJipVKr/Di/HPKAVciCbvo
 Es4k1OMHiTu+z6sw7QIp6XfYjJV23Mfo17nHLWWRfogi7hAAFbHbQ18JuXgmLQDn+olk
 Y/cQ==
X-Gm-Message-State: AOAM530Z0VfISs9+cEugVtOLjTJEfN1ZuSBJPJ2O+7U6hRjF/lpLVCls
 UT4bFIwVmsARnv2aL+/BdbU=
X-Google-Smtp-Source: ABdhPJw8jRGgBClN8UTnXmSnwJiFZ4TrYZIrC9+vZDi0VZDkM9In93jw/P2bqEsSvo0aLZsQfEb4HA==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr746440wmh.46.1605036792714;
 Tue, 10 Nov 2020 11:33:12 -0800 (PST)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id s13sm417213wrv.43.2020.11.10.11.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:33:11 -0800 (PST)
Date: Tue, 10 Nov 2020 20:33:09 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20201110193309.GB2303484@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <20200914220829.GA330122@bogus> <20200915123648.GA3496938@ulmo>
 <20200924112725.GA2486709@ulmo> <20201105164312.GD485884@ulmo>
 <483cd043-980e-81fb-cccb-385206a699df@arm.com>
 <20201106152548.GA767203@ulmo>
MIME-Version: 1.0
In-Reply-To: <20201106152548.GA767203@ulmo>
User-Agent: Mutt/1.14.7 (2020-08-29)
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
Content-Type: multipart/mixed; boundary="===============0417448285946382511=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0417448285946382511==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 04:25:48PM +0100, Thierry Reding wrote:
> On Thu, Nov 05, 2020 at 05:47:21PM +0000, Robin Murphy wrote:
> > On 2020-11-05 16:43, Thierry Reding wrote:
> > > On Thu, Sep 24, 2020 at 01:27:25PM +0200, Thierry Reding wrote:
> > > > On Tue, Sep 15, 2020 at 02:36:48PM +0200, Thierry Reding wrote:
> > > > > On Mon, Sep 14, 2020 at 04:08:29PM -0600, Rob Herring wrote:
> > > > > > On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrote:
> > > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > > >=20
> > > > > > > Reserved memory regions can be marked as "active" if hardware=
 is
> > > > > > > expected to access the regions during boot and before the ope=
rating
> > > > > > > system can take control. One example where this is useful is =
for the
> > > > > > > operating system to infer whether the region needs to be iden=
tity-
> > > > > > > mapped through an IOMMU.
> > > > > >=20
> > > > > > I like simple solutions, but this hardly seems adequate to solv=
e the
> > > > > > problem of passing IOMMU setup from bootloader/firmware to the =
OS. Like
> > > > > > what is the IOVA that's supposed to be used if identity mapping=
 is not
> > > > > > used?
> > > > >=20
> > > > > The assumption here is that if the region is not active there is =
no need
> > > > > for the IOVA to be specified because the kernel will allocate mem=
ory and
> > > > > assign any IOVA of its choosing.
> > > > >=20
> > > > > Also, note that this is not meant as a way of passing IOMMU setup=
 from
> > > > > the bootloader or firmware to the OS. The purpose of this is to s=
pecify
> > > > > that some region of memory is actively being accessed during boot=
=2E The
> > > > > particular case that I'm looking at is where the bootloader set u=
p a
> > > > > splash screen and keeps it on during boot. The bootloader has not=
 set up
> > > > > an IOMMU mapping and the identity mapping serves as a way of keep=
ing the
> > > > > accesses by the display hardware working during the transitional =
period
> > > > > after the IOMMU translations have been enabled by the kernel but =
before
> > > > > the kernel display driver has had a chance to set up its own IOMMU
> > > > > mappings.
> > > > >=20
> > > > > > If you know enough about the regions to assume identity mapping=
, then
> > > > > > can't you know if active or not?
> > > > >=20
> > > > > We could alternatively add some property that describes the regio=
n as
> > > > > requiring an identity mapping. But note that we can't make any
> > > > > assumptions here about the usage of these regions because the IOM=
MU
> > > > > driver simply has no way of knowing what they are being used for.
> > > > >=20
> > > > > Some additional information is required in device tree for the IO=
MMU
> > > > > driver to be able to make that decision.
> > > >=20
> > > > Rob, can you provide any hints on exactly how you want to move this
> > > > forward? I don't know in what direction you'd like to proceed.
> > >=20
> > > Hi Rob,
> > >=20
> > > do you have any suggestions on how to proceed with this? I'd like to =
get
> > > this moving again because it's something that's been nagging me for s=
ome
> > > months now. It also requires changes across two levels in the bootloa=
der
> > > stack as well as Linux and it takes quite a bit of work to make all t=
he
> > > changes, so before I go and rewrite everything I'd like to get the DT
> > > bindings sorted out first.
> > >=20
> > > So just to summarize why I think this simple solution is good enough:=
 it
> > > tries to solve a very narrow and simple problem. This is not an attem=
pt
> > > at describing the firmware's full IOMMU setup to the kernel. In fact,=
 it
> > > is primarily targetted at cases where the firmware hasn't setup an IO=
MMU
> > > at all, and we just want to make sure that when the kernel takes over
> > > and does want to enable the IOMMU, that all the regions that are
> > > actively being accessed by non-quiesced hardware (the most typical
> > > example would be a framebuffer scanning out a splat screen or animati=
on,
> > > but it could equally well be some sort of welcoming tone or music bei=
ng
> > > played back) are described in device tree.
> > >=20
> > > In other words, and this is perhaps better answering your second
> > > question: in addition to describing reserved memory regions, we want =
to
> > > add a bit of information here about the usage of these memory regions.
> > > Some memory regions may contain information that the kernel may want =
to
> > > use (such an external memory frequency scaling tables) and those I wo=
uld
> > > describe as "inactive" memory because it isn't being accessed by
> > > hardware. The framebuffer in this case is the opposite and it is being
> > > actively accessed (hence it is marked "active") by hardware while the
> > > kernel is busy setting everything up so that it can reconfigure that
> > > hardware and take over with its own framebuffer (for the console, for
> > > example). It's also not so much that we know enough about the region =
to
> > > assume it needs identity mapping. We don't really care about that from
> > > the DT point of view. In fact, depending on the rest of the system
> > > configuration, we may not need identity mapping (i.e. if none of the
> > > users of the reserved memory region are behind an IOMMU). But the poi=
nt
> > > here is that the IOMMU drivers can use this "active" property to
> > > determine that if a device is using an "active" region and it is behi=
nd
> > > an IOMMU, then it must identity map that region in order for the
> > > hardware, which is not under the kernel's control yet, to be able to
> > > continue to access that memory through an IOMMU mapping.
> >=20
> > Hmm, "active" is not a property of the memory itself, though, it's real=
ly a
> > property of the device accessing it. If several distinct devices share a
> > carveout region, and for simplicity the bootloader marks it as active
> > because one of those devices happens to be using some part of it at boo=
t, we
> > don't really want to have to do all the reserved region setup for all t=
he
> > other devices unnecessarily, when all that matters is not disrupting on=
e of
> > them when resetting the IOMMU.
> >=20
> > That leads to another possible hiccup - some bindings already have a de=
fined
> > meaning for a "memory-region" property. If we use that to point to some
> > small region for a temporary low-resolution bootsplash screen for visib=
ility
> > to an IOMMU driver, the device's own driver might also interpret it as a
> > private carveout from which it is expected to allocate everything, and =
thus
> > could end up failing to work well or at all.
> >=20
> > I agree that we should only need a relatively simple binding, and that
> > piggybacking off reserved-memory nodes seems like an ideal way of getti=
ng
> > address range descriptions without too much extra complexity; the tricky
> > part is how best to associate those with the other information needed, =
which
> > is really the "iommus" property of the relevant device, and how to make=
 it
> > as generically discoverable as possible. Perhaps it might be workable to
> > follow almost the same approach but with a dedicated property (e.g.
> > "active-memory-region") that the IOMMU code can simply scan the DT for =
to
> > determine relevant device nodes. Otherwise properties on the IOMMU node
> > itself would seem the next most practical option.
>=20
> We did recently introduce a "memory-region-names" property that's used
> to add context for cases where multiple memory regions are used. Perhaps
> the simplest to address the above would be to describe the region as
> active by naming it "active". That has the disadvantage of restricting
> the number of active regions to 1, though I suspect that may even be
> enough for the vast majority of cases where we need this. This would be
> similar to how we use the "dma-mem" string in the "interconnect-names"
> property to specify the "DMA parent" of a device node.
>=20
> Alternatively, we could perhaps support multiple occurrences of "active"
> in the "memory-region-names" property. Or we could add a bit of
> flexibility by considering all memory regions whose names have an
> "active-" prefix as being active.
>=20
> > We've also finally got things going on the IORT RMR side[1], which help=
s add
> > a bit more shape to things too; beyond the actual firmware parsing, DT =
and
> > ACPI systems should definitely be converging on the same internal
> > implementation in the IOMMU layer.
>=20
> Yeah, from a quick look at that series, this actually sounds really
> close to what I'm trying to achieve here.
>=20
> The patch set that I have would nicely complement the code added to
> iommu_dma_get_resv_regions() for RMR regions. It's not exactly the same
> code, but it's basically the DT equivalent of
> iort_dev_rmr_get_resv_regions().

Hi Rob,

what's your preference here for DT bindings? Do you want me to reuse the
existing memory-region/memory-region-names properties, or do you want
something completely separate?

Thierry

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+q6vMACgkQ3SOs138+
s6HFwA//RvTsH3Razxq0jUpBglouVngfodC8jjeEUJ5gHRLh6ln8d+vkh5Qifz4L
acZrCXFUyPuhnKSg+jzkmvufYkiJ1Z16mGzjnKtV420hoBrLZLFS3SBQORU0MSHj
C1bV32HkFSJAIcECA+p2O71ns0bdmhzh2oIUNwtpCSCL612trtm8gzekvuDW3P5C
WBaRoLQMB9CBfs9r2Xt8xhL9nthQKqr5x8Rj2RMWxYbVJ5BK/Co9ZCd4bVSTO6wi
t0edy969cP3ShmKF5vsGufahoVFrsDh/XkvFvCw9fc+KDK7BK855c/E1jIn2DDlE
ZCPvRQfRImVvWr6uj3CMBaZ4aQAFB+aO8f13fXQ+0fdNLT2X7S8hcjFyNlu3GBKr
bKWOhdeDQ8LCvbLwzqndqz3yfR/3dNmTPLhs4Ebw7oiw7cUehnRoqow8uLlXqyD3
/iQJ88P/gutRxgRyin2By+jztGMcxHbvhxmmKM7IJTwDZELSW23jTw9bxIgD57hz
VoEPH5XwHWHWrhKteF0UsgaS1KwKWQ7SsYex/VNEpFQuu094ZwmjRthP3dvG01V/
sbre0QUgmiE+zZ0SusAds+f4dcrB+6nS4GUAuf0jQL6EQEpP8ypSWPJY8+PQgMCC
uC/lqN1gIaornGLd1SAG3fXL4f7l4WFH3cGsTQbDEMPioW6vrNY=
=Jnjt
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--

--===============0417448285946382511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0417448285946382511==--
