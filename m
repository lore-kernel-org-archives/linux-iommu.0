Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC046C844
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853073; cv=fail; b=K2nS7U2i3sqWQUcHw6w2hLQjXQkJEla3FQgf2E2KRIPSuDz+CAt58zJU5aXVdcOV88i/9fDjknfVrG/gvCBxugeufj/JaBZdaODXATkw/LJsSpJvYpRuQfmO6i9JydiWvxicoAqRnFoQ97TjzA5HWIwD+IhsDOEwHlD5MyLEjvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853073; c=relaxed/simple;
	bh=Oz3twWnAwcIxX0YD7LQx2+d3BIzLf5su2QJFX4n/+qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4kM4cTAfoDyaXj4oX8/K/kckuOFk7BsW7q1RS1KPJikFcxzsjD1scIlnxLa89aI6OZATvBjW2jzwYedPS4PlbuXeV9CGZ24kQlUuBjmK8jmRYJUdQ1DaQ/NgYbwxu75Tgl+oA1G2h1/r2JFkaEg75w42HohSNk/IP2yR6xAIqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z/8aO0Kh; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z/8aO0Kh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9kHxr/cH8bbMgoG39sEgiTJKlm0PdHA7UiydapCbZi++RdIY7i6JsIihmnanc2u2jbx2wcO6Qqm8teqPRwz+NAFAhjcUaG8BnzQIxusS/VXX72LBhSIdY9s+b+rIIV/rOEj4XoQAPy8yqoR035micLvyF5mpoFUWaBBM3BfoFV0WgyWlGVoudXISsfR6tcomE9LrHWjUsJVQR3SjOYm+4aEZqqjbmgbQIB1ikbBcMydkggBcBhhSkdLvs+2ezQkNEuXmBKCGMqylvtW5xWgZ/esgKgUenH7Ikat4nnTbE/E74c+QDkHkqLvVihod/ahrD73dKJm92EzPepuwL0/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmuaTab2dpFSs79n+4XpJopimw4CAYA4oHPGLF8SOpY=;
 b=VWqsVQYVefpyiBscTIPEYA38FuPm9Uyw4evA1q/Pj43Qysgr8VcxyGZz/OWvkMxiBG8AXPT0d/AGwaDEnmxupvZ8j+gHReq1HHw0qhSG23d+oG5cMWZLvqOr6FuvHC5Gwy6EFtYkDORycrIAuu1TWcjnLccqmC8TVxzyhsa763tLplxt+nT9iKpfxWW/xkfmDqP3K5DCqS1ZJQWX7qAp/s2wA8HKBj7tfD1Le1DnHzH+oovU6u4Ofxfexohj/pUjvCQkXodDDzNREkitOZkzSrhSEeYkqpcFU9nrnU1iKT+WA83HVLlyGnx+iAC3VL/KhhfpRPa/GbUwR4NFoeekJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmuaTab2dpFSs79n+4XpJopimw4CAYA4oHPGLF8SOpY=;
 b=Z/8aO0KhEgT2WCHp0y2BfTVaE7rhZ4jxQjeRJGW+1uI2pLDMM4PIHROx5UuGH9Aglac3asUQ2/1pZY+8gabKHsVVi0rfaZA1SuQtRklnGDt9ws52ROvuOvmZiY0IbFXgjFTb6iGXrOV/tWXt6JVPOIi22cjcw8s03/j/6Q3NUjv/t+i0cNsGuPkotRkBTjGvOuEDYJsPp5lWqcpCsVfl3uYQjn3RgfH3WGHf4ZHnkzeagPtX8sghLCvxmImRMiq48hWTKOgRhbryRaqg0T8DioULpQhSv0Jj3b4foXm/L0LJDDeLF1ZW4IHYzOcvSVLHZXfOreWVhJ4aQlrIc1B4NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 14:17:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Tue, 4 Aug 2026
 14:17:05 +0000
Date: Tue, 4 Aug 2026 11:17:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <20260804141704.GB27883@nvidia.com>
References: <20260706084708.8072-1-kas@kernel.org>
 <amiBagGKn-Aym1DK@willie-the-truck>
 <amiz6GQZ-XGlH706@thinkstation>
 <anHxBh-xGW9JXsa4@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anHxBh-xGW9JXsa4@willie-the-truck>
X-ClientProxiedBy: BN0PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:408:143::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 943d4c6c-39a6-4f27-ac73-08def2330fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dRkV76r0WmJTY2qI0bKjX1KkwquNqAeRJguZEf2mzPI23fTxdTebYgc+ckyhwV1DuHUwmEKNC0SxAbJC+03CwUDI0Gx7MRfGXgXgjlTtKOHaTef/L8upMCuvsnbg4fKOnKY5n33NsTuWrRfZRisC2eVSe40TMeEeK+D6FyCrRQHLchMLqbg+c4srLQwuHVk68g4dv6q8jTv1NvY6Rcq70aAERa55k2SEzYlzXYVjQOmDhWVzaD/qcXA+sHjIwnFYYafAAcIF6rtA+q9CeAN5JfwpBeLaKoNNg69OXdItlQi1gqlFZakMt1DwOSgpIvlz3v2ECByqonrb9XApLwjL8KQxVi9ICTYn1TO54pUuj3BAosileN3LPeC6CmJ6AUKKqrf5Qd1FCnwbO0p1LRwQMevwWKtg60uyaVhNYeXQykVpNPeA82LdXYCZxGU+29rtAUVfpgaxaVA78ZMB9zNo6LZHTSYWeV+bxra3fQZ+giOqgY4VPsSmVf+vqV394JKA1hnqMTTLcmk3j13NihHekeCXTR79dppepPK0f8JjUgJCKxvy5BgcA0gr3lC0G37NnSkHcYVTi9rRZnBSENw43HJJboBy961kFii1axJ9yC6JUSqcqnmaTZEq0rD/mg2gI6mQmvpe8PxlwR80sn73rl4ucvec1QzMWOzKG9opLgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zKVi6WrPjT5u1WU/gZfNqnl6+m/w6pVmX5K84vTaBpLak4JVFlcfmMj9OhfT?=
 =?us-ascii?Q?Nn+bWAMpmUYFjjeprfmQ/Dv1yhf0orCUpPBCrXL/M0/ucKpEJb39pEm9qnR+?=
 =?us-ascii?Q?zn4Kf4LtGg4ymnoGQLdiDppQitrwDWI71/zzVx4p1An0ic4ZiItnXrIHeuqi?=
 =?us-ascii?Q?w4YXvep7cNFKGQ24UjfFayHfvhqldeyrNVv2s31j+uYS+nxewgAi7mGE3usG?=
 =?us-ascii?Q?DcIcDtyJElDD5HlmM44y6F2De8nlx+jnswFbF3x2VX3g7JC7Z9MpEp4+XB30?=
 =?us-ascii?Q?fMnQROxNpzcn8ERwPExvstUnJcmFBBBYGm2zj8rrZGU//cJa9seG0xwzSYdz?=
 =?us-ascii?Q?MRccBMGkInCDrPrWBlz0bklTN+jCVE9Ot7b0MgVzTBgZeDgtzxitJwT9eE32?=
 =?us-ascii?Q?lcYA4pZSwgIL3M8dD5sxvln3ytHeTdz5ahCMBoNBLhLpMTv0JHxitPDZLrkM?=
 =?us-ascii?Q?5kkD9CEBBF1ArcM0Z3am89vtlaVqxn5c8T3p7tbraKdVsYohZPY/WKH3kuRO?=
 =?us-ascii?Q?UT9jyV1MxK9iiQpvGB4DONSp0L2qclYTPdS5J0KLjPgVgUuRFniEFhfYkNTq?=
 =?us-ascii?Q?H5Xn0GMWQP9d6UO5SRROH5U3p/oHCONRtEgPuIixqDLIMrU1WTNG+UydT6BB?=
 =?us-ascii?Q?pyI2wZwlxi08jZ+QbQEAakTTatY7p4cXhpPd/iDRTe20vVhR/O6uS9fSY9G3?=
 =?us-ascii?Q?aIm6SS+Hw3xPXln4myjhZeAJRR1goxeHsZWEihUmrwuHnPSH/sym4ruuLwYe?=
 =?us-ascii?Q?a7n35QA1AJLIW6XZWHfp4CCVplqoo4GT7CWYS08n5HV+v8O588C8MlPNczng?=
 =?us-ascii?Q?jEusAXhpb9YwB0jBAF8p8f4wzB849QvBlnMkMWiq3UDpocaxu9D8gfSMNaqp?=
 =?us-ascii?Q?DYVsg9EfVG+uM2chA1cicuqCuGDm0CK9UZZ5PBhhJA/p2SY85orCO1fgVNGr?=
 =?us-ascii?Q?THWU37Yx1M1dCocy4J7x87dPhye3S98qONHA868g9OwzH3dW3aPft+A/zJEK?=
 =?us-ascii?Q?+973kC60kBY3ZXz0fBeOIfW1+/KWIYp2ZpIeFeQ8ErCHqylduNxrBMJdSPWA?=
 =?us-ascii?Q?JwUm5gZtthM7ZIZoi1yfzVLslgkXVmbmA3DzTs2P9KqWqUzjQSL4d/VF240h?=
 =?us-ascii?Q?kTDoZyecbrQf5mGeNL7Fe+S6uI2G5mkLus2u9FQCZhOVL3bf6aCY9JK7FCFt?=
 =?us-ascii?Q?czHjIcI30r4EfX4liTNJj45mSOZK9/OiEhYh3TdpjFITtgG9Ca65cCdy7grj?=
 =?us-ascii?Q?a3hwuURn+ykgM3kUzU/Y8ggF75L3TwQFE8Kp0wsxI68msLv3I3/TziBAaMAI?=
 =?us-ascii?Q?apEVLNfesITzB7PQlXtTcjiT3AIuMnhiDndltRdWUWrjTEYcBUjCQ2zgd0DM?=
 =?us-ascii?Q?zwhUiHz1iODb1bwAvbKWJXYY2lBWM+GK4or6eFJD03pLEyQc2G3oJ4u9Nx4o?=
 =?us-ascii?Q?aZVwHFEFafVNBrjuJrOAxtOWA8j06+qv8CDRZpkQwZTE1YuJvWs1T/zw6Lwq?=
 =?us-ascii?Q?7PdBsFZ9ylsd8grvaSWPzWTYHgkDe6qOkklGcyREA0RuXwJ5pcyEc2RiMF1S?=
 =?us-ascii?Q?yeAuvklWp8BbpJngbnc6EIIpNuFdyvu36XhGmqwGnejJ4P1MYL7Al73CCkwF?=
 =?us-ascii?Q?jpIa4B5y0UCSIiR7b4voHahFJNvH2d6xrQ4Vr4gX9y8ZRmqVGTjGCH3owPGU?=
 =?us-ascii?Q?aS2lpZMg2UuZfTL+C2G5K5krNuoNSWcEzTv4Lue/aH0WBcmMWURSNSiYTT0j?=
 =?us-ascii?Q?TYWjPjy+Dg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943d4c6c-39a6-4f27-ac73-08def2330fcb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:17:05.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7ZO3wAW6hpNPnTC5z63Po+iphLSzhQA+87qtJw/Ira6hY5emVEu0gnAksafKA1g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988

On Tue, Aug 04, 2026 at 03:02:46PM +0100, Will Deacon wrote:
> > Would skipping their allocation when is_kdump_kernel() be acceptable on
> > its own, or would you rather see it done differently?
> 
> With Nicolin's patch, we can just avoid allocating the priq and the evtq
> entirely in the kdump case. We can then add a cmdline option to control
> the maximum size of the cmdq, which is useful regardless of kdump.

I would still prefer kdump do this re-sizing automatically, even if we
do add a commandline. It makes it easire to deploy than having to know
secret command lines :\

So functionally I still think this patch is fine, though yes it points
out more things in Nicolin's work too.

Jason
