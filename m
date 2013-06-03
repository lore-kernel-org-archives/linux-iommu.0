From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>
Subject: VFIO and scheduled SR-IOV cards
Date: Mon, 3 Jun 2013 18:33:05 +0200
Message-ID: <20130603163305.GC4094@irqsave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: iommu@lists.linux-foundation.org, qemu-devel@nongnu.org, alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org


Hello,

I plan to write a PF driver for an SR-IOV card and make the VFs work with=
 QEMU's
VFIO passthrough so I am asking the following design question before tryi=
ng to
write and push code.

After SR-IOV being enabled on this hardware only one VF function can be a=
ctive
at a given time.

The PF host kernel driver is acting as a scheduler.
It switch every few milliseconds which VF is the current active function =
while
disabling the others VFs.

One consequence of how the hardware works is that the MMR regions of the
switched off VFs must be unmapped and their io access should block until =
the VF
is switched on again.

Each IOMMU map/unmap should be done in less than 100ns.

As the kernel iommu module is being called by the VFIO driver the PF driv=
er
cannot interface with it.

Currently the only interface of the VFIO code is for the userland QEMU pr=
ocess
and I fear that notifying QEMU that it should do the unmap/block would ta=
ke more
than 100ns.

Also blocking the IO access in QEMU under the BQL would freeze QEMU.

Do you have and idea on how to write this required map and block/unmap fe=
ature ?

Best regards

Beno=EEt Canet
