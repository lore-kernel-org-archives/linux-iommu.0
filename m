Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29F1FAB;
	Thu, 30 Nov 2023 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cPrhKv/O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I928mHecfhzG4Hi/lka9fgo3gwZrElCaa6JVXKLV2t3s9Xr6QXAO2nZZZi2oaxCpvqqPlmEH7fHKr+anqwEWz+8zTnhgiPaBF8CPCi8ay0nK38zVprHEz20XbXV0X169FVWqHUzmLj34m45jEzVqpDUv8xdKDY4jIGjHh9RthJ+7nr9TdkV8YWm+eEH60sXGNCo2+gEe/er+twEG3UUiOEPP6dLXJZok/lHXGHjG3M+nbP8x5eknTurryTqGnobFuCntQTqTkCn46yiQ4e9I0nGrGqqAtiM3N4mxdV1v2ttWIKFLCuV4izHA+5LnkH+POLpM5p4cHd+CDhOnigAMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXP8tNimHbY+P2znJMc85H2A6muYmbWuFS7YeFp+CTM=;
 b=CUjmJxOMkRa4QGqk2+iRjzbLUvO72dJvWGxX45buB9HKWQ6ghPZS+ndO64UoIPHmX4sFLa1rB4GXjvsMl2DzKkiJ4to49SZ1zGT73P3bLDXSfEgY0RTR7heFE/3YbJ0GhJGKf3TzMiphFJd0QUzAWgAmtn+DH5mgoR+xp1FnK7iDaHgSchkGuEtIh5/g3p/0F5egDD/YNfDA+fZ6qfG7cEq8m2v8B2QZicxDZZhdZ7UjV4WrMlhceQQT+Wv2LCz9z3mDyHs+TEt9Vt94wh0hjkI+QKfsV4M8fG9zYOTRiJLDfaIAdiJywOXun/r02vWkxmY0FbjuBPr4el4Wrtks6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXP8tNimHbY+P2znJMc85H2A6muYmbWuFS7YeFp+CTM=;
 b=cPrhKv/OHtaRC8frIrC/dm8ZQaKccn4M/+wphaI51DSZg91I3MfVLtkTMRISPGb2nQH1nrvGp1f1CpJsCJv8mWWV/p27BghnCe3TBAfPxjn/9Ham6m6dk6CYQ8g8hRoGmlOZ0trZ51fLJchT6tW6bhn8qdAqmv0pEsuafF4OtbsGrI8Ho1mpQgt6g2yHSmlNK/pLw4PdD9itwyBZUFH6D7Is7+A+q/RIAXt+lyIV+V02qrJ9Ezn7ktomL2CHc7x0xJrKs0YQ6HVLl6h/Z6bXmEwTUMymMnWAh/1da4/KiOz/DGdifSe15JM46sHERf7jDKsSDrfnol4CIBV64i0iLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:14:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:40 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 28/30] iommu: Call all drivers if there is no fwspec
Date: Wed, 29 Nov 2023 21:14:28 -0400
Message-ID: <28-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:806:20::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dedfe5b-115a-4f10-a1e4-08dbf141b671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FLlK2KAHdNt+wfbySNaiOVhbYD976VGpbNnZ7jr3T0uwcDHzRvibTtugFTBIFxNO9DdX4bGDrUjfAZwNEFk1hEIAXXQy7kP72QBp6JKIZNHpwcgemtVaE0Vf4pMqtWosdSKUCT+uu1TqKv0f3oeAxA1dNPhxHUH/HTYthd5RIesZgnPv3rouUtkGlpP+v49/utkyNnj2ELiaSMXUs3CEhTOjTEeKCzz6B4zqytcCARy6HJYlW2gIdxBS8sPDKjW/wT2J7vvRw0zxkRVZPz2mlwoEqTlcRGLRMNxqk+QzO06mkS1bnktjjjRYex1FOR0je4fDyEKMiB+EeFBEy/yESNXopUJdhYMq5T90T7SN71iQtxkuA29lXJUrC/g7uH13I3xrb8mQaJGkXMO0AR7R0nbvglrKh3uZW4Vr56MFDk+T4njNZAxTVvaexfDe3gq8bVaiJMTJAOnPAQFp4ZVXhTZNDemNds+efeCct95tqAQGZ1nut+VDbAQIgvKV+WNdlMSlaHWe+9ECIx/ZNrwygrrMVu0RWnBGbmwq8/qRi2+K+Dip4rQqBKzXRmKrhZfnAUsxaagD2DbOd6gpM2311bJt3e8kupRh326f3uG6lOA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HWX2QVjgqBhwNeavLJ0Yy6xTp79nb5uS1VaNLEHDzi0yKqkl18yk9VjY2UKR?=
 =?us-ascii?Q?FncKSsvI35vaQJ9rrALu5uWjg7p+DafwWxfC+6SS9jQMuzYCWNumQGRSDw/M?=
 =?us-ascii?Q?df1pwBY+fkEOiZsdWfN4C0Jz+WI+gHn9GSvwL0/mutZ7VVtpEdnNBZUG34Jd?=
 =?us-ascii?Q?hOx7jSB8wXD/YjyU/lje/aidieHHXLvVbwUzJkRG1GImwdesAjG3HFGfpC4/?=
 =?us-ascii?Q?gYs5RJ+R13Jjc5fm6643eGqSqIMh6OQzlbRPRGLEsDiTnJKAIiOwC2xjGS7q?=
 =?us-ascii?Q?EiObUoo3FVqs4KN3GBg6dc0YCiOJHVIXHYUX2wLwH4q5vsi4a8usu09luhG/?=
 =?us-ascii?Q?e+Vs4JPsaeWjzvEd2B4LlhLLbwKZGijDFXFXDMil24xoJoaDFD2GMSnlMOIX?=
 =?us-ascii?Q?nEEK3cd+kXpfdo2zvjldkoufeJxMB1/Re884rWQk8E2MoyhP0Llp3N+jqyr+?=
 =?us-ascii?Q?AjRRP0NZHmjq6HIYbzyLQCFW2FGtPmm5fWA+ls+8jlLypnBJItVa8KqC0r+z?=
 =?us-ascii?Q?o69km4oDIt7AUfW2LmVrkgmIwYIlQkmJf4ChOrDpxBtxvSPFed9LyqbVIPYT?=
 =?us-ascii?Q?a4SyuZ+rWH47WFwxp1Z7GbmrWsziyP8oSlx/ab7T6p030we3dW83El2tnC23?=
 =?us-ascii?Q?PP7XzdoCMYzlOlqNw4aSBwfgGkJsoNj5UsLS5C3X6MXso92ciy4/vHYK48hc?=
 =?us-ascii?Q?zFZG9/TYhRFTOIOe+kSpFBmDvRpej63z2ok5r0MLPsQia2LnD9nbF1hnaDtb?=
 =?us-ascii?Q?G8rGMWNRlPdHwTLTX7FWAgdZp36Z3EIHHVuvtPu7w5Oy49NcvzE28Wn0Ab84?=
 =?us-ascii?Q?MEgVSmoGKNrgACcM4dMa/CmPftDHoePCWFVc/lsZQX4Qsp0VOmdP3twoZ3C6?=
 =?us-ascii?Q?VzjnNy1kdmbGaWm4u+Dsa5Wgb20eLBH6TB/CJnCgb6nJEwWcMXcztZQ06ojU?=
 =?us-ascii?Q?1t3C0YPHDFVQDLw8UC+AFW0zHmHFQN1FIMN4hqMJ+4kZaQXl97u+dSwMOcUA?=
 =?us-ascii?Q?51WFkg297+8tBhowraoLz5eUV/ZiG3txSIoJ9jtytznd9KfgmKhz43sfCjtQ?=
 =?us-ascii?Q?qNfAc3YMTnB1Wk6fpU+0Yu+zj7uB1dSsNecUaftqs7WB+gVkk7XhBFwfXAcW?=
 =?us-ascii?Q?WV+Jogh7knDlw6RqFy2uH9E2Ecppw9GPT/LhAwXZofiltpu10Ju6msEwLJWo?=
 =?us-ascii?Q?LDPWqNI26DROzB6UPe1Cl1IsVPo1c2IqbEVi9bFHS1uzsaUJ+p3FomDkwaes?=
 =?us-ascii?Q?RLArGJ+T7S5AiM4R4QzN21KZGIBkarCmC8eQ9s9mtob8ICqbTGr1Rfh2Gxn7?=
 =?us-ascii?Q?Z/flGFufKT18RysDkYvqTrFExKO4WRfOWEcpdkLV71bQtSZixdCL+tD492X9?=
 =?us-ascii?Q?j40yvBZdpuoi5Eks9Q+N4VjxNNnyR2rxpsEDrgjgI0F3FZ08VSxObmG2WpIf?=
 =?us-ascii?Q?CbdAdMB1O+Vt9XSXTd7a54RE4aydzdjJC1OouDAy2RMA7glW7FO1WVFL3otr?=
 =?us-ascii?Q?+bdez50qGJhohmvaTjBKLDJp61UbQFj/b3huLe+4dco9rUkG9kCNYBedVAUC?=
 =?us-ascii?Q?vsf+KCLPrz/PlPAX2mJ637xlOPEGpC42SzEoSYNh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dedfe5b-115a-4f10-a1e4-08dbf141b671
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mu7rMYgrmzcZUUEbT0aqFU0MimOdrSrSjiV9gmYbububMi+aExqTmqEgzPFuHXBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

Now all the iommu drivers can self probe by checking the struct device to
see if it has an appropriate FW attached to it. We don't need the concept
of "global" drivers with a NULL fwspec, just invoke all the ops.

Real systems only have one ops, so this effectively invokes the single op
in the system to probe each device. If there are multiple ops we invoke
each one once, and drivers that don't understand the struct device should
return -ENODEV.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 59 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7468a64778931b..54e3f14429b3b4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -241,6 +241,26 @@ static int remove_iommu_group(struct device *dev, void *data)
 	return 0;
 }
 
+static void iommu_device_add(struct iommu_device *iommu)
+{
+	struct iommu_device *cur;
+
+	/*
+	 * Keep the iommu_device_list grouped by ops so that
+	 * iommu_find_init_device() works efficiently.
+	 */
+	mutex_lock(&iommu_probe_device_lock);
+	list_for_each_entry(cur, &iommu_device_list, list) {
+		if (cur->ops == iommu->ops) {
+			list_add(&iommu->list, &cur->list);
+			goto out;
+		}
+	}
+	list_add(&iommu->list, &iommu_device_list);
+out:
+	mutex_unlock(&iommu_probe_device_lock);
+}
+
 /**
  * iommu_device_register() - Register an IOMMU hardware instance
  * @iommu: IOMMU handle for the instance
@@ -262,9 +282,7 @@ int iommu_device_register(struct iommu_device *iommu,
 	if (hwdev)
 		iommu->fwnode = dev_fwnode(hwdev);
 
-	mutex_lock(&iommu_probe_device_lock);
-	list_add_tail(&iommu->list, &iommu_device_list);
-	mutex_unlock(&iommu_probe_device_lock);
+	iommu_device_add(iommu);
 
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++)
 		err = bus_iommu_probe(iommu_buses[i]);
@@ -502,6 +520,29 @@ static void iommu_deinit_device(struct device *dev)
 
 DEFINE_MUTEX(iommu_probe_device_lock);
 
+static int iommu_find_init_device(struct iommu_probe_info *pinf)
+{
+	const struct iommu_ops *ops = NULL;
+	struct iommu_device *iommu;
+	int ret;
+
+	lockdep_assert_held(&iommu_probe_device_lock);
+
+	/*
+	 * Each unique ops gets a chance to claim the device, -ENODEV means the
+	 * driver does not support the device.
+	 */
+	list_for_each_entry(iommu, &iommu_device_list, list) {
+		if (iommu->ops != ops) {
+			ops = iommu->ops;
+			ret = iommu_init_device(pinf, iommu->ops);
+			if (ret != -ENODEV)
+				return ret;
+		}
+	}
+	return -ENODEV;
+}
+
 static int __iommu_probe_device(struct iommu_probe_info *pinf)
 {
 	struct device *dev = pinf->dev;
@@ -524,13 +565,6 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 		ops = fwspec->ops;
 		if (!ops)
 			return -ENODEV;
-	} else {
-		struct iommu_device *iommu;
-
-		iommu = iommu_device_from_fwnode(NULL);
-		if (!iommu)
-			return -ENODEV;
-		ops = iommu->ops;
 	}
 
 	/*
@@ -546,7 +580,10 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 	if (dev->iommu_group)
 		return 0;
 
-	ret = iommu_init_device(pinf, ops);
+	if (ops)
+		ret = iommu_init_device(pinf, ops);
+	else
+		ret = iommu_find_init_device(pinf);
 	if (ret)
 		return ret;
 
-- 
2.42.0

