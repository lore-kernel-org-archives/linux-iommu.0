Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E161380FC5
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735107; cv=fail; b=asTc2DsR4oNLC9nJ7nqA22tL8wy/2axfWUqa8bOKqqUfkzmaafca/Ar5rm9YiZghz3K4r2QkCWDKmccImpRusXVpb0Skq0tNzeiK7qyKWPqhisYkw7/Lvt+5a72Wp9gLFkeYT5KYw7AZ+i+3Nn1y6YOm5ajWAz1xNcQ/Wc57KQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735107; c=relaxed/simple;
	bh=rjAiyxRykaDvhMlpZHkvteGoVnTzw3s6E7VHQya7slg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLzN2+3Ja1Gy+wjckilVa/JsJu8XWu5hEOT0E6qpTBdahJUDNj4JJrIgrcLtajCstC1KH9Ds36fuI7pnBIuPya3J65wlbV4YrmVnxZh/jMtDQgMVXUBLNd1NVl4wvAjTXoscVYkAnCniFqIo76YhYWc/M6UhNl3hkiYPkMTAmpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OXO+N3JD; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OXO+N3JD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FttP49Tct5Rd9fWH1CAZ7zU80WknQ+I47isDEFiYV9oWUIAYCPWgACHIW1D3bbHqfUJJfwZ1XXAKrEogdE196aFsgvBKbQ1KtOMINew54qdkfFCwD558nUJIBmL4fRXyti+IiONR5x8sWFZtRe8SKmmv4ueMRWvD5m2sZ6UG54mLMWOlrQY7tZWbPBGqo9j870dnPkPSDRNEAz9BC/fh63lUUHxixB97lYc3FWQJfPRdy2JPhxEqauG02zIqIKY9CAkvHOgc5AOqjzuEW/KzGR5GKvXnaBfc1SIlsEu55YI1VCP6XOD+qoO9TZar5K4gfXOrH8sPoj/da9BDbGQ+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXCRnRHZwZQv4NFgx/xOgEVRBEA6RW/+BJ1T7vbaTPY=;
 b=lE1yXcdrSodt+mOyEoQmgnXPa7qIdRjFsf5bVyjV007jiHaQu0byTmF4yMXcHybfSYJ5Nxk5QDhuHfguD4iZUqt0UryPlsdoJtvca5Wg/hkgYM5z8rHb+rckStdaq0SOHa/1mAF0pmCAfEFo161TQeyi9EFp92fp5W4d0EPggX3hh0MZj1ddc+R51JYuiyBF4myh9W2D4PjHFj/rgYDyf2HivQa8+5Cpu5JvGvEtt3JqT5pCav+4/eLQxGoiQRlxsyJzwS9k97VIOhiwVThg6SeKHdVn2yhfg9b7Z1wh4vsp51BB/ZeFJOcTWFaaoEJ8fbJGL3eDlTOFEGBCyYvncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXCRnRHZwZQv4NFgx/xOgEVRBEA6RW/+BJ1T7vbaTPY=;
 b=OXO+N3JD4uZgDJfOdmIxOHG+vl5+MAuZfg98gaWxWuARYHO0eebqWwKLtRJS2idC+siGrmv9kOtEP28zvgfcjf+lf76s7UFznYqvJEFy2MPRt6gcPuNxZEHM9dkrnz9JcH/m4DUOiMS9VaqlVYx2oA/AS2BxpAk3y4e9+fb9WHK3gJ6txAHdaqY7utlIpfcFk7POKcsXCDT+P+Ub4LfQ5x0OW8yUnNxTgfWxI3tBzxLuBk5kPVIWpspHDVIYRtOFejfyu20Ad5Q9n+HKjBlP9jTBgFRdZJ91LbhhcysK6nID1q34XA2JucKKyBZBq8j4qxsZ/dIWf0hjuuM7YrO1bg==
Received: from SA1PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:2ce::20)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Mon, 25 May
 2026 18:51:41 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::5) by SA1PR04CA0014.outlook.office365.com
 (2603:10b6:806:2ce::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:51:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:51:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 11:51:28 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 11:51:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v3 1/4] iommufd: Fix data_len byte-count vs element-count mismatch
Date: Mon, 25 May 2026 11:51:21 -0700
Message-ID: <bd712df2ce55df2eb75043d62454caf71d985dec.1779734952.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779734952.git.nicolinc@nvidia.com>
References: <cover.1779734952.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 763afb54-9f02-4fa4-c1dd-08deba8ea8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	09T+9mKkWFXW9wxYKp+RrgGz9sByaQAyf/X4SsqyNwVVNEaWVVIamJz6bdvO6iUnVPDFfqcJJhhzHPwDLvjNdfyFSWsPRkIqVW7Zr2R6R5bvxca29usVfWXVdwS9YgWe3GDPSnWySW3Vn7e5gsMPxDOZ0eY4jfMnV9V33n/ZSfhmXL2+QDn+vKSHpOvhPxYecI1v9p9ysc3dQWoDRdn1AHv70j2O5SteRCU06v+2ZYlc6DUpNNQmex4eK0OobkJc8tOlLDWOGjArggRvLr8SwRoOVbnAFUGkNoOAWMX8QI9U+g8hIHvLXlmCHI5O6mQ16vakuu5pgNfruwUljV8PBHMIEyx2hSo3VmJ8orWzEEPb0LwI0jwv7AAsqViolmgOxYaAky/QdXS6PwjmItFXXpv6HMud2k/+qhAflyQ/WE9M87qQSp5GqafkySBCdsol8pMPMWVj9vWOMxRCkTFfiialaGG/QqMJ4ZpKoSKK2cDo0OaE0fQHEKrkJzpBSwFv5V/Jv0iaDZPsvPG037AQmuj+euuL3jnC93lJ+M900MaYlKRKulC/OZIrJaIJazxbXQ70Zp9wENx9lldQARI8//01BsV51+d+qsdVUBMhx0lHHEdPxOThEw5d+lilU4AzNqq0CIYHY6OWAL3gO7XxCCf0e1sey9o9CdyLFni+cYpHMoBKGyHM56sn6VQFa5o59nctdKMNFw5iXD5tL/QfapE7xYHxXlsckt2iEngLLjw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ynjky0YPA7vWKqGXWyYplG0YPDFkfQsyyL4M2q6mG0n4W3e4nhi25griG4pXsZZV+V6Jwg5GbTGk4mF3t7SWhklazrMaa0SipTfUFZ4deB6DIFxyOe2ba14FBzhEUkNzef0g9LMuXzt0Q4NMlpE+Yna1KkQowyDpUNE4Sb6TC5D0Qw4Iklp6IlFBT3451I+udJlpKpS/8rKZUtmwAm4xi0UJRF71/z50yhLHP23iwiKcIt8htSk1USLI3KJt1SyOVEsbbSplARHPykr69EfTbkCCcDsgOpgJqLMur0547DSskx+V/LcOId68OqC6aHUMp914Zkn9DMpnAPHXy+YfhkrjC/9an20/ISn7YD87cZLrwvG9r53nwi1QQt/sOh36xzj9T9muP4YKKS7vaqR5aSfwLijNWzAty35cC6hqbtD9HMJUSEIxz76dXQXzgNY+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:51:41.0059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 763afb54-9f02-4fa4-c1dd-08deba8ea8ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815

kzalloc_flex() computes the allocation size. With event_data typed as u64,
data_len is interpreted as a u64 element count. Yet, every caller and the
read path treat data_len as a byte count. The current code over-allocates
by sizeof(u64) and the __counted_by() annotation overstates the length by
the same factor.

Re-type event_data as u8. No functional change in user-visible behavior.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6ac1965199e9a..43fbc5bed8de3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -602,7 +602,7 @@ struct iommufd_vevent {
 	struct iommufd_vevent_header header;
 	struct list_head node; /* for iommufd_eventq::deliver */
 	ssize_t data_len;
-	u64 event_data[] __counted_by(data_len);
+	u8 event_data[] __counted_by(data_len);
 };
 
 #define vevent_for_lost_events_header(vevent) \
-- 
2.43.0

