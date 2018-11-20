From: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in mdev_device
Date: Wed, 21 Nov 2018 02:22:08 +0530
Message-ID: <339ab9c8-08e1-ce2f-6f71-99a06e4b82f3@nvidia.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-7-baolu.lu@linux.intel.com>
 <20181106165356.44b59ec3@w520.home>
 <edadb198-e4ab-ac23-4520-28bfcac252c3@linux.intel.com>
 <7bfc2f2b-10e6-b53c-51f3-c6494b686aa3@nvidia.com>
 <25b9a20f-06b5-57ac-81f1-fd933845c77f@linux.intel.com>
 <20181116085714.GA13181@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116085714.GA13181@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org



On 11/16/2018 2:27 PM, Christoph Hellwig wrote:
> On Fri, Nov 16, 2018 at 09:20:48AM +0800, Lu Baolu wrote:
>>> Please keep symbols mdev_set/get_iommu_device(dev, iommu_device) non-GPL
>>> same as other exported symbols from mdev_core module.
>>
>> Yes. It will be fixed in the next version.
> 
> No.  mdev shall not be used to circumvent the exports in the generic
> vfio code.
> 

It is about how mdev framework can be used by existing drivers. These
symbols doesn't use any other exported symbols.

Thanks,
Kirti
