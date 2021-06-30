Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40210C11F6A
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 17:42:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD65B6147E
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 17:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD65B6147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A832840528;
	Wed, 30 Jun 2021 17:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mCzpXoqUjxle; Wed, 30 Jun 2021 17:42:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 663C040129;
	Wed, 30 Jun 2021 17:42:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38F4FC0010;
	Wed, 30 Jun 2021 17:42:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5DC2C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 17:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ABCEA415DF
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 17:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZHjO7bWn6wK for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 17:42:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90CFE415D7
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 17:42:08 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id m1so4392841edq.8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TQHMCv6R24tlgOttPpa8QZy6zg0tD38HKkJXHw7Yzmo=;
 b=qBaIUYh8t8d/XQ4Iinzq9nniFH8XhtMCzIuDU/W3kb1U8U05U7m40Ae81PszoJZiBj
 sPkbVeyCkAgSmp+tI82qbI0sxcZSmFl7Qk1pXfTCEiKbEczldGLbgE1PPTwI2oXduxJ4
 6S4s07HBpk2CyyV+OnjkJDYfHiva7tIKNylNKWCvtV82sfRrVfiNfHmEtu2YpPkSExgH
 CkTh/5FmQQokXOontg/Deg5AKzQE7fuAFh01b4z7wuwU74W8QT7y/zYVyvK3emScLWAH
 7LJFjc7QE69DJm4IE03mvIyVD6vI3O58ifkfP1tEZRFqWLHlxC3Q8vU2s+UOTcJyQTsR
 sT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TQHMCv6R24tlgOttPpa8QZy6zg0tD38HKkJXHw7Yzmo=;
 b=D90PZmjLsSh24d3KL/cTbESfFQldf/eFV5LVzS2f7GEXTxQV4HIszsoox255sV+qYD
 NOEziXSWcRqDFpNLsf0R+p5vPW8VtgBDLonExi1s4rn/R7jpLR6E/zBnGDxeyxn4aSfy
 h3asNoVneizJyKELZ/tPsL9NIhdicOGNO1Dk9JUT52VHo8WawfZdduidFPQ2NiJ7iRxE
 OSW5bQWz9zeVy3CVsLZHgg7WVuenfOf/55SJDt6eNfCKRmBN7fDg1N553jPWkt/szuyD
 zNJkoMR51rl0NINfr6fImPOSIVslm0bq784leBfiayKfLQKq6JUuaZ4aX0SYin3pgkg+
 yuOw==
X-Gm-Message-State: AOAM530kna2TAA7dV6NFAke5UaX3OiBbE/t7qGp9vO5ZpQbOycZJD1Xg
 x2MQsq59OMBvqUErnSjiwOM=
X-Google-Smtp-Source: ABdhPJzOMUG9tSrubdJIGQutxcTtjoNoc6Ga9BpCPSoiyUoJJ6VLZ6yTOqNP6Ag1yIa9tOQTqF/EkQ==
X-Received: by 2002:a05:6402:2813:: with SMTP id
 h19mr47932821ede.39.1625074926618; 
 Wed, 30 Jun 2021 10:42:06 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id s7sm10213881ejd.88.2021.06.30.10.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jun 2021 10:42:05 -0700 (PDT)
Date: Wed, 30 Jun 2021 19:44:21 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH rdma-next v1 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
Message-ID: <YNytdbEG9OSHOT1z@orome.fritz.box>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
 <CGME20210630111227eucas1p2212b63f5d9da6788e57319c35ce9eaf4@eucas1p2.samsung.com>
 <a9462d67-2279-93f1-e042-d46033c208df@samsung.com>
MIME-Version: 1.0
In-Reply-To: <a9462d67-2279-93f1-e042-d46033c208df@samsung.com>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Cc: Yishai Hadas <yishaih@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 linux-kernel@vger.kernel.org,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Doug Ledford <dledford@redhat.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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
Content-Type: multipart/mixed; boundary="===============2667945019449985804=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2667945019449985804==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k6cvBpDdjY2dq+5c"
Content-Disposition: inline


--k6cvBpDdjY2dq+5c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 30, 2021 at 01:12:26PM +0200, Marek Szyprowski wrote:
> Hi Leon,
>=20
> On 29.06.2021 10:40, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@nvidia.com>
> >
> > orig_nents should represent the number of entries with pages,
> > but __sg_alloc_table_from_pages sets orig_nents as the number of
> > total entries in the table. This is wrong when the API is used for
> > dynamic allocation where not all the table entries are mapped with
> > pages. It wasn't observed until now, since RDMA umem who uses this
> > API in the dynamic form doesn't use orig_nents implicit or explicit
> > by the scatterlist APIs.
> >
> > Fix it by:
> > 1. Set orig_nents as number of entries with pages also in
> >     __sg_alloc_table_from_pages.
> > 2. Add a new field total_nents to reflect the total number of entries
> >     in the table. This is required for the release flow (sg_free_table).
> >     This filed should be used internally only by scatterlist.
> >
> > Fixes: 07da1223ec93 ("lib/scatterlist: Add support in dynamic allocatio=
n of SG table from pages")
> > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>=20
> This patch landed in linux-next 20210630 as commit a52724456928=20
> ("lib/scatterlist: Fix wrong update of orig_nents"). It causes serious=20
> regression in DMA-IOMMU integration, which can be observed for example=20
> on ARM Juno board during boot:
>=20
> Unable to handle kernel paging request at virtual address 00376f42a6e40454
> Mem abort info:
>  =C2=A0 ESR =3D 0x96000004
>  =C2=A0 EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>  =C2=A0 SET =3D 0, FnV =3D 0
>  =C2=A0 EA =3D 0, S1PTW =3D 0
>  =C2=A0 FSC =3D 0x04: level 0 translation fault
> Data abort info:
>  =C2=A0 ISV =3D 0, ISS =3D 0x00000004
>  =C2=A0 CM =3D 0, WnR =3D 0
> [00376f42a6e40454] address between user and kernel address ranges
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.13.0-next-20210630+ #3585
> Hardware name: ARM Juno development board (r1) (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=3D--)
> pc : __sg_free_table+0x60/0xa0
> lr : __sg_free_table+0x7c/0xa0
> ..
> Call trace:
>  =C2=A0__sg_free_table+0x60/0xa0
>  =C2=A0sg_free_table+0x1c/0x28
>  =C2=A0iommu_dma_alloc+0xc8/0x388
>  =C2=A0dma_alloc_attrs+0xcc/0xf0
>  =C2=A0dmam_alloc_attrs+0x68/0xb8
>  =C2=A0sil24_port_start+0x60/0xe0
>  =C2=A0ata_host_start.part.32+0xbc/0x208
>  =C2=A0ata_host_activate+0x64/0x150
>  =C2=A0sil24_init_one+0x1e8/0x268
>  =C2=A0local_pci_probe+0x3c/0xa0
>  =C2=A0pci_device_probe+0x128/0x1c8
>  =C2=A0really_probe+0x138/0x2d0
>  =C2=A0__driver_probe_device+0x78/0xd8
>  =C2=A0driver_probe_device+0x40/0x110
>  =C2=A0__driver_attach+0xcc/0x118
>  =C2=A0bus_for_each_dev+0x68/0xc8
>  =C2=A0driver_attach+0x20/0x28
>  =C2=A0bus_add_driver+0x168/0x1f8
>  =C2=A0driver_register+0x60/0x110
>  =C2=A0__pci_register_driver+0x5c/0x68
>  =C2=A0sil24_pci_driver_init+0x20/0x28
>  =C2=A0do_one_initcall+0x84/0x450
>  =C2=A0kernel_init_freeable+0x31c/0x38c
>  =C2=A0kernel_init+0x20/0x120
>  =C2=A0ret_from_fork+0x10/0x18
> Code: d37be885 6b01007f 52800004 540000a2 (f8656813)
> ---[ end trace 4ba4f0c9c48711a1 ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
>=20
> It looks that some changes to the scatterlist structures are missing=20
> outside of the lib/scatterlist.c.
>=20
> For now I would suggest to revert this change.

I see a very similar crash on Tegra during the HDA driver's probe.

Leon, let me know if you need a tester for a replacement patch.

Thanks,
Thierry

--k6cvBpDdjY2dq+5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDcrXIACgkQ3SOs138+
s6FhdxAAj3EkX+HHRXHebKLx4fKYxCviBAZT2HFs5aBw0/JsZnsONBmup94Hu6oT
eDWmuaKbQHiah1JQBuO/pcP5SiYzo46khUmCjcrTLH0/R/F4D+MiozEl1b+u6p+I
c/7L2bRE+qvPp34srQeN5sXmr9fYwyi5NsS/h2dy1TdsfmVMmiI14uIkv5bbB1bL
mMixQGYV1GeJEbgI9/93ybpaA7ksE8DEq/Yhn6vrL/qKKwMN2gI1b6xZlzrawzZE
Vtt+KSfxXfCuLGiitdwLzl75p6RGVmfxxd9HzRfLZU4V5Qzo4ZKiGP9QJQCWYyeW
6JB2bRx9q0S64srNf4ePmnpbC3COnwDuGH3YuAkZeh5QAE/OqQ8NrlKKUqe+XGXj
WcfzkPPMoHoJBXAz3am1ul+AMcvLxzEJq/YHJhMPaQ+EGz3oqBk7ijzSdtsFpM6o
FQo+TDtMA45sTGNGv7TCqUzJy7mkQbkgExF1J6mXECCAwH8kZAfRfIBIHz0/3BDV
xG5EXtTREeARBhsDkLoIlamjy7W0a5qn9P71euuV3w22y3dD7ir4W9FuyoX92HoZ
4dagb5SaCDGC171Z5nD/qLRH88nUytOzs7GAo0K8bG+KzYK9ql0f3/5+E/ZM28Bv
OEHUZe5iHid5LDkwyrMgBrlICgvh5f7PTqAuFODFnCyVCZtezP8=
=3wNO
-----END PGP SIGNATURE-----

--k6cvBpDdjY2dq+5c--

--===============2667945019449985804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2667945019449985804==--
