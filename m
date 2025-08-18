Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013061.outbound.protection.outlook.com [40.107.44.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772CB2701D0
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500773; cv=fail; b=jTl7wxiLDXkUQI7yxTEJSIUom4kVGxEv6Lk6CAr49w9Wh0Yb+7tKIRD7MnpMi6+Hkhy1lYZ/pCJhnqrlyIlxGgL9bB6rFtmLvnfVxXAwr1PfonICs9QHHKoBh5Xy3TB59NdohanczYDeUtRQHMqaAgpfhHOkAlQruZbA+9acAyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500773; c=relaxed/simple;
	bh=or2Yoj6PsovMqtP8IgpBOMOarVqmspMmaWqw5FAfDk4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WfjOP2tk0IMED4Si3cZyz49HnuPkjYZzKwfwOH2HbY8n6+rgzdxBBOaxzjqNvadTYp0mA///vXks/7Sq/JfHJNT38FiHUl9lVskaZRfRZEaII+cNvfcVAI2Y3jqyFv/JvNqppZnA3DyE54V11GUclSL7yHLl6h29WZd0amLeeqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DojJl25x; arc=fail smtp.client-ip=40.107.44.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DojJl25x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kle8fD6mS9U2UtuIAvDHEmJtfDlFrhlR32gvWk6JiKieqoA+tCfSZudo7+Uz8ftqt6hUkBOl+niWjnrswWCXez/IKaoJG+/pigL+9Jm2VbpAxR2Q7HGKPZK6ZwKmRUg/bNLXDaClxgTRUvNevI6QHQ2IudappVJ+bBerpiDRPXT87U3/BX92CsWsNXKbsYrpLqOZyd9vaqCfcOdMJVKBzPPapLL9REtwj9v3f4ENvBoUfkvzZCr6MdyZNxDDEhCrPge5aFzREamGF8QklJbDUF+g0tPGXuaIsV7CQFqOgjcO6wnnySerRISaiqfhd/Oi3RswSNFNp6XrLOfFJ3Z9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeQjIgZu47qznmj4Tr39YZFNUMbt+To3GIN5ffWkk4o=;
 b=r4BQoKLlbznrvuxlG7oGW6c00MMoBkcG/5ZxfUeaK2uv3aJZ0tKySPJ0K+DYqZC1kRjPznhyN4hMMDeoMapNHH/ejY0Ud62XxAeTwFWQtL1t6y8GomPI89IDJDIb2ELZocC6lJAwhbcy+840nJXGHIpaNJcxuTOVLkCTP9ra4pxxrZ//5P0ZOZI9OAOGGewZl6KdQXu4z8dsp7nrZVhUsD3DJS5v995olqGT8nXvIrBMYbZEatrFbbs8ga29aiOWpLjZi1XuCjtWWYpig5N6PfGhdb98bog4gJZt2xnOeB47H6Q1wR8xumHnkvjAvztmyyU12P+TZgckPMuZcEaUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeQjIgZu47qznmj4Tr39YZFNUMbt+To3GIN5ffWkk4o=;
 b=DojJl25xoOMgDAi1xxFGBSx3S/i0bgfSsi9HzJQjcfhQrfOZ4dcPtnfcJUaM9m8huRWpY9vq4qoSabTpB1BT/5sCC8dtZVS4MElj7sJzGqmh6HIa+ux6QtrYwbK+hcw9+1haYXpsuyXpq8f51KV2eHQh0FVXho7xJOEbDXhQyamqjjYPMHXYp5Ad5xBrZQeL9TVJZGBf6XhyKd26yo9YLAigK95Fu77+iSL8nBQ3wzB8i0tyNAEWVKHaKXyxmaHm3QNwF25Wb+ACffOmL5Sys/+8IXyIHwng1aVfke7phwU8PLVxxulOplqftDYJmzWOGGyh9Y9xW9e/BPVZ+CsTdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEYPR06MB5987.apcprd06.prod.outlook.com (2603:1096:101:c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Mon, 18 Aug
 2025 07:06:05 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 07:06:05 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: christophe.jaillet@wanadoo.fr,
	suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2] iommu/amd: use str_plural() to simplify the code
Date: Mon, 18 Aug 2025 15:05:56 +0800
Message-Id: <20250818070556.458271-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::14) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEYPR06MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e073d1b-5e68-4c3b-7d16-08ddde25b2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9N6Mj68H97riC3tYHlc8s8y9vVnypuBAVIczCcFRCXPdMqvhTGg97TAiUJYq?=
 =?us-ascii?Q?lV/NviRXsDcqXvuzA1YFHYnVUGwtiF8pAyGTsYynoATgM2d5ci+1GlClpEmJ?=
 =?us-ascii?Q?1n1Ib77jhzttvQ2FUwMbW6daiFYWDdtpEDRs+PKY36mB3wOck7Uo2q/Fd8gN?=
 =?us-ascii?Q?oUmH7meDjQ4gsKQJAKepfC0bFaf+k+yU4ZTC0TOIHnoE8NLFn9DAZr5+70vj?=
 =?us-ascii?Q?QB94m3uw7tYEryMzfDS7GpSxMThjaQLkCnF1LzBYpd/PEIi7U5BWjI+sZfxZ?=
 =?us-ascii?Q?soA1uwD11gJJkgnVCJ3K/ilFAabwcusGVpzYfaGORuFgKiMZ6lk6cO5UeUf4?=
 =?us-ascii?Q?MU0Blgcvx6YqiB3EI501v+nJcnW38qgtgd8q408AThI30cUiOtlQmTyKHONu?=
 =?us-ascii?Q?zEYIy8AgBI6GScf3GJ21iobYbM1wWQKNhGJsVpvVPDFKcjdVrh+kDN1tZPcJ?=
 =?us-ascii?Q?4pieW0c1VEbuhTOqGutp8Uz+rb2gDw5r+DwpuoHa798aiie9cZn5jod6qWbK?=
 =?us-ascii?Q?Kbk93qXUaqUTol3G2OM0j/++o/mbZTAp4cP7OH2fLwPiaTuey3AByzlWZYaj?=
 =?us-ascii?Q?VQxzEt3hBGfqaQmT29a+MfopHLc8ivZt5uhV/6K2AM/Dcbqngh2AYGSTJzJR?=
 =?us-ascii?Q?3Kbvq75lXrGM3kAzJM0UtHHSxhbKGiurEzxj4LPQ98zCg/YzFaQu509ynh2h?=
 =?us-ascii?Q?UjElWweOYmjANNMWv2oaiPoHk90pXo/OBk4bjjwmiKlzWl++bME8jXkjJ49r?=
 =?us-ascii?Q?YFgWStz6MiI3yRnr8TGvSZaMD/hRUsGcmi4NAihxxdnN5UCiSzwuH402MrVR?=
 =?us-ascii?Q?4qql4kMJeWA+JsAO1Clo1gHOEMBTMj4Zp21fniP6QenAJxFSqE7gWyJt8/mG?=
 =?us-ascii?Q?AXYRzqaspHGh+AfBVvzDmnrR+TzfVEX499hycvQ9cdPSHQgRVaEr5yZghdFV?=
 =?us-ascii?Q?fyIV7KprzFYUEBX1q7hAgqdqJaFRXMn3M7OS+sV3sDDraVXJSOMhCDk5hF6y?=
 =?us-ascii?Q?JEZBmnyipWtdX7Ut18hydoTyxaaNZU4usMt25Xkpulfl/snKAxci1zSWK0QE?=
 =?us-ascii?Q?xjqnuz5UG0OGOrlvpX0V8+6HrjSL72BetcOh5RwMhVGw6izW0BbBWwImiYN3?=
 =?us-ascii?Q?N6rqiV/1WoiIeRqDXIAo/jf/TaG1E6emv6yde7Pq3SBL5kgz1Nnx5pZbr58O?=
 =?us-ascii?Q?NyoAnMTzY/WOohPiXFxEPyTj9+Vg5c4hLUwdKXE9JxIYtjvL0F6jGhslmItS?=
 =?us-ascii?Q?jHR7RiCxiAW6xtQCfz1Vmwz5teq4yEpWV3XZZHGHvl/1cP3oCLbmVORKALmT?=
 =?us-ascii?Q?xk5ijZbMfj8M2Y5LOTvw6pJ6qkDVp4SCCq5A8iuRaBfiK+GSI8dhpSiyxf7i?=
 =?us-ascii?Q?rra41Nn2nLBtoCDQVvyrrjnyxv8O9+FZyXvnrhLKuPoVm2+eL9COxen/9C9l?=
 =?us-ascii?Q?W2J7UXWv2NeDgAni6tIBGEkxPJikud3L/w+cHQ8RpR5oRGfRbXM/aQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZNZnNidz8V9tWudDQf6Sx+aoDTqcAIIQcc/6DZoim8Krfi4WB2hh7u6UGDx?=
 =?us-ascii?Q?mEfNyjexX8x0TvLzahd5k7W4+OfvEnsIXybna4z2etWSavWzElsy2eqCoLad?=
 =?us-ascii?Q?fSQApXuczwZatBBJsiiOdgg2juQzeWapVmi2bCDcXB1gdXziUVYL8kmr9p7i?=
 =?us-ascii?Q?jkvvMAx4Czu1YZQTNZhIVz3Z33iMzx+4BzUa3/XN69FzzE/hqg8ek/H7RLHq?=
 =?us-ascii?Q?7vCngtgX5yoOYZGh24vZB5R/KIdkQUQ4XD0Anc7jhs6kKWQgyRqTAIo//LOh?=
 =?us-ascii?Q?XhHppdIfotmzJfsCW/gf9pIJEnTjU+Zo5tIfUZ8TjoP0Gp8E1RdAeoFpgNIa?=
 =?us-ascii?Q?p/p4mNMMtvt+IJ3cGXKppKSgnVgOZY/6Rwe20t12y3uw1nDmSKLLbBSmm1S0?=
 =?us-ascii?Q?3C43wFRidz8LjC3LJcdjJOdIxVnWCogq6M/KC3SP6KJSdJPtKzk3MesltaK0?=
 =?us-ascii?Q?WXBZ8bC19Ohef3b7FslYdH9TMG2WtbS2BdKMDT5MM3SilaKbe1uIps8+yn1p?=
 =?us-ascii?Q?JxJ4z8ZUHF0R9om8UIY6txd9oylXEsKdvZZqMKUdWaJhW1y4TVoTK8yZnZyj?=
 =?us-ascii?Q?rBqc6NssuYGXZIWYeuUKUdDe3IfEjU1wmt3DMM3CGEui9JfRWgqvJJQRT8d9?=
 =?us-ascii?Q?GHFui0EOWnAiSRTpixrfh6xLaoPOjK/OnyZAMIG1Qetz9v8cqaeNTA36zMnx?=
 =?us-ascii?Q?cq7pDiBJbyryqhvdeRfSnb7Tm81NCa1bXn+tmbNELclmtzcltnDGf68bvTRh?=
 =?us-ascii?Q?1tmr/mvYssIRU3lramzCKBBNVqYWuxvhC5R3Zdi3/b1ELJFzv5sf8Bo/V9s9?=
 =?us-ascii?Q?3Nrs4STCfegdZ+Wa/2RQZTcvTZS7EqOf1bZI6IIIIMe4K1ITXWjjTrSJmpJE?=
 =?us-ascii?Q?5z5y1Ca7hB1PTIHyJczWofC+s7581r46i5BLvS5dSDxlHEYkJ/chVPew53KC?=
 =?us-ascii?Q?vKdG5vepntwA9o3eqm3D3o78ua+lah1D+TH6SD6lgOKShPWZoEf4uJABsy/T?=
 =?us-ascii?Q?HWf0222TneCGh9MYSKpL8bnrSbvqbRemhO14S3KxXVUXITeokWpS8nznIMUS?=
 =?us-ascii?Q?a+RO1mPkK6PlB/viJ8X0h/P0qvFFO8mfJgmb8/TC6pUbnxyUEoZHbYQ8hiBj?=
 =?us-ascii?Q?DQQQoeL9e8bm0Z16gbHRYvhTbwFDuBe4X4kEQgX06n8MgdUHz8o1hMgZm0PP?=
 =?us-ascii?Q?YSQc09CW1U//z+tw84G9inA//qr6CiI+gr8yefrulQkxP/No34wdFNNUJAuO?=
 =?us-ascii?Q?b85urgXUrLCHuVKkFDE3FPRJ4Z3GrtMdCqDT5JlVcC2Zi6EBHvgL7IlXhwPh?=
 =?us-ascii?Q?qDY1dxCE4zfjcGDaBz8QBaUJ0tNa6ll26y/lsM4cZ1DrZJhxRa2VyiL3MtJg?=
 =?us-ascii?Q?OGn0bgWPdz8VNhsGdbyQKgBDbpWPZrzoBQepN71SlWm1EyaneySti9C2HRoF?=
 =?us-ascii?Q?UmVpC6YkfVh+DBd//9NIPurJdTGDiEwuBE66sQ2b7ZaV1Qge+7qCNdI1k9Ku?=
 =?us-ascii?Q?Iuu0sxcj+95bISOMrGKv8XNnTBX4IIPMHkSlx3KagHt5vfy+v8J0nFoqvkc1?=
 =?us-ascii?Q?fXDjZe49JZh/KFRv3Vek58y9TVTN2Dlzv26JkxLd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e073d1b-5e68-4c3b-7d16-08ddde25b2cd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:06:05.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wE6cIAQTiOKlOJHeFqRlODjjOE7l33swxpli7UoC6gJiXF2k4gsjEkGse2y7jSIrh2nSswJ9WQXq0sXgfJsrng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5987

Use the string choice helper function str_plural() to simplify the code.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d0..fc11a5dab8ec 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -14,6 +14,7 @@
 #include <linux/pci-ats.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/debugfs.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-map-ops.h>
@@ -265,7 +266,7 @@ static inline int get_acpihid_device_id(struct device *dev,
 		return -EINVAL;
 	if (fw_bug)
 		dev_err_once(dev, FW_BUG "No ACPI device matched UID, but %d device%s matched HID.\n",
-			     hid_count, hid_count > 1 ? "s" : "");
+			     hid_count, str_plural(hid_count));
 	if (hid_count > 1)
 		return -EINVAL;
 	if (entry)
-- 
2.34.1

