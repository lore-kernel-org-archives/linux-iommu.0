Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7845F1E51F;
	Thu, 11 May 2023 04:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJqmAjq41hsl4BqJ6flKpdKDx58l81CaTEQjGdgFdjbCBuV8Pw1dt22JE619pV5wajFvr5PK52oA6dsXnRFedvHyqTroC+s8KjRHRWIXO07NQjgiit/hHwwV4HHO0dC6p+bRfUBO993yCQxJ8pygSi8K0a/zy8nC/jvk7NRjVB5S13ZKwNOq1jxgEmHWkCVt3rjwbuJQeO936kAtkEVDRI7tApUD0gswYI60baIOTDon8eDnSgQ2U0RhODukWIqdsn03LIdMUmTuHWnRa054CW5osneeHoiwjjHx7/862uBonA1rTADavlIljz+EVmwCHhFjPSxdUV2pLNcvEh0K9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3yTMlqQbU/EmvYpcyspttj3v62BprnOerzbP02iiJA=;
 b=Lp8Y5hEvhZ2RLmUtuovcb2gnZXtjgEBMesBBLJNx+KmILqdXqhsfCzR766c3zCzSjfQE82pW0b8rQT6hiwWrtkvGCCnU2i1o33hpE03uzCIdOavXgoHCeDK0cP6jPeI0G3+Wz8TfaXXDU2DSlJL2ezauO+PC6DEBPIxQE82HYeiF/WFHa6TqtUXMfTQoenvzpg51p8gT4iasJcGRp09xTGBYbUzKdEV2B61BkgX2+yEqZ5d273Db/x3qjZ6d4FG2P95TEcDp8322qEqnNi3TGvwwDmRpXLxDqS95gqOWJf4XSBpvXhMcsMfKuTijTkDaku30T+x66StraQXKh2yLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3yTMlqQbU/EmvYpcyspttj3v62BprnOerzbP02iiJA=;
 b=UTVhUge2JTB097WC1J6LGSc5+VdMZ6hWcw0d4VYp8TkiOUCvI/ShehdSXKD/5HVxBCSlYvu6un2dWNjwlhDiS8xujVerRDkmE8nW8VQDVox/Ykp8Dhejh/HgBDzooBdXhqHSQKHlKEN+75+nw1lG9NaYDjhmEGBKBc5j6OQKYwhHXSgxBlWNRbk3KKMRjF5aUTPkHhGFTfWrYvnQeOupCloCmlY0VBjfRk5RZqzrwi6AALj/1x79OalYZScgJFumuz6zZ8qAGNVu24kgaoAzMTTfNeIcLtrHK2aLRKbsoTMBj7hJkJl0kThxOWDnC/7vJ1DOK70cRn9XpwrHTGiJDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:42:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 04:42:25 +0000
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
Subject: [PATCH v5 01/17] iommu: Replace iommu_group_device_count() with list_count_nodes()
Date: Thu, 11 May 2023 01:41:59 -0300
Message-Id: <1-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v5-1b99ae392328+44574-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0192.namprd05.prod.outlook.com
 (2603:10b6:a03:330::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: c083d7c2-4924-4b6b-fa10-08db51da1adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CbiaR/yHSWEunN2xdEvjhOusCGJMvAJK+WeFmYWZyJtph1SweyhHmraMj9MZcS7LVy0JcqrjOSQE2yPrQkmvVL2fkPaNGX+86uGl8jysrmxteNwlcAOdQuSs/ejBlS8/CR096X6VSH+K46F5silSVRjcDs/rL2rTXkOyKGS2tjemkONJmpVVyAnMjTRgXS9+i35liyq7OmKye2O6KWqveKe14cpwStWR0cNK8Ip55vWyd06RlewZoi54XuzmPUBUA0OeaDEXUvNv04JA4Y2P3BNKs/e/UDBQoY0KfGlX8k6aAi1N9WohwQ2i5+DAWk9rghQ9jAVcuMpHu9Rmc78VoxKejpX79Px20E+SzV5+TMhbIGAE4H3yPiGpqpPFJYDflx0g35Crz8J32hU0isYTctLWGZBUQ6PoNSuubPGPkQKcCl9sZd8EHCmjHX94QiEHiGJzgpqIoyyqIVr6oYw/ciW7yR6XhLWGy4pRZ5C/Uu3BH+RWSy7NctSGzlSlCbBI8eeZv3HjGs44LP1Bw6jRLzbPRn4+snlj1Qn+KNxUq2cFzsYlkMAQO8O5vm+v3iVrb3HmRJI05C6WHcdQNX8towlvFIKx/EVeEb0xTIKnYhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(26005)(186003)(6506007)(6512007)(2906002)(41300700001)(66556008)(66476007)(316002)(4326008)(38100700002)(83380400001)(8676002)(7416002)(86362001)(8936002)(36756003)(5660300002)(2616005)(54906003)(110136005)(478600001)(6486002)(6666004)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TQG0PaSu7YA23yXyANRmQtjA52PV5ActzHiZYpfTZlpBcty6yyid+YSotMl?=
 =?us-ascii?Q?MkJUs0awmA2OXCaMawYA9OT3+zYe+6UP6NoftzmHGI0FF6ZJJ6kOZbrPhVQe?=
 =?us-ascii?Q?qnzAEvGrCaTkDU+KMw7BhZ0jMWIXx+5hst47lkZquzGwfz58UvI71LTj6ySf?=
 =?us-ascii?Q?dsOCFxqDBH7JqDGGMw5CiDYMXbuCdFRjhFhQowJ2GQ4Vr4w2D7ylYOLu5uFn?=
 =?us-ascii?Q?9EYb20y2UFNecA3zxSQjSJJ9H62vAoCDn9BiBbx1cZQcXt+SYO+ss/tBRn8x?=
 =?us-ascii?Q?uRWPHw4dH+6/qzr8upBjv2xTALaAbiuqioSguplpG8SZR0JXxWQch0sUubUF?=
 =?us-ascii?Q?PEHl8zOsYX8yNj9gUwhxz9JxsErHsATPBIQLpv95PhMD8kyxpm6bFCQJNmbm?=
 =?us-ascii?Q?LbfGnxK1tkbpAaD1uOt5zxlvNeGEOqIWFSmRRHbXs2nGluzA3lnYIVzv1qsr?=
 =?us-ascii?Q?8wfbQ88OiW2/Fr7i+etmUSjhgtWtyQ+TI/+1/aUexFJXnkP3kBSSyqojV9oe?=
 =?us-ascii?Q?VXw/8q64zj2tACve+eK8BIvnqatX2Vw4ug5yOkpuUwQOlzZWeZWd8wrEkAXO?=
 =?us-ascii?Q?zP7h3P45QYM1ij/AIsjEy7JuUhUzGWfyyjuJDbTKPG4aK01v80o0zKfb5B/G?=
 =?us-ascii?Q?v5+ks003GzrrQkWnsb87NKhjBrRjkocXnsTEX7WYlTADl9VCxsD+AdZD4zCi?=
 =?us-ascii?Q?jk1X92mJPON3cce2bUbMm6qDi7JcC9YBzeeM2dr8DLxkXtHkX4LzSzf4nvw0?=
 =?us-ascii?Q?LU8qs0aIcFMgSL9SfDBiia2+WYR3x7Vtwkg4hjBGQ/NfX+i8MrZTepviq3/j?=
 =?us-ascii?Q?spGOm7bDD2pSbpAiDI6K41DCl7u/IRhuOcEQYitamWPW1PNqOyfUKCd6J3b/?=
 =?us-ascii?Q?3wEDrJTyvlu3pdbBGAVJQvbMxgbvcxA0UDsQUW3S8VzBhwTU2qQxgXX/mi94?=
 =?us-ascii?Q?d6eIJheuiTKLwQTXQhEa619MV/H24M9bk2BlatF1WUAKOhfgc0/Uxdg00D6l?=
 =?us-ascii?Q?gNJvkgz7x2PjFrE0MAEjOrX9zswE/e2cF1j2Ljb/IC6T6h1r0rWNgU/LmkYl?=
 =?us-ascii?Q?ZJRWBlmZvXf/X5e0vqgcIMEzR+5yRdAPgoXuTNcS+WkapkTiM7m6JEMYj+h8?=
 =?us-ascii?Q?7Friuo45Ix9KN8aksN72HgRAXYphN08yx376nFLvDYkRsE1rzxx0qgrS0wVb?=
 =?us-ascii?Q?MInSoS+zChy9THBeEi22MlxLhq8ywAJoyiLlJTJQt4n3fzkpU1U2MrN4vF2w?=
 =?us-ascii?Q?cvMr+9MrCgZSmiO9vCdeNMJGWsp8W1k0mrk2J5uIkmfXhyvI2D34GFxCA7ad?=
 =?us-ascii?Q?LJdsAA7QE4rCZqqnQY6Nk9yBztnH32Em68bpH4rfVonFZ1GX9BV7I9uUrC6v?=
 =?us-ascii?Q?2QQYnyM4VRMSfYPLfSCLo+m8M4HlrrMyzh0CRaF/1HWfFSFdlTL4UYqPwgFo?=
 =?us-ascii?Q?3ie0VZHPVdtsWVHPPYWb0L8OibQ1Ksq+TmhRRIb1sAaB+yMaf272CH7oAvGC?=
 =?us-ascii?Q?BAT8XhMX+o8PdIBJJIvZx00gIgr+wDDXTdu9JcWYbKblWQEHmad6E/Th+nku?=
 =?us-ascii?Q?mmBiR+xr85du4TMoEbKyqGNmLZWt1ay/FbJ3EpFc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c083d7c2-4924-4b6b-fa10-08db51da1adf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:42:20.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tarY3BaDYaBgZ8sQHTWKy41JDu/LInDcJA0s3D3EAQ0Gk0syITS1/YT3Au0TA04U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054

No reason to wrapper a standard function, just call the library directly.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b48..f2c0c10af32c4c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1125,17 +1125,6 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-static int iommu_group_device_count(struct iommu_group *group)
-{
-	struct group_device *entry;
-	int ret = 0;
-
-	list_for_each_entry(entry, &group->devices, list)
-		ret++;
-
-	return ret;
-}
-
 static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				      int (*fn)(struct device *, void *))
 {
@@ -2082,7 +2071,7 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (list_count_nodes(&group->devices) != 1)
 		goto out_unlock;
 
 	ret = __iommu_attach_group(domain, group);
@@ -2113,7 +2102,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (WARN_ON(domain != group->domain) ||
-	    WARN_ON(iommu_group_device_count(group) != 1))
+	    WARN_ON(list_count_nodes(&group->devices) != 1))
 		goto out_unlock;
 	__iommu_group_set_core_domain(group);
 
-- 
2.40.1

