From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
Date: Thu, 25 Apr 2019 10:07:19 +0800
Message-ID: <a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
	<20190421011719.14909-3-baolu.lu@linux.intel.com>
	<20190422164555.GA31181@lst.de>
	<0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
	<20190423061232.GB12762@lst.de>
	<dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com>
	<20190424144532.GA21480@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190424144532.GA21480-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 4/24/19 10:45 PM, Christoph Hellwig wrote:
> On Tue, Apr 23, 2019 at 03:32:16PM +0800, Lu Baolu wrote:
>> When we add the bounce buffer between IOVA and physical buffer, the
>> bounced buffer must starts from the same offset in a page, otherwise,
>> IOMMU can't work here.
> 
> Why?  Even with the odd hardware descriptors typical in Intel land that
> only allow offsets in the first page, not the following ones, having
> a zero offset where we previously had one should be fine.
> 

This is not VT-d specific. It's just how generic IOMMU works.

Normally, IOMMU works in paging mode. So if a driver issues DMA with
IOVA  0xAAAA0123, IOMMU can remap it with a physical address 0xBBBB0123.
But we should never expect IOMMU to remap 0xAAAA0123 with physical
address of 0xBBBB0000. That's the reason why I said that IOMMU will not
work there.

                                 swiotlb                  System
                 IOVA          bounce page                Memory
              .---------.      .---------.             .---------.
              |         |      |         |             |         |
              |         |      |         |             |         |
buffer_start .---------.      .---------.buffer_start .---------.
              |         |----->|         |             |         |
              |         |      |         |************>|         |
              |         |      |         |   swiotlb   |         |
  IOMMU Page  '---------'      '---------'   mapping   '---------'
   Boundary   |         |                              |         |
              |         |                              |         |
              |         |                              |         |
              |         |----------------------------->|         |
              |         |        IOMMU mapping         |         |
              |         |                              |         |
  IOMMU Page  .---------.                              .---------.
   Boundary   |         |                              |         |
              |         |                              |         |
              |         |----------------------------->|         |
              |         |         IOMMU mapping        |         |
              |         |                              |         |
              |         |                              |         |
  IOMMU Page  .---------.      .---------.             .---------.
   Boundary   |         |      |         |             |         |
              |         |      |         |************>|         |
              |         |----->|         |   swiotlb   |         |
   buffer_end '---------'      '---------'   mapping   '---------'
              |         |      |         |             |         |
              |         |      |         |             |         |
              '---------'      '---------'             '---------'


This is the whole view of iommu bounce page. I expect the buffer_start
returned by swiotlb_tbl_map_single() starts from the same page_offset as
the buffer_start in IOVA.

Best regards,
Lu Baolu
