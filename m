Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904614C14E6
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767252; cv=fail; b=avqbWwsdFiKsIWeErJPlkJPRMVPWG0VGZxFD/PRbgLTbX9PUuc3rWPY9RxZaaqV2wIu75zBx9H3rGRAcwF2a1Ujq78KCFDZY5FFlfdBbLWNfw3fGmKgBRdf8T+Lr4cE9dXwg31mJ7XP/1yVUcXhdpdK2hJtJG/QV7QAjFiik2EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767252; c=relaxed/simple;
	bh=jGxj7esqrfOUGbvWlM2uZ5OFDU+k3USQM/XeSq6eP+c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eO9QCE/hi7z2Mgw+tMIMS2Rq7VuwozPCLPxEzeYVq3NPZFOhe298TmYhIuHWCoPpkhEj2B17Egi9WUrnqGyyNdNu7kqz3FqqKXQwwC6gpVQsgCv5mlVD/Ly6GmeUTT99EvUCKXDqnk6Jo9Kh+Lk91uS8I6Uet9GQoX+iL8xEOig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GmEX8eBK; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GmEX8eBK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhHoZvxe6HTovEAal3Bqly0ABKWnQwTkE3MHKsLaiEuxXQx18oWe3rUzMmJ8/ZVzVuXiRcGMvYpjUz58cBTmdaVDdc0xrPwAri7qj+1IDw6UJ1i4IJFc6kl5naziSefWlHj2eL9rTK0np5ykRqlXMD23dTkuB2L8JGIiefCS6K8C85Ht9zMRMmGA8agGVagTEgkHkuqeeTbBGyvcgGFz28gBbG+F1YjzIPMqN7ujTERt3qMcvw//uAbj7LGkD3J4qw4WvsKyaEDrDMzZJalcIKu4vIJgqssNLFVZXRXVqBm2SN2DtOuc+7vplnehQMXzZLjpYLePlwGm7HHPJDnnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUdceregwfkMHsFKEMR4bpSgcTvojhL7jrrFUSZy6FE=;
 b=zDn21xUkcWYaP8dN6YYDspp6JyUeGm2IRTOEcsjuJwgtZzoV+njTGRdSeIgjo8AsW24ufJ2Fk5ZS4T4XrPK5kalRBfbK86QJR6hl9B/rpFPGz9NbLK+ty+piNnGO+u2eMdxFyh4DjmFB0gZMg7/PnlbmHiLcYkh4L7G4yqkQ9Re8DENJ+gYfFKPJqjcZaK0hibfK+ht/9zKx+mg56BTEPNDIf8ahR9igLs958HL3ry2HgMdDax/hpeaO7D1dcL6z4LID7Y7W76oouK1vPRk4ZW02V3rouCmf564AxQZmfWGc0yRX2ExX0Rrm9p30DeucJUBjABYWVcRHHn2rjij9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUdceregwfkMHsFKEMR4bpSgcTvojhL7jrrFUSZy6FE=;
 b=GmEX8eBKKQ2/hW01DGIla490ht3AkERVncWOwZCelAzkI2WCaq4fsrBSB0aY6s21UtBLgpDgAKlfBF8rS7gbrx4ZqlWFwFlFdkyLmgi+0ATfDNvKtgPML5UVEZrtRFG0lHoPAlOae87vV2tie5Wsemunv0B2nbueKCzHVFVeHNubg28c6LfMPb6bQtoNZdDTLNJpniIlOnKKaNiFSwwdnkgvPoPyf0BB9r25ktf/dh12tzAwUDk73YTLsnlJ9RSw87Ie93txdTf92yYRjIdPjPm6LarwEj+ofPuYJJoz8Iy5U6I3Q5auQ2tX+w/qudbCN1U8SZq5z8+80MSjOQt5Mw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB7800.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:20:48 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 11:20:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 30 Sep 2026 19:25:01 +0800
Subject: [PATCH RFC v3 1/3] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-smmu-shared-sid-v3-1-8abe6c1b4c20@nxp.com>
References: <20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com>
In-Reply-To: <20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c237909-1060-4d2e-d618-08df1ee4e091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BcyJAShf03cLcx6/yfClUyJ86vHosl4dGUhc+eagIEnUrb/dGisF2k1cmuUuQIw3rorfdUZ0kUgTmTMyPDOA4EsjrHO9CoGjwwF02OIrddZP+xLUdTleKVKXwXqulz3N2NuKj5+DkDkoHAwFrGtrw/Qd+OntrgZ+0OPmFzMjOEJZK66phScX4/+QHhbUep0xU3+4x9agE/vaWDTdkHqZfubiVz02WxBoC1xn6UeYFE3UIDzIh5F9YtZ5uAOjhX976tZ0ZwuKP7HcK+YjDOiWBcZyFmRVlSrlQLV3EdWQoney6bldtORq5aoYvYWVIxXi/w6PQ03W8Kxconp+gBt4NitPZmKtoDiCSeI8JCEWBAm7cwUyQuzwL8Q9utROqnXuZc7WixLofpRPfhr2UgQaPNpMUlrdwAhz0X1ef+Ov31BrJwiMBXlXbVPXOrp7X1M2AANh5KL65/SuwR+2Py0fyODFtL+uEW/wpXIQ/2PoGtWQoJXlvkTyKRvRbVXC7A7wAAB/WjqO1Uzh2kWPqt7gOe6T6RIDnCUXKhZjNujOerruPbnRoH5sVL6R9+Iy9JOnIbHY+uqja6VkcUjteup8c5bYQ9OgskcXjyt4kcltGMxoRoUo91mBOwdKk3HUpxF4U9197ukSdaGFuZxpqU5w+qkFAuawkT0C+pzklpxaBXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2c0eFozQUY5SlBkSDNlM2pKeFkxZVpDV0FNcVdYY1dNcHhmRkVBUFJNLzg5?=
 =?utf-8?B?SmllT3kzdklrMFVoRkhFMDBpRlRMRXkrZWFzRko1allwelNYcTN0bEtnVHVk?=
 =?utf-8?B?cTByUWJVcVVsK2dCUVBtdkVzTm9GRmMzbUM1UnVxVVp5RG5KWCtGSU5NNEg0?=
 =?utf-8?B?ek4vcEo4TVUrQS9Ed1FJY01zcDJURitKTFhHNVFzVlV1UkdSNnVRZzYwMWMx?=
 =?utf-8?B?bUQ0NEk3OEdZTko2OVFkZGRiT2NOZm1jWTVaY201VHhLcVRnTHQ4NmxPUXZh?=
 =?utf-8?B?N1JVUlZjM1N6WE1LSFhGV25JNXhOdkNsTVVHYWlSYyt3WTc4YXVZTEoyQlMz?=
 =?utf-8?B?cVU0Vm9jRzBGTVdhd2FTbTAvYUVKY3dFV3ozZm55cGROcWVzTjFlcituTERN?=
 =?utf-8?B?aXM0dHlLb080NkYzeUlSUmpMQXJDL0o0MTR6T21VV08xNDFKUjBUekZZd0JF?=
 =?utf-8?B?aUgwS21jUWNUWUg1RGRqejRGL1VXS2MvS3l4NUNRdE5pVC8xam1vTldoaHFp?=
 =?utf-8?B?TnNwbUNqUi9pVWc5ZnR1MTRCOE11Tktyck9mNnRBd0ZTTmVNb2VKVDJQVkpQ?=
 =?utf-8?B?TDVTT3VvR25kSXhTd1U1K25VS1lRWXdzcWEzaWFHb08xUVhaZXpqVnE3Mlhh?=
 =?utf-8?B?SmtpaDQwdHhnbkNnZUZCYzBBODFkYzB1SDk2RngwTTN0aDNyVFdaSHo4Y2dt?=
 =?utf-8?B?V2c3OXh1aFlBZUZGcnR1YlVFOW9OOFFLWEZsU2g1VUxDdnFNL0g0RjJCYWNx?=
 =?utf-8?B?V2FscytxL0ZJL1F4ZDYxcXEra1NkV242WXRYUWdpQjUvamZYRVF6VkxpU3A4?=
 =?utf-8?B?UEdJMFJCZXdPK3F3VXBoSXZsSkZrL2YrbFVjTHlPTEZXU3NpeE1lZFJaRzdw?=
 =?utf-8?B?b2dYQVREWSs3V2N6MkxOY1VkNzBSenM5enZnYnhrRERvc09vS0ltSTdPK1I3?=
 =?utf-8?B?V2Fia1AvNmt1UHgwZ1JWY3dUVXNXYVJxWStYUFJ6anQxZUtoUFRpQ2hNQ2Ur?=
 =?utf-8?B?U1h3RHFIZmtoWVdMUE83dE5nSzBMSncwOG50ZDc1dzlsSWhGcDljN1dOQ1Zz?=
 =?utf-8?B?Y1VzdHNtSDY4UWxnclBNVFFkRnJ0Nkh1MjhYUEdwd1M1WkVvTzNaL1RLT3Vy?=
 =?utf-8?B?V3MrUVhxMmoxMmlwRkpzQUMzdE1HckZucTBua2RRT25icGF0dnY2NENaVWNV?=
 =?utf-8?B?S1J1ZDlDVWVid2UvT2NNN3EyVU1ObEFOWEJjQjcyNDRva1JOck9RMnkwYXBw?=
 =?utf-8?B?dCtUZE1KM0hlZjVYYWg1S3NnNFBvT2x1dkhveEVvYlJlMTROUjBQMmp2cmIy?=
 =?utf-8?B?eW5EKzVqTklMU2ducHZMZjg1anU0YnJrbHYvQzNTRHZlWk9ENXl1Sjc5M3FO?=
 =?utf-8?B?d3puWWhtSFFrSEFSTlFlWFgyL1dyVy82NGxTSUxnYTFSMkVDcXpiUFA5ZG5I?=
 =?utf-8?B?ZDVFYVBjbnM5RllIVWlGdkVUQi9id1loTkxUeXBzSGRBVWdnaDZTYlB6eG5l?=
 =?utf-8?B?bnpUektwMkxMZU9zSFB5eWVqc0FscmthcEw1MTJZNDdsNW9HQzJwT0pvNkZH?=
 =?utf-8?B?ZkpaMUFENktleWVsaFJSZnRhZGM5QWVybVRoRWtSQkUxUm5OK0ZTRGN0ZmlU?=
 =?utf-8?B?NVgxZVBSVUU4ZzBtRDMvRGQrN0ovU21hWnA3anJqUERkZXdwdTJ6QWNwYzh5?=
 =?utf-8?B?UmEzbXBDNEFldFFXZlRsVzQycEtFdHJtMTVteVBFUlZWR1EwQURueHRrVmVR?=
 =?utf-8?B?bmZyQ0hPbkZWRFZVd0RMcmRvT0pvVEtmZnd2REtPSnhIRlhpcjE1a0Z1WXVS?=
 =?utf-8?B?QmVvVnpIWlRwbmRJZksrQ3pPdjd2aVZYRGRtU3RKSi9jcUdqZFIyT1VxNHB5?=
 =?utf-8?B?WW85MVFYdzBjSi9rNDc3UlZJdXhUV0tsdE41dTdmZHNrREIxdEdZK2x4VkRT?=
 =?utf-8?B?RDNiZ1NlK1dLY3hzbm5zd2xTSjlzUjA4Y3pxY000YjAxNzJZWG9YVXVGVVM3?=
 =?utf-8?B?b0lYbGIyekxwZGs4Q1c5OHE5bmlLQ0dFMUVyWDAveUtCN1VMeU9oN1hSenV5?=
 =?utf-8?B?VWZndkhKbzFSNDFzcG9TN2JsSFQ2ZGh6MlluRkZsTHh0VzdZeW5NMk43WUt6?=
 =?utf-8?B?VnlpRnU2K0lJc081UHJxbHBzRFpVWjMwM1UrOW4wQmk3dVhibEtGanpHUGh3?=
 =?utf-8?B?TldkdzJHMmliREE0QXg1NnJCVTgzTWcrWHBhOHVSOFovTCsrUjJYUkxwbmJy?=
 =?utf-8?B?L3VLR3pWank0bGE5dlREVjRZRlcvZDdxRHU3M0RXRkNVc1cyQ1FsVmhHcXFv?=
 =?utf-8?B?ekg5S2wzZE95M0ZBeWJ3bkRNMW9sdFJrQ21QaEhzc09nTzBSaHluUHhJYlYz?=
 =?utf-8?Q?s94cXrsgSDQPnf2mwyZL5sEKIh21iKFJpVa1D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c237909-1060-4d2e-d618-08df1ee4e091
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:20:47.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mKrP50mksCWdG9fEENle+XoL0xSBXtbpwr9CZUwlR2pwNxi+OXWnfawARz/rWaYQSBx7iUQXY77mV5p/FeGK1qMnUQqQ1YVTbGoD1pyly44BdajkY58azb1CjGkwn5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7800

From: Peng Fan <peng.fan@nxp.com>

Some SoCs have a limited number of IOMMU Stream IDs and hardware
that inherently shares them.  For example, the NXP i.MX95 has only
64 SIDs (6-bit internal bus) serving 64+ DMA initiators across
separate IP blocks - MMC, SD, NET, PCI, DMA, NPU, DSP, DISPLAY
and more.  Genuinely distinct platform devices share a SID by
hardware design because the SID space is exhausted.

When arm_smmu_insert_master() encounters a SID already owned by a
different single-SID master, instead of failing with -ENODEV, link
the new master into the existing stream's shared_masters list.
The stream structure is shared directly: the RB tree entry remains
the same, and all sharing masters are tracked via list_head.

On removal, if the departing master owns the canonical stream,
transfer ownership to the next sharer.

Sharing is restricted to single-SID masters (num_streams == 1)
since multi-SID sharing would require more complex tracking.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 76 +++++++++++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 ++++
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..940f34465c0fa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2044,8 +2044,8 @@ static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
 		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
 }
 
-static struct arm_smmu_master *
-arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+static struct arm_smmu_stream *
+arm_smmu_find_stream(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
 
@@ -2054,7 +2054,20 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
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
+	if (!list_empty(&stream->shared_masters))
+		return NULL;
+	return stream->master;
 }
 
 /* IRQ and event handlers */
@@ -4115,7 +4128,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+		new_stream->ste_installed = false;
+		INIT_LIST_HEAD(&new_stream->shared_masters);
 	}
+	INIT_LIST_HEAD(&master->shared_masters_elm);
 
 	/* Put the ids into order for sorted to_merge/to_unref arrays */
 	sort(master->streams, master->num_streams,
@@ -4136,23 +4152,29 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		existing = rb_find_add(&new_stream->node, &smmu->streams,
 				       arm_smmu_streams_cmp_node);
 		if (existing) {
-			struct arm_smmu_master *existing_master =
-				rb_entry(existing, struct arm_smmu_stream, node)
-					->master;
+			struct arm_smmu_stream *existing_stream =
+				rb_entry(existing, struct arm_smmu_stream, node);
 
 			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
+			if (existing_stream->master == master)
 				continue;
 
-			dev_warn(master->dev,
-				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing_master->dev));
-			ret = -ENODEV;
-			break;
+			if (master->num_streams != 1) {
+				dev_warn(master->dev,
+					 "Shared StreamID 0x%x not supported for multi-SID masters\n",
+					 sid);
+				ret = -ENODEV;
+				break;
+			}
+
+			list_add_tail(&master->shared_masters_elm,
+				      &existing_stream->shared_masters);
+			continue;
 		}
 	}
 
 	if (ret) {
+		list_del_init(&master->shared_masters_elm);
 		for (i--; i >= 0; i--)
 			rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
@@ -4167,14 +4189,38 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
 	int i;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
-		rb_erase(&master->streams[i].node, &smmu->streams);
+	list_del_init(&master->shared_masters_elm);
+	for (i = 0; i < master->num_streams; i++) {
+		u32 sid = master->streams[i].id;
+		struct arm_smmu_stream *stream;
+
+		if (i > 0 && master->streams[i - 1].id == sid)
+			continue;
+
+		stream = arm_smmu_find_stream(smmu, sid);
+		if (!stream)
+			continue;
+
+		if (stream->master != master)
+			continue;
+
+		if (list_empty(&stream->shared_masters)) {
+			rb_erase(&stream->node, &smmu->streams);
+		} else {
+			struct arm_smmu_master *next;
+
+			next = list_first_entry(&stream->shared_masters,
+					struct arm_smmu_master,
+					shared_masters_elm);
+			list_del_init(&next->shared_masters_elm);
+			stream->master = next;
+		}
+	}
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd2fee2f560e6..ea0aa345fb673 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -969,6 +969,10 @@ struct arm_smmu_stream {
 	u32				id;
 	struct arm_smmu_master		*master;
 	struct rb_node			node;
+	/* Set when the STE has been programmed for this stream. */
+	bool				ste_installed;
+	/* List of masters sharing this SID.  Empty unless shared. */
+	struct list_head		shared_masters;
 };
 
 struct arm_smmu_vmaster {
@@ -1017,6 +1021,11 @@ struct arm_smmu_master {
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
 	bool				ats_always_on;
+	/*
+	 * Links into arm_smmu_stream.shared_masters. Supports num_streams == 1
+	 * only. Empty if SID is not shared.
+	 */
+	struct list_head		shared_masters_elm;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };

-- 
2.34.1

