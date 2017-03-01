From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC Design Doc v3] Enable Shared Virtual Memory feature in
	pass-through scenarios
Date: Wed, 1 Mar 2017 13:30:23 -0800
Message-ID: <20170301213023.fv5utdpbh4zvsxdy@araj-mobl1>
References: <A2975661238FB949B60364EF0F2C257436DE3165@shsmsx102.ccr.corp.intel.com>
	<20170228220719.GD2352@char.us.ORACLE.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C4FF94@SHSMSX101.ccr.corp.intel.com>
	<20170301210938.GE9043@char.us.ORACLE.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170301210938.GE9043-he5eyhs8q0A6W680SEFli9BPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Peng, Chao P" <chao.p.peng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hao,
	Xudong" <xudong.hao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Sun,
	Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 01, 2017 at 04:09:38PM -0500, Konrad Rzeszutek Wilk wrote:
> .snip..
> > 
> > No. SVM is purely about sharing CPU address space with device. Command
> > submission is still through kernel driver which controls rings (with SVM then
> > you can put VA into those commands). There are other vendor specific 
> > features to enable direct user space submission which is orthogonal to SVM.
> 
> Apologies for my ignorance but how is this beneficial? As in
> currently you would put in bus addresses on the ring, but now you
> can put VA addresses.
> 
> The obvious benefit I see is that you omit the DMA ops which means there is
> less of 'lookup' (VA->bus address) in software - but I would have thought this
> would be negligible performance impact? And now the IOMMU alongside with
> the CPU would do this lookup.
> 
> Or are there some other improvements in this?
Other benefits include,

- Application can simply pass its pointers to the SVM capable devices. which
  means no memory registration overhead to get IO Virtual Addresses. 
- No need to pin memory for DMA, since the devices can handle faults and
  can request pages to be paged-in on demand.
> 
> > 
> > Thanks
> > Kevin
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
