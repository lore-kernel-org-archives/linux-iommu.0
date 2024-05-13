Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C47F7DB
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639466; cv=fail; b=h4g5fj2MjLdWmOWz52k01nFcvioIWELfS8ed3GFnGN1PgDzeTQ+fjIV2GHGK38JzXaeSaReT8NZWcFaudLTRKmHtLrr+yrG5Ib0+hmwkc3NInUtj0YPjKGYL3Qt8S2nQEVOr825pWzagV2obZsRYURY5Vb61Ekevac9YlWbtcc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639466; c=relaxed/simple;
	bh=Ih8G7utJPq1IFV0YPLerxzQtXWE4zh4MOdXICDgC2ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lIPnM7SEgWuEjZm5CMlhJoGJSzoaZCxzb2PWUc5kHfebZAPddAqYFt0Z6MgMzdJnZbKIfyA8iha709K9loBROVT0NiUx03lV7HBxnvi6BgRcne4FWzzzwE+ds2JlzcDyvTwntsW97tjZk8lGquqNOmmtKOg/egAZp1PDNTm4N/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kf3PL3eK; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kf3PL3eK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnWiJk5xCxyxQyEPMB718s8qyP6WJsiHsa3Ng6T02KtuxX9dvzeVzpa2qBWjnEchZHlotogQdsbvH4LndtbcVgmDjYwicQ8xZ8lHfgm8+mIrHclD+E5CCZitCq797gHatpvjhVAklMKbJ+LfNiNajsx44Gs35KLfx37t3BF23zIkP4MvY/6kFq6e6Pjvt/1UnSj0SFlXiawmYDMichsnrAYsQzpBAQVtEYMlzI6vykMKYDyZ5na//b3O2xp04frTw03mhSJvF2VmrjzSkF4IBPp291GliCqRrDKM0HklkepMUHsVlKxQSy8i5pH0Esi7CBmwF9ywJOjU5rMJ7HtYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6uPQqsDtSy3dWjY5u2Z92DsyhEkRjC2zOcYS8SCMaQ=;
 b=aI/F6pyKgDnx5npd3TorwBYJgN7FJDqqk7H0jvC4wGbKh+vKmF7ZvxG8+cOntPdkllBIf6m/xU3JGL/Oa4AosdqtEl3OGIIZdhiYohk/EYi0xWXqfg6FdcFx7/4SazHqwXMyTkUh1BZrm8C5Zf8G2qz7OYBGsBqvN+KPKaisFCRu7RPCL1R+YQKqUqTljNB6yKsBMnRAt4r+aT3P60hOooieRuiP+9whfstwzySyJYXyyucOvPswCrViVyaSjMzBWNF3JIqmXPc8LR9yrZV5L030FGUur4FgbL1ubdSAL6/1UgHr2v4krcJebvZgXh7y9T+tddPEiAC0NELsyIwwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6uPQqsDtSy3dWjY5u2Z92DsyhEkRjC2zOcYS8SCMaQ=;
 b=Kf3PL3eKdjYUcpgE5ujgJeyDhNycBOJ+cCYrWGZpTVdFUnG8MdeESc/NbYfzvI+jjRgUKrwYIa066+ryOGl6Gamym+tMdv/lKMS0DK6FdzBCPTMeIJionJ/AyfeezHjXn28chdUVJhQSYlD+RVzwfgZ4ClxLKtcbvcRuYlskyzshuD0tYYpU4G9rKWxOqB/YSpYJCXuhfCrSXd3JdjssjiEcZhNIDhV5Ce5azNKD7MAFOogebdk/jrVOPyjcuU1bjlGqzyBmgZ2wev4oZd/uKQBddmSMTcCfvQGKgCpbwv/j16W6QzvTg2/J/FfG5msLOl/RZL0/R9PkhofUwTPG3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 22:31:00 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 22:31:00 +0000
Date: Mon, 13 May 2024 19:30:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 02/14] iommufd: Swap _iommufd_object_alloc and
 __iommufd_object_alloc
Message-ID: <ZkKUo1Z+YKdsUPm8@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <43bab81816a7bb08fde868a43d62c439ede91f9f.1712978212.git.nicolinc@nvidia.com>
 <ZkDDlMouOmfTaRRg@nvidia.com>
 <ZkF7EY+COAPYNWwU@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkF7EY+COAPYNWwU@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0b4dba-8201-42b9-12c0-08dc739c5da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4pMNyg+zBSSJncjw1cxzER8+Dq1FV+wXkuaHAEorDzKQG/Maz+JX5NL84OMp?=
 =?us-ascii?Q?996DKsIvzH1kZsg6YHC+0NjCHEe2DR8xsDqEsMRe51UY6kKf1mJpsKbgiDCx?=
 =?us-ascii?Q?OcogSKhSpazv5VM/ptLZV7rp/tUR4ftppDIN/sPp02OgYh/3vu3uS26iErtQ?=
 =?us-ascii?Q?CNqUmQg8sOXCc1X123cKUWo3zw0n6Jc6BZes/tHkymdIn5rTzMLY1Tba2JhI?=
 =?us-ascii?Q?BW5tnuxk/YQap2lYyGFGQ46MjwjHiVS64XtGuj/4lOGKJcPuS94h8jKsO6u9?=
 =?us-ascii?Q?04Ubznx6xRZcXHfs08ZXxB05jO7XAnIXb0ZrWV2wNQAMPfGwtvCfKsQsmA0g?=
 =?us-ascii?Q?pspnG3DyblFf7dyFOqTfq/2ZgVLpZlmW8uK9MTVEiwG8oyg4DM+lAmJxaEYH?=
 =?us-ascii?Q?25Ujg1EGy35KFy2B9AoNDeKdMieSKkL2rZMa6ZrnVeJIi/QmmVF0IoqhgQZc?=
 =?us-ascii?Q?ukHhxpYqSGV3zkkgNqUEqzL2+XMew5hldl3yElgnEEkKexEusXzFLinl8YBj?=
 =?us-ascii?Q?NJmIBFSNagkqkw7VfwUYJSj2vP7QVpiJVb0eakDNpZyuxvCaQAkSzQlrJMSW?=
 =?us-ascii?Q?bB7l+LpOhcMfVKLF3FYgaYFBx5cLocr+qEEbEr2jrD6116AnKflOwdH/ciRf?=
 =?us-ascii?Q?PTrIbhbeRzIJFgE46qZUxw4JfB8ff02xRl1AvSTg/xQiWvAO8ZS40y1eIDue?=
 =?us-ascii?Q?UGsxMvT5/xfmnhRGjbAiBwUbHlD9B55TdNwmNCQ9LTBT1pbxliLTXodZohen?=
 =?us-ascii?Q?c7+QjSfkO4f85uL+9K7oIiMP5RYQDKx809B4SQkvxaSUErwKlc6MD6EKJhMP?=
 =?us-ascii?Q?f5PSOILiFWM0yXymq4mAUg5ZrOhHh4UG+MEMI10NOGn8SlYNLKF19k40x3kH?=
 =?us-ascii?Q?wJPi6hjfi8hpxu0hVOMFUY3xSCraBiTUrHZpWiCOMjpJSGhLifsAO7Lae15d?=
 =?us-ascii?Q?IrcvyXOSn+u+/NQU9OAFOsXfSjjWMZrRX5lwTIlMWkma3WQ8VOWkabKWi3Js?=
 =?us-ascii?Q?ddmPBKixBOIgYTVsFYL/Ov9g9dNoxu1vUPiRiUdo2DN/Q+S58FkEE4cmhmyt?=
 =?us-ascii?Q?VNWv6VzFyOVVnRfjQrjlDMCbLBpx+tByfQwbK6JVn13/ALHpmzcI4+RyOO+o?=
 =?us-ascii?Q?mtPuSDywWnvuPR/g4BtNlJfsUpPLRAig5oLwAOE7E3SxFE0MlaYuZ8TSp5gB?=
 =?us-ascii?Q?Rwa1bfL8Ehv4PAegEcunT6/sgDgxsIkTPKoSn/7adPQyx37GpkTKEhnNOpRN?=
 =?us-ascii?Q?MJ2M7hLiBatJ4Z/6Aur4TE2/CisBS1RyCwK69FP2Qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h0YSL8kAKmp6w7FAInWvRey/Jc3HgEzz8nlJQeeoWBWTQtvWhTAoJpb9jclN?=
 =?us-ascii?Q?zmASUCA6hngTXXWnY4qi8nRsY5Xyvs1WIkG3uUXC3T5VSNoJybioIxJrkBE9?=
 =?us-ascii?Q?SilTafhImfMOFm3hbIpxr/cOb6tdWcVF7mWoumVZD2m9Ptd/TJyGEl6p3Q+Z?=
 =?us-ascii?Q?Oz5wkLIpS/TWxcynD7z+RxTcsQVcVyAj419jmFuEmKvNRf4GB2+ml73XoMnl?=
 =?us-ascii?Q?ngpHJWy7JTU5F6DCBFhfTS1ZgxSTq8vqNtzmM8noGrl8TQAWVOHbQiLSklj0?=
 =?us-ascii?Q?Fyw+r6XqfY2UTOCr+eZp8NHwDvzqDFjlb9z2c4zvF1IQePUJpr4da+dhvgtr?=
 =?us-ascii?Q?cC9YzGul8MQjvRcjKGRJBiwSXlc9k9P3lyQM5tcX58Kqc5UlXPbEW9v7BAQ+?=
 =?us-ascii?Q?zekuD9WkijJI1ZuD5LKXQyzn7jCMXn9rm6VN5HIU6wuBgV64/8WLahugbi+K?=
 =?us-ascii?Q?FQ7yQHOq1JEHotJCQV48qOzlR33ydLRF2CICgms6+4T4HmqowdlVZV3YESnu?=
 =?us-ascii?Q?5dQNK0iwTdlMFEjP+4p+RaNWOYvxdcwTEjtHMX436EiwX44DAAZqlNcmYjND?=
 =?us-ascii?Q?8hpd0cVIOEKo0jNc8TqIzqzEj7twDLUOiJzf7wm/Iyuugi2Ku5WFSWg174Oh?=
 =?us-ascii?Q?Vr4NhSe1skuOHNvjS7/y9eycaY7HfNtxlX1gD1ZAR2FigMenlev+dgBeHKK3?=
 =?us-ascii?Q?esbMSRw2B6omvyZM8lyfZ2PnJwGMgbQTlwD+MDmFgONkUuyV0dwoWZFJD/8R?=
 =?us-ascii?Q?RVlEnQiLjSbQx7mpyUmxkRLGFdHIEXWWMTcIHn2501WGLA0cT1ZH8oTQAXP6?=
 =?us-ascii?Q?oG/djgETZddrJzYVU4FTfNipTSxyvxLI6BcUcgksC+ul334pjglsB6T/VDaf?=
 =?us-ascii?Q?VtJeFnJYpPOgeLm06NQYCmvDu+AUw8JV0uKw2XZqH5DaZOxF/bPOvQwvtk7Z?=
 =?us-ascii?Q?wlTHW2MQITN0g8UWoI8zLY6XdCeJNZqRjAykSZNJvZTunOd6HMQl2O+V489U?=
 =?us-ascii?Q?okLT3BrpgLyLHWBk8n4rMXP0d3fRFfTKQSmOTaTpl3ykW7MG6kUa+fx7gAYa?=
 =?us-ascii?Q?yoQNm3mCchRHLh6DbnTRXh0o+VvLhOcEnsJnrKXAte/hQ00ZiX58wbZdc7zE?=
 =?us-ascii?Q?5uMrGdyouQY6tG7eHFuiLHbUPnM5ridLNfI8FTp2O+LnrlDcst+3xEfCGMnZ?=
 =?us-ascii?Q?ZpQSOhddNOcvpD2/9MV1kX4FIZer1ah3kzIC6Bn8LTvC9pLlwg+m9sLD7K3Z?=
 =?us-ascii?Q?Mum3sV/+Vuui6Xq5+wUTUZhTXK7CF+hLjI2/dxC3S/rHYLPg0h5U/pltGaw+?=
 =?us-ascii?Q?zTi1GuEHJ9mgdaOjfHsmzNXk+pEbDet7zgbh0mIjrCroXtSKvPLHDk3t36/l?=
 =?us-ascii?Q?oiUg3Bn/iCpOo0AQD+wYqk1hZnJKEzth+fkSu1xTxuMsJr72X+8e6zfVn7Iw?=
 =?us-ascii?Q?B0yEG1qAH3glnfFCFahw9iE/gXOMGZkUaMKINlLDOSC6rwpJMw2tgy2sJM5Y?=
 =?us-ascii?Q?XN5GkXDZuTBoJXBKdol25xLK/N7QTO/VeFgkxNCtECnWB/GfMOde2Yqc+W7J?=
 =?us-ascii?Q?rWpp5VBG0rLLwSMnMxo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0b4dba-8201-42b9-12c0-08dc739c5da4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 22:31:00.4317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNq9IbJ/HhTAkdJn8joxZfDQmcK8uIGIVUoM4HSOMHCND0deHoSpw1OCF7Vyhg3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

On Sun, May 12, 2024 at 07:29:37PM -0700, Nicolin Chen wrote:
> On Sun, May 12, 2024 at 10:26:44AM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 12, 2024 at 08:46:59PM -0700, Nicolin Chen wrote:
> > > Currently, the object allocation function calls:
> > > level-0: iommufd_object_alloc()
> > > level-1:     ___iommufd_object_alloc()
> > > level-2:         _iommufd_object_alloc()
> > 
> > Let's give __iommufd_object_alloc() a better name then
> > 
> > It is a less general version of iommufd_object_alloc(), maybe
> > iommufd_object_alloc_elm() ?
> 
> With the level-3 allocator, something like the followings?
> 
> level-0: iommufd_object_alloc()
> level-1:     __iommufd_object_alloc()
> level-2:         iommufd_object_alloc_elm()
> level-3:             __iommufd_object_alloc_elm()
> 
> In this case, this patch will be:
> "iommufd: Rename _iommufd_object_alloc to iommufd_object_alloc_elm"

Yes

Jason
