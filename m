Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BE2F2A
	for <iommu@lists.linux.dev>; Wed,  7 Dec 2022 20:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTBZ0vO2SAaFuNZ49BXIzoS8rBc7D9ZL0tVDyJuY3NDVWQyxpbp23XOfbPPfZJZ0Pf4jKLMunFU548LjILQLWNcgJ5yGmBTtX5I110ijd/e3JuMZhm7KYMM8m1AeTFfitot4rXdytnDk7cYAv6XE2QWbDGd4F3aZafckvtLlAx9XECFOufbnm3LfQKLwSWD425goR39Q/wfa6aJj/enDLMNHIh6sYQbgzdhnBJuBQplf3tHa/mRmdcfgkxkR9eg0Bm36C9aPL14ooM2gsr0RQE4YIu7gMAjufPfnGN25aujr8y9buGvu0lME2wQw/dzNFi2JRunNx/zBk2bA9oHICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huC8jVLoqiU00H9iTEQmHPn1T1QvxjOM6Oi0LHKK4jY=;
 b=Au4ZKHlTOGnfiUy0bMQYDkYJi72vKOhcTQLNrYNhrnBlzFXaJmqmvfTYesnaqdcjOjH/XcxkdPJCjnXiWKjRq/LuRk0scZUvCmeOj3UfDOKUvxTu7LWGwJFrhpSXWqgn3osZtaODpg8qi+rA+O4q/MeCy2/iVh4I529D82qvrSNkJA6ptnu1cdwICVZAJPY1hBwQeyZXoSjXCaswW8glFo5ELB+03PBezoATQ6UO2gHxElaMO541hKg7QOqNymuJ/reHLEL2YG/9S6BMlDWDLJUPjXx1f24xxGf2OrpgoPeaRdfiUbpNlAnPp2XXsvL8CaEqekzpG/g0l+cSaPbTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huC8jVLoqiU00H9iTEQmHPn1T1QvxjOM6Oi0LHKK4jY=;
 b=j1hD+/fSl0TeIP137Mh+wVPJu80+jAsa9ApPXHk3w6fmr45zP3SnFZVpcECyVic0bVc71iTqgdCbFraZwK4s7+QBFW0PlXGf8CZJs0fWi3Oa609qwSE8UBmr7Qw4X6EWy0ZJZTcMoU4S/TYOfsoMsMLb1vEoubPhqyldYb+b+uZMcPFQcQ3d82+lgwp/Ns/ybk0X1EvElhq3QB45+v4MmeqnVyra1tIbO3XWxvuZY9hTazkeoVQwGGImtoT6co3zerdC8Nit/FQkFUJOXIc6Rqc+ud4iobWSz5ZQleNfNQricwqPJd5tmLEEsMUmXE3ZHcdN6VpRWjwhqKhcBvfgQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 20:44:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 20:44:45 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 2/3] iommufd: Improve a few unclear bits of code
Date: Wed,  7 Dec 2022 16:44:42 -0400
Message-Id: <2-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
In-Reply-To: <0-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0441.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a92cf97-1243-4170-e081-08dad893df31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NDSD8JhgN/A9y5ukbNrrWIY+1igyHMTF5xzsonZoVnTE6Xo+SLKiGHDb2qox3d0nPbB4+cWFYSJ13zNNFH88w9cbWv7dAFDYGDHH/1M0Vz1Gl4XvKKXdENk/1e9WAFmpHSm+nch6u/5Ty2ydP3KfOKSkBrcSDs3nAz9oOCWi24EHlK/0V1n+Kg9uEpPF5yHr93/78/COCYpSoOxX1ItYImy+jSC/4LB+R8+3/ofDnTQqqqD3IlZblKl3dfEUxTkRxSWsCew0RDOM57vdbNQ9OIxr9zFnZUZwbdz0wlceOXbnWoUwilV9D0l6Qb06uZdhUJOL/RAlHoBCbvfNPLm/dPLprqBstXiveRhCqkcHplYmyD0Dt+jBL08T9p3FQg/kchHAxL387opjsn7cg6jGLm0vAvCYJLY03oSWsWitt9hBYiGx6kGdehLFCqqzZ10jMNjDMu1T8c9h1HdzarLLQw2jLxcyNoqi48XtGGAVGEHcl4urzTDL+V4DQgqLtCfYtq8zy2iMvUvo/78mxNk8X17M7R3FVym+2KLOIoYkQD1p+bLGc7Adg/zl8JF4QsJSP3SsvymNWrsZBlUjhuLjH1CL5zhZj65Kte43H2L0iwAqNHqniy1dqFLI5WSnmjxnTKewLGjrld88eaMWDeOXooqAlRkBH057DCmUu1xO3P/5vFYcTQELZ2QpSc7WPDRp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(36756003)(6506007)(26005)(86362001)(478600001)(6486002)(5660300002)(6666004)(8936002)(41300700001)(4326008)(66556008)(6916009)(8676002)(66476007)(66946007)(54906003)(316002)(2906002)(83380400001)(38100700002)(186003)(2616005)(6512007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ex0CV60oyohTqrq83d6jG3SWzx+P4N4byAFjaRPXiSoAvEnN+Ab+BaL1yJpt?=
 =?us-ascii?Q?GTltD4GYvHk6wRb58C9EQtaE3ynulOYBOsrQGa52bQBrGj+dTZuUoUcEutjQ?=
 =?us-ascii?Q?EkVVvT3dxmgb16TkWCJtUEeGRvxNT2nrBSyt/6b0Pb+uhPTXOpIE8vYv4Rho?=
 =?us-ascii?Q?p0L4E4DE9MwlIw09d300otUINxiBjuR+35ggYV3okf7zBOe1jLjpbrq+tpgP?=
 =?us-ascii?Q?sQwJW8YIza/ird/W2LjWhHOYQGUc0sLNwNkOX5cVVD3N/hnkzcRbEsc7rVhG?=
 =?us-ascii?Q?fRRqkwa45Wys/lzFJK9SwnFgV8O4r6QkhosxkQhPgH9PrU2GEG5MFI64y7TI?=
 =?us-ascii?Q?I0j9f7z+r8ZU6ufCYENke4uXfWc8gnsD1TVJE6XuNFlqBg0wHDWvLW/rEMxO?=
 =?us-ascii?Q?NP3XG/B70fx0rsXG4xCBVsNmQ0vE0sJnZVq2u6SFfuc0dTRnoO7wakYTNZl8?=
 =?us-ascii?Q?qLHzm6pKyUm+NkL6pPZEKW7ZfXIWaPo2ob7lFBlyRNJtX6jQ2XWLTCR4j3Bg?=
 =?us-ascii?Q?rP6/rXP37e/M3GUe1lahkQqhTPSaGfa0L1Bbu8wgM35rGHHa6KQidbjwx9mx?=
 =?us-ascii?Q?xEbGFtrmQqL6EITOFYPLvZeR3QnbZaGw1U8TjtE+r+DZrAGeh4sHZPFBszVX?=
 =?us-ascii?Q?M7+1yN+pO6wOecdnKNB74oWbQKBlnK+X8DFuvf3x+Qw5DzcKhCO9DzotkcAs?=
 =?us-ascii?Q?0AtraIOE4SHFg+J68yqJGiogq9WqGvsDoobNnlzVkc1UblbRHEolpMHqqAyF?=
 =?us-ascii?Q?9ACJTwmSrHJ2+gUevnWva3au1oF6waiVscHxfWZPdviDQWZ6U9SbebUfF3tr?=
 =?us-ascii?Q?ZduXiQPiQTrVf/56jqu4y6lgPdyw+/WE6XgEdAZxWSvQPUrtqf6D+cUKmJD1?=
 =?us-ascii?Q?qtdURJRwidocDO4g7WewS3g1otAN3ICJwYTowrqMnat2+uB5tZAEtTzSl92u?=
 =?us-ascii?Q?Wb2l0gzZqsiv/Kp5lffKg2HzVjFsLNTRUJZSyJMXjhCv4ER9QWMVjKdiPGCk?=
 =?us-ascii?Q?rTgXiZWk2dpG0qmY5IWM8uehZdw1dgtmI/Mc+o5k/Zp8cXbHsD74xyGtYNmh?=
 =?us-ascii?Q?u6Idr8cRTiRfQNNIn1m+REy8nX5W3nEtoGrmLt0Q0MI6KoAtFy3DBLbIuhDf?=
 =?us-ascii?Q?wkLtA33BULflOT5V5Mocskxyt1tFFac5CDwnWhz0V0fEQK1Av3TNMMvhwGsh?=
 =?us-ascii?Q?iH0/sELGXJr3PajD6q6u3ZI7tRQwg/HnG/S3j686jyulTfiCBlOBlHQ+EQbI?=
 =?us-ascii?Q?n/l81LW52r4zd3B01rOPPBWKUHxhik3ABXe3bedQbLBKhT1U3o7yh+vMtNpW?=
 =?us-ascii?Q?1CY5lQsG+qvG4kpIBl9CEp6Quv3t/X3nx1kyTjjXRi8HSBjSB7pTiAhk/N5J?=
 =?us-ascii?Q?MhJcw4YyqkphuA5FBTQhVa0CmFWH5Tr+Zh68ZZvSJ+MeBpZ5kdCoAPY5ENJu?=
 =?us-ascii?Q?f0F1qxiGjTD0keJ3ZWOBYPMgRUstHsecukIY9pGkrAH0jCilq6cB6tYpzs4l?=
 =?us-ascii?Q?CJCECFGw83YKC6YzTpTlISDaRhpJKgGM1dDdJfph+nYBnqYEDVLMYAswWiA9?=
 =?us-ascii?Q?fWQixlbMmXQ4aKk98Vg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a92cf97-1243-4170-e081-08dad893df31
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 20:44:44.4288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8kKnp168xnjvEBa2pnL5Pp7oFvLiiID742RZVqW6oyif9HU047iP+OZduM1nM+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856

Correct a few items noticed late in review:

 - We should assert that the math in batch_clear_carry() doesn't underflow

 - user->locked should be -1 not 0 sicne we just did mmput

 - npages should not have been recalculated, it already has that value

No functional change.

Fixes: 8d160cd4d506 ("iommufd: Algorithms for PFN storage")
Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index fccdba782cb699..c771772296485f 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -289,6 +289,10 @@ static void batch_clear_carry(struct pfn_batch *batch, unsigned int keep_pfns)
 	if (!keep_pfns)
 		return batch_clear(batch);
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(!batch->end ||
+			batch->npfns[batch->end - 1] < keep_pfns);
+
 	batch->total_pfns = keep_pfns;
 	batch->npfns[0] = keep_pfns;
 	batch->pfns[0] = batch->pfns[batch->end - 1] +
@@ -723,7 +727,7 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
 			mmap_read_unlock(pages->source_mm);
 		if (pages->source_mm != current->mm)
 			mmput(pages->source_mm);
-		user->locked = 0;
+		user->locked = -1;
 	}
 
 	kfree(user->upages);
@@ -810,7 +814,6 @@ static int incr_user_locked_vm(struct iopt_pages *pages, unsigned long npages)
 
 	lock_limit = task_rlimit(pages->source_task, RLIMIT_MEMLOCK) >>
 		     PAGE_SHIFT;
-	npages = pages->npinned - pages->last_npinned;
 	do {
 		cur_pages = atomic_long_read(&pages->source_user->locked_vm);
 		new_pages = cur_pages + npages;
-- 
2.38.1

