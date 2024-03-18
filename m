Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACABE52F6E
	for <iommu@lists.linux.dev>; Mon, 18 Mar 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778944; cv=fail; b=QabmzNBkyZWx0RkG5b8mV1lNFoiBIi8t6enrrip++qfvB2wtIHGP1PVVGBky30P6nUYIAydOIxbd5QtK6LIHn+nLAt6W1DB6J2y4vBRzt3LdGIVnjbqbtizoZa6gSn5HQwwtLrjWEPev5jAyQjs7adMx2Gzn3Ojbk+Y5n4W7hE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778944; c=relaxed/simple;
	bh=FEr+tyXcvYGizrpLGnykqgLsFELt1YMmJeFv47cPOls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s7vGnO53edJwDQMUNOFzsA/9g32kJPP+FcJuvKuTZh1qvmY5xfSLKl+FrN9A29cioD2K5paDzBEGhmm1DqXHNImylqCCDmawKVrDEVmhrWbsFEmHqxcc+YkvQCwNABVqs9Z6cgN06rwjJWnHhbL7R13+JGA8v1FQXzgetW/zPv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PO6O7eRW; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PO6O7eRW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhw1IIckS4YGawRDmgzbqYzrUxsFwQzbvNzp7/jT1xHi2CPIjLVn9XOq6BEIjA0Hf/Bdq27XxK+YixGgKUk1pWg0MYhJRRDxKrj6oH/UVlOrHK/LmLi7oUoFIvA9Jt4TcaNUIsZTCLyxJrkayaasTDCR0PZqX6BWiEHmZKlVCtJqykX9X2To140JwCo/0yGw5YqHFF30JOlkbJxTh6/G178u4RmaK+7W99LloDbLtIpB2PxE32Xyc78SzAUquc5CGH+JJBVvtgTcD3AQQv1eBrlxBYaOFlFSPJQLKKTZGf/YW9rbSKHutY5IPYkWpSgOHb8i/+Who/qckfW2pkK0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx/EPURD5hhlLtuD3MmboAs9+okYJ2v1tLNKUJtRu0U=;
 b=oMZbMDsXzbhy/4yZB7TxxXs1htWm+Zvw3OJRo3ZI6CThGGJEdSNK1Wru+pvgxWt2LZgnrG/yOLM11Rjv3QmbOaKhA3tzDRaH0/EU6maFVaZ4o5Q1V+PLt8pawaqP/sZzR0hyY8TSS02RQPIOjjUYchW2dEwxoLqH3MkIvC3jx9Bf27BA1JkhdGY6E0pGqmUFBYfphXM1Rw6USbRdFwRPRQCL7vaZL6Cr2GXk1d0koqmfkMyP5wpf3xWMWm1fbFI65nfpzQJmAuct1kvVKM5SC9Xu3yRJfAb2DD+dafp9PBbnkI4GtvjwjJgQaR8p1uBqaGpxgJ1AuahZwtFr5pE5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx/EPURD5hhlLtuD3MmboAs9+okYJ2v1tLNKUJtRu0U=;
 b=PO6O7eRWivgB8WIC1QyT//np8o6lKHEjLcpe+cwMprwpbphIFLFoCMvlzaxUocfJMR5wFlCFa2tT0E6nsFWXq/I9p6udaTGboY7xqSHqCQmotBjuQ0f/7TTvOMYHipPt0WvYe473GHyQuv851GLHV9vUHO5qu0WYL/HWfjFRxaqtVWqbTNCGFDgwltY4055LbaNijbSK3wWXnLVLXEhm/7FWpTQ54J1zBKUjM0g4hErkmyF9lKasVToCUe8LSkXcC55ZVJmA0h0pViKwjGOk+JnTwLUkQfgZ7De3Qi5NG6rkUBXjMILd+nQ8ytUwSfAq3EMF+UD4/yVNEPnq+eT1IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:22:15 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:22:15 +0000
Date: Mon, 18 Mar 2024 13:22:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Linuxarm <linuxarm@huawei.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Eric Auger <eric.auger@redhat.com>, Moritz Fischer <mdf@kernel.org>
Subject: Re: Query on ARM SMMUv3 nested support
Message-ID: <20240318162214.GC5825@nvidia.com>
References: <b8c1b2fb281246da94b35ceb5e27b538@huawei.com>
 <ZfI74miZ1ss9+Kz0@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfI74miZ1ss9+Kz0@Asurada-Nvidia>
X-ClientProxiedBy: SA9P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::12) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cb4726-521f-47d0-c6b9-08dc4767930d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F70UdtaBM/GZ2e2X4uf0hvdAqL8y0cTPRhYYGHUB9Xe856Z4QYx37mqlJj9MQZWizmONTQX0VOt98BwDLE1H6WZvBpOYsBoP63ASg8+kMYhy6aL/AS8KzVPb2lcNICCa4gM8Q0RdghTo513d/wDng+SVQ1zR/ovLdFr1QNinZh9cnLJREwkcSewpBNmZa80Z08IDeAzsTIPQzSD2QVOFyLFMh+eJ8tUDjyyj1sLK4xQG2jqK1KO8/KrTepDXK972fOZNHJxnZxUzXtuKo0ef8um3PMmE2ti19j7wM1O8zqS85K1ZBJd7DKo3ODDYWFTp3c/m7nEj+2yqGqzTFrEj4ie6rN2OAPJBfagmC19QgfS8gL+pbrtXOhLNiprwdGxhPCLGDKPrvi1Ck5wMRwNEhoh4TTPlPfS0ScB0oRytKWXcXzG7/HBPO/TZ/VefmgW5o0HjEp4KVqnb+FmWyRy4q0MdqA3wA2d3Crtj+oIzkVquC3dccPR8a5iUroI/mIfKOuTedD9ZHovOP85rF1UXCZSCxetgWz7wJJZLVmA0Jokgj45W4h5cQ6chW/C7ktfQQZ8QwfaO8BvufMajPQkgJp2U2vJnHIB/cPCH5u5OX9JfJFNT3R1g0QNLeUCbBAC//o15kiDUtUpvS9ZlCMjiCKcZl3OA9u3ZIDkOI2K7B5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WlyGbWMQy7i0oHfS56cta6PtJj0j7pijGKfNrt5LvmnyRQzchI150hoWGkPz?=
 =?us-ascii?Q?BCQTByT7xVVWyunyP4jQ+i7S60NybY/EPCTkTscHxb5wa/6mk5hlJ1ys7CMZ?=
 =?us-ascii?Q?CfF79NSnmaWrabJqBO4aqsJ9BkA8qUIdVg2OYiMh0CNiXovKGbz+HlwGJYXD?=
 =?us-ascii?Q?Bi0fqufWEA1kwPxC8vRybTY2N9wtLw6qASIgEI6Wa8e2GHvu9SSCMymHJA7y?=
 =?us-ascii?Q?0rcf1t4suH1Y8L26Wxx5lwFhNcTHv+y1M8Ll+217cGTo9nLOPCL1Ke2ro71s?=
 =?us-ascii?Q?GUeTjmEq0rFCGT9b3/mKRB50vw+xnRfGdX++61hbNNzg4qVe54jviFzM0VfM?=
 =?us-ascii?Q?M6bQ0thJmZhLtBT4gT1sfGozu5e8ZO0HW6MJhmMR+giVVpk9A/xVbSROJiSW?=
 =?us-ascii?Q?o5OX7ygUelalnihLX9GlRTm/UPFhWCA8zdsoMWW0gM09xsjwbQLK4tK7cnC7?=
 =?us-ascii?Q?0yziOQcNzua2YHrIAB+fjoGs+xLpVsc76+r36qkERnZ0zy80meNd8XS3GELV?=
 =?us-ascii?Q?vJdbsi1HU7IJ7ItM7p91PgNwVaOdwRVyDH94dvngQ1yWedVm7g5I0nU7wIzL?=
 =?us-ascii?Q?S6SyEIhFwLOv4mentnxNVFxloMtvQbuHw1BMOkA7wtPzWGIV7YxE5PDMmpca?=
 =?us-ascii?Q?oMjY9V22KAKqWC5ZgIwAy7JJaD+lOyfr1EwD5Fl2zKDnRxis181qLqzOfI20?=
 =?us-ascii?Q?WMRSKd617GVi62py5Jf0fsJ7qK+5yXIf9sR38SUHo2N53J8BrdyfYyNBc/cz?=
 =?us-ascii?Q?eSMgaGJXvo9x5XR9XyL8mPamdeqanpdpk1fyi+urmqZSkefL3qs4twvfDfG8?=
 =?us-ascii?Q?lSmFwFIo6apgMGBQQUi3zonq08jGI9rsuIRZHk+Uyc8thZORZYQC8OmjkmK+?=
 =?us-ascii?Q?Kj4dVV0EfkQ1Dv+ZwE1DLXKfathXgMCU26gtI0ryGQzLUkMEQKILZ5lqIaeB?=
 =?us-ascii?Q?KZmvtc95cm+lFPVrGJGGDxrue1L+OMrGSSJwzkTIvm7g2buD6xhzHm7Qoc8E?=
 =?us-ascii?Q?dUvm3Ntt/B4o1y4mpdlJdeUlrBBS5GzQU9VNsSmn0IoXDEtU1auwn8hwemTX?=
 =?us-ascii?Q?uyGiMCw+BzpJYjsjtgjh15eXsFO5j4iv5nElWGHLxagaC5V49vNBAgWLqkJh?=
 =?us-ascii?Q?jRBCfW/7Wl0C7TySsSI10ZKnK3/Fp7jQNTn7V+ZYUJQpeRxiYAHugSVSVVh0?=
 =?us-ascii?Q?471yAQtjJ3l2XV3gf4FS8hTsZJrh4vv+2h0NHt62V0qgqwhDowRMRjJrkAhk?=
 =?us-ascii?Q?7RgPGnyL0wWpEuWkp/bcxLfQ9hJoT2NX77UIlin6T637VxPq9spu4xjAbRns?=
 =?us-ascii?Q?XaqWVuqZBCeHNySGKFhwCint3uRNwe0ocLpWKJmvTs+mMyeIeNuoU5Mj0a57?=
 =?us-ascii?Q?GpksBxNOTgOdYdFCCgY0qIO5KP1AU22xiXDcne7h0m+g/TpOF7QCmXGZjhbf?=
 =?us-ascii?Q?cKDaevr7/Izl9VmxkPkPLzsC2dbB3Hib4Ux1I+EgCeojC+9/VOfnBVD6ThV7?=
 =?us-ascii?Q?vCmYBwM0fqPk0n4crN0QVHrfKxFnDIhPAQUvDchk3WcMNCKBh2BXDd6nFISF?=
 =?us-ascii?Q?BUAwOx+q4ORAenypfkg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cb4726-521f-47d0-c6b9-08dc4767930d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:22:15.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbeN7/N3KI0u5YgSIRLzWyOrIAIlTpc7ArVwv/Wo01uD9zxUb9qxQLMD0gjuXSur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075

On Wed, Mar 13, 2024 at 04:50:58PM -0700, Nicolin Chen wrote:
> On Wed, Mar 13, 2024 at 10:13:58AM +0000, Shameerali Kolothum Thodi wrote:
> > Hi Nicolin,
> > 
> > Thanks for the latest repos with basic SMMUv3 nested support enabled[1].
> > I did some  basic sanity runs on a HiSilicon platform and they seems to work as
> > expected. The only problem being we can't assign two devices to the VM if
> > they are on different physical SMMUs.
> > 
> > qemu-system-aarch64: -device
> > vfio-pci,host=0000:75:00.1,iommufd=iommufd0: [iommufd=29] error attach
> > 0000:75:00.1 (36) to id=4: Invalid argument
> > qemu-system-aarch64: -device
> > vfio-pci,host=0000:75:00.1,iommufd=iommufd0: Unable to attach dev to
> > stage-2 HW pagetable: -1
> > Segmentation fault (core dumped)
> > ...
> > 
> > I see that on the Qemu side we now allocate a single s2 hwpt and attach that into
> > all the devices . But this will only work currently if all the assigned devices
> > are under the same physical SMMUv3 as we have a check in kernel
> > whether domains are having the same SMMUv3. I remember Jason mentioning
> > that he is planning to relax that. 

Yes, I intend this to be the direction as it makes the most sense


> > So are the Qemu side changes based on that assumption? And any
> > idea how we are planning to relax that restriction? We do a check
> > for compatibility of the phys SMMUv3s and then allow/restrict in
> > kernel?  

Right, so qemu should still handle the case where the HWPT is not
compatible and create a new HWPT. Regardless of the kernel side
optimization qemu is still missing this logic apparently.

> > Do Qemu can then try allocating a separate s2 hwpt for
> > those and attach again?  Sorry if this was already discussed
> > elsewhere and I missed that.

Yes, this is the right thing.

Jason
