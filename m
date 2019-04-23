From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 08/10] iommu/vt-d: Check whether device requires
 bounce buffer
Date: Tue, 23 Apr 2019 08:08:58 +0200
Message-ID: <20190423060858.GA12762@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com> <20190421011719.14909-9-baolu.lu@linux.intel.com> <20190422164755.GC31181@lst.de> <76e35340-32c3-ee0d-5232-bd8800248402@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <76e35340-32c3-ee0d-5232-bd8800248402@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

>> Again, this and the option should not be in a specific iommu driver.
>>
>
> The option of whether bounce is ignored should be in the specific iommu
> driver.

Why?  As a user I could not care less which IOMMU driver my particular
system uses.
