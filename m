From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] swiotlb: Fix unexpected swiotlb_alloc_coherent() failures
Date: Tue, 10 Apr 2018 18:50:04 +0100
Message-ID: <40618b9c-786d-7f5f-3f5b-fc1dd8375846@arm.com>
References: <20180410170513.22834-1-tiwai@suse.de>
	<20180410170615.GA27589@lst.de> <s5hzi2bat25.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <s5hzi2bat25.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
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
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/04/18 18:07, Takashi Iwai wrote:
> On Tue, 10 Apr 2018 19:06:15 +0200,
> Christoph Hellwig wrote:
>>
>> On Tue, Apr 10, 2018 at 07:05:13PM +0200, Takashi Iwai wrote:
>>> The code refactoring by commit 0176adb00406 ("swiotlb: refactor
>>> coherent buffer allocation") made swiotlb_alloc_buffer() almost always
>>> failing due to a thinko: namely, the function evaluates the
>>> dma_coherent_ok() call incorrectly and dealing as if it's invalid.
>>> This ends up with weird errors like iwlwifi probe failure or amdgpu
>>> screen flickering.
>>>
>>> This patch corrects the logic error.
>>
>> This looks ok, although even hitting this code is a bad sign.  Do you
>> know why the previous dma_direct_alloc didn't succeed?
> 
> That I have no idea, sorry.  I just figured out the regression just
> from the dmesg output of 4.16 kernel in bugzilla reports.
> Could you take a look at the bugzilla reports there?

In the first one, the machine appears to have enough RAM that most of it 
is beyond the device's 36-bit DMA mask, thus it's fairly likely for the 
initial direct alloc to come back with something unsuitable.

Robin.

> 
> 
> thanks,
> 
> Takashi
> 
>>> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1088658
>>> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1088902
>>> Fixes: 0176adb00406 ("swiotlb: refactor coherent buffer allocation")
>>> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v4.16+
>>> Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
>>> ---
>>>   lib/swiotlb.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
>>> index 47aeb04c1997..de7cc540450f 100644
>>> --- a/lib/swiotlb.c
>>> +++ b/lib/swiotlb.c
>>> @@ -719,7 +719,7 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>>   		goto out_warn;
>>>   
>>>   	*dma_handle = __phys_to_dma(dev, phys_addr);
>>> -	if (dma_coherent_ok(dev, *dma_handle, size))
>>> +	if (!dma_coherent_ok(dev, *dma_handle, size))
>>>   		goto out_unmap;
>>>   
>>>   	memset(phys_to_virt(phys_addr), 0, size);
>>> -- 
>>> 2.16.3
>> ---end quoted text---
>>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
