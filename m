From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [RFC PATCH 2/2] iommu/arm-smmu: Add support for the fsl-mc bus
Date: Thu, 30 Jun 2016 12:11:48 +0000
Message-ID: <HE1PR0401MB18663F18D156196AB570E174E6240@HE1PR0401MB1866.eurprd04.prod.outlook.com>
References: <1467220448-16764-1-git-send-email-nipun.gupta@nxp.com>
	<1467220448-16764-2-git-send-email-nipun.gupta@nxp.com>
	<5775011C.60402@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_HE1PR0401MB18663F18D156196AB570E174E6240HE1PR0401MB1866_"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5775011C.60402-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--_002_HE1PR0401MB18663F18D156196AB570E174E6240HE1PR0401MB1866_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, June 30, 2016 16:53
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; will.deacon-5wv7dgnIgG8@public.gmane.org; Stuart Yoder
> <stuart.yoder-3arQi8VN3Tc@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [RFC PATCH 2/2] iommu/arm-smmu: Add support for the fsl-mc b=
us
>=20
> On 29/06/16 18:14, Nipun Gupta wrote:
> > Implement bus specific support for the fsl-mc bus including
> > registering the arm_smmu_ops and bus specific smmu device init.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> > Signed-off-by: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 43
> > +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> > ab365ec..28d5dc8 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -47,6 +47,9 @@
> >
> >  #include <linux/amba/bus.h>
> >
> > +/* Include path will be changed once FSL-MC support is out from
> > +staging */
>=20
> How about we do that first?

Agree. We are working on that part :)

>=20
> > +#include <../drivers/staging/fsl-mc/include/fsl_mc_smmu.h>
> > +
> >  #include "io-pgtable.h"
> >
> >  /* Maximum number of stream IDs assigned to a single device */ @@
> > -447,6 +450,11 @@ static struct device_node *dev_get_dev_node(struct
> device *dev)
> >  		return bus->bridge->parent->of_node;
> >  	}
> >
> > +	if (dev_is_fsl_mc(dev)) {
>=20
> Where is dev_is_fsl_mc() defined? I don't see it anywhere in mainline, he=
re, or in
> -next.

My Bad. We have provided a patch on the devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org ; linux-=
kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org to have the macro dev_is_fsl_mc defined. Please see =
the attached patch.

>=20
> > +		while (dev_is_fsl_mc(dev))
> > +			dev =3D dev->parent;
> > +	}
> > +
> >  	return dev->of_node;
> >  }
> >
> > @@ -1443,6 +1451,32 @@ static int arm_smmu_init_platform_device(struct
> device *dev,
> >  	return 0;
> >  }
> >
> > +static void __arm_smmu_release_fslmc_iommudata(void *data) {
> > +	kfree(data);
> > +}
>=20
> There's already a suitable callback for this; nobody needs an exact dupli=
cate of
> it.

I see '__arm_smmu_release_pci_iommudata' similarly defined for PCI bus.
We will probably need it renaming to '__arm_smmu_release_iommudata' to have=
 a better readable code. Seems okay?

>=20
> > +static int arm_smmu_init_fslmc_device(struct device *dev,
> > +				      struct iommu_group *group)
> > +{
> > +	struct arm_smmu_master_cfg *cfg;
> > +
> > +	cfg =3D iommu_group_get_iommudata(group);
> > +	if (!cfg) {
> > +		cfg =3D kzalloc(sizeof(*cfg), GFP_KERNEL);
> > +		if (!cfg)
> > +			return -ENOMEM;
> > +
> > +		cfg->streamids[0] =3D fslmc_dev_streamid(dev);
> > +		cfg->num_streamids =3D 1;
> > +
> > +		iommu_group_set_iommudata(group, cfg,
> > +
> __arm_smmu_release_fslmc_iommudata);
> > +	}
>=20
> So the group gets the ID of the container device (assuming that's the fir=
st one
> added), and the subsequent IDs are just ignored and left to go wrong? Or =
is it
> inherently guaranteed that all devices in the same container are programm=
ed
> with the same ID?

Yeah latter one is correct!! Each container is associated with an ID which =
is common for all the devices. Container device gets added first and is res=
ponsible for creating the iommu group and the master CFG.

Thanks,
Nipun

>=20
> Robin.
>=20
> > +	return 0;
> > +}
> > +
> >  static int arm_smmu_add_device(struct device *dev)  {
> >  	struct iommu_group *group;
> > @@ -1467,6 +1501,8 @@ static struct iommu_group
> > *arm_smmu_device_group(struct device *dev)
> >
> >  	if (dev_is_pci(dev))
> >  		group =3D pci_device_group(dev);
> > +	else if (dev_is_fsl_mc(dev))
> > +		group =3D fslmc_device_group(dev);
> >  	else
> >  		group =3D generic_device_group(dev);
> >
> > @@ -1475,6 +1511,8 @@ static struct iommu_group
> > *arm_smmu_device_group(struct device *dev)
> >
> >  	if (dev_is_pci(dev))
> >  		ret =3D arm_smmu_init_pci_device(to_pci_dev(dev), group);
> > +	else if (dev_is_fsl_mc(dev))
> > +		ret =3D arm_smmu_init_fslmc_device(dev, group);
> >  	else
> >  		ret =3D arm_smmu_init_platform_device(dev, group);
> >
> > @@ -2102,6 +2140,11 @@ static int __init arm_smmu_init(void)
> >  	}
> >  #endif
> >
> > +#ifdef CONFIG_FSL_MC_BUS
> > +	if (!iommu_present(&fsl_mc_bus_type))
> > +		bus_set_iommu(&fsl_mc_bus_type, &arm_smmu_ops); #endif
> > +
> >  	return 0;
> >  }
> >
> >


--_002_HE1PR0401MB18663F18D156196AB570E174E6240HE1PR0401MB1866_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Thu, 30 Jun 2016 12:11:47 GMT";
	modification-date="Thu, 30 Jun 2016 12:11:47 GMT"

Received: from VI1PR0401MB1869.eurprd04.prod.outlook.com (10.165.235.23) by
 HE1PR0401MB1866.eurprd04.prod.outlook.com (10.169.119.24) with Microsoft SMTP
 Server (TLS) id 15.1.528.16 via Mailbox Transport; Wed, 29 Jun 2016 11:19:34
 +0000
Received: from HE1PR0401CA0010.eurprd04.prod.outlook.com (10.166.116.148) by
 VI1PR0401MB1869.eurprd04.prod.outlook.com (10.165.235.23) with Microsoft SMTP
 Server (TLS) id 15.1.528.16; Wed, 29 Jun 2016 11:19:33 +0000
Received: from AM1FFO11FD014.protection.gbl (2a01:111:f400:7e00::115) by
 HE1PR0401CA0010.outlook.office365.com (2a01:111:e400:c512::20) with Microsoft
 SMTP Server (TLS) id 15.1.528.16 via Frontend Transport; Wed, 29 Jun 2016
 11:19:33 +0000
Received: from na01-by2-obe.outbound.protection.outlook.com (207.46.100.80) by
 AM1FFO11FD014.mail.protection.outlook.com (10.174.64.92) with Microsoft SMTP
 Server (TLS) id 15.1.523.9 via Frontend Transport; Wed, 29 Jun 2016 11:19:32
 +0000
Received: from BY2PR03CA039.namprd03.prod.outlook.com (10.141.249.12) by
 DM2PR0301MB0862.namprd03.prod.outlook.com (10.160.215.148) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.523.12; Wed, 29
 Jun 2016 11:19:30 +0000
Received: from BY2FFO11FD035.protection.gbl (2a01:111:f400:7c0c::189) by
 BY2PR03CA039.outlook.office365.com (2a01:111:e400:2c5d::12) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.528.16 via
 Frontend Transport; Wed, 29 Jun 2016 11:19:29 +0000
Received: from tx30smr01.am.freescale.net (192.88.168.50) by
 BY2FFO11FD035.mail.protection.outlook.com (10.1.14.220) with Microsoft SMTP
 Server (TLS) id 15.1.523.9 via Frontend Transport; Wed, 29 Jun 2016 11:19:28
 +0000
Received: from b27504-OptiPlex-790.ap.freescale.net (b27504-OptiPlex-790.ap.freescale.net [10.232.132.60])
	by tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id u5TBJPr5004502;
	Wed, 29 Jun 2016 04:19:26 -0700
From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
To: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Stuart Yoder
	<stuart.yoder-3arQi8VN3Tc@public.gmane.org>
CC: "devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org" <devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nipun Gupta
	<nipun.gupta-3arQi8VN3Tc@public.gmane.org>, Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v2] fsl-mc: add helper macro to determine if a device is of
 fsl_mc type
Thread-Topic: [PATCH v2] fsl-mc: add helper macro to determine if a device is
 of fsl_mc type
Thread-Index: AQHR0fgdbJH4IUuCxUWjH1sx36LVvQ==
Date: Wed, 29 Jun 2016 17:14:39 +0000
Message-ID: <1467220479-16864-1-git-send-email-nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Content-Language: en-US
X-MS-Exchange-Organization-AuthSource: AM1FFO11FD014.protection.gbl
X-MS-Has-Attach: 
X-MS-Exchange-Organization-Network-Message-Id: 6f53d175-ca3d-4682-1f6a-08d3a00f3ee9
X-MS-TNEF-Correlator: 
received-spf: Fail (protection.outlook.com: domain of nxp.com does not
 designate 192.88.168.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.88.168.50; helo=tx30smr01.am.freescale.net;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB1866;9:ojd5cl+OkRV4Gc5vFldJedeL9w5jC5hiuXhOLuDgL+b0QAzvk2OTk2NLekFvsxW19OLUmF+BOLTCB84LLjKa+56FGaJB7MoULCNUVzPIIresOXPX4cq+lcU5QPz6zeWI9UISW56s/GyFLe2vlUWjxaw7mCq2WKe8c88D+rlueadFRAsLIatcjGA1fGJSJPfO2z6Bz1aknuh/8c5p9hnL8w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Add a helper macro to return if a device has a bus type of fsl_mc.
This makes the bus driver code more readable and provides a way for
drivers like the SMMU driver to easily check the bus type.

Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
---
 drivers/staging/fsl-mc/bus/dprc-driver.c               | 4 ++--
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c | 2 +-
 drivers/staging/fsl-mc/bus/mc-allocator.c              | 6 +++---
 drivers/staging/fsl-mc/bus/mc-bus.c                    | 6 +++---
 drivers/staging/fsl-mc/include/mc.h                    | 7 +++++++
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl=
-mc/bus/dprc-driver.c
index 7fc4717..cd6d75a 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
@@ -649,7 +649,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
                /*
                 * This is a child DPRC:
                 */
-               if (WARN_ON(parent_dev->bus !=3D &fsl_mc_bus_type))
+               if (WARN_ON(!dev_is_fsl_mc(parent_dev)))
                        return -EINVAL;

                if (WARN_ON(mc_dev->obj_desc.region_count =3D=3D 0))
@@ -681,7 +681,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
                 */
                struct irq_domain *mc_msi_domain;

-               if (WARN_ON(parent_dev->bus =3D=3D &fsl_mc_bus_type))
+               if (WARN_ON(dev_is_fsl_mc(parent_dev)))
                        return -EINVAL;

                error =3D fsl_mc_find_msi_domain(parent_dev,
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drive=
rs/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index 720e2b0..d0c20d6 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -35,7 +35,7 @@ static int its_fsl_mc_msi_prepare(struct irq_domain *msi_=
domain,
        struct fsl_mc_device *mc_bus_dev;
        struct msi_domain_info *msi_info;

-       if (WARN_ON(dev->bus !=3D &fsl_mc_bus_type))
+       if (WARN_ON(!dev_is_fsl_mc(dev)))
                return -EINVAL;

        mc_bus_dev =3D to_fsl_mc_device(dev);
diff --git a/drivers/staging/fsl-mc/bus/mc-allocator.c b/drivers/staging/fs=
l-mc/bus/mc-allocator.c
index fb08f22..9216c32 100644
--- a/drivers/staging/fsl-mc/bus/mc-allocator.c
+++ b/drivers/staging/fsl-mc/bus/mc-allocator.c
@@ -281,7 +281,7 @@ int __must_check fsl_mc_portal_allocate(struct fsl_mc_d=
evice *mc_dev,
        if (mc_dev->flags & FSL_MC_IS_DPRC) {
                mc_bus_dev =3D mc_dev;
        } else {
-               if (WARN_ON(mc_dev->dev.parent->bus !=3D &fsl_mc_bus_type))
+               if (WARN_ON(!dev_is_fsl_mc(mc_dev->dev.parent)))
                        return error;

                mc_bus_dev =3D to_fsl_mc_device(mc_dev->dev.parent);
@@ -420,7 +420,7 @@ int __must_check fsl_mc_object_allocate(struct fsl_mc_d=
evice *mc_dev,
        if (WARN_ON(mc_dev->flags & FSL_MC_IS_DPRC))
                goto error;

-       if (WARN_ON(mc_dev->dev.parent->bus !=3D &fsl_mc_bus_type))
+       if (WARN_ON(!dev_is_fsl_mc(mc_dev->dev.parent)))
                goto error;

        if (WARN_ON(pool_type =3D=3D FSL_MC_POOL_DPMCP))
@@ -678,7 +678,7 @@ static int fsl_mc_allocator_probe(struct fsl_mc_device =
*mc_dev)
                return -EINVAL;

        mc_bus_dev =3D to_fsl_mc_device(mc_dev->dev.parent);
-       if (WARN_ON(mc_bus_dev->dev.bus !=3D &fsl_mc_bus_type))
+       if (WARN_ON(!dev_is_fsl_mc(&mc_bus_dev->dev)))
                return -EINVAL;

        mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
diff --git a/drivers/staging/fsl-mc/bus/mc-bus.c b/drivers/staging/fsl-mc/b=
us/mc-bus.c
index 4053643..098f07c 100644
--- a/drivers/staging/fsl-mc/bus/mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/mc-bus.c
@@ -207,11 +207,11 @@ static void fsl_mc_get_root_dprc(struct device *dev,
 {
        if (WARN_ON(!dev)) {
                *root_dprc_dev =3D NULL;
-       } else if (WARN_ON(dev->bus !=3D &fsl_mc_bus_type)) {
+       } else if (WARN_ON(!dev_is_fsl_mc(dev))) {
                *root_dprc_dev =3D NULL;
        } else {
                *root_dprc_dev =3D dev;
-               while ((*root_dprc_dev)->parent->bus =3D=3D &fsl_mc_bus_typ=
e)
+               while (dev_is_fsl_mc((*root_dprc_dev)->parent))
                        *root_dprc_dev =3D (*root_dprc_dev)->parent;
        }
 }
@@ -405,7 +405,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
        struct fsl_mc_bus *mc_bus =3D NULL;
        struct fsl_mc_device *parent_mc_dev;

-       if (parent_dev->bus =3D=3D &fsl_mc_bus_type)
+       if (dev_is_fsl_mc(parent_dev))
                parent_mc_dev =3D to_fsl_mc_device(parent_dev);
        else
                parent_mc_dev =3D NULL;
diff --git a/drivers/staging/fsl-mc/include/mc.h b/drivers/staging/fsl-mc/i=
nclude/mc.h
index ac7c1ce..91213f5 100644
--- a/drivers/staging/fsl-mc/include/mc.h
+++ b/drivers/staging/fsl-mc/include/mc.h
@@ -183,6 +183,13 @@ struct fsl_mc_device {
 #define to_fsl_mc_device(_dev) \
        container_of(_dev, struct fsl_mc_device, dev)

+#ifdef CONFIG_FSL_MC_BUS
+#define dev_is_fsl_mc(_dev) ((_dev)->bus =3D=3D &fsl_mc_bus_type)
+#else
+/* If fsl-mc bus is not present device cannot belong to fsl-mc bus */
+#define dev_is_fsl_mc(_dev) (0)
+#endif
+
 /*
  * module_fsl_mc_driver() - Helper macro for drivers that don't do
  * anything special in module init/exit.  This eliminates a lot of
--
1.9.1


--_002_HE1PR0401MB18663F18D156196AB570E174E6240HE1PR0401MB1866_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_HE1PR0401MB18663F18D156196AB570E174E6240HE1PR0401MB1866_--
