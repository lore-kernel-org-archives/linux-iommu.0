From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 03/16] iommu: introduce iommu invalidate API function
Date: Fri, 15 Dec 2017 19:02:24 +0000
Message-ID: <a4d4f26b-09c4-f637-f25a-d42e66360514@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<9fe883f7-8650-20f2-4db1-1539b3e927ae@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9fe883f7-8650-20f2-4db1-1539b3e927ae-5wv7dgnIgG8@public.gmane.org>
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
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

A quick update on invalidations before I leave for holidays, since we're
struggling to define useful semantics. I worked on the virtio-iommu
prototype for vSVA, so I tried to pin down what I think is needed for vSVA
invalidation in the host. I don't know whether the VT-d and AMD emulations
can translate all of this from guest commands.

Scope selects which entries are invalidated, and flags cherry-pick what
caches to invalidate. For example a guest might remove GBs of sparse
mappings, and decide that it would be quicker to invalidate the whole
context instead of one at a time. Then it would set only flags = (TLB |
DEV_TLB) with scope = PASID. If the guest clears one entry in the PASID
table, then it would send scope = PASID and flags = (LEAF | CONFIG | TLB |
DEV_TLB). On an ARM system the guest can invalidate TLBs with CPU
instructions, but can't invalidate ATCs. So it would send an invalidate
with flags = (LEAF | TLB) and scope = VA.

enum iommu_sva_inval_scope {
	IOMMU_INVALIDATE_DOMAIN	= 1,
	IOMMU_INVALIDATE_PASID,
	IOMMU_INVALIDATE_VA,
};

/* Only invalidate leaf entry. Applies to PASID table if scope == PASID or
 * page tables if scope == VA. */
#define IOMMU_INVALIDATE_LEAF		(1 << 0)
/* Invalidate cached PASID table configuration */
#define IOMMU_INVALIDATE_CONFIG		(1 << 1)
/* Invalidate IOTLBs */
#define IOMMU_INVALIDATE_TLB		(1 << 2)
/* Invalidate ATCs */
#define IOMMU_INVALIDATE_DEV_TLB	(1 << 3)
/* + Need a global flag? */

struct iommu_sva_invalidate {
	enum iommu_sva_inval_scope	scope;
	u32				flags;
	u32				pasid;
	u64				iova;
	u64				size;
	/* Arch-specific, format is determined at bind time */
	union {
		struct {
			u16		asid;
			u8		granule;
		} arm;
	}
};

ARM needs two more fields. A 16-bit @asid (Address Space ID) targets TLB
entries and may be different from the PASID (up to the guest to decide),
which targets ATC and config entries.

@granule is the TLB granule that we're invalidating. For instance if the
guest just unmapped a few 2M huge pages, it sets @granule to 21 bits, so
we issue less invalidation commands, since we only need to evict huge TLB
entries. I'm not sure about other architecture but I'd be surprised if
this wasn't more common. Should we move it to the common part?


int iommu_sva_invalidate(struct iommu_domain *domain,
			 struct iommu_sva_invalidate *inval);

And so the host driver implementation is roughly:
--------------------------------------------------------------------------
bool leaf	= flags & IOMMU_INVALIDATE_LEAF;
bool config	= flags & IOMMU_INVALIDATE_CONFIG;
bool tlb	= flags & IOMMU_INVALIDATE_TLB;
bool atc	= flags & IOMMU_INVALIDATE_DEV_TLB;

if (config) {
	switch (scope) {
	case IOMMU_INVALIDATE_PASID:
		inval_cached_pasid_entry(domain, pasid, leaf);
		break;
	case IOMMU_INVALIDATE_DOMAIN:
		inval_all_cached_pasid_entries(domain);
		break;
	default:
		return -EINVAL;
	}

	/* Wait for caches to be clean, then invalidate TLBs */
	sync_commands();
}

if (tlb) {
	switch (scope) {
	case IOMMU_INVALIDATE_VA:
		inval_tlb_entries(domain, asid, iova, size, granule,
				  leaf);
		break;
	case IOMMU_INVALIDATE_PASID:
		inval_all_tlb_entries_for_asid(domain, asid);
		break;
	case IOMMU_INVALIDATE_DOMAIN:
		inval_all_tlb_entries(domain);
		break;
	default:
		return -EINVAL;
	}

	/* Wait for TLBs to be clean, then invalidate ATCs. */
	sync_commands();
}

if (atc) {
	/* ATC invalidations are sent to all devices in the domain */
	switch (scope) {
	case IOMMU_INVALIDATE_VA:
		inval_atc_entries(domain, pasid, iova, size);
		break;
	case IOMMU_INVALIDATE_PASID:
		/* Covers the full address space */
		inval_all_atc_entries_for_pasid(domain, pasid);
		break;
	case IOMMU_INVALIDATE_DOMAIN:
		/* Set Global Invalidate */
		inval_all_atc_entries(domain);
		break;
	default:
		return -EINVAL;
	}

	sync_commands();
}

/* Then return to guest. */
--------------------------------------------------------------------------

I think this covers what we need and allows userspace or the guest to
gather multiple invalidations into a single request/ioctl.

I don't think per-device ATC invalidation is needed, but might be wrong.
According to ATS it is implicit when the guest resets the device (FLR) or
disables the ATS capability. Are there other use-cases than reset? I still
need to see how QEMU handles when a device is detached from a domain (e.g.
its device table entry set to invalid). Kvmtool has one VFIO container per
device so can simply unmap-all to clear caches and TLBs when this happens.

Hope this helps,
Jean
