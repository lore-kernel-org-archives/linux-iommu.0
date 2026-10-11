Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BD3AEF4E
	for <iommu@lists.linux.dev>; Sun, 11 Oct 2026 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791718033; cv=fail; b=RupinsZHSjXw26CqQaVPPAMBsggCoqBVVKz0ur3dfDa5jCnLa9QdfTDv2ZH1e1TPT4LWogKVMdHdQVwxqZknMAtgwNG+rz19Z0jYvgBMTTsqkMDAwcWosLeJMSt0nzpIaZAZ8I3Ogae0W7KpQ51JsLz/jYP5D1SWRgmQlHG1zA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791718033; c=relaxed/simple;
	bh=fF5JiVS2xImiYPeZ3fXzJAPV6BbeDu/fiL+D/aNTPWg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KTe+35xE6fVFq1dT+Rtp1KLuXPVtPHGwxuEhzhmSiuINt1pFBEU9fb8NNxiZYR4T5JNi8vUWRQu+F8sWkC05u7ty8ZDzx9bItDMENJMu34GTjM32YELH4sBn097G6CXGTM6rOLbpqG5qksseQvZEPsDHfPiRD5cJPn24kq9vLss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Rci1sCSe; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Rci1sCSe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kugL8xps9rk/FSUHR0MBO/5wSSIAymi8Rj21eIyFywv3f/h2HvMDUL+BzGg/Iq+kK2sxHdPntuTDqx0oGOVapx/KKUXbfmR8fZ/cw5KkMvwxOflzQMN5yGd4Z3WdSn6C9Ba4nGxmuSgJoXKltn3H17ePZPQFu7/uGi81iuOwZWEydOFswJFtgq9v5cV8LdDTm5ZxQPh2l3twL8Nm7g11b5+AZXEyDpXNu5qYBXXnoRxvdZxfRyEkNJoOhQxnrz9Wx0QzTCuqzQMdrfkWlQv8aWcIZZlCy5n78r6whjfVR4OQDZOL+K/SejfiG+7GthweocrAiIzqB+/9wxhItnUcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=god/6ixPxF2e8nzmKU/T807Gsjf3SMWDKuh4LQ2R7gw=;
 b=k3Vxr0q+SoPcxJ7dF5LFCAg++ftAAKbiu5L6pCChrBB7ROYWtgx4YXSaetpZtkXYLNMt4pIjPr/I/xh0mhiy/qkTeZG32dCVI+UTfqUJ4263kVAFGN9vjPh5R2BgCAE57E+OmECXZY79vzbILOd2QJZK/46j55bQqQeOOFY52VVmXv6F6/Tzfii6WBTj7BaO6Owaq9jGOvpFseqrrRqmw759U1UzTHzrC9B7eW8bUIpj2s/laZd3tv92eQZ00GyvKaq3bBNnbFxP9L2gWKrqe9h+7cXzHnUBFDzpJUH3Q50X18IEmv1NpjBRcO3b6rWDoNjCNkSDPCa1Kw0bNLi+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=god/6ixPxF2e8nzmKU/T807Gsjf3SMWDKuh4LQ2R7gw=;
 b=Rci1sCSeDSRaWWQpRDlyg2BYnLfOlgKexkh/4zPmTIGSXLLTRMqjm8sJ9vHVuA4/2lkAKDoLul5LwXvLguMcdZI4HH+24fuJXZYTa93hG6auZbUJDy5pPuiC+K+qhGxt66mOsN0DsjDu5u7gQ0Ro8MjVDEvLB07vRvg0XlIQdLbH1o5QlmDTsCdXxnWqh9Eh6Oe0AuG6Joq8V67JAkdux3gQXRqsGp6azCw+lFJMcP8wU5xyqOeREc9+AfObLgreR7X7pptf32Ak5cZei/M3gHhecOty+AQZA44DugFE+N1zQGMP/5jgDcsDZslcDqb7KxU7XilJ/HkqISxF5ACEBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI2PR04MB11171.eurprd04.prod.outlook.com (2603:10a6:800:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 11:27:07 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 11:27:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 11 Oct 2026 19:31:26 +0800
Subject: [PATCH RFC v6 2/5] iommu/arm-smmu-v3: Delay stream allocation to
 inside the mutex
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-smmu-shared-sid-v6-2-cb76b89dc612@nxp.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
In-Reply-To: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4abf9c-ca67-4224-acb0-08df278a9562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|11063799006|921020|56012099006|22082099003|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	YPvLVR95IVR6cF0LzfUNvA3c8LVjln7mcHGFMJOaYz3iEMWPZeXXy3IkIFW2oYG5tcv9huEeZVU7q3acOjgu6P1Hz54zzoofNGGh7ZG9xJgLQwFYxh5mReYD80SMI/9K/EKC1WdS1FOsJoveWcz2nDVlgNX00IbleMQw/rW0BpeDbX3YPlI+QpWQ9eVkZ6mjz0t19sJfR3iJ3VaKyaIVFlj4oFA+lLldue6ZPy0QODRGhBtlRlwh63OnA2kn9T+2VwsgRYSfxeVlgJ+MeN/jeMmF4hnopYfExOrjPVVN8Gh0YJv4x+cSuiRzRBqEbfj2MQid9GXpPIoE5VpmfcIDHJHbUMQIcpl9aGSbX2rWGJPLwFg6VuEBVRotQljWFJF2g1+770sYzvcLVwp4EcIjH7oNEyrYiEeLFcb0jfLEar3cSpURGkCyOerwd2xw3u+QHG9f9iNvgatax1sqL876wbDPyXtGSIu5lwY23xQ0Yp2z7s48ExrxCl7y71wbvmGy/KA5LU+ZaacCj4bsyV3QY3TkmMvv1gceUJEtUJJsfMgWnTxqX+yLBBJGqnN8LKwwixO6hE6HwoS3Bo30GvJi9LWeIr5BgYoVGfRhaqhZ50k+vZ1pQqpwKVtDW/89brl+3BIujs/ocHchwsBBX3e+MYVDLtNgvx8s4llU9oHzKfljKCINEAeQehqo1NaXNQD65VRU8zeurx7czVD9d3YcrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(11063799006)(921020)(56012099006)(22082099003)(18002099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXl5d0ozblFURDhoQ2l0T1c1Zzc1VlZHaWNHRmNyOWZNL2lib2FzQVZMckd6?=
 =?utf-8?B?WnJaK2t1UXRhTmlpUGROdW5BZDJUOTg2UUxTVjNlQmRkRWdFSGdsWVdlMXZU?=
 =?utf-8?B?cmduMDFrWDhRNWQ1RlVNMEJySGtuMkFmNm5jUUJnTGRkcitoNlJsNlNMR2N4?=
 =?utf-8?B?VzRyT3ZFSFg4UVl4QXR3eUV1UklSbHNqa25xVHA2L1RReFZGdktOTGhkc3cy?=
 =?utf-8?B?QUZIQlRhK3M4eEJzbWtTUVd0VWY2a09tR2dSdU9TbkE0L3lUMkNuRlhDYk5Y?=
 =?utf-8?B?dTRXa1NZTW5XUzZLeWI3MmVUZHNEaUhacytOUTU1WWc2dWg2NnpmWTlwdUJm?=
 =?utf-8?B?TUdZWDB2RlR3YjF3bHBHcnBqbHRsOXc4NW9WTXRhNFNCU21Ic2laMm8ycTZC?=
 =?utf-8?B?VVRSVlByQUdKQkUrSGpFVFlER1N0Y3I4Y2ZxSUE3MXBYekMwUC91Tm0vd3VI?=
 =?utf-8?B?dkRSZHhqeXlnMHJJUWNYZXNwc2VHUnpQeTA1NFdFRmt5bEtPeks5c1M4MmxU?=
 =?utf-8?B?RzlqMGxDMk5VNGtGc3B3VTVGWDU4aVVadUZCcS85SXdkdmM4cldKZE1SYXVR?=
 =?utf-8?B?b3F0bjR3ejZGNit3SXZ0aHlVb2grWWw5QTFOV2JHWW9vSEdzRlVON3owZDRL?=
 =?utf-8?B?Z0Z3NkMrSjNhZGt4RzRWWjlmczdRZ0NNdjZwUHVSa1hZaXZkVTU0eUo2K2xG?=
 =?utf-8?B?Wk5WY3VJOUQ0YndsTkxXZXM4MTZ5V2d0VzY0VzEzTVVhQkRXSUVPT0E3bkc1?=
 =?utf-8?B?Tnl6UTExSFUrTDRzN3l3UXFaeFVIbkN5Ri8xUVY1WndNVm9NKzZOM1lmbFlM?=
 =?utf-8?B?a2xnamRURWhoKzR5RTM3bjh0dDlma3Z3WDVnT05wc3dVaU1aSG5nS3RzZ3Jn?=
 =?utf-8?B?cm93blo4U0IwdEJpL1lraWU0MjN2ZVpianVZWTIvSFhzVG5waHpUUHF3U095?=
 =?utf-8?B?eUl3U0I2S3QzRTNwTE1RbW9pbWNqYmlGcG1HUTJvTGJNK2txOTFxQWZBZkVS?=
 =?utf-8?B?eFJ5YlZ2L21HZExWVzlQa25OdDBjZjQrcjNVSFNHN1c5VWdSeXpNWFpoUEZU?=
 =?utf-8?B?NGVhS1FMdk5FOEN1dlBWWVlNYWNRSHRBZVhOY3VNQTJQY0ZlRzJkWjVLeTZE?=
 =?utf-8?B?NXNZVk1USjg2aVE1ZTBJQmx6NFd3OFViak5aS3BaQnFCUDFKeGtsUldSOGV5?=
 =?utf-8?B?SktrL0dxektQeWtHMWwvdFcrREd2a2pmQjRpMXVxb1hhWDZreTlCZkFHajBl?=
 =?utf-8?B?MXRxU1g3ZjIzcGV1bDFXd3BJYmZ1SWlYVStOMnJFWVprVjQyWXpIb2dTVzRi?=
 =?utf-8?B?YXMvTHN0M1JxdmlmU1gyaStMUlovekRtdVNZVXBLRlNEMmtkb1pUcXplWm5r?=
 =?utf-8?B?RU1KYkdaODBMR3c3OW95ZFhsQ0s3QTB2d1FCWHl0bTJtN2N1L21sV2ZEWEFn?=
 =?utf-8?B?S3lSeWNJMWJGcjVMbDVUMnF1NEhtaVRTVE82VTBYM3ZJa2lTZ1dVRXM0SUtO?=
 =?utf-8?B?VkVxeUlYWFkwLzM1U2phRjU0NkJRcnBQTkErcFZRTjZtaUhBVm5qNmRqK0JC?=
 =?utf-8?B?UCtNaWwwVkZnd09ha3hEUDRLVXQwdXRuYWIzL1ZRWERldTMzNXlhQStaZndk?=
 =?utf-8?B?T0dGcnhnSSt0MklqR1NqSFZ5TEZBeDRTMGk0blIyaFVtN01iUlpQMTIzRDBt?=
 =?utf-8?B?bzVZK3d3cHcvK2tNcTk2T2pzSjdiOTVCZWhOcDI1d0hqT0tZNitPVkFucHVR?=
 =?utf-8?B?anFrU0Jlc2xYWDMyT3dNbVNrUEZDKzNOTDlLdDk4Zm9VVkZCRWN1bGRvUHd3?=
 =?utf-8?B?dlZlUW92bzc1TFlZblZXaDdKWGo1L2JDMjZCQWUxZFE0bGlhclFLbnpHM2Nn?=
 =?utf-8?B?TXpxNlZvbmdNaDdvQWRKcWN3eTg2ZFNXdTVIWHNScGcyQ1RIUVVJME4yTVJh?=
 =?utf-8?B?QkNVQnZ4N0tYK3dhUnEzN3cwVjhFNTZQeHdibkl4bis5ei9SeFhWUlJkYVZM?=
 =?utf-8?B?S3YzZ3JIV0JacEJVUEJsT01hekVsTlBiSW9ZR2U1VmZ3K01NOHBrT1k4TGM4?=
 =?utf-8?B?Z1krSXo4NlpDdG4wSTE0aUtRTXJnL3ZYWE9DakJwR2pha1R4Vy8zdnhvVm9F?=
 =?utf-8?B?QUpYVmlkdGlmcWYycGRxb2tUTDY3ZDhPb1BwRmZQSGNHSVFuRkhsb0gvNXNQ?=
 =?utf-8?B?dEphSnlSdWhycUxhZHNEOFVWekg4ZEJHNk8wWXFwYlo1MHlxeVlEc2U4TGVs?=
 =?utf-8?B?em1ualprWXdic2hzZHVXMk9GeEQ2Yit3MGJvS3JlaXZzcDZlYzY0V3VNemlS?=
 =?utf-8?B?aW03MWxjcGZXUTI0STB0TDU1TWpRaVlKeGl3dit6NzVNWXcyeUZSV1V0aHkw?=
 =?utf-8?Q?OnFNDOqYboGs2y+z2wZyHFIcICSY8q2Z1azxh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4abf9c-ca67-4224-acb0-08df278a9562
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 11:27:07.7823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkEKaIqSz0S9T8e8T9ssdx/CHcwXvV7H1oLDNEWrfvWz81qjvkTn9Obnln0J7g+ZPPilofWeJ4cF7fLibFvNWJ0rTY08f8zefkRbOCSuEeAXXMZuyfsZH6Q+6Vnx9+wA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

From: Peng Fan <peng.fan@nxp.com>

Move arm_smmu_stream allocation from upfront (before the mutex) into
the mutex-protected loop in arm_smmu_insert_master(). Instead of
pre-allocating all stream objects and then inserting them into the RB
tree, first look up whether the SID already exists in the tree via the
new arm_smmu_find_stream() helper. Only allocate and insert a new
stream when no existing entry is found.

Duplicated Stream IDs from bridged PCI devices are now actively
skipped rather than stored as duplicate pointers. A separate write
index (n) tracks only unique entries, and master->num_streams is set
to the deduplicated count. This eliminates the need for duplicate-
pointer tracking in all cleanup paths.

Extract arm_smmu_find_stream() from arm_smmu_find_master() to provide
stream-level lookup, which will also be used by subsequent shared-SID
patches.

Extract arm_smmu_free_master_streams() to share the stream cleanup
logic between the error rollback in arm_smmu_insert_master() and
arm_smmu_remove_master().

The sort is moved after the mutex section, since streams are now
populated inside the loop rather than beforehand.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 124 ++++++++++++++--------------
 1 file changed, 60 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5e092f51faad0..0ea755ea82192 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2076,8 +2076,8 @@ static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
 		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
 }
 
-static struct arm_smmu_master *
-arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+static struct arm_smmu_stream *
+arm_smmu_find_stream(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
 
@@ -2086,7 +2086,18 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
 	if (!node)
 		return NULL;
-	return rb_entry(node, struct arm_smmu_stream, node)->master;
+	return rb_entry(node, struct arm_smmu_stream, node);
+}
+
+static struct arm_smmu_master *
+arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_stream *stream;
+
+	stream = arm_smmu_find_stream(smmu, sid);
+	if (!stream)
+		return NULL;
+	return stream->master;
 }
 
 /* IRQ and event handlers */
@@ -4282,10 +4293,25 @@ static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
 	return cmp_int((*l)->id, (*r)->id);
 }
 
+static void arm_smmu_free_master_streams(struct arm_smmu_master *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	lockdep_assert_held(&smmu->streams_mutex);
+
+	for (i = 0; i < master->num_streams; i++) {
+		if (!master->streams[i])
+			continue;
+		rb_erase(&master->streams[i]->node, &smmu->streams);
+		kfree(master->streams[i]);
+	}
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
-	int i;
+	int i, n;
 	int ret = 0;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 	bool ats_supported = dev_is_pci(master->dev) &&
@@ -4294,7 +4320,6 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	master->streams = kzalloc_objs(*master->streams, fwspec->num_ids);
 	if (!master->streams)
 		return -ENOMEM;
-	master->num_streams = fwspec->num_ids;
 
 	if (!ats_supported) {
 		/* Base case has 1 ASID entry or maximum 2 VMID entries */
@@ -4308,99 +4333,70 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream;
-
-		new_stream = kzalloc_obj(*new_stream, GFP_KERNEL);
-		if (!new_stream) {
-			ret = -ENOMEM;
-			goto out_free_streams;
-		}
-		new_stream->id = fwspec->ids[i];
-		new_stream->master = master;
-		master->streams[i] = new_stream;
-	}
-
-	/* Put the ids into order for sorted to_merge/to_unref arrays */
-	sort(master->streams, master->num_streams,
-	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
-	     NULL);
-
-	/*
-	 * Clear after sorting: RB_CLEAR_NODE() records the node's own address,
-	 * which sort_nonatomic() invalidates by relocating the entries.
-	 */
-	for (i = 0; i < fwspec->num_ids; i++)
-		RB_CLEAR_NODE(&master->streams[i]->node);
-
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = master->streams[i];
-		struct rb_node *existing;
-		u32 sid = new_stream->id;
+	for (i = 0, n = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *stream;
+		u32 sid = fwspec->ids[i];
 
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
+		stream = arm_smmu_find_stream(smmu, sid);
+		if (stream) {
 			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
+			if (stream->master == master)
 				continue;
 
 			dev_warn(master->dev,
 				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing_master->dev));
+				 sid, dev_name(stream->master->dev));
 			ret = -ENODEV;
 			break;
 		}
+
+		stream = kzalloc_obj(*stream, GFP_KERNEL);
+		if (!stream) {
+			ret = -ENOMEM;
+			break;
+		}
+		stream->id = sid;
+		stream->master = master;
+
+		rb_find_add(&stream->node, &smmu->streams,
+			    arm_smmu_streams_cmp_node);
+		master->streams[n++] = stream;
 	}
+	master->num_streams = n;
 
 	if (ret) {
-		for (i--; i >= 0; i--)
-			if (!RB_EMPTY_NODE(&master->streams[i]->node))
-				rb_erase(&master->streams[i]->node,
-					 &smmu->streams);
+		arm_smmu_free_master_streams(master);
 		mutex_unlock(&smmu->streams_mutex);
-		goto out_free_streams;
+		kfree(master->streams);
+		kfree(master->build_invs);
+		return ret;
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
-	return 0;
+	/* Put the ids into order for sorted to_merge/to_unref arrays */
+	sort(master->streams, master->num_streams,
+	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
+	     NULL);
 
-out_free_streams:
-	for (i = 0; i < master->num_streams; i++)
-		kfree(master->streams[i]);
-	kfree(master->streams);
-	kfree(master->build_invs);
-	return ret;
+	return 0;
 }
 
 static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
-	int i;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
-		if (!RB_EMPTY_NODE(&master->streams[i]->node))
-			rb_erase(&master->streams[i]->node, &smmu->streams);
+	arm_smmu_free_master_streams(master);
 	mutex_unlock(&smmu->streams_mutex);
 
-	for (i = 0; i < master->num_streams; i++)
-		kfree(master->streams[i]);
-
 	kfree(master->streams);
 	kfree(master->build_invs);
 }

-- 
2.34.1

