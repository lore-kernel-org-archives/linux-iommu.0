From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Date: Fri, 14 Sep 2018 15:39:36 +0100
Message-ID: <1eea3561-f2c3-29a2-8ae4-879d8230b540@arm.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
 <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
 <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
 <03d496b0-84c2-b3ca-5be5-d4540c6d8ec7@arm.com>
 <20180913165520.GA14731@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913165520.GA14731@otc-nc-03>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, Kirti Wankhede <kwankhede@nvidia.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>, "Sun, Yi Y" <yi.y.sun@intel.com>
List-Id: iommu@lists.linux-foundation.org

On 13/09/2018 17:55, Raj, Ashok wrote:
>> For Arm SMMU we're more interested in the PASID-granular case than the
>> RID-granular one. It doesn't necessarily require vt-d rev3 scalable
>> mode, the following example can be implemented with an SMMUv3, since it
>> only needs PASID-granular first-level translation:
> 
> You are right, you can simply use the first level as IOVA for every PASID.
> 
> Only issue becomes when you need to assign that to a guest, you would be required
> to shadow the 1st level. If you have a 2nd level per-pasid first level can
> be managed in guest and don't require to shadow them.

Right, for us assigning a PASID-granular mdev to a guest requires shadowing

>> Another note: if for some reason you did want to allow userspace to
>> choose between first-level or second-level, you could implement the
>> VFIO_TYPE1_NESTING_IOMMU container. It acts like a VFIO_TYPE1v2_IOMMU,
>> but also sets the DOMAIN_ATTR_NESTING on the IOMMU domain. So DMA_MAP
>> ioctl on a NESTING container would populate second-level, and DMA_MAP on
>> a normal container populates first-level. But if you're always going to
>> use second-level by default, the distinction isn't necessary.
> 
> Where is the nesting attribute specified? in vt-d2 it was part of context
> entry, so also meant all PASID's are nested now. In vt-d3 its part of
> PASID context.

I don't think the nesting attribute is described in details anywhere.
The SMMU drivers use it to know if they should create first- or
second-level mappings. At the moment QEMU always uses
VFIO_TYPE1v2_IOMMU, but Eric Auger is proposing a patch that adds
VFIO_TYPE1_NESTING_IOMMU to QEMU:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg559820.html

> It seems unsafe to share PASID's with different VM's since any request 
> W/O PASID has only one mapping.

Which case are you talking about? It might be more confusing than
helpful, but here's my understanding of what we can assign to a guest:

              |  no vIOMMU  | vIOMMU no PASID  | vIOMMU with PASID
--------------+-------------+------------------+--------------------
 VF           |     ok      |  shadow or nest  |      nest
 mdev, SMMUv3 |     ok      |     shadow       |  shadow + PV (?)
 mdev, vt-d3  |     ok      |      nest        |    nest + PV

The first line, assigning a PCI VF to a guest is the "basic" vfio-pci
case. Currently in QEMU it works by shadowing first-level translation.
We still have to upstream nested translation for that case. Vt-d2 didn't
support nested without PASID, vt-d3 offers RID_PASID for this. On SMMUv3
the PASID table is assigned to the guest, whereas on vt-d3 the host
manages the PASID table and individual page tables are assigned to the
guest.

Assigning an mdev (here I'm talking about the PASID-granular partition
of a VF, not the whole RID-granular VF wrapped by an mdev) could be done
by shadowing first-level translation on SMMUv3. It cannot do nested
since the VF has a single set of second-level page tables, which cannot
be used when mdevs are assigned to different VMs. Vt-d3 has one set of
second-level page tables per PASID, so it can do nested.

Since the parent device has a single PASID space, allowing the guest to
use multiple PASIDs for one mdev requires paravirtual allocation of
PASIDs (last column). Vt-d3 uses the Virtual Command Registers for that.
I assume that it is safe because the host is in charge of programming
PASIDs in the parent device, so the guest couldn't use a PASID allocated
to another mdev, but I don't know what the device's programming model
would look like. Anyway I don't think guest PASID is tackled by this
series (right?) and I don't intend to work on it for SMMUv3 (shadowing
stage-1 for vSVA seems like a bad idea...)

Does this seem accurate?

Thanks,
Jean
