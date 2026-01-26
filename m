Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014533B6FD
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440831; cv=fail; b=jWIVy0lfprKtxAHw8Rx7wcAwcG/vuYrf4QnmcnCKts85FVIGmWFrorQH7Prjwk+e2Vc8wPeLtD/yYmhoeaEnbHIOILEASr3PvwB+eszeTNqCJL065ML335Qvn7dG6EEEVpj3lgeJoY9cTCiREGnTYcr/ZddAwiCVi7U5lbZlpaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440831; c=relaxed/simple;
	bh=/DbjMIMcID0v7CMwuUEhLMb6ZKlKHVkHim9SQ7fDQ2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fkKI2f7DdG7SbcM25u+hUAS3jAF2Kcnu7KaWoGApiSl7tEIKhjAkpGfX5Qx+pi/p9Uzwt7W9jOZJQo5AoTbQ2ftMc1Z7cfNS8+Q1y+l5FATYq3P4S+1uTM1eSq1jWwkSzlTEP4PEvwk9fYPgx7CbkM6D6ggUB6UNjf7zd9b+RSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uFqadPBj; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uFqadPBj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ymzb8Tdr0CrDVSS0UJiytlRRBDR5HYHtswSaas2KIb2BLsuvZ0gQAOmvMuy3ADRWAQLQTha2zflEnEspOHKaP4HUyOB/NqD8aL2V4ofRM+l46xEsW15eOeBDBnFpw68kVBZWY6M4AHXOkm71qGpYdahXdVdBDGsRDh47AiwJksYA4yEhJCuhJXssoUVvXVmWtqbVZlkwsSVxzNE57UE7jwBFF1Gn/oSfeAIsQ6bqDMroUK97PWlvituCkIn1Sh65jEWSeFjZjyvGB1tcxG+cUvYgbiw9sC1vvfqkaYGNYJeLIX/dNipVEySDvGxt18dU5YbtmllPgzBHJ4MTG55a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USAWvyGPbX8weMuPil7fIhYnN3agyAuJuq18dFDOCOM=;
 b=k7Hoh6GrkOTVlaHrP/RVfnUHAslyQ/tK9xgXiT/la1wl6HYxzC4Gd4a0i4YrvCnuxC7eeBec5lkljOqoEdWjGUcQQ6NiqiYBaM+5phe99Bechadsxn4j1SzZSKMrvMRszGOZBBm3LCGxDVixyrUPUgD54JiEjaYyzlUo7WDm41Y+QduloUyJvGRYwmQ+g9nIWW9/7arWV/Te7XaMcR5WIaqFsiwWvVSIGwtfAr33mJU3IwDRKU/2dXpFgnqayW+9vdIDthCkAlH+6LZEMyCr0MePNrFkWVgktDQ5MTId4W/l1lto2KPLHmffV8tJM7pYiBns54eprukPmK1zykfO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USAWvyGPbX8weMuPil7fIhYnN3agyAuJuq18dFDOCOM=;
 b=uFqadPBjIY4s1Te1d6D0IrIJX54Zlcs8TOBP8z2caooAXIsGynYDSMBwm8jyJpdz1HLEy0TkS7lP1CALk+VDbno+3+2eRWwnZ4SssdInGlXKG1Qu4zdJ2LzjWylkqfUg8JH+ZWmZoS/JgzcJdk8vFSVoaf5tkMDNqiMnKjktqOf68Tsrvsqp+v7yEeZarCpHJVFSR6q3K2Ozl73659gIn5uH/wZOD4MH2y9QFsaVOGORpxLW8MBGKp5K2V0zAvCpMnKrmaYcgYGy1m3xm7Z9qu1TLRBy2rYMDmfoOER4DhAJjnoJ9Y0rEvgkhpe0gRrfvN2C91o/CcU2vnA6B4dprQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 15:20:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 15:20:20 +0000
Date: Mon, 26 Jan 2026 11:20:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20260126152019.GK1134360@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXOqVcX9YEC-Ikdt@willie-the-truck>
 <aXOrnMLLzZL9BtRT@willie-the-truck>
 <20260123200327.GF1134360@nvidia.com>
 <aXdlnLLFUBwjT0V5@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdlnLLFUBwjT0V5@willie-the-truck>
X-ClientProxiedBy: BL0PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:207:3c::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 79246377-5d6f-457e-a18a-08de5cee6b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njK8MRMkKzg8DJ97g80CiK+g4aHLvocerRJhH3mqPEd1lAwd0HuLjkePmKvR?=
 =?us-ascii?Q?ibaXvESkxd3AkkGEDoDtq4P24o+cha/6eHO8MMV8xkbNiSs9SXZUqMsJnO04?=
 =?us-ascii?Q?JY1QIFGwNVD5x+VdyyLMXKt7EnlYKn73KvtvwOxDimxmfEZm7Anv+ag8lnhV?=
 =?us-ascii?Q?98Nyi95pjT+utDEgEf/DSnE3Ah3mRY2g8AekAh+uYsZpkzPLf0juBAxV1bLs?=
 =?us-ascii?Q?35eKHZX4OsM2CZVsn9JSXD3eHilX/bmKOtJxIi7PJKVV90bo+OQZr2XIBllR?=
 =?us-ascii?Q?6cx5YEoGSbmbc5QnZz7eBzG8geCOtyQba0VGMd8vQlJXyILXZfXfVWAx+6e0?=
 =?us-ascii?Q?bNGdZ364po3V008oL1Sda1BaraqERltdNT05nZCd8EE5WAqXWU/kqBV/0X7P?=
 =?us-ascii?Q?ub36TTFL5mmQmN2zLAeHfK5BVy0i7z0jROwopBZ1/XX/HVbrXcRSsbP87WVN?=
 =?us-ascii?Q?PIJXEjCDhbVNjW49kVTQdTwdqJIjOMWPeaKMPfhzWfWKh0SnTdCqaZ0WEzex?=
 =?us-ascii?Q?RiHy6xQ6LsI0q9VK88KidVDrNjVQ2He6MT88+SwTz5U6zWs2FIWv2G/Z7JJY?=
 =?us-ascii?Q?KPbney0SQZ3Byv4XnUx1tqD9KG3nP4+C9NrE7lo/1GciDHWX1gDrdNggha5w?=
 =?us-ascii?Q?61VyrH6ks2nWn4ywGEn+imHJI9xJ0yGMyAt8WynqQEnOQRYnSgl7XdVyq2pV?=
 =?us-ascii?Q?gqZGSbHIR35ypW5OBZMKPRFsAT9Y/1DOlQIZBwvwBNXjDqHLT3BwLDf8ZF80?=
 =?us-ascii?Q?ayg7xnhM4pr6LHFFdLbAd4cZthGFh+j7b1cMr+FGshOhUQdxP3moIt84UaFP?=
 =?us-ascii?Q?mnwYPTbPJe6vKlm7u98MpQe3rkeOCeDY7GOcUSF+KIuEO9MrcGWs2u0evey5?=
 =?us-ascii?Q?o1poy3u9acQbiw9qLE9g3eFetFkkcUn4BCKb0R+xlGn6+agKE5IkDYCWiQMn?=
 =?us-ascii?Q?5t0oxzc+kml6km8E2iII7iJhPTRlLMU+qOn0tJ96rxs2BcmCQvMGfCl5AXQ6?=
 =?us-ascii?Q?8EKbVPW6Prxyd2QtivytkYdnUT2hdXOwKoZfLq05/oRcVAk7t9otVBFT2GYg?=
 =?us-ascii?Q?NBSrWbGXuV5fFYcr6sd6vAesg0ZD9/q9HPIo+TtIZqkexEXJGESci9jxJGsj?=
 =?us-ascii?Q?K5jsORr+l0nlxkBngOvlFlV/8MLGoeiN3pazUij42cmZUHHucm5HZbmLU4Kh?=
 =?us-ascii?Q?SW4IA8+IX1st9f30JWEZd2tKuTmmYms5DbPFqN3mG1brCv/c4PiyTT9qg/Rf?=
 =?us-ascii?Q?k3w+/MN18L2X4f7OYxopenq3pGd1j+uiKe/chMX+dRb6r2c56WpgZkBI1tDh?=
 =?us-ascii?Q?9yKGrOppM3c1rkcAtYoyRmoo9Dhbl4FODL0ana3h2pDt0b8IEHiLAzjyRSXp?=
 =?us-ascii?Q?h9UtVhWGTtmZPPwpYwsloXHXq7E2gbbni79BpvoY5DnzBY8s/Zeh5ZyGinHe?=
 =?us-ascii?Q?/qAKb6A/eVtooKhbMX0/wOkYbyQZuo1kKB4WXIm/I61mdwf3nW2zLuh6CIhG?=
 =?us-ascii?Q?VeKvThFhYEq+NTsZ1pFpsD1xBVybRz746tz2ZKxvg0XAY64saoJGK0SgTgva?=
 =?us-ascii?Q?AQve/VQSyR7QGsl945Na6+zEL8Y3WO8RYNql1laEMZfjWXanSgnXTnWIWyPB?=
 =?us-ascii?Q?WGNkx/ozaVf6dNxUcyjB7uE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ENt6Wfdm5XrDT3wfvLXk1f//rgL/UkPnFPhefSO+lIYCtxB2clKriEcz3/B3?=
 =?us-ascii?Q?ZpgtOSTRuy3EEFCOUB8Hdg/vU7usTzs9j7DzKiyWPxUyhJqwP6dePV/gVyn8?=
 =?us-ascii?Q?ZgGi1RNhPdMz7+Rj1X2jkOWYbVQchnBuMJYqUrTdMYm/9nlez0q0lCWSypmD?=
 =?us-ascii?Q?xPGyvGxT1PK2QA5jmKBaCnzdN1KTtmxsW6OLa0f7hPpFzW4jj/zhFye8bSkU?=
 =?us-ascii?Q?1B+snoSU1XIoyjq+19dD/dcyZn5LAcCAujtWzFe0OHgzD16h3FGfaEI1Egy0?=
 =?us-ascii?Q?DXGUsgawd+YTTIlykls3ysgr29CY0s/8q/2ayhJpRa+YMOUOCf1j7TW0K5Iz?=
 =?us-ascii?Q?hZoS6YK0lsPXU+X1oj4hYQS0FVviqeAppQ8e0W/6qNvoaFAbXW+T70izng4f?=
 =?us-ascii?Q?ladpDlpEswXid5C77edzlYgkkvBlXL+6xGVCCj6c28XqnS2liguXV5u1QAQW?=
 =?us-ascii?Q?RyyaUDK+1lKg2+rpOATPBGKZUc8t+JhM9EK91FFbwpUA9rl4r/QqPACIFue4?=
 =?us-ascii?Q?ZTyQPobmNd1PF41yh0Tyx0Sbcfa1CpsiVMIWHIoXlm7Hp8hqY8jVBMx/Tbeo?=
 =?us-ascii?Q?Uo08jDckAsgRsrtTgZqXePMogPBf2W0e9Tudt6MJy7sphQCqgohEsac2yGJO?=
 =?us-ascii?Q?YzaYtjN1vpU4ne/Lk6vVN1BcKVRrKpUG9D+CdcYdZglT7ySuu6w4nLG8WuGp?=
 =?us-ascii?Q?cKrHxxpbaJopnvuQN0Ja6dWUnxVLFlJTeUSWdVDz8Vt+HvDhriU/RFuFRdYF?=
 =?us-ascii?Q?ETpix4K1CcjvmWldNK9REHbT0u85Ke07yt0U1pT06/zYXlXGrmJeheL+UPPM?=
 =?us-ascii?Q?B0jdrcsc68sSoaDM+8dnXbhiDRTNCFzjS7uiuOeB+eldRhZtnBlAYrtTgrUT?=
 =?us-ascii?Q?VqL0vT2oqjVQSDCdNaSE06eUG92GjFG45RqOuJl/Me/Vo1Jgc83KxuW+nn4A?=
 =?us-ascii?Q?c72XOtzf5d0tYkOcThqRup7KXlMQiC7XELXNovIQk1jwwIf/CDsVln73V6l7?=
 =?us-ascii?Q?2NYZfGlgvxSss5PSNRVtq9xd5xaZFGCU7gU27hKEuYLmWgwXDec5t9C4qeQL?=
 =?us-ascii?Q?q34rodLV7j9cKDOgS6p5HdWgNaViF7AmQMCBDmfXVs3Q7Ur58RTvwrVfPZcp?=
 =?us-ascii?Q?A36pfOpWhgFpbDWVdpFtsBJTKVnsf/mvQXfuGY+kYThn1K9SVFUwx76wZm+P?=
 =?us-ascii?Q?94MidznqrKua6yaVKVHDFTl2SZBU0L+jI9YwiY6uJxYPQX1oxAeMAKQAOR3Q?=
 =?us-ascii?Q?p2o3lU/tBGnl3ynbxpCT9q1l7nJbzim79TRbg8sr7BwCz5hrSSisYVvc/1tP?=
 =?us-ascii?Q?Y55qLcu98tZrKrtQpFYEx/lrZIqBiMgJ0b46a3nZcwSnDSclzbVUO5saMDTv?=
 =?us-ascii?Q?z3T+asB9S9uGnMQtS0ncCZMyu6b60jpJ3Va3G01xpWJI0px8R6Mp//p3o6HX?=
 =?us-ascii?Q?Kh2osJ3yHB/uZCC9fV4uhUamN4aZURYj1TrBxRA6QSKRuB2CYN+GjPMqpkO8?=
 =?us-ascii?Q?JsvRX5DRmrheGH8umxA4QxWdmmSYrWgziLvzbsLCUy3t2NmOdqBFkEpG66JJ?=
 =?us-ascii?Q?5Dk1Xm9Sw4IHDSys1hn6xmjwm4iOrO5ezIzZZI3zRLoEpkfKkY2JFcDSuwI3?=
 =?us-ascii?Q?NF6OTmmslTkdweWzSJ+RIzJxlJsUX4hN5R1RyGg1GCGL36iQ9JQ0Oo8gxfjp?=
 =?us-ascii?Q?dD3TUOfW6lBtG3q+l8opq47J3lhhDgdeOuAD3VzzQ/ltAOAu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79246377-5d6f-457e-a18a-08de5cee6b51
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 15:20:20.7852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWkToM+43m78w6MXt+ptNTQqLT9mCSIIWsKFtnH4yO4a+TT76AndI2f3lPoKSY3r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838

On Mon, Jan 26, 2026 at 01:01:16PM +0000, Will Deacon wrote:
> On Fri, Jan 23, 2026 at 04:03:27PM -0400, Jason Gunthorpe wrote:
> > On Fri, Jan 23, 2026 at 05:10:52PM +0000, Will Deacon wrote:
> > > On Fri, Jan 23, 2026 at 05:05:31PM +0000, Will Deacon wrote:
> > > > On Fri, Dec 19, 2025 at 12:11:28PM -0800, Nicolin Chen wrote:
> > > > > +	/*
> > > > > +	 * We are committed to updating the STE. Ensure the invalidation array
> > > > > +	 * is visible to concurrent map/unmap threads, and acquire any racing
> > > > > +	 * IOPTE updates.
> > > > > +	 *
> > > > > +	 *  [CPU0]                        | [CPU1]
> > > > > +	 *                                |
> > > > > +	 *  change IOPTEs and TLB flush:  |
> > > > > +	 *  arm_smmu_domain_inv_range() { | arm_smmu_install_old_domain_invs {
> > > > > +	 *    ...                         |   rcu_assign_pointer(new_invs);
> > > > > +	 *    smp_mb(); // ensure IOPTEs  |   smp_mb(); // ensure new_invs
> > > > > +	 *    ...                         |   kfree_rcu(old_invs, rcu);
> > > > > +	 *    // load invalidation array  | }
> > > > > +	 *    invs = rcu_dereference();   | arm_smmu_install_ste_for_dev {
> > > > > +	 *                                |   STE = TTB0 // read new IOPTEs
> > > > > +	 */
> > > > > +	smp_mb();
> > > > 
> > > > I don't think we need to duplicate this comment three times, you can just
> > > > refer to the first function (e.g. "See ordering comment in
> > > > arm_smmu_domain_inv_range()").
> > > > 
> > > > However, isn't the comment above misleading for this case?
> > > > arm_smmu_install_old_domain_invs() has the sequencing the other way
> > > > around on CPU 1: we should update the STE first.
> > > 
> > > I also think we probably want a dma_mb() instead of an smp_mb() for all
> > > of these examples? It won't make any practical difference but I think it
> > > helps readability given that one of the readers is the PTW.
> > 
> > The only actual dma_wmb() is inside arm_smmu_install_ste_for_dev()
> > after updating the STE. Adding that line explicitly would help as that
> > is the only point where we must have the writes actually visible to
> > the DMA HW.
> > 
> > The ones written here as smp_mb() are not required to be DMA ones and
> > could all be NOP's on UP..
> 
> Hmm, I'm not sure about that.
> 
> If we've written a new (i.e. previously invalid) valid PTE to a
> page-table and then we install that page-table into an STE hitlessly
> (let's say we write the S2TTB field) then isn't there a window before we
> do the STE invalidation where the page-table might be accessible to the
> SMMU but the new PTE is still sitting in the CPU?

Hmm! Yes seems like it.

However, that's seems like a general bug, if we allocate an
iommu_domain and immediately hitlessly install it, then there would be
no dma_wmb() for the page table memory prior to the earliest point the
HW is able to read the STE.

What I wrote is is how things are intended to work, so lets fix it
with this?

@@ -1173,6 +1173,13 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
        __le64 unused_update[NUM_ENTRY_QWORDS];
        u8 used_qword_diff;
 
+       /*
+        * Many of the entry structures have pointers to other structures that
+        * need to have their updates be visible before any writes of the entry
+        * happen.
+        */
+       dma_wmb();
+
        used_qword_diff =
                arm_smmu_entry_qword_diff(writer, entry, target, unused_update);
        if (hweight8(used_qword_diff) == 1) {

Jason
