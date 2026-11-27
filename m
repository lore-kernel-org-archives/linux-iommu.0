Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779405;
	b=FugcEyaJC4+4u/yJ83cePRMmEM/W+oGtAeuZ7xSXDmDszzTYP8k6iaB3pptTNnqlrUao
	 tLLuhwdDvmxbojVjJlSclhodZ/zRQweNcNkl/7hO4NCqwQj6TvbChQSY8TDqVkPzi74I8
	 G68ydzRxRPQys5We6G26BMEQ/VHqK91NH7Sa/43ffRzXXFg57qQYSd2NL3RezBLstNgyi
	 aOgvRQt5QwxkyICcxY/sTEEXRHEzdqlguW0f5zexc+WKybXI12wQvBuemAH7H+3hlCOOA
	 4M5ocfQoT5CUUlYJbfNw2iVr5PsHk8mp12pJezhk1kBxj3rWL+XG4nZkoMtjT1496LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779405;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nyEIVTuxvGg1fwNyhx1DwXyOIYYTzEY69hha86JiPNk=;
	b=Tks6Q05tHjd4DFcXgCi8D2kMjYR89va2ZHj4x4owVYUZOmWcBi1Ibo2bFQeGmQumZBbh
	 cTeFGDy9ThrF0M4YfolyF+AN2GWJVqdk5WNaFX/Dno5HffnDREUs0BX9inHOZSDAFwwyt
	 Il23x7/Hd0o9kB5ALXv5MKx2rvDRoCjP7XSjns32NzH/tr8vFnNiVOLznzvYgf/Leig7q
	 uzfsREvunsJatdGg0ZK/lrFTloLuH0ZVRzniUBrXfVNVZrWxmhj6drmnp+bhHkUYPEPVI
	 wkO+194IbyVIK/8PZ/ZRlB1PzoKBn4Bp3OZd2/nfVTl70VbLxjukbXV0hk65joOUZdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="rEbkcm2/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.30
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35935606A334
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35935606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rEbkcm2/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAnyz6doChoPWlNvVLH2pXqIMrjSaQTH425E21Htg6OVsUo9MN6pWZf+t+AANoSDcFx0xcUHNtViLKWA9B9ti3Ngt5UuH7KAvXW0KtCWEdJfFsZeLZbi9V19EgqsMWGm0hifsHGOPVV42qhZNESCHW2jooeYtGrisqT+s/+k4aZ7kKVqVLJnensaipyaweGRCY4EaZxwkkglgFZ39+gNfWRnjxj0/veclzqTluwCl+hrkEoKHuRqEi7qucBU+vq09HsuIuNmzxSXevd0ryZjO4mfhtJemXtNcTRwy8uymCqJJSzWC2ZqBv6WPMu378YRC7eg2I3NwONBLC7VUPBp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyEIVTuxvGg1fwNyhx1DwXyOIYYTzEY69hha86JiPNk=;
 b=jYhbNbMN/aqMhyme/p/YmFv8usjMRflnfGrp6SvbiXqvpP75KOHGRDwwpM6uSC8L3TWfJLN1i07vVZSVmgPUXdTxlUtlYh5+qwrgAhWuJ/zoPdxcevi0/3kWnAnprVincPnhh/RPlY/ew+UBMkesUO6kN7ARa2AYFKc9BBdUMLFSU+AQsPGJgJ9AEy6pAuXfX6LtrpRJbTbptJr2dMs62KHk9oOBUaHdy6KkYm/VnMYlzStbNqoe4NotNUQH1jbNYZVc1klRbEyCzv5G7VtD1hXmMsOuD1XG3aWhU4rQzw+XU5xX1PlabJs3TQk6xdCeNG4CxhX1Ua7lQiNdlkR5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyEIVTuxvGg1fwNyhx1DwXyOIYYTzEY69hha86JiPNk=;
 b=rEbkcm2/5x3AdVInGl3NT7YTPNFvkIMAVqjM5aw1jjSByK7Diw0Fe8Fbpours8pGyE51WuJQ1FBfXeVR7rTiQ6GRbNUSkQC+l+tKG247PzPgLsjQYbg9R8uWL+lnthO5sOgWcFQ0KxILs0bpUPpD30lEenSRX+19ru90boxNxh8=
Received: from CH0PR03CA0081.namprd03.prod.outlook.com (2603:10b6:610:cc::26)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:34:56 +0000
Received: from DM3PEPF000265BC.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::55) by CH0PR03CA0081.outlook.office365.com
 (2603:10b6:610:cc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 11:34:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BC.mail.protection.outlook.com (10.167.23.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:34:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:34:53 -0600
Received: from kali.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:34:51 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 1/3] iommu/amd: Clear the event log entry after reporting an I/O page fault
Date: Fri, 27 Nov 2026 11:34:22 +0000
Message-ID: <20261127113424.209190-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113424.209190-1-vasant.hegde@amd.com>
References: <20261127113424.209190-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BC:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a4dfc3-3f70-498f-e993-08df4c7a74ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|261026121527099003|10067099003|11063799006|56012099006|261102123227099003|261021121427099003|261021123027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/Yfcl8CMHpyrlDR3C5BZIkYEl3inBDo3oPixmjvnsyT8YBhQ0Wd9r3M1TGcbi1YIIeJINSyfLxtCqheOMB2NSfs7+7lNcyx09qLcyp5ZN9du6eaioGHWy+9UBAKlLQTvyZq0FagGRyw7hTanQQBtJNQus14piiWflLT7o6bsqbp9y9SCdZb37RZLQ/5cGC8OaxC/HQdc+hdhDOUZAlHnZx1C/mMe6zJ5jQLWlXlaqZMX1iafAFSplDD4f1PYgLf7BVPuDSGVGlbg3KolSmAa8CARiiU6mKKOSpLGPCqknntQibIK8lfXSAZXey5Fafsc32gTw9CPDVaWk7QkZJGVL17EfUMEKGU0fAQPzs1LRLCrOkmMLekY9D4SsReuvrF8ziKDhM9LkglIZ5Imhe9WZw+tvPJD6Rq6fo0JYiT0lKMuKg4E6deS7ZxrWBSp/hRmiLzlrv/ZBzlV0/M4ehMYN6pYSkZr0BvVNXCdg+QNn1/Z5BSxxWRFY6u3oSlZUVW9T8ifhWukehEY2lLbZBLgiwnk/cvjVDmkC83EkvyS4gf3E0p0ulix0WWVwcWQ+MGXR495yRYrAp4w4oaWNL8QPLgKhD3bgpW5g0hVNyO7bg7B83ycb8DprJV/lRg/DRuQuR6QexcJv6NTLw6p1Pi3JpsX+OqPxB9njTu//zL+VLNHLdR/YzBZyKlff7EG/NPx7K1bMcj6tPmA4XCyncqcuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(261026121527099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sxLqNwuk9O0xqyMtj2LWLibENOCMk278bhc8KlhoKZRoYaoE393XdvT9uFDucp4v4djyiEryLQtIcWRXvdiiJtl5RqA5amFnMydGNBV1kEMFWY3hMQgo0zilQr74RyCFBj8zDz2mf3A58Gb5r6CuLk0FtlNpkSQ5+00CaDkXijJ8KigBVx0D8Xmkdt+zhdA8l/jWy127VhgBxtSgktHcZmW2Wu3S1d09ktXdRgZEzWOpHUkwXW4psojxoB9XM24dilKweQ4Z/j7Y8gW5oMc9J3//jpPap0AcVQrfXkMRhu+gayxwYV6nGngLjSOlvXemj2VOVN36++x/6HpYq5NkwCBRF7ktMeOKDYeoXBlrU5AcIyrr9t7fEB3e07KswQMEmDFMQswuEh/ghMMt2NMewkWnabc0YeIRSBSXU8G/kRqGqCHWCe8IE1QxOrGiiwZ5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:34:54.2111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a4dfc3-3f70-498f-e993-08df4c7a74ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839

The I/O page fault path returned early after reporting the fault,
skipping the code that zeroes the slot. Make sure slot is cleared before
returning.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 29a3374216b6..9913b0108f5f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -932,7 +932,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 
 	if (type == EVENT_TYPE_IO_FAULT) {
 		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
-		return;
+		goto out;
 	}
 
 	switch (type) {
@@ -986,6 +986,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			event[0], event[1], event[2], event[3]);
 	}
 
+out:
 	/*
 	 * To detect the hardware errata 732 we need to clear the
 	 * entry back to zero. This issue does not exist on SNP
-- 
2.31.1

