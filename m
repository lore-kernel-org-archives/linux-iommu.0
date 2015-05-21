From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [v6 3/8] iommu, x86: Implement irq_set_vcpu_affinity for
	intel_ir_chip
Date: Thu, 21 May 2015 12:48:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505211244110.4225@nanos>
References: <1432191555-3516-1-git-send-email-feng.wu@intel.com>
	<1432191555-3516-4-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432191555-3516-4-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 21 May 2015, Feng Wu wrote:
> +static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
> +{
> +	struct intel_ir_data *ir_data = data->chip_data;
> +	struct irte *irte_pi = &ir_data->irte_pi_entry;
> +	struct vcpu_data *vcpu_pi_info;
> +
> +	/* stop posting interrupts, back to remapping mode */
> +	if (!vcpu_info)
> +		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
> +	else {

We add braces to both branches if one requires it.

> +		vcpu_pi_info = (struct vcpu_data *)vcpu_info;
> +		memcpy(irte_pi, &ir_data->irte_entry, sizeof(struct irte));

This lacks a comment WHY you copy irte_entry to irte_pi_entry and WHY
we have two seperate entries stored in ir_data.

Thanks,

	tglx
