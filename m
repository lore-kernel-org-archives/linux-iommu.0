Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CE716E894
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964974; cv=fail; b=EhTAEUHcWOchJk/odTjZU1CgI5OuEba995+aEfSWiBeh8/BQb+xHss15VEu7+pqKYIrIMBW6vpIVuuoFbYrB7dlLk+aHO/Ug90s/qyF0hCriaa71+du9zc6pZs7vblXl/xvYVKQZw1/g6k+M5ucIgbdgNDIoMl+T+jDX5xoayn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964974; c=relaxed/simple;
	bh=YOm7YM8JVv8/Q7XtoMuFWIHOh7ZytDwpdLaN5qn6vd0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ArsYjlC8zwszjHm4jDcT+kdfJwcZEggACEM62iUYLu50rh2Y6mKHHxuHyNXbLUP2bxZ+Opz/LneiOupm13zaEF9V786ESuNHZasoZpqZDPXLmmuQXxai73pe6b3aKNpgl/htyDrs9hr5OMCrpWpttF0lMT8BaVqTkut/9XmL5GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wbHGE+fJ; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wbHGE+fJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec7M77Tf/F4gpspjpb6VzacDwRwC6wC9pA1FsbDVLUYazhHlX+FC5pMDlycfhngYJlslBKNdUx/9Kwhvvmbhu3XwU9b4SAa6titsdqV2P6ER27TlMCUV685N7XuBeE3TQg/FXItvKvX3lqAW7+xJCKHAiQ3KkkEvnho/p0r4KY428c9V34rzCLZMu93L4KLv/HFCnR/EtBajudjkih+TzMwE1F4Ve1HFhx7/O61TPCbv+Jspy38G6KGEPhHL8ha+u/LsDTfKv0e6J4xFfCkmoRusL/29lK6vUHfdE/reaVgqYgjOq4y8Ic+sq6xf9nuzUPDvtsQyLYYAwAa4BvE52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFCeVaHwOnrjNHRfPcszFZ4VAEjXgnpSQ/ZxK/v0JEk=;
 b=EoYL8knE5NYA1wgh0VHDA31ag+elG6xG3eIBipAdnOcFbChMfKl0wXHve5upyZ69OVCW5AO8tyIWGwuBe7F90zsmQ7LB6olq6U/jIWMylOlN8bdZAsrTDb4q7JO0RtgQJne1BXKxHmo2CfZhpiJOvffzuP+dZBLHjqFwkrOY+Q0KdLUZzhAJH/dhYO0kSF3pAv0iiJkV0+/YdWbt5owPzMXzkjUkb2OwrSe3j2+I4Wt7CnqpF5CpfY5s9tbRfvCzGlND5g0Rg2uVzdoqhU8w9EYXSX5BH76O6nS1g9lkg27qqzWJjpHHymvAbo+AEvdQm4YmkpZhcCqki9IQWt/nVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFCeVaHwOnrjNHRfPcszFZ4VAEjXgnpSQ/ZxK/v0JEk=;
 b=wbHGE+fJNld/XK9gd9hCFIsFZG20ht7pHJ+UHS3DwgVXYJolFOU+3LcufGsr2XxR8dCJbN1xpBAraqHdOMCdoZPYhXHRHmMlNMsxUq+06yLOlK5E54Gsfm1Kaz9q1w+v4AdD9qdRMvyr7EYJui1c6AUe+7KtWuX7yvZzbPyz+cs=
Received: from BN0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:ea::6)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:16:08 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::26) by BN0PR04CA0061.outlook.office365.com
 (2603:10b6:408:ea::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 10:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Fri, 21 Jun 2024 10:16:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 05:16:05 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	=?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <spaz16@wp.pl>
Subject: [PATCH rc] iommu/amd: Fix GT feature enablement again
Date: Fri, 21 Jun 2024 10:15:33 +0000
Message-ID: <20240621101533.20216-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: 6533dfad-70e4-4645-e48b-08dc91db2acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjR6NllmZndlSG4zYnNBWjFwSk14YWxEeW1QK0lMWlBVUUMwMkoyVllubk5M?=
 =?utf-8?B?QVFNMCtuc0pVT09pRVRTM0JJT0x2cXl0Sm5lTHNiT1BaTXVQRWZtTXBQNGV5?=
 =?utf-8?B?eGo3djBlNjRmOVdadGFPbkZQdW45ZWprY1A0c1BFaTkrUnExTTNnaGJJVGxi?=
 =?utf-8?B?YkRxbjFLY09jaFhHbGZYa2Q4VmxtcjBoOFN6YkxmcUVhTytsRkg5UDc1NEdr?=
 =?utf-8?B?WlFLdE0rYWltTTJsZDZLYVlaa0pXT0NYQlZDczNlbFlqbGQ0ZG1qM1p5VXdn?=
 =?utf-8?B?ZCs0RFl5M0Z5dXlCdG91SDZIbTI3SDhoaDNEdGVhUE83djVlWFBPdG9rWFdv?=
 =?utf-8?B?NzNuNk5NTHIwNlhydnJoenRQaVBrUG5jSHdTYlB3MnNZRlJySmFjQjFJdDRk?=
 =?utf-8?B?bDdIL2RncGlFdWRIRU5LaklUUFF5eDJYZXlGekQwUjdxVlFTRnQzWUZZRlRP?=
 =?utf-8?B?YmxIcFI0bFpqQU9MRGwwMWU3U2k0cUlVdUR2WkJMZHMvYnh5REwvRU12M040?=
 =?utf-8?B?VHM0cEd1cFVsR0tkcit1Lzk3eTBMK2V6TVZCSklNREZiTXRFdzhrU25IT1FN?=
 =?utf-8?B?STgveEN2RkUvTndMS0Q3NUx2akV3OG1ZNFlnV2I3M2dBRFFKL2RkS2VuVlM4?=
 =?utf-8?B?aUdGN05SNS9BenUzdVlEb3g0bDRJUUdaak12cTdlakpOTnRoK0FnQ2l2TjRM?=
 =?utf-8?B?STRKL29Hd0xrenNPU3pxWXFzRGNLSFdzSERIVitER1NvRkdjbjAwV3hpd29w?=
 =?utf-8?B?am1lZFBVQkZMZzl1T01seXczbnNUTFBkOVloV09ITVI5bzRBeTVkVElFYy8x?=
 =?utf-8?B?YWFQVWd6VVl0RkE2NjU3QTVlRjlhSVF2RVYyY3JvSi9DWHE5VmQvMzBtM2pY?=
 =?utf-8?B?MHMzU1lIbVM1T1FEdTFzWVJ2Z0ZyN2JLQWpaWk5lWEtWV1hrWGxHWmI3b1oy?=
 =?utf-8?B?T2tkajNBZ1BJUk9oeURlU0MyenJOOWNzakFkUGhiYVkxaTZpc2Rjd0h1SDlB?=
 =?utf-8?B?OTY0d3hManB1NFlmNXh2cDRyS05ram90MktnQnpxaDZKZXBQQlF1dkd6RGVD?=
 =?utf-8?B?WWI5STZuMjFMK3NHUS9ndW4wc1ZNSExnS3paM2xyNk1hUzFVUnlxVXpKdjdK?=
 =?utf-8?B?cGJSc2NRZS9zUFB1ZUpuNHN6MUpjL1pUWUhtd3NuVXA1MGNOZzdHaEdxVUZv?=
 =?utf-8?B?TC9PaXRuNlpvWGxFMnZDQnN0bVFqRDJMNmVQRDZDV2NwcmtPWUhUUHVhZzhG?=
 =?utf-8?B?cXQ4WU9NcHpmZy84b0xZQi9TbFk3NkVxSGpOdDlqdElyd0V4eHMwVjRYUjFw?=
 =?utf-8?B?RWhuMGV1Ym5ObWZDa2JHUnB1YzBJYThIdHlnNVdnd204bzlDQ0FWcEZqWXFt?=
 =?utf-8?B?T09jQVVuYjl2NE9uYlQycDFmM3dRZVRsMnRKZ0Jmbmtra2tMaGlza0lJUFk2?=
 =?utf-8?B?ckJUK0YxYjRYRFg3KytYUFAzbW1Oc2p4UlRxbFd4U2JVd0dIZ09wd053M1Nh?=
 =?utf-8?B?SG1OMXN0aFJDWGZka1lqR3BpT1V4UDkwM0xPL1V5clZwb3cxL081SFBSdGY2?=
 =?utf-8?B?c1VJRW4vZm1sVi9zcnpQSjVxekZ1S1l6MTVqbFlXK2RmWnZnNWhuSi9FQ3pX?=
 =?utf-8?B?Njl1ZmRHS2RqeWg0dm5ZektrejlhVWFGeGJ0M2MvcitDYWo2eURKenRNMnN3?=
 =?utf-8?B?RE1USTJZRUVhWE9xMEYyaVBENXhoZUJ3WlhiVGh1allxOHlNNnVHVHhIZHFS?=
 =?utf-8?Q?2ZOONhEkexxqTtet+PPgy4XTcCBG+umsqhxQLya?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:16:08.1144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6533dfad-70e4-4645-e48b-08dc91db2acd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346

Current code configures GCR3 even when device is attached to identity
domain. So that we can support SVA with identity domain. This means in
attach device path it updates Guest Translation related bits in DTE.

Commit de111f6b4f6a ("iommu/amd: Enable Guest Translation after reading
IOMMU feature register") missed to enable Control[GT] bit in resume
path. Its causing certain laptop to fail to resume after suspend.

This is because we have inconsistency between between control register
(GT is disabled) and DTE (where we have enabled guest translation related
bits) in resume path. And IOMMU hardware throws ILLEGAL_DEV_TABLE_ENTRY.

Fix it by enabling GT bit in resume path.

Reported-by: Błażej Szczygieł <spaz16@wp.pl>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218975
Fixes: de111f6b4f6a ("iommu/amd: Enable Guest Translation after reading IOMMU feature register")
Tested-by: Błażej Szczygieł <spaz16@wp.pl>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 161248067776..c89d85b54a1a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2743,6 +2743,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_enable_command_buffer(iommu);
 	iommu_enable_event_buffer(iommu);
 	iommu_set_exclusion_range(iommu);
+	iommu_enable_gt(iommu);
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
 	iommu_enable_irtcachedis(iommu);
-- 
2.31.1

