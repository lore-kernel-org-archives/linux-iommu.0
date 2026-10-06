Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDFE3EC83E
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288926; cv=fail; b=FbVtmdshHeD+l4YY+acqt8FPBr8DdIN+RaGPbsdLNmUOg2n8FqZUxh3IOYPNntxASiBpkXo4HzLebGbP/ZMHjxgp85FtorqQFi4LxdnfS6vkcF5KsHRyaTUameIH+jgL1Wb1GzJLksK9/BBrvTKxeqcAspBfjALW3jTwbJhuKrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288926; c=relaxed/simple;
	bh=f3Y1iToKpBhYkZU+ZEfbWcuXPjcXUiyA1Kw//nM7INM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=O8TvyRoCzAk9qZ3JsEwyI0Flb5kbzutUTebcedJg3hoeJnVZRoJCxHdQW/V5I6E+cNP5NDdMiY/es+fdHBzM08fZPrmZwlTlxu0KWXrokoMnhXnCH7NNp+LxM/kuWbjf+I2R0/sN1muNWsq+XPnJecoanVBYWrerLgspVqrCoYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BuVmGov+; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BuVmGov+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgZw9/Xo++yxM9JK8RwKC20cDeeoq9IR05NzEumwwSHniiGKEunAU6/X79EJmq3MZRLdZXqKcRFzi3uDD3wapSH6FRsUlp87oS+0e9Gpn4oAgxtq7lM8XWvMtOJV1yEu+5PmoGCS2O+0N8bh0upEcNb5xkKzAPp1OTcXYAdnaorvWlvxUDr5E53AX/xspziQSJUuHuBZE52PvVm4Vnahr6rjaLuOyCwZEOTlctkgPYlAQ6LN003OjnObsLrI/WOWqecDixlXqqveuO75cp+YfpqJ2+2EHNg4DZnmLGuhLi23FsnHVkvaPhVoUAp6rD2BZenS8ORbKUr9MxpOVC5ALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byrEB3b+JD1GRQ5jhUSCdzBYReiAQXFbzTQ8b9VTYGY=;
 b=uAkNmSs287EnJs9xc9K4SMi56atTK1TKIYN20Qstryhon4Qovdiq8+MVQjwtIbgov4zZMccMF+ECaEar5E7b8HhpWoQ6EyRF1+Lx5VwcZBKyk2AR+g0wxtRavy8hJYPpPegzB+3+M2Tpm0oHctJqJYzBdCXZqCwWQNMiHiauO+mGflBAeTsvyrqjRNvIuW5zVUe4ajACsIV20vPwic9zY2qdhTQY3O5E5qUu0BVVFxozEizGHEe8FIgDlJccN8tYuTTIw/IUBlTU2DDXLe6BfDQ8PO7YNejHMfx0/+8/Z8vciYkstQlrzbMMeDzs/y1NUvBkzOPTC8enGkjWPhm04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byrEB3b+JD1GRQ5jhUSCdzBYReiAQXFbzTQ8b9VTYGY=;
 b=BuVmGov+6S+zgLpkyeohXX1IYlkqjocWynRDJiRUoTiWQ92WcjXE1IH9ClKrAK87bUyUpED6gTnX99AHgUfxL9ei+bP1Zp2ER63A3Q246XsqWI+I/bqQ9Mp0zffxE23aVVOVtFyNJSrDhSi4fd4d2TWOPjwnDNU6lMz+m0Kw4Dq0mVnHpsku2MOnOZzFv2KZOVdXzwB6jemFTF+oyHQ+1sjQC/dtiej7XyVFykIWiNA+PNzDCpNEWCF35t6Lmm4tsPEALgTGAwjQ3pN3mlfxUNIUXOVO3xv2K1f6DwACfzIyQjPQAm8sMXnte0P9ZrOMfxa3H4tgQwSWYt3Z+0gPDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by FRZPR04MB12432.eurprd04.prod.outlook.com (2603:10a6:d10:1ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:15:22 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 12:15:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 06 Oct 2026 20:19:11 +0800
Subject: [PATCH RFC v5 5/6] iommu/arm-smmu-v3: Group aliasing devices into
 the same IOMMU group
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-smmu-shared-sid-v5-5-169a59c671d3@nxp.com>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
In-Reply-To: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5P287CA0169.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|FRZPR04MB12432:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0bbf16-fc43-4bd1-275b-08df23a37eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	2HqNl6XwFSW4Mh7S3AcBz/UKuYbXIErbMttmmegeXQ3zywCJwVSme1FafG1xAa8JaSZLf1Fhanzv/2j/dmwsEURjWFaUzudmoKztP06P4cetwNi0clH6D/8vo2joF/sKp1xAVFLNdFUBIguXjC0Ky22o1kZlbPUVyDAMfkF6CCNNgphmvr/Y64bSie9lx3GpWi1+mz39yvgwheTJZIokZdRGX8Qhw593zttqTAikieaTmiRM5wgiSb0XB9gJ8LQQtitZ/tllTdL3R+B+ON1cYNxlCELt0D00B7d4TMGcDg9XGW1ZvcqR5pdVrIcY83ZrnjX4FtrkribNg9pJNbsnvlj6hxHvxgdkhIWVA41RC2lR1QW8qSAEHt59SVHXMZnv5HzyPrlPnJ15nhY1aMQ0YuYUmyJhx0zSdhen6W4uIyHxxB9meuVJh40ixTIjY2E9nGwIE3LvzXZzx4BIigAXP27jJMM6z+jU1iro5M4h8se4QSQeyrf26qUGt40pRUCuAVbHZ1YV/4kptKac+/elYpokElDQ3ackx3wUMvbWngBDhr2+o/6431Wy9McJW6FqdJuC+/moVprO/UtlnTKCaovDUhGJWY61i0Wb4ZZYSX4ShZqTU7qlVCXBJ6fgJeUAIgaI6jTfBBStwVEUO5ECeZdR+MAhw56k2HkKvN8Vkr2q5+iYxBq+0qwR7ZWrPgtW/rH2gFoxsaXytOBrjLdwvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk1PSnlOSTZscjUzdUJ3Ynk4UkN3c0pFaFpOeVJaV0hJRWMwMmNxVjk5R0ts?=
 =?utf-8?B?MXRqVUpaZnoycXhSZ0xUUjJxLzN2dUZlNllZUk9EWUJmZnFMY0hoaFU5VmlX?=
 =?utf-8?B?SDdoUjhocTAxSi91azc3bkRzMC9oNHF0dFcvNFFYUERBWEd2bXRlVzhwbDlO?=
 =?utf-8?B?dVcwSnRZZGxsZE52NWl0TUx5ZDlGYlBNV2dQN1duNitWRWdZUStGd1hPMkE4?=
 =?utf-8?B?QW5MTWhBYll4TzVrOGZxM0FnVHZEVmR4YitKUkxIWG1WZUszM1NwTHRUenFG?=
 =?utf-8?B?c0tIUVFMbjNTTk96alRXQ1Uyd1I4ZnJLWXFjdENpMCtFZzVKejl2ajMramUr?=
 =?utf-8?B?R3pqSEtWbzF3MmZhTWtTZ0Q0L1ZqY2k0bEtoa0E1bnQzYXd3dEFObTJEa0dQ?=
 =?utf-8?B?MlJKUWZrcWZoV1A4RVRRNStmRnQ3SVNIajVEYnZIZzgwYnlhTHA4WXZYS3Na?=
 =?utf-8?B?czR2NTNDeVJWam1mWU4xM1V1alZyWGdxYTNWQ0xrYTlqY01tQVdtcTVyOHJP?=
 =?utf-8?B?WGh2NjZ4ZGZNTXQzOHVGQXQ4QzFXYjBJemZoTUl0TVdmMFhjN2dvWUtlM0Z5?=
 =?utf-8?B?bEcwdGpKNFYrRDZSeHBwTkhBZXhEZklmRFYvUUE0SXBXbnlMMVRjVDZpVm1q?=
 =?utf-8?B?WmdPMG1PcXh2a25KNk1peFlzKzBCUmdBN1B1Smd0ZHV0ZGw2bUU1b0Z5UWp6?=
 =?utf-8?B?c0pZOXBSbDh2dTF0a2tYQjVvMWd4eEpoR2FEdGsvMmdGdDJGL1FnQ3BhUUpq?=
 =?utf-8?B?RTM1YmI5RkVYYVNycGh4N3habklYakFNcEpmZ1VFVFVVdktBNXRPc1ViSjk1?=
 =?utf-8?B?ZC8waXVJZDhZUUp3MFpiUUpONklTWmwvZU84TWdmQ2ZmbVNwQktOaDRNdy92?=
 =?utf-8?B?cmFmaDRZUHIxR3FINHRWU3IyenB2RVNqQkM4L3l2b01ma0ZhSDE1RnpXRldD?=
 =?utf-8?B?bjdCbGVRVFArUG9tVTZISThvWGd0RHJ5YVAyMjRrSXZmVUpZa1hzY3ljeGk2?=
 =?utf-8?B?Q1hCRlA0dStoV3oxc0V6TzVidENVNDFpZjV6MHBMK0Z2Yk9xbGM2UFArQmtO?=
 =?utf-8?B?YmJTZzZmRi9XNkxrajFCVFF5V2pDT2hPL1F4MVlsS2FSTWN0OUlpbVZ1SlFX?=
 =?utf-8?B?aEo0RWdhQytKYVplNzc4WDlFcDg1SWxLL2puUDBmaXZITUlabCszazZzZFg2?=
 =?utf-8?B?N3V2SWNaa3lFN0Yrb09zU3RrRTNlaEIrQllOTTA2WmJLQklYQ2JCZ2hHK1B2?=
 =?utf-8?B?TThoZFJrdHR5T2JIVk4yZWYrVzNyR3ZUWnphL2pUd285eU1jUzN4RlR1TnVD?=
 =?utf-8?B?N0ZtTDcrOXl6VG5sZkNrNmtJMEpPQlhRK0tYRXRnLzBObjE1QUFSLzNSTW51?=
 =?utf-8?B?eHp3cGlGYzVEWXFXTDJWbmZGeTJrQTRkRi9DZ0NvQ21tU2IvNlJCY25TQmVG?=
 =?utf-8?B?WG84K2p3Mm5WaTFTVmM3T2xQWkRkbytWNXZ6ZTVhaktBeHFzaDVXaWVjdnZ4?=
 =?utf-8?B?WEk5VVN3eE9kQy9TbFVTMDV4QTNSamlqaUQyUWxSaXBTVWRHVnVJYkNaeFAv?=
 =?utf-8?B?am1ObGwzK1NpTTNhRHE5UG51M3lhaXUxN1BhYlFhUVU3Mm1TRS80dE9SalhN?=
 =?utf-8?B?MjliallqUitPSm9ONG9mdGtJSzJYTTVMTS9zNktDOC8rKyt2Ym96RUM2ZTBV?=
 =?utf-8?B?eHdVRjc2aDBOSmhONS8xNUdsR1BtdGFpSGhDaS83V2swSnlEWGswSzVCbTF4?=
 =?utf-8?B?KzkvRlhWbEtvejFIalNUT3lYZmI1SHhLSVMwSktuY2lGa05HVzlMZThDSjFB?=
 =?utf-8?B?NU5ZUk1Qd056emNLb3h1L2hqNklzN1NiQWZ4V0ZjNDhiK2tDS0RBdXBQUmFY?=
 =?utf-8?B?OWwvUTFuTHY0dHBSeHF3dDZZeHVubXM3ZUU4WTNZQzlOZkJ5ekYyTHQ1a3Y1?=
 =?utf-8?B?T2RmcEErYUIvaS9UY3NuaTZpMEVac0dOcGYwYjdkdWk2L0VmY0IxeUI3MFEz?=
 =?utf-8?B?Z0VHZDdWdmg5SXljT1ptTkxJUDdyNk93NGVPdkxYM2Y3SGhKdnRPYVlMbGFH?=
 =?utf-8?B?T0kzaGxFZEhOVkFSRDBrWjRJYXIwREZ0NjZrckUzLzBncTBTam9jcTQyNmR0?=
 =?utf-8?B?S2VjVkV2UVZJVlRCSXdzRjhMOG1oazFjWHJmeVNYTDFFckVBT2FkRUxwRC9s?=
 =?utf-8?B?U2cwUjA1OFIyeVZnMVh1akU4bkhlOU53SVpGOG1kMUlQSjJCZ3g5SW9WbjhQ?=
 =?utf-8?B?bGprMUxGano1NFo2Qk1CMnArWDBQYmVtaWp2VHdQTjdaaWVBd09SQ2NEMnQr?=
 =?utf-8?B?U0VQWVRxbEt1UUl3SUdzRC9MbWowakFYeGZjblBRUisydit0T0U5aVVPSEN2?=
 =?utf-8?Q?9wmaajSJ9JPe0hFF8m3EnWg7g3Xe5CVx2Yxdy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0bbf16-fc43-4bd1-275b-08df23a37eb7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:15:22.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C32cKbfdXIAX4/wIU1wbkmOQY4joUTzNrquewx+HIkU1wsJA7ZPcU9VNZkREVefAped1T76XvXfQKcQx74ZXW7axqiiVLNSuOE+u8g+hncu1Q0Olu2PSbuovJnhk8QLQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR04MB12432

From: Peng Fan <peng.fan@nxp.com>

Devices sharing a SID must share a single IOMMU domain (and
therefore a single cd_table) because the STE can only point to one
cd_table at a time.

Detect SID aliasing at group-assignment time by looking up the RB
tree for existing owners.  arm_smmu_device_group() is called before
arm_smmu_insert_master(), so any RB tree hit belongs to a
different, already-probed master.

Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 ++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d306e4af90ef0..c4cfe609ae93d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4381,19 +4381,32 @@ static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
 
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

