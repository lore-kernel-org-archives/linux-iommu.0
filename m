From: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drivers/of_iommu: ignore SMMU DT nodes with status 'disabled'
Date: Wed, 3 May 2017 11:58:30 +0100
Message-ID: <4B3EA199-183C-40CE-8C7B-E55CD92FD402@linaro.org>
References: <20170414124315.2401-1-ard.biesheuvel@linaro.org> <20170428131133.GJ13675@arm.com> <CAKv+Gu_G9fw0kwSetXmGjomc8Y_nu95O=rEVzgfafNRs0dtgvg@mail.gmail.com> <20170428131744.GL13675@arm.com> <CAKv+Gu8L1iyzBitt8zzvWDDEXk_ysGfPRxHJbQQK5o8NMWF5MA@mail.gmail.com> <1c0463e6-f82f-1179-4f54-b2d3de63dc87@arm.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1c0463e6-f82f-1179-4f54-b2d3de63dc87-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


> On 3 May 2017, at 11:32, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>=20
>> On 28/04/17 14:22, Ard Biesheuvel wrote:
>>> On 28 April 2017 at 14:17, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>>>> On Fri, Apr 28, 2017 at 02:14:49PM +0100, Ard Biesheuvel wrote:
>>>>> On 28 April 2017 at 14:11, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>>>>> Hi Ard,
>>>>>=20
>>>>> [+ devicetree@]
>>>>>=20
>>>>>> On Fri, Apr 14, 2017 at 01:43:15PM +0100, Ard Biesheuvel wrote:
>>>>>> DT nodes may have a status property, and if they do, such nodes shoul=
d
>>>>>> only be considered present if the status property is set to 'okay'.
>>>>>>=20
>>>>>> Currently, we call the init function of IOMMUs described by the devic=
e
>>>>>> tree without taking this into account, which may result in the output=

>>>>>> below on systems where some SMMUs may be legally disabled.
>>>>>>=20
>>>>>> Failed to initialise IOMMU /smb/smmu@e0200000
>>>>>> Failed to initialise IOMMU /smb/smmu@e0c00000
>>>>>> arm-smmu e0a00000.smmu: probing hardware configuration...
>>>>>> arm-smmu e0a00000.smmu: SMMUv1 with:
>>>>>> arm-smmu e0a00000.smmu:  stage 2 translation
>>>>>> arm-smmu e0a00000.smmu:  coherent table walk
>>>>>> arm-smmu e0a00000.smmu:  stream matching with 32 register groups, mas=
k 0x7fff
>>>>>> arm-smmu e0a00000.smmu:  8 context banks (8 stage-2 only)
>>>>>> arm-smmu e0a00000.smmu:  Supported page sizes: 0x60211000
>>>>>> arm-smmu e0a00000.smmu:  Stage-2: 40-bit IPA -> 40-bit PA
>>>>>> Failed to initialise IOMMU /smb/smmu@e0600000
>>>>>> Failed to initialise IOMMU /smb/smmu@e0800000
>>>>>>=20
>>>>>> Since this is not an error condition, only call the init function if
>>>>>> the device is enabled, which also inhibits the spurious error message=
s.
>>>>>>=20
>>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>> ---
>>>>>> drivers/iommu/of_iommu.c | 2 +-
>>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>=20
>>>>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>>>>> index 2683e9fc0dcf..2dd1206e6c0d 100644
>>>>>> --- a/drivers/iommu/of_iommu.c
>>>>>> +++ b/drivers/iommu/of_iommu.c
>>>>>> @@ -183,7 +183,7 @@ static int __init of_iommu_init(void)
>>>>>>      for_each_matching_node_and_match(np, matches, &match) {
>>>>>>              const of_iommu_init_fn init_fn =3D match->data;
>>>>>>=20
>>>>>> -             if (init_fn(np))
>>>>>> +             if (of_device_is_available(np) && init_fn(np))
>>>>>>                      pr_err("Failed to initialise IOMMU %s\n",
>>>>>>                              of_node_full_name(np));
>>>>>>      }
>>>>>=20
>>>>> Is there a definition of what status =3D "disabled" is supposed to mea=
n for an
>>>>> IOMMU? For example, that could mean that the firmware has pre-programm=
ed the
>>>>> SMMU with particular translations or memory attributes (a bit like the=

>>>>> CCA=3D1, CPM=3D1, DACS=3D0 case in ACPI IORT), or even disabled DMA tr=
affic
>>>>> altogether.
>>>>>=20
>>>>> So I think we'd need an update to the generic IOMMU binding text to sa=
y
>>>>> exactly what the semantics are supposed to be here.
>>>>>=20
>>>>=20
>>>> I agree that it might make sense to describe the behavior of the IOMMU
>>>> when it is left in the state we found it in. But that is not the same
>>>> as status=3Ddisabled.
>>>>=20
>>>> The DTS subtree contains loads and loads of boilerplate
>>>> configurations, where only some pieces are enabled in the final image
>>>> by setting status=3Dokay. So a node that has status 'disabled' should b=
e
>>>> treated as 'not present', not as 'present but can be ignored under
>>>> assumptions such and such'
>>>>=20
>>>> In other words, I think we are talking about two different issues here.=

>>>=20
>>> I'm not so sure... if we have a master device that has an iommus=3D prop=
erty
>>> pointing to an IOMMU with status=3D"disabled", I really don't know wheth=
er we
>>> should:
>>>=20
>>>  1. Assume the master can do DMA with a 1:1 mapping of memory and no
>>>     changes to memory attributes
>>>=20
>>>  2. Assume the master can do DMA with a 1:1 mapping of memory, but
>>>     potentially with changes to the attributes
>>>=20
>>>  3. Assume the master can do DMA, but with some pre-existing translation=

>>>     (what?)
>>>=20
>>>  4. Assume the master can't do DMA
>>>=20
>>> and I also don't know whether the "dma-coherent" property remains valid.=

>>>=20
>>=20
>> Ah yes. Good point.
>>=20
>> So indeed, there should be some IOMMU specific status property that
>> can convey all of the above, or 1. and 4. at the minimum
>=20
> FWIW, the underlying issue being addressed here should be going away now
> anyway, since the now-queued probe deferral series obviates the init_fn
> early-device-creation bodge. I've been deliberately ignoring it for some
> time for precisely that reason ;)
>=20


Ok. I have also updated the Seattle firmware to remove the smmu nodes and th=
e associated iommus/iommu-map properties entirely when disabling SMMU suppor=
t in the firmware, which should address Will's concern regarding unspecified=
 behavior of a disabled SMMU.

IOW, this patch can be disregarded. Thanks.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
