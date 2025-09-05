Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CC33E7
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096653; cv=fail; b=GAunrYsa4DXv4tFbGDLKGDIrPWdS85KUQiBjgiqcOjtN2qRUEMUCjsMHAz/e16+mPKTZD+g0FmB2YzjiZuwK7MOYAoprYNqrrWwZuRd1U/Whs7zVFVCuVNRuK+i30yMoO0pOkhIVRpQMRY9lqyvSQ5ssdne+rC77l+4KZc44EXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096653; c=relaxed/simple;
	bh=rYfVdS97ISgl9mK/9Otdu71+3nUjj6JqZbpF2oS/6KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tvSwveHDQANgDi2LJ9PxdVsjPtVzo2hOwfWDJp61r+3UZEseHWsOG8ir+QRHVe2pCvgIJ2f0IOVovZVzzIoEltSAr4sHKcFmWIWB2lb+D5vI42KYGKPU4zUk7I5Da7MkuLJB+oPqBxA4Z51bWOE21+lBfvWi3EYoYAPICXl3T2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PoQf63Hy; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PoQf63Hy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dqfi7URpNKb2H8cJwndNcHPsCIU+S0A6A5BuUX7qtl4wEc1BzJkfWVRNKdJf5lGKA6SXGwWsI37v8aa56oHWMMFXb+X904PRg0p8VzDyasbAbwkbp8EMji+TAe+JQm19TlW6h3i06oKgXvxswzIUb9CxzmCaEIdIl3aE0fZrS62SWI9vmtrGzRcpEomwPBqERyHOpYt7YFxML2yUMhQFney8vTZf+HY5WPnv9kZ6M60n0Yl8n3fmljJPoZbRMAhfB12h6RRPcKiraAvjXWmLgvcY6mj5BFiQcb0qfvoQuExMA9cXutJVe4M0QkGFRyMFa0RzlGy8JXzeVjtA/m9kbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we8AQ2j5XRZUpuSwdSA2DmNkRc/M5LiV4MVBKqdwXcw=;
 b=ubg1wy3VDTwu+zM7zPngaD6WDdDbbm4wQf+bjgSqnQUHMIDTbJDloB3I1A1plo1JY/P54RWzCualqUrO6h9uQm2VKTzcLim7ahtvJTtAGcD5PXhtKEjsAqeIxEVUTLwlxd0tVMv166ZQKWY0i/9CqPVGzaGElDjg9uzU4I1AZJRHSyBBR2i7Pewf5HvwZhx6APAEC/jnxWwIdE2QlE1FUP5xqEtKU9C0tPx1HRfIVDzuhhERxhzusC72nqI0P7Jmbze63Z/oH3hFVO7iywDW/ov5bBN7xyjfIsnx+pfvGTOQ2cqzaf62RMNPYk1OGJjICxgmrV0U+vBa52h1b/eqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we8AQ2j5XRZUpuSwdSA2DmNkRc/M5LiV4MVBKqdwXcw=;
 b=PoQf63HylyHDif8RKgHJ9kxNnlEbrf6MO0ZHImMf0NGN7nlu7PToVP0+lIF5r7snHfFwepDLQmuqRCev2X6YQK1ZBe6JJR/sDqM01lAdEl001n0goNNnDsMDxFySc19BU7g/LFbnB8VssjYwmOGwCRnF1Ylmm7HbpOEqAIUZjuwFAYljS6lqoG4VrW1mqeFBZqKlDzwZ3gVrD6FuOCEs4V6gbzkfPmkN9VKNutUkMOEOZR31sT+GnErthx52gQkvU6r6ZBtG53LtiunaTxGEwoPeu2AVGvM6j+ImShzCMLPJCpDb/g53r7jZDy9URRIQ+ueex0UZ5akEgM2M+2cxaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 18:24:03 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 18:24:03 +0000
Date: Fri, 5 Sep 2025 15:24:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 1/8] mm: Add a ptdesc flag to mark kernel page tables
Message-ID: <20250905182401.GM616306@nvidia.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905055103.3821518-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::7) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: ac17670b-1eb2-48db-22df-08ddeca96418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y1rbEvMGH439MODuO3unT17b59Qh6ol1s2TPsxqU35jKoa1ZcP2NHaOjbqrd?=
 =?us-ascii?Q?Vk4MGG3K4vV/B/zLPSTq/p+eD96331/XVmHmMPlPN4DgPQWHe5QPUQRjXHYQ?=
 =?us-ascii?Q?4f8bHf/oGoQARzx91ZnyipWMof2QMGvmdkotimuvVRYM73stBQRV/w2GbofR?=
 =?us-ascii?Q?rm+MQGc/03mbId5s8g51O/0VoTsQoWm36wg8/9F5N8BXoCrvJmGOS4rjbHXC?=
 =?us-ascii?Q?9uI5FJYmai9XSIHS70nVmEbn7Hza6duTkIkk3iGuHyCfwTLQlk4CoRDHx2NI?=
 =?us-ascii?Q?hmhH8y8alT6l6/95GDILlOVr9rlSubHb1iIu0CI3rIBvACjd/gNkpszhXiyt?=
 =?us-ascii?Q?TV8y4mVrjXuKGtJ+EtwWOy2PGx07K3zjC6D3k49RRHaDzYZEM1LfqaWBrJ2S?=
 =?us-ascii?Q?eO1rVmEGauQnnPpQwGhME1Nw2p/0eo07wOAo9mIBWI4o2HBXRbGXqpR/PvsY?=
 =?us-ascii?Q?NZfXkb0iY8a0nCVAAW7yCfXkKMdJNqmBfA3yqCqnMhiWRr7nEa5k78KUr+md?=
 =?us-ascii?Q?qJ1bHTuqYENjSLvK6LkiU6RXRXnht+G4SznXfNplyfxhALosCebyRx4nevJH?=
 =?us-ascii?Q?OPp9EIoSNRbYOKodU4oDvvjRzXXEZVnf9qQu7Gqu5NXVgxLUz9pVVziCEYkX?=
 =?us-ascii?Q?gqEgxitg21TnOJviFIY0V7DYvx/6eL/FbYscxIGTuhNs7EIKNbhycJGDCn7x?=
 =?us-ascii?Q?L7+DJDdnPFqKgDQWNDhny6jxs2DoETbnWbQ8+Ly0OQ+V6XVnMedqoskpQoTh?=
 =?us-ascii?Q?FH+eN+wlmwaorj5qPQU4Y5w/eGgr+Ng+Eg1otZZ6+TNBACi0i94HsDMPedbQ?=
 =?us-ascii?Q?ptVXm9ujHbIKzOtbqPG/6I+WPTVSpVvSchvowSZEJzQjbPLzbqR3LBy6O+aB?=
 =?us-ascii?Q?FBJhTr6JC4K5PYi+daRJd7xsnkOgGbaifOYgtslnzV5MC+/1Ti/O2jI9EARs?=
 =?us-ascii?Q?60TIT/x0K3Q/LSGl9k7SMbqQXM6gYZxcQ+SAKbt9CRGQaoeSn9CKsxRq3bdj?=
 =?us-ascii?Q?2GekGxK5ZFXQse4vLKPegWI/7mAB0SWeA1fv5ba1TvV1L8rYgTkmOW9gYMB+?=
 =?us-ascii?Q?v3MHWaC+LQXbRAhFYldQMuLeu+VUsX5vsxcH1oORWL9gfrr9ka/5wAF/3p5d?=
 =?us-ascii?Q?mK1kXsb9L8UXCnz2g9ORpSYtlEVZKnI2o+zBTDQR0FgGFpSu14LWtkPq7lJM?=
 =?us-ascii?Q?dl5C8sucUfbSOWH3y59fbByEH6B5XtpaIQw9ZgWop4UvrrfGqpx7YOULK9Bp?=
 =?us-ascii?Q?JOaHwBFOb1TtbMx05+LmC5701G9m8PFfr3mBaMiUuTLmSnRSYRiLW8TXZ0jy?=
 =?us-ascii?Q?YeTF5qIQncwJDxl2KlXnCrM0GxmsJ4c/wqXRvYXg0tZrJw8prKmSYyt+RuX+?=
 =?us-ascii?Q?giaupkv2lvUFRdKnxv5tTdeUQPJDa2TJ1oOBNPOS92gVP5+fDWkTEXqWHOvb?=
 =?us-ascii?Q?8pUf1hyeDz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64RnhFWaC6la/rI9q6pk5EKRY03TU4yCwfZ6sfAVDxe4t47UfHUrHWHEvs/T?=
 =?us-ascii?Q?DNZEMG1d/U7v0DI/m+xV+ZTkOFh3EEBBq1dZtbE7yz2/xJd01065RdcGmnOR?=
 =?us-ascii?Q?Ql6ePerD5vH5EhEWPBb9o+mj2LUsDlIt3fKggVa44HkWft16KmC63YlDWG0G?=
 =?us-ascii?Q?y9s5ZFBK+lDxO62aXNkRM1zOW4Ib9dItCIhMDUsb5NM/nc8QwqjINh/tj+C+?=
 =?us-ascii?Q?M67PqepITyxzUB9Uil81Q+szHpAW/phYWhHUyz9HDEx2OkqscoK46YlssCtq?=
 =?us-ascii?Q?jvOJ5G93p8w+yvRzzJvIqa2PYhHEJKIOQ06hrdFb11kpgHBWxwdf01BSp1Eo?=
 =?us-ascii?Q?FPLOISuLUeUJxIm1ehLljfZ8T+hyjMoVN0xCBIbcC6QAgHzLNO66NMKx6dZu?=
 =?us-ascii?Q?9q745b0WzBZqcbevOX/UKSIekEIZWZdktQe6dd/Un7lbRf+MvdVWaP0K29Vx?=
 =?us-ascii?Q?/Tebc4ikqqenQvLgOt0eoTitHtrvIyjFUdpJbZPiJIkS7QmQytSxctXP90tl?=
 =?us-ascii?Q?MRR1OI6nEB9i4RHjIvTqtjipM6jGRa5wELX88QAPaVpElo9XdU/vP41biq/Z?=
 =?us-ascii?Q?FDat/VdnexDqaMRaBEH5BCKxjCK/CXbUZbWVGxALK/wVhpONJtQ9LH4CGIaa?=
 =?us-ascii?Q?VvdHIJQs65K9UTtS1GJY02dkmpsySQ1Ym4sFEmWfsVuqHOqqO7BE0rOLegmL?=
 =?us-ascii?Q?qfSdoyey+epUOC/ztj92QyJFE77Y8BB7GI7CHdNcBxZs4FXInUbh0J5gnJfb?=
 =?us-ascii?Q?PXZdVa0LCVFH21szUfcCYvr+n8XSGDNe33H9v9DtDu5Fn1NLnvGfdSF09haL?=
 =?us-ascii?Q?rN+mngPeOIzbHsdrgHeZW7Fm9N9Ge9jjtcLE3FUY9smP863aUmYKqixgmjre?=
 =?us-ascii?Q?IG1h8yFjSzzDYm7UC+iIyqC3PRNyo/jHfIEqNRVYoX6HltcW8rjHz1QQ2oFD?=
 =?us-ascii?Q?vrxoKejfV2DfYAYLJ9EBMQlYX6fJI3K8Datt98h+CaxJT26q+k+rDIcYowEf?=
 =?us-ascii?Q?CZlkzTtb6n97A9BTIECFo+R7zYjnvqBQKLEmZ+9b2iYAuGB2Lb8HGkRzDJ1K?=
 =?us-ascii?Q?/IYvMl7Cw6chrWhLhirEFoLc53ZiyFzitrl1MO+V0XV+cvMhFg4GPlFLE7hj?=
 =?us-ascii?Q?hWaAKUSX4VYLouCwYSK30ljatnzTRyvi5Yy+uC4GomAv00ZNAXfnHGIoXkAD?=
 =?us-ascii?Q?1pSzTzR93lVqv2OzaKbli27pmoSQESjqrFHOae0GMiycAFV01wHsPMTJsw7Q?=
 =?us-ascii?Q?NQ3fHX0tvSfzTC1ZsQGqeGh6xLH+Ye6P01RZbPjvkclDk72oxuATHNmAvgjv?=
 =?us-ascii?Q?nsnzQbgnYC7ThE4sRQFF16ZsdFCFIk/NWXma1P7WRP4rxRoIGZqb2saaIzBz?=
 =?us-ascii?Q?uO726QjDCUjFP0lxVxyPz8kNRRGE3Eg6z1hZEBChyXlYGiSbcjuLU0fulQH1?=
 =?us-ascii?Q?2b39MJFgb8e/MmJeq8A0L8mQ5ySWakIE9PURax8OGVRr+ioDiFIxMw/9XAx0?=
 =?us-ascii?Q?2bMLBhVC6SOtfRmkF6E2tzG0wgc8ik6eMKaJtSqA/WUrSeaho9i5IKRNNHEe?=
 =?us-ascii?Q?vBsGT+3+zTi0RO9I/gU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac17670b-1eb2-48db-22df-08ddeca96418
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 18:24:03.0673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IVeKHNbh0V0fpNtV1OB9nFBlHdX77Xvm6mYv/arQQP6R8pFrxCf/nw+WvFGWETv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734

On Fri, Sep 05, 2025 at 01:50:56PM +0800, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The page tables used to map the kernel and userspace often have very
> different handling rules. There are frequently *_kernel() variants of
> functions just for kernel page tables. That's not great and has lead
> to code duplication.
> 
> Instead of having completely separate call paths, allow a 'ptdesc' to
> be marked as being for kernel mappings. Introduce helpers to set and
> clear this status.
> 
> Note: this uses the PG_referenced bit. Page flags are a great fit for
> this since it is truly a single bit of information.  Use PG_referenced
> itself because it's a fairly benign flag (as opposed to things like
> PG_lock). It's also (according to Willy) unlikely to go away any time
> soon.
> 
> PG_referenced is not in PAGE_FLAGS_CHECK_AT_FREE. It does not need to
> be cleared before freeing the page, and pages coming out of the
> allocator should have it cleared. Regardless, introduce an API to
> clear it anyway. Having symmetry in the API makes it easier to change
> the underlying implementation later, like if there was a need to move
> to a PAGE_FLAGS_CHECK_AT_FREE bit.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/page-flags.h | 51 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Seems like a good idea

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +/**
> + * ptdesc_test_kernel - Check if a ptdesc is used to map the kernel
> + * @ptdesc: The ptdesc being tested
> + *
> + * Call to tell if the ptdesc used to map the kernel.
> + */
> +static inline bool ptdesc_test_kernel(struct ptdesc *ptdesc)
> +{
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	/*
> +	 * Note: the 'PG_referenced' bit does not strictly need to be
> +	 * tested before freeing the page. But this is nice for
> +	 * symmetry.
> +	 */
> +	return folio_test_referenced(folio);

Wrong comment, it was copied from the prior function

Jason
