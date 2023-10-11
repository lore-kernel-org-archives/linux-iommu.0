Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4A1C02
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ne1CJO+l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzZICpDKDO+n6rw/T/qXnADFEuUoQZDC2I96mJSDgbA30S0w4ivMBjImnVR++VHMBtKHp8SHJEj2jAFU5+a4PfCNZr9DwTxQIUBuTTxCzS2gr5THewdr8z44aAxIH3/tDjdUdFMYeNE3wqKXJ7YwGTdpjOtcEjvN1lS09Wg8cdIey10p94HB2tpqleyqTpfO/UgBw5hezjjQ+VnjwZbkdKWPKEiQkjq6XPp79sLY2kAGs0DN0o56SGDLPwZ6FN0D/9tvwXYvNlF27t0VLUQ1yS1jC0as1E5zFC/sS1xyOz6C9lvu+eARuFWDQRPrG7og8wXp98I6SPEHmzCJUMj4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czc5qz9bl8H0GQ6OSswFtZ82ieR3jreREUCQivMJWR0=;
 b=fUt48iaOzDvg4LvbXeiWKshYbP73lki+lILnE/X1/aROv4HBM4hNHPB6IcD0RJaz05alicKTWk5Nplv4+qk44bFjkEXUNMoRlUkjDHYMJGwdzM6GGC2K7SX5jkINAL/Q2a1rH1V3K8aEIQrOdeBr/bca/E5U2do6QTk3gPUD/V0dKmxYsQZcorMIhkUJy+G6LbnhP77Qs6QTm3xOA+o6CI3cXVx9m9fDybx2baVkxmLrzDA5cPBmFvOEJrHYUFzrP3md3Xz0gG4vr8vphz9QL0Tid6JbSDn6Rt0vXEVUsY68kCKNtFuG2QeD3mtQlCYLalrP7vDUjE/GystWILy3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czc5qz9bl8H0GQ6OSswFtZ82ieR3jreREUCQivMJWR0=;
 b=ne1CJO+lJTBji7GI1nqacDExvB3hfuTpsuukW56WzJgvVsQ2bPMP3DhHBB+4UltNfqlJQxTtuhASY5y1uAWRIdtCsYiqeZ/rJe4gAAeFamhSDRgyk5d3+163xH7bTFtCe7itZklxBqkBNWJMewtG+J/rTQLjoLSm0Bhu+KCnV3+0kfSjAu96QsWi64BfO7JRS2tAszxWVhu3XfwcKHOuvnrRmwb2HNQbJ3zDYkBjHIk1PtT3VEsYVvzvQuk7AI5lPvWKxshB7MPqO8MxXRgtnFE/YZ/5RWudmaRCEfRfrv1t8E/9W1M78FSedmdnMR/HHZtTwdTFtxqDoNomoxtGzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:31 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 17/19] iommu/arm-smmu-v3: Use the identity/blocked domain during release
Date: Tue, 10 Oct 2023 21:33:23 -0300
Message-ID: <17-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:208:234::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 559e6b05-b100-4c27-e0aa-08dbc9f1af83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BQvF0NAbXXL/eFn56C5mFyYRfW4L1IU+CyUhov43Ei6yXN9DAOX366QA0MoG6t0MTxzGkMmvXlCPYBkVcM1LafqUkvK5vKIeLZcBPkEXVOjJEcyGwp8vZxB9Rq1R42vq2k7w1qsRynW+Wdr2YiFnLJKBr87iGzCYQGquJOYolIys/m92XKCxD39pPEJWQFWMzB5+IB9Fj6BsUAUJa/qb8rSsmQrStt5RiMO/6B6KdetuaC5SFhbRdkQ6OypSGBNNHX+qIwMmdd7QmlexmuYybjSCj3ykMfRahviAeHmvaej2DofOVEnxKwcFvNg4saFx/gcNVujzyr2T0dTJVIHY6MPZemJebdTbiLDuGYpm1ihWWpMDSpYtjtwCEXRy/TUrxazTcZAtHlypftPnij14C7CYqoB6042AzFiM4W9KNT152W6yQmqM2nrre+0BIqcO6GYGzpmCv+5ejeGf+Gc1lSaVZf6w8em4Zk4PLwu3UDPOvgy+k2v3bMVjvJokyG5f8RF7f0HIrb9KhyzBaFd1WTvdz1/SoWEZeYK9ikC6vo5bRQqyeRvozzHdtvpQcDRz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(15650500001)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dR5YWavcNrBFV5hUp3X1gL2zkrWyclAMJI0s46QzMqsdyv9MnLxQuVnXAEzJ?=
 =?us-ascii?Q?51Bp2mIMnCkvs/vOwkp3RS1i2iP/p2HASR9OC4DgC0zUEK52jD1zYhirinS2?=
 =?us-ascii?Q?l9MKwiTUIg0zLbEEomB4DEtVp2ziBCGWVXAAAymoMu7+UF9Iy/QDlpgAFlsM?=
 =?us-ascii?Q?L6+hCPGvYfJrFDKRX6r6RfxnoO1w2m2nslPdtC9EGvwOfLyirj9ve6KepQ9V?=
 =?us-ascii?Q?xuM4IkXhosjlGKa3nPd9TKKxpJSctsHZx4a0oan0bfvPfhf/zoAW/c8ie6Sk?=
 =?us-ascii?Q?2GB0SS5eVZENK5v2vl553G6zQdym2LkPyGV8CJpc7HPsacxe61zuUwYGEVxX?=
 =?us-ascii?Q?vBymPpy3toD43T7BPJvhc9cnWFfFoo+w23fD8wMevr5jAq9tySCqEd/zT+AP?=
 =?us-ascii?Q?dzFH3WgNBxvBUDmfmh/WVXfX5AGcexZt/7aDMfsgF8LZD0OpzCjQcib5Tkyl?=
 =?us-ascii?Q?kRZMN0QdadXedRPvtufwlP96NRTBsQ+OiVbvnM+EEKZVgsjkigNBgzUB+b03?=
 =?us-ascii?Q?r3LCMpVTJyLqew6ccv2gRrGCpkQuMoEMEO+EpNv86iLyVimWzXX4W1IonZBZ?=
 =?us-ascii?Q?ItdRUZIHN89sjmli8G4AAjTcrM3rwOjZJjli9styL8SlP5KnsNX+JkGA+7DM?=
 =?us-ascii?Q?Zdje5g7G1MFFSI2lizbOTni/gbuzmjPeVNOUgoBt8O4P+3kvLbetFpbveK12?=
 =?us-ascii?Q?qNA9yNu+ce/Ao/8y321tG10YBi1lmgCIdSMlN4kOOMvEz88sueQIJjn3BeVz?=
 =?us-ascii?Q?HLD7AGkWKU07xs8KKnhZcFWO65kUHk5tnvBxGPaRqGDGzZ3QBg5ccF+h9lIx?=
 =?us-ascii?Q?N/cIXz00aIhx/pS4RmKnbh1ogviODmDhFHuUhf50XB2tBjiEVe2U9e171Fx2?=
 =?us-ascii?Q?94byFUd3h1PVYak2WBgjwB59UCj03PvZivnCPP+p2DeXXV5vWzE40t4Envar?=
 =?us-ascii?Q?IFTCO5TboPGiZglNXXZLswywqOE5AMoPMtUYhm8voSdhpMYnMV5bYLoyB6Hf?=
 =?us-ascii?Q?wDHHf6li16u+6BlfWKsG9ye5yN8TJxXYSWsb7+Oe8toYJrkz6z5AdmRWpSXt?=
 =?us-ascii?Q?r3EqChCVqYLVuIw6NEet+ZWU8z8ZiuNugRBW+oQmhlDanngCdvbGTyS0LIsd?=
 =?us-ascii?Q?FsRkQiz4Z2OCGEkwit3v4Cax6xhuqBDwQNn9qwb6os1SF6ZDi87OCwP5r3Tm?=
 =?us-ascii?Q?QyJ5RJB5yAaIoBO8nTVcAEQbnWcmP+JDnFmA2jNuP/I/PCXJAbAQrorRS4M0?=
 =?us-ascii?Q?MpS4RY5c1QaZvA1gJwNXnnKV1GGC+cBxSbsPtKBcp/+LllW7D1S1zODtorvc?=
 =?us-ascii?Q?559zTqJYV3aM90MliBk+2w0md+EpJg7OBX4Objpa/hkZOt/yr05KMtvSflE+?=
 =?us-ascii?Q?cnHqUvA9/ueOaG4iAsTLV/592772Zvc47o/DrIZU8ioqk73Xz2LStJdQlfYp?=
 =?us-ascii?Q?ZzvXHabXDFZSXlgJLVEsmOc2Wj1y9iIIREJOym2byTtKi34wnd7ISgagq9rN?=
 =?us-ascii?Q?8rYH85JzS+oY33hObWxikT0dk/0Eh57kSUrk1o22Xmj7bfXUVjmNoKk+E3zT?=
 =?us-ascii?Q?BmUqHDLCBDNFYDRoFEkY6WUTyD6vm85LHgNZSeSb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559e6b05-b100-4c27-e0aa-08dbc9f1af83
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:27.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYg3gVrxCBxBmSBP3ZQW41L8V/uPMUfh5zEuypMywoOa1E5G0jTkCWJn8UYl43fN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Consolidate some more core by having release call
arm_smmu_attach_dev_identity/blocked() instead of open coding this.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d42d5d0c03f812..95bb6cbe2fdb08 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2875,19 +2875,16 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
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

