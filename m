From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/pci: Some buggy virtual functions incorrectly report
 1 for intx.
Date: Mon, 16 Jul 2018 15:13:52 -0700
Message-ID: <20180716221352.GA43385@otc-nc-03>
References: <1531773745-41876-1-git-send-email-ashok.raj@intel.com>
 <20180716151757.28206fae@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716151757.28206fae@t450s.home>
Sender: stable-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <helgaas@kernel.org>, Gage Eads <gage.eads@intel.com>, Ashok Raj <ashok.raj@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Alex

On Mon, Jul 16, 2018 at 03:17:57PM -0600, Alex Williamson wrote:
> >  static bool vfio_pci_nointx(struct pci_dev *pdev)
> >  {
> > +	/*
> > +	 * Per PCI, no VF's should have INTx
> > +	 * Simply disable it here
> > +	 */
> > +	if (pdev->is_virtfn)
> > +		return true;
> > +
> >  	switch (pdev->vendor) {
> >  	case PCI_VENDOR_ID_INTEL:
> >  		switch (pdev->device) {
> 
> Nak, this is not what vfio_pci_nointx() is meant for, it's been tried
> before and it was broken:

That seems to make sense. I'll spin a new patch and have that tested
before reposting with the following suggestions.

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci.c?id=834814e80268c818f354c8f402e0c6604ed75589
> 
> This would cause *every* VF to print:
> 
> 	dev_info(&pdev->dev, "Masking broken INTx support\n");
> 
> If the device is incapable of generating INTx then it's probably better
> to drop it at vfio_pci_get_irq_count().  Please also note the subject is
> misidentified, this is a "vfio/pci" patch, not an "x86/pci" patch.
> kvm@vger is the official list for vfio patches.  Thanks,
> 
> Alex
