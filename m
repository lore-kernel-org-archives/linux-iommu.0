From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 1/3] PCI/MSI: Initial hook for archs to declare multivector
	MSI support
Date: Sun, 23 Nov 2014 21:20:21 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1411232109140.6439@nanos>
References: <20141121213752.31095.30735.stgit@gimli.home>
	<20141121220833.31095.12371.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141121220833.31095.12371.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 21 Nov 2014, Alex Williamson wrote:
> For the most part multivector MSI is not supported and drivers and
> hardware wanting multiple vectors opt for MSI-X instead.  It seems
> though that having the ability to query the arch/platform code to
> determine whether allocating multiple MSI vectors will ever succeed
> is a useful thing.  For instance, vfio-pci can use this to determine
> whether to expose multiple MSI vectors to the user.  If we know we
> cannot ever support more than one vector, we have a better shot at
> the userspace driver working, especially if it's a guest OS, if we
> only expose one vector as being available in the interface.
> 
> Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> 
>  drivers/pci/msi.c   |    5 +++++
>  include/linux/msi.h |    1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 9fab30a..36b503a 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -79,6 +79,11 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  	return 0;
>  }
>  
> +bool __weak arch_supports_multivector_msi(struct pci_dev *dev)

Please not another weak arch function. We are in the process to reduce
them not to extend them.

arch_supports is pretty much wrong here anyway. We are moving away
from arch MSI dependencies simply because it's not a arch property per
se.

Multi MSI is a property of the underlying interrupt controllers and
there might be several MSI interrupt domains on a given system. They
can or cannot support multi MSI.

The current x86 implementation is a tangled maze and Jiang is in the
process to distangle it completely. Until thats done x86 is not going
to add new ad hoc interfaces.

Once we converted everything over to the new hierarchical irqdomains
we can add such an interface to the code, but for now I'm not
accepting anything like that into x86 msi related code.

Thanks,

	tglx
