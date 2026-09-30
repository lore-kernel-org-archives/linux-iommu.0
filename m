Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16414C2277
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767258; cv=fail; b=XQRQbDiegT7SaS3Yvx3HHYoVUm5AYMFxS/sgjqkGcTSCvvNn3d5TE3hlH23FJg4TVFO6L/vXk279D/t/p35DqyhCNgKSeSFCwHU4+0g/Shic75OC9WHjWVnyDcv+Wtws/geXJCvp1d8/rukit074Y4qzEpvWtbyhliD2tPhRfVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767258; c=relaxed/simple;
	bh=evFMbqv2yyeNY2/fNMGQDe1w6ALBysjhzSQ7dMNMiuU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NuLCMdHyppyA5DMGera26bGaYmc+Fz6espVhGHl4fCJBqNO94+00jFKu/uphACimvMZC9ipaYz3Cj+l6EjCMTIQbudK9h/qcqW13CDjRzhFy1m4wGEmxC+ePQ0idZjSPxJnstTbxZrTn4R8K4Jt+VMwy7ReOPPCfuEZrO0qLRx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HhjlGt8A; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HhjlGt8A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=citwJuLsnCUhZI1W0uk9X2bdj8DkJKP8Dj1pKcnM8wDM+vCNod6Oq9yxvQEKQB2/NTeyALTnluU3jLjSkQ9ZeX+s1ciR+P5lmehKwcNwDHPMEChugHEI/y+NzNK+FH36FmsY9yy9YTP8j6JqG9LbL4iAIj5TzuxFGFnGGkmx54gDw5nM76xE8UzApgbIDGU5AAUJrI0k5M888cS5jcDNB9FbGSNe9pscmcYpGSqbg47OMDNgzKUFhYf/UVuE3yhkrlP43RjHSxw1eYHQ4iJME2nvrvptlK45aF0mPNPLiZXjzT3O8rj8oiDmz+kp55/1MJYmYDlH052WPqcmdfVXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5znLLj0KgbPdtP6f/8skDWaHTnVI++23cs/oxDMVxGs=;
 b=VmOmV5w6XjYQT6iY6VOPXiV3UQusmb7iIx6ByNO6gO8XAny7kJUhn2IS32nMKJw5PitNWRPWpM4zFHIM6o1O/EUnP/ikA0XZm2M0SqdY0PObp2R8xdc6wfKw+pnC7MXlJcmNY+26x19QbH99SDzmbkJ2A6ygc/9gb+sUyO2NuzJAyUimukIPO7LuwBx1ISSc0x5i9dQJi8pwpUO9XnWhqbPhtq58WTU79nUBfuOOEtWgDITqJswrF9wjcLQASI8PguDCQOTNph/JX5diD14pPeOm4KFH7DW2khAZqnfryM4OOxXuKLw4P83HbLpZ5dLhP7T2D7nXS7vJQsIJPvvCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5znLLj0KgbPdtP6f/8skDWaHTnVI++23cs/oxDMVxGs=;
 b=HhjlGt8A2TPRLrc5n3f2/cmD8kw+84X5nKdSBzR13MtsGRqBSdfi3QBv6BFvPKNeo9MvqBhQMsxGX/tDGfm7WZQwWkDWkfCa8UYhMXIdfIzMeVMmL0HY4idQIJPF8TubOyheEVSyhPzfUKc8ncGUHdE9PMkBnbdLL4IpFKFDWAYrUYqAMpRVCqrBXWyzvDP4b5SrdBdtXseDYRwthShs0JOsRDOCZG7zxj6s6EKkHVP8HZfDN6OyPzimyvNsbaOvE+wn5hgLvwdevJUKIAL1uqbS6/AaZJOBqstTkbfUbYykbLl/Ma2FQVmXYhZocW0I9MAYKvIhMl59s5Pa5dAj8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB7800.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:20:53 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 11:20:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 30 Sep 2026 19:25:02 +0800
Subject: [PATCH RFC v3 2/3] iommu/arm-smmu-v3: Group aliasing devices into
 the same IOMMU group
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-smmu-shared-sid-v3-2-8abe6c1b4c20@nxp.com>
References: <20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com>
In-Reply-To: <20260930-smmu-shared-sid-v3-0-8abe6c1b4c20@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: d41d0339-c7ec-4232-c308-08df1ee4e3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cbVt4Qu7IK9lIpp9mqdOtUMKt9K2Lgt48HQFJRqKzLD/SxMiXmHMLXlnG5pkqnQXz9W0bQk99+9HE1i2qSJBwfa8z9DLi1vNiyKeBpLTRZ6ZfwpPLEPofLL7h/muSbMZKpUPYcM6DM9yxT0xU5b2PcMHCHtjP3WeZF9HtMooDdGwSu1EAI7tH8Kjy2dGPhzqsrcD9gODemgYkqcTKsJwjWxVcn9IKTWiyxfW2zDUGMix3tVD2igiko+FbK8mRnkFjl+UeZC+9Y9ikZuXpRwFSbmAIrbHVtMUqWs0wNj8vyPT0tmF3zLPcZYQPszzo/yrol/5PfjDMEmmAF+qeEe+N8L6Uu+bMbWgrRbBDNRSHpgeLz3d5ANFwMlsAUVIVmmvW71LYoNwmqgAuze30RmNOx8lNV/SlVfJnvIQu3aCZsYa2HHjPquWmZ00SiEfKYdh+ZdWGlct3TZRyt4/tdb7OTuWEBkPl81s7cGnOWAqeM7tCB9eQLgsa3CxcEEkxxipLPsj5GBqfV8F2A1G8C/ggT0lUzOmNdCcvo+iXIeNTt4obkhnxXsXxJneVBshOMm0GZy8+hU3ZUN+qaZpe8cl6j64oiKqmZ6+D1UvMAKETlDrqqJ3Ib8yDIufThnWsm4kx9HjRCf2LixH2hoEVHA5a6L7Teha4/eyA6Agms2TDWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3B6cTFKMTZEbGp0Y1VGcWxkQ0FZbUR5UElrczQ3bGlBVXBNNjNpeDNERnZ1?=
 =?utf-8?B?cDR2M1MyVXJRalpjWDloYXNTZUViVGE5TkxOVUx1Z0Q5K3RFU21qVkRTR0ww?=
 =?utf-8?B?N1FONU9VMk9tQ1JFbWx0cnFnY3JocU5mS3NaT0VWdythaVVLQkNjdmZad05x?=
 =?utf-8?B?MTFRSUJYSGNPcHBwUngya3ZjbTQ3TDMvK0hYdWtHSGNzc1cyRXB3Um9OdCtt?=
 =?utf-8?B?M3ZaQ2VZRGxPSHkzWUExbnJMZERqMzBFZytRNjVlS2JjSjgxak11RFZEdC9H?=
 =?utf-8?B?ZHFwNDFKNmF2a3BmcU5zNmk3dGJNMnIwaHEvb0pScDJITUtYUHJjSkhIWkEz?=
 =?utf-8?B?YU5LMDlDTVA1a2paODJqSUdEZjdrKzkrdHdOWjNlRExHdWlacy9MYU9kaVor?=
 =?utf-8?B?TW5sQ2I2UWxCeXFaa2FDNmgxWGtiL3pUUFFCakxlY0hBUDRhUnBrb2xReFp4?=
 =?utf-8?B?elZ4ckNkVHFJTEcwRWcvVXFpa3lRT01SOTNFYU1NRGVoRUVpZ0pIVk9lem9y?=
 =?utf-8?B?K2xid3MzSEh4Vit2cmxUS3p1OHl5TXczVTd4SE8wTjRGZWVXaUNSejJmZ1ph?=
 =?utf-8?B?KzF5NFRGQ2hIam1QKzZ4UnN6c1ZRNWV0a1d2c1VTeVMydTd5akFPYUIwckJD?=
 =?utf-8?B?KzYwWFRpUGs2VU9xdUMydkgrY29NYWZ4ZmJCQ1lWY2swTERzenRDZVMydXAw?=
 =?utf-8?B?Q29tQTRGaTEvWnN2K0dXNUQ0T2IzSk1sVmluT0pnemxmLzZjMDQ3SnlTMHoy?=
 =?utf-8?B?SVBtcTJBd2ZmVldTTC93TWQ4SktadlhWMlNmQTVpUGg5d0YyclJvYXZtaGxE?=
 =?utf-8?B?bmhra2ZOZzR1UTBlaU52ZElKY2ZzcUw5eXc1Y3NpQTQ4TDFBY21Sb2VMT3p2?=
 =?utf-8?B?OGZKYUdFdTd0S2tRTU5ESW91M1dZY3JaQVlmQ2NETHA0U25RWWNPdTRtV25L?=
 =?utf-8?B?bHFLcWlIL2oxZlhzQnhJVUNtSk56WGIwZEJPaldBQ2N0cE5BUENxSjUzN0FI?=
 =?utf-8?B?eFBJZUEzZUl4aG5mcC9IcUdDdm5zUzNEa1R3Y1d3b1RJZ3c2WjBIb21teVJv?=
 =?utf-8?B?M2hDcFlmekxWbU92MjQ3R2R1UTgvOGprYjNXL2cwNXhsU3E5bDZaZC9RT3Rp?=
 =?utf-8?B?SWdjaVE4MkRMN1J2VnJKOFpheWZnOUxDcDdXZXhtWkQwVTlFTklsaUNIL0Vn?=
 =?utf-8?B?bno2Yk1xZndxQXdyRjlnRkU3NkJ2SnhXZGNBRHRzeVUrL1MrMVNsNHVaQXdu?=
 =?utf-8?B?N0xBSHhMY0I4eGMxelJGSDFKMTluV1NEV05xT1l0MkVveUs4YXpReEpoOXpS?=
 =?utf-8?B?c2FtbUtmQ3Z2VXc1dU13SEN6dlAxY1dvT3YxODQ3VENTMXorcWQ4cmtQcnlJ?=
 =?utf-8?B?LzhpOS9QR1pCR3F1Ykx6bXVqdmFEYmRnb0YydEhEbHZ0d1BxYXVpSVRzeTAw?=
 =?utf-8?B?L1RQam41YjVqSGJJTno1bnd5T3ZCL2p6SFV0TXpvK0FVclQzTVhTNUsrSmwx?=
 =?utf-8?B?ajQ0YXBXSlg4TEtuWVBTS0xYNDZrNUJOK215TVd5dFc1NDZFV25HV0MzUEVw?=
 =?utf-8?B?YkdhczBPaFJNUjZUTW1meFVlLzdhZjl5UWoxWkNpeEpLQzJST2hlYzlsR3hD?=
 =?utf-8?B?ZTFvTkQ1Vk1HejdodDBiN014cGE5aytEcVQ3UERrQjNId2dneCtDeHI3Q3NJ?=
 =?utf-8?B?SXVDWjlVYkxOVC9sZEg0aDFucWNDcDFBT0dVWi9yeVliOHZyby9DN20xcGJP?=
 =?utf-8?B?YmttWEN1U0ZTamdwTXJ4Sk9pOWs3T3UvcjR3SDFldnRocDZWTk1qdnBGMHg1?=
 =?utf-8?B?NU1wS2g4WCtlejlnbHZCOEpId2hvaGxKSVk4UWdDaEtVYXV6a0YyNjViR1BN?=
 =?utf-8?B?ZGU1Qkw1MkFEZGJaNzIxREI0dVMrdXNoSGxMR1BjeWdoMzJoOWxiZUZITVhx?=
 =?utf-8?B?aXh4MkJUd0RLeGlYN3ZRbmpKWTVmNzVXa1VTVHJVdGUwNS9KSGNwUFFsaHF1?=
 =?utf-8?B?WFdENkFNNW9la2JQaE05S1h5bWdyTGU0VWVUVTdrU2NrV2E3NUFBblRxRGJi?=
 =?utf-8?B?ekY4WnFzZ2xGVnB3Sk1LdmpBdzV4aVBrRFN2UWRVaW9nRnlJbllmMG5MY00w?=
 =?utf-8?B?elhBOXg5VUg5dDFGV0tsZ3NsemtQUTk1YmVVNXpFMUc2ZEdSTmRBZ1VSeVFJ?=
 =?utf-8?B?R1RmbWNXcFV1MW91YzFkL2ovT0NjTTllL1Q3c1dZcUg2M0phc1R1OTNOZU1t?=
 =?utf-8?B?MnNUUGxjU0FsdzZma3R0T3owckZIRG1LdFZiaEs5WWNuYUtmcUtXVUFsYW1U?=
 =?utf-8?B?cXR4ZVhOOWQ0NzJlZ3AzUXpPNnpQdHFxRjV0NDhBbWovcUVPVmdmMndpUnBN?=
 =?utf-8?Q?3U4IMW6sLbqJ7BQA8e9/Z1jS+zchYQXU6yQIS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41d0339-c7ec-4232-c308-08df1ee4e3e6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:20:53.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylPtltL2snbHS8uB8B2BqnUsYlb8/TCBWxhXodN5tcSRTv/E8LL/5Eec9duvasuqyigIJsOKsQ0/E+FgCTxbtpB0aVdWSlPkphznzi29/lx6L1pAh0b4oCg8AZ3E3uyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7800

From: Peng Fan <peng.fan@nxp.com>

Devices sharing a SID must share a single IOMMU domain (and
therefore a single cd_table) because the STE can only point to one
cd_table at a time.

Detect SID aliasing at group-assignment time by looking up the RB
tree for existing owners.  arm_smmu_device_group() is called before
arm_smmu_insert_master(), so any RB tree hit belongs to a
different, already-probed master.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 ++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 940f34465c0fa..2e13cf0cb8882 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4363,19 +4363,32 @@ static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
 
 static struct iommu_group *arm_smmu_device_group(struct device *dev)
 {
-	struct iommu_group *group;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_group *group = NULL;
+	int i;
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *stream;
+
+		stream = arm_smmu_find_stream(smmu, fwspec->ids[i]);
+		if (!stream)
+			continue;
+
+		group = iommu_group_get(stream->master->dev);
+		break;
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	if (group)
+		return group;
 
-	/*
-	 * We don't support devices sharing stream IDs other than PCI RID
-	 * aliases, since the necessary ID-to-device lookup becomes rather
-	 * impractical given a potential sparse 32-bit stream ID space.
-	 */
 	if (dev_is_pci(dev))
-		group = pci_device_group(dev);
-	else
-		group = generic_device_group(dev);
+		return pci_device_group(dev);
 
-	return group;
+	return generic_device_group(dev);
 }
 
 static int arm_smmu_of_xlate(struct device *dev,

-- 
2.34.1

