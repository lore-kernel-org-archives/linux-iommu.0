Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0380C3565A
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 18:03:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C8220722
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 18:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C8220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7B68587647;
	Fri, 21 Feb 2020 18:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iD8FSVOtvo5z; Fri, 21 Feb 2020 18:03:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EDE3D87605;
	Fri, 21 Feb 2020 18:03:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C219CC1D81;
	Fri, 21 Feb 2020 18:03:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAA9BC013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 18:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A85FC87645
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 18:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eJUD4mWbGwjr for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 18:03:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD248875AE
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 18:03:45 +0000 (UTC)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01LHxAYB143042
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 13:03:44 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubybse0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 13:03:44 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <iommu@lists.linux-foundation.org> from <pasic@linux.ibm.com>;
 Fri, 21 Feb 2020 18:03:42 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 21 Feb 2020 18:03:38 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01LI2ePe18219486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2020 18:02:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A619F42042;
 Fri, 21 Feb 2020 18:03:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DC004203F;
 Fri, 21 Feb 2020 18:03:36 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 21 Feb 2020 18:03:36 +0000 (GMT)
Date: Fri, 21 Feb 2020 19:03:34 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
In-Reply-To: <20200221104901-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220154904-mutt-send-email-mst@kernel.org>
 <20200221141230.13eebc35.pasic@linux.ibm.com>
 <20200221104901-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022118-0016-0000-0000-000002E91112
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022118-0017-0000-0000-0000334C3285
Message-Id: <20200221190334.3b03d296.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-21_06:2020-02-21,
 2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210137
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 21 Feb 2020 10:56:45 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Feb 21, 2020 at 02:12:30PM +0100, Halil Pasic wrote:
> > On Thu, 20 Feb 2020 15:55:14 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
[..]
> > > To summarize, the necessary conditions for a hack along these lines
> > > (using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:
> > > 
> > >   - secure guest mode is enabled - so we know that since we don't share
> > >     most memory regular virtio code won't
> > >     work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM
> > 
> > force_dma_unencrypted(&vdev->dev) is IMHO exactly about this.
> > 
> > >   - DMA API is giving us addresses that are actually also physical
> > >     addresses
> > 
> > In case of s390 this is given.
> > I talked with the power people before
> > posting this, and they ensured me they can are willing to deal with
> > this. I was hoping to talk abut this with the AMD SEV people here (hence
> > the cc).
> 
> We'd need a part of DMA API that promises this though. Platform
> maintainers aren't going to go out of their way to do the
> right thing just for virtio, and I can't track all arches
> to make sure they don't violate virtio requirements.
> 

One would have to track only the arches that have
force_dma_unecrypted(), and generally speaking the arches shall make
sure the DMA ops are suitable, whatever that means in the given context.

> > 
> > >   - Hypervisor is buggy and didn't enable VIRTIO_F_ACCESS_PLATFORM
> > > 
> > 
> > I don't get this point. The argument where the hypervisor is buggy is a
> > bit hard to follow for me. If hypervisor is buggy we have already lost
> > anyway most of the time, or?
> 
> If VIRTIO_F_ACCESS_PLATFORM is set then things just work.  If
> VIRTIO_F_ACCESS_PLATFORM is clear device is supposed to have access to
> all of memory.  You can argue in various ways but it's easier to just
> declare a behaviour that violates this a bug. Which might still be worth
> working around, for various reasons.
> 


I don't agree. The spec explicitly states "If this feature bit is set
to 0, then the device has same access to memory addresses supplied to it
as the driver has." That ain't any guest memory, but the addresses
supplied to it. BTW this is how channel I/O works as well: the channel
program authorizes the device to use the memory locations specified by
the channel program, for as long as the channel program is executed.
That's how channel I/O does isolation without an architected IOMMU.

Can you please show me the words in the specification that say, the
device has to have access to the entire guest memory all the time?

Maybe I have to understand all the intentions behind
VIRTIO_F_ACCESS_PLATFORM better. I've read the spec several times, but I
still have the feeling, when we discuss, that I didn't get it right.
IOMMUs and PCI style DMA are unfortunately not my bread and butter.

I only know that the devices do not need any new device capability (I
assume VIRTIO_F_ACCESS_PLATFORM does express a device capability), to
work with protected virtualization. Unless one defines
VIRTIO_F_ACCESS_PLATFORM is the capability that the device won't poke
*arbitrary* guest memory.  From that perspective mandating the flag
feels wrong. (CCW devices are never allowed to poke arbitrary
memory.)

Yet, if VIRTIO_F_ACCESS_PLATFORM is a flag that every nice and modern
virtio device should have (i.e. a lack of it means kida broken), then I
have the feeling virtio-ccw should probably evolve in the direction, that
having VIRTIO_F_ACCESS_PLATFORM set does not hurt.

I have to think some more.

> 
> > > I don't see how this patch does this.
> > 
> > I do get your point. I don't know of a good way to check that DMA API
> > is giving us addresses that are actually physical addresses, and the
> > situation you describe definitely has some risk to it.
> 
> One way would be to extend the DMA API with such an API.

Seems Christoph does not like that idea.

> 
> Another would be to make virtio always use DMA API
> and hide the logic in there.

I thought Christoph wants that, but I was wrong.

> This second approach is not easy, in particular since DMA API adds
> a bunch of overhead which we need to find ways to
> measure and mitigate.
> 

Agreed. From s390 perspective, I think it ain't to bad if we get GFP_DMA.

Many thanks for your patience!
Halil

[..]

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
