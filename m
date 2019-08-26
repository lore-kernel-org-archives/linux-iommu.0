Return-Path: <SRS0=vyM6=WW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB21C3A59F
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 17:49:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7322184D
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 17:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7322184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 382BC2158;
	Mon, 26 Aug 2019 17:49:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 291C72166
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 17:49:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 96A66710
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 17:49:06 +0000 (UTC)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x7QHlQdD139893
	for <iommu@lists.linux-foundation.org>; Mon, 26 Aug 2019 13:49:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2umgu989ab-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Mon, 26 Aug 2019 13:49:05 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <linuxram@us.ibm.com>;
	Mon, 26 Aug 2019 18:49:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 26 Aug 2019 18:48:59 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
	[9.149.105.61])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x7QHmw6w37683404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 26 Aug 2019 17:48:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1331C11C04C;
	Mon, 26 Aug 2019 17:48:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE7C111C050;
	Mon, 26 Aug 2019 17:48:53 +0000 (GMT)
Received: from ram.ibm.com (unknown [9.85.172.199])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Mon, 26 Aug 2019 17:48:53 +0000 (GMT)
Date: Mon, 26 Aug 2019 10:48:49 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, Christoph Hellwig <hch@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
	<20190812095156.GD3947@umbus.fritz.box>
	<20190813132617.GA6426@lst.de>
	<20190813142439.GO3947@umbus.fritz.box>
	<20190813154537.GE5964@ram.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190813154537.GE5964@ram.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19082617-0008-0000-0000-0000030D8F60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082617-0009-0000-0000-00004A2BC8CB
Message-Id: <20190826174849.GA5445@ram.ibm.com>
Subject: RE: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-08-26_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1906280000 definitions=main-1908260173
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
	Paul Mackerras <paulus@ozlabs.org>,
	iommu@lists.linux-foundation.org, ram.n.pai@gmail.com,
	linuxppc-devel@lists.ozlabs.org
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
Reply-To: Ram Pai <linuxram@us.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Aug 13, 2019 at 08:45:37AM -0700, Ram Pai wrote:
> On Wed, Aug 14, 2019 at 12:24:39AM +1000, David Gibson wrote:
> > On Tue, Aug 13, 2019 at 03:26:17PM +0200, Christoph Hellwig wrote:
> > > On Mon, Aug 12, 2019 at 07:51:56PM +1000, David Gibson wrote:
> > > > AFAICT we already kind of abuse this for the VIRTIO_F_IOMMU_PLATFORM,
> > > > because to handle for cases where it *is* a device limitation, we
> > > > assume that if the hypervisor presents VIRTIO_F_IOMMU_PLATFORM then
> > > > the guest *must* select it.
> > > > 
> > > > What we actually need here is for the hypervisor to present
> > > > VIRTIO_F_IOMMU_PLATFORM as available, but not required.  Then we need
> > > > a way for the platform core code to communicate to the virtio driver
> > > > that *it* requires the IOMMU to be used, so that the driver can select
> > > > or not the feature bit on that basis.
> > > 
> > > I agree with the above, but that just brings us back to the original
> > > issue - the whole bypass of the DMA OPS should be an option that the
> > > device can offer, not the other way around.  And we really need to
> > > fix that root cause instead of doctoring around it.
> > 
> > I'm not exactly sure what you mean by "device" in this context.  Do
> > you mean the hypervisor (qemu) side implementation?
> > 
> > You're right that this was the wrong way around to begin with, but as
> > well as being hard to change now, I don't see how it really addresses
> > the current problem.  The device could default to IOMMU and allow
> > bypass, but the driver would still need to get information from the
> > platform to know that it *can't* accept that option in the case of a
> > secure VM.  Reversed sense, but the same basic problem.
> > 
> > The hypervisor does not, and can not be aware of the secure VM
> > restrictions - only the guest side platform code knows that.
> 
> This statement is almost entirely right. I will rephrase it to make it
> entirely right.   
> 
> The hypervisor does not, and can not be aware of the secure VM
> requirement that it needs to do some special processing that has nothing
> to do with DMA address translation - only the guest side platform code
> know that.
> 
> BTW: I do not consider 'bounce buffering' as 'DMA address translation'.
> DMA address translation, translates CPU address to DMA address.  Bounce
> buffering moves the data from one buffer at a given CPU address to
> another buffer at a different CPU address.  Unfortunately the current
> DMA ops conflates the two.  The need to do 'DMA address translation' 
> is something the device can enforce.  But the need to do bounce
> buffering, is something that the device should not be aware and should be
> entirely a decision made locally by the kernel/driver in the secure VM.


Christoph,

	Since we have not heard back from you, I am not sure where you
	stand on this issue now.   One of the three things are
	possible..

	(a) our above explaination did not make sense and hence
		you decided to ignore it.
	(b) our above above made some sense and need more time to think 
		and respond.
	(c) you totally forgot about this.


I hope it is (b). We want a solution that works for all, and your inputs 
are important to us.


Thanks,
RP

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
