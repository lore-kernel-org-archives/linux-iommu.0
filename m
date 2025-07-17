Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4941F29A9FA
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753364; cv=fail; b=kfiniRcvDalnNDRabR0alwc163MlgT+EK7VnUoPZeZDSDofGmr2n+q1WoY8fLhc1NnzhiyipdII1HA0/mpbA3GLIc9t3Uqjs9m7YnYLRJwJ2noIGN83jxTikawOTWz0ctT9eWsVwfmDOVJttP766MoHXkMYS8mLMl9pDJJ5jgCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753364; c=relaxed/simple;
	bh=k0dtf3DrE9GP1nGw09Z4DhGeFPbVAFR/APveuxNXQnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gk3mTbiHLObZEnhdyXpSUEeZPkmO2zZEfyFn1ADZU6oQcOWq6s9CLqKDZrvAGe5l4lFJmKhO97YtzfiUDAReIx2F4ZBz3/i7nF89UPtXzYaUCP+37AbhrRuhwQH3vwW1dQp+LvmIUmA00LWOXU5SDQ1uKi+QJpAarxB/QwcsnZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CVVYIW/Q; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CVVYIW/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4ziAGSif1S+F/ej67KL8dRKxOwjms3Bpr4lFmqUXH1xevnGJyDqtD9LfNmaWrEHJ9ZUFgSRSPGg5+Jpf+ma5vFyv9F9K/MELJCduwhExJCTHbhO6Ux4oJg0JggkQYncwmwySv77LQhiq3mJjKFHXMwy76QwSkb99W56GFjjL6S7eqCOl6IgVcFN/OeO3elUoLzv2o2ni7Hnhn8aWLAzMqC4ygqNh7ARnmC3vfbkFE0mcJyG92lGa7g6H12IhOBzi4ie/Ke2RTppWSPX6G/PjubD8SdxHNq56Yr6XDvqqO+JP5jo8gl/P/vpHrHQBaM31DFLDPMIr2K+9JtvicLgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y675r5yjfJhdqF2Dw9xBjT18eBn6HutObpwM+BFOEC8=;
 b=lPSnvIYhdkJZuKxhN4+E15k6CjAcgv+TbMPuKpbe/36/mzsdgEg10Ec1+iCzG3FuAiipGyF5J8LBK9h6AIBm7pvDErP/2f74LdxTjdd+FtvNhoLHJXnxxrqTX/Fa41az7esl7A1LTrHrSeinKTZ9ervfyjTfYEuHMRarylZzKMn2AigIYnefbLnHD3UY5G1YcoldrKL0qerD4ZythDIh5jcvheuVfj4Ux4Rzo+LDbKOfZi7jJvjtyyFA+edAdJfM5jzGIKI4bvZm47YVrF1jtxoCTxeO25UFTvQyi+hhsRCarEADLpjd3d5XxIImoJujEycnGjnZnpP4fhihXx2FJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y675r5yjfJhdqF2Dw9xBjT18eBn6HutObpwM+BFOEC8=;
 b=CVVYIW/Q/1gF+fyQgpHV2DpisxfisA0m9vNPItPmO6ozzn3qqRCgbBKq72Bbnma4IOe3p/u8ux+AgD4jSNWjqnKYXMBFVK9Ef3qrRFLkSgSxBZyudg2Bdgoa3jGXO79BriBFa4JgUIbAUA7tOj+jAafwBH7caFDnyjQH+LeeDXGD+n5wFkVfqfFxpFckkt62rUkxucQbpzsyqp9Mqkb8kML24jU09tAMD8/X7+9QKD+L55Set087KNdBFJCwdLjglcfr9chIy0pn4gouosjh9vBuRApCsDB+gMx71VyKUrA2kktpdpmwwelTd04QqbvTiCdYcf0sFaKbCimLwrpoUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 17 Jul
 2025 11:56:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 11:56:00 +0000
Date: Thu, 17 Jul 2025 08:55:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] iommu/vt-d: Optimize iotlb_sync_map for
 non-caching/non-RWBF modes
Message-ID: <20250717115559.GD2177622@nvidia.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
 <20250714045028.958850-3-baolu.lu@linux.intel.com>
 <20250716141218.GA2166806@nvidia.com>
 <8aedbbcc-9f4c-4700-acb7-43ec4f540135@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aedbbcc-9f4c-4700-acb7-43ec4f540135@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:256::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: af3d8107-58a1-4056-0730-08ddc528e5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2S5HB8Dp6YBjkrnjnAFYtCnlMtHCF1YdtPdOAzHyuN7YRXp8nP+4exXk6o0p?=
 =?us-ascii?Q?LXvlPCouhPjLQvtdGWRTqANfDYJv11Jmd4ahyjAWITv9zrF564fW5t/m93Pq?=
 =?us-ascii?Q?jI9kk1mXxqB8vmKH2RFlkiHTdsCJfO9Sc7UMcSE6XW/ZM5u3BAZbajes7A+V?=
 =?us-ascii?Q?iD8fDrC+QRkTDODARIetgYugjkL5t5veBjNBBKht7aYOXqtFoS+phIdzVaA0?=
 =?us-ascii?Q?YwgLvqKt6W7hSqLCEESgMOzQKPnsXKNcO1i0kq4aDfwUskrWICBMqRZ0sNNL?=
 =?us-ascii?Q?tRh2XEotcPv51e0irreXWkHOmUhYIGrLQA6XxHTFkmfklhqITREFu1ySOtpU?=
 =?us-ascii?Q?DswvpgyBQfJ3er9TWsQ6PZl97Fu5ijH2f840WboOwUGSIcg6dPEVQpFfQCDq?=
 =?us-ascii?Q?oXLjtJqTTMfYW5SR+eipMXjKmINQPOhTLuLiqwuQ3aMtZxKmr079z80L6HkQ?=
 =?us-ascii?Q?Ma1OkmuK8GbmIdbMenwhEJgK1YTIyq8mWOtMxRVYHl01fiSp9ejWD6wrDXF+?=
 =?us-ascii?Q?iqPzYKeWCy2sCqgdUZ/Rlb+EiWMbI8L3uck/HUD+Twa3rtM2u8AIINVZZp5I?=
 =?us-ascii?Q?l18mymLmgxlrIApG1CdATgOkwHX9pUkXejTkRecgS2zSWxuI++027UopLAHL?=
 =?us-ascii?Q?TJt+W9kL3ri6zglmkUK/54Ye85Qiv4yY6HRlFCL5Kch3CI9GzMimcJcWi+Qz?=
 =?us-ascii?Q?aiD1xaavVG9NVrda30QzZel7kQHPEcezEH5kByfSyw2tWrcrZKgG0q7timNc?=
 =?us-ascii?Q?o39Nx8MUyBAP9kWEHrCHKjVo6ZE5kck5qvxCtN2pUVdTuM/dWJLDyZ/18Hev?=
 =?us-ascii?Q?MUOXIf0LbGPtktcvI4mCr+qguaz8yDUm4VspKdj8Rlb9G1PW4kY5Ipe3E4Qz?=
 =?us-ascii?Q?m+F0MqgMFYFbuWAmR/XeXiDdkCOnuvQO3aiRDdzeYyoQWrXIG6FL4iXEkwA9?=
 =?us-ascii?Q?X2LCuUUZKM+c1i5fH5tXHGNP7xG2FKUr2hV5ikAhQzOHlaxpntFCG9s/ZYc8?=
 =?us-ascii?Q?kBpt4eVrBiWGU155m+c04Vn1sr2otg4eBlRlwsRrU5r2mKP0LUR/J3ols1XW?=
 =?us-ascii?Q?ZKS8+W83Ck9A3zbVoxoXFTnUV512qq4RkYoxkN2vXcuop0ofbGrQk/h+9cCh?=
 =?us-ascii?Q?0iKH9Hmuq9SIED6ypvr5/J8w5ouG/yaliY0dc0FZPzcSPfc8kVO4PxadNYDd?=
 =?us-ascii?Q?k+lFLGsN09+VqGGV66NRQddcjv2ccCFluBdi5M2aztNIO+SYOVCqxInaOhKm?=
 =?us-ascii?Q?DGKuZM7odUI+szR8aTvFMKv2uWDjV57ukUi0WZ5jHQ1GrgX1kKfsBbi7Bzm+?=
 =?us-ascii?Q?kAsNf6lQGQM/Mu9FX3M3ahGRrgzBlHMXyR8opyM64jhoZN8qtyBXZJ3cPjtv?=
 =?us-ascii?Q?DwA1aom9f5Vjonn21z2SPoDmGTelpL+sdeAdnpO8FTrti5n/XB9iz+PwXmK2?=
 =?us-ascii?Q?6eIcrXczHtw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TYxuq29mMdumJbFuPaM/XKqq5s4j5Lpod/YiKiWON5rC6W7teOYl5xfOj7Z?=
 =?us-ascii?Q?YAMgLolTuTXgyhkPk4NOGpa+nYt0lyXzgsJt0UY5KQDiJz7UvVE451BWhxc5?=
 =?us-ascii?Q?3+TrPiFADMPbEpWpcNkzbXy0VKWnfEHxYC1nLkEz41vq3AZ02dlrVVSChWFB?=
 =?us-ascii?Q?QEOjLXNjCo+2zjPtcyEjVpk2fd2HD43AvIYE/KdkKPd7cf1Ll7Bi+D5QL4LQ?=
 =?us-ascii?Q?glwFlFz22Zu+hh2oRjmgCUrwWFlKoFXDA0WcNi8B2OoSAY+C5ARosOuMU/iN?=
 =?us-ascii?Q?KLuGJtpRRBbcFPfgUTviWgJMM3vslRPNXtt8ZYNUzT7gxPnOUXmU6+Isnwi7?=
 =?us-ascii?Q?OLu6Sew4o+VhZN1taFaBvTNy26j8spJebg/0yVQOso5XiWePXkVsZa1GYqGM?=
 =?us-ascii?Q?hv8Xxxy4gwHqznGpQXF4PUIqmaqVECleA71pXnhgbH9ggZ+hARp0MVYm/ICv?=
 =?us-ascii?Q?u2xXAJc1fwAWHAjzP6dobz/vHnO52YllB5iFAJQTOVeGG85+KdgeR3ogMheU?=
 =?us-ascii?Q?SL4yq58MBrVjjRxIaNAwu9SWXEw4RVbjE0S9pQrqXO5FGKsyaNJTpGUr9Z1G?=
 =?us-ascii?Q?Lt9ScowwnEUqdAlo/bmd/UzH+CO0V/v3yoPOKgRMxvYj3Dkc0RK6w1DeNfSh?=
 =?us-ascii?Q?y4J4PfmEnYQXyj8Xmv4SttFnPFZZer4bTUOd8rT5/pibH605VR7RnHQBTkb1?=
 =?us-ascii?Q?5oFeXiO2g8hant/YthtlXToH2UQXF+tZ7ELTfnnFd4ZJm5dMK/QlvH4SDn7v?=
 =?us-ascii?Q?nhxlsq3Bz3dgfql3yq3nKJF7PRxw7N+XPlOXCnCXpkNcr8MFe+aVydZsvNz2?=
 =?us-ascii?Q?l4Q0SFn717f8UkGosow1UFU0Jhj169aynDgLhO3uZXNo+DgnA5wd/qVxOnbi?=
 =?us-ascii?Q?D5DDa8rNY8vd5WojrANyaZgORHOnDnr5oZ7APSylueGHGTLodSougjGde+0O?=
 =?us-ascii?Q?fzKdA7ZXw+dOhuIyyHQ0lK3ZxeIsxBE5w1gZniQyiibggCVdNKhGlZE9QQib?=
 =?us-ascii?Q?a54impDnoFAxHMP6WqzEvVf9J02i5zNCe7uduUFcWbe3JccE9mQYajwoGZUW?=
 =?us-ascii?Q?QI2g6I5Kt9gyjSSuuZOYcociAf5CoyvLXbL7YaF+A5bx/E3OYVHDRZfEOexm?=
 =?us-ascii?Q?td2Dq92naowZO3yHA2XX5xnqp0WbF1BFJKQyqysK80ZnFukaWvqgkBMe3q62?=
 =?us-ascii?Q?U2lBGlzsJEKWFJ7jhPeqkp9H++HLuZGGchQZzVW0IeWao56SVCtL+ZnkALm6?=
 =?us-ascii?Q?tZdDfwT3AHXTlyAKBItMuLQXysj2670M3MIHI/nBi9HGVKWBxhZ+SXS0H5wp?=
 =?us-ascii?Q?0NQNqzsG52YiVYWtRLAOdJwSOgLtc7esskuT5SEWboaWPKcGD9o2h6zn5Oia?=
 =?us-ascii?Q?h6PxSIKUvD7+M9RysZ3yia6uy8vlJ90raGKOL+rR0oikFY7OO+lm0d7mGSeE?=
 =?us-ascii?Q?V1S0cqz3CBXszwWGd7KgQu3jtn5HCMkYAPWx5AFPiYBWbboIQAJwEISYilGi?=
 =?us-ascii?Q?CZQ4oDsIiiasowmRJ2VO9Y5xkzLR7/QBvKjza8oV5nJhQb0cErIh7pLy9odT?=
 =?us-ascii?Q?W3IpYTVz2keOA9P8RUcyWPJzM0mGXALKAFsz0XHK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3d8107-58a1-4056-0730-08ddc528e5f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 11:56:00.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9RYStHa1v3KwRMuBJ0DDzr9GGxo1olNaFpo3Gk6nzrNM3Q47yha7kDV0J8HAZYt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440

On Thu, Jul 17, 2025 at 10:40:01AM +0800, Baolu Lu wrote:
> On 7/16/25 22:12, Jason Gunthorpe wrote:
> > On Mon, Jul 14, 2025 at 12:50:19PM +0800, Lu Baolu wrote:
> > > @@ -1833,6 +1845,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
> > >   	if (ret)
> > >   		goto out_block_translation;
> > > +	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);
> > 
> > This has no locking and is in the wrong order anyhow :(
> > 
> > Any change to how invalidation works has to be done before attaching
> > the HW so that the required invalidations are already happening before
> > the HW can walk the page table.
> > 
> > And you need to serialize somehow with concurrent map/unmap as iommufd
> > doesn't prevent userspace from racing attach with map/unmap.
> 
> domain->iotlb_sync_map does not change the driver's behavior. It simply
> indicates that there's no need to waste time calling
> cache_tag_flush_range_np(), as it's just a no-op.

Of course it changes the behavior, it changes what the invalidation
callback does.

Without locking you have a race situation where a PGD is visible to HW
that requires extra flushing and the SW is not doing the extra
flushing.

Before any PGD is made visible to the HW the software must ensure all
the required invalidations are happening.

> I previously discussed this with Kevin, and we agreed on a phase-by-
> phase approach. As I mentioned, domain->iotlb_sync_map is merely a hint
> for the driver, preventing it from looping through all cache tags to
> determine if any cache invalidation work needs to be performed. We
> already know it's predetermined that no work needs to be done.

The iteration though the cache tags is done inside a lock so it
doesn't have this race (it has the issue I mentioned setting up the
cache tage list though).

> RWBF is only required on some early implementations where memory
> coherence was not yet implemented by the VT-d engine. It should be
> difficult to find such systems in modern environments.

Then I would set it at domain creation time, check it during attach,
and remove this race.

Jason
