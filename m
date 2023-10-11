Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0774C41209
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E7aLVssJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqzfeozW4lzNaHirot+WpvvqBZfmu15GB8pgDTqgOox86/F2L+YcGjym2CHYK6uMT0lsFp2qon65NNm2xpX1zXJdgSuNYOP0LQVRf0xYmQXf1GS9H50k177h5Qwvc+ij3jpKvsDeh/jr6ODluVIP/hTkSLmiveUft25te9ayhA6QTgwcO32H4USt3fGxP2DXR8jvvOld7R4t6v9H43fvVYQL46oo+/aN9BHPh4eUc2UnSnnOjVhPWlSKDYYvzgA0k/70/+UUc+2ipjdzFdMpBOgIsz+f3cv9Z110LC+/SshctxTp8RBorK4ArDn/yHzJsrIqSba12wq7Yypt480QmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OTcy73sGprPbo9XAQi/olkqBBD+Oo6qYpg3GxhgxW0=;
 b=ARnS6Vzqra8cTrkARRgFS49w115aRvoKS6WqztG7F/Dk/cY83DvyKcFgTiv51yZ9iZYZHNHTAllen/93UhNOJBjopHLRVKDkdZ7b56faq4Kd7TcHT9UNhaQ0RWvFNVHBS2VaVWbbKCaMX78xhObcN3WkEfAN8icB+2lHt41/BKfx5otPGG189qm00YUo1BVZK4FO2zyugxvO23dCL0AfALAHdrPiN2g0DFYqg0aM9w1SsPCeeW+u93u8mgd5rhpXxWYmS0wsmS7IRRzEUvzxdWq1804EzJEmESuVxmwmcEwWuQvmaxvxxj3D6aYFMcYjn+u4sNCm9oON3BwgHmWLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OTcy73sGprPbo9XAQi/olkqBBD+Oo6qYpg3GxhgxW0=;
 b=E7aLVssJywzDhxi4wKsaw1QWqLV3BhO1u1t4zPNLvWc6SO8Kci3VAxMRd6jazDfg/0z+qOzBIWpXFl86gqTELCGukfuhJYueeNIzKfpg/GRY1xLE5K9NwjjT5aKt4M/NqXottaAwAkUNdXVjkm35NBJuv3Sn/kHL4qRcfVX22EDzLQCfZL74+h+QCJX2BKBYonZh24YF6aUwZCV6drgJ6eg6RjvqV+NO2Txf6e0LvparfXty4owU779PK/X+oFuarwywD+Yqszp9vsH6SHd7CSflGCxvE53WCwTJEH3iBZw814BXnfOJbwjGbbSL2925aK5Z+4NU4bMKuytWgI4CCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:10 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 03/27] iommu/arm-smmu-v3: Do not ATC invalidate the entire domain
Date: Wed, 11 Oct 2023 20:25:39 -0300
Message-ID: <3-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:23a::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: d8be3ed7-3bb2-4c8e-0307-08dbcab17091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qziks7Nlqz/hWPlk3IBkDpKU6TwIhQ4gHIIQn4wcMxrAJOqzqe8JMsaf4XtCRph9iunfXFOO5Zt4pFKUbtMxaVQFwkcidSUhNlRkXcj12HliCyyJZq9EyXk7aw9O1n2uIOfi+CZWh0QqP84VHd3INoUMc3MqBCU5FWmJsQspNrwpKxYVwnJzDZ7Qe1Rz/yFNkypAVKbxjBFKyZUsGg1nluue584FNjt6whIalUjKqPDOu/af3jDY77MbnCjdqbRzRYOqlgjtKDBAHob2lqsdlcShkOb6EgsgTzpA9HC+QwofRQ5wAQqI0nqyRpn42LBd6K1yXinyaO9MrpVDhmQbJfFQ05DKOULWAWkDU2eYxipBNe7uGFH4Q1ZTkMZh+97PsP4Kllh0pyy4yanKXyGngy5ZlMiEwQ5H9xREoIlBeyQAmhYA1aE0rPfgSo22SuJEUpAM4twwHT1mkdW/m8esN/on486pWqd6DaxvT6DrptEYAdijDKvMkP4xgTzC6/INm0KNVEKziavoIjmrJ49Tz7Uv9IrK+yTODtNeKU37lKINL1yDpbMH6RTIZcqP5KZYIm2CNldaNuNCwfq4oUO7jUZhTbMaqnFeaDefdzzGHLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bvTuTBP1goScxAPS87lmP1ybNnr8Kznin2UvS2Z45NOWcd8cZg9e2L9uhw3w?=
 =?us-ascii?Q?xzyOBr0pqUbC0iAd9QLGuPFvaAAoSEUl6a3HDQIyqO9526TfYjsD8k4G+X/H?=
 =?us-ascii?Q?AUSMeNnnvJJCJVae7ZRl+C4ShmyRRh1NDPY+te+XsCaYscp9MWacW6CT63bM?=
 =?us-ascii?Q?AVLT+dt3PDicczax3K21xnqpj5I88Jj3HQroewSZOC4jQR+4vWTCHhmLPUt5?=
 =?us-ascii?Q?WhKNMwX2OjqWUwGFVtZ5x7vjwTGxNefDQVJX8XskJNrkqCGUgB16PubrHRG2?=
 =?us-ascii?Q?q48kWff3PebkOOmL3DHU86v9oBVoO//noPqgmoPNe9KxizHTD1zlt9ONXAc7?=
 =?us-ascii?Q?YiGbUY3T+7rbofQ+WAD+ibDsLncBmnhWr1HIPMSaSlVcCX8yZHAwMhjYSDDC?=
 =?us-ascii?Q?kImcjq8bi3N4a9mFogir/ThRhEX1HArIgjI5zcMrE1teUJIElQzoiqlgA7yK?=
 =?us-ascii?Q?MnsiC/uD4YcbgxMtZpXjIGHkNVxFrEcE7QLliyKLxo/f6I0o7txuh32fSKFW?=
 =?us-ascii?Q?Uhm7IaWsI1RP4+L+GSaaec+ue/kZC3P6e3/j9/ephGQNdhHavjLIB3qvLeSE?=
 =?us-ascii?Q?hFv5LmJ4b7Lwzt6YXvfEfeQi2y0mLOIYuOhaq2wJZF4F/KZGzPzM97cq3CIb?=
 =?us-ascii?Q?WoyjaGPBh8cgouphKKo3vKPULdUREN+3PfBvHnntEGvjIvhYs0nIH0CFX2b3?=
 =?us-ascii?Q?tLDomOjoY+j/BGYReUChsfAYX3Pi6IzMT0Ci+4bYeqw1Lp95DTsf3rEGAhE+?=
 =?us-ascii?Q?YlhmQd3pycAqqPwnvPSJI5l8dgEW+5/XkrHQdAxfE/9z5E/92R7sQJIzs7Dm?=
 =?us-ascii?Q?c0aXZnNPHs4sOHxinf6pJNOXgxw3gaazgqar4Lbly8eK9BvrMCuhdVB10aJs?=
 =?us-ascii?Q?ZtPPEnaks7J2lNEIjsEPF2MMQsApIIcjhnM9TK3DfRMOvxymxKnPBsv30YFH?=
 =?us-ascii?Q?MmtOzVjh/E1t3IwVk/lBD7nOBci15tZxPPj0WpxcsHCCA/L3T9tssvxUT2EW?=
 =?us-ascii?Q?xZq71mr/Q1jZ66nYYIexob6WK7v2Jj+uzKpP4l1yjNc4wM5Jf6QfMDE6VmF3?=
 =?us-ascii?Q?XbobRI29DqsEOrekteHdMA0pXyKRWc/uYMwwB+WqvRNrjfQ0QNtHfd4I185T?=
 =?us-ascii?Q?YSNHiPftfKzftXpstrYgR0PmF4/6SevMA3rdtqb7VLzJF9RSbkol9LN3vAOk?=
 =?us-ascii?Q?v1m1wf4Bes5rTyfCnJD6Hd9iCwdbmAYQ9QjDbBxpbcbheLf0n42xgOER9u2F?=
 =?us-ascii?Q?Mn3pWbDmvuUHZL3Y0dauQCFr23raH4PhTF/PFN1oMMq7YGOZVq60X5Ai5ZTN?=
 =?us-ascii?Q?r02VSAy9WqN6NYIbUSEzIYpNKACp3eCkXcLkIACa20zza2Khl9SRSxrtPZw0?=
 =?us-ascii?Q?6DVaYrSDHieuihb0zBIKed07+lu7Eu0fGYhAROEQtaq5QXE+Oq6H1j+698TU?=
 =?us-ascii?Q?3X/uykD5f5MPWPPPIhRqg3zCjDCc4jXzubIE6z4mpjxcNOnN1var38l/k1jO?=
 =?us-ascii?Q?ZYnhdfULXrrzyN8kfPSnqEpRcIntqk+NiLsvhlbgywz7EWYbKq3WQ2LeZqfc?=
 =?us-ascii?Q?TYg/DkGleg90RoCHK3irmw+5h5AdQtEMY/hZZz+Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8be3ed7-3bb2-4c8e-0307-08dbcab17091
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:05.0478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWX8lmWeWyCNRIO78ZizZhiyswvC0OGiAHKF4I6DzDwtQEZk8MHFZbZMOC1L8uLE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

At this point we know which master we are going to change the PCI config
on, this is the only device we need to invalidate. Switch
arm_smmu_atc_inv_domain() for arm_smmu_atc_inv_master().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b527e635a3043c..ad29f1ab5185aa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2391,7 +2391,10 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master,
 	pdev = to_pci_dev(master->dev);
 
 	atomic_inc(&smmu_domain->nr_ats_masters);
-	arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, 0, 0);
+	/*
+	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
+	 */
+	arm_smmu_atc_inv_master(master);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
-- 
2.42.0

