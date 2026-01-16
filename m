Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E813B293
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574016; cv=fail; b=ES2bAiclB332mDa0fOmP4YP2UePc6hNss2Kv1Xw3gJV0K72yPJKCBIDm2XdgF5AAgZDnKJGl/MxO+Qb3rNjQUBDY12mRcfQ3LrQLFa22UEFLcliPd0CPVyz7vEYP/rdwQFr37zW5uJfBjQeDLqwqozJQkIstIBwmxH3Vb6FbYxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574016; c=relaxed/simple;
	bh=n+XevbToOiRKA58mq4itt1XxUyu1DHMC5KD+JJ74kJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ft+WXvMbvNqImJAkuYzPw73AI17mK03kUjCr2Q6zVysYUXc3fgp/sQ/FR2T96+wrfjy7UgvIkKBwjOrNanc6LuitFnOqtgnPkgQ4IE0yzmji+gix0BvIrObw05PT+5Io2D4QstA9Uj/bvdSRZ07DHhT+lk/QtoEsuVtZengFZ1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FzTV9Y/t; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FzTV9Y/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Si4ansVdf9AtGKj6Fv8K2kQPSeOQVi6mH4gE/3Dmck97hFtkJfnzeitWDCWuh0GL4tmoo25P2tYFiaDdsNLf7D6UCpZoyyTVzRaaczC0bP0haIzjucH9+mZcG5dkhtg5mVGYYaDYoXeRxt8Rsyi/FX5DAv504JRSPW/V3Ws9rU6NnkSkOnuaqxXahBc3Ed7a+GEmcUwlBZH+Xp0rkq2ppq7w6snvRM0oxneD2EOpMXPKOJGIXCHzNaK4u05NGJxgMJ2TqVrjUOG2Y0KUfh0MnUmKgbvFDHb+RTvdMggjD3wM0zd/lbv7E67o65fqiteCi5y6KsGeelW4iwBEkesg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+XevbToOiRKA58mq4itt1XxUyu1DHMC5KD+JJ74kJc=;
 b=LG5APnlfVboLKS+2P9ss5ixgx/HC/akNw2ySPsY8w9t8Z8qG6uZ++IA3zO9Qhq7uj9Ey8nlbZt68XOiajbPqytY8L50r8vw9IOGFTJfxGhr+RxJR1+vpKsQiDfDlO/k+T09UxmOAnK7GOFFiTnH7jue8JdjTMpafTRw7coWvR2X6kLQEZq+xSnMIcCnYCigrwE/x2o+f6iKJQZ3MX98r5CMqzefD+TKq5MDWrSYQm5pGr6Fh+Al9Lk+C1dVto0bstR+PjE8jHvDJZUQdHM7cL34hbD3JiHVPQvuFFncdYio3q1nnNCjd5XIscschAX02Ntmv1wPk/AsIuoUwPQR/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+XevbToOiRKA58mq4itt1XxUyu1DHMC5KD+JJ74kJc=;
 b=FzTV9Y/t/FXfOn3MsSfylonndBNgxD/Pv6SBbUgipjN7hRGAxgca88YEtWBoLm8C7OZA2z+h6ptAYgOMkkfKSKhqNbsLkVkdEr/SaSjxtIhowQydVnZ5O4IbNXUmaEmt2DLOJ+mCHisoS3wWiJtX4p+npLhsJgNnQ4jRsNUw9bOxi4l/7hEvyrEhiP3cNHHMWv5zTOuvxu7uuzDUaMhhu+XQ7V1xaRpcEHZ+noo8SfhazkBlXV0cgVnsCUowwV6AIPAbIpuWB4JtN2n9UaSAY2eTV62pHRLcmBxTnee7hSedH86BWgAzCcFYgAJWsk9q1OGw+USth9qtSZS599Y/rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 14:33:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:33:32 +0000
Date: Fri, 16 Jan 2026 10:33:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Message-ID: <20260116143331.GJ961588@nvidia.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EFACF8AA21215568550F8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <db26b1e3-bd7a-44ee-b458-6cb0fedf6662@linux.intel.com>
 <BN9PR11MB52768CB67C102CFCF562E8248C8CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260115132322.GE961588@nvidia.com>
 <BN9PR11MB527605C53AD9E8C6C6DCB2498C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527605C53AD9E8C6C6DCB2498C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:208:329::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d8eb5e-c1ab-4479-61ab-08de550c3950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ID0RwfbS1cPl/IIUjTqCUmkaFa921kWd9hruQWJodpCIbWAHjNhQkSotnuR2?=
 =?us-ascii?Q?kqf4IFUEcol+inobh4dQJdG3oIy1jQX9A5PBI2FXKoUoHqfp9i6ONWHc9z57?=
 =?us-ascii?Q?qZcZwxV2nZQqeaEZPIHnEs7wbnmRFmn6WPcMG8paxIiczMDG74O48cKygwni?=
 =?us-ascii?Q?79MBLOMIHMiRJ/+SH7rW5UkQ/9gPupp3zxteAMChK8N0qqJZcX7bvBkuU1i4?=
 =?us-ascii?Q?ukJnJdj1OlHE4w50CkvxE6s9kdqb+aXpPrIoIgDETQ5Oe9IV2R3KQOv5EOFC?=
 =?us-ascii?Q?DCGaqGkZCP4IyxmeEDFX81Yrt6eWKKL315i+qFG0NG+vrxUIM+huzKnHzL3b?=
 =?us-ascii?Q?cjAEGRF0Cmd0TgAiFWNBTOgTH01HvS9X3HnGj1uALQYrOlaJdbafyGdg1PDG?=
 =?us-ascii?Q?zUm13rlpXFASz2WMM3nhexdtPD0yXFHc9kfuPQSEzFYrP8vnOjBbSG8RIDJb?=
 =?us-ascii?Q?snKo4wWWQkGSTHJEVIkobisNVTwamjgmEROvkMpb3/5SYCWgWPLeo6vgYYcw?=
 =?us-ascii?Q?Ch8PncNjRX5v1VZ0fQJu2VUggn4wz/M5lBwXDq3wnwxWwuWR8sOldH+WF0+Z?=
 =?us-ascii?Q?GVea26Gu93Hx8o3F8OGSTsuAARK1225dUQ0+cxRUDD2hLG9pVs5wKqTfWarn?=
 =?us-ascii?Q?BtbHjiwaOhVx51U2UmL6PC4l+XOiRoy7hIWIsR2JB+vybnygN4eTuaxuD5uq?=
 =?us-ascii?Q?JOoNwPE64WLaA1PmixxPSzbWFxa/ua0aAXc98uDu2Z+9XYElJFXOrVibbQ3w?=
 =?us-ascii?Q?y9oI2rbl4tRYOqC3b9MoJopOWWviIYjKhv9IbE2YpiBc9zkZMHfIuGXqmhiJ?=
 =?us-ascii?Q?IBSAZ/pbNU6cTTSBvJ5o4vfs6ZEcK4ni4JRhAyFGEAHfwZvQUGCN3I5Uj7Ko?=
 =?us-ascii?Q?oPlPooZ9SPuynFImyaqE6zKB07V3Lw9rqgIAaJIYSP7P1dEJlDh+sv8P6lWl?=
 =?us-ascii?Q?IlvHAi7djUT8qtXtLUqBWWfhe0psjTiv9+zSrMjA4k8fVmGi19eWeS+a6DEG?=
 =?us-ascii?Q?4nfQ/q+ws8ZE7Iau8dEICqOh/DntYVkZ3wTlG2QobOJzX64AYI1pD7qwAU2E?=
 =?us-ascii?Q?GkC8DM7Uo+d7ee5ivv3X1+4jSCjfgm+2hszFzX0+MATm9fi/YUGl/JP+zKND?=
 =?us-ascii?Q?qn7hTzEaxvd9Sw0HGeoo3zzOHoX3dc0sY9u2z8YkODSFlJDdCv+9CheGK7In?=
 =?us-ascii?Q?KOzK5+4/U6eW7yHtsAfTnmKOivwjM/YDtlUBITvkGScipQFgan39T/RDg8fq?=
 =?us-ascii?Q?HBm03GP0e4bVe50XGsNm+DNzsIVafdeYy5y3N6gwHO4RLNGd/Sanu+O9C2D2?=
 =?us-ascii?Q?PWZlZxOMsircgjOv2irIDL1LuWUw4jb7Ldsf+zN6f/1q08sqI1cpxeHfNw48?=
 =?us-ascii?Q?+PNIRfEIAB9ZLrtd5hySKfdk99mEfsPVYpQ1FZTbDfYkHNUbakpibo9VSJz2?=
 =?us-ascii?Q?nOs1yLnkv7nG/1xVi0aWSzKNopQK7CpnBvPAS4dbSBaHSjQVoYeshcSPlHzP?=
 =?us-ascii?Q?r3VAo3GJJn8frNSvqnjcfJVD5NEWordtBrhb0zd/lll76zsE1oXymXLcwkzE?=
 =?us-ascii?Q?Y8zezOdXVJaO/k2HaZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KOhGUZn8jJBpiJOZTqDrmrry5tPoyvvnSYIFRVaUXz+p08b9I7oIvwOumRza?=
 =?us-ascii?Q?LAHUVKDK/0VsDAdwRJdafKJcju+M5HUBi4ikpivUJslo5qz01uzWwbMhz5St?=
 =?us-ascii?Q?j1Q6gaXSaYBE6t4jMXHQrCL3DniWD6zg8GoFz6bulfTtZysmGZc9qqh0LQed?=
 =?us-ascii?Q?NCBb765vuBHf+zQky4wH423k45Wk+GKIq1CaXG8kjy7Lf1ugJWmTaep+my9g?=
 =?us-ascii?Q?ZNmXxtRMtOR4sPVWfCVGX9/MkMeUCqfNnvFjK/xPbG+AoRj84+Dj7DT7FKwd?=
 =?us-ascii?Q?/VT7ctffXZgfjeAk1IrdxxXBNkcsoo5PZLcFCwooZu928F6RYpgIJEedEfKR?=
 =?us-ascii?Q?HA/d5jf/NsKIeDPv8JTGcIIvo1GWqQk3kT11m9EntPLs+jbfKLCYzfNJd93M?=
 =?us-ascii?Q?RrphvSyYY+Q0qnDYLWny6als617MggLZcI/6QYHm98hwxVUrkZJhRV/EywZQ?=
 =?us-ascii?Q?YlN3w97hp/iyZMQ01Lwgf/QzwBPgoy2SbJ84LTB5rvFlpHg0/G2hmkcpiZWD?=
 =?us-ascii?Q?EUQNKNsTfldZPgzPMJb2RTeZh76eguJZx+LvmtliZaOQlZVWdaHsWTHSQ3T2?=
 =?us-ascii?Q?DMom5Lg7y75grtqzJlzMJ70/PvhEyqITHsVtPvP9WSdq2ldBgDMMYdZUSnDT?=
 =?us-ascii?Q?Kjt7sc1t46XapPnKegVbMnsQwWI1aQyljAUnUEW2SpnJAe2kq6IglkCU2yQY?=
 =?us-ascii?Q?yvq0ODpJZUsNFukTCB08oDxhgcjeVBPgyMp2yEiRSPMNPBPWC0HSDpDoXZXF?=
 =?us-ascii?Q?fH4yhoF5KoKqNpO8RJPx8osAeUQ1pAE92mW+uAHH7yK2F5qxVfrRVAfbPrlg?=
 =?us-ascii?Q?ZddvndsL8pzTNBz4g8x6EwWeHaEfeZ2j9OCOAuihJh5G5aUVv/6FvabEfGU7?=
 =?us-ascii?Q?ODyLKmNSBA02+E3lsjej/ltM5ZXD56roXsv9w9CzJFCkjvDbpuRqRxmftJmP?=
 =?us-ascii?Q?OAyBpN/I7bPot6+ASEjlH52zJIJ2yXTZYS+W3E1rSl5dgXr135gVNc9XeGfM?=
 =?us-ascii?Q?qI3s2rJjTPN1e8xcWVE04AgmIoXF+eurmJ9YzGG3NSPoq9XrQKw8QXzCd/qU?=
 =?us-ascii?Q?kXAeGQOagpz7k3aaUQBul4T8KCD91QPavh4F41HLic4PoPkQsARO5luU0NRt?=
 =?us-ascii?Q?8sAD2QL2UmlMKrIIWCSjbXnbDPq1kjODbkyGLS5fmuVgwTOmuVmLrWoV+Xxy?=
 =?us-ascii?Q?UKVZkFq5h2Thxc0oYxqqrVh01hlS/zO8ppQ8qmh9N/mfYuN7z/vwZcynRwqa?=
 =?us-ascii?Q?ppIUau00iVEmNBQMRScUpFCEeCR+UUhnUA9Br0xJ4LLl5vA9zDlveXusfi5E?=
 =?us-ascii?Q?VaTZxcH12VwWi0B7wXrL3feY3Zwxa4Nspxx1jTnYIgA9nNmcd6JjcRpXAOIg?=
 =?us-ascii?Q?ierXJxkPucOvhjgSvs2mjB/6yWww+oVIxiWxaGxFKEgBhtbyH3qcSVngKTe5?=
 =?us-ascii?Q?0EYT+ZBAaFnSsTUGZic4BVBQubnabLJIqARHLgI9nIdLwNCHfh3nTDMxJKz7?=
 =?us-ascii?Q?1b1cU0THKVhu1bdpnskqhVvqLlrVWGwOS70agjsUInNHilxU8XurojbFRvFP?=
 =?us-ascii?Q?q9oR9epz+nraaQKNNegUVlhRnuT3MILRpnKyQ+Q+MqORVP3M0P6LJT1Zk2/W?=
 =?us-ascii?Q?JEHgjmGHnYpm+86mhpm2/YE/ws34FXcOKF64qvE89mzdPE1ph3sAPddZ3twD?=
 =?us-ascii?Q?NHclr39sVm8gna9UNWrfPAkJjU/bt6Q6YPhVpkPg2GHMg10ZpzZDH1vGo7+9?=
 =?us-ascii?Q?YWc8kMwjnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d8eb5e-c1ab-4479-61ab-08de550c3950
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:33:32.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmP1G4OJHz+LKIBfwvDNkK4TOEVMQkKAOTMEil1RZvLN59YiMMlSmQxBafQ+iPao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

On Fri, Jan 16, 2026 at 05:19:52AM +0000, Tian, Kevin wrote:
> btw the way that VT-d spec describes it as "software MUST use
> 128bit..." highly suggest that it's either as AMD or with exception
> only on very early generations. Another exception is VM which
> may have hardware supporting 128bit but vcpu model doesn't,
> but I doubt it's a meaningful configuration nowadays...

The VMs is an interesting point..

I think with a bit of fiddling the entry_set mechanism could fall back
to 64 bit operation automatically, and that would handle the
compatability needs. It would be much less hitless in such systems but
who cares?

Jason
