Return-Path: <SRS0=NWqd=2B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85490C43603
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 19:13:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515E7206A5
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 19:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515E7206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2839384E42;
	Wed, 11 Dec 2019 19:13:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w4MdGk0tCZLF; Wed, 11 Dec 2019 19:13:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9717784D8A;
	Wed, 11 Dec 2019 19:13:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 702DBC1796;
	Wed, 11 Dec 2019 19:13:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AC20C0881
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 19:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0CEB92271F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 19:13:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7YhWXKTE5Xz for <iommu@lists.linux-foundation.org>;
 Wed, 11 Dec 2019 19:12:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 1B4D422621
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 19:12:59 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E77CEAC44;
 Wed, 11 Dec 2019 19:12:56 +0000 (UTC)
Message-ID: <caef320ed82f3e28065920d037805f18c29e4156.camel@suse.de>
Subject: Re: [PATCH v2] iommu/dma: Rationalise types for DMA masks
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, hch@lst.de
Date: Wed, 11 Dec 2019 20:12:54 +0100
In-Reply-To: <00d1ddf9439a8c79fb561b0fc740bddf9e6fe6b1.1576089015.git.robin.murphy@arm.com>
References: <00d1ddf9439a8c79fb561b0fc740bddf9e6fe6b1.1576089015.git.robin.murphy@arm.com>
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Cc: natechancellor@gmail.com, iommu@lists.linux-foundation.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org, stephan@gerhold.net
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
Content-Type: multipart/mixed; boundary="===============6881280265021105904=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6881280265021105904==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-XICR1gKRvP0/o9JFpxGW"


--=-XICR1gKRvP0/o9JFpxGW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-11 at 18:33 +0000, Robin Murphy wrote:
> Since iommu_dma_alloc_iova() combines incoming masks with the u64 bus
> limit, it makes more sense to pass them around in their native u64
> rather than converting to dma_addr_t early. Do that, and resolve the
> remaining type discrepancy against the domain geometry with a cheeky
> cast to keep things simple.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks!

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-XICR1gKRvP0/o9JFpxGW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3xP7YACgkQlfZmHno8
x/7FiAgAnId4C31mAw6taCSWTYRlI5XzSRM3BWgQ8VW3hnuQJR+8BW9AslfYp1jC
O8Jf22GL7el60MA/jpECLMqmrNryEyysbkQPP+Cxe2ol9bXVCoD2fKnL7kDMwQhi
d5UUU/c7QmHEKucH/BSJpoMrWtz1ljl2dpIh+IFIV0HuCtavfnhqUq1O+whYwiFe
zLow9a+pLjMjKd5y0ZGKFdSiS8ITDk0k1AO1nj2LnUUDEhwu4gv7rZWGrFJP+H4n
vehYQtW88O62CiH3EPBrG4Ge/YxwNhfH+W/q4uxKiQFbBeH9xlvN/AzwnQPYr5/I
2yWOkUHdujJwNhd/h5zdf9gk2Y7vlQ==
=WZQI
-----END PGP SIGNATURE-----

--=-XICR1gKRvP0/o9JFpxGW--


--===============6881280265021105904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6881280265021105904==--

