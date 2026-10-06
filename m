Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF063E49D9
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288900; cv=fail; b=QDi5CK/Ej5M7bkr1sHI26fM2DxlmKW/71Qj3F313EfCaqYksX1kQBDpNtPWn9+e2BPdVFyyrd4sWCxPng73O4Lme8dX6G2uNBh3FZYeJtkVRWdnJ/uOjR7DpUm3XhKFQmTzqm3/67Jvo8I8+vxoQFTfGSfyrlS3FaQGW6JZ7CaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288900; c=relaxed/simple;
	bh=perWGq9E1UJjjStpY4QaJiq8ieREERiJ/QbQgB18yyU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j0vbcnVwJmNIfHI2G5HB+ySISLkprsMc/7Zr4jB1T7RPxuf6QRK8og32cMtjK20bFsqKb5+KU5gj04eIQkxpIQN/fl2GJDrukuexYyvGt/2dhvouv6Bd3eaRNZ6PtCTOLvcQOhsKBH5WPpZIwNGYQ2iDtEr9pFLPWNoG2MUZRI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R5EfQMv5; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R5EfQMv5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJfjXjWOXfKd1DlVgt2lwBR+S/YOtPM6YmappFviPGJcbASi0+f7hp1ZH6FLRY3CH00f6qNccWo1mNShKIEWN+3Awtk3nvA5nVySToTe8Ga0RUg2NEkIKupTcX5m4vuoq1WYgS9cY+i4pJSHDbf1Y5HBOQeCmglUp64gyiKMM+PCzDwMeUN6w2Wq8JvxSVFlL3fSKasAOwb/NHIA913eIWK4Z+4mDSXvFEhBi/emjJil0KcFuXKEYRrYayODgfP4FXMWgM7E7QFKdZeBRwSrBeLlT/Tu8svr8fE17e2C1dG4NF+c3mkMLi5iOzQqNKL3hUkdWCiBPk05gC8vUbX+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of93QaY6XIj65pBH2XAxmWVrhe9AOm3GOUOBdUlbxng=;
 b=EgI+clAzXs9MgXNvNm+hJ110E/erJX5FqKzuDTse0xbJQrK75wgef/rNjEPMtNotOR13Z/hUpZWzKS4HuTtNgnH31WXKYKRd4UVCqUF94VpnyCbW6E2A1NuyEQ4g+Wue6yRUb52dj1V4+zI8KlQ1i+jp0yGm7W2GrP8dysLZGsbBoUGMYJux7Q6HzpTxvZlA6H/AaT6jiXmbrd/Tk2wMgph7PibHcdGq6s/wUAm68yZXqBJL+34cJfbMqmx0O1JupmkU/xRquqOsC/8en70hNbXopl4vP5FXf0BiW+lwcZlb6YFEtvjCuiEoqxVmjaZBmRVVTfE0ftP/cTGmzVInrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of93QaY6XIj65pBH2XAxmWVrhe9AOm3GOUOBdUlbxng=;
 b=R5EfQMv5WTsjhyVps1WYuR0zQRWKHXTpbAGa9s9PuTtkZ5xQ1ob7Euhcv0tVi5BJU1veo+v2bEqsti/j6dbRq1m/tOdYJmuA3sxE2I5pYUjmYsCG5UCfJWgATBDZrpgbxu9AWas69kMm/wG3lQmPPrjeVxtv+mQ1a9XWHFE7Fx01FkJd7imWOLG809hlRYrhhIsbFl0C/pwGSabYPsqJzadWvGqtvr13w7mpcoZNYvgQhf1Y9pT7r7n8d7qdmvxMZOvJfQOPjB+m5/rCEnyBfrpW79NrAuDIX3CPVfulkIIpQX1Z7hsbpD2symo4VQKkoYenmrBs3C3NVgVIagNrGg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by FRZPR04MB12432.eurprd04.prod.outlook.com (2603:10a6:d10:1ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:14:55 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 12:14:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 06 Oct 2026 20:19:07 +0800
Subject: [PATCH RFC v5 1/6] iommu/arm-smmu-v3: Don't rb_erase() a
 never-inserted stream node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-smmu-shared-sid-v5-1-169a59c671d3@nxp.com>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
In-Reply-To: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Mostafa Saleh <smostafa@google.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5PR01CA0268.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|FRZPR04MB12432:EE_
X-MS-Office365-Filtering-Correlation-Id: f937277c-002d-42da-5649-08df23a36ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	n2GpAfoo4twfShPGqCS9HKx8eWPYAmJyxOMzTSSNVbYaqetfgBONHGocHXYpSKgJVmF1tbPf1cA/j1znp0HFPYuSJNjRdjjsUcBSGtlDX6ON0hcJXqMDrlCurlcX/7gQoWPVHiKHteR2ZuE6nAAdL5JIKtPj8Z5oCjWqd//eq4bvggvm0uEWeq5c/WTJxDXS3lyp1CQsIQBv8L4His5uKmZgVwEBJ2uLPtg1BT5k3xCLQu0vpezTQbaiE+5+gtHXCGG+eKOVjdO+aTR2xXKjaUb1HxOODSKD5Wmep9ZTXPKaMRl5LuXg/XxhU4Eu+0G1pCtVojylBSUsyPQAz9jbeny0jdYCjOa+LYqiHuowH/EdRZpTkg+GriLxC1+Sotgnlkpn6OPs4AMx2pFzDt4bFbcqpnKzk5igSn6Ig33H17En6XEgfT2sto1GhN6aaTBD+Xd4x649APa966jPl8u6K2FRYK3AbqXT1BcS5j5z57btRsCWBPAP/tAbo9Jw0Maa4twPaoaq7rMkH+c4llk1bkS6sr+8MOnWJ/r6s2lMFQu5UKsNgpPDAdUXcetNUbnT/BvbxsJuf4P1/zaAK0tXhHc4DDajN1tYXhLkWApUftwHdM+5RzsPQkGiB0SnBmFyZcnFwKljO1YPfT6vbpFvdhlFcqfcsxbxElVTkymg4Dl69U1YmCEXUmdexeslIQsVzsjcjN6F9plbPRrN4Bri7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTUzNlBLQ3RrNVg3KzVBN3NvSVRLb0d1WTdOeTlkd29XUCtXU0VyY2xtV0NG?=
 =?utf-8?B?MHZHdjc3MkRTYllJN3RmUFlpQXE2NC9EYklWZGlsZEh1eFc5blJ3cjFUcytY?=
 =?utf-8?B?RUZxMllJdDVTV0p3UzM4YWoxbDd6dmNsSHRadGNVbEVpVFI3UkV1QThZT3FL?=
 =?utf-8?B?YzhqNVAxVzhwSVVLeUZaU3g1QU1zQ1BVQXJWV1J6enpTYU5wUVd2WGU3OVVU?=
 =?utf-8?B?cHZYQkdxMkkxRW9jZFNJT0tEbmZhZFQ2UzBwUThZQXhQNDJEVno5RlZLV1E1?=
 =?utf-8?B?cnpyQ25TRzBFUWM5OGxSemhlaEZtQW4rYW54U200T3JwVGhiTmtPbnNDQ0p4?=
 =?utf-8?B?aFRmSTY2M0tYODQ4c3c3a2Z6SGhLS1dXZjZMZCswTk9xOWdvS21Ib3BBRWJK?=
 =?utf-8?B?TFd2UGdDTnhTaS9sR0lqOGN5d2ZpcUVQZlB3ZlJVUVdSdUxCQlViVk1JNzRJ?=
 =?utf-8?B?YmFHOVpmb2hydzhkVGVaL0pyV1NKNGtFVnRPWFN2U0tuMEJhTm1YVUg2eXU1?=
 =?utf-8?B?WGx6UkZvZGQwZTZpUVVHR3o0U3NtV0JMWEVFTG1JVXZRd05sYnArY2Qzdzhx?=
 =?utf-8?B?emRmNyt4VDhZc2hacU9GMUNoVkZnN3hsOW1iSml2MkRPZmM5RUlQbE13Vmhz?=
 =?utf-8?B?L0Z2TnFBQUVKOUlSWFBYNFpsR21wa3p0MFM3NTBIOHMzREw2MjlneDVjL0Zu?=
 =?utf-8?B?MldSQ1lROWpxRVRzdXVsN0lkMmZSaVFkMTJraEExY0JucmZ2Y2xYM1NHY0E0?=
 =?utf-8?B?cy9oNWZ6MjMxRGtIYkF4aTFEM0VjcEVGYkRNeWw3bGQxbkRMY1Zrc3B5bnRx?=
 =?utf-8?B?bmdiQ0ZrM1pGZkc3QW96bjZtUkZ4QU5JV3JPZGdjem5VeURsNWlZRkFJSldG?=
 =?utf-8?B?cUQ5enhHbW1yajJqWGFDZWhCUWZzb2hPODdsbmpFUXA2YjA4cGk1WjZoUmRT?=
 =?utf-8?B?UE0rdHFxWnBKZ0o4NlpyQ2pDc3hZeFpyNGdGenByTzhaZkZpejQrWFFEUzA4?=
 =?utf-8?B?Zm1vQlR4b0V3aS93T1NLejdiS1FBWU5FVTNkUUhCVHdyb0M4WWZtOFV1NTFn?=
 =?utf-8?B?bXVmSEQwaDVXMUw4K1JhQzZ5alJHSFg0cnN1UmIyb1ZiSi9vaFpYNWtjUTlB?=
 =?utf-8?B?Si9LVnpXTVhBdVVWakhyQngrOFV6eXM5QTNqNFJPSTlBUHpaWERMTGUvbENC?=
 =?utf-8?B?YmdtazZFYzRGVTQvK0NaTEVtYklzODFiVGxBZEpDZWZkUnNHbFRtam15L0Nr?=
 =?utf-8?B?T096ZXZkd0F3TkJBaW5oQ1JEZmtJV3drSGxxR3Y5WENPRUtkY2RDTjdJdjRY?=
 =?utf-8?B?RTlJZ0w2UHp0c2l2YjM2b05CVGpYL29VU2xQTjNZS05yNjdFeGJtbysxYk0y?=
 =?utf-8?B?dGwwUzlEMG4xTHlKemVYVmdhVU50NWJtYkhsZHV4cFhzUVNiUFNMbVo2aEJI?=
 =?utf-8?B?cnJuTURKNXlCc3JwQUJqSm1PREpRRHIwYmppQ2tsRU8xbUxoKzFXVGhqNllO?=
 =?utf-8?B?SjFSK2Z3UnZOVW8zY1JhRnRVeGJGL2FrZ09GL0xyNnkrRUVJSHJaOGVHOXZ1?=
 =?utf-8?B?WjltbEhmaUJma0RYZkFFc0d6OGRqeHUzREl0ME9hQmZZcGYrdHd0RVlIV1Zi?=
 =?utf-8?B?bENiajc2U3NvMTdjc3R0NXRYNEx4dm5rS1dsa0l6dXhWK3FrbGtaVnByNEkr?=
 =?utf-8?B?OEFNRVQvekJwWFR0ZTZvdFV0WDZrcGNqYmdjS0loSUpFc3FvRWFGT1pTQWVs?=
 =?utf-8?B?b0RQUUFSTTNXY09YbnhzZ1RjaGtmQ1pjOWlkK0VsdmNXOWRXWFBSN3F5c0Q1?=
 =?utf-8?B?M1lGeC9wdy9adjRHbVNVSFVMdTN2K05YbFozWTYvVlY0c2ZkWmRzMFhLeDd3?=
 =?utf-8?B?eisyZGRGU0NuWWRvOWRudVUyYnJNY3ZUbkk3VEpSV3hMS1JJT3pjdFB3cG1i?=
 =?utf-8?B?T29yM1hDOEpwcDgyVm1CRTQ1TzhBSjBuK0E5VTJyUVVISEtnaUJiWDZ2SDBE?=
 =?utf-8?B?bDU1MW9xbmJTQXRhNEhSZGNGUkdVS0Q0YjJqU2IvcElMMTU5UWpHTmFKV1ha?=
 =?utf-8?B?UHpNYitUdVU0QVdkWXNpNThWL2VnU3lNb3NPNUFBV0szMVdVM0V5cU9mQ04v?=
 =?utf-8?B?aDVqMnVzT3dzTUNweUQwMFlJallGRUdOb3ZUd3F6WnRzTk50UFM0bkRQNkJn?=
 =?utf-8?B?a0VLaFRCRDJEanRyb3QvRkVYdmd4c21TOGd5aTRrQ0J3NVZWRUVURlVnRFdl?=
 =?utf-8?B?UWVPaVJNeDVpUlpTcHVpM0VMaDZmN3ZRblhYcHhqZnhaaEpqaVBmd01TMUJt?=
 =?utf-8?B?UDJoa2tLa1c0cVVSb1NzbGZlYXRYYXJrSVFoaW1IOEhwdTZXYUdqQ0Q0Z0h4?=
 =?utf-8?Q?BszVnhLRm3TRySkNTexOl7DKuLF9V+zCl86s+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f937277c-002d-42da-5649-08df23a36ed7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:14:55.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZK1Z8FBU9649bZCCZieUFMu9PWVgLwerCKZHMPRwn40dHvYKvZEq9LsMz0BCpcwNgZIWTpYVjmR1fCGlZ9bOoS4KgvUWdXftOh8XKdIggYDtEohSPtj4YstPRZUFyr2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR04MB12432

From: Nicolin Chen <nicolinc@nvidia.com>

arm_smmu_insert_master() skips inserting a stream whose StreamID duplicates
one the same master already owns (bridged PCI devices can present duplicate
IDs), leaving that master->streams[i].node zeroed and unlinked from the
smmu->streams rb-tree.

Both the insert error-rollback loop and arm_smmu_remove_master() then call
rb_erase() on every master->streams[i].node unconditionally. rb_erase() on
a zeroed node sees a NULL parent, treats the node as the tree root and sets
root->rb_node = NULL, silently emptying the whole SID tree and breaking SID
lookups (and DMA) for every other master on the SMMU.

Mark each node with RB_CLEAR_NODE() after sort_nonatomic() reorders the
array, since sorting relocates the entries and would leave the earlier
self-referential RB_CLEAR_NODE() pointer stale. An un-inserted node then
stays RB_EMPTY_NODE() and is skipped in both erase loops; inserted nodes
are linked by rb_find_add() and erased as before.

Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 98f105798b89a..dba6c2942af8f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4122,6 +4122,13 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
 	     NULL);
 
+	/*
+	 * Clear after sorting: RB_CLEAR_NODE() records the node's own address,
+	 * which sort_nonatomic() invalidates by relocating the entries.
+	 */
+	for (i = 0; i < fwspec->num_ids; i++)
+		RB_CLEAR_NODE(&master->streams[i].node);
+
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
@@ -4154,7 +4161,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			rb_erase(&master->streams[i].node, &smmu->streams);
+			if (!RB_EMPTY_NODE(&master->streams[i].node))
+				rb_erase(&master->streams[i].node,
+					 &smmu->streams);
 		kfree(master->streams);
 		kfree(master->build_invs);
 	}
@@ -4174,7 +4183,8 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++)
-		rb_erase(&master->streams[i].node, &smmu->streams);
+		if (!RB_EMPTY_NODE(&master->streams[i].node))
+			rb_erase(&master->streams[i].node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);

-- 
2.34.1

