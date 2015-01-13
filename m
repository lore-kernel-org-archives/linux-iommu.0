From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Tue, 13 Jan 2015 17:40:01 +0900
Message-ID: <54B4D9E1.10400@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com>
 <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
 <54AC93E0.8010705@samsung.com> <54ACFD69.1020500@collabora.co.uk>
 <54AD0293.70909@samsung.com> <54AEB384.2040005@collabora.co.uk>
 <54B36C5A.6050109@samsung.com> <54B3F1B7.7090307@collabora.co.uk>
 <54B4ABFB.5000501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <54B4ABFB.5000501@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Javier Martinez Canillas <javier@dowhile0.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linaro-mm-sig@lists.linaro.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Tomasz Figa <tomasz.figa@gmail.com>, Inki Dae <inki.dae@samsung.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <treding@nvidia.com>, Cho KyongHo <pullip.cho@samsung.com>, David Wodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On 01/13/2015 02:24 PM, Joonyoung Shim wrote:
> Hi,
> 
> On 01/13/2015 01:09 AM, Javier Martinez Canillas wrote:
>> Hello Joonyoung,
>>
>> On 01/12/2015 07:40 AM, Joonyoung Shim wrote:
>>>> And also making changes to the clocks in the clk-exynos5420 driver. Can
>>>> you please explain the rationale for those changes? I'm asking because
>>>> without your clock changes (only adding the DISP1 pd and making the
>>>> devices as consumers), I've HDMI output too but video is even worse. This
>>>> [0] is the minimal change I have on top of 3.19-rc3 to have some output.
>>>>
>>>
>>> I just refer below patches,
>>> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/34576
>>>
>>> But i'm not sure whether DISP1 power domain is same case with MFC power domain.
>>>
>>
>> Thanks a lot for sharing those patches, now your changes are much more
>> clear to me.
>>
>>>>
>>>> So there seems to be two issues here, one is the mixer and hdmi modules not
>>>> being attached to the DISP1 power domain and another one is the clocks setup
>>>> not being correct to have proper HDMI video output.
>>>>  
>>>
>>> Hmm, i can see normal hdmi output still from latest upstream
>>> kernel(3.19-rc4) with my kernel changes and u-boot changes(DISP1 power
>>> domain disable) of prior mail on odroid xu3 board.
>>>
>>
>> I thought you said on another email that after commit 2ed127697eb1 which
>> landed on 3.19-rc1 you had bad HDMI output?
>>
>> In your changes, it was missing the SW_ACLK_400_DISP1 and USER_ACLK_400_DISP1
>> clock mux outputs that goes to internal buses in the DISP1. Adding IDs for
>> these in the exynos5420 clock driver and to the parent and input clock paris
>> list in the DISP1 power domain gives me a good HDMI output on 3.19-rc2.
>>
>> Also, the SW_ACLK_300_DISP1 and USER_ACLK_300_DISP1 are needed for the FIMD
>> parent and input clock respectively. Adding those to the clocks list of the
>> DISP1 power domain gives me working display + HDMI on my Exynos5800 Peach Pi.
>>
>> These are the changes I have now [0]. Please let me know what you think.
>>
> 
> Good, it's working with your patch without u-boot changes and reverting
> of commit 2ed127697eb.
> 

But i also get stripe hdmi output if hdmi/mixer drivers aren't defered
probed, because DISP1 power domain isn't disabled on booting by defered
probe so is always on.

Thanks.
