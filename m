Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6425DC11D25
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 06:44:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049F72082E
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 06:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="A2k8RAOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049F72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2578A8700D;
	Mon, 24 Feb 2020 06:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xa1qk86r9uCl; Mon, 24 Feb 2020 06:44:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8F50C86F8D;
	Mon, 24 Feb 2020 06:44:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82B43C1D89;
	Mon, 24 Feb 2020 06:44:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06AB7C18DA;
 Mon, 24 Feb 2020 06:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E81A585C11;
 Mon, 24 Feb 2020 06:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x4yG9Ix6KH_R; Mon, 24 Feb 2020 06:43:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2A96385B4D;
 Mon, 24 Feb 2020 06:43:56 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48QswR4QQ9z9sRf; Mon, 24 Feb 2020 17:43:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582526631;
 bh=htknb17Uk8fVFhFIa11PeQWaB1RywfjrKYh7McPzKaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A2k8RAOJ4XV3K5TDcE3+viHL40zy7GJhyNz9D6/cqtYvsoczT12lJi12rSZGLEKqH
 eAt0viVC1lU8zZ+tWxuhqG/z5G/bgs1RHNNRzk7/UZxNDkG0TcszcGlmDtcS8e2MV7
 I42zDmdaoGyb9mEQXOol+pq8p2580cV78ael2xg0=
Date: Mon, 24 Feb 2020 14:38:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200224033853.GE1751@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200221155602.4de41fa7.pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Michael Mueller <mimu@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============7408810731771317058=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7408810731771317058==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 03:56:02PM +0100, Halil Pasic wrote:
> On Fri, 21 Feb 2020 14:22:26 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>=20
> >=20
> > On 2020/2/21 =E4=B8=8A=E5=8D=8812:06, Halil Pasic wrote:
> > > Currently if one intends to run a memory protection enabled VM with
> > > virtio devices and linux as the guest OS, one needs to specify the
> > > VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the guest
> > > linux use the DMA API, which in turn handles the memory
> > > encryption/protection stuff if the guest decides to turn itself into
> > > a protected one. This however makes no sense due to multiple reasons:
> > > * The device is not changed by the fact that the guest RAM is
> > > protected. The so called IOMMU bypass quirk is not affected.
> > > * This usage is not congruent with  standardised semantics of
> > > VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reas=
on
> > > for using DMA API in virtio (orthogonal with respect to what is
> > > expressed by VIRTIO_F_IOMMU_PLATFORM).
> > >
> > > This series aims to decouple 'have to use DMA API because my (guest) =
RAM
> > > is protected' and 'have to use DMA API because the device told me
> > > VIRTIO_F_IOMMU_PLATFORM'.
> > >
> > > Please find more detailed explanations about the conceptual aspects in
> > > the individual patches. There is however also a very practical problem
> > > that is addressed by this series.
> > >
> > > For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following s=
ide
> > > effect The vhost code assumes it the addresses on the virtio descript=
or
> > > ring are not guest physical addresses but iova's, and insists on doin=
g a
> > > translation of these regardless of what transport is used (e.g. wheth=
er
> > > we emulate a PCI or a CCW device). (For details see commit 6b1e6cc785=
5b
> > > "vhost: new device IOTLB API".) On s390 this results in severe
> > > performance degradation (c.a. factor 10).
> >=20
> >=20
> > Do you see a consistent degradation on the performance, or it only=20
> > happen when for during the beginning of the test?
> >=20
>=20
> AFAIK the degradation is consistent.
>=20
> >=20
> > > BTW with ccw I/O there is
> > > (architecturally) no IOMMU, so the whole address translation makes no
> > > sense in the context of virtio-ccw.
> >=20
> >=20
> > I suspect we can do optimization in qemu side.
> >=20
> > E.g send memtable entry via IOTLB API when vIOMMU is not enabled.
> >=20
> > If this makes sense, I can draft patch to see if there's any difference.
>=20
> Frankly I would prefer to avoid IOVAs on the descriptor ring (and the
> then necessary translation) for virtio-ccw altogether. But Michael
> voiced his opinion that we should mandate F_IOMMU_PLATFORM for devices
> that could be used with guests running in protected mode. I don't share
> his opinion, but that's an ongoing discussion.

I'm a bit confused by this.  For the ccw specific case,
F_ACCESS_PLATFORM shouldn't have any impact: for you, IOVA =3D=3D GPA so
everything is easy.

> Should we end up having to do translation from IOVA in vhost, we are
> very interested in that translation being fast and efficient.
>=20
> In that sense we would be very happy to test any optimization that aim
> into that direction.
>=20
> Thank you very much for your input!
>=20
> Regards,
> Halil
>=20
> >=20
> > Thanks
> >=20
> >=20
> > >
> > > Halil Pasic (2):
> > >    mm: move force_dma_unencrypted() to mem_encrypt.h
> > >    virtio: let virtio use DMA API when guest RAM is protected
> > >
> > >   drivers/virtio/virtio_ring.c |  3 +++
> > >   include/linux/dma-direct.h   |  9 ---------
> > >   include/linux/mem_encrypt.h  | 10 ++++++++++
> > >   3 files changed, 13 insertions(+), 9 deletions(-)
> > >
> > >
> > > base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5TRUwACgkQbDjKyiDZ
s5KHhRAAzvCq4VbEVWbiYmB1ioNQU2Zls3KoMhs0PgZRddR+1P85yLT3xnHrw/LQ
g2UfyDDlqIqQgVjwHuHBTwoRWvNFm7Q72IUkh/Crwex4MlbvdSA0MIovpx9J3SSq
tjQ/No5y2xz2zsksr3T7KRh+w7EM62KyxJU1vnZj1NvlZQmHGG4tMtEpsv+rwa9R
13j0VvV9SqLMCPS7zMFge/kvOg59UqwGpFXIaILBx9TGPHAjjLNt2GZCAPAsOxmO
TIqzQwP2pooqNrLVnTvaXP3R4HUi/3V86Cys7oKnStuG95psLjB+2S8wxpfOTXS2
3pPHCTweu2xyQNReRbrjQq0aovnDdioNVFn6auGF0ilCd3xFrd0fYWG0vvW0d8f/
hlyZfoJCTCvKs60OcC7x45FKfpcU4+R8oHxdVJG/DPI6Uxbk9C5T0G/maOMxKLDO
40hJGP2SVIFtdmb8lNhlA4saVYjsR0OqH+Y+fLYi6dsl1S7FFNAhMEOOJrvhfE1O
cSSWeq2NsyY0mtTFeAtXv25yZ4t8Ed9oNnVvTXyNKkp8VKmVGz2qmH+sx1wHi4m8
UANxHkrr0V1IzMdE4Bz7TKeOVNdTQQN+0AQlwL6R+XZTpwgPAUXQbV5bLvwX+CEp
SqpVVhl9CnKeqyppaXy08CiYwdQIaze77BSX0VHTyIJq4WzI8YY=
=FeJg
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--

--===============7408810731771317058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7408810731771317058==--
