From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
	callback
Date: Fri, 11 Nov 2016 17:45:19 +0100
Message-ID: <634ac375-3507-6926-164f-e67f7c798c98@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
	<1478258646-3117-9-git-send-email-eric.auger@redhat.com>
	<20161110154606.GH2078@8bytes.org>
	<04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
	<20161110161331.GJ2078@8bytes.org>
	<f4537e43-0237-e478-eacd-b107458628b8@redhat.com>
	<20161111114223.GP2078@8bytes.org>
	<79da09b8-ac1e-cebf-5393-7d67f002b3e3@redhat.com>
	<20161111162211.GU2078@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161111162211.GU2078-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 11/11/2016 17:22, Joerg Roedel wrote:
> Hi Eric,
> 
> On Fri, Nov 11, 2016 at 04:47:01PM +0100, Auger Eric wrote:
>> Effectively in passthrough use case, the userspace defines the address
>> space layout and maps guest RAM PA=IOVA to PAs (using
>> VFIO_IOMMU_MAP_DMA). But this address space does not comprise the MSI
>> IOVAs. Userspace does not care about MSI IOMMU mapping. So the MSI IOVA
>> region must be allocated by either the VFIO driver or the IOMMU driver I
>> think. Who else could initialize the IOVA allocator domain?
> 
> So I think we need a way to tell userspace about the reserved regions
> (per iommu-group) so that userspace knows where it can not map anything,
Current plan is to expose that info through an iommu-group sysfs
attribute, as you and Robin advised.
> and VFIO can enforce that. But the right struct here is not an
> iova-allocator rb-tree, a ordered linked list should be sufficient.
I plan a linked list to store the reserved regions (P2P regions, MSI
region, ...). get_dma_regions is called with a list local to a function
for that. Might be needed to move that list head in the iommu_group to
avoid calling the get_dm_regions again in the attribute show function?

But to allocate the IOVAs within the MSI reserved region, I understand
you don't want us to use the iova.c allocator, is that correct? We need
an allocator though, even a very basic one based on bitmap or whatever.
There potentially have several different physical MSI frame pages to map.

Best Regards

Eric

> 
> 
> 	Joerg
> 
