Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC64AC35646
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 13:28:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6C42073A
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 13:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6C42073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 96EAF87ED2;
	Fri, 21 Feb 2020 13:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CD-HOnd9Slsa; Fri, 21 Feb 2020 13:28:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AE59187E7A;
	Fri, 21 Feb 2020 13:28:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90103C1D81;
	Fri, 21 Feb 2020 13:28:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB714C013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 13:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B443F86381
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 13:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l0CvqN9cd_m8 for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 13:27:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 642A6861FE
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 13:27:57 +0000 (UTC)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01LDPTvV058616
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 08:27:56 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yadgdwqn2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 08:27:56 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <iommu@lists.linux-foundation.org> from <pasic@linux.ibm.com>;
 Fri, 21 Feb 2020 13:27:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 21 Feb 2020 13:27:50 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01LDRmrG20971590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2020 13:27:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DE4F5204F;
 Fri, 21 Feb 2020 13:27:48 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2DB6352052;
 Fri, 21 Feb 2020 13:27:48 +0000 (GMT)
Date: Fri, 21 Feb 2020 14:27:46 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
In-Reply-To: <20200221025915.GB2298@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220161309.GB12709@lst.de>
 <20200221025915.GB2298@umbus.fritz.box>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022113-0016-0000-0000-000002E8FC1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022113-0017-0000-0000-0000334C1C9A
Message-Id: <20200221142746.1da0881f.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-21_03:2020-02-19,
 2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210104
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
Content-Type: multipart/mixed; boundary="===============3517453799354854108=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============3517453799354854108==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/6L0zE9scbEzJxcRVxZin/tR"; protocol="application/pgp-signature"

--Sig_/6L0zE9scbEzJxcRVxZin/tR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2020 13:59:15 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Feb 20, 2020 at 05:13:09PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 867c7ebd3f10..fafc8f924955 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_devic=
e *vdev)
> > >  	if (!virtio_has_iommu_quirk(vdev))
> > >  		return true;
> > > =20
> > > +	if (force_dma_unencrypted(&vdev->dev))
> > > +		return true;
> >=20
> > Hell no.  This is a detail of the platform DMA direct implementation.
> > Drivers have no business looking at this flag, and virtio finally needs
> > to be fixed to use the DMA API properly for everything but legacy devic=
es.
>=20
> So, this patch definitely isn't right as it stands, but I'm struggling
> to understand what it is you're saying is the right way.
>=20
> By "legacy devices" I assume you mean pre-virtio-1.0 devices, that
> lack the F_VERSION_1 feature flag.  Is that right?  Because I don't
> see how being a legacy device or not relates to use of the DMA API.
>=20
> I *think* what you are suggesting here is that virtio devices that
> have !F_IOMMU_PLATFORM should have their dma_ops set up so that the
> DMA API treats IOVA=3D=3DPA, which will satisfy what the device expects.
> Then the virtio driver can use the DMA API the same way for both
> F_IOMMU_PLATFORM and !F_IOMMU_PLATFORM devices.

I've considered this idea, and as a matter a fact would be my preferred
solution. It would be, if we could use GFP_DMA when allocating coherent
memory through the DMA API. For CCW devices we *must* have some of the
device accessible memory 31 bit addressable (in physical address space),
because the s390 architecture *mandates it*. I had patches
(https://lkml.org/lkml/2019/9/23/313) that do that but Christoph was not
open to the idea.

Always pushing all the stuff allocated by virtio devices into the DMA
zone is not a good option for us. We did that for protected guests,
because that was what Christoph was willing to accept, but not happy
with it.

I'm willing to go down that rute, but I really need the capability to
tell the DMA API 'do this allocation from ZONE_DMA'. I don't care how.


>=20
> But if that works for !F_IOMMU_PLATFORM_DEVICES+F_VERSION_1 devices,
> then AFAICT it will work equally well for legacy devices.

I agree.

>=20
> Using the DMA API for *everything* in virtio, legacy or not, seems
> like a reasonable approach to me.  But, AFAICT, that does require the
> DMA layer to have some kind of explicit call to turn on this
> behaviour, which the virtio driver would call during initializsation.
> I don't think we can do it 100% within the DMA layer, because only the
> driver can reasonably know when a device has this weird non-standard
> DMA behaviour.
>=20

IMHO one could make the DMA API work with different DMA ops. The
virtio transport or the virtio core can probably intervene. But then, we
(virtio-ccw) would need the iommu=3Doff DMA ops to do the bounce buffering
iff force_dma_unencrypted().

Regards,
Halil

--Sig_/6L0zE9scbEzJxcRVxZin/tR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJeT9rSAAoJEA0vhuyXGx0AgHQP+gLGTX4Ns4WO0rTvm272UO/v
hxbJZMxeojiTFWHD4TkCbltyBOw2vVGwyCrlR264NQDgcPkDbUpp/kU5KyuUWkMx
fg6K4ZOh4ZiwczUstvV5PB0qzEbKI4lK8uktHUzvHBdo7Hkflb3adUCZekqhKgJU
E5dipJ6cqTuWGgjY9hqOhFHBphLbThSY1fUlgIv3yXFrwW0LGUX4WFETF3Mq9S5y
4Z8xR8QsjPoNEmRpP6uZhSZ7ue5i0iRpf+zgJRF/F7mP4buODibZ3rN7YGhRP+ip
LP4NDLuooYIDnVVGcDZm578p/20XCGYldebH7wIcpoJemQGMRE8ZxS3eqvqhFMS4
PhUYS8/mR8v5Hq61r85qu4R6JDHJ8yH47YEFFVO+ZLrhk4WE7/NXohjGWzimmsx7
+oaTFLiuuQvn7K3ur1KGfgiMYDt4f2x7AstT3dr1qXj+jtKLcUUsSCjRdCN/CT65
o+lpGU4sDp04ekLWOGCtyymzC4QoJq8fZ5osnQnRb+w5mbDleSUgKD8FZbX2Zonu
t8XpKJBtY3ByHi2qu0Ll/1Kx22TTtTtt4CNedhQLvzZ6BEmZtx1/yQHZ6ju3V4p+
y6kumCXn8PCdSsrnzJL2zblvZhrDuyshzKNtB2Ihgn5ksldJ6z54hUCuw/oFbZ/y
B9ZUzg5KJmqce9haoZCY
=zf/I
-----END PGP SIGNATURE-----

--Sig_/6L0zE9scbEzJxcRVxZin/tR--


--===============3517453799354854108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3517453799354854108==--

