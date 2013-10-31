From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 6/6] documentation/iommu: Update description of ARM
 System MMU binding
Date: Thu, 31 Oct 2013 01:17:15 +0000
Message-ID: <20131031011715.GF28613@mudshark.cambridge.arm.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
 <1382127195-15261-7-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1382127195-15261-7-git-send-email-andreas.herrmann@calxeda.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas Herrmann <andreas.herrmann@calxeda.com>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 18, 2013 at 09:13:15PM +0100, Andreas Herrmann wrote:
> This patch adds descriptions fore new properties of device tree
> binding for the ARM SMMU architecture. These properties control
> arm-smmu driver options.
> 
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index e34c6cd..de88cf9 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -48,6 +48,17 @@ conditions.
>                    from the mmu-masters towards memory) node for this
>                    SMMU.
>  
> +- arm,smmu-isolate-devices : Enable device isolation for all masters
> +                             of this SMMU. Ie. each master will be
> +                             attached to its own iommu domain.
> +
> +- arm,smmu-secure-config-access : Enable proper handling of buggy
> +                                  implementations that always use
> +                                  secure access to SMMU configuration
> +                                  registers. In this case non-secure
> +                                  aliases of secure registers have to
> +                                  be used during SMMU configuration.

Why are you using the "arm" vendor prefix for the secure config access
stuff? Wouldn't it make more sense to use "calxeda", just in case somebody
else finds a different way to wire things up in this regard?

Will
