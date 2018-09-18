From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Date: Tue, 18 Sep 2018 16:46:31 +0100
Message-ID: <a92a6077-226f-5d38-cdfa-ec5e06a5d532@arm.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
 <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
 <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
 <03d496b0-84c2-b3ca-5be5-d4540c6d8ec7@arm.com>
 <20180914140433.6891a90c@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180914140433.6891a90c@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 14/09/2018 22:04, Jacob Pan wrote:
>> This example only needs to modify first-level translation, and works
>> with SMMUv3. The kernel here could be the host, in which case
>> second-level translation is disabled in the SMMU, or it could be the
>> guest, in which case second-level mappings are created by QEMU and
>> first-level translation is managed by assigning PASID tables to the
>> guest.
> There is a difference in case of guest SVA. VT-d v3 will bind guest
> PASID and guest CR3 instead of the guest PASID table. Then turn on
> nesting. In case of mdev, the second level is obtained from the aux
> domain which was setup for the default PASID. Or in case of PCI device,
> second level is harvested from RID2PASID.

Right, though I wasn't talking about the host managing guest SVA here,
but a kernel binding the address space of one of its userspace drivers
to the mdev.

>> So (2) would use iommu_sva_bind_device(), 
> We would need something different than that for guest bind, just to show
> the two cases:>
> int iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, int
> *pasid, unsigned long flags, void *drvdata)
> 
> (WIP)
> int sva_bind_gpasid(struct device *dev, struct gpasid_bind_data *data)
> where:
> /**
>  * struct gpasid_bind_data - Information about device and guest PASID
> binding
>  * @pasid:       Process address space ID used for the guest mm
>  * @addr_width:  Guest address width. Paging mode can also be derived.
>  * @gcr3:        Guest CR3 value from guest mm
>  */
> struct gpasid_bind_data {
>         __u32 pasid;
>         __u64 gcr3;
>         __u32 addr_width;
>         __u32 flags;
> #define IOMMU_SVA_GPASID_SRE    BIT(0) /* supervisor request */
> };
> Perhaps there is room to merge with io_mm but the life cycle management
> of guest PASID and host PASID will be different if you rely on mm
> release callback than FD.

I think gpasid management should stay separate from io_mm, since in your
case VFIO mechanisms are used for life cycle management of the VM,
similarly to the former bind_pasid_table proposal. For example closing
the container fd would unbind all guest page tables. The QEMU process'
address space lifetime seems like the wrong thing to track for gpasid.

>> but (1) needs something
>> else. Aren't auxiliary domains suitable for (1)? Why limit auxiliary
>> domain to second-level or nested translation? It seems silly to use a
>> different API for first-level, since the flow in userspace and VFIO
>> is the same as your second-level case as far as MAP_DMA ioctl goes.
>> The difference is that in your case the auxiliary domain supports an
>> additional operation which binds first-level page tables. An
>> auxiliary domain that only supports first-level wouldn't support this
>> operation, but it can still implement iommu_map/unmap/etc.
>> 
> I think the intention is that when a mdev is created, we don;t
> know whether it will be used for SVA or IOVA. So aux domain is here to
> "hold a spot" for the default PASID such that MAP_DMA calls can work as
> usual, which is second level only. Later, if SVA is used on the mdev
> there will be another PASID allocated for that purpose.
> Do we need to create an aux domain for each PASID? the translation can
> be looked up by the combination of parent dev and pasid.

When allocating a new PASID for the guest, I suppose you need to clone
the second-level translation config? In which case a single aux domain
for the mdev might be easier to implement in the IOMMU driver. Entirely
up to you since we don't have this case on SMMUv3

Thanks,
Jean
