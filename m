Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB4AC11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 17:49:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450E961480
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 17:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450E961480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 182CE60841;
	Wed, 30 Jun 2021 17:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CFZPz3sm5dtD; Wed, 30 Jun 2021 17:49:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F3E3860803;
	Wed, 30 Jun 2021 17:49:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEF4CC0010;
	Wed, 30 Jun 2021 17:49:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E7EBC000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 17:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D1866082D
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 17:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IaZ_f95XVg39 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 17:49:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CC1E60803
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 17:49:46 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BB4961462;
 Wed, 30 Jun 2021 17:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625075386;
 bh=/QiX33p5bYPVFlmCGcTrcEYCsFrjvItICmc+E7ZuREY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q6wtlg0Ujzsh2cKDL5/DRjlc7iNwjeXHqa/c+hhPvO4yq6c5IMviTnnnKAne1lvg8
 s3mUU69+lYuUnIUIAmb3IVIIqqsE4y3s+bILMptpD+pSOcIVE/hEDsQU+cSSm/xLqx
 p4o62Ge/fdBaBa11DID8+teioklVEKEE2IZabfrQztzYaX+Izff52SV8mfBENLBmT6
 5CTtOJ3se3Wd5CVq1Y9ylU6BhyEFfwRw+IOISIv4xs+Ar2w0hxR10C0bqCOQmVj6pY
 BzKQuj5cZYBGqTCbbUPKue1VdwmHH3Ckh+T6fRM/nHFnOWBuTgaqy1tqdoN+EePhoK
 tbyGqwl+As4sw==
Date: Wed, 30 Jun 2021 20:49:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH rdma-next v1 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
Message-ID: <YNyutTbAWRcK7Bgp@unreal>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
 <CGME20210630111227eucas1p2212b63f5d9da6788e57319c35ce9eaf4@eucas1p2.samsung.com>
 <a9462d67-2279-93f1-e042-d46033c208df@samsung.com>
 <YNytdbEG9OSHOT1z@orome.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNytdbEG9OSHOT1z@orome.fritz.box>
Cc: Yishai Hadas <yishaih@nvidia.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 linux-kernel@vger.kernel.org,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Doug Ledford <dledford@redhat.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jun 30, 2021 at 07:44:21PM +0200, Thierry Reding wrote:
> On Wed, Jun 30, 2021 at 01:12:26PM +0200, Marek Szyprowski wrote:
> > Hi Leon,
> > =

> > On 29.06.2021 10:40, Leon Romanovsky wrote:
> > > From: Maor Gottlieb <maorg@nvidia.com>
> > >
> > > orig_nents should represent the number of entries with pages,
> > > but __sg_alloc_table_from_pages sets orig_nents as the number of
> > > total entries in the table. This is wrong when the API is used for
> > > dynamic allocation where not all the table entries are mapped with
> > > pages. It wasn't observed until now, since RDMA umem who uses this
> > > API in the dynamic form doesn't use orig_nents implicit or explicit
> > > by the scatterlist APIs.
> > >
> > > Fix it by:
> > > 1. Set orig_nents as number of entries with pages also in
> > >     __sg_alloc_table_from_pages.
> > > 2. Add a new field total_nents to reflect the total number of entries
> > >     in the table. This is required for the release flow (sg_free_tabl=
e).
> > >     This filed should be used internally only by scatterlist.
> > >
> > > Fixes: 07da1223ec93 ("lib/scatterlist: Add support in dynamic allocat=
ion of SG table from pages")
> > > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > =

> > This patch landed in linux-next 20210630 as commit a52724456928 =

> > ("lib/scatterlist: Fix wrong update of orig_nents"). It causes serious =

> > regression in DMA-IOMMU integration, which can be observed for example =

> > on ARM Juno board during boot:
> > =

> > Unable to handle kernel paging request at virtual address 00376f42a6e40=
454
> > Mem abort info:
> >  =A0 ESR =3D 0x96000004
> >  =A0 EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >  =A0 SET =3D 0, FnV =3D 0
> >  =A0 EA =3D 0, S1PTW =3D 0
> >  =A0 FSC =3D 0x04: level 0 translation fault
> > Data abort info:
> >  =A0 ISV =3D 0, ISS =3D 0x00000004
> >  =A0 CM =3D 0, WnR =3D 0
> > [00376f42a6e40454] address between user and kernel address ranges
> > Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.13.0-next-20210630+ #3585
> > Hardware name: ARM Juno development board (r1) (DT)
> > pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=3D--)
> > pc : __sg_free_table+0x60/0xa0
> > lr : __sg_free_table+0x7c/0xa0
> > ..
> > Call trace:
> >  =A0__sg_free_table+0x60/0xa0
> >  =A0sg_free_table+0x1c/0x28
> >  =A0iommu_dma_alloc+0xc8/0x388
> >  =A0dma_alloc_attrs+0xcc/0xf0
> >  =A0dmam_alloc_attrs+0x68/0xb8
> >  =A0sil24_port_start+0x60/0xe0
> >  =A0ata_host_start.part.32+0xbc/0x208
> >  =A0ata_host_activate+0x64/0x150
> >  =A0sil24_init_one+0x1e8/0x268
> >  =A0local_pci_probe+0x3c/0xa0
> >  =A0pci_device_probe+0x128/0x1c8
> >  =A0really_probe+0x138/0x2d0
> >  =A0__driver_probe_device+0x78/0xd8
> >  =A0driver_probe_device+0x40/0x110
> >  =A0__driver_attach+0xcc/0x118
> >  =A0bus_for_each_dev+0x68/0xc8
> >  =A0driver_attach+0x20/0x28
> >  =A0bus_add_driver+0x168/0x1f8
> >  =A0driver_register+0x60/0x110
> >  =A0__pci_register_driver+0x5c/0x68
> >  =A0sil24_pci_driver_init+0x20/0x28
> >  =A0do_one_initcall+0x84/0x450
> >  =A0kernel_init_freeable+0x31c/0x38c
> >  =A0kernel_init+0x20/0x120
> >  =A0ret_from_fork+0x10/0x18
> > Code: d37be885 6b01007f 52800004 540000a2 (f8656813)
> > ---[ end trace 4ba4f0c9c48711a1 ]---
> > Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x000000=
0b
> > =

> > It looks that some changes to the scatterlist structures are missing =

> > outside of the lib/scatterlist.c.
> > =

> > For now I would suggest to revert this change.
> =

> I see a very similar crash on Tegra during the HDA driver's probe.
> =

> Leon, let me know if you need a tester for a replacement patch.

With a great pleasure, I'll contact you offline when we prepare it.

For now, this patch will be dropped.

Thanks

> =

> Thanks,
> Thierry


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
