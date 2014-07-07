From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: 3.16rc3 multiplatform, Armada 370 and IOMMU: unbootable kernel
Date: Mon, 7 Jul 2014 20:37:58 -0300
Message-ID: <20140707233758.GA1456@arch.cereza>
References: <20140703135146.GA6898@luxor.wired.org>
 <53B5C61D.2060308@free-electrons.com>
 <53B5CA26.7050405@free-electrons.com>
 <1936558.QaAG1bYMuD@avalon>
 <20140705150308.GA28791@arch.cereza>
 <20140705205951.GB3678@kroah.com>
 <20140707105818.GA1101@arch.cereza>
 <20140707183002.GA5947@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140707183002.GA5947@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paolo Pisati <p.pisati@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Joerg Roedel <joro@8bytes.org>, Hiroshi.DOYU@nokia.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 07 Jul 11:30 AM, Greg Kroah-Hartman wrote:
> On Mon, Jul 07, 2014 at 07:58:18AM -0300, Ezequiel Garcia wrote:
[..]
> >=20
> > I guess I snipped the thread and lost most of the information about=
 the panic.
> > Here's the original bug report:
> >=20
> > http://www.spinics.net/lists/arm-kernel/msg344059.html
> >=20
> > The problem reported involves enabling OMAP IOMMU driver and not an=
y other IOMMU
> > driver. Doing some tracing and adding a few prints, we found that
> > omap_iommu_init() sets a bus notifier for the platform bus type:
> >=20
> > omap_iommu_init -> bus_set_iommu -> iommu_bus_init:
> >=20
> > static void iommu_bus_init(struct bus_type *bus, struct iommu_ops *=
ops)
> > {
> >         bus_register_notifier(bus, &iommu_bus_nb);
> >         bus_for_each_dev(bus, NULL, ops, add_iommu_group);
> > }
> >=20
> > But the iommu bus notifier gets called for the 'pci' bus type, whic=
h
> > has the iommu_ops field NULL (since it hasn't been set for iommu).
>=20
> So this is what needs to be figured out, how is the notifier being
> called with a PCI device?  Who else called iommu_bus_init() for the P=
CI
> bus?
>=20

Nobody. The only caller of iommu_bus_init() the above OMAP IOMMU.

However, I found something interesting. Tried to bisect this without mu=
ch
luck; I did two bisects and ended up in the same merge commit:

# good: [0f16aa3c24a216d14d7f0587e1cbd2c1b51a38f3] Merge tag 'samsung-d=
t-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsu=
ng into next/dt
# first bad commit: [755a9ba7bf24a45b6dbf8bb15a5a56c8ed12461a] Merge ta=
g 'dt-for-3.16' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/ar=
m-soc into next

So, after doing a few diff's between that good and bad and searching fo=
r
"bus_notifier" changes, saw something strange in arch/arm/mach-mvebu/co=
herency.c.

It seems bus_register_notifier() is been called for platform and pci de=
vices
with the *same* notifier block. Haven't looked close enough, but you me=
ntioned
that could cause trouble?

This patch fixes the issue here:

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/cohe=
rency.c
index 477202f..2bdc323 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -292,6 +292,10 @@ static struct notifier_block mvebu_hwcc_nb =3D {
 	.notifier_call =3D mvebu_hwcc_notifier,
 };
=20
+static struct notifier_block mvebu_hwcc_pci_nb =3D {
+	.notifier_call =3D mvebu_hwcc_notifier,
+};
+
 static void __init armada_370_coherency_init(struct device_node *np)
 {
 	struct resource res;
@@ -427,7 +431,7 @@ static int __init coherency_pci_init(void)
 {
 	if (coherency_available())
 		bus_register_notifier(&pci_bus_type,
-				       &mvebu_hwcc_nb);
+				       &mvebu_hwcc_pci_nb);
 	return 0;
 }
=20
Paolo, can you apply it and confirm it fixes the problem?

Greg, can you confirm using the same notifier block pointer
for two different bus types makes the bus notifier go nuts?

Thanks for the help,
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
