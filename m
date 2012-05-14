From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 05/13] pci: New pci_acs_enabled()
Date: Mon, 14 May 2012 16:02:11 -0600
Message-ID: <CAErSpo58hKPFb5duOi64sWuR5AJDTVp0rRHkQLotYE3CMXRRhA@mail.gmail.com>
References: <20120511222148.30496.68571.stgit@bling.home>
	<20120511225602.30496.80438.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120511225602.30496.80438.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 11, 2012 at 4:56 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> In a PCIe environment, transactions aren't always required to
> reach the root bus before being re-routed. =A0Peer-to-peer DMA
> may actually not be seen by the IOMMU in these cases. =A0For
> IOMMU groups, we want to provide IOMMU drivers a way to detect
> these restrictions. =A0Provided with a PCI device, pci_acs_enabled
> returns the furthest downstream device with a complete PCI ACS
> chain. =A0This information can then be used in grouping to create
> fully isolated groups. =A0ACS chain logic extracted from libvirt.

The name "pci_acs_enabled()" sounds like it returns a boolean, but it doesn=
't.

I'm not sure what "a complete PCI ACS chain" means.

The function starts from "dev" and searches *upstream*, so I'm
guessing it returns the root of a subtree that must be contained in a
group.

> Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>
> =A0drivers/pci/pci.c =A0 | =A0 43 +++++++++++++++++++++++++++++++++++++++=
++++
> =A0include/linux/pci.h | =A0 =A01 +
> =A02 files changed, 44 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 111569c..d7f05ce 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2358,6 +2358,49 @@ void pci_enable_acs(struct pci_dev *dev)
> =A0 =A0 =A0 =A0pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> =A0}
>
> +#define PCI_EXT_CAP_ACS_ENABLED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(PCI_ACS_=
SV | PCI_ACS_RR | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PCI_ACS_CR | PCI_ACS_UF)
> +
> +/**
> + * pci_acs_enabled - test ACS support in downstream chain
> + * @dev: starting PCI device
> + *
> + * Returns the furthest downstream device with an unbroken ACS chain. =
=A0If
> + * ACS is enabled throughout the chain, the returned device is the same =
as
> + * the one passed in.
> + */
> +struct pci_dev *pci_acs_enabled(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 struct pci_dev *acs_dev;
> + =A0 =A0 =A0 int pos;
> + =A0 =A0 =A0 u16 ctrl;
> +
> + =A0 =A0 =A0 if (!pci_is_root_bus(dev->bus))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acs_dev =3D pci_acs_enabled(dev->bus->self);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dev;
> +
> + =A0 =A0 =A0 /* If the chain is already broken, pass on the device */
> + =A0 =A0 =A0 if (acs_dev !=3D dev->bus->self)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return acs_dev;
> +
> + =A0 =A0 =A0 if (!pci_is_pcie(dev) || (dev->class >> 8) !=3D PCI_CLASS_B=
RIDGE_PCI)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dev;
> +
> + =A0 =A0 =A0 if (dev->pcie_type !=3D PCI_EXP_TYPE_DOWNSTREAM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dev;
> +
> + =A0 =A0 =A0 pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> + =A0 =A0 =A0 if (!pos)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return acs_dev;
> +
> + =A0 =A0 =A0 pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> + =A0 =A0 =A0 if ((ctrl & PCI_EXT_CAP_ACS_ENABLED) !=3D PCI_EXT_CAP_ACS_E=
NABLED)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return acs_dev;
> +
> + =A0 =A0 =A0 return dev;
> +}
> +
> =A0/**
> =A0* pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
> =A0* @dev: the PCI device
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9910b5c..dc25da3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1586,6 +1586,7 @@ static inline bool pci_is_pcie(struct pci_dev *dev)
> =A0}
>
> =A0void pci_request_acs(void);
> +struct pci_dev *pci_acs_enabled(struct pci_dev *dev);
>
>
> =A0#define PCI_VPD_LRDT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x80 =A0 =A0/=
* Large Resource Data Type */
>
