Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793846979;
	b=zCi1haRb5HrOb9dIqRvVAt7+4iFmjd1liEtGov3txSwRdEi125hPlpya7rl3DPF4pxsb
	 sPT8xa9AXeIcQVFfS6RFrQs0LSCRKEwkTItSZWMDJmRpJbfD1+ZeYAIATx2DT4RS9mgGj
	 Aid/1XdX2A4Etxoz/R0MCSsgP61Z2UbNrn9fUZmn0ld67mUHDUXMdlePuM6OiiAMs62AW
	 uS5yPwUtMl/b907usLsnz6vML9QGsHRCdXEgxmumrlnuxdgMVv2dAMUnfrm30a8int0mc
	 ODlNuv8nSkvPMX3xjltTFM1g77lI7mjYUC7zx4CBR7MQFv5DJQS1PkdfLhFBLAIg2Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846979;
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
	bh=lGTNRUNx7jKoADGU6nChE0bYV1JxVaw3Ybd2726he3I=;
	b=5nJAHLXnQltnL7QqkyLIDQsZp93YjKtirn+5G5peapNDXc+0niiZnJPhWh8zOPcKLhiL
	 LPKuVsM2CxnGHIHxKvCqNVAqbYhzOyANwnDaB8f7gFXs0CIDvrW40T8FTt5+cTGTAssxI
	 JLfd1IcKH5aZjR9repskQfATSsfO1JbzSzfeU1oiNnJUDsxCZF9UNtSG9ucVJU1aUiAsw
	 EnXuTgIR/PlOLzL1OphPbxZ+uINmT7pcSStmTQF+G1j+ZuqpfhLQLRcArKBiGMh+0uA69
	 DbICE6SXxZhXL0nYWPL2RU/CP3hOfFv/VxHmV4q0oVftrAeRJTNd8cHAheCMzRRfnHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=f4hU4SAi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.139
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020139.outbound.protection.outlook.com [52.101.228.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B83606A337
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 02:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8B83606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=f4hU4SAi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbjLJJsv8me7fLOw0DhjCoyA+r7hLFgLQG0tQyNl8nxTxze6A2NBBeiVth370BQWJh5JuuDLoDpoEQ6OgpyXxCs2GDeRLCdqbdu/5HHUTpLqIm1btkH8koj4tINaSkDWKQM122oqZ9YI88J7E1HXeWpEBbtxaUL2Kf0rQxz66NkEv31h78zIf/o/5aPaHnKkEe4e5jFora1X9vpv9loQOoLC9CBXo/BFeI6LuUtOZCRZ5GxMANVe8ZjOOhSlc31emhiOiYtA+HKXi97HPEjSaDmlQZXvOSWo/bStJhZXx7rnWUo81/gYxa0AjfNxYvX0/GUWNKT9xalOKnPpfGKPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGTNRUNx7jKoADGU6nChE0bYV1JxVaw3Ybd2726he3I=;
 b=mTi58ezScHr53EgXm/vYVysmW0S/K5g3ruqsxoQ+Vt3jqG6dFmtWirzZHcyBklXUlL42dpFxkSgajDr9oRRlcr7JX8XjzNo+79Yj99eZHzUXUFr7XTNK/9YDVEjpNkcX9VM5/v1xd6SMot7m4YyZZmuEQv6RAd1KKZDdKt2hI/8N7d1wLklrvDT6UX049v/OeBKX9oAfux0lm8BEA++1EzCH6Tqlm8fm11KvR6QszbMvs9HZxOt2V6yIoSbWiK/6ukWIm2uE2JHQdW+2GNJ+VYfpjN4lKbjidFjQbb/T0Z6jgyDbapnyM4eE3C/Fs6N8jATSNFO4qLcpB++HfbUj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGTNRUNx7jKoADGU6nChE0bYV1JxVaw3Ybd2726he3I=;
 b=f4hU4SAihd1Xy28BN9nVjAB68QAyvvmkMDhu6sk4jTMHQKbDWJfLpVbxkrWPVr1wJdGU8mneaNwbKey7JJAB9YSdeMl9srFU8YAvQSiTYrshSIpvuruiRk0kZNR7B3r233EYkUML6SfWLqHz3r4DC45As1Nimnv0FG7lz3JkP9g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB1661.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:178::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 02:49:34 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:49:33 +0000
From: Koichiro Den <den@valinux.co.jp>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Magnus Damm <damm+renesas@opensource.se>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Marek Vasut <marek.vasut@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iommu/ipmmu-vmsa: Keep shared micro-TLBs enabled while in use
Date: Thu,  5 Nov 2026 11:49:08 +0900
Message-ID: <20261105024910.1879230-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0196.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB1661:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7fb7df-78d5-47ce-85ba-08df3ae76bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|56012099006|5023799004|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261026135527099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	2OiR93dH5RLTQ+dqIwsKJwKFm0eTT2AUcwiOGxgFSjlGRmUG8Os9Lmd+Q83OyT6h9seThlnrJ2Mcvbgo+woTflll8zOpWmW6EF8QRydv1UTTDiB1BfIlRkk/3eWED6c44R/T2oMzAWPwkZTqeNPtZsPzyYK804ZLodd7UtF0rYWohOYuKU4NGamTI3h7HTtDw7GLPXoN/1QRdtMxRGajTxovOG9hsQmm+j37IAbnoGKmLmU02BVNJSiU0hN8QBcc6pBYLZXIlMUW1l5y7C1P3Eygrt/9+vxN46EKd7K6Sd4Trle/RDBwvzL8C4YBORqvGx+vTSyFVtrzkBqXcad8pkQo3V1Wxw1izGJUhfzz6BIrQ8WdySv15nOgr9lSejIdYf/5ug23WqA4akZYwaT9ElS5lt2H/hqp5/JkUsvMxKE9kh0RCLQdzvTyav6GLbG8rqzrXDXyzk6vNa8Y36Yq2zNDJ9znls7/CiiACxT4zXbk9iEaMtbiDdaqIc8Qp4JXyDxHaNbKuIIMfy1Z95g7gHv6OWxPHuamgrn6ksExC9K5yltM7ZzeezwiW8RxMMSGFZNrrG1S9bSaxUeZ0ZE5z2QrXHXu5u4QnCi8Ab+GSm4u9tUysnsRfbmryvotneKK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(56012099006)(5023799004)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261026135527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BG2rYwNpIiYyuaNHUXkYb2d+73xEs5Pc5XCxRDp8y99lczF5r8e5jbvhXVe+?=
 =?us-ascii?Q?+tka1edzgPx+vbG2wVRpNBlACimjRrblDD76JZuDRLSiEjbb/SIuFHZ170iF?=
 =?us-ascii?Q?s5M0rTUjFoq1VBAy15bhdJVcHsb7Ro/Z6UyKBV7N6OdNrWDM3DpAMXQc1pHB?=
 =?us-ascii?Q?LVBHd408wGRuSHgspK769fJHSAHVOeu6k5ftfcmhNZDuOKVSMuSyHcga6Xd4?=
 =?us-ascii?Q?tDxh7mEDYWuCFxvWTeX+jc2iqpoqWDEgKYTjTlfMlpsWTIDo8xjw0BHyTDIK?=
 =?us-ascii?Q?CuFHAMifXauNyCPCOgHqUOQJspkhPOaKXNDIBr9T1BRW7JM+Vxcfe+23eKyV?=
 =?us-ascii?Q?1IoYsar2m9l7SWoCCH0fwTi19XQkX0ofDEkBugLPQLmmg3izow/BP0Vc07+A?=
 =?us-ascii?Q?8JrzB6p7PpyZvDiH/QTpy++skfYtYpXm0Vbe5AoZV3F9lnjOSIIVRCLf+HxA?=
 =?us-ascii?Q?Z/TcgBCU6BGUcHR7ic7nBo8mvcyczipFirJz7FjfTaoO2v0MBUgjRz+HddpD?=
 =?us-ascii?Q?/PEGXpit04P20PS0oogFFu8fcAFi5Ae9pdNHAo/YYEzSkVzaH6ytZJS0ypTW?=
 =?us-ascii?Q?dAs30bY0SylL5PCf4ncapJKawRZvBtubz0Ta8qolTNDOKTdCwaFE4BPaXbBv?=
 =?us-ascii?Q?4wsQcA4XhCOO3lT29GroZGx7aWE+4XbUaR97iJhsclYcmtiVkEq2kNY1CtDE?=
 =?us-ascii?Q?PCKdFyHeDuLFbiC4jXgbWIn6/WSvUfbIB6FlKguTAisR5pT3sv3M/GedwxGH?=
 =?us-ascii?Q?wCslWC3vTJ4RCRArtnZ9AUTFvgPxrJjuD1eRJ2lKJm8V/egVlnttp74rhR7n?=
 =?us-ascii?Q?mi85iVmnFNgDzQ+2L+fe9Wz496We6PoiJ19zqI2/PtEuT3m6DufLAeuXzMK1?=
 =?us-ascii?Q?TWFc9oJiycIJtXhnBuBgcUprg/bMrZAge/strhocMBPgt1qEpO4yxM3CZnWY?=
 =?us-ascii?Q?4NCpy+hgQr/BHlHOLGX9qQUojf5pE5CypGwxs1v1KxX3V2JZYgwIf5Qz9fdP?=
 =?us-ascii?Q?0SwprBX2xc/NFp3rSo6OtKxI2zo5bHk0H3w7SlXNLaeisJXKOhQeuPfm+tzJ?=
 =?us-ascii?Q?+JZ1qslJ7Cn9thefP1kfZ8GtoP2wp+iZrg5NhkPzsoNVcW2LtJyS/JIqP/Fp?=
 =?us-ascii?Q?VF224k31FkVuZ5f/yBDRKB8ukkENES6XD+cSEoDKNwhwee1wbKWNAarmzHub?=
 =?us-ascii?Q?rocx7mhvXurXff6bVHFTpGyuAjabxc4L3BwDbP7zJJEQhzlLn+493x1fY9lf?=
 =?us-ascii?Q?rmx6PfJmuQGojWMf2BRLj0XSU5lQviNT07U9RfthkMvNQs6MJwEMjNefmaw+?=
 =?us-ascii?Q?QrjkYBXfVLR+TI8+j816F+9mQqz9UCKidDH2oAn10Vf9TqwLqS7cT7RiyH1h?=
 =?us-ascii?Q?Jt9WU9VALnsm+doaGPDcfPaZ37lgEWGI4mTIsVtk1TtnBdISzG652TZL2ZL7?=
 =?us-ascii?Q?1rIo+MWG0eFpxJa31KloPfUgozdR1QZwvNN2D8fsntfhTNFe58gEXNfOP6Gv?=
 =?us-ascii?Q?X2ind6ZZR1NwYFWVgLt0OOjNwImA3EIsN26ywqetcoRw/pqpD5JB28nC0tBC?=
 =?us-ascii?Q?xyxRtkv2sv7XaXNEJKJJZfRiU674jYAPm93e+SqrFJQfOB9qxNQQv41GrFPg?=
 =?us-ascii?Q?Mv9AvbrAvjlk2MQ/hzUkjomCBCtf6ts34Pana8CcoitVKBR66hEKwkY3po79?=
 =?us-ascii?Q?66kI4+UxEs5gQlUIrbhvA8C7uhDfPgo2US4X4HTFSdbXlApF9xoK67cwh+ZS?=
 =?us-ascii?Q?stwy1Qa19972sd8qQBIUiUgk6KBQ6+IqXrdkEYozJ6s4VU+2oxQb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7fb7df-78d5-47ce-85ba-08df3ae76bed
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:49:33.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bv+zG+S0WABcPh/urPWbwJNNbRgYvHPdqLo26jf59n+kzIC1c3sS43cEktMp6DW/K9AkqIwF/zk3Ws26Lub3MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1661

Hi,

Removing one PCI function can disable the micro-TLB still used by other
functions, causing their DMA to bypass the IOMMU. This series leaves
shared micro-TLBs unchanged on device release and cleans them up when
their domain's context is destroyed.

v2 was retested in the same manner as v1 (with the Linux PCI endpoint
framework exposing two functions to an R-Car S4 Spider host, by removing
an unused function that shares a micro-TLB with the remaining function.)

Best regards,
Koichiro Den
---
v1->v2 changes:
  - Move micro-TLB cleanup from device release to context destruction,
    drop per-device reference counting. (Robin)
  - Drop v1 patch 2, as it is no longer needed.

v1: https://lore.kernel.org/r/20261104162251.1749998-1-den@valinux.co.jp/


Koichiro Den (2):
  iommu/ipmmu-vmsa: Propagate errors from iommu_fwspec_add_ids()
  iommu/ipmmu-vmsa: Keep shared micro-TLBs enabled while in use

 drivers/iommu/ipmmu-vmsa.c | 42 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 24 deletions(-)


base-commit: 528280c12a26c9da2449c42c5ab4a5c4fe6dbb9c
-- 
2.54.0

