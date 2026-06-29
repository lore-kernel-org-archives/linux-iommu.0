Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3362836A6
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726110; cv=fail; b=pQVZVAs2lxOBmiwazGsvgvr16VT+dfkVGnyZb+LaMq8FJt8ULCYCexO0U9b5J3Z/37RomYzJeAWIMltDM3twZxTIBBlXc8TUGWxlrNrqE/l1xJbtOXNpnL3T0icLyNAPcp4enWIZXSSpR3kgtfsACynVR0RuExoOW3UNA0EKIYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726110; c=relaxed/simple;
	bh=brbtnZbOVWpzJ9kclzj0Dd7SQ5xOJy0iWgnzinvjV6s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hH1v7znsrFbgMDnp3IRPS4eBtT41pY30ICpGspvE/FPofJEbOGFuh/l14k2nghf2euOOOT86MACXMNWX2zJIkIGzHtMHBe4yhz/O4ueLUWq32RTEn02lmNPeazw+t4Ml4Yaf3Hw3Z43pH0ZPtA01Drs9K0DEgGkTmx0CN/mFMYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDxKITpN; arc=fail smtp.client-ip=40.107.209.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDxKITpN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdgVJjVc58kUTZH91YljkGv7SrHaUye4orAWYDjdRHOPv/kqtUtsepIACSZ+6hG/XPDRTEOMwSGnwyVF7qYyFRvRPUmb8HsEX9f1RG/V/ZcxqCKAR6URAVRaC5J3uiD2TA6MruBNrAR6BuRxqRTMbFo6AHGrBXueOoFvDar037wXIwS7+gRfmw8RWKs2ASPbCYEw6VC8EHeRxuSBVRyAZYdZ41HfxTEuCIqcwH6KMwmC+sNbzjTWePev72b+0KKjNljNmNU4fnRjHSPAqlQMBXznuIxJi31/dDY6MDVEV8xa/KE0UsyPkfqtFmoln/Guj6M0eR5QUye0mRsBX6EtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPPm4tZJ7V39usgdlT0lb8Nc64UxiiyYF277VQ+x8gE=;
 b=jx0vYCCbuYTQKGa1AKqVI/KBVtahAE5WEu9wrVLBDfFqF7IrcQG/9qJg66sx7T1qudEiFCzU8IECp/TeIat+qZfAYiC0L2ccLqflzWSPcSectitnjKh832lqCFMx25eJ6HrhJgpcJ8Z0wDrJohe+iKRGm21i+wmMwfrNTtEQzgU5TVNYTp9hjuZ40pm2sz3qZbAVC1sddUDiSSbxOQ4wp5BoEI0xz0ROG9+Cie1jyEJofEyHlyLz2hbTzA/Er0yuQfmys3eSthahCwCneQNCYN+iF4qH2IMBI8wkAjmoclVbmhO5tLclRD1b05ZgTlAwwkYjryctRcw1IDoM+WJmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPPm4tZJ7V39usgdlT0lb8Nc64UxiiyYF277VQ+x8gE=;
 b=ZDxKITpN71eCp06CCjoo3M/5cagaGGuS1zgUAwqv8JA+bN5n7OzJuBozdKFE+lP8qCZzLrZ1mcxnJcJKVrn7P6ezsqvR+gFmVHhEM7RyYZABK5N+qjMBhFzmckG1dZzh/8VgHGvh0swv78PAWiFIah6YedLiDtfXHNoAlcY2HRjLqakyghNFPSAAx4Zf8mBJmr2hTDx4v2D/keHeTHrH6jC75RfDkkX9gI8YyI6AsDRfU1ZGT/dL1dRYrsT7qENNHO0SxRSH2EsSBVvw2MiRsunReiwdI3neSvI+zxBZsR22zc1t13v9MeZsRtisv2InIUILKjdTOTL5YfRJ889KSw==
Received: from CY8PR19CA0035.namprd19.prod.outlook.com (2603:10b6:930:6::17)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:41:43 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:930:6:cafe::30) by CY8PR19CA0035.outlook.office365.com
 (2603:10b6:930:6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 09:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 09:41:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 02:41:29 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 02:41:26 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <nicolinc@nvidia.com>, <jgg@ziepe.ca>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v3 0/2] iommu/arm-smmu-v3: Fix Tegra241 CMDQV CMD_SYNC use-after-free
Date: Mon, 29 Jun 2026 10:41:04 +0100
Message-ID: <20260629094106.251694-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b78217a-7599-4f52-19d6-08ded5c2a0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	BGuJUtEiIxw5uICuQPSdheYpE76PPzHAKOuiW7MFo5XDBL0E5tbbOuZb39/sT9soYt1G6Ba9eyIbb3Q3s3G/PiMVF2fvHdSwZVTjRIASkuY8UbJGMUlhfQAebSiyp5cOQKPqbFCkRI2OqS2Dbx4pjtoEWWVGVf30q2ClJGEXN2JrWVIWxLrqVR32H29m0vWrWRRkxnmpMDuST65/FzURxGgvsoKVbU+cH9lWxz3Ekb6HBS8ENzCwrv6QsHolpEJdgpwHeTVwm4ArrY+AdmXHsOxT9WhChTeLanjJqCNMlAedbVNSpOxm675e40jy/LCxJ2bV2H2SnoCGIwDfS7xnulLt/vsmYtudig8G09L2HBXP6C4ybD1VgF340r6PJW7zT667fNBGEo4m6OUnvHP5sv2My46qFMXMKMH4A5b7UufZnyD4Wdi8+4uJBhng6Bjl8rGR5RZVc5y7YPp0XQuBkHgDAEB33dRg8PImWLv74Dr5E3YpoT+gd7zKEiKRkw21z6JjP+ZttHsOtt5O3S3edx+7CyX/rRF8MeMRKdqPqG7ceLepWIOVjDlsc+z/NOSnEJV6xc5Vv6B0ShadpdLmJKMwB8tDFN/NXrQ/fCoWSOLQmQ1T14Qzs0nUIIw4TwuAFtsQKYABNLuxz0zIiOFjgfNRihYDCeLnlwCiikBYbZ0tTymubU4W/DwNUGXsmnmRrIWrhDuPy1sf9f0oQz+m1w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(56012099006)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ljq3G6MDjy3ZxL8ISnA5phLjqJTHI7pyz6R7L4ejhvJrUTJNZrexAyg6UUG2OHSCQ58PRGa+os+YtEZaRlkELjywfetp1i3T84Gn+hHHcTrCoRsSYrzljToVjo7gSXBx6FDyyJs93Ge4o4Q+VUKHzIyjQHRIlypQAS5wH8EIg0XVZLr26otyH3ip1SqNOxIDATOgJPYGRIW7WsjmFl28l613r2juLLHxRGRLc9m/wkjSbYXU7xK4RRBdC21Zt5LxuEgE//yH618YCPOKAH0W7S+Xc4PKJCx+aejjAAXHxB/CHh/pcPBct+XuVCf0suquTlbiZJg70gxI30thA5xiSIvK8p/myLmfdQt52AgcZOY3c6dzRhzJXdNFUzryK9HIuhM7VleD++VajtobnZ7E3pHthhUhTptgpTFf06XdjEQIR1tGsl+weVmRrVGlUU+b
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:41:42.8408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b78217a-7599-4f52-19d6-08ded5c2a0b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302

Hi,

Changes from v2:
 https://lore.kernel.org/linux-iommu/20260611084205.686559-1-skolothumtho@nvidia.com/

 -Addressed feedback and picked up R-by tags(Thanks!).
 -Use explicit type casts in devm action callbacks(patch #1)
 -Add Cc: stable to patch #1 as it is a pre requisite for patch #2.

Please take a look and let me know.

Thanks,
Shameer

From v2:

The arm-smmu-v3 probe teardown mixes devm and manual cleanup, so resources
unwind in the wrong order. The IOPF queue is freed before the event-queue
IRQ whose handler uses it. On Tegra241 this is worse: devres frees
smmu->cmdq.q.base before arm_smmu_impl_remove() runs, and the CMDQV
teardown then issues a CMD_SYNC on the freed queue, a use-after-free.

Patch 1 moves the remaining manual teardown (IOPF queue, vmid_map, device
disable) onto devm so the unwind order is correct. Patch 2 adds a
device_disable() impl op and uses it to quiesce the Tegra241 VINTFs
while the CMDQ is still up, fixing the UAF.

Shameer Kolothum (2):
  iommu/arm-smmu-v3: Manage teardown with devm
  iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 58 ++++++++++++++-----
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 15 ++++-
 3 files changed, 56 insertions(+), 18 deletions(-)

-- 
2.43.0

