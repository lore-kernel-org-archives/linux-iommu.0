From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V5 05/12] drivers: platform: Configure dma operations at probe time
Date: Fri, 20 Jan 2017 11:04:19 +0530
Message-ID: <000201d272de$dc6d1c10$95475430$@codeaurora.org>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org> <1484838356-24962-6-git-send-email-sricharan@codeaurora.org> <20170119164821.GB28483@red-moon>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170119164821.GB28483@red-moon>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

>-----Original Message-----
>From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
>Sent: Thursday, January 19, 2017 10:18 PM
>To: Sricharan R <sricharan@codeaurora.org>
>Cc: robin.murphy@arm.com; will.deacon@arm.com; joro@8bytes.org; iommu@lists.linux-foundation.org; linux-arm-
>kernel@lists.infradead.org; linux-arm-msm@vger.kernel.org; m.szyprowski@samsung.com
>Subject: Re: [PATCH V5 05/12] drivers: platform: Configure dma operations at probe time
>
>On Thu, Jan 19, 2017 at 08:35:49PM +0530, Sricharan R wrote:
>> Configuring DMA ops at probe time will allow deferring device probe when
>> the IOMMU isn't available yet. The dma_configure for the device is
>> now called from the generic device_attach callback just before the
>> bus/driver probe is called. This way, configuring the DMA ops for the
>> device would be called at the same place for all bus_types, hence the
>> deferred probing mechanism should work for all buses as well.
>>
>> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>>        |                         |
>> pci_bus_add_device     (device_add/driver_register)
>>        |                         |
>> device_attach           device_initial_probe
>>        |                         |
>> __device_attach_driver    __device_attach_driver
>>        |
>> driver_probe_device
>>        |
>> really_probe
>>        |
>> dma_configure
>>
>> Similarly on the device/driver_unregister path __device_release_driver is
>> called which inturn calls dma_deconfigure.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  * Removed the dma configuration for the pci devices in case of DT
>>    from pci_dma_configure which was hanging outside separately and
>>    doing it in dma_configure function itself.
>
>Rename the patch subject then, it is misleading.

Ha, infact the patch still does what it says. The above words were
to mention what was changed from V4 to V5. Sorry i should have
mentioned that explicitly.

Regards,
 Sricharan
