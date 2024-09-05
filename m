Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5319AA68
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538553; cv=fail; b=MbRScgAQY97LnybyzSahLSh15CvSnLrxXqZ5x6tZZxa8AKE0QYagDZlmrwr3I6AYH+e0mUpSos6HTe5ZkwM8Xq3mocMPssUYW5GC9fJ7XH1GfdDgSgRKrpnjnvNwZRcnM/TTUIULDE1ZrOUVgZ0J0gvMZRyhdqJb8t/Lt4tZ2XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538553; c=relaxed/simple;
	bh=9D7ozJL+FmB4rUk2TkZByxt/MgRFll/xV0tMxwqEHMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQQtQsxE8aN5mjqA8XB+2MExabwuMEFIof8hpF703QUR6noKRJWkJUZt1ayV1sYRU/SOb/wclKjD6j0G7KdoOXl7rHGsZ7b9c2oLmGRxcs6cuTGWoXo+AuVq1AaKgMnW/rjSPwK+dKHUXf0NPYEBqzdaAbzVra47YLnfaFaopII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J9Pq+D+X; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J9Pq+D+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHy7zF9VF+QEOL3clvJFRIbHIEO87L0wMPxhZHGFYXUP4PzSlFCDNFDOxvrDfqGYfHokScoS1zVLax+69ZFZUnP+HbWT0KrjHoa8kHI9s//iwjT4dtPm8KAFocHNARcG7vrq9CwAQxOx7bUzDwSa34oEgPRNgHvd9/pxdOprLcyZWQ3b2iN3oEUKkcJymCh0xJJljNlk4P/QlLEL7NRs8KfxiebBr92XSiiid/soInCqn8BP13ek6HgrdfSh8Dn2e8sEPdf8Rn11Ljno1YxTfEDB/SnTlAbyPZAG+8nqVRLkCVfSZPFq6MEgm43kUEVnXpCihMJJHrjBnrlwo1OLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpMSO3ec0MSHiKRIy31rb9BoEmpNcbdfEpqd+dIvfCk=;
 b=HfTUzwh6t06Q4Ug1d1ZUqiTrV5LNVWP2GLsdpe8zBwAOLzz5Ao82DgW0XRHc8L4q/SejewNtItvSgzO9TzXqZ79in1d4AbUancDtlAO67w9D21p7JO3SxTwKQynYYSiN0XyWDw2KCRnXUg2Uf49HDZ/qObGQQbOwsWmlPR66CMu1ugKtN2XEi074V2f5DdkmOt4F4LKauWYpzZx97b6g3OdfWfWecLxKCSj4CfqeQGbnDNfpt61vP/X+JASyEjHDRd5b34uMRSCPl57DiT8rmPGb27TOV648Hf45DKRsGAIMB1EJS/iGEARylQojoFUq/sBvbd5gBzH8FozKDpqgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpMSO3ec0MSHiKRIy31rb9BoEmpNcbdfEpqd+dIvfCk=;
 b=J9Pq+D+Xact4FMImRhoFrDuawDQNpGAIxyylQtngvp78b3ihQeUZ+fC3ky0ccYcSKUn1OOe/4yBMH2Mi+u/IDjCovkY3ClrLouiF8rT17V24jfybJZo+WKOK1esxjUfse5CKewwZ0N2IxHEDlixcE+4lcdHKgMYlOnc7wmuIvn6bHdCd9IEUTcEBcrR3AWbrQa2dQngSc1UnOJbis8OzdOaziFqoUB+U/Zp74931qqEZxkKFza/LZuFRY/86iuDkBsmJ3Ci0/4Syzfbg2HO0aDgru2qB+Wnc/ZZTeke9tD0sEkpR2UzC4Xk/tcm8u9aCjB8BsRT0mh8tOL788mJJNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 12:15:46 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:15:46 +0000
Date: Thu, 5 Sep 2024 09:15:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v2 2/5] iommu/amd: Introduce rw_semaphore for Device
 Table Entry (DTE)
Message-ID: <20240905121545.GE1358970@nvidia.com>
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
 <20240829180726.5022-3-suravee.suthikulpanit@amd.com>
 <20240829193402.GK3773488@nvidia.com>
 <096dc644-c42b-4d59-9306-4007d04b779e@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <096dc644-c42b-4d59-9306-4007d04b779e@amd.com>
X-ClientProxiedBy: MN2PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:160::43) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 01349bcf-e350-43ad-54b1-08dccda478b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQiK0O21t2377LLBxJNYG6ILfOPFWmMnsfuzZCZEwGqZEby302ovFZr81w94?=
 =?us-ascii?Q?ql+R+euWPpaEkRO6MYJSOhywErBn3UkVr3aD10yXML2JEUogZSxXEcwxoLjD?=
 =?us-ascii?Q?H2LpSXaOhyWEvtzO4XMlSq02JjDPaJ0MvBlmcEZLv0AnxX/AVfRblGPxLeU2?=
 =?us-ascii?Q?Gde0plO5/JHtz7P4aYlzVtW7DDNPjEgaAKd7dbEwJLMTvLKZMEx9CxS2Mntp?=
 =?us-ascii?Q?Kan6pZzrIyPc8agwZTnrPCZBNDtTaSq2o36vXybJov0KnseZheDshv9JvGdC?=
 =?us-ascii?Q?aGOxzYhO1m8VKEmikzDceQq8QGmfj/PC3pa/usj6gRloYXCm1KZLyS7Qb4yB?=
 =?us-ascii?Q?0EVs/YtyZip7EFBO60RqrXKu1DMQcrJnnZDE5xmxR8jOIz4dm+lEoTh9vlT2?=
 =?us-ascii?Q?rQHAUY7gFvhNa01TPwrRD0kGSVWcinrIFhjIW6wx9LYCPX/FHe4L58F/OP3/?=
 =?us-ascii?Q?4d2GAE0ysBjJEnk95MkhyKU3vdlY2IgimZOKFvzKk8N1ZBiUPO7KRUjtDk5d?=
 =?us-ascii?Q?rSX+jma2g/RY8+/T4Sn3Xa9z5jP6MMFAzdLl1iuovVspiPty2Xns6jIJ2sWt?=
 =?us-ascii?Q?pWwxgauTk2L7TxsmNBKEc3K6eyE7UMRbKPfn8bbIF6566yOXeFuLfGhggPub?=
 =?us-ascii?Q?X3jskI24EooSS3VCK6z+LidE1Qdqs/x9FeCQa1Lg2Hag+4biMF3mUv0zbnfO?=
 =?us-ascii?Q?xM8SXQzy79TWz4eR86Vrh5ZMm3C5HfrJui8PDxrpvggM/r2ktSaZn1y4zoOy?=
 =?us-ascii?Q?1NNqL9VzLPmg1Tb34Uexltk7lg9H1uFdBoycVSjsyu7mHKblXwyumgmUPHYM?=
 =?us-ascii?Q?HRdfTU19n5VdVQzH7HarKuMvm5P4+3iVIsKchm0NJ4MsfaMSFGQp2SxENquN?=
 =?us-ascii?Q?EtPuBS6Pllqsl9ri26fRqWrHif92XW/C24o+UX7PapaepTaxUNa0e46wFSeD?=
 =?us-ascii?Q?ylyhExYfcpFo3Vk5Uw4U4SfhcTom1PvESYs07OcmHkzZG1mAXvPyzMRNbtBI?=
 =?us-ascii?Q?C79pYsNUvcsTUaWvX2VjuALPeHFjVO/X1F2+1iLQXWNclHELxUd1sEwFCsMo?=
 =?us-ascii?Q?5jTAOz3JSjnMMReC8auQ1BGTLeVzNBk0Z5d6Yza7h+7tgDMyQNiKE6zddgpK?=
 =?us-ascii?Q?wCP3S/cl1wPpEWVa/t/PL/Nh4u9gnSqv08HLYpFcbhP7TMWl+bikkVR2MIfb?=
 =?us-ascii?Q?41vu6XgpCaGf6MwTrkY5pXrCQav7R5eGyMwJJ89dQH7qeQT/W7BuMJ/9qfAx?=
 =?us-ascii?Q?c4CLmZuqEqG4TtEBJKLOj99EW8TQjAsVH+wd0jPWnPawJxuP6+2nFuHrg4Fz?=
 =?us-ascii?Q?jopKmgg4TxwYYLj9vhBRG/919HFL3pVFkg7kCW6TmvbHNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qnbRf3d5+cjt930Y0LOyslCJ54pbWZDOGtc7Tb10jfKViZNiICBvk0PzbrpF?=
 =?us-ascii?Q?i+ftkmPclBn0cUQn2Rp+06Xnwsmoo65WfUBHDExCKwt6dALfUD+Mkd+WwLaS?=
 =?us-ascii?Q?Ub608iDeZZL/kIB7kGet5BRgR2ZX3W02IA8DuCQSpzezwlve16lrhZe8ATbe?=
 =?us-ascii?Q?KaNydc62zsNlhQg6uAzSf+8njL53iju1ghuNn7H1zZrM/w8APnHPsTbxDwyn?=
 =?us-ascii?Q?IBdx34/ZGFtsrl6WY+HeZZ1O9nCTnq1i7gTEaXd/LEWUQT2liBeYqHBIIBXu?=
 =?us-ascii?Q?i2O8ufVTCz+06OndODSmFAKgyL43YmOKu9y6Z0J3fZHvImVvua1FzofbjxCl?=
 =?us-ascii?Q?yWPFT4L+ApsWZsOVk8Qho4muF8EsUXfOyYPtOLVOCyTBS9dp7VuNtTHLHCkZ?=
 =?us-ascii?Q?DuSwydoKcN5NoZsofXgBRg5Fag7Pcp41V8j1NrXmb3TG7E5fd7QgP6JJERCT?=
 =?us-ascii?Q?P8+kGCH09kMP1Ak+DuiKkhDsEidSmoeIq1E9TLh1XzMnHxbZKz8LJ4ZJO17e?=
 =?us-ascii?Q?3y0GF1Nj0vwgmo4qx0Q92s9YLKWqV1VVUtv3OM5AUmd/JfVJzySKzAVKETK0?=
 =?us-ascii?Q?uqIDme0CpCEA45rcdb/lHHKLQhVBZS06eXGxBos0qq3WEGjUg6H6csgE0BSU?=
 =?us-ascii?Q?3fm9YdekrqPYR+bu53CcKGe7K9hnWUoYcTnkfcwuqo4/8JK+A9P+adp+rUdp?=
 =?us-ascii?Q?CPh8m31xFRMVZn3+h28ruN63QXBoz6Ukp/xE+oQLsPQSTiF7UmyqzVmcDM5g?=
 =?us-ascii?Q?sGEWRFefTxB4eC+UUliv6TQRJrwAbKFgG3bdIjvJ86TBGZpt6Zf3vwzw+q/G?=
 =?us-ascii?Q?TUD9yRTDhIvggE9C/j+wcjdy5cdwda9WCFzOmaPxyzzfY1r4yZIumphTbc33?=
 =?us-ascii?Q?MvhM2j+Ek1EMH043Y5IcgLbWAT9voRpZ95GqG8gzgJg3KhzV7VJ6rkVLWBSy?=
 =?us-ascii?Q?oCRCHcSPleSYFEoA2NAPuCILKaXYIJt4/9VeyRd6exVdoEe2gsWdxH+rMT99?=
 =?us-ascii?Q?ZWaCeIXJ/7KLYgqyt7B+PEMys7LTc6SoMPNfrva5Uxq5wNquTq9PKTsJppro?=
 =?us-ascii?Q?/dvtKd0YAcX9qSnuE1qtS7YRgjChP8cwgub97RZp+vje7Acqs4N2JZknuHP5?=
 =?us-ascii?Q?EXWMNIv54nYS3TFX46T4Sx6tjYcfZO60k36hR7sIULLHMpi7btR9h01t/Noe?=
 =?us-ascii?Q?aweqcq8As4C4Lx2980umCmBgYMi/EB+L3aN039Bin+0vyYpyeDiJOtyEF+jx?=
 =?us-ascii?Q?/7ZlQFaHkRuq1XyAPzLLGg9qVto9KtvQ2e4YCUYVHYN1YI9AjqxPjHiIgfiy?=
 =?us-ascii?Q?LfmsFVqQrV05vvYKFmkWRR01LMUR0s3okqP3+DB4cwBztJhgGU8ivRqQZAPk?=
 =?us-ascii?Q?GlqwVz+Mp40jWMkLxAR1VabD5rtd5SXpRAPw9J5B44cr1nfNrja3O8Ha7GUF?=
 =?us-ascii?Q?9/8Oy4QV1gUDyoCUG04yc/AgleJvxWNDH5sFaHgKw/7kfZCvn/23WqZUfqeN?=
 =?us-ascii?Q?xmWCOCBPrxgKbJUhc/6eAZXRy+8syHH5Hl4VWCsr5HYGh1XM5v95pkTCz0Kd?=
 =?us-ascii?Q?OAoF/7QFl83JdQrEbfQbdGOA964fq0HtgxEESwSS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01349bcf-e350-43ad-54b1-08dccda478b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:15:46.4872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ED3NA1p/cb6YyhmDVszcfdUhOy8Aaf9Mk/VjDq2rwJNoaH1uI064rLtT9zPZspG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

On Thu, Sep 05, 2024 at 01:20:42PM +0700, Suthikulpanit, Suravee wrote:

> > There is no such thing as 'clear' in the iommu domain API. The DTE is
> > either PAGING, BLOCKED or IDENTITY, and any write to it should be
> > writing an entire DTE for that target.
> > 
> > I guess clear is actually trying to set the DTE to BLOCKING?
> 
> Yes, it's called from blocked_domain->attach_dev() and when doing
> amd_iommu_detach_device().

Could give it a better name then too
 
> > Also no need to get the lock here because you don't touch 128 bit
> > quanta [1] which holds the IRQ stuff that is racey. This is already
> > locked by the iommu core group lock.
> 
> Actually, we Need to preserve DTE[96:106] because certain fields are
> programmed using value in IVRS table from early init phase. So, to avoid
> try_cmpxchg128 failure, I need to spin_lock on dte_lock across the
> get_dte256() and update_dte256()

But who is concurrently writing those bits? Isn't it just set at boot
time once and sort of stored in the DTE, never changing?

There are two locking regimes here, all the normal DTE touches from
iomm ops are locked by the group mutex and they are non-concurrent
already.

Jason
