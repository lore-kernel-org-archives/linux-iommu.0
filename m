From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [Patch Part2 v3 15/24] x86, MSI: Use hierarchy irqdomain to
	manage MSI interrupts
Date: Tue, 28 Oct 2014 22:37:17 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1410282046120.5308@nanos>
References: <1414484803-10311-1-git-send-email-jiang.liu@linux.intel.com>
	<1414484803-10311-16-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414484803-10311-16-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 28 Oct 2014, Jiang Liu wrote:
> +static int msi_set_affinity(struct irq_data *data, const struct cpumask *mask,
> +			    bool force)
> +{
> +	struct irq_data *parent = data->parent_data;
> +	int ret;
>  
> -	msg.data &= ~MSI_DATA_VECTOR_MASK;
> -	msg.data |= MSI_DATA_VECTOR(cfg->vector);
> -	msg.address_lo &= ~MSI_ADDR_DEST_ID_MASK;
> -	msg.address_lo |= MSI_ADDR_DEST_ID(dest);
> +	ret = parent->chip->irq_set_affinity(parent, mask, force);
> +	/* No need to reprogram MSI registers if interrupt is remapped */
> +	if (ret >= 0 && !msi_irq_remapped(data)) {
> +		struct msi_msg msg;
>  
> -	__write_msi_msg(data->msi_desc, &msg);
> +		__get_cached_msi_msg(data->msi_desc, &msg);
> +		msi_update_msg(&msg, data);
> +		__write_msi_msg(data->msi_desc, &msg);
> +	}

I'm not too happy about the msi_irq_remapped() conditional here. It
violates the whole concept of domain stacking somewhat.

A better separation would be to add a callback to the irq chip:

  	void (*irq_write_msi_msg)(struct irq_data *data, struct msi_desc *msi_desc, bool cached);

and change this code to:

    	if (ret >= 0)
	   	parent->chip->irq_write_msi_msg(parent, data->msi-desc, true);
  
> -	return IRQ_SET_MASK_OK_NOCOPY;
> +	return ret;
>  }

And do the same here:

> +static int msi_domain_activate(struct irq_domain *domain,
> +			       struct irq_data *irq_data)
> +{
> +	struct msi_msg msg;
> +	struct irq_cfg *cfg = irqd_cfg(irq_data);
> +
> +	/*
> +	 * irq_data->chip_data is MSI/MSIx offset.
> +	 * MSI-X message is written per-IRQ, the offset is always 0.
> +	 * MSI message denotes a contiguous group of IRQs, written for 0th IRQ.
> +	 */
> +	if (irq_data->chip_data)
> +		return 0;

        parent->chip->irq_write_msi_msg(parent, data->msi_desc, false);  		

> +	if (msi_irq_remapped(irq_data))
> +		irq_remapping_get_msi_entry(irq_data->parent_data, &msg);
> +	else
> +		native_compose_msi_msg(NULL, irq_data->irq, cfg->dest_apicid,
> +				       &msg, 0);
> +	write_msi_msg(irq_data->irq, &msg);
> +
> +	return 0;
> +}

And here:

> +static int msi_domain_deactivate(struct irq_domain *domain,
> +				 struct irq_data *irq_data)
> +{
> +	struct msi_msg msg;
> +
> +	if (irq_data->chip_data)
> +		return 0;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	write_msi_msg(irq_data->irq, &msg);

  	parent->chip->irq_write_msi_msg(parent, NULL, false);

> +	return 0;
> +}

And let the vector and the remapping domain deal with it in their callbacks.

> @@ -166,25 +264,59 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>  
>  int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
> -	struct msi_desc *msidesc;
> -	int irq, ret;
> +	int irq, cnt, nvec_pow2;
> +	struct irq_domain *domain;
> +	struct msi_desc *msidesc, *iter;
> +	struct irq_alloc_info info;
> +	int node = dev_to_node(&dev->dev);
>  
> -	/* Multiple MSI vectors only supported with interrupt remapping */
> -	if (type == PCI_CAP_ID_MSI && nvec > 1)
> -		return 1;
> +	if (disable_apic)
> +		return -ENOSYS;
>  
> -	list_for_each_entry(msidesc, &dev->msi_list, list) {
> -		irq = irq_domain_alloc_irqs(NULL, 1, NUMA_NO_NODE, NULL);
> +	init_irq_alloc_info(&info, NULL);
> +	info.msi_dev = dev;
> +	if (type == PCI_CAP_ID_MSI) {
> +		msidesc = list_first_entry(&dev->msi_list,
> +					   struct msi_desc, list);
> +		WARN_ON(!list_is_singular(&dev->msi_list));
> +		WARN_ON(msidesc->irq);
> +		WARN_ON(msidesc->msi_attrib.multiple);
> +		WARN_ON(msidesc->nvec_used);
> +		info.type = X86_IRQ_ALLOC_TYPE_MSI;
> +		cnt = nvec;
> +	} else {
> +		info.type = X86_IRQ_ALLOC_TYPE_MSIX;
> +		cnt = 1;
> +	}

We have a similar issue here.

> +	domain = irq_remapping_get_irq_domain(&info);

We add domain specific knowledge to the MSI implementation. Not
necessary at all.

Again MSI is not an x86 problem and we really can move most of that to
the core code. The above sanity checks and the distinction between MSI
and MSIX can be handled in the core code. And every domain involved in
the MSI chain would need a alloc_msi() callback.

So native_setup_msi_irqs() would boil down to:
+ {
+	if (disable_apic)
+		return -ENOSYS;
+ 
+	return irq_domain_alloc_msi(msi_domain, dev, nvec, type);   
+ }

Now that core function performs the sanity checks for the MSI case. In
fact it should not proceed when a warning condition is detected. Not a
x86 issue at all, its true for every MSI implementation.

Then it calls down the domain allocation chain. x86_msi_domain would
simply hand down to the parent domain. That would either be the remap
domain or the vector domain.

The reject for the multi MSI would only be implemented in the vector
domain callback, while the remap domain can handle it. Once we gain
support for allocating consecutive vectors for multi-MSI in the vector
domain we would not have to change any of the MSI code at all. 

Thoughts?

Thanks,

	tglx
