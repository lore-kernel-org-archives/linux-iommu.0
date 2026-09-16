Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AEE3812FB
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571311; cv=fail; b=fDUuMw23RXUK8D6vymabQUUazi3/nG59rGEF+/rDeY3c8Se4DIzrCkTfjOW0MGPyTAUOrabSdPfneC4mFfK3fmArlqccrP3uNfjIqtCHhvlvu9mRnRxDEFtBADMZ+gFPEGNGsfcX0+fzkc837RXeFQhGQDIgOEeU5pvXz90LSGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571311; c=relaxed/simple;
	bh=w76LrviwoRXi1DOlKR7MnWMDfpZ4qGj3rLacMTnd53g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=J+Rzc5DXtlqok9DsQy3sVdLd2JQyga72eeWa0WqohXLRIewCZX5dYoZXOiYhNlL8ru0X3rFX8ynQfxeCBMHbjvvjlZrBf04aSwM/y/o2q8PJe6pRMDUHcPGwIl4uWIKsRsupYrG3xn1Ghw8HjzU6tsv7jBqYpgJLYP8LRcctBDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jxsT/WMD; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jxsT/WMD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtwyEDQ1Slf5OD4CKH1kseuhjgzLm6JD9MUUpnAkZVrJlRPSOdEirzLy/nQRw3CgJ7o1laWRGIfuAMhUp1SIPjZqSGPqKuM7qY0zwNRxpux8/xpV/U7QWLO4xY/WqoH/dEqpy9TIzYa4q8P/jKnWNCK8pjf5JoAJVZmzMmGdWSMu6QNKcV5qLqQPtnbJ502tIbasgCzdDgiWF1INhPOi+sMML4a+kFacCjNhdzZX6GO3ZnF3ANlXUH5IH5M7e1ye9eSrzmGAj8GSSBN5bb+OrSY/IrQzGEfbDybhq7HHh9bPFnSEcrIZ6Kon/PdBK70X4dUdBFl+tSI6ICFCqA6lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYR+CCfe7Nse5TyLdV8R6PaT5x5yrAjUFlHn+dCy7yU=;
 b=eUL+/vyymTqBk/EPGcpM5N6+qFB1MiNkoMkceC5wFU4KMNicWbCdM2Tn46sxws4fvug9giukaZ9j4f6VaM+8ZlvtJxkzbxI2lAZvZt2aYhML1g6cwD//mgOJr/ZbTA4aw5KN+1lP772KdmoRjITsak0dz8UeeD7j1Kg525zZvxVlHhmkWBQqhMgoPLDb6qnSj8EYsHLXfopwVABhMHG+Ai5Pg5WEDV/FggFuL3m/qJHPhMkWKpd7WPOXjlJXJIWR/Q8deMIhmq6NFgJcKDK0we0U6FWjnNCoQVwOOoWqwT1vAJK9YO1t0PQa5tl4daMoJnOMuTKha+UqxABH7inJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYR+CCfe7Nse5TyLdV8R6PaT5x5yrAjUFlHn+dCy7yU=;
 b=jxsT/WMDwrHoKtZzQs3WUb3Lvz0EAEaYgdjMcNktMMMy8QXcM4CQ0Y7Gce9ZOIocw1aEQIrvr8pVYmQJ9BO71jNFG2zVMS6oi3yeF9C4QMFk0pw5RL27vV+8xLjihD8cQG7KBMMps+G99Enha/Brvx/qqvxZG6HCYJyWdo6r9U+S/pm6TsjuRNUuGQ8/RHzfym41M8T291AJnOlsBRdmub5/pjNMj/OaYa8qONTMfGVis7Jr2j1fi42eGIZ9+GlWm1GS6GkDFxoE0Mmtiqzrh5tKyt8E9C3r0/STNNtBz018sClcMU/fKinoPx7Lu2FsEVE//RWwmW52n674mZDmpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB921731.eurprd04.prod.outlook.com (2603:10a6:2c8:2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:08:26 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:08:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 16 Sep 2026 23:12:34 +0800
Subject: [PATCH RFC 1/4] iommu/arm-smmu-v3: Convert streams from RB tree to
 XArray
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-smmu-shared-sid-v1-1-517384504aee@nxp.com>
References: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
In-Reply-To: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR2PR04MB921731:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b7e458-2aaf-4756-048a-08df14045be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fkyOQ3DLt2cB4mn7WxWSWtdlD8rY3oeUq07Mt+zEJm9458zppxzyYLb1rlK8aqytv0T/WezzTcWrCvZal2zVxaR0JIGFkn2kqRQI+yLD0i4mP9734ihzOOMJWVkDjEMgOolo0GDdwdfWlXxe9Cen95fNcqWo5LHpaXxg91E0MBjcDx68p9msC1RCymphTLTAkLPeX1NsmByAH3uXNzHRIHC3/3Q7C5c3eoaXxDFlcLi/tTUNm87EJJ2uxGMjx+ABPCDQDx5FuzdxrErVTHiBuHIqQ7X9PLo854lX4u75ujPicfkg5GkvnCGDzoMhTiqxilLY6GQZDAvBxLa86jWTedxuzJ0cDQJesLWAhLn9uFSBz9+4qVuJ+TT3cNB94nTc7CKH6RpJelfDio5yDVyZDV9t280pHgaix1S5nIc+Foy0TDofnG1abhhxI9yeMHUrcimhczX5dw8I8/G0K+WbO9e9BAkNvu4aj2T9Azs25MqRCKCZw9AKP2eIlH160madDPmH3Iopo/uvw7/WA3/AgQzcJ2LVK+zXPPgMY2zGtMACsWWLh/rO72uWLDz2LZTbfSPZt7x7ySIqviLpoypggfWLo59Cb3xKKIkSAZpDkpWG5u4UQxufSH0rg2AQpwKmVzgvh4gDyS70s3yZKxYX0gD3mOQZq7LnYYKhfNzq6FM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjlySnJuR1NZWkgyaGdSK0RQMGVOY0hacHVaZ1Rhb2pITFhyZ0w5cStOQ2tQ?=
 =?utf-8?B?c29QLytFNzJMcHZJK0RKK0JqVVp4TGx6QjVNVExJZDY1R3M2TGRUbkViUHpK?=
 =?utf-8?B?S1o5Slk3TURYcDJpdWhnT0NXQ1N5NU9vQVBuWmxGeC9PWWxxaEZuWFRyUlRH?=
 =?utf-8?B?dUZTVVpnK3lkeEtGYnBJWVNON3lCb0ZqWC9DNWpUUVBZK05MRGNhbnZWa0Fa?=
 =?utf-8?B?Z0xoWWNXaDV5b1BJcG5kTnNOSUM2TW1IM3p4LytmQXM2c1ErdGFhQmZxTE1o?=
 =?utf-8?B?Ykc5aUh0cGdsYmJSUEM3aEdZR2FvZ3hGZU5WRitad3VUTUZLUXdnU3hWbzdW?=
 =?utf-8?B?L3o1aEtMZHVKNXFNaTN2YjZteVgyNHlKeFdYdDFLQlFETkxrMVBKc01zY2l2?=
 =?utf-8?B?L0NpcXFFQjUrRmpLYTRHQ3lEN0lOeU5OM3hGVFh3dXF3NVMyQ3czUzI5UlRQ?=
 =?utf-8?B?cW9YNkJXd2dhcWhhS1pYRlk2MmtaY24xZE5tNHZHeTk1TEVHRkNjaldvVXF2?=
 =?utf-8?B?Vi8vN1Q4akJabGY5WWZ2S2FtZ2UwVm82aW53RlJlODZNTmtwazFpR1BaUXcy?=
 =?utf-8?B?T2RUTGNGZFBJT1NDclRxMmVhYVZVZmRGNTljcjhOeG9pUzV6akJFYlI0M3pu?=
 =?utf-8?B?QnJoNjdIYnovK1JnOGJleUpub3luMk5wNXN4dlczd2pxaU0venI1d2Rkd3V3?=
 =?utf-8?B?eWhkb09DOFVpeERBVTJwOFp4aDNUcXY4TDlsTjN3c2lXTXZya3ArQ215bHRv?=
 =?utf-8?B?TUFGOS9XZG5yL1ViaWV3dHF1cUJIaHFWQTlYUmVmc2ZxOEZNMi9JbDlreFky?=
 =?utf-8?B?cmJvQzJiOEI3SkhRbmxIWUV5dWVsUk9Hb1FMN29iVzVwUU5jKy93RXFnN3N6?=
 =?utf-8?B?emFNMnF0VEhMNTBvVUp3a3JXV3NBK3BBcnlhZ0hGYmFlV2h6RG4wTStaSjJa?=
 =?utf-8?B?MGpoVHZTNldiNStMTCtZd0pRR1hUZUlDdW9TUUtzalRBbUM4Y2pRR1o4SUZL?=
 =?utf-8?B?WW5nRTlMZ1IxUE9Yc0tUZUtCOU5tOWtxUmdsL1lGUWJGN3ErTW9hN0xUUFcy?=
 =?utf-8?B?MEJLQk9KYVNwOFlmbVVXTWcvUHQ2dFdWTW1RcFJiMnNGVEF3b0FPc2Y0TlNk?=
 =?utf-8?B?eUpYbW9OSVZqaTEwV3hOTkZsVUpTbWpKWlU0SGtocVI4UDY3cWNIaHFoZGta?=
 =?utf-8?B?LzNRVnEwejBSZ2dBSUxoMStwOGFTZ1UxR0JVejQ2RlZ0VkVmOHE5bzAvSEhN?=
 =?utf-8?B?K29Lem94U1IyZk83Qk5aVmtIbUxLZWF4bXk2QStuU0MzaDhpQ1ZnYi83a0FJ?=
 =?utf-8?B?eWF5VUFBMG5ZeVdUZm5qUjRKeDBMOUZzeVpubGw2UXQwYUJuUWRySG5JSVlK?=
 =?utf-8?B?Z08vS20rLzkrYzVUbjlvcmprWStiRzdjTENVcUVON2ZwLysycjZXYUJnQkVH?=
 =?utf-8?B?SERQNW9Zbjg2NFJPWEw0V2lzbzZVc3VlNXlXc2JrV0hoWE8rK2phL1paSlJa?=
 =?utf-8?B?dUo1N0k0U2lxZkZ6UE12dkdBTUlCdDRHTTRmd2U1bnY3TnhkV0pRam1FYXV2?=
 =?utf-8?B?c3ZPY3U0akw0M2RqUnFGUnhzZFpXTXBjeWpPUWIwTHlnWG5Fdm0wVDZxdkZH?=
 =?utf-8?B?UXNvU042VEl1czZBWnBPOUo4YzkvT3dpSUtnaFovVzV6azd6UTE2UzV4MnBJ?=
 =?utf-8?B?ZEx0RHJPWG43Si9YM3JRV3lvd0hhNzVGQlY2TjJWcnpnUnhGYXpyUFVuZHlM?=
 =?utf-8?B?TEJxYlJNVFhGMWV3SmpSUzFZUWlrNlVBQStPNzU2VnNJZ05ubXRvditaaHQ5?=
 =?utf-8?B?eDFOQmFVK20xNG8vNzQrNWVBUjhuR3FVR2Y4V3p1VU1DcGRLUkQ1QzNhK0Rj?=
 =?utf-8?B?bW96WHFhSXFsdVRMbTliRFk5a2FPc2RmOEhXSXkwa1Fyb1hEdEZYdDBFcEFy?=
 =?utf-8?B?TXUxVWl4NldFdWNTMFNUMDNwMTBSdHV5MnFXVU1TRmlkcjVkVWdXU0ZjL1lL?=
 =?utf-8?B?WHRVbElaakpkV0Y2c3Nyb29lakZKdncwZlIzQmdDWnVnM2V1STl2aENsRGEw?=
 =?utf-8?B?T0QrQnRudWdPK3hRRm9hYlhqTWZjclZOdlFvaHEvZDZ5Uks5dVBvYkx1SWl4?=
 =?utf-8?B?c3ppdzlNaU5oU2dhSlcwYkZXU2pxdnVWV0NQS0JKTmJGRXoyWlNhR2dqdzlX?=
 =?utf-8?B?ZGV3anJlaE5iN0piMlNZM00xcGRhNkpId29mUitBczNQOVJ0RVVxT3FFdHhr?=
 =?utf-8?B?K0hDNXBuRlRsUGZ5czBSeTBhemxLS0duZU9VMWVWZ0cyOVBGT0ZtMWNnSCtH?=
 =?utf-8?B?OVVuVERGcENYSGo0RmhhV1RrZEh2a00yUytFWWJWVndkZVArcXRFamhpODdo?=
 =?utf-8?Q?rJwY+vH4W32q+q7tbhBLZBwEJrXAJ9u5m9E6K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b7e458-2aaf-4756-048a-08df14045be5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:08:26.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuX/GBCUVoBzlof20GjGKfAMPHICSqdl27EgRGnEyCkbJ2SmPdbJYLlVEK8+lZ2GbK6QS+/3tx7+TP0fpPD0sH9BNpr75UtadBSTeM00/GtjmGUuyqkHgkoDACJwl0cd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB921731

From: Peng Fan <peng.fan@nxp.com>

Replace the smmu->streams RB tree with an XArray for SID ->
arm_smmu_stream lookups. The existing streams_mutex serialises all
accesses (both xa_store/xa_erase and xa_load), protecting the lifetime
of returned pointers against concurrent arm_smmu_remove_master()
without requiring RCU grace periods. A mutex (rather than xa_lock) is
needed because several paths sleep while the lock is held:
dmam_alloc_coherent(GFP_KERNEL) in arm_smmu_init_sid_strtab(), and
down_read() inside iommu_report_device_fault().

This removes the RB tree comparators, the rb_node from
arm_smmu_stream, and simplifies duplicate-SID handling for bridged PCI
devices.

No behavioural change intended; preparation for shared-SID support.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 83 ++++++++++++++---------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 11 +++-
 2 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..65e448a69a019 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2024,37 +2024,17 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
-static int arm_smmu_streams_cmp_key(const void *lhs, const struct rb_node *rhs)
-{
-	struct arm_smmu_stream *stream_rhs =
-		rb_entry(rhs, struct arm_smmu_stream, node);
-	const u32 *sid_lhs = lhs;
-
-	if (*sid_lhs < stream_rhs->id)
-		return -1;
-	if (*sid_lhs > stream_rhs->id)
-		return 1;
-	return 0;
-}
-
-static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
-				     const struct rb_node *rhs)
-{
-	return arm_smmu_streams_cmp_key(
-		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
-}
-
 static struct arm_smmu_master *
 arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
-	struct rb_node *node;
+	struct arm_smmu_stream *stream;
 
 	lockdep_assert_held(&smmu->streams_mutex);
 
-	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
-	if (!node)
+	stream = xa_load(&smmu->streams, sid);
+	if (!stream)
 		return NULL;
-	return rb_entry(node, struct arm_smmu_stream, node)->master;
+	return stream->master;
 }
 
 /* IRQ and event handlers */
@@ -4123,38 +4103,47 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	     NULL);
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++) {
+	for (i = 0; i < master->num_streams; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
-		struct rb_node *existing;
+		struct arm_smmu_stream *existing;
 		u32 sid = new_stream->id;
 
 		ret = arm_smmu_init_sid_strtab(smmu, sid);
 		if (ret)
 			break;
 
-		/* Insert into SID tree */
-		existing = rb_find_add(&new_stream->node, &smmu->streams,
-				       arm_smmu_streams_cmp_node);
-		if (existing) {
-			struct arm_smmu_master *existing_master =
-				rb_entry(existing, struct arm_smmu_stream, node)
-					->master;
-
-			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
-				continue;
+		/* Bridged PCI devices may end up with duplicated IDs */
+		if (i > 0 && master->streams[i - 1].id == sid)
+			continue;
 
+		existing = xa_load(&smmu->streams, sid);
+		if (existing) {
 			dev_warn(master->dev,
 				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing_master->dev));
+				 sid, dev_name(existing->master->dev));
 			ret = -ENODEV;
 			break;
 		}
+
+		/*
+		 * xa_store() returns the old entry (void *) on success
+		 * or an ERR_PTR on allocation failure.  Use xa_err() to
+		 * convert to a standard errno.
+		 */
+		ret = xa_err(xa_store(&smmu->streams, sid, new_stream,
+				      GFP_KERNEL));
+		if (ret)
+			break;
 	}
 
 	if (ret) {
-		for (i--; i >= 0; i--)
-			rb_erase(&master->streams[i].node, &smmu->streams);
+		for (i--; i >= 0; i--) {
+			u32 sid = master->streams[i].id;
+
+			if (i > 0 && master->streams[i - 1].id == sid)
+				continue;
+			xa_erase(&smmu->streams, sid);
+		}
 		kfree(master->streams);
 		kfree(master->build_invs);
 	}
@@ -4167,14 +4156,19 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
 	int i;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
-		rb_erase(&master->streams[i].node, &smmu->streams);
+	for (i = 0; i < master->num_streams; i++) {
+		u32 sid = master->streams[i].id;
+
+		/* Skip intra-master duplicate SIDs */
+		if (i > 0 && master->streams[i - 1].id == sid)
+			continue;
+		xa_erase(&smmu->streams, sid);
+	}
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
@@ -4602,7 +4596,7 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	int ret;
 
 	mutex_init(&smmu->streams_mutex);
-	smmu->streams = RB_ROOT;
+	xa_init(&smmu->streams);
 
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
@@ -5627,6 +5621,7 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
+	xa_destroy(&smmu->streams);
 }
 
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd2fee2f560e6..97dc97ac704d9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
+#include <linux/xarray.h>
 
 struct arm_smmu_device;
 struct arm_vsmmu;
@@ -961,14 +962,20 @@ struct arm_smmu_device {
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
 
-	struct rb_root			streams;
+	/*
+	 * XArray of arm_smmu_stream, indexed by SID.
+	 * All accesses (reads and writes) are serialised by streams_mutex.
+	 * The mutex is held across xa_load() and all subsequent uses of the
+	 * returned pointer to prevent use-after-free from concurrent
+	 * arm_smmu_remove_master().
+	 */
+	struct xarray			streams;
 	struct mutex			streams_mutex;
 };
 
 struct arm_smmu_stream {
 	u32				id;
 	struct arm_smmu_master		*master;
-	struct rb_node			node;
 };
 
 struct arm_smmu_vmaster {

-- 
2.34.1

