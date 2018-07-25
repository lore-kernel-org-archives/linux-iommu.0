From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu/arm-smmu: Error out only if not enough context
	interrupts
Date: Wed, 25 Jul 2018 12:57:30 +0100
Message-ID: <20180725115729.GA31576@arm.com>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
	<20180719175356.14753-4-vivek.gautam@codeaurora.org>
	<20180724083633.GA19324@arm.com>
	<d6796a00-17da-c03e-ca7f-7a67139ad99a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d6796a00-17da-c03e-ca7f-7a67139ad99a-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 24, 2018 at 03:09:41PM +0530, Vivek Gautam wrote:
> On 7/24/2018 2:06 PM, Will Deacon wrote:
> >On Thu, Jul 19, 2018 at 11:23:56PM +0530, Vivek Gautam wrote:
> >>diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >>index 7c69736a30f8..4cb53bf4f423 100644
> >>--- a/drivers/iommu/arm-smmu.c
> >>+++ b/drivers/iommu/arm-smmu.c
> >>@@ -2229,12 +2229,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >>  	if (err)
> >>  		return err;
> >>-	if (smmu->version == ARM_SMMU_V2 &&
> >>-	    smmu->num_context_banks != smmu->num_context_irqs) {
> >>-		dev_err(dev,
> >>-			"found only %d context interrupt(s) but %d required\n",
> >>-			smmu->num_context_irqs, smmu->num_context_banks);
> >>-		return -ENODEV;
> >>+	if (smmu->version == ARM_SMMU_V2) {
> >>+		if (smmu->num_context_banks > smmu->num_context_irqs) {
> >>+			dev_err(dev,
> >>+			      "found only %d context irq(s) but %d required\n",
> >>+			      smmu->num_context_irqs, smmu->num_context_banks);
> >>+			return -ENODEV;
> >>+		} else if (smmu->num_context_banks < smmu->num_context_irqs) {
> >>+			/* loose extra context interrupts */
> >>+			dev_notice(dev,
> >>+			      "found %d context irq(s) but only %d required\n",
> >>+			      smmu->num_context_irqs, smmu->num_context_banks);
> >>+			smmu->num_context_irqs = smmu->num_context_banks;
> >>+		}
> >I don't see the utility in the new message. Can you simplify with the patch
> >below on top? It's a bit weird that we only decide to ignore the extra irqs
> >after calling platform_get_irq() on them, but that seems to be harmless.
> 
> Thanks. I will modify as suggested below and respin.

It's ok, I can make the change locally.

Will
