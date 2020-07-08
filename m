Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB586C433DF
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 07:57:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7876820672
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 07:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7876820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 472F1894BC;
	Wed,  8 Jul 2020 07:57:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BOrqOH8Ui4dO; Wed,  8 Jul 2020 07:57:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4AF6E894B2;
	Wed,  8 Jul 2020 07:57:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ED73C0893;
	Wed,  8 Jul 2020 07:57:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EA3DC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 07:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 48382894B8
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 07:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kn-h-0foch4l for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 07:57:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 106F8894B2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 07:57:36 +0000 (UTC)
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 41A63D2E46B7DB4B1399;
 Wed,  8 Jul 2020 15:57:26 +0800 (CST)
Received: from DGGEMI424-HUB.china.huawei.com (10.1.199.153) by
 dggemi403-hub.china.huawei.com (10.3.17.136) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 8 Jul 2020 15:57:25 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 DGGEMI424-HUB.china.huawei.com ([10.1.199.153]) with mapi id 14.03.0487.000;
 Wed, 8 Jul 2020 15:57:23 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH net] xsk: remove cheap_dma optimization
Thread-Topic: [PATCH net] xsk: remove cheap_dma optimization
Thread-Index: AQHWS7/pzfMg3B6anUq8fHsEY1HhhKjq/YSAgACHKgCAAj1zgIABd7YAgA2QnQCAAJazMA==
Date: Wed, 8 Jul 2020 07:57:23 +0000
Message-ID: <B926444035E5E2439431908E3842AFD255E99A@DGGEMI525-MBS.china.huawei.com>
References: <20200626134358.90122-1-bjorn.topel@gmail.com>
 <c60dfb5a-2bf3-20bd-74b3-6b5e215f73f8@iogearbox.net>
 <20200627070406.GB11854@lst.de>
 <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
 <878626a2-6663-0d75-6339-7b3608aa4e42@arm.com> <20200708065014.GA5694@lst.de>
In-Reply-To: <20200708065014.GA5694@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.214]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "maximmi@mellanox.com" <maximmi@mellanox.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "magnus.karlsson@intel.com" <magnus.karlsson@intel.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-owner@vger.kernel.org]
> On Behalf Of Christoph Hellwig
> Sent: Wednesday, July 8, 2020 6:50 PM
> To: Robin Murphy <robin.murphy@arm.com>
> Cc: Bj=F6rn T=F6pel <bjorn.topel@intel.com>; Christoph Hellwig <hch@lst.d=
e>;
> Daniel Borkmann <daniel@iogearbox.net>; maximmi@mellanox.com;
> konrad.wilk@oracle.com; jonathan.lemon@gmail.com;
> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> netdev@vger.kernel.org; bpf@vger.kernel.org; davem@davemloft.net;
> magnus.karlsson@intel.com
> Subject: Re: [PATCH net] xsk: remove cheap_dma optimization
> =

> On Mon, Jun 29, 2020 at 04:41:16PM +0100, Robin Murphy wrote:
> > On 2020-06-28 18:16, Bj=F6rn T=F6pel wrote:
> >>
> >> On 2020-06-27 09:04, Christoph Hellwig wrote:
> >>> On Sat, Jun 27, 2020 at 01:00:19AM +0200, Daniel Borkmann wrote:
> >>>> Given there is roughly a ~5 weeks window at max where this removal
> could
> >>>> still be applied in the worst case, could we come up with a fix /
> >>>> proposal
> >>>> first that moves this into the DMA mapping core? If there is somethi=
ng
> >>>> that
> >>>> can be agreed upon by all parties, then we could avoid re-adding the=
 9%
> >>>> slowdown. :/
> >>>
> >>> I'd rather turn it upside down - this abuse of the internals blocks w=
ork
> >>> that has basically just missed the previous window and I'm not going
> >>> to wait weeks to sort out the API misuse.=A0 But we can add optimizat=
ions
> >>> back later if we find a sane way.
> >>>
> >>
> >> I'm not super excited about the performance loss, but I do get
> >> Christoph's frustration about gutting the DMA API making it harder for
> >> DMA people to get work done. Lets try to solve this properly using
> >> proper DMA APIs.
> >>
> >>
> >>> That being said I really can't see how this would make so much of a
> >>> difference.=A0 What architecture and what dma_ops are you using for
> >>> those measurements?=A0 What is the workload?
> >>>
> >>
> >> The 9% is for an AF_XDP (Fast raw Ethernet socket. Think AF_PACKET, but
> >> faster.) benchmark: receive the packet from the NIC, and drop it. The =
DMA
> >> syncs stand out in the perf top:
> >>
> >>  =A0 28.63%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [k] i40e_clean_rx_irq_zc
> >>  =A0 17.12%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [k] xp_alloc
> >>  =A0=A0 8.80%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [k] __xsk_rcv_zc
> >>  =A0=A0 7.69%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [k] xdp_do_redirect
> >>  =A0=A0 5.35%=A0 bpf_prog_992d9ddc835e5629=A0 [k]
> bpf_prog_992d9ddc835e5629
> >>  =A0=A0 4.77%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [k] xsk_rcv.part.0
> >>  =A0=A0 4.07%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [k] __xsk_map_redirect
> >>  =A0=A0 3.80%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [k]
> dma_direct_sync_single_for_cpu
> >>  =A0=A0 3.03%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [k]
> dma_direct_sync_single_for_device
> >>  =A0=A0 2.76%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [k]
> i40e_alloc_rx_buffers_zc
> >>  =A0=A0 1.83%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [k] xsk_flush
> >> ...
> >>
> >> For this benchmark the dma_ops are NULL (dma_is_direct() =3D=3D true),=
 and
> >> the main issue is that SWIOTLB is now unconditionally enabled [1] for
> >> x86, and for each sync we have to check that if is_swiotlb_buffer()
> >> which involves a some costly indirection.
> >>
> >> That was pretty much what my hack avoided. Instead we did all the chec=
ks
> >> upfront, since AF_XDP has long-term DMA mappings, and just set a flag
> >> for that.
> >>
> >> Avoiding the whole "is this address swiotlb" in
> >> dma_direct_sync_single_for_{cpu, device]() per-packet
> >> would help a lot.
> >
> > I'm pretty sure that's one of the things we hope to achieve with the
> > generic bypass flag :)
> >
> >> Somewhat related to the DMA API; It would have performance benefits for
> >> AF_XDP if the DMA range of the mapped memory was linear, i.e. by IOMMU
> >> utilization. I've started hacking a thing a little bit, but it would be
> >> nice if such API was part of the mapping core.
> >>
> >> Input: array of pages Output: array of dma addrs (and obviously dev,
> >> flags and such)
> >>
> >> For non-IOMMU len(array of pages) =3D=3D len(array of dma addrs)
> >> For best-case IOMMU len(array of dma addrs) =3D=3D 1 (large linear spa=
ce)
> >>
> >> But that's for later. :-)
> >
> > FWIW you will typically get that behaviour from IOMMU-based
> implementations
> > of dma_map_sg() right now, although it's not strictly guaranteed. If you
> > can weather some additional setup cost of calling
> > sg_alloc_table_from_pages() plus walking the list after mapping to test
> > whether you did get a contiguous result, you could start taking advanta=
ge
> > of it as some of the dma-buf code in DRM and v4l2 does already (although
> > those cases actually treat it as a strict dependency rather than an
> > optimisation).
> =

> Yikes.
> =

> > I'm inclined to agree that if we're going to see more of these cases, a=
 new
> > API call that did formally guarantee a DMA-contiguous mapping (either v=
ia
> > IOMMU or bounce buffering) or failure might indeed be handy.
> =

> I was planning on adding a dma-level API to add more pages to an
> IOMMU batch, but was waiting for at least the intel IOMMU driver to be
> converted to the dma-iommu code (and preferably arm32 and s390 as well).
> =

> Here is my old pseudo-code sketch for what I was aiming for from the
> block/nvme perspective.  I haven't even implemented it yet, so there might
> be some holes in the design:
> =

> =

> /*
>  * Returns 0 if batching is possible, postitive number of segments requir=
ed
>  * if batching is not possible, or negatie values on error.
>  */
> int dma_map_batch_start(struct device *dev, size_t rounded_len,
> 	enum dma_data_direction dir, unsigned long attrs, dma_addr_t *addr);
> int dma_map_batch_add(struct device *dev, dma_addr_t *addr, struct page
> *page,
> 		unsigned long offset, size_t size);
> int dma_map_batch_end(struct device *dev, int ret, dma_addr_t start_addr);
> =


Hello Christoph,

What is the different between dma_map_batch_add() and adding the buffer to =
sg of dma_map_sg()?

> int blk_dma_map_rq(struct device *dev, struct request *rq,
> 		enum dma_data_direction dir, unsigned long attrs,
> 		dma_addr_t *start_addr, size_t *len)
> {
> 	struct req_iterator iter;
> 	struct bio_vec bvec;
> 	dma_addr_t next_addr;
> 	int ret;
> =

> 	if (number_of_segments(req) =3D=3D 1) {
> 		// plain old dma_map_page();
> 		return 0;
> 	}
> =

> 	// XXX: block helper for rounded_len?
> 	*len =3D length_of_request(req);
> 	ret =3D dma_map_batch_start(dev, *len, dir, attrs, start_addr);
> 	if (ret)
> 		return ret;
> =

> 	next_addr =3D *start_addr;
> 	rq_for_each_segment(bvec, rq, iter) {
> 		ret =3D dma_map_batch_add(dev, &next_addr, bvec.bv_page,
> 				bvec.bv_offset, bvev.bv_len);
> 		if (ret)
> 			break;
> 	}
> =

> 	return dma_map_batch_end(dev, ret, *start_addr);
> }
> =

> dma_addr_t blk_dma_map_bvec(struct device *dev, struct bio_vec *bvec,
> 		enum dma_data_direction dir, unsigned long attrs)
> {
> 	return dma_map_page_attrs(dev, bv_page, bvec.bv_offset, bvev.bv_len,
> 			dir, attrs);
> }
> =

> int queue_rq()
> {
> 	dma_addr_t addr;
> 	int ret;
> =

> 	ret =3D blk_dma_map_rq(dev, rq, dir, attrs. &addr, &len);
> 	if (ret < 0)
> 		return ret;
> =

> 	if (ret =3D=3D 0) {
> 		if (use_sgl()) {
> 			nvme_pci_sgl_set_data(&cmd->dptr.sgl, addr, len);
> 		} else {
> 			set_prps();
> 		}
> 		return;
> 	}
> =

> 	if (use_sgl()) {
> 		alloc_one_sgl_per_segment();
> =

> 		rq_for_each_segment(bvec, rq, iter) {
> 			addr =3D blk_dma_map_bvec(dev, &bdev, dir, 0);
> 			set_one_sgl();
> 		}
> 	} else {
> 		alloc_one_prp_per_page();
> =

> 		rq_for_each_segment(bvec, rq, iter) {
> 			ret =3D blk_dma_map_bvec(dev, &bdev, dir, 0);
> 			if (ret)
> 				break;
> 			set_prps();
> 	}
> }

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
