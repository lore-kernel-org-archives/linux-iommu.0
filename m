From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [PATCH 1/1] iommu: Bind process address spaces to devices
Date: Thu, 28 Feb 2019 01:10:55 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19C9687D8@SHSMSX104.ccr.corp.intel.com>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
        <20190220142759.33308-2-jean-philippe.brucker@arm.com>
        <20190226111743.GK20740@8bytes.org> <20190227134129.51ad42ac@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190227134129.51ad42ac@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "christian.koenig@amd.com" <christian.koenig@amd.com>, "Raj, Ashok" <ashok.raj@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
List-Id: iommu@lists.linux-foundation.org

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Thursday, February 28, 2019 5:41 AM
> 
> On Tue, 26 Feb 2019 12:17:43 +0100
> Joerg Roedel <joro@8bytes.org> wrote:
> 
> >
> > How about a 'struct iommu_sva' with an iommu-private definition that
> > is returned by this function:
> >
> > 	struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> > 						struct mm_struct *mm);
> >
> Just trying to understand how to use this API.
> So if we bind the same mm to two different devices, we should get two
> different iommu_sva handle, right?
> I think intel-svm still needs a flag argument for supervisor pasid etc.
> Other than that, I think both interface should work for vt-d.
> 
> Another question is that for nested SVA, we will need to bind guest mm.
> Do you think we should try to reuse this or have it separate? I am
> working on a separate API for now.
> 

It has to be different. Host doesn't know guest mm.

Also note that from virtualization p.o.v we just focus on 'nested
translation' in host side. The 1st level may point to guest CPU
page table (SVA), or IOVA page table. In that manner, the API
(as currently defined in your series) is purely about setting up
nested translation on VFIO assigned device. 

Thanks
Kevin
