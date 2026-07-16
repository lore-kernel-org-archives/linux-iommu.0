Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E4329E6C
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215135; cv=fail; b=iYNPO/r2FcqBovCWfeoPG9zRQkhKn5oH8qFxGLeuTviQqcYyOubpARrvElopcQmCCWqiR41dze1zY/BvdRF3OzGhqImk+l8h3nxoUkvAimiWVQ+6fVzKmzl983HKCo7HAtCnyF2HNBqEsXmzSRQ/xV3AOT4eCkAbPFBcefaKKFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215135; c=relaxed/simple;
	bh=pmpPI07MDN4xgipSR+CFFFlaIM5YWSQWsm1yzre5g5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VV87NNiPC55bulOSYvbSLqCVkhWSVhkJzuFmXcphXG3kGq6Wk0Na04q7C7h9+h61xVodDlh7sImpRgWiI/6ZVPuP8y9aEb5075+CL4aLEPxS01Xd6HOrU82DxAK0FQqrmZntIi61Zzaihdx1LxzgeJaTkr1AW/x8b7yki32nxdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kwj4lKCz; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kwj4lKCz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqzoSfaJBStZslUZsOeLsmf+gqcMS5u6YxCfqdhr9Kx7dVlX00hMjZJtTyTnzcsF4wyRaC2sbDw0huBbv9osutTukDElAJCdSZ/Fdq93H9SBAQKr8OJAel2f8esgEC9FvemBeLsE14w7/qtNuW9YpKywwmVh7u7aOZw2oWelkiZnQFUyx74Op8UzlgwYv7k9SSDH4VyieOJNVqgu+9O5VlXo2XeNueUrl+fkGpXF/YpNCz6CO7Gz8+LxrscYo1S/MZsc66U4P/Rk3Te0z4eoVx6Q4kcC0XFZ6M9q4pI6xbte6mJR3NDtYGlLQKPIsRuyexjYeJCrCC5/Qhe+zusMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XokQrfMF6zAUhbROxE+ZUpCq7eoabTlLvVf2YrOd0BI=;
 b=JyaGKna4qOxm4KojgQz3f8KrQsHS4hYkib98Y+A+Pm55yV6EO8vR8ckUktijRjPi4pFZi29YTSn5WZe4Npt6KjxtmSXKGbsSm4ikXYw1OvnF+Z3qdNk5TO4OTi+N4w4XYYaVP8qTibiQM2LAcHMTsbA4aqlIkwnykVF/irMoTTWSfhJmFz3fDkStmEXqzJ+H9eBAl2QVXZrm0y2EuzyssMOWoW082tbdd1aOixj1h1sP7edEmEv2b6/e6qWkyUnM+D7KDmAinTBlaWtNJPvnBb9Rrn7GjJuyGQkNchn5o3PycBeD/gV1SzFv7aXnCgT51qucxXpJUe18dXO3qto15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XokQrfMF6zAUhbROxE+ZUpCq7eoabTlLvVf2YrOd0BI=;
 b=Kwj4lKCzaZTsWYmv0QOJodWyImMVWl4zksyL/LO9Gh2j+bnFr1nArWQC3mVEkzY8g7EHq0YOOuJy5zxieI4UfIX2SzAOxGtIsqxZ0ZRGHWXgoO6aD9q6IPNt2Ej/rMkXdYdDDAt7UNKRwhXNrzC1eMvb4Uudn4aP7Xre33T3YaN0T6x02dAfN9kO7iPiqZ9DheJFjygfSre/CiqYg7qFiDQxgXyLsc54VW5ujetOIpcDdd2mMYveEYDuR6CouBb0zsW4Wcjgn8FNST+nBZSZmZQu8D6lDGqMA8DPLhEItHNawTtB7vWzUB6WUv8cj87fwjWGTJj8SUBqxsHa2zooVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 15:18:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 15:18:46 +0000
Date: Thu, 16 Jul 2026 12:18:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v4 0/6] iommufd: Iterate the cache invalidation array in
 the core
Message-ID: <20260716151845.GO3775915@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
 <20260715201521.GL3775915@nvidia.com>
 <alft3llhZ79t17j8@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alft3llhZ79t17j8@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0421.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3bdced-687f-412c-db78-08dee34d879c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|11063799006|4143699003|56012099006|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	mjfTRxba0WRAM54CyAlcm6G9Vu6Lip+/jbhcL6P+ymRqsLa0nYLWJXEfZj36ZVkFESCiPiRU4SxNdnfaE2VNII3O6f0EhR29D9y3NUQR6k69EFcn7JStCyz7GMwO7VDFBVpnBWji7OVnXeJYiK8IvCOmPB5eRJ5NtEX/5xn+n5Z6nlxOMjw0Ljix2F+LlLDw8K3J6T1xcW2bADs9pRf5me4vmUOyCjAmrQ2wkeIEM4fJ1XGy0cqYQSP/aGqZsHzFAS23fBCPRZ2+NDv2x4zVLVh9JAMtkHCUDac6Mu8dxlugQNw5RZStIv3yPvZE8gudO6pvuNrxCG+g+QV4ZKifcRC0aTdDaFeU1VzG7AbwMGwi1KJJI0uQVRL98XjkWZXbL8ThtpsjEKHSfSRv6hZUhwQxGZ2Qyb3WCvWat8c3tLOelkaoDyS8Z38EcfM3krD1wb980IJLLQnsa4duv2jm7Ji/DnGHBIaKy0VjwVnWyezC5pek8nswmVfL8nRYnhDqgGv+/kaIsyMKR/nmGgUS+QpAXZEo0FE821+27yZBzN3fQZ+BxM+TbLLpYI9f1U7Ihb4fzdrQqqOTyCmo9A+rAhYRMnrThHFB/p3FvD79s27zMX4tLUtR/26u/0gSD3cKYIlCmtm1igG4eV2LKuHNJbuDh5gC2+dthwy0V0+x2eo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g6KQ4g/aEke3greBEqmoD4JDmaoNX9SH/VvH31Eb2GmXLl6lCbgcyElMqsk/?=
 =?us-ascii?Q?vDwAGvOD6o9ZEofomZxt2f1P4By/sfKLjo9qZAoQ29dyVLE2s0HwQ99dbBTq?=
 =?us-ascii?Q?yb9oPvgEMfK9KwZDtCVIWvQD6JPwLJ7nSeIdKbAsVn0NujSXiEG5v5Ll9+ha?=
 =?us-ascii?Q?Zc3xkOaAw9DJN7Xu3tminrV6UPw1knxvw/1TAXVZXjUiD9uaMi5zEeAf2ZAA?=
 =?us-ascii?Q?OIwnourOR4XDOIZ6T7NhiYtQfIRvaYOP2/raSuktYjRMLsPNsMA8yA8mSuyb?=
 =?us-ascii?Q?DKM6FIha83DyPYg9AIz48ClF7jjrwILbQCrl4Zscb+Z64YPKJTi5jDUmF6Ax?=
 =?us-ascii?Q?MQlTuUN8uzYpKozjhmZYQmvAHFpHXQRF3zJc96K/j29KUmynFWejaEfCkkcu?=
 =?us-ascii?Q?cixn5m6R5osTB3Co87TDhDEpTWrSZOqklw+fsoRdva75+SwQy5p3y+rMUab9?=
 =?us-ascii?Q?NX1dhwrpYZczhlZF4bpwTwp8wDMBiDcfNX88FLf1xZxE9yTH72L40tHb23+A?=
 =?us-ascii?Q?P+1JkRjyhjjpA4eGlPcdd0l7z4emQfFDg5NRbmVoolG7kjZAOKfXwXp0rFUc?=
 =?us-ascii?Q?hnMAOXYBARZyqz4vDXPwzccVmtrGdUvlHXr9/ZF+YUCKd52JentR1W23i//2?=
 =?us-ascii?Q?XhDuylFmxcmbOqP1d+CWF5sAK1a1jd7p4EscnCQhMCTNTqFnK5mvSlt4erBg?=
 =?us-ascii?Q?/JGRWr1EXbNsDXhJgryXiyzVs3pNrmaBq8yYrhB7RqZoN0xlmCobDj7LXysu?=
 =?us-ascii?Q?qqvYhVKIKgNpWflgInIq2QoKnpiObDAvv97HqqYKpKpWWQX89kKefGdCA0Cz?=
 =?us-ascii?Q?FPQfEyNcEvpotfSMAdeyoDSCOkG0181BTtUrXeJIofJkPUH+Vns1tWqwzfJR?=
 =?us-ascii?Q?aQPnz3VdLeUo8lz1FLUD2ivx/KX4Jjza+1pttIaTX4k4ZEDz2PHcVoXvOZ9N?=
 =?us-ascii?Q?h+Rxn7Vj4ieXYEVgPWImAAa3sNcVLXiG9Ys03HQu1KuNGHYUg6tBIsNMdxJK?=
 =?us-ascii?Q?GFPic3KvPES/ZyAaXxyVdrZ8BviCaVp6KKNsibbsesC6zkv6JCLblvlIFs9D?=
 =?us-ascii?Q?0w6l5k/LtdYjQkeSgpbCyrK57YTMHwFFavKJ1BSpNfe8KQzvGYnuMddMi+D7?=
 =?us-ascii?Q?71buMPvP0qvOUt928Kbo4XIcyxUWAgOnLgj845fA6WBWK1Tz2NZtkPjM2Uli?=
 =?us-ascii?Q?XyEXspQYVAU4oTWE+X5gt9XDF94rlpYCTF5BVgC0dudwv9hvHpvfD4zOPN1v?=
 =?us-ascii?Q?GXJMSA1jKAI667eeYqkwsNmpUjraB/jQ7qdYRA4WPC1imT6RYRGAWcuXWsNy?=
 =?us-ascii?Q?Nf+NHbMyTwmuCYzfoNp53dcLKCY+pHOK28waB+LpOe3zOBq+gD4S+m94/4go?=
 =?us-ascii?Q?6dR392qOrYJavsoz7jXQiZOzFB25SAAMFaL2N3rzJfkpnGhbc2adq+mEN8lE?=
 =?us-ascii?Q?PHZ1hbxvgz2SpbuP+PPmwZwkUDJpCyD0gDnWPo70YTC2A3uzYo1WwFxj9zON?=
 =?us-ascii?Q?BuMRg6ArsNYrSr7ez8zRk8qtGexYwk7GaF/hjI+FZNdnoYUlDRBwPd1RgbXB?=
 =?us-ascii?Q?Dhi//hX0dE8x+a4sg3lN4oZlrCK70buYUfk62p2JEMasgdxtBWOegUe0FOLt?=
 =?us-ascii?Q?mrnvOB2QX2Kiod6q5gIpoMmL1e3Iusm2HEHjkHPbC9lcepUN1DOtnSXR4S0f?=
 =?us-ascii?Q?NueLiCm5U2lXVX4iPYkgibgtnTRuEPqe5zIEBUZq86WiPxNl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3bdced-687f-412c-db78-08dee34d879c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:18:46.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: as5QRYlpyFVYGmPA6U9RQvyayvWRTlvfiZmzVPIQORHUUhjLdPQQ3zPLtNELwoaj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316

On Wed, Jul 15, 2026 at 01:30:22PM -0700, Nicolin Chen wrote:
> On Wed, Jul 15, 2026 at 05:15:21PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 14, 2026 at 11:48:46AM -0700, Nicolin Chen wrote:
> > > Nicolin Chen (6):
> > >   iommu/arm-smmu-v3: Support IDR5.DS and widen the TLBI SCALE field
> > >   iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation
> > >     commands
> > >   iommufd: Iterate the cache invalidation array in the core
> > >   iommufd/selftest: Convert cache invalidation mocks to the core array
> > >     loop
> > >   iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core
> > >     array loop
> > >   iommu/vt-d: Convert nested cache invalidation to the core array loop
> > 
> > I was tempted to take this through the iommufd tree, but Will, I think
> > the first two ought to go to -stable through iommu ?
> > 
> > If you do that then maybe I'll pick up the rest
> 
> PATCH-5 touches arm-smmu-v3-iommufd. Merging via the iommufd tree
> will conflict with the PATCH-2 in Ashish's series (via iommu):
> https://lore.kernel.org/all/20260714104202.1664187-1-amhetre@nvidia.com/
> 
> Maybe it needs a shared branch; and then, Ashish can rebase?

Urk this is a pain. I think Ashish's errata fix should go first so it
is easier to backport.

Jason
