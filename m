From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 07/10] iommu/amd: copy old dev tables and do not touch
	dev tables
Date: Sat, 10 Oct 2015 20:28:03 +0800
Message-ID: <20151010122803.GB31787@dhcp-16-116.nay.redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
	<1443076656-31776-8-git-send-email-bhe@redhat.com>
	<20150929160808.GO3036@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150929160808.GO3036-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/29/15 at 06:08pm, Joerg Roedel wrote:
> On Thu, Sep 24, 2015 at 02:37:33PM +0800, Baoquan He wrote:
> > +		 if ( !translation_pre_enabled() ) {
> > +			iommu_disable(iommu);
> > +			iommu_init_flags(iommu);
> > +			iommu_set_device_table(iommu);
> > +			iommu_enable_command_buffer(iommu);
> > +			iommu_enable_event_buffer(iommu);
> > +			iommu_set_exclusion_range(iommu);
> > +			iommu_enable(iommu);
> > +			iommu_flush_all_caches(iommu);
> > +		} else {
> > +			copy_dev_tables();
> > +			copy_command_buffer();
> > +			copy_event_buffer();
> > +		}
> 
> Hmm, this leaves the old device-table in place and removes flushing the
> iommu-caches in kdump kernel, right?


Yeah, that's what I thought at that time. no iommu-caches flushing will
cause the timer bug I mentioned in cover letter. Later I added
iommu_flush_dte(iommu, devid) if the related amd_iommu_dev_table[devid]
need be copied, then timer interupt bug disappeared.

static void copy_dev_tables(void)
{
        u64 entry;
        u32 lo, hi;
        phys_addr_t old_devtb_phys;
        struct dev_table_entry *old_devtb;
        struct amd_iommu *iommu;
        u16 dom_id;
        u32 devid;
        //memset(amd_iommu_dev_table,0, dev_table_size);


        for_each_iommu(iommu) {
                iommu->cmd_buf_size &= ~(CMD_BUFFER_UNINITIALIZED);
                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
                entry = (((u64) hi) << 32) + lo;
                old_devtb_phys = entry & PAGE_MASK;
                old_devtb = ioremap_cache(old_devtb_phys, dev_table_size);
                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
                //for (devid = iommu->first_device; devid <=
                //iommu->last_device; ++devid) {
                        amd_iommu_dev_table[devid] = old_devtb[devid];
                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
                        if (!dom_id)
                                continue;
                        copy_irq_table(devid);
                        __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
                        iommu_flush_dte(iommu, devid);
                }
                iounmap(old_devtb);
                iommu_completion_wait(iommu);
        }
}
> 
> 
> 	Joerg
> 
