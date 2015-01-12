From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Mon, 12 Jan 2015 18:43:31 +0900
Message-ID: <54B39743.1010804@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com>
 <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
 <54AC93E0.8010705@samsung.com> <54ACFD69.1020500@collabora.co.uk>
 <54AD0293.70909@samsung.com> <54AEB384.2040005@collabora.co.uk>
 <54B36C5A.6050109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <54B36C5A.6050109@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Javier Martinez Canillas <javier@dowhile0.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rob Herring <robh@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>, David Wodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <treding@nvidia.com>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, Cho KyongHo <pullip.cho@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 01/12/2015 03:40 PM, Joonyoung Shim wrote:
> Hi,
> 
> On 01/09/2015 01:42 AM, Javier Martinez Canillas wrote:
>> Hello Joonyoung,
>>
>> On 01/07/2015 10:55 AM, Joonyoung Shim wrote:
>>>>>
>>>>> I don't think iommu support and power domain issue are related. I also
>>>>> get displaying stripes via hdmi but it is just power domain issue
>>>>> regardless iommu support.
>>>>>
>>>>> I observed 8th bit from 0x1445000C register of mixer is set to 1 with
>>>>> displaying stripes. It means "The graphic layer0 line buffer underflow".
>>>>> There was same underflow issue on Exynos4 based boards. As Marek said,
>>>>> because LCD0 power domain was turned off.
>>>>>
>>>>
>>>> Interesting, thanks a lot for sharing this information.
>>>>  
>>>>> I just tried to turn off DISP1 power domain at u-boot and DISP1 power
>>>>> domain is turned on from kernel hdmi and mixer driver on odroid xu3 
>>>>> board. As the result, i can see displaying penguin logo from hdmi.
>>>>>
>>>>
>>>> Can you share the patches you are using to turn on the DISP1 power domain
>>>> since AFAIU the kernel does not know about the DISP1 power domain after
>>>> commit d51cad7df871 ("ARM: dts: remove display power domain for exynos5420").
>>>>
>>>> I tried reverting that commit before so the kernel knows about the DISP1
>>>> power domain and booting with pd_ignore_unused but still had the stripes.
>>>>  
>>>
>>> I add DISP1 power domain on dts and please refer below patch[0] with
>>> some modification on hdmi phy(Actually, i think this is not related).
>>> You also should disable DISP1 power domain from bootloader.
>>>
>>
>> Thanks a lot for the patch. With your changes I have some HDMI output on
>> my Peach Pi. But the HDMI output is broken since the resolution is very
>> low and the video as a lot of visual artifacts.
>>
>> In your change you are also adding clock phandles for the pd oscillator
>> clock and the CLK_MOUT_SW_ACLK200, CLK_MOUT_USER_ACLK200_DISP1 pairs for
>> the parent input and input clocks of the devices attached to the pd.
>>
>> And also making changes to the clocks in the clk-exynos5420 driver. Can
>> you please explain the rationale for those changes? I'm asking because
>> without your clock changes (only adding the DISP1 pd and making the
>> devices as consumers), I've HDMI output too but video is even worse. This
>> [0] is the minimal change I have on top of 3.19-rc3 to have some output.
>>
> 
> I just refer below patches,
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/34576
> 
> But i'm not sure whether DISP1 power domain is same case with MFC power domain.
> 
>> The docs I've access to, don't have information about the clock hierarchy.
>> So each time there is a clock issue, I've a hard time to figure out what's
>> happening.
>>
>> So there seems to be two issues here, one is the mixer and hdmi modules not
>> being attached to the DISP1 power domain and another one is the clocks setup
>> not being correct to have proper HDMI video output.
>>  
> 
> Hmm, i can see normal hdmi output still from latest upstream
> kernel(3.19-rc4) with my kernel changes and u-boot changes(DISP1 power
> domain disable) of prior mail on odroid xu3 board.
> 
>>>>> But the problem exists still because it is failed to control on/off of
>>>>> DISP1 power domain more than twice from kernel hdmi and mixer driver.[0]
>>>>>
>>
>> I didn't have this issue when testing your patch against 3.19-rc2. From your
>> log I see that you are testing on a 3.18.1. So maybe makes sense to test with
>> the latest kernel version since this HDMI issue qualifies as an 3.19-rc fix?
>>
>> Since commit 2ed127697eb1 ("PM / Domains: Power on the PM domain right after attach completes")
>> that landed in 3.19-rc1, I see that the power domain is powered on when a
>> device is attached. So maybe that is what makes a difference here?
>>
> 

I also get ashake hdmi output since commit 2ed127697eb1, it causes
on and off of DISP1 power domain when hdmi/mixer driver probe is defered
because regulator driver is not probed yet.

I'm not sure why it causes abnormal hdmi operation.

Thanks.

> I'm not sure, but i get same error results from 3.19-rc4. Did you test
> using exynos drm driver? I used modetest of libdrm
> 
