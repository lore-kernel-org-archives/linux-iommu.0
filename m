Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4537E
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 00:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d31WRt1gfiGmJzBevZQvFuiR43A+qS6z+NKwXhs00U6xgSpSAZvDNjeqmyPGjk1916JgGVrWDqPEls+YkJquxQBF0radNdqCWuVbJaczixfOA28es5F0kiPm6AuBVldeyIZQxIzPYekdeirB8NITJl2fFvBq5QQszfW0N3ofNU/t9NEZ2ah72OUMi9Nv1JWsVLw/9xPy8x+4pAzp5Eem84ikZF9RiBoKYL9ryQ+hkIfbqymV+vg1xkycQFWK4N0ZTs1yFeHOyWW+i60ngwOuHlj3IT8kRmq5ojYOiJ2jq4L/jVRGtMDxS/hdMQuXzYoZklcFdle0AlH0qQ6e8yVVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvawkteNq92wUaNm9sYInWII60Gkb1+5wf2QC47yfjk=;
 b=gNh42/XoBT+XzFjr9GEdW8u6u1pBHdmHdw3EL/PEDi58K/Dir5diNsmWRCLo5fdu60ABssm6kEbBlcfRSBVS2HR0J/xjMnrZbcZU7IRdFJwey3IMZjnLKGLb3/ix+Z/azCA+2gGdpMEMosfOxEhnVpAjoMSHps1jnSxajGOaCpzpE8QKsaUIGZcckdotnvq8GywpbZHtmefbEa3OqM1TgLWU0vsxb+iYciyI15Vm4+LZ2tM59jntyDVRrmG1JeJvJk7+5+BmYIOIyrCXfr+quP2FDzFa1fjhyWuz/YjvJf+nit9Gu0QR2kD2k4BF+breonx93w3bGGpldLk7Y2iD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvawkteNq92wUaNm9sYInWII60Gkb1+5wf2QC47yfjk=;
 b=PezUp2ZiR8qyhIZ4sjx2bSWgnvKf/apHYGKChPpRgK+X1vpFVeiOGRxIv/yc0P5GVwocL+MsWojpomxntBXqv1JjKXo9m9HVldCQolg5XWhQgm6L4hQVQw6+0NyaUS2DHIvfP0lWpbCK4JdCSFofHNUV6cOJDeR6aIPwYitPGNmg3UN3Xt0ZHd89CcIrEMNa9VAMgm2aZvjtBRql/No2ks07MIrE+8PyeKeGNhVPnmyN1Ne/J1Do23tNppsrhO0kmoyGscP6YoTHCIWBVoLQA46DZF81UymrNPQTgs5Z9hoDB8ZpZcxwSp6CLK25aWEbms8sechdKIEO0NQe5CaxEQ==
Received: from SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 by SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 00:33:41 +0000
Received: from BN0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:e8::33)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 00:33:39 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::a) by BN0PR04CA0058.outlook.office365.com
 (2603:10b6:408:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 00:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.26 via Frontend Transport; Mon, 3 Apr 2023 00:33:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 2 Apr 2023
 17:33:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 2 Apr 2023
 17:33:36 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Sun, 2 Apr 2023 17:33:36 -0700
Date: Sun, 2 Apr 2023 17:33:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <yi.l.liu@intel.com>, <eric.auger@redhat.com>, <baolu.lu@linux.intel.com>,
	<shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
	<iommu@lists.linux.dev>
Subject: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	BN8NAM11FT114:EE_|SA1PR12MB6896:EE_|SA1PR12MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 713e2572-a408-43d9-ed1c-08db33db11ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5b6xrgfHz1huUa4ZWIKznz+Rl1hgI6Qc6e+pCPIzmMsDt8b0QaXapcWmB8Efc4LZUFXLHvPoEslVqOY6/hHq/GfNr0Q3zCfKLyv/XPM7Rb4xajGihVIm/1B9xW+lSWI0z5We8PwmoyskiaLG10jsftZNrgARfuQxN4wzMSA6u6MXXQtVkIvnRNyIi5JpaVtVDcAcABhCDQI2O9phVwU51VjrI1ARpvhGvFtnSpSblu7YoZLXR7SiZpFXHlul2xmTbmc9QbQKNSEoCCk6lLWe3nJFu36HRQQNX5z0z3ZOINnlZYZKRxPVdoAaVLgaolcxSh9GujxREr/r9WFMCe+y3h9oJAKkOO9ivOw2AYe6FjC4vHQBYq8Tx57QQ+po3Ibjl5YDtjDn8ujkgfCZeOkNkVpS9GYMjHCIZYEaWabazXB+detxcigjqd5nBvhH/3lEgMgusKiaW+j8f/0N8wkHEVmO9tpIkdSHteKKoZlcI8dvgT9vttTWw4jv187rClgmFXlQw5eUeNFuxroVZUEqsYr4+FH0GiayRko2lpGzBXiA4P4kRthfOvghoNiJkakxi2vC44c0BnU3dc8gE1sj4S48NTLAedpfgBkLclhzOmTR+b8HTmNqiWtrJINX7ppIB5dDyQmkXWlIy0pQBwMC9SWLt3vgQh3Nwr5NdA1HhLHzH7KHYQ6jpa/pfmKWZitwFkAEI6PMkz0hC0WzYf8b99Nh89vMIC348Te6++Nw93Zi+gQg1jwdNk+EJ9HL0gFKO5wp80x/jW+2SwgtdeKXu941eTEvfZwDUQwu0suUYMTaYJrdGCZVMformhMcCe/uCP3D5Qu/KdyEhb6QIaVwayNdmRbu6fPY7mOJlqaBPMJBJ461ZbtdjiVkexq1a6aVUE8o202lFi1+zHNv6hkmnw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(186003)(9686003)(40460700003)(26005)(55016003)(40480700001)(336012)(426003)(110136005)(54906003)(33716001)(478600001)(82310400005)(34020700004)(36860700001)(86362001)(70206006)(70586007)(47076005)(82740400003)(83380400001)(4326008)(8676002)(316002)(2906002)(356005)(7636003)(41300700001)(5660300002)(966005)(8936002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 00:33:39.0079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713e2572-a408-43d9-ed1c-08db33db11ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175

Hi all,

Per discussion in the nested SMMUv3 series[1], we have come up
with a couple of ideas to accelerate the invalidation uAPI.

I have drafted two solutions and would like to collect all of
your inputs, so we shall decide which approach we would choose
to put in the next version.

The first version is simply to individually forward the entire
command. This can save a few CPU cycles from packing/unpacking
invalidation fields of the commands via a data structure, v.s.
the structure in v1[2].

[User Data]
struct iommu_hwpt_invalidate_arm_smmuv3 {
	__u64 cmd[2];
	__u32 error;
	__u32 __reserved;
};

[Driver Handler]
// This draft requires set_rid/unset_rid in the 2nd draft for
// command sanity to report errors.
static void arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
					   void *user_data)
{
	struct iommu_hwpt_invalidate_arm_smmuv3 *inv_info = user_data;
	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
	struct arm_smmu_device *smmu = smmu_domain->smmu;
	u64 cmd[CMDQ_ENT_DWORDS];
 
	if (!smmu || !smmu_domain->s2 || domain->type != IOMMU_DOMAIN_NESTED)
		return;
 
	cmd[0] = inv_info->cmd[0];
	cmd[1] = inv_info->cmd[1];
	switch (cmd[0] & CMDQ_0_OP) {
	case CMDQ_OP_TLBI_NSNH_ALL:
		cmd[0] &= ~CMDQ_0_OP;
		cmd[0] |= CMDQ_OP_TLBI_NH_ALL;
		fallthrough;
	case CMDQ_OP_TLBI_NH_VA:
	case CMDQ_OP_TLBI_NH_VAA:
	case CMDQ_OP_TLBI_NH_ALL:
	case CMDQ_OP_TLBI_NH_ASID:
		cmd[0] &= ~CMDQ_TLBI_0_VMID;
		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID,
				     smmu_domain->s2->s2_cfg.vmid);
		arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, true);
		break;
	case CMDQ_OP_CFGI_CD:
	case CMDQ_OP_CFGI_CD_ALL:
		arm_smmu_sync_cd(smmu_domain,
				 FIELD_GET(CMDQ_CFGI_0_SSID, cmd[0]), false);
		break;
	default:
		return;
	}
}


The second version is a bit further to support batching, by sharing
a kernel page via mmap().

Firstly, I drafted a pair of new ioctls and iommu_ops callbacks to
link vSID with pSID. This seems to be useful for Intel VT-d also.
https://github.com/nicolinc/iommufd/commit/cbec01245edc70e5de88fbc477d8f0af50b3b0ed

Then I added a new mmap interface to share kernel page(s) from the
Driver, to allow QEMU to write all TLBI commands as a single batch.
Then it can initiate the batch invalidation via another synchronous
hypercall.
https://github.com/nicolinc/iommufd/commit/ee717eb6d46b5285db1aae9172ecdfc70b9cd9ca

The two TMP changes are available in this repo:
https://github.com/nicolinc/iommufd/commits/wip/iommufd_nesting-mmap-04022023
This solution certainly needs some rework before it can be posted
in the next version for review. Yet again, I'd like to see if it
can be a good direction for us to adopt in v2.

The new set_rid/unset_rid ioctls and the mmap interface would be
essential for VCMDQ support that we'd like to achieve at the end
of this journey. So, personally I'd like to see it can be used at
this stage, by the generic SMMUv3 (and potentially VT-d) too.

Thanks
Nicolin

[1] https://lore.kernel.org/linux-iommu/ZBe3kxRXf+VbKy+m@Asurada-Nvidia/
[2] https://lore.kernel.org/linux-iommu/364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com/
