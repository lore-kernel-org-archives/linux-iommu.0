From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Fri, 5 Apr 2019 13:57:26 +0100
Message-ID: <d7e21f40-a639-c3e5-c259-3b05562a5446@arm.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
 <CAL_JsqKbqNDMx26Tkyrem-NXF_0iApcWaaEDphtfy6kX050Upg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKbqNDMx26Tkyrem-NXF_0iApcWaaEDphtfy6kX050Upg@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>, Neil Armstrong <narmstrong@baylibre.com>, "Marty E . Plummer" <hanetzer@startmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: iommu@lists.linux-foundation.org

On 03/04/2019 05:57, Rob Herring wrote:
[...]
>>> +static int panfrost_clk_init(struct panfrost_device *pfdev)
>>> +{
>>> +     int err;
>>> +     unsigned long rate;
>>> +
>>> +     pfdev->clock = devm_clk_get(pfdev->dev, NULL);
>>> +     if (IS_ERR(pfdev->clock)) {
>>
>> The DT binding says clocks are optional, but this doesn't treat them as
>> such.
> 
> Hum, I would think effectively clocks are always there and necessary
> for thermal reasons.

Should the binding be updated to move clocks from "optional" to 
"required" then? Juno does actually have a GPU clock for DVFS, but the 
clk-scmi driver didn't seem to want to play nicely with either 
mali_kbase or panfrost DRM, so I've just been leaving it out of my DT 
for now (and mali_kbase was perfectly happy without).

>>> +     spin_lock_init(&pfdev->mm_lock);
>>> +
>>> +     /* 4G enough for now. can be 48-bit */
>>> +     drm_mm_init(&pfdev->mm, SZ_32M >> PAGE_SHIFT, SZ_4G);
>>
>> You probably want a dma_set_mask_and_coherent() call for your 'real'
>> output address size somewhere - the default 32-bit mask works out OK for
>> RK3399, but on systems with RAM above 4GB io-pgtable will get very
>> unhappy about DMA bounce-buffering.
> 
> Yes, I have a todo for figuring out the # of physaddr bits in the mmu
> setup (as this call is just relevant to the input address side).
> Though maybe just calling dma_set_mask_and_coherent() is enough and I
> don't need to know the exact number of output bits for the io-pgtable
> setup?

True, io-pgtable itself only really depends on the input size, but in 
order for non-coherent pagtables to work correctly in general, the DMA 
mask does need to be set appropriately, at which point it may as well 
also be propagated into OAS for completeness (as we do in arm-smmu*).

FWIW I'm just gonna leave this quote here...

	gpu_props->mmu.va_bits = KBASE_UBFX32(raw->mmu_features, 0U, 8);
	gpu_props->mmu.pa_bits = KBASE_UBFX32(raw->mmu_features, 8U, 8);


Robin.
