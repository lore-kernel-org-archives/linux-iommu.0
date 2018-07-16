From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] x86/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Date: Mon, 16 Jul 2018 15:17:57 -0600
Message-ID: <20180716151757.28206fae@t450s.home>
References: <1531773745-41876-1-git-send-email-ashok.raj@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1531773745-41876-1-git-send-email-ashok.raj@intel.com>
Sender: stable-owner@vger.kernel.org
To: Ashok Raj <ashok.raj@intel.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <helgaas@kernel.org>, Gage Eads <gage.eads@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, 16 Jul 2018 13:42:25 -0700
Ashok Raj <ashok.raj@intel.com> wrote:

> PCI_INTERRUPT_PIN should always read  0 for SRIOV Virtual Functions.
> 
> Some SRIOV devices have some bugs in RTL and VF's end up reading 1
> instead of 0 for the PIN.
> 
> We could enforce it by default in vfio_pci_nointx.
> 
> Reported-by: Gage Eads <gage.eads@intel.com>
> Tested-by: Gage Eads <gage.eads@intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Gage Eads <gage.eads@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index b423a30..bc3f4fa 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -192,6 +192,13 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev);
>   */
>  static bool vfio_pci_nointx(struct pci_dev *pdev)
>  {
> +	/*
> +	 * Per PCI, no VF's should have INTx
> +	 * Simply disable it here
> +	 */
> +	if (pdev->is_virtfn)
> +		return true;
> +
>  	switch (pdev->vendor) {
>  	case PCI_VENDOR_ID_INTEL:
>  		switch (pdev->device) {

Nak, this is not what vfio_pci_nointx() is meant for, it's been tried
before and it was broken:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci.c?id=834814e80268c818f354c8f402e0c6604ed75589

This would cause *every* VF to print:

	dev_info(&pdev->dev, "Masking broken INTx support\n");

If the device is incapable of generating INTx then it's probably better
to drop it at vfio_pci_get_irq_count().  Please also note the subject is
misidentified, this is a "vfio/pci" patch, not an "x86/pci" patch.
kvm@vger is the official list for vfio patches.  Thanks,

Alex
