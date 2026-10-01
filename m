Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE7C502771
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858758; cv=fail; b=Jx9IUQqKFmNrAn3C7DVF89mrICTp/BB40UWFzhd8PotEsPBHFq/Z0oJhlktMd96VPO6t9VU7rPytMGqdVOTXf9+UB82/5vS9EfKm+YfyKO2PNsDMa77wVFUPJcrp8hFhYStXmwyJundqNWb1eqDOFEHddvJTL5QMvfJgiQZ7UR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858758; c=relaxed/simple;
	bh=/rSIgnCySZsDt4tAgGsujz4vjotf6OxQKmDOlPvPhJ8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A51pY4vifoM6OB9YpgRglVf/lEFCYAxD0hM+wqDcAhNqYwQ4COkXs4keHpVLfS5WTvf0z8EQ+EFL+O60bQM0JEUn2a0wEPtyeeFXDPAG7PklefPYvfcbdhMevKPnKjs+mRkMK7wD35aUdpeWUjRP+nVDRw9bW0/gzXTm5UrcMkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uj9WmI73; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uj9WmI73"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpvJoGAgNa7rq/yI3L6XncXEtF46JWxP6VkHsNsLCr30QCn7joTdR5TObYyvHUVxhqM4iEzCXLMdFvXOGLK4G+0Au0NUcnRkb7tSDaL0Y/RWKKWzrSf+NPdakmbPPHFPE0B7J/CjjRvY1wE/2MzVK3UeRgXc80Snac76E1xa0Dw7FZVZAgheHYhtAOpWv4VvZwBRamy+mcCby8YBdRlW6wSCfR7r6we6aT+/SNkWLFiCwHB6oJczXWgwqfjqaefbVALFywCeoDxIZrD2zuFLecqkH/G/D98QfXLLi1hmoHwgcfk5ey1g7QTg1SyDm67URgldZk5qWUDqGlHlolFkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtYAVUQPvgfbh85aFpMQ+3FCcnbcZQPh3AYLTCNKd8k=;
 b=pd5vFCM+3asGPsz+gFQY8X0HN+PPAvWL5eKAni0TrPmNDrhVUP0j7zf4glqnIHudsNPvI7XN+MXBzJoLJ8yWfR7ZpWfg00jAmziYVJZQ9SNe6XSj7UDeuyFF3tKSZAzmPA/DN7ObN+1lKhkhYT0NKvjzYs9VsnoeM+vU1svur+Yun3OsJfFnWDPPyPN5RnP4fg3AwH0gxI72nxB0lTSzwkZIJNtX85hVbcxNglX6yyyVOKfGdjF1hV8gg3mOGN67Jt10x8TV1UX+kX8EPDa8gVyvyAUbE4ecpZ8NbtPEG9muzlhfZF99YrErTid3oEmhsDDUoTInwDxmnuL5b8Dq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtYAVUQPvgfbh85aFpMQ+3FCcnbcZQPh3AYLTCNKd8k=;
 b=uj9WmI73vBXRYUMC1KPtmccWbNeSCuRLkJ84JpqDVy3zCGp32tV7S6qalE5DHs0krl4G5xa72CAZv0CNf4kFb9Nzr0GXnOdVASJAyQuk/7ngKAdMPO20+IGT07wF/5Ku4Dl8BDrwmTKLGkQk2wJzaO4rtHFcDMBV5qMtb2TqzP+t22x0Q389fy7aM2YL8FTqnchng3+dvCVXAmyq+nS5jspn5LoHQCf/gum7F2+6dpp9dBmzg8yQd5STB2WVU6H5V5375xK+8xzHV47L7NjWKL7L6SEf6YY4W8yhi6Q24WWGNEOuunOP0s7wli6CNmPzhyAaKOKGWJjGPMLp+i6x7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AMBPR04MB11839.eurprd04.prod.outlook.com (2603:10a6:20b:6ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 12:45:53 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 12:45:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 01 Oct 2026 20:50:00 +0800
Subject: [PATCH RFC v4 3/4] iommu/arm-smmu-v3: Group aliasing devices into
 the same IOMMU group
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-smmu-shared-sid-ver3-v4-3-06b34fb2e691@nxp.com>
References: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
In-Reply-To: <20261001-smmu-shared-sid-ver3-v4-0-06b34fb2e691@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jean-Philippe Brucker <jpb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA0PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AMBPR04MB11839:EE_
X-MS-Office365-Filtering-Correlation-Id: a49bbd77-dbf0-4735-374d-08df1fb9ee35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	qekTmFPJQX/CwkL6+DGQtooyKOq4nMEUACFHqoWE6V8PFg4fYyPw8vk8E0w17YwyyYeShpCf5uZ0wwz5aKlZtb/VISkcazRb6zM0r6Clf0HIwdntIzN4nOYewOmABhoQNi74OBwk+jSb1Sl7RwjOeACcHFtzyfaH99YMduxPkWPRGpjurHuNdvOrLWMApNml8b3aebe+unWYSU55KCYfniN/qc6z6qeOvhZZtDBMeflwqSGKoy8h2bgxdqC0thSij27Y5kXkqXnXRNqrSKyjdFtVmYmju2u8StktlZT5fSFhOrA27jteCcfJ3cSkDiBsDOMefRFBQYbBIfOUzkswAgBpodlsbZxEOJYORmzlQrr+XuFbEzaKEnRUcJoeBYxugZoZis0FMsD4fi9UyhtyOox0WqDxfkcOHUC3F89gHAnEhxxKgFIHKirK8OPPaBmz92qGoQDbtJ/wb0X38b2BZ/NnSIUR532E60wV9m1c1gJ7pmepVkO/cdOJKL1yY03ucD5AJf4dmf/MjuS64zHflcW053x24lkv1zl01gB+qwNWCHL7tV+ZiQaNPaUHtHHjhb1MEqobnJh5mNo4m+6PrGOQR/0YgvJn0aTFrOBjD2+W47to8LvKgUsNCEJ+dtLbz2coglbsJ0L1IDTjUPOqx5YXpLv1xIkHr2pPOmXV0ow=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGZOSjV3S1poTUo0R0FUT3ZYYkdXNkYvY040dGNld3BJL1lKQmhXaFFyOXV2?=
 =?utf-8?B?d3Myd2U0YUVCSzhvZlNRTGFXRm5xVU9FbENPamhVY0NVbHVvdlU4SkhubHps?=
 =?utf-8?B?ZGVNY2J2R04zT3Y2K1NLSnZEUG1HbGladHhDRm5hdDJkUmVjRzJpSEdPdnlx?=
 =?utf-8?B?UGplakFYODN6cmhuMFRrVDA0ZkRKdEZLbTlVTzJhUFRtbkgxa2ZTMElxcXZE?=
 =?utf-8?B?MCtJWG5CTnFNaVhRUGJiM2lXSzlmdUU2RHNIMllCcjRrOWVvaHZrRHZEempp?=
 =?utf-8?B?TDdpQVM4REc0RUYwOFBXYWF0aFRZeHppWUFwMGVUQ2Uvb1RUSk1wb1dXZmpw?=
 =?utf-8?B?MlBDZW9BRG9PTDkrLzM1U2l2c2Q1M3JhOFhyUDJrUGI4b2JOeGxzUVM1NXVO?=
 =?utf-8?B?THNVcm1PT0dLWFl6STNWTVhhK25TaHBmdTVUbDhReDRucEpFSHhjZHlCQkZq?=
 =?utf-8?B?c29HaEJ4M2dNbUJZUG11THFDajJkeFVaTjZRa2I3Y0NwM1UrOE5yeVZXZ3ZG?=
 =?utf-8?B?MG9VeFd3d3lQOXZRbENBdnhPYUJqeU5aSk1vcCsrKzk1R0J4NWNiRlZpWFFL?=
 =?utf-8?B?RW9KdVp3cUZaVUthb1JNT2NFSTllNVpNNktmRkJlNVJ5a0dVV0JIRE9wM01E?=
 =?utf-8?B?UTA0ZWs3VWZOeGhXTCtWRHhHa0pUYndJbFM2Z2JsUWovZDVBeTlrYnFiYktm?=
 =?utf-8?B?bytRcWVxQTN5TmY0ZjV0VmZNcitZZ2RnQmRybCtPa3NUYTRaYjhLY2pRcnFs?=
 =?utf-8?B?TDFZRlRadTlwV0dmMkJyM2U4YmVDVU9YTzd4TVdjUy8vVmR1dXlldEsrMzFB?=
 =?utf-8?B?c3hpOExMK3JQcEt6dmhESXNXZWVBazliTmc1ejVKR1JJQWVnM0cyeFlkNE9F?=
 =?utf-8?B?S0laMEN5VlNMbWY3NnpIdkxieUYrOFR6ZEYwK25EZFpZN0tmQXF2SVB4UjlV?=
 =?utf-8?B?Nm4rSTRrY01JMEJhaDZ4UnMrWEU2dEZrTVV0akRDRkRNdUNCOHQ0SmhGcXNW?=
 =?utf-8?B?MnRTWGR5RVJMbWZQeTdjTExhKy83Vi9FTTgrWHFHSWRQUURIL2hEaU9WY0kx?=
 =?utf-8?B?MUQ1aTVMbmdjYzhkNGdQWlcvZzV4R2VsdmNLQmtuWUxnY1phL1NNRWc2NHc4?=
 =?utf-8?B?bmpPRU04RklieFNpd1hNQnJZM2Z3ZThtN0lLc1NoVFFkT0s2NzJsb1hpenFU?=
 =?utf-8?B?L2dBNCt3QjZiWmpuNFhIMFd6MWhiTVYwenVWd2VQTTNqbWxsOEFzVFp6aWwz?=
 =?utf-8?B?NWpaS0MzdnluQ3NnTEw4blIxRHQ2RXVXcHN6VUVaYTZMU1JZU2thWkhjRCsx?=
 =?utf-8?B?UUJiNGFjWmwrdlNLNENXQ1hsZHNQbXlIZEhrajVnTEdyUGM1eEVOdW15OG0x?=
 =?utf-8?B?dnRzWVl5VGxHNWNjK0c5Y2VUT0IzbnVCd05rdjhyelNoWCtGUFVRSk5XaE5L?=
 =?utf-8?B?cmZsaXNSL1IyVHREVXRYMjFkbEJQUm0vVHExRDI2ak9ZS0Y0dytSN3NNT2Uz?=
 =?utf-8?B?VjlvWkpIK2Vha1hNcW9MNS9OUi9yd2pEaDNxWlVXYU5hdVh0YnlsMHNDNzFE?=
 =?utf-8?B?V29nYjJPREljbTBYS0QyRDNRNHlzb2Q3WHd5clFja3kvajZTSFdBOURhRWJX?=
 =?utf-8?B?cVY0S3RHZ1VJTFAvSjhjWnBvZk83RzEyYUJhU0RWOGdLT2hnaXFILzVwWXFY?=
 =?utf-8?B?SUxWbWp3bUhoM1dTcUFMc21pKy9HOHRRN2NPMEFkT011ZnNCckkxaWpHc2xw?=
 =?utf-8?B?UVpHNm9na0crWjdFV3B5Y2ZIT1hnUWRYT1lMOXB2bkVEbWw4QmFSYXFjOTRp?=
 =?utf-8?B?Y05Lb3Q0M1FyRk1PaVFpdHAraWU0bFJ4dUJYSWx6alZ1WnBzTUdLZ25mUGc0?=
 =?utf-8?B?d0ZJcnNzSEFVR3I0SVlvaFdTRHJBbkNIOGhYMXlleVViYUJrMVpDcWZ1eE9y?=
 =?utf-8?B?M0VqekJ5M1JiRTlWWURGdWJkWWozNGJtSXN6TStjQ2ZaUDNjWEg1ZXdqaHBP?=
 =?utf-8?B?akxPc2NqbkFvV1ZkdG15OXdUNUFMaTFlSlpLOUlhYTk1VWdSSFUrTWs2OUVj?=
 =?utf-8?B?Vm4vdEhNNVhYZFlra0txRzdoeHBoSVlFYTB2UHdid2pVcGgwYm5mUTRYcjdI?=
 =?utf-8?B?TWhBTEdlK0t0RTROQmxNWXlGSlkxRXBEbnBraHZpTEJGZko4NTVHS010U3lt?=
 =?utf-8?B?L0tTckZwbGpTREw1K3dneTlwNWtlQjljbnIrbDFScm8vTFFPT0g3TDBPMC9z?=
 =?utf-8?B?SU5iVDhNcEdKaTRkdEdQd1VvREczbUtoZk5Ua1dTRnU2RTIrL2FDQU5tbFNn?=
 =?utf-8?B?K0FOWkR6ZE5ZWk5tQUF1R0lmazBZMXBpWm5uLzdOSlJBRmVwQjBSMU54SUJD?=
 =?utf-8?Q?CbzCasaWXp+XbHnU+NSZEa2xohyjyZzh0bxPW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49bbd77-dbf0-4735-374d-08df1fb9ee35
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:45:53.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuBczyDmDPYdKUZdTjkl4sfBRqz0HkVPmwW52mQcCy//xYJgSa4IFDk4C7HQQS9I3Y98E8xqAwh67KoIZWyj1+LeuTP3kaoZKFtpfxtJIH078sMRwAtuQDG+qOh+DnyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11839

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
index 9d98d1b2758f7..0f7e90af5823d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4379,19 +4379,32 @@ static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
 
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

