From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/3] x86/Hyper-V: Set x2apic destination mode to physical
 when x2apic is available
Date: Fri, 1 Feb 2019 10:06:55 +0300
Message-ID: <20190201070655.GA14343@kadam>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1548929853-25877-2-git-send-email-Tianyu.Lan@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: lantianyu1986@gmail.com
Cc: nicolas.ferre@microchip.com, hpa@zytor.com, mchehab+samsung@kernel.org, sashal@kernel.org, sthemmin@microsoft.com, joro@8bytes.org, x86@kernel.org, michael.h.kelley@microsoft.com, mingo@redhat.com, Lan Tianyu <Tianyu.Lan@microsoft.com>, arnd@arndb.de, haiyangz@microsoft.com, alex.williamson@redhat.com, bp@alien8.de, tglx@linutronix.de, vkuznets@redhat.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, devel@linuxdriverproject.org, akpm@linux-foundation.org, davem@davemloft.net
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 06:17:31PM +0800, lantianyu1986@gmail.com wrote:
>
>

This comment needs to be indented one tab or it looks like we're outside
the funciton.

> +/*
> + * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> + * set x2apic destination mode to physcial mode when x2apic is available
> + * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
> + * have 8-bit APIC id.
> + */
> +# if IS_ENABLED(CONFIG_HYPERV_IOMMU)
> +	if (x2apic_supported())
> +		x2apic_phys = 1;
> +# endif

The IS_ENABLED() macro is really magical.  You could write this like so:

	if (IS_ENABLED(CONFIG_HYPERV_IOMMU) && x2apic_supported())
		x2apic_phys = 1;

It works the same and is slightly more pleasant to look at.

regards,
dan carpenter
