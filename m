From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC Design Doc v3] Enable Shared Virtual Memory feature in
	pass-through scenarios
Date: Wed, 1 Mar 2017 16:09:38 -0500
Message-ID: <20170301210938.GE9043@char.us.ORACLE.com>
References: <A2975661238FB949B60364EF0F2C257436DE3165@shsmsx102.ccr.corp.intel.com>
	<20170228220719.GD2352@char.us.ORACLE.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C4FF94@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190C4FF94-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Peng,
	Chao P" <chao.p.peng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Hao, Xudong" <xudong.hao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "Sun,
	Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

.snip..
> > > Shared Virtual Memory feature in pass-through scenarios is actually SVM
> > > virtualization. It is to let application programs(running in guest)share their
> > > virtual address with assigned device(e.g. graphics processors or accelerators).
> > 
> > I think I am missing something obvious, but the current way that DRM
> > works is that the kernel sets up its VA addresses for the GPU and it uses
> > that for its ring. It also setups an user level mapping for the GPU if the
> > application (Xorg) really wants it - but most of the time the kernel is
> > in charge of poking at the ring, and the memory that is shared with the
> > Xorg is normal RAM allocated via alloc_pages (see
> > drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> > and drivers/gpu/drm/ttm/ttm_page_alloc.c).
> > 
> > So are talking about the guest applications having access to the
> > ring of the GPU?
> 
> No. SVM is purely about sharing CPU address space with device. Command
> submission is still through kernel driver which controls rings (with SVM then
> you can put VA into those commands). There are other vendor specific 
> features to enable direct user space submission which is orthogonal to SVM.

Apologies for my ignorance but how is this beneficial? As in
currently you would put in bus addresses on the ring, but now you
can put VA addresses.

The obvious benefit I see is that you omit the DMA ops which means there is
less of 'lookup' (VA->bus address) in software - but I would have thought this
would be negligible performance impact? And now the IOMMU alongside with
the CPU would do this lookup.

Or are there some other improvements in this?

> 
> Thanks
> Kevin
