From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: don't touch the secure STLBIALL register
Date: Thu, 8 Jan 2015 14:58:33 -0600
Message-ID: <CAL_JsqLqgZ4tYVpd7pFOE9w8Ca441ahOa1OZ_+=XRPk2-WOQrQ@mail.gmail.com>
References: <1419356362-27343-1-git-send-email-mitchelh@codeaurora.org>
	<20150106141507.GB3484@arm.com>
	<vnkwiogjhdgm.fsf@mitchelh-linux.qualcomm.com>
	<CAL_JsqJYZ+-qt8UXPP7=pCsZFXeOkB8ogOzbuusdv1Cb+o1d2A@mail.gmail.com>
	<vnkw61cjebbq.fsf@mitchelh-linux.qualcomm.com>
	<20150107101300.GC7485@arm.com>
	<vnkw4ms2cwb5.fsf@mitchelh-linux.qualcomm.com>
	<20150107180420.GR7485@arm.com>
	<vnkwh9w2bfr6.fsf@mitchelh-linux.qualcomm.com>
	<20150107185322.GU7485@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150107185322.GU7485-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

+Andreas

On Wed, Jan 7, 2015 at 12:53 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Jan 07, 2015 at 06:35:41PM +0000, Mitchel Humpherys wrote:
>> On Wed, Jan 07 2015 at 10:04:20 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> > On Wed, Jan 07, 2015 at 05:52:46PM +0000, Mitchel Humpherys wrote:
>> >> On Wed, Jan 07 2015 at 02:13:00 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> >> > If would be better to check for the ARM_SMMU_OPT_SECURE_CFG_ACCESS feature
>> >> > and, if it's set then zero ARM_SMMU_GR0_STLBIALL at the correct address
>> >> > otherwise do the ARM_SMMU_GR0_TLBIALLH and ARM_SMMU_GR0_TLBIALLNSNH.
>> >>
>> >> I'm confused.  The problem I'm addressing here is that we're touching a
>> >> register that's marked as "secure only", which causes our system to
>> >> crash.  Why would we ever want to touch a secure only register, calxeda
>> >> workaround or not?
>> >
>> > Because I think the way the SMMU is wired for Calxeda is that the CPU can
>> > only see the secure side of the register interface, so the only way to nuke
>> > the whole TLB would be to use ARM_SMMU_GR0_STLBIALL.
>>
>> Still not sure I understand what "the correct address" is for STLBIALL
>> on Calxeda (i.e. whether or not we need to use ARM_SMMU_GR0_NS), but
>> something like:
>
> Hehe, I wasn't actually expecting a patch, but thanks!
>
>> -- >8 --
>> Subject: [PATCH v2] iommu/arm-smmu: don't touch the secure STLBIALL register
>>
>> Currently we do a STLBIALL when we initialize the SMMU.  However, on
>> systems with sane secure
>> configurations (i.e. !ARM_SMMU_OPT_SECURE_CFG_ACCESS) that register is
>> not supposed to be touched and is marked as "Secure only" in the spec.
>> Touching it results in a crash on those platforms.  However, on
>> platforms with ARM_SMMU_OPT_SECURE_CFG_ACCESS it's the only way to nuke
>> the whole TLB, so leave it in for them but rip it out for everyone else.
>>
>> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 60558f794922..d4c149d83f3d 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1686,9 +1686,12 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>>       }
>>
>>       /* Invalidate the TLB, just in case */
>> -     writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
>> -     writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
>> -     writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
>> +     if (smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS) {
>> +             writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
>
> Right, so this is the bit where we'd need some Calxeda information about
> whether or not to subtract 0x400 from gr0_base or not.

Beats me. I don't recall any configuration option here. The binding
only has a single address. Maybe Andreas remembers.

Rob
