From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>
Subject: SR-IOV PF reset and QEMU VFs VFIO passthrough
Date: Sat, 1 Jun 2013 14:13:21 +0200
Message-ID: <20130601121320.GC5157@irqsave.net>
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
To: linux-pci@vger.kernel.org, qemu-devel@nongnu.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org


Hello,

I may have soon the PF driver of an SR-IOV card to code and make work wit=
h
QEMU/KVM so I have the following questions.

In an AMD64 setup where QEMU use VFIO to passthrough the VFs of an SR-IOV=
 card
to a guest will the consequences of a PF FLR be handled fine by QEMU and =
the
guest ?

I read that pci_reset_function would call pci_restore_state restoring the=
 SR-IOV
configuration after the reset of the PF.

The ways the hardware work means that the VFs would disappear and reappea=
r in a
short lapse of time.

Will these events be handled by the kernel pci hotplug code ?

Given that the PF driver restore the PF config space after the reset will=
 /sys
files used by QEMU disappear and reappear messing the QEMU VFIO passthrou=
gh or
will it goes smoothly ?

Best regards

Beno=EEt Canet
