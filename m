From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] irq remapping ops for x86
Date: Mon, 7 May 2012 15:54:18 +0200
Message-ID: <20120507135418.GA16756@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4238340606769657644=="
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
To: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4238340606769657644==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(again as a signed email)

Hi Ingo,

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git intr-remapping-ops

or as a signed tag at:
  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git intr-remapping-ops-for-ingo

Joerg Roedel (8):
      iommu: Rename intr_remapping files to intel_intr_remapping
      iommu/vt-d: Make intr-remapping initialization generic
      iommu/vt-d: Convert missing apic.c intr-remapping call to remap_ops
      iommu/vt-d: Convert IR ioapic-setup to use remap_ops
      iommu/vt-d: Convert IR set_affinity function to remap_ops
      iommu/vt-d: Convert free_irte into a remap_ops callback
      iommu/vt-d: Convert MSI remapping setup to remap_ops
      x86, iommu/vt-d: Clean up interfaces for interrupt remapping

Suresh Siddha (2):
      iommu: rename intr_remapping references to irq_remapping
      iommu: rename intr_remapping.[ch] to irq_remapping.[ch]

 arch/ia64/include/asm/irq_remapping.h              |    4 +
 arch/x86/include/asm/irq_remapping.h               |  120 +++++--
 arch/x86/kernel/apic/apic.c                        |   30 +-
 arch/x86/kernel/apic/io_apic.c                     |  297 ++++-------------
 drivers/iommu/Makefile                             |    2 +-
 drivers/iommu/dmar.c                               |    9 +-
 drivers/iommu/intel-iommu.c                        |    3 +-
 .../{intr_remapping.c => intel_irq_remapping.c}    |  355 ++++++++++++++++----
 drivers/iommu/intr_remapping.h                     |   17 -
 drivers/iommu/irq_remapping.c                      |  164 +++++++++
 drivers/iommu/irq_remapping.h                      |   88 +++++
 include/linux/dmar.h                               |   85 -----
 12 files changed, 724 insertions(+), 450 deletions(-)
 create mode 100644 arch/ia64/include/asm/irq_remapping.h
 rename drivers/iommu/{intr_remapping.c => intel_irq_remapping.c} (66%)
 delete mode 100644 drivers/iommu/intr_remapping.h
 create mode 100644 drivers/iommu/irq_remapping.c
 create mode 100644 drivers/iommu/irq_remapping.h

This patchset introduces a generic ops-interface for
accessing interrupt remapping hardware on x86. It factors
out the VT-d specific code from io_apic.c and moves it to
drivers/iommu. These changes will be used to add support for
AMD interrupt remapping hardware.

Please pull.

Thanks,

	Joerg


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPp9QKAAoJECvwRC2XARrjP0kQAJeB4vWQeW3qm/j6mwVYp49u
LLsmQU+xdX7gN/uGzdvRRJ39n0HK/IK89+/Z61YfFBLT4J54QgFICJqFqRhieKYJ
nH8393MBmSfL5B+CakHYmuO6Iq7hwE9c6BQLWbUG0RZXfgIhT8H5Q/25zzUanuVD
6omtulBnpqc94pJisvo8PpJfDrOCwqZgR8XISgEb4NSNTQeTxNMmfstwyherbXfb
YE+Z0VCl7Tc7lcm1IHqQN5srBWyokbzppTWzjmutcDVpnnMNhUrVMOwWX08ajZHP
+NjWb73TUyn2j5miedeJ5hxJ9UPxEdMxsl/nUIioir23P/ia8M2FvzEWhETozWU8
jBd+BDdouUMDFRKJ9KpxqoEFB4DyAn2PbgkVu97vKn53I9AtI/oaFnp4i77O9w0j
Lvdd8oI7VpuU1SHdPpVbll8zm0z6vWVKfgvC6kWpZaoMAGm6NoG1t0QX6Ao4CTkQ
ynCNy+ZGzusZXmslrCHJHWseZCUjZPmKXMuM+IbxBnvdyw9Hdlrhe6EK3FDSkKnH
I7z2x4Cu3p3LH6Y4pwg70hQqi4AmGT50VXkWkHGxJ4hjcWZ7m/o0OccaGQQh7qh7
MCYo9M4st+bQOahatnan7CcOK4fwrE7fqMQaBTMeFiRPKUHzuomEZJ+YjD0gMbIG
8u8wfdyoSqKjWK5mIttX
=0Las
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--



--===============4238340606769657644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4238340606769657644==--
