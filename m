Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC621E47C5
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498960; cv=fail; b=KsmSnr6F976BY8VYpA6FG8FYQ3Gcae6TYS+Lk9hB2Y4ztO0I0Ksp4W+9wqac6oQvNIlK94v/S0M+YXRH0lr0vKbRx0gdcqJkfS+PBa1KaNfJYEdGLK46liOo3euBpLEuYTI5d+gQB2V5OL9Df4+41v6vTgdjorudHao6YKK8DQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498960; c=relaxed/simple;
	bh=NIMxo0K80iTe4UbljKxDqwBI/9rEtAlc/SU6GVY7nUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lMY9Wk8lhJ4kHCL1p94HI8ZsLRpNqS2qpiH2u7AdJVHO6b5lPC/n/5SpsSSjwpDMppy0a8v7O+c/pN3uuU4CC0x2SChD0CDVJkvoOoJbFiwTmksTyVUoKRajAvUbCFq7oQLjZGN7NKHwWFK1QWEBdH2rLLfWGivDHV35H/xtO7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MpB+Ddsm; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MpB+Ddsm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNJDjzTw7PVEiTaVecUwtZvOZ9q3Y03wFDTQHrf7ptssaC7oeSE41sWxwDWF0VMC/M4sWy/NahpU560fqYPUb6JsVgfSjI0dacQD0Rx6KyvD75ObFVXHVei9bMxQsbP/IHh0ma8dXK8txBWnohzoG/iu7JtDkcJeGlaNEDeVl/tU3FQI9Cm4il5/UXOi6NHntB3Xg5otP4098wvq8Mdc9AqCohmKcxtrCCU4OfS5jDS6N+QRNBAEjhbSHOW9BMpm6ibcEkQjQglZeqEpYE2H/ESr9nOSHaVlIi7/538gEkgR7eAzujVr0ooC7hvM9BillpVEDODs3KzL6p5dM8spQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itvlhC6sCWgPrP15P4LHAVl1s0xhMAQtLlMP9Af2q8k=;
 b=qYlIen/xUVBbdZnzS/faQ+gYHpneqBRXH2zGZofSJSaCcV5RcSsWbCCqBUlxIppz9TgRg28sUKaonJQGcNPOTUFNTagwADbNWXkcsNNebny8FF46gt8CRtcDprqmh4CsVDBZXZZfpnbC/R7tduVWQDohkj4ipO1qoL18wUPYQTW3hufKUfvLkWaFxRfTAQAajKmyDvBdDKx2P5LMv5pPDwDEh/dlL+1KWenjVi43qt7EHMckq1FoquXR/fTIGCAg4B/QRCpTgH1TR8vya3dN02o2pjNMtOG0nxn0luqXIdAzxR6E/AkOJJNLJ0VcTMD3NWqPrRPPifoRHMg4PLZ4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itvlhC6sCWgPrP15P4LHAVl1s0xhMAQtLlMP9Af2q8k=;
 b=MpB+DdsmMqHb2xsrLoSCtgrgP/As/miqmqdKkDzGhYkpnjwhV2FC8qxgpaj/OYnkllMxsBNnBd9EfoYB2tyYTyA0hrJO1HDjTWi9MFxjsnMh+ZBUMw/H5KN9pwc/Xu4HWmYsmec9jr8ICIUNAmWxAW1A3g8qwS5L9OLkldw+Hn9setIGaWqgOduGgCJn583w/ZeF2q1jA3gLAXx82eemsq/BJcqpai6Jr7IslrknT1J7X7pjwR/rR0aLoL9UyQxRiUbMhxoOtLVtwjwVFsn2lpLi55ptREX2+jSIAMT2l4Iz46TghTVAEXlBEg/nAwLwYjgXb3Sr5MvYLlF7jukGpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA5PPFE91247D15.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 19:29:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 19:29:15 +0000
Date: Thu, 20 Mar 2025 16:29:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v10 09/18] iommufd/device: Add pasid_attach array to
 track per-PASID attach
Message-ID: <20250320192914.GH206770@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-10-yi.l.liu@intel.com>
 <Z9xqRS6CHLnPAT2w@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9xqRS6CHLnPAT2w@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0337.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a40c75d-50e0-4372-c26c-08dd67e5803c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tKFwTXLrTObrOlkqLO10fn3ExgKX8TvlPv+TGGdQd22Q2/ZLRtNfY6CP32Xv?=
 =?us-ascii?Q?iWuPX2IP+B+Fq6Y+n5K5O/LKFd/trrtaaru5WJ7kFwHxSn6h3oCENla5QfOt?=
 =?us-ascii?Q?342zE8kfPYmGX3bM9KsF62i991mqffFFF9BZIxSFZeHZgvaaTMx/d+WqOANK?=
 =?us-ascii?Q?EqaPFWddqxXGEVLlp2wDK7QGkoQVt8lu6qXLS9Q+kN+u9UkZwm/0LzhUs9r5?=
 =?us-ascii?Q?iPBG0Jfy+KJVRX/2Egyd4TKe1lkqYrje3hCYVOIZSF94vrOcoPtjqMVazeB6?=
 =?us-ascii?Q?M+ND74OwLvf4SZpbNcm0Y0S3aRMD3jkttOiTOzYoRpMO2XanYtt7VBGfhXQy?=
 =?us-ascii?Q?pocc35hrHQB4wQLoNTMenNXf26uViCjuFqBxsyQGVvsPkdmW1UpqP4aXEugW?=
 =?us-ascii?Q?SXaFj6/YRBfrE8jU2Q5QKJD1M+oPqlyfTV4sh/f0xVllGU81oSZW34DNlnvL?=
 =?us-ascii?Q?14xK81uAoHDYbmrN9HJ2pFWzCB3GqMmF/9iiCHTy5/qQE44N/LXmJwUtXeWT?=
 =?us-ascii?Q?KznswnDKmshzx1fWi1pm6wyNuteE06OG4Klfa2dFzvkS0uVL+8q0fjjSJBcE?=
 =?us-ascii?Q?fcYJQiMhAlRl4I5HHSzDP8N/AGZObaykhx8CePiyx/0tazR16juKUwB9nJ6V?=
 =?us-ascii?Q?Dpv4K6ppV/YzUXE6A84hhgTqA4QTwmLIzre87iK+tglAts0scr5Ndz2DHIGN?=
 =?us-ascii?Q?sBoJoIx6K/6eLQJFJkkvsu1RgoJL9JMMMZQ72bjDgGsh/fuMOA8sktf9qVrU?=
 =?us-ascii?Q?5YpT7IOrSjK2ZeLMVtIYh1X7RCGZcSYZrhLA2FZQDvuPe+uwNMgdUf7iwR9q?=
 =?us-ascii?Q?Lqmj0OFEdmteEhzn+JmZq2Qcp7a/rSCz4h8WxQcnGe4owxkr9/JFsjiV52QR?=
 =?us-ascii?Q?JgHaVcBfT6kRa/77JLv9iEG7/TDh9cjM7ooufcGKnBBDXeZodwANaar4ozKQ?=
 =?us-ascii?Q?rJfS6inMRLvDNAtFl+BlBQtrPDFTLc9eVafG1sgrFx20TcF9kPjlrJ+BWa9f?=
 =?us-ascii?Q?GsDELhcRNZdq9wwMceTPanuoeCAouLhCnb5qYwbrKf5loZ0XvCt5a44eALQb?=
 =?us-ascii?Q?roiIx6gEZxu5ooQGLDHhcLj8ujf98DQcDMi1lqzfS6G4DHnqfbtwHRJGq+Ea?=
 =?us-ascii?Q?lhUg0t26ABWggdnfeWK3CcEG0x8IsYlEkfTLgF9ZJlL9u66yF5KGnL3vTAvM?=
 =?us-ascii?Q?IuAOhbCQ5HRCtYdyGjNNQpb7oUh2Kcir/zkethRM3TI3zEvMr86mgbG8ao3c?=
 =?us-ascii?Q?9Wjvm10L7mApsSNV9dMTv9SRsGpYcxJqZnRfyqCv23E1hcHC/HAmxbsUzc7i?=
 =?us-ascii?Q?WRa1R3zmKScDx8K3gWaA4istezGtPAZVteMn6+QHOAsHSyD7sAZC6IWvnCur?=
 =?us-ascii?Q?l4kZ0qt9rZ8xsGVEOsbbFKjDyjar?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adRznaOXFilxJsnYoopZK2dG9LRsgRzKLoscAdf1HJ/GqlciEJvCPzfUW9HX?=
 =?us-ascii?Q?VYIiVhEZqHGYvYCiXi/VzOJwU0ZV9Y/JcWDRnzRtxsxw3Ak5iAm1PzkpeucV?=
 =?us-ascii?Q?Al+vGdFte96md7QI+WeWEW85HyzTDFVIICC+RyoWzwNvg+QJWyq5omWmVGDJ?=
 =?us-ascii?Q?mJ3m0QJVXIE2vhUym1ChJp6Z20H+FGXxEmYTU/JDWf8srQA23jZ64uHJUM09?=
 =?us-ascii?Q?lGHnYYRoYpNAtvtrURIW0aIT18OGqLwUX0VTgStXvNiyM6vNKYwUwH2jhM31?=
 =?us-ascii?Q?A5Xywcw7fn8gMzDP43AVVvi7UwmQ9ilnnyauqRh2HXd0doU0ezoaHUXGO1QX?=
 =?us-ascii?Q?KHYNek+8OYbrhOb2pQ2hYrRMoJAjFk9krX5DB7K/QWeNAf6gswTXUXkMoDcJ?=
 =?us-ascii?Q?a/ICXW3y/0Wh9u25dcoOacQvohzmgZ3pbkLa0cDctv6q4M7VciSz7aL92bGS?=
 =?us-ascii?Q?Xz8H4B38kSt1/4njHwSeAWsS2cLGloz0qGUqm5XY1bam4X304wiheqO2oRy3?=
 =?us-ascii?Q?MzfVYxVeKq9D7m56DeyT3bMeSpDvk9Yn1fzdyvQLs5Bq7Il17cG/42m7JMql?=
 =?us-ascii?Q?BxvFocMaj5VziTmjYnfKnhJNeQkMRnNR1CkuGWZsHpH/ZuwQiDj+edwUkXZ/?=
 =?us-ascii?Q?tZspfXsVQsmATgshMjkaCD78w4ypWvOPrngYl/+59+0OqJaxuJT5N5T8fQhF?=
 =?us-ascii?Q?CiddiVE1QEH7vTCB4/ADlSrWWs1r97pfwMqkpggG+JYCfaEBHSCeCTt/MGln?=
 =?us-ascii?Q?MRXQOB1P27CF20CsqHCbO1Da7jaySRKJkMfN+2mg8ck4zS/Ry1NPstQvCbDp?=
 =?us-ascii?Q?gz5N3PJpXiaAwgO8S1F9eCqJU7jCT1xl+plf83RdWrN4ufqP1fUGLrjAc9LN?=
 =?us-ascii?Q?zt0dT6dFDQEKnqFGv6SaFJWqHAc5/qnIH56lRhBF5ToVxes+PJc5ThWuz0s7?=
 =?us-ascii?Q?q5XhEDuIxn1rDPzhVlRg0zp0jyNCM+sQpkqJoNsjuRHREXwcEk2bsLgo957V?=
 =?us-ascii?Q?Cb2EN2eA2JlpSI4eJvsPa45uXcxUHyUS/RkZAP6FuqDwbNIouDtXyuQDC5ZY?=
 =?us-ascii?Q?4s/1BKhrmjKUPbPg3Y4BIFrWXPR+axOw47ZwhLFZi4uAC7q9M8sehCA7dmAD?=
 =?us-ascii?Q?TGNFir6oGDfqOK4wZxRnTE5VfrnmLYoz7ym2F0/qrAkIsFfpUWRF2qyBN+LG?=
 =?us-ascii?Q?50HuEs+BdpKye7JfW0HFpJeLIMADhhbqkB9vewCNz1Ijd/rrV49Q+R/YRedR?=
 =?us-ascii?Q?m9T7OOldOttrv+Gt3ml6r/jXXz4h0JWUJLlwf0b6JwfgLhN38ejtwjDTP6BL?=
 =?us-ascii?Q?pnPh+/si5ELs/sXn0AtSKUiGKu/BCfzESg0JO73R46yTWIYoxRIZHf6FFr3a?=
 =?us-ascii?Q?jDh/4hx8K2Fs7dapVIjULsQA49ZP3mmDbyBpfsw6zO1RYyVI5YuKw8s8c4ts?=
 =?us-ascii?Q?/FaiUPrZa1ijsDf2ohgYf64hpb3lOifgMDoFKF7ajEmCTJIlFXAapPuvQuqW?=
 =?us-ascii?Q?UHsir0JrBL0i3e+HbCEqNxXFrII2/OlpwJhe5dgAFAlOlVdmPPnOxv037wxU?=
 =?us-ascii?Q?QCmZYOpiO6qWyb0wktvk6mCNseFHZEz9f9EeL6Nh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a40c75d-50e0-4372-c26c-08dd67e5803c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:29:15.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbIq3U1P5Fhwo9wXSFpcrEXmHKue8eBnhblGz3SJZFYDxeGz0Ji3YNBbZ/in/p/z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15

On Thu, Mar 20, 2025 at 12:19:33PM -0700, Nicolin Chen wrote:
> > -	attach = igroup->attach;
> > +	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
> > +			    XA_ZERO_ENTRY, GFP_KERNEL);
> > +	if (xa_is_err(attach)) {
> > +		rc = xa_err(attach);
> > +		goto err_unlock;
> > +	}
> > +
> >  	if (!attach) {
> >  		attach = kzalloc(sizeof(*attach), GFP_KERNEL);
> 
> Since this is attach() and we do xa_cmpxchg() with an "old=NULL",
> should !attach always be true?

No, all this xa_cmpxchg is a sort of odd way to atomically tell what
is already in the xarray. If there is already an entry then it will
fail the cmpxchange and return the old entry. This gives the 'if
(attach)' condition.

> > -	attach = igroup->attach;
> > +	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
> > +			    XA_ZERO_ENTRY, GFP_KERNEL);
> 
> Hmm, this is replace(). Should the "pasid" position in pasid_attach
> be already filled? I mean the old entry shouldn't be "NULL" so as to
> call it a "replace"?

Same xa oddness, the logic is sound but this could probably just be a
xa_load() under the mutex to confirm a non-NULL entry is present.

Jason
