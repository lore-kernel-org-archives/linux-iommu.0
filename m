Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027E818
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C5IWl+zt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwaQThzob69r7JYkM4jAOydpcXNLgJpJaccv/gpsiYfJg7KndFlSaosucYF2n9vdvB9ZHpwtLfYWrb2W+SNU31BpP0rFAIqWKMCY+fVRg+xEVfiMA2yw0jglxQE9aoYq+8odhzhf8FhT+OaVXmjJfAHESPhaLgSdw4ZBT65MiGb1e0HcGh5ylJO44oaaakmWBJL9abD4O5aEPMUSEweJV4CmW0barzz5sQbpG/Hx6yTLb00ODMu2GVsbK8ePyidhkrzzvw4TuuwEK6QUvm1LwW3Tb/TC7UiYlCViQnfxghRUbSl1sVQXAespy9SRRlLuem41fofdFuBoDKsrhVYoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6dWbNrR/nEF6btEMTVv1f+7dExpUXjbUUby1CvnHKw=;
 b=Jm5+K5koVDJvxdkjSse0YmFa9OeNbTElgO1r+N1DP9ncWWbATS8RFiXRcOUb0mwRL2EI+ay060VfWnE6JOj5dmPpAWhU12j5DGTKbO7Hrk9AcOshznz+7OmJPC0lJyEiqigLd5bM5DESK+Y1swMBJsKb0bRgDBVCIzgUIjFnQbGQWLpJdDdzCMfmyOej1Lhey5KfXLozGK16hjN4ektVA0j/1OEmYKvyTmevmA8qv9Qf5HZvMLCCImpOFNVwHbphGsfQCKH31fp2mMhS5flfDrQ3LnRpV67JIhlFoum48+hr3z95szW+JbdCKTPDAJAjdY9XDQ+npqO/iw/FfMw78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6dWbNrR/nEF6btEMTVv1f+7dExpUXjbUUby1CvnHKw=;
 b=C5IWl+ztR+h/E6adGi1u7KhJaFlC3LT9FYPQmLFUJa2tni/cHaAOCZZRA8hlgiykKh9Ej/SrWWJRqmWOzlLO7bTssEoS56+2FbOBY8jCEtWoGb3BUvCxe8M1JZTDsEWi8TJPP5jpqX0x/93wqJA9SETyXiA9nsuVFmE9mrtWHtrVqJT0CdYTgLtTd1h1RgiNPnJt/c68jl4QEEjUTdS/ajPsbpthOsLuOrdr4dHsnQQk+TVmkLtfF/eVofqHzFqyh9KpQ7vywHV3Ojwgaj9xfmNdKwnsxpQ1Fud7ck/3OKeHS99WMeLkQM1Rqa09wdH6vJEZx25NujI1pEISdy++7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 00:33:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:26 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent of the callers
Date: Tue, 10 Oct 2023 21:33:10 -0300
Message-ID: <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:208:d4::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc42a3f-0333-4e07-695c-08dbc9f1aec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ctZZL98KwECPB0qgWEjRu2kbMboiLP+D/aOQJn2qs4jqmz6D+sOs6IgBRPa/TSOGfxbB680TuBHNqhAN9PL1AldqMEaC97FzNn38oY6cYGXLy6HbhU2lkLSRD497Lnc9c1DL1bdb89VCG79yhXBKBo/+DM5FPlqrVqrq8IwunaAEyQMJ38r1NrS2+dcLXl9bezepIbHChwzISZX1kKe2Y7LeaL3wimW7xm3VaczTPvx3e98cj2tX/yKPs8tRL6NjAJ7yRa/xttgEUw4oCNkXaSkEeXYD7YY7oQR+eRQbSc6M2Q0XMx4IZzia2phj9kXIB0dQnLK5xq/7wYquZhyHy3oUoN2VY6sErxLogTzMdlA3DUE4CuklUgghE8EMFm+DnYVLy/Csypxifp0/dt0CZnP4Cpk9rP4nQK+yHvGUXNjin7OM/7oJzdB1tKfe1DcqrQiY5PBeq0w1lU3fUWoBtNKvsW1iXC2dNrOQyGxQThzDtWa2rJavLY1FBKWGNMfrnQror+29e0kJ5rLK5qLIFNpvw0tDcNu6uI6IWsZGv++kM62zb4f8bcdCV5PZDRe4hdGXx5CB+sudQN0EPA/5qtvqgSyG5fcGM+NDfR67Mo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(107886003)(2616005)(478600001)(26005)(6486002)(38100700002)(316002)(66556008)(66946007)(66476007)(6512007)(110136005)(6506007)(54906003)(5660300002)(83380400001)(41300700001)(8936002)(8676002)(4326008)(6666004)(36756003)(86362001)(2906002)(30864003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UKyGu54CmcvhlBK3GugdcK2odVEQbnxGePxPMYrrHfmRwY+h7STcdOB+Ei8h?=
 =?us-ascii?Q?CFy7H1t/9iqGtOgI6xZliUPs/ZyC3l7JoanNclDLFoAP5B3FNyFuwZk2ShjV?=
 =?us-ascii?Q?NEjdw68W5w9ke4OCfVHYdUo/GxL0FOqGxABHiVssGHoPewuysBPKtm/CmxGx?=
 =?us-ascii?Q?j3NcRq0DROovc2wfWndwvA5EHFnhOOOEBXBiR1VANaAC/xGjJyL2onGH3nDt?=
 =?us-ascii?Q?ETTvDcWfKeTDLnf3/+uz8/Kze1h86i4qkKDBNPjdhakcZNJRSsLgke9sEaNp?=
 =?us-ascii?Q?0+wi9YPmhG22locWDwcm/tC22fZy28MFOqehIPGNIPI+/jqC8v2N2bkwqlXx?=
 =?us-ascii?Q?nY0p7Wzt7tsLSLyiK8suyLhwddOH/sNV5BUiB97G3MgZsff7mygXJnATqly8?=
 =?us-ascii?Q?kS09ysmEm1XjRRHm/gQ8KMIyDVtJ8aheJkcSF3KSiHmaHPniZ0zMCx1vsU4C?=
 =?us-ascii?Q?0rVAcqaB+fJfuvnjWTVbS/1GcB98zhDkCO7jONza4oZcS8H8L6mZP37OurTf?=
 =?us-ascii?Q?S8EXkLXq5lIxVOG363G4bK2LCSE/4Vtjjpwarxp6dEW7uZLqpl3E6TuCGBEm?=
 =?us-ascii?Q?zA2iZANV7FwDwQulkPC17GsAD2JdOKVH7+GnLCxgTiZ6wCAVRVWXyWP35Ecu?=
 =?us-ascii?Q?X7uEyMtuOQ5mjbbkLDlPMt6nO2DWwoFLAaMB5Cd5ux0joCxuUxw2sdVRua3B?=
 =?us-ascii?Q?K074JADAMw9q4EhVU3rRkfZ/ENPyflhR64VvIsKBT3VWBM7KT2spHAst1ONA?=
 =?us-ascii?Q?BZWhlHrl85upXZ7PXkEnANdEl3C2xEbJwYoKPNb2dR6KMqDsABVCQl5WC3s6?=
 =?us-ascii?Q?hik2hD1MdsSx972pX2NqLQAHtvNIyxMElhrVOEfjPeB04DFtyCbwO5mwaGE6?=
 =?us-ascii?Q?flTh206NH96YJ437alrLdP/cVe/pMarvIe0GDZGTj9uHQh4FgOJTaSNx30Xs?=
 =?us-ascii?Q?XB4ItJ+te36OxQ5+sPEHH1n1AcP+z65kn1GOa3WPHowGjxevzlVi9ToO/nkh?=
 =?us-ascii?Q?GKwqOKCBYii67k14Wv3LW/6gXz69xA8ZcBHwQo9Blr30iFYMlfJ6JxcMef3S?=
 =?us-ascii?Q?X2cetguXZCRvcW1+BggHmEYxtQ94jf3avvGFyzrTrFN9Ek2JK92LzaQh+oPZ?=
 =?us-ascii?Q?9aqY+5/v/1Ym7EtXd35B64EPW+GYNfrdtCZiJStOWzyDufSxhttUJhmOdgn+?=
 =?us-ascii?Q?3D6a+H5SpTKWeyuohdZVouADoEcNhHdfN/omIQF7TBQz+kXB3OpTBvuS00nu?=
 =?us-ascii?Q?BesSh6o+yr4BCmEcI3C/yYRLkAcvSD5krf/44/4l3EmyV2hBl+G1qZA2zk7M?=
 =?us-ascii?Q?msXvVcJ/GOsFvNmNbW2u/tRv2ilboR77EmSf/JBqdktOslnU+seiYZS2sxYM?=
 =?us-ascii?Q?u1qXOHmyvg2SWT0jtjNQ8q3o4COkW9TgNXLdpl9F0O4YVxkyAfynAjyiJseE?=
 =?us-ascii?Q?BeCszdRakK7tI0rEeVABXHeWjQXeZp9Do+vBhjsoGJypLIESaLL8e17jh5wv?=
 =?us-ascii?Q?GuJLhNg8Hk2JSQVG5HrTXNDZVBZQNmxoMzh1gXZ9nfwKvBHluOoMnwVGZm7U?=
 =?us-ascii?Q?mt0zeYe0SwG2ZndciIFOjTw0Jl0pAt8q+RGCh2G1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc42a3f-0333-4e07-695c-08dbc9f1aec0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mdi9MjvYDU4xYLrHY1FH5pt245/QBplhfxl1frBsbDPggUX/x7FYz9wb1dIu1wGL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658

As the comment in arm_smmu_write_strtab_ent() explains, this routine has
been limited to only work correctly in certain scenarios that the caller
must ensure. Generally the caller must put the STE into ABORT or BYPASS
before attempting to program it to something else.

The next patches/series are going to start removing some of this logic
from the callers, and add more complex state combinations than currently.

Thus, consolidate all the complexity here. Callers do not have to care
about what STE transition they are doing, this function will handle
everything optimally.

Revise arm_smmu_write_strtab_ent() so it algorithmically computes the
required programming sequence to avoid creating an incoherent 'torn' STE
in the HW caches. The update algorithm follows the same design that the
driver already uses: it is safe to change bits that HW doesn't currently
use and then do a single 64 bit update, with sync's in between.

The basic idea is to express in a bitmask what bits the HW is actually
using based on the V and CFG bits. Based on that mask we know what STE
changes are safe and which are disruptive. We can count how many 64 bit
QWORDS need a disruptive update and know if a step with V=0 is required.

This gives two basic flows through the algorithm.

If only a single 64 bit quantity needs disruptive replacement:
 - Write the target value into all currently unused bits
 - Write the single 64 bit quantity
 - Zero the remaining different bits

If multiple 64 bit quantities need disruptive replacement then do:
 - Write V=0 to QWORD 0
 - Write the entire STE except QWORD 0
 - Write QWORD 0

With HW flushes at each step, that can be skipped if the STE didn't change
in that step.

At this point it generates the same sequence of updates as the current
code, except that zeroing the VMID on entry to BYPASS/ABORT will do an
extra sync (this seems to be an existing bug).

Going forward this will use a V=0 transition instead of cycling through
ABORT if a hitfull change is required. This seems more appropriate as ABORT
will fail DMAs without any logging, but dropping a DMA due to transient
V=0 is probably signaling a bug, so the C_BAD_STE is valuable.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 247 +++++++++++++++-----
 1 file changed, 183 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bf7218adbc2822..6e6b1ebb5ac0ef 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -971,6 +971,69 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
+/*
+ * Do one step along the coherent update algorithm. Each step either changes
+ * only bits that the HW isn't using or entirely changes 1 qword. It may take
+ * several iterations of this routine to make the full change.
+ */
+static bool arm_smmu_write_entry_step(__le64 *cur, const __le64 *cur_used,
+				      const __le64 *target,
+				      const __le64 *target_used, __le64 *step,
+				      __le64 v_bit,
+				      unsigned int len)
+{
+	u8 step_used_diff = 0;
+	u8 step_change = 0;
+	unsigned int i;
+
+	/*
+	 * Compute a step that has all the bits currently unused by HW set to
+	 * their target values.
+	 */
+	for (i = 0; i != len; i++) {
+		step[i] = (cur[i] & cur_used[i]) | (target[i] & ~cur_used[i]);
+		if (cur[i] != step[i])
+			step_change |= 1 << i;
+		/*
+		 * Each bit indicates if the step is incorrect compared to the
+		 * target, considering only the used bits in the target
+		 */
+		if ((step[i] & target_used[i]) != (target[i] & target_used[i]))
+			step_used_diff |= 1 << i;
+	}
+
+	if (hweight8(step_used_diff) > 1) {
+		/*
+		 * More than 1 qword is mismatched, this cannot be done without
+		 * a break. Clear the V bit and go again.
+		 */
+		step[0] &= ~v_bit;
+	} else if (!step_change && step_used_diff) {
+		/*
+		 * Have exactly one critical qword, all the other qwords are set
+		 * correctly, so we can set this qword now.
+		 */
+		i = ffs(step_used_diff) - 1;
+		step[i] = target[i];
+	} else if (!step_change) {
+		/* cur == target, so all done */
+		if (memcmp(cur, target, sizeof(*cur)) == 0)
+			return true;
+
+		/*
+		 * All the used HW bits match, but unused bits are different.
+		 * Set them as well. Technically this isn't necessary but it
+		 * brings the entry to the full target state, so if there are
+		 * bugs in the mask calculation this will obscure them.
+		 */
+		memcpy(step, target, len * sizeof(*step));
+	}
+
+	for (i = 0; i != len; i++)
+		WRITE_ONCE(cur[i], step[i]);
+	return false;
+}
+
 static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 			     int ssid, bool leaf)
 {
@@ -1248,37 +1311,122 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
+/*
+ * Based on the value of ent report which bits of the STE the HW will access. It
+ * would be nice if this was complete according to the spec, but minimally it
+ * has to capture the bits this driver uses.
+ */
+static void arm_smmu_get_ste_used(const struct arm_smmu_ste *ent,
+				  struct arm_smmu_ste *used_bits)
+{
+	memset(used_bits, 0, sizeof(*used_bits));
+
+	used_bits->data[0] = cpu_to_le64(STRTAB_STE_0_V);
+	if (!(ent->data[0] & cpu_to_le64(STRTAB_STE_0_V)))
+		return;
+
+	used_bits->data[0] |= cpu_to_le64(STRTAB_STE_0_CFG);
+	switch (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(ent->data[0]))) {
+	case STRTAB_STE_0_CFG_ABORT:
+		break;
+	case STRTAB_STE_0_CFG_BYPASS:
+		used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_SHCFG);
+		break;
+	case STRTAB_STE_0_CFG_S1_TRANS:
+		used_bits->data[0] |= cpu_to_le64(STRTAB_STE_0_S1FMT |
+						  STRTAB_STE_0_S1CTXPTR_MASK |
+						  STRTAB_STE_0_S1CDMAX);
+		used_bits->data[1] |=
+			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
+				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
+				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW);
+		used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
+
+		if (FIELD_GET(STRTAB_STE_1_S1DSS, le64_to_cpu(ent->data[1])) ==
+		    STRTAB_STE_1_S1DSS_BYPASS)
+			used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_SHCFG);
+		break;
+	case STRTAB_STE_0_CFG_S2_TRANS:
+		used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
+		used_bits->data[2] |=
+			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
+				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
+				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2R);
+		used_bits->data[3] |= cpu_to_le64(STRTAB_STE_3_S2TTB_MASK);
+		break;
+
+	default:
+		memset(used_bits, 0xFF, sizeof(*used_bits));
+	}
+}
+
+static bool arm_smmu_write_ste_step(struct arm_smmu_ste *cur,
+				    const struct arm_smmu_ste *target,
+				    const struct arm_smmu_ste *target_used)
+{
+	struct arm_smmu_ste cur_used;
+	struct arm_smmu_ste step;
+
+	arm_smmu_get_ste_used(cur, &cur_used);
+	return arm_smmu_write_entry_step(cur->data, cur_used.data, target->data,
+					 target_used->data, step.data,
+					 cpu_to_le64(STRTAB_STE_0_V),
+					 ARRAY_SIZE(cur->data));
+}
+
+/*
+ * This algorithm updates any STE to any value without creating a situation
+ * where the HW can percieve a corrupted STE. HW is only required to have a 64
+ * bit atomicity with stores.
+ *
+ * In the most general case we can make any update by disrupting the STE (making
+ * it abort, or clearing the V bit) using a single qword store. Then all the
+ * other qwords can be written safely, and finally the full STE written.
+ *
+ * However this disrupts the HW while it is happening. There are several
+ * interesting cases where a STE can be updated without disturbing the HW
+ * because only a small number of bits are changing (S1DSS, CONFIG, etc) or
+ * because the used bits don't intersect.
+ */
+static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
+			       struct arm_smmu_ste *ste,
+			       const struct arm_smmu_ste *target)
+{
+	struct arm_smmu_ste target_used;
+	int i;
+
+	arm_smmu_get_ste_used(target, &target_used);
+	/* Masks in arm_smmu_get_ste_used() are up to date */
+	for (i = 0; i != ARRAY_SIZE(target->data); i++)
+		WARN_ON_ONCE(target->data[i] & ~target_used.data[i]);
+
+	while (true) {
+		if (arm_smmu_write_ste_step(ste, target, &target_used))
+			break;
+		arm_smmu_sync_ste_for_sid(smmu, sid);
+	}
+
+	/* It's likely that we'll want to use the new STE soon */
+	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH)) {
+		struct arm_smmu_cmdq_ent
+			prefetch_cmd = { .opcode = CMDQ_OP_PREFETCH_CFG,
+					 .prefetch = {
+						 .sid = sid,
+					 } };
+
+		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
+	}
+}
+
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				      struct arm_smmu_ste *dst)
 {
-	/*
-	 * This is hideously complicated, but we only really care about
-	 * three cases at the moment:
-	 *
-	 * 1. Invalid (all zero) -> bypass/fault (init)
-	 * 2. Bypass/fault -> translation/bypass (attach)
-	 * 3. Translation/bypass -> bypass/fault (detach)
-	 *
-	 * Given that we can't update the STE atomically and the SMMU
-	 * doesn't read the thing in a defined order, that leaves us
-	 * with the following maintenance requirements:
-	 *
-	 * 1. Update Config, return (init time STEs aren't live)
-	 * 2. Write everything apart from dword 0, sync, write dword 0, sync
-	 * 3. Update Config, sync
-	 */
-	u64 val = le64_to_cpu(dst->data[0]);
-	bool ste_live = false;
+	u64 val;
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
 	struct arm_smmu_s2_cfg *s2_cfg = NULL;
 	struct arm_smmu_domain *smmu_domain = master->domain;
-	struct arm_smmu_cmdq_ent prefetch_cmd = {
-		.opcode		= CMDQ_OP_PREFETCH_CFG,
-		.prefetch	= {
-			.sid	= sid,
-		},
-	};
+	struct arm_smmu_ste target = {};
 
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
@@ -1293,22 +1441,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		}
 	}
 
-	if (val & STRTAB_STE_0_V) {
-		switch (FIELD_GET(STRTAB_STE_0_CFG, val)) {
-		case STRTAB_STE_0_CFG_BYPASS:
-			break;
-		case STRTAB_STE_0_CFG_S1_TRANS:
-		case STRTAB_STE_0_CFG_S2_TRANS:
-			ste_live = true;
-			break;
-		case STRTAB_STE_0_CFG_ABORT:
-			BUG_ON(!disable_bypass);
-			break;
-		default:
-			BUG(); /* STE corruption */
-		}
-	}
-
 	/* Nuke the existing STE_0 value, as we're going to rewrite it */
 	val = STRTAB_STE_0_V;
 
@@ -1319,16 +1451,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		else
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
 
-		dst->data[0] = cpu_to_le64(val);
-		dst->data[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
+		target.data[0] = cpu_to_le64(val);
+		target.data[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
 						STRTAB_STE_1_SHCFG_INCOMING));
-		dst->data[2] = 0; /* Nuke the VMID */
-		/*
-		 * The SMMU can perform negative caching, so we must sync
-		 * the STE regardless of whether the old value was live.
-		 */
-		if (smmu)
-			arm_smmu_sync_ste_for_sid(smmu, sid);
+		target.data[2] = 0; /* Nuke the VMID */
+		arm_smmu_write_ste(smmu, sid, dst, &target);
 		return;
 	}
 
@@ -1336,8 +1463,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
 			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
 
-		BUG_ON(ste_live);
-		dst->data[1] = cpu_to_le64(
+		target.data[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
@@ -1346,7 +1472,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		    !master->stall_enabled)
-			dst->data[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
+			target.data[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
@@ -1355,8 +1481,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	}
 
 	if (s2_cfg) {
-		BUG_ON(ste_live);
-		dst->data[2] = cpu_to_le64(
+		target.data[2] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
 			 FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
 #ifdef __BIG_ENDIAN
@@ -1365,23 +1490,17 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			 STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
 			 STRTAB_STE_2_S2R);
 
-		dst->data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
+		target.data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
 
 		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
 	}
 
 	if (master->ats_enabled)
-		dst->data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
+		target.data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
 						 STRTAB_STE_1_EATS_TRANS));
 
-	arm_smmu_sync_ste_for_sid(smmu, sid);
-	/* See comment in arm_smmu_write_ctx_desc() */
-	WRITE_ONCE(dst->data[0], cpu_to_le64(val));
-	arm_smmu_sync_ste_for_sid(smmu, sid);
-
-	/* It's likely that we'll want to use the new STE soon */
-	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH))
-		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
+	target.data[0] = cpu_to_le64(val);
+	arm_smmu_write_ste(smmu, sid, dst, &target);
 }
 
 static void arm_smmu_init_bypass_stes(struct arm_smmu_ste *strtab,
-- 
2.42.0

