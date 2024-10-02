Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A111854
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890450; cv=fail; b=mG7xAKNZgPrYUSIVbhosJ5tRQ68LwjNxD2xWCF3WZqDwtXydReuUsKbSJhiKYEnnOtbrU7i9f+B1FGQhAgV0zLULg1uDpdWAGnV9J8bU/IA46kigx6TSqZuuDnq4SBUlH/iMObTX1j4S0xr3XbaRfFhLW5lKpNegNLNzgz6e5bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890450; c=relaxed/simple;
	bh=46JynCfI2pIQUVikTvilQfBbspuRnxV6Uq6+EwQYLSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W3AqeA+MozHOo2HyEwczFIeBNxhcEF6whKGDc9MTxnleRkIl4BGK5XxBdGgiId2fNhkMBAVET2khnqc4iE4SJZ0OUPYLdhCmgdxSM8mfuDoq+V98tPHz7O84adyBu8RSmYvOKTuKQPv7QCCCMEmU1tFpC3tAwo7DI/jjlYOX/QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l9unpXhI; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l9unpXhI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9Ipl7AY6XxzkZL2HkBRoyaIu4oM85zOd6ZnQrTNQp3su3rFLiKIS+O6EyvVEHuVkzlQrI8FPmiE965VgXMFNU2OdNCq46X4VSOJH2/byjBb4Y2VUzLUmQZInRzX+VAPR/3Tb/EvDPjwsX3gLniBrEEVnIA5uGnJLPMpu4KSuGgY4/eV+Tb4Lyftl38HqbuziHrpxiw0CNI7B0wxrFuDwWJTfsyJE7ituHLdLjAVNHwn1ge4X7tu6PhwNPwm5GZw7yXEZ6p57n1Xtr3bmYCozzJ42tkJaUAcchMoZ/8Deg2bKnw0oEsJWoyNcz2fw1FB1EwQsP8bKJ9c01BPYakoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEyP7gbW3RtFZuPUR9wG3FvyUxHRKHM3i5n0EtUKJvY=;
 b=JkglQ7CN5F2AFoRXcSgaBChA+E0mA6tk+yFpaQDAy5XRbWqwZ+LHx6DMAIuXcEoZ5IEn1yv6c2MTDHVYz4rY/zF2lyZSmv6jCZLBfdaOKD5+3NOVuKcwNAzA6ab1saPSpWBVH775CagV0j5ic4eBxdBYgnY+x+aaaB6lGjg1KWHQvKOW1r1mOH94sPD/fwkiGdSXG8MEeD/pWB2GSqb+5dgymdvDxN1zy8riZkhm1jYc3PyqAy71XJUzus9cvfM15ac5jYdot35Myvr7jtnRcXdQKCd1AZEMjTBL3iBX1JvEmUrKhY+es8rjsfatkUpspe1KR3AOreui9KU+nfMouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEyP7gbW3RtFZuPUR9wG3FvyUxHRKHM3i5n0EtUKJvY=;
 b=l9unpXhIqQP78JC0ctd7Z3rIlpPGuiSza5HMevVBc0+Qg4TeBcQBIaZDxnP08F7FpI+TSUklexYJ1Jqv495Le1h0wq7QyQkYYMBHPV0p4EngheRTVIqAToKhVO9BPlzuKQNUDZd/EOPsIugeX4weOu4kHnBp3yt+HHZHOJ6FAap2ImX/RtqtHl8GOZTt3nH34lIlsGaDypD7mrpN/3pJ1bEsVMs7WKDlSlsJUQki3ZlR8wcWj1KTklUDbLV831jjieorNPkScXCrz9dbQh0NZhRx5Hm9V3lZ/55Ikidm2CxGaGihXB0LDVG7y8y9kJ1SasM5yJ0xeJ6fP8gspj+UuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 17:34:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:34:03 +0000
Date: Wed, 2 Oct 2024 14:34:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V2 1/4] iommufd: Export do_update_pinned
Message-ID: <20241002173401.GV1365916@nvidia.com>
References: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
 <1727358828-97791-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727358828-97791-2-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BN9PR03CA0888.namprd03.prod.outlook.com
 (2603:10b6:408:13c::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ba4fd5-ff4b-43d3-ae45-08dce308684c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OuA8nKowNjXQJfyJsBrn1DjxI3bHeOTcnpOsW+i74pXum6uYh7kellRI+2Lm?=
 =?us-ascii?Q?zJObSTGwRJaskkpDzc3NSOLf4+1cTwVmeHfmE+ASn6JR+G45s6UN+4UoPQXL?=
 =?us-ascii?Q?pCd3acKGwgnaSZ5wiH3bBrWQ77zSYX2u8DS9zbs5/HHtJrEqedXuFjGV1Hp3?=
 =?us-ascii?Q?POwLXlZM6+SmTOF6CK9OkM29347v+lzeP9gbY5K6EWB0n9STIrR4MwyBsqSa?=
 =?us-ascii?Q?9gJeWxiUqj2XvPyskcOw8CmWqTpvU32KCRnlHTBY4vXow9y5+57sJXJOMNDt?=
 =?us-ascii?Q?uSQruWO/VST8zsJW0kBJ6cVxSNpJ3DNaeKGp8IndOMDYky66ltOCA/Xramhc?=
 =?us-ascii?Q?hVPZwyqWVeXj+9eNXFvEuUYfk5h0WKwqfylP4xd0N+Yd71p8vUgivZa/6pVf?=
 =?us-ascii?Q?eEJUO2Z6svjkkenuPdul0jYjIc4Ygb1Z8Jd7WOUhEPPWJRotQ1wLK1iRu7V3?=
 =?us-ascii?Q?sPpXwG0UZ290CyloJAJV+Jo1ONS6cwL9R0aLFh6nBbSPTLyXi8jYCfFq+EYb?=
 =?us-ascii?Q?s5DGHOX2XPw+V49nZJxDl2HB9AciHOfibp7fSABkJ/8L8Za1DFq0P6sphDeD?=
 =?us-ascii?Q?QSU8y8AG48kXSE51iWeUXDn9YydsjbUUoDUU10oREEu9kT7XMRJp18jCZlK3?=
 =?us-ascii?Q?lVg5J+v6wRAw/EyPXLKs5Dv6vbtk6PEjmFfTVYRy5xw14TMTKZSAIFkTggFQ?=
 =?us-ascii?Q?fAUquv301qpOL/bFDplk/bpAg3sRKkIa3NwY4BUqrYyPtUpd7B2fhUwHpjzn?=
 =?us-ascii?Q?o0dfDhadI8OOzfN2VWpyvokjOFpmWJufpNDqvqyOcMFQcEV8p4yykX+fvBmy?=
 =?us-ascii?Q?Rm5BrotcUvdxCJavJcurmv2kD+krQOk1W9r5KhtFyP4MrWSPhSV6Oz7m74Tt?=
 =?us-ascii?Q?Nu5H+gc5xcZB+T9s/73AdsH/8y9JfQn4Rqb5acgU5ufthZy+9QuLLfXhyzRY?=
 =?us-ascii?Q?ZIywGxR6O7yePHNvzi8yL7xMLL+RdH9amUnSCG6IwaWYyD2qxiS+Y0jBvTjx?=
 =?us-ascii?Q?wQWCy1SDLw3qI8hajQInnBHzrhRM5SNiLsrfYpTkoNXgWe7BVyEhXL1QfEqp?=
 =?us-ascii?Q?B7h6eJT3vmMLvSvsMlPEmA8LUzWD0rpRz8nGH2Lys5wHh/1pB8BlkMILX8V8?=
 =?us-ascii?Q?NROlQWW9IOND7plyiz3+NSE+R5ZpF17KMl/fFX6QWOlzzLWtD5jBNCWog11b?=
 =?us-ascii?Q?wjtnCGlmnWkMvtHPVoExlPqpjz23cUaMpEEvc7C7H21ywU8m+cRExDCEUgab?=
 =?us-ascii?Q?2rk9qXP14XguBOIMMObUhKcgU3gvjQFV9fL1+1krdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Mid7pQlkuS9rl1SKVmCflMXMEv1nYiH+lSVU/+KodUcf9dDrfpZRyQChXRL?=
 =?us-ascii?Q?W+YOaKWjfKr/zozw6m/JPDs0+eoGZOI0HIKI+gXt29KQ3yWMsUzCNFuoNEfo?=
 =?us-ascii?Q?p4I30wQ3mP4fk5f7bASS361pI1mYNzrNtWZiN9xwN0WgbMI0FMoFepEyJ3/W?=
 =?us-ascii?Q?MONQYOij1J++lgR5VE5SlnUEu6PPMTyqXKVGmrGGJb4UKpdebgXCgFbZFUKx?=
 =?us-ascii?Q?bqyRU/83gPD6pKYJd+7LOVfz8t90DtjZsDCbkmYm3CMhd4MBoaTKdq4vZbip?=
 =?us-ascii?Q?4oS3zdAfUMuntIVEKh20PmUwq0rpeq5JyGmg6YmjiJEuyo8CLuQPTTeD+Puu?=
 =?us-ascii?Q?Gb4m2WVRTzRJ5P/c4bnjCWlZqkie+3/zwAJ9gJwQCo/T9Hzf0o7F/JRTJJ7U?=
 =?us-ascii?Q?fxNp/8j5iK1wCG1BhwQCET6DMStfm0OxCemY+/ePTB1LQARY/t+79Hd3L8w8?=
 =?us-ascii?Q?V5c3Y9lfI58wNLSaDOv9/texWoRaiCYLv2eYev6s1ElAodPgu2vWx31TEUoa?=
 =?us-ascii?Q?LkARVcq2yzn33YQNACixdmLDSgMo82ePMPhV1/s9TmO87DIucU//27CqWSjr?=
 =?us-ascii?Q?S+qbXz+j4S/SdwxU4mt0iFGljG6DLjZU4Ks2kQYuGiT8B/oIuZKlNw8Xr1U9?=
 =?us-ascii?Q?e6sdDLeTA123Ms3BCSuWCjfi8EeKxyNwWkCkV04nSw4UjQF+i6eehpzLFNbb?=
 =?us-ascii?Q?KK0GWJ31VGwimWeCM0Bq5LXojrSCBV+mXBwLVbCSJc3fGO4O1/da9GmtKZS3?=
 =?us-ascii?Q?nUgpRE22A/9O9s4WvDNlEKWRt05tqZnQx+2sLrkMWNGvDg0BAlg8YmafjzA5?=
 =?us-ascii?Q?Fxu1AbWxGHbQhOUUVKt6qaqDbascEbT3PkCO2pKt2O6rdi0VIfBENB69fV0c?=
 =?us-ascii?Q?KBJxWklGSJpqVNbmtZ5M7U5HODRzI74wa69ZOpwRs/JmK5TyJZVqmhwoQimA?=
 =?us-ascii?Q?/r6h9L8c88jAyfqn2lYHAvpQ2tTpXubK6V8zEb0bbWYGc23rR8xfpXM9+E0P?=
 =?us-ascii?Q?eb/eesHD1UCkfjRhjeIqTYIEK22A5pvH27xSQtKLMNj0oOAey6hy/IbHP+iF?=
 =?us-ascii?Q?L5gShiboa0yiVVRbNkkW/q2uGy9+10LN3Vge5rRZ3/sg3fVQMUG/oABi8Ga3?=
 =?us-ascii?Q?K40qR4U5naT2y8+cjNDNo0EiKtjtYpC/P8RiSKVmrxQexUghiwm9/jbkkr8u?=
 =?us-ascii?Q?9IoD6OjvHxW5NqZzf1dDwAgrm0g9C+YRBTXz+vk+puB0BD24MGAq7es+YQJR?=
 =?us-ascii?Q?lECf1UCf4JcwyKPAhY1TIe0wnsaETeJ5kTrJRJf4WrXWiU/vF1v7fzccKx9p?=
 =?us-ascii?Q?59jo7taY51Z2GYb02MoNqBls+HmHRAnj9TOUfAmW98IG1brVS+tOFUkQDfh5?=
 =?us-ascii?Q?ZtOWQQRAM10nseHgmk+N7G1LAo+MQMzHuZ//+7DSmp7lNc0DO2ELFTaUdZzT?=
 =?us-ascii?Q?I3AjUu6dDiaSa5hpyzVkak8YSYESy3gxBt9+2TqmZ//aDoFx3E/I01ltDyhz?=
 =?us-ascii?Q?TSxitbzEVaKtzAlL7HVWSVyfM0UZcJau1M5ohmpGJuWEzUSDbidnQZZ6Fyoo?=
 =?us-ascii?Q?svLsY6XvPLE/85p9wQI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ba4fd5-ff4b-43d3-ae45-08dce308684c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:34:03.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+h7gEETwE71j3VoIbxuxNyz0Wdvsj6mchfZw+qCPvDabVG7RYHXvYOf4g6vUsHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289

On Thu, Sep 26, 2024 at 06:53:45AM -0700, Steve Sistare wrote:
> Export do_update_pinned. No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.h |  5 +++++
>  drivers/iommu/iommufd/pages.c        | 10 +++++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
