From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v14 04/16] iommu/dma: MSI doorbell alloc/free
Date: Fri, 14 Oct 2016 12:25:11 +0100
Message-ID: <87lgxrqijs.fsf@e105922-lin.cambridge.arm.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
        <1476278544-3397-5-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1476278544-3397-5-git-send-email-eric.auger@redhat.com> (Eric
        Auger's message of "Wed, 12 Oct 2016 13:22:12 +0000")
Sender: kvm-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, drjones@redhat.com, kvm@vger.kernel.org, Manish.Jaggi@caviumnetworks.com, p.fedin@samsung.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

One query and a comment below.

Eric Auger <eric.auger@redhat.com> writes:

> We introduce the capability to (un)register MSI doorbells.
>
> A doorbell region is characterized by its physical address base, size,
> and whether it its safe (ie. it implements IRQ remapping). A doorbell
> can be per-cpu or global. We currently only care about global doorbells.
>
> A function returns whether all registered doorbells are safe.
>
> MSI controllers likely to work along with IOMMU that translate MSI
> transaction must register their doorbells to allow device assignment
> with MSI support.  Otherwise the MSI transactions will cause IOMMU faults.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v13 -> v14:
> - previously in msi-doorbell.h/c
> ---
>  drivers/iommu/dma-iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h | 41 ++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d45f9a0..d8a7d86 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -43,6 +43,38 @@ struct iommu_dma_cookie {
>  	spinlock_t		msi_lock;
>  };
>  
> +/**
> + * struct iommu_msi_doorbell_info - MSI doorbell region descriptor
> + * @percpu_doorbells: per cpu doorbell base address
> + * @global_doorbell: base address of the doorbell
> + * @doorbell_is_percpu: is the doorbell per cpu or global?
> + * @safe: true if irq remapping is implemented
> + * @size: size of the doorbell
> + */
> +struct iommu_msi_doorbell_info {
> +	union {
> +		phys_addr_t __percpu    *percpu_doorbells;

Out of curiosity, have you come across systems that have per-cpu
doorbells? I couldn't find a system that'd help solidify my
understanding on it's usage.

> +		phys_addr_t             global_doorbell;
> +	};
> +	bool    doorbell_is_percpu;
> +	bool    safe;

Although you've got the comment above, 'safe' doesn't quite convey it's
purpose. Can this be renamed to something more descriptive -
'intr_remapping' or 'intr_isolation' perhaps?

Thanks,
Punit


[...]

