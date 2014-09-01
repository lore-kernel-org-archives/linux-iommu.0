From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 10/29] drivers: add DRIVER_HAS_OWN_IOMMU_MANAGER flag
Date: Mon, 01 Sep 2014 14:07:34 +0200
Message-ID: <54046186.5030407@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <4621634.jlJLccozTJ@wuerfel> <54044EAC.6010701@samsung.com>
 <5493968.dbuSPSqts4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5493968.dbuSPSqts4@wuerfel>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, Rob Herring <robh@kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-09-01 13:56, Arnd Bergmann wrote:
> On Monday 01 September 2014 12:47:08 Marek Szyprowski wrote:
>>> Who do you think needs to set this flag, and who needs to read it?
>> In the proposed solution Exynos IOMMU driver creates a separate IO
>> address space
>> for every client device in a system and binds it to the default
>> dma-mapping space
>> for the given device. When drivers are doing its own management of IO
>> address
>> space, instead of relying on what is available by default with dma-mapping
>> interface, this will require releasing of the previously created default
>> structures and resources. So this flag is set by the driver doing its own
>> management of io address space. The flags is then checked by Exynos
>> IOMMU driver
>> to avoid creating the default dma-mapping address space for devices
>> which driver
>> does its own management.
> I don't completely understand it yet. I would assume the device
> to be added to the default domain at device creation time
> (of_platform_populate), way before we know which device driver
> is going to be used. How can this prevent the iommu driver
> from doing the association with the domain?

of_platform_populate() is too early to do the association, because that 
time the
exynos iommu driver is even not yet probed.

The association with default dma-mapping domain is done in
IOMMU_GROUP_NOTIFY_BIND_DRIVER notifier, just before binding the driver 
to the
given device. This way iommu driver can check dev->driver->flags and 
skip creating
default dma-mapping domain if driver announces that it wants to handle it by
itself.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
