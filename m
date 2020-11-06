Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E38C4741F
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:25:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26217208C7
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaM+Ey4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26217208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 805D82E12D;
	Fri,  6 Nov 2020 15:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F3S2pzaJTZEr; Fri,  6 Nov 2020 15:25:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 410B32E0F8;
	Fri,  6 Nov 2020 15:25:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28E57C088B;
	Fri,  6 Nov 2020 15:25:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDBC0C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AC6492E12A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XzvL96Uc3AAt for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 15:25:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 904282E0F8
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:25:53 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id v5so1803218wmh.1
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 07:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XjzG9xyKNoWRwOPWSZKi7Qnobe1TMbEDxLVfqKsHoJY=;
 b=QaM+Ey4orHCx45wYxpmqtMIw2lq2ia+NB3LYHIYGADi65ZiYRqp9gVZFYlMIDTyjPs
 HRcSxH6ahU88EjnfdJorANALFuwkHeclQwhyFl8DwTJGS7bw1M7RsLIXu1zkwqyb6fcB
 45wAYwoxTU351BRlzS5XUDUsbUGgsH27pp9dC++0dhzdzqiLAAv8xTy6xVW/1fkwyQUU
 VrzqjXRzjInDlNM5NrPbXKrN9bzTcLQ+pvZv4SKjSxC/qSXsDEVUCliFdtxYAB7JP9KC
 NUL9jT3HckoGBKnSmgb8XO2g1lFQXa+AsIkApad0Wfm5EMsRPsEf/BX2tsfiQKUTVOHR
 pfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XjzG9xyKNoWRwOPWSZKi7Qnobe1TMbEDxLVfqKsHoJY=;
 b=PfqpVLDp3cU6meLwcguLamgcEeT0/TskiNH/7Or0AWN23JV+trKc87FugSO30dgLry
 jqdZuJKSqspIwszFCHzad/x6JY5Y44pzkOG0QQtk3QqpaxawUHYytp7kapnJQQI/x6kG
 Y62eShCZr34w0vasPTKpz0mQTql02iEntOJbpDQMXIfMjoUbN8HVygbWDIlPTiG8Sgyl
 VvyQez+0PnksoJajn3Uc31Z8HxSdVpkz12xwaGSruHKMJal3CUN0N4Mevu+q0w6yTIhh
 xnZGlbZfOXUXQUvNPNXO20rfCHIeGkJ+W1eG2lW/dlIU6Werpaa0kuuZRBgabUuXVCns
 FuRw==
X-Gm-Message-State: AOAM532vQs4A+UchfUlxD1OZXRTMzwnL9bJwb81s+VdcbdjLT8EEfp5T
 2joIkIFnD6WnNie0Aq6RfSE=
X-Google-Smtp-Source: ABdhPJyHYsoPRRaUlDi/KOLf1Ms07rJdvWShvPs0DnJwxwTVWFHx232cTKbzTqefKMO1Nvy8mGtKMQ==
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr67157wmf.133.1604676351969; 
 Fri, 06 Nov 2020 07:25:51 -0800 (PST)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id v67sm2963806wma.17.2020.11.06.07.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:25:50 -0800 (PST)
Date: Fri, 6 Nov 2020 16:25:48 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20201106152548.GA767203@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <20200914220829.GA330122@bogus> <20200915123648.GA3496938@ulmo>
 <20200924112725.GA2486709@ulmo> <20201105164312.GD485884@ulmo>
 <483cd043-980e-81fb-cccb-385206a699df@arm.com>
MIME-Version: 1.0
In-Reply-To: <483cd043-980e-81fb-cccb-385206a699df@arm.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Frank Rowand <frowand.list@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0071698710288640555=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0071698710288640555==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 05:47:21PM +0000, Robin Murphy wrote:
> On 2020-11-05 16:43, Thierry Reding wrote:
> > On Thu, Sep 24, 2020 at 01:27:25PM +0200, Thierry Reding wrote:
> > > On Tue, Sep 15, 2020 at 02:36:48PM +0200, Thierry Reding wrote:
> > > > On Mon, Sep 14, 2020 at 04:08:29PM -0600, Rob Herring wrote:
> > > > > On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrote:
> > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > >=20
> > > > > > Reserved memory regions can be marked as "active" if hardware is
> > > > > > expected to access the regions during boot and before the opera=
ting
> > > > > > system can take control. One example where this is useful is fo=
r the
> > > > > > operating system to infer whether the region needs to be identi=
ty-
> > > > > > mapped through an IOMMU.
> > > > >=20
> > > > > I like simple solutions, but this hardly seems adequate to solve =
the
> > > > > problem of passing IOMMU setup from bootloader/firmware to the OS=
=2E Like
> > > > > what is the IOVA that's supposed to be used if identity mapping i=
s not
> > > > > used?
> > > >=20
> > > > The assumption here is that if the region is not active there is no=
 need
> > > > for the IOVA to be specified because the kernel will allocate memor=
y and
> > > > assign any IOVA of its choosing.
> > > >=20
> > > > Also, note that this is not meant as a way of passing IOMMU setup f=
rom
> > > > the bootloader or firmware to the OS. The purpose of this is to spe=
cify
> > > > that some region of memory is actively being accessed during boot. =
The
> > > > particular case that I'm looking at is where the bootloader set up a
> > > > splash screen and keeps it on during boot. The bootloader has not s=
et up
> > > > an IOMMU mapping and the identity mapping serves as a way of keepin=
g the
> > > > accesses by the display hardware working during the transitional pe=
riod
> > > > after the IOMMU translations have been enabled by the kernel but be=
fore
> > > > the kernel display driver has had a chance to set up its own IOMMU
> > > > mappings.
> > > >=20
> > > > > If you know enough about the regions to assume identity mapping, =
then
> > > > > can't you know if active or not?
> > > >=20
> > > > We could alternatively add some property that describes the region =
as
> > > > requiring an identity mapping. But note that we can't make any
> > > > assumptions here about the usage of these regions because the IOMMU
> > > > driver simply has no way of knowing what they are being used for.
> > > >=20
> > > > Some additional information is required in device tree for the IOMMU
> > > > driver to be able to make that decision.
> > >=20
> > > Rob, can you provide any hints on exactly how you want to move this
> > > forward? I don't know in what direction you'd like to proceed.
> >=20
> > Hi Rob,
> >=20
> > do you have any suggestions on how to proceed with this? I'd like to get
> > this moving again because it's something that's been nagging me for some
> > months now. It also requires changes across two levels in the bootloader
> > stack as well as Linux and it takes quite a bit of work to make all the
> > changes, so before I go and rewrite everything I'd like to get the DT
> > bindings sorted out first.
> >=20
> > So just to summarize why I think this simple solution is good enough: it
> > tries to solve a very narrow and simple problem. This is not an attempt
> > at describing the firmware's full IOMMU setup to the kernel. In fact, it
> > is primarily targetted at cases where the firmware hasn't setup an IOMMU
> > at all, and we just want to make sure that when the kernel takes over
> > and does want to enable the IOMMU, that all the regions that are
> > actively being accessed by non-quiesced hardware (the most typical
> > example would be a framebuffer scanning out a splat screen or animation,
> > but it could equally well be some sort of welcoming tone or music being
> > played back) are described in device tree.
> >=20
> > In other words, and this is perhaps better answering your second
> > question: in addition to describing reserved memory regions, we want to
> > add a bit of information here about the usage of these memory regions.
> > Some memory regions may contain information that the kernel may want to
> > use (such an external memory frequency scaling tables) and those I would
> > describe as "inactive" memory because it isn't being accessed by
> > hardware. The framebuffer in this case is the opposite and it is being
> > actively accessed (hence it is marked "active") by hardware while the
> > kernel is busy setting everything up so that it can reconfigure that
> > hardware and take over with its own framebuffer (for the console, for
> > example). It's also not so much that we know enough about the region to
> > assume it needs identity mapping. We don't really care about that from
> > the DT point of view. In fact, depending on the rest of the system
> > configuration, we may not need identity mapping (i.e. if none of the
> > users of the reserved memory region are behind an IOMMU). But the point
> > here is that the IOMMU drivers can use this "active" property to
> > determine that if a device is using an "active" region and it is behind
> > an IOMMU, then it must identity map that region in order for the
> > hardware, which is not under the kernel's control yet, to be able to
> > continue to access that memory through an IOMMU mapping.
>=20
> Hmm, "active" is not a property of the memory itself, though, it's really=
 a
> property of the device accessing it. If several distinct devices share a
> carveout region, and for simplicity the bootloader marks it as active
> because one of those devices happens to be using some part of it at boot,=
 we
> don't really want to have to do all the reserved region setup for all the
> other devices unnecessarily, when all that matters is not disrupting one =
of
> them when resetting the IOMMU.
>=20
> That leads to another possible hiccup - some bindings already have a defi=
ned
> meaning for a "memory-region" property. If we use that to point to some
> small region for a temporary low-resolution bootsplash screen for visibil=
ity
> to an IOMMU driver, the device's own driver might also interpret it as a
> private carveout from which it is expected to allocate everything, and th=
us
> could end up failing to work well or at all.
>=20
> I agree that we should only need a relatively simple binding, and that
> piggybacking off reserved-memory nodes seems like an ideal way of getting
> address range descriptions without too much extra complexity; the tricky
> part is how best to associate those with the other information needed, wh=
ich
> is really the "iommus" property of the relevant device, and how to make it
> as generically discoverable as possible. Perhaps it might be workable to
> follow almost the same approach but with a dedicated property (e.g.
> "active-memory-region") that the IOMMU code can simply scan the DT for to
> determine relevant device nodes. Otherwise properties on the IOMMU node
> itself would seem the next most practical option.

We did recently introduce a "memory-region-names" property that's used
to add context for cases where multiple memory regions are used. Perhaps
the simplest to address the above would be to describe the region as
active by naming it "active". That has the disadvantage of restricting
the number of active regions to 1, though I suspect that may even be
enough for the vast majority of cases where we need this. This would be
similar to how we use the "dma-mem" string in the "interconnect-names"
property to specify the "DMA parent" of a device node.

Alternatively, we could perhaps support multiple occurrences of "active"
in the "memory-region-names" property. Or we could add a bit of
flexibility by considering all memory regions whose names have an
"active-" prefix as being active.

> We've also finally got things going on the IORT RMR side[1], which helps =
add
> a bit more shape to things too; beyond the actual firmware parsing, DT and
> ACPI systems should definitely be converging on the same internal
> implementation in the IOMMU layer.

Yeah, from a quick look at that series, this actually sounds really
close to what I'm trying to achieve here.

The patch set that I have would nicely complement the code added to
iommu_dma_get_resv_regions() for RMR regions. It's not exactly the same
code, but it's basically the DT equivalent of
iort_dev_rmr_get_resv_regions().

Thierry

>=20
> Robin.
>=20
> [1] https://lore.kernel.org/linux-iommu/20201027112646.44680-1-shameerali=
=2Ekolothum.thodi@huawei.com/

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+lavoACgkQ3SOs138+
s6EbHQ//bBMGXHz8NNarH32aC/YlgdqyQx9d6cXFTfGIlIPcLZz3+RCQUOBTGPam
jyMV5r/4opV66yWaGzF1oEKYvDsZUzi7gryanzE5dpqPWtDirVOZvoheJDCZiO90
twlwmNVgeCa81+FPVokFkHFQfRAQqxoDgTKvA5EBFKXjLIqNDYdjd6D6gPOIwrQl
exAkMvvUTbMtX7M/BpusLe33wTpoR6v0XVtD7nBl3Z4itSLXzrPU4Xcg8ltJbGmq
34XFNhHvMENJDgVIwztSBHJkM6dcCPOqZEzSruIPPKndicvdosq57zsJ8zH2jL+I
UpWhRnaxzuaN/frxS2hszDKliRJkUIj5FkIosH+C+Wyp6mwWHxiJ9TvHJfsPnKIb
p0tlOL9S238HkaMwbc+hluZcKnwirpxfgcN1sYDv9VJTmhydWIJ2lg8ROE71I29H
IWDCMksFqsTXCvpxDcAREU8DBvJtPuV4EWsbdPAOEKZ/Suj/mEI/PV1ycflS7MYs
4yLlMXDHB6jmXaDA3N2kbCiicxvZ4jeeH3VUFiztMcxnaOIQBW1URqvWPgEcFZZH
9fwFL7595WfDJL3G4ZA23f214TmPtzmuP1/NRh/UC3UGD8w/th1/5LBzX7Nb+kVM
E0FggPCLd0dY2Y9fDbBYbZY8xyzXGWdLlHuvrOVOVPUuLoNuvmI=
=nflf
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

--===============0071698710288640555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0071698710288640555==--
