From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain
 map/unmap
Date: Tue, 12 Mar 2019 09:38:45 -0700
Message-ID: <20190312163845.GA13141@infradead.org>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
 <20190312060005.12189-5-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312060005.12189-5-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 12, 2019 at 02:00:00PM +0800, Lu Baolu wrote:
> This adds the APIs for bounce buffer specified domain
> map() and unmap(). The start and end partial pages will
> be mapped with bounce buffered pages instead. This will
> enhance the security of DMA buffer by isolating the DMA
> attacks from malicious devices.

Please reuse the swiotlb code instead of reinventing it.
