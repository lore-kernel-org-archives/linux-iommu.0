From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 00/19] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
	reserved regions
Date: Tue, 10 Jan 2017 14:15:32 +0000
Message-ID: <20170110141532.GA27365@arm.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
	<20170110140924.GC1318@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170110140924.GC1318-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 10, 2017 at 03:09:24PM +0100, Joerg Roedel wrote:
> On Mon, Jan 09, 2017 at 01:45:51PM +0000, Eric Auger wrote:
> > Eric Auger (17):
> >   iommu: Rename iommu_dm_regions into iommu_resv_regions
> >   iommu: Add a new type field in iommu_resv_region
> >   iommu: iommu_alloc_resv_region
> >   iommu: Only map direct mapped regions
> >   iommu: iommu_get_group_resv_regions
> >   iommu: Implement reserved_regions iommu-group sysfs file
> >   iommu/vt-d: Implement reserved region get/put callbacks
> >   iommu/amd: Declare MSI and HT regions as reserved IOVA regions
> >   iommu/arm-smmu: Implement reserved region get/put callbacks
> >   iommu/arm-smmu-v3: Implement reserved region get/put callbacks
> 
> IOMMU patches look good, what is the plan to merge this? I'd like to
> take the IOMMU patches and can provide a branch for someone else to base
> the rest on.

I'm perfectly happy with this going through you. In fact, I suspect you
could take the whole series once Marc is happy with the few remaining
irq domain niggles (which are really minor at this point).

That just leaves the VFIO bits -- Alex, are you happy with those now?
If not, we can hold off on the last three patches for the time being.

Will
