Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587D9C11D24
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 03:27:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9BF20716
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 03:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AzVjCTlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9BF20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD9F786E1F;
	Fri, 21 Feb 2020 03:27:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hy-G1zLg8az; Fri, 21 Feb 2020 03:27:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0506286E33;
	Fri, 21 Feb 2020 03:27:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF305C1D84;
	Fri, 21 Feb 2020 03:27:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75EE0C013E;
 Fri, 21 Feb 2020 03:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6034B86205;
 Fri, 21 Feb 2020 03:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A4TRY7vXd-rh; Fri, 21 Feb 2020 03:27:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 398F986160;
 Fri, 21 Feb 2020 03:27:50 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Nxjc3QBLz9sRk; Fri, 21 Feb 2020 14:27:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582255668;
 bh=y3lVtMpiI83RZRQFRmOykg/5zxHYT5D2zzjV2uwjV3s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AzVjCTlMyorNgEHOIaIpCqwmc5f/HP95xbBaFBc3b6BE149F7e/ZfSyTrQYJcAhWg
 UsHiPoIQtmjVabo+7H9zIstBLyAgo3Pda472sqcCTQUopX4set3xYqJ7sSrBgq2kM6
 TnKBFOgI5IOo+NmbVrJgt4SEJKsed3roEsQY9FCo=
Date: Fri, 21 Feb 2020 14:27:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Message-ID: <20200221032727.GC2298@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com>
 <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
MIME-Version: 1.0
In-Reply-To: <20200220163135.GA13192@lst.de>
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Michael Mueller <mimu@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
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
Content-Type: multipart/mixed; boundary="===============6136605632716803571=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6136605632716803571==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger wrote:
> > >From a users perspective it makes absolutely perfect sense to use the
> > bounce buffers when they are NEEDED.=20
> > Forcing the user to specify iommu_platform just because you need bounce=
 buffers
> > really feels wrong. And obviously we have a severe performance issue
> > because of the indirections.
>=20
> The point is that the user should not have to specify iommu_platform.
> We need to make sure any new hypervisor (especially one that might require
> bounce buffering) always sets it,

So, I have draft qemu patches which enable iommu_platform by default.
But that's really because of other problems with !iommu_platform, not
anything to do with bounce buffering or secure VMs.

The thing is that the hypervisor *doesn't* require bounce buffering.
In the POWER (and maybe s390 as well) models for Secure VMs, it's the
*guest*'s choice to enter secure mode, so the hypervisor has no reason
to know whether the guest needs bounce buffering.  As far as the
hypervisor and qemu are concerned that's a guest internal detail, it
just expects to get addresses it can access whether those are GPAs
(iommu_platform=3Doff) or IOVAs (iommu_platform=3Don).

> as was a rather bogus legacy hack

It was certainly a bad idea, but it was a bad idea that went into a
public spec and has been widely deployed for many years.  We can't
just pretend it didn't happen and move on.

Turning iommu_platform=3Don by default breaks old guests, some of which
we still care about.  We can't (automatically) do it only for guests
that need bounce buffering, because the hypervisor doesn't know that
ahead of time.

> that isn't extensibe for cases that for example require bounce buffering.

In fact bounce buffering isn't really the issue from the hypervisor
(or spec's) point of view.  It's the fact that not all of guest memory
is accessible to the hypervisor.  Bounce buffering is just one way the
guest might deal with that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5PTh0ACgkQbDjKyiDZ
s5KxuA/8Dp0u3ClHJcvgYS9sPsWYf3cIiL0ssD718l7m06uHYCC8BZhGbCeMhbfK
jDV3bIOPMI6f+L4KTSrPkH71KAYKLKbt52Si354kI/7xkDmCu3B8SmL/u+ptC0Y/
UYD0ZFkgyOLQaOS/jN5zMae3337n6qPRZuOP12epFWZ9QpP4v55Dba2ICuJXkbU1
5QaQIcCLwSBcEYxZOuLqc7s7tWfOt/NeNmvgMnCGJie035XlK0c8q2v7XqRnH8ec
5tej0mQvwOyKgZkYhr35Q/4t2V0LxPDvD+8W636WdH0O9h6wjeMeKlVoq8IpgMyz
NkYNX7yaPfnkh3fvqWa7NMmmi32Rt9/85Kk/3I4YD1KCMSzv7AGJ1TBnUMumisYJ
F2rB+Q07oGi/r/UNg2VSUE2S4rGgq1k9hD2Xb0yE+3+l1TvowJ+2ly30W1TSo5Hu
LZZ/XX0uzsCnrlw4aqzyh4+u4++QcgnlwvDgdfadNXVd3gQdPEoxAP+vV6FhTinx
29Dus3s83/aCpkNeU63NfDWXSIOPTUspWC8Ny1qGE1Vt0Dfie5K+6j7iZdYX0HZT
duIb419GYkR2DBTS0vS6jFh9QFN+jThVs4qc4uRqR6ibwocNlXSdxt+jT7QNkaqO
8HtGwkfqQZCCm4Z0uNnoFv4NY9kLB21wa/z0xOVmDJZtVD8Jgto=
=NO4r
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--

--===============6136605632716803571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6136605632716803571==--
