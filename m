From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain
	map/unmap
Date: Thu, 14 Mar 2019 09:01:16 +0800
Message-ID: <b3e88984-d2ff-c23d-c4bd-3248e4e9487d@linux.intel.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
	<20190312060005.12189-5-baolu.lu@linux.intel.com>
	<20190312163845.GA13141@infradead.org>
	<e653341d-e001-7262-740b-2262842be06d@linux.intel.com>
	<c9fe7879-569e-b4f4-d6ec-47ab7e6fd443@linux.intel.com>
	<20190313161029.GA23513@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190313161029.GA23513-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
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
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 3/14/19 12:10 AM, Christoph Hellwig wrote:
> On Wed, Mar 13, 2019 at 10:31:52AM +0800, Lu Baolu wrote:
>> Hi again,
>>
>> On 3/13/19 10:04 AM, Lu Baolu wrote:
>>> Hi,
>>>
>>> On 3/13/19 12:38 AM, Christoph Hellwig wrote:
>>>> On Tue, Mar 12, 2019 at 02:00:00PM +0800, Lu Baolu wrote:
>>>>> This adds the APIs for bounce buffer specified domain
>>>>> map() and unmap(). The start and end partial pages will
>>>>> be mapped with bounce buffered pages instead. This will
>>>>> enhance the security of DMA buffer by isolating the DMA
>>>>> attacks from malicious devices.
>>>>
>>>> Please reuse the swiotlb code instead of reinventing it.
>>>>
>>
>> Just looked into the code again. At least we could reuse below
>> functions:
>>
>> swiotlb_tbl_map_single()
>> swiotlb_tbl_unmap_single()
>> swiotlb_tbl_sync_single()
>>
>> Anything else?
> 
> Yes, that is probably about the level you want to reuse, given that the
> next higher layer already has hooks into the direct mapping code.
> 

Okay. Thank you!

I will try to make this happen in v2.

Best regards,
Lu Baolu
