From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 7/9] documentation: iommu: add description of ARM System
	MMU binding
Date: Wed, 12 Jun 2013 09:44:15 +0100
Message-ID: <20130612084415.834ED3E0A56@localhost>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
	<1370889285-22799-8-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1370889285-22799-8-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 10 Jun 2013 19:34:43 +0100, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> This patch adds a description of the device tree binding for the ARM
> System MMU architecture.
> 
> Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> new file mode 100644
> index 0000000..e34c6cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -0,0 +1,70 @@
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
> +- compatible    : Should be one of:
> +
> +                        "arm,smmu-v1"
> +                        "arm,smmu-v2"
> +                        "arm,mmu-400"
> +                        "arm,mmu-500"
> +
> +                  depending on the particular implementation and/or the
> +                  version of the architecture implemented.
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
> +                  For SMMUv2 implementations, there must be exactly one
> +                  interrupt per context bank. In the case of a single,
> +                  combined interrupt, it must be listed multiple times.
> +
> +- mmu-masters   : A list of phandles to device nodes representing bus
> +                  masters for which the SMMU can provide a translation
> +                  and their corresponding StreamIDs (see example below).
> +                  Each device node linked from this list must have a
> +                  "#stream-id-cells" property, indicating the number of
> +                  StreamIDs associated with it.
> +
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
> +
> +                /*
> +                 * Two DMA controllers, the first with two StreamIDs (0xd01d
> +                 * and 0xd01e) and the second with only one (0xd11c).
> +                 */
> +                mmu-masters = <&dma0 0xd01d 0xd01e>,
> +                              <&dma1 0xd11c>;
> +        };
> -- 
> 1.8.2.2
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
