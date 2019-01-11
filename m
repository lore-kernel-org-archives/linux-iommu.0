From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 2/2] dts: arm64/sdm845: Add node for arm,mmu-500
Date: Thu, 10 Jan 2019 19:15:04 -0800
Message-ID: <20190111031504.GC17247@minitux>
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181011094930.17010-3-vivek.gautam@codeaurora.org>
 <20190108065935.GA11536@builder>
 <9675f7d8-a726-07d3-34b7-99b7464a6303@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9675f7d8-a726-07d3-34b7-99b7464a6303@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, david.brown@linaro.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, will.deacon@arm.com, dianders@chromium.org
List-Id: iommu@lists.linux-foundation.org

On Tue 08 Jan 03:18 PST 2019, Vivek Gautam wrote:

> 
> On 1/8/2019 12:29 PM, Bjorn Andersson wrote:
> > On Thu 11 Oct 02:49 PDT 2018, Vivek Gautam wrote:
> > 
> > > Add device node for arm,mmu-500 available on sdm845.
> > > This MMU-500 with single TCU and multiple TBU architecture
> > > is shared among all the peripherals except gpu.
> > > 
> > Hi Vivek,
> > 
> > Applying this patch together with UFS ([1] and [2]) ontop of v5.0-rc1
> > causes my MTP reboot once the UFSHCD module is inserted and probed.
> > Independently the patches seems to work fine.
> > 
> > Do you have any suggestion to why this would be?
> 
> 
> Hi Bjorn,
> 
> Enabling SMMU on sdm845 when you have UFS also enabled, would need addition
> of
> 'iommus' property to ufs dt node.
> You will need to add the following with ufs:
> 
> iommus = <&apps_smmu 0x100 0xf>;
> 

Thanks, this do address the sudden restart of my MTP, but provides a
fault.

[    7.391117] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0xffffdf3e0, fsynr=0x290000, cb=0
[    7.747406] ufshcd-qcom 1d84000.ufshc: ufshcd_verify_dev_init: NOP OUT failed -11

The only thing done ontop of v5.0-rc1, is to take your patch adding
apps_smmu, add the ufs nodes as Evan proposed and specify iommus in the
ufshcd node.


With Coreboot UFS seems to work without specifying iommus, but with it
UFS fails to come up.

Regards,
Bjorn

> Thanks
> Vivek
> 
> > 
> > [1] https://lore.kernel.org/lkml/20181210192826.241350-4-evgreen@chromium.org/
> > [2] https://lore.kernel.org/lkml/20181210192826.241350-5-evgreen@chromium.org/
> > 
> > Regards,
> > Bjorn
> > 
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > ---
> > > 
> > > Changes since v3:
> > >   - none.
> > > 
> > >   arch/arm64/boot/dts/qcom/sdm845.dtsi | 72 ++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 72 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index b72bdb0a31a5..0aace729643d 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -1297,6 +1297,78 @@
> > >   			cell-index = <0>;
> > >   		};
> > > +		apps_smmu: iommu@15000000 {
> > > +			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
> > > +			reg = <0x15000000 0x80000>;
> > > +			#iommu-cells = <2>;
> > > +			#global-interrupts = <1>;
> > > +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> > > +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
> > > +		};
> > > +
> > >   		apss_shared: mailbox@17990000 {
> > >   			compatible = "qcom,sdm845-apss-shared";
> > >   			reg = <0x17990000 0x1000>;
> > > -- 
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > > of Code Aurora Forum, hosted by The Linux Foundation
> > > 
