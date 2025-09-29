Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46633D8
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150045; cv=fail; b=PLrig7v+C2tjbvH9W6T5FmDTBkD1dker5SemyCvqt7OSW/MGzKEkOzOKFM9QgrUN/GKfytCFzG+iKJaNE/aKrkWrD7Jz7jeXDrG5w0rHCSFg3IBJQv0xgQSI17vGOI301XwUp7WnRfuY4Vw0mCQOnxOJBqDPxalpd43IntYgGy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150045; c=relaxed/simple;
	bh=tV82/40c6JBndC64tEAP0Dhi21h6JfQXiUa6SV2UP/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u9ghufK/nj2VDojDBCXbb9qkdsN7+SKkRHiDyAlx2C6FDZ9wasu+kN1GCZcV4aQre/7S14OlYcbX4j1sz8lvJJ+vrIXRX/uCckHqJMxpjfC2VzXUfDHNJEL1oqWgwP3obO27c2U/fK1nUaADNtRycL2B/lfM3ePah6nM/23sTeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T1jfgx5K; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T1jfgx5K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gk+mEXZBRkGoKcJO7sU59DykUn3WRDD1vwMrgim1QVSsCl7YviAKbQWLtUmgQoRx01GVey72opmH4hGruAaHwbdVODxQKcjlNeKhxMrRYkbF0JEe0vg0lEof+wBodPb7mtNUAKQ6+O1IHUYmCVhxA9XsqXmxAzChWr8psK88mNPHoNlKT+vLVbowGuYyEj1+RSgfdBodLwn5V01EZowHmIbFVnyrug3T6mbH0V+D8cfj4ad2Bwbok7VAiS8gOgj1Lh2akDENyRaUR8an9PqqiAbQnkr1L1ZPHgY+Xq2yPlQmSHLEQyYSWTw1gUBStFFDx4sevRqYVguUlqKMUc2oAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zG42iJ+mFmIovbfTJ0ihEglcq7bdZQHWKLSFSOaoSg=;
 b=m2Z319H1Xe/Kd1Evy1wF7TQEHjYGiwNrY8yji0Y2fymUQLg3MXYQiO7FWVD/AU02lfGE52j/LYX51Nu1R1Pe7P7T+2NRNVOBy9ZtJbmGuKN6FO4iM8lQRygx3miShJgPHHi0hYlP/l35aOYscmg4+5MjWol/j9H7rrx1obFKM8mXPBe5qyP9T3ZlIbSklDAhLiS5GNgZwIZblh7Ms/6RS8DFrYFJmsEtPl+oGGK5NC4Y0cKv/0e+bxy/K6U/z0ef2njKjOlhcvebVYnqSQm+nnrbWGPl+9wHQ6aDba/DvV8Qyw8nRzMRi98jg2uFRj1PY+2DmcSXPP7qsAWmpW5bVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zG42iJ+mFmIovbfTJ0ihEglcq7bdZQHWKLSFSOaoSg=;
 b=T1jfgx5KotGWkSyEmU4VXj66GHFZJPT4ZELHcPZSHVwx2jhtYU6wsMw2TtjCsMOxruA2X0yH9gZ/ZegvL3nehUd0kctYq9w2qnny0XzM5SRz11/bS6usSrp+R6opfggHBh50EENAR0/jVpfHYgmAmpwJhJCcOEtc1NGFYrEbANqWcqMErUXjbEFCEzxHS7N1WU8A/NXlEK3uiklJ71hl+ugXmeYq8NHGquJh+IkF90LVKJ5UkvtUrLBpCeqM5W6ScW8z3pUfFNtwiuoD7vTqkRBrc+Wraqh/f4KNnxmCu4FfTcYqabVF7GigDGyyHIdqwTKrff6Z8Vv8f1qjaMPkMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 12:47:21 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 12:47:21 +0000
Date: Mon, 29 Sep 2025 09:47:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <20250929124719.GJ2617119@nvidia.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
 <20250929115803.GF2617119@nvidia.com>
 <aNp6fJNoehs8hMyF@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNp6fJNoehs8hMyF@google.com>
X-ClientProxiedBy: YT3PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::6) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1a57dd-3047-4e4a-9567-08ddff56549f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2DxGASXArGWlqTyOOkScTrE8BfluwUql0dPbt4Djv/2PeMRRmgoVUGR6zcH6?=
 =?us-ascii?Q?tOWjHFSADoYBUt0Tni8cdcF1loZwS1pBASZm+wFzESvYtlpT75cxM6WVKBXX?=
 =?us-ascii?Q?kR6cuDPcGemQliASm5X3vMWKXCihvuAkqyLDex609u2wOK0ys8clXNxwYytq?=
 =?us-ascii?Q?nEgjjv7hmULNV+/iHHNWoX/GA5zuEcKZTS4Bfm51lZ90H+/WqWCvLrc8geNq?=
 =?us-ascii?Q?QaW+UaLG/tNZwtHDrOXU2BHVM0hjkYtyAd3j+MP6RUpHI2rlQ1k4XEqfSDKq?=
 =?us-ascii?Q?syf4oNpclT0b10b4cJcI7+JGnHsAtYpSQGvbtom1l366OO+pllLc6ggXEvQw?=
 =?us-ascii?Q?2Ngmn3JSsdZZ5rh1sEYg5vnX3/ygV9H5PGpkTbIM3+6sDDl8oXfAqk+Uz74/?=
 =?us-ascii?Q?7QGD1gjy98uolzI1SNPYQQ2Gfv9xnGdeo+Q5ikEmTaLlg4kwhWJ9m2zIjQXb?=
 =?us-ascii?Q?3x4/SpFbnKu25LGGCGQQpoqePeNccWYMG1mhzsiXUMVRVHbW7AyLjpn5MtCR?=
 =?us-ascii?Q?IEBxrXmRFC5mY4tAH28mf1BRM5FQdCQtiSMXrwa619ELRCa1p8A+9XdfXT6y?=
 =?us-ascii?Q?EqvRhrXaPRuiPDVF3SLbY68xL+xZkveqUhvZv2ZGu7kkTSe3p8+AcwyoZvgM?=
 =?us-ascii?Q?JSvmp0SY27DnctgXUt4k8H7l7KVCmoKAof1fAUbZCt3ZpIcIfr7pzMjTSQO2?=
 =?us-ascii?Q?/1Tau2WBaB11rI1xzJnw97uK55wVHgX8kHXfNA2btIJmkwOod1XH+AKcW08i?=
 =?us-ascii?Q?kEGcmOeEz8wXZfzBdfe0SYHMsUmReio+abUW3IVbrJQRkKR+aqKglf6H6qbz?=
 =?us-ascii?Q?8EXmHkWyjDG42I/nOz25qOAsaQLHlMfhDDIfQp/N9/oxHPXMm+PzFlwCKJf3?=
 =?us-ascii?Q?yXAn304a+VkKp29lsAFuhwCXRorB71hN/4zOaBe7T9zi9QHmzQEubBkFL7n8?=
 =?us-ascii?Q?vmaVkPGqwbnsdZ3gwHOfxlcRHlJDLj2VYZ4AtxdR9m+sf9yVXb8ljcNx1+1o?=
 =?us-ascii?Q?Vz8KS2V8PB9nprwVWchc13GpLWGmz8tYwKTTETubaE5RL+ZJibUElqCYqb15?=
 =?us-ascii?Q?OpTQTJaCyzNxBFqUAELRNaJiybNzfOH/y4qqzLWBkaRqg45HNXPGhMsDaYCr?=
 =?us-ascii?Q?vw72DoDLijWKgi1X6ZPWVTMJNIO8kay2iYa6f8MGONWDs9Oq30J0YYhn9OI+?=
 =?us-ascii?Q?FlLylTuwM6sUMhoW1MY/PMZnRlUTBqYSIRR3zs2X4WXd3ynY1XoCqfm2h5WZ?=
 =?us-ascii?Q?sGyq3alMLNALY1AGeAGLOTceXdlRX0y9Ln/F7sj92+ryLdTvqnulNO4hoLIR?=
 =?us-ascii?Q?JC45JpOtS9KV4T18n4ywKlt49TdXbsPFzDF2fV73Tyt2gp/Uu2ZnSuIDYNDA?=
 =?us-ascii?Q?LIu+kvWUhiAuzabYSLLawPPd7Y3dIxYc43394S85gHtaj3LDsk2bpPQFFTrh?=
 =?us-ascii?Q?vyE/veu0AmMLKWSjThQc9OrXcRNJwNtm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aFqkQk3HwF2R0ElWC32Xe617P3mmO95q4AIF4l2BUrcrN22q+3jtJGyepmme?=
 =?us-ascii?Q?mASvEEC0pOwTMjUe3xbTEXdGNFaSAX6uK+SL5U04WrvWEJ/i5whSwzZynMwm?=
 =?us-ascii?Q?Xi6anoxFyKMqZMmVk7iAjbPklxh23NwHsPgGG8AzQ4I251q9T2MYRPdgmn2P?=
 =?us-ascii?Q?VJjlPOGw0E1rLj/3EyV1ZvRUQW0dPY6DQpUD1q3ltZRuXVjN2F88oMj84yJP?=
 =?us-ascii?Q?ZW0haeNZxLEmdYnmPT2yIxKNU3Y2aqGzdKyZDfhX1xPOa9SLcfQFcdgM2xnR?=
 =?us-ascii?Q?fR9pEEQswVnuh26uKCXug0P8UKd5BWXxL7KVQgnMSa0FP+iVYahWZVQICFPm?=
 =?us-ascii?Q?bsa+aH9CIFDuW9mUsGxs7W8LLv0GtWnfY0kw2jeFVVWdnjMZ4jYthzU2HWsK?=
 =?us-ascii?Q?0mSucz1S7xEejCgUCLTAbP2HsgVsFCyMiQ1BiOJqC+rjU4Ku1U1ybeJ2ab6A?=
 =?us-ascii?Q?/i6dz0qXdB2pKZJQWPtnyctUguWBFn94RINsKaAs6WKfoEj2bwaD7bj/0qPw?=
 =?us-ascii?Q?jL5mLJJTtIfFW6aLWC0YXjMDXLXt5uKw6e/OumCJoFQfKylhbHXjHCrA0B4/?=
 =?us-ascii?Q?SNBEv93q+R/JJxvj8bFB2OPGCwztE09WcnWOWW2itVv8VuzFYbU95TPQhZPj?=
 =?us-ascii?Q?nYLNrv1pjjAtJJOCKA0NX7X3RiPxJs4sml4/ElciRYAfxalc52mu0l5B0xu5?=
 =?us-ascii?Q?owYYw6VVLpTvTbKDLAEacSr22upg6Q2xK0OlMY8DoBpS4bqwxn9oXnhn8WQi?=
 =?us-ascii?Q?mAFwH7Vz/E90jCAQuhz6hnv+4XVjg5/RSjHoCV6FvQuVmvn744Uz2BcK5TZO?=
 =?us-ascii?Q?R1R2yDPVzP7PJxMBv+eUoK2cOjUQGA/a66E9Bor2isMYv56PE3yZIGTnmb43?=
 =?us-ascii?Q?wIyffzV0EyJ4izdYNiCKzH+Wobh5IzvgYO9nv7bxjhbBlWPwXClDmV61MP8r?=
 =?us-ascii?Q?vpo0Fma/SqkWlCndfEMw9l70/T6e0qBFtW8PwPOfvfSOoQfQVY9NY/sotA73?=
 =?us-ascii?Q?v6TvI33eCTqNPcTIN81+aH965W2JvMLE7mCeAsV4hiBIOrdUW+WgcSbMaxJ7?=
 =?us-ascii?Q?BhlsevcTmqrGdUzMeJohuRB3DYydN2jEK542LuLti4PRgLtqN8wz3/EymJ5I?=
 =?us-ascii?Q?DjARlXuiGoL9IEeuLOtME3wyDnPFZp3B+PqhyNPiJsM8N6/AZwHLg5pQr5Af?=
 =?us-ascii?Q?/awfCI7jDW+8xzIJ8crxbGjROzcuh1vHA5zQuHwPt9JtTHKHG4jDHbdGKMgD?=
 =?us-ascii?Q?tizzHfxRB4N/onmwvVOgnb5bvChw1kdcsfUtnLGovfBrEMEKqZT3Q+NM4vKD?=
 =?us-ascii?Q?bXYvFf+ma3jv+fMBiTtk/iniflOfzQTfbZioukX/1pgrkuGsTDBlYO9cfJEI?=
 =?us-ascii?Q?yG+rCFiitb6cJabwlAalS/Q4W1TTzblzmzMvw1rH3Fw8jft+W/BE1nw18kVu?=
 =?us-ascii?Q?kx77E6CA7zTCr4vfZ8uJRTXqBnvKvqujg4A82ETN42yIbbHwTnWOX9eD1WjT?=
 =?us-ascii?Q?R4AN9bzy2L69HNQNE0B/roS8dQUfkDxm/KV1WLgAOZUij8hblLzXx9NTa7k1?=
 =?us-ascii?Q?LHh2nNO/3mrHH4MfUPg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1a57dd-3047-4e4a-9567-08ddff56549f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 12:47:21.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kem+LhbcenDDAVAyhjrwzMcIbRyPMxVIqFxUiDKvQIK3KSVZaVracVP3qtWsNI4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793

On Mon, Sep 29, 2025 at 12:24:28PM +0000, Mostafa Saleh wrote:
> On Mon, Sep 29, 2025 at 08:58:03AM -0300, Jason Gunthorpe wrote:
> > On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> > > @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
> > >  		.map_pages		= arm_smmu_map_pages,
> > >  		.unmap_pages		= arm_smmu_unmap_pages,
> > >  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> > > +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
> > 
> > Shouldn't this avoid defining the op on coherent systems?
> 
> Does that mean we need to have 2 iommu_ops, one for
> coherent/non-coherent SMMUs, as both can be mixed in the same system.

Yes, I think you'd have to do it with two ops..

It just seems wrong to penalize the normal fast case for these
systems.

Jason
