From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] pci: Add dummy for pci_acs_enabled() if CONFIG_PCI=n to
 fix iommmu build
Date: Fri, 22 Sep 2017 10:56:05 -0500
Message-ID: <20170922155605.GB15970@bhelgaas-glaptop.roam.corp.google.com>
References: <1505132955-9517-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505132955-9517-1-git-send-email-geert@linux-m68k.org>
Sender: linux-pci-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 11, 2017 at 02:29:15PM +0200, Geert Uytterhoeven wrote:
> If CONFIG_PCI=n, and gcc (e.g. 4.1.2) decides not to inline
> get_pci_function_alias_group(), the build fails with:
> 
>     drivers/iommu/iommu.o: In function `get_pci_function_alias_group':
>     iommu.c:(.text+0xfdc): undefined reference to `pci_acs_enabled'
> 
> Due to the various dummies for PCI calls in the CONFIG_PCI=n case,
> pci_acs_enabled() isn't actually ever called, but not all versions of
> gcc are smart enough to realize that.
> 
> While explicitly marking get_pci_function_alias_group() inline would fix
> the build, this would inflate the code for the CONFIG_PCI=y case, as
> get_pci_function_alias_group() is a not-so-small function called from
> two places.
> 
> Hence fix the issue by introducing a dummy for pci_acs_enabled()
> instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Joerg, if you pick this up, would you mind capitalizing the subject
line to match the PCI convention, e.g.,

  PCI: Add dummy pci_acs_enabled() for CONFIG_PCI=n build

If it's too late for you to pick this up this week, I can include it
next week.  I assume this is not related to a specific change, i.e.,
it's not a regression?  Should it be marked for stable?

> ---
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f68c58a93dd045b9..f4f8ee5a7362e982 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1685,6 +1685,8 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  
>  #define dev_is_pci(d) (false)
>  #define dev_is_pf(d) (false)
> +static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
> +{ return false; }
>  #endif /* CONFIG_PCI */
>  
>  /* Include architecture-dependent settings and functions */
> -- 
> 2.7.4
> 
