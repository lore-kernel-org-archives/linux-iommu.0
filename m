From: "Eads, Gage" <gage.eads@intel.com>
Subject: RE: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
 report 1 for intx.
Date: Wed, 19 Sep 2018 22:25:03 +0000
Message-ID: <9184057F7FC11744A2107296B6B8EB1E44721113@fmsmsx101.amr.corp.intel.com>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
 <20180809134417.50de7fe7@t450s.home>
 <20180912174618.GA19551@araj-mobl1.jf.intel.com>
 <20180918215957.0d155684@t450s.home> <20180919194617.GA14924@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919194617.GA14924@otc-nc-03>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Raj, Ashok" <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <helgaas@kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
List-Id: iommu@lists.linux-foundation.org

> This looks good and also addresses Alan's concern that don't silently hide under
> the rug for all devices. We'll also queue it for testing just to confirm and keep
> you posted.
> 
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> 

Hi Alex,

I've confirmed that the patch works as intended for the 8086:270c device, and negative tested the warning by commenting out the device's entry in known_bogus_vf_intx_pin.

For what it's worth, my positive test case - launching a QEMU VM with a VFIO-owned 0x270c device - did not trigger the warning. This is because the change to vfio_pci_config.c caused QEMU to read a PCI_INTERRUPT_PIN value of 0, and so didn't execute a codepath that calls vfio_pci_get_irq_count(). Instead, I used a simple C program that calls the VFIO_DEVICE_GET_IRQ_INFO ioctl for negative testing.

Also, there's one typo in the comment: 'quite' -> 'quiet'

Tested-by: Gage Eads <gage.eads@intel.com>

Thanks,
Gage
