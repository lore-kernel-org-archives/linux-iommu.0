Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A518392C42
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571327; cv=fail; b=CJmj2Nc9Us8byYWveMVf78JdII4tN0SvNWE52kxC/eQDO7CS6O70fN8B5eRoTrHRbMTPfd2uo7KZLiaEk4VHorXKXS8fbXFEOPPmDA15Vrvhk5JNs3MnPaHxP6ByjO+b2mvUezrMV/p8mFYlh/BjrzfGU9px3Xo5/RKIXgtTJ0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571327; c=relaxed/simple;
	bh=gFB0vKROOdqv7ECfDScY3E0FSLOfSviNbDsop0kvd0w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IGNMKSDTzBQNhy+kvH4Q734igAI+T1mMT5gwKkEE9bUSsKdgv+zwl91z7ANqMwpCwRZlC5dYjTXTRrv+Hg3R51K+wfhyDLhrJpVgMUOHnG8lgtec+CzAF1zEw2G8pFsvZagMRav8VoH10kRc/hHshHG7jdYMHQvOzA/Tiaa93Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uGMB5tQm; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uGMB5tQm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0wtCBilsTB3X1SFcDQzkwgejvhojtdWfVoj7Uk7AIGizn7NnRMfMpv+d31TGz92qhUZ9m2HDPzmLNjysQdeb/sBpToZq0eUN85wLJCPiuVGGuEUmt+r52JkL00Ve1br5CC0FOtufR+jgXYBDTcQobXjdHqg+aUcvmZRhbAO1tDRtbcRHBMN3ZjkJhb1GSrsjrLVmC0o2iWDgJTbXMIkZKDVD7H+cYAkQU/FrnT0X99EP4Mgzpj2dHzUygC68JFOOFco85BzaX9OrpiAGWT1GdE4LrE9dgXPzgjIJCS9WtVF5Hbau+k+FUkLdB7rPi/sOtPU/YkP4CRfae+/OWGiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcoUu8W8E4EKdFS9q9NwstZkdoHGZGNtawN29LCmo4Q=;
 b=MsOnUyGoIvmZQICzTsLzQsdUNgap7d6RYZJALrqaLJTZ28LT5T9R6CAclurhA0arp0RAEHmwMh0bB/DaTOd1nabyfM0YodB3q0QiFBlTvhvKOPcVe12rmXpxgmy48CA6UND1ExhxtlSw8BMNY5zd7ZZmQZ8kDnSeiejgxyNzk8f7A1/MIih/tZepNKLZ3tUteDWTBMB8d2VTzf6yzjzblPaXVjZ5ZYIAaIGLG0tsfeWV+BGPSa/dUweAlVJefOVQ7jIyfOjbMeODzye/6d7Synq6wrtHAOWqTs+Zgg70/u3BlI3n5UFkDB/XaGPz3216CWeG5YjYtJiIRHh+Xx/qQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcoUu8W8E4EKdFS9q9NwstZkdoHGZGNtawN29LCmo4Q=;
 b=uGMB5tQmG8cZ3NUZI8koJm2dpqVe8751D+A+hcEe+7AZLI4Fj/sLus6CXDzVU+81suNd95AYxabnVucuoZm+FgRw/4aqHvWt0i2oFzJLqfO1TzAQcPiiHvj3+aLoHkNLHzRg9eX8bFxNKXrPWfySc8JT8UsTw20oRx8s2tHlPVQwxMy7JuOGTKRyvB8TMKTPHbiXek2FAh46UcE3WDME4aOXcKybuEdr0UBEZO+9o+MA8xYDo5+AvUyGGWbXpyvzvnsdaFVDL3mJk+mW34lJ9js9fiBOimrqMWQ6U8/8vmntV70hccYlLR91FYCLGcPSUtC65ds+Jom+8aaPca6OTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by MIWPR04MB714835.eurprd04.prod.outlook.com (2603:10a6:290:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 15:08:42 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:08:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 16 Sep 2026 23:12:37 +0800
Subject: [PATCH RFC 4/4] iommu/arm-smmu-v3: Wire up shared-SID STE ordering
 and feature gating
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-smmu-shared-sid-v1-4-517384504aee@nxp.com>
References: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
In-Reply-To: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|MIWPR04MB714835:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e56df59-bbcd-4428-d39a-08df1404653c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|23010399003|22082099003|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	xB8paPq8cNw//MQceCs18S7QheJDzvHzSjI49Q4P8corQ8iNgoxTWEFmpsAL825uGZF2qlubx0i03hv7xEsFwVkWF8bzp0pqNmJTwsxqyjpz0XPo3O/1VFbjjb44XQZ/AlPe8osVbBV1u38kz1xU28Pj/R2xTj0+IwN+p4vEKbQ2NPb72yTC05QLHLxLOxrKO1t+TJ8sd0dixTk0apIwD7AO+Kr0qTG/9TSOeninhVkomNvXNedLT4TtuvO01iXOYqLrAU0skpoaUR6rt7NbI8NVW5ZjkjBQCVLSo6mieZ+8A4WcjFegPdQ5iDwjZ/VtkfOoVv6Z2Dhq1h8wBVQTrYsoYnU6KOZw8RsbYQ2291bwTCVpVdUXAaaAn+77mu5w/4FfyRgh3AizaQHC0mx1M4JY2iLe1rpjSsvobFN21X/BVNRp8iceleRqu7ngtFPggaj2EI2x4yOxY6AxYNCGSn8cmKA+SKo8L2lfs0ONNLHlETATMxkIrVg9G8Hk+TMRD9/ZvEQWbOWBvq67idaVmmHZB+94uNdnDaK5xG4PR1VshdE4ANOJSp+bYGW6I41OSIrBeFB6rj3/TwqxdGXBncigM3VPU6YsjSTCVloIaDCT6oCA85OZBrBeXMnj4XGXdqEI5Pxenps/lws7PI9cDjEhwpe2f3Mb8HWO3nm194Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(23010399003)(22082099003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2FqZ3p0d2NJdUZiZ0Z0WDVsV3IyRUdNcXd0czRmRWIyTEJ0aTNwSmJyVStv?=
 =?utf-8?B?MnYwSFJFUHVhMWY5S0wxTGVnWEdPeEFXUVd3aE1mMU1jak9EVERsRVhEWDdO?=
 =?utf-8?B?dGltV2VONGZxbis1YUlZcjdQczJOWUNyVTVGWm5SUXkrcllLVXhjTVliVVB6?=
 =?utf-8?B?RU91ZXBZTW5wS3EzSXlXRUp3WDBpUTVLMmxwa1ZnanF2ZmQvWkkwRzk5bFdQ?=
 =?utf-8?B?RFk4Ykc5azF1OTBiemtVbVd0WDlzbXpmWkl0Z21tOE1UUGVwZUczOG5RNGky?=
 =?utf-8?B?YTk0MXl1UDRSdDhBMWpNNHYvVU1ONXFJNU1BRWZTVzRzSTg2UElxVHdybUNE?=
 =?utf-8?B?M2g4MFMrd0FxSkN1dVJhSFBxaE92bkQvdlhWc2grQjIyeEloZ2xubER2Y0Fx?=
 =?utf-8?B?M2IycVdhSnM2aGFZZlhjSE16VytybC9CUWdSM3BpMTNCVmpiVzlQNC9TQjhi?=
 =?utf-8?B?bVkzZlZHRnpNM1RoNnVyb0xsaVU5QlRLS082VGticVpYUnpqSmhyZURSeHJB?=
 =?utf-8?B?T0M1T2EyZ1hmV3ZCYTdWTWlCblJzZ1BUWHFIZnJXRFZITFRCaTJvZnlVTWIw?=
 =?utf-8?B?eEhMTE1sTm92MUJzbklsUkQvZTBncGFTZk9YMTRkUHdqNEJLbURIR2I1Mm44?=
 =?utf-8?B?Y0Z3L05NTkgwUGprcnFsVGFjaUVRTmcrdlV0bUF6Q0dTeG5DWVVJOThZcldu?=
 =?utf-8?B?a2pOb0NhTW4xaTVSWVZ3Zjl6a0dzZnRKc2RCTUUyUkFkQ0tnaW1xbkpqTHkv?=
 =?utf-8?B?MVdiV1lDcktHUDRjZEFJczJQTXE2eGM1d3krdkZHak5jNVZkR1FFNTNCSnY2?=
 =?utf-8?B?V0VBUjFqV1E1QWJIZzdmRCtZZUhwNmlyRWhFVEI0ajdTNE9aaG1CbnB3V1pU?=
 =?utf-8?B?cTU0ZnB1ZE1HaGhycXV6Y3dPeHRvQWs4Ti9hay81aVV0TXF6NUZnV2FqQWdO?=
 =?utf-8?B?Ukc4UndRZmVMZGNhY041N1lDa2Yxem9PWGI2eFhtUFp6MGlueVM5TXFySFlV?=
 =?utf-8?B?UnY1VzB1RjRhQmUrcFUrVWxIa3FVcnpLc3lLQ2tOYXkvUEF1WVl1dFZDSW4v?=
 =?utf-8?B?dnNHelhGZkZrWEptQ2R1cEVPdWVGL1gyZVlNOFVzMUpnS1dOQXorSS9HN3Rs?=
 =?utf-8?B?WGhqeTlqVHpRR2x1aEl1aWt1TWNXMXhOYStPVEVnS29BTkh6WE93ZHM2c2Yr?=
 =?utf-8?B?c29ab05uNWhKQ1pPQzdxMkZvaFE2RVBISzFpS3Q0QlVxeGF3UVFWQnNKQmQ3?=
 =?utf-8?B?VTdtRzNVWWZ1Y0ZoZktzN2JNVmZmYkpGK09hcGxmL2RWNjhRVEg4Mmc3aFBM?=
 =?utf-8?B?RFVIY2dpVUw2akFwb1lNQUpTSTNkVURxRmhqN3BlT01NYXRrVThEWWppbzBi?=
 =?utf-8?B?SU5oWTh2eHRUc2NjNlZtVlhHYjlKN1kvVkdyTUxKRHRvaVJ6VHBDT3BJK3pE?=
 =?utf-8?B?U004RU9La01GRm5jcnFucTJOYVg5K3hwb21qczNscGpXZm54ZTVYYk5GZDVQ?=
 =?utf-8?B?MTFqZHh6MThyam9rT0JZVEROVGNuZHQ5UmluK1IwWXIvMDZKMm1lTzdibmRp?=
 =?utf-8?B?KzZYSGFPUWZhdHJQQnZJZzUydFl5ZWpZMFMrKzNsUW1kTHh4Tlg5NHl4djJ0?=
 =?utf-8?B?Z3FZMUVHZmhVWlFSbUwzek5IbzJHSXNzcG1ZQmdtUEFQR0xzSXlrYXBxVHQ2?=
 =?utf-8?B?bVZGc1E2QytqY2pYT2ExcFoyWHRSV0hIN0tYTUtmRkZvcmxTODdOclFURjVH?=
 =?utf-8?B?eERmZEFWMkg2bi81c2I1WldhWVNtaHJBdWtPbWlpdTZtM3d2eFRTeS85MWl6?=
 =?utf-8?B?ZGxKLzVIRU0zbGdCeStCT0FFUUVwS0g0Q0UybmU3cXRIUzFJSUZNdXpEUGJ0?=
 =?utf-8?B?L1RnZ1NENmZ5OU16OU1oUnBiVWExOU12SnZSeHdlVjk2N3dIZnc4UXdzQWt2?=
 =?utf-8?B?cmxJbWpxc010NlBJOW1vd2swNHFWdVh0ZnF1dHRmazE4K1dkT2RMWTRmWmU1?=
 =?utf-8?B?WjlsTkRaUWNsWENDSW1NWEc0dzRFZy8zbUg5ZU5aUnZreDlmZmpwS015RFZl?=
 =?utf-8?B?cHpKUXh5WUxxalRVUk85MlFTVUZwd2FFSVZXWnkxSExiZ0ZWZUZKN3VoUUQ4?=
 =?utf-8?B?T2g3V21ETmJrYUw2Slh0WWhudWsrMFdjdFBiUi84T3JpMldwdHUyWlBIRlNo?=
 =?utf-8?B?dDNxWktSZ2VMd0FDcmdvUzhnUWpJQ0gybjhHOTVBdlRTeGR2UFRrNmRKQ1ds?=
 =?utf-8?B?WkdpUGlHV1ErWlo4SndPajlYUUViYnhleW1lZGNrNGU2T20yMVRWRmZtY005?=
 =?utf-8?B?ZmUvaGR2dTVNSXY3MUFBM1lBYkV1ZUZObkxPeC9mdVNyQ1JCZEZ6VXZuaVZz?=
 =?utf-8?Q?9W5vR1S7dAOk7oTmR2mgAe87t7KqsYTs13XDm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e56df59-bbcd-4428-d39a-08df1404653c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:08:42.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHFaRhN4yEEn7+lX7Ui3Yl83YLaXYAB6WQXf/RuVLFcrt+Xj/LI1d+Jy3jMBG24II41F/67djfzX7f0yDPGStbWtcs8+R4KkAn6xnTlo5wul/K0ECt8W3nvNL6TJdOs3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB714835

From: Peng Fan <peng.fan@nxp.com>

For shared SIDs, only the first master to attach writes the STE
(tracked by ste_installed under streams_mutex); subsequent masters
skip the write. On teardown, only the last master writes the ABORT
STE (ref_count == 1). This is handled by arm_smmu_skip_shared_ste().

Fault events on shared SIDs cannot be attributed to a specific master,
so arm_smmu_find_master() returns NULL when ref_count > 1.

Disable SVA, IOPF/stall, and vSMMU nesting for shared-SID masters
since all three require unambiguous SID-to-device mapping.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  7 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 59 ++++++++++++++++++++--
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ab1078a97d801..258ca42917f07 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -308,8 +308,10 @@ static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
 	/*
 	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0] alone, so
 	 * more streams would leave the rest stale and none reads out of bounds.
+	 * Shared SIDs are also unsupported for vSMMU since the STE is shared
+	 * between multiple masters.
 	 */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || master->shared_sid)
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 0a429c64fbf3e..43f8cc81bfdd1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -271,6 +271,13 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
 		return -EOPNOTSUPP;
 
+	/*
+	 * SVA requires stall-based fault handling which cannot be supported
+	 * when multiple devices share a SID (fault routing is ambiguous).
+	 */
+	if (master->shared_sid)
+		return -EOPNOTSUPP;
+
 	/* Prevent arm_smmu_mm_release from being called while we are attaching */
 	if (!mmget_not_zero(domain->mm))
 		return -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bb3ee25d10d6e..13968191b1452 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2034,6 +2034,13 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	stream = xa_load(&smmu->streams, sid);
 	if (!stream)
 		return NULL;
+	/*
+	 * For shared SIDs (ref_count > 1) we cannot determine which master
+	 * triggered the fault, so return NULL to let the caller handle it
+	 * as an unresolvable event.
+	 */
+	if (stream->ref_count > 1)
+		return NULL;
 	return stream->master;
 }
 
@@ -2944,11 +2951,43 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	}
 }
 
+/*
+ * For shared SIDs, check whether this master should skip the STE write.
+ *
+ * Setup path: only the first master writes the STE; subsequent masters
+ * skip because ste_installed is already true.
+ *
+ * Teardown path (ABORT): skip while other masters still share the SID
+ * (ref_count > 1).  Only the last remaining master writes the ABORT STE.
+ *
+ * Returns true if the STE write should be skipped for this SID.
+ */
+static bool arm_smmu_skip_shared_ste(struct arm_smmu_device *smmu,
+				     u32 sid, bool is_abort)
+{
+	struct arm_smmu_stream *stream;
+	bool skip = false;
+
+	mutex_lock(&smmu->streams_mutex);
+	stream = xa_load(&smmu->streams, sid);
+	if (stream) {
+		if (is_abort)
+			skip = stream->ref_count > 1;
+		else if (stream->ste_installed)
+			skip = true;
+		else
+			stream->ste_installed = true;
+	}
+	mutex_unlock(&smmu->streams_mutex);
+	return skip;
+}
+
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target)
 {
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
+	bool is_abort;
 
 	master->cd_table.in_ste =
 		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
@@ -2957,10 +2996,12 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(target->data[1])) ==
 		STRTAB_STE_1_EATS_TRANS;
 
+	is_abort = (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
+		    STRTAB_STE_0_CFG_ABORT);
+
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i].id;
-		struct arm_smmu_ste *step =
-			arm_smmu_get_step_for_sid(smmu, sid);
+		struct arm_smmu_ste *step;
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
@@ -2969,6 +3010,11 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		if (j < i)
 			continue;
 
+		if (master->shared_sid &&
+		    arm_smmu_skip_shared_ste(smmu, sid, is_abort))
+			continue;
+
+		step = arm_smmu_get_step_for_sid(smmu, sid);
 		arm_smmu_write_ste(master, sid, step, target);
 	}
 }
@@ -3116,8 +3162,13 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	if (!master->stall_enabled)
 		return 0;
 
-	/* We're not keeping track of SIDs in fault events */
-	if (master->num_streams != 1)
+	/*
+	 * We're not keeping track of SIDs in fault events, and stall/PRI
+	 * cannot be supported when multiple devices share a SID because page
+	 * fault responses are routed by RID/SID and we cannot distinguish
+	 * which device triggered the fault.
+	 */
+	if (master->num_streams != 1 || master->shared_sid)
 		return -EOPNOTSUPP;
 
 	if (master->iopf_refcount) {

-- 
2.34.1

