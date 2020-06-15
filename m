Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089DC433E1
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 11:06:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8374C20707
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 11:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MADKiMUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8374C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 75C2F86F8E;
	Mon, 15 Jun 2020 11:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NquHkb8m3r5u; Mon, 15 Jun 2020 11:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6C66686F57;
	Mon, 15 Jun 2020 11:06:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF04C0892;
	Mon, 15 Jun 2020 11:06:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC77CC016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 09:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 95F2888B37
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 09:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RhppoTiBrZmf for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 09:41:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4DFB188975
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 09:41:32 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id l26so13928104wme.3
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KX2ULwgHf9kOaWMhPVMslim8oE0KSCOv/pZ2klCyRGI=;
 b=MADKiMUvO5q+6PpA7O/3H1wZ356C+bn7YJCQLTnaUNSoHutxT+2j5eIE9ZkXJ+DWxi
 NPrNRkA7Qdfa8fRr1zoKHDZTaZQLLGM1Ttq8bcuqecfCz/x3VhjouNbfQd08q6QLw2PY
 iNNqd0yr1mQvOJ0mN2hoblfClSj1xRs5n1jd9khVou1+7h9W2TT1NHEgxDTQgptOYJ53
 i2iJmywNJC9aksGIjW+YdbRYdKSB7uUCgPElSqa+ITDHQ0gXm+tRkTSxHS0wtwWvJ5/S
 dI2aUdQLDhB0Yj+9pWpcew4a9wV9L2cRkb/ti/IyjfoG6xrcZgOisuQsMrCj6nGtO+AN
 y/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KX2ULwgHf9kOaWMhPVMslim8oE0KSCOv/pZ2klCyRGI=;
 b=qs45CPXAtU4sVAjDJZXVgwu8Jp8Z8wE9bEsc2vYntv2ESu4OJ1qRIhlBobCCIsaFvT
 fY27xTCvqsDSWJMP1c9ux+1dirjV4N8pp1aI28L6nj1ybPR0UlACFitL1fy0IFSymE2n
 6Ppw78/u/dCzvEg1Ya+M4d6/HSVeQS4rH6wbsR6UWqIpsT4HCB1o3V3ixOZKFJC/82Qp
 QzXPTn9C047iR8zEsqk4L2M3vydB4w038UJiAdcAH1AUDlBIg7cgWdnUJZkHkt6keI94
 wAhm1J+JvTtKDMU+HArXfrQr1BAPZHEYmkWz97TFTMybOj+m8sQlT5eDsn1Q79Tl02wK
 pXMQ==
X-Gm-Message-State: AOAM532b9TwbEChazOGWGuHW01RaCb1WvbYtG3S0ON9ougxb/l8O7+Eg
 LgYEgkeuSyxohp8gq+tdfGo=
X-Google-Smtp-Source: ABdhPJyVaVd7y3qPeu+QQyc6wGoty9uDZd9oVpwHAHUFCZmUiI3IHbcATQ+TsPgQKHhygmoNJ17xlA==
X-Received: by 2002:a1c:6006:: with SMTP id u6mr12071103wmb.39.1592214090818; 
 Mon, 15 Jun 2020 02:41:30 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b8sm24305884wrs.36.2020.06.15.02.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 02:41:29 -0700 (PDT)
Date: Mon, 15 Jun 2020 10:41:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 14/15] vfio: Document dual stage control
Message-ID: <20200615094128.GB1491454@stefanha-x1.localdomain>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <1591877734-66527-15-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1591877734-66527-15-git-send-email-yi.l.liu@intel.com>
X-Mailman-Approved-At: Mon, 15 Jun 2020 11:06:21 +0000
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, yi.y.sun@intel.com, linux-kernel@vger.kernel.org,
 alex.williamson@redhat.com, iommu@lists.linux-foundation.org, hao.wu@intel.com,
 jun.j.tian@intel.com
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
Content-Type: multipart/mixed; boundary="===============5619824672421008511=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5619824672421008511==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 05:15:33AM -0700, Liu Yi L wrote:
> From: Eric Auger <eric.auger@redhat.com>
>=20
> The VFIO API was enhanced to support nested stage control: a bunch of
> new iotcls and usage guideline.
>=20
> Let's document the process to follow to set up nested mode.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
> v1 -> v2:
> *) new in v2, compared with Eric's original version, pasid table bind
>    and fault reporting is removed as this series doesn't cover them.
>    Original version from Eric.
>    https://lkml.org/lkml/2020/3/20/700
>=20
>  Documentation/driver-api/vfio.rst | 64 +++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/Documentation/driver-api/vfio.rst b/Documentation/driver-api=
/vfio.rst
> index f1a4d3c..06224bd 100644
> --- a/Documentation/driver-api/vfio.rst
> +++ b/Documentation/driver-api/vfio.rst
> @@ -239,6 +239,70 @@ group and can access them as follows::
>  	/* Gratuitous device reset and go... */
>  	ioctl(device, VFIO_DEVICE_RESET);
> =20
> +IOMMU Dual Stage Control
> +------------------------
> +
> +Some IOMMUs support 2 stages/levels of translation. Stage corresponds to
> +the ARM terminology while level corresponds to Intel's VTD terminology.
> +In the following text we use either without distinction.
> +
> +This is useful when the guest is exposed with a virtual IOMMU and some
> +devices are assigned to the guest through VFIO. Then the guest OS can use
> +stage 1 (GIOVA -> GPA or GVA->GPA), while the hypervisor uses stage 2 for
> +VM isolation (GPA -> HPA).
> +
> +Under dual stage translation, the guest gets ownership of the stage 1 pa=
ge
> +tables and also owns stage 1 configuration structures. The hypervisor ow=
ns
> +the root configuration structure (for security reason), including stage 2
> +configuration. This works as long configuration structures and page table

s/as long configuration/as long as configuration/

> +format are compatible between the virtual IOMMU and the physical IOMMU.

s/format/formats/

> +
> +Assuming the HW supports it, this nested mode is selected by choosing the
> +VFIO_TYPE1_NESTING_IOMMU type through:
> +
> +    ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU);
> +
> +This forces the hypervisor to use the stage 2, leaving stage 1 available
> +for guest usage. The guest stage 1 format depends on IOMMU vendor, and
> +it is the same with the nesting configuration method. User space should
> +check the format and configuration method after setting nesting type by
> +using:
> +
> +    ioctl(container->fd, VFIO_IOMMU_GET_INFO, &nesting_info);
> +
> +Details can be found in Documentation/userspace-api/iommu.rst. For Intel
> +VT-d, each stage 1 page table is bound to host by:
> +
> +    nesting_op->flags =3D VFIO_IOMMU_NESTING_OP_BIND_PGTBL;
> +    memcpy(&nesting_op->data, &bind_data, sizeof(bind_data));
> +    ioctl(container->fd, VFIO_IOMMU_NESTING_OP, nesting_op);
> +
> +As mentioned above, guest OS may use stage 1 for GIOVA->GPA or GVA->GPA.
> +GVA->GPA page tables are available when PASID (Process Address Space ID)
> +is exposed to guest. e.g. guest with PASID-capable devices assigned. For
> +such page table binding, the bind_data should include PASID info, which
> +is allocated by guest itself or by host. This depends on hardware vendor
> +e.g. Intel VT-d requires to allocate PASID from host. This requirement is
> +available by VFIO_IOMMU_GET_INFO. User space could allocate PASID from
> +host by:
> +
> +    req.flags =3D VFIO_IOMMU_ALLOC_PASID;
> +    ioctl(container, VFIO_IOMMU_PASID_REQUEST, &req);

It is not clear how the userspace application determines whether PASIDs
must be allocated from the host via VFIO_IOMMU_PASID_REQUEST or if the
guest itself can allocate PASIDs. The text mentions VFIO_IOMMU_GET_INFO
but what exactly should the userspace application check?

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7nQkgACgkQnKSrs4Gr
c8jZ0gf/XFjQsLCysIADPfVm33C/7VK8W+efHOrirtgQ8Hq2FEuki7UjwGgs933f
RRuvRaPuVCeVMuM9pEXT7uZyAVNS8uKoTVv0Z0gzQsRv/wNHKH6SrgW+n+o6Yhyo
6z200NLZZ9HrIt7J5cCYEqLv56KVSam5UfaX1LJMBF1I9YFNF7mo4oE12RJ69sT4
f3cjbmN3DmUpuB4AhVxYxn6/cdE5nFa3wkxqFE68yExNbNjcvUvZumLbEiQnEZYW
c4BVsNb71Q76yXB340m6RN4fU5pcS91eK9XAiDdPGYHtdFGNbSGA6Iadj8vbz++c
qlxF2QhlrFHPiXHRgrnzLKJcvmmZrA==
=/aVG
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--

--===============5619824672421008511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5619824672421008511==--
