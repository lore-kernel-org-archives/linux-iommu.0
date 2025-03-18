Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6C1F5858
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304419; cv=fail; b=SOlW6wMd0w5EJsdbbHJupFLei518zALmkDzANf1MdypNZ1tOZENcQWZzIeruGbkZhniTcMmkj1J/FQidnVbyKj+9TimT7cZSe8UUFmbTiNxgphDf+j5G6upTYZlk0hUYcE7t4ppECwme1KQcQuInNv/hS6vQJA1nc1bczmTIaBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304419; c=relaxed/simple;
	bh=dQr2kVCsE0a5xBOYka/IrMmmdfvBnTgpQUTj/IeMIxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H6P4l5ivtFIowHz4qdB87MG8/Pt9BY9SXVQp+MjnBcjS4ZIz3aQCXKXT4wUwwRAKF+CAZuWp1bwWm23KpEVDQVw7lyJrvXQjYcSw4QA5CehJUMUL5jOP0CB4fS8fK3OWz1M3YvKT0iJz0RMAj7BWrzmx95VUDpVo56kaKVn8jZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oKDPuIln; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oKDPuIln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLCkdDf9P12B7cw2gQsjMqVOMlB1YySe6s6XMoVas2gwBxPj8+ouZgNFRi2x4bffTqTdxW/UGIenfQXD2TCuz6lP5oRpFwYTKG2B+bDWnCw1r8hPhyf0dT1pGWpP3I6U/6djhh5fMH5Zh7UvGdlrTTzsqxJJvmN1RBolbdfBzVnyLuFB0uXlYqj6x/F0R8x4AR4pn3G+eYsmLv4tz7Ykbhxp+3ZJ3VsU9MHuKo1ohbew//xgkLarBgEKwIogMYteEfA7QxqIwN1skyYCs+6353gysIGkPsz/7OiiWGkdctf4tfwzyhp9dRl/siSKLiLoJAHK/VgHdUH32/XZTTInXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5D6/5qpn7aYymmZCtSGtRjebXvPttdwYC9P7sVinpY=;
 b=cwLkNq52qiZbweVc3EuxdWRPguJqtunrWkrhedllmeBI4AWAuGcJmb1G5eQTkCyhivf1jTIG+xpLEYVgn6Ms6yaHnktA0GtoNB2vIcJ51yIlKZD7pH5EOyV8/0IZdxxhcI4MmjwWwLC6pzlFrg9rzMzXCSS2owdztLe+S55omTJV1iHR6sI4OnhEP4BuNhaASXRKrxBhIEP5DTnMtaVZdiAZTLYxp/wzTnAldeeAtAmTqSXYhhnQlo5UG7pnqNwsbjmc1BPaXHhStfCJfSaafN2XuCvUBD8uMfBP4AP9W303sSl90rvRrACIMHBUkG9zhKX53NZz7MsP5dqFGrDREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5D6/5qpn7aYymmZCtSGtRjebXvPttdwYC9P7sVinpY=;
 b=oKDPuIlneQIPo38YqJGIy94e3SjRsSyRvlqyKZfLLb0SXz34usNUXVx9bIeo6TVlTl+2Qxr+Xu7wN9w+YEClJNY4w6KfFnrotM7lhKjgNV8H7GwrPPqfaANHw/bdpXPgHU0khhYq9ixb6VrUtJGbWh4ernBAjatdNmraC/9H6p4bAkF4/XjHYoftBZWULTuV1DEnKJSn4KI0nbudhEYMccdd4kDPUzQnHPtE8jhrDL/jnmWOg37zJfSi/WsRsrJtBNwU06m1bAu+/wj36DX4jC9Inl/vcVZmJcKf00Jk+Kn92tnmRqQl95TEFM6AOynwAPVoCBFJmNI/FN4XTDpZgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:26:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 13:26:53 +0000
Date: Tue, 18 Mar 2025 10:26:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 11/21] iommufd/device: Move attached device tracking
 to handle
Message-ID: <20250318132652.GS9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-12-yi.l.liu@intel.com>
 <20250318123406.GJ9311@nvidia.com>
 <bafc2cdb-fea5-445b-a7a0-5a1fb390e3f3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bafc2cdb-fea5-445b-a7a0-5a1fb390e3f3@intel.com>
X-ClientProxiedBy: MN2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:208:23c::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 78240d9c-3348-4a45-53a7-08dd66208c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKp1mjtYkmskYGbjFMvf0IuhXgmC7gOlA9YMQkRGNkKRSfXlZJ6wRt4siGeM?=
 =?us-ascii?Q?/UaI6ng+xU5vycarrxaHh1OkXL973qCbgoqo7+lybtrrt0IDzTTPy0JNloE9?=
 =?us-ascii?Q?pyQ2E6nUB6k+92cE/64C+TyZMM0QR2IQPpNi6YAF+wz0qWF2G8Gl7CTVVm/1?=
 =?us-ascii?Q?/c6+DVkQMM3YzUX6cMOWzkxEo6Q4deBegKomZfdqVrqh65kUL0lc1q5Aeh85?=
 =?us-ascii?Q?bZ6iYIXJgxYKEQvOWHUUDkDtogWJajUOL94LUqw0S028jqAhyieNiQM4ADAQ?=
 =?us-ascii?Q?/8DZGThFNKluMpT6KFJkEI+pramjVAdPfsqV2AaL6mxqaqlJF/BtZtl6bDkM?=
 =?us-ascii?Q?I2mgGL7LUrpOWWRlosHklfek8mdSP3/5nyrXgqImbbvtypUrhmonHw7kLqoZ?=
 =?us-ascii?Q?4hfw2lbJg8sJNQ3+dEVW8aNymVp+FoL0yGIr5OL/xMX3OOjoyK60eE1Jw/gv?=
 =?us-ascii?Q?sRQFB76rYUEKc6jL1uu3nAYwrnIWRsOTkEr+HH3qBVIbVecG2POH+4WxawJq?=
 =?us-ascii?Q?NnaYVdeOnkY55ugMSPxF6bWjuDZwsF3VG26tVvJ7M2uGSqaoqykQPzDR1j58?=
 =?us-ascii?Q?aFQdKZZf62yVBy7+5s5dD4riqN6BGqFx2O9MH51eJsHz07BYyhQt3u/h8HKy?=
 =?us-ascii?Q?7poGq8VV0YJz9Euo76+4EEp2IuLaaPupMimib3kzp/p0r95mTgWIQTH8LPP/?=
 =?us-ascii?Q?NwfkWv7cmfAIwYt7yhMt+TbitwmfgU6jXTtaibgy8z/SiPrbZwhZn0hudQdK?=
 =?us-ascii?Q?3eiN5H4HM+z1asP/Y4jyO1x9rW3JScmT24Gn6wCtcuJC4nmq7sMV/rRB8SPT?=
 =?us-ascii?Q?8UvJkGHoZgOU5r+y87Xn7Fb0rn+/Pvq8fXvEDllI6OXb/dHMxC+QPikQxstv?=
 =?us-ascii?Q?FPaYghp0FITie3jBKRWMcHPgiIQcG+tL2tXheHqcP5XVUdADUsREAt7YGlpG?=
 =?us-ascii?Q?9gSasXIsqoZLoUhR62rDBM4qXV4yt/DiY+U/80JKP3ysjx5qIFZ7uOzEKO/s?=
 =?us-ascii?Q?CAy8xvxSRiOwR3H+XOYtTr66RlHdtsZ0PpfW0A3nlta9fwvLRY21i27obQGj?=
 =?us-ascii?Q?48/myiKQU4ofYcsoIXMdD1oqYfo04T3wvpSlKf26xDX9jL6RJ+ea7GqE9ZYC?=
 =?us-ascii?Q?eZTlpe2O7HSualyS3cvGEhITyvGO/ZHM57a6/0I/hr1AuMf1mA2q/Mo5E1DJ?=
 =?us-ascii?Q?GVOoaefI05ElO8pxL/k3cDNGmaXDIuyL8XAWRD94dS3aH+qc/dtQ/lwg+dNg?=
 =?us-ascii?Q?LdvnTsOa53uv8X4eVvhHpOMWAElXCMj2HJxQNx6tcHti3LMQ354/VfXZ57PM?=
 =?us-ascii?Q?q93qZjNguh8+8qQRZ9/Ocn5+qtkGKB1J+F8Q+QW/cjse0gvEShj9qvbncm83?=
 =?us-ascii?Q?hfD1LzhxNfBRf8uDUIdMpdaofx9m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+hPoiwh3gOWeO0ZlnYUPNm52EehRvSel1JhWPeg1rNtxYlhrceCyagIXV3vd?=
 =?us-ascii?Q?p0YO0g0kEhgT/lWXBV7cswjIkZLpGcJ8/CCMkwSaVHg6oxww5yFdm4poIGLp?=
 =?us-ascii?Q?BJSYVhoxPGntN5BRq80DhFArVDZSp93QojFy2FO4hlVTjv0mkvwDfmAaiHhP?=
 =?us-ascii?Q?c4WTkSp+7tZtgLstHL/TVGe1cH2WG5rhL8fKPcd2XtwC/EFQLDFLaVSkT5pE?=
 =?us-ascii?Q?t15O0MX+AKACEC+TNu/aDnrAixEKs7KzQH8zWBe4sFIAKZVlNu64cbxLlboG?=
 =?us-ascii?Q?sGiXD1oPYbjrcsVfrEVONu7VtXHzlWN33p0h864TKebU2vQ/mzgmgVx3UEZ3?=
 =?us-ascii?Q?NRifU6NJJfKMku5v28Gyy4v6OUm0EGDpSvhlmKzZ+5L5xR6sWhiWe8itzRmI?=
 =?us-ascii?Q?eacGlLfwobTOyfKhGeaIXWvKKjgshaINcQ1p9m8ZGWqFFuS+gO62a4gbgC2a?=
 =?us-ascii?Q?L2Hm0NDnXXXKOuR1rN7LM6f3YFiD2JN/x8JZ9yNB9qvOUKvl68nGZbXGulIo?=
 =?us-ascii?Q?CwAwXx5K2t6LWAM4rvVeLvM0HRewSeCn5ylgVLxoD5Ew7SqMDpjS+BlHEwFz?=
 =?us-ascii?Q?3DbtS91Ohlc+vMIe6polaOO9Q7o/yYIZTcfeyvMoKMJbt4iuI+Owl1M7oRW0?=
 =?us-ascii?Q?rDhluzxPq0zseUawAfhguAOP91lrEj/IMclu8gQJfOI0s7DpigM7fpl41MxA?=
 =?us-ascii?Q?XYAO3U1UgH/hzSPiw84CqrgPW/UQ2lQhQnX+Ins+wm/IzZPmoKlxAZHN9dT8?=
 =?us-ascii?Q?mDk5WU5YmALNd4/8Ms4FrpWd2s6tfImQNdSkkUXczJb6uDa/itZn7Pafk+6Q?=
 =?us-ascii?Q?Gx0VuV59cO230aDLAmVeCdRX4HgHMgFzkUHeFhYDm3lWWz3xyq4E5yQdcvRI?=
 =?us-ascii?Q?YEYPTAk0Tnm0lttV05na1NUjhJhZ5TRDMzDHZMQ4PVQ/Q4484/NPVDwYx5tR?=
 =?us-ascii?Q?asVqlRusJGGhpyjStExv1E0uJFBz4Ui67Myx3pTCyJxg3E4klDCGKE6ps5yw?=
 =?us-ascii?Q?3lbs3kw7kmUaNNZ/EPVQ0xfNWswge+STAzOLsHorlSpndy1Xyi/EIk+tv4oh?=
 =?us-ascii?Q?McR56TZn7GeeW7kypoLWRpHbhKBBxfW2n7ly2jtG33pGR5cxxGNZtZH8RJKP?=
 =?us-ascii?Q?R5t5tXgGyQXiKaG0Yd5lKbI04WazMpc/dPJH0BMQfEDL/H7M7otnQ7enpmcI?=
 =?us-ascii?Q?jSazMHelDb35TGNaryYnOdnk3kTOalaTiMIDfVKryp/p0h7qdye9qvpLTyPW?=
 =?us-ascii?Q?miTzfzAONc6Ug23Dc2SaGSCEEdbxFM6tKqKHD5TmM/XwLYJDjvNuwqsVEI5/?=
 =?us-ascii?Q?ODruE1sgQ6H2U0E6BfI3Ki/LoSBkGrxcQBjJhSUfYnWvIZmS2vJwLPOhFspH?=
 =?us-ascii?Q?rlqzIahlx24MoWNx5yqkLIFR4jGnWC7nEhcZDrckRtNgF1N1NxyOuAaMx3Ex?=
 =?us-ascii?Q?sc1YxZlY8aUdiHMnZMENd24NIXOdWgCcbgCOkHOJV0THzGstK8xIC7fu7ztC?=
 =?us-ascii?Q?uRfJSYeDsXrzJR7rg7glc2GnFoSgxnbLPf7Ehes19ILc738QxFwUcsZKqP/D?=
 =?us-ascii?Q?Gt3O4EgltMXGsfbI0czEr29eg7YuZ4r+55ncwvri?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78240d9c-3348-4a45-53a7-08dd66208c0d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:26:53.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpY37k1OJj47Sc/w4NTK1aA3ETiBAMDeG5Dxhmn7xvq9Q/y2iR5VC9kc9jlXAQ3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

On Tue, Mar 18, 2025 at 09:25:56PM +0800, Yi Liu wrote:
> >    	struct iommufd_attach_handle *handle;
> > 	struct xarray device_array;
> > };
> > 
> > ?
> > 
> > I think I'd just accept the additional allocation and not try to make
> > handle re-usable. Every unique attach gets a unique handle allocation.
> 
> If so, we also need to loop the device_array and add the attached devices
> to the new device_array of the new handle.

Why? Just don't use the handle for that, as above, the handle is still
a pointer that you allocate, and this pasid_enty is another pointer
that is allocated once.

Jason
