From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 3/5] documentation/iommu: update description of ARM System
 MMU binding
Date: Fri, 21 Feb 2014 21:57:37 +0300
Message-ID: <5307A1A1.7070601@cogentembedded.com>
References: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
 <1393002992-24561-4-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393002992-24561-4-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>, Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hello.

On 02/21/2014 08:16 PM, Will Deacon wrote:

> From: Andreas Herrmann <andreas.herrmann@calxeda.com>

> This patch adds descriptions for new properties of the device tree
> binding for the ARM SMMU architecture. These properties control
> arm-smmu driver options.

> Cc: Grant Likely <grant.likely@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> [will: removed device isolation property, as this has been dropped]
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index e34c6cdd8ba8..d6d2f6dd437a 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -48,6 +48,12 @@ conditions.
>                     from the mmu-masters towards memory) node for this
>                     SMMU.
>
> +- calxeda,smmu-secure-config-access : Enable proper handling of buggy
> +                  implementations that always use secure access to
> +                  SMMU configuration registers. In this case non-secure
> +		  aliases of secure registers have to be used during
> +		  SMMU configuration.

    Could you indent the text uniformly, in this case probably with spaces 
only (looking at the above property)?

WBR, Sergei
