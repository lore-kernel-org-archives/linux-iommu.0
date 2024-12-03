Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F51F76AD
	for <iommu@lists.linux.dev>; Tue,  3 Dec 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242017; cv=fail; b=N1apo4hAqS6UkkmKqmucc+kp+pUYhUCQt+Z2B04yDTHvV/kzrIIqCxrrZKufwBlyISzdBXFlpJEeyILTxX5NNKKVu9iJ52ux3gFDR69i8teoPbu5J9XTQ5FOZ1+rrprRV9lIp9m+GE/zdmDiFlTTfBDme7YwXgj/dIs1tbSfTSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242017; c=relaxed/simple;
	bh=OXw01LUqPW1JsZPf9/Q7WBZ2449lkMqs2KfmaAF5TPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZMHNojXAHY95F8i8S4H+hvNAB9n2il68rsLa21Ljo76A1nKNOBUZLY9C5WgcG0gtASmma1I1wPTFFQNVIJdBeYCpeYevjy45bqqxP1ilEcI+TWXSgbIJXqvWbYr58Dz6FjvxAayl/K0VoMD8XwfejfGY0LROSgbB8U4H1XzAdyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OpbGE4ma; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OpbGE4ma"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lj8ynSbgA5hfYGA+tIn742x+MSzEK/0tMwnx7x+7LdkjJ5vmzlobmlA24Wy2FJNWRpEBFfpkVaOf9HAAWe4qZWTXDdE2myt9I8bQMHoP+NQ3j3fgoGvxRMupl5Jp89FV4tRRXpZZhLV5oUFrGNSJUsWc8GpfxZASEIwMRSdPOxUxkjDfhCdn/8H9iZp2DjDAW22JuOQ5oFDxCMLuotGikm+6Xrsm1v1FXcMAhGBaCn/E5rBydpLDsMrtFQzeMQ2NJBMJmnPeVcDDvygGcEmWYJPODJpJoB9q+zlYhtxe1eAtNnne3JpqSOhYgh+p+dKkBkpLA4JmF3/MFmLJwk2CqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVGmIe+H68qqIGUu0RMLjHNlK8BdVWEk2uWpzMC+NpY=;
 b=C4gkN09469mMtnSp3RZikXoTeAEHTwWDVpArYwE1tCsHmxg/W/61Uj78ZeUc91BNsO86N104ldSd7Z6kOITF6p1BU6EFN640YeugdCxQdvzi95MJRh9r9Ri92yfqSpSJ1KXA/GVwjrvHOum+vAtqq1Jr1LtvetildVmSKRFwyixR3KtY1iwRhYE72cPUOOigEjtM9RhMHiDQK1MvVRY5sYbQt2MTRRfq2Al8mJfU91iSFKe14glp2yUW4EG19dnkyIUiJWBxb3j0KiLs7Ns2RFusPrQ7H3ZZZoNZcVC+Kzwqmhg8cr8gp0c67hDGJb5+V0PHCR9KQBHevDdfiKLIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVGmIe+H68qqIGUu0RMLjHNlK8BdVWEk2uWpzMC+NpY=;
 b=OpbGE4maZ5uJs1RmXsQ6AEMwCZQxMWq6/+8J7kzsWGQ+eDw3CQ2FESZ7jYvU+yamiCBJJzvfWNgKxhRojKPm7Ytd2yvtyBu0Gk0m3VwhqiyD3X6/5sLZLeAFP1SMlDaLsAw3ckmpH7XdF5UjzNm1vXXEHtw5P49S91GKqMdkJcv9sRvslVMEVDrGzpRcw7GnCOTXleax+OCKGUmN0TJhq6j0Yfp2fU0Nu46tylgJge/hzaGdg7roooCsK5qo0ZOKt0eIxGrY+bunmD3GECgtFbkIx5Nn7rAOZl+HL/cXvAuoQucsYaI9BJiQJdLSmhb1jxiV1yuVWGaviWMp6NpPvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 16:06:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 16:06:51 +0000
Date: Tue, 3 Dec 2024 12:06:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] iommufd: fix typos in kernel-doc comments
Message-ID: <20241203160649.GM1253388@nvidia.com>
References: <20241128035159.374624-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128035159.374624-1-rdunlap@infradead.org>
X-ClientProxiedBy: BN8PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:408:70::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f931fe-dc9d-423e-a0a9-08dd13b47fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9iuZz3kod0l0/+HMOpnQ95Coc6t4MkwQ4RPh3PtNakGk4Dqnp3KixgrxHPN?=
 =?us-ascii?Q?QOfBRH0VOIqL43SQzrVlFmw2grdkTN1pJCkxMh3QcD/YAwAXumGkRMMXT01S?=
 =?us-ascii?Q?HIAh1dBCcpJ5+TXng+vggBuXj4QhAoCA1x8pl3xQe33bJH3L+zMpZJf+uEp2?=
 =?us-ascii?Q?wbQ9YJOKFujrmth95ELiYIH/1aWhUzC+gcy/wEO+yWms83g29jhj/8y1oeX1?=
 =?us-ascii?Q?4XlSNd7Gz4FijyNpbLs/wfhbpAzjCxIDidDrfAiop+BGhIfROwXdisZCQH7b?=
 =?us-ascii?Q?TX3mDYeCu9/GfYKRqYjfeTaX6ZLirFRNS0F1MR/uNtNADbkLP+VDnCpDcBup?=
 =?us-ascii?Q?RHRy9e7ynr2r/TNzN8zGv09DoBxtw3ZMPlIAdqCclQ0Ym1bP2cbHabebShV5?=
 =?us-ascii?Q?yCmFqr9OsgUIyINuYkThz1ZC2mTdOxSMGjG1glZcoXR9+/4e7Gy58DHW1yzT?=
 =?us-ascii?Q?o5xKWN5gmW7drug7SNJyEZk8bA62QzQMJJPz8DbEUs8jHfTwMzNgznMVM0oA?=
 =?us-ascii?Q?WM9bIHq3+Qx6qK4WCS9uwvL4jgCbunMVnpqLvcTU7bWUCSDTGBnFB6555Yct?=
 =?us-ascii?Q?AgoxSQeXGVG/vRN8WfVbILipaMNpdzqhh4RItekUs2Onbc/VKBAt0vmxMdYT?=
 =?us-ascii?Q?Q5HQPJl5ys7s56q9Q46F1PhpwnrwztssG4szUn5/rzk2sAyZ4C6vBqpPOGRe?=
 =?us-ascii?Q?yetPQ4FqwM+QMD3+PVQbM7Z7ylqmeMaqFuBzIyCYMLmrv74KS6cFFqN9bMPl?=
 =?us-ascii?Q?5koH8/YOGoep1C4j8zLMidhrZYr1rpyUo3UxwfZpWPO87sKVc0Yb4INwj+8w?=
 =?us-ascii?Q?8GASKWOs+8Hrf1x+r/Jxcv92I+eF82+7c44cnkDeOnGbQwbQaxDdJIfsm5O9?=
 =?us-ascii?Q?zBPYuD9/5nblgV9c46nyMLte2BWlDytKKCkYVKYsJQeFx4yvhl7hKpqUdAHt?=
 =?us-ascii?Q?OEwYPD+fPPd4pAtRKfJHdENsfWHy58VGwAzmb1+KUBmEBI1mEPwD0gX+ng+G?=
 =?us-ascii?Q?4ip8Td13uvugAwZv1Ns0JMaiYpzkxZrZAJyOz9k881hV3P/dyEfhdEsK97hY?=
 =?us-ascii?Q?eNgPJBnmJlFVZaNA1pBZ3eSeVoV1rE7m3f7t4qZa77W09DJHJzUHrDXzYQNC?=
 =?us-ascii?Q?y05W5+wwIsf2aCttNY/b3PuvNZBYZjFs0lzzery0Eb4gGwkVFgmGxLh9ILxo?=
 =?us-ascii?Q?Z6FvU9nDxVNSi58XMK2TntLNZgQvYTDJI+J3aKu+DeEu+Z8Pwj4kENPQ0+D9?=
 =?us-ascii?Q?VPONzRXD1J7qSSEoTnB82lxbxWPDVpFbhIYw7o/GBrQ1x80qM3N2srXHc6Ub?=
 =?us-ascii?Q?iK59q+1LCKnl4ATLBSXFMMDAOCzpTyCFz9BozCZJDDz1gQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PX/PNp8MRzdNU2Q9lj5M3ftLFCsZw6emcT+BJE/1fY8Wmi87BoZsRbw1vF6o?=
 =?us-ascii?Q?owPE9zWHWxY+/UlO3IC0I55JYQDSdZmyEmQlnTWEBxbRnMuWk6zbF0SQgdxY?=
 =?us-ascii?Q?rcCFYEzSncc5pIJ0VvZXl1qFSbufwBWP5m0jwl9jDQWZOVhQl5CN19nO55zR?=
 =?us-ascii?Q?TJP7AnCNp2torwUzsBXPYIbWQmnCp+O6zztehz9PwdMjTffmrR2uGsn6RV5j?=
 =?us-ascii?Q?COibqMWw1netxuduwdr+Dc7ncJ3VZl/M8Mhaf88dnLyDnc1h9/HGODNDMgF9?=
 =?us-ascii?Q?ZV+etr8wx4831KcXzfXjIAcw3jMNJ/Qnn5cSQIpmlEaJxDuzlhR1ACInxcYY?=
 =?us-ascii?Q?6Li9VPwg8rjiHF6in2GCiHEC8fsU2UOkEuonsjfOuQKdAI/cPs2WUbhpbAG0?=
 =?us-ascii?Q?T+JjphAGUv7tg5ZCRsjE/ol3ib1nkm43tVlEI+86qLXlA4msXZGpXt8FwNI2?=
 =?us-ascii?Q?R+/eQNxlPRD6px2hHO9Jy14MbsgRvlSLhUQ0dAcn93/5+oXahAmrui4+AGpX?=
 =?us-ascii?Q?Erq1X94eAVnBy05W0QjSRc60D+0Q1uQidCBURFGkNJNfYH+WblWKvjldXSvd?=
 =?us-ascii?Q?8GqrCJdiwh6zZmZhO9jTm1s4G3J0KMMA2UhPvMshpVyO2nLmFfExNR/eIzUN?=
 =?us-ascii?Q?8nbaMqbBuDBKb+Y34+1gZDUprdEAiY8cOEhSfC+R0yxkDzIHytKUdxy/HRze?=
 =?us-ascii?Q?D+IiBzOxJQ9J4KX+zUCV0spgd94y7gnEQ9OD+iQHJ4RilGNeAid9Zvi7OOWM?=
 =?us-ascii?Q?0zkkAAbVqJC1WBAuTu3kzE1b4XaEAIcVUGSWKZMgfxSZnzsjwSXkvtDSEq3w?=
 =?us-ascii?Q?F2K47qk/xnHycAWA0uhGish4zfuWkFtDOFVz5WxSu4MNpnXinaYUNxEhpNrm?=
 =?us-ascii?Q?iN05i9dE2zDKfbYOgBmotBdVvYGMfuNwPk2zePI1AwpvGLuUXzbO0/h7sDc1?=
 =?us-ascii?Q?da77Il8y7ZjIYJSt2I0lrttrcy0DIaCWHaFXsbk0OwdZDtxVB13d3KzZgu8d?=
 =?us-ascii?Q?IF/jSUY1dC+eAxRaphBeaKU3tDQ+8x+IRgo8y07ukUnl0b9FdHeJALwlWd/v?=
 =?us-ascii?Q?CpzuSBgHzz9klHNOCscP+soRrf1HizXIgXMGDXiHEhrjK7jY3jT2O+pvEU+H?=
 =?us-ascii?Q?We4uDl49KQFjc4/BxW/8x3/qCuLtY5cVreeefX/xunLDkTL5TO+etTPkN37+?=
 =?us-ascii?Q?8tTbkIziWkEu4oIBFCNvlHR3OjF141IRe+SGHbnhK76QCEs8C5s3FyuD5Nd2?=
 =?us-ascii?Q?ZvC2geSAv/LUhdsEPNluBnHm6HBbsgXOLUg3zfOSUxaM27x/S78m01rbxlxE?=
 =?us-ascii?Q?lkRL2LlFivj8wuxNBcZhXkB8Q8mGcmRw8uV/tteUN+0K/ID1F9XH8NnWCS+K?=
 =?us-ascii?Q?/3VaKib7gw7og3WOwyZVCm9Y6k8eLYdvLt5iw5hKrDDCNheDRJsLHLvc16Zy?=
 =?us-ascii?Q?qn+ZWaeCFJUcsDk7WCNILxvtD5alfCpdMrbKYs8A+E4UwuWTJE3gK+r0HSnN?=
 =?us-ascii?Q?iRwIzJlXzpRT7BtShq8Cbrh+8mpFpPAA7BRDr94uNKwwJAruyL9l3JIDHGw7?=
 =?us-ascii?Q?3uaJx7Oh7F6gM2cT6qy6RC3OTEvqbLk1ZwucJx4u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f931fe-dc9d-423e-a0a9-08dd13b47fc5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 16:06:51.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGnigZDut5P+c+P/jlWjn09u0w2YD6tS2kJd8LB/vrrIA6/ND2kq2wEJO+uhXb6O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141

On Wed, Nov 27, 2024 at 07:51:59PM -0800, Randy Dunlap wrote:
> Fix typos/spellos in kernel-doc comments for readability.
> 
> Fixes: aad37e71d5c4 ("iommufd: IOCTLs for the io_pagetable")
> Fixes: b7a0855eb95f ("iommu: Add new flag to explictly request PASID capable domain")
> Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Nicolin Chen <nicolinc@nvidia.com>
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: iommu@lists.linux.dev
> ---
>  include/uapi/linux/iommufd.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-rc

Thanks,
Jason
