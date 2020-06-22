Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9056BC433DF
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 12:49:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F3320738
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 12:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSHOIfFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F3320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 208B0893EA;
	Mon, 22 Jun 2020 12:49:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eGgZVSEF6bRO; Mon, 22 Jun 2020 12:49:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0C879893BA;
	Mon, 22 Jun 2020 12:49:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC96FC088F;
	Mon, 22 Jun 2020 12:49:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CCEAC016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3C0FA86E22
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:49:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 33tHmeZgcZTO for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 12:49:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0999886DEA
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 12:49:26 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id g10so14743366wmh.4
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KyLbHowE6Jr6ya5fF0rsMffz94nF0gU2x2NdsZwz5xg=;
 b=jSHOIfFO6zvVaNFqx8sLYnIxMZys6BSWItV9cExOZn7uRFt1usy6TniPiGY3Wpku4M
 cPiLnANrE5H89S/ajTkWTOtWY4oyKeG3L8sjRkvXMsyFtl9VLH1nfImE5cA84jiV6L30
 pm+xidmd+f6Ye1FRRv5Wlnr2y8j0KgljbWFlz3RQSNtMgwUeQ5mRc8UPu1WoFjza4n3m
 HNqkgQTlQ+9saGhaxYriNMDRTyjnOYpTho3Im5/Kyn9ArKh2/+LA7LaicydPqzEPjpRe
 rJTBS5xXRnrelHTMU/S8XtPt8AkGEgnEjgKA3jhqrfNGUaOBMSkaWLlctQHEzs+7J6/y
 UZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KyLbHowE6Jr6ya5fF0rsMffz94nF0gU2x2NdsZwz5xg=;
 b=QIbt2xWF+ca5F7XOyIfl8fpNQeSJjOKrg7Vq/y9GiDH5aYNvXTb1MoBQLc/tWWNACj
 hxi8FVsWahaydl5724Q7da5nH6C4pQIztwHzW2fuNbYxmkzXjV3v7Ikk6I6PKJrbgmfa
 JkpYnGQmnzcfhxkp6FNzcr535350qOaw2kBs8/IZMlbGGAbHkLnYOmLSWi2qmuhFBBn9
 znCypwOfkcCpeGzoKR73CIodxTMiRP5NkjmuNkJGe/k8MVjg1n49yAH2jzMpYimf99+u
 Co9I97tgO3PlKODC2RTxTe2eZ0NSnA0jNs2UC/5/r7+h/ENseXVpPzbzD1J5NXrzzOZl
 tGAg==
X-Gm-Message-State: AOAM531P3dC7wxYy/vBZKqpbBXapP2+CjZQpNxzCrMx14QzncNQgGBWk
 Ed33Qlg5l370jaK3kNKdErY=
X-Google-Smtp-Source: ABdhPJznXuUJEHfwe0EtG5zR7hb9qeM0wSlf8Zkg2rS6OhrasTx0vYRyo2FQTbcA9V7VXwBVsfXdMA==
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr11963492wmm.156.1592830164484; 
 Mon, 22 Jun 2020 05:49:24 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a22sm9152512wmj.9.2020.06.22.05.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 05:49:23 -0700 (PDT)
Date: Mon, 22 Jun 2020 13:49:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 00/15] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200622124922.GB15683@stefanha-x1.localdomain>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <20200615100214.GC1491454@stefanha-x1.localdomain>
 <MWHPR11MB16451F1E4748DF97D6A1DDD48C9D0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200616154928.GF1491454@stefanha-x1.localdomain>
 <20200616160916.GC11838@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200616160916.GC11838@xz-x1>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
Content-Type: multipart/mixed; boundary="===============0678022625659266135=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0678022625659266135==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 12:09:16PM -0400, Peter Xu wrote:
> On Tue, Jun 16, 2020 at 04:49:28PM +0100, Stefan Hajnoczi wrote:
> > Isolation between applications is preserved but there is no isolation
> > between the device and the application itself. The application needs to
> > trust the device.
> >=20
> > Examples:
> >=20
> > 1. The device can snoop secret data from readable pages in the
> >    application's virtual memory space.
> >=20
> > 2. The device can gain arbitrary execution on the CPU by overwriting
> >    control flow addresses (e.g. function pointers, stack return
> >    addresses) in writable pages.
>=20
> To me, SVA seems to be that "middle layer" of secure where it's not as sa=
fe as
> VFIO_IOMMU_MAP_DMA which has buffer level granularity of control (but of =
course
> we pay overhead on buffer setups and on-the-fly translations), however it=
's far
> better than DMA with no IOMMU which can ruin the whole host/guest, because
> after all we do a lot of isolations as process based.
>=20
> IMHO it's the same as when we see a VM (or the QEMU process) as a whole a=
long
> with the guest code.  In some cases we don't care if the guest did some b=
ad
> things to mess up with its own QEMU process.  It is still ideal if we can=
 even
> stop the guest from doing so, but when it's not easy to do it the ideal w=
ay, we
> just lower the requirement to not spread the influence to the host and ot=
her
> VMs.

Makes sense.

Stefan

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7wqNIACgkQnKSrs4Gr
c8hI8gf/caTxzWohWdHk0/Kop0H0CHDO065rgRJxZWIoB6f9resPUp7w3XbfOSzJ
cSXRukN+jPVq04Wh30cOpxJKT1OvdWTr6qgEa2u8mKZPCM3tftAN6j15gum7wcm+
LQhpJaHes/xES7VI3MbqoOtxVzxQ+kS5ve7fDxWSxVbE8fi10WGll5lx4eH+AOqC
nWbqRXKCb67Ya4aPiW+HZrs4zxcDe0CjIPqYLsGIRhC03VbMetbzygcxa6jMvibS
zye/aP0RQysbVYVgWlVvuGXvBwvJEDWE2d6AsRrVsXuLI2Vgstarzf0ttUxQuVRk
gY8hL0ENtePg6Iub4OC/idFoMffoZw==
=EiVH
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--===============0678022625659266135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0678022625659266135==--
