From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Date: Tue, 24 Jul 2018 13:51:01 -0600
Message-ID: <20180724135101.58e81678@t450s.home>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
        <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
        <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
        <5B568D5B.5050606@linux.intel.com>
        <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>, "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, 24 Jul 2018 12:30:35 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Hi Baolu,
> 
> On 24/07/18 03:22, Lu Baolu wrote:
> > Hi,
> > 
> > On 07/23/2018 12:44 PM, Liu, Yi L wrote:  
> >>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> >>> Sent: Sunday, July 22, 2018 2:09 PM
> >>>
> >>> With the Intel IOMMU supporting PASID granularity isolation and protection, a
> >>> mediated device could be isolated and protected by an IOMMU unit. We need to
> >>> allocate a new group instead of a PCI group.  
> >> Existing vfio mdev framework also allocates an iommu group for mediate device.
> >>
> >> mdev_probe()
> >>   |_ mdev_attach_iommu()
> >>        |_ iommu_group_alloc()  
> > 
> > When external components ask iommu to allocate a group for a device,
> > it will call pci_device_group in Intel IOMMU driver's @device_group
> > callback. In another word, current Intel IOMMU driver doesn't aware
> > the mediated device and treat all devices as PCI ones. This patch
> > extends the @device_group call back to make it aware of a mediated
> > device.  
> 
> I agree that allocating two groups for an mdev seems strange, and in my
> opinion we shouldn't export the notion of mdev to IOMMU drivers.

Yep, I was just thinking the same thing.  This is too highly integrated
into VT-d and too narrowly focused on PASID being the only way that an
mdev could make use of the IOMMU.  Thanks,

Alex
