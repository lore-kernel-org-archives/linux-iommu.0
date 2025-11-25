Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F41EB5E1
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076040; cv=fail; b=nj61fBVZXoYtezwGXXTx7caFk0NQYJS2VAn9qIXzU4ZQwCl0spXeH1rTuqltH0DvebhNbuRR50wgtvP+Or0EngVwsWeL1V1Dj+sV10fKlLbUdv0EUkkWLhtQCDReCokaDtITCKvWPR5qDXM3rPn9Zl2vLMPaz+WspbJlruw4x7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076040; c=relaxed/simple;
	bh=PWvuuJ5e4H2DUvthkjCP3gTgVrBQD4efIsKqqhL1aEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GEDcYqMyYlcjAgkiUj1hliJS62sDUMENsNUJBzHotdmNdcYAPRi+pRdXsV2CKtrLU4AsCyfxrbX56/jeYTKmTnEAXXngco/xOGIpdZAQiyJa0aU6eRbwKw9J2az1az4HeHHcIG/VXCwAOF8wbLHrkk7EbFH8vfDozUgi7HD7FGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NNWv702S; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NNWv702S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS5yaHXV0v1Y++tww1CNiT6aB8hSz38RbbtBJCJEPAmuvmKna+Cv54ZAqIy8NoHGDM9BgOGlaVrPEgWSWigr2LRx8t8KR2jUahfggaHgo3MbWuHnw+qH6oCedL+64x/kiDr03UVoRdLrlrVgiKj9/fr4RLvtmys0DfIZJxjGqmbwAK5GCQoNmzJmnJwZQ1hSD9P/FzpBvsCqXo55bipxiQlFNpkgKwOiEnAnTx8I8j0VEUjA4KDBQbe/0t0I2SAXfxZN9DwSxjQILz+dzLTYhZd0oA2b5G0oAGlHmJHtg6MgdxnTo1ZI0dEd9Xd3sT+PmwRTUtow5kvnI/p1U/KirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUbFznDRlqAaFg/sxspFqdjQdRRjQjFhl/p/2D/pKpw=;
 b=j0h6gHsDzxZhjrpseUDecpL8jOIfVL8fcXdvGZ49Z5L+LwPS7pasuqdcus9JiGZQPGQcqBOpXrVj4J5GMRyPGjNm5TR+i2zgx3U117Lm5LNrdl1h+bwAVVVLfLJ1FsvT3HTe482YlgTUFUi7QG0OKIJOyJk/5UjwF0tSUTd9hEfSTaiNnjDECGE73hA5hESjzDossRKdtczXs3SNiKOw6uVQNeqodsdA/73QtOemYIXgatYDbQZgocdJ5MKa+u/IuDwAn3qnHSmzsRvGfkQGZbAfi34Vg7H6dVgEzfDIo72kkkn4nBrINdbM2gu0Q7sBLkBZ5RPJzldtkxy0qXjdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUbFznDRlqAaFg/sxspFqdjQdRRjQjFhl/p/2D/pKpw=;
 b=NNWv702SqbxPByIfQ0xx991tJdEtuBaFh7QXwHIe+4UQmCIneaI70Le2ROekF53crUZZgC9Suct4NHGEOUWe+Z7RwlsOWTYZyu9dpIMvUgG254rdOoNo0vrdredTWcWJ/ka7tguSWyv9Dd0/RiloC+4Tfl8CtgB3rcvMbIxIikdL9ixzi25IwB7c1dBZpF5wKPgvo1U8YdQwjqjn5DokIh5YTvixD8oJ+GAli9ekuatfr9FUoj/smrxFV8DIyY4UznC4JSSHKk7TDwIwwjAkXg0VIE3BjhfczyXrn3MCHI85ScS2oVyz+9yV3o8XkpEMpbF3KtHco7G0Db8rl8mfTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 25 Nov
 2025 13:07:13 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 25 Nov 2025
 13:07:13 +0000
Date: Tue, 25 Nov 2025 09:07:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] iommu/arm-smmu-v3: Pre-allocate a per-master
 invalidation array
Message-ID: <20251125130712.GP153257@nvidia.com>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <b6e1b5d0ac0157fc06b5cd20c5cd72caec892c47.1762588839.git.nicolinc@nvidia.com>
 <aSTRX5RJJhfNU6l3@willie-the-truck>
 <aSTfrp9D7i03XhyU@Asurada-Nvidia>
 <20251124230845.GN153257@nvidia.com>
 <aSTqw4Doipb+0AfP@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSTqw4Doipb+0AfP@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::14) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab5ae81-64a8-4e5a-f2ed-08de2c238d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+qle7YNNNor2HFAIUBbcwX7r1x3LHO60R8AwRT/PutDKgQ93wOTBl5RKQANU?=
 =?us-ascii?Q?HByA6bBCHsmRQXBUbJMgfSwmkWxLo2Nkv2ys5Xsa6dBxdfo4gOALMsMoXwpR?=
 =?us-ascii?Q?pBqkgsbRf/xiAgntpD6KDu98hfs7ixtBQAMzqwMYtxGC+T8di0YXWtMh4jZl?=
 =?us-ascii?Q?XIGttmIJnLqkx30EKiSetzmA5Nr2YYcbML1wkWp8nyPDQ8ry3w+z6c6ZViLj?=
 =?us-ascii?Q?/u4ZiH7O0BTRiUw7vQjK/UQIgS2H/PXd0+hDmUDFVGTjes3f5tVGRDoqwYxU?=
 =?us-ascii?Q?auhiV1kUkh595nFyKHEn1HjjZIrBwEojBWwrbc5eEUpfgpGZRzzAR4ResSUc?=
 =?us-ascii?Q?sG4s8KdhxiSKMuM4W33xNX69okqYMQ0JHtFQ0t0fTWVbo0zc7t8PUj5Fn5o1?=
 =?us-ascii?Q?P72e6ZQyR91gc/kWkRtGNt+ArVVIaglYm5CclcBtvYgtxqF6Y3Uqm/C9HvYR?=
 =?us-ascii?Q?Dm2N/UcMCLHUyiCHlZQyH+XVehdg5dY5nfrH7r+F7R3GReCsGnrd9nlv02rC?=
 =?us-ascii?Q?SZ2S3IFonZqCsAvCHzpDEec837HZmoPQEGdZHDxH+Yhn+uKnSssSdXV/9R2q?=
 =?us-ascii?Q?8QJX7b4c17jg4u4HfxBSnnMdZ9rRFnJyWbjepnnmxv+xKz766CD3/8OoWKRR?=
 =?us-ascii?Q?Ho0SCu86qWDz2R+jEtugWSiE6jU6Hz0P3+7W/uSWHd/GCH3JxRxUgqIkO4te?=
 =?us-ascii?Q?8994KhQq5KxCe5a9ZxfxZaF2UdHKYXO0Gz/OhQPGIxnnVHEiMU2v0yA3ee6m?=
 =?us-ascii?Q?6+OirIDpTr03blimnPXRqeZIgIb38Egay6fSKnRmR1s9a2L9kaBt0qvebk/w?=
 =?us-ascii?Q?loYte3P3zLcceVmVt61PqkXh66k4MCx9j7cJZSBljGF4K1EDZHgQgAeuKUry?=
 =?us-ascii?Q?HncQQcY3os+Y4YBdhRd5hiRtkMuLkItAhq9BevA8XE/TrwSGsI4THJGk9uVa?=
 =?us-ascii?Q?78wAX7QsE9jAaEHYAS9H7blwowZRIRuxJmO82kBLUkwDzzXGBJwQdZo8drnq?=
 =?us-ascii?Q?eMn8owzAfMyA3kPmWApkIYJY0WLUdwVbPT6NfCaYCwOlqbVM8Bh++cAmArBw?=
 =?us-ascii?Q?3LRnNoIullzCKHiR2qQ0A9gBuiRb04qByIAIuSDhKhh6yYb7UIntyBefFNQ2?=
 =?us-ascii?Q?lNYZYoajhQUli5HEcCZCFwADi0Lh8euOknVL84b4E49K23hirndjN2qxVzTU?=
 =?us-ascii?Q?LjoRuKdRJsmm5pCv5C/2IEokClVLmBbKN3fhtl/SkuEZ5mRb7JAFjXBG/TNT?=
 =?us-ascii?Q?yADTQ1ryFIHuN7QnUM6Dpw+kcujqxB8RNk22J8NWHjLaTz0hMHP74ddSYcLJ?=
 =?us-ascii?Q?SwtIchwZuVXWW9EemN5onreweLtkDhQQNFfqb82Idih0pdmAGgyDe6mFF4aR?=
 =?us-ascii?Q?tDcejy1VI7KsSui7Zmq/RB8ftk/MK8OT1o2E6p2DeICakggjwfp2Fs6de5DR?=
 =?us-ascii?Q?OgfLH9S98OgOQxKSMN/i7jGoK0r62EeU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ss4IL5NkJlZEBFfakzCAkKZOpmVrW30oGbC3eK05Jaxb0kbBg69YQ9t/381T?=
 =?us-ascii?Q?XkSihidS7JHRHhW/hZzLOVDVpmbZArbs+aE2QigUwDiHLglMIt4Nbbniuaw3?=
 =?us-ascii?Q?201r9dn/OH2/uB8DKFoV671lKtyZ6mZcuTy8BeDaWgqhBMT/OIxR4a9mNsek?=
 =?us-ascii?Q?TnJW0ApqgCyfDy1UjX+oExx/smimcGWCtRrwuTBtg7KauivwWMJG0IvqPjZH?=
 =?us-ascii?Q?qLnJfIlzGCOf1TyXxl604txekVSU/QYnC47dFs9vhvMcj8SPivf8dr0Y2jgW?=
 =?us-ascii?Q?qGWySJy5MgG4+TwjOwBzeZibAU6hKv6alKupWD8NiYuhue6C1eyX0XLxrsL+?=
 =?us-ascii?Q?7HTq9QBv37323o8Db8oNkT/b+LAXGZEdmESt6EieHL2+ZPBsgHF9iCDk5pE8?=
 =?us-ascii?Q?6T512Q0PuUxayT0Xnjh/8yTU/KasAvx2SuD09ZR0pErvzIgZie7Q65K7WWcX?=
 =?us-ascii?Q?HswSk5egrwE5zTf5WjEAPfp7+hnP/kX9k/kpD5H+7yInNyh8K1o45qlPvEJy?=
 =?us-ascii?Q?O2dIEj/NwP3esom1bW53FIqto1yHVZcQFWHnKNHba/qRdBxVyq02UAVTz5Gs?=
 =?us-ascii?Q?nGsLOgfZmSXCRn5K+H2HW9ePVW9NZz4GLEBRCKcx/tpknMb/0yCsU+8sf3XX?=
 =?us-ascii?Q?Qe6ZLZz8TnJfRei/AldwG5/61Ble4OpDG3gGQL7ODU+UGWPdY3jVwfqtjoE4?=
 =?us-ascii?Q?2qnYbNrrMMpffpvovL3V51oFJh2vVzQtT8T6vAUfBNgP+4WZvYnXTgNf8S/d?=
 =?us-ascii?Q?P8Gv4usa57eL8YA9aCFj6T0gfTcNqFEU17HNCxPmm8mESTMzpn5IIBetFG8m?=
 =?us-ascii?Q?YF0TGDNKQdPIS+WBnceLNi9b8wVsCjpgHcLz5WCDkNOMo58YiHNWIFb1MiG9?=
 =?us-ascii?Q?+JcrZHhkXkstyhjZyfjVClh8EbERSR+Ulz/OcflaG38yiPY9hzuVK8tQ7Qpb?=
 =?us-ascii?Q?PhoS6gzmGgxeRIc/K/cLNtfb/loL+B5yVl0axixIsO/Q1uxmo/FHQqoDl1kT?=
 =?us-ascii?Q?ZcTE1aI7BnBX7qrAXZhWtJiC0x6/4MJu5qU+3huftRdTeEp/TP06M/xdcLDr?=
 =?us-ascii?Q?gZH6a2D8O2UEw8GhjRXN+ng39AXScaDHK8N3Vx/UPrAufcWf81ljMPr1dBrI?=
 =?us-ascii?Q?2XHsHB39gPaRtfJftubNrfgfcydLU28xQCJl3GdXTOozg48uocLPR2a7lioj?=
 =?us-ascii?Q?KWJ2mS3OEE3jny6gY8o8EIJ+rTu7uZrqiTjlsy25m/o+9t9U4kkqBbnyIYpE?=
 =?us-ascii?Q?l5B7u386/PH8LpkIyzeXXdICkBGiEtQZmswQUoXGxhpC+JTPN7hHdL3htxGE?=
 =?us-ascii?Q?DEP97V5jLbQhNY3V57zw7Oe+IJjOuPt+vZuGWeYfDicbhA4fIIKjo9lkm41O?=
 =?us-ascii?Q?U8i6e7a6Ezopn1Dm0yj01QVK423RJTe+NeFhQT3Adj0epMqG+SGs4VxxUKJu?=
 =?us-ascii?Q?oe8aa/3OC/48ypj85HGDLCFzF3FGojRBd563zb+6OnXci6MPMWY8IOiwgoZ3?=
 =?us-ascii?Q?umPX9921iDT/ZaD/4upTlNlo3wPnLyLRzX3OkRejsAu/RCPRYHUa9e9bbN9q?=
 =?us-ascii?Q?vZD7QBafraLxefxItRY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab5ae81-64a8-4e5a-f2ed-08de2c238d11
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 13:07:13.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUkfL8SqTCl2cBcSiVi1E6UhiEhq52OS27hHbm2hes15RvWkSJkb10D45DZ7za2L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484

On Mon, Nov 24, 2025 at 03:31:15PM -0800, Nicolin Chen wrote:
> > If you want to be conservative then the thing to do is sort the
> > master->streams that arm_smmu_insert_master() copies the fwspec
> > into. It just has to be sorted prior to feeding it into the rbtree.
> > 
> > Then consistently use master->streams as the sorted list.
> 
> How about kmemdup() an local id array to bridge betwen fwspec->ids
> and rbtree?

Not needed, just like this:

--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3454,15 +3454,21 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
        if (!master->streams)
                return -ENOMEM;
        master->num_streams = fwspec->num_ids;
-
-       mutex_lock(&smmu->streams_mutex);
        for (i = 0; i < fwspec->num_ids; i++) {
                struct arm_smmu_stream *new_stream = &master->streams[i];
-               struct rb_node *existing;
-               u32 sid = fwspec->ids[i];
 
-               new_stream->id = sid;
+               new_stream->id = fwspec->ids[i];
                new_stream->master = master;
+       }
+
+       sort_nonatomic(master->streams, master->num_streams,
+                      sizeof(master->streams[0]), arm_smmu_ids_cmp, NULL);
+
+       mutex_lock(&smmu->streams_mutex);
+       for (i = 0; i < master->num_streams; i++) {
+               struct arm_smmu_stream *new_stream = &master->streams[i];
+               struct rb_node *existing;
+               u32 sid = new_stream->id;
 
                ret = arm_smmu_init_sid_strtab(smmu, sid);
                if (ret)

cmp would work on a struct arm_smmu_stream.

Jason
