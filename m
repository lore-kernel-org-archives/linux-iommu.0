Return-Path: <SRS0=ekvE=HY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F049C433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 19:05:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2554D64DE8
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 19:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2554D64DE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9225834C7;
	Mon, 22 Feb 2021 19:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cx08I403hT7c; Mon, 22 Feb 2021 19:05:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3673D8321B;
	Mon, 22 Feb 2021 19:05:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C525C000B;
	Mon, 22 Feb 2021 19:05:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42633C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 19:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3EAFA87038
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 19:05:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id filMXbWX3q8C for <iommu@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 19:05:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3839486FEF
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 19:05:40 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 315BDADE3;
 Mon, 22 Feb 2021 19:05:38 +0000 (UTC)
Message-ID: <70edceb03e4bf283072397f9563dfc4162aec92a.camel@suse.de>
Subject: Re: [PATCH 6/9] swiotlb: refactor swiotlb_tbl_map_single
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>, jxgao@google.com, 
 gregkh@linuxfoundation.org
Date: Mon, 22 Feb 2021 20:05:36 +0100
In-Reply-To: <20210207160327.2955490-7-hch@lst.de>
References: <20210207160327.2955490-1-hch@lst.de>
 <20210207160327.2955490-7-hch@lst.de>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 kbusch@kernel.org, robin.murphy@arm.com
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
Content-Type: multipart/mixed; boundary="===============6172822096870458005=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6172822096870458005==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-0N6/MlCWp/kYePTqUFa5"


--=-0N6/MlCWp/kYePTqUFa5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Sun, 2021-02-07 at 17:03 +0100, Christoph Hellwig wrote:
> Split out a bunch of a self-contained helpers to make the function easier
> to follow.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> =C2=A0kernel/dma/swiotlb.c | 179 +++++++++++++++++++++-------------------=
---
> =C2=A01 file changed, 89 insertions(+), 90 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b38b1553c4663a..381c24ef1ac1d0 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -468,134 +468,133 @@ static void swiotlb_bounce(phys_addr_t orig_addr,=
 phys_addr_t tlb_addr,
> =C2=A0	}
> =C2=A0}
> =C2=A0
>=20
> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t ori=
g_addr,
> -		size_t mapping_size, size_t alloc_size,
> -		enum dma_data_direction dir, unsigned long attrs)
> -{
> -	dma_addr_t tbl_dma_addr =3D phys_to_dma_unencrypted(hwdev, io_tlb_start=
);
> -	unsigned long flags;
> -	phys_addr_t tlb_addr;
> -	unsigned int nslots, stride, index, wrap;
> -	int i;
> -	unsigned long mask;
> -	unsigned long offset_slots;
> -	unsigned long max_slots;
> -	unsigned long tmp_io_tlb_used;
> -
> -	if (no_iotlb_memory)
> -		panic("Can not allocate SWIOTLB buffer earlier and can't now provide y=
ou with the DMA bounce buffer");
> -
> -	if (mem_encrypt_active())
> -		pr_warn_once("Memory encryption is active and system is using DMA boun=
ce buffers\n");
> +#define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
> =C2=A0
>=20
> -	if (mapping_size > alloc_size) {
> -		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd by=
tes)",
> -			      mapping_size, alloc_size);
> -		return (phys_addr_t)DMA_MAPPING_ERROR;
> -	}
> -
> -	mask =3D dma_get_seg_boundary(hwdev);
> +/*
> + * Carefully handle integer overflow which can occur when boundary_mask =
=3D=3D ~0UL.
> + */
> +static inline unsigned long get_max_slots(unsigned long boundary_mask)
> +{
> +	if (boundary_mask =3D=3D ~0UL)
> +		return 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
> +	return nr_slots(boundary_mask + 1);
> +}
> =C2=A0
>=20
> -	tbl_dma_addr &=3D mask;
> +static unsigned int wrap_index(unsigned int index)
> +{
> +	if (index >=3D io_tlb_nslabs)
> +		return 0;
> +	return index;
> +}
> =C2=A0
>=20
> -	offset_slots =3D nr_slots(tbl_dma_addr);
> +/*
> + * Find a suitable number of IO TLB entries size that will fit this requ=
est and
> + * allocate a buffer from that IO TLB pool.
> + */
> +static int find_slots(struct device *dev, size_t alloc_size)
> +{
> +	unsigned long boundary_mask =3D dma_get_seg_boundary(dev);
> +	dma_addr_t tbl_dma_addr =3D
> +		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
> +	unsigned int max_slots =3D get_max_slots(boundary_mask);

'max_slots' should be 'unsigned long' here. Breaks SWIOTLB on RPi4. Do you =
want
me to send a fix or you prefer editing the patch?

Regards,
Nicolas


--=-0N6/MlCWp/kYePTqUFa5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmA0AIAACgkQlfZmHno8
x/7nOwf8DHHip4IbMdYG8YJXxkxViw5qANwPZ+jyR0H4ngQmL/lbyFjmFteQu55c
gsG38mNa2K5EgaQywdwZXAvLF9a0CMNj9J76TDgHTTY5y79ioMnVRj9atp+57p9F
dOSa/Bq61L0Z31hhk0/oeKNtzyIVEFxZArJ+8FGIOfeik2ju6ZSJYEbDtSxvqnF5
ek4cLGYuehwHMojnMdbIPYH261AQdqqFofATdJtd/cDLqiSQeb70vJQo6Q0Hwfeb
0LnanDYcrxMGmmSahbrx+PcWUbA45RHNI0GBBz/rGp/KFyucbI+/aGNVoDPSbGGx
KRlIjSbuujswuLD1TJ1kJlDZGcCNog==
=lXJX
-----END PGP SIGNATURE-----

--=-0N6/MlCWp/kYePTqUFa5--


--===============6172822096870458005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6172822096870458005==--

