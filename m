From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v11 20/27] iommu/exynos: allow having multiple System MMUs
 for a master H/W
Date: Wed, 19 Mar 2014 14:20:34 +0100
Message-ID: <532999A2.6030107@samsung.com>
References: <20140314141050.c8bedcb66532d277c496796d@samsung.com>
 <53232A53.4040708@samsung.com>
 <20140318220128.564740c88d06b86c9c5c10e3@samsung.com>
 <532857A8.5060000@samsung.com>
 <20140319093929.d3a7cea131c626cf978e0ff1@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20140319093929.d3a7cea131c626cf978e0ff1@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On 19.03.2014 01:39, Cho KyongHo wrote:
> On Tue, 18 Mar 2014 15:26:48 +0100, Tomasz Figa wrote:
>>
>>
>> On 18.03.2014 14:01, Cho KyongHo wrote:
>>> On Fri, 14 Mar 2014 17:12:03 +0100, Tomasz Figa wrote:
>>>> Hi KyongHo,
>>>>
>>>> On 14.03.2014 06:10, Cho KyongHo wrote:
>>>>> Some master device descriptor like fimc-is which is an abstraction
>>>>> of very complex H/W may have multiple System MMUs. For those devices,
>>>>> the design of the link between System MMU and its master H/W is needed
>>>>> to be reconsidered.
>>>>>
>>>>> A link structure, sysmmu_list_data is introduced that provides a link
>>>>> to master H/W and that has a pointer to the device descriptor of a
>>>>> System MMU. Given a device descriptor of a master H/W, it is possible
>>>>> to traverse all System MMUs that must be controlled along with the
>>>>> master H/W.
>>>>
>>>> NAK.
>>>>
>>>> A device driver should handle particular hardware instances separately,
>>>> without abstracting a virtual hardware instance consisting of multiple
>>>> physical ones.
>>>>
>>>> If such abstraction is needed, it should be done above the exynos-iommu
>>>> driver, e.g. by something like iommu-composite driver that would
>>>> aggregate several IOMMUs. Keep in mind that such IOMMUs in a group could
>>>> be different, e.g. different Exynos SysMMU versions or even completely
>>>> different IPs handled by different drivers.
>>>>
>>>> Still, I don't think there is a real need for such abstraction. Instead,
>>>> related drivers shall be fixed to properly handle multiple memory
>>>> masters and their IOMMUs.
>>>>
>>>
>>> G2D, Scalers and FIMD of Exynos5420 has 2 System MMUs while aother SoC like
>>> Exynos5250 does not.
>>>
>>> I don't understand why you are negative to this approach.
>>> This is the simplest than the others.
>>>
>>> Let me show you an example.
>>> FIMC-IS driver just controls MCU in FIMC-IS subsystem and the firmware of
>>> the MCU controls all other peripherals in the subsystem. Each peripherals
>>> have their own System MMU. Moreover, the configuration of the peripherals
>>> varies according to the SoCs.
>>>
>>> If System MMU driver accepts multiple masters, everything is done in DT.
>>> But I worry that it is not easy if System MMU driver does not support
>>> multiple masters.
>>
>> I believe I have stated enough reasons why this kind of implementation
>> is bad. I'm not going to waste time repeating myself.
>>
>> Your concerns presented above are valid, however they are not related to
>> what is wrong with this patch. I have given you two proper ways to
>> handle this, none should be forced upon particular IOMMU master drivers
>> - their authors should have the chance to select the method that works
>> best for them.
>>
>
> I don't still understand why you think this patch is wrong.
> I think this is the best way not to think for all the driver developers
> about other things than their business logic.

I agree, but one of the ways I proposed (an iommu-composite layer above 
the IOMMU low level drivers) doesn't add any extra responsibility of 
driver developers.

Moreover, it's this kind of business logic in low level drivers that is 
adding more responsibility, because it introduces additional complexity 
and makes the driver harder to read, maintain and extend in future.

>
> This does not hurt anyone and I think this is good enough.
>

Well, it is barely good enough. It is a good practice to make a low 
level driver handle a single device instance and this is how Linux 
driver model is designed.

Moreover, a single device tree node _must_ represent a single hardware 
block, so you can't group multiple SysMMUs into a single device tree node.

Furthermore, if you force grouping of SysMMUs into a single virtual one, 
you enforce using the same address space for all masters of some 
particular hardware blocks, while potentially driver developers would 
like to separate them.

A good interface design should not enforce any particular implementation 
and this is what we should stick to in this case as well.

> If you want to provide another layer between master device and system mmu
> as you mentioned, you do that. This patch does not restrict it.

It does, as mentioned above. With a device tree listing multiple SysMMUs 
as one, you can't separate them.

Best regards,
Tomasz
