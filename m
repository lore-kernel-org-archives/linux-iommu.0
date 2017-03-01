From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC Design Doc v3] Enable Shared Virtual Memory feature in
	pass-through scenarios
Date: Wed, 1 Mar 2017 06:51:22 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C4FF94@SHSMSX101.ccr.corp.intel.com>
References: <A2975661238FB949B60364EF0F2C257436DE3165@shsmsx102.ccr.corp.intel.com>
	<20170228220719.GD2352@char.us.ORACLE.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170228220719.GD2352-he5eyhs8q0A6W680SEFli9BPR1lH4CV8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Peng,
	Chao P" <chao.p.peng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hao,
	Xudong" <xudong.hao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "Sun,
	Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org]
> Sent: Wednesday, March 01, 2017 6:07 AM
> 
> On Wed, Nov 30, 2016 at 08:49:24AM +0000, Liu, Yi L wrote:
> > What's changed from v2:
> > a) Detailed feature description
> > b) refine description in "Address translation in virtual SVM"
> > b) "Terms" is added
> >
> > Content
> > ===============================================
> > 1. Feature description
> > 2. Why use it?
> > 3. How to enable it
> > 4. How to test
> > 5. Terms
> >
> > Details
> > ===============================================
> > 1. Feature description
> > Shared virtual memory(SVM) is to let application program share its virtual
> > address with SVM capable devices.
> >
> > Shared virtual memory details:
> > a) SVM feature requires ATS/PRQ/PASID support on both device side and
> > IOMMU side.
> > b) SVM capable devices could send DMA requests with PASID, the address
> > in the request would be a virtual address within a program's virtual address
> > space.
> > c) IOMMU would use first level page table to translate the address in the
> > request.
> > d) First level page table is a HVA->HPA mapping on bare metal.
> >
> > Shared Virtual Memory feature in pass-through scenarios is actually SVM
> > virtualization. It is to let application programs(running in guest)share their
> > virtual address with assigned device(e.g. graphics processors or accelerators).
> 
> I think I am missing something obvious, but the current way that DRM
> works is that the kernel sets up its VA addresses for the GPU and it uses
> that for its ring. It also setups an user level mapping for the GPU if the
> application (Xorg) really wants it - but most of the time the kernel is
> in charge of poking at the ring, and the memory that is shared with the
> Xorg is normal RAM allocated via alloc_pages (see
> drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> and drivers/gpu/drm/ttm/ttm_page_alloc.c).
> 
> So are talking about the guest applications having access to the
> ring of the GPU?

No. SVM is purely about sharing CPU address space with device. Command
submission is still through kernel driver which controls rings (with SVM then
you can put VA into those commands). There are other vendor specific 
features to enable direct user space submission which is orthogonal to SVM.

Thanks
Kevin
