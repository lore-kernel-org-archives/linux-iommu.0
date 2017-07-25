From: Anup Patel <anup.patel@broadcom.com>
Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: add IOMMU_CAP_BYPASS to the ARM
 SMMUv3 driver
Date: Tue, 25 Jul 2017 14:29:33 +0530
Message-ID: <CAALAos8pLM203B5aRhDy0tkwQoWt3Nym8h2vYC7wLFq-5PpzVw@mail.gmail.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
 <1500456838-18405-4-git-send-email-anup.patel@broadcom.com>
 <ace28bd1-2dd3-482c-d11b-539c055ee9b7@arm.com> <CAALAos8y0kLGrbwgz3u=ZVyteSicuPyQZ3Yp=LPZohXzVaE5NQ@mail.gmail.com>
 <20170719112524.GF13642@arm.com> <CAALAos_xGCt7U1Oz5uCf9Q4hP6fdn4fcymFNQP5xO_UBduSY3g@mail.gmail.com>
 <20170719113325.GI13642@arm.com> <CAALAos99HWLoW=0P-dvFA+oNsF03TRNzNbfppyQNtqmcRELXXQ@mail.gmail.com>
 <20170719115333.GJ13642@arm.com> <CAALAos-YbVbgvPmDYXeWaF4y8MQ9i7CG3tgGuf-QLR6hmXo18Q@mail.gmail.com>
 <20170720091003.GA17837@arm.com> <8e82d8f5-e5e2-dd09-c774-29f9eda2ecdd@arm.com>
 <20170724111621.7f1c3a85@w520.home> <6468f359-1682-b9b0-5a4d-72738939cb84@arm.com>
 <20170724130656.5240ae0d@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724130656.5240ae0d@w520.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Scott Branden <sbranden@broadcom.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, kvm@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 25, 2017 at 12:36 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 24 Jul 2017 18:23:20 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
>
>> On 24/07/17 18:16, Alex Williamson wrote:
>> > On Thu, 20 Jul 2017 12:17:12 +0100
>> > Robin Murphy <robin.murphy@arm.com> wrote:
>> >
>> >> On 20/07/17 10:10, Will Deacon wrote:
>> >>> On Thu, Jul 20, 2017 at 09:32:00AM +0530, Anup Patel wrote:
>> >>>> On Wed, Jul 19, 2017 at 5:23 PM, Will Deacon <will.deacon@arm.com> wrote:
>> >>>>> There are two things here:
>> >>>>>
>> >>>>>   1. iommu_present() is pretty useless, because it applies to a "bus" which
>> >>>>>      doesn't actually tell you what you need to know for things like the
>> >>>>>      platform_bus, where some masters might be upstream of an SMMU and
>> >>>>>      others might not be.
>> >>>>
>> >>>> I agree with you. The iommu_present() check in vfio_iommu_group_get()
>> >>>> is not much useful. We only reach line which checks iommu_present()
>> >>>> when iommu_group_get() returns NULL for given "struct device *". If there
>> >>>> is no IOMMU group for a "struct device *" then it means there is no IOMMU
>> >>>> HW doing translations for such device.
>> >>>>
>> >>>> If we drop the iommu_present() check (due to above reasons) in
>> >>>> vfio_iommu_group_get() then we don't require the IOMMU_CAP_BYPASS
>> >>>> and we can happily drop PATCH1, PATCH2, and PATCH3.
>> >>>>
>> >>>> I will remove the iommu_present() check in vfio_iommu_group_get()
>> >>>> because it is only comes into actions when VFIO_NOIOMMU is
>> >>>> enabled. This will also help us drop PATCH1-to-PATCH3.
>> >>>
>> >>> I don't think that's the right answer. Whilst iommu_present has obvious
>> >>> shortcomings, its intention is clear: it should tell you whether a given
>> >>> *device* is upstream of an IOMMU. So the right fix is to make this
>> >>> per-device, instead of per-bus. Removing it altogether is worse than leaving
>> >>> it like it is.
>> >>
>> >> Not really - if there is an IOMMU up and running to the point of setting
>> >> bus ops, every device it cares about can be expected to have a group
>> >> already (there are only a couple of drivers left that don't use groups,
>> >> and they're hardly relevant to VFIO). Thus iommu_group_get() already is
>> >> the de-facto per-device IOMMU check.
>> >>
>> >> And having looked into it, I'm now spinning a couple of patches to
>> >> finish off making groups truly mandatory so that that can be less
>> >> de-facto ;)
>> >
>> > No, look at vfio-noiommu and even vfio-mdev devices for devices which
>> > have an iommu group but there is no physical iommu supporting them.
>> > iommu_present() is how we can distinguish these groups and therefore
>> > not generate a segfault in trying to use the full IOMMU API on them.
>>
>> OK, so that means that the combination of vfio-noiommu and vfio-platform
>> is simply unusable, because iommu_present(&platform_bus_type) can give
>> such dangerous false positives too.
>
> Yep, this kinda falls apart since platform_bus_type doesn't really map
> to a physical bus, nor does the presence of a group canonically
> demonstrate that an iommu is present since anyone can create a group
> for a device.  We really do need to migrate to per-device iommu_ops.
> Thanks,

Yes, per-device iommu_ops will make things much cleaner. That's why
I have dropped VFIO no-IOMMU and IOMMU_CAP_BYPASS related
patches.

Can you please have a look at FlexRM platform reset driver?

Regards,
Anup
