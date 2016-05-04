From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v8 5/8] genirq/irq: introduce msi_doorbell_info
Date: Wed, 4 May 2016 13:57:30 +0100
Message-ID: <5729F1BA.6060306@arm.com>
References: <1461831730-5575-1-git-send-email-eric.auger@linaro.org>
 <1461831730-5575-6-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461831730-5575-6-git-send-email-eric.auger@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@linaro.org>, eric.auger@st.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com
List-Id: iommu@lists.linux-foundation.org

On 28/04/16 09:22, Eric Auger wrote:
> The purpose is to be able to retrieve the MSI doorbells of an irqchip.
> This is now needed since on some platforms those doorbells must be
> iommu mapped (in case the MSIs transit through an IOMMU that do not
> bypass those transactions).
> 
> The assumption is there is a maximum of one doorbell region per cpu.
> 
> A doorbell region is characterized by its physical address base, size and
> IOMMU protection flag. Those 2 last characteristics are shared among all
> doorbells.
> 
> irq_chip msi_doorbell_info callback enables to retrieve the doorbells of
> the irqchip.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> v7 -> v8:
> - size and prot now are shared among all doorbells
> - doorbells now directly points to a percpu phys_addr_t
> 
> v7: creation
> ---
>  include/linux/irq.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index c4de623..5dbb26d 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -312,6 +312,19 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>  	return d->hwirq;
>  }
>  
> +/*
> + * Describe all the MSI doorbell regions for an irqchip.
> + * A single doorbell region per cpu is assumed.
> + * In case a single doorbell is supported for the whole irqchip,
> + * the region is described in as cpu #0's one
> + */
> +struct irq_chip_msi_doorbell_info {
> +	phys_addr_t __percpu *percpu_doorbells; /* per cpu base address */

Here's an idea: you could turn this field into a union:

	union {
		phys_addr_t __percpu *percpu_doorbells;
		phys_addr_t global_doorbell;
	};

> +	size_t size;				/* size of a each doorbell */
> +	int prot;				/* iommu protection flag */
> +	int nb_doorbells;

And this can be turned into a boolean:

	bool doorbell_is_percpu;

This allows you to avoid allocating a bunch of percpu doorbells for a
MSI controller that only has a global one. And the number of doorbells
is always either 1 or the number of CPUs anyway.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
