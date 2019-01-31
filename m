From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] x86/Hyper-V: Set x2apic destination mode to physical
 when x2apic is available
Date: Thu, 31 Jan 2019 12:57:56 +0100
Message-ID: <20190131115756.GA19969@kroah.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lantianyu1986@gmail.com
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, mchehab+samsung@kernel.org, sashal@kernel.org, sthemmin@microsoft.com, joro@8bytes.org, x86@kernel.org, michael.h.kelley@microsoft.com, mingo@redhat.com, Lan Tianyu <Tianyu.Lan@microsoft.com>, arnd@arndb.de, haiyangz@microsoft.com, alex.williamson@redhat.com, bp@alien8.de, tglx@linutronix.de, vkuznets@redhat.com, nicolas.ferre@microchip.com, iommu@lists.linux-foundation.org, devel@linuxdriverproject.org, akpm@linux-foundation.org, davem@davemloft.net
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 06:17:31PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> set x2apic destination mode to physcial mode when x2apic is available
> and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> 8-bit APIC id.
> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index e81a2db..9d62f33 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -36,6 +36,8 @@
>  struct ms_hyperv_info ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
>  
> +extern int x2apic_phys;

Shouldn't this be in a .h file somewhere instead?

thanks,

greg k-h
