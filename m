Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B307F
	for <iommu@lists.linux.dev>; Thu,  2 Feb 2023 07:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqm7RVRlHVgTkrtBn1Rgue40SKd0W/yhXFKeNPFhRUmMxlkQwe0cY94Tc+IrKtiqi77gD66KOAJLBiemYkhKqIhuimODjdeOlggvJ37KPMGtwXtINEiHXJLvvl5X14vBYRkIZOE8PqjoLpuweVGadp2w+AYH2TbbwSZLg5dXcXlDUjTLQD2KWDa8iMa3OZHamSim+elTKPxo0ulVyurwY1fG6twYaaW/oBx7hs0o88f2+zwsdEXEl7Q5oPNArVXICNKkcbgI6If3v8hxjK5Turtm+7CM+1RQ//fPMlt7YO7y6TsIr9GfVCDfIFBgiSeadLccbHpZJYpxC8Tt3FBXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M7iekfihGGncrRbOBERG3QeRSGUe0DStydbRWS41RI=;
 b=J5wEV2xsaxA79Bghw4XcFF+kR8aqmocfhN+cT6ZJ88IvMZ92Be9ERMJ2apDdxo88dShs66OjYivejLJVhxD4MOvlC4yI8sQ6mmWHAaQbXninRCzH3k7STPosNHnYsDFMQvXxmRlrYAKu8y+F5tnMIxd7ITx6KqwzBN8A1vVMeSvb2vSNwn0YxxB3clvKoSHUXQxiCVOarx88Ehq2vOHezggebmBKn8V8X9OHJGlRX0Qgw/kdYAgj2TV6olTB+TjlnTs9A6JZTo7Tn+O9rjFJ0t+2+OzI7SZZsqOAXIgk3CB6OpB7tXYMZDq2tS/NCEkFbLsH9d2b7x6mnl7XN85OuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M7iekfihGGncrRbOBERG3QeRSGUe0DStydbRWS41RI=;
 b=rtG5O4FZGRY0kWz43WPNPzaYqkH26EC5grDb5bKmOC8SppprwL7YdLtAtjs0rCfz1DoeMGdhvvRHkOqHkG5Xr6alALMv8Bm/544MHkB7SMPFGF3QvcncTvJ60Vot/qyKWbR0pAe7Uvhl9CQ7fMp8w/jR9JYw4RDYM8KAIo+kR6hVbIUVakAq8B9vv7V+xg3DtiRoouXg2tTxETZLypMGCYprXlJhBxii1H0LzdOwFsuIY3XuiFVvP3F7Dv5CEXM4kVues21OED3JgZCRNqc0x7USYuyh6wmIOac3rtQkquHfE8oCMa1ELdMJ36Hm2tdIXFgc0VLBTd6bEp0U90PAUQ==
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 07:05:43 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::7b) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 07:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 07:05:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:28 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:28 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 23:05:27 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
	<shuah@kernel.org>
CC: <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v1 6/8] iommufd/selftest: Add coverage for access->ioas replacement
Date: Wed, 1 Feb 2023 23:05:10 -0800
Message-ID: <8afddda23752f41a31e8233847f4998fbda9db78.1675320212.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675320212.git.nicolinc@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: afcc4e08-655b-4b52-531f-08db04ebe63b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8okXiqiYtFDuCj+WyBeWpnuWkNBgdBH1ZM/UsIrYh8K0DdDtlcercdZ29JBWik67rkdUvbOkE8J7pM4cwfZWp4RJxWkmXSCZ/VdRVgJL7tm+/+i7qfxwqcg1fZ+TAbSakhT6BFgdHhsO2BcvYuPJOhabFVel7WmrVDGZsYEU/bbveK6sjkv3clUBGjsSYaux1sRaaPdtYHLK8oe6k56Tj/Csk1lTBx41DmLdQ1PuYi2tGs0pNwIqtxg8d2EN4QnH8ZkpUUv/TxG2uas1QFWo6RiSgdegID/nSUzAfZLwNpmp+8wOGRrdf0Rh+PYwHS/O7XV2YWBoxWQphGF5B6r/eTw2TKbcEVSXWQMXCaS3ZnivzpgTgalGYa73ZYxjAEhspc6+EuYkwy1pq6OIeoFgYUmvaFLXU6jBAHsOnUDwsdA3pVdLsU11NycLxP3t7yFz48EkN2f146p6x5phdsrbe/ZN2ewUwoEod8hStinVAnNglkLur9o4dYcSwGYi7uKK2GfBjotn57IMNCCR+8xpk7VphqKztdKwDGEcfDSEFTNakfxVo8hM0vH+w8YhmfhomgpptaXb9teYBxtweEQ2/w7aGgULa7F70GFHS3lPWestBrywYr70NoXuv1H/FwyQl7KtkDCqhD/jg1r5xSNuRJ8DYEINYNrG0K85fICNCKJE69KVeZEPYUuScs1IWrvC7ZuHWDtQzj6ZTaH8HpM1JA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(46966006)(36840700001)(40470700004)(70586007)(70206006)(7696005)(4326008)(8676002)(356005)(86362001)(7636003)(40460700003)(36756003)(6666004)(336012)(426003)(83380400001)(36860700001)(186003)(26005)(2616005)(82310400005)(41300700001)(8936002)(5660300002)(54906003)(110136005)(316002)(47076005)(82740400003)(7416002)(478600001)(2906002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:05:42.8436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afcc4e08-655b-4b52-531f-08db04ebe63b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945

Add replace coverage as a part of user_copy test case. It basically
repeats the copy test after replacing the old ioas with a new one.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 29 +++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index fa08209268c4..1e293950ac88 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1239,7 +1239,13 @@ TEST_F(iommufd_mock_domain, user_copy)
 		.dst_iova = MOCK_APERTURE_START,
 		.length = BUFFER_SIZE,
 	};
-	unsigned int ioas_id;
+	struct iommu_ioas_unmap unmap_cmd = {
+		.size = sizeof(unmap_cmd),
+		.ioas_id = self->ioas_id,
+		.iova = MOCK_APERTURE_START,
+		.length = BUFFER_SIZE,
+	};
+	unsigned int new_ioas_id, ioas_id;
 
 	/* Pin the pages in an IOAS with no domains then copy to an IOAS with domains */
 	test_ioctl_ioas_alloc(&ioas_id);
@@ -1257,11 +1263,30 @@ TEST_F(iommufd_mock_domain, user_copy)
 	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
 	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
 
+	/* Now replace the ioas with a new one */
+	test_ioctl_ioas_alloc(&new_ioas_id);
+	test_ioctl_ioas_map_id(new_ioas_id, buffer, BUFFER_SIZE,
+			       &copy_cmd.src_iova);
+	test_cmd_access_set_ioas(access_cmd.id, new_ioas_id);
+
+	/* Destroy the old ioas and cleanup copied mapping */
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_UNMAP, &unmap_cmd));
+	test_ioctl_destroy(ioas_id);
+
+	/* Then run the same test again with the new ioas */
+	access_cmd.access_pages.iova = copy_cmd.src_iova;
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_cmd));
+	copy_cmd.src_ioas_id = new_ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
+
 	test_cmd_destroy_access_pages(
 		access_cmd.id, access_cmd.access_pages.out_access_pages_id);
 	test_cmd_destroy_access(access_cmd.id);
 
-	test_ioctl_destroy(ioas_id);
+	test_ioctl_destroy(new_ioas_id);
 }
 
 /* VFIO compatibility IOCTLs */
-- 
2.39.1

