Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFEE1E7C02
	for <iommu@lists.linux.dev>; Tue,  3 Jun 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748973252; cv=fail; b=of66cL27uUA88VKm0YlYRIhEDV3xw+CiHsdTnNhCsPv/SjGoP1yfphLMyVK4y6l/HxTi3f3I+G8e2hpx5ujhWF/uXyYS4dmQRqERZUEoBUMBjuJuAgEvHyiTES3K+/EtCuks/sMqGiM1MvDbTZFDRDJdisYVmPmRHur7q8byaIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748973252; c=relaxed/simple;
	bh=M/qgKvb7jHcOXOIbUJCrsLGbYPx41jeiNL8i8XQNbCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QBiN4S8ehqz8PX8QZ4l/yY1UA8mU4kba5lxapW5B+hJZNew3x5E/UL+CtkeAZuV5BKajgugVqAxd60eVp/aJaAPK6l4i4APypfPNKWLDUc1oXjxyXR1IaXJXolTfklKxovGKxZyt2d+la5FTcGGykDfItCbzXbGRrStRoT/RAsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HNPBRcUo; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HNPBRcUo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we+WjjADSaUVwTgsbClnwPqPksJuHuPpt0i+jvAYdNLLURhiQIwYvndFUtPQ9yGVPX4YhdIKSqs+4oXHhjthzqroLoXEqTY4nxU6IPSTZsBKQalT7eSaBp7Ssd9bxowyz51sDLbWx8XsiF8y1bz/cVfXEFDIwaScSkbXRlVURTelL7ke9znhZrpSiQLS934+G5zGZkdZTljmeVZ5aSi+mK4ZTs6sExquQO7olnIMYrqPdlFGxbabSg34VPE9MceR+iZxGvI96Dt6C3RSD1SCfnG9Prb8VMd/PULyX7cuzb3Alg1slrLkPA7pw+DI8k6995ct9wTO7fiREX+ISaF1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1nRMIYMXbkJh+3+n0Ylhjke6PgTkKZA7j3AP4TkyCk=;
 b=Tqr1FQjSOUrIjoMmnpoyJnnh4/D6EMt6Sf0h4fS4Cwtiio3JkDVOAXhYvc+ZR1IrYYmWydyJTlB9B5ghOAw7nV5hP5tBJPWC7rUV1CQYvLGaqFP81ExYsasxznkngvb7l3bOBS/+U2mZhLN+IryadOnHoWvirSaDF0Dys0GfwO0gMqmJWZGLGYxyXjgMaPAuIuQRCc16DO4CgizZH/sHEzVwwcs+otwNmkzEZx03X0Xfl7euX1j4pnrQnlhpZkJHckT6sv82jNNkFKLRGdT6vqUDNNv0/msjuXxxEumLxO/3AvW6Qa4WHWya9lvcRgOtf2/g1UP+7buWl90XzwRu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1nRMIYMXbkJh+3+n0Ylhjke6PgTkKZA7j3AP4TkyCk=;
 b=HNPBRcUoLXL2GyYtHO4w9vxoJBqPoq5qKFyTMXeK521gDJyI8GRQXO2sEmKiDj6V9UY1qPtNT7+EeH7hNnRJ3jl0KpP5vY4o1eHKzPowGjiNZ+2WpwGu4jcXt26YQ2xyonGFW88IDo6NU0JuhMHpUQUWHGjOGhDJnp2RugQLaMVBq90qH83I/7dYJ7Xvh0CSmgS1FNK+TUO1gvl86OvNySq0b9BEMtTM8R5WlJnQn0hrmgBkR04XQCC5F360luatmVL4QCYpw01LYhwCZLGmfmJTJjkPJIyXUbvHem3cykE+lhpiqeWr1wDLCQCNSqCPo6jIVz9kAIU3ygLSZzcRMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 3 Jun
 2025 17:54:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 17:54:04 +0000
Date: Tue, 3 Jun 2025 14:54:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: jacob.pan@linux.microsoft.com,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: Yi Liu <yi.l.liu@intel.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: [PATCH 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu
 mode
Message-ID: <20250603175403.GA407344@nvidia.com>
References: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
 <20250527000511.GK61950@nvidia.com>
 <dcd0cf4b-1907-4c27-a8f6-3dddf8313f6b@intel.com>
 <20250603092549.4fbbed92@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603092549.4fbbed92@DESKTOP-0403QTC.>
X-ClientProxiedBy: BN9PR03CA0465.namprd03.prod.outlook.com
 (2603:10b6:408:139::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fcd184-1710-4f89-9157-08dda2c7a120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CUVKMDrG4WEuqEYQk+VvIG1jVIRzLkI/mnOs7GWrZd2DKnIG3D4l+rIlyhaz?=
 =?us-ascii?Q?GXggRKSeH4qO6Xf7FigT50C0yW40PTfUJOXyr3lli2lv6fZeEO0cJpJh3RXY?=
 =?us-ascii?Q?IEBXYnsWN98ErwCNZFiiaNl9oyfGTn5Xcxt7zMqm//SnrmXenYeiht4ybzxr?=
 =?us-ascii?Q?TaAJ7EfTLU5hLv+a2I3fItmWbHkvnFHVTf4HeJl8B62zI0tCYYxlJgnkZzvo?=
 =?us-ascii?Q?MCo7imUJcFnEbjkfUmyr9OOXqt7uKQHDxjAvrT8fYxvxz648mP/F4X/0RPFe?=
 =?us-ascii?Q?2e6217j57/dA8TFN0Y2YJP5N3XLIY+Rt+o8/i6S/RhOvDSzlGV3SNvco5yJ0?=
 =?us-ascii?Q?PPLNFkHviErEXAwdUXGZm1UuDXidogI8K89mFJmlIw4FaTtGDShFnoKgjr/k?=
 =?us-ascii?Q?Nhw/dfUb25sOcd3DuJHyqPl01w2XXAF4LlO6ZgiYPqM/lfnAyaJnjn0ZSqjS?=
 =?us-ascii?Q?GRM8BtaNEbUAksFokKX0gqJstO6tZ0Pa5N7pHi86kdnYzskazmx7E2ZEsFcA?=
 =?us-ascii?Q?CSTuaebgRZGMjtjLqWUTTbfhxGcTy09CqcXpwefb1MJtUxMX9ju65wfPlfK1?=
 =?us-ascii?Q?pwLcoiwVspiJgvNRrLKageFp9qcf4r3hc45IFX/pUOOIP0gcOvNxDvOy2ycF?=
 =?us-ascii?Q?XeNgpUL43qbCg62EGnD7t3wyVTnynpuuS5qZ5OCbEvbVH7WxTd0q39eAnEa2?=
 =?us-ascii?Q?SwsMFLhYheD9Qzf0J2opcSclkp2y74pNP3tmBy0/BV0zK7Vf9Ugxc/UE/220?=
 =?us-ascii?Q?JUs1h001ka5iv8bP82g7YguKCyrD+KFFlkwtVzWsGTGb1b9exMhwrPW6wZxb?=
 =?us-ascii?Q?MVsABtgnieEbfxn4+ED1ke1Kn7I+atDVhycIIo3h2OUTB8td545ls62mdQqc?=
 =?us-ascii?Q?VX8kSnb05jNxMluFKebeR24ICy6NWh4U3D+KdhhpVNBiU6Ql3SchiXFNHYZ5?=
 =?us-ascii?Q?aSPk3avPkq8QpSJZ4CIU9AzY94y3aJwGsRvnQuMscPiymrBwVDbqqWsb31gE?=
 =?us-ascii?Q?3jjqdhHVXH13rwAccubiMoc2eYue+wissqsrVk5F2Sx3FTO8xmkHjS1tb9Wt?=
 =?us-ascii?Q?s6Nn52h6AaaXeHK0CNXE6kagYqhbtVwMmFd0pl+9HC7Pbu2eDbmIUltiBYxU?=
 =?us-ascii?Q?sbRTI8m01w43VmvhY3UqWJUZCVQYpMiV3Y+erOq6Tk/Ej7gP6hN50N0LQABJ?=
 =?us-ascii?Q?8J5ZowFMSJ8MchENinnPiz55M6tcrfgR+pKXao+CAJgEyYu/jX8zImLDdnve?=
 =?us-ascii?Q?u3E2xLoLgntWK17J48oXvIrgQYcZAzipnIn7YBxG6yquCIveoxOfFowsjGf1?=
 =?us-ascii?Q?UbDb0Fx8nM383dYh32cCKnmjnaCpr/cuh5TV8SAaN1E9sgh2wG9B2IrSnk0e?=
 =?us-ascii?Q?iPZSWGHTwumkjd36gzY1Tj1Zr36R17z4aq6B9NW9aneDWVZjJ4R6zPiSwUGu?=
 =?us-ascii?Q?07Pz7RHsLb8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?742O7kfS5mDSRt3taxUEUkCKM7FRjGlXID+kUbc818L3yfhABdIqzgVlG1Nc?=
 =?us-ascii?Q?nNtpd+Hf53midw4XaBEvJsKkXvdWPzdxZCgn2IvSWPMUrUjzN3FNA41SIEdY?=
 =?us-ascii?Q?TLAoDGMesGmW6qEprS0x9nrTLkKxqLFW4KEvzyQS4HcHmP117MObDZuwGS31?=
 =?us-ascii?Q?RgWYK/3MKX59WAn8KwQB9cDBdpKcLAkeifB2jHObyz41efRjetWAOhZzrDBh?=
 =?us-ascii?Q?Pu9A0zynhdrtekNXCmjIMqDJf9wFKT8/dx9zpLxT5V/DJnthDSP9pV/uqwdS?=
 =?us-ascii?Q?CVWf6EEM8GUIS1oy+5NfKrc2Y2N18cn0yUsQxmkxmNFMHbrVbq2tmamT9KXy?=
 =?us-ascii?Q?90Qa88x12nD/SeLtwh1lSFyT6Dyh89S/GEewPtEC0wYetBWEYLMvXCOhnRPT?=
 =?us-ascii?Q?RwULLYJzkDosPGe1AdjmX6Y/haDXT+e1sKjmvtKZCAxgBgrPeeeBe8bAM+RV?=
 =?us-ascii?Q?CU6g5+xgEt/+dN/3PTp5X6K2by9SEkiFuYHOJl94P3T3pdfeH/TzoDkm4ACB?=
 =?us-ascii?Q?7i7Vab+G2+M8JM8SH5+UD9sWqu5WeBs+J4TyAoRYO/AFdjTgCXpI8IUnZ01/?=
 =?us-ascii?Q?OSqH3wBe5tvdp+aBWEO/8yc1rU+lhPZ1pD6Q+HhxJ2siyOPld8D5aXoBi43w?=
 =?us-ascii?Q?Zgith2g/1rpvLhFerVyrtoBkZc+KWQjtdgG7NIX07EgpTUbzW+vSLkeBGD6U?=
 =?us-ascii?Q?JRVo4xWuUWKMuGf6feaIjVdrCyJYGoFmF3M79tnzieYtKFeUrmFlAuEMvSoH?=
 =?us-ascii?Q?2KAJA6vocece+jNKH2r+Bj25Jt4kjYmFx3NgprFw+e4cUx5zGETypyep9cOF?=
 =?us-ascii?Q?IhSoaJoI2AuohgImEdBifIrMgbJcd0VRKU17JAJ4VxooyTBsaNF8jxHSTAUZ?=
 =?us-ascii?Q?yK6Bnj9nLsFFUrzUxB+i4hxrkR8dejU53Vi1mIZjt+NJWX7mkLt7+Z0CwDsI?=
 =?us-ascii?Q?TQshfdgowKIJJCSPiav24qR1SInCnsPVof98q4C0/s7f9RqkDGujimChLim5?=
 =?us-ascii?Q?nJ+p9TLs7S6Fu9ILNIpf6A11epMh1p5JR6sRw0mBPXuAg1DB1gsV8j2I2H4h?=
 =?us-ascii?Q?5Q2yHMTMszv+Zije2kZJzUHkd0y754xzSp87Egol3k8tW2G0cs7Swmdeqj76?=
 =?us-ascii?Q?O3Y4204J2PPJKYZne+EW0+410+H6ZLb/fyeqHBeKjCEFjSGhwGP5zea/lfjU?=
 =?us-ascii?Q?qSV6RW/kTaPp5wZOcBleHztP30KJLz55Wh/dorLI/5RheNbf8xxfqE5HsBPx?=
 =?us-ascii?Q?HB6yLSd4Z/Iq53wVmGqfpCSedY3sOhOiBwn6b6SxBYCWYAQL4sbey3A7OW12?=
 =?us-ascii?Q?Z7i4GgaEljfaMdQkeo1xcKergWdgKM0PxCmHZ3KR37kUUrkdw+nikuLzh0by?=
 =?us-ascii?Q?/XmkJZnmjoQLYjqbLOHYik0yZ1a0eCyhKUecfpLrXiNpD7wFmwapQJXilcEZ?=
 =?us-ascii?Q?wN6YJ50S/GMjk0GsagNmhsK95xEL0cp4tg4vpV367vfxGYgPcBdhU9G/qOqV?=
 =?us-ascii?Q?h7Qps+aiI8CXrVUOVVoW5OXSFQ8qnxxSTDIp1vHH4mtaCa2inIr2mm4CB3K9?=
 =?us-ascii?Q?bIFxa1E9bvsUgxefIBoJYBA2CiKI4YT4yQpGY4xa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fcd184-1710-4f89-9157-08dda2c7a120
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:54:04.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +p2Kt0CMLT2cXeFYkkZphKxxHYXGZa265yGFkfWtndIkXbB1d5qVoky5vw8D/XkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640

On Tue, Jun 03, 2025 at 09:25:49AM -0700, Jacob Pan wrote:

> Put this bug aside for now, I'm still unclear on why we do not allow
> bind for no-IOMMU devices. Per my understanding, no-IOMMU only means no
> translation. But since device still has been granted access, we should
> be able to allow binding device in no-IOMMU mode with IOMMU-FD
> context while simply disallowing IOAS attachment?

Because it isn't finished, the no-iommu mode under cdev should work
the same as the real iommu mode, complete with an ioas, hwpt and
idevice object.

There is a bunch of work still missing, so the uapi was blocked off
until it is done. Don't want to end up with uapi that doesn't
implement the plan and can't be fixed later..

> The reason I am asking is that I am working on enabling cdev with
> noiommu mode based on Yi's patch
> (https://lore.kernel.org/kvm/20230601082413.22a55ac4.alex.williamson@redhat.com/),
> it seems having iommufd implicit ownership model is key to enable PCI
> HOT RESET. 

The idea is that the IOAS and HWPT will allow iommufd to do the page
pinning exactly as normal-iommu would. So no mlock. A new ioctl would
let userspace retrieve the virtual to physical mapping, so no /proc/
mess.

I haven't thought too much about it, but I'm suspecting the easiest
thing is to make a "VFIO no-iommu iommu_domain" with special ops/etc
that can be put under a HWPT. The selftest has something like this
already.

Then when you bind VFIO would request a no-iommu mode and it wouuld
through the normal flow but create/find a no-iommu HWPT with the
special no-iommu iommu_domain.

Aside from that special logic everything else would be exactly the
same.

Add the virtual to physical ioctl and you are done.

> Our goal is to leverage persistent iommufd context for kexec
> handle off (KHO) usage, we currently have noiommu mode. This requires
> binding of device with iommufd ctx (can be marked as persistent) AFAIK,
> any suggestions?"

Then when you get here things can be much more similar to real KHO as
you could have a real page table (couresty of the iommupt patches)
with identical KHO semantics for no-iommu as real-iommu. Then it
becomes much less of a special case.

Something approximately like this

Jason

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2111bad72c720f..7d171a7c34a287 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -241,6 +241,62 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, "IOMMUFD");
 
+struct iommufd_device *iommufd_device_bind_noiommu(struct iommufd_ctx *ictx,
+						   struct device *dev, u32 *id)
+{
+	struct iommufd_group *igroup;
+	struct iommufd_device *idev;
+	int rc;
+
+	/* FIXME better code sharing with iommufd_get_group() and iommufd_device_bind() */
+
+	igroup = kzalloc(sizeof(*igroup), GFP_KERNEL);
+	if (!igroup)
+		return ERR_PTR(-ENOMEM);
+
+	kref_init(&igroup->ref);
+	mutex_init(&igroup->lock);
+	xa_init(&igroup->pasid_attach);
+	igroup->sw_msi_start = PHYS_ADDR_MAX;
+
+	// FIXME: need to check that igroup->group == NULL is OK for the no iommu paths.
+
+	rc = iommu_device_claim_dma_owner(dev, ictx);
+	if (rc && rc != -ENODEV)
+		goto out_group_put;
+
+	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_release_owner;
+	}
+	idev->no_iommu = true;
+	idev->ictx = ictx;
+	iommufd_ctx_get(ictx);
+	idev->dev = dev;
+	/* The calling driver is a user until iommufd_device_unbind() */
+	refcount_inc(&idev->obj.users);
+	/* igroup refcount moves into iommufd_device */
+	idev->igroup = igroup;
+	mutex_init(&idev->iopf_lock);
+	/*
+	 * If the caller fails after this success it must call
+	 * iommufd_unbind_device() which is safe since we hold this refcount.
+	 * This also means the device is a leaf in the graph and no other object
+	 * can take a reference on it.
+	 */
+	iommufd_object_finalize(ictx, &idev->obj);
+	*id = idev->obj.id;
+	return idev;
+
+out_release_owner:
+	iommu_device_release_dma_owner(dev);
+out_group_put:
+	iommufd_put_group(igroup);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_bind_noiommu, "IOMMUFD");
+
 /**
  * iommufd_ctx_has_group - True if any device within the group is bound
  *                         to the ictx
@@ -366,6 +422,9 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 	struct iommufd_group *igroup = idev->igroup;
 	int rc;
 
+	if (idev->no_iommu)
+		return 0;
+
 	lockdep_assert_held(&igroup->lock);
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
@@ -432,6 +491,9 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_attach_handle *handle;
 	int rc;
 
+	if (idev->no_iommu)
+		return 0;
+
 	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
 	if (rc)
 		return rc;
@@ -486,6 +548,9 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_attach_handle *handle;
 
+	if (idev->no_iommu)
+		return;
+
 	handle = iommufd_device_get_attach_handle(idev, pasid);
 	if (pasid == IOMMU_NO_PASID)
 		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
@@ -507,6 +572,9 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	struct iommufd_attach_handle *handle, *old_handle;
 	int rc;
 
+	if (idev->no_iommu)
+		return 0;
+
 	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
 	if (rc)
 		return rc;
@@ -560,6 +628,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_attach *attach;
 	int rc;
 
+	if (hwpt_paging->no_iommu != idev->no_iommu)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&igroup->lock);
 
 	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
@@ -703,6 +774,9 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 	unsigned long index;
 	int rc;
 
+	if (hwpt_paging->no_iommu)
+		return 0;
+
 	lockdep_assert_held(&igroup->lock);
 
 	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 487779470261a7..58102df9cdfeb0 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -145,7 +145,16 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	hwpt_paging->ioas = ioas;
 	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 
-	if (ops->domain_alloc_paging_flags) {
+	if (idev->no_iommu) {
+		hwpt->domain = iommufd_create_no_iommu_domain();
+		if (IS_ERR(hwpt->domain)) {
+			rc = PTR_ERR(hwpt->domain);
+			hwpt->domain = NULL;
+			goto out_abort;
+		}
+		immediate_attach = false;
+		hwpt_paging->no_iommu = true;
+	} else if (ops->domain_alloc_paging_flags) {
 		hwpt->domain = ops->domain_alloc_paging_flags(idev->dev,
 				flags & ~IOMMU_HWPT_FAULT_ID_VALID, user_data);
 		if (IS_ERR(hwpt->domain)) {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 80e8c76d25f234..7a4a019ad7e5ab 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -308,6 +308,7 @@ struct iommufd_hwpt_paging {
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
 	bool nest_parent : 1;
+	bool no_iommu : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 	struct iommufd_sw_msi_maps present_sw_msi;
@@ -425,6 +426,7 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	bool no_iommu;
 	/* protect iopf_enabled counter */
 	struct mutex iopf_lock;
 	unsigned int iopf_enabled;
diff --git a/drivers/iommu/iommufd/noiommu.c b/drivers/iommu/iommufd/noiommu.c
new file mode 100644
index 00000000000000..6b419a37f0713d
--- /dev/null
+++ b/drivers/iommu/iommufd/noiommu.c
@@ -0,0 +1,180 @@
+
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021-2025, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+#include <linux/iommu.h>
+
+/* FIXME s/mock/noiommu/ */
+
+struct mock_iommu_domain {
+	unsigned long flags;
+	struct iommu_domain domain;
+	struct xarray pfns;
+};
+
+enum {
+	MOCK_DIRTY_TRACK = 1,
+	MOCK_HUGE_PAGE_SIZE = 512 * PAGE_SIZE,
+
+	/*
+	 * Like a real page table alignment requires the low bits of the address
+	 * to be zero. xarray also requires the high bit to be zero, so we store
+	 * the pfns shifted. The upper bits are used for metadata.
+	 */
+	MOCK_PFN_MASK = ULONG_MAX / PAGE_SIZE,
+
+	_MOCK_PFN_START = MOCK_PFN_MASK + 1,
+	MOCK_PFN_START_IOVA = _MOCK_PFN_START,
+	MOCK_PFN_LAST_IOVA = _MOCK_PFN_START,
+	MOCK_PFN_DIRTY_IOVA = _MOCK_PFN_START << 1,
+	MOCK_PFN_HUGE_IOVA = _MOCK_PFN_START << 2,
+};
+
+static inline struct mock_iommu_domain *
+to_mock_domain(struct iommu_domain *domain)
+{
+	return container_of(domain, struct mock_iommu_domain, domain);
+}
+
+static int mock_domain_map_pages(struct iommu_domain *domain,
+				 unsigned long iova, phys_addr_t paddr,
+				 size_t pgsize, size_t pgcount, int prot,
+				 gfp_t gfp, size_t *mapped)
+{
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
+	unsigned long flags = MOCK_PFN_START_IOVA;
+	unsigned long start_iova = iova;
+
+	WARN_ON(iova % PAGE_SIZE);
+	WARN_ON(pgsize % PAGE_SIZE);
+	for (; pgcount; pgcount--) {
+		size_t cur;
+
+		for (cur = 0; cur != pgsize; cur += PAGE_SIZE) {
+			void *old;
+
+			if (pgcount == 1 && cur + PAGE_SIZE == pgsize)
+				flags = MOCK_PFN_LAST_IOVA;
+			if (pgsize != PAGE_SIZE) {
+				flags |= MOCK_PFN_HUGE_IOVA;
+			}
+			old = xa_store(&mock->pfns, iova / PAGE_SIZE,
+				       xa_mk_value((paddr / PAGE_SIZE) |
+						   flags),
+				       gfp);
+			if (xa_is_err(old)) {
+				for (; start_iova != iova;
+				     start_iova += PAGE_SIZE)
+					xa_erase(&mock->pfns,
+						 start_iova /
+							 PAGE_SIZE);
+				return xa_err(old);
+			}
+			WARN_ON(old);
+			iova += PAGE_SIZE;
+			paddr += PAGE_SIZE;
+			*mapped += PAGE_SIZE;
+			flags = 0;
+		}
+	}
+	return 0;
+}
+
+static size_t mock_domain_unmap_pages(struct iommu_domain *domain,
+				      unsigned long iova, size_t pgsize,
+				      size_t pgcount,
+				      struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
+	bool first = true;
+	size_t ret = 0;
+	void *ent;
+
+	WARN_ON(iova % PAGE_SIZE);
+	WARN_ON(pgsize % PAGE_SIZE);
+
+	for (; pgcount; pgcount--) {
+		size_t cur;
+
+		for (cur = 0; cur != pgsize; cur += PAGE_SIZE) {
+			ent = xa_erase(&mock->pfns, iova / PAGE_SIZE);
+
+			/*
+			 * iommufd generates unmaps that must be a strict
+			 * superset of the map's performend So every
+			 * starting/ending IOVA should have been an iova passed
+			 * to map.
+			 *
+			 * This simple logic doesn't work when the HUGE_PAGE is
+			 * turned on since the core code will automatically
+			 * switch between the two page sizes creating a break in
+			 * the unmap calls. The break can land in the middle of
+			 * contiguous IOVA.
+			 */
+			if (!(domain->pgsize_bitmap & MOCK_HUGE_PAGE_SIZE)) {
+				if (first) {
+					WARN_ON(ent && !(xa_to_value(ent) &
+							 MOCK_PFN_START_IOVA));
+					first = false;
+				}
+				if (pgcount == 1 &&
+				    cur + PAGE_SIZE == pgsize)
+					WARN_ON(ent && !(xa_to_value(ent) &
+							 MOCK_PFN_LAST_IOVA));
+			}
+
+			iova += PAGE_SIZE;
+			ret += PAGE_SIZE;
+		}
+	}
+	return ret;
+}
+
+static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
+					    dma_addr_t iova)
+{
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
+	void *ent;
+
+	WARN_ON(iova % PAGE_SIZE);
+	ent = xa_load(&mock->pfns, iova / PAGE_SIZE);
+	WARN_ON(!ent);
+	return (xa_to_value(ent) & MOCK_PFN_MASK) * PAGE_SIZE;
+}
+
+static void mock_domain_free(struct iommu_domain *domain)
+{
+	struct mock_iommu_domain *mock = to_mock_domain(domain);
+
+	WARN_ON(!xa_empty(&mock->pfns));
+	kfree(mock);
+}
+
+static const struct iommu_domain_ops mock_domain_ops = {
+	.free = mock_domain_free,
+	.map_pages = mock_domain_map_pages,
+	.unmap_pages = mock_domain_unmap_pages,
+	.iova_to_phys = mock_domain_iova_to_phys,
+};
+
+static const struct iommu_ops no_iommu_owner;
+
+struct iommu_domain *iommufd_create_no_iommu_domain(void)
+{
+	struct mock_iommu_domain *mock;
+
+	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
+	if (!mock)
+		return ERR_PTR(-ENOMEM);
+
+	mock->domain.geometry.aperture_start = 0;
+	mock->domain.geometry.aperture_end = ULONG_MAX;
+	mock->domain.pgsize_bitmap = PAGE_SIZE;
+	mock->domain.ops = &mock_domain_ops;
+	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
+	xa_init(&mock->pfns);
+	mock->domain.owner = &no_iommu_owner;
+
+	return &mock->domain;
+}
