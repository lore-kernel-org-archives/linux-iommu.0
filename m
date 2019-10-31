Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF4ECA9ECB
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 17:26:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9C720873
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 17:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9C720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5675FC5C;
	Thu, 31 Oct 2019 17:26:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8ACC4C3E
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 17:26:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 069AE89E
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 17:26:17 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 3E70EB961;
	Thu, 31 Oct 2019 17:26:14 +0000 (UTC)
Message-ID: <9c051b0f2d89baa36fd3d3669a107f549c310d49.camel@suse.de>
Subject: Re: [PATCH RFC 1/5] dma/direct: turn ARCH_ZONE_DMA_BITS into a
	variable
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 31 Oct 2019 18:26:10 +0100
In-Reply-To: <20191031133831.GA21509@infradead.org>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
	<20191014183108.24804-2-nsaenzjulienne@suse.de>
	<20191030214914.GA15939@infradead.org>
	<8c525f66c1c0d9f07e0cff4948d1ec3229756220.camel@suse.de>
	<20191031133831.GA21509@infradead.org>
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Cc: linux-s390@vger.kernel.org, mbrugger@suse.com,
	Vasily Gorbik <gor@linux.ibm.com>, wahrenst@gmx.net,
	Michael Ellerman <mpe@ellerman.id.au>,
	Will Deacon <will@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	iommu@lists.linux-foundation.org, f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============2135628875719419066=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============2135628875719419066==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-HUsDE4pCuvQagD+CYqmq"


--=-HUsDE4pCuvQagD+CYqmq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-31 at 06:38 -0700, Christoph Hellwig wrote:
> On Thu, Oct 31, 2019 at 11:30:36AM +0100, Nicolas Saenz Julienne wrote:
> > On Wed, 2019-10-30 at 14:49 -0700, Christoph Hellwig wrote:
> > > On Mon, Oct 14, 2019 at 08:31:03PM +0200, Nicolas Saenz Julienne wrot=
e:
> > > > Some architectures, notably ARM, are interested in tweaking this
> > > > depending on their runtime DMA addressing limitations.
> > > >=20
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > >=20
> > > Do you want me to pick this up for the 5.5 dma-mapping tree, or do yo=
u
> > > want me to wait for the rest to settle?
> >=20
> > I'd say take it, this will be ultimately needed once we push forward wi=
th
> > ARM.
>=20
> Can you resend a version that applies against 5.4-rc?  The current one
> has conflicts in the arm64 code.

Hi Catalin,
would you mind taking this patch on top of the arm64 ZONE_DMA series?

I tried to go though Christoph's tree but it ultimately clashes with the
ZONE_DMA series. It's simpler to apply it on top of your tree.

Regrads,
Nicolas


--=-HUsDE4pCuvQagD+CYqmq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl27GTIACgkQlfZmHno8
x/6rAgf/ZoMMGW7IRaV6x5ZwhpeWmnDuHERj4vzVJa0/eBKTyeFHQYuyNBygdzOW
JGunOdpAkJNo6DdJKxyUt8u5d8vvnq3mIm+g0xkoz6PxzzUtPlEuFZ1fgP1oGYIT
BdBcYj23cYMrYjtqcJJkBoBu+5JBkx28Mu5oGyWeRojupXkK+9NN53qUZMmYcFD+
Lw9i3nBQmiozrdeHMiErrYTXOkz93sipx2zeo2jF4CsOtj67BfJMhmsRogeQTIe+
Z5A6Ik+LQ8AejhKOAisJzXidZPdUwaENRKw2qicQFBoifWbqinhT6JxmrEk/AHR1
eg9iA75sotbQfuNiAzn6qCofWaKfcg==
=jqtB
-----END PGP SIGNATURE-----

--=-HUsDE4pCuvQagD+CYqmq--


--===============2135628875719419066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2135628875719419066==--

