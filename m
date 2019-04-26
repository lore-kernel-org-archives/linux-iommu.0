From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
Date: Fri, 26 Apr 2019 12:47:43 +0100
Message-ID: <856b0457-bd2f-c2af-fdeb-45fe0bd3136b@arm.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <20190424061903.GB30717@infradead.org>
 <20190425111912.0e15eb7d@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425111912.0e15eb7d@jacob-builder>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Christoph Hellwig <hch@infradead.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, "christian.koenig@amd.com" <christian.koenig@amd.com>
List-Id: iommu@lists.linux-foundation.org

On 25/04/2019 19:19, Jacob Pan wrote:
> Hi Christoph,
> 
> On Tue, 23 Apr 2019 23:19:03 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> On Tue, Apr 23, 2019 at 04:31:06PM -0700, Jacob Pan wrote:
>>> The allocator doesn't really belong in drivers/iommu because some
>>> drivers would like to allocate PASIDs for devices that aren't
>>> managed by an IOMMU, using the same ID space as IOMMU. It doesn't
>>> really belong in drivers/pci either since platform device also
>>> support PASID. Add the allocator in drivers/base.  
>>
>> I'd still add it to drivers/iommu, just selectable separately from the
>> core iommu code..
> Perhaps I misunderstood. If a driver wants to use IOASIDs w/o iommu
> subsystem even turned on, how could selecting from the core iommu code
> help? Could you elaborate on "selectable"?

How about doing the same as CONFIG_IOMMU_IOVA? The code is in
drivers/iommu but can be selected by non-IOMMU_API users, independently
of CONFIG_IOMMU_SUPPORT. It's true that this allocator will mostly be
used by IOMMU drivers.

> From VT-d's perspective, PASIDs are only used with IOMMU on. Jean
> knows other use cases.

I know of one: the AMD GPU driver may use IOASID for context IDs, even
if IOMMU is disabled. As I understand it, if IOMMU is enabled they need
to use the same allocator as IOMMU since it's the same ID space. And I
think it's more convenient to use the same allocation code in the GPU
driver regardless of CONFIG_IOMMU_SUPPORT.

See the previous discussion at
https://www.spinics.net/lists/iommu/msg31200.html

Thanks,
Jean
