Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279D22738C
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193072; cv=fail; b=P+149waLeD5HDtRtupFMykvcbX3SLd2jgfu1QdLpL/UMcpwkcxIVBOwpjIsPn2kl17EzqyDYaJwHx15Uc8HHuEuouCiAlgP8T+TB+LkXUWxjNVd2gGY2yfe365RW0MjG3Ge+QkjrZswT4DW9drzfQg49u5jxju5yUrDAFsztYq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193072; c=relaxed/simple;
	bh=1r/ML5++4uCwV4hQiFW40LJlUWvgHZs4VjLkOPHO+60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AcDniukxWiuw8xMNyUfYm0B84HMPY3R0D9Q4GiVerHCuwNmAVbfg1fngD7jRm2/acIbolDKQGu7uaCTd6tJ7ZRb5OquORT+RfmIev6OozS8hlNi635zzCemmRyopAyTIaqDH/FPU9iTf2lR0XnlOGBDCeNz/4iefqM95xAteGxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BfCweqXw; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BfCweqXw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tj+vCiySnM6ESNrFlzp2w+WV1g3BXWy+RlHAQtw5zHP1+aUXR+XtbI8GKLWVtgRCFBN2onHu321aoCz84oPm9qDijY0AEMC1G0gqA1+Q0OtJwaFzfGictJpo82D7bt1XzOBlNCRRvLekW4fGRPc/s1bgkeDXH2PnhuWPxxtl4fVj8WMzwKLVD4tTbIPxW/8T7zj/vYzG/7lCjwopSj7CXgJKFSPMGg2gILxCqzpVjH6ieEm5DQumBLY/YyVdtIcLMTmzZBOYFR2yzFQ/YijnrKxf053ZGMgtYh6YFaxL4gmvnfFrxIFm2NUWsSUvCutkKJmc0gE16WZ2e2F+1IgoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ih4RTfUjEGfhEDsn3EW+RueD3IPqUYQv7ax4u6ucfu0=;
 b=fbe1UdAgpKvHA985lpNnEfjvRcbAtBb6+NLPS10OWdydh6SljF9nTl+7UqD31/S7KgXw0uiEG0c8qwz2zIKG3iYrFWQ0cOKgvmG14SRhUdCfx4CEwX6R/xplMB570LAPZQ++8RveJLgnnEIXca6JfqdcmHgle7N1eCbuF6UaToh++jGaVT8n34Hlb6XH26bTj4NtkMYTj3Qc56xo19D+GV/leeo1FmAsYQdaKMFIRhFeLWRpT8lRgJzgHX9rt/zw9dXClW/aWTfRiXCzmcp1DWpFxWYzReVXSg4Xvb4j6npNjDL1dE4G2SwqQgIW6Ah3671AYw2jx/ZoDGYxSU0Tww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih4RTfUjEGfhEDsn3EW+RueD3IPqUYQv7ax4u6ucfu0=;
 b=BfCweqXwP6n1lgOpxPrudLKM0pmHgbcIghRNMcbeNjnZ0rcddiEU052Fh5fmpyc+I89UEEOJ7MMAVkhd+CS9DysI5HkCvjK+o0gcIu+dcLC4A0AVncqT1hsv8Gg3kZfyxJKh0AA868wGAMn8w3is1zxbrHxiabUfYFztg23Qy6Rwd4wiGm03FqSazRrIEEPBE6jwuCrJvdX8dHZE1FmHRmsZWUGWFbYsyIbPHitNzVRmduCTHOnOG1BNfV6zeEhiBhxvek4ThY7/LLaV4Vx9ts6Ecx9PGkyKD/x723sdzJq20k4ZdfSLGgKkWBPE5+ca2yhFVn9Wu/ZFF2eEfqoLPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 19:24:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:24:19 +0000
Date: Thu, 17 Oct 2024 16:24:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
Message-ID: <20241017192418.GD3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
 <20241016130001.GI3559746@nvidia.com>
 <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
X-ClientProxiedBy: BN9P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: d200fcae-dbff-4bbb-0ca9-08dceee14c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nPI/8jN6+S1QoIheQmy/HvGKqjM7zbwxhgO9IZXz3pWme/0mcOFywvVgcRdl?=
 =?us-ascii?Q?zjgRvCAZ8BKA/ZIbqwroVT+mfZONrUbzCijWQzUCLfkDstDWENvJI5TmSg9y?=
 =?us-ascii?Q?KX5nuTuI9f5ksslBWcTqlgDS4+sYvAXzPbwdO9o4U/pB7Tw4Z1N3flGfKFfS?=
 =?us-ascii?Q?2k2y9tsgckHu1WLR6hOg9ngjbLwH/Hv4/tBMvbtsQKXQFcigvICsXe5O9crk?=
 =?us-ascii?Q?PSskFBlzjjAn+trDgYnCFHuR42Wen/GIxZfw3qKPoZicCpS0tYO7APzde24B?=
 =?us-ascii?Q?qijGnHdIeG55zE+/LzhcfOygWAVC75Q4iqW8/JLKSSZU3UJEjm4/nXgChICj?=
 =?us-ascii?Q?lCFv7sa5elQ+PRnORjxu+Lu7N2MTvpvThBMmRB37fphZ97ZzfhJNcw5T8Upk?=
 =?us-ascii?Q?soSKo66zPp9lVasEiFfhOmyeYOorOoJvvJjpsrKmfcPrcoLG2vMSxKKPwku5?=
 =?us-ascii?Q?+LUbQVNOaHFxuTq+fntomFw8joJX0blUlT3+vNv1e5M7xryth0UDErq9eIbs?=
 =?us-ascii?Q?+yNC60GZ2+bHVsxmL/zebfn8ulCyE4vHk3OjKS2EpjlfI48KyMTMa21ldUM4?=
 =?us-ascii?Q?0x42bzV1rSBOhBYM7vTgmIfKA5w9EYyOd1BsIBDoHwOfH2XMbXAp9WQc6F6O?=
 =?us-ascii?Q?yFimeW/dhxq65RM58Un8HYMacOQcJMGipkBkjAQvHHN9fVnBuS3aTzbwnZ2Q?=
 =?us-ascii?Q?uVnJOetx60OvsgWztFU/ZLv0ddCy+L9SoMuHdF2JVFzzZurt2OSuML+Ttp0z?=
 =?us-ascii?Q?EHu15XX+tOA2LWPDNF37y5t4hyMXXDFqzQHkvoFcVSIpaHsaxsYp/TNKygxM?=
 =?us-ascii?Q?O9vz3pc6+92yX64Vr2TbHa52l1bqsEqQDVCrf8Ph9vP8wOPO/gDJd+7Thr1v?=
 =?us-ascii?Q?0FtUDBO08NwJeT/Yot6rjX7W/VK2iqkqgBz1P83ry3PURapVKQ2MzRAC8Wbl?=
 =?us-ascii?Q?oM93GYN5D2arOhBZ0UIBabxNvQjwPv2DxN889nU4nU3qPJXKqwWeSKALi0RG?=
 =?us-ascii?Q?4dOkmwSMP1TsZobiEQvvJ3xhCdhg3gu4s2xqHIwq8/tKyW0g/5HcdecEs6Qm?=
 =?us-ascii?Q?QElySbe5pvMoC0fOsxPmMAebtsH072AhSBLkFZjJSnaqrOBYtdZRH0YiuY9F?=
 =?us-ascii?Q?NiGDoSwPCKfu9WPBZwmeNjl0cfHiFXvGFZRLh2UtZCy7K6nTI9XCWxmoDNfe?=
 =?us-ascii?Q?wSj/q4544rnDnbky8AT0sKNdJU9JcpQ7QwMqt6yQS2kaVVzSWH9D08dZp5PW?=
 =?us-ascii?Q?RVa+w8IRgrKcvp/BJWA2bksZT4FFR+rnOz7we8rmTYhSc/VJStoDT6g7hGum?=
 =?us-ascii?Q?ELwBiq/jdajLglASCJygojR4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WyGShe7w4lTKXK+NcUcc7hP9r1Ism3xXvrA2PVV3PSI7DinAomycAiFcRAiw?=
 =?us-ascii?Q?iI2XE3RRRHc7so1kbO/PaQUyPGH1Xpj9B29F0EjwKO94OGVmEAjNoYzzyXjx?=
 =?us-ascii?Q?qRrdmkFEVRnKI+xigAAfFFjqQKYDU32BGKyXf4RcWERefpnbCflgAvKg1EC/?=
 =?us-ascii?Q?JoaenO0e8rIFUo5bgqFaS9g1SAliEfTBfKLbBQoomytBMzYMjDTCgU3fA30v?=
 =?us-ascii?Q?6BzwL/xw7A7r8Fq9T24/gEjjEOvSdpxF3zQ3hQGNr3EDyJ9c2LaFFRb9mAth?=
 =?us-ascii?Q?yD8kYJbAtn54Xl+LWkIbxeRREP9n0gK/tdDaJHgfVCIcQwpKJ6f7ZWqKe8Z6?=
 =?us-ascii?Q?/nZj33doZig4iiWie6f54rek8I1qeiBw81aRLvvtNNWyToPLhQqoxuXGsgtT?=
 =?us-ascii?Q?nO+oj2GciwCpIznbQpogXrsbKzMJddiSKNvwO9XzTlxjs/LlDorLsyQGmxmK?=
 =?us-ascii?Q?cvTQ0OFOC6Eohoz75SRBmeGDPAYjlrbG3W3rbqnE7E9bpVO6OdAtFmDIMxhz?=
 =?us-ascii?Q?mdZqOKRBlTPoAWd7U30PQ8xVJxPrkLTYW+pjyUoLeIzrppkWRMyxwlnQgG1V?=
 =?us-ascii?Q?eLLgKUR9TOnq7WWoxkeu59h3eq7kmlEjJKhPMfYUDV2zWQxdxQ3D3qXYw/PZ?=
 =?us-ascii?Q?xv9O2uHXIBskS9YGbm56X8I3mzB7hb9B8mUGxXxMFUnNVkN8Bw4vswKKzyaU?=
 =?us-ascii?Q?bFXTrDe9u7eyfl8LgU8VWxyd3527pLBs3r/SPuQx69mtK5kxQM5Lq3f31d9a?=
 =?us-ascii?Q?FrE2q3pEAb3XFT8vP3rwk5iOzNi2XxjvdBJEpNUUrIJ2GuCXR7zawWTtfcfT?=
 =?us-ascii?Q?+weLHFOY5xBQIvf8FX1teyNTK7J5Ag6NRen6jqhO23o+Rxs1q0ipiWsHZ95O?=
 =?us-ascii?Q?/+MKThzn+Wf6f541AXTgHXjSnVs5VsKXm5SuKwJsTjr+n7LDNzgimElrxA/Y?=
 =?us-ascii?Q?akyzYcLvWDjgkxlkeTo/mTFGZfzJIww4Ct1JrHNzi4N/mmPxr5Nh2BOjv16Q?=
 =?us-ascii?Q?oyKmxm3HzF7AndlBJeg6+r3iF+zmVJmBC2g6Ojgl0OMd7MvkZHMf7a57HUza?=
 =?us-ascii?Q?OwV2nX1fyAKuEX/YRf71AOWV7gJm+oKGTLrGb50jeNA1rHi5uYpD77Bx5OQi?=
 =?us-ascii?Q?PYCdkQogCqG2VFpLOofH/xyJorVSFKZkktR4fcOZHCbcUtw+aLJEb6Esh8VY?=
 =?us-ascii?Q?e1OeXnhHPK0e2Zi/uCmfcQcs6exVIeIxpGQjbdsqY97oad4c6euHvKhbSTwj?=
 =?us-ascii?Q?V+LKk+H3RqTiYpiN6TwwF7U/iTfOAk0LWMbLvrOxfcv11rZZ+QHsSStE159L?=
 =?us-ascii?Q?nIYu1VYo71z9KCRFW2CqFcJJ70ae5HMcpH5GDOaOoejx5z2Rr2CmTK1GOarn?=
 =?us-ascii?Q?kR4enZzsW5bgEidWfi/UtIvc/zgiBdZFqk1390Zblp2/PWImxdgMP7QXnjBn?=
 =?us-ascii?Q?Y4ImCARWL3peX9RyMIJCTI8IlrIvOhaHoaYRDO0eN2wO2oOWWVhxFf65gPLX?=
 =?us-ascii?Q?uWCM9TPInxwuIy7qmjm7p9J4HtogocBoHJp/e6gPbnT8dWIvZQOfI8m+5p/6?=
 =?us-ascii?Q?VIiZczIrMNbhrBN47yI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d200fcae-dbff-4bbb-0ca9-08dceee14c44
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:24:19.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/sj0QvY18eyuAEEqkrA1SL0uCd22hUQbopZtOUFlVBR/UNgpVn08ozxpFI582b5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631

On Thu, Oct 17, 2024 at 01:02:14PM -0400, Steven Sistare wrote:

> > > @@ -623,6 +639,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
> > >   			break;
> > >   }
> > > +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
> > > +			      size_t npages)
> > > +{
> > > +	struct folio **end = folios + npages;
> > > +
> > > +	for (; folios != end; folios++)
> > > +		if (!batch_add_pfn(batch, page_to_pfn(&folios[0]->page)))
> > > +			break;
> > 
> > This function is really weird, why would we have a function adding
> > only the first page of each item in a list of folios?
> 
> It is only called when we know that the number of pages in all folios is 1
> (user->ufolios_huge is false).

Oh, lets add some comments about this please, and maybe give the
function a more scary name. batch_from_folios doesn't suggest it does
something so strange. batch_from_single_page_folios ?

But, still, *why*? If the folios in the list all have 1 page size then
why not just add them in the normal way?

I still didn't quite entirely follow what the ufolios_huge was doing,
it is what I wanted to look at in an editor..

> > > +static void batch_from_folios_huge(struct pfn_batch *batch,
> > > +				   struct folio ***folios_p,
> > > +				   unsigned long *offset_p,
> > > +				   unsigned long npages)
> > > +{
> > > +	unsigned long nr, n, pfn, i = 0;
> > > +	struct folio *folio, **folios = *folios_p;
> > > +	unsigned long offset = *offset_p;
> > 
> > Let's make more use of scope local values please (put folio, pfn, etc
> > in side the narrowest loop scope)
> 
> OK.  Some like this, some do not, now I know your preference.

Yeah, I'm in the camp it is easier to follow

> I personally like to use local scope and initializers, but dislike when
> cstyle it forces me to add a blank line after the declarations which disrupts
> the flow/use of some quantity, eg:
>   {
>     long pfn = foo();
> 
>     bar(pfn);
>   }

Yeah, sometimes, maybe don't initialize in those cases?

> > I would like to see this patch when it is applied but I can't apply
> > it..
> 
> I will send you my patched version of pages.c off list.

include a git link in your next cover letter, that makes it easier

Jason
