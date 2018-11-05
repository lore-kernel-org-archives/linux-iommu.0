From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 11/12] iommu/vt-d: Shared virtual address in scalable
 mode
Date: Mon, 5 Nov 2018 15:17:12 +0800
Message-ID: <e747d3dd-0b79-fab8-b6c1-b466113e27ce@linux.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-12-baolu.lu@linux.intel.com>
 <20181105071505.GA13230@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105071505.GA13230@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com, ashok.raj@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com
List-Id: iommu@lists.linux-foundation.org

Hi,

On 11/5/18 3:15 PM, Christoph Hellwig wrote:
>> --- a/include/linux/dma_remapping.h
>> +++ b/include/linux/dma_remapping.h
> 
> FYI, this file seems to be entirely VT-D specific, but has an awfully
> generic name.  It should be renamed to something more suitable (or maybe
> just merged into intel-iommu.h?) and also grow some comments describing
> the contents.
> 

Yes, good catch. I will do this in a separated patch.

Best regards,
Lu Baolu
