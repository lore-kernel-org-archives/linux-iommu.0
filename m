Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1FC2F362D
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056608; cv=fail; b=uSguWj9uHz61Lkix0BIVubfKKg4UiTY7z/4SvvpJ6inBz2jSSelr1ASERwA9hN1fsXsGjExAduxsqNVcS+tZctVoTMVhoKwhfvsURmfTts6a3FNjLx9O99O3HWZs+MudAK6q3mQUul3lvnJBkCVLssEBWRoUa1DbG/V+CpvapQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056608; c=relaxed/simple;
	bh=GKRYBrwpHZMxXp50ShVr2P5Q9U/W2twiIR+iGSckBhI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDG5ApcquAfX0QAYUPKVmeReMpHkQRbTsszF32yGM0UFVx0YWjpq9rc8qglnA9p1V7lMSST5suEWXL/eXP6Vt00cDV07Wzs8Zvl9hZUZiU9P+BVMuzZ/HbMTWbYPM2QQYV+vThWRnoQVbqPQjZPMAZK/PQTd52vII3TTIIpxUJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VlyPRmL4; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VlyPRmL4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htTuFmgU2Zg9Hass3SbpKBezUXROXpUNO5BW4IWQbW9tTq/6gWyZTNaqrebXr4NwZJqwxH/o3QstGA9vwEJBe5/ZziZaRgg1e6Q+y7J3ntq8V7aQaTZO1ZEO8lPBpQzrpUQWMub+oJ/NY6EwBjqS0b5H8JvH68dvJbzlDL5YVB16ddUemwK2IFZhz71xyRPtt7n6tvRxE/jDkMZjyQLIA1JYge/APxpThDrqf51j8fM0VhidAiaZjU/cKoo4QXdhr3ccT55mH7YAzCeBKqGfx8qW2LEsIPS2czSjW9shyv5G6YNULFGxuUMoK6rqS6/YxxQFRE3Y3N1zgpgI9MY4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hoXLNzasOe17sA2UErm+pJ156aufeLYkZMtIAC2WSc=;
 b=yoOzMbzUuj0fApr51tmlW3BLAF9B/w8uFvcycOjqs5WTszek3NO5obz9WtV5cJDjMcz0xLZHTLY+9FO4Ps/kW2VzwjcbPZvX1fl6vom0ctLsjQ1NNZQBl8mWESAEkx+MgPqpEMBTGKrbpE4itSaU+AV1JsIeE9cYT20DbpBvPTN2u05EOn9sxo7Vp+ZZG+4zjCLPQfGM0x5UIE2d/PN4GwMbjGhhAl4Tbb0SDcQrUhfftv8leaezyT+RFO/3D/ZeCbFB2b+6DjvQ+YDH7jBTT3sISIVC5Kjg8dXLLhPseEka2/gS5pMNmBLhRSru05rdBTYkkoyRZGYkiKwJlwjZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hoXLNzasOe17sA2UErm+pJ156aufeLYkZMtIAC2WSc=;
 b=VlyPRmL4BFK6HO0xa/gfq1f1ZvyDT2p6KARQF/pymN6486/wgsKVAw8QwUYIo+jMfO6lfpAndh6GIL21VwcNRjo5uyqC068CgX4T0dI87D2OOsbmfFopwAKbZmKMF2G4UJtQS3N5JFDoyacF3PNueUSwEKdpuMTvq6RTDS+aUJ+sD8ku4SnJfMXwiXP6/0J+BLd/0F98QGVXzWKsv7nSHWbzPPZbNMhYgcnu0LOYZzn2T0XquRMbpDRJstiQ5wO42fdIBdLnSUZXn35gPzzMtLm6PfU2FUiGnN6wJmi0QvwWyfbppxs1neK+ZN8QwGAnerxnCm5d5fr0NwXgUKMifQ==
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 07:43:20 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::fb) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 07:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 07:43:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:43:13 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 23:43:13 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 23:43:12 -0800
Date: Mon, 24 Nov 2025 23:43:11 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, <jean-philippe@linaro.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <balbirs@nvidia.com>,
	<miko.lenczewski@arm.com>, <peterz@infradead.org>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/7] iommu/arm-smmu-v3: Pre-allocate a per-master
 invalidation array
Message-ID: <aSVeDwUNfzCbwgGU@Asurada-Nvidia>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <b6e1b5d0ac0157fc06b5cd20c5cd72caec892c47.1762588839.git.nicolinc@nvidia.com>
 <aSTRX5RJJhfNU6l3@willie-the-truck>
 <aSTfrp9D7i03XhyU@Asurada-Nvidia>
 <20251124230845.GN153257@nvidia.com>
 <aSTqw4Doipb+0AfP@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSTqw4Doipb+0AfP@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: decdc4fa-1e97-4c1d-4f69-08de2bf64dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D2ZVd/H55CHcaGKRPHHJ3nuKodj9EuVpBMxT0vSy//GMw2GDdg2ryDEzWm9q?=
 =?us-ascii?Q?z8NFrFhhBBaNkNM/o5ay8DpeTlDisKUCQSo+9cOTiou53b6yqQRjQD8JgfiK?=
 =?us-ascii?Q?aKZSHUuQR3uZtRQ/4EOIRfkOwzAnBfwiClH+Fh1vW18VEH8CHw3FjBQv9vXA?=
 =?us-ascii?Q?ZPM45ixjbwHoqlKorRIj1OSZ07Y4Us27OiXrWbdxYU5h9Qtvgkn8PYylxgwK?=
 =?us-ascii?Q?zF92MNjFbeom3XgIwuMb4Ni1/MUnXMBVs3FuaM0HSz/pDfcwqaopeJVupZOm?=
 =?us-ascii?Q?8HoCTCzh/k4Z5QBMnEfdPlGdNnYXVoLOot9Tp9T65REuu3t1r32pfFPEDOmm?=
 =?us-ascii?Q?rsWEo33NsfJsyCxA0TawM8Qu1hsfR0zF59YoO3iwYyX9WNrYBghJ5bufiXVf?=
 =?us-ascii?Q?eVkweFBQ52HSj14CnUjmoChhSn2nEYEhWBIAqNqIcm38WSoq0IBuLzlQfPrJ?=
 =?us-ascii?Q?9P9Y2xaPhlkDDgtA/nDx7t9BpNEHLJ44X9uYix0apHg1L7RygIXaOflzpHWm?=
 =?us-ascii?Q?s+BGF6067iUQtkEx7wCXNGJBQO6Vw6WI4HHwtHyNRSCXAek8h7I733kYAEbD?=
 =?us-ascii?Q?NjhKWhZBqw/GykhyepO6f2oXUTBlbSkJZT2QEduffjAQB/DYELh4ooeZRAuc?=
 =?us-ascii?Q?pQW6+Ry8+v8RaepGacbzDLevCTwSYfhGZ8eagzeWwbPIuSRF6u3fz3tBLfQy?=
 =?us-ascii?Q?ICmwBkMyJbe4aOEvQYgWJz43Ch5shmRMCTJuRTFRLGOFv6Sy98dKsHpifTJ+?=
 =?us-ascii?Q?Xa93QqLMTTsZ9P0X5l+jw62hmQwilpK0AMidx+my8bpiW4DDsHMJKLRqyRLg?=
 =?us-ascii?Q?H8Fk1ZV99bXYSLUo89P6nlL+Jjlc1w+CqXxNxdWQr/AYw1+2BnaCbPzs0KuK?=
 =?us-ascii?Q?F9jdQSu2uNAmH82gM5jlnPsZUcjRE8d5TpdJIJoFxvg+APQnfdCcTJSDZCwP?=
 =?us-ascii?Q?1ilatzL+ZewDCzuwPyPNn+adZFhoGzKcYn2Y8gvVDNgowrg9MoRgjQ43Z5D7?=
 =?us-ascii?Q?dwWMKEAKicg0IZd1BqAbzMjEGzxAip95Ja3hF5TBxwR3ugX3JL+mwHIBToSk?=
 =?us-ascii?Q?ft077aFH42e3CrA/Pm/GXhjQVVpT+I29qoonDvEjs5sDjKW+qSFIeeoNAfj9?=
 =?us-ascii?Q?lnHM6u/LOu2DqSuIAfs1zoQQUhQwB1KqMG5yrYHnLifsoo/YmpNa1v5qx5vT?=
 =?us-ascii?Q?0zyzXsHneRY6CykT0ScES9fQ2tyGLecRMPuPhfE4RYUnD5A0xa0dXxE/EAhy?=
 =?us-ascii?Q?lKicaVfs66VJ2qfbmtVy3nUMW7SJKd3AIvJHaN38eiiz5N168JpcMZ+mpy1Q?=
 =?us-ascii?Q?h6t11TlIRdu1JtBzg3e5vmhC9JGnSRSAhnvyIlGlUK319b/2IBzFQ4JHNF+3?=
 =?us-ascii?Q?QtIK6nJLpD2jq93GXErWiQAj/jtSQeEmNZ/5gQRoPEqDjgMEHRfmMyhoWaGp?=
 =?us-ascii?Q?qOlFVM2MPUxp1Ub8lP4vAdd0dh4aXcG56+odZIwo2d/DYHCICgNkquHhhlkY?=
 =?us-ascii?Q?hw2ZLL53leZtLfQ9xt4Kqxo+353Jw7IylEXlDzNC/dGZ8oN/9ibdNd+gjeQy?=
 =?us-ascii?Q?O1ViqfSckArCwPlZPS0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:43:19.9946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: decdc4fa-1e97-4c1d-4f69-08de2bf64dd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189

On Mon, Nov 24, 2025 at 03:31:17PM -0800, Nicolin Chen wrote:
> On Mon, Nov 24, 2025 at 07:08:45PM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 24, 2025 at 02:43:58PM -0800, Nicolin Chen wrote:
> > > On Mon, Nov 24, 2025 at 09:42:55PM +0000, Will Deacon wrote:
> > > > On Sat, Nov 08, 2025 at 12:08:05AM -0800, Nicolin Chen wrote:
> > > > > +		/* Put the ids into order for sorted to_merge/to_unref arrays */
> > > > > +		sort_nonatomic(fwspec->ids, fwspec->num_ids,
> > > > > +			       sizeof(fwspec->ids[0]), arm_smmu_ids_cmp, NULL);
> > > > > +		/* ATS case adds num_ids of entries, on top of the base case */
> > > > > +		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
> > > > 
> > > > Although I can't point at a specific issue here, I'm nervous about mutating
> > > > the 'fwspec->ids' array from within the driver, The array isn't allocated
> > > > or populated directly by the driver and so I don't think we really have any
> > > > business sorting it. Could we hack iommu_fwspec_add_ids() to keep the array
> > > > ordered instead?
> > > 
> > > Yea, I think it makes sense to do it in the core, once we have the
> > > data structure provided by the core as well.
> > 
> > I would be more worried about sorting it everywhere for every
> > driver. I feel confident SMMUv3 doesn't use it, but something really
> > old and embedded focused like tegra or omap, IDK.
> > 
> > So I wouldn't propose to change iommu_fwspec_add_ids().
> 
> Perhaps a different helper iommu_fwspec_add_ids_sorted()? Drivers
> can choose to use the sorted version, when they want to implement
> the invalidation array. And SMMU can be the first only caller.
> 
> > If you want to be conservative then the thing to do is sort the
> > master->streams that arm_smmu_insert_master() copies the fwspec
> > into. It just has to be sorted prior to feeding it into the rbtree.
> > 
> > Then consistently use master->streams as the sorted list.
> 
> How about kmemdup() an local id array to bridge betwen fwspec->ids
> and rbtree?

Does this look okay?

@@ -3713,6 +3713,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 {
 	int i;
 	int ret = 0;
+	u32 *ids, *ids_sorted = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 	bool ats_supported = dev_is_pci(master->dev) &&
 			     pci_ats_supported(to_pci_dev(master->dev));
@@ -3723,26 +3724,38 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	master->num_streams = fwspec->num_ids;
 
+	ids = fwspec->ids;
 	if (!ats_supported) {
 		/* Base case has 1 ASID entry or maximum 2 VMID entries */
 		master->build_invs = arm_smmu_invs_alloc(2);
 	} else {
 		/* Put the ids into order for sorted to_merge/to_unref arrays */
-		sort_nonatomic(fwspec->ids, fwspec->num_ids,
-			       sizeof(fwspec->ids[0]), arm_smmu_ids_cmp, NULL);
+		if (fwspec->num_ids > 1) {
+			ids = kmemdup_array(fwspec->ids, fwspec->num_ids,
+					    sizeof(*ids), GFP_KERNEL);
+			if (!ids) {
+				kfree(master->streams);
+				return -ENOMEM;
+			}
+
+			sort_nonatomic(ids, fwspec->num_ids, sizeof(*ids),
+				       arm_smmu_ids_cmp, NULL);
+			ids_sorted = ids;
+		}
 		/* ATS case adds num_ids of entries, on top of the base case */
 		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
 	}
-	if (IS_ERR(master->build_invs)) {
+	if (!master->build_invs) {
 		kfree(master->streams);
-		return PTR_ERR(master->build_invs);
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
 		struct rb_node *existing;
-		u32 sid = fwspec->ids[i];
+		u32 sid = ids[i];
 
 		new_stream->id = sid;
 		new_stream->master = master;
@@ -3779,6 +3792,8 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
+out:
+	kfree(ids_sorted);
 	return ret;
 }
 
Thanks
Nicolin
