Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013017.outbound.protection.outlook.com [52.101.127.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69168175A5
	for <iommu@lists.linux.dev>; Tue,  5 Aug 2025 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754361161; cv=fail; b=ifN5mUrHfltlKbrcy27P9tL0+y4VEcfzhWqp6Qswzoyv3qbI6I4ahfza28lKp9HSbg10lREw1ZsRZMxhWP0GoU8k1M5Hjb67+nfJmUKFwd4kIDAhpUw3OsuSVFNWvkHELo/tmLX6r4bpvHQh+LTcFlC0n5/JqnIE1NOdYB3OGDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754361161; c=relaxed/simple;
	bh=J5RoG/zJ73Kug/jBx9OoJK/kOVrFfelJiETmyuo8zGA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=geb6VV8c43XrEgxbpFCDNjZYFm1OjybFMy87Cb+b25Pk2o77GD6XvqcvYeF6GPO/2n1LQ3UPal7NPpWOA3dh4TbtWym0cCaAnOL4PcSI24wnVYkxR24BpvvuaeMoy7IgROsJk2NIraTdbARom69g2z5ESoDIYduetIQWb3pKp98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=L+OnEqhr; arc=fail smtp.client-ip=52.101.127.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="L+OnEqhr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGJmPtrny4OSMzQwJni6+p7sOYQvqz43EnrYjJJPMmgIzCxiS0uWQ6kkALQ72OSgyShwFUep+bf6MbMwKGWZOcPoWbSP9del6YBVf71Vmvoh6y30k91v+8BOPe3B4gI/QHTQBFH9KdW4yduDo/QGDz1BFs4i8+taDaUsq6Wkzx/dd2NeGSciJbVDju67qF/RNltKqFNsJOFOncPDWXXGVfQ1utXl+eCHTEwRkeb7rFRfAl/mTNRGpq/4NjjeZFTOmMHdb61uM438FsFGv9SQu6IhsIuDBLYANIJtAf56b0WsqfzGzT6C8U6ZhgW272drjm2qcBIVq2e2fPzWEAkE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0pBCrzy0M4C9hfL2hwNeaRq26HJpiNdL6aTEW0J2mQ=;
 b=J7ZeNJLu1PwzIpozqAeoh2hAygzDwFg4enhVVeMhmhWifY8T//+GZ1lNX9tX0neiBcSn5W9pgcDC/n9R4y4eWu3uSt+t3xCYF9/Ixw3/qWZRIwGWJJG8EX7bI4zltLW2vaLP2WUuyJP9RFyy0ppJK4eKbEKuqYSwZEXm40mIpyEcRi8KM7VDFcaDsTOnck0k8cJ0O1ml5OOT4TZIWPWVnXln6ux0eNTzYOtXMoo4i9bautZWhBOXTaOJ6UK0GterSs0NFMzKLwlvq/BukhCOvUnbJ7pi95P346OTZQSN2fHzFJErbCvZjr9K5ZkQwCjIa8rUzKEQ5gk9RsmS0CyPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0pBCrzy0M4C9hfL2hwNeaRq26HJpiNdL6aTEW0J2mQ=;
 b=L+OnEqhrizr8xgcF0da8iYgVAcQfjHqzE5BgeanKNqfoSx81gjSLjv5v4IuIBrOfzvkTj08MD7swfCo6LUSJqfaEVUjBpqnH7u3uldPaWVQoKkm+nW/6ZEOua5pnlZaBdxIqTifgHk72AHhHm9zaedT9nasivhhRMlj2Lzzuvhbnn1e62Xf/0Xi5quftnAJ7ZcwvhmHD6uag+drc0prw1KQOp9Sz4iGO4LQFhcXCT197fKwQRqajg6VggbyCUfP2hOcVqxODtOcHktldUZ+Wf+iQOBXGKDq4FrY5Aic9EN3Mt5RiKLcU5z3Dor6gVEedGWIui4UjcSPL4LJTB5GwKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6659.apcprd06.prod.outlook.com (2603:1096:400:45b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 02:32:33 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 02:32:33 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] swiotlb: Remove redundant __GFP_NOWARN
Date: Tue,  5 Aug 2025 10:32:22 +0800
Message-Id: <20250805023222.332920-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0117.jpnprd01.prod.outlook.com
 (2603:1096:405:4::33) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: faef81f3-57a6-4ef3-0580-08ddd3c85553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cYGXXHbhSZhQlZ8cszPRfcq4J3tcPPV40X68dCuxBsVIRDxdAEZtMsMgcp0H?=
 =?us-ascii?Q?LpX2G7L/bW+fGkbP3OVMP9/24PYadZAE+en1vPs1J83okgPEqlq4SpO0my72?=
 =?us-ascii?Q?EELSorbUUzaxl/AbkHuWnWWYE5j91tjdYyRrjMWcILJwxM8DBo3sCjBQNexM?=
 =?us-ascii?Q?QTosvbBMNpCNVT5MmnOd9d/SRuqrTqewdLypaVHMhabxSv5QszgNrAb0jSLw?=
 =?us-ascii?Q?/5dE1jmgUn9MlDR86GvlDf2ipO6NNmLXlvXM0YKoTHBc7WuwbYe6Gw+WBK+H?=
 =?us-ascii?Q?O6Ys3i6zS6C4yhVi0Lxc2O+i7+PgxFSxEgQ7niiCF5F4oplIgdgDMWWCF3Jp?=
 =?us-ascii?Q?T9PugdZ3sq3Y/5f2T/ZNDBdOTyvFi4kGBnp+JQMvgOvbm7mduqcprW86s8MU?=
 =?us-ascii?Q?SBCyrqfKg1lCIXRIpnS7Il4Bl3lFmcMURJHLrI6gpgXjUuPU9jwksl0zzQAq?=
 =?us-ascii?Q?g2PtOrWrgMhNWA9rjHr/oTi5nOpjn4qNmrhnItDgkN1G2Ws2WakyE+8hVH4Y?=
 =?us-ascii?Q?v7mXMFUgqai/uUdMHQnpXCeaBFhzs2qgU9iYDNrkhPxlZTO0tJvyvMdbbWAg?=
 =?us-ascii?Q?vNMLgHdMXGeRJCthedqk9IJQLjYAh3jdu0EYqD1j79mvDTJ5bHfumbxyFUBy?=
 =?us-ascii?Q?uabyG/dHi3ZnUtsGDmv7J8BsRInU/h5Nbsj+42SKDzvaepnYUZN/dSLq7uU0?=
 =?us-ascii?Q?a8+E1keFaHdntPMsjkR06j/yvJqbbiUkpplbfjv/UhRB4OMhhbW3muz0lGuw?=
 =?us-ascii?Q?NuAMlqYOCyfEnbfstdIzeINBL//lNDE11yl8eyquMoMp01thfdYu8fZIU78N?=
 =?us-ascii?Q?387HyyyWhxeyLPCo77tqgli5lDwTbXS0fBxbI9nUSID0okAtovZXWjjfCF42?=
 =?us-ascii?Q?/ichLikQknGMfHdraZ6HKQMB0UL4QY8t2wMUE913Mp3AQ0TWWv1oVm9kE3Ua?=
 =?us-ascii?Q?0Rtl1kSNIFSO9y2kx81ag8xYaRYL8MXqMn01Mo76zYTngbbaVTgGDjfdk6aE?=
 =?us-ascii?Q?vzn4jMz8CdjRU9KAHk3jDBuJnFoRqa+hN5C1TTHrrHh13cDfvqMYFOdjqAgF?=
 =?us-ascii?Q?5yi1mpzp2nOLY8Ezj61LnMTypHvVOiJlv2XYXgNU13uhhwRKdoK95z0PYR8R?=
 =?us-ascii?Q?7zdQymfpi4+yxHmjuSBXM45RViRxHufPS4/eREHuWZS7T0eW5FLwvfH8w4IJ?=
 =?us-ascii?Q?ENEaPC3q8eqQhjDSR9jdawIoj/79Jxqs+gL1erBRI6t8T2udDFc+5QdKV2NE?=
 =?us-ascii?Q?sgEw8o4TE1Z85kjejGgPenSkYYjWYTvT41JwvleDG8HjSHvlrVQQsmzBoda/?=
 =?us-ascii?Q?32y/8MfUAI/X75DaQuvIz1MxyJwWPNH7vit0DgH2wnjFZbsE78m099zSqPi/?=
 =?us-ascii?Q?bRy8s24FxzZMJ5D7U74XA0EjmCvMd1eZmcE81EunGLnIi8308HT6uBG1EPSI?=
 =?us-ascii?Q?2+HDOJK8c/uD46d/TBlRG7y5fswHvcw1fuQ1PgAy3Kv0KKrlBNtXSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gl7YmCGUKVj3k1rKl/ivDMhu9RxpqlOe/FNrBXDfF3zWX8cGWJi8WBd7bJq4?=
 =?us-ascii?Q?1W+poiUDuKC3dRaIEaRkK2AeMyJLpGAxwrcHs7iXuwUKy54QrGqi9N5Yn4YQ?=
 =?us-ascii?Q?ZqOQycOCleOF7bglBvEfIeLapkBAkUlqENrXaGKX/aTH2Zn3uvDpu3NhcCPp?=
 =?us-ascii?Q?LTiU2oRjATgpz2S/e7mBmp6Rer61Df1Z7XYqPVnV9glmV04xSErh/hwjVazv?=
 =?us-ascii?Q?ECaOwB8DkuCVUccVXuHR+yzfg1TwGsOvrm6fpheOqe2SxTAanXrw+O/gBp97?=
 =?us-ascii?Q?j2EpRUzqnDbZsEHhVOvt5PXH9qHcM9bTZjwHzPj14zCZnPzgj167e7Na1cpD?=
 =?us-ascii?Q?XPPBpTUymD3S7l50QuIo+a+3sNjrjI16FqJ05PXsp/+WQcJxP56bbJj2ArwC?=
 =?us-ascii?Q?fABDHmeiJlv1ASI2kv/F4n0kN6BJoV8ypGlbxAR+JDrUP1tNvZOeJQPG0HF9?=
 =?us-ascii?Q?SmgWqOQTDHawhrnLAajqNIYoAaKcxVQaGlRACM/ARSs8hnIFwsY2CBcbRaoZ?=
 =?us-ascii?Q?dwdMYWemE7YHK4ofx3H6BGX6ymD/yqyrqLWf0qUhAgzqv49xdqxxioKGtCyw?=
 =?us-ascii?Q?Sj6P/FPjwwCAl3oMQDeDV3YUnMzm6r4GpX/QjnC1aXDsK7N6I9c4LF+h6XlG?=
 =?us-ascii?Q?Y6EsMKLqRpgsJOhl6oDUJPzh12sWptG93DpBMq4M1mqgMBO3+IHKiRWKOOJy?=
 =?us-ascii?Q?YWyqqQ0c8FYMHryUgbXaVLhMgKe74EUeb08cO54SRPLRDmdTITqi58H+z2Tv?=
 =?us-ascii?Q?T8xXE+7O54s+4D+UUqXrUd2AZNEm8U5XvNsjjhnP32/bD8E2WlO1m8Gcf0au?=
 =?us-ascii?Q?ZRBr2x49//xyXtgDEpOrzU5rrUbnmqSB6OKuZsER+wV76ANgmy7hCi1n79eU?=
 =?us-ascii?Q?ez5rOLff/qwXti5r5tkg3/iBTRlI0NONIHu1sHNWwZ150DdCOzc9QQGixkZD?=
 =?us-ascii?Q?HQenAMf7bYmQqgvnHr/4z2esHB8bjHRGRIRFD3REy5YIzuZ7TNYlgq9396lp?=
 =?us-ascii?Q?taZFETlANrVSJ2KLgHC/iUIDiZc8kzAi6U/awhVEd2bAUbpW0PsOL7QCHJsP?=
 =?us-ascii?Q?e7haKi7jQZGCUcF024xbiPBbCZcDAiggcl/iq5bMab+6+2TpP9i/gwtoOhe/?=
 =?us-ascii?Q?/woHmUUi7w9kN8OHM+ViySRMO/raTfs6B9NMMifyVgX7Jt0EXKU9neUVBLml?=
 =?us-ascii?Q?tBe/LYPQ6cxjF8wBLKx8cRdz/Dcx4wZFGHcj2prXkkoTMFbqJtrXZm4x5ENK?=
 =?us-ascii?Q?shD4ct1AWcFoxDfUDyBy8k2fLzkQfdsQnX9wnmyz9utUXONXufhHZqDcppsG?=
 =?us-ascii?Q?ICMoPBfEOufIJCauJUtNT62BNAXik8xIsd+XlhR25VvFAjzOCRqDOCiqJuKq?=
 =?us-ascii?Q?+TlIwa0Iu9rohsckCNC4fgt+du0gToYPHFVA7omQz0scwiG9e5LYmVU4KwgM?=
 =?us-ascii?Q?MRN3ADRd5vXWDgoIajuuCy76P0YFaEVgYMxnh5f6PgzbDH8FJpE/f46B+KLr?=
 =?us-ascii?Q?j3dva+GBMUSZzwOp9dQFHATJN/whmw8lxINz5ZnlNTKzJefYEPJJ4beVaE0w?=
 =?us-ascii?Q?yzqf0s9j+g7vrtqQ/7XggjS5qpFb1Nv1aOAUZx7Z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faef81f3-57a6-4ef3-0580-08ddd3c85553
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:32:33.7103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiOZtCWvrWCD4BT83U6PoPfnU2JK+ERiYOt0msLtBgtVm7NJ9vzwpdnYVsAFLve9v5ang3NB7YwNzVudbQYrcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6659

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index abcf3fa63a56..0d37da3d95b6 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1209,7 +1209,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	nslabs = nr_slots(alloc_size);
 	phys_limit = min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
 	pool = swiotlb_alloc_pool(dev, nslabs, nslabs, 1, phys_limit,
-				  GFP_NOWAIT | __GFP_NOWARN);
+				  GFP_NOWAIT);
 	if (!pool)
 		return -1;
 
-- 
2.34.1

