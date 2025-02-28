Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A5280A47
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755877; cv=fail; b=NTL3Qq3JVjdS83RvUyGA4E7m2tnUWtgziJYIrDs4f1KzcAQKLxgVqcC92mYZ7OnljJqHM/mdIFGQOlMzA4asE6OXRKLt/9bg7ODzJOdnTCnjwndNS/X3vh9B5HJmgPTyhtwziUSX8zKCF5HT4A21yvk0opA52qJtn3tiU2A+sLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755877; c=relaxed/simple;
	bh=AgAmVA4rH2K87NKBkDlboHJaoaOE2LAtOkMhNBv30v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ppYNFFbH69S9zaqfwje+HZBSCzr6Yy8oRj79fPi+Pembd0Gpl3e6coaCTyEpwptFBW46LmZc7eD2ENH42J4S3NomoaMQOSfFUzFzBmfxk3yuCHthxASssOhqZtCY1VTFwS5PSq4QFPVinIWf/6V8T95DmgmLanG1FQJyfLInw+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eB0V6aFh; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eB0V6aFh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXJC2tURqnJajtbfJkVg1nIn5V9tdsiwXkvUD8csw/7Nzhc2zgCpcA4dkbhDiJlOY8XsrI2e3mvWQP0CV4Vh760OcfZD23aMIvTcjFtjFLt/tCw7bFkKTMftSUvT38+f1fQBUUXZhvfTsj3k/6yFRLbq/osROloZjAoXtrXRWpgzS0RioRzk/sxRovRvX7ETqOLLlZj1j1YvGXQ5vLDcvIKOIuctubRc+0zzEPLNJAKjelFmHgqm9F3r+7Zfh9gM0NcvGjIFa9jdNQZ85eybIN3oNE7rCh7DkPc2QS8xuO+yGvgE6v63Mp514YoozIZuBJvuctZfrXvffaN1KO9DpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UmLqsX7sVoCC+xVJIVJUoIckFifdepNSdofP/xhwAc=;
 b=DtpqdqgWel9bx++7mAbEfaJODFz7GtK3SjQEXKe3g93zByKZwM999bKLiyqm0+xKRRg/GjiJw/cQ1wbP7kMgChl/hgoFGqMCTx21wTAx9+/LsFfVocYUQWSOSwPRl8312ukN7Fn/3LWRX49Amg5R7Z+rRM1aJOlA1ziWdpKi1OpPz48s/TDM7x4cPwq4//hw21e+SHtMTUuS7IPG4Szgo1qP2CHYahlAZ5Bai1apUzpk+c7BQSvi8IosiJ1TkLagWZ9YpQq3nJbGCYkUpPjBBF4ML9urFeOcUeBcBCBnJcA1ayeShjB8w9QtHtQWOfR8diD06AWRzdR3rTsgSEIcaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UmLqsX7sVoCC+xVJIVJUoIckFifdepNSdofP/xhwAc=;
 b=eB0V6aFhGr6nlptSBAdEuw8qHsla/qO4Khoy0mSnLWB6VIK1yWtbFr9IgxwFARiJEFW4YT/iSbP+VPpWLkSSHJxEYPamcx+jiRfVzbEbbxeynIEj7CpnJBNoIQrdJadalteWTrEEKUW7wzmt+OBq3aVHJ6nsOBuxy+yk4jcvt01ZQG0wo3yq/0ZivHUGxDBH6qDeoIqb3+u9B63mRrNWstICtOmitsjkLqXpoXI8ifgf41cgrpOuMGldSbQmyrN1RNU6VylwGyg9dJ6LpREq74OJfTZb0B6WvJQwcvXpA0gEgjabID8nwU5o5sT3gZ6akkFRH3yCRNxs4RLFXph9Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 15:17:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:17:52 +0000
Date: Fri, 28 Feb 2025 11:17:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
Message-ID: <20250228151750.GU39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-2-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0268.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 51087a38-9721-46ce-2457-08dd580b11ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xM18eNu0CtO3rkHcuaaLP7+QZH9VZJTzKtMsKkWifUxy7x9e/LRHsqaS/cQl?=
 =?us-ascii?Q?/gIN9fYGA8BKbOss7K2deDpYcYc9oLV6GqfbQv/hWYStUQXdHysMWSwAFzou?=
 =?us-ascii?Q?1WaenorfGZU4cOL8qCWRn2mAU52eMq5B2tn8S1RD1WL3ZpqKqvT2h02aGnbD?=
 =?us-ascii?Q?CR5kE1pHrFo27sotl9A9P6YIgE4JdHk3uKnk6hL6WlcLlndvzt1FImaA7fNh?=
 =?us-ascii?Q?SQOdvLnFQtc7MMAvvD2BEFVxKScz7we7laZ9DRjrMuUAJ4TEwrADW5xJzhcd?=
 =?us-ascii?Q?Z7QK3mXH1NRcrPk3eVYgDfGUhInkB39xYjkpuktHd4q9FNY5MUY4MmSDlf82?=
 =?us-ascii?Q?YlzzFvslIwuKVMz6qXBz1Oklp0Xn3Oy1i01Y+yIdfCkmIuefEEQFD9audPHJ?=
 =?us-ascii?Q?40WkgKMCQwhoJT0yLdPGBtOr/+hQFgLcItlHAs/8SWnuamyTzCXe/6xIA3V9?=
 =?us-ascii?Q?vpgpjCaQMMUXo65dgzzvmGSyr9h5bik3dctnQBRyKpvLySdR7LYUZ0pc2A5n?=
 =?us-ascii?Q?rnxbiIcd3mq4P/rRSBLJvmKtUklwCRai9ElV865KGbvSQ2FOA5gB5g9OYXDe?=
 =?us-ascii?Q?PyH/bVyWDmbc3rahkBYLLMavYfvKv41FP/vACQy7+zciKY9sohjxhQvst/Tv?=
 =?us-ascii?Q?tVkhxkKP4oaYC5zYA3cdyxSm23H+ZE/07vAtiPROL44iaF3ReoUya74Mudbd?=
 =?us-ascii?Q?46hqDhhMUcgc1vtQCHVBKkIy61Zp1KqDQDZzHCOdnklL+K+8W10mQOIWYHT9?=
 =?us-ascii?Q?2ZxNGwXL+VH7YaBoN+yeXaDgNNoHzDr8U8pxjG46vZ2DrAP/Evhr/Tt+4HR8?=
 =?us-ascii?Q?CLtxQGQnHS0XUtHRcWl2RWNflpqPH/I0RzvBEV0u2QSSooVZxaQqkkmkmkeo?=
 =?us-ascii?Q?bWaWf4don3clM1noMx5jrEdNv3Kx8CsaqEUAKxh0DJNzB+O3Ugwrdn57jz6N?=
 =?us-ascii?Q?+8zJ+wNkIhVCfoGBfWi9xeM0TICKe4CMBnYnSNiNqPyHXekwXFvf1+X3zXT1?=
 =?us-ascii?Q?CYgfsOcUX7l0HVBsZlQKuER3rAwgnje8KtmOf2MxAnrf+VRnoxPJdndFTF2/?=
 =?us-ascii?Q?Qd/wsflqx77fouALBlP48RjdzzHE2UdU/LHik3UGvAUs0HlcHBM9pH6CzJzE?=
 =?us-ascii?Q?4fWDmChbiaSTEccyp6CDWHZ8csoW6Gc73J5H9lPejo19btoSxPcCcGw+P8Qh?=
 =?us-ascii?Q?3Lfw4pd25bwdhju5HRnfDGidJrUmbWBhAcR7r7a2og6z2R7TJrCGiFhbRxUX?=
 =?us-ascii?Q?W5tKggmjbXIU34tzWFVPE7hlQgs7c4jq+NiAvixSGItccT5uuAY/yVEEfFZv?=
 =?us-ascii?Q?Qh4CYdsAlb3h/NsQTqGw4I8lAmh8lmNTxfq43eXBMdc0e40ZuEoF1g5gGRIP?=
 =?us-ascii?Q?3laTSNhT5p2kF5F+YP6yP9At2o1y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mpjXSVjLIq32WzZWpO0KQGSAwZlqBpsBzpmN9aN6VLqi+bT4emn7HZ47nGiY?=
 =?us-ascii?Q?B4kz+l+37uQQ4t2LOM5GCafDt6Q2RVwh95tKZixPRjeJWq46h1eDZL4Map8j?=
 =?us-ascii?Q?MvuOIHkEUSmqFDbJ9IalgsEXhkS6Ko3cR8SpnJyXYHDxsHhp8oF14S0rKxpP?=
 =?us-ascii?Q?xVCEf08lY8dh75puLMTH8s2keIvq52LOR6BDtqRX4B2L3MaN6fwQdjFUHs7P?=
 =?us-ascii?Q?2CzMeTTGNY3QTUPIOqxxRYnz6PJu0h8FimTmsaCZ0WuwCA4J87FMXrBVB9TC?=
 =?us-ascii?Q?rFPl8xhyLV9ZRNVk5aBVA7qxPmj9GE2s/IOTW/M+gANgVgaWWWJkkXbMH49G?=
 =?us-ascii?Q?zEzQ0CN9COQvCoRbw1f+NDAQqlsJ1rxbdb6Jpldr4wdk8nbIz+qSBF4its7c?=
 =?us-ascii?Q?YzRzP0tmklfcWf/C6ycqM72Kv+Wj9vf4+8vgxCb9FIuJyQGlF1yz4ZHtv6JX?=
 =?us-ascii?Q?zQvAorw9NuXx8tANM63EMv+mq8Wa6NloM8tw/lkLxQcwIWHbo/xHi+ZAq/je?=
 =?us-ascii?Q?ll8nULXifUbC3RX1GGq3WJ91E0cEOYeXmP2Y/Xkqmp9qX0ZUqfzK4klIe5oF?=
 =?us-ascii?Q?ECTbmgf9gnGStr89SngeJxi4jRgw2qVCm1SjNcoLeXH1PUK1pYdIlWdS359u?=
 =?us-ascii?Q?BGIRGiCqYkX3ddx0QqzW7UT5BrNpUhn2ePNW2vV+R+RAzgW3jmVCGDZuz/Cp?=
 =?us-ascii?Q?4sdt/pI9bHZ594eZMiUQR9PcQ/l3VFGaxPzige19O2rAH/H8bvHPF+SyICSi?=
 =?us-ascii?Q?Kd7bH7l+V8hbroxqT1Uo6J7WYSRcEKzt81KHzQyboFM+E+ZkUQrQff3wgXGD?=
 =?us-ascii?Q?HpoOJb6ksZWcqQjvKBWQB3V8FYOnODPHJKfF+DqwYH7rcaRvIDw8z25g1lVn?=
 =?us-ascii?Q?Fn9D2tKNSxTDtJl8IHmp9PUhvODtaIYQ0/v+bCUSGvlknwKK84H2REb0PXKy?=
 =?us-ascii?Q?+15XS2JR7X73VAqcDjY/dW2D9SHmWDUXeDWyADbswEtMk/vT6QWBV/44rvqK?=
 =?us-ascii?Q?F1adjbMkpAdzxD4dd0sMHZCSzyspDtA6bE5ysKmZEa8BuT2i5dMIWORRo1MJ?=
 =?us-ascii?Q?WWrIRpOHSgBWPOGRZYFs2EZKf1ePrNMww7BVpWREqbctcQSw8/yayPTNzEKY?=
 =?us-ascii?Q?mehs1rW9LHQfKXDy7fRl7/+GZHNbaag8rqVath2sKxiQuiteRzOGYNiKzwZm?=
 =?us-ascii?Q?7Sr8X9R8+VNQSLzo66tOH4GMVZfOfgVucV4fciHY7eQDs2+qjzmL0UuQ/fhw?=
 =?us-ascii?Q?b2295hlIUzzGL2kKOaB+rz/Vo0SkW2g3d0t0g+6IegA49ek3SDKEi8yRPVmN?=
 =?us-ascii?Q?Aa0CUHDZb3ndmi3pKPd0/3Ggpiv4uBg8P4NZZ0tYXDi9r43G3IBeHZubABSz?=
 =?us-ascii?Q?VZ4rxPEFCq1bqZO+aqYgVazmFdjtUNz0PgR2nr2su93tGvZz5puVA/goe9Np?=
 =?us-ascii?Q?YNHWog7LAuCYkRtRaKk8hGG8G40/BMuq3bopVQS6QYnyGzjTajdwUD/uzrLF?=
 =?us-ascii?Q?j/wNQMD0QZsz6kxt4YUpV9WM+0m+AUGVLKeXpQPAQSKAApeXROjJG00xZVAX?=
 =?us-ascii?Q?FS66jjPfqRdgot5SlNhPPz5CRYSRNDqcSqlf5vLi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51087a38-9721-46ce-2457-08dd580b11ad
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:17:52.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnvSbwQg2U2Cj9DJedyzGRE2PmKZqv7BSuBf/yqDhCG4C+zt9ZZ1JJ7oO9Y4AGaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036

On Wed, Feb 26, 2025 at 03:40:21AM -0800, Yi Liu wrote:

> +int __iommu_attach_device_pasid(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t pasid,
> +				struct iommu_attach_handle *handle);
> +
> +static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +	return __iommu_attach_device_pasid(domain, dev, pasid, NULL);
> +}
> +
> +static inline int
> +iommu_attach_device_pasid_handle(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t pasid,
> +				 struct iommu_attach_handle *handle)
> +{
> +	return __iommu_attach_device_pasid(domain, dev, pasid, handle);
> +}

I think this is the right pattern, you might add a 

if (WARN_ON(!handle))
   return -EINVAL;

But it also isn't really necessary since the API works with a NULL
handle just fine. We don't check for 0 flags in the alloc path for
instance.

However, I agree with Nicolin, this doesn't seem well justfied as I
see only one caller that passes in the NULL and really the only value
it brings is to save that boilerplate

So it is fine as is, but I'd also suggest dropping it unless the rest
of the series changes the reasoning.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
