From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 10/29] drivers: add DRIVER_HAS_OWN_IOMMU_MANAGER flag
Date: Mon, 01 Sep 2014 12:47:08 +0200
Message-ID: <54044EAC.6010701@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <20140901070748.GA24226@ulmo.nvidia.com> <540425F9.7080307@samsung.com>
 <4621634.jlJLccozTJ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4621634.jlJLccozTJ@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Thierry Reding <treding@nvidia.com>, Rob Herring <robh@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-09-01 11:38, Arnd Bergmann wrote:
> On Monday 01 September 2014 09:53:29 Marek Szyprowski wrote:
>> On 2014-09-01 09:07, Thierry Reding wrote:
>>> On Mon, Sep 01, 2014 at 07:22:32AM +0200, Marek Szyprowski wrote:
>>>> Hi Greg,
>>>>
>>>> On 2014-08-05 12:47, Marek Szyprowski wrote:
>>>>> This patch adds a new flags for device drivers. This flag instructs
>>>>> kernel that the device driver does it own management of IOMMU assisted
>>>>> IO address space translations, so no default dma-mapping structures
>>>>> should be initialized.
>>>>>
>>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> ---
>>>>>     include/linux/device.h | 2 ++
>>>>>     1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/device.h b/include/linux/device.h
>>>>> index 5f4ff02..2e62371 100644
>>>>> --- a/include/linux/device.h
>>>>> +++ b/include/linux/device.h
>>>>> @@ -253,6 +253,8 @@ struct device_driver {
>>>>>     
>>>>>     /* disables bind/unbind via sysfs */
>>>>>     #define DRIVER_SUPPRESS_BIND_ATTRS       (1 << 0)
>>>>> +/* driver uses own methods to manage IO address space */
>>>>> +#define DRIVER_HAS_OWN_IOMMU_MANAGER       (1 << 1)
>>>>>     
>>>>>     extern int __must_check driver_register(struct device_driver *drv);
>>>>>     extern void driver_unregister(struct device_driver *drv);
>>>> Could you comment if the approach of using flags in the struct driver
>>>> could be accepted? I've converted suppress_bind_attrs entry to flags to
>>>> avoid extending the structure, please see patch "[PATCH 05/29] drivers:
>>>> convert suppress_bind_attrs parameter into flags".
>>> Is this really necessary? What I did as part of an RFC series for Tegra
>>> IOMMU support is keep this knowledge within the IOMMU driver rather than
>>> export it to the driver core.i
>> The problem with embedding the list of drivers that you would need to update
>> it everytime when you modify or extend iommu support in the other drivers.
>> I've tried also other approach, like adding respective notifiers to
>> individual
>> drivers to initialize custom iommu support (or disable default iommu
>> mapping)
>> before iommu driver gets initialized, but such solution is in my opinion too
>> complex and hard to understand if one is not familiar will all this stuff.
>>
>> All in all it turned out that the simplest and most generic way is to simply
>> add the flag to the driver core. Flags might be also used in the future
>> to model other kinds of dependencies between device drivers and/or driver
>> core.
> I don't get it yet. I would expect that a driver doing its own management
> of the iommu gets to use the linux/iommu.h interfaces, while a driver
> using the default iommu setup uses linux/dma-mapping.h.

You are right.

> Who do you think needs to set this flag, and who needs to read it?

In the proposed solution Exynos IOMMU driver creates a separate IO 
address space
for every client device in a system and binds it to the default 
dma-mapping space
for the given device. When drivers are doing its own management of IO 
address
space, instead of relying on what is available by default with dma-mapping
interface, this will require releasing of the previously created default
structures and resources. So this flag is set by the driver doing its own
management of io address space. The flags is then checked by Exynos 
IOMMU driver
to avoid creating the default dma-mapping address space for devices 
which driver
does its own management.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
