From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.2
Date: Tue, 23 Jun 2015 11:24:13 +0200
Message-ID: <20150623092412.GA25264@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6394195295686438769=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============6394195295686438769==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The IOMMU changes have conflicts this time with IRQ related patches
coming from the tip tree. Some of the IRQ patches there also touch the
Intel and AMD interrupt remapping code in drivers/iommu, which conflicts
with the Intel VT-d kdump fixes.

I attached my resolution of the conflicts to this pull-request and
compiled and run-time tested my resolution on an Intel VT-d and an
AMD IOMMU machine.

If you want me to send you another pull-request with the conflicts
already solved, please let me know.  So with that notice in front, here
comes the pull-request:

The following changes since commit 0f57d86787d8b1076ea8f9cbdddda2a46d534a27:

  Linux 4.1-rc8 (2015-06-14 15:51:10 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v4.2

for you to fetch changes up to 5ffde2f67181195d457b95df44b8f88e8d969d89:

  Merge branches 'arm/rockchip', 'arm/exynos', 'arm/smmu', 'x86/vt-d', 'x86=
/amd', 'default-domains' and 'core' into next (2015-06-19 17:17:47 +0200)

----------------------------------------------------------------

IOMMU Updates for Linux v4.2

This time with bigger changes than usual:

	* A new IOMMU driver for the ARM SMMUv3. This IOMMU is pretty
	  different from SMMUv1 and v2 in that it is configured through
	  in-memory structures and not through the MMIO register region.
	  The ARM SMMUv3 also supports IO demand paging for PCI devices
	  with PRI/PASID capabilities, but this is not implemented in
	  the driver yet.

	* Lots of cleanups and device-tree support for the Exynos IOMMU
	  driver. This is part of the effort to bring Exynos DRM support
	  upstream.

	* Introduction of default domains into the IOMMU core code. The
	  rationale behind this is to move functionalily out of the
	  IOMMU drivers to common code to get to a unified behavior
	  between different drivers.
	  The patches here introduce a default domain for iommu-groups
	  (isolation groups). A device will now always be attached to a
	  domain, either the default domain or another domain handled by
	  the device driver. The IOMMU drivers have to be modified to
	  make use of that feature. So long the AMD IOMMU driver is
	  converted, with others to follow.

	* Patches for the Intel VT-d drvier to fix DMAR faults that
	  happen when a kdump kernel boots. When the kdump kernel boots
	  it re-initializes the IOMMU hardware, which destroys all
	  mappings from the crashed kernel. As this happens before
	  the endpoint devices are re-initialized, any in-flight DMA
	  causes a DMAR fault. These faults cause PCI master aborts,
	  which some devices can't handle properly and go into an
	  undefined state, so that the device driver in the kdump kernel
	  fails to initialize them and the dump fails.
	  This is now fixed by copying over the mapping structures (only
	  context tables and interrupt remapping tables) from the old
	  kernel and keep the old mappings in place until the device
	  driver of the new kernel takes over. This emulates the the
	  behavior without an IOMMU to the best degree possible.

	* A couple of other small fixes and cleanups.

----------------------------------------------------------------
Colin Cross (1):
      iommu/exynos: Tell kmemleak to ignore 2nd level page tables

Dan Carpenter (1):
      iommu: Checking for NULL instead of IS_ERR

Heiko Stuebner (1):
      iommu/rockchip: Silence attaching and detaching of devices

Joerg Roedel (45):
      iommu/amd: Handle integer overflow in dma_ops_area_alloc
      iommu: Remove function name from pr_fmt()
      iommu: Add a few printk messages to group handling code
      iommu: Propagate error in add_iommu_group
      iommu: Clean up after a failed bus initialization
      iommu: Call remove_device call-back after driver release
      iommu: Allocate a default domain for iommu groups
      iommu: Limit iommu_attach/detach_device to devices with their own gro=
up
      iommu: Make sure a device is always attached to a domain
      iommu: Add iommu_get_domain_for_dev function
      iommu: Introduce direct mapped region handling
      iommu: Create direct mappings in default domains
      iommu: Add function to query the default domain of a group
      iommu: Introduce iommu_request_dm_for_dev()
      iommu/amd: Implement dm_region call-backs
      iommu/amd: Use default domain if available for DMA-API
      iommu/amd: Implement add_device and remove_device
      iommu/amd: Support IOMMU_DOMAIN_DMA type allocation
      iommu/amd: Support IOMMU_DOMAIN_IDENTITY type allocation
      iommu/amd: Put IOMMUv2 devices in a direct mapped domain
      iommu/amd: Get rid of device_dma_ops_init()
      iommu/amd: Remove unused fields from struct dma_ops_domain
      iommu/amd: Propagate errors from amd_iommu_init_api
      iommu/amd: Handle errors returned from iommu_init_device
      iommu/vt-d: Cleanup log messages
      iommu/vt-d: Init QI before root entry is allocated
      iommu/vt-d: Make root entry visible for hardware right after allocati=
on
      iommu/vt-d: Detect pre enabled translation
      iommu/vt-d: Copy translation tables from old kernel
      iommu/vt-d: Do not re-use domain-ids from the old kernel
      iommu/vt-d: Mark copied context entries
      iommu/vt-d: Allocate si_domain in init_dmars()
      iommu/vt-d: Don't do early domain assignment if kdump kernel
      iommu/vt-d: Don't copy translation tables if RTT bit needs to be chan=
ged
      iommu/vt-d: Don't disable translation prior to OS handover
      iommu/vt-d: Enable Translation only if it was previously disabled
      iommu/vt-d: Move EIM detection to intel_prepare_irq_remapping
      iommu/vt-d: Move QI initializationt to intel_setup_irq_remapping
      iommu/vt-d: Disable IRQ remapping in intel_prepare_irq_remapping
      iommu/vt-d: Set IRTA in intel_setup_irq_remapping
      iommu/vt-d: Copy IR table from old kernel when in kdump mode
      iommu/vt-d: Make sure copied over IR entries are not reused
      iommu/vt-d: Don't disable IR when it was previously enabled
      iommu/amd: Handle large pages correctly in free_pagetable
      Merge branches 'arm/rockchip', 'arm/exynos', 'arm/smmu', 'x86/vt-d', =
'x86/amd', 'default-domains' and 'core' into next

Marek Szyprowski (15):
      iommu: Init iommu-groups support earlier, in core_initcall
      iommu/exynos: Don't read version register on every tlb operation
      iommu/exynos: Remove unused functions
      iommu/exynos: Remove useless members from exynos_iommu_owner structure
      iommu/exynos: Refactor function parameters to simplify code
      iommu/exynos: Rename variables to reflect their purpose
      iommu/exynos: Use struct exynos_iommu_domain in internal structures
      iommu/exynos: Remove excessive includes and sort others alphabetically
      iommu/exynos: Document internal structures
      iommu/exynos: Add/remove callbacks should fail if no iommu is availab=
le
      iommu/exynos: Add support for binding more than one sysmmu to master =
device
      iommu/exynos: Add support for runtime_pm
      iommu/exynos: Add system suspend/resume support
      iommu/exynos: Init from dt-specific callback instead of initcall
      iommu/exynos: Add callback for initializing devices from device tree

Robert Callicotte (1):
      iommu: Fix checkpatch warnings for Missing a blank line after declara=
tions

Robin Murphy (1):
      iommu/arm-smmu: Fix ATS1* register writes

Tomasz Figa (1):
      iommu/rockchip: Make sure that page table state is coherent

Will Deacon (4):
      iommu/arm-smmu: Make force_stage module param read-only in sysfs
      Documentation: dt-bindings: Add device-tree binding for ARM SMMUv3 IO=
MMU
      iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices
      drivers/vfio: Allow type-1 IOMMU instantiation on top of an ARM SMMUv3

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   37 +
 MAINTAINERS                                        |    3 +-
 drivers/iommu/Kconfig                              |   13 +
 drivers/iommu/Makefile                             |    1 +
 drivers/iommu/amd_iommu.c                          |  589 ++---
 drivers/iommu/amd_iommu_init.c                     |   34 +-
 drivers/iommu/amd_iommu_proto.h                    |    2 +-
 drivers/iommu/amd_iommu_types.h                    |   11 -
 drivers/iommu/arm-smmu-v3.c                        | 2670 ++++++++++++++++=
++++
 drivers/iommu/arm-smmu.c                           |   23 +-
 drivers/iommu/dmar.c                               |   28 +-
 drivers/iommu/exynos-iommu.c                       |  527 ++--
 drivers/iommu/intel-iommu.c                        |  495 +++-
 drivers/iommu/intel_irq_remapping.c                |  255 +-
 drivers/iommu/iommu.c                              |  373 ++-
 drivers/iommu/iova.c                               |    4 +
 drivers/iommu/rockchip-iommu.c                     |   27 +-
 drivers/vfio/Kconfig                               |    2 +-
 include/linux/intel-iommu.h                        |    5 +
 include/linux/iommu.h                              |   44 +
 20 files changed, 4186 insertions(+), 957 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
 create mode 100644 drivers/iommu/arm-smmu-v3.c

Please pull.

Thanks,

	Joerg

diff --cc drivers/iommu/dmar.c
index 536f2d8,c588658..c9db04d
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@@ -1642,17 -1642,26 +1642,17 @@@ int dmar_set_interrupt(struct intel_iom
  	if (iommu->irq)
  		return 0;
 =20
 -	irq =3D dmar_alloc_hwirq();
 -	if (irq <=3D 0) {
 +	irq =3D dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
 +	if (irq > 0) {
 +		iommu->irq =3D irq;
 +	} else {
- 		pr_err("IOMMU: no free vectors\n");
+ 		pr_err("No free IRQ vectors\n");
  		return -EINVAL;
  	}
 =20
 -	irq_set_handler_data(irq, iommu);
 -	iommu->irq =3D irq;
 -
 -	ret =3D arch_setup_dmar_msi(irq);
 -	if (ret) {
 -		irq_set_handler_data(irq, NULL);
 -		iommu->irq =3D 0;
 -		dmar_free_hwirq(irq);
 -		return ret;
 -	}
 -
  	ret =3D request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
  	if (ret)
- 		pr_err("IOMMU: can't request irq\n");
+ 		pr_err("Can't request irq\n");
  	return ret;
  }
 =20
diff --cc drivers/iommu/intel_irq_remapping.c
index 80f1d14,47fcebf..6f75ab7
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@@ -8,7 -11,7 +11,8 @@@
  #include <linux/irq.h>
  #include <linux/intel-iommu.h>
  #include <linux/acpi.h>
 +#include <linux/irqdomain.h>
+ #include <linux/crash_dump.h>
  #include <asm/io_apic.h>
  #include <asm/smp.h>
  #include <asm/cpu.h>
@@@ -72,14 -54,63 +76,34 @@@ static struct hpet_scope ir_hpet[MAX_HP
   * the dmar_global_lock.
   */
  static DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
 +static struct irq_domain_ops intel_ir_domain_ops;
 =20
+ static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
  static int __init parse_ioapics_under_ir(void);
 =20
+ static bool ir_pre_enabled(struct intel_iommu *iommu)
+ {
+ 	return (iommu->flags & VTD_FLAG_IRQ_REMAP_PRE_ENABLED);
+ }
+=20
+ static void clear_ir_pre_enabled(struct intel_iommu *iommu)
+ {
+ 	iommu->flags &=3D ~VTD_FLAG_IRQ_REMAP_PRE_ENABLED;
+ }
+=20
+ static void init_ir_status(struct intel_iommu *iommu)
+ {
+ 	u32 gsts;
+=20
+ 	gsts =3D readl(iommu->reg + DMAR_GSTS_REG);
+ 	if (gsts & DMA_GSTS_IRES)
+ 		iommu->flags |=3D VTD_FLAG_IRQ_REMAP_PRE_ENABLED;
+ }
+=20
 -static struct irq_2_iommu *irq_2_iommu(unsigned int irq)
 -{
 -	struct irq_cfg *cfg =3D irq_cfg(irq);
 -	return cfg ? &cfg->irq_2_iommu : NULL;
 -}
 -
 -static int get_irte(int irq, struct irte *entry)
 -{
 -	struct irq_2_iommu *irq_iommu =3D irq_2_iommu(irq);
 -	unsigned long flags;
 -	int index;
 -
 -	if (!entry || !irq_iommu)
 -		return -1;
 -
 -	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
 -
 -	if (unlikely(!irq_iommu->iommu)) {
 -		raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 -		return -1;
 -	}
 -
 -	index =3D irq_iommu->irte_index + irq_iommu->sub_handle;
 -	*entry =3D *(irq_iommu->iommu->ir_table->base + index);
 -
 -	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 -	return 0;
 -}
 -
 -static int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
 +static int alloc_irte(struct intel_iommu *iommu, int irq,
 +		      struct irq_2_iommu *irq_iommu, u16 count)
  {
  	struct ir_table *table =3D iommu->ir_table;
 -	struct irq_2_iommu *irq_iommu =3D irq_2_iommu(irq);
 -	struct irq_cfg *cfg =3D irq_cfg(irq);
  	unsigned int mask =3D 0;
  	unsigned long flags;
  	int index;
@@@ -534,9 -693,9 +645,29 @@@ static void __init intel_cleanup_irq_re
  	}
 =20
  	if (x2apic_supported())
- 		pr_warn("Failed to enable irq remapping.  You are vulnerable to irq-inj=
ection attacks.\n");
+ 		pr_warn("Failed to enable irq remapping. You are vulnerable to irq-inje=
ction attacks.\n");
+ }
+=20
++/*
++ * Set Posted-Interrupts capability.
++ */
++static inline void set_irq_posting_cap(void)
++{
++	struct dmar_drhd_unit *drhd;
++	struct intel_iommu *iommu;
++
++	if (!disable_irq_post) {
++		intel_irq_remap_ops.capability |=3D 1 << IRQ_POSTING_CAP;
++
++		for_each_iommu(iommu, drhd)
++			if (!cap_pi_support(iommu->cap)) {
++				intel_irq_remap_ops.capability &=3D
++						~(1 << IRQ_POSTING_CAP);
++				break;
++			}
++	}
 +}
 +
  static int __init intel_prepare_irq_remapping(void)
  {
  	struct dmar_drhd_unit *drhd;
@@@ -676,11 -784,16 +756,11 @@@ static int __init intel_enable_irq_rema
 =20
  	irq_remapping_enabled =3D 1;
 =20
 -	/*
 -	 * VT-d has a different layout for IO-APIC entries when
 -	 * interrupt remapping is enabled. So it needs a special routine
 -	 * to print IO-APIC entries for debugging purposes too.
 -	 */
 -	x86_io_apic_ops.print_entries =3D intel_ir_io_apic_print_entries;
 +	set_irq_posting_cap();
 =20
- 	pr_info("Enabled IRQ remapping in %s mode\n", eim ? "x2apic" : "xapic");
+ 	pr_info("Enabled IRQ remapping in %s mode\n", eim_mode ? "x2apic" : "xap=
ic");
 =20
- 	return eim ? IRQ_REMAP_X2APIC_MODE : IRQ_REMAP_XAPIC_MODE;
+ 	return eim_mode ? IRQ_REMAP_X2APIC_MODE : IRQ_REMAP_XAPIC_MODE;
 =20
  error:
  	intel_cleanup_irq_remapping();

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJViSW8AAoJECvwRC2XARrjKrIQAJLtZIhjsXN5S2SFOgJ9nplI
yM8bzjFyTFfseulZqvMjLBC+4bLSjr5mvaGhOSTRgeBs04NEuSgo70Oo73gvpDKO
TzEYt8g+CKcLxgwROiiKO2o9RUCgeR+X8bjf0yNuM63xxitglQREbQs1SoGEeLba
D58dp2NBcAZ3N/NpPLjX1LnRSayW+07sB+HCDMZPgDmQ1h50CmT06z8WUNXtKRxM
/u5PqDWqqVIi2wbOasiXUePKFyTeNyVSdEMG/NIRf8/hxM2mqX9xfbZPVMk/qoES
nHt9ZknH5gKg+xevD6KT/3KKxnqNIjYnBVh2roKrAt0jRQhgTgTz5LcNP5GiZtlg
XeY5J8mfz3guPEtLD2DxxmHTP2/vpifMHyYZbD2XIUhBl2v8z3dVo4Ppe/jPQgmK
9dKBp2nrGPtNcBbFalmWLWssybwlghHr7Jeq2coWNmw+rfQB8Sl4o9TFiAcyUWlZ
9hMgP5IK/9kExH90XLrPfsTrlaDyEggiln3NW2622nR+fW64Srkv2eMO34b51XlA
eZhat+Qm+BNYB6VU1b9emUn0wnbOPOOLlp7ro3Z+Xa2TxSywqaoEjxx/uc3dQiVh
5jAMbk6H0lX4MCxqCS0LhUv/jUb8oPfQpRWr/B4+EMAlPVG+RuNQ5fbzAh44rWFY
tSf6tBG7xMHt3WgO9/sZ
=5+RA
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--===============6394195295686438769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6394195295686438769==--
