Return-Path: <SRS0=4AON=WJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E258FC433FF
	for <iommu@archiver.kernel.org>; Tue, 13 Aug 2019 15:46:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF359205F4
	for <iommu@archiver.kernel.org>; Tue, 13 Aug 2019 15:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF359205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7D8BACF3;
	Tue, 13 Aug 2019 15:45:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D277ACF3
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 15:45:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 04BC88A7
	for <iommu@lists.linux-foundation.org>;
	Tue, 13 Aug 2019 15:45:51 +0000 (UTC)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x7DFXSt8037340
	for <iommu@lists.linux-foundation.org>; Tue, 13 Aug 2019 11:45:51 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ubxx9uu4c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Tue, 13 Aug 2019 11:45:50 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <linuxram@us.ibm.com>;
	Tue, 13 Aug 2019 16:45:49 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 13 Aug 2019 16:45:44 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x7DFjgol60096752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 13 Aug 2019 15:45:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D35FFA4054;
	Tue, 13 Aug 2019 15:45:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D140A4060;
	Tue, 13 Aug 2019 15:45:40 +0000 (GMT)
Received: from ram.ibm.com (unknown [9.85.191.17])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Aug 2019 15:45:40 +0000 (GMT)
Date: Tue, 13 Aug 2019 08:45:37 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
	<20190812095156.GD3947@umbus.fritz.box>
	<20190813132617.GA6426@lst.de>
	<20190813142439.GO3947@umbus.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190813142439.GO3947@umbus.fritz.box>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081315-0012-0000-0000-0000033E3613
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081315-0013-0000-0000-000021784637
Message-Id: <20190813154537.GE5964@ram.ibm.com>
Subject: RE: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-08-13_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=811 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1906280000 definitions=main-1908130159
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
	Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org,
	linuxppc-devel@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
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

On Wed, Aug 14, 2019 at 12:24:39AM +1000, David Gibson wrote:
> On Tue, Aug 13, 2019 at 03:26:17PM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 12, 2019 at 07:51:56PM +1000, David Gibson wrote:
> > > AFAICT we already kind of abuse this for the VIRTIO_F_IOMMU_PLATFORM,
> > > because to handle for cases where it *is* a device limitation, we
> > > assume that if the hypervisor presents VIRTIO_F_IOMMU_PLATFORM then
> > > the guest *must* select it.
> > > 
> > > What we actually need here is for the hypervisor to present
> > > VIRTIO_F_IOMMU_PLATFORM as available, but not required.  Then we need
> > > a way for the platform core code to communicate to the virtio driver
> > > that *it* requires the IOMMU to be used, so that the driver can select
> > > or not the feature bit on that basis.
> > 
> > I agree with the above, but that just brings us back to the original
> > issue - the whole bypass of the DMA OPS should be an option that the
> > device can offer, not the other way around.  And we really need to
> > fix that root cause instead of doctoring around it.
> 
> I'm not exactly sure what you mean by "device" in this context.  Do
> you mean the hypervisor (qemu) side implementation?
> 
> You're right that this was the wrong way around to begin with, but as
> well as being hard to change now, I don't see how it really addresses
> the current problem.  The device could default to IOMMU and allow
> bypass, but the driver would still need to get information from the
> platform to know that it *can't* accept that option in the case of a
> secure VM.  Reversed sense, but the same basic problem.
> 
> The hypervisor does not, and can not be aware of the secure VM
> restrictions - only the guest side platform code knows that.

This statement is almost entirely right. I will rephrase it to make it
entirely right.   

The hypervisor does not, and can not be aware of the secure VM
requirement that it needs to do some special processing that has nothing
to do with DMA address translation - only the guest side platform code
know that.

BTW: I do not consider 'bounce buffering' as 'DMA address translation'.
DMA address translation, translates CPU address to DMA address.  Bounce
buffering moves the data from one buffer at a given CPU address to
another buffer at a different CPU address.  Unfortunately the current
DMA ops conflates the two.  The need to do 'DMA address translation' 
is something the device can enforce.  But the need to do bounce
buffering, is something that the device should not be aware and should be
entirely a decision made locally by the kernel/driver in the secure VM.

RP

> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



-- 
Ram Pai

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
