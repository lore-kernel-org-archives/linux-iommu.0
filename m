Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BA8C433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 12:51:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5378820732
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 12:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhLP70Rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5378820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F068893E3;
	Mon, 22 Jun 2020 12:51:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pwwPb3q7xIqf; Mon, 22 Jun 2020 12:51:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 665B2893BA;
	Mon, 22 Jun 2020 12:51:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FFA4C088F;
	Mon, 22 Jun 2020 12:51:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6114CC016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4BA3B88663
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:51:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UAAggceOTt3e for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 12:51:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 16ABA88629
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:51:19 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z13so4796682wrw.5
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zX/vQrH+HC/mucizOa8U1pMYcedLXVgLImbH/v3tPS0=;
 b=JhLP70RcDDFMFYc7ZxEIe1hTIp69j0N7fT3eiKD5NEVpzW5wivY2d+4xyEwBnxOaxv
 kJ68t97XxfsUkhGvW3aG4q9UBhw6y3EvZxj3lPilWMgdauvT787Lklprdc80s2ovc6Im
 GN3kidGgoUdqo1XM6djT4h7yZ9BkY6aB04ivnbcv+IU46wv5MxffJ7Txa3+7IWRWKzDr
 Zz6iPqaMUTsoHjTXZ43ACXzCS24kNWkVYJjvh6f6OT0QEWT3692CS7N7gHbv/UwdVobK
 irbQKcl7rKS/ublt8UznIOojLVAjN8nzVWkKRqVj9cJYY0UcLpW20HZ52cu11PnxgE4v
 lRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zX/vQrH+HC/mucizOa8U1pMYcedLXVgLImbH/v3tPS0=;
 b=jCjb3SG3IOzp14gvpaheCuBh2VcGkxGi3bb+Q849DRppZkiNfu7FTtk38yK+CpD09J
 Wic4ZQBiqMfWCI+ZeCK4HFxffIP8rPPUXmg6NBn/tJaTvs8tTxyksZqgIO3JHNfhZWRq
 sMTjdD2/Q2j/8BuK0LzDsj2sGfxSFxo4oXRSy8czUsp7eAYdl06YmfFExQlM9qNJim6t
 p4pRfC+BA66IJ3ooRadsFYVvbYVHOu+3lMeEjC3wXodiWswEWVUmzjL6fWlU2hhnrFiD
 Ezi25hpSIen/jxXoiLP1hRh9xsTObx75sPgHte2CvPqSz1eRuYLQsKSdWZgbH8EkAG5N
 ncHA==
X-Gm-Message-State: AOAM532Cz/p7D7ax3qIZ/dXw+P/y3pca3Q/vW3SLsnxgVX+VSuS+Bc+G
 SikpIxjcmcIGutiBQXa+7hQ=
X-Google-Smtp-Source: ABdhPJxI4UVX4dTZ/ry3z9DrcIkJ3kGLDq/UM07+8O+yaTZxSbSNFRHTH8ZBS3yAurbDt/ZM22UjyQ==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr18730878wrw.63.1592830277348; 
 Mon, 22 Jun 2020 05:51:17 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b201sm16893800wmb.36.2020.06.22.05.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 05:51:16 -0700 (PDT)
Date: Mon, 22 Jun 2020 13:51:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 14/15] vfio: Document dual stage control
Message-ID: <20200622125114.GC15683@stefanha-x1.localdomain>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <1591877734-66527-15-git-send-email-yi.l.liu@intel.com>
 <20200615094128.GB1491454@stefanha-x1.localdomain>
 <DM5PR11MB1435C484283BDCD75F19EDB5C39A0@DM5PR11MB1435.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB1435C484283BDCD75F19EDB5C39A0@DM5PR11MB1435.namprd11.prod.outlook.com>
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
Content-Type: multipart/mixed; boundary="===============1203537529567849941=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1203537529567849941==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 06:27:27AM +0000, Liu, Yi L wrote:
> > From: Stefan Hajnoczi <stefanha@gmail.com>
> > Sent: Monday, June 15, 2020 5:41 PM
> > On Thu, Jun 11, 2020 at 05:15:33AM -0700, Liu Yi L wrote:
> >
> > > From: Eric Auger <eric.auger@redhat.com>
> > >
> > > The VFIO API was enhanced to support nested stage control: a bunch of
> > > new iotcls and usage guideline.
> > >
> > > Let's document the process to follow to set up nested mode.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > > v1 -> v2:
> > > *) new in v2, compared with Eric's original version, pasid table bind
> > >    and fault reporting is removed as this series doesn't cover them.
> > >    Original version from Eric.
> > >    https://lkml.org/lkml/2020/3/20/700
> > >
> > >  Documentation/driver-api/vfio.rst | 64
> > > +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 64 insertions(+)
> > >
> > > diff --git a/Documentation/driver-api/vfio.rst
> > > b/Documentation/driver-api/vfio.rst
> > > index f1a4d3c..06224bd 100644
> > > --- a/Documentation/driver-api/vfio.rst
> > > +++ b/Documentation/driver-api/vfio.rst
> > > @@ -239,6 +239,70 @@ group and can access them as follows::
> > >  	/* Gratuitous device reset and go... */
> > >  	ioctl(device, VFIO_DEVICE_RESET);
> > >
> > > +IOMMU Dual Stage Control
> > > +------------------------
> > > +
> > > +Some IOMMUs support 2 stages/levels of translation. Stage corresponds
> > > +to the ARM terminology while level corresponds to Intel's VTD termin=
ology.
> > > +In the following text we use either without distinction.
> > > +
> > > +This is useful when the guest is exposed with a virtual IOMMU and
> > > +some devices are assigned to the guest through VFIO. Then the guest
> > > +OS can use stage 1 (GIOVA -> GPA or GVA->GPA), while the hypervisor
> > > +uses stage 2 for VM isolation (GPA -> HPA).
> > > +
> > > +Under dual stage translation, the guest gets ownership of the stage 1
> > > +page tables and also owns stage 1 configuration structures. The
> > > +hypervisor owns the root configuration structure (for security
> > > +reason), including stage 2 configuration. This works as long
> > > +configuration structures and page table
> >=20
> > s/as long configuration/as long as configuration/
>=20
> got it.
>=20
> >=20
> > > +format are compatible between the virtual IOMMU and the physical IOM=
MU.
> >=20
> > s/format/formats/
>=20
> I see.
>=20
> > > +
> > > +Assuming the HW supports it, this nested mode is selected by choosing
> > > +the VFIO_TYPE1_NESTING_IOMMU type through:
> > > +
> > > +    ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU);
> > > +
> > > +This forces the hypervisor to use the stage 2, leaving stage 1
> > > +available for guest usage. The guest stage 1 format depends on IOMMU
> > > +vendor, and it is the same with the nesting configuration method.
> > > +User space should check the format and configuration method after
> > > +setting nesting type by
> > > +using:
> > > +
> > > +    ioctl(container->fd, VFIO_IOMMU_GET_INFO, &nesting_info);
> > > +
> > > +Details can be found in Documentation/userspace-api/iommu.rst. For
> > > +Intel VT-d, each stage 1 page table is bound to host by:
> > > +
> > > +    nesting_op->flags =3D VFIO_IOMMU_NESTING_OP_BIND_PGTBL;
> > > +    memcpy(&nesting_op->data, &bind_data, sizeof(bind_data));
> > > +    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
> > > +
> > > +As mentioned above, guest OS may use stage 1 for GIOVA->GPA or GVA->=
GPA.
> > > +GVA->GPA page tables are available when PASID (Process Address Space
> > > +GVA->ID)
> > > +is exposed to guest. e.g. guest with PASID-capable devices assigned.
> > > +For such page table binding, the bind_data should include PASID info,
> > > +which is allocated by guest itself or by host. This depends on
> > > +hardware vendor e.g. Intel VT-d requires to allocate PASID from host.
> > > +This requirement is available by VFIO_IOMMU_GET_INFO. User space
> > > +could allocate PASID from host by:
> > > +
> > > +    req.flags =3D VFIO_IOMMU_ALLOC_PASID;
> > > +    ioctl(container, VFIO_IOMMU_PASID_REQUEST, &req);
> >=20
> > It is not clear how the userspace application determines whether PASIDs=
 must be
> > allocated from the host via VFIO_IOMMU_PASID_REQUEST or if the guest it=
self can
> > allocate PASIDs. The text mentions VFIO_IOMMU_GET_INFO but what exactly
> > should the userspace application check?
>=20
> For VT-d, spec 3.0 introduced Virtual Cmd interface for PASID allocation,
> guest request PASID from host if it detects the interface. Application
> should check the IOMMU_NESTING_FEAT_SYSWIDE_PASID setting in the below
> info reported by VFIO_IOMMU_GET_INFO. And virtual VT-d should not report
> SVA related capabilities to guest if  SYSWIDE_PASID is not supported by
> kernel.
>=20
> +struct iommu_nesting_info {
> +	__u32	size;
> +	__u32	format;
> +	__u32	features;
> +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> +	__u32	flags;
> +	__u8	data[];
> +};
> https://lore.kernel.org/linux-iommu/1591877734-66527-3-git-send-email-yi.=
l.liu@intel.com/

I see. Is it possible to add this information into this patch or at
least a reference so readers know where to find out exactly how to do
this?

Stefan

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7wqUIACgkQnKSrs4Gr
c8gEXAf/ZQH8CodMq4v9KMj2p9NfiCaoPCLUovRUE5HN/T65F4Ws54FqyH1P7o1D
D1+HFmvmqlTxWeYPGQezE0oPyHHXoklhwabmOsZfvNdXcCxLCT/Ly8KtqSQvrGtY
6726z2oGqGsKG9P1VS363mcwFXGAS4bsSiq/lKfaPqsK0ixQhIZ6W7uYDd+ftcO9
RF+fAaZo+HfTgbOjtXNJEBloLq9+hKfC8DzUlndGVuscAZrzw9IFKBaYDI23Mrmu
NP48KNAT7EkIIqpO7g+1wUo+CsKN0QrZsaMk7mOY3UAFfv2n9kUqQHeNVCNq7rc/
J1A0bqVto/R4LzTP6oY6Txi+4dTSBQ==
=D21M
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

--===============1203537529567849941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1203537529567849941==--
