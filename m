Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1C7C38BE0
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:51:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A41B20836
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A41B20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 16CA58700D;
	Mon, 24 Feb 2020 18:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTOY5TeMNP2j; Mon, 24 Feb 2020 18:51:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E5E28733C;
	Mon, 24 Feb 2020 18:50:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41696C18DA;
	Mon, 24 Feb 2020 18:50:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA728C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A271820500
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:50:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NBbOYhc7Sw+x for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:50:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by silver.osuosl.org (Postfix) with ESMTPS id 35C35204F7
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:50:17 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01OInpwo061947
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 13:50:16 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yb16247at-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 13:50:15 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <iommu@lists.linux-foundation.org> from <pasic@linux.ibm.com>;
 Mon, 24 Feb 2020 18:50:13 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 24 Feb 2020 18:50:10 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01OIo84236110674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 18:50:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B23511C052;
 Mon, 24 Feb 2020 18:50:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E96A211C04C;
 Mon, 24 Feb 2020 18:50:07 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2020 18:50:07 +0000 (GMT)
Date: Mon, 24 Feb 2020 19:49:53 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
In-Reply-To: <20200224033314.GC1751@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com>
 <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
 <20200221032727.GC2298@umbus.fritz.box>
 <20200221140639.54928efe.pasic@linux.ibm.com>
 <20200221104724-mutt-send-email-mst@kernel.org>
 <20200221190702.68fd57fc.pasic@linux.ibm.com>
 <20200224033314.GC1751@umbus.fritz.box>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022418-0012-0000-0000-00000389E105
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022418-0013-0000-0000-000021C68166
Message-Id: <20200224194953.37c0d6b8.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-24_07:2020-02-21,
 2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240137
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
Content-Type: multipart/mixed; boundary="===============1386928080995079911=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1386928080995079911==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/vGHA3vF9dtV+mrvkwT/xAt3"; protocol="application/pgp-signature"

--Sig_/vGHA3vF9dtV+mrvkwT/xAt3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Feb 2020 14:33:14 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Feb 21, 2020 at 07:07:02PM +0100, Halil Pasic wrote:
> > On Fri, 21 Feb 2020 10:48:15 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >=20
> > > On Fri, Feb 21, 2020 at 02:06:39PM +0100, Halil Pasic wrote:
> > > > On Fri, 21 Feb 2020 14:27:27 +1100
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >=20
> > > > > On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> > > > > > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger=
 wrote:
> > > > > > > >From a users perspective it makes absolutely perfect sense t=
o use the
> > > > > > > bounce buffers when they are NEEDED.=20
> > > > > > > Forcing the user to specify iommu_platform just because you n=
eed bounce buffers
> > > > > > > really feels wrong. And obviously we have a severe performanc=
e issue
> > > > > > > because of the indirections.
> > > > > >=20
> > > > > > The point is that the user should not have to specify iommu_pla=
tform.
> > > > > > We need to make sure any new hypervisor (especially one that mi=
ght require
> > > > > > bounce buffering) always sets it,
> > > > >=20
> > > > > So, I have draft qemu patches which enable iommu_platform by defa=
ult.
> > > > > But that's really because of other problems with !iommu_platform,=
 not
> > > > > anything to do with bounce buffering or secure VMs.
> > > > >=20
> > > > > The thing is that the hypervisor *doesn't* require bounce bufferi=
ng.
> > > > > In the POWER (and maybe s390 as well) models for Secure VMs, it's=
 the
> > > > > *guest*'s choice to enter secure mode, so the hypervisor has no r=
eason
> > > > > to know whether the guest needs bounce buffering.  As far as the
> > > > > hypervisor and qemu are concerned that's a guest internal detail,=
 it
> > > > > just expects to get addresses it can access whether those are GPAs
> > > > > (iommu_platform=3Doff) or IOVAs (iommu_platform=3Don).
> > > >=20
> > > > I very much agree!
> > > >=20
> > > > >=20
> > > > > > as was a rather bogus legacy hack
> > > > >=20
> > > > > It was certainly a bad idea, but it was a bad idea that went into=
 a
> > > > > public spec and has been widely deployed for many years.  We can't
> > > > > just pretend it didn't happen and move on.
> > > > >=20
> > > > > Turning iommu_platform=3Don by default breaks old guests, some of=
 which
> > > > > we still care about.  We can't (automatically) do it only for gue=
sts
> > > > > that need bounce buffering, because the hypervisor doesn't know t=
hat
> > > > > ahead of time.
> > > >=20
> > > > Turning iommu_platform=3Don for virtio-ccw makes no sense whatsover,
> > > > because for CCW I/O there is no such thing as IOMMU and the address=
es
> > > > are always physical addresses.
> > >=20
> > > Fix the name then. The spec calls is ACCESS_PLATFORM now, which
> > > makes much more sense.
> >=20
> > I don't quite get it. Sorry. Maybe I will revisit this later.
>=20
> Halil, I think I can clarify this.
>=20
> The "iommu_platform" flag doesn't necessarily have anything to do with
> an iommu, although it often will.  Basically it means "access guest
> memory via the bus's normal DMA mechanism" rather than "access guest
> memory using GPA, because you're the hypervisor and you can do that".
>=20

Unfortunately, I don't think this is what is conveyed to the end users.
Let's see what do we have documented:

Neither Qemu user documentation
(https://www.qemu.org/docs/master/qemu-doc.html) nor online help:
qemu-system-s390x -device virtio-net-ccw,?|grep iommu
  iommu_platform=3D<bool>  - on/off (default: false)
has any documentation on it.

But libvirt does have have documenttion on the knob that contros
iommu_platform for QEMU (when  QEMU is managed by libvirt):
"""
Virtio-related options=20

QEMU's virtio devices have some attributes related to the virtio
transport under the driver element: The iommu attribute enables the use
of emulated IOMMU by the device. The attribute ats controls the Address
Translation Service support for PCIe devices. This is needed to make use
of IOTLB support (see IOMMU device). Possible values are on or off.
Since 3.5.0=20
"""
(https://libvirt.org/formatdomain.html#elementsVirtio)

Thus it seems the only available documentation says that it "enables the use
of emulated IOMMU by the device".

And for vhost-user we have
"""
When the ``VIRTIO_F_IOMMU_PLATFORM`` feature has not been negotiated:

* Guest addresses map to the vhost memory region containing that guest
  address.

When the ``VIRTIO_F_IOMMU_PLATFORM`` feature has been negotiated:

* Guest addresses are also called I/O virtual addresses (IOVAs).  They are
  translated to user addresses via the IOTLB.
"""
(docs/interop/vhost-user.rst)

> For the case of ccw, both mechanisms end up being the same thing,
> since CCW's normal DMA *is* untranslated GPA access.
>=20

Nod.

> For this reason, the flag in the spec was renamed to ACCESS_PLATFORM,
> but the flag in qemu still has the old name.
>=20

Yes, the name in the spec is more neutral.

> AIUI, Michael is saying you could trivially change the name in qemu
> (obviously you'd need to alias the old name to the new one for
> compatibility).
>=20

I could, and the I could also ask the libvirt guys to change <driver
iommu=3D'X'> to <driver access_platform=3D'X'> or similar and to change
their documentation to something that is harder to comprehend. Although
I'm not sure they would like the idea.

>=20
> Actually, the fact that ccw has no translation makes things easier for
> you: you don't really have any impediment to turning ACCESS_PLATFORM
> on by default, since it doesn't make any real change to how things
> work.

Yeah, it should not, in theory, but currently it does in practice.
Currently vhost will try to do the IOTLB dance (Jason has a patch that
should help with that), and we get the 'use dma api' side effects in the
guest (e.g. virtqueue's data go <2G + some overhead).

>=20
> The remaining difficulty is that the virtio driver - since it can sit
> on multiple buses - won't know this, and will reject the
> ACCESS_PLATFORM flag, even though it could just do what it normally
> does on ccw and it would work.

Right ACCESS_PLATFORM is a funny feature where the device refuses to
work if the driver does not ack.

>=20
> For that case, we could consider a hack in qemu where for virtio-ccw
> devices *only* we allow the guest to nack the ACCESS_PLATFORM flag and
> carry on anyway.  Normally we insist that the guest accept the
> ACCESS_PLATFORM flag if offered, because on most platforms they
> *don't* amount to the same thing.

Jason found a nice way to differentiate between needs translation and
does not need translation. But that patch still requires the ack by the
driver (and as Michael has pointed out we have to consider migration).

I'm afraid that  F_IOMMU_PLATFORM means different things in different
contexts, and that this ain't sufficiently documented. I'm tempted to do
a proper write-up on this (let's hope my motivation will and my time
will allow). I would also very much like to have Conny's opinion on this.

Regards,
Halil







--Sig_/vGHA3vF9dtV+mrvkwT/xAt3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJeVBreAAoJEA0vhuyXGx0ARbkP/30RsQqiAI89yXrLcS/g7x69
ZQSI71PL1cJaSoeOO8NZBLMOS2Hk8qJgacIUsTTqqt/qMge4DYLZMh74ZPA7GXdc
bzgYA2zM8Y0eyM/5fCEKNROhI8XQdYVnjmy4ah0KcwJp8328lKx5TJ84AyCPyfT7
n++IdVLuzXOoVV5QkKD+bttvTVXt9zjJFayTgkJcoyCGoyVkIw/HRkTCw/XCDXQR
2TmVTtJhu04VKxue9knWDLH6twnG5MBL/BXJ8bQdTLl228RW4yDHUgvx99HZqH+1
VNSIk9fRCGG7INH/0ZjMjk9wfll2yrB97YOviQ+muj1pC4mOKoTuJjjoT+EVfuz/
4Wwot29ZqE4WVDhMeHr1sJRYH83911zgrXCDXfbNnEn4qp4XuWUyzRj9d82n+kVx
2yUq3u8tleBGNqN85xnpfpK5LppvgFkR3xJTRDPLkdUlZ4jSYKpCLmx/9i4KMvl/
P96EX9ZRLU3oxb8Ju7tZIAskIJP0uwtnHf8XpT3WQZxp0dIISv9/qh86C868jble
NMx37+iXXLQV3MA/rG08a1VyTHSqGeEdSB8ZstdKC+K6adadnn+jHUUOa2NKF1aI
X8D/xJ/mTKj+CbsE7K5S8NFAShko5RexZ0gkJWTHnT8j6Jw/aNwbeJezCxihKpRg
PaQRUIF0348PSE4t0rEt
=lt9E
-----END PGP SIGNATURE-----

--Sig_/vGHA3vF9dtV+mrvkwT/xAt3--


--===============1386928080995079911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1386928080995079911==--

