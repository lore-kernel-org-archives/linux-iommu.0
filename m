Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0A645;
	Thu, 11 May 2023 04:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBN7bLQ+6Fsc2+GqCz9OYTGaZSwvuvd8qLpEsLzoCfxx6za34J2uZNM8pDSkMmXIKEF3Otnq+DUwNm1GncbjUprubX/yMWf50/qfgGKT416SldVnGEeLcU03ckK0HuyectcTDc9obIywEeTrT3ztcU0J7jZ5mUyHNPJO26n0LXm/mQLFnwZvg45T30SEORVN65JRF8jfDvxFbP1lLOfNk/NnOlWKRFIkJOxyVDUgZxvHOoU9xdp5BwSBvFdEzReYmuno4NQ/SJZWx4e5nnxJnjQJ1SPX/q2tjbao4KFt1cIP8NRaLZWxwfTgjCOAWRx3xGRhWrAvZE9pek7YKKqlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmbsUMdi2DhQg0q02dOsFuiA/tkqF8uMEZg+QrZ3P1Q=;
 b=oaCuKolNOTimE4ua+Mj+HrptjE3GVxa9nzKE8EejXUl8S2jK8bjqb6Wp297igrW1a+P3ClCuUe5rHz+m9N4FZUpicO78obJhpjPzULvgOaKQXz3lcwMjwJN6YhfaB1JoLUfqEjJosIQF74bQmc9YCElng9hcGYrEp0wB1urW1FGhedzuOEj2Ns3AGj1/wrE8Viw7Xiu2RGHc5zb5gBhQbs38MmdqPy07BzGN7QAacw09fy3AFXvUejBLtmLVdlsgvoGTg/D1QOufH7hKPe1zg9SFrEjcgThnwdRwATuf3ZO6EyXTVHN36OicWA/XT4nP/RIFbou31Bdwf9sSGAR2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmbsUMdi2DhQg0q02dOsFuiA/tkqF8uMEZg+QrZ3P1Q=;
 b=MdpUdogYXPdpSO4J5A5kI9e9gg6hP0wHwVmYnVH1Mv43AUrIYXa2PiMOsoGBkOGV9X6cH6pv8ta5MYDSsIgE2spwHcdA/iPfBxEVqockKV8kuOfqw0l7rlxrCJ1BlfabHcy7SvDX/X1aMXZ1mY91LZLnPNUWDeSWSWapr/wTgMwA+ifiG/lDfr6FVFiLBAF/dXxavvxYfNCv2JhWfGV39+rr1Ywtiou06JI2IBgGLHy+Ck29mJjJxIpTDu3iRrFYm4Ngl4dQ+4N+X6tFPquwZL4gu5I3+c/zgukGQ6n9NUMT/oxaxTMeQwsPEJifIaiMJDQ9wHLNPAcbwTRI7Bk3Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:22 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v5 05/17] iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
Date: Thu, 11 May 2023 01:42:03 -0300
Message-Id: <5-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a054c5-949f-4b31-d633-08db51da19ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LBzJTvfbfzUFCu+BQSJ0Uq2ZyGCodkUo9TTP/V1KHPtc6Z7vsLTsbQjWDHnq7/7eBE5hIAWBaenox93uKSSuWyWC38HsQIX7joVVP6pQW5e6XZ61E7+u0BT5/Qf00YmShgVqlLfregtVKwJctm/o2/maRQntvFE4SuuokhOHp20of8ta0F1ha72V/qrO9ZzvGEDChbPxowjXotfARFESjNVVzMNAoW94gaPBZfrgHCPiR9j3Qkd4PxFo1+E9MmNVpIpxgj0SNxrrLJ7ZVi7IvNieiGlDW4Bhramgki48O+KvIFO0skqfP7IpWGbWC7ru4wwuJG7YLL0wMiiL4BCjV+bZqYgiG+aRdP8SuHqyLSEMG9NWqNb7UFn49aRxHS+vzxEoVzkY1LpJGfZHJSoiL/7hVBSZQRpiwv9eRhLzD3YGaQ2O5yAn+fyy6MWsT8cq3nbBpgC9l2EtD8bTsgeJOjfqGoz5vp4XpgB2w2KIEIMAT/8sLbI1vlc0LPVywltiVxCYn2LFEwfDJdPnvvhB2fq77LbCdeoF/CTK7llV1Sho8raPMKEvz9CjI2gZQg2meNFoGCQ+IxRYOSrGZEEnyl/AjFz/T5rwuTJTVgD1OzI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1pt8hu50ry+Z4xXIeo+tJUi+CYHCNvH+pSotjqfAUFJi6HD7YWoQx7IaIQrk?=
 =?us-ascii?Q?HcImOJMR0rlaqlngLwQRsdMJ7Vay0rLfj6FZz11yW1gNDKRIW39FsMFdQXLu?=
 =?us-ascii?Q?bx9RUIzrbN+iImqjuEC1mH6VSKd/HuLpzSDqS/TFHfwHwgsijHnEiPaVhvXx?=
 =?us-ascii?Q?6TN/BzukkbLx7CKBu4jI3rAa8fAzH7HFRwRAuKqB+II8UHFSfcdP8ImYf1sv?=
 =?us-ascii?Q?da0TmK8ie+lb1eLzU1MPlS1HC12/GhGesEaUiNMGHmLaePy53UWQs9KiPbYW?=
 =?us-ascii?Q?hPVwnoHsXGdRvBPXeVhR3RZ4Uhfz6X70il3ZLya7Fkjt0K5/eMTkUTKGJ+Pt?=
 =?us-ascii?Q?Iuki7O/pZsG9BDn24XoTYw/1BsX7d7g98xZ8SZRKv9/TdbonrbwRIqn+lnAB?=
 =?us-ascii?Q?AXvHwdTT2U3Fnry2T2bRaK/KbwIQNqKUr5m4fp4gt1mvpfVb+Gx2kBH2PG6B?=
 =?us-ascii?Q?jUyfyis9CGBs8M3ICVORixkdfjb63sZnITvZmKKX43JGPjI2gMBUWT2crRs1?=
 =?us-ascii?Q?B1ZtH/NaE+Yo2jsB/++kZNWvMZFbyzvjULoCoqBQUN/IYbZ5gnUAXAoZRDF6?=
 =?us-ascii?Q?0dVktOmnqWueI5UAoQQHMcJ9tM2TFVof+9oHiC1BB8zm8WVQKgyiUxpDqFqD?=
 =?us-ascii?Q?GqTamw4fWGuSA584kRLqG/4tvelKRC/R3teMk3Y6ML6J/bbJbxSlulO9Mynw?=
 =?us-ascii?Q?3f5uO5GqpYMMkONrJ0jM54bYoZ+F1L8uNLNHn6Ij/wTb85RuOiixdLHRfl1J?=
 =?us-ascii?Q?2knqsDNxNySa4JpbHhOCNsvXGxmXaWsldFn13HUnC7N+AlVyognPTYjpaFy+?=
 =?us-ascii?Q?7NE4emruNqpdH1kpfsz9+uHe9IRZsW2alAL2a+DARuDdpzgA14XLC0nOImpx?=
 =?us-ascii?Q?7IXOnItMcH5ZtFuEXrIcfyHsWvBJVhhkAcaMx1kuW8DkgODmh5hGt0sOwuB1?=
 =?us-ascii?Q?B6XFzD8GZvvDA9fv9ROXMOQS/8PYBF7SFt5berFxigG6BVIE/mobln3XEGJX?=
 =?us-ascii?Q?hRk6Me6yL4LKMj29zzo4iyQOQ4ZfUudBpCPiGBGFCnptGRhwQEEzRReRfI5z?=
 =?us-ascii?Q?PBbpRboiz5vW1To/mLSZHGPJ+akysKOr/tfCHXuOWG72jS7ir1mvMqMWpBfo?=
 =?us-ascii?Q?EN50ZwGQLKjAUG27ptMf/f6UCFpGJqMfmQTPI16rO6M/Ze0FDzkdpAmwMTG6?=
 =?us-ascii?Q?pR5IqcSAx2Cz2Mtdjt6JUVaTmpr41GZNo2LMFi4vI5dm6Y7fl0pyv1ZMIsK+?=
 =?us-ascii?Q?dEZ2z8X20ixv0DKwkRtxzwYlNYCOjv7J1YLOk8ZWpoOvWBqaF2qcUF5LZLwx?=
 =?us-ascii?Q?xaPc0j761Gs1jqEFYkmhLBewnwAreKXxb4CpQ4F8rf8KjnTHQ0ld3AkPyaV9?=
 =?us-ascii?Q?9o5fCrREXraI3IK+phAucvR4F9Isj8+wjHzYg8xjcBUkjO1LJnOH6E5G8HOz?=
 =?us-ascii?Q?Fz2lnpP7fdnTwPChsowUPMOGJnCtcu40VrOD8GXVZfXkt4gHseih/BI6le2b?=
 =?us-ascii?Q?H9ITmpKCdWDrInGPAm3jGUcz+PUdaMtEVbxPDaN/ZvN63Gcf+eApWgM+1evm?=
 =?us-ascii?Q?DLbnwsKIW72ViEqBMSGr+N4F1dmvsQq6QaWytdZB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a054c5-949f-4b31-d633-08db51da19ec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:18.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2r/vvBQReLFkfDw2iwjDzlcosJ/fWEoI1Ar+vv6NT7rG/JMqOixDkaDb7XafhNG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

This is missing re-attach error handling if the attach fails, use the
common code.

The ugly "group->domain = prev_domain" will be cleaned in a later patch.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f99c000118e2e1..46000ed5d19317 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2945,11 +2945,12 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	if (ret)
 		goto restore_old_domain;
 
-	ret = iommu_group_create_direct_mappings(group);
+	group->domain = prev_dom;
+	ret = iommu_create_device_direct_mappings(group, dev);
 	if (ret)
 		goto free_new_domain;
 
-	ret = __iommu_attach_group(group->default_domain, group);
+	ret = __iommu_group_set_domain(group, group->default_domain);
 	if (ret)
 		goto free_new_domain;
 
@@ -2961,7 +2962,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	iommu_domain_free(group->default_domain);
 restore_old_domain:
 	group->default_domain = prev_dom;
-	group->domain = prev_dom;
 
 	return ret;
 }
-- 
2.40.1

