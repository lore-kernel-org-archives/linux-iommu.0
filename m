Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AA3570C8
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709111; cv=fail; b=loLYgYrL44SYaNO3XUSdZ+TKfC4XOeiQjIoMG94RHDES6pzgoFi7nj0U5/oTSLsU/pX/y0nd4Wbaj4h9f0ityrm3uc6X0exjBvPWRD8F4+tbcO9GS81aQzw7+VwDKsqoTEO6dmYqVSBJ65qlrH03vqO2U2Z5Za7kq1AG1BejdpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709111; c=relaxed/simple;
	bh=xYV3GNq8fKPw0A3zlKr5zOFHSvPgfRfhFeHWjHM1TMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qrRkFVbS3VnOm9dHntNjPTM8BbsXDv/owCftRrUyPfTMXxFxDyOGayC+OCGm3nlwQV8DvcEndNQp2UFzXjt+XgYVxItIdljHXss6pq2CnA43lfV9la6q1MHj3tr+MXGKDmAZE1nMDtL6PPHdhVk3d+uwWNZGdWKQ6ilUS1Qjhv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sga8G6az; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sga8G6az"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2QH7oR9xcwOJC6yCLT0UaXXgalOMsNN6LvqIytFRmXV2EBZoYYM75ETYKm+ZSHqaihX41yc9s1APUcTW3DQo09m7G5xqU5KXCTYh9kegTPo7WwIJGgV2F2Bo/B1U+Epxv8xkh56qBdvgC5XsAhvXdMFUaTLxcMZJubH5ZAz7hpaOVudSAj+ABCt2GgmH45mHAWHlxExSbCF4tcp7EEng9EONQkjz6JkCvgRU+AL0NLoq56Z9+/arImrRKiSWurJPoaT6Lg8xsrPwc9VSxC9AuwWYZujiOegXKZp8ejBwxK1r+Kpv07vVRWl9gPnZoaGmOL4IrUORJLNdX89m3gSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhfkPJUuusT7nqbDWNAyDSLdTYDRpXcohWHJWYeMMuE=;
 b=yILInjCZaYVUDPqKHs+G0Xc3p3svYtZ9sAXEBoj6R7HL7LdlcTROPA0IrrihMaA/UAyTMYAGfml8NZsSN3sI1nN7TlUe+PqeXPa4vgXLYE1ks/kOuAVi0y1PZP9D3+ffU74E6ynwIVK81GtqLc/nf21q44i/p2Aio8F7Hb7c5hJb2cF6Ax8hdb1fLQ48uIkwM3UDTL+/eIv2H2kpZ5vCvajtmAs3cSmU2j9hcsrzPmazZgbYA28PsknkufT9hfDwW58c7Ud2JrKADu+FI2D+auapIg/aAXk2Y1A72WlrAvpIbKmwir6Q6k6HIV+8AzOHGjtqMZdz2USUoNYHnhH2PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhfkPJUuusT7nqbDWNAyDSLdTYDRpXcohWHJWYeMMuE=;
 b=sga8G6aztMz0jle84sAym+Pa1kB0joYvaPgQBN/ff71aMnnPZxoJwLcA4KxD9eNi1BXIjnksRW9n0qmmIvH+hQTew/PmrzC/lKbDc04ir3ggrJJ4l/oVxiipZqhU4gVNBgREWKm8KRJSyMtTFNNZ4X5Hbw+CokO7j5lBZ2ncsd4tu3thA0zRljRSltWKgHQr5Beiia3YieJynLcqil+Ydb09d3srukE/pNKawgHOE2jwaos/0lo7l2xnCoh1k7tlEVKWblt+95yFA4qH8llEgkYNrC8UG6Hq1NN7mbtCzRCSVwVpWmBwavfNxEWmDH4k+ImzJuRHJF8ABWU/sx3d8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 13:51:47 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 13:51:47 +0000
Date: Fri, 17 Oct 2025 10:51:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <20251017135145.GL3901471@nvidia.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
 <aPIhMGnzHiBkIEam@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPIhMGnzHiBkIEam@google.com>
X-ClientProxiedBy: SA9PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:806:23::7) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3216d7-cd51-4180-f0b3-08de0d845066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UYgbfIYqVNEyguqOMIBmoF/jSFISqsHcElIn6Rnl1Kt2bprzsuDIrBuYCGn3?=
 =?us-ascii?Q?yMjrzXlqkCH+vaslZziICS4CJPRg5BluVuY7P/HsKW77HJ8ZTWEcMN9eZ7Hj?=
 =?us-ascii?Q?KIGw+HE3n5IRnd85QNE1+xJS8bCrz1k4lu5orIyEm1SYAKhl8TXqJRLoAQdl?=
 =?us-ascii?Q?/5a2vmtH3/BBwC2P7xs+k00QOfDpgxk6I+2+HESDo3FLEuTj3c/jugeGabLt?=
 =?us-ascii?Q?SrCsaNjH3GBIsCxmLYoadHF5mQCPvGAqGRyui8bmIjNJlGqeZ9qsSqSzMMNG?=
 =?us-ascii?Q?+BcVzGt6otDjKGFIQCgRdkpDNLjcmBO5/L49uqVjHhPJ0Of0NsEWF6zV9yxc?=
 =?us-ascii?Q?NMlDRMZXAGqkODlfhPq+ISihStWn1aizPbifZuzIsg0DGRHtYIOv2XnnYwv9?=
 =?us-ascii?Q?J0mxa2sh9Vnpg7MGByLQSixqVd8tXBHplK7UIUpP6OXgXqOMmelMFTTNFK/L?=
 =?us-ascii?Q?kipqxEjm6iqytCaStT6hbdKgHyu11SGWEnuJj5W2U5oT+vp/mJD0s3VKzS6U?=
 =?us-ascii?Q?HjHdVSoPF8ou0mcP66ExfpGy/6i2IF3ySdMLWS4MoC5Kg6KKz/7v7g9/aJ8f?=
 =?us-ascii?Q?vkUB6LrPdcZmyr0YRqEywXqsIiRd/rMNo/2+nTjfg3zkSQL1gTeSbNcMo0Bs?=
 =?us-ascii?Q?I1ZwAHiYiJRZh72MSAUsWn6nfaddVOIH3WcEr7O5sW67SZjkCdp03ZDI8EL4?=
 =?us-ascii?Q?yxMkyjFaXZWSPMYZCfu016wk57cqzR6Loo/dCsgLAVwML3hlWzTyoEPhG5pA?=
 =?us-ascii?Q?GrM4/6HhSNRSqztrfy0G7jCF+oygJSG0Gx89+TGbZ0XQn/ewbgYEN52rTlgE?=
 =?us-ascii?Q?Upn9FIri3mpIXjDdTItRnV63SxOs0asx+onKiI/CRHhE72u4CQELcYwElXLj?=
 =?us-ascii?Q?KYvTRAt130eZHejHnKdFsZVwwwZ6oIP2uaD+XY+xl/I7zljFUJupXYpBR0oV?=
 =?us-ascii?Q?9Ag2r8gahAo0IOoMfNtYhgvisTCFO2Xf8MyJ4Py+anmTrAsMhKA1M55+3Ox8?=
 =?us-ascii?Q?40X71lO9uQKerX6zSSVjLIuBYzspXg19Ld1T0yT2Awi7RpcSOajKctW9HFmR?=
 =?us-ascii?Q?iHo1sZWJ0xO4ejzIeLRPi4s/NzXXstuF3J9SoMwZMTetsJfxN/0XgqVGJ8vQ?=
 =?us-ascii?Q?YBV9MLnfmn7VWNEKuZG1h1BI6U5k0w1g6BVntPNJje9dRng+frRfiamj4fOo?=
 =?us-ascii?Q?2ozyo16+LN7i79olZFlshyHIcNcw0Pei7ogqaJGgjCfgLhhRHcI2V+HzcLnd?=
 =?us-ascii?Q?t0q8jSNBjpX/6jAqZYNTrYlQ4Vab4XG5esMdVHfoKQ7PAyBAh4xYzbDP6WwV?=
 =?us-ascii?Q?Zq5T0TlvfwQLt73yagrIQ4IiNgZvDq3CO0foygdICpyCmueKYkytdgNE4uVn?=
 =?us-ascii?Q?OJZeK616AOPbOSvz921v6Qv3GeOl8lNIUKW4PCyoPa24iKEjdGPgNsFMwwxR?=
 =?us-ascii?Q?3tZl0Fjp1hRmCkMcipwPRXnHsWT5DK2W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zXr2dVE0TQr7JRe8Vjn9neY7uTj1iVfZf5IvhKPaTzTtTFyVXlRttuzRL9JS?=
 =?us-ascii?Q?0uwDdXZioQqlOhS9ztZIN8FtuU4MKUspX1tyIS6BRIIp8lxOFRFDwdkqiIsz?=
 =?us-ascii?Q?KnUhHiy9m3PeYSztkGF69uqzM7R46AX0wCcxA8UqgMPx5qWdSn9pe9If62KS?=
 =?us-ascii?Q?4EPzzw+ZripNE0u5IVjA/oLY90oOH+W5xWh8M70jMLscxrV5ypI3WPJ80yXj?=
 =?us-ascii?Q?yZUciXqMAu4zG/V+jkbLfgSBrAYY5Cg6PwlqZQVAgGJ0mrN5fUPCOXTAyXlO?=
 =?us-ascii?Q?2jVa5D4PivaJpfVJtqqaGOADlrX9LdtddGjVu+P6QrCWPQcUpebkL/CyszyF?=
 =?us-ascii?Q?D5MofsyL7ht/oVNnai6GnaZt2K0zU1UuqPVKD9umB2XmYVYbTqbbImVRqMZ5?=
 =?us-ascii?Q?0q2Hj/MaD0HvhvASj263zzRShqc6q2LrZ0t+oZS5kvsBoUXBmFS7kuFwvXmA?=
 =?us-ascii?Q?fGz46uY8vgK1f1pFqZj2HT22+BEpDnLHYwkVamBhcj9RWF+w3W5ciRrYYUbj?=
 =?us-ascii?Q?XSY8FE/E+7AwV/Z4FlDIIvqHnZDbHhbZl6azOWPIO5ZxJVwE1yu55OxuEmQo?=
 =?us-ascii?Q?4DM+BaMR/owiEABwCznaHFOxp1CQOhDFaadvEXNQU3pVBHaewTFrUNThoY67?=
 =?us-ascii?Q?vmXV/CQ1/2XXgS+OV8lxEzmCn0DCP+rOpXRqXoZUnZJDpeohcdQp2VAhFBg5?=
 =?us-ascii?Q?ZOhp6oUghFWQqJfCSUlP4dqaA1SZ9J/7uS/Azj2pzI3PN1nvm9S519ZjX3k2?=
 =?us-ascii?Q?pBiyzcILs67gzRlwh4SzpXSsO3xOxGjADFlgwEeIHErTjtpiiP4xqcoaWJo6?=
 =?us-ascii?Q?y27GpLfEoQiqkSeeVxFi9q4QwQ3z4op/50Q8Mc60vkGX5rKxqSZ5mlTbzflk?=
 =?us-ascii?Q?J6QW11nllqxZTJKWcjlsC1mWm09nUQrbkEOoHscXoD3yXInSNgMQ6bManpA9?=
 =?us-ascii?Q?kh3bWUSF714vLcymkfgX1/2KwyIrT1W/wHjUe1I3A16oeme1dnsaMREf/A7F?=
 =?us-ascii?Q?LR+cRaz5U/s0MTxrw1+ELbgUpy3Fmyg+fUTNA4Ohr+os+2d/30Lj/TP96Gi0?=
 =?us-ascii?Q?SSSxD2dNbId8YfEqhdRAtTTlQRc7bs2EEnZ5Gb9bwcd2sJmmpUkdUoGxiQAe?=
 =?us-ascii?Q?SXDcOgaomQaae3osqJkS5gh97+ixBzwKP7YXDksm1e8sQ9LDhtf2QDkYpxMx?=
 =?us-ascii?Q?tZb8ZgULg7DpjWQmi7RBZmCQCXJLLnEMeUJuml+zLAyJ825cjaRXdE3Jkcer?=
 =?us-ascii?Q?i3w18zw+kgemRtVDUKI/dRieyanuQ7zJJWu8cHVvmIm5yDYXgoNsrbdq0YXz?=
 =?us-ascii?Q?JGfpp8+9PTAfNr7Bz91v717LAhRKpkmwh8SjsylvglWNGByTPRd/eg6aCYTS?=
 =?us-ascii?Q?be9WlzLr8GyLydmV5cklUWi0qWwQ7joQ/vYGna+q7FodJxXh2ePqUIyaqCyd?=
 =?us-ascii?Q?cUHYs8bDBNUGzbxUJWuW3dRDoTvLF0F0+UuBBCdjy9+Eu/fHOjRVQ16JNVnf?=
 =?us-ascii?Q?spf96xxYKjhip7l00vYsnu30Wq9YmQuO+3RQYwvlKky0GLI11Tf2Qz/qiVn6?=
 =?us-ascii?Q?cjAkho/hM53FMP+GbXViogFQiNrAiGtwIc8Sn9To?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3216d7-cd51-4180-f0b3-08de0d845066
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:51:47.2674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siEwkoT368Wf/VUSTiIG31+pKUn/TrakreWcU04b8n06/zgludRPbJN4TYLnmBPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584

On Fri, Oct 17, 2025 at 10:57:52AM +0000, Mostafa Saleh wrote:
> On Wed, Sep 24, 2025 at 10:54:36AM -0700, Jacob Pan wrote:
> > Hi Will et al,
> > 
> > These two patches are derived from testing SMMU driver with smaller CMDQ
> > sizes where we see soft lockups.
> > 
> > This happens on HyperV emulated SMMU v3 as well as baremetal ARM servers
> > with artificially reduced queue size and microbenchmark to stress test
> > concurrency.
> 
> Is it possible to share what are the artificial sizes and does the HW/emulation
> support range invalidation (IRD3.RIL)?
> 
> I'd expect it would be really hard to overwhelm the command queue, unless the
> HW doesn't support range invalidation and/or the queue entries are close to
> the number of CPUs.

At least on Jacob's system there is no RIL and there are 72/144 CPU
cores potentially banging on this.

I think it is combination of lots of required invalidation commands,
low queue depth and slow retirement of commands that make it easier to
create a queue full condition.

Without RIL one SVA invalidation may take out the entire small queue,
for example.

Jason
