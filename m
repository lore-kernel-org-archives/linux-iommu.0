From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback
 instead of initcall
Date: Tue, 16 Dec 2014 11:58:06 +0100
Message-ID: <5490103E.9000503@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <4894156.QdIh4JzSl0@avalon> <20141215181323.GX20738@arm.com>
 <1582013.9WDR2r2f3r@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1582013.9WDR2r2f3r@avalon>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>, Joerg Roedel <joro@8bytes.org>, Tomasz Figa <tomasz.figa@gmail.com>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Cho KyongHo <pullip.cho@samsung.com>, David Wodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-12-15 19:19, Laurent Pinchart wrote:
> On Monday 15 December 2014 18:13:23 Will Deacon wrote:
>> On Mon, Dec 15, 2014 at 05:53:48PM +0000, Laurent Pinchart wrote:
>>> On Monday 15 December 2014 17:43:02 Will Deacon wrote:
>>>> On Mon, Dec 15, 2014 at 05:27:30PM +0000, Laurent Pinchart wrote:
>>>>> On Monday 15 December 2014 17:17:00 Will Deacon wrote:
>>>>>> Creating the platform device manually for the IOMMU is indeed
>>>>>> grotty, but I don't really understand why it's needed. Interrupt
>>>>>> controllers, for example, seem to get by without one.
>>>>> There's several reasons, one of the most compelling ones I can think
>>>>> of at the moment is runtime PM. IRQ controllers close to the CPU use
>>>>> CPU PM notifiers instead. Note that IRQ controllers that are further
>>>>> away from the CPU (such as GPIO-based IRQ controllers) are real
>>>>> platform devices and use runtime PM.
>>>> Ok, that's a good point, but the IOMMU will still probe later anyway,
>>>> right?
>>> That depends on the driver implementation, using OF node match an IOMMU
>>> driver doesn't have to register a struct driver. Assuming we require
>>> IOMMU drivers to register a struct driver, a platform device should then
>>> be probed at a later time.
>>>
>>> However, if we wait until the IOMMU gets probed to initialize runtime PM
>>> and make it functional, we'll be back in square one if the IOMMU gets
>>> probed after the bus master, as the bus master could start issuing bus
>>> requests at probe time with the IOMMU not powered yet.
>> True, but couldn't the early init code do enough to get the thing
>> functional? That said, I'm showing my ignorance here as I'm not familiar
>> with the PM code (and the software models I have for the SMMU clearly don't
>> implement anything in this regard).
> We're reaching the limits of my knowledge as well. If the IOMMU is in a power
> domain different than the bus masters the driver would at least need to ensure
> that the power domain is turned on, which might be a bit hackish without
> runtime PM.

In case of Exynos SoC both IOMMU and master device are in the same power 
domain.
During iommu_attach() call driver needs to have power domain enabled, 
but power
domain driver is probed from arch_initcall(). I wanted to move power domain
initialization earlier to ensure that it will happen before IOMMU driver 
probe,
that not really a problem. Right now it usually works, because power 
domains are
enabled by bootloader.

However please not that I would really like to have something merged. The
discussion about iommu controllers lasts for about 2 years and we still 
don't
have ANYTHING working in mainline, so lets merge the of_iommu glue and then
check how the remaining issues can be solved.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
