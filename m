From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
Date: Wed, 24 Apr 2019 16:45:32 +0200
Message-ID: <20190424144532.GA21480@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com> <20190421011719.14909-3-baolu.lu@linux.intel.com> <20190422164555.GA31181@lst.de> <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com> <20190423061232.GB12762@lst.de> <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 23, 2019 at 03:32:16PM +0800, Lu Baolu wrote:
> When we add the bounce buffer between IOVA and physical buffer, the
> bounced buffer must starts from the same offset in a page, otherwise,
> IOMMU can't work here.

Why?  Even with the odd hardware descriptors typical in Intel land that
only allow offsets in the first page, not the following ones, having
a zero offset where we previously had one should be fine.
