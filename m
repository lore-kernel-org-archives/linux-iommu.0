Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3034D4F2
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972015; cv=fail; b=ZabLqdgl6upj1AispETPyZeibCPO8m7OvpL0Wsj7IClWJ1ZR9PyJyFgVa8zzNH5ui7/9fmelkCfY+qPObB6jePpBYRLorKbpGjmJLSvVWNsALugEX/7C4jueqcu2zwrFUd5ha6JY2/vzJPEUKi+DXJkgHpOZJsEU2gJXsbXisqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972015; c=relaxed/simple;
	bh=C4dh9sapLcnydNhLXH3XEjk3ChNrib2GUXr23XN9O04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mX7JfnV4XyzGlW8ejnNBh9YnelnIh2A83EdGIa2sDvufXEvRPB+pmnJri7NQ57MexcLG/LKZZYox4If3l9j4Zlh0Z73yIvX3sQlU7wzozZt8uNG4DXhPezs3MCdbhitBh0H3KMw6SeOPE5Dp2QflwpU3B5ek3WSkvVr2eh3naZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P49I+GV0; arc=fail smtp.client-ip=52.101.46.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P49I+GV0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDGlmpzYj56OaZlQkIVEBp9b/xFQ+0lgPd9pVPlqVPbxXQjcYcd7OZpCjupnq0LPATBhyiMou9wSYaNhLxW3ffrUplLr2PDsN0xrvH+iHhrfK6a86oP7O3k7F25oK5jjr8R25ilziR3KY4o60DAXk28GyzUPEXZ8dQgZsItzVHmgPiX6vWqLfbpSEJyqXWWx2KcyMMjJg1nlpAQp+MGVSV6OddP0a0cQ9pWzCnUCsmUQ/1bM2HZ45W2KMS+E0AuBx9+t2CUnkfJHwAwRONGukAmrkm4ov/1co9AFFWuMqkhTGHoI0KgoSERAu57gaJQqLqEjWKs29vQijZp5e7Qctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQECgF21SzkvOm/HNCznkTxuoIMAHiPBetTO+KGLfwM=;
 b=SPKttbUNn5DknyMxgd5Kla8KRSUgZqkXiSr6OBHj8Zg4T3Xzqmaod0kesnT/Kf6Xhjas9nEn4q1TlzMTRDAkABPkFbF5mmFmkyVxOVqx/rva071t3MdaR9PmalrBH8yUmw3YGeGZ4bEE8Cm01EB7xMV27u1DEyisXVu6uJGz8Qh0a3SLQuCb8UXTbuEiI5mwQ7oIZDP1oBDeBZ5sHa8cUEhMGpfJckY4EBvYWcDOoCvzFkUq9ZszzNDx4J2v/nds97T67u+Fq8J2q4I7e+Se9Q6cQ2wIFVRMtge2CbvJ4fTwua6UexEmGp46aedj9qwxBqFbNPpu1F5qYqTTAUZBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQECgF21SzkvOm/HNCznkTxuoIMAHiPBetTO+KGLfwM=;
 b=P49I+GV02bVkmesKlPyCO4LI/gvSH9h5qgyRQVWuyTCf6HVkwkET+RxUkW05X/rqsz/rT9GQDHn5ODgBKXbAtU2sqGwLqOGMC0udhfmc5Q8+mO1gNz6NNM+8v7VfVbHPVniTYgvoZKCEw85rVjlnC5OcgFJuzsVY0w4ay4Am2Kc=
Received: from SA9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::32)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 18:26:48 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::8b) by SA9P221CA0027.outlook.office365.com
 (2603:10b6:806:25::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:26:47 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:26:39 -0800
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 14/14] iommu/amd: Add support for nested domain attach/detach
Date: Wed, 12 Nov 2025 18:25:06 +0000
Message-ID: <20251112182506.7165-15-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fec37b5-58b2-454c-276e-08de22190a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bAWz6tBASM77cNScf3X625E6iorbLY5hSDpyZjbTj01zHorecF2+bk3WVE/3?=
 =?us-ascii?Q?xTiVGoBRqgSGkb/4xi4bbM/BC4JMhVSP7LSeuHQLWpekOWstm0lK+lXD+Klf?=
 =?us-ascii?Q?pDsWPEH/vbNwXuSic/aeQwjqhKOrLkslHZiq9DiCVhQYYiuiS+m4xGQK35qJ?=
 =?us-ascii?Q?eA3CzpaXhJmH72pYZFd9lprOxOlA1qgobTEfRRmil9VjrfutuTvv+yx1WEyF?=
 =?us-ascii?Q?LTFxqUCx5SxB1tdc10WZlgykoK/MtUWUDOpeWNsu8oevl33xPfAenMc2l93l?=
 =?us-ascii?Q?f8eTkBBvUbi6bpNqGZgFxSxd8t77Uq1Zol8hzIt6HaCgeYHcHQQyYgy0ypTi?=
 =?us-ascii?Q?YoEmRsYONVyjYEWeKh8db6YtNlOh95KsqXThjdamD8VCPiu2PIPSRlG4fCB8?=
 =?us-ascii?Q?JXk46fqJKicVKi0Kgy0izXLOwUEVqNBMqaT/KHnwJ47JnBCkuRmscxhKtLDD?=
 =?us-ascii?Q?chKo9dPeg8LRVtWo+v6CRI/5d00iosW2hX1FQ/Xp5WAzpbir4cIpR/QSg44n?=
 =?us-ascii?Q?bMFe4cCAbvroP0qm2t1Sf0on/YMnWV/pN77+U34rb69GKMhvFgUQpxW3Davb?=
 =?us-ascii?Q?71td7ldaN/8HYEo1hi74b0AWbwlVn2RO/p0l5YDxtTMt3PWh9Db+Y1X/AZ1p?=
 =?us-ascii?Q?qK2qzqpB9JukKHB4UNumLUjLk0pTRnzR7AA0OtZZDvhJisBcjdN3DvnutiH+?=
 =?us-ascii?Q?BzwoJk1uZw1y0WcWLiqIDjY8+Gee3AY8fIDdifPqJBeBimV5QbGJY9uBzRpE?=
 =?us-ascii?Q?a3i90nG8MTuanwt7fA9MImu1w+wsY7IeyPTKzIPqgfAt1BUQcTYM9XG1+hfm?=
 =?us-ascii?Q?h2NPh1qoTh9PE/jMOdkzgiTBKaTptHoK+1NfUUKarv355gg/5GghATokhYVX?=
 =?us-ascii?Q?m1TSU+ZKvwqY8/uXe2pDU8Mb9ie+0R1uus58I3Z0XUohpSCXxQ5BE1Od0IP3?=
 =?us-ascii?Q?4drxRFvsevLkjrD1355+RASY9W7K6BeccTwxdeutjATL6d4OR9ef/w4yt+xb?=
 =?us-ascii?Q?CoLM9vUAxhHyRhCHFcVvqk5V2ZIXActCaqTbrJK+WpaKbHYxfsINqn7e2knV?=
 =?us-ascii?Q?Et/icrpRhg34Huref1fq3Su8HbHxaE6rza7jMQeYI9WLsx5pwKeiRrzXF4yA?=
 =?us-ascii?Q?p9mX/9uJnycYgrThnzR9EUEBv9Yxxb6ur5WYSyRq2sb9+vMvB5P91KTYkGCq?=
 =?us-ascii?Q?Hj6uhFEla/y2GDwUuxU3iv8fYLuEfB1wgOJKLJChCqfDbt9CVRMNAh+nt6eu?=
 =?us-ascii?Q?0AZrwS/eQ47UFly7H4cj2GoEpubtYPF9MnV1tNQi9t/7yKVBNpE9Sk0y4tlR?=
 =?us-ascii?Q?DB6OQT09v2b3kmMI3dqX9kEI8knwpXX3ZTlDQn6FuljKR3em9vbtU58/dXdO?=
 =?us-ascii?Q?D6rFWHhf3L9y6qPCZuabZJitz735NqlG/Fv/q3hjchcUjWy0zguLMCKOYAWT?=
 =?us-ascii?Q?MeKKITxtKccWCpGZYSaM6oSguPAPmpJrRJkYp6GLZJ7TKwZeYclHi50H06XO?=
 =?us-ascii?Q?wdPes3b0Zyv1hgl5f91FcYj32fcqi5xtX4dawSpDa7G1rQf0h/GZwggqcBxa?=
 =?us-ascii?Q?AeMXUQVlxKV+LPopWZM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:26:47.6723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fec37b5-58b2-454c-276e-08de22190a69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725

Introduce set_dte_nested() to program guest translation settings in
the host DTE when attaches the nested domain to a device.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/nested.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 1bbcb16abecc..eeb5d9b3a58f 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -153,6 +153,74 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	return ERR_PTR(ret);
 }
 
+static void set_dte_nested(struct amd_iommu *iommu,
+			   struct iommu_domain *dom,
+			   struct iommu_dev_data *dev_data)
+{
+	struct protection_domain *parent;
+	struct dev_table_entry new = {0};
+	struct nested_domain *ndom = to_ndomain(dom);
+	struct iommu_hwpt_amd_guest *gdte = &ndom->gdte;
+	struct pt_iommu_amdv1_hw_info pt_info;
+
+	/*
+	 * The nest parent domain is attached during the call to the
+	 * struct iommu_ops.viommu_init(), which will be stored as part
+	 * of the struct amd_iommu_viommu.parent.
+	 */
+	if (WARN_ON(!ndom->viommu || !ndom->viommu->parent))
+		return;
+
+	parent = ndom->viommu->parent;
+	amd_iommu_make_clear_dte(dev_data, &new);
+
+	/* Retrieve the current pagetable info via the IOMMU PT API. */
+	pt_iommu_amdv1_hw_info(&parent->amdv1, &pt_info);
+
+	/*
+	 * Use nested domain ID to program DTE.
+	 * See amd_iommu_alloc_domain_nested().
+	 */
+	amd_iommu_set_dte_v1(dev_data, parent, ndom->gdom_info->hdom_id, &pt_info, &new);
+
+	/* Guest PPR */
+	new.data[0] |= gdte->dte[0] & DTE_FLAG_PPR;
+
+	/* Guest translation stuff */
+	new.data[0] |= gdte->dte[0] & (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV);
+
+	/* GCR3 table */
+	new.data[0] |= gdte->dte[0] & DTE_GCR3_14_12;
+	new.data[1] |= gdte->dte[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31);
+
+	/* Guest paging mode */
+	new.data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
+
+	amd_iommu_update_dte(iommu, dev_data, &new);
+}
+
+static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
+				struct iommu_domain *old)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int ret = 0;
+
+	if (WARN_ON(dom->type != IOMMU_DOMAIN_NESTED))
+		return -EINVAL;
+
+	mutex_lock(&dev_data->mutex);
+
+	/* Setup DTE for nested translation and
+	 * update the device table
+	 */
+	set_dte_nested(iommu, dom, dev_data);
+
+	mutex_unlock(&dev_data->mutex);
+
+	return ret;
+}
+
 static void nested_domain_free(struct iommu_domain *dom)
 {
 	struct guest_domain_mapping_info *curr;
@@ -186,5 +254,6 @@ static void nested_domain_free(struct iommu_domain *dom)
 }
 
 static const struct iommu_domain_ops nested_domain_ops = {
+	.attach_dev = nested_attach_device,
 	.free = nested_domain_free,
 };
-- 
2.34.1

