Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB37100AC;
	Tue,  8 Aug 2023 12:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjWzfn9JUc6G7pfis7nNoBAe08SynhvbUKrg+pGHQ8PsRAbdtt08yM3yD2SZ/WE2Z9FzgfZLoPT6dgUhVrB1qZxO6+r7JDQYDMVFTtkc0+S8metBcZSQbDt1OjHTPIfQcG5sTNggWJrX7yoqNjqsmiqWDOLxh59VwGp5HwByNxVeV+JPq90/WVWpwNgK60ex7ZlutT8AdNzt+ytgYUDEHjcLfSClWL/S9aYkcI60Gik0e8/Cb2yYS/QcXR8MMP8pHTFjsgIi+OE7IAqL+aF4dltugICg3xiWqmeEFgCf6zQtZlr3HnhmTVWjbQjUF8Wk2gN9Y4pKrMEpmvsOFh4h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLH9DtIrPDBjbLLByOYOlQTBw13QxHYGRrSMKu+0Muw=;
 b=ADr21Q4EmxnsUtI3EN0wHrqEyY8O7hyc6WbE98GMeQgRxa8Dqakf/oqjlJq+zoHf0wFqjXhdLvj+37C7WlVEPWisYZR75wIcoF02d7eHGCXwK04yAIKNb6BaMxOkG/QYMvNvR4E8WDhVFXFdkZZOjhsi/8eEbXBOsK/rCquzGBr620qB+Kujenl5YM2L1lNfOvb4lEewDLv4EWiNbSl49wmdTlaZh4oQmgtPzjm2CGxAHWDVWyDaQYkkl6geHk8xIjjb2H3wzGTKnF/7KmZnqKhnas8wIi54Ad99ZJgz6xDp1k8l606AmQssjdUZWoBBeoNbXlnpHX8E8G/t4zVlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLH9DtIrPDBjbLLByOYOlQTBw13QxHYGRrSMKu+0Muw=;
 b=alpKncMLissCKJz3L8nuZ6aeYZQM5dAr5XaGyrDok276vF+nN5t17Pa/OG9aRf1FwfnHY/GH6Op9FjMjY44POLIAy7kBRj72oP+WfLgETU/fcc9cnoueE1U1Qq2svoc4f/BLt6HAIHuYAsEAuyctKWQHcx/ecM6fMDbashCcHW2wM0NnGs50W3QBQEYf+uMVQanAnuwXfI56DvfAXDlIea9AA59rpLetE+PWTxScaVFKsrKWH+AYaA+IIyJ69dA8al6gj2iy0syl62MmApc8tXsAvVN27zKhx812IA+LzI6PRMHZnIT6hQ9qQaSzpVCoaCjWM6IZ5D7zuBdg+Mb6Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 12:24:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 12:24:29 +0000
Date: Tue, 8 Aug 2023 09:24:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>,
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
Message-ID: <ZNIz/NVLb6WqqvQx@nvidia.com>
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <ZNDpfCoeFxA56ZlU@8bytes.org>
 <CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com>
X-ClientProxiedBy: BL0PR01CA0020.prod.exchangelabs.com (2603:10b6:208:71::33)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea9326d-2641-449f-3868-08db980a69df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PeA30jiBKejRb4GZvZVqTQGv/agZH9f2laqaxYb4yPCTqd1OSgklBRkxEW1eRxxRTtjmJGfbK/HFDHxB1ZE7kFjZIRTyE31hKuMMOpfsZtWOy+ung1IOdsh+4T4IJX3J6ytrHw/nV4Pqeepm6xSKJ21DoyeK4w+0ExsHbjmYJHYICnzGbLHfVrL6afwbqFyGQRXw/jKAL0CmbtCej6AAeP/tspaiWYTcrP14nGrc8ujFpoklAPDI47zNmjLmsTtUTlIKL4psb5U7cwNi/0BHNTOe7Ph1cCHNY4rx4AuPwHK7Ch2YG63RukHCHGzB8JNeHvyK/m1TqFhXMHkRw1dUMwDruH6iziOSqOJifbZ4XBOPb3vBKKJofcwt0YBtBkJaBXIvr/L53ioWB2dFuD6gIQdtzPXC9HARHwvSmjlJOviNiy51mUkmaIte5wrVeU1nwnANcOHy6ni8Wbpt8ZnE4kjZgPU97zwXKMaBmi/TjCQ3wPgSTUFDGTACro13vwNB3UQyFhY2UvXZNrK9t4eRCVn8aWnaWtW1CQqF7VJMRqAZBiOqlwByxVi+7M0H9zbj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(1800799003)(186006)(2616005)(36756003)(6512007)(4326008)(316002)(6916009)(38100700002)(54906003)(6486002)(6506007)(86362001)(66946007)(66476007)(66556008)(478600001)(41300700001)(26005)(8676002)(8936002)(2906002)(83380400001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iju2S4LQik66rAstyoRkap9rULQ/we345GynG+GbdtCuDyZyf5Tx4OSjDRoX?=
 =?us-ascii?Q?SinPu13wOOsqTJ66p7sd7FEstKmRVdS7okYuV1vc+Y5YgLFOlVTtBwkZ3M+O?=
 =?us-ascii?Q?VaY/EOSY47tHHxs1SjDr0PTKJJhfZ5Ai72rfuKVyzpFjtChT7XLGHrIV+q/L?=
 =?us-ascii?Q?G2KN7Skq2EDLjafV60316t2YPPrb7hghPPs/Pr2YwZlPMZwVKPAtnb74GWNL?=
 =?us-ascii?Q?8UTLsivLfncao9cVdP1Bxj+kLT9J1JXDpFgIjNyHaBFesdBw5wPzEYiH6lpw?=
 =?us-ascii?Q?QwSYQbWHIroTfD4ahkOR+C11O60+NOseghyia2rKm6idCLkDhf99yP2+Nt+s?=
 =?us-ascii?Q?hdPUa2fNb2JCeZNaIqas9a4jKJtAFwhqZoMgDP8kkbKlDWUtBEgfWHtqslz5?=
 =?us-ascii?Q?NijrdRJuRKA8pLm9C7MdvOY06QvGFHExpiqf4TE31ixOfou1lf5lI5NrW39z?=
 =?us-ascii?Q?jnVh50B2ifWhGv5eJeNJ7roeXibic3IhvSvDGBgWtRO3mP7Rgomljdb7286q?=
 =?us-ascii?Q?6dNjnHadoMTpOW7qmXtuWYTqjsH/sA+wOrFDbmw5TD42JqSuZxrQnGRWyBjz?=
 =?us-ascii?Q?2fEIXcp3F1CkXupcP5Ntg59ImpcuaNWjl6UZd96Afn5yH1sM6N6EpbBxkiKd?=
 =?us-ascii?Q?TrsFgKsI02rqbxdatKJW0og8J2PBXD4+Tq79zv1rn19E6lG6WubjY0+J+cj7?=
 =?us-ascii?Q?JRoPWX3BObcSm3+MXMCfvpLPbQDydkFqQDl5VhHG+bR4vI50ykdReBFIaPfc?=
 =?us-ascii?Q?2/G3FcAA0wuHvgcTxlNFJyphfbCc7v/k4xytpdNzgD86ygfA0eUk66XZDP+P?=
 =?us-ascii?Q?nLm5C1Yt2YCcwwz0kxEDaR03ugE3stsdPNkDnHASXhKsH128qQp+FSVNmX8P?=
 =?us-ascii?Q?ZKC3tke63/Eout4SYab0jfv8ved48DJfmQ+xKYEnN37BosuA8T2SV4e0fVuC?=
 =?us-ascii?Q?UBShZ7Gom4qvikQQoNKdQrgIZmdD1Vof3Z+1L2CSehL1rr5aSAjYJmF2cLPk?=
 =?us-ascii?Q?bbDr+nEj6MNR/7QFnEt1knlCk7jdIfcZrESvsAW3i9HZnBTM7E0W4hK0p221?=
 =?us-ascii?Q?XTb+Xb47XyCQcIRszsiVBFKJ6kG0chirIKhOkiE+2NktHHk1ll5iNKNoKdPh?=
 =?us-ascii?Q?BiUgp7yFKzj1wjwLi6kZAhJo+6fR5oOB96ttunu3QZtG2SYNMCoJdPU1ZPg9?=
 =?us-ascii?Q?zJ07Nb4XflDe1iKctfryKR27mG/l2o2POk3XEeQ6RAdV6usMgxpOWR8Gzah9?=
 =?us-ascii?Q?Fim89UY/8N5nGxBaAYuJUr6NbA8cINCVQGWxr4TGQDrODb03RKTo8Ddh96DI?=
 =?us-ascii?Q?4vYSkl6egfFLrfHL4iUdDTpRmp1X4Gb0HCB/jL5nxsJfxlY9VrO6VCQC9fnx?=
 =?us-ascii?Q?LB4wTuaQuWBwkV6MElkk1VlJdnkF9JiOx1yoEabLZpuiNyoBcNUlh4r6mUZO?=
 =?us-ascii?Q?+5ZkIBtuiO+F/I68ihGWDk7tFryrMKmpWrqcYV0VoZKQOq+a21LkdKXbNfYK?=
 =?us-ascii?Q?ucX6xSStOkclaFvrT3MA1wMywtQzITNQP8Jb0Ea/cWMVcGTtoURcspaJ4+rV?=
 =?us-ascii?Q?S1lsFPYR2yS90wt7r/mitMCTk/RceAX6xTY8X20L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea9326d-2641-449f-3868-08db980a69df
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 12:24:29.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUL7FixR4q9oOP62KXKEjGAU1mpvBis6fc7/JjXCvJ6AlTmhpeu0JxA1F3v4Lk+p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214

On Tue, Aug 08, 2023 at 06:31:47PM +0800, Chen-Yu Tsai wrote:
> INFO: task kworker/u18:1:67 blocked for more than 122 seconds.
>       Not tainted 6.5.0-rc5-next-20230808-08004-g396bbe23dbf4 #859
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u18:1   state:D stack:0     pid:67    ppid:2      flags:0x00000008
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
>  __switch_to+0x138/0x1e8
>  __schedule+0x728/0x1388
>  schedule+0xa8/0x170
>  schedule_preempt_disabled+0x44/0x80
>  __mutex_lock+0x3fc/0x598
>  mutex_lock_nested+0x2c/0x40
>  __iommu_probe_device+0xb8/0x6e0
>  probe_iommu_group+0x18/0x38
>  bus_for_each_dev+0xe4/0x168
>  bus_iommu_probe+0x8c/0x240
>  iommu_device_register+0x120/0x1b0
>  mtk_iommu_probe+0x494/0x7a0
>  platform_probe+0x94/0x100
>  really_probe+0x1e4/0x3e8
>  __driver_probe_device+0xc0/0x1a0
>  driver_probe_device+0x110/0x1f0
>  __device_attach_driver+0xf0/0x1b0
>  bus_for_each_drv+0xf0/0x170
>  __device_attach+0x120/0x240
>  device_initial_probe+0x1c/0x30
>  bus_probe_device+0xdc/0xe8
>  deferred_probe_work_func+0xf0/0x140
>  process_one_work+0x3b0/0x910
>  worker_thread+0x33c/0x610
>  kthread+0x1dc/0x1f0
>  ret_from_fork+0x10/0x20

Oh weird, I wonder why this didn't show up on my testing? It is trying
to probe the iommu device itself against the iommu and deadlocks on
the device_lock (which is held during probe):

> process_one_work+0x2c4/0x910
>  #2: ffffff80c14090f8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8c/0x240
>  #3: ffffff80c14090f8 (&dev->mutex){....}-{3:3}, at:

I suppose the easy fix is to just exclude the iommu driver from
probing, it doesn't have an iommu usually anyhow.

Does this work for you?

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7dbbcffac21930..faa0e3520f66b0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -273,7 +273,7 @@ int iommu_device_register(struct iommu_device *iommu,
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++) {
 		iommu_buses[i]->iommu_ops = ops;
-		err = bus_iommu_probe(iommu_buses[i]);
+		err = bus_iommu_probe(iommu_buses[i], iommu);
 	}
 	if (err)
 		iommu_device_unregister(iommu);
@@ -1784,12 +1784,21 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
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
 	int ret;
 
-	ret = __iommu_probe_device(dev, group_list);
+	/* We never probe the iommu device itself */
+	if (args->iommu && args->iommu->dev == dev)
+		return 0;
+
+	ret = __iommu_probe_device(dev, args->group_list);
 	if (ret == -ENODEV)
 		ret = 0;
 
@@ -1858,13 +1867,16 @@ static void iommu_group_do_probe_finalize(struct device *dev)
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
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 97c45f50bf4332..e8ab7cb832ba37 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1234,6 +1234,9 @@ static int omap_iommu_probe(struct platform_device *pdev)
 		if (err)
 			goto out_sysfs;
 		obj->has_iommu_driver = true;
+	} else {
+		/* Re-probe bus to probe device attached to this IOMMU */
+		bus_iommu_probe(&platform_bus_type, NULL);
 	}
 
 	pm_runtime_enable(obj->dev);
@@ -1242,9 +1245,6 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 
-	/* Re-probe bus to probe device attached to this IOMMU */
-	bus_iommu_probe(&platform_bus_type);
-
 	return 0;
 
 out_sysfs:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f1e18e81fca78b..8e10225e0d611a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -465,7 +465,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
-extern int bus_iommu_probe(const struct bus_type *bus);
+extern int bus_iommu_probe(const struct bus_type *bus,
+			   struct iommu_device *iommu);
 extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
