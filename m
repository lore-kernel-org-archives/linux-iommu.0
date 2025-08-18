Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013061.outbound.protection.outlook.com [52.101.127.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEDC25A2CF
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 03:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489229; cv=fail; b=F4bQJ8EbnXkd3F4TPfly2AcUQ4jv8/giecPEBXsKTccEKFWYvCKZ97bP9kE2XwfFijUm1HzcvqYjKW6tpo5VbPKqPiI91H05fdXUUoUU91V8mZOuJLtFPig2Tw+gffDGQONh6IDaxqHXLhDm+R5tTmb5bNGq+USg8o5Famj+BCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489229; c=relaxed/simple;
	bh=v++9N8G4Lc0ypgQkOtAxllO+W5+8VEPf/3h3r9sgYBU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=efL3sx4a28D1d6BuZhg8XxsDE+jBenQRuHK2qUyIWxjcKH4UanFc+xFxnnz/PkEjccv6g7jcuxWVA4JJW02O0FZo5oa3pes+vewQZDdInSxrxyOZxoW43AphHr4PgDDttjPEyXfDlx8GuEebuCPftBb6wJKpXipaZk4sVFf5eYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=N+8QhPri; arc=fail smtp.client-ip=52.101.127.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="N+8QhPri"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJN6gOGgdQgc7Qm5WN5tIajqoa9UufGx5lTZ+VN/AyKUEcSw9h+UhRCsxfpxgzPA8+grMnCpw4v8XW2E+puNvV1x7EtbSGeszI1ExfCnDCxFYUBVYnqQ8mUTMLZmrbiWiaDG9u+5mqrawuJuvH669AaLnesH/egjQxoU//hP/NA7Jg4o0bTNd7Ag/hbvp8uyqTauJRzqz7HZY65St7kkiTOkwH29ckEREH7GtHiCSNwDnc08velCjLnO/I/Ab5ebcCIoX/wG4vDoqQahjwXvBQWkm1jcnWg+mW5O1yjI36NnLxmKn27kRtNOYKj8wI5dz5EiXYV/K+KwdaqTcJWcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNz/VQg5lXeSt9ilqzsYSfrsbZNZsUTzJvTscIoR/BY=;
 b=Z61F+bK4pCqQdPyM5kUeBXTuU90ri0Snit2FzsO8vZdd6c5r/JmTpJNNfbo5u+ij0u/MJzp2EJytUZnHuUlr5RQ9Dsh6yqCZ2Vi+41/8SmYnSXerdtsug1VXOUFmlMl0RjjuGu8gqA9Z0NLG4v78QDIarcRx89W/25XinbXLqqH6GV15N+h3lbu82VN2kDhqDK987RQus0CHwBQ0JzRyD/FI4g+38XBI0fo9YSFvhx2pdU/CY0LAOGE9/Py685sAjaOHuyWihFvA6pnOLRStV+M7ngTcIXTGcAYYsJYTxzgpg4+VQXsrxDmxd4FqDIf9FUflFxaeLY7j88HB23uPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNz/VQg5lXeSt9ilqzsYSfrsbZNZsUTzJvTscIoR/BY=;
 b=N+8QhPriqDjbtgQMoZUgnl74YjEdxhiHqHAeTo8pL7BVZ1GDsBfqq9yRIJpyqKxGnyMfIcR5Y0pcrRGUYut1h/n1wkSSQos4TId35Iy6XpgPbgF3RHyUK+QhCE3OR6Xbkxv2kliNEDGrEDj+1eLoNwMW2BwiMT/JHuoCgg7LG8CrICy6zyISEcyG5QXd5Bfzh++W5jgPoPNEAR8xsu0hsxZnWfKNxb9c8dYzIv8h8yPcSNj40vCx5xgP48IQT8E9OB4QVqd489V2HnncNMlQyynvbLFUqBgvuTwe0iSyjZgYQgaIqo+1bJoyWlMMRIhZHoh3T8ymaqFhJKc2l+3XHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SE3PR06MB8016.apcprd06.prod.outlook.com (2603:1096:101:2dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 03:53:41 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 03:53:41 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] iommu/amd: use str_plural() to simplify the code
Date: Mon, 18 Aug 2025 11:53:31 +0800
Message-Id: <20250818035331.393560-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SE3PR06MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2ef701-fe01-4a8d-3b7c-08ddde0ad22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GCTs0Xb74NUOdSubbcICxNx5djZ/3rcoC0FqNXiAz03fePf2V5WgmC81zDPP?=
 =?us-ascii?Q?yzpdHgH1RM2bHmV/7SRyH/chDRlhbNuZ/DBJfeRKmJAHG1sVHQWmOQR6ZQi9?=
 =?us-ascii?Q?jfgh6FajZLc5SBPDRyqPLakbbjANz9o6YQSWmmBqKvdl7vQ1/EzGA3a5u+U9?=
 =?us-ascii?Q?i8fP+s3q3VE3hOqJo/yLhLtSVgLBIGbEjVCxXw1Ej8IAiJC6SMJureJASkc5?=
 =?us-ascii?Q?5pc33K8nSKfWDsaLeHQSWHpWYvm2S8wYS66bdbc9OlE9loFzKZz2StEaJnmY?=
 =?us-ascii?Q?AtLfiUJp9xFdNbYCWVSdAEQSTxcfh17U0eBP2SL7+gmbphLzgW9IHyJXvAB3?=
 =?us-ascii?Q?hcf6NQ8gL8FjDV8/5hhfNf5LeJ9jagYyTlbyU1PcmWrnmt8cuKD9B4y2MVza?=
 =?us-ascii?Q?lRPSrDH27IG3j5mAvKnuo2bEolSgVbgwL16XV6pKmMwwxksgh2hDJXpwQ5i3?=
 =?us-ascii?Q?t+CvXSfUp06oTJGQvZnZyTXcUMQTvSCQ05gtnwh3ql+nNeeP1mKQZym2/u4s?=
 =?us-ascii?Q?Hdj/JYtt+w7ROUNriXa6cN8/DlhD9/ogkJsAZJbDX6m3w6Z48DzF3VrL1bL6?=
 =?us-ascii?Q?5NWmOQElRIZ5+qIsA/khRVrhYxywGkTiZoQza7a489UW4TGSmJmxrms7n0iz?=
 =?us-ascii?Q?RiI5nyZi9+ft/UXcbicVZmkzAAztwTaxiQ/rk/MmH2Px7YdfV6DWYmy0YzUQ?=
 =?us-ascii?Q?CEv8Rm9XGGjCsfoeS7rBJeICTMhCHC9SGxbwaFuyIyAsyT2wCSzWafvbwPf/?=
 =?us-ascii?Q?Kd9++3yHOKWg12mgwvmppYXMnzyD94vTVwUvi1Jm9DYROV1iUpNI3INp8WgY?=
 =?us-ascii?Q?vS0BbKunL3UzUDYncTIp07wloVnypDMRckC/yIMBy2jyncOZbDF0Ct1VY2sR?=
 =?us-ascii?Q?jMFEzdl04W5ejxfjpmXf7a3cXANo+krzXlSIvwB0m2rGPu5K1iSy10Bn66Wa?=
 =?us-ascii?Q?qGw6VWzuSUe/YlvftK2+YPPU5TdU8jMV/WcJGAoJQcqGN1hj/EfZAWjloaDP?=
 =?us-ascii?Q?rCZUl1mutBg6UDpHauZlUvV/rH0Y+FTxVivnG7RVXOuKhJoKwUJC67rBaIyT?=
 =?us-ascii?Q?gI0ZbKDUZE7pJEVAojpUR8H2Pr4pRhFORgDdEvVdmyq/2tNXUEd3lfJ9uyH4?=
 =?us-ascii?Q?DqLckMNF/9d5q6Nqh/DFrrW2oRgdig/Ao7Ho06MGLepn7vvkv6tXnliAsi67?=
 =?us-ascii?Q?6hHCMqTZY1dgrwJerfI3bQE+gCK66EDmqu4LvLwQ1HOWeMuFZBDzT+m2nIbl?=
 =?us-ascii?Q?Y24JjguY/MSos0BDIH2rNzr2oZmDmWUsvxJVurEPnRe51byCoQNELHNReTBC?=
 =?us-ascii?Q?cqQ3Ysqjb5Vw+8xSlyRo0GbSgLQQHSqyFGB0GfxpeF9GU/FLY8CR/ePzvXuK?=
 =?us-ascii?Q?yOWeAPBzF6SAX0AQK8j7aXRkAthqJ0CTwwzV5TNHEubB+ymUAiOBCkfBmVXZ?=
 =?us-ascii?Q?WSUtNbHoE9cssmUHT/EpA0fo7kZtcH2iHnGCstxvAchsAXLXV6MkWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WdKKAb21gZaina1Ycg1gdolJ0I4AP5B3/fMLTKJxNadoyUI1Yu8kcHJHSaGQ?=
 =?us-ascii?Q?MDSco0ZI97tIWR0sOodaiYJ7+ZpMn8/y80l0WEQg/sM3r7XteYdLrbT3mA6X?=
 =?us-ascii?Q?+jZ3OWszsQmAPsc+e+pCnTS6Y5KqruEsWWziv0EFISRHSOOGIAXOEHEu1sKg?=
 =?us-ascii?Q?2OYxnIw69mfAW63L6sRs0T42NA5OdRPX21ZlYyT7CY9BOBH6c8ufm2jJ3nDT?=
 =?us-ascii?Q?qBtF0xVZKkiTaTtGoOPMOfQAur7OqbeOBe3y3jaW4PxR4x26ExsJFlBnQr0u?=
 =?us-ascii?Q?DgMQ2NdZmkhAO8fcg5C5uycE4e8vF6K+HnT238ki4IZW5One06QJENZvBZcR?=
 =?us-ascii?Q?0SC6qsUeXIpjNgW451+kPr1Uhrysa3jz0BvW/KyneNpWuH8Fserkm7OyWKca?=
 =?us-ascii?Q?d1EkNCCZPkdEm+EIT+vWL5oekbxV6H5MQqwydT8pdDzhl62NA4HTyYNIW3eQ?=
 =?us-ascii?Q?fDE+GV0QdbvMhQ+b6iiuaRRF8+H17S8/9B1QS58nZ/Wnmh4cT7CDutEsIC4J?=
 =?us-ascii?Q?RrJHTESHixtUxOMyKMogkflFKG/pVZfuStjXv62G7Sc/mJS9cqfH5S1G31Px?=
 =?us-ascii?Q?g/b4xuA8+Q3xz7UjlOxlw306w4BTG/+qMCGxzC99VpXtCZG9NKngQMeqnb4M?=
 =?us-ascii?Q?tyB6ts+k7yGMkDJxn1Gip3nSY0eC/CmimXoV6B0K7YqIwRjyFCYZntP8IT+n?=
 =?us-ascii?Q?egcNit/yQC7LlrgaMVzLU7ocdtHQ/qBU9tGMJX4guA463IIWuk50tcy66FnL?=
 =?us-ascii?Q?sEzOIzQETAMBsltumvywr7GewC/mBJnGulYTUB8AxPvxeHh4u1pqvq9XYBVr?=
 =?us-ascii?Q?2zzdaiqZ6Xc7WAaU7C95A8YygpZx7mQWNNU72G2a5STRcf+0Ajt+t80c6xD9?=
 =?us-ascii?Q?d7QTS0jkwpW5PIiQHkz9f+ahcyRwIaiYpFL8VBOYzWWABLZOlTu9vEjk5kFy?=
 =?us-ascii?Q?XESbxCAZTGgcGJLsvsFPVJKBoI2rwooRB+132uQeU/Ztkhrl1fwEPt0RAgNi?=
 =?us-ascii?Q?akIH7G6ETCbjvWyQ5gw8/2+xBLH+ChdJnMCJyHnTOIhklIKG96LkULDTL7lu?=
 =?us-ascii?Q?MiEkmPsLb1tj1fs1kMNT9c0kvAmcwOcB+Xb0zd8V+Z7nvEdBVvOlHCubwGMP?=
 =?us-ascii?Q?d9K0sgmWOPuBm+pUHJPbUQBUovi6u7/aSiey9H1dngGDdlMYRFRsOQcncMV3?=
 =?us-ascii?Q?r03BYuO2mHqUYOAktr65zhCEdrVqJq+Ypyh0M4aAXX5+I6S5OePkSle4VRBJ?=
 =?us-ascii?Q?4789VufCz+TqEPiAcwCPThyzagGCZbO1THO6LcGA1JOrU66TL5hZM0w6qAFW?=
 =?us-ascii?Q?srIvW3fgXlLXNl5nTjJVz+J+yISYRYtuXvq+owitWF2+95y/gCjhC4ur3TcE?=
 =?us-ascii?Q?ZaVhWzurKrBxlCmUTiZx2k6s6Kjqu09GdOwXny9V6xpK696Ex+0r953/O+fe?=
 =?us-ascii?Q?bUvlXb7SjwWyVi7q12Z+TslL9RX6fmH6ZVFGDGVolinhrpxrmLCsTZYjYZpb?=
 =?us-ascii?Q?Ic1aPownqqRSgztYPps/MCGvacsE7b6zAou2MVS6aqGCesO4oRcoQl5XUZDs?=
 =?us-ascii?Q?Hju2IsH8VrDABshO8KHcImgrRF84YBH8D76LEZWI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2ef701-fe01-4a8d-3b7c-08ddde0ad22f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 03:53:41.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQY5TXJM3Ht0Lm7RL8vj8Ja8vfSQqfdgn/7yr4KqFHX8hED7lufzG/XfySGh1ALwjipSilkZH2ScNUFsYh8lRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8016

Use the string choice helper function str_plural() to simplify the code.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d0..b5c829f89544 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -265,7 +265,7 @@ static inline int get_acpihid_device_id(struct device *dev,
 		return -EINVAL;
 	if (fw_bug)
 		dev_err_once(dev, FW_BUG "No ACPI device matched UID, but %d device%s matched HID.\n",
-			     hid_count, hid_count > 1 ? "s" : "");
+			     hid_count,  str_plural(hid_count));
 	if (hid_count > 1)
 		return -EINVAL;
 	if (entry)
-- 
2.34.1

