Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71A224FD
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RHiZRAIr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaVLi4hQ+Y3lN/eH8skJ+ut/jjiLP8a+bNJ04Fx/8DCs17RuOVmhTnXAkcaopZotftDjT0zSzBTJVnR5do59dPgNtlv7U1mH1mKUscecrItQzka3mHmOU8in3yU+aW8vmMldEqLnoi82UjJnjhEF8im4e5Vuv9uigiyYwNU7MzC4Uo1eNP5Hv6FBZdP5aAgGAx9QKu4s0eXjhBOJ+mUxXp0p6HVXRx8U/Ufkim7VivrQINglx72yb2PSvwHky5OjAUoDMy1hePEV60tTBmkixoEx3MtvrwCo5yD6KCggiHISIrSiIwKrz4GmuMqGvv0Muq1EHjSx4D/rNBtTST06kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOwAMQ/obnhGFvMT58apBOcxmS6qezpUCxgtrJspcSY=;
 b=WbRFxDKrmojRUUBQzWCdvyNUNqV1JpOzAAtiGibhc5DY3JTM3OAKqqPSa7qmOvy8WNK1AoKorB+SritWOzZKCdKQyhgNQxW5JAFKIwUsELGbGfrmrcF4qOpKqth5p5w/sXnnjp1d81uc2tpuhbcBPYlWO0JVZkffFEUuldQxHecUhmdDW2CCqf62YtunAJ7DlYCSKm1fdU+klJs4WeekziY/DjEW16q9+z36r075++7mW7bMp+zKSxPeC2d/L+lgI/bSO1LwC5sZjt0dJmKCJYewZC+HV2U4okcgQy5mdfm63nS+v0EhT4njBvBMx4f04jYO8jkAAColFl5BQ+PGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOwAMQ/obnhGFvMT58apBOcxmS6qezpUCxgtrJspcSY=;
 b=RHiZRAIrnf11sXlWGxO7KTN4BQ6L5NmaXsh6NQ7DPScayiyVKB1g7P/rlIX+EC1ADiEtX+NOuvD3RXDzSNGGEtOq7p5UmtbGBhdDvoUn9/gYSNCH+DgUpE4z4eiQkhhqbrAZ0YWX7oo42yBdE98LoSIvLONU4tJONyzz2CHeK/WNHsLI10UDDaken2N5tGnDWV4kZWICtfeX+ASWPCFwTGeMY/yjIhYb3bni3tpAkHNLqDvBdTXIxQub4jEeeB05AR9ACNu8UQmoiChEpmzQ+9riPV1P7tYS+T88SageJpEx7GpU/nYoBrO5yyEdvQRRmXpQjU/KTiH7gkRHiQ+xVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:33 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 04/19] iommu/arm-smmu-v3: Make STE programming independent of the callers
Date: Mon, 13 Nov 2023 13:53:11 -0400
Message-ID: <4-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0039.prod.exchangelabs.com
 (2603:10b6:208:25::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: a802dc8b-8350-4071-b536-08dbe4717080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pvk+iQvfR/E228uy0mOPLBAZBwP66TQb5CqhLlf5cVwHLrvzyrkyMtdPQzsLEMJG6n/KA4pi6BpKfxMhMTtNCG5eGfz7ndHLJ6/1bF/K97nMc6Bzxghhm90oqw9NDf0boAkS/B0a9z+Y9MmLluoUrLw9zpPjf1y0efg8ooAqP0qgZMUKhEX9f4nCsg8T1H12VPyF2ZG4U2hztZHXsPfuN9ZqZIundX6nk+P6C8nkBLS3agP+/ZHSCcVNdR7x635NzVTTtZNh8xlyve9LfiJcRQilKVSDGuMMbuBe4kCXefSPiS6B5lOX8QTeImeYgD0/aoyiRofaM4SfVRpeLhLgP3D5wsQ9WoPGml52B/IIrd8xH5vm6VA8TcYrWMIzEc2fEoFPM2pO6+tg98mFSZLx5pjZ5RFNO39xarU4NSIQSWbPTjYxgogd//CzO23fu14qn5aEUVP88I48aFG3+n7u69DzXdJ24cXpweWxoOPnfVpPKbr7uKICjPUpDgKCNdU9zWqSlksTz9vrckiOXpGMmV24bu0Bj/UVlsObOgPXyMpQ2cEfnpE1tKmuDL7+IGIIe1hqrnQEZbG+oqk9X78A1YAdhuBX/ax53nAGOmewoE8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(30864003)(2906002)(83380400001)(86362001)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sjfEK5t0gOlpHjsH5jwAhXy06/qiD27WtyJvLpo6+OzD2FJAr0WBJE31jGaG?=
 =?us-ascii?Q?vZ/WjOwf0cFymF4o55I0FC3kfcxZNtBjYvAR/1Jd6yMLAJiXA7UHyot2alJq?=
 =?us-ascii?Q?PgsUKx9e/13xapuJjSKD1qJMIF4vBDnH382RTKKMfcnoPMEuWFDrySyELDnJ?=
 =?us-ascii?Q?vZZ8jhafRjym74trHhZBGnvoR8TBCqhrAAZgLny///ktU5zkDcBgtNuNjwdK?=
 =?us-ascii?Q?YYChwAtdKf2C7kTZXY5Ah/Ee9hl0PdI4ZRbXc36VIkyWv5rPDU57PB9TgCAq?=
 =?us-ascii?Q?gY+9VDjelSHaxK9APAXTgJ4oyl+/LitOA+fCzxtUjGCTjTCm/uDCxktmk6Y4?=
 =?us-ascii?Q?48UX07y+6qcEI7Hf7/rz79C6oCUFeUWKfNMAyRhYp8nTQx7aiXPmEGJ4atm0?=
 =?us-ascii?Q?3LpRqePu9d9AH3ORYN8Dp3a/eX42pNkO7gAq6jkhRjsCX+ZBS23mkNEW9eQC?=
 =?us-ascii?Q?Ct4jWUSqyN0bzxmmhC/6idFJsRc33KtQhQgiihf4c3pBcsJ03s2lNcWsJggV?=
 =?us-ascii?Q?s3lMzqHL60npWRHBeg932xtRF30tpfB9OYz4BnKIvAHy8YhfwuIiq1QFwG3/?=
 =?us-ascii?Q?hYY0ETmt+5tg2TAIPlwonkxZZgUWSOw0FkZ9UDO25OHvQ9vBC/WhlIHCa6wl?=
 =?us-ascii?Q?8ppnveCndG5kqjay7pkG2udEIlTri53YOlDITs6JY9d/1eYBuOtJooJJWWUU?=
 =?us-ascii?Q?Tzlol2Nk6BAxA6wPMQzgTgxJjW/eblBakiZdkoPIUbPmHgurkzsVYjf5t7+0?=
 =?us-ascii?Q?B4H/eVNbpRga2hzLxn1vN1TJA0pVv0qrQR0dRH9Okc5WZDDVWdywaPcL/syw?=
 =?us-ascii?Q?JcOvwNiJNJ0+w03wwp4ZO/10k4oXkeaqxJKWncL7xigzLCHN7gSd5JZFZRjQ?=
 =?us-ascii?Q?g6KXfTzqSVppI1BhrYPnmEiPn6VOOvzqe2Qq9g2PV1edW/pZJaDzknatylRV?=
 =?us-ascii?Q?M7gmQtv2/D8Wvja4YDffYxZjgWeFeqj6UEost4l+RpefyCkY/DKuqayVkyA/?=
 =?us-ascii?Q?araGp2g1FydNYTLYt7pWlaeCjq/0hdW9c31FaevZxYTuw/eFfBV+YbbcAepr?=
 =?us-ascii?Q?mU4vxtLXivfgONCKUDT86ABWblASnSAHT3G394YTuR97P1ntSTDNH2Vd9mGC?=
 =?us-ascii?Q?vvXZrDShGJLXyIJW6xNBnOmtKGcTT20eGE5rYFXarPSAhMhYWRTpzMp4ISMi?=
 =?us-ascii?Q?C90xEKMT4rzkEI2eJnWpax19dBQsicOe1Ng4DF35yRu8FprgoxkjDAgQv42N?=
 =?us-ascii?Q?vL5/Lpvdlvdw+29tP1MKKzL7CbCqjsF2DpbiPqrhCkXz/SN0xMFG4MUOjaAh?=
 =?us-ascii?Q?30Op11ls2ZWrEDbYY+Fg7omPjs81OVKZZ3uFcM6maHgiJB5FFlei7pBnlohq?=
 =?us-ascii?Q?IsCMocgfmMZHPiZbLT2s5TxLU8q71bW+HAi4A7GT5gYcrBJxUV009NfeddYn?=
 =?us-ascii?Q?LF36d1I4QtN62iJzA9gUCB4zytumcUOC/1cdq4z9bqdZaLCbeow2kDeET19r?=
 =?us-ascii?Q?rWesuIjW/TzUR1xuaHi5w7VD9wkG540zZwNBUGe2ezpZDFbdvfL3/wxaYnvV?=
 =?us-ascii?Q?5QDjKie2g7Q4TrxDXAw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a802dc8b-8350-4071-b536-08dbe4717080
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:27.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9u5BcbOmevppoejKWsIdfVZ6aUdFuRKyPEvEs33lncvDO/6u9m9lJuZ75d4qiSx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 272 +++++++++++++++-----
 1 file changed, 208 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bf7218adbc2822..6430a8d89cb471 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -971,6 +971,101 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
+/*
+ * This algorithm updates any STE/CD to any value without creating a situation
+ * where the HW can percieve a corrupted entry. HW is only required to have a 64
+ * bit atomicity with stores from the CPU, while entries are many 64 bit values
+ * big.
+ *
+ * The algorithm works by evolving the entry toward the target in a series of
+ * steps. Each step synchronizes with the HW so that the HW can not see an entry
+ * torn across two steps. Upon each call cur/cur_used reflect the current
+ * synchronized value seen by the HW.
+ *
+ * During each step the HW can observe a torn entry that has any combination of
+ * the step's old/new 64 bit words. The algorithm objective is for the HW
+ * behavior to always be one of current behavior, V=0, or new behavior, during
+ * each step, and across all steps.
+ *
+ * At each step one of three actions is chosen to evolve cur to target:
+ *  - Update all unused bits with their target values.
+ *    This relies on the IGNORED behavior described in the specification
+ *  - Update a single 64-bit value
+ *  - Update all unused bits and set V=0
+ *
+ * The last two actions will cause cur_used to change, which will then allow the
+ * first action on the next step.
+ *
+ * In the most general case we can make any update in three steps:
+ *  - Disrupting the entry (V=0)
+ *  - Fill now unused bits, all bits except V
+ *  - Make valid (V=1), single 64 bit store
+ *
+ * However this disrupts the HW while it is happening. There are several
+ * interesting cases where a STE/CD can be updated without disturbing the HW
+ * because only a small number of bits are changing (S1DSS, CONFIG, etc) or
+ * because the used bits don't intersect. We can detect this by calculating how
+ * many 64 bit values need update after adjusting the unused bits and skip the
+ * V=0 process.
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
+		if (memcmp(cur, target, len * sizeof(*cur)) == 0)
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
@@ -1248,37 +1343,115 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
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
+	/*
+	 * If S1 is enabled S1DSS is valid, see 13.5 Summary of
+	 * attribute/permission configuration fields for the SHCFG behavior.
+	 */
+	if (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(ent->data[0])) & 1 &&
+	    FIELD_GET(STRTAB_STE_1_S1DSS, le64_to_cpu(ent->data[1])) ==
+		    STRTAB_STE_1_S1DSS_BYPASS)
+		used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_SHCFG);
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
+		break;
+	case STRTAB_STE_0_CFG_S2_TRANS:
+		used_bits->data[1] |=
+			cpu_to_le64(STRTAB_STE_1_EATS | STRTAB_STE_1_SHCFG);
+		used_bits->data[2] |=
+			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
+				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
+				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2R);
+		used_bits->data[3] |= cpu_to_le64(STRTAB_STE_3_S2TTB_MASK);
+		break;
+
+	default:
+		memset(used_bits, 0xFF, sizeof(*used_bits));
+		WARN_ON(true);
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
@@ -1293,22 +1466,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
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
 
@@ -1319,16 +1476,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
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
 
@@ -1336,8 +1488,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
 			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
 
-		BUG_ON(ste_live);
-		dst->data[1] = cpu_to_le64(
+		target.data[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
@@ -1346,7 +1497,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		    !master->stall_enabled)
-			dst->data[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
+			target.data[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
@@ -1355,8 +1506,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	}
 
 	if (s2_cfg) {
-		BUG_ON(ste_live);
-		dst->data[2] = cpu_to_le64(
+		target.data[2] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
 			 FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
 #ifdef __BIG_ENDIAN
@@ -1365,23 +1515,17 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
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

