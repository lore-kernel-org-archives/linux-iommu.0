Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCC8C43217
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 06:22:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1756260FF2
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 06:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1756260FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DAD124036B;
	Thu, 14 Oct 2021 06:22:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0swF5dYTl-cN; Thu, 14 Oct 2021 06:22:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F203140417;
	Thu, 14 Oct 2021 06:22:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7E9BC0011;
	Thu, 14 Oct 2021 06:22:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 426A5C0022
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 06:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24D5B831A0
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 06:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kmKVjSwC9Sck for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:22:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05CBF831A7
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 06:22:36 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HVK7r23g8z4xbX; Thu, 14 Oct 2021 17:22:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1634192552;
 bh=ZjbiQlJIXJMoYEFn9YS8ZY2I4WMOysFPmdFgHdCC4bk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bnu5pnv1agQiV9iOQmNVRreuQOZUbrPFJUc9qZoDrD5bci44q3xFm0xecwh6tepQU
 z0PRsRWB5HYaSr4KQx5u3QLB4/Krs5lFuLYwboFRxudY8MxVGd11wkcFEiYqUYo+gu
 YyWs+sArvD4TvxUdsbQ4i5V8rGgNNrz1ojnYLPx0=
Date: Thu, 14 Oct 2021 15:38:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YWe0TXqEm6uWH695@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com> <YVanJqG2pt6g+ROL@yekko>
 <20211001122225.GK964074@nvidia.com> <YWPTWdHhoI4k0Ksc@yekko>
 <YWP6tblC2+/2RQtN@myrica>
MIME-Version: 1.0
In-Reply-To: <YWP6tblC2+/2RQtN@myrica>
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, lkml@metux.net, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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
Content-Type: multipart/mixed; boundary="===============1096836180750034162=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1096836180750034162==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6dLb7we/5OKQdVbz"
Content-Disposition: inline


--6dLb7we/5OKQdVbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 11, 2021 at 09:49:57AM +0100, Jean-Philippe Brucker wrote:
> On Mon, Oct 11, 2021 at 05:02:01PM +1100, David Gibson wrote:
> > qemu wants to emulate a PAPR vIOMMU, so it says (via interfaces yet to
> > be determined) that it needs an IOAS where things can be mapped in the
> > range 0..2GiB (for the 32-bit window) and 2^59..2^59+1TiB (for the
> > 64-bit window).
> >=20
> > Ideally the host /dev/iommu will say "ok!", since both those ranges
> > are within the 0..2^60 translated range of the host IOMMU, and don't
> > touch the IO hole.  When the guest calls the IO mapping hypercalls,
> > qemu translates those into DMA_MAP operations, and since they're all
> > within the previously verified windows, they should work fine.
>=20
> Seems like we don't need the negotiation part?  The host kernel
> communicates available IOVA ranges to userspace including holes (patch
> 17), and userspace can check that the ranges it needs are within the IOVA
> space boundaries. That part is necessary for DPDK as well since it needs
> to know about holes in the IOVA space where DMA wouldn't work as expected
> (MSI doorbells for example). And there already is a negotiation happening,
> when the host kernel rejects MAP ioctl outside the advertised area.

The problem with the approach where the kernel advertises and
userspace selects based on that, is that it locks us into a specific
representation of what's possible.  If we get new hardware with new
weird constraints that can't be expressed with the representation we
chose, we're kind of out of stuffed.  Userspace will have to change to
accomodate the new extension and have any chance of working on the new
hardware.

With the model where userspace requests, and the kernel acks or nacks,
we can still support existing userspace if the only things it requests
can still be accomodated in the new constraints.  That's pretty likely
if the majority of userspaces request very simple things (say a single
IOVA block where it doesn't care about the base address).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6dLb7we/5OKQdVbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFntE0ACgkQbDjKyiDZ
s5IfiQ//ZhlukeW5UG20W/811MuwXc1bzTOsyL5lBR7JUPze3jwwNHOyDcVvG3bE
lcVXb6jOX3m4jdp1CARvSYiuLHRHbr3yXhz5e1Kzl8lYrGz2OCK99Aa4IVZsWe0W
vg8BORYBNzKhtbLXjYyYG00UPYpTqd3fsMc5HZOmhl4KDKFnMhxk093OcveJAyEz
U7QNQU9t5aCmGYesbGeFpLHjAMUVbxp2fPDmqwazo2BmJX7QMYO7S5/99cwC+uJ2
huezzVUkGRzRX8M1Vn+7SXX/VEZS+Qxg4hvMtHuyEMpft0ECzF+8RsTY2pX0RkUP
fox84HDo/JvRQFbP61C3bIz5PIHbZ5/MFpJ2UJ0ispkm/30v0hM4AcKTDYOMy1fi
pPd3lZoOvTWOfLX5GHYdDAONCt+4vOE868LJHIblRGGmnwZ6Z4M/5oJlgWBSkpzb
czVxyIPADRLUWtaTkLTuWmhyw6aGWMCmqSWJRQQ2y62vQScLQFEq3ReXpwq/tu4U
WRczYt41+LxQaRTySLmmNQq08/caNf/z6CpkvmD6Nm69isY1HpJaDyS4oymffvjW
tgNeITcmxVFvTD4G5qFVar6qZHOlIXYB0PPbOm3z31bxgKGJXvo4CFw5g0KTS2IC
keIgE7F4OQDg8CVFU4SwJwWMiSCS2cUrqT58Km8XGq2eZxDSwjg=
=0DMk
-----END PGP SIGNATURE-----

--6dLb7we/5OKQdVbz--

--===============1096836180750034162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1096836180750034162==--
