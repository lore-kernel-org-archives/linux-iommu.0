Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBAE4EA;
	Wed, 29 Mar 2023 23:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFXZJpWulUfCE1pO4CGR5v+qg+iEPy6J3mW/wu6BwD/kW/wD+HED2SbRCQ8qJbdRjKbf+qCwwg5pmE4EcSN28+mdtCx8WFHwWaYF+vCDo5n499deYqtuEnfDYZImpBd6e0EMAmJ3bt96qrTekH2kkRVDDO1Kac2gMJ7i580dq0c5pAeg/mep5ev5adBLeeyqnXYMNVQ5udOUrs9vm1gXtBPb1jSsPv2D4EM09XjLWxC4LwCtuI7bhcVwwVyGo/tHPgA7rWAb5E7oZ3D7SIJvc/bYPctEajY92cwXiPgv4jdxZK0Qm5PBMA4aKnkhitLrSux3egSdxdrfdVdiyQtR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9BKnlImouEpVTEwvjtFSmEwaf35prrCzYX8NDTzBpg=;
 b=MIdJ+jaVfliWLokblBhGdIK7znxX7+E/rzTQ32+l+wJl1BMzThpcG7GpGnbZZKTOb7KRKQRAlbSovyC1Tfr5+v7sZ0+2Gmwsf5sgMWIcNN0bcYU3kcvh33CwPuSIKu7t5erP91YFBX9OyyLAK/R7L0Z3D4gx2m4iwgiRf1zVfvS9QJcCM16fI+8sQhh9/L/5nQeC4DBFXLjImjRyCOK/TVsqd6Lh+Cv3coWYaTh7e68uBE+YaRuB630ztYDC/ENOAdaHQinPa0i0nJV6FkmCJU3JkXqna8FRiOUntZF8nbAJZE/d+XYek1yVRfAHITyLGdce8d3npCQi6Vczjv3d6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9BKnlImouEpVTEwvjtFSmEwaf35prrCzYX8NDTzBpg=;
 b=Fg+Qm4FAXcWHzQOiFE8uC+/vxSddo/Lqyhoe8PAieoreJx9332bcK45utxceF2kzn63u7uiuZy2/73tjnmBX+9l9y2d/yrNGGJ3ojyV4/JlmgA0eJdX9QDuJm/aORBHetocrQQOsJhZkzWNi4hDGZ+MN6ZY6N329NK7JA0vo5HxZdR5eg8q/xiqSQBstBM4R8ICY3HH/sCTydYPFE38f8Ms8Wdo3ed5NibGE6rjhNcmgHj/68h1gMCcj/qSnqSA+DGVmJpPAczQ4gm+2TEosL9sxZQQdn5tIX/89iAHFtCEPFtBlQgW/v8F2NInr4WPPxJ5s8BZ5lg27jv+eah45iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:40 +0000
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
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 04/14] iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
Date: Wed, 29 Mar 2023 20:40:28 -0300
Message-Id: <4-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:208:2be::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ac8e24-8ae4-48e8-f1d7-08db30af0090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6mCIpV4cUNK5Y8rMq8kStmrWEp5aagXc/J+Mss3wiitQCNd5Z/35lhNdpWPFYARcYcVFvqgETnliXXopK1vax42JOlG/sk6siCw9yjNYw8F0KyPa9+o7IMjqoot6UZJuz7BupDDx5FbiSwmdUxCLVBnMhDnc5rmrMP8ceS4KEqUtD//Ambrv9SeVUVKQ9nd7yEJ4qMOqarUPRU8r8NwGvKT2/r+LRHxcJzUqktornA/FD4SRiWC3IRf7G0uVan1Ovje3q2GidI6EGy5TeN7g44Q4MHHLWWtWBdsqOAng1p7cVN7iZuF1FnEeEJi3WxtrYpvX4LRlBo55IA7yDH0IQXyLm/y1qxL/cMvYF+Pqxj59eJB7aLwzMgiXLp2N6sUPhYkGNeXGUKHsTMPpSSKc4e42REpBMIzkl8B1rgunQfcwv4sdueycMmRSDwCThamMFrSFH450ntSd1PBy12vu4wSaSuTX4QpE+BDC7Q8E2WQQe1TmFcGLp9bRfimYFUMiRwr3pdSr9KtcEJRFu9y31MurgSFHatKPBfgKx8DCF4ohUwmJHGwLjvIn3OUFDr1QWmT0VSL8DdY7dkVPbQbLUTFuRtnrbF99QKICm/IHVmI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66899021)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WIEzhHRRYg0/YCIkLl0K1EYNvFv8FWuDW2BMbo7dhSKvFJYAMu35zmAL7R8K?=
 =?us-ascii?Q?nrAcU1nYKFH6OduDmTDDvmU5bjlnL4QSA6gurIzBDqznxjQfKa+nzgasSzYn?=
 =?us-ascii?Q?MoYiSXWahbMLxvZFwzfz+fruaJIYzBmILVgd3beNPhxD1f8Z+QUDzwNmTVq7?=
 =?us-ascii?Q?9El6oA9URGYQ+foOXVDuez3hEyNjQNko1WrvaGtHLKJBHhHlvRYz0hTZ3JD3?=
 =?us-ascii?Q?O1pPkAhovn0w6ySBQpCK1LDzshQbPmKZyf7lk6IdQgFiYGyrAE7J09KHtrIL?=
 =?us-ascii?Q?LkTmAIeGhYo+uV8en+OH/swl9otcV+B4xg3+UdkcPJ1dk8pRuQZbZuL+je1T?=
 =?us-ascii?Q?QtsRczVz0BC0smmcYfdp2COb6fM/C4xqwBEcVo8hzkoKDozp2FQ2bcvAmdLI?=
 =?us-ascii?Q?8TiWh55vjahuZjgNgeu1QrrjjCBMyZqhlQ+NKQLJ1/CMEObFbfFf42aRj3Lz?=
 =?us-ascii?Q?Lbsf2TrTpjNdwEFsjgF4yFkYMiYV9VTa2fKZf2/ZHq2YmwhXZqRb4u+6VEgD?=
 =?us-ascii?Q?4zg1TPLWACA8Z/ZwcT7Xt2FXPlihh5H7opspGDXY46gM1y8jbJ6cdREWMQIp?=
 =?us-ascii?Q?VitvcWohTFZX9I0XYIrYLYlP/WTfXPa+Od9Rh76nsDc5hu43d2h9hKoxpTih?=
 =?us-ascii?Q?YYWEtIIVfbBHiZTe36l7wDphFTuY+SXS8q5nb8Tt4ZsC1xGo/ApDf8Bffm2t?=
 =?us-ascii?Q?NKxkh5WjCwtgFrImkiWdKNzvtBRAU+uUyOT5NSgwXuNYJF/wWGPMZsk90ikE?=
 =?us-ascii?Q?KkoSagwpPY3ohHlrg2bMDPuSJwRwqBAf7NBtJlWZR/VMjfEJBdvW/YiEeFPk?=
 =?us-ascii?Q?ysIi7Kee3moF4TIQLQX44ahM1GNaNXidFoBh2A4GZXIYhOlNfKt83BjLdx7E?=
 =?us-ascii?Q?3iVC9BQnx07/ZlguYLhd5Wg53PBAbHNe18Kf8Ex16bFEs/Yi767/oi2ADpZG?=
 =?us-ascii?Q?dZ+sSaJVXUmbuMi6z5EufBdKGTLI5m2S6Ihs9ISBvAZePzqqqxcewsbYmgy6?=
 =?us-ascii?Q?aR0DqaPYV5M+9hq6sd4A2DjriVfO0Nz9qVMVzl8wMhwRC2TraRDLKr2bWyKD?=
 =?us-ascii?Q?u8qYSnP3WjAfay+XyMgFc6Z43h9WjV8pUAZlNL1Kb8/Tdcxyu3dhLZJ3SFfI?=
 =?us-ascii?Q?GkVLWw46bRBXd7tPbZXp5VjJQY8zJVKc0EBdmA4ulrsf2Y/rheyGRQ6ZYXOe?=
 =?us-ascii?Q?01rimmYQFv8gEZjkVsmsfQTYSp8APBoKtfk599pEhWso1IMCpWxMZLE+J6V9?=
 =?us-ascii?Q?jJywPwbtoV18eWa/pzthN9c+oVR71Ww4Lf67DZ9lDoGjd9WB2fnNUhevu3a2?=
 =?us-ascii?Q?T8MWPlRXXoRNiUxR5ZNAwvKJR2W4pWEgrspYviIqaHmz0JFAOQgE2Q5L5kXP?=
 =?us-ascii?Q?gn7tubOtRzopJbMbRh6B5j7QX8HfNEC6FdYzMgxROrn3EXUp9zNwdReKO2JZ?=
 =?us-ascii?Q?MjfB1ga1Z3iqDQtqT8DhxeX6csYtKWvkluZuZ+uZbFPIYO8gBU147dd+PlyX?=
 =?us-ascii?Q?IOaO2oKmbGnx9utKYeWDPYRulxG3lD5TXPBYtvJRISSA4ot+fPfRxBqwLPdD?=
 =?us-ascii?Q?KnqhrmpQxmfBcFhyjB/L3ls3REQ7buHeFXilLtnI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ac8e24-8ae4-48e8-f1d7-08db30af0090
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:39.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDlz9JkoQ7IR6wEogHQyBEFmCJjshJyUfBaUBbbC/B8fKSTnDLp0mSGpNMotD7cz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

The error recovery here matches the recovery inside
__iommu_group_set_domain(), so just use it directly.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 40 +---------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b7cb2a56ebfe8c..ba9e988293f23f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2177,52 +2177,14 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 	return dev->iommu_group->default_domain;
 }
 
-/*
- * IOMMU groups are really the natural working unit of the IOMMU, but
- * the IOMMU API works on domains and devices.  Bridge that gap by
- * iterating over the devices in a group.  Ideally we'd have a single
- * device which represents the requestor ID of the group, but we also
- * allow IOMMU drivers to create policy defined minimum sets, where
- * the physical hardware may be able to distiguish members, but we
- * wish to group them at a higher level (ex. untrusted multi-function
- * PCI devices).  Thus we attach each device.
- */
-static int iommu_group_do_attach_device(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	return __iommu_attach_device(domain, dev);
-}
-
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
-	int ret;
-
 	if (group->domain && group->domain != group->default_domain &&
 	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
-	ret = __iommu_group_for_each_dev(group, domain,
-					 iommu_group_do_attach_device);
-	if (ret == 0) {
-		group->domain = domain;
-	} else {
-		/*
-		 * To recover from the case when certain device within the
-		 * group fails to attach to the new domain, we need force
-		 * attaching all devices back to the old domain. The old
-		 * domain is compatible for all devices in the group,
-		 * hence the iommu driver should always return success.
-		 */
-		struct iommu_domain *old_domain = group->domain;
-
-		group->domain = NULL;
-		WARN(__iommu_group_set_domain(group, old_domain),
-		     "iommu driver failed to attach a compatible domain");
-	}
-
-	return ret;
+	return __iommu_group_set_domain(group, domain);
 }
 
 /**
-- 
2.40.0

