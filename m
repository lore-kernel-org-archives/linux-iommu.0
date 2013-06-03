From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet-J9ArbTHlV+bR7s880joybQ@public.gmane.org>
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Date: Mon, 3 Jun 2013 23:58:55 +0200
Message-ID: <20130603215855.GC31044@irqsave.net>
References: <20130601121320.GC5157@irqsave.net> <51ACE340.1030406@redhat.com>
	<20130603192958.GB31044@irqsave.net> <51AD02B1.8070503@redhat.com>
	<20130603212723.GG4094@irqsave.net> <51AD0DB8.8090109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51AD0DB8.8090109-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet-J9ArbTHlV+bR7s880joybQ@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> >When the PF does an FLR the hardware go back to its default state, the S=
R-IOV
> >configuration is gone and the VFs disappears from the bus.
> >Then the restore state function of the kernel reset code would bring the=
 SR-IOV
> >PF configuration back.
> >
> Ok, now you're a bit mis-led here.
> The configuration header for SRIOV is _not_ put back.
> Only the std, PCI config header section is put back in place, along with
> msi(x), pm-caps.
> If the hw wipes out all VF state setup (which it should, IMO), all VF con=
figuration
> will be lost in the hw...
> *but*, the PCI core will still think the VFs exist (not hot-unplugged, no=
 more than PF was);
> trying to setup the VFs again, will fail (or worse).

I read the following code on a not so hold kernel.

-----------
int pci_reset_function(struct pci_dev *dev)
{
>.......int rc;

>.......rc =3D pci_dev_reset(dev, 1);
>.......if (rc)
>.......>.......return rc;

>.......pci_save_state(dev);

>......./*
>....... * both INTx and MSI are disabled after the Interrupt Disable bit
>....... * is set and the Bus Master bit is cleared.
>....... */
>.......pci_write_config_word(dev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);

>.......rc =3D pci_dev_reset(dev, 0);

>.......pci_restore_state(dev);

>.......return rc;
}
EXPORT_SYMBOL_GPL(pci_reset_function);
-----------

and

-----------
/**
 * pci_restore_state - Restore the saved state of a PCI device
 * @dev: - PCI device that we're dealing with
 */
void pci_restore_state(struct pci_dev *dev)
{
>.......if (!dev->state_saved)
>.......>.......return;

>......./* PCI Express register must be restored first */
>.......pci_restore_pcie_state(dev);
>.......pci_restore_ats_state(dev);

>.......pci_restore_config_space(dev);

>.......pci_restore_pcix_state(dev);
>.......pci_restore_msi_state(dev);
>.......pci_restore_iov_state(dev);

>.......dev->state_saved =3D false;
}
-----------

with pci_restore_iov_state calling sriov_restore_state:

-----------
static void sriov_restore_state(struct pci_dev *dev)
{
>.......int i;
>.......u16 ctrl;
>.......struct pci_sriov *iov =3D dev->sriov;

>.......pci_read_config_word(dev, iov->pos + PCI_SRIOV_CTRL, &ctrl);
>.......if (ctrl & PCI_SRIOV_CTRL_VFE)
>.......>.......return;

>.......for (i =3D PCI_IOV_RESOURCES; i <=3D PCI_IOV_RESOURCE_END; i++)
>.......>.......pci_update_resource(dev, i);

>.......pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->p=
gsz);
>.......pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, iov->num_VF=
s);
>.......pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>.......if (iov->ctrl & PCI_SRIOV_CTRL_VFE)
>.......>.......msleep(100);
}
--------

The sriov_restore_state looked like if it does the right thing but maybe I =
missread
the code.

>
> >The hardware also have a privately owned SR-IOV related configuration in=
 the PF
> >configuration space. This configuration is used to configure the VFs res=
ources.
> >(memory)
> >
> Per the SRIOV spec, yes, but that's in PCIe ext cfg space.
> That area of the PCI configuration is not saved or restored by dev-reset.

Can a callback be added so PF driver can restore this state ?

Best regards

Beno=EEt Canet
