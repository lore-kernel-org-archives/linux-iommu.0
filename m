From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH] x86: Allow IOMMU drivers to Hook arch_setup_dma_ops()
Date: Mon, 31 Oct 2016 11:45:15 +0000
Message-ID: <a95e5fb2-3f5d-5334-c62d-e4b99a52adcb@arm.com>
References: <1477854889.14501.6.camel@woodhou.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1477854889.14501.6.camel-1zP8QHzw3cfLoDKTGw+V6w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi David,

On 30/10/16 19:14, David Woodhouse wrote:
> The Intel IOMMU code registers a notifier and plays nasty tricks to fill
> device pointers in with its DMAR scope tables when devices are detected,
> then later compares the device pointers in those tables when it needs to
> find the IOMMU unit for a given device.
> 
> If we let it use arch_setup_dma_ops() to match the device to an IOMMU
> unit at device_register() time, this gets a whole lot saner.

I like the sound of this, but do beware that there are plans afoot to
move the arch_setup_dma_ops() call later, to driver probe time[1], to
allow probe deferral in favour of other nasty platform-device-creation
hacks that we currently have to ensure IOMMUs are up and running before
any other devices need to interact with them. As it transpires that we
probably need to keep something like the current of_iommu_configure()
call prior to device_add(), though, then given Lorenzo's work to
formalise ACPI DMA configuration along similar lines[2], I think the
only impact is a slight jiggling such that x86_platform.iommu_setup
slots in as x86's equivalent of ARM's iort_iommu_configure().

> Signed-off-by: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> ---
> Of course it's still not actually *sane*. We have per-device DMA ops,
> but per-bus IOMMU ops. What we actually want to do is ditch the DMA ops
> entirely and simply do it all through the IOMMU ops, like ARM does in
> its arch/arm/mm/dma-mapping.c.

FWIW, arm64 is probably the nicer example. The arch side of the DMA ops
is purely cache maintenance, and the rest is just funnelled through the
generic dma-iommu.c glue layer. ARM still has some extra legacy to clean
up before it can be converted over to that (I've looked into it, and
it's effectively blocked on the probe-deferral thing).

> I think we can do an iova-dma-mapping.c
> with just an additional flag in the IOMMU domain which says that it can
> do lazy unmaps. 

It should be OK to predicate DMA-ops-specific behaviour on domain->type
within the driver - I've been playing with vaguely similar ideas for the
ARM SMMU (namely skipping pagetable locks).

> And IOMMU ops should be per-device of course, not per-bus. But this is
> a start...

As it happens, that was one of the additional motivations for
introducing the new iommu_fwspec - see [3] for my take on the matter.

Robin.

[1]:http://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg14491.html
[2]:http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1251993.html
[3]:http://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg14576.html

>  arch/x86/include/asm/dma-mapping.h | 2 ++
>  arch/x86/include/asm/x86_init.h    | 3 +++
>  arch/x86/kernel/x86_init.c         | 3 +++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
> index 4446162..b3888a0 100644
> --- a/arch/x86/include/asm/dma-mapping.h
> +++ b/arch/x86/include/asm/dma-mapping.h
> @@ -42,6 +42,8 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
>  bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
>  #define arch_dma_alloc_attrs arch_dma_alloc_attrs
>  
> +#define arch_setup_dma_ops x86_platform.iommu_setup_dma_ops
> +
>  #define HAVE_ARCH_DMA_SUPPORTED 1
>  extern int dma_supported(struct device *hwdev, u64 mask);
>  
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 6ba7931..6872dcc 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -7,6 +7,7 @@ struct mpc_bus;
>  struct mpc_cpu;
>  struct mpc_table;
>  struct cpuinfo_x86;
> +struct iommu_ops;
>  
>  /**
>   * struct x86_init_mpparse - platform specific mpparse ops
> @@ -207,6 +208,8 @@ struct x86_platform_ops {
>  	void (*get_wallclock)(struct timespec *ts);
>  	int (*set_wallclock)(const struct timespec *ts);
>  	void (*iommu_shutdown)(void);
> +	void (*iommu_setup_dma_ops)(struct device *dev, u64 dma_base, u64 size,
> +				    const struct iommu_ops *iommu, bool coherent);
>  	bool (*is_untracked_pat_range)(u64 start, u64 end);
>  	void (*nmi_init)(void);
>  	unsigned char (*get_nmi_reason)(void);
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 0bd9f12..5e54a72 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -28,6 +28,8 @@ void x86_init_noop(void) { }
>  void __init x86_init_uint_noop(unsigned int unused) { }
>  int __init iommu_init_noop(void) { return 0; }
>  void iommu_shutdown_noop(void) { }
> +void iommu_setup_dma_ops_noop(struct device *dev, u64 dma_base, u64 size,
> +			      const struct iommu_ops *iommu, bool coherent) { }
>  
>  /*
>   * The platform setup functions are preset with the default functions
> @@ -97,6 +99,7 @@ struct x86_platform_ops x86_platform __ro_after_init = {
>  	.get_wallclock			= mach_get_cmos_time,
>  	.set_wallclock			= mach_set_rtc_mmss,
>  	.iommu_shutdown			= iommu_shutdown_noop,
> +	.iommu_setup_dma_ops		= iommu_setup_dma_ops_noop,
>  	.is_untracked_pat_range		= is_ISA_range,
>  	.nmi_init			= default_nmi_init,
>  	.get_nmi_reason			= default_get_nmi_reason,
> -- 
> 2.5.5
> 
> 
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
