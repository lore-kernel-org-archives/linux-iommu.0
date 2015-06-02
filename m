From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [v8 3/9] iommu, x86: Implement irq_set_vcpu_affinity for
	intel_ir_chip
Date: Tue, 2 Jun 2015 15:59:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1506021501070.3786@nanos>
References: <1432699544-17444-1-git-send-email-feng.wu@intel.com>
	<1432699544-17444-4-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432699544-17444-4-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

On Wed, 27 May 2015, Feng Wu wrote:
> +	/* stop posting interrupts, back to remapping mode */
> +	if (!vcpu_info) {
> +		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
> +	} else {
> +		vcpu_pi_info = (struct vcpu_data *)vcpu_info;
> +
> +		/*
> +		 * "ir_data->irte_entry" saves the remapped format of IRTE,
> +		 * which being a cached irte is still updated when setting
> +		 * the affinity even when we are in posted mode. So this make

s/make/makes/

> +		 * it possible to switch back to remapped mode from posted mode,
> +		 * we can just set "ir_data->irte_entry" to hardware for that
> +		 * purpose. Here we store the posted format of IRTE in another
> +		 * new member "ir_data->irte_pi_entry" to not corrupt

Remove the 'another new member' please. That member is not longer new
once that patch is applied.

Now there is another question. Are we actually using that pi_entry
cached value for anything else than this code here? If not, we can do
this on the stack and avoid the extra storage in ir_data.

Thanks,

	tglx
