From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 0/4] Add larbid init routine for mediatek's gen1 smi
 larb driver
Date: Fri, 4 Aug 2017 16:28:36 +0200
Message-ID: <781f5dee-9a2d-30b6-b080-8b027de41b03@gmail.com>
References: <1501810348-20997-1-git-send-email-honghui.zhang@mediatek.com>
 <20170804100632.GC17443@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170804100632.GC17443@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, honghui.zhang@mediatek.com
Cc: robh@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org, devicetree@vger.kernel.org, kendrick.hsu@mediatek.com, srv_heupstream@mediatek.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com, erin.lo@mediatek.com, yong.wu@mediatek.com, xinping.qian@mediatek.com
List-Id: iommu@lists.linux-foundation.org



On 08/04/2017 12:06 PM, Joerg Roedel wrote:
> On Fri, Aug 04, 2017 at 09:32:24AM +0800, honghui.zhang@mediatek.com wrote:
>> Honghui Zhang (4):
>>    memory: mtk-smi: Use of_device_get_match_data helper
>>    memory: mtk-smi: add larbid handle routine
>>    dt-bindings: mediatek: add descriptions for larbid
>>    arm: dts: mediatek: add larbid property for larb
>>
>>   .../memory-controllers/mediatek,smi-larb.txt       | 15 +++++++++++++
>>   arch/arm/boot/dts/mt2701.dtsi                      |  3 +++
>>   drivers/memory/mtk-smi.c                           | 26 ++++++++++++----------
>>   3 files changed, 32 insertions(+), 12 deletions(-)
> 
> Applied, thanks.
> 

I just pushed patch 4/4 to v4.13-next/dts32

Thanks everybody!
