From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v9 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Mon, 27 Aug 2018 08:56:50 +0200
Message-ID: <CAMuHMdVf-QDAVh-vHF_xyvX73_nsO9X7RnDc=yCK_FS68i6zTw@mail.gmail.com>
References: <152883965482.1936.13657625103232933481.stgit@taos>
	<152883969032.1936.15155267369758178246.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152883969032.1936.15155267369758178246.stgit@taos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: gary.hook-5C7GfCeVMHo@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-kbuild <linux-kbuild-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Gary,

On Tue, Jun 12, 2018 at 11:42 PM Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org> wrote:
> Implement a skeleton framework for debugfs support in the AMD
> IOMMU.  Add an AMD-specific Kconfig boolean that depends upon
> general enablement of DebugFS in the IOMMU.
>
> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>

This is now commit 7d0f5fd3e4d68742 ("iommu/amd: Add basic debugfs
infrastructure for AMD IOMMU").

> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -146,6 +146,18 @@ config AMD_IOMMU_V2
>           hardware. Select this option if you want to use devices that support
>           the PCI PRI and PASID interface.
>
> +config AMD_IOMMU_DEBUGFS
> +       bool "Enable AMD IOMMU internals in DebugFS"
> +       depends on AMD_IOMMU && IOMMU_DEBUGFS
> +       ---help---
> +         !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
> +
> +         DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
> +         Exposes AMD IOMMU device internals in DebugFS.
> +
> +         This option is -NOT- intended for production environments, and should
> +         not generally be enabled.

If it is that bad, shouldn't this option be protected by some Kconfig
trickery to avoid it being enabled in allmodconfig/allyesconfig builds?

I forgot the way to do that, so some CCs added.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
