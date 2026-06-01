Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F613F9293
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346610; cv=fail; b=f6t1um15WKv6BonZt3J+24NCp+SrpYztZLoM4UPqmcztdKyEFwVs/+S5VR4qI0OkuVyqubD0LnblgTxTXHH1eyWMllsYHraEtJuXf9oGSNgflHEGMfZvQ5o+PXF/7YlS+PMz6f5nOyQMwUmxJZXg5Y76mhJLEyQd+OpSq9y7+9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346610; c=relaxed/simple;
	bh=l8DRyxc3BEGZ+DtrKLh89xFQrScMLfOWL508uSTYE1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjr0EqBg0j8ZU06GBoyDeWasxbP+ANW3zIvSs4hzjG4N1XiHs1FoHk5pUYe1xLY+lsnQCmcfdhjtIhIdW/3fTTJ5/COhP6bBup7OojlN/L2DxMxwCw7aH1EWFsw940/vcvB2TVy18YELOkERBwoTfRLgeVZqsdCUQtTPMzC+9Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HUuY5Adk; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HUuY5Adk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtB4OQKezgcjO9y/CdRGW3zURsFv/G4d+G3EajpWw0BTTsnp8lSfSqSWdKbJG6pYrw1aYdDdsbK2r/7kbouXUqCqbcRpkwNH6DOgtcSetA1qQuCGiREuZTxV9xd6/C+HgoMzzimgIjmw395KsMPavkgEpPBw1GUjf5bxRJxfkXpXtXfKClYSQlauo8a3AVrEStj/3gfFCtCNC1F75puIYopGZmoNQwCiZiOW2y/zaEIasEXwOMJ1t+VC7X9uhV+PpvYVgbRs8mT4in2zrCJ7+hgFY5KFemWg6AsMjrIOKizhnb6tQnYNaprauz9Sf7PLxDykOOTE8U9fTUAj6A/l6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHzPqikahsSOHDfoWnamNXsKZE7HD2IguEH+X5fM06s=;
 b=ydsxPnI/mngGMUf+PZkMpRAdpdQVHTJynbub84Y1JiNQKyVIMR41JmDlx0W0GPxW4xd3RJHo+B1xXgek1WFkXcSfJskxyTcTeZB5idPtYa6QgFNkOAgjtMJKcNGMCRgN/HnHxEcsQfWqJ/yZkFjgVCOYdIbedI31+Hy0nHNbnTw9e0EJMzlF47MzHeoqMr/dbHKBRAbPGXXEHvOKwixA1U64CIZWmN3mZ3E9VaXDX2l9XjEKzPjdvfBDmX7jclvHuL2lzQGssH2Xomrv7PquPWHpFf4c8XCvlexCSyfWebSHozFycs4Lzi2HPoGJ5Kcp+2tsLNv7it1qnwDOHnRkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHzPqikahsSOHDfoWnamNXsKZE7HD2IguEH+X5fM06s=;
 b=HUuY5Adkfz2cx2GmJOuRDCgWeJ5+yjiMMutnJ2zG8huK19sXupwWqZFuzE5Yqy5IbDPfJMD1G06WgWMdbKHREz8DQiGO0MGPTV9jdZSHr+r6DnOrlQu3XmgRcQd5YKq3WqXqvayeA5Fdga1a5cw2KS8Bh4XMoFYp5h6q3CFmLn8dnDsEYMek1LEgArnivVeQAPQubGZBMHv26M/C3AchO25A0RTdiu2An827JhNySzHER315b0HdT7FTdoqBGeZW1BKQqr3wJensgg2uKnUYEeyyP49AObgUDLK7gBO1vsuEbOb4NOCpwp7lwtyAMksG+iNpXg02zXLjlwMkHr1VCQ==
Received: from MN2PR22CA0030.namprd22.prod.outlook.com (2603:10b6:208:238::35)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 20:43:21 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::2c) by MN2PR22CA0030.outlook.office365.com
 (2603:10b6:208:238::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 20:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:43:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:57 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 13:42:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Jun 2026 13:42:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <joro@8bytes.org>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v1 5/7] iommufd: Break the loop on failure in iommufd_fault_fops_read()
Date: Mon, 1 Jun 2026 13:42:36 -0700
Message-ID: <336a9b6e44fe66a24199d3be777c405c85c98622.1780343944.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fe9f7a-533d-4db8-944a-08dec01e6b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	nucHATeke0wpMyNJBbgGZjMxDllBRZc7kaqe1bsATNAXw+QxMyAlwYcM/iEG4MYLDRRz1jolBC0MJ5ROgWvRybl0V3q/loBZWxoq3657KedlX6mT7xK3gc6omCpgtAFp4a7odAnasKsw8rUvp2f98iRAnN5JYKhqGUnw87n+GXfgDqKh90CnW8wcfDgqL/5seu84sYTiHfL7IH97PAKFeW3xDofB4fBlrX26aZwY+NP0nA+nU+67FPW4C+2CtZdLXaOrNG6a/vQuFXgSNv5DeWRHowGhcmoj3q8CbKKulDq6gq6TjCFhPD7WJM89nybQ63p8t+oGYCnsq4Rz8HhzLDnBXalq6sDyu3xV/mhSj1yxazERYLzUeBu9sQ/ZthhsxDDEdtVBJ/ERt+h52GqRgUfP01d/8Go/6KiQ59wQH9oaH3KcZmer8U4/odK8F6iH2DPGNlr6t3xjv8Q2WM7d56dMTzOIJh47QaPzrM7TnOp0JZREA94il5cMEGHbo92hEzmZHEqjKA9Y8kTfNlVRlLkd7wpedtaTYlcA4CiDKGp2kiYIjbn7d6u7Y5JO6ZFpI4jWlegi5qMs7fKt5FiEAGiRE9LSFILcE/Kyqn977VWY5wJwYdgZvsA7HYXqMWPzvOWQMOXi6Wn1bpWoYUwVp4e23GLElX8swLuSC0y26DZbHWRz0Yqd+6j6WApSOB+sRdMWAOJ4fyqu8fBR76RF7J4sbbvUjN/fsp26MYOPNvc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uscitzQ5U4+bvGkQSQgNFlx0yQsNoaUBtWfEpa2IxJB8wE4nJIFW/qEcQHjDmsTl8HIQOPMehn7PY/oB0vAJRV66IDyfJ3wHETNoKLLk/Rhv2tsgZmC6wRksFZrU7IzTqYCUQVHS6oDAIUarAYur/Vtp9RjSe0x/L/G2QXMEy0isCdluZVRfiWjvYP9IfwNUR/eBTemNvCvFIMxCSIFaFIN5HYjQGMyR9u3pfpxo7gliYVyLRcxknGxOHS49H7PEkYwzQCWD5YgGojahSq1qXlN6v4PWTvPUTpOsH5Ey8K99glonkUvQmq8y1APo8AGMaZadtM/SpLMwj6SbJJFKfV6mLqXzUn4t+oQmromN5nuBNrQif4rbRu+kEZ7p9ldae06oreFCmOSqibLsGdVjOGsmwex0I9M7b+Nfc2pkUIbxv5B9RDFgKKF4ypw86ECX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:43:21.0109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fe9f7a-533d-4db8-944a-08dec01e6b22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736

On a copy_to_user() failure inside the inner list_for_each_entry, only the
inner loop breaks; the outer while re-fetches the just-restored fault group
and retries the failing copy_to_user() forever, spinning the reader at 100%
CPU with fault->mutex held.

Check rc after the inner loop and break the outer while as well.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/eventq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 613024ca8f1ff..1c010e691f972 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -168,6 +168,8 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 			}
 			done += fault_size;
 		}
+		if (rc)
+			break;
 	}
 	mutex_unlock(&fault->mutex);
 
-- 
2.43.0

