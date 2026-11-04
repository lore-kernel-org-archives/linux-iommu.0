Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.107.74.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793809382;
	b=mqhnTFVFZbEsa5JykhcdX2AWj+7Gmo6/kt/g0+VBwxWYDmCRbvsFQJd4qP1LFejR2rsr
	 rqoyXwBRc8sL8SokyjNUeuupbUvi6IIh/qm/FbbXqk9BzHVg3uFPEG8DVJz1XFtxddXUV
	 aQLx91YbB5+nLdQyzXnGmHtenAHJ5HhdSNI+AT6DrmrsKb48VmUj5tsb20VrYFFZ3dhbQ
	 bXIWjP1bzis+06okFLwXBDDEhhqpFoYrWlJSrE9hnxHGU2DKLpIyQw6Yy/nHHXtmt5xTN
	 jLTo8PdNUkpoyPYw6U4ELZkcId3qXrsAQnsbCkB6tPwSfiQLf1F/vJaIVjudspcbGWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809382;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=U7TeULVpbowD4kFYkGgNpbpZugcUFyU9u4JboGrD7i0=;
	b=mY/btxfyyXm9lDYWjizzScaZZ1fRkFB5fLybdRMtHPX/WfG72k06h9L4G7uZAI+cfUKI
	 AIVYd8RVxVC1kHXzN0wcRMhsMOEV/aTBe517/+ALPpo2GsQpb8exjBN2IeYCPb7KI0cJC
	 cTS13qshVhKI/FyeA6pyqixB2UZ4K2ZJmYXklTXE3E7YyKPWtiwCzQMsDf0V7rUtf2XK7
	 lVf4PhHwhzQU/+kqjR6DH1Z6+Uagl1X4uNOntw7xGPzdSS01ExX2X/owfr8ste/togILC
	 2Ne/fiaHKlLy5CTcIxwNs2WYLFmZGweoX76r7t35abjOKdMYyQImXRsciP30C1n2IYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=VvUjA7xC;
	arc=fail smtp.remote-ip=40.107.74.105
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021105.outbound.protection.outlook.com [40.107.74.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C04606B8F5
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 16:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C04606B8F5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=VvUjA7xC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz+DHmZAp6XeTA6y2W6Q0g/xGmOrhpvGKb2GtDQUwOhLp7hE3hcdyaJHwWuwNjNEjbFHtkWk+fMXeFGFaWjjZbNNojE5WHOw7vqYrHza+akYZNi7jGUvub89etjKwYniS4Me8a9uL/m1qh4hIsSvMAtDqG5DJ8rq4AcU9SZcWoa8EMbyzOzuren7W8wBRP27ECHHipb/RLq0wA1Qcl/cvxg+i/+5fIliFeqo38QEBsMveBYZtriVtyTszXHEDNhhBvyTpBszUdqOLvxIGMhyTkLIIFhHLlnQKwfWirIpEbqsZdlWdzPt5yWW1sc89a7+8xdw5Bjs095gbT23s/aMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7TeULVpbowD4kFYkGgNpbpZugcUFyU9u4JboGrD7i0=;
 b=MmMOBsjXMsprTTUWqvF9VL43Y6Ia8z1FxT8cDXFsJVuwcvSeyJsNUR/E4/Pc/t18UEHUOwX4uQ8DI83Ig+Ly/3YoOsRcHnAVsGOtSOvN3bOInJNJg9hNs4avHccwJdZBZDM5jLM8ZLQwZrpOIoui9gAGALZiq0qe3fat08bksGxa1Dxvz3VvUB5Vsp6XnoBJGWJEsxeFrgmpXbyilUefCfn3utZKWCCH6QIvi7NQbmaq6OW/isX3jxtY8M/7e5IXM1jztI1kyEer3yl7Mcua+HsNVcp6M/DMM3+gb1pZiD/AqkJ7ntTLHw4FJ2K1j+rcvqCUQx+votyrUEMuZ/Dmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7TeULVpbowD4kFYkGgNpbpZugcUFyU9u4JboGrD7i0=;
 b=VvUjA7xCbR6UsYxrKeczYA/VEfYohvPIcrkUPmOoettA1HQxVYKRYBu0rAchcn32F/SOWnuwgaFi5LPOzZ1YywdEwVPQOseJ3VFWcmF9kayrDL6Hjaj9TyGDzQAnXQGgFUm7jBrbPsRoZDjIc7Y7N+lp51Km49R62Qx3ZDoiCdg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSZP286MB1462.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 16:22:58 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:22:58 +0000
From: Koichiro Den <den@valinux.co.jp>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Magnus Damm <damm+renesas@opensource.se>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Marek Vasut <marek.vasut@mailbox.org>,
	iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iommu/ipmmu-vmsa: Keep shared micro-TLBs enabled
Date: Thu,  5 Nov 2026 01:22:48 +0900
Message-ID: <20261104162251.1749998-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSZP286MB1462:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f71d5c-f8d2-4708-eb74-08df3a8fe363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|366016|1800799024|5023799004|261009223027099003|261021121427099003|56012099006|261021123027099003|261028144727099003|261022105027099003|261026140227099003|261102123227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NKyqgUzMpZYd68PH2xMaH+r+eiXmxpnpOrESP/3hOZkl+jimrm3wHeRqTKZotYFovp+AOJ+ydTBn5JHvGZUCRGhARt31QcIYBVO9lLuaR/rDqF3x376fjC5fIeuYBPtTnRrZajxWDyDUeOXAOU4x8o7tWkxkVFm3TFpYi/jcqQmHUXNnAdEVBZAgwPT4QksYtNd2Gc3svXpBTgaJppGPsMOuQUuWhUgc2Imfk3nE+OIpBTK05JTTVCU65IX7ZvW78dzIWLifvTKxopN3wBZHc33hvrMnjBLp49ROBUw4YZ5dHQrAMZS7vm9O/yq0SQru2OkRvfSoXoMervIph+OD/PnAyLMwcoGTWNswGrL+3E9pcrpv9LWudmpxd3ROOhQWu8y+WMYznNAXziJsddEN5N8DSkB6DduVmjTugoVsKgK2fqgx7LToQmyu7PQnJAZBxm410QqtCAERvYpTMXUk9/tMUaKCdz6yPehH+7L98HozR+TkR5RgVnLWkLXubmsVAr57nGUV2uauJdywi427fkVO33bAtoBuc/1nqZOgKFL8HBRNQi71SHJVCLtGKlpDQY/OdFe1FrSec8Mgw+b7NWNMbM7vptitZRpcWTMU8mCfxSZWlzAYyLLX1a/OXfKrzyi5r38b6iOikVQAxWlEY5O6j0rYwe0t6MOF6UAw+OM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(366016)(1800799024)(5023799004)(261009223027099003)(261021121427099003)(56012099006)(261021123027099003)(261028144727099003)(261022105027099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rupJ0M0kfVWouNRdHRdXKVVna8UkDkANqqEhGkb2RhcmEIzYUTaDwziuFOkG?=
 =?us-ascii?Q?8ucOqB2tjR5yZuJQkxNNs47faufmnUF2QKSbYFDk1sMY3+1wgxayD/c1/Jei?=
 =?us-ascii?Q?sJX6F8D7QqmP2hL2KsGtu70P/tdHsBclaWXeDpzPxjsUmj91i1YVnvmK9lpy?=
 =?us-ascii?Q?XtoAXQYcxS7Zpb50eWAZRVlhwj+qhN/5ZtHAuK/F4lGwC+UyRwDSh3lkGKUb?=
 =?us-ascii?Q?anJtD6lp867Z2A29NrpZY+7kE8A4PMpFow2jR/y2UYVmXCEzEvXHNKMEHNk7?=
 =?us-ascii?Q?a3MSLcZrZhr1SNIu1LfcCvW74aHfs4G2W7Nm/VD8MkqjWYrQ1Ga3Oyld6SUX?=
 =?us-ascii?Q?YvROgjmA3dn+4ISaIxpOE80bfCWZPGY5xz3Oszekp4+mNW2nMzAvnqu3VDRA?=
 =?us-ascii?Q?rYfy4FhKRnwJKT9joncdhonEubtuVwQorzhEAM6ozU8ptkk9hbB9jdJFxH5B?=
 =?us-ascii?Q?Ym66MSmRHkIEnse4ItdSgBHOiJ3n697Mu9O1cAPPkU7mA1GaCWH0GtCyLLz4?=
 =?us-ascii?Q?LMw1n6CypGuKBDo45MuZbyHaBVclVc3+LkdbT9vTVCs5Q5knkv0fCqbkxvNA?=
 =?us-ascii?Q?lE0TlbAY0X4aSu0O3DbVrN5T3uCwaOuG7FnCEnOTcd3vDLE0Z1S8ngkWYDma?=
 =?us-ascii?Q?UWLACCmknkbn0tyi1NbnxS7vp53wRfqz6ZRo+MjENt1k025hTSlIwNMrjaz2?=
 =?us-ascii?Q?JnbfK6+HX8ejIgBLQ29juWB4so0+9ZdDaRRaK6Y+td/OsZDFrNrUloeiFCvw?=
 =?us-ascii?Q?vAi4cSSSX9X/9mpks9aPerEvmxx0czLXMDuy9X++3XKoJmsRuEuDDAVJmGKb?=
 =?us-ascii?Q?dQ8Axi/WpHxhfSznd4s52KQFNKaWPBsG0ATxcxoPMeho4OyZymkgkx5T2DPa?=
 =?us-ascii?Q?onDUsFUC4PmU14cwxR+NSC4c0I0Oi/eNelp8Mt0YsZbM3jN+ifE3kRXQoL3V?=
 =?us-ascii?Q?BqFW5jCoyKx4QDiFhIWsBsMGgdH9pwg9H0JG1Ovo7EgV9YVeoui/sfGgMlYX?=
 =?us-ascii?Q?DE13RpPYy/1qMYnsIt3BbULMfq55PugfQvWvEw62kjV10lBxk0mZID/M+VQ5?=
 =?us-ascii?Q?71Myn/XFPL9QcnTkUryjyAIVVJw39AfMbQ5+CNm4MlXMoC9JYGazUnxztbuG?=
 =?us-ascii?Q?iJeiBRhD7AzYhoJ63Jq8n29zKy9ORvmQfVxVwdZf4x3nqvo/4Xre32BHgd0Z?=
 =?us-ascii?Q?QIzoQaFue6i4RYiMDQg507kQoLG1NTbNifSJCmlTMvqb5DJmr99emeY/A5qE?=
 =?us-ascii?Q?95PPKiI1ypp0MbO+NXGfKjqQ+ZDygK6IgQkB4nuKNOWAqOxrUIPhCB/ZjF5g?=
 =?us-ascii?Q?PBHAR5DEmOFtCThCelYzbFvr76gLepgPN7dF5OCnB0yPPqNO1G2/DkRK7pRu?=
 =?us-ascii?Q?29Pi6e3rsI7TXjGpEg9QYITqO5ZD5pqXiGCtNlRSuaT0Pldf1+1VSQ3F/7og?=
 =?us-ascii?Q?gi9sMZMD9sRaU1MTLB66e6IUjgcumsU6p2yhfK2i3FcVZdLw8WVUatOEinn5?=
 =?us-ascii?Q?nRQszyfQX9hYz83/kvqREXpCiZj5R62zX67ATbaes2XbjbecT0deM6ofeG4t?=
 =?us-ascii?Q?ShidIqJcG+iW4lky8NvZaZmeoMOcNPwWBM4WZfOGFNTEMJ73Nsm7H5GlPu3L?=
 =?us-ascii?Q?nHYLqWo+1Z+GTlWyt1fQ/vcvyIw1/zCXkkHPQboutURHbWeTyINjDz/Gc07B?=
 =?us-ascii?Q?JEF84dWPT1sGT/qOIfrD3ZSO8RjRXK45st2o9siCMXbVwe+mnfPrjZ2mlv9j?=
 =?us-ascii?Q?nggaaR16w6R/T7IHvTO/MgMKahnNDNo5WhosNQFzcqflacwqS5Wn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f71d5c-f8d2-4708-eb74-08df3a8fe363
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:22:58.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX0Bq1kpZ4vT1GnkD2XECLqBMnhUWh4vzCeU0R4oLwSyXjIgUyt4i5e+9m/v9TrXLspKgpCLYFJKBELE202ZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1462

Hi,

Removing one PCI function can disable the micro-TLB still used by other
functions, causing their DMA to bypass the IOMMU. This series keeps a
shared micro-TLB enabled until its last user is detached.

Tested with the Linux PCI endpoint framework exposing two functions to
an R-Car S4 Spider host, by removing an unused function that shares a
micro-TLB with the remaining function.

Best regards,
Koichiro


Koichiro Den (3):
  iommu/ipmmu-vmsa: Propagate errors from iommu_fwspec_add_ids()
  iommu/ipmmu-vmsa: Move device initialization to probe_device()
  iommu/ipmmu-vmsa: Keep shared micro-TLBs enabled while in use

 drivers/iommu/ipmmu-vmsa.c | 162 +++++++++++++++++++++++--------------
 1 file changed, 101 insertions(+), 61 deletions(-)


base-commit: 528280c12a26c9da2449c42c5ab4a5c4fe6dbb9c
-- 
2.54.0

