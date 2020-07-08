Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B325BC433DF
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 16:00:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90402206A1
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 16:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90402206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6AE6888DC4;
	Wed,  8 Jul 2020 16:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yrDzhskH1uBr; Wed,  8 Jul 2020 16:00:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D6ED1884AD;
	Wed,  8 Jul 2020 16:00:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3699C0893;
	Wed,  8 Jul 2020 16:00:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B21BC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 16:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4950888504
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 16:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pzq+LQrJ0Ypo for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 16:00:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 58FC8884AD
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 16:00:39 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BC203AE25;
 Wed,  8 Jul 2020 16:00:37 +0000 (UTC)
Message-ID: <e81db35628a22a0d1635699d1e87bacde706ad25.camel@suse.de>
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>
Date: Wed, 08 Jul 2020 18:00:35 +0200
In-Reply-To: <20200708153509.GA26743@lst.de>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
 <20200708153509.GA26743@lst.de>
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============3581263261944886709=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3581263261944886709==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-1l9N/1yPO/4ruj6aYldS"


--=-1l9N/1yPO/4ruj6aYldS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-07-08 at 17:35 +0200, Christoph Hellwig wrote:
> On Tue, Jul 07, 2020 at 02:28:04PM +0200, Nicolas Saenz Julienne wrote:
> > When allocating atomic DMA memory for a device, the dma-pool core
> > queries __dma_direct_optimal_gfp_mask() to check which atomic pool to
> > use. It turns out the GFP flag returned is only an optimistic guess.
> > The pool selected might sometimes live in a zone higher than the
> > device's view of memory.
> >=20
> > As there isn't a way to grantee a mapping between a device's DMA
> > constraints and correct GFP flags this unifies both DMA atomic pools.
> > The resulting pool is allocated in the lower DMA zone available, if any=
,
> > so as for devices to always get accessible memory while having the
> > flexibility of using dma_pool_kernel for the non constrained ones.
> >=20
> > Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to=
 gfp
> > mask")
> > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Hmm, this is not what I expected from the previous thread.  I thought
> we'd just use one dma pool based on runtime available of the zones..

I may be misunderstanding you, but isn't that going back to how things used=
 to
be before pulling in David Rientjes' work? The benefit of having a GFP_KERN=
EL
pool is that non-address-constrained devices can get their atomic memory th=
ere,
instead of consuming somewhat scarcer low memory.


--=-1l9N/1yPO/4ruj6aYldS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8F7aMACgkQlfZmHno8
x/5/9gf+NzyxgUaobjh+kSJ+z1K3KcgSbBWTsleHIga7PNEsLskweeTIbHy8Mu+L
+l3d5Luho/JiDNEwb/ogwIUOxxVnRMMypi0Pi1sSQKC8saaZBaACuZHlbl9FYola
+hM7aLJNaSdqN5lEqo185qtvbWE4czz+Lvhw+AiuzzI4d4bKswtCYj9kKO70ir+I
cTIIpzcwHXjDELCOGBnTmhIIL11feTP7BDZszZdk+Pp99KFBLPedpmSvp0PoaKN0
qxchAwBNrt31Jb1VjkMpRyAUqFZFPbcbBw0cqNdovej39bRIdJnjKUV2Qpg56ZRh
S5MgcOa4ctQVFoo7VirwED00A3dGDg==
=bCcC
-----END PGP SIGNATURE-----

--=-1l9N/1yPO/4ruj6aYldS--


--===============3581263261944886709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3581263261944886709==--

