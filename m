Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21F18E354
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293019; cv=fail; b=RHeey2Lewu+SOtNi/0vK11X/WxEi4ttxVccYGVuTlEqCiSU30kUGSiih+HyBc0fVMT9O8b1TSfMdSu/wzQp8ykUcKXK7tmduDO7C+q/gEmT43mSvoWPMTp8+TKHwOfejijzjUkm7OsOe1RU6AsI0WltNd04SxaY7nhIdSoCCEsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293019; c=relaxed/simple;
	bh=yYnqG/OmVCO7uwxSodUazN9uar9qJ3SDdfuaghBQ5Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ibch7EHpe8HhuL/on5CbBo7qfp7LJuPj3ylNSUAsQlZ2QnJmVsCjH4t98MNGyrAODuCWMmUYI53pfvpQfOZraBqJEmBw4Ouz9t/gITddyj6RSQrofi7KDxTslLXpwUiXHMy6LHSMkIoldodEZaa8JFudhmMaVVWWyu+DoQcjYoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QsErIVpi; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QsErIVpi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3OyVPO7aJcOfm0q1OIHxvsn2M7XvO5eTg/h3qrt+jKx7T3c+T6G/qFHPrnRUKc/uSXV0AMXZoEiXPZN8pHDixcBunuSbC9yeMbsRuPh6KSd4eYTPewIzHRGAb3j/QJ6AXNQZyPdABUL3MfWdzZTeYHK/3qAUZrEohGFpKq+j0F3rwE5zK7aKidnCW+F5JnG6NYaLO+j5+T7JbcLDIBdDcnLxIE8S5CWU9qWMXrVIeiUA+inoxDiMXIN8njw6p7rhOfMhI190cwLl1MCEU2yhmSV/xAa5m1oKom60FUUHYVM76co/hEBzgBSiwcZp6intOP6B8hhJNknYG9niyJj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpH59/YwUEuDy1FAUJ5O736PPNAZjvRe1mmyyc6J/oU=;
 b=Pw51cgnXM6RA5RDxNxY+CbcQVbH4vLl+723m2A5qMXKbRX6TRFfuuWQ0NbBsuivW4+ydDjmnw/Lkzp84h559sKcbRptrzpeYwcWMF/REQrXWY/MUIJxc4MJsWVT8h51isjZ5hvxvziZfQfWYleMxHYsaPfw3O/Me8LSusjvnmNsiVo1mWNgBpD61/NLrzcOmYZL6xQvDT0SzUsUnTczCGFr4dDeR3ZjLWIWfZsJWCagDtJIPHaYvfeTJlkCDdwoqFlTxrmpZLmPGpLrcQ0GCQlzEwb6hoDp5T2wfSKGQDmw/Z33BkEkj+Zm81SsVm4OFsCcAlbX4ZqI8lGGOIxGmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpH59/YwUEuDy1FAUJ5O736PPNAZjvRe1mmyyc6J/oU=;
 b=QsErIVpir5Pg2CDtyjTZPOR9wR8Z6XLNinPIWCc2w+6rM6qvC2a0xWWd6YskIbZVbqxjuGfmvKwnXbv1hryu0PmumPi7/f3R48aKZpwhKuibn6jE9xyNJHK0kaHvxrOu+wzAfEMnk2G/g6lzVLMA/gwJl6g+ygoAvmeEf1p1ZSz2F7RflWGwC1E/g1hAz4AGv4zDyh1xC5Sxe+dH8RLXWOgpoLquYji58FnktInVXbqUu1cKhldSQRIYRYS/KWv034m+2uHkEldfxUd/5ekShSBvnpPtMoJWyD6+k+845a3msQQb89xzzBiEjqFtyRhfm7ZYs2J0gW3wPiRRUi6AcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 23:10:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 23:10:13 +0000
Date: Fri, 18 Oct 2024 20:10:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
Message-ID: <20241018231011.GL3559746@nvidia.com>
References: <20241016130001.GI3559746@nvidia.com>
 <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
 <20241017192418.GD3559746@nvidia.com>
 <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
 <20241018001046.GF3559746@nvidia.com>
 <279c7e80-1d72-407e-bfb8-d286760a5e11@oracle.com>
 <20241018160430.GJ3559746@nvidia.com>
 <dc59dc36-027f-42c1-971a-8218c658c5a0@oracle.com>
 <20241018175951.GK3559746@nvidia.com>
 <55027ff1-05cb-4ce9-adad-8dca586a26ac@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55027ff1-05cb-4ce9-adad-8dca586a26ac@oracle.com>
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5a7900-d521-4926-832a-08dcefca051b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WkA3CxBXE2D2/JgPtKm693frjSMFCqPreO8q98X44DVeecN1AnGk+qSWIN4h?=
 =?us-ascii?Q?Yar12WFS3z/sVSQ6EOk47Dlkjr/vPFtk8XMqllv35K8ZMDj4dh+j8tLPpPHE?=
 =?us-ascii?Q?baNpzw2ygr6eeJVE91qb86pahubkrFmyeqTrGiWiOIXZFmnTOgJMQKVgb3yM?=
 =?us-ascii?Q?8Pxo/+vl9swITsaofxGDGoCxyO1eJMlS6fCJReTBzhzmzl4xsPfr9T4ZBLsw?=
 =?us-ascii?Q?SteKHqmAqDKHg5N8Ycl8cJauJbNoJ6JMOy0uxdnwxNOmDyAJd1JQo/7Izpi0?=
 =?us-ascii?Q?czxQks+JJk2sOiu0C9WddqKqajL9DRnYgLvXmg/ds9zQgThwk/ESkJnImDlL?=
 =?us-ascii?Q?TLhZh0LOIi7RVHV0T0qjifKetT5TZKlM2FjsvveBEijVyHp/g9KW2hH7tCtf?=
 =?us-ascii?Q?+N9gfntymQIzNeSDf/otfjpn97LyGP0OWmrE+N2db2QDU6rZX7TQwx2+uarG?=
 =?us-ascii?Q?d8qX6tPS0q7vjbV5exgbRscaGFidIQwanb0tbai+r45M3IMhO8+mZezvl2Oz?=
 =?us-ascii?Q?ksocAYaW9ryHiyy21wPhLmKwQYfGyxQpeIufYrwyrt/NV2qVZGyp0uquWsox?=
 =?us-ascii?Q?a8wXzriFr+0hJL6uSXVgRHjLtk8oJKnr2ykflbcLex/yr806gmKdA7oSIt5w?=
 =?us-ascii?Q?2L4E3qae9AwVRCprkdzxsLLvzpxhUi55epA3RiGoSfPmpyK00A5hq9W4VTgw?=
 =?us-ascii?Q?hlnFTo6xp1s9tguiBmMeRIwIWjISHZtRl0cF0Oshz9KVN7MG48qBxyxhHKCM?=
 =?us-ascii?Q?zqMmLOK0+4pnYo1/nxZky3dlJEJvSeg7sFvPtJX2Yrni3tKjAzBN7xML/l/E?=
 =?us-ascii?Q?fzgKaq0+nkKmTQBSqKujHN6K9e8afkeeELaOQ0I8w30CXSOE7LhSV8iJrdHH?=
 =?us-ascii?Q?UA+r0lbgWgqqBoCiuma/qt6dvF4qkSfk5umMQkU5bb8F+tyTH3PplWFrct+w?=
 =?us-ascii?Q?oU6A7nt/bkocXiK/235ij3+Bld/qtAyFnbg1piU+u0LJnugsRyXqRT900wiq?=
 =?us-ascii?Q?Ejhw2Gw7HqKW46BKq5YW6i7uZILse0AGQHTfkdjtGGxi0UyNzh5r0j440ZTJ?=
 =?us-ascii?Q?dPGDpeu8jnHMQ6PvI7edGaY8e/BbP3P6gUz8zYvurjrLO/xhk8J7lHiy2y1f?=
 =?us-ascii?Q?eB0hSRzh2iAIalFIjLBi7SAe6N2iZ44b2YGtOE0u2MDEXC/kSwihV0yYrnRr?=
 =?us-ascii?Q?Q57Xjl8RILHssxfZa74J2gwD9DxTc6RKsFpf/jE5PFzWWnecw4g00uup/Rsl?=
 =?us-ascii?Q?zwjT3jsMC+qKr4DEetrattqHms8TuNL2jeb3t7HkBvAO7zcIZ+JMLw0JvRYK?=
 =?us-ascii?Q?bcg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44O3PgxfMIrO2yEDV4+5CQ5JZFJ+WVsfyvmpNXrfkxketvbZx6gOvfOTWQB6?=
 =?us-ascii?Q?cibj3WRWRPegs6eVfVZMOMq8qmWj7/xRGzgekmUgX3pi7nElsJMWpLnSf9TX?=
 =?us-ascii?Q?VNULHy4tvpTuQNEFDripggKYn2W05hT7uYmhd/nk92WTQhf+6Sk5z4HlTVjL?=
 =?us-ascii?Q?KkazhRRjPkes9FEfTldlVQOqxdNDDLHoupnzhLw2F8eroSGEOdfOa7+kLNSv?=
 =?us-ascii?Q?i209Nb2B0zWODPRoL8QGpoQHfOVJ0YJtzGOBmlZ42eC6YOIYovjZzUBJHCFr?=
 =?us-ascii?Q?IQgpFSr7PztlVwXNftsaksNyquJwLQb+6TAbyXnhGrOg190LcSIvEe5EqQ9G?=
 =?us-ascii?Q?Hs5Zk5maTql+cM97XFXWL/Mx89noVxo7ToYB1WVJTHOOPXhbYvwEuL6SHI2g?=
 =?us-ascii?Q?tXnD2diJXBuDc74qmy1QcbARzP78g61AP1Taj2alte2OsUKJrX13bA8pTCWQ?=
 =?us-ascii?Q?716IbnhzWnwFdFvtrNi3lj8CGMDBuOY0l2AxI4ts5sWYSfs81tu/CFVOBVih?=
 =?us-ascii?Q?p/N+iZi6IfYUOjTRf6dSz7fw1B6lpZrBMBw1PBjKqTbZbOOKxrlKzDJvHDXu?=
 =?us-ascii?Q?6CixZge0015BTJsZ8jdbn+Ixh+2mi1G9NxiVrZoKcIssfFgAUAppE8B+jiS0?=
 =?us-ascii?Q?41x6odQk4WDZY3CzhUedL8a2rNmsZ2GkCXG1MDuiRkX7l/HAnN5dxO2HVDRK?=
 =?us-ascii?Q?qYoW24ZRcSWouvZ7Dk1arm59linI2e7cHrunmmxCosxtIrfj+xrG3iM4NX5E?=
 =?us-ascii?Q?0woSA8368Mca9jgO6t3Pc60pthdDiiq4UNUnL2VTebD89h3RdJfIfY9w23Vv?=
 =?us-ascii?Q?uEdzyt02cG5a+bden9AVMrVSo+JAmqASpKoyfqL16UV2Npg+N5PB5Flbh3hF?=
 =?us-ascii?Q?Vr49s/tQ/hDHWebP6VHE4ThVLX9jmxD+UyY/HsS/73KWyMxFL5t+dscjs4pO?=
 =?us-ascii?Q?lzjHDMETqBf+QVbjRIDlOf/WJ2VYalL8gSfO1lwj6qiyGuLd6+PN5h0bLIUz?=
 =?us-ascii?Q?4yyWB4WOo074mqyFfJNCGyS/MyOH3cTY357BpBHP03kM48VER4BQb2E9Sn9t?=
 =?us-ascii?Q?cMJzC2R1FoOEdrV8j3NE91f/KaxucG3Lzm601lYeyexfWqfFgI8fAvZMy0RB?=
 =?us-ascii?Q?iJH06xnt0EJw2FIKJcW9ZmrRhM+DsMY7vgIHqjstt9ejm85K/OxKGUm/ls6z?=
 =?us-ascii?Q?qXyRqQw9IXwUWegIj7Ga0HIIv87zj7lG3oPsHPnlSq5xOre0vw32zQkp1iOj?=
 =?us-ascii?Q?ooeUYw5WJO6mFshXoEH0gyEjrGpixQLHWceAu6JeLBl3tdGWzEx02HHB90+8?=
 =?us-ascii?Q?gXZIa6aVW71lB3RhmqAelILL3efL6nM/mz7lFVZQLm5u1EZ8juc5WgHnY0Fi?=
 =?us-ascii?Q?THVwOvjFIJE0rvAQQCWbojNUd1hIac98pc2Y6KGuQm+e+LdTKeWtgAuAdBoP?=
 =?us-ascii?Q?c9Br7tU7uvJpHVru/GjLXbKtuhQGVWWpXx1lXwTc2tAAGb5fuQpmG/yTPKXm?=
 =?us-ascii?Q?FD9LBTDkVw/wfHXs8oRG04wUqG3pBFjCKveGnnWXqzDW1ierJB3zLROH13MA?=
 =?us-ascii?Q?dOQosAgBdIIgfnncVLU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5a7900-d521-4926-832a-08dcefca051b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:10:12.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnKWYO29WnfHfLam+oF4FnenJmBRt4VjL+r9cA+VFKj6tUiFJcVwA5bvbgQQH+mJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461

On Fri, Oct 18, 2024 at 02:10:26PM -0400, Steven Sistare wrote:

> > > > But why is that such a problem? The ufolios_offset already handles a
> > > > partial folio.
> > > > 
> > > > If the batch fills you leave ufolios_next alone and adjust
> > > > ufolios_offset. The next iteration does exactly the same as the first
> > > > iteration and takes the partial folio.
> > > > 
> > > > The refcount has to be handled carefully as the the portion that has
> > > > been put in the batch needs to be refcounted at 4k and the remainder
> > > > remain a single ref, but that just means adjusting the refcount after
> > > > putting it in the batch.
> > > > 
> > > > It seems like it just works naturally and avoids the double loop
> > > 
> > > Yes, I can squash the nested loop in batch_from_folios_huge.  (I was off
> > > point because I thought you were suggesting something else).
> > > 
> > > Do you want me to delete ufolios_huge and its special cases?
> > 
> > I think yes, if you can get to one loop then it would be a degradation
> > to sweep the folio list an extra time just to figure out ufolios_huge.
> 
> So now I'm confused again and don't know which "double loops" you want me
> to eliminate. There is still a loop in pin_memfd_pages.  It calls folio_add_pins,
> which I could push to batch_from_folios_huge, but it also counts and returns
> pages.

This is the one I was looking at, yes..

> It must do the count because the caller calls
> iopt_pages_add_npinned().

Ah, this is what I was trying to get to, if there was some reason why
this loop and this pages calculation was needed..

So, to fix that up you'd need to adjust the memfd_pin_folios() to also
return back the end va of what it returned - it calls it start_idx
internally. Then that can directly give the npages for add_npinned
with simple math and the loop in pin_memfd_pages can go away.

Then you have a single loop in the batch_from_folios(), which
is what I am thinking about.

What do you think?

Jason
