From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V2] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
Date: Tue, 23 Feb 2016 15:54:47 -0800
Message-ID: <56CCF147.7080308@caviumnetworks.com>
References: <1455820158-8529-1-git-send-email-tchalamarla@caviumnetworks.com>
	<20160223122616.GE4989@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160223122616.GE4989@leverpostej>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 02/23/2016 04:26 AM, Mark Rutland wrote:
> On Thu, Feb 18, 2016 at 10:29:18AM -0800, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org wrote:
>> From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>>
>> Due to Errata#27704 CN88xx SMMUv2,supports  only shared ASID and VMID
>> namespaces; specifically within a given node SMMU0 and SMMU1 share,
>> as does SMMU2 and SMMU3.
>>
>> This patch tries to address these issuee by supplying asid and vmid
>> base from devicetree.
>>
>> changes from V1:
>> 	- rebased on top of 16 bit VMID patch
>> 	- removed redundent options from DT
>> 	- insted of transform, DT now supplies starting ASID/VMID
>>
>> Signed-off-by: Akula Geethasowjanya <Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> ---
>>   .../devicetree/bindings/iommu/arm,smmu.txt         |  8 +++++
>>   drivers/iommu/arm-smmu.c                           | 37 +++++++++++++++-------
>>   2 files changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index bb7e569..80b8484 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -57,6 +57,14 @@ conditions.
>>
>>   - smmu-enable-vmid16 : Enable 16 bit VMID, if allowed.
>>
>> +- asid-base :	Buggy SMMUv2 implementations which doesn't satisfy the
>> +		ASID namespace needs, use this field to specify starting
>> +		ASID for the SMMU.
>> +
>> +- vmid-base :	Buggy SMMUv2 implementations which doesn't satisfy the VMID
>> +		namespace needs, use this field to specify starting VMID
>> +		for the SMMU.
>
> As has been pointed out, these are not strictly properties of the
> hardware, and are insufficient to aovid the issue in general (adding an
> arbitrary base does not enforce IDs fall within a particular range).
>

pardon my ignorance, are you saying what happens if DT don't know what 
values to send?
> So NAK for *-base properties alone.
>
>> +	if (of_property_read_u32(dev->of_node, "#asid-base",
>> +				 &smmu->asid_base)) {
>> +		smmu->asid_base = 0;
>> +	}
>> +
>> +	if (of_property_read_u32(dev->of_node, "#vmid-base",
>> +				 &smmu->vmid_base)) {
>> +		smmu->vmid_base = 1;
>> +	}
>
> These do not match the documentation above.
>
> Mark.
>
