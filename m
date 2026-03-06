Received: from OLAP279CU001.outbound.protection.outlook.com (mail-norwayeastazon11021092.outbound.protection.outlook.com [40.107.157.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4083446B7
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.157.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788984; cv=fail; b=eUXG85CHM+4B6sh9viB3C3cqMjb8tsgZuIGqJGHArSXmRflLe927ugDLoWUDomFcQNMZtFknWJimENJvqG0a3YCT2+47C1VHDUCqDqVtVyLCi9lDGuMYqwqveNWoReK9CwR5tSI6E174qvnqWJGO+rCZngT8FC0Kne8OkUNnWhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788984; c=relaxed/simple;
	bh=h3XTxdJHnEXxK43BW2PY8HlvNru6C5VpLLfX5ItlROU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LPj8gFdbyKDBts42b0gax/kwN92/k5zGwCCSBGRCsfQdylerX3FlumUJ39eSmkKSQbfReOvgzVl3Mkjv9fihhU19w4xxE8+TT+1zveCmf/BJNyteDqJ7YEztCU/U3r+owbK92g/bmC/layfPSqnc+USAj6sjeKyiZAtWdyjAPAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=d+orE0xK; arc=fail smtp.client-ip=40.107.157.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="d+orE0xK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lV9FBIrNViyyMUuQ8ARpxWhrRmOJBVX4MHvDkE0lKYat1bE72AfveJVegeikY1tL8o+3USiqnpRaTD1VKl3WTfD+FeRGwovdd+105YTs/G0vwmuitvRAdJVk0Udwvw7QHUTUQC8QA/3sKFXVjYF0PyLpVkhuGomZp2iaxyFLeu41X1+5NF+rO8+U3dgxnUYs+fe18qhc/xB2mSfkwnSOie1pGADDj3za7Tt4saEgUqCN0WXZ+fsUSMJtO04swedupLPxKZN3sZLz1avrUH0Oyh3KLqLG2/eDcfgFTRdzxN20jfWkXpZJUnOZrDox75RehS8r7HHScCxDMVvQp2bicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6etFIiMllfRhkM+Pu4GgcEgd71w+oLRDTAR19fWzU5Q=;
 b=XMQprhz3cQmttcVbwROcP+ImAySeauO8bqA1XAkRz1+hfGZ0WqF1pZvx/17ypiCKYjRHyc7lDgurceT48lj2oEIuVaDmM/8j2AakHD/BPPtDpOYROcy1dli3FpY1CVDVUqE4UDYd/7zKFDu8qJwtFYr0tLAAUKC78xK58jHH9GYEFFgIrV85V+gngYwpY4JYQleseoT0856ui5oM/AhtZNpj4axSq9Mj1o8NtwE+idoJSRdvxtUX3wSCeZvHpi7TdpsskkvZ04v5CjGqh50Z6Y1Ro5q4AbSZwJiUZ5r1Oe0RwIxaHkjBHU7n5c2OuWjLERC315RvcRc1iQ9e+q9JOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6etFIiMllfRhkM+Pu4GgcEgd71w+oLRDTAR19fWzU5Q=;
 b=d+orE0xKxpsPlziT4GN+Awplx7WM6IoUAuNJJt85kbGkooYhpcVruw5hjAMe3QZc9V/plIC8bOwHq621nYuwI06vQwyr4owCE1OrXLcTIvqPjvhTK+le4guAR2pJ03gz64TnlXa4M+ROs3fTckfyXUfizONfDNbR7DLaUUI9/Zcfah0FEfRUIybvprodec0iM9La57aNIFPvQCOmIklWVXZ+7tNV2I0T7Ce927cu7lXZ0fRu4SU+Ukico6sRBT0cBn3EKBOpCBybovjP5VgWF4XfdgkmtHfVUZ3SIfqo3GLJyJucR8+h6aSC4O08QjzGu2O4u7CUXfag65NYF9jS0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS5P279MB0536.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:20::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.19; Fri, 6 Mar 2026 09:23:00 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 09:23:00 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dhsrivas@amd.com,
	Magnus Kalland <magnus@dolphinics.com>
Subject: [PATCH v3 2/3] iommu/amd: Track PCIe DMA aliases in set_remap_table_entry_alias
Date: Fri,  6 Mar 2026 10:22:29 +0100
Message-ID: <20260306092230.132183-3-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306092230.132183-1-magnus@dolphinics.com>
References: <20260306092230.132183-1-magnus@dolphinics.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0095.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3d::17) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OS5P279MB0536:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9107e2-bc7d-4996-2a0a-08de7b61f5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	UoTsorwMKTMLrG0gKS6Id0JVrv+x6JYQaAk7pZLZ/dqFcVynzhf3Vb6iZNgVbitZqB2HGWtmOppdhnXMOU4QcPCnLHEfx+tQNxQs2ZVIgH7bviW8BG8mniD6kyPhU27pxOOkV2G4kbfntuDJAaoTADGC3O5TY25xDgBv6QecAq719bS8VtK2PzbdsIII4EfwkHuinEJ+GAXmN7Q2WC1VR7jQ7CQudJElo6AkzQY4k6wWNNFrdvpL71A2dSAPn+KV4sPE+Rpo/Pko4K84c16fysb3DvTGPSlD+2aXTMyJiobRLJD6bBHHv7/xsIF/a5Kge7UdN4R204pEr4gnU1ByTqmm2Dw6Bn+649zBKH4COWV0ksTdni5Dor+YBrQMlgs2868kN6UyjxbXkkm8ck9csP0/jpNvyyU+ofIYjiMygYYv/M314ug4ybz7ENI+cA6cGPxW9s5oMsPg4VIrn1yPhZJacxgyNfilhkCwZxzYhzs2+jOpqsar5WbdZ6akQnqFpoLCDT0jqXW8N2s1gXsZhW7OBmuSkARtK4PVQGCMj92TWEffEKLqWgEL80vt8ndNJ6M5Obd69XskIYTVyY+0nbK70X7vmvRBoi47p4QdglwI2oISKND9qj5ajLYPb9xGGwRpKjXGNqptjYR+c4GiXlGwdNw6gtscSdLlYUUrWn7gbmOhAkVarfvjrEUJigzGpGFoo2m+KCEPlbe37CI3A0/yh4AjYIdxEzOf0nHnCM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PdhgIeLXkqj/1kjQ20pXO8WBUr9mWbCl0kkxRfzyMsG2VB85XeM3ou9DKcm3?=
 =?us-ascii?Q?oLMZhnrtHm22PsvvKUIiaEFc/U4PE6PHItZxuAoOco9tWpO68ISsIFWeGKoC?=
 =?us-ascii?Q?4OhRr9M4UnutMazQ7zBGE437f/MDJCUzKC16EbtMoqDIaLlRi6PCRwEoVBhF?=
 =?us-ascii?Q?LEw2k75AD0LNxGgNE4TXDu4ynCyiP41gEvB0Olm9zCTh3gGzrzrUDzWGADXK?=
 =?us-ascii?Q?zcSeZ+kBQ4gf74j8j5dUzHzO6MSmEmWqx8Z7ZL8Dmhh+JJtgAPNiiS3Cv93k?=
 =?us-ascii?Q?LIKdpZ0LP/DwM/eZUdUVYKxI/+icfBCCo2yswXbmFTpS0R1pY0p3XsnQKjzF?=
 =?us-ascii?Q?EbKwrL0WWN7537PobZqebw8DPOrOVNgYD/k348WiAVMy71pjqXeQm1P6A6AG?=
 =?us-ascii?Q?kPKJXIpSjrD3AyWzPdBCYi6Sf0ejtqDzW4Pf0DYYLHtRQPLLW7VxEoYpsML6?=
 =?us-ascii?Q?rOFcPtU1dxtQ6xanRR6C/gbwOKfECauz2GAoX5nz1FmybqrMEm4se3gAz950?=
 =?us-ascii?Q?qbWOy2HK0DF9u7N00eP+xSB++4r+RWXzlkZW/Ik0eFPgqc5Opi7zQ+JtDfPT?=
 =?us-ascii?Q?9gbPVzrH8MLojDkRyAP0MxrjkM1vPKc7sDq3QYNyqfwyC5IFesU3W8pzq48g?=
 =?us-ascii?Q?bAbvkc00h0qRrrBFAbW5nG/SZmFlzY5tB0n0kOUxXhEp0T4rc/vRoOVVj/CQ?=
 =?us-ascii?Q?UP8k7LTeq7uT8hUNEvEFeJ30A0psS8WsOLW2KqccWHPLSMYEiZGNSXRCIQ//?=
 =?us-ascii?Q?fOCQuw4c1QgC5c81is1g94W8sguNNtU7HU/V9q0rFfpshjSewMTLjmDOorT/?=
 =?us-ascii?Q?X/E1YmyhVpcGfKWvMBzAsBXy7+RthkluHe0swOrfUQr1zTjECr3Q4+dfMiCt?=
 =?us-ascii?Q?3DaM0odDa2Nh7NWGJLBUs35kSig+gYhN6t707ZHFGmMYltZPUP1dpPJvVN65?=
 =?us-ascii?Q?xOO110Ulp3Bn9DLtVI3e4QTWJF9a0RgrW9qBcd0DBdV+fbgjIDNGj4cxPwcV?=
 =?us-ascii?Q?yy7vOz2sJYK3RFz1FTFz2StfnShDWGeCE3YJ4LuAU8KWAO/tz5m8ihQ83ruN?=
 =?us-ascii?Q?whOxpKsYF0YKTYU9D8mUR+JUTXj8fbBEGh8YTPRN9l2CWyyW1o9Hb0uGedmH?=
 =?us-ascii?Q?6eMo3C8e7fdrSWzj79a1VrtP3j0E01+8+UArYHHa6CEq+P1LGzTCw8+TzTtH?=
 =?us-ascii?Q?QcmyCvTbh5K/bfjJaLN36nBSfEhescaVz/w1oNzG8NBnDtYcL5Iy3n7syF0k?=
 =?us-ascii?Q?Gu8EC8pByyw6kLm7262Uxs+RcInxkG/upRbwfV79f696vg5cCWtWQJNO9u6u?=
 =?us-ascii?Q?9qJm06ljQePN4lkxNdhKal9tnE44olR2JtanZ6ojvIgf+anS/tUPWY0FNPN1?=
 =?us-ascii?Q?V6orSBlyv74biU6nhb5+IauaCoUdMPzxZJtJkvGo8IjeqVh5EjMVJNrpiStn?=
 =?us-ascii?Q?hwTi7Cfr8DC1VZtzW+bBjEUe70iW0Q3nRVCREu7YL6jjeTE353/wZXGHW1V8?=
 =?us-ascii?Q?8eAx0lz6IS/Hk4FkJSui7oAQfXsWz6SpLUf8EMJ67HqIwQuiEXfOAejoV/LM?=
 =?us-ascii?Q?4Wf6/ZgnjMIUz0PWmHXwdeHVcM6DxreB0x6eTjh1WEtKzmjXsPpMxeA/nEVR?=
 =?us-ascii?Q?pVIF/IRZ5fe+cDWZhtjHODgGI31pC4hnD0dFtO3ipporHQCrtn8eh7DOdTbt?=
 =?us-ascii?Q?//d+6oNyFZ5g0NY6oaOQYAidzsG3Z65dpxEkE5t+ZugwqtxrjtOnf31LeZ8R?=
 =?us-ascii?Q?HE1eV1fU2Q=3D=3D?=
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9107e2-bc7d-4996-2a0a-08de7b61f5eb
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:23:00.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K40cv9tC7JXRfaB97X1xSuKK+EuaBRSWCC/MNnFbxNekJur+apbT/UCbHr6mCteeyy/XffUu6GfE+RLzTDJSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS5P279MB0536

Track PCIe DMA aliases in set_remap_table_entry_alias so that we can
iterate over shared IRTs by alias in iommu_flush_irt_for_aliases.

Signed-off-by: Magnus Kalland <magnus@dolphinics.com>

---
 drivers/iommu/amd/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f3193c6428c9..5dec3502c8b3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3280,12 +3280,14 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 	struct irq_remap_table *table = data;
 	struct amd_iommu_pci_seg *pci_seg;
 	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
+	u16 devid = pci_dev_id(pdev);
 
 	if (!iommu)
 		return -EINVAL;
 
 	pci_seg = iommu->pci_seg;
 	pci_seg->irq_lookup_table[alias] = table;
+	pci_seg->alias_table[alias] = devid;
 	set_dte_irq_entry(iommu, alias, table);
 	iommu_flush_dte(pci_seg->rlookup_table[alias], alias);
 
-- 
2.43.0

