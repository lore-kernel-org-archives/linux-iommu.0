Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809390;
	b=GNyRx7p/yK4CN3UpFSKBKSR0JrmproMCxEPg9GIs5SVaEWLz1V7nDw0VUWIIontGurXH
	 aDpYp4aaV3FPKxvVujo3gElbOV5oGIfx4AiNhhOg6VnOmSc25VUvjrWOibcCJBbK5bpBo
	 MjXdBdyJ6IWXWuO+/y/xOSUjHgYsz7O6HGlQPjCDWQ1WSncMqj7cMFgzA2UlxkZlSZnvU
	 Ue7iul66c5Dz+IUhvZC5XOkL0UW8+ql3nzQAaVNXOi2BGQoijjWYsCSN3LOvGh3uk/hD2
	 HE5ASwMPDtv+X53szG5WYnCcJpE5JboLrV3Wq5JGaLsnisQtTyWI8mP6fyGIhp7xPDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809390;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=f5sd92Y+sgDHxIB9Sy2YuZFL8BI2wiy79lP6ceZ/DUo=;
	b=fv0rn80KDF027sXdDdbhw8qatVFTMnEIHsLW+U33j+CHuiLwzBCf9qD5U4N21bHsaldU
	 /Lt5jflqq1e2qmQKkGocQzYRgtKgIWnP/FZPoXbGESy2Hi6zI2J/rb3cFPwNjwIH3q/ft
	 MzrL2to7++b6bHDb+VjfFx9ZlVOz94PLU5GK+2K66XLK2YcYt2NkWKDZv6Q68cp/0cWf3
	 hyV9WuEiyKRFJbHHs6Fhf2A+VNMLdr1dcHK2+JYFdphyNyLpOfDQRWRxnN1bE/UB5iy6d
	 rG1lkKp1Ai7/9fogCrWU/0awxndk4HLYUL5YEDg1k+95BBH/spjp/JXYSAsQjPEOxtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="weadjiE/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.105
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021105.outbound.protection.outlook.com [40.107.74.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84007606A31B
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 16:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84007606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=weadjiE/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktm/s6F76Bcj7boZAAUETgOB6F+t/zREnqh6T9vBAElF5dOYcJgLD2Hmt4T7+BdVX3mECLo8jETaHkprYE+zOEBKoGNt+QiwbjhzV1D0gzEayJZYmr7BxXJL9zCJSGCa9ds7LDPkhbXjgUVXkXPG+CPl3DGTErpRGzExXYQ6pIpp0JIovu2280XOnLrD+3O2oYa4CflrlsGz+gcMxfmrYLjPayDpBwSHPN1R+Qcc5LdNeMUWltyNCgm23VTUx5pw2O8Egg+37KndiRqq39cH1i8iTKMBkeODvQlfA+/z8r5I/zAqTNmxxTHIcrLVc/dI6qwawH1WYAMF0y4wDhlWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5sd92Y+sgDHxIB9Sy2YuZFL8BI2wiy79lP6ceZ/DUo=;
 b=EGe5A4m8eECurZl0XaVqRGOk/O8jhWYkk2/FYcKt8lK0QYf/qn6jlknYS1WK5hW/EhA58A/KXKdWnUo2OO5ISCQgI39qm0qHaJqOIoJgBsLKBY3R2IftWMwOMjZtBIVJnh0CmWV1NzrGE/Q8rX6+1f29rogF82EcoPbpzs0enY+JD+Quz5oI4UHNzlrAneielts1CgzclgnQUnV9etdmlemZ84fQ9Z4F5WZ5iOrJiDDRj+hBDjebILecd9w1eU3A5UN3OqZ80+BaUyrwJfaiRZSzcATZytWMKkrDAmZ4/X6S+uQTpkJF9ZMgzM0GxLE2rlAsI4VQfdLF04JZRRqkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5sd92Y+sgDHxIB9Sy2YuZFL8BI2wiy79lP6ceZ/DUo=;
 b=weadjiE/XgSbm8vIpxvoPBRH3iDC/BU/PwAByxJLq4FTKzWwyD6W9653PZe6KF99qgSNhMp1x+o3CaUrKALs2AuMZ2g7x3SeCYWEixWu72pkUJawTZHjgRZhwj+HGPP1grKHWGSkhnJPD9o5wAFkJLhCtO5e0KoBt91rwiaDYoQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSZP286MB1462.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 16:22:59 +0000
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
Subject: [PATCH 1/3] iommu/ipmmu-vmsa: Propagate errors from iommu_fwspec_add_ids()
Date: Thu,  5 Nov 2026 01:22:49 +0900
Message-ID: <20261104162251.1749998-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104162251.1749998-1-den@valinux.co.jp>
References: <20261104162251.1749998-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0248.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 0f419a17-42f8-4bb9-436e-08df3a8fe3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|366016|1800799024|261009223027099003|261021121427099003|56012099006|261021123027099003|261028144727099003|261022105027099003|261026140227099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bh+wQPm7uWZjgVDJphhOUfFcA9h4O95ReT2HUpH3MLTSQWDEE6hZW9iXgaflKy4f3BgMWbcoetyhu0084niLiQNVoZbgnBmy2J8VY79T82EfQATfm9VE1gbLjALaxEHZpnIY9Jyze/o2/RqVnKPsHeqwFAdOJ7hXXmSU6slhuYjHVYQTaVoJ094rNJvpO4SkROk1ZTJBVCEyoxgtkdCx8xNwdn77PyYoaQxMLU+Cp8MEqLG5mpTFOXtvF8YXyffcXnMKtweh44c8KLxOybx5o4jqBqKzIWe9z3fxkOJvCL8V0ORCpqXKbzlUFdUgM9Lp2YQjoyEj7F7XVNSi+MUzhFIfnXogvIGIGihucN/YUhXS/6okNJEF4CfM/+XFR90OvwS7DnkYsxB1a4IYPMavIhIhGhYtYPNdSW84WCoxRUJRcLNX9b6oFosvbdvmg1x9d1RTQwQ7K/D/CXinJWg1QIqTbpDS1YLoGUGN5LLbpJHYdJRPTAqUfLLKow92eIEV2K0wek+z2ps+MbqQinPTyXINcTrmNrfm9CDMg+enxrg4noaEcvCerv0RBuvqPMwiVECIwhjEluMWqDTvhJHrftu1v0bmzBF4D8KKZPGSNyjA0UexRAkLZNpyumr08r+st8FufGhV74UOgtMtjRxCGHNZyJK+IKCbSFnpkrK0EZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(366016)(1800799024)(261009223027099003)(261021121427099003)(56012099006)(261021123027099003)(261028144727099003)(261022105027099003)(261026140227099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lc1Vkyc4airDrLLHWhamWpVHiivk2UcCiOR4pEX23NLvb8cKYpoJH3V/Y69f?=
 =?us-ascii?Q?NUErf+Ql0p58P7CHlmIDH0H5e2uZfNaKRxHYVCRvaTx/E9hQd1Cs0/aailr5?=
 =?us-ascii?Q?lyu94pWhbG3psDcYTs1a5DgmwZbbnzzwKJxa/gW0QdOFYJ6Op40GczJBZTwI?=
 =?us-ascii?Q?AWTYutaQt5opCq8PUhpMT2a84Gq5+Ft61wvBQfxhjbvzWt+7aLroytS5GFb3?=
 =?us-ascii?Q?AUzyT1tDBvcXAQoFH7Lri+OY7eRXokohiI58vq38b6KPEKNWzlfnMh+z4uR0?=
 =?us-ascii?Q?VVFT9uN2DbBq7ws2RlvWZ9T4QzyDThgAUF+fGLsgNe3X/63iQOn3VYssLCjE?=
 =?us-ascii?Q?5d0vrG8PSucLFnk8vbF7gv33fjpYB9PreBA+UEc5Mqa+TQebvz6s6pIXKDxP?=
 =?us-ascii?Q?YCycJmZgOao4yBrvDaLM0L020vgXNVnwL7AJRbGWuWRuvgFADLzIq6d93V1N?=
 =?us-ascii?Q?ntXgVHh7crbEHpFk4T1oPJCTcP+94wc6gqWMnqnqLtZjAP/kailmyf9XaNyY?=
 =?us-ascii?Q?ql0YG3W4aKYugBKDGRTwbJ+6OjBTHoWQRAOBecmmdu9kPYFSmpXrWxSVN73p?=
 =?us-ascii?Q?HdDnY48dZd9j73BPBKTqt+Kk5X3Iyth1aRnaYJFzDs7VtBEo+MFj8w3RcCmT?=
 =?us-ascii?Q?e6dx/bat0EeDw814bC/Atbas+Y5GoxMBLHIVRaDKnhNGKNiEacYUk/iX5qbI?=
 =?us-ascii?Q?SxZM7ZykGoFNid0m/ohaA1d/8UVhK+v/sCDPKKQJcsV1lEKBapyGJ9bJnl1O?=
 =?us-ascii?Q?hWign24lovZynmhTU989vaj4JfPW7mkjS1PVXHkytq7wKcPt0b2vXGNC3I04?=
 =?us-ascii?Q?PVPZp5ufhmhAaEfRCqeZTvyXlG1IZb9wYGJlVfEt14q35AkSme7V3NEgCOKt?=
 =?us-ascii?Q?HUC+LuEdJ0dZVHw7NYirjftrALxUvZ9sci8lpsIJsp2NpPTDRWK5e6qh8LiF?=
 =?us-ascii?Q?xth0XObhGb8xdW7ZqB3IL9VW9h88a7niIhtegkK0wzhQyyKSiMVZF38/FECH?=
 =?us-ascii?Q?0FO7UTPqRFV5ZaPQV45CrQGZ79jtdSGdgy9Jj1KbjzDkoGGhQJwEwVdvDPs5?=
 =?us-ascii?Q?5ydTpRhZqsVhZ+QRy9OwPd5ffmBHTzocXHRMnryDusG0bRDcUf2IoQ4ARFmb?=
 =?us-ascii?Q?2WDUZZEkXHZDq46O4m0uo4nczeoslkMBvBamdqGi3zWYBaXkp+Ly2JOcxms+?=
 =?us-ascii?Q?tTlmuyYkFV+OhM3c4564+X6bhe+HkP78irJ/7N6I0Y1VbOcJGdmJFhEF+mAb?=
 =?us-ascii?Q?lzonSNizHB0Lg6EejRTKmbJDQvRch7+rJKXqyGsYBbf2ST+4IGKbX78Iu60z?=
 =?us-ascii?Q?2db1jx+CJblyb57VzYBB985rQZdS49CKkpSndVQRr3uDPrrguVHpdydYWTfD?=
 =?us-ascii?Q?JkQ8PlSJvlswRC/MOhi8xGRO2RKhKrmKjSTFmpnvN61j1ACcsZe08Pm7sUYc?=
 =?us-ascii?Q?m7NBf7nACmsoifkNBZPGgaV2Z+O9CHKK+0RugnWZXhyWiOF1yVE3rAOuaH5G?=
 =?us-ascii?Q?SJmIpG/Hgxzuwowp9Yodl9sYxzIl8MfCHQ1C8UNPYYCSfeLdEbZmqkoclbXw?=
 =?us-ascii?Q?86ezlBuJNcMb+mS7WFLrTgf030D/+6tpIP4i4KFTTgHaahdCVrooY/LHcrqn?=
 =?us-ascii?Q?GDDx/KtVqv3GQ+FwbptKcquXj/TjWzdp9BIj/wvAIiK1IF7IzPJbPo4AFY8d?=
 =?us-ascii?Q?loQMgEObJXuN1VT/EehPU5Gzr8D4Mdlwhb9F1hotr/SFuUs33beyjVcb2zgV?=
 =?us-ascii?Q?q1W4DWFq5VHzIlpOhEwA72Aunvk3MhZVEOMp+4eLXYZOdAwq7sP0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f419a17-42f8-4bb9-436e-08df3a8fe3dc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:22:58.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 250BNosZKSnbQy94+lzGVAw4dwNCj3jXKaxEA6Pybwh9o1uuSaNV+0kol2LDsnQ904w+OfU7rJPBlw2zuuMV2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1462

iommu_fwspec_add_ids() can fail while extending the ID array. Ignoring
its return value lets IOMMU setup continue with missing micro-TLB IDs.

Propagate the error so of_iommu_configure() can discard the incomplete
fwspec.

Cc: stable@vger.kernel.org
Fixes: 7b2d59611fef ("iommu/ipmmu-vmsa: Replace local utlb code with fwspec ids")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/iommu/ipmmu-vmsa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9386b752dea2..99586c68ef35 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -778,10 +778,14 @@ static bool ipmmu_device_is_allowed(struct device *dev)
 static int ipmmu_of_xlate(struct device *dev,
 			  const struct of_phandle_args *spec)
 {
+	int ret;
+
 	if (!ipmmu_device_is_allowed(dev))
 		return -ENODEV;
 
-	iommu_fwspec_add_ids(dev, spec->args, 1);
+	ret = iommu_fwspec_add_ids(dev, spec->args, 1);
+	if (ret)
+		return ret;
 
 	/* Initialize once - xlate() will call multiple times */
 	if (to_ipmmu(dev))
-- 
2.54.0

