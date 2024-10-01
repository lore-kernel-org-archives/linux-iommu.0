Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E763A1CEACF
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816642; cv=fail; b=Zy7FtSXdsmOU4+4RzRwQaN7ehphwtaQZnOFOVgsmgIUjimXpKBTCvYu9PPw1KoSckdSnKO5dnxyCqqT9pwg6TqycAaZdQ6sy52mrVU+4csIXrKd21v9bozQLeXVNoKDnH54+iCMZZNaKZrflHfb3sfRu0fucm0J/tigLb3keumM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816642; c=relaxed/simple;
	bh=ck0/6qwsKUXAJ5lyIqBHYBuLIUam2sP67O1zpvrobLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HaVmBJwGrWYY0yfHeod+ABAuNL7Wmu/xiGLeV5ymTD23crhLLl7GlgXqdCeZ5AmcBwFxkrd7uMuhuIFZgQg8ZGOJicsNBu2OYr08zsiuGSaY5+pTlyBhJikQbDwjR7/Js46Cw3kPrefc4qFlv1SGf1g0I8LyEYMrJr+c3bKecYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K3xSBz/m; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K3xSBz/m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR8ua+iFJ2+XeLXVmUn3YJvcR26Kvr3miZQaB8DD/HR1TACszuJGYJYukpQnEtjNWAMZUbOoVmazDpzjuAptKHbTTwzBbwjqt1lQuVljp75ZJjuSdik5HFHwcH3diLwvh25H62ziI0KebIG4CB7ygOe4oAMCsioOGcRt5+bJ2VfsOAPt5617ELrVtLk1BMv2og1A8bmrl8tb89znQeX4FUWXy1VQqdMJxOpTEsslNvShZM43EHljfofzB1KrSqVDreehoRzIP3C46wB/v5eBwqxqT+pjMi5Xi8THXJjMalwzvU5zMCAso481eiz8LywBiPCD3ekV09dUJzw4ehYhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38gI0ZurJSMDUnUsfDNalwOd0DRImCvnjFDq7dmxtfs=;
 b=Th6rMFWYnXPuL394h8lb25OlTh8j0lWa3lxsDh3ZSgTCwVEMThPi96Wf3jXPfnwSC/8lurg4WSoVHaeaReA4MLa9uVM8EQbYTpbDmAuRFpx6w5CGghOoZgfCPTHkmKH82uu3QTAaGkbNAHAIfqI2XMksOmNdn/G+YDdrmQvRKsayTg2BWBM5RAQMS9DwM9s/dQGE0pOvsQLC+G2EjOjGA0Y3EEPJ5WUUAUuZ+AOGo0A5zm/nRHWd6TzZkzTpTcGLy3E+P/0oAWfMfePgsGuNe1bZrBLjhaX9HV0y6qJWDGNbNejJ2vcJffbzr2DueA37uzMxPIA7xHaYQZA62PfapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38gI0ZurJSMDUnUsfDNalwOd0DRImCvnjFDq7dmxtfs=;
 b=K3xSBz/mEikysE3sqQybu0tL/a0XSBvTsZPOGlPj4DTP7poTVdR9IiFr7wFMQySoBG2usDjh/FFtecyrwNLUXOTAc2c8A0t/OnW8yNnGegORyuiTZ6bb7iL+8S9cO8NI8jiZtoALxc3M0HAIXjcc2Uv9htEv5FmuR6LSKxX6hSOmH2QS6ZAbHjsyAnamnHyHfGCvtoZHLDwH5dNEEwAr2+5SOwU2FlfpBBUljW/Kkx3EL5B3KntakiqyNRMpr7B6qtvP3wyg9w4DtEuEzQHxTkyPMjdjRNFY1YcWbq5MFAGwDE+NFgAWJCOLOQOQj1s6gf5690/3AbImv0q1wFX1gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 21:03:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 21:03:56 +0000
Date: Tue, 1 Oct 2024 18:03:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V2 8/9] iommufd: optimize file mapping
Message-ID: <20241001210356.GO1365916@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-9-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727190338-385692-9-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN2PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:208:23d::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5bdfb7-a661-408c-5519-08dce25c905d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQf807J5QWPxSd8uefVE7RpSIR+9TYVctZU7MPZCwZSUrfPa6OfsKZ8rAiH/?=
 =?us-ascii?Q?lSE9IiCi8Y2RFkvXrArDiZwTiRLd1xhI1BpiuIV3bAp6yWSjj7SlC7Cmlp5C?=
 =?us-ascii?Q?DJJDjlRha9Eh2DZLutPpP95WyHEXHTtus6tmms2uv6vVzvoVV93UJm7kCoTk?=
 =?us-ascii?Q?MR5nuA2/FCGMgAEcizxev2E/+aqhkRU0RNpIkc7LROMbE5eU8CQxVESvIz14?=
 =?us-ascii?Q?yL2WslScuiwyF6wULGYVnk6lOtZcoLgBgsIvM8d11nhj5j85axD2LUIjbNnI?=
 =?us-ascii?Q?J1ZxwzyhC21gVar0FypteT0OyPb2fcA//s2OXnI6wF6Of7lxJl9Y5IOYxCxe?=
 =?us-ascii?Q?tHVVa8o0349YEmPqC04Np2T0HlizFgwkc8lh8nL0/YGaKDmEh5AfakVcuIHV?=
 =?us-ascii?Q?txBKDihS9iu3jHrC8yfPIWOy8AfZEzdvsPTj7Dt2qOC++KExNvcSLbxO2Qpf?=
 =?us-ascii?Q?SvTsdMZsPYJxuqpZLTTHUIUYj/5ldYNgtcTv3jYvNG3J/XKw7K4fdhchdGz4?=
 =?us-ascii?Q?FYAT/KYjMnCGT72m2ZxBdpNz1c+JnLkhwICHCdnzW5Qtp6tZ4cDWI8ulTWuQ?=
 =?us-ascii?Q?3RS1QqyeGvPnagHX0Q9X7j1vpQphj391dBDtbtKi3nVGVLCOHZzjbmnq71ve?=
 =?us-ascii?Q?eu4GqdqYzOQV3+u9orGpOXyP6YJ1uialDSfQBWoIGWe6nr89RwImi4OvP/kj?=
 =?us-ascii?Q?D8k5gqaZC+ceod9U4qGIpmFaaRhzAk1Bord+5RzxFMQm0lYo+dPuq2d4HhL2?=
 =?us-ascii?Q?zqowGdIzfa+XO00kjb8UOvkdKFjnKM6FvEjhtSRoSzCjLGnchEy6tsyLkYfn?=
 =?us-ascii?Q?kBeAyJbzJKN5x+kV8i4jLpowpx9rwKA8kRs2PPaW0iMZbxdsjBH6wQ1rE0qM?=
 =?us-ascii?Q?r2H3a2a784nbN9k+m1NUIGiY2f/W/Ho4nxKOmWa2cpRVC4lIRah6FK6O2YFj?=
 =?us-ascii?Q?QWSdhdV2f46sYpV85k0MvXmHXqG2E3Y7g5B0E70O7PQEPY7MGZiacR0qWZ0Y?=
 =?us-ascii?Q?fTXwBqaMr7/0F4X8lX1DhQI1dDZVMHLJkpZIHlQi7Q/UHq7GPgxrktGILJ5m?=
 =?us-ascii?Q?MQrtgikHPjcqwWFu0J1I37DY8oLf3KNdzZaWDS0V7UgdGRlmN3RBYQt/xoh/?=
 =?us-ascii?Q?Jv4jrqJaYU79MKhANkzGSyejE8H6IQXZTjwQqY8tJFXC+GbcfPdRaRFAHA6K?=
 =?us-ascii?Q?rioOdmnw20puizJfXoq+9+Gds+X9F8Tj9JH2ZxZLcQMEDwAEweYBJxn8qbHg?=
 =?us-ascii?Q?lf91xNodPRVx80iPWD53+P8kUYEK8QPXo+WPluQIYdTyTja8ubVqImm+r0S7?=
 =?us-ascii?Q?PNn7+6pEueGHneIP5hLzdydy+7Ju8YVfeQ9eAD1/trZ0ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F2Z66Qep4ziAghL5/oMW2qUdfSSn3ziVJsuaSAE0ymQFYon/wEYSxaCFvi8j?=
 =?us-ascii?Q?dMZcxwKZC3CUMv5dkYTt5JdYDNKHQXkH+l9kVK3cBzmQvgY3f8MOjkmc6cgY?=
 =?us-ascii?Q?0IFGEoHmSazQD4yv4S5dupb16SK+4Yv0HuPi5P/+I7pTZISmSqWZWOjZ5ttr?=
 =?us-ascii?Q?qtKJAkttqPHw+Bx87viBSxBodkceswP8qPhsLtTdwpkCiV4/GM270Jy7dMyi?=
 =?us-ascii?Q?nTeyo4847owg46t2Nk5gXp1w3MB+w9tas1OFaAkCgPlIw8xK/jrCgf5TxPRa?=
 =?us-ascii?Q?I0EJHYtDzr5EOJPRXDLPtZc7InLOSTWGJ6Kx9Lv3kQiVze1YNHAcxQa9ENCr?=
 =?us-ascii?Q?CZif8irWbNbNhMqoNJEifUQ7IhrGHF8ZU3TBUmR8/X/oN3Agnz4+yr3ZL9tH?=
 =?us-ascii?Q?aMSfGkBqPBMS8v+xu54bIfllpF+z/1l52u5wQKQXiALA7YzayvCmtrYLjYN1?=
 =?us-ascii?Q?vZpm4IVdsJmUGED5OjjjVC5mpqwzUH0eyVVayQa68Exe7fwTQOxZWGZWTIGc?=
 =?us-ascii?Q?g4Or7o8JNKwXAcBwWIKiQhBrQ67EVcq6GzlfycPfW75HUfVBB5vvdIN1swcm?=
 =?us-ascii?Q?RcTYp99lPkDdcq2DI4WqLHG/a3OT7eRL9xfZg+Ky6hX/t7br5EC9TbshdqUD?=
 =?us-ascii?Q?GijhL/7WpvDa02E6vIft4NpDpNCpGtc9d3tnA8CHy7ci/aDkEB61m6B7NvWI?=
 =?us-ascii?Q?FuySwGs7luAsxqV2lrnbbruU7BJmSqJT+z4szojIMN4P0AQaYq0XNApokdcC?=
 =?us-ascii?Q?+K0BCH6XvezIkxfFtMC9yk7gC3k0BxNsEN+NSnynpyE9d4T7KQ248MyXAOKi?=
 =?us-ascii?Q?RFDgzEOKEtrYp0itderKLQamnx+um3fdaRW+pw8VPLcvvP2j3EsyebuiCQdM?=
 =?us-ascii?Q?USL68xz/9Iydm7MfQnwTSee6QIiJXgG7/PVLJq/M/iN7bVPnQXdZOaRBCWUa?=
 =?us-ascii?Q?ntXBIHAr3WeGJWJkszgKvhdC2tvXubcWV83oEqSOgMq2iqJ1uz1YL7rlWeDK?=
 =?us-ascii?Q?bvdmQxSw0YV3nWEBeA+40B2Lr5flHMJRS0h00zQdmYlExrXdINpShx6IBoBb?=
 =?us-ascii?Q?+F4jKYbsAOHwr/2XOaEEa6VC+UwmYrC+Yy6XxBXT6z0hF0BLl685g6wA4Cvk?=
 =?us-ascii?Q?TBm49mMeuw1y/lgkyVis2bVoLegqSzueytdiz7BNneFd5n4FJgrvK/jPmftQ?=
 =?us-ascii?Q?Oya3ab0CYpvbExLIuKlX7B3jCzlr43XsDWkKxMXJTlmyMNKQ5JyGVMCmrY7S?=
 =?us-ascii?Q?qF+5m9Nd1HKMYRq2R4lFyrIMk9X/GEaPrkvdDWcLQqZkQvsfeltmJsZbHdJk?=
 =?us-ascii?Q?9ZJDb3DHoiFG4G+sFK9OjHOou9FrlH901bMghAp1DCHgcBwwnuoNGBx3LyaM?=
 =?us-ascii?Q?qbrAxejtjidz+ztDsMYpFeJG8s22Vlo82ADJGzIrs3BN1jS7eudiEw/q8HK7?=
 =?us-ascii?Q?uEMx+vlrqmWufExez6bY8TWyAgBczbMv1quCkrrfaa83QlpWBvosql/HPZsM?=
 =?us-ascii?Q?cMVsc7JSyT5xBC0H1OG0N7rfBqEEZb21XxD4qHuFi/eH3bgXZMlfsetCtel7?=
 =?us-ascii?Q?BpPPACPXTH3yX5X/abY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5bdfb7-a661-408c-5519-08dce25c905d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 21:03:56.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeA8o9UVv+kLr6YtZnCNz075rfHfzF8NhmX4eE1xS+amuL2x/cYySIupqF+JGYA7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

On Tue, Sep 24, 2024 at 08:05:37AM -0700, Steve Sistare wrote:
> @@ -622,6 +630,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
>  			break;
>  }
>  
> +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
> +			      unsigned long offset, unsigned long npages)
> +{
> +	unsigned long nr, pfn, i = 0;
> +	struct folio *folio;
> +
> +	while (npages) {
> +		folio = folios[i++];
> +		nr = folio_nr_pages(folio) - offset;
> +		nr = min_t(unsigned long, nr, npages);
> +		pfn = page_to_pfn(folio_page(folio, offset));
> +		batch_add_pfn_num(batch, pfn, nr);

I think we technically need to cap nr here as well?

> +		offset = 0;
> +		npages -= nr;
> +	}
> +}
> +
> +/*
> + * Return the folio containing the page which is @start_index pages beyond
> + * page number @offset in folios[0].  Return the index of that page in
> + * @offset_out.
> + */
> +static struct folio **folios_start(struct folio **folios, unsigned long offset,
> +				   unsigned long start_index,
> +				   unsigned long *offset_out)
> +{
> +	unsigned long nr = folio_nr_pages(*folios);
> +
> +	while (offset + start_index > nr) {
> +		start_index -= (nr - offset);
> +		offset = 0;
> +		folios++;
> +		nr = folio_nr_pages(*folios);
> +	}
> +
> +	*offset_out = offset + start_index;
> +	return folios;
> +}

Why does this exist? I would expect you'd call memfd_pin_folios with
the correct offset so that the first folio was the right folio, this
is how the pin_user_pages path works?

> +static void folios_unpin_partial(struct folio **folios, unsigned long offset,
> +				 unsigned long npages)
> +{
> +	unsigned long nr, j, i = 0;
> +	struct folio *folio;
> +
> +	while (npages) {
> +		folio = folios[i++];
> +		nr = folio_nr_pages(folio);
> +		if (offset == 0 && nr < npages) {
> +			unpin_folio(folio);
> +		} else {
> +			nr = min_t(unsigned long, npages, nr - offset);
> +			for (j = 0; j < nr; j++)
> +				unpin_user_page(folio_page(folio, offset + j));

Don't loop, we have unpin_user_pages() for this

Jason
