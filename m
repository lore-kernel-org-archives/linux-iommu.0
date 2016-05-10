From: =?UTF-8?B?SG9uZ2h1aSBaaGFuZyAo5byg5rSq6L6JKQ==?=
	<honghui.zhang@mediatek.com>
Subject: Re: [PATCH 1/5] dt-bindings: mediatek: add descriptions for mediatek
 mt2701 iommu and smi
Date: Tue, 10 May 2016 09:13:07 +0800
Message-ID: <c06cbea8-3882-9021-22f8-b0e378018ec2@mediatek.com>
References: <1462780816-5288-1-git-send-email-honghui.zhang@mediatek.com>
 <1462780816-5288-2-git-send-email-honghui.zhang@mediatek.com>
 <20160509202236.GA23951@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509202236.GA23951@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: joro@8bytes.org, treding@nvidia.com, mark.rutland@arm.com, matthias.bgg@gmail.com, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pebolle@tiscali.nl, kendrick.hsu@mediatek.com, arnd@arndb.de, srv_heupstream@mediatek.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, tfiga@google.com, iommu@lists.linux-foundation.org, djkurtz@google.com, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, youlin.pei@mediatek.com, erin.lo@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On 5/10/2016 4:22 AM, Rob Herring wrote:
> On Mon, May 09, 2016 at 04:00:12PM +0800, honghui.zhang@mediatek.com wrote:
>> From: Honghui Zhang <honghui.zhang@mediatek.com>
>>
>> This patch defines the local arbitor port IDs for mediatek SoC MT2701 and
>> add descriptions of binding for mediatek generation one iommu and smi.
>>
>> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
>> ---
>>  .../devicetree/bindings/iommu/mediatek,iommu.txt   | 13 +++-
>>  .../memory-controllers/mediatek,smi-common.txt     | 21 +++++-
>>  .../memory-controllers/mediatek,smi-larb.txt       |  4 +-
>>  include/dt-bindings/memory/mt2701-larb-port.h      | 85 ++++++++++++++++++++++
>>  4 files changed, 115 insertions(+), 8 deletions(-)
>>  create mode 100644 include/dt-bindings/memory/mt2701-larb-port.h
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>> index cd1b1cd..9a4a5b5 100644
>> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>> @@ -1,7 +1,9 @@
>>  * Mediatek IOMMU Architecture Implementation
>>  
>> -  Some Mediatek SOCs contain a Multimedia Memory Management Unit (M4U) which
>> -uses the ARM Short-Descriptor translation table format for address translation.
>> +  Some Mediatek SOCs contain a Multimedia Memory Management Unit (M4U), and
>> +this M4U have two generations of HW architecture. Generation one use flat
> 
> s/use/uses/

Hi, Rob,
Thank you very much, I will fix all of those in the next version.

> 
>> +pagetable, and only support 4K size page mapping. Generation two uses the
> 
> s/support/supports/
> 
>> +ARM Short-Descriptor translation table format for address translation.
>>  
>>    About the M4U Hardware Block Diagram, please check below:
>>  
>> @@ -36,7 +38,9 @@ in each larb. Take a example, There are many ports like MC, PP, VLD in the
>>  video decode local arbiter, all these ports are according to the video HW.
>>  
>>  Required properties:
>> -- compatible : must be "mediatek,mt8173-m4u".
>> +- compatible : must be one of the following string:
>> +	"mediatek,mt2701-m4u" for mt2701 which use generation one m4u HW.
>> +	"mediatek,mt8173-m4u" for mt8173 which use generation two m4u HW.
>>  - reg : m4u register base and size.
>>  - interrupts : the interrupt of m4u.
>>  - clocks : must contain one entry for each clock-names.
>> @@ -46,7 +50,8 @@ Required properties:
>>  	according to the local arbiter index, like larb0, larb1, larb2...
>>  - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
>>  	Specifies the mtk_m4u_id as defined in
>> -	dt-binding/memory/mt8173-larb-port.h.
>> +	dt-binding/memory/mt2701-larb-port.h for mt2701 and
>> +	dt-binding/memory/mt8173-larb-port.h for mt8173
>>  
>>  Example:
>>  	iommu: iommu@10205000 {
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>> index 06a83ce..80c0e22 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>> @@ -2,16 +2,31 @@ SMI (Smart Multimedia Interface) Common
>>  
>>  The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
>>  
>> +Mediatek SMI have two generation HW architecture, mt8173 use the secondary
> 
> s/generation/generations of/
> s/use/uses/
> s/secondary/second/
> 
>> +generation of SMI HW while mt2701 use the first generation HW of SMI.
> 
> s/use/uses/
> 
>> +
>> +There's slight differences between the two SMI, for generation 2, the
>> +register which control the iommu port is at each larb's register base. But
>> +for generation 1, the register is at smi ao base(smi always on register
>> +base). Besides that, the smi async clock should be prepare and enabled for
> 
> s/prepare/prepared/
> 
>> +SMI generation 1 to transform the smi clock into emi clock domain, but no
> 
> s/no/that is not/
> 
>> +needed for SMI generation 2.
>> +
>>  Required properties:
>> -- compatible : must be "mediatek,mt8173-smi-common"
>> +- compatible : must be one of :
>> +	"mediatek,mt2701-smi-common"
>> +	"mediatek,mt8173-smi-common"
>>  - reg : the register and size of the SMI block.
>>  - power-domains : a phandle to the power domain of this local arbiter.
>>  - clocks : Must contain an entry for each entry in clock-names.
>> -- clock-names : must contain 2 entries, as follows:
>> +- clock-names : must contain 3 entries for generation 1 smi HW and 2 entries
>> +  for generation 2 smi HW as follows:
>>    - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
>>  	    the register.
>>    - "smi" : It's the clock for transfer data and command.
>> -  They may be the same if both source clocks are the same.
>> +	    They may be the same if both source clocks are the same.
>> +  - "async" : asynchronous clock, it help transform the smi clock into the emi
>> +	      clock domain, this clock is only needed by generation 1 smi HW.
>>  
>>  Example:
>>  	smi_common: smi@14022000 {
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>> index 55ff3b7..21277a5 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>> @@ -3,7 +3,9 @@ SMI (Smart Multimedia Interface) Local Arbiter
>>  The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
>>  
>>  Required properties:
>> -- compatible : must be "mediatek,mt8173-smi-larb"
>> +- compatible : must be one of :
>> +		"mediatek,mt8173-smi-larb"
>> +		"mediatek,mt2701-smi-larb"
>>  - reg : the register and size of this local arbiter.
>>  - mediatek,smi : a phandle to the smi_common node.
>>  - power-domains : a phandle to the power domain of this local arbiter.
> 
