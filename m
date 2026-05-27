Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0930B535
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849817; cv=fail; b=fCyjayFfkg3y16pCXHiyCVlWgKXRP+6Yk0xbsYShDPK6yqTTiU+tvHeIXssJxHwrGfkpBHJBlzRqEB0YV6KilaijgiIfZCiZptQ1GKJ5d+xDXOJWgsZDFNb3Zzdf9QGsxhVKJSBnnYE/DBHIEzUjirJQqzXBIRUqU7aXcjSJ1zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849817; c=relaxed/simple;
	bh=FBCmntLuZDUDowMCQ4WfnT/tzcL9eMGQSsSdy3lxNik=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g92aJZlq7RagX85VelPfg03M/upepSJ4s/BzBx3/Z/UG+qkGFvj1YtXLx9DySeyax/TCvXFkbHTbLUstHKZO36TZbnezFCT42FER6o4BZ9Fhzu2IK3jME/sOPlykPzwgN1v+VPlP/XtO4KDR1kKbNQwfSuVsuW8tro4eJQKO2Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cxDVhskv; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cxDVhskv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qy0WsjsiTxbF+NfyTjQuhZuKzc5sfieXChEEuPZeUf70zcKlN+IOUKKpYZOYXRsAsxKcTMLagQ9/DFit15vP0XmFO/o/UHh1vzWRLdpFcSCFJlW6MhIbhLv3kkqLKYtde2BTySeIaEVFnqn6wJQ4yeyTPTlupi0314kUAt8TRRC/Llbr07E8Ouu7/nyZzX1h+Crpv16ZxenYaxLrSRJAp9DLiql3lfyWhMkLaEw/5/KEyuLsk2CDyCRyEhBw3d8AZAriGeLatyLrh+fslBk7ZdJrw9v/w2VmUqt6px5rWcXT7pOs2OHZpHh/8p0qkSJTNvU6BNUtPVv7ZwzOnja6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5Mwubb50a3a1UbJsaANhGk4gwOh7jVnisci01868wA=;
 b=odRh5/n1/tr/vXq5HoQnEC4amWY0U21NthNzsvGJ5/nQVngcdf3hB//SCeHocP5H4T7zfqZCxSXY25VTPVbcUinPceG4YOM9RixyCXrmlKMU+Ldu4hbt1a4JoG2BYRrQbsKdebl0+DeWztm+Zc8kBw/+9cuj+XW2bz6yKUhawyT7UKLr6+HZnTsCuhxcAMRCq94ZQKpafyl868I8+bVqtUmoE4KTSCeTVBwcXugKxDZvdN0rjjlYKs2R03QQ7nO+aTSEFvfk76cpOboGgScnW2y38/cMNkVV/JesRPTYU7YjMnfGF+izaKHxQ1UFmSQwTnJGiS7lumQdiIGqOrlr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5Mwubb50a3a1UbJsaANhGk4gwOh7jVnisci01868wA=;
 b=cxDVhskv4GJOZYItI97XApUVYiZeHP2TcBmYzOYuBbZReXkcESqu7D89pex0VouyJG9rtJoS1l+YwDVHX6vxbA3o4BRpxVAhpgvlRK5/mNLkBX7Z7d1bNsbI2q8U15MZ7oW6YtuP1DsDZyQVmlNafhvNVzVS4/OHa2mk9jLpIm9cEDXU1nuebJHQVO/umEG66WUZv6SsHkgW/Ui0YRfkzQpOhb4ueLaQ1x1LfJ4jL+gwetqI3l9SXGjlTq5RO67zKuRcAe0zjRnzAczOT8zn0D0mwMsdgQabXG7SA5pyKShQ1CmLNNCfXKudWGSCQIEEUGnUuGqNJc2QAEUE3wOh7Q==
Received: from DM6PR11CA0066.namprd11.prod.outlook.com (2603:10b6:5:14c::43)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 02:43:29 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::5c) by DM6PR11CA0066.outlook.office365.com
 (2603:10b6:5:14c::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 02:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 02:43:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 26 May
 2026 19:43:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 26 May
 2026 19:43:08 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 26 May 2026 19:43:07 -0700
Date: Tue, 26 May 2026 19:43:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>,
	<wuyifan50@huawei.com>, <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: Add Stream Table Entry display to
 debugfs
Message-ID: <ahZaOpADaIep+lWs@Asurada-Nvidia>
References: <20260328101706.3448655-1-xiaqinxin@huawei.com>
 <20260520063714.2440584-3-xiaqinxin@huawei.com>
 <ahZUjmpkB8puCNds@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ahZUjmpkB8puCNds@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 04511953-0113-4514-b993-08debb99bbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|376014|1800799024|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	27PHhVeCVwop++EJhvY/60CmoetltPIb01+i9waT7JW4+rg8trohmpUdCldyGgUTPmN715pMoQAz313J9ONUGy/tpfTdwJgc/JqukvcSudGE2rCYuFaGiPPv6Ag5ZmVN8urS/LT+WOp9QpdBOV8mMz2FUDC0KyxslKTVzNlhtKsqf2QuJJ26aSmWXF91yOdqCxdkNp3mA+wFVPLDWsVQy5LnkTmN6AN+owXKn9+8XlOoCsVT9Ak7hIqek6pc1shXrLWz/D5a5dZip4FTsFMWjNZqmNrPxRJD4zJDoWCYCER7q2NbElyIu5mivpkGPiIOVls3Ne/O4sx/AKigGpWNiKTt52Bk9y1IF0RVFMlGhl3Q9GXo6Otagan/TUlDUvQDPJGg4f16q8jsmRTcX0k+V9w84UU3uB+VQBgCKNzCgZOiD1QTNDZlNyMKET5JwDp0FVLrXo6ULA9eDM1aP0fzffHzGUxIFSRpMzGsv1abJyhpMVS5M0l5llGV1aTV31qcV4vMMVyP/2vH2BifpxbjTt3kHBUvoDz1AIp6buvOMzjXbkP3mdu/BPcmZgYSZc+bvEOJdPqU/VmNz+OOtUktAxLNC28yUJLsN10rfgrxKEopd5aTMI0NllF2yQSFkvqX+pjCcI76ZfcJTvv+iEzyX9croyffO7tYSyQQ2R53XZu1BlEneEIRkNjwsTcruI7uuXPlNJhCI9+izZG8ag+5HfQIXXogNaJ+uBlqvKD/s08=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rl37XMJLBAi82Vwo0yZDDvcyFb9xX8bW3AH3ZQDOyCDH4/0TIO8SG17GsPZLEoa3PxRGaX7QQ6gzX1vtB9LeKL5M3Z8bbp130QDqdxwJkb1wDvzK7Tplxi35eNzYTV04JfhYPcRhFrkKMRL+L111IY7oaQtxdIv3TgEhP/LrEOEaybHl41LA6vxB32g3V3WANuKxp8qxVZ+PCRKEzkJ/BjsjaAYJfOf5bR/jthWb/Kmc7yAgwRMLYL8xf0rEWM5CZ8JPNmMvhQcPRb/W22arGfQnEQ8IG8C3oNYVGig/cVHZ0iqu/sSJWsgmz0fz7cJf8QWtJ8pV9l8J9eMIo1NOI+AZ4I1RWBjjplGd5Hw/qRxgiOiR8ZTLyVaGkSO6A8EkMT4096fl7HmGuhciYYMnugH03zL/ZqlNiKdcGbr1zupJWqWhzhXDHXTH5fhaNVqy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 02:43:28.8714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04511953-0113-4514-b993-08debb99bbea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

On Tue, May 26, 2026 at 07:18:54PM -0700, Nicolin Chen wrote:
> On Wed, May 20, 2026 at 02:37:09PM +0800, Qinxin Xia wrote:
> > +int arm_smmu_debugfs_create_stream_table(struct arm_smmu_device *smmu,
> > +					 struct device *dev)
> > +{
> > +	struct dentry *stream_dir, *dev_dir;
> > +	struct arm_smmu_master *master;
> > +	struct ste_context *ctx;
> > +	char name[64];
> > +	u32 sid;
> > +	int i;
> [...]
> > +	master = dev_iommu_priv_get(dev);
> > +	if (!master || !master->num_streams)
> > +		return -ENODEV;
> 
> The caller has master. Why not just pass it in? Then, you would
> have master->smmu and master->dev.

I forgot that this is to fence against concurrent device unplug.

Maybe add a note for the reason of having smmu and dev instead?

Nicolin
