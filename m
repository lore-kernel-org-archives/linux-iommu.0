Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060C1C433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 11:06:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5BF20707
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 11:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO0pRvC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5BF20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 530D2884D7;
	Mon, 15 Jun 2020 11:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I1kZ4EvdWXfC; Mon, 15 Jun 2020 11:06:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A9BAB884BB;
	Mon, 15 Jun 2020 11:06:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F261C0892;
	Mon, 15 Jun 2020 11:06:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 548F2C016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 10:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 392D186D5B
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 10:02:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LS0h89oBkYHE for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 10:02:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CA18A8073A
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 10:02:18 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id d128so14182561wmc.1
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=08GcNeJgDJiHZoSCn55z5bT9ubYArPoNshimIgtmrxI=;
 b=QO0pRvC2qVcMaJQ1lTSuk7HXw4jnlqpbEwCy2b7HVqADTf/GNIv4YdnBzNHVw3OIKF
 MLsXLdpHZPMdBG6PfwTT0SFTybZXh835oquCUm3jZWE6QH0/QhDucD7SUl35TWO6e/rV
 mmbDpBoam0NEmYWiatJfvtqstG0WOrOLAIH5oAcUkSU/pJWz7lFjNjSE6NaolLfr3pbG
 87EkcDfgVc4XMUYzKZcUKGUSK3xEZ2eKA8JHRXDWTW65Imb84jXh5XDbArdXBC4p9Hao
 i5lZNcj3+1DHaWTnpmE+rPhIg6sTXyGn2hnHJ5UgC+BicdM4b25DZUULNrvk6pERMvfR
 UcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=08GcNeJgDJiHZoSCn55z5bT9ubYArPoNshimIgtmrxI=;
 b=nRfJcv7crXyzp560xb1lpPbZV9ptLMzaFP/XzFPI1dtCqgEZjFSr07odNOS+KZ9srF
 bnkXY8mDsACdjNWXuMJ4jC++TMnf6C+ETWJ5Yl+H1RPlMwprXMjJgC+bM43ux0CWCn9l
 EocZbDYnm8gfo4T0lUi7ftYdS6ehubNUCEVQ5VuV4BF8iTHvtQ0M19EnCAVtNJOpa68W
 sN8Etv327A8m9HlosfkVBTCgTKIOYuDdlY6vNMGHblZhqbTPkpN+EWzHvryrC4z2Io5j
 i0FbVK87/2tzkpkJWH1bMFy0L74mBe0IiMqBkLZoeZGlfkUqAQry/19d1bn3gBCJzzNM
 /CNg==
X-Gm-Message-State: AOAM530EtdxOFET9tQjr7enkC1BDFLPQxzl3/MzbQAwOPXNqQ+kM8oNc
 BrYtZDVrLkgL14n6JDcEOko=
X-Google-Smtp-Source: ABdhPJzWSdHeJZNPFXdicH+0DDwzdE3V7acyxzPD+oe7DXfRReDP+5v+LccZQloVMXDtKOAvZKdHbg==
X-Received: by 2002:a1c:dc44:: with SMTP id t65mr13176902wmg.128.1592215337114; 
 Mon, 15 Jun 2020 03:02:17 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id k17sm23995217wrl.54.2020.06.15.03.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 03:02:16 -0700 (PDT)
Date: Mon, 15 Jun 2020 11:02:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 00/15] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200615100214.GC1491454@stefanha-x1.localdomain>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============8610393235283134005=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8610393235283134005==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 05:15:19AM -0700, Liu Yi L wrote:
> Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SVM) on
> Intel platforms allows address space sharing between device DMA and
> applications. SVA can reduce programming complexity and enhance security.
>=20
> This VFIO series is intended to expose SVA usage to VMs. i.e. Sharing
> guest application address space with passthru devices. This is called
> vSVA in this series. The whole vSVA enabling requires QEMU/VFIO/IOMMU
> changes. For IOMMU and QEMU changes, they are in separate series (listed
> in the "Related series").
>=20
> The high-level architecture for SVA virtualization is as below, the key
> design of vSVA support is to utilize the dual-stage IOMMU translation (
> also known as IOMMU nesting translation) capability in host IOMMU.
>=20
>=20
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process CR3, FL only|
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |                CR3 in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.------------------------------.
>     |             |   |SL for GPA-HPA, default domain|
>     |             |   '------------------------------'
>     '-------------'
> Where:
>  - FL =3D First level/stage one page tables
>  - SL =3D Second level/stage two page tables

Hi,
Looks like an interesting feature!

To check I understand this feature: can applications now pass virtual
addresses to devices instead of translating to IOVAs?

If yes, can guest applications restrict the vSVA address space so the
device only has access to certain regions?

On one hand replacing IOVA translation with virtual addresses simplifies
the application programming model, but does it give up isolation if the
device can now access all application memory?

Thanks,
Stefan

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7nRyYACgkQnKSrs4Gr
c8it8gf/TeJTtf8ILMVekJJKiE/LzXVWGX/dqeYBMEp9fhU6QYQIgieaQ9coR+zu
2Rk66LdmgfNDct0Yd9JsUgcBzggYCE4EXUQq2gX5+43O6KkbMKPZq9XWG3c1lorL
dcghm6bL66QtyXtTuirc4PLDyXHQXrSFE1XyCqb1LI4ZJ06ixoayWLvG1Y+OhaE6
QsTzNbo5RhADYG+l5U40nTXoQu4sr/7oPK3fBT5BI8/iTGgVnb43tHBTLtxxMPXS
h8S8N0eJpXdfudpdp7YMUu9crttpDcTvtWIRQm2gLVpF+t95Dh1RKtntiKPfNTzz
dlmLpMC5acu6JEAimAswW5t7IYqzfQ==
=zQiU
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--

--===============8610393235283134005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8610393235283134005==--
