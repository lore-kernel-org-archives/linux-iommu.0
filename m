Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32918C433E7
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 15:15:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC6D2222E
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 15:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC6D2222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E8B03880DC;
	Thu, 15 Oct 2020 15:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KuBLuZB7I4Tw; Thu, 15 Oct 2020 15:15:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C2E8D880D0;
	Thu, 15 Oct 2020 15:15:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6142C0052;
	Thu, 15 Oct 2020 15:15:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE9DCC0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 15:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A5FC0883D9
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 15:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VUtciAr4EzUm for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 15:15:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F0A2B882FB
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 15:15:12 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EFBECAB0E;
 Thu, 15 Oct 2020 15:15:10 +0000 (UTC)
Message-ID: <64bbecb547422272417feaff1aa6b3d8c3da1157.camel@suse.de>
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Hanjun Guo <guohanjun@huawei.com>, robh+dt@kernel.org, 
 catalin.marinas@arm.com, hch@lst.de, ardb@kernel.org,
 linux-kernel@vger.kernel.org,  Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
Date: Thu, 15 Oct 2020 17:15:09 +0200
In-Reply-To: <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de>
 <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 jeremy.linton@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============6032620893365384672=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6032620893365384672==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-rA4ctgOOrD1oldFe6ryS"


--=-rA4ctgOOrD1oldFe6ryS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 22:26 +0800, Hanjun Guo wrote:
> On 2020/10/15 3:12, Nicolas Saenz Julienne wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >=20
> > We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
> > incorporating masters that can address less than 32 bits of DMA, in
> > particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
> > peripherals that can only address up to 1 GB (and its PCIe host
> > bridge can only access the bottom 3 GB)
> >=20
> > Instructing the DMA layer about these limitations is straight-forward,
> > even though we had to fix some issues regarding memory limits set in
> > the IORT for named components, and regarding the handling of ACPI _DMA
> > methods. However, the DMA layer also needs to be able to allocate
> > memory that is guaranteed to meet those DMA constraints, for bounce
> > buffering as well as allocating the backing for consistent mappings.
> >=20
> > This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
> > it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
> > problems with kdump, and potentially in other places where allocations
> > cannot cross zone boundaries. Therefore, we should avoid having two
> > separate DMA zones when possible.
> >=20
> > So let's do an early scan of the IORT, and only create the ZONE_DMA
> > if we encounter any devices that need it. This puts the burden on
> > the firmware to describe such limitations in the IORT, which may be
> > redundant (and less precise) if _DMA methods are also being provided.
> > However, it should be noted that this situation is highly unusual for
> > arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
> > the _DMA method if implemented, and so we will not lose the ability to
> > perform streaming DMA outside the ZONE_DMA if the _DMA method permits
> > it.
>=20
> Sorry, I'm still a little bit confused. With this patch, if we have
> a device which set the right _DMA method (DMA size >=3D 32), but with the
> wrong DMA size in IORT, we still have the ZONE_DMA created which
> is actually not needed?

Yes, that would be the case.

Regards,
Nicolas


--=-rA4ctgOOrD1oldFe6ryS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IZ30ACgkQlfZmHno8
x/4cJwf9FfM3BZ9/yE9L5jVNiTGCeMhHtWSqKvOj5ffnkuUmxE4Xm3qLk9INWqO3
5Wyvp86ggfOjlYEqSQTnWzA0XEarBU47BEcPaxcZCYHatFm45aGfPO6xiaedBjPK
qOAbpttbRtFI4XF9FVCBgZw1F1XTm5NN+OnQLTyI6b09rsm6m0oBR6XB2p9MNpLw
IXC+dLpvAA8J8LEb1veX6dXMYfqH6huFaws6Eg1VQFP+0unizIfDZMmbsV8goJqc
egGTR/9MrU+ta2kaweQjBo4q49KpyEXXnzTvTAV+29joccYcyHFKBrSuwQdZo76T
cLo7n6gtcREwAG4fkZD0tRUmqaELKQ==
=wbwJ
-----END PGP SIGNATURE-----

--=-rA4ctgOOrD1oldFe6ryS--


--===============6032620893365384672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6032620893365384672==--

