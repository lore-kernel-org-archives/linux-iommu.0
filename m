From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] vfio/pci: Some buggy virtual functions incorrectly
	report 1 for intx.
Date: Tue, 18 Sep 2018 21:59:57 -0600
Message-ID: <20180918215957.0d155684@t450s.home>
References: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
	<20180809134417.50de7fe7@t450s.home>
	<20180912174618.GA19551@araj-mobl1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180912174618.GA19551-7RUrO8UaCDyr4tA6zuQqW9h3ngVCH38I@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gage Eads <gage.eads-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 12 Sep 2018 10:46:19 -0700
"Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, Aug 09, 2018 at 01:44:17PM -0600, Alex Williamson wrote:
> > On Thu,  9 Aug 2018 12:37:06 -0700
> > Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >   
> > > PCI_INTERRUPT_PIN should always read  0 for SRIOV Virtual
> > > Functions.
> > > 
> > > Some SRIOV devices have some bugs in RTL and VF's end up reading 1
> > > instead of 0 for the PIN.  
> > 
> > Hi Ashok,
> > 
> > One question, can we identify which VFs are known to have this
> > issue so that users (and downstreams) can know how to prioritize
> > this patch?  
> 
> Hi Alex
> 
> Sorry it took some time to hunt this down. 
> 
> The offending VF has a device ID : 0x270C
> The corresponding PF has a device ID: 0x270B.

Ok, I interpret Alan's previous comment about the patch[1] to suggest a
structure a bit more like that below.  IOW, we know that 8086:270c
inspires this change, but once it's included we won't know who else
relies on it.  We can perhaps encourage better hardware validation, or
at least better tracking of who needs this with a warning and
whitelist.  Testing, especially positive and negative testing against
the warning, and reviews welcome.  Thanks,

Alex

[1]https://lkml.org/lkml/2018/8/10/462

commit d780da26a81c6f47522ae0aeff03abd4d08b89b5
Author: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Tue Sep 18 21:27:57 2018 -0600

    vfio/pci: Mask buggy SR-IOV VF INTx support
    
    The SR-IOV spec requires that VFs must report zero for the INTx pin
    register as VFs are precluded from INTx support.  It's much easier for
    the host kernel to understand whether a device is a VF and therefore
    whether a non-zero pin register value is bogus than it is to do the
    same in userspace.  Override the INTx count for such devices and
    virtualize the pin register to provide a consistent view of the device
    to the user.
    
    As this is clearly a spec violation, warn about it to support hardware
    validation, but also provide a known whitelist as it doesn't do much
    good to continue complaining if the hardware vendor doesn't plan to
    fix it.
    
    Known devices with this issue: 8086:270c
    
    Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index cddb453a1ba5..8af3f6f35f32 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -430,14 +430,41 @@ static int vfio_pci_open(void *device_data)
 	return ret;
 }
 
+static const struct pci_device_id known_bogus_vf_intx_pin[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x270c) },
+	{}
+};
+
 static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
 {
 	if (irq_type == VFIO_PCI_INTX_IRQ_INDEX) {
 		u8 pin;
+
+		if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx)
+			return 0;
+
 		pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
-		if (IS_ENABLED(CONFIG_VFIO_PCI_INTX) && !vdev->nointx && pin)
-			return 1;
 
+		/*
+		 * Per SR-IOV spec rev 1.1, 3.4.1.18 the interrupt pin register
+		 * does not apply to VFs and VFs must implement this register
+		 * as read-only with value zero.  Userspace is not readily
+		 * able to identify a device as a VF and thus that the pin
+		 * definition on the device is bogus should a device violate
+		 * this requirement.  For such devices, override the bogus
+		 * value and provide a warning to support hardware validation
+		 * (or be quite if it's known).  PCI config space emulation
+		 * will virtualize this register for all VFs.
+		 */
+		if (pin && vdev->pdev->is_virtfn) {
+			if (!pci_match_id(known_bogus_vf_intx_pin, vdev->pdev))
+				dev_warn_once(&vdev->pdev->dev,
+					      "VF reports bogus INTx pin %d\n",
+					      pin);
+			return 0;
+		}
+
+		return pin ? 1 : 0;
 	} else if (irq_type == VFIO_PCI_MSI_IRQ_INDEX) {
 		u8 pos;
 		u16 flags;
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 62023b4a373b..25130fa6e265 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1678,7 +1678,8 @@ int vfio_config_init(struct vfio_pci_device *vdev)
 		*(__le16 *)&vconfig[PCI_DEVICE_ID] = cpu_to_le16(pdev->device);
 	}
 
-	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx)
+	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx ||
+	    pdev->is_virtfn)
 		vconfig[PCI_INTERRUPT_PIN] = 0;
 
 	ret = vfio_cap_init(vdev);
