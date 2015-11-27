From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch v2 5/9] iommu/amd: Add function copy_dev_tables
Date: Fri, 27 Nov 2015 12:21:53 +0100
Message-ID: <20151127112152.GD24300@8bytes.org>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
	<1446811851-20623-6-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446811851-20623-6-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 06, 2015 at 08:10:47PM +0800, Baoquan He wrote:
> +static void copy_dev_tables(void)
> +{
> +        u64 entry;
> +        u32 lo, hi;
> +        phys_addr_t old_devtb_phys;
> +        struct dev_table_entry *old_devtb;
> +        struct amd_iommu *iommu;
> +        u16 dom_id;
> +        u32 devid;
> +
> +        for_each_iommu(iommu) {

You don't need to do this for all IOMMUs in the system. Linux uses the
same device table for all IOMMUs, so it is better to just check whether
all IOMMUs in the system are enabled and also point to the same device
table. If any of this is not the case we should just bail out of any
tries to copy over data from the old kernel.

> +		/*
> +		 * This is used to prevent the WARNING in iommu_queue_command_sync()
> +		 * when call flush function
> +		 */
> +		iommu->cmd_buf_size &= ~(CMD_BUFFER_UNINITIALIZED);

This is a hack. You need to add code to re-initialize the command buffer
and the error and ppr logs in the new kernel.

> +
> +                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
> +                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
> +                entry = (((u64) hi) << 32) + lo;
> +                old_devtb_phys = entry & PAGE_MASK;
> +                old_devtb = ioremap_cache(old_devtb_phys, dev_table_size);

Please use memremap.

> +                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
> +                        amd_iommu_dev_table[devid] = old_devtb[devid];
> +                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
> +			if (!dom_id)
> +				continue;

Check the V and IV bits of the here instead of the domid.
