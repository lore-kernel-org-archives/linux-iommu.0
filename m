Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF33FB040
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346609; cv=fail; b=TLf2sH/gH8BdxNBfF/CZEQf5GZmjYvAFoVH0InRZk5D/d5IvYXtMU39pif4PPI8rY9nZP6hRat0g4t/rWyF0aM24T1GJkZ3CFbuqGWd8IxrTjsnOfmyj03zwjWgyBjdyEzgYIb9PzF06+PKeVYz2tYAa4J7qr+G84ScFUwvUF7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346609; c=relaxed/simple;
	bh=KoCNufDtcmtRsNYVkP6lU5PAntWn+8H5mSIsIf1/inM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyQ2fXyzu0rcy8ibdAf8Ev4RCvBGAzffxHfJCasLOsvRjkaDW0PPSxmzGLXZoPEGJT8o97hFZ0il0FbiDQpnBFal3G8rQHs0iasrgy5nEp4p2rVk71vCSN0J5QVKD7LKcsSYYrxESKI1scmTGdh1P0yNdftBHVfICWgjQ38Myrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pewlnnmg; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pewlnnmg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdSAX4n9GS9jV3vIlgxAiDaneiD5Xl+H5jXa+mhW1kSCyPmx7+DJ6kN4nyr4wYcRZS3mpKb8iLRmhn4srffd76KuvfM5bQ8tmEUFpFfh+IHhri360nBxPBb0gxF1guWoPBB1swJ2y9X8ILS1pY6YOTLUosjcXYCfI0uRImzFotBAEBJgc0MsegDstpTT2NMWxdpKWnzzGO0zRP91lY+AE8iSPFkxwrZ+nqxzl432646V1cKE3cfkCJE0SE08iEtosbyzcu/bHFRGJFkHV0QzsdPLGo9F8qWqUnSdDZ13Z1VxeYF0VCcAIeQYFgiaTAxvnC5y5pDJ++RlKP38JraiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsvGqZLvKH8oUoVM6+07HstqeICCOxwO17y7APtcvm8=;
 b=N6fXn8o2Mcz/vB/8trYThLq07E2nAowMRgg5MXPMg6eKkQCuOSHtfE89iezPBYBnzRH0adezIb6BchcxgJpKBFkgzAxK4/pD7fpK89TzUfQNu18gJQciwTrJ73Y7U1KUiSmXC6MBiUg2fzb/Mqwmltcug1O7I5f30eGVaR4Fsy9yiRXhhLTGzAYbfkrhayHYZhn9tDf9blI78rtQBas4NmcZ2f4wcIaOx1md2kEntKf96MvjjbrnilcepKPZQOGsizNe5gXEn36/ZiVTl0jWO8/TkEnPOn3xvXNrxBGfS42xUfff7G0YLo2t6ZPg0k0tU5RouL5sXMjDLYOS3es6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsvGqZLvKH8oUoVM6+07HstqeICCOxwO17y7APtcvm8=;
 b=PewlnnmgGbuKaFvKNz2xowr4MpnT+xsKMbS6iH7k9SvqMHXy0vHpXbbOcXOAtmNncoyCYe9htUGBiiHUxxyPblYmOkLk3ByqZy7R2+WoMCrWnyZBr3JbOAA6xDXnL1g3updRgbopKkbvlg4ICq5F4Cf2vy8z6xqOkLJmgQZprX2RQ1XG3DxgMA5yWHg6In8N4MOJDsWNQ8mj4eSjcDn3/h7iaSaDUgVuDb1/WtZl+7Gof3SVcb6hLRsH/jy4qn5tfndOhCEeemcsCIhYKZwKNoN79s9RwFqlnEt4zRca6io/UE4BuEc+sKWZ+oyMKJTD9oHkQmIUHVwUAQx53FrcEQ==
Received: from BL1PR13CA0346.namprd13.prod.outlook.com (2603:10b6:208:2c6::21)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 20:43:19 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::5) by BL1PR13CA0346.outlook.office365.com
 (2603:10b6:208:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 20:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:43:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:56 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 13:42:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 4/7] iommufd: Reject invalid read count in iommufd_fault_fops_read()
Date: Mon, 1 Jun 2026 13:42:35 -0700
Message-ID: <85c118a606fbedc5c132a1f5ec223a5ba23b92d2.1780343944.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780343944.git.nicolinc@nvidia.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 77604a61-cdf6-44fe-273f-08dec01e6a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ckEO4GrOIzNe8RXLR7kk1/+ACsRgB9tbs5cYzxAwC1rjGvaF0dBMjaHm6rqPrZBjNmg/YLpRVKrmdRI7VCorNxIRAv0EDdewwO/sZQ4NtwR5kfFoLdhg254i+5zlN+oZycPylsTDt3vGMg2lPuDGBcRvMRn2RIKctKKYOeZC0ttnU0Yy1juYCB+UAO4FLt0H9kUSoYpmPewNTDqFqfbExBrhjiPq0IGqA0QNMoYvi7wao04nrcWdKEqrp0aWoU/Rl21ptMTxcDCRw6XfF4oSOgm7Fwg7rJ+7KZ6gKwb7Fs3CcXxjS7JVpY/2VTZ9Uh+bOK0KofSzO/9yP9y0UY6GvoSjuD08lPhfZEmpI+9NJsZnpp+d9ibPdptQBwa8dWKryshRFCzxzNKQj7yBpS3x86GVbbkQtC9LFXHTnT6yQNmtRIcOqyOh/LY1y82I4u0Phd1o+89pFsF8UKA4n0kZPkMEEoEgT46TZN0QGsXEd+BZut4mZd+gIyPMWlAN3dGM6O3hH7f6375IDtMJmGtGcEBpDsLWUWFjoyfjJdZPrP/1j1JJ0p/CagkLrFfBbBchM3Z8LFMT2JbffibE9ZnAusvTuAy4cEqF9G6Ri9a9ExQ4qjZtAEHRPa3qFRt6wd0DzzvdT2gJRGNAu1TPzfzbYkVjm5vnlOZhBN7sQ9wMN+j7NYb5solAIKLbTcpOLdOo/R4W1v80Utz8R0oiL6DEYHfw83po/+fdYgdxbF40v1Q=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7xw2LYePsgBeWti6n3VYK0/5NplEAAA8cIOLaJBC6FlNvozdIkEKZN+ebqypnvjZIoX1n3/C4ilw6q8/M/VK9ajSpNCt7hRdTecQYbsiO8kLkVFFD2RqnBxzxcsY2TCn2hvIeU3bRUXactWi5PLFmFzvC29FjKTaTTLO9cYet8P/gAzoJS6Sw4XRRvpj9LhQJsx5sC8CJeVnRoXTC2LHKfPPfbGdghM0q9Xzi2MBTXr1iywnIgTc8Yse74BTisYzq8NrtO7f2NkUKtnTexkmOICP8hvZ1Om2Xpe4kjM/eVIkrGHPgFCimNaA25aJDuzp6G2LcDR5TdHQrp3XPLdF5uvPHDioHn+VLdfj/b9u8wt8kahHTxjHWIP+sRCYs8E6EvDHvtedyhi8DGb61bLHQCUnpKVv1AVqqJKCbXow7D5JuNn8InavSkQHs8mt7r6C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:43:19.4269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77604a61-cdf6-44fe-273f-08dec01e6a30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698

The read count must be large enough to hold one fault or a group's faults.

iommufd_fault_fops_read() does not validate the count, but returns 0 as if
the read had succeeded while leaving the pending fault in the queue.

Return -EINVAL in the undersize cases.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/eventq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f55d173c59f61..613024ca8f1ff 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -142,6 +142,9 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 		if (done >= count ||
 		    group->fault_count * fault_size > count - done) {
 			iommufd_fault_deliver_restore(fault, group);
+			/* Read count doesn't fit the first fault group */
+			if (done == 0)
+				rc = -EINVAL;
 			break;
 		}
 
-- 
2.43.0

