Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CA291C16
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772127; cv=fail; b=ELcMLNvM5fBsX2J91J23AtC/fm+IZpVS4P+EEL2uDxRj36ZDPK1/HEC2LIZ1O9U6yXnHRjC978V64yLoRmpw4WRlrrGzvZThcpSYUQees0U5y+KQFZWIEMc/wUsrF7ucqtZGELcYTJ/KDiFFZVbvwvDOwNnkiA/4mfZ9oYR+Ds4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772127; c=relaxed/simple;
	bh=qICPvkATsDuq0pHsdJ4/l4nozYwK8+cYBsnxZXrZe/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SUJNwfVOm05tfUXY0K9igpTeIJcRpfDx2O00bhaX77LeQgPc4mlbLhraPeFvcPvw32YgHrqQA3g9u0tsBG7I67kHhnvgUpAu4EKMwn1E/jEduGKa5dfQDc8Rtf38h/8HRqkojkkQDX4xryyHN3Rayuu2lJP3xrY0i1SefRG86zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OxE7OB6q; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OxE7OB6q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efUQ0/Ysgi2GkcapWbOhyplaJE4GreVauofBKyhmpACjjlsK745FKHpr6NlnzBj3SSAvJcsC8erfnGlh3992o++kbNBfGxsvb/xk38itxDQ/ec8QDZ5Xd7NhJYxFdsd6+itAIKWbt6D3A5Isbxsvb8azpsD3CSaXtrXcr0WvR/R3BBhKoW/+2lbWmXcNES1dwOharBaJpu/iUu9OshuZpKm1gVAKsTFt3y7MDLkbTcJ4yIeSUmO1UniLBN5fRjV94+VZt6mOYEe/wtKYfIDCjhl1ZDG5al+pW5kpf7/fniuvMqvdWNOw7bCR0jIQm1wKZAfb9qHGu6xIJ35BWK0oHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFBdunpr7rgCPzCtjOrThfMZMVZLnD26dxzayDw1AvQ=;
 b=IKey5LpIC4jSDolJqXEHo5dt9q8xVBNOby0fYXm0YgQ5wkpuQTpgtyI/bSILDRKO2YuwfrDW74n7iHApYmStnYoBaalgPOzjdtsXrt27jwUwfqK+JuBM8i4QBJIgPeraiE90l6jCzMJrnyQS8vVctv1uSM1UKTkzLUOmgtK3e+bRLSkR+amjRptWjdqy0w7FmTBOOLuMkZCbdIu0Q9l8nvA0FsVMwioJOjDUWbare1LkiZfrdibSlFe3Lm0B6R1WEuAgLDmd0+JZaeVuq1f815F3mwX+StMLmANdPo0RoXcd3a3mxwMbHngdMfcKM+GX+JTok78Z6fiLVVKZyJlaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFBdunpr7rgCPzCtjOrThfMZMVZLnD26dxzayDw1AvQ=;
 b=OxE7OB6q8LXjRvfJl8o1oRsYw7//XCUNO4/7qyQ9ZMIH8ATEpmIvkCUspQNWG+tHBp5/yBxvp/jX2nBalJP8X711PQub3r0nfztGYIHamPn+jxiSZTCGW/vNDyWzamP6YPqcCzL1yXhgVVH7tv9PSdnxdIS/h+2eX1H+04z+7gD7DKDr810bBXdchi96AK++8G+7+dDXEzRGj4ixYdskSk7X76mOR3ETEj9PoS8zlELewVtnmhW/DEz/kYbW7p/vHrC574MhayTkDtO39+WgAKfIcYZfJjsLAhDSZDASu0w39J+bQtBr2tPdgzZSQu6tlwoEm45ebWnw0c+9aMPmPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 24 Jun
 2025 13:35:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Tue, 24 Jun 2025
 13:35:22 +0000
Date: Tue, 24 Jun 2025 10:35:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 1/4] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <20250624133520.GA150753@nvidia.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-2-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623094946.1714996-2-yilun.xu@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf1bcbf-29a2-4703-d3b5-08ddb323f7af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fqF1J6GZuZC3anmFIT4SnZ/mQfkqbVsdZyiZfGodE9ObwrcwCcoFCAr4gR+B?=
 =?us-ascii?Q?2Fk2gyCkEdC+Ye5wOFbDa9PddcvPwkZF8s8bhzH48/jz4EZPi4mKnqHRAsxz?=
 =?us-ascii?Q?0a1J0yk3t0+M9Ri8eaBXW7YW56DZ1q4PXm0g2rAiJ5PvrjktFxCfc4FxiSQF?=
 =?us-ascii?Q?8DgCoY+2qLeK3NV+nSzW+TSlMfLt3PsI8ZbRu/Sp4UxE5TDyR7wgASckh554?=
 =?us-ascii?Q?V4D0UbqOJivCVY3+cIsW23f0W++PaQJWwI+TXBTv+UykBFdqbvOuTjdaomMh?=
 =?us-ascii?Q?+lQvpcYeIWJsijZ4ot7qMChEmvhuFz2K8wyFstHczmiZi2RdImtYiqmGpmEb?=
 =?us-ascii?Q?wfj2uyYcfT7fFY3/xxlgROrA7oPnTYrZmJmCV2DI5AXEhGXLTMqkqnI1Gbea?=
 =?us-ascii?Q?RbTz1O86FeObYhhBW6eI0nfG7mTcPzVS2ItRliKT4feKWMvmRnOVG8EHn7WN?=
 =?us-ascii?Q?GO/gVikd3bqqBxXMeVZEV2/LPPTFun5gRnJw4rqcbMmbCSXx7Zi55zYBV2Ix?=
 =?us-ascii?Q?Jhb0VN4O2tSqIFEQS91nMPjAFu3qjfhlxryJpEukaEEhxHaMfD31YR/V5qza?=
 =?us-ascii?Q?yolmLIhZzI9bYVOUBLhiZhThWXER+Z2FHvLHNPwf6xvukT/YLisozlkk634Y?=
 =?us-ascii?Q?Uz5zqqEJ+C4CUHCY8X9oFfZiFCHBQn6zRgAGYfaNly6hlrhss2ombWw97eRZ?=
 =?us-ascii?Q?fg9w1xpAV7nhnUSFF00h/Tv7fWEus7zDjRAPxOnqgRWv/UBQVt0HVSwlA5lo?=
 =?us-ascii?Q?hFQLtI749yhDnrdom0NO68SBp+uy18VxVMlTGI5DeY1S3IbuOf0EkK8TXePs?=
 =?us-ascii?Q?MHYCB+MH9KG+hNuA3jrKzblu0/cQqNVmsP4XZocsqevYotdNBnPvRlDc/uQ9?=
 =?us-ascii?Q?IhAAjvTAu/cl03B+HVCTcEWTlm0XkL8yHkVa3aaFd1SXkq8DlOD+SP/SJ1I/?=
 =?us-ascii?Q?tb8KIeiUYdHpjk250jRd8IOREPAjGYZBnAB2pD6egHvFdPOFWLt1imSHbBsB?=
 =?us-ascii?Q?5QiSDmyXIafmPeEctY6CKiZu1wnxy+BuA2ksSJ7G/q3MhyedfmbKCwmxUJw4?=
 =?us-ascii?Q?KELGyK7cmK2dkrynxmlfDn+bZxJ9ad7PGUhYcOJ/dgxeJWVPti9DP+uDYT++?=
 =?us-ascii?Q?5oAKTEe2r0Pa/2/D6vVo9WsMFx7klPa25Ny4qVDMpcKgMcvDJfUORTQOIaT+?=
 =?us-ascii?Q?81I1IyBVd5KCB74+42O20kYy3h7+YKsMQG/zjP6GzcKr8rf5qvlwnxtqnm/X?=
 =?us-ascii?Q?LWHXSEuQehzauPnKG7Y+0myri/hg6Bzv6zon/Y4GmOrph96d+fpqaJioVRNF?=
 =?us-ascii?Q?IlodFqveqDTehMIuYWd4Z1JeAlIt/l5ZBikcZ/hU0NlKaQHqepSEbk/RDDur?=
 =?us-ascii?Q?QAZAShxuK5rcSfFbDJgjDprbAfR+Oo+D3NHhTr3rAAzRXVhb+7BOC9CvYpHF?=
 =?us-ascii?Q?OQT7lacrIX4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KXjSgVVWEqAR8rrVJLVtKfsu3mpmQbFEbqSuhoWiwEVGKX77VP1xi/zXGFum?=
 =?us-ascii?Q?6HslTEy/Wpf/FuU34mYPeImNyEUgTARwMk+Lit14mPrCqwDqYcjOWILDO2VF?=
 =?us-ascii?Q?JPSz5A4Uz9Ho/fbDxSLLbDZ/wwJji71BhfxizLVmo1xSPxIpb8MMPVzQYIVh?=
 =?us-ascii?Q?bx7DKdpxI9ijAwglKhA3KkTti698R01LRxnBfWZFbhhjOwXoZWat76K0Fhwk?=
 =?us-ascii?Q?19uqcKoEDfNQ3Wyfw4cui+5AnJNdqfIBQfTWIVThg8G851fMLxXBwx0jzyHe?=
 =?us-ascii?Q?9cTxTt5bo0MjHTY2x10pk8/NuY7HlaV8slzrOvZxDTcF0tTG8YZ5Z621mRxx?=
 =?us-ascii?Q?jitn9c8UT5kfj0vmX/+1JG6QS+kaIYYfOgqtJNCgPpY47gv/hAAVgRAkL8G/?=
 =?us-ascii?Q?0SFUATVOzZ6LpAFZW0cOYgcwWCE3WzOrBZzgyu3K/xdRZMnFa+qQTd/XZBGL?=
 =?us-ascii?Q?mDAEMeKeWSgY2crK3O40r23uDdZ7ku1CYZxeYr4lnlpRI2Tl9vXF/YPn4iJc?=
 =?us-ascii?Q?66EIrxQ62UjZjRRyWQ8nE6W+WKiliUF2d8agQn7mb3fTOl0c3Ljus6fbDHmz?=
 =?us-ascii?Q?6PgBGTWg7/3ZPtVpp9vhI/lYeUGKQq3G4L6oiQydMwhtiRzRg/geLb9Zabag?=
 =?us-ascii?Q?4wIBPQ6jJmDXcXVPx3NpZz2G/3S4Sv+KrlBr1dx/VGgkmIpVDo644Cztqftc?=
 =?us-ascii?Q?q/BPtc1w1q4rpZ0kuzb6QhyXG8Cs3jxQ9NgDKX5Tgm/OAQZpf0+PLsdUcrXZ?=
 =?us-ascii?Q?RR9+2o8zq8ZkAv5/0Zpp4AiWAt8CB2to43nM12i9jtX2loLMupPdfFd5yG7T?=
 =?us-ascii?Q?iKNA4pfG/ehJe+FpjylQroh10VIw2SQrwGybuf81C8gsey4FVje/BQI6n7kB?=
 =?us-ascii?Q?v6t3SdEsCkfhjZyGd8nBhcEszYipArz6rJ6qwJ9xyUzPRnbAXvD5nb/EJB0n?=
 =?us-ascii?Q?kLkasFHRHkJi8HpVoHYe5Pa7dW7r5LvZB0NTJ6K+2Bqa3PrkQfXifNV6UwBs?=
 =?us-ascii?Q?nqOiVoyd8JcdwNowCMh9HJ+9Jh6JMeON3/c0304gomgQUrjEY477NQYT/n3s?=
 =?us-ascii?Q?H8BfiC3BiIg0pd/2CgcLlHHZ2YSqm6tIMN5SM4EzqyXtz5/0RsL9AJxP0p9r?=
 =?us-ascii?Q?kbWZ2VP9nSktZr3pZBx8jEVNuvaQB1rlf7ZAC71RZVkahweNdDGb0Eu7gYP/?=
 =?us-ascii?Q?WYehLtE6iFAl2QhTAhoMoJDlNgDPDfbp7gu2nYOj/mgjfUyEXa5DYVeq3Ld3?=
 =?us-ascii?Q?+5/UTYxw339k4B/N3qRJq2/iuqSW8ATVuAuKCUYmpPduQg9EYFoBLdcClmyd?=
 =?us-ascii?Q?eNHY8y1lpaUmn62nAripnN0IfWZD9UCsadkePS4FXdXcIs5+ulLPXvrcpiiA?=
 =?us-ascii?Q?aP8Qz2Z9GZfzGpY7pxWs5ydBcQ0EwOVUiRapT58ezT5kUtBjiXLlL7uB3nWw?=
 =?us-ascii?Q?MRpp1pl/lyJkDqJDST2ew+3xNMBeQthAh1o0oYIeJWL682Q/iktup5Q1j5iM?=
 =?us-ascii?Q?rhdNmLIu2A5esQOV867eqsvsLHuOuh+oPK3IyA5TuUMRLrJPto2qfaJNouzn?=
 =?us-ascii?Q?Pkoo6EXcArnovL9AUWo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf1bcbf-29a2-4703-d3b5-08ddb323f7af
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 13:35:22.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwHwb75T1ys9NFGKYHdzmaodK+kT0i9NxUg4oxEgUt8uRAqIcA9/AdJceuywqJWC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337

On Mon, Jun 23, 2025 at 05:49:43PM +0800, Xu Yilun wrote:
> @@ -251,16 +252,30 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>  	 */
>  	while (!xa_empty(&ictx->objects)) {
>  		unsigned int destroyed = 0;
> -		unsigned long index;
>  
> -		xa_for_each(&ictx->objects, index, obj) {
> -			if (!refcount_dec_if_one(&obj->users))
> -				continue;

I don't think you need all these changes..

xa_for_each will skip the XA_ZERO_ENTRIES because it won't return NULL

xa_empty() will fail, but just remove it.

@@ -288,6 +288,7 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
        struct iommufd_sw_msi_map *next;
        struct iommufd_sw_msi_map *cur;
        struct iommufd_object *obj;
+       bool empty;
 
        /*
         * The objects in the xarray form a graph of "users" counts, and we have
@@ -298,11 +299,13 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
         * until the entire list is destroyed. If this can't progress then there
         * is some bug related to object refcounting.
         */
-       while (!xa_empty(&ictx->objects)) {
+       do {
                unsigned int destroyed = 0;
                unsigned long index;
 
+               empty = true;
                xa_for_each(&ictx->objects, index, obj) {
+                       empty = false;
                        if (!refcount_dec_if_one(&obj->users))
                                continue;
                        destroyed++;
@@ -313,8 +316,13 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
                /* Bug related to users refcount */
                if (WARN_ON(!destroyed))
                        break;
-       }
-       WARN_ON(!xa_empty(&ictx->groups));
+       } while (!empty);
+
+       /*
+        * There may be some tombstones left over from
+        * iommufd_object_tombstone_user()
+        */
+       xa_destroy(&ictx->groups);


Jason
