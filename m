Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F6403E8A
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767263; cv=fail; b=nocU+SiO+zy8eVNULTnB0vFEr6RmloUB5bs6RXaOFru3LAE/zh4JBTaY1SlFcwbOn8y1mmmddaI95tc1vgH19lXORcmZ+SvmyHzfTQgGxlY9mbA3QdTiHsKXwygdJX4cHbcLIcZ8kj6CTU2pXgMUDrxgAZ9I3A+WjtB54OdR4e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767263; c=relaxed/simple;
	bh=f/YPBpJ1N9joUXnAJnOFk8thYGeqamGGyLwyRhqfqwc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s21oWZGhc/6AF61ngqCwHutI2IOSUM8UX4+Yck92v11kAm66UJhsSmRoD3Vuyzs1LI9XHoqb9OLNAIVoLt41319bH17KCTYFVUIfshNBKvdXfQbj7Nu+ejMXetshhG02x7Y6F3mM9Lxyf9hsSxOAh1T2M55DKt1D/bLmFPMun7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ThG5Cdv3; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ThG5Cdv3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPcKYo0jumvht+8bqVW6UwHLGj0LRjsWawLKmq/QoYaV8w+DioplQyysh+JeP5AlS3v1DH3juXsLDyrSHwD/4OghuzlPRc85UcsxZb2e6+PzkiDlLI81CATGN3BWEtEUjg00tjtQ9wz1za3wFNIqsD4tt04adiuoYv+GXZJfmQQoBibya7j3qOLosdyX9R8X+5NG50c0XTXS7yatT3qr8ze8JtxnnMPpTku0ACR4MZ6awNGrN7oz3G+3BS6Gho8D897mm1JmGSTopdTHLMatNC0sJ6UwnM35p+S34QOQUWtWrSuvXJd7TUH7uVjlhndasgfJ1EImkIUFS4bNK/Vshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zkxwxh2vb8r9uum/qEmi4UF4TwEDESqKLNFHPtJWVbo=;
 b=kZBrFYvQqlgRROveuYqoXfVxFTjiHhYE5EvAy4d54OhrWev3tRwYGeTJPBQ/0Si+fc+StVrr2MMmmSfov7DJnOV+o+x5V/eOrcFX4Q89SlcpwZHXw7OWxEz6/9JS3SBeEf0SAVQcEkYr/kR1sNOlYDNiAU/a7EWD9NUqC5fInGOtpQGRYmvMAkyI+Y60vdcuu5umZXhhKci021LOrO4kp9cx5VGxzApYpxcQ7RN6K5VC4zG2AItOsEMfpPHGlpCkZk8lIXV4JQO6TF+8Uz2HcNto0L5r78ajtc747a8zXCWEyKnzgJg9OAsa2yagwir8h9SLWqBVjW2Ipi3YrK8weQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zkxwxh2vb8r9uum/qEmi4UF4TwEDESqKLNFHPtJWVbo=;
 b=ThG5Cdv3Squ65AlLTM/3/1knDH4F0uJR8MuGwxsQ9LdWlx8noMRmcaJH9nsPOkHlyk/Hzi5eLKw0+8yNFzN0n2xfjH7hPXxq9jR1YzOBjwA8s3KifWxPDZNtZfK45ogS1g7dCkZFHE2grCF51R89C2tbPBmUdOQi67qJoJMwx2qYQS+Xr+7IvAmzoRBu+9bRYtOb0mUYHq5Nd9JAAxOmB7lFsR6gxP4OVBtRmvczqubP59zZjY0POqMT/HrlkpMHgNPn+Dfk0AiYW30O4vToaAGatkHD/X/iTwpOe/IMbOD/8tkpqAjLMNxZWqdnU9WmQ5GTPa1sxI75UrJNPPCSrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB7800.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:20:59 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 11:20:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 30 Sep 2026 19:25:03 +0800
Subject: [PATCH RFC v3 3/3] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-smmu-shared-sid-v3-3-8abe6c1b4c20@nxp.com>
References: <20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com>
In-Reply-To: <20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad1848a-3ea6-4243-c71a-08df1ee4e74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lEd21x6pwvXxaMXpVcbY2ASFp/rbzaKAks0EbS2ZwT+hUKUrZJh/Lh/9ALPs34uNTULWC27KhanFilDwOhbWlR8OrmK9HS3eyazd/ZS/tYOO+7XI/xwGOz7xbd3eoQZ5KB4y6sO0BuxYPdXa11bGvLQ63DK5tOUK4qlYxb4vZCmrTkUJRblI+JlrnwvkSeN6RmCYNkIV0EXntTWh0L34zYWCLuroeAxIBLq1JhjUhlHuxTC/FVTg85QQGc653MzbaZLfNmGr2chvpsowoBM+100tGmyJRfPX+2gNI529bNv4jnjP1wOXdd3QhThi0w/L14NdL6Z9t++XO8UdKx1kqBYyQB5i7ADIsXsXxAd9PZ6G4SY87eMmFm0je1Nmo8Kxz5ys/lpjhxi+5e+x2PpoxcBl2a+UZ0xLyCCF0jOP/udiOqNc7jNlTDcowMFeefjHbb0ITRTpLNLQUpHyr2XayzKNE3jHeO3sHjqi/3tmPdFZ8z43eoYtlFG/QDgERzfse0lepklL7eGOgTaYJ+F+xNDmUoDtSO9UaoyW2qnt/t9naEDYK+fClwNhmF0TjqDqlakvE4fMsCD7LEi2rxmC+vqxCoFzR9wtx27/uQg8Zpr/KmS0q5/AIJ8g/TrNHl2083RIJ9FwuEJB8Zccs3T/kO+Gp9gAcEs5nWQMFPfNqgc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFdvSVlXWDV1TFd2N2txMjQxR0lLT2xZempGQWJIU1RJa25VdnlmV1ozSmVB?=
 =?utf-8?B?disxZjIxclhQUFZPdER5THFqdllXL0l2a3ZRSHBzMXA2UkhxQ25yY2JicDE1?=
 =?utf-8?B?RmRaOTluUVZodGViQTNmeDlxWkZLU1NlYW81dDM1TWg5Q3pYSDkzenlhTy95?=
 =?utf-8?B?cW9ib0ZSeTBXWlQxUTBId0luQzBRYTFJZlc2cTJmMWF0RWNoV2gwTENQeUY5?=
 =?utf-8?B?cysybk1qQ0xxc2NBQ2F5ZE9jVGwxbE4wQUthdHpTazB5WWN5YTVjYjhkbkpC?=
 =?utf-8?B?TGJPRDR5SkRQNHNyT0FLSnBzM3gyKzhPOUZxTlJscEczeElQNEJrUlVnV1Yy?=
 =?utf-8?B?VE1HdEhiZ3ZKWmNFQXp2ZThyOEhmbVRuaTdDaitPYnhKZklCVURULzByR0h0?=
 =?utf-8?B?MmlHMWFYS1ZkZmZ1cTB1QXBDZUI0K2gwbjJETWI2SGZNemdNVGh0Q3gxKzFi?=
 =?utf-8?B?TkhueTFPTVNIaEJ3TS92dVduQUtWdlVzOUxBcWthQTFqQUNsVTJxNU5HOGJU?=
 =?utf-8?B?Y0UveUttdXUrdHJQQnFUMzRNcmhHclR3OVgrOHVBS2ZZOVJQNmhibVJvdlJp?=
 =?utf-8?B?b0YyRGdBTkhHaTVWQW5hYVFqVDF4a0VJRHN6cWtNazlVako0K0Npb0xlYjk4?=
 =?utf-8?B?NVpZRzY3Tmp6aEpmTzIycSsvVDlNalNZWkp4MHkwZTZCWTlibUIybnNNQ0NH?=
 =?utf-8?B?ZE9GazZMdmFiakRiZWlOWUVTSnZQaWJ4UFlNOUorUWUxczExZjhzaDloeVBx?=
 =?utf-8?B?VFk0U0xzNlVnM1d0SnhIbG9LOW5QMUtDVTZRNlNIWVlaejh6Ync0d21RQWVp?=
 =?utf-8?B?M3hlQTNGcG9TbTBqbm1YQVBuTE4xVUlZN0MzejF0d3FDY0szTW0yTWVUcGZo?=
 =?utf-8?B?RlgzSWx6N1RURTQ4dWVURzhpaWR4L2RHRXBmSEJXcGVsS1J0eTJFbmwwa2ZM?=
 =?utf-8?B?ck5Bemx2Umx1emt4TGo2T2tTb3N2N1JZc2dFeTZ4YWhSRnlwNzBvWjY2djN1?=
 =?utf-8?B?bW13ZTJoMldOR0ZwTHEwNDJhZTlSZlJXYWRuN1JTK3dFbVZVM0xaRGIyYmRX?=
 =?utf-8?B?NXZ4ZnRDa3JkYnJnZWh0RHhmRVEzSDJHNkcrQndBZ3diRC96MEtUbld4dkhC?=
 =?utf-8?B?Q1dTM1NxYjBsV0ZqSW81YXFCS3ptaTk5YjIwQXFyWUFGODlOREpQaC9xRHcx?=
 =?utf-8?B?SlhON0JwQlAzL1NQZTFxR0hQb3RLZE5nWEpoblFHL1VNUU5ZeWM4MXc5RnN0?=
 =?utf-8?B?eXRta2dQZjNWb2U4bVVmdFYyeVduMWVtdXY5Q3VJMHA5SkcvZi9XTHZ3cHBR?=
 =?utf-8?B?Wnlyc3g5RlZVYTc2andOVmllVW4yNmRYb1pNaDFrZXZFWWEzczBBUnZ0dmgx?=
 =?utf-8?B?M2d2cmEyWGEweVpEMEVwQU8yVktGWjEwVzJMdnBBYTl2WWxmb1Z2L2U2eFI2?=
 =?utf-8?B?aHZMeEIvTWNjY0JRNkdxMXNCYmt0a2dnSDJsWWJGVWltMlFNalhRekplR0dh?=
 =?utf-8?B?MnY2bmxlamF5R05DeFVsZDREdndhZ2N4NU82WmFOS1BGbmxydUdITEI1TGJ0?=
 =?utf-8?B?ODZpVUI0MDd4NmlCd2FwT3k0WjhrMU0vb1ZOK3NqcFNUaFpjQ200NkNseE95?=
 =?utf-8?B?eVBSQkZrc2ZxVG1RVjVLSlhSamJzN0FsS2FPWmZlRzJ6ekNqZThTS213Ny9H?=
 =?utf-8?B?NnpWVzF5c2VoMVZhRkpKU3U5QkdSeHY0MUoreTZtaVU3RGlCeU9kVXV3UXJo?=
 =?utf-8?B?LzJwckE5TEpMSHA0TWkzTUF1blZHTXFSSUtMcndpZUFMNThKR0VhOWw2NlUr?=
 =?utf-8?B?Q0QxaWRFL09mek1ZZ1BtYllsK1h6dzN3V2NmRm1TUGJOaVpHYzJNblNxWDA4?=
 =?utf-8?B?K243K2lXcEQ0NUdmTDJXK0E4WmtuUDBTUGM5OWdqOWlHR3JMTEtSTkU0MWY3?=
 =?utf-8?B?cFMyV1FuWWd1alJjOWF6U0wwUktFcm1ud0x3am5RNXZ4eDNpSmlqM0VZM3NQ?=
 =?utf-8?B?bkQ4UE9wcXV4WUlMaXV1Rng2dnFMOUdFYjZ5Z2draEZ2c1pzTm1CK0NCY3N3?=
 =?utf-8?B?eU5zVld4MVNGeVFhSEZFYldYWDFFZ25tcVkrL28wb0lCL1Qva2JIcWNwTndj?=
 =?utf-8?B?SjBmVU9KRmlrMHIzSyt6OEhWR2JpaVN5V0V1dlBOUFloRlQxTjhPa1hOVTRt?=
 =?utf-8?B?M2RGNm4xOG9VYXZVRkpNd1psd2tRbENUdDNmWFVCUndGN1NYemNIQjBOaWxZ?=
 =?utf-8?B?citsZDE0OG95Zkhtcy9STTV3VTg2WEdMNEk2cFFaUTFHUTFBRXBUYWVHaVpT?=
 =?utf-8?B?Q3VlUjVVOTUvenpvTFpKUW1vdEFlV2RoVXJTMUtKSnJMa1ZRWUM1TWhRTElY?=
 =?utf-8?Q?aqrszwPWAUbMGebkw+kfr1G8D6ltaDZKxC7u2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad1848a-3ea6-4243-c71a-08df1ee4e74a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:20:59.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/wcTPyFQ9mWLBJ3OW9WyGOJ9k8as9TSTgXVwCU4dPO2u6CoIPk/OWK7bFzJsx1qdlL0tDVpCcUd/V+N3USyufdsBAsF5po6aCVaCeRnblIh4hF3sX111JRYC61kjxf3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7800

From: Peng Fan <peng.fan@nxp.com>

For shared SIDs, only the first master to attach writes the STE
(tracked by ste_installed under streams_mutex); subsequent masters
skip the write.  On teardown, skip the ABORT STE write while other
masters still share the SID.

Fault events on shared SIDs cannot be attributed to a specific
master, so arm_smmu_find_master() returns NULL when the stream's
shared_masters list is non-empty.

Disable SVA, IOPF/stall, and vSMMU nesting for shared-SID masters
since all three require unambiguous SID-to-device mapping.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  3 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 44 ++++++++++++++++++++--
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ab1078a97d801..73fb5fad1c181 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -309,7 +309,7 @@ static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
 	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0] alone, so
 	 * more streams would leave the rest stale and none reads out of bounds.
 	 */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || !list_empty(&master->shared_masters_elm))
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 0a429c64fbf3e..54a0a65669ac2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -271,6 +271,9 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
 		return -EOPNOTSUPP;
 
+	if (!list_empty(&master->shared_masters_elm))
+		return -EOPNOTSUPP;
+
 	/* Prevent arm_smmu_mm_release from being called while we are attaching */
 	if (!mmget_not_zero(domain->mm))
 		return -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2e13cf0cb8882..b192efa679561 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2977,11 +2977,36 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	}
 }
 
+static bool arm_smmu_is_shared_sid(struct arm_smmu_master *master)
+{
+	return !list_empty(&master->shared_masters_elm);
+}
+
+static bool arm_smmu_skip_shared_ste(struct arm_smmu_device *smmu,
+				     u32 sid, bool is_abort)
+{
+	struct arm_smmu_stream *stream;
+
+	lockdep_assert_held(&smmu->streams_mutex);
+
+	stream = arm_smmu_find_stream(smmu, sid);
+	if (!stream || list_empty(&stream->shared_masters))
+		return false;
+
+	if (is_abort)
+		return true;
+	if (stream->ste_installed)
+		return true;
+	stream->ste_installed = true;
+	return false;
+}
+
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target)
 {
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
+	bool is_abort;
 
 	master->cd_table.in_ste =
 		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
@@ -2990,10 +3015,12 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(target->data[1])) ==
 		STRTAB_STE_1_EATS_TRANS;
 
+	is_abort = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
+		   STRTAB_STE_0_CFG_ABORT;
+
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i].id;
-		struct arm_smmu_ste *step =
-			arm_smmu_get_step_for_sid(smmu, sid);
+		struct arm_smmu_ste *step;
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
@@ -3002,6 +3029,16 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		if (j < i)
 			continue;
 
+		if (arm_smmu_is_shared_sid(master)) {
+			mutex_lock(&smmu->streams_mutex);
+			if (arm_smmu_skip_shared_ste(smmu, sid, is_abort)) {
+				mutex_unlock(&smmu->streams_mutex);
+				continue;
+			}
+			mutex_unlock(&smmu->streams_mutex);
+		}
+
+		step = arm_smmu_get_step_for_sid(smmu, sid);
 		arm_smmu_write_ste(master, sid, step, target);
 	}
 }
@@ -3149,8 +3186,7 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	if (!master->stall_enabled)
 		return 0;
 
-	/* We're not keeping track of SIDs in fault events */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || arm_smmu_is_shared_sid(master))
 		return -EOPNOTSUPP;
 
 	if (master->iopf_refcount) {

-- 
2.34.1

