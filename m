Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB3B20823D
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082243; cv=fail; b=bt/Pe7UzVPq7YkIGwDHVm6wmQ5NpuBB+nZV/wcCcUU0CJPAxMguYTfI8Yj8t5dTJE6R+cbKztif6NvbXAzb1fribNtmNAchzu9DzlDRF9B533P/mdd+kKRb9jGzYNmqusyuAH+rsGmoUH7226YLU9P7CdYAuPvIQJUnZSJxsnZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082243; c=relaxed/simple;
	bh=lRAvCbgkh8VY8lpMajH0SuDN96fPt5CcEXkOHHht22g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ARbwQKOkGiyR4gmUvLuZOIpHWFxYZi2B88SL1eFTESXhYc7ssE0Kj24Yf0Zr4afVh/BPoLZPQnPjJwiDNyonsgjqXS03AfKP5hPzPNMUtVtYljJY3XSEEov7SUEzsZQ0VbgAtXdRuIroLOP1a6tn+JsCdpVJdJgIVo4j8r4TItE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ah5n4tBe; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ah5n4tBe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0zdcatZupRrkIoqBfjO8JTGALCpLgZZU5Vs6hAyPCz2TcYr6+4JawpzBkQ/2mpXD3F+MPuA58m1gZHiux57LlTsyVc4doSyi+XeqlpsZQMKXd78CK7EB25BBmPTZSbLeK02ryJ9XwdkViGkopzRObvmYUxS01BqEBsXLn3QoP7wECXhkn+mjSxVQJh6nCVHGnpjZ1cfrdBf5FZR3bPghFlUPafZkGEcDjzDMGptNUaR50XxqDjF7JdwBbZJ9JB+jNvicdBrLTYFVCoFkLUzZwet06SNTAq/MRqGSplWBbMrCqtwRqEaQ8kjdOAiBkWG1mW4r//eqrVtgQy4qWdHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjMmbLnNYOiNOW3aiLvYfiwr3tlTT3CpkQzci6KyX3k=;
 b=SPghuEZm3+5MqegRHDUxIlLk3TEjfmdgIJz9i6aAexcTq7B3QmtuP0NanYgxGYTz0I8I0DIQNhDVvitgF/d+UCtlBhdTgvc4WWk2DMyzuzNLaKNBlLY3qazsvZFs05Y/vCuWfRiqEQK2T9Bzj8CxzSm8/2qO3bkNkDFgxhL34grgWMhVU91EG648EqVU1Nbxk8MDHio7+1qhnGykSDmr+w7MxlXnLSPr4UoHAfwnJT161vsJinHhXsUtPnXRe08JMgJQgBGWqxysRSi1y/98Q+cywE9+QzYS8XjcankcRAMVv4PYluy7hj1UqrhE+eEuErt4EKhJfkPhPNy+QyJU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjMmbLnNYOiNOW3aiLvYfiwr3tlTT3CpkQzci6KyX3k=;
 b=ah5n4tBeJZDkcPMw7vuILlOFn5JeDyLqgzwCTjoM+a/xgoDHnBzI/3bkmt7HkGcpKGToYUpwdSZIzUuRVgNtfLzBsP72YK9km19I9J5qLrkV4Ryk3qKH//ysDEl2WC6DOkCclfFQ3ei2Msa/qGiADiN4A1YjLTjzpQR8MWCiKe0Vp5xw5o7SRHeq6rKzjN1+uO5iIm+5moDMoXmuVeB91Gpd/Ecr7qMZ9dgsta47w0godrnq8v7zkyzN0wBIAyRKrsXCUnQnLYuJp/0pTJBpOib3fevSgNTjXWmM4VTPMdT4eCFeIsTJqaxabdKk9g+NBQxN2R08H+eBy1ySe13IXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 12:37:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 12:37:18 +0000
Date: Wed, 16 Oct 2024 09:37:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 4/9] iommufd: pfn reader for file mappings
Message-ID: <20241016123716.GF3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-5-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728067700-32092-5-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BN0PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:408:143::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e23be5-4b22-4d7e-2d38-08dceddf4572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EwJO42gB+2b3AYRmV0Z4cpJx9/W/Wc3dE+vCV1tNaZBJ5F1N8G4zrp2jLmrz?=
 =?us-ascii?Q?lecVY4fsFPapQPXb8VzeD7Bh8lW1Z1gkbf+omQzQZoacPHoZvQHNt6gdD0ga?=
 =?us-ascii?Q?ub81h5IZyXvQXdNqECAVATLyoU1eh9aQ8dSgh/N5djLBLWKyn5gSRG53YHCk?=
 =?us-ascii?Q?h5nI1mg4A07qtVBPc5i7N4q64w0d2YQDM/6d3Qa57gk7HsjT8BFl2jobgFHt?=
 =?us-ascii?Q?oP5+BHk+q5YgAVBvxORDKw9gPSj0RKp/G2oKpR7h+I1eOxftWeWPwXOiF7id?=
 =?us-ascii?Q?adfhQSBu6Gn0Zl7TyKK3mh48xnYzAEcICbgyq9Vzc6tJsXnJmU6M1hj9xWZd?=
 =?us-ascii?Q?vdvnaE4MFE7yw5KcCKh+gs/DLUwkTvYDqsbxjZxsX0fUeXHOrxJ9jPOHEust?=
 =?us-ascii?Q?hWfb5twfKdXxIShJ4/a/sQBW+EmmMroeFHvVjc9NAHlpjVlbIoP3exHycqMf?=
 =?us-ascii?Q?DVe1SQgCwcl3CIMS5WBbYi5/l1C5miqitdkDKO7LEoewGipb990RdSoPlkeA?=
 =?us-ascii?Q?67DcE0TpVY4qJZi0Sr8KlUPPlGAOF4hGx63JS/dRvDTNOHxw4cWeJcOIL4iU?=
 =?us-ascii?Q?H6C9aWix3w+D1xpPJJMXd6c9PRyL33C+A/sIhN4hSRvsyQwwalgAAKtAQQZq?=
 =?us-ascii?Q?OKo7JgtXjpZRjN/ra2MmBnL/BGDBL0CIBWDV7LKvCAKgaiYKDQE9cnKio1L8?=
 =?us-ascii?Q?CcOopFBtYc9LkmKutaTaUBhdmbm3LbZkuZpxdRFU7RykqPsm+ygbqm9LkJN7?=
 =?us-ascii?Q?3RHJYbVwTEmcGrMFlB+yq8ImkOubWDQun3wu4DWueALRCUbf1NotvEopTsdK?=
 =?us-ascii?Q?PirvBp6/p48iGR99JKHU7dTsVf4hSGbDSRz6V8PrOpzrT1Zmk2eqrGyb5uWW?=
 =?us-ascii?Q?Q7N923nT9GapLukgTGDM49TxXJ3HH8BHhb6GvZn4tCUmsvcR6HVgzl8enz4O?=
 =?us-ascii?Q?fkuf/LsYK2jXfGMa/lNq3dsj0UzHfH9zHSAfwT00n/QJiv3GD6jTJHGwOega?=
 =?us-ascii?Q?gnRuMZlV86UHIZlFZFW0mai1V1s5oN8G63gfQSpfd1oz/TJNCkyVr0uo4qDd?=
 =?us-ascii?Q?QTtfpn93vjADE4N2TlB1SX0LGANhsApdLnbAPPU9BDlX1UqRizzd41psBf8b?=
 =?us-ascii?Q?vGoqnmJcqk9joaUBIUNYDBmEDl4ercAWV2Ihy3BIvYxqNU0FOqKnhV0O+JYJ?=
 =?us-ascii?Q?Vg2teyfKrbJxJzkYFBBOGOY654K6hAukUbnKa7I/23QS85NotqGQiJbalRhz?=
 =?us-ascii?Q?F0I3PKlfnRRshmJHP004H39W1edWmdvvIhiX0Ucetw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oIMK4QZcopjijwp/CEMr45XDTbCylUylNUkb+ETceuHS4LDtPp4ema6J0ATu?=
 =?us-ascii?Q?/x42piNzEHeDMeuZoh8NMKdyuIIhXifVZx74hojck6ZUbGMaehCPv6YBMIZE?=
 =?us-ascii?Q?OXIjidC3Lpbaz7n/txwzuHAVN3RHDmMvCnAO0vUKjShGnh0iQRaQEkkG4lV6?=
 =?us-ascii?Q?vu70u2/e0EK2hCDju0lxWag/G9leumxsJH6jqp1+SVwGLTL9QSmILEjU/gjE?=
 =?us-ascii?Q?lfoB/ZYgeY3cuVkQXf+Yas+IipSlKOlwZ5+yy7+B1EdJpWfnkemwJ1dpy+10?=
 =?us-ascii?Q?f9roJK4Dyw6CgokOp3kp2PN7JZcx3/rCMK3L3nhqW7iY7dkxNaGNqWTO+yOv?=
 =?us-ascii?Q?xezBG3UyLg2QTT/nuJbMcTsQrNYKooXzxjvszFeeM/PjhV1AZ022zBjU9ILs?=
 =?us-ascii?Q?PnAWpeLWkVU06nAUtLH0Y9XkDTWQj/LD9iMm0Y7J9XiatGR9fYuJ8HYXaPDB?=
 =?us-ascii?Q?6lJNGj1MzSPC/ei4+mxM3KYxONcMULbDZaHUB07IuPPGFhw8SV+Fl0XOTZiC?=
 =?us-ascii?Q?KUxPkvK7rgH4wuG5mSbTeEmHfepC+K0TGBGMz5hAbClcJLPBNpR5/961Olqu?=
 =?us-ascii?Q?FH2Q6hU5TKF02buH9uulEyoPWETJVzNJ0RkrOK36R2SLRVntlxBJ7TZjoM9j?=
 =?us-ascii?Q?kpXD41ycLIieYc5T3pT1BX07jQXwuSKucJkmVFwjk5Gyl/j3o6oVlFFEGQ3u?=
 =?us-ascii?Q?5uO0/C1j7Bccpo+rYkJAtt4pHrGCIe0crfpA+6GAsXym5v5rdTQZfcP+YvuZ?=
 =?us-ascii?Q?tlC8mjr+dV/EUp9pltPhSn/cpvxE8xqYAQQyyIcDvgzvHGsPcMCA9kmydAxo?=
 =?us-ascii?Q?WP0ij68P3JLBKC3zPG9FmkFfljhb12cFTB28AXzigqEldTuona0sqLa86jWV?=
 =?us-ascii?Q?GVX5nIpROfsuGaYbfULovWSwRUSf1o0KZSlIpBD4Igpr3ub5exPeJbxR+HQk?=
 =?us-ascii?Q?/4HuRQV+x2g+sH5vxf4O7IG8PXQwUL8IOctJWavbH0jzHCOSeBdX+ZPVRCbg?=
 =?us-ascii?Q?94DmSA3AaRDK6Y3Mjly7dRV3YS8uOLM3J30Y5O5abAGC3DGliVvmOOgwzEBH?=
 =?us-ascii?Q?u/EtC7fDnrF2QBPp9OHR4BzZS/uk22r5B4M+0JAi1Ig2eoyyEhoZA6YneDeH?=
 =?us-ascii?Q?Fa7HjSztc1CjXLNdOteZHzzw1BIBj2qCvxx5HJiuhR412CGQ8UjybgEQT/Rv?=
 =?us-ascii?Q?RlUH2LsNSiOWBJc2M/2yq5HWBM8FDba1ohNf/0gHasCVJB0KO2IZKjQ2ZjHU?=
 =?us-ascii?Q?ake52qvbDOSpQi/AOUvcIfmy+adTaNn9ymWudU182yfn3c5i1LDn7BGhU04Q?=
 =?us-ascii?Q?KvTyj93Kv7JP4EvOWNjryth19AQ0saVeM9cs3r73r9ekgZBaSOkaysEl9/vJ?=
 =?us-ascii?Q?EhQzcR3tDpDaeWjtsMqdE2fN0m1yWHengDG4Ha5ULhIBZQ/L6YNWLMJvgmVQ?=
 =?us-ascii?Q?JCdUaWBM62vI2GLZAbar69DVTtb9vVo6yb/UsFltXJOZdhUAWI7scLoMftvg?=
 =?us-ascii?Q?yLANi07O0UtTuMKCoPRi6pKY3uG24FTpYopwj1TKrRsaujrZ3GZrd4VLv7cN?=
 =?us-ascii?Q?uvsqa6LQi/YnNvVcQzk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e23be5-4b22-4d7e-2d38-08dceddf4572
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 12:37:18.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGDyh5JahBkgayzSKtiD0KaKwlQeGFJRpzf8hqadg3wHhpcwkU0BgvdHRoxYA195
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551

On Fri, Oct 04, 2024 at 11:48:15AM -0700, Steve Sistare wrote:

> +static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
> +			    unsigned long npages)
> +{
> +	unsigned long end, nr, i, j, npin, offset, npages_out;
> +	long nfolios;
> +	int rc;
> +	struct folio *folio;
> +	struct page **upages = user->upages;
> +
> +	nfolios = user->ufolios_len / sizeof(*user->ufolios);
> +	end = start + (npages << PAGE_SHIFT) - 1;
> +
> +	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
> +				   nfolios, &offset);
> +	if (nfolios <= 0)
> +		return nfolios;
> +
> +	offset >>= PAGE_SHIFT;
> +	npages_out = 0;
> +
> +	for (i = 0; i < nfolios; i++) {
> +		folio = user->ufolios[i];
> +		nr = folio_nr_pages(folio);
> +		npin = min(nr - offset, npages);

What happens if all the folios don't fit into the upages array once
expanded? It looks like they are leaked?

I suppose the later patch gets this all sane, but I wonder if we need
this inbetween step?

Jason
