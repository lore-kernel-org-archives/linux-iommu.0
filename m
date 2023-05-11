Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624E645;
	Thu, 11 May 2023 04:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItfTPV7eTghbF17mB2a0pmnpl3AmNciZ2Zd6GPoTs81Y3fWFSDQgLBj+xzITPEkWE7wbONMj8HRHhgBw0uUlQsP6FRPm/qNs8rjLP85VnQbRu3D/c5q9JDnbDJWcO2S45PtnKrTP4pXAhVjYkmQTySq+pP91LMPyMYF6XypuV9bmNZu0FK3W8iPCwBQDG34rTgY9FWD3IuHmCIGS7yT+rKEsplRgXpaOIYZRm3pGdRhqH3U9Ag0t/9HwUXHU6FIWr+GaDUv0aSVXXExa6B2kktpqf67nGwXX6jBzGpD3F9x1E5buEskU4oAWrEYin5+Tvs2w234rCO0BaN5WgdSNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkRUWPEPLlqzwdhIXN+tisdjpsd+OHct9BVkdI1HsbM=;
 b=nn6ftpurzs9Ni+fcNGHvUA0ZnEbCJD7hWsXbGQh8SlO9TxnOCEDdbsWxwk3DdUMF7SpXlVmV+jJnyGa7Odz0CpRrWN0dWTv6O7EH2tUUWNTMhaOQAlf43CbQNvn/DLugxnzzp77q9ukKTh9mX5J7BJBQKGoc0c8s0aysDlXZbgKtswTAarjqoiLGnGfSUUohUb0LtoKQ3WgBtFgh36yZicNgwF8qcMPULtJx4YPQHJw9PwWZwgRy9WP3IVPvq+j3YOHJG1R5gfqcSFJbazDISBa72pJh7F3/H5DgNUJnyeYmg/NCWxxbKKsSivuhDALoy738mbHYqhRvaaaiPvbpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkRUWPEPLlqzwdhIXN+tisdjpsd+OHct9BVkdI1HsbM=;
 b=o+ZWinmTXWNT7kVYef4yMP4sFBrjd9rMZfQZUCteU9FY3fPsI7PAXIvUdKj0PaQt4JHWy9S0tIaQgH3Xjb982VH86u2r94dO2/EMxVwkzMrIV9EEXZJ4Hg5z+38W0JKDGbIWJxgQ2cxyzx6MjwWVuaeck3S7foHMIZZrLEl46sTlMGKOPJJeLMNMoNY1XYMNJPg/Q7eMJsfiY1QIhkAs2vHT6UeHUDhNyEaivaWzn3V0HcbejOZtAZL6OJ3LSROqfe5vF/meWDgrSVAGay9ET/oehV1Cf25fXCpYjZj6OHDA5cLKyWD0FrvOIsD2l/y3JZUKWmXDZTkIQV+2VY9ahQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 04:42:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 07/17] iommu: Remove iommu_group_do_dma_first_attach() from iommu_group_add_device()
Date: Thu, 11 May 2023 01:42:05 -0300
Message-Id: <7-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7858c5-b7e0-4610-7cf8-08db51da198d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mC8+4BnZh2bfV/zxNzUb/SJnwMnCY6Un6+l8o4atgPdEbu8+wdKV9QZ8CaPCWZ3qL7BiQ28x4baLC/cv3i96ySV8Ql6lvcZzj2OXtCS8J77R0q3qr50Bsv0iNISj3myxSMdmRiNeL6nln4cJ1jgBHiCrn6cDLIdfiHjW7vPzEbH1XpWnNua52j2O4BIWL4fG4tqenjjnRVjE/TZSGZLlDlCw4XQ455qvvWYP5U+7CMbhx0m/rL/vOdfZBxtnDp/fNKM9lmrsXgQF+mOQs8t3zVAwJZCb3lMprsIIZeMUn8Jh44wyVd9cF+L5FX7+DW8czPtsc5Cw7AYXkjPz8HFxlgCVgN/BhamFhsomvRrdB73NhBvkoP3XYoR96Uy0Ap6zTpcU2ab8ArLjGaSkFSeBhiuU45dZ5r1gXtY9wgIo5EpMO8xfTc/pZGTCfx1nurlZAaEd/JyJH3KHgFrCI8wdyj7I4TIrrE3WHQ8Hk+0Ub+8vZWZpZ41Mv6HPt8YPEsRoCTNs6WhROthqt+qwq8EOHU3+dFKRzuUZBfebaYHur0GJl8MuvvQcJ+v+vFhDKkYZTymLxMnYkWPzgTV9S79uIfSAMAukQ2KT9gy5W5EwGBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(7416002)(38100700002)(8936002)(66556008)(66476007)(66946007)(83380400001)(2906002)(478600001)(110136005)(54906003)(316002)(6666004)(8676002)(6486002)(5660300002)(41300700001)(4326008)(86362001)(6512007)(186003)(6506007)(26005)(2616005)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H8MHFtxJRxrtACME7069oSArHOhHx2YFcmPN8Zh/i8J3t0JCJtYnHw6m22EB?=
 =?us-ascii?Q?QiViNlrcdKO3AcypHDogRpxvTzaWOjWSgZ7cbBdaYLjsFUUeg1EN0BKR1VZF?=
 =?us-ascii?Q?2kQq066Y2C5vYVeTgSPKV5kody8qJu5O3NdT1vr+7XOVaDXIEyP0hETtLakP?=
 =?us-ascii?Q?UnKH36hlto2c8IoLU3T43A6oHDo3tPjuy7CfwVRISXsMUlJNQKpkdv6Qloqm?=
 =?us-ascii?Q?Q0eFULXq3PXf8GGgiqjkPEgukexTG4EcxxEiMQSC66H667rfKCNA2I1G4VEg?=
 =?us-ascii?Q?z1jApiT9n3YsSVR7MCogkoFE7rGBjC6fGqb7HCk6YmCdvDMPteAyKbwjE8uG?=
 =?us-ascii?Q?oRe2qaXjEWYeuq4z3zHWY0WwARpOPDhYU7QUe8BKeIb6vysfn9/0XvGnBDqv?=
 =?us-ascii?Q?HibFmZooOeLM6kyi2bJANaL749UHDpgHfklCSP8BZDvcioyh3m075wx+HCAK?=
 =?us-ascii?Q?cFNsrWVHpxTccHEBjcXfrLd0fpkvEPz5HUJyqClz2iKVq4MkUjGJUxODeiRb?=
 =?us-ascii?Q?6Zf+tClJGhZTUbjp/wsE2jPisI3+47TVcakZxP8XhfN+xv+ENInffpKmf7YK?=
 =?us-ascii?Q?4V6swKFAw9zdpaCEzY+Y3j6BN1JaBx+GnlNgPHtk8I80GXB6lrQJvNo43UYy?=
 =?us-ascii?Q?v/gj98Kn5c20BjblshTWUKhiEdvzPFpZiTNB1qjqkteaNHXE2VQTgqja/Jww?=
 =?us-ascii?Q?LP8iMo8a9r9YVeNdpatoIWBhh3XoBXrJcrCk/WuTFeIlzCqBwYKTik9PeVKy?=
 =?us-ascii?Q?iddHXVC80XxwYPws6F7OkQOxZavjN3bp/gyZKqjC1qZ7YiDDErxKpJT/MatX?=
 =?us-ascii?Q?7eJo5+6Rr35J4hZLoW7QcYi0Q+8dqbcQX1fBwHB5dr5CY2VDs+MY/imBmoYJ?=
 =?us-ascii?Q?c58HyykV20wf8b8+HCBfI7qqlc//SpX5XKUTvhSTtADRgZqN9i2J4IlituC1?=
 =?us-ascii?Q?lh+NIxQFkEI0OjjbHvGF+fI/PQH+Y87frSW8IhZLc8F4IrDvuz/4aGNOH4KO?=
 =?us-ascii?Q?mUxfozaIboP8IO4UHiRzce7tRCXTp5uuB1itfdcnbleahT95iRPM6qiibFit?=
 =?us-ascii?Q?p8j4uWuQSZ7lt+2tOR84Hol0BCgSVJ96tEWvp6vsMfVs1wq46eX278B+g0n/?=
 =?us-ascii?Q?ANRZUmAVtOJwdA7RqWFo8T/fqXhJbegiv/ZxLyvfL55pozs1Ey27+H+XBMFU?=
 =?us-ascii?Q?MkgfxGKPNrk6xNaIg8pvcsFtYrYONMVahlodYQ9nWl4CfB9qE/eJOgd445rg?=
 =?us-ascii?Q?lIvaPD6cCRLicaQLH+ODsbF97DzDdOJviVBp4Bw2UrKctnuBU8HT+8e+Bc36?=
 =?us-ascii?Q?Bgkya5Z4HHB2s0P4/5vmuorsvpIxCsFBoIVqstq6KQTR6j0tDiB30LuS5ifW?=
 =?us-ascii?Q?B4dte1sYXhUjSBfv0i7OU1uH3cFyk7fhb+EjLJEj5lJgnYP+U2Ew1IXrDq8l?=
 =?us-ascii?Q?SIlutHk4Ai+Jn96/qI8hZ+0sUT0jiTjJUUQE+LrcqMju40F0E5S1/CaV5s6v?=
 =?us-ascii?Q?okKi9Lgfto8eNUvY8iFjv5z+FkZ+HWHkDxasdFG56ReR41mIZqdrHtzFfwSG?=
 =?us-ascii?Q?XFAqaLUVDHB8ekJkF0bVMnRHWaQGFl9b4mVhz+n3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7858c5-b7e0-4610-7cf8-08db51da198d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:17.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2z4qhdGS/obDnlgegbbJhVVqJ4WxMkt8A++4AfbJY4JL6r2oaGqjIT2RySi66iZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

This function is only used to construct the groups, it should not be
operating the iommu driver.

External callers in VFIO and POWER do not have any iommu drivers on the
devices so group->domain will be NULL.

The only internal caller is from iommu_probe_device() which already calls
iommu_group_do_dma_first_attach(), meaning we are calling it twice in the
only case it matters.

Since iommu_probe_device() is the logical place to sort out the group's
domain, remove the call from iommu_group_add_device().

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 44b74850f7f442..5ca23efd2e048c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1080,25 +1080,13 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain)
-		ret = iommu_group_do_dma_first_attach(dev, group->domain);
 	mutex_unlock(&group->mutex);
-	if (ret)
-		goto err_put_group;
-
 	trace_add_device_to_group(group->id, dev);
 
 	dev_info(dev, "Adding to iommu group %d\n", group->id);
 
 	return 0;
 
-err_put_group:
-	mutex_lock(&group->mutex);
-	list_del(&device->list);
-	mutex_unlock(&group->mutex);
-	dev->iommu_group = NULL;
-	kobject_put(group->devices_kobj);
-	sysfs_remove_link(group->devices_kobj, device->name);
 err_free_name:
 	kfree(device->name);
 err_remove_link:
-- 
2.40.1

