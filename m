From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/9] iommu: Introduce iommu do invalidate API function
Date: Wed, 26 Jul 2017 11:02:40 +0200
Message-ID: <20170726090240.GD30429@8bytes.org>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1498592883-56224-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<20170628100823.GG14532@8bytes.org>
	<20170628090952.0bebd2b3@jacob-builder>
	<00a5fe10-98bb-f018-06b6-29af22d014eb@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D25CCB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D25CCB-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu,
	Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 05, 2017 at 07:57:57AM +0000, Tian, Kevin wrote:
> > > struct tlb_invalidate_info
> > > {
> > >         __u32   model;  /* Vendor number */

I don't like to have a model-specifier here, as I don't think its
needed.

> > >         __u8 granularity
> > > #define DEVICE_SELECTVIE_INV    (1 << 0)
> > > #define PAGE_SELECTIVE_INV      (1 << 0)
> > > #define PASID_SELECTIVE_INV     (1 << 1)
> > >         __u32 pasid;
> > >         __u64 addr;
> > >         __u64 size;
> > >
> > >         /* Since IOMMU format has already been validated for this table,
> > >            the IOMMU driver knows that the following structure is in a
> > >            format it knows */
> > >         __u8 opaque[];
> > > };
> > >
> 
> I just gave some information in another thread:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00853.html
> 
> Below summarizes all the invalidation capabilities supported by Intel VTd:
> 
> Scope: All PASIDs, single PASID
> for each PASID:
>         all mappings, or page-selective mappings (addr, size)
> invalidation target:
>         IOTLB entries (leaf)
>         paging structure cache (non-leaf)
>         PASID cache (pasid->cr3)
> invalidation hint:
>         whether global pages are included
>         drain reads/writes

The AMD IOMMU for example supports similar flushing capabilities. They
are all based on a IOMMU-independent PCI standards (PASID, PRI, ATS),
and the interface can be designed around those standards instead of
IOMMU hardware implementations.

If a given hardware implementation does not support all of the above
flushing modes, it is always free to flush more than requested as
supported by its capabilities.

Regards,

	Joerg
