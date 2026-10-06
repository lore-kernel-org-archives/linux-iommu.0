Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D25392829
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288895; cv=fail; b=P3PTki40Pd76jWz02uIYsWBjU4ep916T0uMQBbl6VYezFJ81luljmqQw0U08GppAPqXQgasCx6Nde4Mbz7xTzyN82qthE3adxFUdqX63hIev7YUaLSvmYD8i2AloCJ5cbvPR8BruFeuNN+opcnkkcvQM6te2SKj8OwFaGHsCYEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288895; c=relaxed/simple;
	bh=t2DbNhqmuzL1JgrWTCjCuaN5hh6UWv3AMNFEIcXXiko=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=u3PHaHelcJgjh8FwnoNiTNfGUil+fFOFjUlAnnBBO/S6kXGDZ/+/ozz1wX8+nhAAlGJ5R039uFjGDFMqDJwnziafTao7XuyenfGZgPAYFFjtNyNyAkVVYvuRprfQcUUVTlHUbUTjazAhOOV4olgYNdzhkSsygu08sTvMs1I5AAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=K7c79eqh; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K7c79eqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTU9RpBg1jOTSFGcijas0vpnn2YBMbe/9ryI7YbKJirzdq4sWQy7zn61x1e+Wgvr/NhIMTlF4pq/akhKJlbIKzUNzsLYAeq77lWVnuU/kXWyRtaKTsOtlgj4hIqe4VhQ/aj7FYi3RzGrETOhwGqt5FSN6CfvtdLB3roCB8cCcxXXEBC49siK4rb+LbEhWxQtjDM3Mkj8HhcCZpeScHME78n1BME01IlGBlCKGj4/XNAPxvlVz219tpWmCQ9owgbyYHHXDQhNSxC3Mhu+9ZpbQj5b5ukmXtv+BQyOgnB/EFIPYnnGmhsgyJs718A8xY3jwD+vIIYgizXA7xtKeanr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqWd/7B0dxLPU1n4dfHMHURXPc583Z1IyYZXvB5sPVc=;
 b=UKnsbgFX73bXmH773SC9OXJkEyUrKRzAmeuIZ3cxg3Kh0p+1OCe8UVt9r4JgvT45QShQr8j+cWViXMCv2RwH4BwXNjIQq5+Rx0YXKjPwy2i/9EVPwwkgzprfTPuTogFocybUU49Oach41HT8T/be73Ke/sxBhct940AFhg5ZOoQQCFWBGBSdy5k+FIyTXnewXFFQbNsjUY4tanqt/zh0qsLLv+jFh7iAKVy+ipFL28MbbpgSmc0JD0EgzkQhArkC6hC/ipjMFquC+ZdeRqw9SFmiiJWtydcICTVb5rdUyN3E1QxWvuLIC7dRTQwBcIPd3wJnGMRNpiy2EEDzWvN/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqWd/7B0dxLPU1n4dfHMHURXPc583Z1IyYZXvB5sPVc=;
 b=K7c79eqhCB5R3geEGe08ldXSOK97Jx1pqzK3ehGpFpQJBT3cEd6Q4YKEVRbmS1eJb8iaX9IFcokxSnvfwtrcAdVTv6r8juwXb7HeCABpWfWGcYwmt3SfqvmVnQraIgE7r9SDxieooS35i4AXl5i3jFlYqJQytZQ9EfCUyk7tnN1YBqK90RtKnb7NUGTz0AW67nUXsZPxO85lMzLc/NotJfcpYwhBXG39YEWqD+anMMvXSVFct3gP68rgZ9lZJFbvI3vYLsCQqWyA2dONqy4qlC5OtxT+qIq2ac8+B5bKnSRQH7EU1iYDpr6YrOQWTCHuAP7mTFFtuKVh39jnOYRrmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by FRZPR04MB12432.eurprd04.prod.outlook.com (2603:10a6:d10:1ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:14:49 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 12:14:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH RFC v5 0/6] iommu/arm-smmu-v3: Support shared Stream IDs
Date: Tue, 06 Oct 2026 20:19:06 +0800
Message-Id: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADrnxGoC/3WNwQ6CMBBEf4Xs2TUtFkRPJiZ+gFfDAdtF1qRAu
 kAwhH8X8OxxJm/eTCAUmATO0QSBBhZu6iUkuwhsVdQvQnZLhljFqTrpFMX7HqUqAjkUdkgmy8r
 UGmdKBcuqDVTyuBkfcL9dIf+V0j/fZLvVtWIVS9eEz/Y76A3+ezFoVJjo4yEziTIF0aUe271tP
 OTzPH8BcwK67MMAAAA=
X-Change-ID: 20260916-smmu-shared-sid-e488f6c4d4f0
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
X-ClientProxiedBy: MA5PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|FRZPR04MB12432:EE_
X-MS-Office365-Filtering-Correlation-Id: c34ff6f1-e3d1-4c1a-dbc4-08df23a36af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|10067099003|56012099006|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	DPdoZxwrxyVHgFuI3TQ18O3meFjGBMoNhP3huMCoT6CiygduTyjjhl28AYjQdl7M2267+zLE/ScfNsZopHPVJxlFm40Mj4KdbdW8rEnYHOtK1wgcbcuycOWu7ayPH8RfbGMnPgEOYKTRUA3sWHPqcyVG8bi21lUt3QoHzl0Auu7DDrCBbzbCOJU5I8rz/olB5ABGQ9pDRJzaaK4iBt6plhKu2YiZmHtxWbqpJIeskrBXNj6vowjhaV4D9axWqeFVrmk2Jld9CLGE9ED/sl3Abzs3K1H4YDOhsxa26dm0r5ZMhtWzOUI6yzumAEKTeRvTmeSrCock4vYSHpKof1/7GLggvgt/n9mmQtgTThxgTbq5f228tVKLaM5S/RYDb8Z3hYNxTsfDtElJwHVAivxQCRLNxb/Subh4AErfsheN10VCjN4QHgKxGpLMZ+BBR2EbI60lbOQ1nM6j5iWKSmQlyT4YcW3M3uWoeWwfA9DAXbOP7JgWMQTCYkR0vjzTzHF7V077qDrQeRWFo28p9MFxbGT82BJGdY9QSr+vr9RMTMa9swSpyCGpeAtehVF6erPqV3VuEFTVCfOjKU+pUfkN72E2QGccAR8g4w99H7x51WlFn/uJsMezE+o6H82s3PB0scb5QrmNYzlC5Lx+yIQIxSHBKK/d8UzW0SrVuT9nGTw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzdhSUJlQ0JVcGZHMEFRSDBlNHlSWFhmU3BUazJiQXl4dUlGemhyajFhSWFJ?=
 =?utf-8?B?UURKdVFuK0cwSlh6SEtXNjJGeGVBOXBPNnVJajE5aWtnbTNnZlVEWWFzRnpC?=
 =?utf-8?B?U2hnZDg0d1M2cU9yUld1OUZVNXZJY2g0dGh0clJQdTFnR0NOMGR5RDJJOVdl?=
 =?utf-8?B?NXZnUHIzNHVSWEZiejE2WExlMVhTbGI4TEVQdmkrek9FUm8rTFZQRHpUUGVR?=
 =?utf-8?B?RStDM3NQWk5idmsvb1dCd3JsSWxMUDZBT2gvOWV4WmplL1NIbnhpQUdLZlRq?=
 =?utf-8?B?YVQyVURmdUx5bDlCbGxobUxnMHc1SGVGWUZWODZEL1RLQkxjWWxyQTl4dyts?=
 =?utf-8?B?Vll2Z1dUbzU2U1EzR0NBRGg2RDNSQkNPOC9UN1dQcHFZa0IrWW1ubzgyRWlL?=
 =?utf-8?B?K1FCc1poZzRJTW12Yi9pMW01d3o3SnBTd1RUbGFITTh3SGlkdVRZSVJkNkRv?=
 =?utf-8?B?VlZ5eXdKSzlSMVA1K05hZ2E2cTFySDlvNkM3M0xEYXZHakl3UGF1SVc4U242?=
 =?utf-8?B?a0ZiQmw5N0hSMk9hTGh2QkYrT25vazZicGxhcDAyeTlvNm04U1pFcnIvQURo?=
 =?utf-8?B?QmY2VDhmRXFMeTJUcjdMa1lJNUgzTG0xbUkva0IwdTVmQWpIK2M2T3Z4YlZn?=
 =?utf-8?B?YkdIbHhmTmtCSlpCSmwxdkROdlAyUnQrOGFnQld2REJFTzFnWVUvTzlCNU4x?=
 =?utf-8?B?N0p6anRvdlhJcnZBQkl2Qyt4RHB3eFk5M0Z6NHdhVDl4bVVac0tyQ2pVc3ZG?=
 =?utf-8?B?Wk1tam52UHFiSENjK002TERKYUdHMGVUdnRTSXRSemRSYy9QSnprVlJ6czFy?=
 =?utf-8?B?SlJDSVRxTXZWK2tnMHhyQ0VKeFU1RGxFcHVXeVVRempkWjdZb295QlY0V3VY?=
 =?utf-8?B?ODVqcldtQWZtTmxYNlFKTWVUbVE3VGNZMmN2bTVsT1YrSmFBR1V6blNselFn?=
 =?utf-8?B?R1pWcnkvcjc1NDg5UkpnL2w3WENjMGFlOWQyRSt2bzlVZlNlTXFkZmc2eGJU?=
 =?utf-8?B?eE9UMTBaSk1ZcTJ1QjBDbWh0L2gwbU9GNnBia3JvbmVCYjBlc0ZzRW9OdlNS?=
 =?utf-8?B?b1ZXYit5TU9USnRXU1cwNDVVdlZBVHBBNlZsTEdyR3VsNFF3LzRHL0ZITFNh?=
 =?utf-8?B?cGs4cE5WWSs5WCsrSURnNWQ3M1Z3QUNYRktNOTU1M3hKeGRvMUEwRC9aUmlI?=
 =?utf-8?B?UE54akFRc2NFc1RMaGJrQ0hIZmc5UmZEUlZzNDVERG1iWFpQeEtYVE9pd0RW?=
 =?utf-8?B?OUI3emY1VU5NZmZqTTRtMjdzcW12ZnNoWmFocDh0QXphVDJnMFJCRTRvdmdG?=
 =?utf-8?B?ZHBpOTFUaXZMaEpNSkJta0VQNDNGcGt4NGpVRmxocG42OXJPUGU3ak1HRUVR?=
 =?utf-8?B?Vnk2alRkQ2ZUYWFIL25VYVJCNXQ2cGllSmpGb3cxTmFKWUpTUndMR3hqZVJt?=
 =?utf-8?B?Yi9oelU0eFVlTGF2eEQ2RjAzNUc0Ny9FNkg2M05zSTlwN1JhUXFYVURkM0I5?=
 =?utf-8?B?TFhHTXE2SFpMSStPN25sRWxXalprSGZVNFQ4NjFIdExDREhUUVpuU1V5VnUy?=
 =?utf-8?B?a29EelpGdzZIR2JRaElNVC9xWEZmVUNBcWdnd21MN2Y5ZXRvL0piVkRTZjlQ?=
 =?utf-8?B?Sk9kNUN1YVlNQnBlMVg4ZUhHdWlmZ1lvdVIvTXV0czJuRHZYRUlqTDhUTXo1?=
 =?utf-8?B?NUVvbmp4RjVqdHl0N0FZWmlJb2d1aGhPblE5RXh6bnBLbmhMTzJzanVDOXlC?=
 =?utf-8?B?SGR6ZXZMeWJKSjU3TVFneFNjejFTTHhXUnMzZ2paL01UZzAra2swMThGcVlo?=
 =?utf-8?B?OEFCeXhPd2VKeFdobmtkcGVzSW56ZmhDN2NZb2RPOGR0c01OVnlrSFBLbGh1?=
 =?utf-8?B?dDNkckpseWtMdzBTRDN4K0tJdjY3YU91NjJPM0ZHVC9DS3c2QVliWmhiL3Q4?=
 =?utf-8?B?WjRkSGdwaWJTU1IvclA5Sks3UlVHT2FRWG9lR3V2VW1XVFNjQW40MmhHaUFa?=
 =?utf-8?B?QWg0QkxxOWUvS3dHMTZlZGJnSjRwTDFGbXBOTXdCbGtEY3NEWDdMRUd4VkVv?=
 =?utf-8?B?a2xxemZmK0dLUGpYRlJDaVcybGtXd0Q3SmVYOEcvdW4walJJMjFWRUFXTVI2?=
 =?utf-8?B?dEdOSkx2bytrQk0xamJwSEF2dE9Gb0lwdFVDUlJuNEFmU3V0Vmo4aHJid0VK?=
 =?utf-8?B?ak81WUQvd1VPT0F0VGNlNmtYaVhoNWYrMk15Q0VBV2ppU0d5SHB5eWIxSXlz?=
 =?utf-8?B?aUJBdnVtR2V2R3I5MFlGd1BLVUhFZ3hPVmdWY1lxYWRRSnVuVXl5OWxZcGFG?=
 =?utf-8?B?ZVRjd2dGUTg5TjFveFYwZjdtSzgzWW5Pa0pXUzcxSHJUZWhkYkR0bW0xMU1H?=
 =?utf-8?Q?xEJ2TUmIXt9K+JwYJyKGDYVZN9dARAkNH3o4T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34ff6f1-e3d1-4c1a-dbc4-08df23a36af8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:14:49.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOgzT8FPA/b8A4w1JNXjQehU57XFApUmgcSAfwLStOJfSNhJtyEUjqdLDZjjOwPH0BvbiVP4h/87PDo2fgDemnGAehtaTVHUrn7ouZZITgdjrDT6tc6AfjuxupdfPHx1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR04MB12432

Changes since RFC v4:
- Include Nicolin's patch ("iommu/arm-smmu-v3: Don't rb_erase() a
  never-inserted stream node") to avoid conflicts in future.
  so the standalone patch 1 from v4 is dropped.
- Split old patch 2 (shared SID support) into two:
  - New patch 2: Convert streams from embedded array to individually
    allocated objects (struct arm_smmu_stream ** instead of *).
  - New patch 3: Move stream allocation inside the mutex and look up
    existing entries first (find-before-allocate), avoiding unnecessary
    allocation when the SID already exists.  Pure refactor, no
    functional change.
  - New patch 4: Add shared-SID logic on top of the refactored code.
- Duplicate-SID cleanup (bridged PCI) now uses pointer-equality dedup
  instead of RB_EMPTY_NODE checks, since streams are no longer
  pre-allocated with cleared nodes.
- Link to v4: https://lore.kernel.org/all/20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com/

Changes since RFC v3:
- Added a standalone bugfix for duplicate-SID rb_erase (new patch 1).
- Stream structures are now shared directly between masters
  instead of duplicating them (Nicolin).  No ref_count field;
  sharing is detected via list_empty(&stream->shared_masters).
- On owner removal, use rb_replace_node() + list_splice_init()
  to transfer the RB tree entry and shared_masters list to the
  next sharer, avoiding use-after-free.
- INIT_LIST_HEAD(&stream->shared_masters) moved after sort() to
  avoid list pointer corruption from bitwise memory swaps.
- Both sides of the sharing pair are checked for num_streams == 1.
- Link to v3: https://lore.kernel.org/all/20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com/

Changes since RFC v2:
- Dropped the RB tree to XArray conversion patch (Nicolin).
  The RB tree is retained as-is; a new arm_smmu_find_stream()
  helper provides stream-level lookup.
- No per-master shared_sid bool; replaced by
  list_empty(&master->shared_masters_elm) (Nicolin).
- Only SID-sharing for single SID device
- Follow Nicolin's suggestion https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
- Link to v2: https://lore.kernel.org/linux-iommu/20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com/

Changes since RFC v1:
- Revised cover letter to drop eDMA channel example (Jason).

Some SoCs have a limited number of IOMMU Stream IDs (SIDs) and
hardware that inherently shares them. For example, the NXP i.MX95
only has 64 SIDs, only 6 bits for SID in the system chip bus.
However there are many device IPs, such as SDHC, PCIE, NETC, GPU,
NPU, Display, VPU, ISP, ISI, JPEG, SATA, DMA and etc. Each Kind IP has
mutilple instances inside the SoC. So I introudce this patchset to
support shared SID.

The current ARM SMMUv3 driver rejects this with:
  "Aliasing StreamID unsupported, expect DMA to be broken"

I took comments in [1] and implement this patchset and only want to
support a very simple case that multiple platform devices share one SID.

Patch 1 converts the per-master streams array from an embedded array
of structs to an array of individually allocated pointers.  This
prepares for subsequent patches where multiple masters will point
to the same stream object.

Patch 2 moves stream allocation from upfront into the mutex-protected
loop in arm_smmu_insert_master(), using a find-before-allocate pattern:
first look up whether the SID already exists in the RB tree, only
allocate and insert a new stream when no existing entry is found.
This is a pure refactor with no functional change.

Patch 3 adds shared-SID tracking so that when a second single-SID
master registers an already-owned SID, it joins the existing
stream rather than being rejected.  The stream structure is shared
directly between masters via a linked list.  On removal, a shared
master detaches from the list; the stream and its RB tree entry
are kept alive until the last master is removed.

Patch 4 places devices that share a SID into the same IOMMU
group, ensuring they share a single IOMMU domain (required
because one STE can only point to one cd_table).

Patch 5 wires up STE write ordering (first master writes, last
master tears down) and gates features that require unambiguous
SID-to-device mapping: SVA, IOPF/stall, and vSMMU nesting are
disabled for shared-SID masters.

[1] https://lore.kernel.org/linux-iommu/DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Nicolin Chen (1):
      iommu/arm-smmu-v3: Don't rb_erase() a never-inserted stream node

Peng Fan (5):
      iommu/arm-smmu-v3: Allocate streams individually
      iommu/arm-smmu-v3: Delay stream allocation to inside the mutex
      iommu/arm-smmu-v3: Support shared SIDs in insert/remove_master
      iommu/arm-smmu-v3: Group aliasing devices into the same IOMMU group
      iommu/arm-smmu-v3: Wire up shared-SID STE ordering and feature gating

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 236 +++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   5 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |   2 +-
 5 files changed, 186 insertions(+), 64 deletions(-)
---
base-commit: dceac7e589200a458860830d783b90dfd471691f
change-id: 20260916-smmu-shared-sid-e488f6c4d4f0

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

