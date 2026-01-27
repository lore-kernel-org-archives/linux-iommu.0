Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CAE33BBDF
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769541583; cv=fail; b=NUd/67FNmCR/1ZEbXwQZNMi0TNGgjnLNR9arRdBNje7hF/PEMv8uwwx2sTE0GlYAEiOSl41ark8LjTr/A57zoyDnfiDf8m4EDAl4P47edzcR+Ym43ZzFlVIpKg7dVX8FyvJ9U3Ih5D074VNBKlNpY4TlfIuGwdkiK26UdrnIamQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769541583; c=relaxed/simple;
	bh=CBvetsAtV0BMXzRlny8dynIqF20PlJ0CQqFvHEWGzdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Veallt9sxmwAMmBcYH1lZQrnEC8rOUal2zv6b9bATRKaUvhc9o6uKbbMD84H0BkJrRcZxRbOjcNU39Dl91KZOALv6E9vDwpXUnID3sXlkOUMwdH3izbhk3pQoZ0yr0Je25e7iV3jK0Q7qwWAkOZJUWCmjRkcYE+kmx9h4NCbo5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KzTVP8Bl; arc=fail smtp.client-ip=52.101.46.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KzTVP8Bl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6CiUQMJi+DNNuY6HIJmWF3tCd/CeGKgsY4z21YIslMzB/FVNecC/0SKv8xFrwelhwioQYKAY26KydO97szthIV6JhMS/fixYBUmgrRgF8nDPHEXLTzLMRb/XyCKdBRL1Qf57L9AVtqYisg6D/oml2TOtzkpri0+yCnaEbdRlbsk1ldWEAN4TC6MEN66qbQAoCxFW0UjitUQxHOdLYtU1HIQ/bNi0ldN7hPci3H2kzcZq1wq5BzEPTakxQi2IJlOBjpvUGNyYlJyxNJ4mDKBnvUKWEhW9ttj6orsxvt6yLJPWZXp/olE9NApe6Ly5vOcxvBLtuWfkgxhBn/B1nn9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xScE2ypuY8jzLtCKKVFUFCP+2DYupdD6ZS/DKbYtMas=;
 b=w6xPhZYxLmd0SDySDXbiCOZfGmcNa1IJVKwJitp+FwSVTS7GLSvZeL4FHs5GVl/q39tEj7FvY13qti9grDBlRRouGDKDyQjHVmphGUbNMefO/TNxLtjxe/o2SDvbHNk7ki7Nv7mgENYqiTcrlkA5yKMf8E4LePPnwrClGOAlhyQACe53dWqY1RQD2DEMj8xofPsZkPz9y0c999Iq5tS/OBH3QivCll+iznbOu7Q5pf+9SFJ0aR35o8hRmtRX1+5U/RSQ4/S8VhC831v5hBdrsP7N0sjBicQq0HLeRqeA+/+R+4aaIhkdAEFDSsuM7wAQUm2yB0Ol4TYpQhI5+Bxiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xScE2ypuY8jzLtCKKVFUFCP+2DYupdD6ZS/DKbYtMas=;
 b=KzTVP8Blr4ynmZMxIHZXWmnxI4dq9itDu5/iM2Rc4VLu+ZDhGX2Dd63kCtkjA/jWKh2EgnIZ5a1iBtY60mlAeLNqMkpAsOBARrM1SQ2uQjvr21IE1isU3ON3fjWuHtJfzvHLaPJebQwYNQxkcOSiUzBwboWzC6ig9cDuA4qIUgOFiXujcwphKUTpSxXEkNDlgNF9fOtzwKWEFh7R1FBzumIy4l11NaIoOHJZOOCw+26onznwc6lF/vaWEivtDAYRIbjuK7OD0h/zrEmAPsbiyk2Lw+xZz7hQIQoA6fz9ayzm8RrK9KbR+X8ZxSxWREaYHJ9gTxsWb+bPRZ4EVSmrtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 19:19:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 19:19:39 +0000
Date: Tue, 27 Jan 2026 15:19:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	balbirs@nvidia.com, miko.lenczewski@arm.com, peterz@infradead.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20260127191938.GR1134360@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXND9YJTwm6om689@google.com>
 <aXjqBy2sWAUMm/aY@Asurada-Nvidia>
 <20260127170837.GM1134360@nvidia.com>
 <aXj+zaLoh/yQmHOH@Asurada-Nvidia>
 <20260127182348.GP1134360@nvidia.com>
 <aXkF+FcsXG928Qfc@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXkF+FcsXG928Qfc@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:52c::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 4125e71b-588e-4c1d-ecd9-08de5dd903ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KEnw7SYvfBJt6qV16ht1/za8XCo9wo1ayRNxvhPtBVY2EgXmtHt+QiFUDhHA?=
 =?us-ascii?Q?S+yqbVa/SFccG+BxCBbn9ptPlRFZ1fQErYR0Xgkrml3gM7BlawN1padWMpTT?=
 =?us-ascii?Q?5nUTGMeTcjaSno1Bp+ulxtUCYZaNc9WhzrCEeALQukdgJNp2/CBiiakbCT7Z?=
 =?us-ascii?Q?kCGgNQz1LFJLelfYTVBixF54meQ07NdPVJMyggIi/1r+onkMX0ob+5/V6E0f?=
 =?us-ascii?Q?pdUsIX5RKE4MumOrtJvqBsp0+EOY5nJKrzUkSfGmLJltqOoLBqvcQLB6E+TT?=
 =?us-ascii?Q?4l5vjJwkL2vpTlTLmcpmYD9mHBDYfrt3ftJXIlOPj7YC8GeXQm83OGwM7e49?=
 =?us-ascii?Q?dkGXj+9DP2jrzpRXi6GkkSuSH5HfPC4205M3AosIs4VzzY+FDasmAZsGqQeE?=
 =?us-ascii?Q?COabbpSOBalzgdpvJywGukNAxjhL3msZ+3RexcWuFI8qkiHqfjoGuLz4GLNO?=
 =?us-ascii?Q?wtUeuBGDRWM62hblmjA62pILNw2R40fZeh2UvPqKJhi9QT/Ln1GQ+skR2l7G?=
 =?us-ascii?Q?6m6DQoUd2XcZ9PkBFo3U90nqpMB9qWCgzyy+WpWp6gh4TPxV8v/v+Q/dAkcW?=
 =?us-ascii?Q?6eDY7ci6+11LEJQ1Fy5qdyWLRdN6kxvjsKCsb5qZMf/dSGORcpAWV115rP6A?=
 =?us-ascii?Q?P8lD7vP7mLXxcw48ZRHHQaEsOXuuC7avJ58AaK3Hvfck51iqv+Zeu55SD3Xo?=
 =?us-ascii?Q?JUBIN+jWRBCtakYocLaW0/iVMKJdFjKp4jH8nVUZ2aBOYnArfmoOcSFCFexW?=
 =?us-ascii?Q?Lq106MZS+ZjVQ+gxtylm4qJMITreFbl6bqVEbI+BBsTMSnIWO5GcCAMH6l93?=
 =?us-ascii?Q?Q4tcCgOmVZ/4CLQw/OVzu2yIjQWjVBQddZ+M90TzZ/p0sFJtmaHWuNz33Kzx?=
 =?us-ascii?Q?JWIzhW3dxgUyVd+PP23JfcGeF9kVsCsHcXHFu/v4W/sCIUfTtPHcsBxIq5mY?=
 =?us-ascii?Q?64z+VdY1tjMIRd38XI3HazxNYd4oHEGfV/G7Qcu3DUTtBMFQWITb/PRhnop0?=
 =?us-ascii?Q?T+SfFp4bnEvyPLD8KHXqWGXW5yDX4R8DI4mZ11Ia2LAZ03NlsQrKiFK6PR6I?=
 =?us-ascii?Q?a0GRRU5Fw0/Cc02cM7qg3G6dAESrk+WL1wDUe1ZCiKYSg32S4nktZ4Yfq+WM?=
 =?us-ascii?Q?EdlGzISRbOrD9ZkAsS5CSKTIaZyArgkuAtdJv7FBZZ4CiLxFRNpPaSr104Yx?=
 =?us-ascii?Q?RFECNpZOWCPId9HlICyYuFzLX07/KvbIqgRC3g0Sbj2W6hlZRB6fvMRm8Lf7?=
 =?us-ascii?Q?1Q44+yV18vLEqIUFluPSQKold/t435Ln/fHv3o7GC20qLMUbVo97zgeLnnNB?=
 =?us-ascii?Q?ZRTcYfEmWn1gQZ+3KU8n5GfpxukhqE+mWFF6DjFP/hIooMxLcBP1j43q3DMA?=
 =?us-ascii?Q?hVXs9eRRUB4b0oesRK7KeMxh2V3zhWzxFd/LkU4+Ka1vAI3HpwjIMhIhHlJl?=
 =?us-ascii?Q?/Xv3aWJfGkt5aUF23n7ZAhUoZmwEHX+Oyh3gaKiJuZIHHARzPyIo1YA0/R4v?=
 =?us-ascii?Q?Ibcw3yEXCw6kJ7uiQAEBoF2n1K2JwJe8ZGjpLCfQBjzmQu0CuOHuro4TMCny?=
 =?us-ascii?Q?7aos7T05LJ3zzPPtFpvNttswv9LEg8vPP5gQM4O7xv1xcjnXKHzEkjgj7srX?=
 =?us-ascii?Q?L3WibrG4E4mSaE2Dy/Sim1s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jkRJZOrwVPG8HJCAmVa1xqceVyk368h3sbGreuoMPOTIha5WRV2UA3n+d18L?=
 =?us-ascii?Q?f5FxI1o5oDqcbFT8OhaQk0c573CcKPvGBK1pXWfdm+dYXC5ZZUTkJePifhQ/?=
 =?us-ascii?Q?Pj4E2+xT0KVePqRNhg/l7Olsx7bGulwFDNtObI1uv00I+o16YGyKgMetmJ3o?=
 =?us-ascii?Q?Juu3GaHTfKFYR1f/TSAQENDIo5yQmS/JHfy+36+MD/HGNbtPh4KDKATXKOdG?=
 =?us-ascii?Q?+2nzpjpxnvrRENXrOVmZCNlp/5/MqpPT0lXKaoHRAo6LGMYW5FX34mFDpVl2?=
 =?us-ascii?Q?/6LKxxh6QVVVUpkPT0Msf/xJ2LV6PDO8njwMk9rUtdyrXDp47p27TKCwsZLU?=
 =?us-ascii?Q?yY/EMPycu1fB/FKXqlzWYLkit+DLhBLKunxkcsann8q3gxkn97w9+UFPpWJI?=
 =?us-ascii?Q?Hzt7IioIREF0dkQNoVzdYd2xJFVXIIXtvXFfwmBxPm3c/BKGiGI9iP7tsKrO?=
 =?us-ascii?Q?Q7sy55cmTZIvnA3ryWNCABYNwXbfKX5UjbhPablgquOGDt6gpNmhKXfS7tq6?=
 =?us-ascii?Q?iSQWMhInwybJ0sRFJcKNYwQUK3NFFBh0KkIIYq6Vdl5OQNKIlK6wS/wWv1d2?=
 =?us-ascii?Q?+w7Df8rLaEWju8qcGUBR2sW9ZWEa+qGQKaZ5nh4IpsOUiza/txvWcbGdANpS?=
 =?us-ascii?Q?tAk2BHMnlSebpbmHftB0mdNCzvv373kMArz1Pq1QnC/0g4BiOxaI04GRLxLj?=
 =?us-ascii?Q?Q+5wUnl3I1CAxNvDGwkkapY9AX6tRcQTnhPJZh9uOs6pNrU3oG4GhvRBcVc4?=
 =?us-ascii?Q?32XDQneEt4HQbJZCIJszGHuzDoXg+wYHpZ1gXJANyUdkeCaRVOs9SuxUTbYN?=
 =?us-ascii?Q?smGDfp0rUCBU8mN+qdLIwVc2cyCJsXlsiDqMrttuZuAeT1TTq3lnIS0gf5JR?=
 =?us-ascii?Q?4a9Qb1PmCNIKSE2speyGDNytbI11YlmI3/ZC9VSeQFK2IPONDwz85Lzv4gjS?=
 =?us-ascii?Q?BAkINCv2yB12UHlMe33rtGoyNOQBcz3gHFJFM+am9rEodPawqvjOo2el1qAM?=
 =?us-ascii?Q?3ZyP64JjlWo+C6Qas1rnlEtfLmK0LloosFfi0Ft2dMJ73hOeRtGBvEJEmiiN?=
 =?us-ascii?Q?x+Vzx5Or5ZDfkTzo1IWT1JANktOpS+dSpDO2doHwxGfsvg+SDNvSrCuRYR7X?=
 =?us-ascii?Q?ShaPwVfaZedFbwUmV3QtEhrcz2ahxu+MYVLI+JvEaTntlq/9dwEySxFU/g9D?=
 =?us-ascii?Q?dUTPkQHWFyO/zmZHftJ4GVYdj9oyFW9YGq27hpEkcUCw3nO60+5R0e7oX6DR?=
 =?us-ascii?Q?jjFAjesQAN6yQDyjDazTfrWyXmMa4pxjbqiNxrTLvhdL30v/XN444ahrtTLV?=
 =?us-ascii?Q?obCvnljMJRtfOu16CAw+ZogqtkYiujA8bKol1No+3TYd/95Wz41liTG6doFK?=
 =?us-ascii?Q?FFxKCQzUDIs2TgFsbuj72aVBTMgzC6ryLg6S8C+BPsnNTLLgd0fSxdu9+KYi?=
 =?us-ascii?Q?5nxbsLIK7Pm9h61s1MmiM2hyGYcqhj0E3flBOazGMAfoKqHwgBRDducyhfwU?=
 =?us-ascii?Q?VKxlBqx0eC7OT2mMBzB/3HG5OmEXSjV9ilFp7ciuVjYV5CvLeA0FP4m3zag3?=
 =?us-ascii?Q?4Sx5Pqt5I53pbRrx9RYh2k+cC/3vUKXpwdkUD3NCZ4/ahKWorPaWU1N3eOF5?=
 =?us-ascii?Q?dNM1Tid1nI1agJ30k6zc143Z7BHpA4al36uviaIoTJufDOysTE3WC2ua2YCD?=
 =?us-ascii?Q?PUBIckDQVzWyN7TAPG1LJTWCPEHw8fXO7Bn9ajwZTmz5650Utx4DRyUCUVx0?=
 =?us-ascii?Q?VYX0mfHRaA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4125e71b-588e-4c1d-ecd9-08de5dd903ed
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:19:38.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +85hNmC19VvPDpLdNiI+jnXppIDyEwOIWMvR8+qPBjEDZV6UUQgaJ9LcJ5T6+kUT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123

On Tue, Jan 27, 2026 at 10:37:44AM -0800, Nicolin Chen wrote:
> On Tue, Jan 27, 2026 at 02:23:48PM -0400, Jason Gunthorpe wrote:
> > On Tue, Jan 27, 2026 at 10:07:09AM -0800, Nicolin Chen wrote:
> > > > My understanding has been that this invalidation can run from an IRQ
> > > > context - we permit the use of the DMA API from an interrupt handler?
> > > > 
> > > > I though that for rwsem the read side does not require the _irqsave,
> > > > even if it is in an irq context, unless the write side runs from an
> > > > IRQ. 
> > > 
> > > Hmm, is "rwsem" a typo? Because it's rwlock_t, which is spinlock :-/
> > 
> > Yeah, sorry
> > 
> > > > Here the write side always runs from a process context.
> > > > 
> > > > So the write side will block the IRQ which ensures we don't spin
> > > > during read in an IRQ.
> > > 
> > > And, does write_lock_irqsave() disable global IRQ or local IRQ only?
> > > 
> > > Documentation/locking/locktypes.rst mentions "local_irq_disable()"..
> > 
> > It will only disable the local IRQ, since it is a spin type lock an IRQ on
> > another CPU can spin until it is unlocked.
> > 
> > The main issue is if this CPU takes an IRQ while the write side is
> > locked and spins, then it will never unlock.
> 
> Yea, that sounds unsafe. I'll send a v11 with read_lock_irqsave().

I'm explaining why it is safe now, the write side takes the irqsave so
the above can't happen.

There is no case where the read side needs to block IRQ because if the
read side succeeds, an IRQ happens and tries to take another read
side, it will succeed not spin.

But it is a very very small optimization so let's just go ahead with
the thing that is obviously safe.

Jason
