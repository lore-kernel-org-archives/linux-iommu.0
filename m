From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/3] Docs: dt: arm-smmu: Add optional clock parameter
Date: Tue, 24 Jul 2018 17:25:22 -0500
Message-ID: <7a8041ff-ce54-6640-9c9b-d018b0534ff8@linux.intel.com>
References: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
	<1531499278-32132-2-git-send-email-thor.thayer@linux.intel.com>
	<20180720161507.GA24992@rob-hp-laptop>
Reply-To: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180720161507.GA24992@rob-hp-laptop>
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
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

On 07/20/2018 11:15 AM, Rob Herring wrote:
> On Fri, Jul 13, 2018 at 11:27:56AM -0500, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org wrote:
>> From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>
>> Add a clock to the SMMU node bindings.
>>
>> Signed-off-by: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index 8a6ffce12af5..356fd9f41e1b 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -71,6 +71,8 @@ conditions.
>>                     or using stream matching with #iommu-cells = <2>, and
>>                     may be ignored if present in such cases.
>>   
>> +- clock:          clock provider specifier
>> +
> 
> The TRM says there is a TCU clock and clock per TBU.
> 
> Rob
> 
Yes, good point. I'm abandoning this review and will use the bulk clock 
suggested in [1].

In our case, the TCU clock is always on and we have 1 clock for the
TBU masters.

Thanks for reviewing!

Thor

[1] https://patchwork.kernel.org/patch/10534089/
