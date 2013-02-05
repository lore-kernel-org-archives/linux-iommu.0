From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: PCI warning on boot 3.8.0-rc1
Date: Mon, 4 Feb 2013 17:36:10 -0800
Message-ID: <20130204173610.18a31d24@nehalam.linuxnetplumber.net>
References: <20130116143853.339dd89b@nehalam.linuxnetplumber.net>
	<CAErSpo5eOE_=Ob2jN7ACy0eJBOa8k36XqCbHnGTCs-wfiy8tiw@mail.gmail.com>
	<20130204103645.38ae2d5e@nehalam.linuxnetplumber.net>
	<1360009684.11144.539.camel@bling.home>
	<1360017684.11144.547.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1360017684.11144.547.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 04 Feb 2013 15:41:24 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> +
> +	if (pci_is_pcie(parent) &&
> +	    (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(parent) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		pr_warn("WARNING: Your hardware is broken, device %s appears to be a\n Legacy PCI device attached directly to a PCIe device which is not a\n PCIe-to-PCI bridge.  Per section 7.8 of the PCI Express 3.0 spec, the\n PCI express capability structure is required for PCI express device\nfunctions.\n",
> +		        pci_name(pdev));

Too whiny!
Two short lines seems to be more the enough. Users can't do anything about
hardware not following spec. Put any outher stuff into comments.
