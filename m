From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v4 03/15] drivers: acpi: iort: introduce linker section
 for IORT entries probing
Date: Mon, 5 Sep 2016 19:42:05 +0800
Message-ID: <300bbfa6-8a9a-25f6-1182-e220ed46397e@linaro.org>
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1471274620-20754-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471274620-20754-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, iommu@lists.linux-foundation.org
Cc: Tomasz Nowicki <tn@semihalf.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>, Sinan Kaya <okaya@codeaurora.org>, Nate Watterson <nwatters@codeaurora.org>, Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 2016/8/15 23:23, Lorenzo Pieralisi wrote:
> Since commit e647b532275b ("ACPI: Add early device probing
> infrastructure") the kernel has gained the infrastructure that allows
> adding linker script section entries to execute ACPI driver callbacks
> (ie probe routines) for all subsystems that register a table entry
> in the respective kernel section (eg clocksource, irqchip).
>
> Since ARM IOMMU devices data is described through IORT tables when
> booting with ACPI, the ARM IOMMU drivers must be made able to hook ACPI
> callback routines that are called to probe IORT entries and initialize
> the respective IOMMU devices.
>
> To avoid adding driver specific hooks into IORT table initialization
> code (breaking therefore code modularity - ie ACPI IORT code must be made
> aware of ARM SMMU drivers ACPI init callbacks), this patch adds code
> that allows ARM SMMU drivers to take advantage of the ACPI early probing
> infrastructure, so that they can add linker script section entries
> containing drivers callback to be executed on IORT tables detection.
>
> Since IORT nodes are differentiated by a type, the callback routines
> can easily parse the IORT table entries, check the IORT nodes and
> carry out some actions whenever the IORT node type associated with
> the driver specific callback is matched.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/acpi/arm64/iort.c         | 2 ++
>  include/asm-generic/vmlinux.lds.h | 1 +
>  include/linux/iort.h              | 3 +++
>  3 files changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 2543f60..cad7d1d 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -383,4 +383,6 @@ void __init iort_table_detect(void)
>  		const char *msg = acpi_format_exception(status);
>  		pr_err("Failed to get table, %s\n", msg);
>  	}
> +
> +	acpi_probe_device_table(iort);
>  }
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 2456397..7ee4e0c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -546,6 +546,7 @@
>  	IRQCHIP_OF_MATCH_TABLE()					\
>  	ACPI_PROBE_TABLE(irqchip)					\
>  	ACPI_PROBE_TABLE(clksrc)					\
> +	ACPI_PROBE_TABLE(iort)						\
>  	EARLYCON_TABLE()
>
>  #define INIT_TEXT							\
> diff --git a/include/linux/iort.h b/include/linux/iort.h
> index d7daba1..9bb30c5 100644
> --- a/include/linux/iort.h
> +++ b/include/linux/iort.h
> @@ -38,4 +38,7 @@ static inline struct irq_domain *
>  iort_get_device_domain(struct device *dev, u32 req_id) { return NULL; }
>  #endif
>
> +#define IORT_ACPI_DECLARE(name, table_id, fn)		\
> +	ACPI_DECLARE_PROBE_ENTRY(iort, name, table_id, 0, NULL, 0, fn)
> +
>  #endif /* __IORT_H__ */

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
