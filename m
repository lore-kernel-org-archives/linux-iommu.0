From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 18/18] iommu: exynos: add callback for initializing
 devices from device tree
Date: Fri, 23 Jan 2015 13:40:58 +0100
Message-ID: <54C2415A.3020508@samsung.com>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
 <1421399592-7482-19-git-send-email-m.szyprowski@samsung.com>
 <CABxcv=nkcY0biXuDH1BHDdOZhrzYWr-YNP13QWzdLfZfQrxouA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CABxcv=nkcY0biXuDH1BHDdOZhrzYWr-YNP13QWzdLfZfQrxouA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-01-19 16:27, Javier Martinez Canillas wrote:
> I wanted to test your IOMMU series on an Exynos5420 Peach Pit but the
> kernel hangs with your series + dependencies on top of 3.19-rc5.
>
> Bisecting I found that $subject is the offending commit. I've pushed
> my test branch [0] in case I missed something.
>
> On Fri, Jan 16, 2015 at 10:13 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> This patch adds implementation of of_xlate callback, which prepares
>> masters device for attaching to IOMMU. This callback is called during
>> creating devices from device tree.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/iommu/exynos-iommu.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index ea2659159e63..5432b443abfc 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -1077,6 +1077,33 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
>>          return phys;
>>   }
>>
>> +static int exynos_iommu_of_xlate(struct device *dev,
>> +                                struct of_phandle_args *spec)
>> +{
>> +       struct exynos_iommu_owner *owner = dev->archdata.iommu;
>> +       struct platform_device *sysmmu = of_find_device_by_node(spec->np);
>> +       struct sysmmu_drvdata *data;
>> +
>> +       if (!sysmmu)
>> +               return -ENODEV;
>> +
>> +       data = platform_get_drvdata(sysmmu);
>> +       if (!data)
>> +               return -ENODEV;
>> +
>> +       if (!owner) {
>> +               owner = kzalloc(sizeof(*owner), GFP_KERNEL);
>> +               if (!owner)
>> +                       return -ENOMEM;
>> +
>> +               INIT_LIST_HEAD(&owner->clients);
>> +               dev->archdata.iommu = owner;
>> +       }
>> +
>> +       list_add_tail(&data->owner_node, &owner->clients);
> This is the line that causes the kernel to hang, if I comment the
> list_add_tail() call then the kernel boots.
>
> I checked that neither data nor owner are NULL and that the
> owner->clients list_head is initialized. Do you have any ideas what
> could be happening?

This is really strange. However the hang is definitely not caused by
adding the controller to the list, but rather the fact that it is later
being initialized, probably in exynos_iommu_attach_device().

Just a quick question - does bootloader on Exynos5420 Peach Pit sets
any image on the display?

If so then we will get IOMMU page fault on init (DMA engine of FIMD is
left enabled from bootloader) and such case is not yet handled.
Besides that I have no idea for any other reason for such failure.

To check if this is caused by io page fault, please temporarily add the
following hack:
--->8---
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7864797609b3..5e70cf7eb31b 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2011,6 +2011,9 @@ static bool arm_setup_iommu_dma_ops(struct device 
*dev, u64 dma_base, u64 size,
          return false;
      }

+    iommu_map(mapping->domain, 0x40000000, 0x40000000, 0x80000000,
+          IOMMU_READ | IOMMU_WRITE);
+
      if (arm_iommu_attach_device(dev, mapping)) {
          pr_warn("Failed to attached device %s to IOMMU_mapping\n",
                  dev_name(dev));

--->8---

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
