Return-Path: <SRS0=er0l=WG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F61C32751
	for <iommu@archiver.kernel.org>; Sat, 10 Aug 2019 22:07:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA51D208C4
	for <iommu@archiver.kernel.org>; Sat, 10 Aug 2019 22:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA51D208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 985EF481;
	Sat, 10 Aug 2019 22:07:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BA0A19D
	for <iommu@lists.linux-foundation.org>;
	Sat, 10 Aug 2019 22:07:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 136267D2
	for <iommu@lists.linux-foundation.org>;
	Sat, 10 Aug 2019 22:07:17 +0000 (UTC)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x7AM6wxu124761
	for <iommu@lists.linux-foundation.org>; Sat, 10 Aug 2019 18:07:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2u9t2jgtfj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Sat, 10 Aug 2019 18:07:16 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <linuxram@us.ibm.com>;
	Sat, 10 Aug 2019 23:07:14 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Sat, 10 Aug 2019 23:07:12 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
	[9.149.105.58])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x7AM7A6540829368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Sat, 10 Aug 2019 22:07:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67EFF4C046;
	Sat, 10 Aug 2019 22:07:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 411074C044;
	Sat, 10 Aug 2019 22:07:06 +0000 (GMT)
Received: from ram.ibm.com (unknown [9.85.188.164])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Sat, 10 Aug 2019 22:07:05 +0000 (GMT)
Date: Sat, 10 Aug 2019 15:07:02 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190810143038-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081022-4275-0000-0000-000003579D45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081022-4276-0000-0000-00003869A755
Message-Id: <20190810220702.GA5964@ram.ibm.com>
Subject: RE: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-08-10_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1906280000 definitions=main-1908100247
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
	Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org,
	linuxppc-devel@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
	David Gibson <david@gibson.dropbear.id.au>
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

On Sat, Aug 10, 2019 at 02:57:17PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jan 29, 2019 at 03:08:12PM -0200, Thiago Jung Bauermann wrote:
> > 
> > Hello,
> > 
> > With Christoph's rework of the DMA API that recently landed, the patch
> > below is the only change needed in virtio to make it work in a POWER
> > secure guest under the ultravisor.
> > 
> > The other change we need (making sure the device's dma_map_ops is NULL
> > so that the dma-direct/swiotlb code is used) can be made in
> > powerpc-specific code.
> > 
> > Of course, I also have patches (soon to be posted as RFC) which hook up
> > <linux/mem_encrypt.h> to the powerpc secure guest support code.
> > 
> > What do you think?
> > 
> > >From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > Date: Thu, 24 Jan 2019 22:08:02 -0200
> > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
> > 
> > The host can't access the guest memory when it's encrypted, so using
> > regular memory pages for the ring isn't an option. Go through the DMA API.
> > 
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cd7e755484e3..321a27075380 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * not work without an even larger kludge.  Instead, enable
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> > +	 *
> > +	 * Also, if guest memory is encrypted the host can't access
> > +	 * it directly. In this case, we'll need to use the DMA API.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_domain() || sev_active())
> >  		return true;
> > 
> >  	return false;
> 
> So I gave this lots of thought, and I'm coming round to
> basically accepting something very similar to this patch.
> 
> But not exactly like this :).
> 
> Let's see what are the requirements.
> 
> If
> 
> 1. We do not trust the device (so we want to use a bounce buffer with it)
> 2. DMA address is also a physical address of a buffer
> 
> then we should use DMA API with virtio.
> 
> 
> sev_active() above is one way to put (1).  I can't say I love it but
> it's tolerable.
> 
> 
> But we also want promise from DMA API about 2.
> 
> 
> Without promise 2 we simply can't use DMA API with a legacy device.
> 
> 
> Otherwise, on a SEV system with an IOMMU which isn't 1:1
> and with a virtio device without ACCESS_PLATFORM, we are trying
> to pass a virtual address, and devices without ACCESS_PLATFORM
> can only access CPU physical addresses.
> 
> So something like:
> 
> dma_addr_is_phys_addr?


On our Secure pseries platform,  dma address is physical address and this
proposal will help us, use DMA API. 

On our normal pseries platform, dma address is physical address too.
But we do not necessarily need to use the DMA API.  We can use the DMA
API, but our handlers will do the same thing, the generic virtio handlers
would do. If there is an opt-out option; even when dma addr is same as
physical addr, than there will be less code duplication.

Would something like this be better.

(dma_addr_is_phys_addr  && arch_want_to_use_dma_api()) ?


RP


> -- 
> MST

-- 
Ram Pai

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
