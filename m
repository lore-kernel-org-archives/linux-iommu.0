From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v4 05/12] memory: Add NVIDIA Tegra memory controller
	support
Date: Wed, 15 Oct 2014 15:09:30 -0700
Message-ID: <CAOesGMgDE_PZHrrEhntnce2AMsdtAb9+i5XuxP-Q7j--432zpw@mail.gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
	<1413196434-5292-5-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1413196434-5292-5-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

Oh, a few more comments:

On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index c32d31981be3..1c932e7e7b8d 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -12,4 +12,5 @@ obj-$(CONFIG_FSL_CORENET_CF)  += fsl-corenet-cf.o
>  obj-$(CONFIG_FSL_IFC)          += fsl_ifc.o
>  obj-$(CONFIG_MVEBU_DEVBUS)     += mvebu-devbus.o
>  obj-$(CONFIG_TEGRA20_MC)       += tegra20-mc.o
> -obj-$(CONFIG_TEGRA30_MC)       += tegra30-mc.o
> +
> +obj-$(CONFIG_ARCH_TEGRA)       += tegra/
> diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
> new file mode 100644
> index 000000000000..51b9e8fcde1b
> --- /dev/null
> +++ b/drivers/memory/tegra/Makefile
> @@ -0,0 +1,5 @@
> +obj-y                                   = tegra-mc.o
> +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)                += tegra30-mc.o
> +obj-$(CONFIG_ARCH_TEGRA_114_SOC)       += tegra114-mc.o
> +obj-$(CONFIG_ARCH_TEGRA_124_SOC)       += tegra124-mc.o
> +obj-$(CONFIG_ARCH_TEGRA_132_SOC)       += tegra124-mc.o

You'll need a Kconfig and not just a makefile -- there are definitely
dependencies on this driver (IOMMU in particular).


Also, the problem of having a global enable bit that is only under
control of TrustZone FW is a big problem -- if the bit is not set, the
driver will not work (and the machine will crash).

I think you'll need to come up with a way to detect that in the
driver. I don't have a good idea of how it can be done though.


-Olof
