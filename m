Return-Path: <SRS0=5edT=4J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF48C35646
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 18:07:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A82208E4
	for <iommu@archiver.kernel.org>; Fri, 21 Feb 2020 18:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A82208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A8B2085829;
	Fri, 21 Feb 2020 18:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IrvVrRkdoalB; Fri, 21 Feb 2020 18:07:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 88C1181D5F;
	Fri, 21 Feb 2020 18:07:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CE8AC1D81;
	Fri, 21 Feb 2020 18:07:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89723C013E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 18:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7643481D5F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 18:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id beedSEbh-pJN for <iommu@lists.linux-foundation.org>;
 Fri, 21 Feb 2020 18:07:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 45A4B857DC
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 18:07:13 +0000 (UTC)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01LI5qpm084062
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 13:07:12 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yadge7hbf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <iommu@lists.linux-foundation.org>; Fri, 21 Feb 2020 13:07:12 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <iommu@lists.linux-foundation.org> from <pasic@linux.ibm.com>;
 Fri, 21 Feb 2020 18:07:09 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 21 Feb 2020 18:07:06 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01LI74lF55443576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2020 18:07:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BE7CAE04D;
 Fri, 21 Feb 2020 18:07:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D52EAE056;
 Fri, 21 Feb 2020 18:07:03 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 21 Feb 2020 18:07:03 +0000 (GMT)
Date: Fri, 21 Feb 2020 19:07:02 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
In-Reply-To: <20200221104724-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com>
 <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
 <20200221032727.GC2298@umbus.fritz.box>
 <20200221140639.54928efe.pasic@linux.ibm.com>
 <20200221104724-mutt-send-email-mst@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022118-0016-0000-0000-000002E91148
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022118-0017-0000-0000-0000334C32B8
Message-Id: <20200221190702.68fd57fc.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-21_06:2020-02-21,
 2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210138
Cc: linux-s390@vger.kernel.org, Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Michael Mueller <mimu@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
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

On Fri, 21 Feb 2020 10:48:15 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Feb 21, 2020 at 02:06:39PM +0100, Halil Pasic wrote:
> > On Fri, 21 Feb 2020 14:27:27 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > 
> > > On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> > > > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger wrote:
> > > > > >From a users perspective it makes absolutely perfect sense to use the
> > > > > bounce buffers when they are NEEDED. 
> > > > > Forcing the user to specify iommu_platform just because you need bounce buffers
> > > > > really feels wrong. And obviously we have a severe performance issue
> > > > > because of the indirections.
> > > > 
> > > > The point is that the user should not have to specify iommu_platform.
> > > > We need to make sure any new hypervisor (especially one that might require
> > > > bounce buffering) always sets it,
> > > 
> > > So, I have draft qemu patches which enable iommu_platform by default.
> > > But that's really because of other problems with !iommu_platform, not
> > > anything to do with bounce buffering or secure VMs.
> > > 
> > > The thing is that the hypervisor *doesn't* require bounce buffering.
> > > In the POWER (and maybe s390 as well) models for Secure VMs, it's the
> > > *guest*'s choice to enter secure mode, so the hypervisor has no reason
> > > to know whether the guest needs bounce buffering.  As far as the
> > > hypervisor and qemu are concerned that's a guest internal detail, it
> > > just expects to get addresses it can access whether those are GPAs
> > > (iommu_platform=off) or IOVAs (iommu_platform=on).
> > 
> > I very much agree!
> > 
> > > 
> > > > as was a rather bogus legacy hack
> > > 
> > > It was certainly a bad idea, but it was a bad idea that went into a
> > > public spec and has been widely deployed for many years.  We can't
> > > just pretend it didn't happen and move on.
> > > 
> > > Turning iommu_platform=on by default breaks old guests, some of which
> > > we still care about.  We can't (automatically) do it only for guests
> > > that need bounce buffering, because the hypervisor doesn't know that
> > > ahead of time.
> > 
> > Turning iommu_platform=on for virtio-ccw makes no sense whatsover,
> > because for CCW I/O there is no such thing as IOMMU and the addresses
> > are always physical addresses.
> 
> Fix the name then. The spec calls is ACCESS_PLATFORM now, which
> makes much more sense.

I don't quite get it. Sorry. Maybe I will revisit this later.

Regards,
Halil

> 
> > > 
> > > > that isn't extensibe for cases that for example require bounce buffering.
> > > 
> > > In fact bounce buffering isn't really the issue from the hypervisor
> > > (or spec's) point of view.  It's the fact that not all of guest memory
> > > is accessible to the hypervisor.  Bounce buffering is just one way the
> > > guest might deal with that.
> > > 
> > 
> > Agreed.
> > 
> > Regards,
> > Halil
> > 
> > 
> > 
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
