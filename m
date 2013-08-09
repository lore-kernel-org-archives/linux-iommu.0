From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v9 07/16] iommu/exynos: support for device tree
Date: Fri, 9 Aug 2013 08:28:09 -0500
Message-ID: <CAL_JsqKM_YP0Cj3Uo7TeCVcKcbzzsuK3yxTSn6pG8qGFOnZAiA@mail.gmail.com>
References: <002b01ce941b$160a88a0$421f99e0$@samsung.com>
	<5396565.vjlSOm37Vf@flatron>
	<20130809153730.83d3a5ba419def5424bcbb0e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20130809153730.83d3a5ba419def5424bcbb0e@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Subash Patel <supash.ramaswamy@linaro.org>, Grant Grundler <grundler@chromium.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 9, 2013 at 1:37 AM, Cho KyongHo <pullip.cho@samsung.com> wrote:
> On Fri, 09 Aug 2013 00:41:25 +0200, Tomasz Figa wrote:
>> Hi KyongHo,
>>
>> On Thursday 08 of August 2013 18:38:49 Cho KyongHo wrote:
>> > This commit adds device tree support for System MMU.
>> > This also include the following changes and enhancements:
>> >
>> > * use managed device helper functions.
>> > Simplyfies System MMU device driver.
>> >
>> > * use only a single clock descriptor.
>> > System MMU device descriptor is seperate if it is imposible to make
>> > a single clock descriptor to make a device descriptor for a group of
>> > System MMUs.
>> >
>> > * removed dbgname member from sysmmu_drvdata structure.
>> > debugging kernel message for a System MMU is distinguisheable with the
>> > name of device descroptors.
>>
>> Please put all these three changes in separate patches. This patch is hard
>> to review with all the changes mixed together...

Agreed.

>>
>
> Ok.
>
>> In addition, I believe this is the patch that should be adding device tree
>> binding documentation, not the 6/16 one, as this is where actually support
>> for this binding gets added to the kernel.
>
> Oh, I didn't know that devicetree binding description and implementation need
> to be in the same patch.
> I will do as you advised.

Actually, I prefer the binding docs be separate patches. The reason
being so we can get closer to having them in a separate repository.
Also, then the binding can be acked separately from the kernel
implementation using the binding.

Rob
