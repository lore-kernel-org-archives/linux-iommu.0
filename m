Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74B22EE7
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SqfwTDFu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+c69ROHw41QIQgDEhBul1w+O2nimljdOAT1iM3pjaHklZTb1w+911+lbWPIy3D1/GohN0DTzUL1Tj+EywLJdWfsfNoHii7h6ympaP0i26C0BduhHd4MPQqK85eBnczSZ88UrlPfHu8h/gPZQXeLSD7KACwIL0cllb9XmLilsQVLjeGBfcORBJzmUt2NTQdzvGazPqavpNrq07edq2K2RVYDCTywPCaUyS0xZr4hLzMDU8ntCkKi0cfhGwfBcdu2xWUBEFKXf1+ehySRwNzXio4LMnNcG2wOMftKfGLPbCumG4nfTVZR7WcFoxvra4sB/S6SEyjDyjz8qyoHXYtAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmSBMelYoeL8PSeZSGkueUwdtIkXI1yyhlC/bwoJEKY=;
 b=HvgunloEGOU73R9gcA8WlbGwy2WW52V/C1K+camCWh/Oj3D5YS1nlGVqyc31AaSo6cuj1u9H7FraW0iBRvha0i23wf/OzzkQByGAxrwm8bX6OtQ2ldrIgCyYes/yJLX5moPwkmG5I8Zl4RHSlmzBE/DGHsL+T/82MpZXemxU+9V+LgwrSfcw27uw2BuB6YIKMZTV1t9TsFzayOrOtTOiAaAg1QMQRLTfUZWuLjxq5G05b+0YyZTB4n1y/KJBXTAPF3jPmck7j8C0WPzG74aVCvUCKliSL0U9BmMDbstrjQbb2YA5kmngB9WFz1m3mCBrbEpflppdH2wjtNcAmhGXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmSBMelYoeL8PSeZSGkueUwdtIkXI1yyhlC/bwoJEKY=;
 b=SqfwTDFullYQqMGBhe/tCogcH/SThTFghXm1b2urtFXDEdBJjure5OyQXLOpSTx/3QSRetjsAGZdvXHNerRwkEwwkk1aGkrJnz52QJfQRLcHWg3FmqryaPIUm1dGqbL1Gr1dUiifm6eYkyGm82GaNepC22U6+NfcfeUESfAfk08rwgUaFfaIac5Ko95+A1xhn0fqGp88oSOkWDQfdK/qVKNpyNhtY7AMbBAMwWTEUPn4l2qhmn7rD0rJHt5xQ04TBZXoW8S/Q8wmqxAx6HAIb6U769+grAihwJdk0Inx7GsjLDMJUPHIKxUFlh4qd+WiVI37sL7nsHGxKFpRf+nTWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 17/19] iommu/arm-smmu-v3: Use the identity/blocked domain during release
Date: Mon, 13 Nov 2023 13:53:24 -0400
Message-ID: <17-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:208:a8::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf23e73-c94e-4830-d6dc-08dbe4717103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fRrlqHmcpPtdbV56AAQF0ixFthAOG9TuIZcF3s/JowhZ0GLG0YdrhMS0KLBOyz2RqA0kFnbHHzqdXTutrdkoS89p8qIr4VeQDU7owPcGGva36XtPnX4orw9PZajUStRT2u+PHnvxtfKyBGgRusmHgUIuM3y6J/oG6cQwUge/9uvry56l6J04w8tlZNLsnugDrdGTpYBw8+6pfNeWrcA9v0m2DGALJMRrddNwnHu+ILMVROE9yF/1SNQLb352VaDr11LAF8BQHMS9xXB7B0izMLtGiee0Or9VRuzMuuVcTRewxegxq5Hgb39ME9SNNCaL7+hHJQj3KokBU8oqPLl74BCufGHRcETMMvVKlvLelYsGnn+Q+1+7fR2uwl8aNxrXhpPow/DRu8JyLylX9uRjcSoZw/ydcumDgj4KDV7Le2L8YMwMcQgXFeZSKsVMKmfmeMV170y7ix33My2VnIvFQfe0feb9tQx6svp/qptpdZClkcxEHqyF36BSgKoL3aIt3GKE7qZ0J5ivqw+sMJmXSWyti0ImlS0W44dzYVPEp1K8CriG4Tgj+bx36OMorvlE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(15650500001)(2906002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YkFXhgJ22DTEEqS+c7LxfDPWsw3AaSbM/YN7id+zgm/sTFu48pTWoP9lsz6T?=
 =?us-ascii?Q?sTUHdWKvdYbh35vfGzrHQI3dlRUdlIRJSfsdMHlbfgwTWNzYT4j7FTWwt9X2?=
 =?us-ascii?Q?okD571qIyCmFJfSbtD7Oja7pBED+MUBwQgftnv/TWeQzk8gRGGYv6zf5MoAQ?=
 =?us-ascii?Q?79pJrvUPD6Li+nDcKNmLdoV1lNuJWMhMhaUxecbo9t7ozWJubB9vvFfy2Yoz?=
 =?us-ascii?Q?gkuIQjAm10UxYTOq9/Zflgmmwte7hZtQlBtpUlDzgIBM7wfHZmXsPHZrYkP8?=
 =?us-ascii?Q?SDrrKURrOrYxjSOWRDd8fHjF2S9vbV68E+N+MBLL/rRh5a5whlv0E6ChgaP+?=
 =?us-ascii?Q?f8UhPWyKj8OL09JdgzCY0275IMnjhftiz0ccfJySdEzeCHxmOMGdRYCIrcyL?=
 =?us-ascii?Q?+NhWB9cF4Htjc9dk+A9FvsowUH8w7lL7u5zZgWtNnG+2211ba/VRksQulsjt?=
 =?us-ascii?Q?wn4IF77fWmPTOZae8syf2i58fVc+wvbmEJ0n4EJkWuXHDI6yp7glfS6WGiuV?=
 =?us-ascii?Q?2U1RYufL0PHrrHHbpo8qxtMnULHgyz18SCjF9/PMcVHutSt7OTqxl7kVntip?=
 =?us-ascii?Q?tjUfb80SSktvi8sI+4wupJevtIpAz9x0rSsck7rexl/ZjejX+nxYXlq/UaGU?=
 =?us-ascii?Q?KfksQMavSZrgYxJtoyQ5ITz/F4IP62q3jMNPwwrJstjivJ2NI1P0+9zr02pp?=
 =?us-ascii?Q?uMYDXdjW2G2PuwjJpARnD+nNbIchv2QpgZN8Wr39LzwZqvxkAb4wW38cECPK?=
 =?us-ascii?Q?M30qKQ0rfbcbjr/80PutuCYi7prduFy/q4B/7NpD1wG5dM6ba2pPIVsuVqHj?=
 =?us-ascii?Q?+7sGuG6ujIaym/XcIgTiHCLkRNs53hbqRl4qS8GHTw4Dm3lUZ/Jp392PbU2N?=
 =?us-ascii?Q?+cHnYAJjshpVjQjKnztDmWuhVYUymNfDCj6pqeg3fNRJKPU5gS1BCRX4MlM7?=
 =?us-ascii?Q?rUAiJxK7PoQpbpHcF3Tll9F8jb86zgCuyoJNZ9Ey7ymke05eOdMaLHJ5GqLh?=
 =?us-ascii?Q?4YWu8KbQ09xkPESrwPgMms1D2ZXUBY/KZcMt3f7M6pYJxqVZZPabx1VAc0Ph?=
 =?us-ascii?Q?TD+c/IjfW6e9KWyTJHjOipAc06xkXf8AkXjDoOMJ7F0gFj2WFl81dnP1bBHv?=
 =?us-ascii?Q?v1LRYobmLUwABegOVa0jdHBVsLPXf4vJpe6iJAd4wNsazSH8BDAaxIiIRWzG?=
 =?us-ascii?Q?OUYpNoGUcADX+annf8Mdp9Drpch3mogNIsvmEx6AIZEkG8I+qlxhtWG9AaGC?=
 =?us-ascii?Q?bZB7/gdCS8oIls1D83haDZRwX9Ywv+WCVHfVNH5F02/cNu6oi2fTaumnIADu?=
 =?us-ascii?Q?0BA+UnC6PNWsB/6jK/oTEzlSTI3RYkNGV8iojyruDo95+TlDUGfIQWl6N1Kz?=
 =?us-ascii?Q?uLkVHPKnalCYfkLEO7Fp4NbdjC0PSKc/kZQ//5TVkwbof6k9ouwU7i4H770s?=
 =?us-ascii?Q?xPl9EpoooLoiNjcJkmIOQURKUqZT3ODhgKL/LFmLi5l5tm18I1ZWvhBn+zD9?=
 =?us-ascii?Q?7Q1FkYG5f0dyWvm13612Nann/JAfyVNO4fjw/QeSqIq6OQUb+XUYOjtMi5yz?=
 =?us-ascii?Q?8WIesO1eIqV75ckO1YI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf23e73-c94e-4830-d6dc-08dbe4717103
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:28.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEs76haaxz6nHUBcSvXsK+ApMiWy7jt/Ix3lfIcetqJLjXr3xtZl63fvOff2DwT7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

Consolidate some more core by having release call
arm_smmu_attach_dev_identity/blocked() instead of open coding this.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 48981c2ff7a746..331568e086c70a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2900,19 +2900,16 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 static void arm_smmu_release_device(struct device *dev)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	struct arm_smmu_ste target;
 
 	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 
 	/* Put the STE back to what arm_smmu_init_strtab() sets */
 	if (disable_bypass && !dev->iommu->require_direct)
-		arm_smmu_make_abort_ste(&target);
+		arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain, dev);
 	else
-		arm_smmu_make_bypass_ste(&target);
-	arm_smmu_install_ste_for_dev(master, &target);
+		arm_smmu_attach_dev_identity(&arm_smmu_identity_domain, dev);
 
-	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 	if (master->cd_table.cdtab)
-- 
2.42.0

