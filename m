From: colin@horizon.com
Subject: Re: [PATCH v3 00/15] PCI/iommu: Fix DMA alias problems
Date: 16 May 2014 02:28:23 -0400
Message-ID: <20140516062823.15105.qmail@ns.horizon.com>
References: <400175834.3289.65.camel@ul30vt.home>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <400175834.3289.65.camel@ul30vt.home>
Sender: linux-kernel-owner@vger.kernel.org
To: alex.williamson@redhat.com, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Cc: acooks@gmail.com, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux@horizon.com
List-Id: iommu@lists.linux-foundation.org

Alex Williamson wrote:
> Wow, I didn't think that kind of broken was possible.  Maybe instead of
> a bitmap of function aliases we could have a single devfn alias for a
> device.  That means we'd only be able to support a single alias for a
> device, but since I don't think we've seen devices that use more than a
> single alias, maybe that's ok.

In my (never finished) patch set for the same problem, the first thing
I did was

diff --git a/include/linux/pci.h b/include/linux/pci.h
index a13d6825..7788870a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -251,12 +251,13 @@ struct pci_dev {
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/pci */
 	struct pci_slot	*slot;		/* Physical slot this device is in */
 
-	unsigned int	devfn;		/* encoded device & function index */
 	unsigned short	vendor;
 	unsigned short	device;
 	unsigned short	subsystem_vendor;
 	unsigned short	subsystem_device;
 	unsigned int	class;		/* 3 bytes: (base,sub,prog-if) */
+	u8		devfn;		/* encoded device & function index */
+	u8		devfn_quirk;	/* zero is non-quirky */
 	u8		revision;	/* PCI revision, low byte of class word */
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 	u8		pcie_cap;	/* PCIe capability offset */

I encoded "devfn_quirk" as a delta to devfn, so that zero would mean
"no quirk", and no existing intialization would need changing.
