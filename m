Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362D8F62
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601067; cv=fail; b=opj8W0LQ1zK7RlhsOOJzMrTjlyjYjuSek0B+f0hWVv2MKaMeLpjx5YiMrSJHLd4cPy848YDkBTviU4HtyFAo+vsUSjgCpIm2W7tmJQtC3hciuuajZ33NU9hAMhXq/+gmhZAEpwIa6h8TlEIXDE1gmLIHjAw1hcqtU2Gxiu43Q5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601067; c=relaxed/simple;
	bh=TKMogpKeyqKb7lrtTIhKNan8J5mQ1A7YrSctrEXcgt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Po58cwYHFHKVkqQxnoN0+8ivBE08PJgd8TEEL6rVJDRykGNF0kpUPJMi+cDcQ7d8Vhh+NNnVcP4OQ28USPuvJDjcWDe1tdehkPI68KeOs34YBcoVSQ2CTx0S4Xjq3Z8IkNr6lGDrZFTPOmAiSPoqRpJioCzec0TZNmGCml4i/2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tgro4zac; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tgro4zac"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZUMrFqQP7a17VTWp5K4+a2TJb77ayR2ft0olBx5gjaY/BJskC80ZUtId5NE/yPDK9XHeNE3WqxEsDsD/Y/cBj3eZMfPljQgDv/re1E3XdhE2c4Y8QWXXThI18GG09DZNhdJJM1l/4GSo9Z6RPmPOScXNnzIKvm1/xzhCiyuOSqsYWmAaAPY/UMXVY2GBs1RqLo1SWgudCyZ/OfIamNwcRP0XKbUbswUNrfV24sIf/wl5MEAmA+Hk69+RyjVan7M87rAUUVNmTtwneLYP+KLhFPETnPBUY8R63wR+seCYITuwdrGBqcsrerylQHnBwA8aHtYl02TUmJ+iFi5jasz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8bDHPiCUJgfhflM/CxBg/5U4FoqB1nmvqL49a+tq2k=;
 b=bQv5faaY8TMYqOKwj/tp/lg82s8JqQtsVO/HDqlijjFCr3+g/YBlVidxfUF5fm0oLgR827Y6P9pKQuBI2bdq+5srhWkOY8L+yi+OxSIqIHmIIPTsa8pl3oe3S9hyp1e9SAKpn4MUpz3XarvD3s6OTTAwjH0WS7mkXyKMQkM4tCWtpPjTgJtEDErk/cBuIpSNDn0phkA51O30UlZq4IV5sAmPXUNMhWZjPN3NOWRoljztdpmKacyXYPGhOGoxMOp8bhRhIBRZW84UK0rljwi+8L/gLcciWnU1HSw2hwD+L8w8gMWjG+NW7zZFWcydRrYPOl2fiwmeSqrH1AgnV6kBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8bDHPiCUJgfhflM/CxBg/5U4FoqB1nmvqL49a+tq2k=;
 b=tgro4zacnEjTimwFhXVo4aWB+w2cD+dZ3GLgRHdZbO9IDGPm4UW8PKm/vvuuAPmjBoDI6tk6nAO4/LdbCueWA6cjk+LUA8eFzEWa81CfUY+0AxIl4cZDpEC633UKo1cONZG+hP+MAqv5c89cQQJNQ4sanzKy3sVEFtGKWLhbNxWRLv+jDJ4DAImpi495Rgkgq07yUh9C7Xg37roA1aCxlApYmZ46l9jItkY9sRB3SkBWSal2qJWXXVwmJkvqV9TjB8jIo5hbakekg7k2F7CDqE7VbPLiDKHjgU1NqGTPAf0mwdLan09BHIAEDW+MPTVaXlvPVsd217021MLXkyULTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 16:17:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 16:17:25 +0000
Date: Thu, 14 Nov 2024 12:17:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V7 6/9] iommufd: pfn reader for file mappings
Message-ID: <20241114161723.GO35230@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
 <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
 <7788773d-471d-48ad-9f9c-ddd5671b26e5@amd.com>
 <2bbfb5fa-20e5-4935-b52d-73b5186c6123@oracle.com>
 <5ff5b402-95c4-408a-99f0-2f6ea4e617b8@amd.com>
 <20241107140821.GE520535@nvidia.com>
 <987fe758-de45-44b1-843c-63f3f82fd864@amd.com>
 <71e700f2-178d-4847-8266-af285fd5f524@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71e700f2-178d-4847-8266-af285fd5f524@amd.com>
X-ClientProxiedBy: BLAPR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:208:32a::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c46a3e4-6398-4518-67a5-08dd04c7d37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dAne00pohkmkdLsGs747tO85WXMfkaZa08inN6r1CoDT+Tz77IYBr6leZRuk?=
 =?us-ascii?Q?VV/TZCyD7GsfZ1AQQID6WeIXlLJifsTLRYMCfMDkbTKBME7+SLoN/cm1egwK?=
 =?us-ascii?Q?w6nx9idtcx6yhLZawosmqe3wIH2AgMJkZatkfW2/yIlW1qhMWCr5rWkcN0S4?=
 =?us-ascii?Q?Q8OQuEDplmM4YRhEkDDdxQMTCxwOcqCDBtbxS3yXDu8mO6BPb41NZtBHDXJS?=
 =?us-ascii?Q?XOSftf3e70qEaKRtBg5B4jP+pAs702cSAmFDoqKIF/eoVAP3Tg9VmA5SntVw?=
 =?us-ascii?Q?Kj9+Sbe10ZXXcoFYeVjGIjpiUiGVFdPbnFK39TOEWvxeQ5DnpxnBct19f/gl?=
 =?us-ascii?Q?E+DY16pxMe1SawTKhfGJb0Fe9+d0T80ZRXyDColkGjuGm01d+QtsdKuqszRD?=
 =?us-ascii?Q?xmh+zoYuW/Q496WrZwHVp0Lo0wzPix10F5VRHv3RXbHWcog+L+D1xt72Bn+d?=
 =?us-ascii?Q?gJ2DlvARHIMWzfZEFmwc+65VHuRFi3thYmmTXjXTnEEnDRD9HVfGDrEjGoZG?=
 =?us-ascii?Q?+Mp+Q5TVxpQvK8z1YD3ck6/7VKxhbWyB3AClG+CPPRAzR+9hpfvqRg6ueF4/?=
 =?us-ascii?Q?Fl5FAAaRZgcnXcF4OLLyozwwgQhEgzDHHrrXnUqaRbyYcgtRa+kn62dUCQqJ?=
 =?us-ascii?Q?BrPlJq144msQnnS1LgsybEZqqpvWofDKY3qhrKwsOnBD8j2nERhjm2QJHZvz?=
 =?us-ascii?Q?nGUgG6adt0N2s2z2hSAb4PHQsuuxZCyZyEEbOrPgoAPjT0Gzhsb3VULUi6Pz?=
 =?us-ascii?Q?AFAXFnKaHwSQXXtbJdiTPddWWaUXA8qnFmAa35OYoBtV1pUbpOGTKdo9lzpl?=
 =?us-ascii?Q?i/T3QRaiU6Um8b3T24JLDpEvuMPZyDHt6Sl9Y+9IsQMX5TBgc21cWym3zPoM?=
 =?us-ascii?Q?eUMGMBNHsaMpk9eOb7+DTKRqQm10W6YQc8s1HERNX7+P8cnrtGf5jsSfgPD/?=
 =?us-ascii?Q?siodbCg3q+2p3dgVE+vQtX/gIkHRh+Pr3IesM6U2J3EBiJyosrYDhy5l8ADQ?=
 =?us-ascii?Q?vo76NA+ymkDgYAUuSUKj+Ix7yM95SraoGmQAFsTB7D5wCKiiiCJejUrR9hX/?=
 =?us-ascii?Q?WXv90hnTKN7PSgS5WOo5kcZGEHrAHJeYJI6Tmep+bYEgavDEqzs4eYvof3q2?=
 =?us-ascii?Q?cYpf1BccgVeoFQK9avPJYdx+gOOO8a/w82JOGuC3yr6Miiwpq//vkZhFK4zi?=
 =?us-ascii?Q?NXKNkuHrWsqZiwR3KLxL/kFWDKlccF33uxv+kXBhGr8KyBZAutcjoVVgh1Pk?=
 =?us-ascii?Q?EnJqbB79ZNJVmxy0Urrrpre0/0ct+kIGF4YfDV+lK758Bpf4RrSlK+DQbQ6R?=
 =?us-ascii?Q?b4SQvk7Un1haKp1IE+K46gl0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R5mJcPW6ggUyUHnwixROktj8rkerNeL8AxuE6g5TSiILKO2Yn4hH4XQn3faM?=
 =?us-ascii?Q?zPx/BWrFdfx84Em396ksyB3/ku1hrHgvtTjGZYBbjNgMi3SZZPDuK7dc+4kt?=
 =?us-ascii?Q?VQEt9MLiPsury9gkZ4i3Qh9f4paOQiG9aP9mX66fj5AIXsIH+njP6VqMbYJ+?=
 =?us-ascii?Q?iJRPHYuU87cK+u6dWi8X1skxyE9YmdhvCegQPZskxPivqMlOshL7H0PmD2Hc?=
 =?us-ascii?Q?3HtP397AgmTBr9Ms4JH1V4vUXS98TUQvhX7Pt3CechvPVhs1S8AQkXyzu/69?=
 =?us-ascii?Q?2LZ7VQtCol6S8fHlhkNbEbvI/Wqbg4UWhq92eeBs7O7FjHsLmYPFr6JlCQFw?=
 =?us-ascii?Q?UxBgyb20qBZKlswSC5vB5jhFuu+RSaTonoKtTGCCuIrapys3/tFSkdIROK6b?=
 =?us-ascii?Q?OzAsYrjmKs424h4EuXaSXavIiKd4lLes6xw6mJvweek4K/ospoB2vQ0arVBP?=
 =?us-ascii?Q?dFK5AvcxqACmEV5yriIpRrwe4/CdH1Yjv8TqS0Zd70mDQSWx0TLOeSQKaV+5?=
 =?us-ascii?Q?5sXm/iiGgJxEsonJLKIktuHGxODhFIXS5fEqM3LXoR5bCwti64HXg7QE3R67?=
 =?us-ascii?Q?bGSmI/6v2mAWHv5dtqHeK0OwfA9G/P0O8zn1BBsl8FemaXplSJDn6/grP8tp?=
 =?us-ascii?Q?cR7E1WB5fEs46G1C1NMIPG/f4LTECvj54v1fEe51By267dbnI4kEhsnFFSyI?=
 =?us-ascii?Q?Wp0QG4FBgEi6CVPcjufDYHteyPID4H8J1JgdaRnfjeeJ3kD6CFGXqeHPCQ+i?=
 =?us-ascii?Q?oSs6LWjiF7OjlJ8yKfvd0nHBsZdvJCHB+hMbcLs1KOWirF/bcDiq2DqWvBhg?=
 =?us-ascii?Q?TyOq4GndVqnlqUwh0Jubysgd8YaplEactq9pThaAAU6xoCRtyco5lj1f67ih?=
 =?us-ascii?Q?XZdYRf4UPvmA62626zRbN38jOWJXZ1N53Rz93cNiHNjZsZOf+4g4Bvn4Uc95?=
 =?us-ascii?Q?kC8rjM6d+8SciCGSAyXKh1aW3FuA0E+a/apSDhLVtlImSl5MDCWNIn7Iy6rC?=
 =?us-ascii?Q?gmcMAc1owvBBD3JQmOVCSnaaPRvlXPQJ2SEoPo9wDgQQ/JY5LZprCr9Iwwgl?=
 =?us-ascii?Q?uH9kI3HTIx1EN6UpcEfztt3J9/sXc724zkRglCpP5fEM0FcDZqqp2ms4Wj2X?=
 =?us-ascii?Q?xF+V0GaCrUOC7yR7EYMiCiniGbw2Vq/luVbPbjLFmtA1UfgJ9pm1UJMveXJk?=
 =?us-ascii?Q?GEDciAID2ZMoN2+yOkuK2NUQKIMhcGCpHj1azUUGEGgyf+CSzldk4qsgz3UH?=
 =?us-ascii?Q?yEu3Lxp8HyYXAae+sC387eJqG0+QJIjLFOx8O7GF6erK14N+QvO2M7EX+V2G?=
 =?us-ascii?Q?HbxYVUrWB0lC9ER2VMGSqrw3Enrtv790+igrgrc7Pzg4gajWiqXBp+q0wHq7?=
 =?us-ascii?Q?zdrUtvwSu/HQyX8avIDeXMifRS2vdMUy9T0K2dWb24iIXi0WHly75qep1osO?=
 =?us-ascii?Q?JFnUxHLKVpFD7/t7zceZBddZf4Mzr08TpE84k3ZspODdcCm6c4nZozJmaejG?=
 =?us-ascii?Q?zwxPBd+UETdVtURGSGBpotUWRxod0on2NvsOg9TRXn3BJLK0DtJry4Hebd9n?=
 =?us-ascii?Q?tW9WM6MLDHb1gGNITSs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c46a3e4-6398-4518-67a5-08dd04c7d37d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:17:25.1693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u59TltH7nWVR69DJFkaO08glP+zfmfhCflAH7J5B19bvay7a2FVNfDst7arlFLxr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744

On Thu, Nov 14, 2024 at 03:03:36PM +1100, Alexey Kardashevskiy wrote:
> > > I though KVM had its own private interface to guestmemfd?
> > 
> > At the moment it is essentially this:
> > 
> > folio = filemap_grab_folio(file_inode(file)->i_mapping, index);
> 
> Turns out the complete sequence is:
> 
> folio = filemap_grab_folio(file_inode(file)->i_mapping, index);
> folio_add_pins(folio, 1);
> folio_put(folio);
> 
> so then unpin_user_page_range_dirty_lock() => gup_fast_unpin_user_pages() =>
> gup_put_folio() work properly.

I'm surprised given how forceful people were that pinning should not
be done there. Please confirm with guestmemfd experts..

> Later on, hopefully, guest_memfd will developed ability to mmap() and then
> the existing iommufd mapping API will "just work", I suppose. I'll carry on
> the above for now. Thanks,

I think that is not possible, the entire point of guest memfd is that
private memory is never mapped.

For the AMD case we still need to program the address of private
memory into the hypervisor iommu page tables, so the FD path will have
to used to make that connection.

Jason
