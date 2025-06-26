Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C202EBDFB
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948625; cv=fail; b=QU/8Dsube1OFPIDkmKM2shGzX7vmK011BDxEfsO7RAzxqGGaY+PHWwmOiSLlGsQR/fC6SWw2J91Zl/xvTYiJo0EDNa4qEuoO61vu/93jkFI5FRf8Nw9R3nfJyQD1VOJqhEpcHO9pQfP3GM1kQu3DVx0x7iRTdHqAPwb/m59jcD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948625; c=relaxed/simple;
	bh=ZUVZ9HfdIvCEep5jRY96GBdyO04Mmtwa4dT6ceOV4uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EUQcT83pLSPv65Tmd3NIzK8TkmiW/RBQcgfC32GYIPqkIvcyubKgm6/NC3DRpqLjebst2SucAIgZp1LqRoLDnhq0739mO+iR3Ltddgm1nDrsihfDM1ajcBlBAngRyGXvukVj8trspb3IcQGcpMigwvB4Ei3YnurjLEO05HmYAoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TkXDnzIE; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TkXDnzIE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVB+/fajEQV0hGmgzKHrHJC5dRU00voiiJho9sTXMjCQESU5XKPr+Hh43ykqHgiakmH6Ktj31nz627pIS8A7GC1xmHiw3m6ha4PWscewMsaT7OOe8EeUjNWOy4BBp3jNCzeHbQCALBu+dQHHh14mRBqssOMKVCLL0nMZOz+cwAJ93y2aHNxSi0BaLQwLd9otvHDE6Vk/ZuMEO55d4H+TX2FHwab0p6m82L1BJvrK8NORBcJO799JFUPkX3hOG319cF6KKoxnmBv0/Mzk6BY6bOYVjglV9vxUy9YjlYtJ+reRGt1j3dyRm9e5xpH0Gyy/bUF+XjUQjMErxKI92vsdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/7SIAy1A/1etdJ513Q8x0r1/evfP6va5ohY7yM1hkA=;
 b=hG5TQsjDxl5cb/IeKfcKXmHmcA41OjfIzOebGDi8KRYDePKtZj0kVXxcMBGIqHHfNxVUpU70UDnLvX5zfiI6ePdCatGpy6AXe9hu2vJoMy5druovO5UaDwhBZAxl2uhraIQ/FuxqRBBS56HD42JxM2GqCB8HNQlWDDzISWFA9RkY64fbYfkuMIycoljWZQ0lFt5LsR+Xz39N43HksVxWZ3ltWH0dMq4RuQnKFX7RYTRS36gftQwNtSHx9ym7dLlN3rQ0yUIkU89Lu0q20d5zaXcUnLFyGvkQ6/rml37I6KKtZhGf5LiSdIp2BFiH5U2x3Y+w3jyxFR0pKmvK+TxpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/7SIAy1A/1etdJ513Q8x0r1/evfP6va5ohY7yM1hkA=;
 b=TkXDnzIEO/M2rl8yrBIRczBJ1Fk7wfBnTZnwHYsbBVdOu3TYqKt4bzIsA88Uvb1tvOxgb3lfKh1jA9g6X5XRGzBWKevrpwP0Wy2M3vV6gfED10CL0/OWqYBZKAB/aT9wpAfEimw4qB0aQFxi2fLjaCy+oQaVZe5/vNuMlZNbod/BafEPChLwmW2tYBOoNtj9s5KGqe+1fB6ONogKCzr3O1eSL9tAF+Vbc63Kay6vYGVyJ+y6u8sJLnEOppKF+Ys/3tN+u6htQalH7yUYV5jHUwE0oLeARObl9DfzvuyjPYfJiZpXEpNQ5i34yIjrBQKRJT/SMvzdwb9bAwiILIIxVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.31; Thu, 26 Jun
 2025 14:37:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Thu, 26 Jun 2025
 14:36:59 +0000
Date: Thu, 26 Jun 2025 11:36:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Message-ID: <20250626143657.GK167785@nvidia.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <20250624145346.GC150753@nvidia.com>
 <aFvKCEt6FadGtYr+@yilunxu-OptiPlex-7050>
 <20250625123832.GF167785@nvidia.com>
 <aFy++lne6X+1bFlM@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFy++lne6X+1bFlM@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: b297adcc-c358-4afc-bc17-08ddb4bee893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xF/5nHRnUqci7HBliUt4tzPYdG3dHm2H1iQXWGN1F6tPZSmAqHJANciD0GMW?=
 =?us-ascii?Q?fMnDEhhFTXCVr4fJ7uNFtElr9laZ+X0cjbHhHjsKtW5QxByI6C9cYqzIXsNN?=
 =?us-ascii?Q?VqYaX2r48SoF/HPU/dEFcUVcx9Dc35Ik19dJuhM9oMzsWbAqd/FhmDKdu+gA?=
 =?us-ascii?Q?ZG4EPM0WWl9i2+U1qqYOXmOY0K5pj1n/ndlRz8DAF9PehqYtyzLKhoeEOs9m?=
 =?us-ascii?Q?XE1PMp7s1N2Eb6fNiXhJ1IdtSn2J3DmXfnOsFXQLFls94dhUzT+0hPCK2ZYj?=
 =?us-ascii?Q?AWXZyE3t8vqbR+94eQP8FYs4+epf9ArZP8doAFRvWBlXGrYKMIZQ/UXC/B7v?=
 =?us-ascii?Q?N2wkwOg68W+/HCaBDWLK7zyzenZie7uCzunrTOgdDHkQJzfA92eMZqD9uJjz?=
 =?us-ascii?Q?2pvkJ0hBkOPEBBa+y5lYQoT84iEYq0Tc2OeBIIq5pgSiBorFftuaytPqnBYV?=
 =?us-ascii?Q?EWcfAhOkYb3GjJdFOoYHsaoAygMuMeEB6QEfcdhJ0e7nmtSZVdT1WKFEmMqE?=
 =?us-ascii?Q?O5f+mYUVjLAQpHaIgW7/v3b8RprgA0HzEv7iP1R7p/D11y2PKX1nCOrhuQ7x?=
 =?us-ascii?Q?MyrfSoI6OM6yFJdsPpdoRKk8OUai/lqDechtIl1CHO4RGXdcoDMempB1kca0?=
 =?us-ascii?Q?oitbsInSq6vpfKfpeFGSrz3LoOpGNKDfD85kQ8slBBxhPub1iobo/5HjjJtt?=
 =?us-ascii?Q?TYDicABBXfhalKRSEKUrL5rCWhs33DUPISgn9le/ZqWUfM8NAmLIM9Uc/+LX?=
 =?us-ascii?Q?2IThZmw4D5xZhqhR+dTi0FJ/vWZsE0TnlQLmNJw8NOG6M1kmqQpyopDzNgf/?=
 =?us-ascii?Q?Om0FBLe8hSP3oHJFT9KtQ6QeEfeMKk9eG2uGC59gWy31fwq5b8yNdFuss1cz?=
 =?us-ascii?Q?3falmRt8WtZjbe5vBupm2c6yps48ycBFalJipz48u2LM7wsUf8vQs6NBC0yo?=
 =?us-ascii?Q?ZTLcPQ5qOkbugars67cd76+P9XhMDdAZQGTkVFOt2HiGjonl9/qN1F7dxP1/?=
 =?us-ascii?Q?eB5CLOi60DwSGTcjvsBKjzsshGXDjcWsH0uhVwStO6NIh/LbabxyZ+nEujra?=
 =?us-ascii?Q?mq+eRA1GYW582qh/MFRnwgc2rWxru0KOuObgGy2Cr6CnnQatBg59njeshPJO?=
 =?us-ascii?Q?jH8MaLCmuogXL9BQYFvMx7TwlrI0ZFcjoADMFsLTTp1aGl4BCseaoiqI4Z8D?=
 =?us-ascii?Q?hQuSeAJD4ita/CZlQOiAXjgfbRM2I9QRsYmbZkz3RM2UWE87zNnudUmJp8U4?=
 =?us-ascii?Q?XxRIzcsVD3Pk+c3RvekGddR1XdEEZMSfDdZIRFP0klmCwIy12Gcr0gtX1cLV?=
 =?us-ascii?Q?bLUbgXM8j7Vnmjlw8HYY0/2sJYFR1OwHXWizHzswqapEffRgaguspr5izi0I?=
 =?us-ascii?Q?xfmoDxj0IQpY2jtAL0XXM213NfKigiRtRBN3zAQYLhUgM0McehFPZl3zw61R?=
 =?us-ascii?Q?GMplE9oQ2x0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4k03lfWIjveeZaV1USRYjO+AknmP2OjhhEJJTxsmWAV1DVtHZejJD/m0D8qX?=
 =?us-ascii?Q?pyyuaYyXcPRaaZG3IMSgq/XrqcXdBiQNhksGiR0Of6meK+/0iNKmK/EuPHhm?=
 =?us-ascii?Q?n69wlfZfbMANqFOD+WcSEwTgx9nYUr8sXJCFFUigEEO+pm4et0dKL3XQgjbp?=
 =?us-ascii?Q?+Cb87OHdfI5ST6fIoZwESp/oMaAuaZMIUrUtHOw7R4KGLpPs2bfPjwvuJhKD?=
 =?us-ascii?Q?aYBX9nG7rTVG9DoBlvmULtg5c971NzC2+8LKDfuAgvu3WgYrk23e92m2BHiz?=
 =?us-ascii?Q?ouqjPufeqq3MScX+LOecRyvaAjSyIPtaEfcEB4Cg7urfYkmdHjr7BOX0x7oP?=
 =?us-ascii?Q?24RFvLYpZw+ilntR5gB1nakwqFOAc6VMGc/5RygRIQNToO3vvejmYZZZceUl?=
 =?us-ascii?Q?dXETdhMJgx1VGXM/CQzI64zItlBd5TagnsqF1nv5jNmAHN9Hye5ronAK0geT?=
 =?us-ascii?Q?pF//hMPvx4mbNPUKRZbki9nALdy5TGLxRjU4CxwT3YwshgA06O4qURioJiVP?=
 =?us-ascii?Q?F+Dvya7sAyPqzxx/yM43dTztv3OzJVsRkIa6vp9+D/AG62P2Mzk7XoZ9d/yv?=
 =?us-ascii?Q?/aEKYh7HwBJzQjnsjGHrxb6tQD4Yae9EP4A5s8RdLSMmCxj7INsnaIRmflf4?=
 =?us-ascii?Q?VshnqcYMiS7z2WX20sfGC+pvtJ2g+ftP61Sk/Zs7MvvNdneqt6uQV9e4H8nI?=
 =?us-ascii?Q?m/pwplEd+y2Y6dVzi+d3McCfqmy6SsVP2/QD3Ipk3L4YD64kehlq/nkINlP6?=
 =?us-ascii?Q?AorPa0INtl72NmXFNeN5Ikj4+2Q5IA4qK9ZGCn61g8w/qkSHNuHVMHrplfVM?=
 =?us-ascii?Q?0HEmLDlGDGDk2J46PfFdm5F6IFqytjAUFCL3tuAB/U9209SFtFjBrPhhz4g+?=
 =?us-ascii?Q?7OlIj1zRGHFARezLolkSxJvo+ruFJ9noter6hSszcFN3pAkirNe9Omdh8SNE?=
 =?us-ascii?Q?+WAvgw+MS8YYpjgFeU6gWJgyP4EYjUHdpwVJ3gyQbXjSbwQyJM67tFoeXCjY?=
 =?us-ascii?Q?DBmLZtcNIN9608U2VwzU2pjelJ/TRDm/mQzSRpZ+GWPw95eUFhTUy2LVmbLa?=
 =?us-ascii?Q?soRA0nmxNU++mPFy6OFP8bN5QrbLtTFRnYB/B4Q/m6ws6ivQfORfWS5jLrjW?=
 =?us-ascii?Q?THL/pHxhFsDcB/VUBGZxw3XSsfsoYyAwp2afBhszLcB4NmN/Da6hMR5R3LJ0?=
 =?us-ascii?Q?AQ887g6pImpzm2hb+roLWka5LdTtUukVayqayqgmbgI2yl85M2BAqOrYyx1a?=
 =?us-ascii?Q?nH+cSwj/BTVJpPvRc+jYJvghpf2Od2SOQISm4xsOE8+USSxolBW+oLLQknuZ?=
 =?us-ascii?Q?g/zCWmGTZrCt86n9f6l5Jx9C9LT2PniCQJduBWwO5tbRVjWI/kImlFJ4th03?=
 =?us-ascii?Q?vKyQdOAGprrNzfZiRe2BoIrRJmVw7vtEw0FbzKG0XWfhhvq4EDCjg5ygqzeE?=
 =?us-ascii?Q?Tk9K4O9j66i9govPQmRDYd2iaeqrqg4bw7p3HM1DHfVbgMdum12cDgffxUgd?=
 =?us-ascii?Q?/jvK+LDvBU1qrqs/S9aSsjLqFTL5vqanrlma5XdW57157/2+U9DydZI5HAxw?=
 =?us-ascii?Q?A+NWPTccVjhBgjvEbT4sr3LyYIiCj6YL6wmJZeXN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b297adcc-c358-4afc-bc17-08ddb4bee893
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 14:36:59.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKy+mUA0yz/4WLzReKGb74XkmAappR2RMrtyWksCldTWh+tMnzX9+4iMlala5a64
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

On Thu, Jun 26, 2025 at 11:31:06AM +0800, Xu Yilun wrote:
> > The wait_event is a ugly hack though, even in its existing code. The
> > above version is better because it doesn't have any failure mode and
> > doesn't introduce any unlocked use of the idev->vdev which is easier
> > to reason about, no READ_ONCE/WRITE_ONCE/etc
> > 
> > It sounds like you should largely leave the existing other parts the
> > same as this v2, though can you try reorganize it to look a little
> > more like the version I shared?
> 
> Sure. But may I confirm that your only want reentrant
> iommufd_vdevice_abort() but not your iommufd_object_remove_tombstone()
> changes?

I think take a look at how I organized the control flow in the patch I
sent and try to use some of those ideas, it was a bit simpler

> To me, grab a shortterm_users but not a user is a new operation model. I
> hesitate to add it when the existing refcount_inc(&obj->user) works for
> this case.

Yes, I am convinced you should not do this. Just hold the users only
and use the normal destroy with the XA_ZERO_ENTRY change

Along with the locked abort idea.

Jason
