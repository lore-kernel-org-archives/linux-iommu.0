From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC][PATCH 1/2] Introduce the IOMMU_DEVICE flag.
Date: Mon, 06 Oct 2014 11:35:59 -0700
Message-ID: <5432E10F.8060702@codeaurora.org>
References: <1412591296-31934-1-git-send-email-Varun.Sethi@freescale.com>
	<20141006110428.GE12935@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141006110428.GE12935-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/6/2014 4:04 AM, Will Deacon wrote:
> Hi Varun,
>
> [adding the Qualcomm guys, as I have an open question below]
>
> On Mon, Oct 06, 2014 at 11:28:15AM +0100, Varun Sethi wrote:
>> This is used for indicating device memory type for a DMA transaction. IOMMU
>> driver would set up attributes indicationg access to device memory.
>>
>> Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>> ---
>>   include/linux/iommu.h |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 20f9a52..0599fe1 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -28,6 +28,7 @@
>>   #define IOMMU_WRITE	(1 << 1)
>>   #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
>>   #define IOMMU_EXEC	(1 << 3)
>> +#define IOMMU_DEVICE	(1 << 4) /* Indicates access to device memory */
>
> An alternative to this would be to make device-memory the default type for
> !IOMMU_CACHE mappings (i.e. MAIR index 0).
>
> I'd value feedback either way; the argument comes down to whether we should
> use normal non-cacheable or device-nGnRE as the default (!IOMMU_CACHE) memory
> type. The latter is likely to be significantly slower, but provides the
> ordering guarantees that you need for MSI delivery.

We would prefer to stay with normal non-cacheable as the default since 
this is our most common use case and this is what is the default now.

.Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
