Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C981C47E49
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 10:44:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0025620862
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 10:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0025620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C23C21364;
	Thu, 31 Oct 2019 10:44:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7E1ADC5D
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 10:44:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 184EE174
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 10:44:54 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 46A14AC44;
	Thu, 31 Oct 2019 10:44:52 +0000 (UTC)
Message-ID: <cc8dd3f3261c75db44ebe991212b2b501b95fe5f.camel@suse.de>
Subject: Re: [PATCH v2 1/2] dma-direct: check for overflows on 32 bit DMA
	addresses
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Date: Thu, 31 Oct 2019 11:44:50 +0100
In-Reply-To: <20191030214140.GB25515@infradead.org>
References: <20191018110044.22062-1-nsaenzjulienne@suse.de>
	<20191018110044.22062-2-nsaenzjulienne@suse.de>
	<20191030214140.GB25515@infradead.org>
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Cc: rubini@gnudd.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, helgaas@kernel.org,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============1122730741055628511=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============1122730741055628511==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-8na/vhjgey3dmGswifWc"


--=-8na/vhjgey3dmGswifWc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-30 at 14:41 -0700, Christoph Hellwig wrote:
> On Fri, Oct 18, 2019 at 01:00:43PM +0200, Nicolas Saenz Julienne wrote:
> > +#ifndef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > +	/* Check if DMA address overflowed */
> > +	if (min(addr, addr + size - 1) <
> > +		__phys_to_dma(dev, (phys_addr_t)(min_low_pfn << PAGE_SHIFT)))
> > +		return false;
> > +#endif
>=20
> Would be nice to use IS_ENABLED and PFN_PHYS here, and I also think we
> need to use phys_to_dma to take care of the encryption bit.  If you then
> also introduce an end variable we can make the whole thing actually look
> nice:
>=20
> static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_=
t
> size)
> {
> 	dma_addr_t end =3D addr + size - 1;
>=20
>         if (!dev->dma_mask)
>                 return false;
>=20
> 	if (!IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
> 	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
> 		return false;
>=20
>         return end <=3D min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
> }
>=20
> Otherwise this looks sensible to me.

Thanks, noted.


--=-8na/vhjgey3dmGswifWc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl26uyIACgkQlfZmHno8
x/6faggAkUu1xkZr5yxkCdu+LrePqzvMc6UA2N3H3DznZz6FCuJuxEz7RvASAKYr
HDGjjBTtzbzxrdlhuEANucWhVE+WfFj18aWeSH2BL67ogVrNFIUeYKejhylBwj2U
19sS0FIdk1iSM6FYdDBH0g937Qo8tToyoiNfq3lpy/DvDF5Ge4oVGbURGl+0ARRu
UxX2wCOxPO1MM9RqjI5vc75o5bxxnmxSOVGZCbqSO2PDtqJSGcNjIPZMEIV2uVD+
P3CWcXOChiLXpppitNT5zdhzAN/tw57uP4xg7FYOQYNwn+SGyHq40CxhnbIRmC6V
KY+nFhWbVlJx+m7KgsbvpF6VuCPQ7Q==
=r3RJ
-----END PGP SIGNATURE-----

--=-8na/vhjgey3dmGswifWc--


--===============1122730741055628511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1122730741055628511==--

