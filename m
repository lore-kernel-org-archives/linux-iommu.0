Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8C1C433E0
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 08:20:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841D0206A5
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 08:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841D0206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F40E88310;
	Fri, 10 Jul 2020 08:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uxsjiskLQzvv; Fri, 10 Jul 2020 08:20:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AE8E6882FD;
	Fri, 10 Jul 2020 08:20:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D2C0C016F;
	Fri, 10 Jul 2020 08:20:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7FDCC0865
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 08:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5042C89666
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 08:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DpwwM4MNqsrk for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 08:19:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BF5A789660
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 08:19:44 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AFBB7AB7A;
 Fri, 10 Jul 2020 08:19:42 +0000 (UTC)
Message-ID: <5c21867fd2e9c1c25f3080deeeb0ccdb3070ead2.camel@suse.de>
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: David Rientjes <rientjes@google.com>, Christoph Hellwig <hch@lst.de>
Date: Fri, 10 Jul 2020 10:19:40 +0200
In-Reply-To: <alpine.DEB.2.23.453.2007091448550.972523@chino.kir.corp.google.com>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
 <20200708153509.GA26743@lst.de>
 <e81db35628a22a0d1635699d1e87bacde706ad25.camel@suse.de>
 <20200708161010.GA30184@lst.de>
 <alpine.DEB.2.23.453.2007091448550.972523@chino.kir.corp.google.com>
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============0048570396864706301=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0048570396864706301==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-ghHFpb3jrVR40NR7F7FC"


--=-ghHFpb3jrVR40NR7F7FC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-07-09 at 14:49 -0700, David Rientjes wrote:
> On Wed, 8 Jul 2020, Christoph Hellwig wrote:
>=20
> > On Wed, Jul 08, 2020 at 06:00:35PM +0200, Nicolas Saenz Julienne wrote:
> > > On Wed, 2020-07-08 at 17:35 +0200, Christoph Hellwig wrote:
> > > > On Tue, Jul 07, 2020 at 02:28:04PM +0200, Nicolas Saenz Julienne wr=
ote:
> > > > > When allocating atomic DMA memory for a device, the dma-pool core
> > > > > queries __dma_direct_optimal_gfp_mask() to check which atomic poo=
l to
> > > > > use. It turns out the GFP flag returned is only an optimistic gue=
ss.
> > > > > The pool selected might sometimes live in a zone higher than the
> > > > > device's view of memory.
> > > > >=20
> > > > > As there isn't a way to grantee a mapping between a device's DMA
> > > > > constraints and correct GFP flags this unifies both DMA atomic po=
ols.
> > > > > The resulting pool is allocated in the lower DMA zone available, =
if
> > > > > any,
> > > > > so as for devices to always get accessible memory while having th=
e
> > > > > flexibility of using dma_pool_kernel for the non constrained ones=
.
> > > > >=20
> > > > > Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to =
map
> > > > > to gfp
> > > > > mask")
> > > > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > >=20
> > > > Hmm, this is not what I expected from the previous thread.  I thoug=
ht
> > > > we'd just use one dma pool based on runtime available of the zones.=
.
> > >=20
> > > I may be misunderstanding you, but isn't that going back to how thing=
s
> > > used to
> > > be before pulling in David Rientjes' work? The benefit of having a
> > > GFP_KERNEL
> > > pool is that non-address-constrained devices can get their atomic mem=
ory
> > > there,
> > > instead of consuming somewhat scarcer low memory.
> >=20
> > Yes, I think we are misunderstanding each other.  I don't want to remov=
e
> > any pool, just make better runtime decisions when to use them.
> >=20
>=20
> Just to be extra explicit for the record and for my own understanding:=
=20
> Nicolas, your patch series "dma-pool: Fix atomic pool selection" obsolete=
s=20
> this patch, right? :)

Yes, that's right.

Regards,
Nicolas


--=-ghHFpb3jrVR40NR7F7FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8IJJwACgkQlfZmHno8
x/7eRgf+LVqWrnAjb1c88gXOrDMdl27HUQzIDYXit5TQgnkyp7CwzALmvSEnc2Es
BtY2vTG+MkAnQosY5mRuw2Ycs6K89qFjVnd5JmCefM44A89n3vTG1Fu3/1yOFjEZ
dcdJuY7x6pFvZal7dEJpm3BMjWMGPRwCgdgF3fMmVqfwA7k4R0TflEZT/W7fSz1N
c9mVgO4dfv4uBghkHYe+ffZ/71uuWtebNkM5mwygsTJ6IFvQErnf0jF4ROi+Tv+o
XvKnWsFxvX8B36eZWhNHr5bWXbS7dHjAqiwIqhgKvwRvEqrSWVL3np29KwdrP09k
4AowWeWsNLJ9kHsHfaoaubpv6nUDbA==
=ZWwI
-----END PGP SIGNATURE-----

--=-ghHFpb3jrVR40NR7F7FC--


--===============0048570396864706301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0048570396864706301==--

