Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452731A7264
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688641; cv=fail; b=RZw65j1Xmmv8W/vwAU9iGryX7eM/Br+vzFWNBbIlX8ji4lKLXBi/JxcbzFl+4U9SV7NOOfDhlHN62LEUEohWrVdf6jlwBPWgUncdnFCG6rUQuXdUwOKe9wifBLz1nw15kKu8jbVRo6mRppm1VD51Xb4lvg4CF3lGPz1PPF8wXp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688641; c=relaxed/simple;
	bh=TwrKuiAOd9TbyGFbcuRsTfoX9IVkhICdggpxVQ/RtJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KiGl5IwjKYEGqHFOyIeOA1vgMFIf0tGyGiif0xsbn7yfsACAXteglLNZ+SP525xUaOZRETujxt3Y9D/8IvFhjyWNn3fohGiHvVptqQoHrq4RIk98HnCt6ngVCzv7/jK/9u25uVyKc1VcfiPhR2xfR0bGVJR+a6DbF3SL3z1EAvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c7htil3n; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c7htil3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uz9HJe1vtYpRUdPoOy7yKF3IeaSxVh+iNX4Y5zrEfTy1rCuO1QPHf2mDVOna7adZivaQHSsR3yJFh44Dd6T3gNfPV0YZ69NMQm1mb3ExeG1BlLPYyzQYi5CV9BuUk+9rXZefCPDVuus5TfgLLi+7fC4/TwA8N5wn/MDzaOrVC6iWtDoHEbXnXSX4+jvH8AX6mzVZW+oTuZqS7tZYYhrII7sePixAxosmt+7KWarOQ8zplZkjjPT89UZPTojPpYy3NRVx2vm/ySHa2iaeTYXg5K0hhU0MqdDfiySuSyXOiSiTqrr00TfaIbH/M0QhSTyGdcUDwUWxnZxDSqBqCk+GGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BIEGTYfAhoHI1dPgvs91v23lcCUMbyfuvbKCTupU6s=;
 b=NH6JdUudoY6G7ualYbJojkyalulBtlhi0Sl9uECnnn0LD/+Wh9UZOLMZQWguazwl1ngLCPnEenrLOQOEx4OHckJy5OvMaYj0HfMT/r/eo+IVgjk9vejaxoVMB0sp1/36Bpw64b1U2UVlBkR4x52emonwQuOgYBKb10QrUPLp61R6cYY4RTgf98iGWtQkUIxnoqvZ5SbArKTaa6niHRKOH7mcuy0Z1Jx4wJJbVCYSFvQOmQuu8Gq5NZ878J2CosRQPElDZ+k0zSl4tOHR5IvUQp80m/pTin/b5NMoVBjLNWnDuvfRq2+7Iukgjjl2qnmMjG/IpjXIX2xX7B2DeHD/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BIEGTYfAhoHI1dPgvs91v23lcCUMbyfuvbKCTupU6s=;
 b=c7htil3nI8IdV286WtL5xMRB9P+0CBU7fLPx4C27iz/XxTAS5fmKq8QnQ3716MB/hkWq8smU+VqAgnmxHYM78WlZZrk0YcwdDAf4j/tXvG3OJqlGZWyrbhPJW2fzJfzlnYnANypFU5TH5rkjyndZZbMJY5AwdH3lafCEEA+BAGCjV8mm2TtyjIOosGTLe8eveO+GL1ejlPn2VbCJiK+ZE/G9amAinW+IpaADr0YElsZ4DG7lbMuJ66IBPjLt6Za656WkEonTLSEBJSw8Luq8vrWNMTrdClVZ+qlkmwCBTCG0xcSCiP0uL/B7EStvlbBBGv7sOibUkfIvLfDuvulmrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30; Wed, 23 Oct
 2024 13:03:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:03:56 +0000
Date: Wed, 23 Oct 2024 10:03:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V5 5/9] iommufd: folio subroutines
Message-ID: <20241023130355.GD864191@nvidia.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-6-git-send-email-steven.sistare@oracle.com>
 <BN9PR11MB52763A8B95B982399E62EE108C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763A8B95B982399E62EE108C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:208:329::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf038c1-e699-4b21-40a8-08dcf36326ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ck0QQYD2iOSK7SwiqymBRiP02igzAIMtfO5lboohN1FDzRZUMhX2Y6vnJPb8?=
 =?us-ascii?Q?+TlqWKjI1tiEUdLFowpJHtnypiysP0Rvy/eTPrn0ZpicKeED808K+3eMq5jf?=
 =?us-ascii?Q?+v7uiOcW8uI98gSq5c4bXMfR8pdhrI+xQsmMatL8sLyHZEEJpsI2eYGKPyDG?=
 =?us-ascii?Q?YGa2WIoM7zDVjoZ3dkba851eOmy9+8iKjT1XJbEpM/DAriE48DYFKAFtJX+G?=
 =?us-ascii?Q?3u7CLfSGepQDSo6wqKz2QNI4Dd5ryBcE8oVGRWD51B2jGpRD6z+xl8/fT4iN?=
 =?us-ascii?Q?4/QOy724f9yvSAfX9x9u8//WMShIDRlPZBLFdR1BpcGJYl6oMWEwa/Xwej63?=
 =?us-ascii?Q?n5naO4vL1h97nughDOd5nD++Ug2ZbMeA8QGWsiJbMsGAtUWN6BcSARLlsI9u?=
 =?us-ascii?Q?+V1EIuaLm/XkYRCzVaa9YQqGuLydtuMnC2+eHeWe+bT3I0AT4oBw/GvRh3f2?=
 =?us-ascii?Q?V67XJ66JgoYTKchB1J8s7CdH0a4B1HqY13hcCo86J5K9anrwUPHPKgqmuF3E?=
 =?us-ascii?Q?6dfLePOm1wWFFlWsQdcnnxa2T+3mT+FQ5tyZ1JNEGW2Y3OypGziTKzwoR9Fh?=
 =?us-ascii?Q?kHCMevLBIPNAeGWvW0CeW28xwCzDN/HcRdJsJV5EP12X/9l+JPwGS211zex0?=
 =?us-ascii?Q?t4UviMGFjj7Gm/TsxelUhzP+Kd17creOSYnNG7jhrj7knYe5/rMlM5kXLyxt?=
 =?us-ascii?Q?DPAff3nOLQU9RgdkiDnDiC4FcapbYK7pOsFEJkSPu+e1rkkBDgQ7GZPIBq+t?=
 =?us-ascii?Q?XxED6Qwsyc+tRJDtWOvTLDAAAccunHy+M89GcA+w2xNQxcnT6HyHB5AKolnz?=
 =?us-ascii?Q?yWnQYVep7TrUVdngplVESSBZSjT/susaUGzjHU+EZQK0IalXrV7mPw3szHgS?=
 =?us-ascii?Q?kVq09YkXNvHrLFP1+xvb6nqPc/umKEG9L1zsLzIf0+Io0u8YPv7REDFlUr2o?=
 =?us-ascii?Q?eSqsXhPD+XPFN8dZFNPya5NQmVbEBiz291rreeEC22pyRZ2m/1bUtuWXyydC?=
 =?us-ascii?Q?lKZUtA3KBQKVaUrRiVR8fkjtFr0mB5qZyWC+K4++g5ejLNDZEY7vopKJn9t/?=
 =?us-ascii?Q?bnkqAd2G2glVq1VvIasdU9LyHldZBuiupekjzypWWR7Ovp9AirO+n04Cu3Wb?=
 =?us-ascii?Q?KrHYmTtKvml3xnYVyfRLImcnczP3nJ5OK/h02WPSeQircfNgvAKekg2BsZ6L?=
 =?us-ascii?Q?OnbCMnWOsSTHMw9lQFKuochKxvP+RLm7DKrSqB8SHcg6xQfjri3IGe+kxonl?=
 =?us-ascii?Q?/LoOx/Zb+mPj/d1dUiaBlt1/sosIodJK2P7/NKDUmCIdFtHjBZwN/ESbaRSL?=
 =?us-ascii?Q?5LA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lrzPiDWUL/mVknEDnXTCzbmPfj9KpKu1AMzHasOhf6Haitd69GhdI0fTM4vs?=
 =?us-ascii?Q?4QVZYzgnThuVLXmSSLZX52U5jfytqrVFPu0V7lKUx1wMf7nyKpl6bxS+Lezq?=
 =?us-ascii?Q?+adYG1r7iWeRSaW+C/NrsHZWkrwQGuzGcsvVpWVmOHcJIo84RsunNpsGkfZ2?=
 =?us-ascii?Q?fj9gkNI6KM4JVsoWUHaIfxZxTt2K7HsGcvpnPwH63VGq48cSkMY2cQOqvFPR?=
 =?us-ascii?Q?USdMBDBlz7iGQhZsx+jhv/zxj3omAP37bLrykLoi+D2MUeGwAHMK6j34yYaX?=
 =?us-ascii?Q?0Ni6iBJcP1LnO6EhDWQanprZW1DspMJp41dbiZGbzTTdvjyy6O18Y4bcR+vE?=
 =?us-ascii?Q?GGcQz6qlz4vwSx6CUSLfOTzCwgJ8Gsvdh3Y3W5j+rEa0kUIS46QSAmlmCqgS?=
 =?us-ascii?Q?Y7Bn9YGcfeV/XRlqlN94+oyN6ZUAV4ZOhBCk6B0K+Fl6OKtami2iv1TIP4Lq?=
 =?us-ascii?Q?ihBqCBIrAxNnUG1Ns7kEJA8QLDoZXCouy5hMp+0LjodTjnik6l2bMpgSh2JK?=
 =?us-ascii?Q?quBp8TLjCeo1wLlQEcBzgmpY1kgZnC8R3EqySnlhD5SWEWRFbVvFpcODmZ5F?=
 =?us-ascii?Q?deVroFeF4VkKJjsTN4ueDCKUnvmwIMHRZjZhIIs5JMo7mME6vhxE6gDPoXtY?=
 =?us-ascii?Q?OFTZwuDR3c/Ul1vKs538GlF8aJQNlTpt6ywmFD1v5WAnbkw8hPZQ4IU+TKdb?=
 =?us-ascii?Q?+6RsM/ourUPFRBGQYt9EWrz9FkLptxtYf07+SSUubva/Jf33Qjqi2h2JbHEl?=
 =?us-ascii?Q?8NxCRxeyEu7c0NkRZ8Fge1D+z+9XpUtNQrsWkAO3LVlS1A3Zda2CLFDYPGI4?=
 =?us-ascii?Q?uE9LmSQ53XI1632sWEkJPrt4+wp2Awe5Xsu4PHXz1EKHI9jj+QnnHmTdahOC?=
 =?us-ascii?Q?y1EtZGvlxpokg3R4gJqdGIvg+uaUNbbn9zhes+vlBExP4FU953qkXa3/Wyq2?=
 =?us-ascii?Q?DIF8NHrA7o5WSck53T7KrwKCrUFkrArIT3g61cqLOhB2dVmIKUt/qvNSxuc6?=
 =?us-ascii?Q?YqVIuLIKWug/63WRdsA2GJoOLDGwZ1kipd2/O0ljxGJSRvFQgoSqGom9qoyy?=
 =?us-ascii?Q?2v96Ulot1uBRFvuNLbsdVe80aahPiM8S+T3Ku/yp730B3Mj8OOvE1aFYDVCy?=
 =?us-ascii?Q?GgOIMECIEhL2PIERCdJRTCLpGPKmWQNdxg7CUaiaxn4wz4BCVw+p3pSNflw5?=
 =?us-ascii?Q?1KvwtfKCpYrp3YyNjfIun7YLK79qJg1fYkCr95+20qyIiBn0Baf+Xn7CEBUQ?=
 =?us-ascii?Q?qeze9WSyxwTfZyHBkM2hHcdRAHM3u7z62UtSW9Y4xwZwLrzf7kABw0MvfwRG?=
 =?us-ascii?Q?gZR0Goyv9l2psAvZpiH3AmeP7+N4JWRkAxzdk4/Yk3z4u0dIi18Nw07VPjTw?=
 =?us-ascii?Q?E5w/PTm8NY0ncO+Y+f2xo4KanelrjURlLpzQtZCLcIoAUMRpTrngSgXE36oh?=
 =?us-ascii?Q?1tibFhg2RkXOs5GUsO1EneUc7Di+PIi02AWdynCISWGz0YN9SIXLM6+fMMPQ?=
 =?us-ascii?Q?n5GUo8006pGTiLYW0G9+5ttBvJ3Cw38Kc6bIyLBMrQ1fEMT5jtanYWcu1YnS?=
 =?us-ascii?Q?mkoL5TOpkFb/e2O5agocZ3ZuC/yxp8KKkaUmH2P2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf038c1-e699-4b21-40a8-08dcf36326ea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:03:56.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Vr824bUFREPtvx4QMnqOPjYWEz/bhqXNiYk//6bIn+kbNQ7Xij8gO2xbZAgXtDN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

On Wed, Oct 23, 2024 at 07:21:05AM +0000, Tian, Kevin wrote:
> > From: Steve Sistare <steven.sistare@oracle.com>
> > Sent: Wednesday, October 23, 2024 5:01 AM
> > 
> > +static int batch_from_folios(struct pfn_batch *batch, struct folio ***folios_p,
> > +			     unsigned long *offset_p, unsigned long npages)
> > +{
> > +	int rc = 0;
> > +	struct folio **folios = *folios_p;
> > +	unsigned long offset = *offset_p;
> > +
> > +	while (npages) {
> > +		struct folio *folio = *folios;
> > +		unsigned long nr = folio_nr_pages(folio) - offset;
> > +		unsigned long pfn = page_to_pfn(folio_page(folio, offset));
> > +
> > +		nr = min(nr, npages);
> > +		npages -= nr;
> > +
> > +		if (!batch_add_pfn_num(batch, pfn, nr))
> > +			break;
> > +		if (nr > 1) {
> > +			rc = folio_add_pins(folio, nr - 1);
> > +			if (rc) {
> > +				batch_remove_pfn_num(batch, nr);
> > +				goto out;
> > +			}
> > +		}
> 
> forgot to ask one thing here. Could you add a comment here why
> additional pins is required only when batching more than 1 page?

Something like:

 The unpin path during unmap can unpin slices of a single folio, and
 broadly does not keep track of where the folio boundaries were. Since
 it treats everything as a single page transform the refcount on the
 folio from a per-folio ref to a per-page ref. This makes the unmap
 path uniform regardless of how the memory was pinned.

Jason
