From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
Date: Sun, 10 Feb 2019 22:48:51 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1902102247100.8784@nanos.tec.linutronix.de>
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com> <1549553629-8414-2-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549553629-8414-2-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lantianyu1986@gmail.com
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, joro@8bytes.org, mchehab+samsung@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, arnd@arndb.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com, dan.carpenter@oracle.com
List-Id: iommu@lists.linux-foundation.org

On Thu, 7 Feb 2019, lantianyu1986@gmail.com wrote:

> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> set x2apic destination mode to physcial mode when x2apic is available
> and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> 8-bit APIC id.

This looks good now. Can that be applied independent of the IOMMU stuff or
should this go together. If the latter:

   Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

If not, I just queue if for 5.1. Let me know,

Thanks,

	tglx
