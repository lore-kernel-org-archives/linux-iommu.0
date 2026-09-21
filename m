Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380142F709
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994092; cv=fail; b=GmkSLEIErRc5Z2RSFKKpGrkmfdnhNt8RKGa+16WE77s/VvoVaORAvp+n2lX4VLPlGOwaMbFPkXrlLITR30Brczluv8mOGYu0djMejwY4G8d2ERq2nfVKkQrGC1Yq9DycXooCj8jptZDbMUjHcehjPOjO9fQkvAu0NbA0mCqR8S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994092; c=relaxed/simple;
	bh=nak7FVAxN8cQOLQ+DAJJzpH8R+4Ob2v4U3C3bNtEdBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B/VlZC+V76BUjIloYceEroJjIbEsG+/GV7SWD0maeoPcFqh7ATyh7sJ+RpkWizmq34m0xDasmvTyrKGiNl+oQdkwNrzsVEzqqgZQ7UqqzI5/WeNRTiFuyMS00fEWWdqZuLruTDKw3KpgoRTjqPhd7xFlEErycHlepCJK1AOFqFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qsaGG1lP; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qsaGG1lP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVmdju4Xad4hpu17IQLC3znT9DRbGN3jDVz+64mJIa9K+1cYQ8RW9aMr5pFBvlTGKzlJIsn6wOqxLDPyUQV+GNzoqrkQp8ekMMcE8V1BbZpJuHuq3hx63nusn+BTMkLnDHUe85jOTTuqcm+CREPPE3MBGPDRsaCEWihRoYMVZ5wONz2T5y6rd80EGY1Zbx6vzEb+ug7b0ipPtF60cZUSHydWJigJT+2xcCQhuQjyocFoy/OXAKplHpT6Pv59uFPcbIr+4Xbfhvu3AQ+5l6Ngt6SDKrbw59M0TmSbF5Xgxn1VorphRbczRZ1SXMdPSUOze0xrdx2eWZrAs20oMGpW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEh8nJP0Bu9S+D5Xpz+LrHk0N2+O3O2q90oFsvUt/Z8=;
 b=l6WPUwSEvdI1jkMXZkYcnNH69lzYmUIzlnqg5r4xgSWmCWy4ptHajX6XOFCZacENkXYNlgFBjVoQ1lbO0PfcuQCFS9LDIi/PMxewm/Xltep8ZQQV/hFOTGW3ISV5QTVsw3soqkuMoTx2mJkJG2xRIPt3SxiocnrVl6mk0IVD3nooYdDLkGjg/ObqpCUZJ4BDQbOglTTjnMNZV1hUlC2dbUBo7KqtHIRddZDavDThoXPNCfxXo/oTnUFDpje+ET7RqMCg1c2XMSKKvqdJacXdFqP1Y4gwrLHzs9th6+B5xi4DTxg9skow07nNzmxgnFxBV++EA7lB9UMggTELz/4iCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEh8nJP0Bu9S+D5Xpz+LrHk0N2+O3O2q90oFsvUt/Z8=;
 b=qsaGG1lPqlCTBHcuYx/crqS4+cpI5k5AXxaHfRmuqPsr0oafLk0sEKThABpKvRYJpZqzv2T8fuSLRQusiArtOH1T+XsAbo8IYnZm3ZStDXBraJlNKv8foFtUAzEbN/EjgbUC97f6HDUQEjYsljAqZVTAVVw9IEwl3jTQYci2x3LUjHJGI/6+TVD82884SpqYXXyeuYLmhn4uYWLgu/TcjbFWoWr9sTjrA3vUpC9B/r+htJC9qpfuha9FfCNytRwGE76JCy7fOz5KnmEiywkutOJfiIc601SQgTpQE/HjsKDimCYnRuG/uAiWlx64OKj6dAwsGuKKdDneqR179o/1Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 12:34:44 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:34:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	jpb@kernel.org,
	jgg@ziepe.ca
Cc: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com
Subject: [PATCH RFC v2 2/4] iommu/arm-smmu-v3: Support shared SIDs in insert/remove_master
Date: Mon, 21 Sep 2026 20:38:46 +0800
Message-Id: <20260921123846.1663580-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
References: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: 189fc34b-79ab-48f8-cbe2-08df17dcb735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|23010399003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	a8E+pRAEv7eFNZ8EakQrJkBfDvJYN7b8bwwPXWPMUcVK75iIfxodvoudCfvr0SEYBeOuLn++esRTlJg2MhGht2f0mV4P6i9WQudLVJnH80YRX3zbAWhfgXPNZ5o4kmLxTO5y90KTChy/TvKocVqJ/bJCeeMuEGR2u3ctVyUQ7qrwu/anMhf+AkO9Bho86DGRhWcygFqrsS9jb0YGScLm3hEpgnJMyuXn1wM1kpbknPvN6pWrpsh88yNjKS5H69Fji5dYR12DYb6BNeY8L9DR18rKmBok598zii9TSVvQZyiL/x1xo5lceRp0lxGRxGXKmayGALeiMTTHn/y4kntorznoccntrFgLNrZzQsgcVtZMjMcrUETLMCHb30R+uALZBVANAZPcVImFOHMQ8uFMBJsZQar4tro17aupR1oJIsi/IatJO9YKQ/9CXyWw/mPcf5t7lavx18o8hJb6udd3Cvd+j+8AiUuBXBR4hHVECjzeknq6c7g1CxgC2M/62GomdiQ6I/YgclHXtEClWDkK/xen58+kyh+ZriHCjaMtnaCfsCK2GYI8AMTktwbpSIALzSKKTIpEqeFlzFuGHXRfF2kfctOueUQTHHo1efT1dQLEeEGhyIcX4W8OzD5PBjLNw4u699r4AVjkodcUgTB3xKrahJm3rFvNIayFJ5BAalc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5me87vpBPH9J2aRN7Qgu1u8umZvt6fGYLgG0QqC5Ac56+UpFxKJNcYMORRW?=
 =?us-ascii?Q?XmOYwEZ+/SZKchPEAtr842+VK40dPzw06OKLUJsJ4uXPOZ2xSreVXdQsPTm3?=
 =?us-ascii?Q?PziBG8T7zjdI9JwmQFT+WDaU2Vo6eEP2yqw+9lY5hYn1IxYuS3Ow/PyGtXM7?=
 =?us-ascii?Q?KfTWQ1XGB6XrkO7U/noegxQmaFlhpKOtLnnX0v6ebREcyeD1hYS58NPLts+N?=
 =?us-ascii?Q?cnbta5YUl5b1vP9ZwuxCJbTeoUoMSpP7h/7UhvSHe/t/wtDG2Cmf1C/qtnWy?=
 =?us-ascii?Q?LlRYPawb4m6tq6s2hG0dlrLDSSGhbhHVis+rMoNj47Duz4RYgGfc4Qxsdkr+?=
 =?us-ascii?Q?vnk5qKFk7D9G/28RZ2q9TLPVJL2T7TiEnVNQb4QtwhqgDBzJWQ7Hbp9HyEYq?=
 =?us-ascii?Q?+Nw8ZGt6kYqDb+ft/PURaJ8MkEMeB3x8kaArMveWC1/ce0k600yQidYXSnLt?=
 =?us-ascii?Q?/B7eLDfirXQhG8kyfDa4IfrbuLWE1NHjdssLnxnWkCNZSlCSedAv47Ylk/cx?=
 =?us-ascii?Q?GNWxjHsvuK583VzpKlL5f0hUoKQG+IQuROZHRbZf1Y7bLWsNFCAW7CfVS0Ao?=
 =?us-ascii?Q?oyGxDNLWEtPaK8vCxxZuO40AjvGAnexaGwkD8Onf4UObwU08o3Oo+ek62ACh?=
 =?us-ascii?Q?mwyScoTtrqnguskLKLaOlUcdbMa1QTOtIwzbsUekZAoqUF3VVikEQ0kVDE5n?=
 =?us-ascii?Q?k/vb6nckp6AMAdHVlfKWm61RgTUUKA9muJlYF95ITuPWHow/aV2rT/W0KRgJ?=
 =?us-ascii?Q?dXZpJjnBIGNgtuPABDa2+l7MUJBcZ/Q4HuueX2YRIy6+TBK6O1LNBMKe6abm?=
 =?us-ascii?Q?rsDQK7CHfD9uHQvwm3hZ5kIRZ8kKzPVW1tkkjwR0NuksslGJUctMLYDo2/o3?=
 =?us-ascii?Q?Yu1R8PuxWLh+N/UiuxXi6H6dDwf75h7lsfUYtUU02ioEBtR5E9401O2rvM84?=
 =?us-ascii?Q?fBgczY4fX/5Ik/K45S+QOjLQcK57CZ9/uM4/oZOItu9bnRdkLTebIr+gJnvF?=
 =?us-ascii?Q?UEe3SqzbcqpSNCCmHvZifw4AvTff+de8Vtt5ASCrF1SsfPHp8b5YMZvDQJqc?=
 =?us-ascii?Q?4SHDfsBP/yw6hyOZwmSdU3iPjymjIMotVJDZxVERosMsr7b5b0XCLQLxSTMw?=
 =?us-ascii?Q?9/uK0ucKnCMFgw4Ct75zN1CKpqht3690j4qI6VAdiFqZyS5Gpanh5Xx/QFDT?=
 =?us-ascii?Q?nD2vTCgTBOq+L0nlTmgwwh8pCcRCN8DjutyKGMx+SUY+wopQV61RkMF5rEgS?=
 =?us-ascii?Q?w127p78FPPYaa2e2/wy3BPYwTSabvzJUSmOdbZRdFMLLRJc+KhLha/oMB/JN?=
 =?us-ascii?Q?DaKFVP8p2ds9xEHShYzIm8isLVWrKZtIoodRPT0VcA+fDKHzUEAbvC39H883?=
 =?us-ascii?Q?2TBYud9QWxJVi8fWkbkgxKIXR1p8Ln0nR/eCQL3Kbn+lyFhfgt/L5ZLWbf4Z?=
 =?us-ascii?Q?PACi3l+Uj/9yfZDSZkk8jX60VpeGEIsEY1WuiW4xhS4Vmq+nZJw1EQj44tDe?=
 =?us-ascii?Q?T8bvIGDWSJuxK4TS6XQZMwF8NWujXB3Y8kyOEHhj766OoyRscapYZiKVmX2N?=
 =?us-ascii?Q?hbEEwGE9imzGuKrcIoTSRE6mIFuwCLvvaE0Wk6mheT8yHPTIu0y09kW/Sb1A?=
 =?us-ascii?Q?u0S7IbihVEk8X714nYRXjRcNAvhg7IiBQqnAFDW6vU42AwEFye43VUNysHEf?=
 =?us-ascii?Q?2l1wtuYVKalAI+KkAUM7Zll9WpYAghA3tbQwDFBGX6pxt5dLkPbNwCd6cQRo?=
 =?us-ascii?Q?Wmi2zPxfoMPexraCzeISuJKV5wY0fglMq+P3Yva5TQLPYxYgPWAy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189fc34b-79ab-48f8-cbe2-08df17dcb735
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:34:44.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4wiW2JtFT0SWb+hE6qDgi3XEwQiv2RFnNkz9yge3ITDLHcQEVsKEApQ/oFEdyis5DffEkNPeZSMJ8c31zOvU4JRG+0uYN/5owyqGKk4lB7L4AHznKZC7XcaeWjXyL9z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604

From: Peng Fan <peng.fan@nxp.com>

When arm_smmu_insert_master() encounters a SID already owned by a
different master, instead of failing with -ENODEV, increment the
canonical stream's ref_count and mark both masters as shared_sid.
A per-SID shared_link list tracks all co-sharing streams so that
ownership can be transferred when the canonical owner is removed.

When arm_smmu_remove_master() removes a master:
 - Owning master with ref_count > 1: transfer the XArray entry to
   the next sharer via list_first_entry + xa_store, and clear
   shared_sid on the successor when ref_count drops to 1.
 - Owning master with ref_count == 1: xa_erase (sole owner).
 - Non-owning sharer: list_del + ref_count--.  Clear shared_sid on
   the canonical owner when ref_count drops to 1.

New fields:
 - arm_smmu_stream: ref_count, ste_installed, shared_link (list_head)
 - arm_smmu_master: shared_sid (disables SVA, stall, IOPF)

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 88 +++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 23 ++++++
 2 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 65e448a69a019..f53e1871426a5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4095,6 +4095,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+		INIT_LIST_HEAD(&new_stream->shared_link);
 	}
 
 	/* Put the ids into order for sorted to_merge/to_unref arrays */
@@ -4118,31 +4119,46 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 		existing = xa_load(&smmu->streams, sid);
 		if (existing) {
-			dev_warn(master->dev,
-				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
-				 sid, dev_name(existing->master->dev));
-			ret = -ENODEV;
-			break;
+			/*
+			 * Another master already owns this SID.  Bump the
+			 * refcount, mark both masters as sharing, and link
+			 * our stream so ownership can be transferred later.
+			 */
+			existing->ref_count++;
+			existing->master->shared_sid = true;
+			master->shared_sid = true;
+			list_add_tail(&new_stream->shared_link,
+				      &existing->shared_link);
+		} else {
+			new_stream->ref_count = 1;
+			new_stream->ste_installed = false;
+			ret = xa_err(xa_store(&smmu->streams, sid, new_stream,
+					      GFP_KERNEL));
+			if (ret)
+				break;
 		}
-
-		/*
-		 * xa_store() returns the old entry (void *) on success
-		 * or an ERR_PTR on allocation failure.  Use xa_err() to
-		 * convert to a standard errno.
-		 */
-		ret = xa_err(xa_store(&smmu->streams, sid, new_stream,
-				      GFP_KERNEL));
-		if (ret)
-			break;
 	}
 
 	if (ret) {
+		/* Undo any successful insertions / refcount bumps */
 		for (i--; i >= 0; i--) {
+			struct arm_smmu_stream *existing;
 			u32 sid = master->streams[i].id;
 
 			if (i > 0 && master->streams[i - 1].id == sid)
 				continue;
-			xa_erase(&smmu->streams, sid);
+
+			existing = xa_load(&smmu->streams, sid);
+			if (!existing)
+				continue;
+			if (existing->master == master) {
+				xa_erase(&smmu->streams, sid);
+			} else {
+				list_del_init(&master->streams[i].shared_link);
+				existing->ref_count--;
+				if (existing->ref_count == 1)
+					existing->master->shared_sid = false;
+			}
 		}
 		kfree(master->streams);
 		kfree(master->build_invs);
@@ -4163,11 +4179,49 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < master->num_streams; i++) {
 		u32 sid = master->streams[i].id;
+		struct arm_smmu_stream *stream;
 
 		/* Skip intra-master duplicate SIDs */
 		if (i > 0 && master->streams[i - 1].id == sid)
 			continue;
-		xa_erase(&smmu->streams, sid);
+
+		stream = xa_load(&smmu->streams, sid);
+		if (!stream)
+			continue;
+
+		if (stream->master == master) {
+			/*
+			 * This master owns the canonical XArray entry.
+			 * Erase when the last reference drops; otherwise
+			 * transfer ownership to the next sharer.
+			 */
+			stream->ref_count--;
+			if (stream->ref_count == 0) {
+				xa_erase(&smmu->streams, sid);
+			} else {
+				struct arm_smmu_stream *next;
+
+				next = list_first_entry(&stream->shared_link,
+						struct arm_smmu_stream,
+						shared_link);
+				list_del(&stream->shared_link);
+				next->ref_count = stream->ref_count;
+				next->ste_installed = stream->ste_installed;
+				xa_store(&smmu->streams, sid, next,
+					 GFP_KERNEL);
+				if (next->ref_count == 1)
+					next->master->shared_sid = false;
+			}
+		} else {
+			/*
+			 * Non-owning sharer: unlink from the shared list
+			 * and drop the refcount on the canonical entry.
+			 */
+			list_del_init(&master->streams[i].shared_link);
+			stream->ref_count--;
+			if (stream->ref_count == 1)
+				stream->master->shared_sid = false;
+		}
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 97dc97ac704d9..cf245b5de2bd2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -976,6 +976,24 @@ struct arm_smmu_device {
 struct arm_smmu_stream {
 	u32				id;
 	struct arm_smmu_master		*master;
+	/*
+	 * ref_count > 1 means multiple masters share this SID.  Protected by
+	 * smmu->streams_mutex.
+	 */
+	unsigned int			ref_count;
+	/*
+	 * When ref_count > 1 the STE has already been written by the first
+	 * master; subsequent masters must skip the write.
+	 */
+	bool				ste_installed;
+	/*
+	 * Links all arm_smmu_stream objects that share the same SID across
+	 * different masters.  The canonical (XArray-stored) entry is the list
+	 * head; non-owning sharers are linked into it.  Used to transfer
+	 * XArray ownership when the current owner is removed.
+	 * Protected by smmu->streams_mutex.
+	 */
+	struct list_head		shared_link;
 };
 
 struct arm_smmu_vmaster {
@@ -1024,6 +1042,11 @@ struct arm_smmu_master {
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
 	bool				ats_always_on;
+	/*
+	 * True when at least one of this master's SIDs is shared with another
+	 * master.  SVA, stall and IOPF are disabled for such masters.
+	 */
+	bool				shared_sid;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };
-- 
2.34.1

