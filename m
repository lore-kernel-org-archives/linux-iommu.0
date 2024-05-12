Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76995210FB
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715518739; cv=fail; b=C4/qYI4w3KexYvwtS8wlUBC1z90D6h6Osz5GVZbNJ5+OZ0ltNX1NkVHF/yT9nnEn76ZcC9zCJX6X0gHd6zpmHHqMQTInzvzGIFkFs0UALAcjAtQAOogMduowU2wvXrjS941qSCQqVS4gKhY4ZtATQGvZbS9uv3g4mj386+uy3E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715518739; c=relaxed/simple;
	bh=l7yCvM2AjRIcaAIuYQHlYrVhSiC1/63yxbseiEQqHBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nQzUOPsWXEd93AFzQa+912nFvlmoPbt49zzkAYRIMKAcj8VYW1/964c1xM5F0aIsbOXL0LJCjjR2/KxmO1NWzNFGv43S6lw8797Etg7QdqR1zhdJDfi8bmME0DhwKp200WgK9sd6GTktbBF1djn0ptdSaJeQm9o5vxvDhaYt5Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pBTtfYbM; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pBTtfYbM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUFp1RKunx0X86UOT1MaSzJRrKEuQNam3eHBe2DQsRHIAnQKegFgS6ribvkDpXOGVx9RGZhSXTyggi7FUxBf8jBc8X/Zw8tSRc+mnqNQ3gt6ETIFNkYTe5NsJz7u9tBgM9frJmHYcerJ1lXlT2JE6A75JRdgFfNrqOexyoxsSebDPkcFt6VY8iOQxKFuxoRuyM/5cJQy2szedaUdzgpyGibqHcTJunBWpK6LLQDD0InISID97E2tv165pt8HG+yLLIBrwL2gJS2B8a1wo7bFx2z2kZKezoz3/+wRoLRbpwlL7M1ubyPObnHzU/CvL6OdLX4qOwzIw1WtpAvYYWZHZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGEztMcz5xqQm1ba6nARZ9gvVujvJXEmdHybcCJl2lY=;
 b=VuSyeXx+lx/a2wyPDgsphWOwCRK5Ys9iDhgoLrSz/2B3SjHQ7r4drgTH0yKv9qsSyfugN3N+2xxFYNXkcUPb5bRE6L2X8g4zyv1o9OyogfMSInMMnjHigA0pUvYTmac5CvRCP8BJk1M8y7u9aQesgVRFaXp5RiFozPIMR9XbOrrC+XNAzarqM0ABlLBrrYIpqmcTDUJf87+cz3xlBG8j09R59vBvhjUrfJ9F92a9tPjwxe1WTXubhHBi/yMF7W7B++1URlQFSzyJ2ijj/1iCkw7+N0qO9thxnTSOwQmsQ6b9PYpQKxd9JB2FlshLZsUpkSKxQtBR5aR2JHNriB+rWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGEztMcz5xqQm1ba6nARZ9gvVujvJXEmdHybcCJl2lY=;
 b=pBTtfYbMFi7OfEIqOaYaLslkTPyZTgrbgT8Ecwk/YM0ysPfWjlLrd7E5gXsNjCan9H36WfjJLvXYSS0BZC5p4xz4xbc0RpaIkTW5SQFglaMuq5EqYzBHK8//Vq7iPi9DyA8KxeEbLvsQ6/bg7Zvp+Iw8ziJUC+yM0ejfEfSPq/mlop9auIDdEkA8A3r2Ip6F5RU0OzhyuCZLpfp6MIw00brDWIgiLhsmP18BUWsRVLexijSaLRZJEJrUzKgZzN6frDv/M5u93OzPKYSxbFOKfN8YGrVr9GrtKl3nS7IvoZ3btmW8DpJ3Y7V5gPsNVM0Qmee4/wehq0jaXNXpafyWlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 12:58:54 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 12:58:54 +0000
Date: Sun, 12 May 2024 09:58:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	ryan.roberts@arm.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, eric.auger@redhat.com,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v3 0/4] iommu/smmuv3: Add IOMMUFD dirty tracking support
 for SMMUv3
Message-ID: <ZkC9CK2bLPpqpSaP@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: BY5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::31) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f8cfc3-cea8-4024-cc2e-08dc72834789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/H1tTdxTAzSoUtyZa9cUyHz1VprS9t1E4S40Tv5PKpoWVGQ3uQbbl+eqnEk?=
 =?us-ascii?Q?OS266lZvwfY0VEhMLzEIOmAq7CZe915VGm+0QGnIfuLr78QnBJHlymihtxGJ?=
 =?us-ascii?Q?oWjQI64B5bi5PKjnuo14vg2HDP3INNVKgTI2dtl4elGZ+uAGf90xVzEDOjXC?=
 =?us-ascii?Q?f++Yl84G8/soXjgcAjeYfSky5LsC4tZI4XGVXTYA3dyJxgrESdsOSSLaX1mQ?=
 =?us-ascii?Q?hyKrm1oRXU2U1Wq7Bmr++9ev7ABzvKxIdbe1EcqdgUB2I9AHq+dFJUqrNKbA?=
 =?us-ascii?Q?JCYd7cJ/W6KfKW4umTft2sRw2W9uyV/w6sl6eLk+IQcjQKqrtUCCFMUvE1Dy?=
 =?us-ascii?Q?jXqCY8sa/wUNapFKRsjEvvCTvttE6MGs0Xk7HBklxKzXf+ynw0y520ea7JuO?=
 =?us-ascii?Q?cu/Oiw2Jd4ZNYal7kUMzcqpKK5qb4KS9r+mZKubIojJ9liBoP4wn+KOAACYc?=
 =?us-ascii?Q?GdnL6H2Cshav2ub1EOXsoBEJMPpfNCbrbKQXTeNXj806XdbDVPbZoj0KyQOQ?=
 =?us-ascii?Q?hODrCHJD2TWe22gu4+W87HiKQg4rc39ACcvrm4bVbS35pMPwgxtdsudzvo7a?=
 =?us-ascii?Q?uITu1xkJ16LivLckrAQOqrtc2STHto+RLWTXy7mTfmWcatZ096i8y9i4DkiS?=
 =?us-ascii?Q?SpRdn3dhoHQG2hlzvnC393Z0pmLT8cUoXn6JJ1rHuLsNQHalTy4YImkjPIdL?=
 =?us-ascii?Q?xpa0+a/G6Ayz6RtQtKLa66fXDDB74duTQq+T3h8YUmFJaDFrYahdhZPMH/WE?=
 =?us-ascii?Q?U9CgpNNCiySbhhqizH5W8251fuattz6Fh3oKLDfCHqD8zodwaOzu+lHpoPE+?=
 =?us-ascii?Q?QcUapxUHoBY8oDTKDl8INwlm5reEYNQoXn/CRTVgenBXc2nsKA85O5mm2KtU?=
 =?us-ascii?Q?S3QLykPJBdV6YtP8rdOrKmIyrQ2u4viR8F9yTANPc9mEdVFCRuWgQrKhoLiw?=
 =?us-ascii?Q?Hd1zVRhZhqGaLMNpTYFkSq4dWovopMF49A6rg4B3TNgXYWixj1RVKu9pg9ep?=
 =?us-ascii?Q?bsW3vGVDk1f3LdNlhODtAcx7d4k+I/PD2dsX7AknFd+O4HVZemMJP2vNpLjt?=
 =?us-ascii?Q?OLrwYgLgRiG7WjgPfkwcqirkAgB+y9dq1/vFqIEOGVmhKlsQStN0pziPiTo1?=
 =?us-ascii?Q?yepw3LVkiHnQFrpeLymkv++Sz/NKqRTF7z++oj6f65srpUKtuCqw0kZuNc+I?=
 =?us-ascii?Q?OU6BKdZQwEHkEYc340vM+nnjSpVw68DMNYvbcvXp+Bxul/A/Iu5KpFeTDiKP?=
 =?us-ascii?Q?MBjk7YMmGRpveXvRwxHfzjFayY+YSE17jtXQxUi3aA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x5aQ/OMwgeEj4GQgEWdAkcfmxXaEmb0Nfgj2QYiqnAhgs7IhxTC+HRLWlP/M?=
 =?us-ascii?Q?G23+sGFhUGpVRDOMv3YpX1o+KetoMztBKGZlxii5nyaJU7N1Tqm9IBNQ2Cwl?=
 =?us-ascii?Q?lImBkVF2+StcY4MljfQbclr2ZiJrarAAsYtHBhym1La021c/FApIxBxPcs9Y?=
 =?us-ascii?Q?RmE7QP6eT8TngeK4H72RAy3ejXbh7yKCMY3jbF7mzjkS/QxN+z5F1rRJ4dgT?=
 =?us-ascii?Q?j7AjJu3HIszlPlgR01nn4vn/rHQw1Ni2KogK28hE+QjrfyiTTDUsOrzD5vLq?=
 =?us-ascii?Q?z1LdIFZN4wC1VGZLvtFUbLYV5CQBwOnVJfLmvU2i1a8Yl2E6cFyeKh25vcyr?=
 =?us-ascii?Q?fffpV3Tql3pWXKruGEpThiPCy/V7N+YZ9CsT7lF1alerN5jEPe0ys5L4BlRz?=
 =?us-ascii?Q?2SQpCu6dvvL/oHQOTrcUDwrqoxIT5gRRtstWkcJieHejns3WqXTFLoWUVqsZ?=
 =?us-ascii?Q?yfyfHBzQEgRv2xy6QrqNaJI/W7v4MS5ZDV7fHyWsyE1mWyFPhgXOo/SSAEYf?=
 =?us-ascii?Q?stRuUEHwbpyO+4PN4fvl8IaDxfXSLShAQN3VMgwqDAKuVBZjrU6+jh9dr4i6?=
 =?us-ascii?Q?6ObwWIsfDmKtfgLJoTDOqCDCYpIftAgAhE/lNMovumyzZCQMFU36GBgEklQT?=
 =?us-ascii?Q?xK35vy5NYBNYSCXRFfQGbgY/z8y14RbJwecD5Sd20jN7g6edbjcRwX8Z4rYq?=
 =?us-ascii?Q?AiCBzvQt28ankccvEprJanPVgCrOIB+Xk1/ceN/3sYoUjJ+NzL6Du86plq4o?=
 =?us-ascii?Q?cxdv00pJr+ZlO9UR0vWaGktZnADQ1k08coUw0tQM7l9uRmfaGPMAdNfbnEag?=
 =?us-ascii?Q?NcRqp+vlloAv9UIpJefPJZTQOk99qolQIVIiv6u18d+egz6N3VvrDcy57K5m?=
 =?us-ascii?Q?f0uybvr/7kPiIM3xvzyfHKgBkPJvXOzkByOssxnk/vczMblRR91sPG5hHPhS?=
 =?us-ascii?Q?kKMla89za6xkZpzVcV1vrzfLJ0N5T7nJx6PwylANlypcqPJN3ySUX81vO9Jh?=
 =?us-ascii?Q?x9u+zzDT1m8/rM3gQ36BmDN/Cb5Pxu48ysBt/P9Y6tWQlO6yihJ/bUtqx0FI?=
 =?us-ascii?Q?Ukb5y1LUpjNnjBGJH73cXOD2/LXE9wWKYtLk84o/sjTxigYWG4/k6vgR36yh?=
 =?us-ascii?Q?LB64ruIGkxtZmaI9ZPeSN/ENmUq3SinVB0xUv1+KnJRQQojskuaHWu27xLSj?=
 =?us-ascii?Q?EzNgLuiDQP0c0MEn6tg9QU+5BFlwLVDYfxbeYhdTSibly7NG7jVPpSK0xbNR?=
 =?us-ascii?Q?6XcCmYljz0Q23nnBmhllm8HAvvyBAiGz5cvo0u2hxbzWzou1DYl+sMAtNV4G?=
 =?us-ascii?Q?9NgXaqjvTJR7QJ4x+DurEG7H5gp03WISLlEAUiVxaouljewU1+Q5E+6UjdeJ?=
 =?us-ascii?Q?JozVU5ooTgOkBzTK7XBJkkBkib6TSCYbutqg2D+2rRu0Rp17ZnayE4+tI2nT?=
 =?us-ascii?Q?6hV8dzURHsptbcezjSUatW+iwAXNtiFEnQgTRUOmZBqT6uKLj34gCvj06DOt?=
 =?us-ascii?Q?HLF0e8NabT+l2HJqAFRPjr7YkjqpQzVr8a3OTaldPsSgIBdif/fZTScJNdkP?=
 =?us-ascii?Q?LEWOZR0+9zGu3dRJErvTnCZgGNtjp6R47ue/69X1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f8cfc3-cea8-4024-cc2e-08dc72834789
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 12:58:54.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWirCgp1ZuUjYm7PH5Pe11xibyxGA9Di7tc0UXQkiGbWe3yc9lp4pb/KHxkG0ETt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140

On Tue, Apr 30, 2024 at 02:43:04PM +0100, Shameer Kolothum wrote:
> This is revisiting the earlier attempts [1, 2] to use SMMUv3 HTTU feature
> for dirty page tracking. The Intel/AMD support is already mainline.
> 
> Basic sanity tests are done using an emulation setup and on a test
> hardware setup. Block page split/merge(BBML) is not part of this
> series. I am planning to send it separately.

This looks good to me, lets have it go after the merge window. As I
mentioned please post a version rebased on top of v6.10-rc1. (ie
based on the patches only in Joerg's current tree) in two weeks.

Thanks,
Jason
