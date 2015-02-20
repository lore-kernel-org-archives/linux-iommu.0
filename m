From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add built time dependency
Date: Fri, 20 Feb 2015 19:19:43 +0000
Message-ID: <20150220191943.GB1767@arm.com>
References: <20150220194445.4225d56b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150220194445.4225d56b-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 20, 2015 at 06:44:45PM +0000, Jean Delvare wrote:
> If io-pgtable-arm is an ARM-specific driver then configuration option
> IOMMU_IO_PGTABLE_LPAE should not be presented to the user by default
> for non-ARM kernels.
> 
> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iommu/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-3.20-rc0.orig/drivers/iommu/Kconfig	2015-02-20 17:24:46.838955014 +0100
> +++ linux-3.20-rc0/drivers/iommu/Kconfig	2015-02-20 19:38:45.804582668 +0100
> @@ -23,6 +23,7 @@ config IOMMU_IO_PGTABLE
>  config IOMMU_IO_PGTABLE_LPAE
>  	bool "ARMv7/v8 Long Descriptor Format"
>  	select IOMMU_IO_PGTABLE
> +	depends on ARM || COMPILE_TEST
>  	help
>  	  Enable support for the ARM long descriptor pagetable format.
>  	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page

So this code doesn't actually *depend* on any arch code at all. In fact,
having it built and booted on x86 revealed a couple of bugs that I've
since fixed. I'd rather let this run everywhere, but if people insist on
the false dependency, so be it but we should add ARM64 to the mix too.

Will
