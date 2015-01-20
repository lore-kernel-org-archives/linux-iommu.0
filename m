From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v7 2/2] iommu/arm-smmu: add support for iova_to_phys
	through ATS1PR
Date: Tue, 20 Jan 2015 11:45:55 -0800
Message-ID: <vnkwmw5d44ng.fsf@mitchelh-linux.qualcomm.com>
References: <1414617220-21493-1-git-send-email-mitchelh@codeaurora.org>
	<1414617220-21493-3-git-send-email-mitchelh@codeaurora.org>
	<20150120141643.GA1549@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150120141643.GA1549-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Tue,
	20 Jan 2015 14:16:43 +0000")
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 20 2015 at 06:16:43 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> Hey Mitch,
>
> On Wed, Oct 29, 2014 at 09:13:40PM +0000, Mitchel Humpherys wrote:
>> Currently, we provide the iommu_ops.iova_to_phys service by doing a
>> table walk in software to translate IO virtual addresses to physical
>> addresses. On SMMUs that support it, it can be useful to ask the SMMU
>> itself to do the translation. This can be used to warm the TLBs for an
>> SMMU. It can also be useful for testing and hardware validation.
>> 
>> Since the address translation registers are optional on SMMUv2, only
>> enable hardware translations when using SMMUv1 or when SMMU_IDR0.S1TS=1
>> and SMMU_IDR0.ATOSNS=0, as described in the ARM SMMU v1-v2 spec.
>> 
>> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>> Changes since v6:
>>   - added missing lock
>>   - fixed physical address mask
>
> I had a go at rebasing this onto my current queue, but ended up making
> quite a few changes. Can you take a look at the result, please?
>
> Patch below (also on my for-joerg/arm-smmu/updates branch).

The modified patch looks good to me.  Thanks!

-Mitch


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
