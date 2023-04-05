Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863C637
	for <iommu@lists.linux.dev>; Wed,  5 Apr 2023 05:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4YmufNLMNAdf7dKpJbtJhKuWqcjjW3WUwuOcDTWCDvGHu+bfZaHbwrxbQxQjMbW7jp6u0Md81PYxN4KWVDtYrY0J29Pj2yobiA0tAtGmJsyyFPlQQyrq5jqzXGlAP8Mec4V1n7ynJIis+Dm+jfPKeCy/jIZ3Os78SFN7OfIvyuS6ZzisRAwfKahTWqfWmjcw3rk7/yLIZ0aZJR8W+7dr1lRdx2xNs7yv3pNQe8MW1HfOjqv48S51fPO78gIzfj10OjZPsz9f19TLDAWVI3ot3S9heltLe8l08Sph5DBbyXMNakq+BKVkB0J0/opCMkZodny/9SoluCmqpxYfe+Czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kilYkHFqKDRemFNNmwFxKpFnOp0aBgd9oGg7Mu1hVTs=;
 b=URHfwpTD+6hhkKG0sEWf1GmrRXPd+VcwScmUAdyzrOpIzUhCXMD45V2U8EKZhQTJcL88Rqf5v7VadRSQUGD45M4RkUJNe/alfWFqrXk4g7Kxa5ZLBcHaL3bH4H78HSt/uCneN+s1Kpw/3HYexV9gdsT4LuUCY5p1vvGSmS5gB+u0Hlyj4+yY7Pi0b8HSq8jUkRZIfLeYGeF3yKDAQmQG8vkNW/E3u9LCDkHIyyk3u3FAok30of0JU8tIPIF8/Wwo2lTHyiHRD9UhMK6ixKZYeVQ7/QNpZqSfUIAEaQEn21hm2v4SuHM+o/tqFYYldgHTR3B75Bm64bdfkz/qHqLVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kilYkHFqKDRemFNNmwFxKpFnOp0aBgd9oGg7Mu1hVTs=;
 b=i66ZIp8+OedPz9UaqewlWJc5b3grTX6X2udrh1UFBfAwaxM3tc93HxfUIZwJ2P7GMdlfKUceLtJ3iM/JYdNeOreyJ6g+5A4kK4BlUIjPMj4Ah1VFA9iROyOdNLjgp1ZXbNR6ETL3VknVMPA2xnONkWNuoHohVD1+z8HAJTil8OiDTMYByoAejELHdGew7Ylc1PeXmKZ1CVEYxsrM6sqlvdL2Gi7w2i58qcYOwTiGyZ8PZhX/GKOeGMfvRgZehCKEBBpfJNQF7XP94cs7D/3DYRLegdfmjZ1AojAt0PB98cY0TOZSxULksmPg3M2RflaEyS4cMqx+WGNPG2JBUrG7DA==
Received: from CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 05:46:11 +0000
Received: from MW4PR04CA0033.namprd04.prod.outlook.com (2603:10b6:303:6a::8)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 05:46:10 +0000
Received: from CO1PEPF00001A61.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::9c) by MW4PR04CA0033.outlook.office365.com
 (2603:10b6:303:6a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Wed, 5 Apr 2023 05:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00001A61.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Wed, 5 Apr 2023 05:46:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 4 Apr 2023
 22:45:58 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 4 Apr 2023 22:45:58 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 4 Apr 2023 22:45:57 -0700
Date: Tue, 4 Apr 2023 22:45:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <baolu.lu@linux.intel.com>,
	<shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
	<iommu@lists.linux.dev>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZC0LFM9hxF9wY76w@Asurada-Nvidia>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCxOMSvR+6rYbIfy@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CO1PEPF00001A61:EE_|CYYPR12MB8731:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfe9622-9a4d-4cdd-570f-08db35990e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r+Z5shZzg1Jq8HXvG6LOvq+p3e5xbefNkvVz+IeoTmCC8HinaynLSxFRGcvQsi/CdwbHxjRoYunyycbPmYbCGDNcUEqtox03WNRo09rATlyV3I3d7E0x1JPZWPuIXDIJcyE6izMNjwIyrGQjuWxlY7Bk7IpWI1HIgTLGBR+m4ku+IiM7E8FnWe3esD8wV/g7k63Gj+SMW0PgOfbICZ8ty56S7JT6MwKVjL1JV4GhgaKDN5lElBJgKshK2XOwsdQl+u9zE6h76+DVLmYoQeim5Cj8cfSVIdyOdXYZbyZNVJXXiXnO6KySRe9xSsL3qlSxx0PY1XHxKDu+c7n/MijbmFL+2gkexm97jDpCaF6idP3uiFmz39MwC1u3uJxlqHh/tcWShfwjxmIcshnITFvbkzoc1LEfUM1EY/oLpp8TrN38AKG1QlJSszLGjZ59/h17549rIQdV7BYkb/o/vS3L2TAVWeQbLQKcEkjadBbhzBMe6yGPOXF+nQ6Sustx7+ZHdlJO+k+vlwVrWh/v1bjGFgkoVCEZhj6yQqEXQt8HI2Xoonhcrv0svRJmvqfh8kL9yKFPGYGeMzbmdrUcGy7UKbC33DR4KDsd//1ghq1tNc9Y13BQIdXFNfuNaE1rsJslHFkKABqbxGV08BjUMJJo/2KW0j1WFSMPhJEQl5aPIDIdoCGsJGPhK84Lz1iQ5Yh5D+bHht1WHVutIO817P0waHt4Ekq4cC0sVKK2sXSKfKQdRJ+NX/CXPfZT588UuTJ/
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(6862004)(55016003)(40480700001)(7636003)(4326008)(36860700001)(40460700003)(478600001)(316002)(70586007)(8676002)(70206006)(82740400003)(6636002)(8936002)(54906003)(356005)(41300700001)(5660300002)(426003)(186003)(47076005)(336012)(9686003)(83380400001)(26005)(86362001)(33716001)(2906002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 05:46:08.9320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfe9622-9a4d-4cdd-570f-08db35990e5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00001A61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962

On Tue, Apr 04, 2023 at 01:20:01PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 03, 2023 at 05:02:09PM -0700, Nicolin Chen wrote:
> 
> > My preference is to have a mmap'd page, so the interface can
> > be reused later by VCMDQ too. Performance-wise, it should be
> > good enough, since it does batching, IMHO.
> 
> You can't reuse mmaping the queue page with vcmdq, so it doesn't seem
> meaningful to me.
> 
> There should be no mmap on the SW path. If you need a half step
> between an ioctl as a batch and a full vhost-like queue scheme then
> using iouring with pre-registered memory would be appropriate.

I've changed to a non-mmap approach that the host kernel reads
the guest queue directly and inserts all invalidation commands
into the host queue.

The qsz could be as large as 128 x 64K pages. So, there has to
be a big array of pages getting pinned in the handler.

(The handler still needs a pathway to report errors. I will add
 tomorrow.)

Does the implementation below look fine in general?

Thanks
Nicolin

[User Data]
/**
 * struct iommu_hwpt_invalidate_arm_smmuv3 - ARM SMMUv3 cahce invalidation info
 * @cmdq_base: User space base virtual address of user command queue
 * @cmdq_entry_size: Entry size of user command queue
 * @cmdq_log2size: User command queue size as log 2 (entries)
 *                 Refer to LOG2SIZE field of SMMU_CMDQ_BASE register
 * @cmdq_prod: Producer index of user command queue
 * @cmdq_cons: Consumer index of user command queue
 */
struct iommu_hwpt_invalidate_arm_smmuv3 {
	__u64 cmdq_base;
	__u32 cmdq_entry_size;
	__u32 cmdq_log2size;
	__u32 cmdq_prod;
	__u32 cmdq_cons;
};

[Host Handler]
static int arm_smmu_fix_user_cmd(struct arm_smmu_domain *smmu_domain, u64 *cmd)
{
	struct arm_smmu_stream *stream;

	switch (*cmd & CMDQ_0_OP) {
	case CMDQ_OP_TLBI_NSNH_ALL:
		*cmd &= ~CMDQ_0_OP;
		*cmd |= CMDQ_OP_TLBI_NH_ALL;
		fallthrough;
	case CMDQ_OP_TLBI_NH_VA:
	case CMDQ_OP_TLBI_NH_VAA:
	case CMDQ_OP_TLBI_NH_ALL:
	case CMDQ_OP_TLBI_NH_ASID:
		*cmd &= ~CMDQ_TLBI_0_VMID;
		*cmd |= FIELD_PREP(CMDQ_TLBI_0_VMID,
				   smmu_domain->s2->s2_cfg.vmid);
		break;
	case CMDQ_OP_ATC_INV:
	case CMDQ_OP_CFGI_CD:
	case CMDQ_OP_CFGI_CD_ALL:
		xa_lock(&smmu_domain->smmu->user_streams);
		stream = xa_load(&smmu_domain->smmu->user_streams,
				 FIELD_GET(CMDQ_CFGI_0_SID, *cmd));
		xa_unlock(&smmu_domain->smmu->user_streams);
		if (!stream)
			return -ENODEV;
		*cmd &= ~CMDQ_CFGI_0_SID;
		*cmd |= FIELD_PREP(CMDQ_CFGI_0_SID, stream->id);
		break;
	default:
		return -EOPNOTSUPP;
	}
	pr_debug("Fixed user CMD: %016llx : %016llx\n", cmd[1], cmd[0]);

	return 0;
}

static void arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
					   void *user_data)
{
	const u32 cons_err = FIELD_PREP(CMDQ_CONS_ERR, CMDQ_ERR_CERROR_ILL_IDX);
	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
	struct iommu_hwpt_invalidate_arm_smmuv3 *inv = user_data;
	struct arm_smmu_device *smmu = smmu_domain->smmu;
	struct arm_smmu_queue q = {
		.llq = {
			.prod = inv->cmdq_prod,
			.cons = inv->cmdq_cons,
			.max_n_shift = inv->cmdq_log2size,
		},
		.ent_dwords = inv->cmdq_entry_size / sizeof(u64),
	};
	int ncmds = inv->cmdq_prod - inv->cmdq_cons;
	unsigned int nents = 1 << q.llq.max_n_shift;
	size_t qsz = nents * inv->cmdq_entry_size;
	unsigned long npages = qsz >> PAGE_SHIFT;
	struct page **pages;
	long pinned;
	u64 *cmds;
	int i = 0;
	int ret;

	if (!smmu || !smmu_domain->s2 || domain->type != IOMMU_DOMAIN_NESTED)
		return;
	if (WARN_ON(q.ent_dwords != CMDQ_ENT_DWORDS))
		return;
	if (WARN_ON(queue_empty(&q.llq)))
		return;
	WARN_ON(q.llq.max_n_shift > smmu->cmdq.q.llq.max_n_shift);

	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
	if (!pages)
		return;

	if (ncmds <= 0)
		ncmds += nents;
	cmds = kcalloc(ncmds, inv->cmdq_entry_size, GFP_KERNEL);
	if (!cmds)
		goto out_free_pages;

	pinned = get_user_pages(inv->cmdq_base, npages, FOLL_GET, pages, NULL);
	if (pinned != npages)
		goto out_put_page;
	q.base = page_to_virt(pages[0]) + (inv->cmdq_base & (PAGE_SIZE - 1));

	do {
		u64 *cmd = &cmds[i * CMDQ_ENT_DWORDS];

		queue_read(cmd, Q_ENT(&q, q.llq.cons), q.ent_dwords);
		ret = arm_smmu_fix_user_cmd(smmu_domain, cmd);
		if (ret && ret != -EOPNOTSUPP) {
			q.llq.cons |= cons_err;
			goto out_put_page;
		}
		if (!ret)
			i++;
		queue_inc_cons(&q.llq);
	} while (!queue_empty(&q.llq));

	ret = arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, true);
	/* FIXME return CMD_SYNC timeout */
out_put_page:
	for (i = 0; i < pinned; i++)
		put_page(pages[i]);
	kfree(cmds);
out_free_pages:
	kfree(pages);
	inv->cmdq_cons = q.llq.cons;
}
