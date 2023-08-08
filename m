Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0912B60;
	Tue,  8 Aug 2023 14:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckLjWiVNsUUhoRLZbYByEmKuI3qbWipQtBRAI2MM2/fhlihBgEx+s1mIuvFKgZVHnv9RebVXFlfE9062MH5ycdt1y6ocAl32qnGPX974+S6GO6h8J7m7D8i/TJWrDVuBmN41YGzQdH9PYAXeOCptpb2u5Y161sKVFu60xP80iQTCaV99DzDACy5rChxjhh22FoxwXBX4gL04q6XLi64wX66QFXQ2ig+OMDoQgNaVuhsrATmPKs7D0vxwUUrTrmsbWAP0IJKixof0kINfmc1mBYnfAj1CSiw+EBQzV2B9SXzHXT81Ci5CdkkMkbF4DkifpzwpgcLcnVwOaqB8pwfa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pmSiTom7KXLbgR9EJPSH/eiZyymNsAvVN9DZTZ5EKg=;
 b=X4EuD6Sb4OrFsbuTakKmivVa6C6Jn3bD2E/1h6CkUokVyyKht26gLGGnPQ+1a4pxVDIKBRduKH02fnR8cQf5a4msSef8pDTGFXUFOJbaWB8uqROcKXgEl71V3kmu/jJqGiUp54PvXf09KHCgK/MgRpNfIEN0VkvKc2lSsHMvmBz1Jlf9kUBnz8QdCiEp+6paCTsbqE/w6HIvQR64vdL5qfeZx7YVmzhhrMBKUKyaUNR2pgcquzJVVqjgvWrjt0y16SxJ+DL0hYlxPem5RjVnbO7ywIXYbJ/BRoa8M4rV2qbgLe4VJBJOIUxP9A/6QWo74tv8IW9RmoJz/ijfLg6MHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pmSiTom7KXLbgR9EJPSH/eiZyymNsAvVN9DZTZ5EKg=;
 b=dnROMHK3Cwr4wvHrTpIUVfdXDSEUcroGcZIRu/ArtQWAUrnbG2T6WTEgWgOu35L+dSimkF0EE+YhwWjMUtNpELpiKX842H0Eh1f1NUwcguhkSvS6jGx9SDnKWO4/W53l8S9fLw/UdsiMSSM4xtvS1MmxJc29B+PxMh0rtKnuwyZq6L1MRDwPy+2otoprtihT0o4JUQmTgMcAbDnyWC2vEqEZkvTtgm28SjerMMcASQjDrKuSMXZymi9rZgx7HQHvfty2SEbnDixUS7ItM+DyQCOH8WlbyOrNhXTGD/Jr3+1RLIXyWD+cWbygmmkfs62VlOsM4zQHDLTISEtv9M73JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 14:30:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:30:25 +0000
Date: Tue, 8 Aug 2023 11:30:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 00/10] Refine the locking for dev->iommu_group
Message-ID: <ZNJRf4Xp8rY1+iT4@nvidia.com>
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <ZNDpfCoeFxA56ZlU@8bytes.org>
 <CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com>
 <CGME20230808123250eucas1p19d12a9ae0e530c123ba625189f593b36@eucas1p1.samsung.com>
 <7483d18e-d06f-53eb-92af-beed50674ab0@samsung.com>
 <ZNI8W0hTXraSi/Ne@nvidia.com>
 <4d56203e-b602-07ee-ab74-2825c110c36d@samsung.com>
 <ZNJCRhGGxS+63Dnr@nvidia.com>
 <bc5d6aa8-e8ca-c896-2f39-af074d55e436@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5d6aa8-e8ca-c896-2f39-af074d55e436@samsung.com>
X-ClientProxiedBy: MN2PR20CA0057.namprd20.prod.outlook.com
 (2603:10b6:208:235::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5c22ec-a047-428b-82a0-08db981c0198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FVYkEzZgGmlqFot4EybcnDkEL4ggxgfL6n8RSJGjHhZXbYx1yzfyoz4TTbPVpA8VfZIOFBiadEK8WOjMauN2CSI1/ZF9k36qyUjM6FWbEi9z4h48p0Ke/u/NiI4pHi5dO6Pn6oOTgE13yl4+5DoPJMnAJQLi0jiRdEf4zUEQEfNGwSGGS77H68bsYGkWdG/lfHQQRFVozG49n+sN0pJ7d9shKHywD9IBcN9tNOxeVcX8veO0s8ijaF+dvXWr5OiVk1JQfgT4kzfb6hPu8brNx90r2ArUW7iPMFwPQe7Qg1+j87KQHwV2sjnRDPzQVEfhOKacBu4pKy+cRmpRo6albsf0UoB511XhL19W9adbOogQGQsQ5NSuUKrWVBsj2AXz098ryTCdfP3xn/5uw9iZKQ3DhXfgddBfsHp00xFzklxCi5xeU9NEZ6U7hRVrYZ1r+m4nL4TRPaqgoWav/vqwzVIsx05loBydoomrpLy0B8t4v45ta7l4ErRFqGWKTjz9+yarOQEgwLUqOkg0Qr0Tu4PQ5FxkFiA/5HEHkIFg6HAMDRf2WwvtP7ee31na8N0f22YppdXcdaKLBPKFi82it0wSCCXaOIlCcCF2HlgxEAfzkiNzIn7Cm/l6prY1i5S+MOtSkQ8J3eVZbO/0+qxLaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(186006)(1800799003)(451199021)(83380400001)(2616005)(54906003)(4326008)(6916009)(8936002)(316002)(8676002)(7416002)(5660300002)(66476007)(66556008)(66946007)(38100700002)(966005)(478600001)(6486002)(86362001)(2906002)(6512007)(41300700001)(6506007)(36756003)(26005)(53546011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y32ADOOsA987QsLH6pnqds3wx8PGi9dKyrkIBtwGZx6Wqo2bmEqCg0hyzxfi?=
 =?us-ascii?Q?S/qKqIYz2q3I6GML1wxVh7Rty53bhHLup64FF0hpCmm3Ol/lNVDK/h6I/GR1?=
 =?us-ascii?Q?6KJfftlLyJPhlqPnneCEYhpYEAu3Jnsue7GtYT8uVYvyW1axCm9xOUngshMv?=
 =?us-ascii?Q?u1L5dKDkKkzdWHobE+NUiHVoVwZXH/SX4B3S0Ld6ht6v9X0tkxI8NXSzorQq?=
 =?us-ascii?Q?BPkkPnji/8fDw0Yr2mdfYwucHDHEXqFe35EIhpuPJk9xQ65asTa1+8MDFq4U?=
 =?us-ascii?Q?AhM/7CZKGv9vLYH6agbZ6LDTkjlutsG2wKd2WWZrezqsmRpPJW9M2iet8n4D?=
 =?us-ascii?Q?zs2uCVJa+iVAzCBnmKEO02hwj5A72CgZYAz9b6jw6+SU9i7bNM+7WTZWc1Yq?=
 =?us-ascii?Q?ZvUcEH+yl5MEZT5F7l2zfdYTC6YQQe+5LYvTglG5WFOfU2Gq2NEUnnOcjAMx?=
 =?us-ascii?Q?sYDOAZAr7zWK8YsyBc7/TB97Mzml1hCkh06DpXZptiLWz4OYsfzCHa1wuYVk?=
 =?us-ascii?Q?CR8VM0AYJHTMHMHFGYLM0+crR9S2OIRuA3wlhJGSAtixiNWfhVyTzVJ6qpk/?=
 =?us-ascii?Q?i+tIktLVcedzs/ZvRaAPKucMycvxrxeiNWxutpjsKWD0Efnoocx+gPn5OWeD?=
 =?us-ascii?Q?OASOw+fmRb9Jqt7a/eogpMThs0tn/AXltMyaraBC/780wuTTI3ZQLuxK6pjx?=
 =?us-ascii?Q?KGNclKXRftFmURu2o37LUGvOQG8TjKStWmkKl0k9NrMhglQyIpf8tRJX5DJe?=
 =?us-ascii?Q?uKRixXISutz+4Th6BhS5z8UbZG+Ap9df4OhiORMPoMzxEdLgKSfTYUvWwysZ?=
 =?us-ascii?Q?ZmAvQB7nf7OgirR/QYmaek/Wl/nfvkaE5w+83FXZ3rTOGy3u9KCUDImTO4xD?=
 =?us-ascii?Q?VDLWOmr/nS42TZvl1zwpwcMu0Ffbtxy81JjTAolKFhiUtJw7YTTZKOnOjoHh?=
 =?us-ascii?Q?JnglBAToNLivbzlOYMp0wI+eW2XMkLs40M6bInRYMgV+fW8mfhpo/q1TFyuz?=
 =?us-ascii?Q?B2S6+d0sW3qWFL2LmJmV94yzLyRosSyjKk40w1184IHEI+Iyyhs9p/PFaM7V?=
 =?us-ascii?Q?y0EFyBVqsz9/xIBvlTUA0XOwqjoYQV4aJdfxF9QfEdmgT4K3wCFZ1wCf04Ih?=
 =?us-ascii?Q?elaKfiVQBNJfqViWO1XBAUh8JT97SKBQjF0DCNJjlMT/ZwaVlqgH+jkEkRUi?=
 =?us-ascii?Q?68Yta5PEijUSw91R7rvhzcD1EzardvzrTon1l0rhCiuxXBe0mhyhP3BMIrJO?=
 =?us-ascii?Q?K+cYAK3M/PraKmuhX8icePTPSAZu3Ia6zEebdW9ZdArJVlIMSYkjJQUzGYkO?=
 =?us-ascii?Q?I2vxMmJ04S9Z5qzrRZOQJX2YK8xP6rVy8q2sAwYBhmG202xaNpQDP3GIzq99?=
 =?us-ascii?Q?CtVyvUqfr3xpSuC8qqEzah1+9eIUNYmV01mgjMZlL2m+oZ0jdXdT0OtwRqh1?=
 =?us-ascii?Q?JHz/dtckafhBcVtz6zPHZ4uX75TxffQBG6Qr+RtcduICAlZYhCfvHJ+U98JT?=
 =?us-ascii?Q?5E0gxQmxIsu1MSXxUZmfkHDcmXXnHZ/6KfkNi0Q6XnkTSvh7SR0dyhqt3oE5?=
 =?us-ascii?Q?XWLEb7Z1yBHsnBniQWZY/5sG0YbrrZ5pmxpzrDQc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5c22ec-a047-428b-82a0-08db981c0198
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:30:25.8432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TT7AXCflXsVOEyMAINMJqCvjMegaztCmUnWEdnLKd16aJSwQAHaN803wYChYTIUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732

On Tue, Aug 08, 2023 at 04:02:40PM +0200, Marek Szyprowski wrote:
> Hi Jason,
> 
> On 08.08.2023 15:25, Jason Gunthorpe wrote:
> > On Tue, Aug 08, 2023 at 03:08:30PM +0200, Marek Szyprowski wrote:
> >>> Any of the drivers that use platform device as the iommu_device will
> >>> have a problem, please try:
> >>>
> >>> https://lore.kernel.org/linux-iommu/ZNIz%2FNVLb6WqqvQx@nvidia.com/
> >> I've checked and it doesn't help in my case. I will soon check why.
> > Oh, I botched it. Forgot that the iommu_device->dev is the sysfs
> > handle not the HW device. Maybe this:
> 
> This fixed the early lockup, but then system hangs again a bit later. It 
> looks that this device lock in __iommu_probe_device() is really
> problematic, 

Yes, I expected we'd hit something like this - I checked alot of call
paths but missed these two. The self-probe is sneaky, but here the
device_lock is held way up the call chain, I just missed it.

The fix is to just annotate that we already hold the lock when calling
iommu_probe_device(), since we know in those cases that we must be
holding it:

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index daa64dd687524b..3fc5e12f2f1c09 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1582,7 +1582,7 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 	 * iommu_probe_device() call for dev, replay it to get things in order.
 	 */
 	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
+		err = iommu_probe_device_locked(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7dbbcffac21930..b867d7f22954e9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -264,6 +264,7 @@ int iommu_device_register(struct iommu_device *iommu,
 		return -EBUSY;
 
 	iommu->ops = ops;
+	iommu->hwdev = hwdev;
 	if (hwdev)
 		iommu->fwnode = dev_fwnode(hwdev);
 
@@ -273,7 +274,7 @@ int iommu_device_register(struct iommu_device *iommu,
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++) {
 		iommu_buses[i]->iommu_ops = ops;
-		err = bus_iommu_probe(iommu_buses[i]);
+		err = bus_iommu_probe(iommu_buses[i], iommu);
 	}
 	if (err)
 		iommu_device_unregister(iommu);
@@ -452,24 +453,23 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	struct group_device *gdev;
 	int ret;
 
-	if (!ops)
-		return -ENODEV;
 	/*
 	 * Allow __iommu_probe_device() to be safely called in parallel,
 	 * both dev->iommu_group and the initial setup of dev->iommu are
 	 * protected this way.
 	 */
-	device_lock(dev);
+	device_lock_assert(dev);
+
+	if (!ops)
+		return -ENODEV;
 
 	/* Device is probed already if in a group */
-	if (dev->iommu_group) {
-		ret = 0;
-		goto out_unlock;
-	}
+	if (dev->iommu_group)
+		return 0;
 
 	ret = iommu_init_device(dev, ops);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	group = dev->iommu_group;
 	gdev = iommu_group_alloc_device(group, dev);
@@ -505,7 +505,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 			list_add_tail(&group->entry, group_list);
 	}
 	mutex_unlock(&group->mutex);
-	device_unlock(dev);
 
 	if (dev_is_pci(dev))
 		iommu_dma_set_pci_32bit_workaround(dev);
@@ -519,12 +518,10 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
-out_unlock:
-	device_unlock(dev);
 	return ret;
 }
 
-int iommu_probe_device(struct device *dev)
+int iommu_probe_device_locked(struct device *dev)
 {
 	const struct iommu_ops *ops;
 	int ret;
@@ -540,6 +537,16 @@ int iommu_probe_device(struct device *dev)
 	return 0;
 }
 
+int iommu_probe_device(struct device *dev)
+{
+	int ret;
+
+	device_lock(dev);
+	ret = iommu_probe_device_locked(dev);
+	device_unlock(dev);
+	return ret;
+}
+
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev)
 {
@@ -1784,12 +1791,26 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 	return group->default_domain;
 }
 
+struct probe_iommu_args {
+	struct list_head *group_list;
+	struct iommu_device *iommu;
+};
+
 static int probe_iommu_group(struct device *dev, void *data)
 {
-	struct list_head *group_list = data;
+	struct probe_iommu_args *args = data;
+	bool need_lock;
 	int ret;
 
-	ret = __iommu_probe_device(dev, group_list);
+	/* Probing the iommu itself is always done under the device_lock */
+	need_lock = !args->iommu || args->iommu->hwdev != dev;
+
+	if (need_lock)
+		device_lock(dev);
+	ret = __iommu_probe_device(dev, args->group_list);
+	if (need_lock)
+		device_unlock(dev);
+
 	if (ret == -ENODEV)
 		ret = 0;
 
@@ -1858,13 +1879,16 @@ static void iommu_group_do_probe_finalize(struct device *dev)
 		ops->probe_finalize(dev);
 }
 
-int bus_iommu_probe(const struct bus_type *bus)
+int bus_iommu_probe(const struct bus_type *bus, struct iommu_device *iommu)
 {
 	struct iommu_group *group, *next;
+	struct probe_iommu_args args = {};
 	LIST_HEAD(group_list);
 	int ret;
 
-	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
+	args.group_list = &group_list;
+	args.iommu = iommu;
+	ret = bus_for_each_dev(bus, NULL, &args, probe_iommu_group);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 157b286e36bf3a..b5b7d4bd2cefb9 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -160,7 +160,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	 * probe for dev, replay it to get things in order.
 	 */
 	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
+		err = iommu_probe_device_locked(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 97c45f50bf4332..828679abef7503 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1234,6 +1234,10 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		if (err)
 			goto out_sysfs;
 		obj->has_iommu_driver = true;
+	} else {
+		/* Re-probe bus to probe device attached to this IOMMU */
+		obj->iommu.hwdev = &pdev->dev;
+		bus_iommu_probe(&platform_bus_type, &obj->iommu);
 	}
 
 	pm_runtime_enable(obj->dev);
@@ -1242,9 +1246,6 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 
-	/* Re-probe bus to probe device attached to this IOMMU */
-	bus_iommu_probe(&platform_bus_type);
-
 	return 0;
 
 out_sysfs:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f1e18e81fca78b..96782bfb384462 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -361,6 +361,7 @@ struct iommu_domain_ops {
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
+ * @hwdev: The device HW that controls the iommu
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  */
@@ -369,6 +370,7 @@ struct iommu_device {
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
 	struct device *dev;
+	struct device *hwdev;
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 };
@@ -465,7 +467,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
-extern int bus_iommu_probe(const struct bus_type *bus);
+extern int bus_iommu_probe(const struct bus_type *bus,
+			   struct iommu_device *iommu);
 extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
@@ -709,6 +712,7 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 }
 
 int iommu_probe_device(struct device *dev);
+int iommu_probe_device_locked(struct device *dev);
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);


