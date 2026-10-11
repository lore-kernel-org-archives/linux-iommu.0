Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B013AEF4E
	for <iommu@lists.linux.dev>; Sun, 11 Oct 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791718052; cv=fail; b=q8OWvgRZqY7/ZW2RNEMWecmGQcCUelEj5AaSp0/DH0KdggjnF0N4pSn5YQAaX8CQsne7DV6J4NqFSydfwyMD7etXZZFU5zrvDfOFvtZXPk2hjFXkrA3d1XdXA0u7dhW312/aEH0nHvLfRTguPKpvbGLUODG82A+2emyF3oIBZLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791718052; c=relaxed/simple;
	bh=uOzVN7TyjaioNHL8GDfaF0uJfIZYuVzZ1ahVIVKojB8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JoHVx9TjjcxNEzZ7kBd08adBDo5NJgYeAOW25ruJ0YGfBamU6jud8mWvsfXiRzDq64NsspKKbxBypxQ90PK1zPcvBt+H97dyHLRO1aNvmMbSDWw1uV9LcGPv749kGQNnJthhcZ1sWJH9kp78EDaUZLJMOdV52u1UYarPwaMo9WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QNp7+ssV; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QNp7+ssV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eT3Upyb0mE8iOQr95WfB9jz1I1XLqVXHhv+ZyMS+uQ5ST2GDY7VZfNbDJb97qY0XNO8KKJzwBUJpVa/D3nUuX1IeqaQM0PbpbHENW827tBx1HPtb3o3Q4WswDuPCvn9/MOr50lJgk0R5RzxloQYnVzimEtZH1NyPs++4uSYQZX3A3T3IwJKIh9jB1qX+ulxvs9kJHUotE2yAf8KMuWjMDD8bkIgdOEef1tuBAQWAEknIx7EFyY7DBpVXqINn+h0VqLeSAtxlTznXMLQFvmOw11BvlHad/jYTU0Yk2XMxsyIesaQi2w8xs245BX18kVqjDT3G6tkWsqE4M4AsHUdybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEIiiZhu75Sy7zuykymK3rG+0trVLEtUiC+H1LDiOjE=;
 b=hsinlHrbk//tLLuHC4Gvdj1XZawiyfyrR6/s3VMHSS39UAZxAkTBjydhAasvhy5QLkiKQkvJIIIxK8OSIHOW1HzTCnyUWgooDnph0q3qurpXRsLMt2LSwNFr2RlZ4leXeyU1lmLvmYxTKFx9G71tMELUii8Hebgtv/T4Hic1Ogbpt/nf6hOQRwDd/q1fyFA7WoxdkSUqA+posBKGlTslSdcuhf4akRbIwNKoghkk9GDhVXIPKYr1xgJPzsjgBHzxtak6te3nPX6E4yZ/3HlnAydlP9F7321BB9zLjUpB8obGUXLRaBeKspnLqN1KFpvp3C3KrHUvdUdMtMHJ+KySqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEIiiZhu75Sy7zuykymK3rG+0trVLEtUiC+H1LDiOjE=;
 b=QNp7+ssVpm5KG2+EaqponpxPM/+haIznzwEQqU6+mb6Se9POWfgpZyn6s3X+e+TDY4aNFB85UvBtkyzAYH4XCPyhbTBQop+kvhCv/B//SyG+FWadvfbLdnoXdh5LRwAdBEuo1xcMN+I+zqMDsZ7sI2sOG/Wn45UG6Wp6PdUx72cuCm8GM+XpOzxI5NWXoiOGm6YbqyPublgloMi+PwJV9r5sXvt6sOu0zlUYNFoGewi/j+SmAxFOuxYTQce+k6+X4znAv0z14SMvei0bcSDaY53uKbD+8zZoV+gYo5r6BaarCSqO3BKS9JRnhOXMYYv1+B6OlJa439vnDFxw17mGsQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI2PR04MB11171.eurprd04.prod.outlook.com (2603:10a6:800:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 11:27:27 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 11:27:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 11 Oct 2026 19:31:29 +0800
Subject: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
In-Reply-To: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
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
X-ClientProxiedBy: MA5PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: 96619755-b87d-4723-8f88-08df278aa124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|11063799006|921020|56012099006|22082099003|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	pTc62K7Nwpb/lqbVQXDSCYTGQEZDI2ecHqVgTpzB2rxTFFy2pld1v+iE2rrS3WDYk78Dsh6TCHpc4TMJEb/y8ZGU7c37ZhO4sV4erabxQ+H69XmHIQaKy63h+hYrw3hjPDtuQaJcFMscPWNnvdmO6+6kespcAcISEoEQQTWL/NgdLc+8btQZwonwXTvbIdUfzN3+rhWGbBVNZrt/OhWvDuSk/JQYMiDsYDr3ce2VGB8NvwCE1nAUBicc6FdGKddzFWGWjnXib9qw8sgfht8gl5pB+lyNU/sbB4srr3ZUWZCd8Da1aWEHONErU25QiZD1Xs+monLVoZ+NLCZCbPZmAVelAaU8epFjMiw74Kfgf/to1IG53F9+s+xE14lRiMBX8BADoZuYapHCAxUOCqxCHCUtkyBN83Ycra+YFm1s5C0Kb4CKwCPjMKvyHUf3tBYGdKB4a5xd8Kb+AQq4oAQF5hz5XzdlqteeJxupFqXN120k4gIAdouW8UAFeh/ERu0HcGxuIWTzD8GSzXNYK/ZK08Ejl1qIm8JLcG0ZBr14CVY/7AZXm9g09RAUyLFWtJchvCCrU7zRSRXL3hBAA4kGMsQ5zfjbOj0jGs1RGUQY5bPYoIQy+pMvHAJeovUXby+e5JiYdbmiPhsdt4ZLGuoBBhkblcO1913ya8BBtqUU+CzykJPcPJp7ViQstQdfDM+qk1F9/OKkx00BFkR73ycCVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(11063799006)(921020)(56012099006)(22082099003)(18002099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWoxS1FGenp3azNOVFJGUGhic0hoUGdwL25sdkZnMFQxa09qa0tyYUFxOUNx?=
 =?utf-8?B?SC96ZVkwSGZPZHlLWHF6a3hwVUR0eUJMeldJTnk4WnJsMHVUcDlQZkVPTWNY?=
 =?utf-8?B?R2lETHR5Zk43R1ZSYUNvM1lBZm5ER1ZySHFpR3B0SkltZHJabjBkbm9YVU5m?=
 =?utf-8?B?MU1nZ1NLRWVQVGhLSGtkNnhLUkZ4NEdvS2VzRzVtckdjRGwrS25YZUpLZ05M?=
 =?utf-8?B?eHI0V1ByZ3UvbUdBMHphZndaTThJS3lZcnlqenBhb29LSjM4bWMzUmxZVDdm?=
 =?utf-8?B?WEJRSnRQSlg5UkhVMjM5bnFkYUUybGNxc2dEUHNsM3ZXcEN6eW04Z0tleWZL?=
 =?utf-8?B?dVhPWFh2a3pjbll6RXhibGZiak9vNDU4NUx5Wjk4U2Y5ZnY2L05yMDJYbjk2?=
 =?utf-8?B?UEZtWStoRTJ4VytDUkhnazFLZXhFRWpNZWFBTWpTNFBiQk5oWmV4K1BnY090?=
 =?utf-8?B?Y2wyQXNpakgwYzMrcHJjZlhwejRFR2o2TElGeFRwUU95YmgyMENPYy82T1lr?=
 =?utf-8?B?aUVWeVdFYXQ0VG0wUjlzRmwzN2lJd2M4MWpza0Q5SHFRajQrU0N6TGhuUU9E?=
 =?utf-8?B?NFBXN0VkZTVpN2h1MTVTZTBBVGpaa0FhZHczOWlUdTBuUVA2czZ6ZUo1cmtn?=
 =?utf-8?B?TXlNLytDdSs5UjMvbXJ4eWFYK2xvYlpJSlV6ZWlDbDlmcXVLbXhNT2Rjc2Vo?=
 =?utf-8?B?azBoZlY0QTNzL24xMzlZNVMwQkJEQUdVUkQxLzJ2ZEp6eUFrTGk5cGQxK2x3?=
 =?utf-8?B?aU10TXZIelhWVkk4QlA4dlBjZUx2aVBoY2NUNlpERnp4emVhUHdxa0pnVXpG?=
 =?utf-8?B?TFloSkFzcGFXSzRFblBiUXVMVmZSdTU2a0hLQ0xEYUU5SkZtK2dSTnRwaTlG?=
 =?utf-8?B?amo4YlhENldUMG9xRFFyazZ5dUdmc3grSFA0a2VlMDkzZWpmczdUR0Y5aEtv?=
 =?utf-8?B?cUpUK3ZtOTVKMVkxTzlkKzd2cnNwVkdjSjdMR1RsSVNBcDh1b1ZXTDd2a1Ni?=
 =?utf-8?B?ampZcC9CV2FkOFBYZDZWRXAxam9IUlM3OHl2VkIzQkpJVGliMk9KZVFWbFJh?=
 =?utf-8?B?M3ZNTW1aQWhPaTJrWDhIdy9Wbm9VM3RVSjQwZWhGZEV1OStpbmYrazY2NGxP?=
 =?utf-8?B?Q0s3WUhzbkpqMU5mOFM2TVkybmIyV2FVWGFlNlZIZFZIWG1zelpZRFR2QWdl?=
 =?utf-8?B?VXgxZDlQbmhwRHpXenh4ZGpHMnYxeUI3eDI3WUx5NVgyVjV3bXR3aG1qTVFE?=
 =?utf-8?B?Y3ZtOEFjU0twVDVxQk01ZkxSK3c4eE1QcHVDR2NNeFEwU2MwcTVSNFMxczNH?=
 =?utf-8?B?QTJRbXhpOU8xWCtxc0poZUVWRlBmUEQrSnpZd1pOblRQeVZESFk4bG9OTllD?=
 =?utf-8?B?cEZDL3VFWEgrZk52dDdiQWtlZzZWTXJnUzhHaC9kSkVTVnp3M2tqVkgyWmJV?=
 =?utf-8?B?ZUxkcGpaZTVyWlhYTThnTXZqQXRTNUgyOVB4ZmhXSDFpRXNmU20veHkwTktK?=
 =?utf-8?B?YXA5UnNIMm1ZWE1LbzZSbG9iRVpkU2pVcm0wOC83MU9CeHdyUGFRTi9hL3Fl?=
 =?utf-8?B?K3lXR21lV0JBWWNETUlDMTUwVW9SYUJmMTY0cVdrME14amZNT1M4UW9CeW01?=
 =?utf-8?B?Szg5MWE3VjFBSEpMbkpZUWU2WnpPa0pwY3Y5T0Z6WjN0bVkwdWRNZ1FVd05y?=
 =?utf-8?B?NnZLUnZWMFA1a3dmSVlhQ0JwVVhzdDdNMjB2MVhVTnRPV2dwR3Y3bER2bHFw?=
 =?utf-8?B?TnFOQk5uanVqcytiMkk2V1ZMUmx4cVpxSWJrRHMrNnhaR0lQTWFaTnY2eWJO?=
 =?utf-8?B?WVhaSEJNRmZBVGZYNGl2ZGwzWkcvRWFrVzRWSTdzMnlBeE1hZlFjQ3ovK3g3?=
 =?utf-8?B?VXNWcEV1S3lsTHo1WUhjbGJyMEtUbkE3OGd1bnpVakRBQWV6RWJnTWxWZTdz?=
 =?utf-8?B?ZjhEb3JiZGhzbFpUK2N3ZXpaVjBHTE5jR1hRYXg4aDNKL3lVL0pOcnhIWXBN?=
 =?utf-8?B?aXh0Vk9NYjEwY1NjQm1HTjlUNGRxQWsxNFBSZVhHYXRSelBsWmc0QmlUaUdH?=
 =?utf-8?B?YjVlNit3QkJ1SEd2akFod01OU3NlYXFzYmVGNy91YmxuZEZucGxhenNGUERo?=
 =?utf-8?B?cFJpNmNTZTJydnZnMFVaa0dZeGJaeXA2YXFxVVpXSHh3NVk2NEJPZG5Za21I?=
 =?utf-8?B?V1ZidHhVNTlFRExLb1I4NHp0ZTdPYXNDeldrbkovaENMK1JnKzVmS2xxdGYx?=
 =?utf-8?B?RnhGbFZpVlVpM2xtUmtLT0JSNlFRS3VFbDJjdWxNOVU1SEZSSFFFb3lnTXVG?=
 =?utf-8?B?MWV3eTIrSy85b1hjeWtKY0dTbGhIWTdLOWdxTStkanZ5YzlWbUpzeVFNSS9Y?=
 =?utf-8?Q?zA1//N4r5T2UYTS0aOoiKnwAmX3MQDSY9qYKJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96619755-b87d-4723-8f88-08df278aa124
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 11:27:27.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2BL/4GDKlkb6faW7vz3ompYFla0jdtNjX5fQhcbl4DUVj2agZwYC28ASx5zCAeFZNDJ0cRP6AY1D+XcNB+mYq96KZubnIJOwi7VOr8dANipaikmdWDPX5lFwyu045VC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

From: Peng Fan <peng.fan@nxp.com>

For shared SIDs, only the first master to attach writes the STE
(tracked by ste_installed under streams_mutex); subsequent masters
skip the write.  On teardown, skip the ABORT STE write while other
masters still share the SID, and reset ste_installed so the next
domain attach cycle re-writes the STE.

Fault events on shared SIDs cannot be attributed to a specific
master, so arm_smmu_find_master() returns NULL when the stream's
shared_masters list is non-empty.

Disable SVA, IOPF/stall, and vSMMU nesting for shared-SID masters
since all three require unambiguous SID-to-device mapping.  Clear
stall_enabled for both the new master and the existing first master
when sharing is detected in arm_smmu_insert_master(), so the STE
is never programmed with the stall bit.  This prevents
unrecoverable bus lockups since CMD_RESUME cannot be issued without
a unique SID-to-device mapping.

Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  3 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 60 +++++++++++++++++-----
 3 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 853276dd54536..cccc42b13d89e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -310,7 +310,7 @@ static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
 	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0] alone, so
 	 * more streams would leave the rest stale and none reads out of bounds.
 	 */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || !list_empty(&master->shared_masters_elm))
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index faeec656da9e7..46d24f8eac830 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -281,6 +281,9 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
 		return -EOPNOTSUPP;
 
+	if (!list_empty(&master->shared_masters_elm))
+		return -EOPNOTSUPP;
+
 	/* Prevent arm_smmu_mm_release from being called while we are attaching */
 	if (!mmget_not_zero(domain->mm))
 		return -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 328d580935b96..d56fe512382dc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3154,11 +3154,38 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	}
 }
 
+static bool arm_smmu_is_shared_sid(struct arm_smmu_master *master)
+{
+	return !list_empty(&master->shared_masters_elm);
+}
+
+static bool arm_smmu_skip_shared_ste(struct arm_smmu_device *smmu,
+				     u32 sid, bool is_abort)
+{
+	struct arm_smmu_stream *stream;
+
+	lockdep_assert_held(&smmu->streams_mutex);
+
+	stream = arm_smmu_find_stream(smmu, sid);
+	if (!stream || list_empty(&stream->shared_masters))
+		return false;
+
+	if (is_abort) {
+		stream->ste_installed = false;
+		return true;
+	}
+	if (stream->ste_installed)
+		return true;
+	stream->ste_installed = true;
+	return false;
+}
+
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target)
 {
-	int i, j;
+	int i;
 	struct arm_smmu_device *smmu = master->smmu;
+	bool is_abort;
 
 	master->cd_table.in_ste =
 		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
@@ -3167,18 +3194,23 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(target->data[1])) ==
 		STRTAB_STE_1_EATS_TRANS;
 
+	is_abort = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
+		   STRTAB_STE_0_CFG_ABORT;
+
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i]->id;
-		struct arm_smmu_ste *step =
-			arm_smmu_get_step_for_sid(smmu, sid);
+		struct arm_smmu_ste *step;
 
-		/* Bridged PCI devices may end up with duplicated IDs */
-		for (j = 0; j < i; j++)
-			if (master->streams[j]->id == sid)
-				break;
-		if (j < i)
-			continue;
+		if (arm_smmu_is_shared_sid(master)) {
+			mutex_lock(&smmu->streams_mutex);
+			if (arm_smmu_skip_shared_ste(smmu, sid, is_abort)) {
+				mutex_unlock(&smmu->streams_mutex);
+				continue;
+			}
+			mutex_unlock(&smmu->streams_mutex);
+		}
 
+		step = arm_smmu_get_step_for_sid(smmu, sid);
 		arm_smmu_write_ste(master, sid, step, target);
 	}
 }
@@ -3326,8 +3358,7 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	if (!master->stall_enabled)
 		return 0;
 
-	/* We're not keeping track of SIDs in fault events */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || arm_smmu_is_shared_sid(master))
 		return -EOPNOTSUPP;
 
 	if (master->iopf_refcount) {
@@ -4360,9 +4391,11 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				break;
 			}
 
-			if (list_empty(&stream->shared_masters))
+			if (list_empty(&stream->shared_masters)) {
 				list_add_tail(&stream->master->shared_masters_elm,
 					      &stream->shared_masters);
+				stream->master->stall_enabled = false;
+			}
 			list_add_tail(&master->shared_masters_elm,
 				      &stream->shared_masters);
 			master->streams[n++] = stream;
@@ -4522,6 +4555,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	if (arm_smmu_is_shared_sid(master))
+		master->stall_enabled = false;
+
 	ret = arm_smmu_master_prepare_ats(master);
 	if (ret)
 		goto err_disable_pasid;

-- 
2.34.1

