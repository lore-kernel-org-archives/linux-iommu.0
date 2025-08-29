Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012071.outbound.protection.outlook.com [52.101.126.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4E27D77B
	for <iommu@lists.linux.dev>; Fri, 29 Aug 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476160; cv=fail; b=Ey3Rg9PVndP58O+jotWNQxVZZ8qTFYvrfjaTy99O+ozCCbp/565u/fvAFner1lhgKwOi9t+ULtBvpbdsyOXR7CQ1sA/Gqxpf0s6tW9yb8V412KmuBjiby2ZD8y2j15bXdLBrQeRYGt9yeUwOmyL144kIttwnwFlAbkGNnwAoE4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476160; c=relaxed/simple;
	bh=90L5ecOC9+HDqQ8jLKnptzW9+9U2vgJAwXQOrdWrVI8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gC1xL3z++2Dx57I5liEqjFWY5bayq5WZuTrgGHLfxTWnBiAYpcjASCBG6q4SgDNozZOlKUX9hamslKJi3IWp4MQ6ePRUdJDDmEh3LXu7Wdkyr2uDNA0982rdzoe0InAhfYBBwq+8zZnUZhPPtmoxWyKKKNHIdcrHYQq1p9BSZm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hbAiHAXo; arc=fail smtp.client-ip=52.101.126.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hbAiHAXo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtI3151M1dXieop8dHikR5arMbkjjLAEEONt3mT6Aqj2AhD/mwoojOWsn+BCaDQ1rbD0hwpSIbsd71W97v+pUYZ8JSBOdROpEAXgq0UV6qvmIbf8Wguteay/Yxpm2y3Z0X/NZI3tKRDJYRkr3XxdI3B+nYzqRvMrg90rgkw+SrRebRDgPm3Li0mf3O5yApO9YXuE0No/m5pfP69bFA3Ss8L6KShjixcahVZWxrY4ggl4WvB0cj3AYoXPKGNadsT0njzFdilqeAVytomMm18YYhVfZa2r015CIQ4Kxs4gR7fKgzZERvds4duyA3MLZVH8hfsm96ptkRqGrvaGYXBLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8inOdD+yYyxIepPGy50CRP1SimmHEw0/3nKh05z46Rk=;
 b=W7JafUam+PaT5SohZjEE5JZL6FH0yTTWwMQ+19OqKpfDMIQsxAn2OuaZSTCpOb++mHeWarHI6KEUY/07Jgxn/xv6Ef0gAhFQEKzXgg+Bu4Qg/pa8UWGByweLejma/DyrhndLz9Up4OeHjzbeARzEnsOWXA1iOoVMDmVdnbZUXcy+t6/OKldhUpsyvEpsqPeKTEubT16E3UtplWp5vx3rxbT4s6PzotukKKWE+mBlA7kZe2XNqaUrBqKk/Rg9ELiEdYNBcP9o1rSt1QxRi3BySV/emuMZvNtpEE0kgaIRBT86sXh4FkIBZG9HUCEuvuWUxJzKk3MHfsYwDyDm7pyxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8inOdD+yYyxIepPGy50CRP1SimmHEw0/3nKh05z46Rk=;
 b=hbAiHAXoFKSiHV42vvGFxeZHOdfVJFKgOgl2Sv5ASeaE4pirLc3QampdxbhZsL70VJtlsKYHnvDNAYxELQqfbSnqgpQ04Lw7/nFpxLGdpkjy0Eq8e0Vv7kHdDE9DDbzE2lda5zsQmL8RZqoQUMqGsGUghRemKrMUbKPaPqhztBSr/WZ/hxeQ0ADtUdTFRaoWF8eIuhPv421T7+nR9Nkk5G4s1c19ApHUt/xD+jJjqEv/AoUDqWkyW8oQLeK7G2/sFalegmNoiov9pLh+HCPPZd+zWbFgNLGmxDD7pM5KQ1hERyTiYenYHFUpgDUVUMD2dOSeTpYt9WQA77CW+g+PYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SE2PPF927A03F6A.apcprd06.prod.outlook.com (2603:1096:108:1::7e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 29 Aug
 2025 14:02:34 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 14:02:34 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] iommu/omap: Use int type to store negative error codes
Date: Fri, 29 Aug 2025 22:02:19 +0800
Message-Id: <20250829140219.121783-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SE2PPF927A03F6A:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8d427d-9fff-4a9c-2a51-08dde704b41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQEn+xRlViCmEL/e6sihIwMvqTA7GAc+vaP2VYpzdfj2JOtdd97uoHkpUfSb?=
 =?us-ascii?Q?nYyn7rNvPJyIxOu+/7wlVZ2s9CDEYgAci6WkzZCMEp8FBIq3bZpGaubAX8Q4?=
 =?us-ascii?Q?MTapeDEBLnEcvy+2KsZCtjYSGjdM1QNXz3f6c4CSA8KHVQC/nHVyDyNpg6b7?=
 =?us-ascii?Q?tMLwXIM+S9QndB27WZEazjc6pcw8zxOSBDtwVELzZUie8pMT6YVaVcH/2R9v?=
 =?us-ascii?Q?PvFTb1JOySaaNqmLlXaeFwN95YD+bw9sWEG0Re4IIqzBmAp0SWYWKWCGPSi2?=
 =?us-ascii?Q?X8KifJEZKW8VqlcczlmapRWupr1tbBBxBBjV9cHmSGnclGf4Pe2NyEqdPMqR?=
 =?us-ascii?Q?kxENPOwnEveDtWT3ya+YpGbX6EWOjxG5mnTpqXnJhjurxgzaInNlj7B878Mo?=
 =?us-ascii?Q?EsGR2gk28MP5i5bY1xoNY9rEPB/smM3JZi72XRgPqiR71F3eouM/p45LaeAz?=
 =?us-ascii?Q?tdSSCwBPBdUB/BYaBKaF7uxEdHkRan34aHS75sjAeYS7FT6q8wdtOHKMa0lG?=
 =?us-ascii?Q?bi+rntmHd3Bvgv5JrDUxUJ3eEZ5XbkvB7KPpV5b4eUfNV2x+c3OynQm3nzEx?=
 =?us-ascii?Q?CSqyH+GKRgWCHLbS92+cQ1O7mtktqU7qFExply9VD+hdxq494Cw+k3d3jKyK?=
 =?us-ascii?Q?tYkAJBuw43qiD59ZXTbJj6Uuyh6a1Aqut8ndFHjuXu50kDSPV+AVhZYceoYs?=
 =?us-ascii?Q?UIuKIK1MgM3x4XABGvsFhG1oBWrJ+XQLiTd6Li9fLBH20GuPDE/zEt4k99gF?=
 =?us-ascii?Q?VvxfhONchUpBewQ7W+hlb/XN0DFbXDzUnmCGgd1Rb0so69tyg7tQ4RP7wVkJ?=
 =?us-ascii?Q?7/J2RqIdt1QRSHju9iSXlzdvO881lnVlzagZSi2lD76INZKGMxnmKbQieAAC?=
 =?us-ascii?Q?1h1grtmgtQhjrbkDJPc2aHGlkHQ9iebp5IFivROdc8mYU7LVdFVSCKJXJRVo?=
 =?us-ascii?Q?YV13sdRLfwWa4d0+cZEbZaUb6290gp7LaLISEttz7lncKKfnj9VFbYQJ/FNO?=
 =?us-ascii?Q?wEE9khwlLcc9kLZJ+pLO1Yaa/FBE76aGhjWtZaxEOAosLWMO7WoYIn6bH5jW?=
 =?us-ascii?Q?vzAGqiY8UViTFsjg+UtC70HpDERMfCbmkBxCVj/nHgEDaLK07KCRLkigeyoL?=
 =?us-ascii?Q?q1uIeQcydbeL/AVIr+PL9L8zvNU3EFxcevmZb1SkhVZx4+0nLjG2P6IrNjnb?=
 =?us-ascii?Q?E9v9SiplRke9hIae+XU4Y1KgRqJeVPxsFPewJFCR09aSuLINtfMMK1hSlB6q?=
 =?us-ascii?Q?xUdlB+anOBSk2ON7zxBeubYUHRxdnAlw778InfoL+D4xgr2J+wpuf07LFGpT?=
 =?us-ascii?Q?OYl0t9B3QrnaFcxmDcpurt+zQzk0WOuXmilWm6TC+b1BOxq2QiAJfLDG/8Oy?=
 =?us-ascii?Q?w3QP+4wbunsl5i4uIhMXSKDUQGGDpPx/P6YLNDva2hjXHjtK20UBWx+n0nBD?=
 =?us-ascii?Q?YauEplQAdLq4pCU8Fc1LCmbj7u0+5Pzqn9zuUj0TnDNAr8HFLjhtwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z6tLRzGrdgCCdIcSalBrfUjMMbbLQtK0I3sVU3nY0qqkhVFnnDPj3AZj48oc?=
 =?us-ascii?Q?mQmsGM0B61JE0Z3SUjVJ1VAb1eL4jAfAS8+5P6rkYYo5o8fMkdE1IC6IFIf4?=
 =?us-ascii?Q?cgrLmky1g8SkMNmaP4TCmtjWlLLBkjFJVtnBsHmIFcUrAEF+0WvU1VPp5y+3?=
 =?us-ascii?Q?ZAtPye1f2kItMvdcNzSkNKzV+WmDCz0eiOycAPBZftXdKO3K5oQVojDPu5db?=
 =?us-ascii?Q?USgcFJn7t+X946i1ptkP8XilgDv8j+OimoU8VsV2r1GOc0RRb/+BkslSlbBr?=
 =?us-ascii?Q?Zpo9HiQFqcRQ0921GM8P6Q2NDRaeFyhP6+sZWsH5n6qBZD2xfd+Mxlj7da7K?=
 =?us-ascii?Q?sdR5RbrGzA1SDqSKMPtudcz/NL9z+46Vex2aP1gD03ExxFZ9tPgAIUlLzLUq?=
 =?us-ascii?Q?U2UenbEITJB7301G5pdBmh7Gv1UeC15oIKnvLDt4h/x53WLBUSqq0vCOKirZ?=
 =?us-ascii?Q?pf7Hl85Su5YesYnpgNAVCn8n/LYAiyl+PowO+uu+WvTl/b5cvzhfXytVHBFp?=
 =?us-ascii?Q?KsfIoFWxnGKXE1mQZ87BIkJ1LIGWscMncZJ0manrSCqLS2PE/Eng1/CSRe1x?=
 =?us-ascii?Q?ShFESK6tRf3w/mtC8mJNHU3d+bQeA6h1VXeSRwZ0z2iwL+fFMhA8pjr+H2pU?=
 =?us-ascii?Q?hcXB3qLCeBGZomzx1/HaBHK0dlhTI2dcFGV2g4tyj/zteyTQIuR8gTP6uiK7?=
 =?us-ascii?Q?Jyw/mqkRjzEIDgUt0zCvKDRQWjziFLiZQzWT1lunO3SAYTwbgmtn2NkG6bsP?=
 =?us-ascii?Q?ewYou0AvO9eroN/BYla7dZ3GgG48WDA3SfXlxNylOFy2HeT16h7Ii/VImkxy?=
 =?us-ascii?Q?a9IYO1EEppnooaBJXSQwFbgO/iR+wH1viRSMCDRtvjM/SGEfAmXVXV+nOpie?=
 =?us-ascii?Q?QFQO8eXrY0afDXC4and8On7AUSprR4mVcR4ak/b2LECItg15g7ZSCW/G4R/N?=
 =?us-ascii?Q?/j6MXj7DzlcMTzMy1OlSRFOBa8aWTg27YPd748F0SOV3r+N7cMkrCq/HqyRF?=
 =?us-ascii?Q?n3V/7qJV2YIuqECaQpQ+UtN2F2mWSR69negzwccNdyp5s5P3iutdUfqBvwIy?=
 =?us-ascii?Q?TqK3P7nhpfTENJ0v8I1RS2lSh++xd6PzHoLtqSnNmxMDCNl5V+MQ55dhR0on?=
 =?us-ascii?Q?JYz/bk/2rXlhfNLbkAy1OY3bcuqnVkN3RXc+Fzx+7y7mbNOMFXyJFShBBksA?=
 =?us-ascii?Q?mKdV+eejEJeMNa6n5ypRWzOovHbV12xQhx9DdxNX7hna6Y0VSdu2dbZaRuhx?=
 =?us-ascii?Q?Xo2psEiTLY31G6nNzQac0XSiGCFNi74Cp26frFrwaYsFAkP37tdc3VRQoBJk?=
 =?us-ascii?Q?9XPVzmNiHZ49tdbUbesYpEmT2Eb7yeKhM+xTps2/Dm63mBqU2oAm4spoFQ+g?=
 =?us-ascii?Q?2Pjay1KIrKTOqETErrxtAMBDG5oDSoTiu0LmITi/+B0ouaH3bDLwUfsKkhLf?=
 =?us-ascii?Q?zV+TTpHQMDPP9FsHY3cBZTvuIiqA5OQrAGJNS9uRqQVU4EDi6rYdUFAsiPWg?=
 =?us-ascii?Q?gvdTDZcLjXjPhjDhXVoMeAnxkUooaDf7alPHsPg99lLr4lBqdqTQAQpo61Hy?=
 =?us-ascii?Q?rjM3P3t/GksggpS0KSrokd+EjY2PECMYHBQdjgBR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8d427d-9fff-4a9c-2a51-08dde704b41d
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:02:34.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck+GnTONnJU/Ud/Mk0CXvABYcafvnyTudrSCLZPokTnaFbjPhNx9vu0Lp7OWw8rW7hwxz49cpyg3YzvI20effg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF927A03F6A

Change the 'ret' variable from u32 to int to store negative error codes
or zero;

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly. Additionally, assigning negative error codes to
unsigned type may trigger a GCC warning when the -Wsign-conversion flag
is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 6fb93927bdb9..5c6f5943f44b 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1303,8 +1303,8 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 	struct omap_iommu_device *iommu;
 	struct omap_iommu *oiommu;
 	struct iotlb_entry e;
+	int ret = -EINVAL;
 	int omap_pgsz;
-	u32 ret = -EINVAL;
 	int i;
 
 	omap_pgsz = bytes_to_iopgsz(bytes);
-- 
2.34.1

