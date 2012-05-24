From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 12/13] pci: Misc pci_reg additions
Date: Thu, 24 May 2012 16:17:44 -0600
Message-ID: <1337897864.4714.57.camel@ul30vt>
References: <20120522043607.5871.11340.stgit@bling.home>
	<20120522050557.5871.15364.stgit@bling.home>
	<4FBEACE2.1050701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FBEACE2.1050701-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2012-05-24 at 17:49 -0400, Don Dutile wrote:
> On 05/22/2012 01:05 AM, Alex Williamson wrote:
> > Fill in many missing definitions and add sizeof fields for many
> > sections allowing for more extensive config parsing.
> >
> > Signed-off-by: Alex Williamson<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >
> overall, i'm very glad to see defines instead of hardcoded numbers in the code, but....
> 
> >   include/linux/pci_regs.h |  112 +++++++++++++++++++++++++++++++++++++++++-----
> >   1 files changed, 100 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
> > index 4b608f5..379be84 100644
> > --- a/include/linux/pci_regs.h
> > +++ b/include/linux/pci_regs.h
> > @@ -26,6 +26,7 @@
> >    * Under PCI, each device has 256 bytes of configuration address space,
> >    * of which the first 64 bytes are standardized as follows:
> >    */
> > +#define PCI_STD_HEADER_SIZEOF	64
> >   #define PCI_VENDOR_ID		0x00	/* 16 bits */
> >   #define PCI_DEVICE_ID		0x02	/* 16 bits */
> >   #define PCI_COMMAND		0x04	/* 16 bits */
> > @@ -209,9 +210,12 @@
> >   #define  PCI_CAP_ID_SHPC 	0x0C	/* PCI Standard Hot-Plug Controller */
> >   #define  PCI_CAP_ID_SSVID	0x0D	/* Bridge subsystem vendor/device ID */
> >   #define  PCI_CAP_ID_AGP3	0x0E	/* AGP Target PCI-PCI bridge */
> > +#define  PCI_CAP_ID_SECDEV	0x0F	/* Secure Device */
> >   #define  PCI_CAP_ID_EXP 	0x10	/* PCI Express */
> >   #define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */
> > +#define  PCI_CAP_ID_SATA	0x12	/* SATA Data/Index Conf. */
> >   #define  PCI_CAP_ID_AF		0x13	/* PCI Advanced Features */
> > +#define  PCI_CAP_ID_MAX		PCI_CAP_ID_AF
> >   #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
> >   #define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
> >   #define PCI_CAP_SIZEOF		4
> > @@ -276,6 +280,7 @@
> >   #define  PCI_VPD_ADDR_MASK	0x7fff	/* Address mask */
> >   #define  PCI_VPD_ADDR_F		0x8000	/* Write 0, 1 indicates completion */
> >   #define PCI_VPD_DATA		4	/* 32-bits of data returned here */
> > +#define PCI_CAP_VPD_SIZEOF	8
> >
> >   /* Slot Identification */
> >
> > @@ -297,8 +302,10 @@
> >   #define PCI_MSI_ADDRESS_HI	8	/* Upper 32 bits (if PCI_MSI_FLAGS_64BIT set) */
> >   #define PCI_MSI_DATA_32		8	/* 16 bits of data for 32-bit devices */
> >   #define PCI_MSI_MASK_32		12	/* Mask bits register for 32-bit devices */
> > +#define PCI_MSI_PENDING_32	16	/* Pending intrs for 32-bit devices */
> >   #define PCI_MSI_DATA_64		12	/* 16 bits of data for 64-bit devices */
> >   #define PCI_MSI_MASK_64		16	/* Mask bits register for 64-bit devices */
> > +#define PCI_MSI_PENDING_64	20	/* Pending intrs for 64-bit devices */
> >
> >   /* MSI-X registers */
> >   #define PCI_MSIX_FLAGS		2
> > @@ -308,6 +315,7 @@
> >   #define PCI_MSIX_TABLE		4
> >   #define PCI_MSIX_PBA		8
> >   #define  PCI_MSIX_FLAGS_BIRMASK	(7<<  0)
> > +#define PCI_CAP_MSIX_SIZEOF	12	/* size of MSIX registers */
> >
> >   /* MSI-X entry's format */
> >   #define PCI_MSIX_ENTRY_SIZE		16
> > @@ -338,6 +346,7 @@
> >   #define  PCI_AF_CTRL_FLR	0x01
> >   #define PCI_AF_STATUS		5
> >   #define  PCI_AF_STATUS_TP	0x01
> > +#define PCI_CAP_AF_SIZEOF	6	/* size of AF registers */
> >
> >   /* PCI-X registers */
> >
> > @@ -374,6 +383,9 @@
> >   #define  PCI_X_STATUS_SPL_ERR	0x20000000	/* Rcvd Split Completion Error Msg */
> >   #define  PCI_X_STATUS_266MHZ	0x40000000	/* 266 MHz capable */
> >   #define  PCI_X_STATUS_533MHZ	0x80000000	/* 533 MHz capable */
> > +#define PCI_X_ECC_CSR		8	/* ECC control and status */
> > +#define PCI_CAP_PCIX_SIZEOF_V0	8	/* size of registers for Version 0 */
> > +#define PCI_CAP_PCIX_SIZEOF_V12	24	/* size for Version 1&  2 */
> ew!
> unlikely that version 12 will ever exist, but why not:
> #define PCI_CAP_PCIX_SIZEOF_V1	24
> #define PCI_CAP_PCIX_SIZEOF_V2	PCI_CAP_PCIX_SIZEOF_V1

Works for me, will fix.  Thanks,

Alex
