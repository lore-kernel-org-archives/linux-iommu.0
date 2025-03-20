Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1422540B
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492019; cv=fail; b=OjjsKwqEljgiIqMKjga8KK1GCHDe+6HKb6E7jyejr6nET1g75/o7K4VVmZ+l11omd6lGXA+CaYXAMSdzdeKFbLyrFi85TTq58DHA534eLyBM6ISeQrGG7AXz5uvoDu8dB6CdkT8MkA3zc0cORRmVXkGvFH6LbAhIdxtjIy/Ww3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492019; c=relaxed/simple;
	bh=yOKqOGJwsuoiZg8QjBAYrB8BoCJrswStmhzEUw7I0cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tcRrEBKmq96tKCmu1JqQjLXZEmV7+qVW9oV4f+HIC2Ls1gkEKsO4W0m10LqigyIJ4JEsxUyoDpMIQya5/WHP59jUfkQlJJPRyIjkPc9447dIpp9pY6TIdYNCbyLKCHnlfpIwQfmTngJQGSQlF4K8UfvfDmxTHVAdmOBS/bvY1fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UJeNAatk; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UJeNAatk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coWRQa6AFf4yOY/QFdCEqw6G/AcXNOf6KUYu6QoCuz6VQ+FXYkMP49xdUygwi5kdYCh4YSXOWv2XmRvvOe3oHoeuVl7LNuSNNOeaayBCk34qmzWAr6wKcFzuAsuuMgkhlgisemAmJQOHOeCATx81lG386KwKVuC7xTzapPXO+sdwj9/lDEpDaysGTIf035jsYsrzo15WCs4JkCrJU6NUUTrDPBcrXXKuOm/aVCb1VDVn6VxZMVwd4v0A+RIKrsPWF0s9CEW+HLD2fr8nPFMCDSciue1n0bpi2fs16vKrAghpP8S8LIkipQddLM+YasSLtuAo/dQ1zc8l4g1/zp1olQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoS1DhZ752ia0RchKTsTmchyPuH3L+guVuIeW09s2bY=;
 b=hcDXD2K2/nkDqShsl5fgzQATIM6wORVuKBmFqoRq/Pjvq0ZJ55jhwJ8/n0c7bw7/s8fNeqxx2PofqdB1yv9+ip7XQKXTnHZc+TVXblzmbv/9dE/iE17g1cV1pIWHCAZ8p/PPp4xoWJ07kpKbomtub2OJ/Mq/0r0Fhh5o82HYVG5W2n51POPpTqEl3WWv8CXzRuk/8mImGhJVN8mwxAIPDjj79IT9VR7YTgDmIudbpP8woHI+UwSSZpEkK6Dw0x+8RB1Nsoh8Wyu3XtL5qHEY3nGBHFRjGkV4YiyZ/GLrZiNVnK/Cu4ZQ3VOUgotszWVhPuCb3o2DxybeuJMOMed5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoS1DhZ752ia0RchKTsTmchyPuH3L+guVuIeW09s2bY=;
 b=UJeNAatkatRao7lweQS4rqeh0RmNqlLr00n9NGDqEVEVnrFxaEQizrY3FjlfojiLaz2a5PbKhyg1WnwFzVygKpKZvS3d4A2CfjQ3mKkRtMxSYRzBNZ7uYZKarVqLP9rGgDwS2FVLr9PODjVOt2PeFD/W7IFN8dzEafCkBQryEJORVoN78vWA0vh013rE8zTXVZJZOSopw0m1giJGOlxWRPySd/69EHB5Mpnp2f0o63E9hoYNyttncB+01816kjFrRUhLltBwthyO9zoe0ECpvWNzRxaS8CZGjKJyPE3fDMG1Ji4aviqgtZPV0AHL9JXVobQm03oAyb/k02f9Qd0a7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 17:33:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 17:33:33 +0000
Date: Thu, 20 Mar 2025 14:33:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v10 09/18] iommufd/device: Add pasid_attach array to
 track per-PASID attach
Message-ID: <20250320173332.GB206770@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-10-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 89302704-9e55-41a8-b777-08dd67d556be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WzkxTk/CDPuqDRkTmr9AcDaEEiCE2V1bURlHS5pnDG+4lxac8WjuR7lzAJhp?=
 =?us-ascii?Q?UTVK/qQEX06V3pnTRuhyMONZz/UnfbeQrahCKISy9CqCiZnekWLTjoIA7a73?=
 =?us-ascii?Q?YkDpBcKAGc4+251Dxj3nL5zx3+IKN0F1fuS/8c5ALaslUKl+1Eu39sPvMPJm?=
 =?us-ascii?Q?8RLGFUM/JPGSx6kqdcWbGVPvMbN4rdEmnWzt0QS2E5zlALTQL8isbZO+1ijZ?=
 =?us-ascii?Q?aiNzN2pRsOZPHbQeNkF7rCgRt9J6hlf2m74F25THOCKBTi6niE4YAbZny9ca?=
 =?us-ascii?Q?uYh4gJEkdXbEcog00hL6py6tbxyFYO0CUdv5X5SGGNGc2spYUXVIpYoI+oFB?=
 =?us-ascii?Q?9YPxFtg/WmWHGoIzwfVtGZKxqOBX4BM3VYBJ1DTlO0rPSIMuVksnVSeq2vK/?=
 =?us-ascii?Q?7FxLE3/TaHE4x4zhV7fKKQKBbolnkPC00EJ+ype/Mk23OdZb1FNFLmjK2rEu?=
 =?us-ascii?Q?XZbkKJJ+AUStn7THrKUcSWKbbFbP8YPDg515qYxoxA9PuHv+ICHzEO1kupsP?=
 =?us-ascii?Q?p+7PtlufYPPOODwc5rClmxWwLkBr3esQM+m1rzG/elENCuS5slb1QE2bI684?=
 =?us-ascii?Q?46AJgAXlOAa0s5/GoJ0EJRODDb9PRqjJhexLuBBxzrh+PF3Rd+udfT8pVeZj?=
 =?us-ascii?Q?KD3+vB6MwOP/MUKKzLp3BAIYE0382R5hO3jswhsn658g4g2ckUh1WZS7s1bf?=
 =?us-ascii?Q?wp1ALfFLijKK3LYMw0E5bxV1W2fenbpVOv7nK5HlB7cIWfDfB85oIKzvOBop?=
 =?us-ascii?Q?fyIMWvLcRNR1c8uWYKGMToDKY0oyD0UmNbLV5KVqyWo+AuPMBaVJFXmwqLyX?=
 =?us-ascii?Q?yBYG/Ba1Mf72YM4bcGS6AalG38LyvUaQFEivSZlQblwJbYjM5KRlB9wqZXIm?=
 =?us-ascii?Q?IbPDnWWUWsNEABQdamG3Cp+TAe4K4F4oxe+C9diJXWHDUzW+tZSLL1LBIBI5?=
 =?us-ascii?Q?ARqVIRmyHEAP5r7a44qgv6DjfMSZhZFWCnt1UN2bIvsbaw4zBbYP9nh+scCE?=
 =?us-ascii?Q?AV5sqobaRK5DIPs0Pthwrq9sfHn/Vg7OXzW+7TBXwhqlkvWTftOGfv2vFGor?=
 =?us-ascii?Q?J+2wTOkW5vhrOhl2AxRFHhB+HVG3n3qsJ9qRCs6Sd2NW5uGbInymRfFxjhgt?=
 =?us-ascii?Q?XFE7fDc9wGMXCFuWIUsURHT9Lhrg9ve++I5o3vg8hgR5PnurnOSvWGa/z74x?=
 =?us-ascii?Q?ome0vX2jZAdg8yNEJ2my6aMecDBpN8FeyQcs3+h8FQHPP2eM4S7FuRDHWRHT?=
 =?us-ascii?Q?16KcJdkZjzbIzP+ZTwblp/6Y52QtMwfOGaaTlItw5D48Q7nbsnfrPIK7th81?=
 =?us-ascii?Q?iBaGIz/LdX9ghHzvNjtRAYqCXD4gPWMKD4jzzqC7HJuTLAExAvWPzxE18s7H?=
 =?us-ascii?Q?t31c3fZBFyx3yzoHs1fwRzifGC48?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gqzXV6YZY6UO+/5TpmW8p709jUJ3sU37etqY4/j71gsYrHpXavCHjTMSuFC+?=
 =?us-ascii?Q?d+cKNxir8lUto2735tB0t0MBeOUjm4/q3dtvUIMfhTUDjRTHyi38s+c8Fc8Z?=
 =?us-ascii?Q?jZkDv31eiCd8aUmheEA014G4zLu3k5kOQwKRBL0m4Noe9899TwJt8sQjo+UN?=
 =?us-ascii?Q?Gk0ga50W2NKhQsc3myFcOrIJ2ss+WbztUP+DwAAdGslw8JTo7dNWMj6jMAyg?=
 =?us-ascii?Q?7jrR86SHgIcmSZT3TDBciBt6/df80E7Dovy43s3R1QNc4oMGHXXVJ/VD6qLy?=
 =?us-ascii?Q?zSTqGo9h8hXGLVPkJ0l7at8JSLWtqa/ksx+g/7POG17Oz2Jn0iZYJuoFYG+x?=
 =?us-ascii?Q?08i/lB1IzJEf+geP0GLzMfEo5uvJ2/fHOPlGZOcVxHAEA/JN8VU+ZWUkwXjq?=
 =?us-ascii?Q?wjb3JiCk+QZEICYO5efjtoamoEkar/tgJqwzyf1nr7KihBnPNc8XjY+UZ9cu?=
 =?us-ascii?Q?RQJWNoWZYYurwvr0h28UVLGL38Tylnal6qRp0hZBn8A3DK4R0PR6gq6Z30V9?=
 =?us-ascii?Q?/qcflcfj3RgNekYAs8BcgAbK/km4mDM1q6/6plf+FqUspVV5ooIrrQlDYoAC?=
 =?us-ascii?Q?/KIw032mSHAo/aCuoXawkCfWLh8jtpTKWq+w3VUYuEK7HmY25aKtel3Tg6UT?=
 =?us-ascii?Q?6ykSWEmYHz/676kDA+UqEdmj0jULRW/IKfI7YgK0SsVuW9j0iRtwpBBGjAXt?=
 =?us-ascii?Q?QpZisKQtzSgOmbx0x/bizekk9ynr6r/tj8Mrm/lT6QtMnL5cxpF4MOdT2v1M?=
 =?us-ascii?Q?mBF/JqBBTmSjcAp6rgGPnjN58bvgW5dib08pWSNYZNS6Ist4PLZcD6NqHtgC?=
 =?us-ascii?Q?0Gh2Ednu2pLtvFR3lN0OYPBJBWh+depRYM3YElp+5zrQcziCJsufp1BfRFrR?=
 =?us-ascii?Q?73opfCPbjdqIPqNPrDe2+nuCFlCQMBHnoSZ7bBIGs874so0FC/G51KlkFXDP?=
 =?us-ascii?Q?xfcDDf26SmHKaW+aRbQ9Yzf7VOyjaXbfBVPGTdwLeG897TZmKE9LoOsNZE+e?=
 =?us-ascii?Q?YkWXUtlZG8zhkn8M8X/SZVIvHI/HcrUouaKpCRppkmbMwtIh+qrnleUqYaAP?=
 =?us-ascii?Q?wBrJ3fXtHVu3LSKuis1g9qtfm/fMrEUGqn5zOmLRRg9QV+hU+9QnAwhDFbvS?=
 =?us-ascii?Q?gTmrq6Z2/eQ+RP3Vie2+RNaCGABmNy59NCYPiDOSF8KLE3OcdA0ISipMhWB5?=
 =?us-ascii?Q?x+EVV+sIC4+owfRHxLICWpz3LIZIG2893UzdvxAhvC1prtnUm4gzauQQsY9o?=
 =?us-ascii?Q?R6IQAwYc1GWbIRspVHb8h/Qc5WsekIX0+IRIu/GgPQG7Ca4rJfXabsfMNIU0?=
 =?us-ascii?Q?P2kGGPV0ixpWbRxVintP3+4TY9d+SW+e5j6NrsKRqf80BYbNsfYSC2TeZXM6?=
 =?us-ascii?Q?b7oXBYzAlKbQ+5fxzn5+JnTTsYlTHgA0GFSNAifiLgFYR1VAEScpF6iIsrqy?=
 =?us-ascii?Q?BcmI6nT4mq+0k7h0gbUzEhNHPTKUxggpkk1MwVg85qAErrRXLAkCl2b1opRV?=
 =?us-ascii?Q?8F7N6bpE1MJ6kiy81Sod30VW7HfH97yG7qwGxDjh/AqsVKIPkQriut5pwrgx?=
 =?us-ascii?Q?7iaZAbTLsZ251WFyP/gPSjkcu29WfPsjRW1q4tQy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89302704-9e55-41a8-b777-08dd67d556be
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:33:33.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5wp4lbb2XDvk7QxTRG5/LaPA5OGc9lt9NqecJJC7PFZjw3fOincQnU7e8Rjk29G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170

On Thu, Mar 20, 2025 at 06:47:35AM -0700, Yi Liu wrote:
> PASIDs of PASID-capable device can be attached to hwpt separately, hence
> a pasid array to track per-PASID attachment is necessary. The index
> IOMMU_NO_PASID is used by the RID path. Hence drop the igroup->attach.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c          | 68 +++++++++++++++++--------
>  drivers/iommu/iommufd/iommufd_private.h |  2 +-
>  2 files changed, 49 insertions(+), 21 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
