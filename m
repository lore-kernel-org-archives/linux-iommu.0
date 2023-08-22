Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12A1DA4F;
	Tue, 22 Aug 2023 16:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLUSAvEdYsI1aahuk+uiByU0HihX03I9XKlzLCWLJknKEpiHDM+nvbEIVt+PpJbxxPEqirFW1PpztstqqntcFaFYhOTqHB0igycFGxDuupCPCcBlgckBFfBJ4GVWhpTke5vypBbF38CC2bBe91SCv4IB+seV6zDN+QKU2jz4J5yjJ5M4XCsgMKdE59OcUAoYlJzmY9x9po0IHH03CxA2iAmNTCuO3Rb6ZeE8b4CQOcU6Hp020CZ0o2R9x2cybD7DoeROzj4GR1iKDocuLZ7WdvRPbRlCfpK+C8IlLwoEi0Tuvs8R7/MHWxSQTUP7gXR04JOvJXVi659FQgDxccg+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/EiohERC4PV6mQAz7QZADKo/0C4MxnhQ3V5u2NLOno=;
 b=CHpb3zzBqJrOynDu3gsWUaDOASGHuVdb+PeE22IQsUW7uyLr7KZ89LLcPa/Ch+V0p4NLtg1X7vvqaKFC7DvpEl5I1QCjiZqtt1Cr5Y+dZKfUn3KxlLmgGGSWV39rhiCagDoOUM0IMXtiPBdoRNGVFA7DvXndQZaOtpq4giuh1bML02OSb6U73aRT5FL35LYhMd8lzXsBOU67w9I0U5gVTFLPXGb+nU1GgwaFSZ0cEKoqi7WNSklP3EU6/XBRsErDj3f1PVJMQ3o5uLymYpgc3WZvejerc1byVI9Pty6SMQCS3dTcnNyCpBexckifnVhDcnGa9qW85zJQx40UO3o0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/EiohERC4PV6mQAz7QZADKo/0C4MxnhQ3V5u2NLOno=;
 b=I9L4ZHoUk3OTwM0YWpyniB7DEJZUE2s2MTQu+Hypz05oMmbg0rjyFpu+kUuls8DfoDAuZXjUuGootbWa+98GgUKPZNOgK2yi8KDgt/fGYZYYE0qFdERqzh9OtScpZzHNM8v+00pCnZ4Gd5zkCENgeyT11UB98rm/ywvEiXUbzpOw9jAkipKq5ZjYG7+yh360JvUkIHdP2GIJsAWk7o6875jEKL7lJvALvaCmxwMkFJDx3piozxGQEEAO8S1b+T+9gyZYWKSjGipcDMyq85kjsoq+oUxCHqgD3o3JLvPyEdf9ms4QyiShZ9JBjNzzq/CJEOx/Jq2B2/4LmyxJmV1JtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 16:16:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 16:16:05 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/7] iommu: Add generic_single_device_group()
Date: Tue, 22 Aug 2023 13:15:57 -0300
Message-ID: <2-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
In-Reply-To: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:610:53::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f04f2d-77a0-4c09-ac85-08dba32b155e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gda+1Ljnor2ziEY154vx3O3vKxR7hj7MGA+lWCwWxH+XWRn59R8WzDG1JoLjWU8qGJSUsn/1nQ26HRRHwmTtQzMrnHMgG0PoGIhBDxGauFCvvwBk2Y4N3ApXo6ktgWZ8N2KOjgh6SQmWvljfTgBNwpbHp7H55gtYRIVYXvuDPLlnMSidFFgWdxLBFvFig+E3nR16/He+/Eqc6uAF80XX0OAC1dA+tg3+HgIt6kZhUyaUP9oMTiDhG6QXdnWmXrmJkKMr8enIdX8Ax7t5Y5vs9H98UdzVtAdRxmScoqydmLpYNqpKAINLCc7CfgTjLcOOkZAtlT4jaTvBdcUb199BIbwiDdZ5lt4EbtrdjD83eQlK+wL3G9KxL6kRTtjXEnTWRTvYYIiHNcfCVdrQ/EQgFu6/XWV/100FZKBo5pXKbLhKcsintD2QScCbQbZ18Zpra0Y3hqX/8kzUas3Qxul/vBhkV4De/frhwl5I5j7BSesTVq3lifmaqSORZTaCRTqzccqhGSK24Rt4yL2g0DqvSQ7k+cj7zK2m5vbqGi6HfLDJjTBzg+Wan8F33HEQB7X0YYeP9QJhCKFS5Ul0ytZOJXNq/1LtytffBS34DVEGPkOK3GJu1FIvmrfPNs3nt+5+MsoSiho545soD6HP1re6Rg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(451199024)(1800799009)(186009)(2906002)(7416002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(66946007)(6512007)(54906003)(66556008)(66476007)(110136005)(498600001)(921005)(6666004)(36756003)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sukzy1eSpfHy5j5DmZrQnHX0c9R/Qs/pycuvZmGQZ/u+s+djd5zXRTxuSaVf?=
 =?us-ascii?Q?0fF13nwxSBcBXLLCfhrAIjjJT1dI7GrRAhuofEMzKNrQ71G5kVCx6a5oZLm/?=
 =?us-ascii?Q?eTbKm4kBZ8p6npiIm6dVdlvmdGQYlaqmPioONITvFkBLuyVfDxgFv6tmQffU?=
 =?us-ascii?Q?WQeh8lFyp3EfCcSmZbzZTYiz3ENxET3QcJDKzfn+WCxIhYKqoWbflI+Bye4k?=
 =?us-ascii?Q?gkbznibQtjGneJxdLWkdThGb1pmwVU/+ek8oA/ffrUuKp6HfW+w/oPLzKH4F?=
 =?us-ascii?Q?iwR3zoYElffA94dJjDc2uNh033Ox029pKBmrdfLUc7A/8NU9AhG+yMSlK+Gm?=
 =?us-ascii?Q?H47FCHLv5EcVhIim8bykCD01byfTVjwBcCWsg8eZvGjHgvRABO7H0FhmG0rd?=
 =?us-ascii?Q?9YhDJ/wWgaY1GzCWuwEdLz5ZBuMFjM06CfJaHBbkKwk+RQRupymbwjVgzKJ8?=
 =?us-ascii?Q?o6LEZi2VzRtcRkk+49vu2V9ckDwNhWl4PV7xxyPl5cHlLRrrHo/28a5hqfan?=
 =?us-ascii?Q?FkJBpY6FpS5iKD+d36igE8cEHwJVpMNRJ0Rk01HlTgoQjZTsi+LoDkaG5zXk?=
 =?us-ascii?Q?AUSr+iVKotIjg/CQOvZy0ATNVi3OAhPhwVHPd9gxIWyT8gXHqjNJTTA2AmfT?=
 =?us-ascii?Q?logta0rk7Spr8S865xpulkwCP4PA/1VQy0qcEWIp78ZSw3LKhxZzPMWkWQq0?=
 =?us-ascii?Q?o1sAV51u7Y6Ml425y7Un3oIVG6cYM9OFwr+tW5G0P+X1dECxJ8CPENutFs0c?=
 =?us-ascii?Q?k4dMeOLi+UWgZ+3KuxWTc6Vx+CJ7gjBovj7MqPVpjT3cSgtpWJBWCez3jpNS?=
 =?us-ascii?Q?f9JvyzkNrntqy2STU2q4sSGmI5a7ag3dfLN3m+dW2hLsaMK2U5pyg6slb5E+?=
 =?us-ascii?Q?Sl4sHa+aPwUCWuo/dQaDrhFNSqVth7IUIvwRBCOHG3TZ1Ta+NcIrZth0A1Cz?=
 =?us-ascii?Q?24Pxiqiyyj90kTFtfwfaxygwgFFY2sz71/BdqlPm9ZR5ICQn3ZXC76g5Gk6A?=
 =?us-ascii?Q?gEC6oA3GvhBG4smvmwbvC//Q0jU8MFRjY+svtQok5HVPHLPfMi2WQGCMzua3?=
 =?us-ascii?Q?uQV5u4ALrU7E7suTY6z/DSJXTdX/9Np9CGv6S8qbD1ETaehDLWiIlFUaaXnv?=
 =?us-ascii?Q?7nxQGPWHP3zmJL6wcQQuNoRhNrRaBKYkfDmx3DkNqfFafd3iJuz2UH2ah80+?=
 =?us-ascii?Q?AUeKoASiYWVClJMqSOmGJoqT+5cxZ/hL4CjSeDDG3sqXxMcF5yG4F/R012rb?=
 =?us-ascii?Q?r6DS9HIRxuKv8Bnyq8FAI09liHrx2LmR1OUOf8dvtgdKyIryPqkFX1RwL1eY?=
 =?us-ascii?Q?ZM7IkUeNwsIx+JwIQ3TpssJGgsrr9sH9f5GZuo2XVu/ceYdxPodhEFrNlcXy?=
 =?us-ascii?Q?y6v47xJC69/4wVbPk0T2a9COchpRdWfXNq+CqGRseZ7eQFr2jM730fmJKhfj?=
 =?us-ascii?Q?v/ERO40FFXwtvfVhkGN8r55jUzCQtrMngkk8zxXw1r72GdTNr3vnWXB1/O67?=
 =?us-ascii?Q?mOGARaSLA0GY6nlZ0tgbR2VMkcPGfxGoM8qlD5w/HWsjuSKUf9AkZWB7KXjP?=
 =?us-ascii?Q?/Sp1nq2SLIjWzFfp/6x/h9uzPeTXpUE/GmccWWqG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f04f2d-77a0-4c09-ac85-08dba32b155e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:16:04.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bW4Q4gQdCCL5stCpSZitijV2v3SKhIRhN8jKXSEbgpql/uqzJ9fXkqElHcdHApQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831

This implements the common pattern seen in drivers of a single iommu_group
for the entire iommu driver instance. Implement this in core code so the
drivers that want this can select it from their ops.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 28 +++++++++++++++++++++++++++-
 include/linux/iommu.h |  3 +++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 50afc55eaca8e6..3d6bb2537e8d85 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -288,6 +288,10 @@ void iommu_device_unregister(struct iommu_device *iommu)
 	spin_lock(&iommu_device_lock);
 	list_del(&iommu->list);
 	spin_unlock(&iommu_device_lock);
+
+	/* Pairs with the alloc in generic_single_device_group() */
+	iommu_group_put(iommu->singleton_group);
+	iommu->singleton_group = NULL;
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
@@ -360,6 +364,7 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 		ret = PTR_ERR(iommu_dev);
 		goto err_module_put;
 	}
+	dev->iommu->iommu_dev = iommu_dev;
 
 	ret = iommu_device_link(iommu_dev, dev);
 	if (ret)
@@ -374,7 +379,6 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	}
 	dev->iommu_group = group;
 
-	dev->iommu->iommu_dev = iommu_dev;
 	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
 	if (ops->is_attach_deferred)
 		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
@@ -388,6 +392,7 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 err_module_put:
 	module_put(ops->owner);
 err_free:
+	dev->iommu->iommu_dev = NULL;
 	dev_iommu_free(dev);
 	return ret;
 }
@@ -1591,6 +1596,27 @@ struct iommu_group *generic_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(generic_device_group);
 
+/*
+ * Generic device_group call-back function. It just allocates one
+ * iommu-group per iommu driver instance shared by every device
+ * probed by that iommu driver.
+ */
+struct iommu_group *generic_single_device_group(struct device *dev)
+{
+	struct iommu_device *iommu = dev->iommu->iommu_dev;
+
+	if (!iommu->singleton_group) {
+		struct iommu_group *group;
+
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			return group;
+		iommu->singleton_group = group;
+	}
+	return iommu_group_ref_get(iommu->singleton_group);
+}
+EXPORT_SYMBOL_GPL(generic_single_device_group);
+
 /*
  * Use standard PCI bus topology, isolation features, and DMA alias quirks
  * to find or create an IOMMU group for a device.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 389fffc0b3a2df..9ed139bf111f6d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -363,6 +363,7 @@ struct iommu_domain_ops {
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
+ * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  */
 struct iommu_device {
@@ -370,6 +371,7 @@ struct iommu_device {
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
 	struct device *dev;
+	struct iommu_group *singleton_group;
 	u32 max_pasids;
 };
 
@@ -644,6 +646,7 @@ extern struct iommu_group *pci_device_group(struct device *dev);
 extern struct iommu_group *generic_device_group(struct device *dev);
 /* FSL-MC device grouping function */
 struct iommu_group *fsl_mc_device_group(struct device *dev);
+extern struct iommu_group *generic_single_device_group(struct device *dev);
 
 /**
  * struct iommu_fwspec - per-device IOMMU instance data
-- 
2.41.0

