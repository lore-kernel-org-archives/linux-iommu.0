From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 3/6] Crashdump-Accepting-Active-IOMMU-Domain-Interfaces
Date: Tue, 4 Mar 2014 15:59:15 +0100
Message-ID: <20140304145911.GD2799@8bytes.org>
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
	<1389391652-52422-4-git-send-email-bill.sumner@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389391652-52422-4-git-send-email-bill.sumner-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhenhua-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 10, 2014 at 03:07:29PM -0700, Bill Sumner wrote:
> +context_get_entry(struct context_entry *context_addr,
> +			struct intel_iommu *iommu, u32 bus, int devfn)
> +{
> +	unsigned long long q;		/* quadword scratch */
> +	struct root_entry *root_phys;	/* Phys adr (root table entry) */
> +	struct root_entry  root_temp;	/* Local copy of root_entry */
> +	struct context_entry *context_phys;	/* Phys adr */
> +
> +	if (pr_dbg.domain_get)
> +		pr_debug("ENTER %s B:D:F=%2.2x:%2.2x:%1.1x &context_entry:0x%llx &intel_iommu:0x%llx\n",
> +			__func__, bus, devfn>>3, devfn&7,
> +			(u64)context_addr, (u64)iommu);
> +
> +	if (bus > 255)				/* Sanity check */
> +		return -5;
> +	if (devfn > 255 || devfn < 0)		/* Sanity check */
> +		return -6;
> +
> +	q = readq(iommu->reg + DMAR_RTADDR_REG);
> +	pr_debug("IOMMU %d: DMAR_RTADDR_REG:0x%16.16llx\n", iommu->seq_id, q);
> +	if (!q)
> +		return -1;
> +
> +	root_phys = (struct root_entry *) q;	/* Adr(base of vector) */
> +	root_phys += bus;			/* Adr(entry we want) */
> +
> +	oldcopy(&root_temp, root_phys, sizeof(root_temp));
> +
> +	pr_debug("root_temp.val:0x%llx .rsvd1:0x%llx root_phys:0x%llx\n",
> +		root_temp.val, root_temp.rsvd1, (u64)root_phys);
> +
> +	if (!root_present(&root_temp))
> +		return -2;
> +
> +	pr_debug("B:D:F=%2.2x:%2.2x:%1.1x root_temp.val: %llx .rsvd1: %llx\n",
> +		bus, devfn >> 3, devfn & 7, root_temp.val, root_temp.rsvd1);
> +
> +	if (root_temp.rsvd1)			/* If (root_entry is bad) */
> +		return -3;
> +
> +	context_phys = get_context_phys_from_root(&root_temp);
> +	if (!context_phys)
> +		return -4;

What do all these magic return values mean? 
