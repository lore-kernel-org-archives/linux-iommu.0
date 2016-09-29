From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] arch/x86: Add CONFIG_IOMMU_DEFAULT_PT for iommu=pt
Date: Thu, 29 Sep 2016 12:31:15 -0600
Message-ID: <20160929123115.7afcc88e@t450s.home>
References: <2ebef311-b346-f3ed-2fca-ce4715b84c9d@brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2ebef311-b346-f3ed-2fca-ce4715b84c9d-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Glenn Serre <gserre-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 29 Sep 2016 09:58:55 -0700
Glenn Serre <gserre-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org> wrote:

> Add CONFIG_IOMMU_DEFAULT_PT for iommu=pt
> 
> Allow default to iommu=pt without adding to command line.
> Add iommu=nopt to turn off default.
> 
> Signed-off-by: Glenn Serre <gserre-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
> ---
>   Documentation/kernel-parameters.txt | 3 ++-
>   arch/x86/Kconfig                    | 7 +++++++
>   arch/x86/kernel/pci-dma.c           | 6 ++++++
>   3 files changed, 15 insertions(+), 1 deletion(-)
> 
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1607,7 +1607,8 @@
>   		nomerge
>   		forcesac
>   		soft
> -		pt		[x86, IA-64]
> +		pt		[x86]
> +		nopt		[x86]
>   		nobypass	[PPC/POWERNV]
>   			Disable IOMMU bypass, using IOMMU for PCI devices.
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -845,6 +845,15 @@
>   	def_bool y
>   	depends on CALGARY_IOMMU || GART_IOMMU || SWIOTLB || AMD_IOMMU
> 
> +config IOMMU_DEFAULT_PT
> +	int "Default iommu pt value (0-1)"
> +	range 0 1
> +	default "0"
> +	prompt "Set to 1 to default to iommu=pt"

An integer that can be either zero or one... IOW a bool.  There's
support for bools in Kconfig.

> +	help
> +	  Setting this option to 1 will set iommu passthrough (iommu=pt)
> +	  by default.  Use iommu=nopt to override.
> +
>   config MAXSMP
>   	bool "Enable Maximum number of SMP Processors and NUMA Nodes"
>   	depends on X86_64 && SMP && DEBUG_KERNEL
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -43,7 +43,7 @@
>    * useful if a user wants to use an IOMMU only for KVM device 
> assignment to
>    * guests and not for driver dma translation.
>    */
> -int iommu_pass_through __read_mostly;
> +int iommu_pass_through __read_mostly = CONFIG_IOMMU_DEFAULT_PT;
> 
>   extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
> 
> @@ -196,6 +196,8 @@
>   #endif
>   		if (!strncmp(p, "pt", 2))
>   			iommu_pass_through = 1;
> +		if (!strncmp(p, "nopt", 4))
> +			iommu_pass_through = 0;
> 
>   		gart_parse_options(p);
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
