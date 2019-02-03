From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH V2 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Date: Sun, 3 Feb 2019 21:26:11 +0000
Message-ID: <DM5PR2101MB091820B372812576837724CED76C0@DM5PR2101MB0918.namprd21.prod.outlook.com>
References: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549113287-5606-2-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1549113287-5606-2-git-send-email-Tianyu.Lan@microsoft.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>, vkuznets <vkuznets@redhat.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, devel
List-Id: iommu@lists.linux-foundation.org

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com>  Sent: Saturday, February 2, 2019 5:15 AM
> 
> Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> set x2apic destination mode to physcial mode when x2apic is available
> and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> 8-bit APIC id.
> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
>        - Remove redundant extern for x2apic_phys
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index e81a2db..4bd6d90 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -328,6 +328,16 @@ static void __init ms_hyperv_init_platform(void)
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
>  # endif
> +
> +/*
> + * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> + * set x2apic destination mode to physcial mode when x2apic is available
> + * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
> + * have 8-bit APIC id.
> + */

Per comment from Dan Carpenter on v1 of this patch, the above comment
block should be indented one tab to line up with the "if" statement below.

Michael

> +	if (IS_ENABLED(CONFIG_HYPERV_IOMMU) && x2apic_supported())
> +		x2apic_phys = 1;
> +
>  #endif
>  }
> 
> --
> 2.7.4
