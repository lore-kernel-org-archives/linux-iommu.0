From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC 2/2] drivers: dma-mapping: parse per device reserved mem
 at probe time
Date: Thu, 07 Dec 2017 13:01:45 +0100
Message-ID: <c47720b4-17cf-200b-bac4-85653cd06700@samsung.com>
References: <20171126131346.12532-1-peng.fan@nxp.com>
        <CGME20171126131432epcas4p23145c6f438f7f186545456960f284b91@epcas4p2.samsung.com>
        <20171126131346.12532-2-peng.fan@nxp.com>
        <875c3a8c-a857-823e-0243-487d1dd9bee7@samsung.com>
        <20171127083713.clh6oz5sgere4usq@linux-u7w5.ap.freescale.net>
        <e44416ee-0f33-e310-d881-aaa3edfdf69e@samsung.com>
        <20171127090409.posgikgumpoq4wdm@linux-u7w5.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171127090409.posgikgumpoq4wdm@linux-u7w5.ap.freescale.net>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Fan <van.freenix@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, hch@lst.de, robin.murphy@arm.com, gregkh@linuxfoundation.org, robh+dt@kernel.org, frowand.list@gmail.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Peng,

On 2017-11-27 10:04, Peng Fan wrote:
> On Mon, Nov 27, 2017 at 09:44:20AM +0100, Marek Szyprowski wrote:
>> On 2017-11-27 09:37, Peng Fan wrote:
>>> On Mon, Nov 27, 2017 at 09:31:00AM +0100, Marek Szyprowski wrote:
>>>> On 2017-11-26 14:13, Peng Fan wrote:
>>>>> Invoke of_reserved_mem_device_init at dma_configure, then
>>>>> there is no need to call of_reserved_mem_device_init in device
>>>>> specific probe function.
>>>>>
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>> This has been already tried long time ago, without success:
>>>> http://patches.linaro.org/patch/33558/
>>> Thanks for the info. I should first search mail list before
>>> sending out patches.
>> It doesn't mean that I'm against such idea. I just pointed that I've
>> already tried. That time, however there was no dma_configure() function
>> yet, which seems to be better place for of_rmem_device_init().
>>
>> I would however always call of_dma_configure(), even when reserved mem
>> node is there. IIRC on ARM64 that function configures dma_ops, without
>> which no dma is possible at all.
> So, you prefer this?
> 	if (dma_dev->of_node) {
> +		of_reserved_mem_device_init(dev);
> 		ret = of_dma_configure(dev, dma_dev->of_node);
>
> However in of_reserved_mem_device, there is also an call to
> of_dma_configure.
>
> "
> 	/* ensure that dma_ops is set for virtual devices
> 	 * using reserved memory
> 	 */
> 	 ret = of_dma_configure(dev, np);
> "
>
> If always call of_dma_configure, of_dma_configure maybe called twice.

Right, I forgot about this.

> I just checked more. of_reserved_mem_device_init only handle the first
> memory-region. To nodes which have multiple memory-region, seems 2nd and etc
> could not be handled, such as drivers/media/platform/s5p-mfc/s5p_mfc.c.

Well, maybe automatic assignment should be done only when there is only
one reserved region set? In case more than one region assigned to a device,
the driver has to create virtual child devices and configure DMA for them
to be able to let dma-mapping API to use those reserved regions. It looks
that the call to of_dma_configure(dev, np) can be moved back to the driver
(it was not possible at the time that code was merged due to missing
export symbols).

Configuring more than one reserved memory region for given device might
then moved to some helper function to have a common code for that across
the drivers.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
