From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
Date: Tue, 23 Apr 2019 15:32:16 +0800
Message-ID: <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-3-baolu.lu@linux.intel.com>
 <20190422164555.GA31181@lst.de>
 <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
 <20190423061232.GB12762@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423061232.GB12762@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On 4/23/19 2:12 PM, Christoph Hellwig wrote:
> On Tue, Apr 23, 2019 at 09:58:19AM +0800, Lu Baolu wrote:
>> 554         for (i = 0; i < nslots; i++)
>> 555                 io_tlb_orig_addr[index+i] = orig_addr + (i <<
>> IO_TLB_SHIFT);
>>
>> Could the tlb orig address set to PAGE_ALIGN_DOWN(orig_addr)? We
>> couldn't assume the bounce buffer just starts from the beginning of the
>> slot. Or anything I missed?
> 
> I don't see why we need to align the orig_addr.  We only use
> io_tlb_orig_addr to find the address(es) for the swiotlb_bounce calls,
> and I don't see a good reason why we'd need to align those.
> 

Let me show you an example. Normally, if IOMMU is on, the device DMAs
with an iova. IOMMU takes the responsibility to translate the iova to
the physical address in paging mode.

                        Physical
    IOVA                 Buffer
.---------.          .---------.
| IOMMU   |          | IOMMU   |
| PAGE    |          | PAGE    |
.---------. -------> .---------.
| Buffer  |          | Buffer  |
'---------'          '---------'
|         |          |         |
|         |          |         |
'---------'          '---------'
             .-------.
             | IOMMU |
             '-------'

When we add the bounce buffer between IOVA and physical buffer, the
bounced buffer must starts from the same offset in a page, otherwise,
IOMMU can't work here.


                       Bouce             Physical
    IOVA               Buffer             Buffer
.---------.         .---------.       .---------.
|         | .-----> | Buffer  | <---. |         |
|         | |       '---------'     | |         |
.---------. |       |         |     | .---------.
| Buffer  |    NO   |         |  YES  | Buffer  |
'---------'         |         |       '---------'
|         |         |         |       |         |
|         |         |         |       |         |
'---------'         '---------'       '---------'
            .-------.         .---------.
            | IOMMU |         | swiotlb |
            '-------'         '---------'

A workable buffer location looks like below.


                       Bouce             Physical
    IOVA               Buffer             Buffer
.---------.         .---------.       .---------.
|         |         |         |       |         |
|         |         |         |       |         |
.---------. ------->.---------.<----- .---------.
| Buffer  |    YES  | Buffer  |  YES  | Buffer  |
'---------'         '---------'       '---------'
|         |         |         |       |         |
|         |         |         |       |         |
'---------'         '---------'       '---------'
            .-------.         .---------.
            | IOMMU |         | swiotlb |
            '-------'         '---------'

Best regards,
Lu Baolu
