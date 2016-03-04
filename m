From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V4] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
Date: Fri, 4 Mar 2016 13:35:18 -0800
Message-ID: <56D9FF96.5030906@caviumnetworks.com>
References: <1457116784-13287-1-git-send-email-tchalamarla@caviumnetworks.com>
	<20160304205945.GG7886@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160304205945.GG7886-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 03/04/2016 12:59 PM, Will Deacon wrote:
> On Fri, Mar 04, 2016 at 10:39:44AM -0800, Tirumalesh Chalamarla wrote:
>> Due to Errata#27704 CN88xx SMMUv2,supports  only shared ASID and VMID
>> namespaces; specifically within a given node SMMU0 and SMMU1 share,
>> as does SMMU2 and SMMU3.
>>
>> This patch make sure ASID and VMID space is unique across cavium SMMUv2.
>>
>> changes from V3:
>> 	- Removed redundent variable.
>> 	- Used atomic_t for maintaining running total
>>
>> changes from V2:
>> 	- removed *_base from DT, and replaced with compatible string
>>
>> changes from V1:
>> 	- rebased on top of 16 bit VMID patch
>> 	- removed redundent options from DT
>> 	- insted of transform, DT now supplies starting ASID/VMID
>>
>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> Signed-off-by: Akula Geethasowjanya <Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> ---
>>   Documentation/arm64/silicon-errata.txt             |  1 +
>>   .../devicetree/bindings/iommu/arm,smmu.txt         |  1 +
>>   drivers/iommu/arm-smmu.c                           | 42 ++++++++++++++++------
>>   3 files changed, 33 insertions(+), 11 deletions(-)
>
> Hmm, this doesn't seem to apply to my iommu/devel branch. Am I missing
> some dependency?
>
there should not, i will repost based on that branch.

> Will
>
