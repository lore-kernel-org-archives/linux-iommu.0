From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
 binding
Date: Fri, 05 Apr 2013 13:44:49 -0700
Message-ID: <515F37C1.4000109@codeaurora.org>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>, tzeng@codeaurora.com, devicetree-discuss@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 4/4/2013 9:50 AM, Will Deacon wrote:
> This patch adds a description of the device tree binding for the ARM
> System MMU architecture.
> 
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Hello,
> 
> The driver for this is still a WIP. Both Andreas and myself have prototype
> code, but we're planning to merge that together to get something more
> general. Deciding on the binding is a good first step.
> 
> All comments welcome,
> 
> Will
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> new file mode 100644
> index 0000000..938325f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -0,0 +1,61 @@
> +* ARM System MMU Architecture Implementation
> +
> +ARM SoCs may contain an implementation of the ARM System Memory
> +Management Unit Architecture, which can be used to provide 1 or 2 stages
> +of address translation to bus masters external to the CPU.
> +
> +The SMMU may also raise interrupts in response to various fault
> +conditions.
> +
> +** System MMU required properties:
> +
> +- compatible    : Should be one of "arm,smmu-v1" or "arm,smmu-v2"
> +                  depending on the version of the architecture
> +                  implemented.
> +
> +- reg           : Base address and size of the SMMU.
> +
> +- #global-interrupts : The number of global interrupts exposed by the
> +                       device.
> +
> +- interrupts    : Interrupt list, with the first #global-irqs entries
> +                  corresponding to the global interrupts and any
> +                  following entries corresponding to context interrupts,
> +                  specified in order of their indexing by the SMMU.
> +
> +- mmu-masters   : A list of phandles to device nodes representing bus
> +                  masters for which the SMMU can provide a translation.

I am not sure I understand the use of mmu-masters. I would imagine that
the bus masters themselves would have phandles to their respective SMMUs
that provides the translation.

> +
> +- stream-ids    : A list of 16-bit values corresponding to the StreamIDs
> +                  for the devices listed in the mmu-masters property.
> +                  This list must be same length as mmu-masters, so
> +                  masters with multiple stream-ids will have multiple
> +                  entries in mmu-masters.
> +

Why are the stream IDs (SIDs) coupled with the bus masters in this way?
You are probably following a different pattern than we do. Our SMMU
driver programs the SMMU SIDs and does not really know or care which
mmu-master it belongs to.

> +** System MMU optional properties:
> +
> +- smmu-parent   : When multiple SMMUs are chained together, this
> +                  property can be used to provide a phandle to the
> +                  parent SMMU (that is the next SMMU on the path going
> +                  from the mmu-masters towards memory) node for this
> +                  SMMU.
> +
> +Example:
> +
> +        smmu {
> +                compatible = "arm,smmu-v1";
> +                reg = <0xba5e0000 0x10000>;
> +                #global-interrupts = <2>;
> +                interrupts = <0 32 4>,
> +                             <0 33 4>,
> +                             <0 34 4>, /* This is the first context interrupt */
> +                             <0 35 4>,
> +                             <0 36 4>,
> +                             <0 37 4>;
> +                mmu-masters = <&dma0>,
> +                              <&dma0>,
> +                              <&dma1>;
> +                stream-ids  = <0xd01d>,
> +                              <0xd01e>,
> +                              <0xd11c>;
> +        };
> 

Hi Will,

Please see my comments above. I would like to work with you on defining
the bindings for System MMU. We have had System MMU DT bindings for some
time and I'd like to share what we are doing in hope that we can merge
something that works for all of us.

We use some of the same properties but we have a lot more. We also model
the context banks as children of each SMMU in an object-oriented way.

Here is our current binding for SMMUv1:

* Qualcomm MSM IOMMU v1

Required properties:
- compatible : one of:
	- "qcom,msm-smmu-v1"
- reg : offset and length of the register set for the device. Optional
	offset and length for clock register for additional clock that
	needs to be turned on for access to this IOMMU.
- reg-names: "iommu_base", "clk_base" (optional)
- label: name of this IOMMU instance.

Optional properties:
- qcom,iommu-secure-id : Secure identifier for the IOMMU block
- vdd-supply : vdd-supply: phandle to GDSC regulator controlling this IOMMU.
- qcom,alt-vdd-supply : Alternative regulator needed to access IOMMU
  configuration registers.
- interrupts : should contain the performance monitor overflow interrupt
number.
- qcom,iommu-enable-halt : Enable halt of the IOMMU before programming
certain	registers
- qcom,iommu-pmu-ngroups: Number of Performance Monitor Unit (PMU) groups.
- qcom,iommu-pmu-ncounters: Number of PMU counters per group.
- qcom,iommu-pmu-event-classes: List of event classes supported.
- qcom,needs-alt-core-clk : boolean to enable the secondary core clock
for access to the IOMMU configuration registers
- qcom,iommu-bfb-regs : An array of unsigned 32-bit integers
corresponding to BFB register addresses that need to be configured for
performance tuning purposes. If this property is present, the
qcom,iommu-bfb-data must also be present. Register addresses are
specified as an offset from the base of the IOMMU hardware block. This
property may be omitted if no BFB register configuration needs to be
done for a particular IOMMU hardware instance. The registers specified
by this property shall fall within the IOMMU implementation-defined
register region.
- qcom,iommu-bfb-data : An array of unsigned 32-bit integers
representing the values to be programmed into the corresponding
registers given by the qcom,iommu-bfb-regs property. If this property is
present, the qcom,iommu-bfb-regs property shall also be present, and the
lengths of both properties shall be the same.

- List of sub nodes, one for each of the translation context banks
supported.
  Each sub node has the following required properties:

  - reg : offset and length of the register set for the context bank.
  - interrupts : should contain the context bank interrupt.
  - qcom,iommu-ctx-sids : List of stream identifiers associated with
this translation context.
  - label : Name of the context bank

Optional sub-node properties:
   - qcom,secure-context : boolean indicating that a context is secure
 and programmed by the secure environment.

Example:

	qcom,iommu@fda64000 {
		compatible = "qcom,msm-smmu-v1";
		reg = <0xfda64000 0x10000>;
		reg-names = "iommu_base";
		vdd-supply = <&gdsc_iommu>;
		qcom,iommu-bfb-regs = <0x204c 0x2050>;
		qcom,iommu-bfb-data = <0xffff 0xffce>;
		label = "iommu_0";
		qcom,iommu-pmu-ngroups = <1>;
		qcom,iommu-pmu-ncounters = <8>;
		qcom,iommu-pmu-event-classes = <0x00,
						0x01>;

		qcom,iommu-ctx@fda6c000 {
			reg = <0xfda6c000 0x1000>;
			interrupts = <0 70 0>;
			qcom,iommu-ctx-sids = <0 2>;
			label = "ctx_0";
		};
		qcom,iommu-ctx@fda6d000 {
			reg = <0xfda6d000 0x1000>;
			interrupts = <0 70 0>;
			qcom,iommu-ctx-sids = <1>;
			label = "ctx_1";
		};
	};

Please let me know your thoughts on this.

Thanks,

Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
