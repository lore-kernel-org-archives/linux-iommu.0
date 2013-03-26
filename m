From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/4] pci: Add PCI_BUS() and PCI_DEVID() interfaces to
	return bus number and device id
Date: Tue, 26 Mar 2013 15:41:07 -0600
Message-ID: <CAErSpo6DjjSKCFL6CjmqkOAyc1iU1TG1=n=K=AXPcU_r6ZdPGA@mail.gmail.com>
References: <1362009978.2808.33.camel@lorien2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1362009978.2808.33.camel@lorien2>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: shuah.khan-VXdhtT5mjnY@public.gmane.org
Cc: Jiang Liu <jiang.liu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Michael Kerrisk-manpages <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "shemminger-ZtmgI6mnKB3QT0dZR+AlfA@public.gmane.org" <shemminger-ZtmgI6mnKB3QT0dZR+AlfA@public.gmane.org>, Paul McKenney <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Linas Vepstas <linasvepstas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 27, 2013 at 5:06 PM, Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org> wrote:
> pci defines PCI_DEVFN(), PCI_SLOT(), and PCI_FUNC() interfaces, however,
> it doesn't have interfaces to return PCI bus and PCI device id. Drivers
> (AMD IOMMU, and AER) have module specific definitions for PCI_BUS() and
> AMD_IOMMU driver also has a module specific interface to calculate PCI
> device id from bus number and devfn.
>
> This patch set adds PCI_BUS_NUM(), and PCI_DEVID() to pci.h, changes AER
> to use PCI_BUS_NUM() from pci and remove local PCI_BUS() define. Changes
> AMD_IOMMU driver to use PCI_BUS_NUM() and PCI_DEVID() from pci and remove
> local PCI_BUS() define and local PCI_DEVID() implementation.
>
> Files changed:
>
> [PATCH v2 1/4] pci: Add PCI_BUS_NUM() and PCI_DEVID() interfaces to return bus
>            number and device id
>
>  include/linux/pci.h |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> [PATCH v2 2/4] pci/aer: Remove local PCI_BUS() define and use PCI_BUS_NUM()
>            from pci
>
>  drivers/pci/pcie/aer/aerdrv_core.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> [PATCH v2 3/4] iommu/amd: Remove local PCI_BUS() define and use PCI_BUS_NUM()
>            from pci
>
>  drivers/iommu/amd_iommu.c       |   12 ++++++------
>  drivers/iommu/amd_iommu_init.c  |   34 +++++++++++++++++-----------------
>  drivers/iommu/amd_iommu_types.h |    4 +---
>  3 files changed, 24 insertions(+), 26 deletions(-)
>
> [PATCH v2 4/4] iommu/amd: Remove calc_devid() and use PCI_DEVID() from pci
> (no change to this patch - but tagging it v2 for clarity)
>
>  drivers/iommu/amd_iommu.c       |    2 +-
>  drivers/iommu/amd_iommu_init.c  |    6 +++---
>  drivers/iommu/amd_iommu_types.h |    7 -------
>  3 files changed, 4 insertions(+), 11 deletions(-)

Thanks, Shuah, I applied these to a pci/shuah-defines branch and pushed it.

Since some of these touch drivers/iommu, it'd be good if you acked
them again, Joerg.  I know you acked them before, but there have been
minor changes since then, so I didn't add your ack to these.  But if
you're still OK with them, I'll refresh the branch to add it now.

Bjorn
