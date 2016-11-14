From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
Date: Mon, 14 Nov 2016 17:08:16 +0100
Message-ID: <295feefe-014b-5669-7f5a-e04b09ba3454@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
 <20161110154606.GH2078@8bytes.org>
 <04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
 <20161110161331.GJ2078@8bytes.org>
 <f4537e43-0237-e478-eacd-b107458628b8@redhat.com>
 <20161111114223.GP2078@8bytes.org>
 <79da09b8-ac1e-cebf-5393-7d67f002b3e3@redhat.com>
 <20161111162211.GU2078@8bytes.org>
 <634ac375-3507-6926-164f-e67f7c798c98@redhat.com>
 <20161114153149.GY2078@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114153149.GY2078@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: drjones@redhat.com, alex.williamson@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, christoffer.dall@linaro.org, tglx@linutronix.de, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 14/11/2016 16:31, Joerg Roedel wrote:
> Hi Eric,
> 
> On Fri, Nov 11, 2016 at 05:45:19PM +0100, Auger Eric wrote:
>> On 11/11/2016 17:22, Joerg Roedel wrote:
>>> So I think we need a way to tell userspace about the reserved regions
>>> (per iommu-group) so that userspace knows where it can not map anything,
> 
>> Current plan is to expose that info through an iommu-group sysfs
>> attribute, as you and Robin advised.
> 
> Great.
> 
>>> and VFIO can enforce that. But the right struct here is not an
>>> iova-allocator rb-tree, a ordered linked list should be sufficient.
>> I plan a linked list to store the reserved regions (P2P regions, MSI
>> region, ...). get_dma_regions is called with a list local to a function
>> for that. Might be needed to move that list head in the iommu_group to
>> avoid calling the get_dm_regions again in the attribute show function?
> 
> You can re-use the get_dm_regions() call-back available in the iommu-ops
> already. Just rename it and add a flag to it which tells the iommu-core
> whether that region needs to be mapped or not.
> 
>> But to allocate the IOVAs within the MSI reserved region, I understand
>> you don't want us to use the iova.c allocator, is that correct? We need
>> an allocator though, even a very basic one based on bitmap or whatever.
>> There potentially have several different physical MSI frame pages to map.
> 
> I don't get this, what do you need and address-allocator for?

There are potentially several MSI doorbell physical pages in the SOC
that are accessed through the IOMMU (translated). Each of those must
have a corresponding IOVA and IOVA/PA mapping programmed in the IOMMU.
Else MSI will fault.

- step 1 was to define a usable IOVA range for MSI mapping. So now we
decided the base address and size would be hardcoded for ARM. The
get_dm_region can be used to retrieve that hardcoded region.
- Step2 is to allocate IOVAs within that range and map then for each of
those MSI doorbells. This is done in the MSI controller compose() callback.

I hope I succeeded in clarifying this time.

Robin sent today a new version of its cookie think using a dummy
allocator. I am currently integrating it.

Thanks

Eric
> 
> 
> 
> 	Joerg
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
