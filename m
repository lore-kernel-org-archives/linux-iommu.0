Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3922CBE6
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768542835; cv=fail; b=l7+rDFs8IPA5JB1+SYUCUO5ZfwiHKtghGGhWTnWjX4g4lw3Rt6YE0f2QIpqt8AT2ANP89eSppTFTm2/3aUtCdLo00VgQwZQwoOf70Ifgw9LiRvo63lSzIYZLuooxADmJ01oaR33MnYy7iyiUE72Q0yWEs1kPGO37DsqwqchrFEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768542835; c=relaxed/simple;
	bh=wNx++n9hcMjcXXeZH/UlmMT1UVTptXuKqGTlikNLQRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3rXlzej94nBkNek1yR6HmiNda+IoNTNr5g7GLs1R/GJrXv1I6tcNAJY/H16z7NOqx3LXQonlddvoDqmiZeea9KYXX6LYdhd/L7zvaD96QmnUMOrTxZQGdiTiOeElp2vU+sIEYEw9rrgkbSeGbY3NIsL0RKrDCISfUL2IE3f+n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IodWW9ml; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IodWW9ml"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIJ8Gpv5c4KuEX/2QWwdM4sKDyyUngEbkljCDKhhFPBsc8B5rN178SLdysIgQZ1WtZi9TJ4zKYivigul7b49R7EJ/1riqAZ+RVK2Z/wfOq//S6IuzsLY8QIWqhBg1O/MHJXW7c1NiREAEV/SO2ED+h/gEno3XmwqVdHyHN6fO18J3+N5KUMjyAPBWhvpnxAkP6GI5S+NfvPFGqPXZLVz3u8OCtDOCBvuzPMxtYhL9dTo4Ci8ctushTfbE9W2LOeHLEnlLhU3Be51H5uze99bW7rBFXRp6O/bnduKlQNv4ejqBCwKyy/R4/Oy76nPeuLaDWIbdacnLrTODRaBv6FcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDB1FtkJFBr5r2SMxqUvUsC6se27r8bGU0U8XvjLdVQ=;
 b=xGuo8mxzN01T272dc7Q4umZc7Haa5bIpJOf2CZzwe9rc7kqwTpLsnzUDGMm5+kluf3BACo6ZwfmGpZnBk+wEJHP9r+mA8hNGsvMS0sMGZOczuGZ6JujTd8qSmzlsPEkbvWiUVSDCxss7HTOFY6Rt67l5mGs5knnA0iO/Qr8LD7js6wH9qzLwIYrqsiRI4Mkpna4FdFbTxm5VgXH241Sxw5wIPxTF4z1Pc4C59Jv0AWVinQx1YDYgd+mOF7z21rDs+fVM2DK09giro+6oeSumqoy5XlnZ/kzEVaUVkL9sk4zP2YBfR8VEmejq9008UoWpwYnXVEC1e5HXBTmNG0lvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDB1FtkJFBr5r2SMxqUvUsC6se27r8bGU0U8XvjLdVQ=;
 b=IodWW9mlYLMAeZj7mIcZ8c19nVMfNX3gc9dvE6a5GM7b0pz/zvyNViQuRx3jy1gnr2qiBWULYQ+U5ksIsEtw1NVDK7rX1vqHULY+NOnfGI3OOubfMGL/YwsXS7eRfVuUkCVhAmHZNbaaSZ51NyXvzpCP6Bq1tfSMRXFyA4GPTTQ=
Received: from BYAPR02CA0045.namprd02.prod.outlook.com (2603:10b6:a03:54::22)
 by MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 05:53:50 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::7f) by BYAPR02CA0045.outlook.office365.com
 (2603:10b6:a03:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 05:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 05:53:49 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 23:53:46 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Rakuram Eswaran" <rakuram.e96@gmail.com>, kernel test robot <lkp@intel.com>,
	"Dan Carpenter" <dan.carpenter@linaro.org>
Subject: [PATCH] iommu/amd: Fix error path in amd_iommu_probe_device()
Date: Fri, 16 Jan 2026 05:53:32 +0000
Message-ID: <20260116055332.342204-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ca2e9a-1237-4874-7589-08de54c39f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmJ0NzZLRTYyOXdBTEdtSFVNaGt2b245RGpBaUgxaEJYVEJPLzJHY2dac09t?=
 =?utf-8?B?UUNhNVFuVUJpSXFpMzlPb0JVZ0tpVjE5dTZuREQvb1gwWnBuZDk0aG9OalBV?=
 =?utf-8?B?RmY0cTUrL1JWL3lvcTIyckU0alFHZzVhM2Y2NWxFYzNlSjdNTHJmUkdvUytJ?=
 =?utf-8?B?THl0Zzc3NHhDNEUvMVFCNUR6Z1FydlRZUTRrYTZCSWNFWTg5Y29KMDl6LzFJ?=
 =?utf-8?B?TTVpcW1odW5GK2VoWDBRUUhpTHlyNUw5SDhacnEzZk0xZ0lBTW5KRjdmdGV5?=
 =?utf-8?B?dHBKcU5Id2tCU1h0aXFKbmlMK2lhS00rWE9mSDBheDhvWXlaY0xacU1NNGhN?=
 =?utf-8?B?bEJIQ0dXUHN4ZXJGUitpSlc0L2pNWENLaTZjRzQyYXNNVEpFVk5ZN3hleFRh?=
 =?utf-8?B?cjJjWkI3TlBRaEpyekdtQ1dCb1IvbjJBSGdMZS9YaXBocThpd2FYSTVQa1Rv?=
 =?utf-8?B?WU5UNllMOXBSeVRFVit3aWVmRVNiVFduR3B1UVA1SVRYbGxMelg2cERxM0hV?=
 =?utf-8?B?ajJuZmwxb1huUkw4bDU4c3ZLa0NnTGpWNHpwQTZNblF1OGw1RldpenRNdkJY?=
 =?utf-8?B?Z0haSVl2Z0c3eFhiM0FPc0dYWngweXBNNGk4M1MzVkk0UHJSdThQS3ZyeVNn?=
 =?utf-8?B?blRRU3drSW90Y2hWeXUzZTdJV3lwbHcwR1FDRnh4U0J5L0tUS0E2SzRZWVZq?=
 =?utf-8?B?SjhMU2dHbDcxY3A3N1dHZWY3bUpHcnRkVXFkd1ViNEh1cFNzdTBEa1R2Nzhv?=
 =?utf-8?B?bVRxeDJ2MVBFa0VIOHBQZ25kR3ZXU3RzYUQzcU82em9uTlZWbjRIYTMxRmIy?=
 =?utf-8?B?TDAraTNvL255T1A3b25jcXhlK3RIVm1pR21KLzNrZDJXL0dCT1U3NXBzdzhU?=
 =?utf-8?B?Q204UXBRYzIrRUFEbGZncW1KeUppMFhJUkpyUkgxaGxtMFVQMDVSMGVpQW9j?=
 =?utf-8?B?YkZwZkFEcXRBRXNZRFZKQnFNQzBKYUhxOXJ0dFFsbjhsQktNWng0WWh2RWhC?=
 =?utf-8?B?aWZ1WTg4T3AzN1MxUGhOeWZ0aDd1bzhhR1VnczYrVmo1eVJnb3NXeklGUXhr?=
 =?utf-8?B?Y3VldUdQWUZVYjhmcDVSdEVjU1pEb2Jjd0VDbldTak9ueGh5L3E5dzdIZXlk?=
 =?utf-8?B?bzk3RGQybFUzY1RLcTZQNlcxU1A2SnJXVHorQlJrZEd6b0cyNzB4aTZ0S1k4?=
 =?utf-8?B?N3pXOUQ2dmp2WnZXSkgvQTNmVXdNdGtreU5mc1orbHhVOUtvZjZsdnlndm5s?=
 =?utf-8?B?YTZUeG1kSWFHd2xxdUlWVlNSampOaFpITHQ0a1hPSFFKcUZjUGdId0lzdHFm?=
 =?utf-8?B?MjNVdWY0VkJwYUdZbGwrakl4WHV6OFpLUUl6MmhPaEtMaHBaRUw3elVkQ1hk?=
 =?utf-8?B?N3lWUGNUNjJyd01LK2FJOEJiSTR6M3MxWjVieFlBQm9LcVlFKyt4LzdIT0lv?=
 =?utf-8?B?ZnVSUEg3MkdmdVNjZEFraVZGYjZQcGhlTVZwUW1MUVkyUWJiRmpTc1Y5SU9a?=
 =?utf-8?B?ZTFzWWFlZlVieDZtTVY1S3VEQ2JBckEzSHFZUUE1YkpBcnFzM2Y4SkVadktk?=
 =?utf-8?B?a2RkdU03SFl5cjhqd1d2T3kwNlVWNXRqM1ZYSTdwVHZoRzFDdklRaHFlTmRy?=
 =?utf-8?B?eEJkdm5RMWl0RzFEL291SXdMNnc5T0lHamg0SXd0SFhIcVM2UjZFek1aYzZE?=
 =?utf-8?B?WnByTGhkYlNNblF2OGZlN2NCMUNpc0Ivc3BpaG1mNmpoNjhiSnFyK3pqVW45?=
 =?utf-8?B?U3Fsazg5cFVrdWNIcEU3VHZHMFpzTGZFc3lGNDJCWHdEajVaenhZOUd6ZFlO?=
 =?utf-8?B?QUlrTVNMUDF6bFpOZXIyak1NZ0I2QzJFU2ZvdWRiZU1NSjNYcmNMTjlaYnNK?=
 =?utf-8?B?MkpDd2ZGMlJ2eVJ1aUhka0xNS1ZENmFtNjNCdlFNN244NUJVS1V3dHNoV2Fi?=
 =?utf-8?B?UUhqWXM1TVA0UGRWMDBIblJTdUpNbFNiZGk1WHBrNVRRZGN5YjltbG5UeHk1?=
 =?utf-8?B?REFsMUdUbC9BemUvUGN0WjYrVDVqb2dnMTZxbDRIb0lMOGVFd0ZjTjR3WElS?=
 =?utf-8?B?ajUwTGk5Z1JpZ1l1dktISjJGcVAzVXZuZE04YlZ1TXlTU3F4a3h2ZG1vSUdO?=
 =?utf-8?B?ZkJodmR3RWwrTk1kV1lleWNHUDlnOU9WRjNiM2RLaFowdWpjajA0ZzlJUy9N?=
 =?utf-8?B?dk80YkErRUdDZ1BMS3dEeWI5dDgzRU1ybXo0bE9pLzVaWDB0c1J0cU5xMy9F?=
 =?utf-8?B?TllDUkVIc1ZpNUJXSWVyL1ZCejF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 05:53:49.5922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ca2e9a-1237-4874-7589-08de54c39f11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491

Currently, the error path of amd_iommu_probe_device() unconditionally
references dev_data, which may not be initialized if an early failure
occurs (like iommu_init_device() fails).

Move the out_err label to ensure the function exits immediately on
failure without accessing potentially uninitialized dev_data.

Fixes: 19e5cc156cb ("iommu/amd: Enable support for up to 2K interrupts per function")
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: Jörg Rödel <joro@8bytes.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202512191724.meqJENXe-lkp@intel.com/
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
---
Joerg,
  This code path needs some rework. We have to re-arrange PCI feature
  enablement properly. I will do it later along with other SVA related
  cleanup.

-Vasant

 drivers/iommu/amd/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d7f457338de7..2a3c9bb1c229 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2454,8 +2454,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto out_err;
 	}
 
-out_err:
-
 	iommu_completion_wait(iommu);
 
 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
@@ -2466,6 +2464,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (dev_is_pci(dev))
 		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
 
+out_err:
 	return iommu_dev;
 }
 
-- 
2.31.1

