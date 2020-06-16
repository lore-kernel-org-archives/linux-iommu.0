Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F256C433DF
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 15:34:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA253208B3
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 15:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVYrNLNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA253208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 636752634A;
	Tue, 16 Jun 2020 15:34:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZtBzmxzcjs3r; Tue, 16 Jun 2020 15:34:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9445726282;
	Tue, 16 Jun 2020 15:34:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DF25C0888;
	Tue, 16 Jun 2020 15:34:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60538C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 15:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E99389498
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 15:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 99vcPVZ6I33s for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 15:34:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6501E88B26
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 15:34:43 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id j10so21241039wrw.8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=heeKT585/GdJnkdDzmupKcXSMWfb3JfA/9n//HJB8KI=;
 b=cVYrNLNBPz0x7FpNz+U7hpChITwYsvE8DuKNm4jFWi++FFsx9Oy5FGkGG7EMAeixt5
 U3WtXC/XYWsXL42lruWiNAMIaRDKlzVff8qoSZ6PoHK8XWLzziskLvOWnmeVBWIZHREj
 CLvmtD80NhJ1D3CeNego+GCMSfHpbodVfLy68PkArxZaBkTttH9eFkxIviYNo08PweY8
 sS3ZAV6yrqnkiOElaGZ4qLNldl23QnU4OchQd0QTff25M+gljt2uNkwy5AgCTYni49N3
 NPLLKrZrawdCqgE+FotClWohXnwxarw70eHiR7UTtByQZ6/I8ry/BGO43Iok3f9zc6iT
 ZDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=heeKT585/GdJnkdDzmupKcXSMWfb3JfA/9n//HJB8KI=;
 b=FNRGpSaRvrzPU4C0dFqjSXwf9A9oFNyyo7/ShsMQit4RFUPBh1iiwf5Rnotn7RLJxY
 RnVjWIlPjQ2MVG/TJr3ffvlB2uKiPfUPLPVh/c6LfDBAVdwUjRVX1YyGzCb8Vawp5m8u
 Fj5WQFG/aczNQApAPGO/OP/a8qdGFDOv0JvJpaOPMx+LhtL0LFqLJVHVqwBSEJ7/CvSl
 lPljxAhBcQmMPL1GKymcGR6Yo3GDDbDZTDuYrSaqNCq/ZdIWDb2ZDCpu6AlGfeXk3YAe
 4CiYMYrdHKEehnCetwf67j51X+Aqy8uLY1oVFHDjN38Ob0plBPMPM2JVLd914DMZgKdi
 2bqQ==
X-Gm-Message-State: AOAM531ngGnEBHp6QctLg761Wab78F6cGoVsYdFDiVsy3s6NcWRRswp+
 Uqzp45JGvJaNLP0YGg5Ui+A=
X-Google-Smtp-Source: ABdhPJw/GEtHnCh8n9ATBH9qJvvqoxLPRCt8puQyiC7D6fMHA7H4jA6wx0SyNiBrwSUDVP8LvdB0DQ==
X-Received: by 2002:adf:e692:: with SMTP id r18mr3503560wrm.192.1592321681879; 
 Tue, 16 Jun 2020 08:34:41 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id j4sm4815947wma.7.2020.06.16.08.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 08:34:41 -0700 (PDT)
Date: Tue, 16 Jun 2020 16:34:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 00/15] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200616153439.GE1491454@stefanha-x1.localdomain>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <20200615100214.GC1491454@stefanha-x1.localdomain>
 <DM5PR11MB143598745517132685DF1D09C39C0@DM5PR11MB1435.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB143598745517132685DF1D09C39C0@DM5PR11MB1435.namprd11.prod.outlook.com>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
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
Content-Type: multipart/mixed; boundary="===============3685681966406027765=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3685681966406027765==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 12:39:40PM +0000, Liu, Yi L wrote:
> > From: Stefan Hajnoczi <stefanha@gmail.com>
> > Sent: Monday, June 15, 2020 6:02 PM
> >=20
> > On Thu, Jun 11, 2020 at 05:15:19AM -0700, Liu Yi L wrote:
> > > Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SVM) on
> > > Intel platforms allows address space sharing between device DMA and
> > > applications. SVA can reduce programming complexity and enhance secur=
ity.
> > >
> > > This VFIO series is intended to expose SVA usage to VMs. i.e. Sharing
> > > guest application address space with passthru devices. This is called
> > > vSVA in this series. The whole vSVA enabling requires QEMU/VFIO/IOMMU
> > > changes. For IOMMU and QEMU changes, they are in separate series (lis=
ted
> > > in the "Related series").
> > >
> > > The high-level architecture for SVA virtualization is as below, the k=
ey
> > > design of vSVA support is to utilize the dual-stage IOMMU translation=
 (
> > > also known as IOMMU nesting translation) capability in host IOMMU.
> > >
> > >
> > >     .-------------.  .---------------------------.
> > >     |   vIOMMU    |  | Guest process CR3, FL only|
> > >     |             |  '---------------------------'
> > >     .----------------/
> > >     | PASID Entry |--- PASID cache flush -
> > >     '-------------'                       |
> > >     |             |                       V
> > >     |             |                CR3 in GPA
> > >     '-------------'
> > > Guest
> > > ------| Shadow |--------------------------|--------
> > >       v        v                          v
> > > Host
> > >     .-------------.  .----------------------.
> > >     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> > >     |             |  '----------------------'
> > >     .----------------/  |
> > >     | PASID Entry |     V (Nested xlate)
> > >     '----------------\.------------------------------.
> > >     |             |   |SL for GPA-HPA, default domain|
> > >     |             |   '------------------------------'
> > >     '-------------'
> > > Where:
> > >  - FL =3D First level/stage one page tables
> > >  - SL =3D Second level/stage two page tables
> >=20
> > Hi,
> > Looks like an interesting feature!
>=20
> thanks for the interest. Stefan :-)
>=20
> > To check I understand this feature: can applications now pass virtual
> > addresses to devices instead of translating to IOVAs?
>=20
> yes, application could pass virtual addresses to device directly. As
> long as the virtual address is mapped in cpu page table, then IOMMU
> would get it translated to physical address.
>=20
> > If yes, can guest applications restrict the vSVA address space so the
> > device only has access to certain regions?
>=20
> do you mean restrict the access of certain virtual address regions of
> guest application ? or certain guest memory? :-)

Your reply below answered my question. I was wondering if applications
can protect parts of their virtual memory space that should not be
accessed by the device. It makes sense that there is a trade-off to
simplify the programming model and performance might also be better if
the application doesn't need to DMA map/unmap buffers frequently.

Stefan

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7o5o8ACgkQnKSrs4Gr
c8g6Tgf/Van2m7eceyvVRw03HdeF1bB30zQNxTLZWlAYDwU8aW2VTupF58Qp/21A
SqcR20C9LsPofsXKrbhWfK+6FVu/HxqQTR2cNtRLGE6/lSMB892d4YC/wEgMPWyb
h+bHpwTOxse5/ywwglCtapKMgTpLdtvFWXGRAF5/g4BLM19dEji5JoSZf1oQEIT6
g8aCbxYoaD9GyE7HpYazYL1xPawp67YQNIp833WVsNky/9F/b9qnJxsg9QcVVJyq
2wcW/9L18xKbM2lEBHgIkJp/6tumX0x02wn5E+TsLj5l1X5FxMC5VDqUY4dovBvu
yzWMCyrcU+JnPV6o2VOhBqNiZf4SZQ==
=jhcy
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--

--===============3685681966406027765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3685681966406027765==--
