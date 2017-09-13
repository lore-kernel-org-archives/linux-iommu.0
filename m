From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 6/6] iommu/arm-smmu-v3: Avoid ILLEGAL setting of
	STE.S1STALLD and CD.S
Date: Wed, 13 Sep 2017 16:47:27 +0100
Message-ID: <e214b851-efa8-a45f-7deb-b99f3873564b@arm.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
	<1504167642-14922-7-git-send-email-xieyisheng1@huawei.com>
	<738977bb-4cd7-7d86-0ea0-0c88b6af721c@arm.com>
	<20170913030643.GD12411@arm.com>
	<2f952821-afc3-46dd-17eb-40e8626bd6e5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2f952821-afc3-46dd-17eb-40e8626bd6e5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "chenjiankang1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <chenjiankang1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 13/09/17 11:11, Yisheng Xie wrote:
> Hi Will,
> =

> On 2017/9/13 11:06, Will Deacon wrote:
>> On Tue, Sep 05, 2017 at 01:54:19PM +0100, Jean-Philippe Brucker wrote:
>>> On 31/08/17 09:20, Yisheng Xie wrote:
>>>> It is ILLEGAL to set STE.S1STALLD if STALL_MODEL is not 0b00, which
>>>> means we should not disable stall mode if stall/terminate mode is not
>>>> configuable.
>>>>
>>>> Meanwhile, it is also ILLEGAL when STALL_MODEL=3D=3D0b10 && CD.S=3D=3D=
0 which
>>>> means if stall mode is force we should always set CD.S.
>>>>
>>>> This patch add ARM_SMMU_FEAT_TERMINATE feature bit for smmu, and use
>>>> TERMINATE feature checking to ensue above ILLEGAL cases from happening.
>>>>
>>>> Signed-off-by: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>>=A0 drivers/iommu/arm-smmu-v3.c | 22 ++++++++++++++++------
>>>>=A0 1 file changed, 16 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>>> index dbda2eb..0745522 100644
>>>> --- a/drivers/iommu/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>>> @@ -55,6 +55,7 @@
>>>>=A0 #define IDR0_STALL_MODEL_SHIFT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
24
>>>>=A0 #define IDR0_STALL_MODEL_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0x3
>>>>=A0 #define IDR0_STALL_MODEL_STALL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
(0 << IDR0_STALL_MODEL_SHIFT)
>>>> +#define IDR0_STALL_MODEL_NS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 (1 << IDR0_STALL_MODEL_SHIFT)
>>>>=A0 #define IDR0_STALL_MODEL_FORCE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
(2 << IDR0_STALL_MODEL_SHIFT)
>>>>=A0 #define IDR0_TTENDIAN_SHIFT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 21
>>>>=A0 #define IDR0_TTENDIAN_MASK=A0=A0=A0=A0=A0=A0=A0=A0 0x3
>>>> @@ -766,6 +767,7 @@ struct arm_smmu_device {
>>>>=A0 #define ARM_SMMU_FEAT_SVM=A0=A0=A0=A0=A0=A0=A0=A0=A0 (1 << 15)
>>>>=A0 #define ARM_SMMU_FEAT_HA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (1 << 16)
>>>>=A0 #define ARM_SMMU_FEAT_HD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (1 << 17)
>>>> +#define ARM_SMMU_FEAT_TERMINATE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (1 <=
< 18)
>>>
>>> I'd rather introduce something like "ARM_SMMU_FEAT_STALL_FORCE" instead.
>>> Terminate model has another meaning, and is defined by a different bit =
in
>>> IDR0.
>> =

>> Yes. What we need to do is:
>> =

>> - If STALL_MODEL is 0b00, then set S1STALLD
> =

> Yes, and within this case, we can only set the S1STALLD for masters which=
 can
> not stall in the future?
> =

>> - If STALL_MODEL is 0b01, then we're ok (in future, avoiding trying to u=
se
>>=A0=A0 stalls, even for masters that claim to support it)
>> - If STALL_MODEL is 0b10, then force all PCI devices and any platform
>>=A0=A0 devices that don't claim to support stalls into bypass (depending =
on
>>=A0=A0 disable_bypass).
>> =

>> Reasonable? We could actually knock up a fix for mainline to do most of
>> this already.
> This sound reasonable to me. And I can be a volunteer to prepare this pat=
ch if
> Jean-Philippe do not oppose :)

Sure go ahead, I'll rebase the platform SVM work on top of it.

Thanks,
Jean
