Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA943C069
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865187; cv=fail; b=ZyISUFNI/2QC3twl2DFrVMAbevz0ZZZH1rXFjVi1mEx2a9u9XYRMXVIR85uRlylxvY8kM8DnPEX/EUTExd2EmltuRVv8RXoOw5hPhVJSpKlb5VwU9wKci3Og9te0h3IBk+4mmGXy9OBUmKNjo1YqL5piFA1NCsUadpfMXiouPUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865187; c=relaxed/simple;
	bh=L1PVieVm8HLXGX1YrHG7llN/vJuyBO1ZxLmc3uEC/pU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+b632aRqXAUBoYZmBmEwcX9Xyhp2RdM44XZQsFWNPGr262XgYGEpwG+E/j7AV6DLjvsz0bGaYmqssDwR/quCF0NCo7cxQhR82jZuYJKVMxJNMsh/2EyYO5hwXpKgktf34g8vu2udQtCGkqTCzrqG6TdkhxNRhoQm12nAwO55D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lx0BJ5Om; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lx0BJ5Om"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imcYiLTOw77ZfRuHqFAo7vQWQoujBJIx0XjoULDmFR267xtlEN8ywWaQCf5x9KqjzGyIsm2Tk6T09AHhsYy2shbdaYYLv6lKRVlNyj/IhYRnPh2LFUeW1zj7rZdtM/4w3oiLVLkmurExBk5whuM7q99A3IzDKWCywxvsZqxPZue25Ice/sZnpz+dsV3g+xzdBeDFyvCSaOyiZB8DcHIdm0S70K5kOkV3MVMRqlCx/MrsiMVUB6iT/qgQRo3QxEO/ReCqzq68NhODrrS3WXMnRfNfgL/7NgDMnglgxU87cLoS4DGgD3FrThP32JXEXXlXaNKnuXeFAtZvoMsMTf07LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwgclgBw0wHq1GhyqgZG93yEwj2QffdkDULvLcPvfEc=;
 b=aPv0RvjCcmd6/c3mtTf3T72+LSk0dSH0SnEdGXy31hDiz5vPQPBCacQXiRxNqbhe6BME19BBQv2YdBsA8B4k0akpTwyn2w7ox2ORTvFuqkRB23EeEJxCDpivANZcTJV9T+NiBvV6nnsteh1HyDLjyHT4kyNZpHOvAm8HL7DGM8dRaF8hZxAMsFC9tT5kxE2O2JxjL5MXfiXr9m8xeagMWUBSG+nyb8EO+FFTgPEHS7LO/IHnYaW8UIrhaUfvM47RT2ZRuOyfhM3G+pj/EOIZZVJoau3kapWShYM4LRnj7JvIrjfFJAGsn3f76gTc7+mStuOWX/QOaJk9qqe9l/fmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwgclgBw0wHq1GhyqgZG93yEwj2QffdkDULvLcPvfEc=;
 b=lx0BJ5Om6BAeTVL7yrFkKTi5R6aNrJ9BOnKFNyrhqcRejxznpN6cNxCzU1837rSIN/hDv9JBFwp8D3Qoj3BkGbOJXDWr4F75CLchrFp3SxVn027H5BWxbrD6EkJb+hHPq4Gw9dEer9NYDWaF4CK7OEO/bYXVxtiFI1ApibaIBPVNkUq688Xr7r3OU0IodPfFHnVnbv/yD6S1KEIbXW5HKSVwB44yEvzOZBhOsJAs6Pq+EnsexmMQN09xq5SkV59SFD9aVKYPhamxJLk3GbfRoXYzEvSqteQGp1vOPPuDuUt3JG9lyVhkWV2GWihkQ5MXewfLyi0czh4pwnM03HbdoQ==
Received: from DS7PR05CA0040.namprd05.prod.outlook.com (2603:10b6:8:2f::33) by
 IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 17:39:38 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::56) by DS7PR05CA0040.outlook.office365.com
 (2603:10b6:8:2f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 17:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 17:39:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Aug
 2026 10:39:16 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Aug
 2026 10:39:16 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Aug 2026 10:39:15 -0700
Date: Tue, 4 Aug 2026 10:39:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, "Pranjal
 Shrivastava" <praan@google.com>, Breno Leitao <leitao@debian.org>, "Kyle
 McMartin" <jkkm@meta.com>, Usama Arif <usama.arif@linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <anIjwUVvfWOb9xa4@Asurada-Nvidia>
References: <20260706084708.8072-1-kas@kernel.org>
 <amiBagGKn-Aym1DK@willie-the-truck>
 <amiz6GQZ-XGlH706@thinkstation>
 <anHxBh-xGW9JXsa4@willie-the-truck>
 <20260804141704.GB27883@nvidia.com>
 <anINkO1l9Kz8lTVh@nvidia.com>
 <20260804161918.GG27883@nvidia.com>
 <anIXDd839UC/M2n/@nvidia.com>
 <20260804165905.GH27883@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260804165905.GH27883@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: aa008f33-239c-46a1-b054-08def24f5b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|23010399003|82310400026|376014|6133799003|56012099006|11063799006|10067099003|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6j/Le6ZtSfZ/rGCCrrKofSfg7ngwyv7banwi1rEbTViCi81kim4Vzx9bqSoP1cD2Z/bv0hkSEnfhQ5HUICCP/B7y5OcJxbAr8JeRsdLW5iHY7/RpzJ7MPkcZnTsFjGK6WWNaAlQpgmD+lYbpTaeexQOi8LSMHj0bN8eFmjppWrtVNfhnrlWwgyo2CAnocp+BA1avwDf8Mq77vqOiRkT3geR58qSQ4bG2VlEPgGyzVagvJ7NqP+29Y1viXeJISQ3e9OcK4LLggru2nQ9YhPIDHABdo0dEC4Jsj4VC6gNff/3xtVVoGloxUalCklKMrP2jyKL6IfgvTEjV5eZX9uhvhWZ91BOujXb58701n79aWekOgxImRN/9YpcTUAwM6gvsk6+UoR05Ce7zD0IG9koLBnjMK7DJbfJbI6wlHE33VZ7zqyTKTnIW23oiVD9qCI5OquWYZs9YDpslYCMIhHYozcwgbxMLWAVXuld+GUkv5juDw3cdjq23w0JYXrBAZgOBLEueMJC8iUAp9qwRvMEXWXe2ocmPqJ1x/o19FFHxUQIgIYGFDNZEerY9wx4vrrIpuo4fY86yyw2WoYcMnfrp5hhviFfipEFPx/JwHlhtv12H19cShH/SKpRoFsG4b/tvK82gaK7kzMxluaIHbQMdRqB8uc9Rz6DazMV8rnrcaa72kwj6HsvefaaWfS3zXoZ8GA7CFTVZoRC1yu9nxSTs4w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wI3J8hUZJ9MdIIKpHABMcHaA8kVx7PHuoHm0HYjbxYCkMwo2rw2LpstcKJn5Rs6AndVfBbDV0zQx1QydzFVMpmHfWTQ76jJJgczJO657a3WCOzBfhU3LOjv88CG2OvchO5+rSV0RAwA5uNJ/COzinXDNt6Glklvvyq+x1ZYYNpgVFGO8ihm9+5Q90lp81wHJtsnwNUOXGij+TorD2HjfrOiVz1LoVYCkghAh0MVQ//3IYlr1dErNcu7I073gB+sCAFmtSGWMtHQEdqNT7Auu70LHBFqeU8v8klkMajsELyVeu4a63z5w5krnm22cTqYdI1RujHWDuDMwlaYRmtHhnicVQAUyBNgECpa8cEuWdceAYdh9G5cFDjwfFaAMu/LdHCkZCnH9q3YnZgoekht7rsnHgc6gNB/yxo0H1zpESlM7aV+FtoH5wQMKjRCJW5RH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 17:39:37.8848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa008f33-239c-46a1-b054-08def24f5b37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

On Tue, Aug 04, 2026 at 01:59:05PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 04, 2026 at 09:45:01AM -0700, Nicolin Chen wrote:
> > On Tue, Aug 04, 2026 at 01:19:18PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 04, 2026 at 09:04:32AM -0700, Nicolin Chen wrote:
> > > > On Tue, Aug 04, 2026 at 11:17:04AM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Aug 04, 2026 at 03:02:46PM +0100, Will Deacon wrote:
> > > > > > > Would skipping their allocation when is_kdump_kernel() be acceptable on
> > > > > > > its own, or would you rather see it done differently?
> > > > > > 
> > > > > > With Nicolin's patch, we can just avoid allocating the priq and the evtq
> > > > > > entirely in the kdump case. We can then add a cmdline option to control
> > > > > > the maximum size of the cmdq, which is useful regardless of kdump.
> > > > > 
> > > > > I would still prefer kdump do this re-sizing automatically, even if we
> > > > > do add a commandline. It makes it easire to deploy than having to know
> > > > > secret command lines :\
> > > > > 
> > > > > So functionally I still think this patch is fine, though yes it points
> > > > > out more things in Nicolin's work too.
> > > > 
> > > > I will send a v10 of mine, to skip the EVTQ/PRIQ allocations.
> > > 
> > > I think Robin's point is to structure the v10 so you introduce a bunch
> > > of tunables, including something like 0 size to disable a feature.
> > >
> > > Then have kdump default those tunables to the right thing
> > 
> > But in kdump, EVTQ/PRIQ are disabled, so my series should have
> > skipped their allocations regardless of the tunables.
> > 
> > So, I think the tunables can be done in a separate series. And
> > its use case might not be confined to kdump?
> 
> I think the ask is to do the tunables first and change your series to
> default the tunables instead of doing direct kdump overrides.

You mean the driver can override the tunables to 0 in kdump mode,
right?

Well, we are skipping a lot of things in kdump mode already; it's
a very small change to skip EVTQ/PRIQ even without the tunables.

If Will prefers this merging sequence, I wouldn't mind changing my
series to overriding the tunables.

Thanks
Nicolin
