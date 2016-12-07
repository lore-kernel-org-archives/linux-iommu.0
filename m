From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [RESEND PATCH V6 0/6] Add support for privileged mappings
Date: Wed, 7 Dec 2016 15:14:37 +0530
Message-ID: <003001d2506e$8a9b64b0$9fd22e10$@codeaurora.org>
References: <1480690509-13490-1-git-send-email-sricharan@codeaurora.org> <e7e05493-e216-d744-b828-351d2c70150d@arm.com> <000d01d24e02$e3023700$a906a500$@codeaurora.org> <ad7a90ce-c1cd-856e-8573-394c05fda6e4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ad7a90ce-c1cd-856e-8573-394c05fda6e4@arm.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Robin Murphy' <robin.murphy@arm.com>, jcrouse@codeaurora.org, pdaly@codeaurora.org, jgebben@codeaurora.org, joro@8bytes.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org, iommu@lists.linux-foundation.org, tzeng@codeaurora.org, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, mitchelh@codeaurora.org, vinod.koul@intel.com
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>>> Hi Sricharan,
>>>
>>> On 02/12/16 14:55, Sricharan R wrote:
>>>> This series is a resend of the V5 that Mitch sent sometime back [2]
>>>> All the patches are the same and i have just rebased. Not sure why this
>>>> finally did not make it last time. The last patch in the previous
>>>> series does not apply now [3], so just redid that. Also Copied the tags
>>>> that he had from last time as well.
>>>
>>> Heh, I was assuming this would be down to me to pick up. Vinod did have
>>> some complaints last time about the commit message on the PL330 patch -
>>> I did get as far as rewriting that and reworking onto my SMMU
>>> changes[1], I just hadn't got round to sending it, so it fell onto the
>>> "after the next merge window" pile.
>>>
>>> I'd give some review comments, but they'd essentially be a diff against
>>> that branch :)
>>>
>>
>> Sure, i did not knew that you were on this already. I can repost with the diff
>> from your branch taken in or wait for you as well. I am fine with either ways
>> that you suggest.
>>
>> I checked the patches against your branch, i see that the changes are,
>>
>> 1) one patch for implementing it for armv7s descriptor
>> 2) Changes on pl330 patch commit logs and
>> 3) One patch for doing the revert on arm-smmuv3 as well.
>
>If you want to pick up my short-descriptor and SMMUv3 patches and run
>with them you're more than welcome - the rest is just cosmetic stuff
>which doesn't really matter, especially as it's picking up acks as-is.
>

Sure, i will repost with additional stuff picked up from your branch and
the acks as well.

Regards,
 Sricharan
