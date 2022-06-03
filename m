Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1351C43334
	for <iommu@archiver.kernel.org>; Fri,  3 Jun 2022 14:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D4FC4046B;
	Fri,  3 Jun 2022 14:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cc1ZOoh8puNz; Fri,  3 Jun 2022 14:53:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 038C240137;
	Fri,  3 Jun 2022 14:53:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C23C3C0032;
	Fri,  3 Jun 2022 14:53:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48EABC002D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 14:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 293F784099
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 14:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RVXTR5Hsgzeo for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 14:53:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2611984065
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 14:53:13 +0000 (UTC)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253DoeFj009820;
 Fri, 3 Jun 2022 14:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ZsyfiaSF8s1Rdnxxm8UOnRJxjQ5WWAHBRYLJbTV2KKE=;
 b=IrULW35fM4Lq0CR3+xfjmVGxdPjLHbybBrMthk2+Vw5OsQA8of+D5WR/qJ0ITcSnH9ev
 TMbuVA/ASw9IFJVJkmrgGSCYo1Z2FIN8aIVrFHgXwCIA6aM81UvVv7cgSydDhj+UUBGk
 ELnSdWWKQwctREGUquU0/vZJPSP0BqiUj9J6ZqF5kPervcFkmskHefgi+zhqgh6pCju6
 r5UErWR9KoergSJ33JhdsBDJF+OU8pppQm+pYULDgkZag71xgVSow2/hy3ScKqHGH8Xp
 FjX87klmVfl/d9uVwRGP+FlYitDJWCVziEBRO0XCrtHbUj+c3ZjIGOCGrAaQsQDCZzui mQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfkhu1a3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jun 2022 14:53:06 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253EpSQ0000399;
 Fri, 3 Jun 2022 14:53:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma02fra.de.ibm.com with ESMTP id 3gbcc6ehtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jun 2022 14:53:04 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 253Er2kP35258734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jun 2022 14:53:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 521B44C052;
 Fri,  3 Jun 2022 14:53:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA58A4C04A;
 Fri,  3 Jun 2022 14:53:01 +0000 (GMT)
Received: from sig-9-145-190-168.de.ibm.com (unknown [9.145.190.168])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jun 2022 14:53:01 +0000 (GMT)
Message-ID: <984986721d6d0a7e8ffeb90a8fd6103772eab286.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/9] Add dynamic iommu backed bounce buffers
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: David Stevens <stevensd@chromium.org>
Date: Fri, 03 Jun 2022 16:53:01 +0200
In-Reply-To: <CAD=HUj62m_P53nr-Zz4bO4Bsn_tgauWX3a28MgRgsB2xShB4Hg@mail.gmail.com>
References: <20210806103423.3341285-1-stevensd@google.com>
 <48f72bbddb099b474d7917ff0e7c14a271d31350.camel@linux.ibm.com>
 <CAD=HUj62m_P53nr-Zz4bO4Bsn_tgauWX3a28MgRgsB2xShB4Hg@mail.gmail.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NTOsrkM3_fGrBKP6mHPHeAfGwvaD4LdK
X-Proofpoint-GUID: NTOsrkM3_fGrBKP6mHPHeAfGwvaD4LdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_05,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030062
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Fri, 2022-05-27 at 10:25 +0900, David Stevens wrote:
> On Tue, May 24, 2022 at 9:27 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > On Fri, 2021-08-06 at 19:34 +0900, David Stevens wrote:
> > > From: David Stevens <stevensd@chromium.org>
> > > 
> > > This patch series adds support for per-domain dynamic pools of iommu
> > > bounce buffers to the dma-iommu API. This allows iommu mappings to be
> > > reused while still maintaining strict iommu protection.
> > > 
> > > This bounce buffer support is used to add a new config option that, when
> > > enabled, causes all non-direct streaming mappings below a configurable
> > > size to go through the bounce buffers. This serves as an optimization on
> > > systems where manipulating iommu mappings is very expensive. For
> > > example, virtio-iommu operations in a guest on a linux host require a
> > > vmexit, involvement the VMM, and a VFIO syscall. For relatively small
> > > DMA operations, memcpy can be significantly faster.
> > > 
> > > As a performance comparison, on a device with an i5-10210U, I ran fio
> > > with a VFIO passthrough NVMe drive and virtio-iommu with '--direct=1
> > > --rw=read --ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k,
> > > and 128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
> > > spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
> > > 94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
> > > by >99%, as bounce buffers don't require syncing here in the read case.
> > > Running with multiple jobs doesn't serve as a useful performance
> > > comparison because virtio-iommu and vfio_iommu_type1 both have big
> > > locks that significantly limit mulithreaded DMA performance.
> > > 
> > > These pooled bounce buffers are also used for subgranule mappings with
> > > untrusted devices, replacing the single use bounce buffers used
> > > currently. The biggest difference here is that the new implementation
> > > maps a whole sglist using a single bounce buffer. The new implementation
> > > does not support using bounce buffers for only some segments of the
> > > sglist, so it may require more copying. However, the current
> > > implementation requires per-segment iommu map/unmap operations for all
> > > untrusted sglist mappings (fully aligned sglists included). On a
> > > i5-10210U laptop with the internal NVMe drive made to appear untrusted,
> > > fio --direct=1 --rw=read --ioengine=libaio --iodepth=64 --bs=64k showed
> > > a statistically significant decrease in CPU load from 2.28% -> 2.17%
> > > with the new iommu bounce buffer optimization enabled.
> > > 
> > > Each domain's buffer pool is split into multiple power-of-2 size
> > > classes. Each class allocates a fixed number of buffer slot metadata. A
> > > large iova range is allocated, and each slot is assigned an iova from
> > > the range. This allows the iova to be easily mapped back to the slot,
> > > and allows the critical section of most pool operations to be constant
> > > time. The one exception is finding a cached buffer to reuse. These are
> > > only separated according to R/W permissions - the use of other
> > > permissions such as IOMMU_PRIV may require a linear search through the
> > > cache. However, these other permissions are rare and likely exhibit high
> > > locality, so the should not be a bottleneck in practice.
> > > 
> > > Since untrusted devices may require bounce buffers, each domain has a
> > > fallback rbtree to manage single use buffers. This may be necessary if a
> > > very large number of DMA operations are simultaneously in-flight, or for
> > > very large individual DMA operations.
> > > 
> > > This patch set does not use swiotlb. There are two primary ways in which
> > > swiotlb isn't compatible with per-domain buffer pools. First, swiotlb
> > > allocates buffers to be compatible with a single device, whereas
> > > per-domain buffer pools don't handle that during buffer allocation as a
> > > single buffer may end up being used by multiple devices. Second, swiotlb
> > > allocation establishes the original to bounce buffer mapping, which
> > > again doesn't work if buffers can be reused. Effectively the only code
> > > that can be shared between the two use cases is allocating slots from
> > > the swiotlb's memory. However, given that we're going to be allocating
> > > memory for use with an iommu, allocating memory from a block of memory
> > > explicitly set aside to deal with a lack of iommu seems kind of
> > > contradictory. At best there might be a small performance improvement if
> > > wiotlb allocation is faster than regular page allocation, but buffer
> > > allocation isn't on the hot path anyway.
> > > 
> > > Not using the swiotlb has the benefit that memory doesn't have to be
> > > preallocated. Instead, bounce buffers consume memory only for in-flight
> > > dma transactions (ignoring temporarily cached buffers), which is the
> > > smallest amount possible. This makes it easier to use bounce buffers as
> > > an optimization on systems with large numbers of devices or in
> > > situations where devices are unknown, since it is not necessary to try
> > > to tune how much memory needs to be set aside to achieve good
> > > performance without costing too much memory.
> > > 
> > > Finally, this series adds a new DMA_ATTR_PERSISTENT_STREAMING flag. This
> > > is meant to address devices which create long lived streaming mappings
> > > but manage CPU cache coherency without using the dma_sync_* APIs.
> > > Currently, these devices don't function properly with swiotlb=force. The
> > > new flag is used to bypass bounce buffers so such devices will function
> > > when the new bounce buffer optimization is enabled. The flag is added to
> > > the i915 driver, which creates such mappings. It can also be added to
> > > various dma-buf implementations as an optimization, although that is not
> > > done here.
> > > 
> > > v1 -> v2:
> > >  - Replace existing untrusted bounce buffers with new bounce
> > >    buffer pools. This includes significant rework to account for
> > >    untrusted bounce buffers being required instead of an
> > >    optimization.
> > >  - Add flag for persistent streaming mappings.
> > > 
> > 
> > Hi David,
> > 
> > I'm currently looking into converting s390 from our custom IOMMU based
> > DMA API implementation to using dma-iommu.c. We're always using an
> > IOMMU for PCI devices even when doing pass-through to guests (under
> > both the KVM and z/VM hypervisors). In this case I/O TLB flushes, which
> > we use to do the shadowing of the guest I/O translations, are
> > relatively expensive I'm thus very interested in your work. I've tried
> > rebasing it on v5.18 and got it to compile but didn't get DMA to work
> > though it seems to partially work as I don't get probe failures unlike
> > with a completely broken DMA API. Since I might have very well screwed
> > up the rebase and my DMA API conversion is experimental too I was
> > wondering if you're still working on this and might have a current
> > version I could experiment with?
> 
> Unfortunately I don't have anything more recent to share. I've come
> across some performance issues caused by pathological usage patterns
> in internal usage, but I haven't seen any correctness issues. I'm
> hoping that I'll be able to address the performance issues and send a
> rebased series within the next month or so.
> 
> It's definitely possible that this series has some bugs. I've tested
> it on a range of chromebooks and their various hardware and drivers,
> but that's still all relatively normal x86_64/arm64. If your hardware
> is more particular about its DMA, this series might be missing
> something.
> 
> -David


Hi David,

Thanks for the answer. The only unusual thing about our DMA is that we
only do 64 bit DMA and IOVAs are always >2^32. I don't think I
triggered a bug in your code though, rather I think I made some mistake
in the rebase onto 5.18 as some of the APIs changed a bit. I'm out next
week but may try it again and possibly just test on x86_64 if it
doesn't work on s390. If you have anything new I'd be interested to
hear of course. Also could you say anything more about the pathological
usage patterns?

Thanks,
Niklas

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
