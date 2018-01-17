From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 05/13] iommu/rockchip: Fix error handling in init
Date: Wed, 17 Jan 2018 11:36:03 +0000
Message-ID: <e227cf1e-f00a-5cdb-487c-bf0046f3acbb@arm.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-6-jeffy.chen@rock-chips.com>
 <CAAFQd5AFHheE+5Dx=0=BeL2W1EYd=Kmcb8fKcCBFRgP8ViuxgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAFQd5AFHheE+5Dx=0=BeL2W1EYd=Kmcb8fKcCBFRgP8ViuxgQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>, simon xue <xxm@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 17/01/18 05:26, Tomasz Figa wrote:
> On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> It's hard to undo bus_set_iommu() in the error path, so move it to the
>> end of rk_iommu_probe().
> 
> Does this work fine now? I remember we used to need this called in an
> early initcall for all the ARM/ARM64 DMA stuff to work.

It will do once we get to patch #11 (where the IOMMU_OF_DECLARE ensures 
that masters defer until iommu_register() has set ops with a non-NULL 
.of_xlate callback); in the meantime you might end up depending on DT 
probe order as to whether the master uses the IOMMU or not. I'd say it's 
up to you guys whether you consider that a bisection-breaker or not.

Robin.
