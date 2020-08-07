Return-Path: <SRS0=0w8+=BR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2BEC433E0
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 08:50:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6D6206B5
	for <iommu@archiver.kernel.org>; Fri,  7 Aug 2020 08:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6D6206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CADDA2039D;
	Fri,  7 Aug 2020 08:50:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZAP18lv0neSS; Fri,  7 Aug 2020 08:50:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1E861203A4;
	Fri,  7 Aug 2020 08:50:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5B80C0050;
	Fri,  7 Aug 2020 08:50:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A99FDC004C
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 08:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 91C4D88650
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 08:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gBT3qL1gmuYD for <iommu@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 08:50:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1EF1E88646
 for <iommu@lists.linux-foundation.org>; Fri,  7 Aug 2020 08:50:22 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 478AAAF06;
 Fri,  7 Aug 2020 08:50:39 +0000 (UTC)
Message-ID: <aae9250e660339142e9390427a603c4cf4e282af.camel@suse.de>
Subject: Re: [PATCH v3 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Fri, 07 Aug 2020 10:50:19 +0200
In-Reply-To: <20200807052116.GA584@lst.de>
References: <20200806184756.32075-1-nsaenzjulienne@suse.de>
 <20200806184756.32075-3-nsaenzjulienne@suse.de>
 <20200807052116.GA584@lst.de>
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Cc: amit.pundir@linaro.org, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 rientjes@google.com, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============4724565054509250734=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4724565054509250734==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-CN1cawQ3wxFHCl/garHR"


--=-CN1cawQ3wxFHCl/garHR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-08-07 at 07:21 +0200, Christoph Hellwig wrote:
> On Thu, Aug 06, 2020 at 08:47:55PM +0200, Nicolas Saenz Julienne wrote:
> > There is no guarantee to CMA's placement, so allocating a zone specific
> > atomic pool from CMA might return memory from a completely different
> > memory zone. To get around this double check CMA's placement before
> > allocating from it.
>=20
> As the builtbot pointed out, memblock_start_of_DRAM can't be used from
> non-__init code.  But lookig at it I think throwing that in
> is bogus anyway, as cma_get_base returns a proper physical address
> already.

It does indeed, but I'm comparing CMA's base with bitmasks that don't take =
into
account where the memory starts. Say memory starts at 0x80000000, and CMA f=
alls
into ZONE_DMA [0x80000000 0xC0000000], if you want to compare it with
DMA_BIT_MASK(zone_dma_bits) you're forced to unify the memory bases.

That said, I now realize that this doesn't work for ZONE_DMA32 which has a =
hard
limit on 32bit addresses reglardless of the memory base.

That said I still need to call memblock_start_of_DRAM() any suggestions WRT
that? I could save the value in dma_atomic_pool_init(), which is __init cod=
e.


--=-CN1cawQ3wxFHCl/garHR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8tFcsACgkQlfZmHno8
x/5Wxwf+IXh+GDy4xNKtfhxHMTDolZREHO/kvmoJd/zTobn0o4992GzMyEVu9YLd
MA+Yxdpi4IDDTredYMITrPM7f0nd2BpqZ1Wf8zXF2o5nmtPoAeOqH89FbajqzXle
oLRzLPoC5xDcErO2J1UDIRg539IJu1kKGaPDxJT0gxcDv39DOMITNzMuphQwacLM
tYXUuZ9yNFRx0AdODTOXPE7iE4qKRQvm54rExmYsT3VJIjlo+H8qrpa79q6BhooL
G19pFMDFTVhX/iRA94j2HBXr7IjyDK44JJlHWZ9Ocf04S3bVCClkDH9nK74ZRHgm
GS5W7k8K8VWOD1DajSTMyZjk/2+E/A==
=i4iT
-----END PGP SIGNATURE-----

--=-CN1cawQ3wxFHCl/garHR--


--===============4724565054509250734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4724565054509250734==--

