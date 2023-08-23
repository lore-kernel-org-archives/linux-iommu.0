Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA80BE5B
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 12:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT0ragCvfiW0yJqJKp+xJRJan7U/jfIQS2R8zInJT3Pbo1B3mvInOmWforg9TpRnNoBRclHfqdikDClwzrWIVeWS8DaR/R8XrCuBRVulNmk96qspxXtwx7ap91YITgW7HCDtgLt247Zn8gCyY5Lz5x1GgM0duYRS+BDyKGPqAvAigkxQyZBg4/a/bUFPdphAGKm/QMPXD1Xf9zOXdTgNxKS3p2dkEBhP2uWsU5BlU1gqmX+xSdrISRuuG/WB0yHpns6AvtcI6+fwej/xlsjHfQh02ld7kqKQrpCNauvptyqvwXprE093NCXgaHuve7SjX+OCB6Nrth9uHZwXtmWqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8h17L4iFuU4fDPX+D5yHJwbNKOl248YSCfi2RRZrpI=;
 b=GleMwajbRXrNK7gTLehf+mjg54P6YmsorWEC8ox5Jb92r7lEUlHMqX8q2J2+5NkzhVU0vNWVzM+wthwppwIx1uJnop//x5S3F6n8+LRQGx1b6OUVUZaJhQzqLwvsj1zb7pqAee9Ol1ZJG7Pc+2vszjcZjzduZ3h0ISFF93C4AJr8WNV3QuX3FHFK5Z2yXGa4snYteUJoHe+RPDAtLFs6KH6bvXoPnKj/a4amqRnyyqdIU/LkEMFMTXpT274zydjM0F+wywlmd1t8PLHi0dRBSXFNW5WvSmByY+aSbNBjiLqRgsgsGjr85pZ7ZzH5gw7izeqjX5KvTdtPYi+P2klEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8h17L4iFuU4fDPX+D5yHJwbNKOl248YSCfi2RRZrpI=;
 b=K5LF2lDkJfi9CMAOn8kGHVW/zOFvAC+J7fHH7h9L1ubNCRS1ezepiounfl7iYw+Bbl+z/MCwaKtClpxJy/PglW3oaqCnvsUUA+/Kj0PZmZRoFb2sGCYunSy4Fnv7RdS28x9V0/rS2ATkdt0YbD8/oo/0htoDZP4hyYVp2GyhZes=
Received: from CY5P221CA0124.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::7) by
 IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Wed, 23 Aug 2023 12:05:23 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::32) by CY5P221CA0124.outlook.office365.com
 (2603:10b6:930:1f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 12:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 12:05:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 07:05:19 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 04/10] sdxi: Fix for vma->vm_flags
Date: Wed, 23 Aug 2023 12:02:18 +0000
Message-ID: <20230823120230.727935-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120230.727935-1-vasant.hegde@amd.com>
References: <20230823120230.727935-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1bb2bc-aac5-455f-0a74-08dba3d13ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mbJGVwokOJKOPZUCxdxtuoclvNgXpM+tbSSTzW4d6MqV/VqBWrEIUEHvkaw/vmAXkhqVW2huJEGx6NTX2wYQvzIk+J+ZpkGPjEyPQ67PYzFMY4ofwG+ta1Dl7Fq7jX9ZRRCcWtSa8olmWJdCymmTGaEfm941XwwYcq+mThZtEAqjgUUw5bCv4j47DfU3mBUn37vj3M250zXb8xh6YRjM5uSJhL0Buram7pdwIvspatZL4s9g/Lv6aNlq7k5AnAXatLPa0TMQYFnBsrHUvUWlWl8FGvnXFlHI8EDNr27Td78bAKmlYYBPt37nnXE+X9MHCGOjJSlb5Av1yiridsAfjRhyW/H3W90nAYkp+Lbqkt2UwJv8pBuNWSC87L21katiOgUKx/HRfzg1IKX4k5djFtUqM348hPx+D998YQvlpN0EUiV6KbGVB9EJPGY+P9JhNHmfZewLG6ju0PGRnWTwOdKUvg6ziDy/cP9lLPrN7K0oAIyhK0UsU1HHL+rLEaTXUpJPZxoiZnnYUhtGUwYdNrL2QGI9etjO1dyGuU9wzFJsZcb1mPTU32rBY3EHyJJkb7cNMKWvUHQWWLYbssuk6id0vwzbWxhmCFlzPZ0ZM7E4V4/VL4wwz36l2LZELzy1b+V71v6iWZba21XpUxJKamRKGra4Ii94HkeUxfFh6s4Rmm1jRAPAS4uNxPYuuE7cnu+URJSz+SpnEvQ3hPKp3NgiARwDMp2FYWpMl0vnAkk9FV3xHO8T57cjHKgUJ6AIC34uiNLTEA3gD46yq+9LAA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(7696005)(2616005)(1076003)(40460700003)(86362001)(4326008)(5660300002)(44832011)(2906002)(70586007)(70206006)(110136005)(54906003)(8676002)(8936002)(36756003)(41300700001)(316002)(81166007)(478600001)(82740400003)(36860700001)(83380400001)(356005)(426003)(47076005)(336012)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:05:23.0136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1bb2bc-aac5-455f-0a74-08dba3d13ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/dma/sdxi/ioctl.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index 4355099a9584..9f7c7dc5014a 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -43,8 +43,11 @@ static int sdxi_ctxt_doorbell_mmap(struct sdxi_process *process,
 
 	address = ctxt->db_base;
 
-	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
-		VM_DONTDUMP | VM_PFNMAP;
+	vm_flags_init(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
+		      VM_DONTDUMP | VM_PFNMAP);
+
+	//vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
+	//	VM_DONTDUMP | VM_PFNMAP;
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
@@ -83,8 +86,11 @@ static int sdxi_ctxt_struct_mmap(struct sdxi_process *process,
 		return -EINVAL;
 	}
 
-	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND
-		| VM_NORESERVE | VM_DONTDUMP | VM_PFNMAP;
+	vm_flags_init(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND
+		      | VM_NORESERVE | VM_DONTDUMP | VM_PFNMAP);
+
+	//vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND
+	//	| VM_NORESERVE | VM_DONTDUMP | VM_PFNMAP;
 
 	//vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-- 
2.31.1

