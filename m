Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71504C433E2
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 12:49:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38BEB2074D
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 12:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo0jCaeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BEB2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EFD7C87CB4;
	Mon, 22 Jun 2020 12:49:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FSMM0v6forHP; Mon, 22 Jun 2020 12:49:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA3C187899;
	Mon, 22 Jun 2020 12:49:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC7C6C088F;
	Mon, 22 Jun 2020 12:49:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 528D5C016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 419C6893C0
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IM4+76jJiLCD for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 12:49:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3EB07893BA
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:49:08 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id q5so4151659wru.6
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xGatUJxNTAw2tUiFEaNFWmvGzMlb5CEE+27h8ZbQoqA=;
 b=Fo0jCaebeHZeZRepyjDDO5l3PFS2O33eoeemUc7+TfVjsdW0PZh1jxiNqsbozvZ+/S
 WbwtPoO2/lKaDMExIygZ/rAUsJZnrnQpNutiLvWuLimsp+OhRyAfBdp5NsRSAThz5uKx
 63wl8EZq7CCRE1v387f86SlE6MhyIpQYjUrzcFdFeaWUz30gUNnloIJODOMqxXC2I/dH
 0hnhSV/v0ZA0i+h5a9r/Z0tZpFgmn/9kIalWhRtDb2eZWiVcAp1MBWs0EOyCMNMg8BmD
 XiGyMtxPjjT7otFsFPFJVrKjx0xjG75+Ny6hSK4vLaRlvtfg9Mr5clmipUCDINCpWCUF
 fGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xGatUJxNTAw2tUiFEaNFWmvGzMlb5CEE+27h8ZbQoqA=;
 b=ENE99VE2dxDBwYe3TO1nXE67HA5FLRf4qeuDX4HoaGFZY6aDWAMjDISnZ3iDxRVyjj
 xCdWqyP07lywZlVsQlUS1Mcka04uFP+MRWie6s/9Ds9vLQxSFykEIEiqIOKzcq0n3h2M
 K8Fj4OWVAU4ky40ZDeQkyEde7CwcWVckEDfCJze8U+Tx4TjPcpQ8HAHju5B4NlTQBOUZ
 stI0XqJqmAsYWZ1qw4Yo+BfYP7Rm9w5O7EvS2MjNExgq0KXNvdLwsGh5KySWEIogfRGH
 SBYAGNZG6xZNJDqajqDwl7XzpVTOZFoyR4CFj0mIC4WhNcOyCgWLtKbMuJJgov7AJc29
 CLeg==
X-Gm-Message-State: AOAM530VwwSR2m2VPgB0zfoz1SfZaPViU8MwXs/p+eALems9IRPfBO8x
 9SymGDJQ8DRbuwMf0NUC3z8=
X-Google-Smtp-Source: ABdhPJzMLu4KRyVzvJP0bS2XiYGikCs23dmilk57dFnSrKScoyR4yDFMDMhiQJv/QXhrNjgLZ9TprQ==
X-Received: by 2002:a5d:6088:: with SMTP id w8mr3846805wrt.49.1592830146570;
 Mon, 22 Jun 2020 05:49:06 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c201sm12510825wmd.4.2020.06.22.05.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 05:49:05 -0700 (PDT)
Date: Mon, 22 Jun 2020 13:49:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v2 00/15] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200622124904.GA15683@stefanha-x1.localdomain>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <20200615100214.GC1491454@stefanha-x1.localdomain>
 <MWHPR11MB16451F1E4748DF97D6A1DDD48C9D0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200616154928.GF1491454@stefanha-x1.localdomain>
 <20200616170016.GC34820@otc-nc-03>
MIME-Version: 1.0
In-Reply-To: <20200616170016.GC34820@otc-nc-03>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wu,
 Hao" <hao.wu@intel.com>, "Tian, Jun J" <jun.j.tian@intel.com>
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
Content-Type: multipart/mixed; boundary="===============4995672992890590791=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4995672992890590791==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 10:00:16AM -0700, Raj, Ashok wrote:
> On Tue, Jun 16, 2020 at 04:49:28PM +0100, Stefan Hajnoczi wrote:
> > On Tue, Jun 16, 2020 at 02:26:38AM +0000, Tian, Kevin wrote:
> > > > From: Stefan Hajnoczi <stefanha@gmail.com>
> > > > Sent: Monday, June 15, 2020 6:02 PM
> > > >=20
> > > > On Thu, Jun 11, 2020 at 05:15:19AM -0700, Liu Yi L wrote:
> > > > > Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SV=
M) on
> > > > > Intel platforms allows address space sharing between device DMA a=
nd
> > > > > applications. SVA can reduce programming complexity and enhance
> > > > security.
> > > > >
> > > > > This VFIO series is intended to expose SVA usage to VMs. i.e. Sha=
ring
> > > > > guest application address space with passthru devices. This is ca=
lled
> > > > > vSVA in this series. The whole vSVA enabling requires QEMU/VFIO/I=
OMMU
> > > > > changes. For IOMMU and QEMU changes, they are in separate series =
(listed
> > > > > in the "Related series").
> > > > >
> > > > > The high-level architecture for SVA virtualization is as below, t=
he key
> > > > > design of vSVA support is to utilize the dual-stage IOMMU transla=
tion (
> > > > > also known as IOMMU nesting translation) capability in host IOMMU.
> > > > >
> > > > >
> > > > >     .-------------.  .---------------------------.
> > > > >     |   vIOMMU    |  | Guest process CR3, FL only|
> > > > >     |             |  '---------------------------'
> > > > >     .----------------/
> > > > >     | PASID Entry |--- PASID cache flush -
> > > > >     '-------------'                       |
> > > > >     |             |                       V
> > > > >     |             |                CR3 in GPA
> > > > >     '-------------'
> > > > > Guest
> > > > > ------| Shadow |--------------------------|--------
> > > > >       v        v                          v
> > > > > Host
> > > > >     .-------------.  .----------------------.
> > > > >     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> > > > >     |             |  '----------------------'
> > > > >     .----------------/  |
> > > > >     | PASID Entry |     V (Nested xlate)
> > > > >     '----------------\.------------------------------.
> > > > >     |             |   |SL for GPA-HPA, default domain|
> > > > >     |             |   '------------------------------'
> > > > >     '-------------'
> > > > > Where:
> > > > >  - FL =3D First level/stage one page tables
> > > > >  - SL =3D Second level/stage two page tables
> > > >=20
> > > > Hi,
> > > > Looks like an interesting feature!
> > > >=20
> > > > To check I understand this feature: can applications now pass virtu=
al
> > > > addresses to devices instead of translating to IOVAs?
> > > >=20
> > > > If yes, can guest applications restrict the vSVA address space so t=
he
> > > > device only has access to certain regions?
> > > >=20
> > > > On one hand replacing IOVA translation with virtual addresses simpl=
ifies
> > > > the application programming model, but does it give up isolation if=
 the
> > > > device can now access all application memory?
> > > >=20
> > >=20
> > > with SVA each application is allocated with a unique PASID to tag its
> > > virtual address space. The device that claims SVA support must guaran=
tee=20
> > > that one application can only program the device to access its own vi=
rtual
> > > address space (i.e. all DMAs triggered by this application are tagged=
 with
> > > the application's PASID, and are translated by IOMMU's PASID-granular
> > > page table). So, isolation is not sacrificed in SVA.
> >=20
> > Isolation between applications is preserved but there is no isolation
> > between the device and the application itself. The application needs to
> > trust the device.
>=20
> Right. With all convenience comes security trust. With SVA there is an
> expectation that the device has the required security boundaries properly
> implemented. FWIW, what is our guarantee today that VF's are secure from
> one another or even its own PF? They can also generate transactions with
> any of its peer id's and there is nothing an IOMMU can do today. Other th=
an
> rely on ACS. Even BusMaster enable can be ignored and devices (malicious
> or otherwise) can generate after the BM=3D0. With SVM you get the benefit=
s of
>=20
> * Not having to register regions
> * Don't need to pin application space for DMA.

As along as the security model is clearly documented users can decide
whether or not SVA meets their requirements. I just wanted to clarify
what the security model is.

>=20
> >=20
> > Examples:
> >=20
> > 1. The device can snoop secret data from readable pages in the
> >    application's virtual memory space.
>=20
> Aren't there other security technologies that can address this?

Maybe the IOMMU could enforce Memory Protection Keys? Imagine each
device is assigned a subset of memory protection keys and the IOMMU
checks them on each device access. This would allow the application to
mark certain pages off-limits to the device but the IOMMU could still
walk the full process page table (no need to construct a special device
page table for the IOMMU).

> >=20
> > 2. The device can gain arbitrary execution on the CPU by overwriting
> >    control flow addresses (e.g. function pointers, stack return
> >    addresses) in writable pages.
>=20
> I suppose technology like CET might be able to guard. The general
> expectation is code pages and anything that needs to be protected should =
be
> mapped nor writable.

Function pointers are a common exception to this. They are often located
in writable heap or stack pages.

There might also be dynamic linker memory structures that are easy to
hijack.

Stefan

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7wqL8ACgkQnKSrs4Gr
c8heuQgApuxvMLS3gRIfo/o5wq9Bk1pmP6BYlbH+zzsGCLuIHFmY4vMWAxjZxfX/
ThavBmvMFOSnJSzTxzDcM/kY1P5XfcTwdaEaELIn/Pvd1bnfo+1R3fxUZAL9wQeT
y1XqmdmqC8s8Gv38VLR6YhWuEs0ZkevIWCMkySxjkvb0VN0OdFBidJeroRJq/LTo
dlmZJQg138jFzeSJYHsT6sY+SHKZVjnLltBOZJxVHRLzEPeA0YfqPeLNmOZDUAA4
nSGknlEO5CUuWGo9NK0JNfA0CbRR+cWgUtIcGi3FS729MSKXoErHoNVTgKPxL992
KjDqf88bkzcwGigXGrKjmB2TOvbmAg==
=/67A
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

--===============4995672992890590791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4995672992890590791==--
