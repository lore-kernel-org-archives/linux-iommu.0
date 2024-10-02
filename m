Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C51D0F62
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890153; cv=fail; b=ZtShzIP5XT8TFTu9MJf0/vkQJTby2YjllWojIoQUOS0rC13Oge2qMkIAHG9kURN2Abn0wlf5raXGqMtMNKbMtHq1LTvFjSkbHYCUbf9vaXG5UbVZ/LrmE7Vdv5ykHbTbkle15u5P1SF7t320BcaGCxPOPit38lEZd3RE/yhrt44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890153; c=relaxed/simple;
	bh=k/6GHuNcL7u8N9C96Qw/P+svV2SkA/MPcUYQ5Aqspsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ow1W9ERYXG3bMV3ZJdvpQOEgvN97yhnXS5OUCX1Qd4fbsHEICBpG4eqbkpcRiwCeySgdXqc88sewSc3lECDFPDqRRnXJvZoaRS6FkfVyRWyuUdbo8B/7xdOudZUNOf8tCs31ZqsmUd2x7VFnFhWxnXAhBQZBfaNuA9NzPm+ZjGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OSYhan6S; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OSYhan6S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvhxv0AjQGIbd3B91amx/NIFZho8KoA93s7WCg9QbcVhcmYxVTdmctz+F4sSa7C4cH9kiMcMrX84E91drZoupFOuRqhG5DYDEH3Qz1Li3jfHCkmGpSq443TfR1aVmGR14R8VhWYygfs6xOYxl4L5D79tELKb59zTuo5pf9OTjQzEYBQOOn/kx9VxFF7MCzAnMripMhM7Kk51dWhy6w1l5Jk8adkR/vcWmP2WuQ1bpjE/07ghipjyQ7l+vVYucIBH31XYabn1bq/+uoUfgdvppxDEg+kaLjaRpqu/R7XW2Y8sEfx6mOOwzMdOoHS+/VwICo/oxj17nRoyzCTo+Zs3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shiaXUFKLnEVoWUc6M3ksQ/HrYLmh2X7e/WTgEgqQQ0=;
 b=GezCHGjFudj2NunehZg2BWB7MbBU/OVAqtUurA5E5oOiejyDDnLun13lje9ySN4YqpyZUPuM5kfYkJaV7zpVtMPrpa2R5IjVlrpNXLNBqrGZaRp5fRSuaTkT95IdbVa5fybQynEQQo6YWldRngWbR2AibbTcH4JGwqWVF2mh5QY8JF+B7zZThvc6Kpl4bxnlaIWzSbOQrofgWHgc8j+lt/DZI7VISgo6HB6JWNCngSd84MgHfm+kdZRn4F1Je9SiUItOON9bRxgRbXkRHDO/T/Rq55FIJbpd1quo/vKmNyDgerKkF0daiz0LVdHI1VmRbQeL05l6kR3NO/Mqsfg3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shiaXUFKLnEVoWUc6M3ksQ/HrYLmh2X7e/WTgEgqQQ0=;
 b=OSYhan6SSQalVC416xxWXR5u/BY8hbiIErcTNDHIIwRKFUxUkyl7TpoDeN2eDJ7i7pB6b7khiu8GJkmOmph0WBJ0GZtHhjuayNgHnYDutZxeQEOEmYOvamFO+hvRdFsV3DbhRxEyYRboWc1brJm/KSSdqnavH4vrB2anK21l6kps4JFQM5/2SlbmUvEJ2aZzAdbmQ03+csEajgpAPUUUPOfiWq2l2WkPSWkzZed7AUlKoNIJ30/YzEqotQsQbWrJOLi+is8rufsrtN1eEQvImAjLVVGJvIP4ZSRPN+kFfycXgt/NyJom53EJBIbLJ3RTmymrFOeY0s6ZRMie7h9ZFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:29:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:29:06 +0000
Date: Wed, 2 Oct 2024 14:29:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V2 8/9] iommufd: optimize file mapping
Message-ID: <20241002172904.GT1365916@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-9-git-send-email-steven.sistare@oracle.com>
 <20241001210356.GO1365916@nvidia.com>
 <a8005da1-6f89-4934-a010-73867b596239@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8005da1-6f89-4934-a010-73867b596239@oracle.com>
X-ClientProxiedBy: BN0PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:408:e9::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 91828cfb-52d7-435b-cb33-08dce307b759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BK1wIhAVm36ZJBe9qTDB7EWLrqjQKVxuP2r5/Qj0wKQPgKPuYBg9k2cTZIvH?=
 =?us-ascii?Q?whRkeDeLuNARNPFjPvYTzOvJ8ZZmEpsOee3bmoVpezTcMivh8Y6FKNEQ4/mW?=
 =?us-ascii?Q?awD3DvPkPxRks4nyLRkWAt2xdYtxyaWZg2JL6qHacr40V991Ou+GS6rmEah7?=
 =?us-ascii?Q?mHX4g7QNiPWbMdXNvW6cxFk6ui1foM+mYJtcLJNydBptG9ZmMLwVr3ezBheK?=
 =?us-ascii?Q?6stvXPpjrWELUHZsFSqeGkwWyowYu4G11miKX7IwMFtM2MWPSYOIwDBewXO0?=
 =?us-ascii?Q?Jn9JTKSF8CmH1Qz0WSaOCoSbhmEM0TszpnNVwglflLp/oLJB+qwSX6nHCoc3?=
 =?us-ascii?Q?wY88xP6gJdgoOXejAl1AGIByizBs45U4XOUBNyRRTm5IZqyScqCzH9I3YqoW?=
 =?us-ascii?Q?xJDt1JKp4L7Yq/zyA/XMJI8iHxkkLAmHplnXvFyUCUHd3HCnAzmx1VEH4NU+?=
 =?us-ascii?Q?cKziwsbf4C1wyC0CCCQAWY/pjJsVcZGnZy4Hb0OmbLVRwztmTmDIU4fWrTjc?=
 =?us-ascii?Q?idrKeBD0ClSOJkuuBj7ASnQnZluCDpCJ5RBA3k0NwYUhwtmkgHqs+U7A9/zn?=
 =?us-ascii?Q?BM/MJ3hScct1dVez/OpQr5G0K30C55wvwil4b97a2X7wnka7z5AMqFBi3qMj?=
 =?us-ascii?Q?5MZj4RJ318ftJ5kGmXdmhQGEDpXM7ySeW+e4SFAbUp8cYphi/6BmFvTVS4Qs?=
 =?us-ascii?Q?vI5p95oeBQ7+fuJqcCvpsGUUPypkCKTKNtZGWQZ15PbdINp27x+Eu81UE3X2?=
 =?us-ascii?Q?wjx2wHxRy6Hc1HjSAkZ4ZJe0ClJvjXEUx+ovovMJOMkoxfYLif5dKJkqaqBm?=
 =?us-ascii?Q?zuYZOGnGekD6oE3SkeJ4T4on6plDC+pkGWi9Hq78JEBvyhbJibOUoY/8wWO1?=
 =?us-ascii?Q?cskpnB5hJcgVqOjzLnMEE+VsXgtOKQUzESSgC/v/qcfX2o1vPb6nX0xts6h9?=
 =?us-ascii?Q?iPQvPiXCawAh+UAPGEa3Ql3i3p2Ro6zIhU8I+RG4qZ3H9+u3b+G0aSj5F/WC?=
 =?us-ascii?Q?I8r1x8ZN8Oyd7wcX/O7wB3CdHTPvVdbuzUgKU/0a1VE2PNGxCXKkRtzWmyG3?=
 =?us-ascii?Q?5NzrPL6+uMiVSAIGgjP4bki29MVrejPpbxkgrWEotQQhIXgzza9NL0mhhKaM?=
 =?us-ascii?Q?GGgKHCEkccUxLJJ9k1QulixdI5Hit1Xio5UhvI8/2qjb2iBt7khbrxw6PeWM?=
 =?us-ascii?Q?318Fvzf0/Ot/x+88YEiLTIQHg/+LCwODZ7fsRauGL6p/hr66PxfNJ3jAolik?=
 =?us-ascii?Q?MGcW4IcoCByCbs4cwHluRwHS9MBEZRSocGRQj7EXNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ncu2+1w0BXJOcJWZMcnH9omeBiyvtzzkuOjLciW8QJOcyfLFYXHBAv2sHhdn?=
 =?us-ascii?Q?L8e89hZgVMFZrWkj+Gl/GI4K8vmzHkNMKFvuSeQ9SlRk2PmnJalFyA2b/UPe?=
 =?us-ascii?Q?5kkvKYb6PDXudZN9sCDd7bOp1/ySOhM2kRxUjR0kWknSaBhQiHMPsuGNeQNm?=
 =?us-ascii?Q?BV1eK1z+JN1THzjnL3Fife6JNIX9hjmNRljKfvzxP3L42UpqDE44ZoGZNluK?=
 =?us-ascii?Q?yed+1TDxV9K5B+g7Qut4vWF5daxD1vOtVaWZXVpx6Yh5JNAMSIOynyW0QzCj?=
 =?us-ascii?Q?xYmDfHDAJiLYkwrLuEnQxHTsH/bbJ0BuKwSAH6x4e7Zml85Gg6eW88JiBVi4?=
 =?us-ascii?Q?3otNvWig+2CEx7TvFFIMr9vcv0n2KVBcBWTmzbJNuEjcT2GYnyz4w/55oszk?=
 =?us-ascii?Q?HUw5pcp3XG3J629fu7q4/LjwPtIHJOQ95gw+8KhE8HLvyjJO26UIbQNvssWw?=
 =?us-ascii?Q?1q+C8NBs2Q/ZfE78WF4seFph9JOMzjVgabnowKtOdN53nN26JXCdDE1aCxU2?=
 =?us-ascii?Q?FBu1WHLuFuIA/cmqV0ut5LeBuJxZWkphaGBzDrScXmPe8065r+rkSBvVQ2QY?=
 =?us-ascii?Q?tFBB3mM+y0MdPWWJr8dFHO3k9BJxMxDWdp1OLGf/W89rzViCNHWyMKO4Vxqe?=
 =?us-ascii?Q?i2w8ry3pNmlN50K/247VeBuQXGfx77Gy+P0iXjSNAL2lH6j9d/uQj51TFZRQ?=
 =?us-ascii?Q?32EZZtHn1mNxWppe3I08PxjtRzaLfcaoG6lVQm1ebTm1rW9aguMqydVslcfV?=
 =?us-ascii?Q?5khQ5HW9AkcVg6yeB67ZII8sv/ALtuPRoAUVm4R85ozfjIo4MuUfr30Wg+00?=
 =?us-ascii?Q?KESE2cPeVwLt2o7vOIWnT6QsneaDHdMIuGhkyICoS7KVTORoApJFXVzMs4eB?=
 =?us-ascii?Q?rA28N8LSzqjD1UsVfX6qnvM2MyOL/39IF6y8+irGdgoiVzInlxyZT0oUzJ5K?=
 =?us-ascii?Q?QgKIpfUN/uoL/O6aIQgTE9d0ti7gQ/BSxGI8BKB/Ioq2OEam7PjOAZeeHsSf?=
 =?us-ascii?Q?9cX3+rricoZUD2LA92faDHYJxCuWSLk7O9fx0pKJNmpUd3NaDNKG4Iu6GHlC?=
 =?us-ascii?Q?Nh9kPuzY4VUPHhY6JpJ/KQB7AncvBKoPtAnknoT6l5t+0W6pl2dbkqVB2g1O?=
 =?us-ascii?Q?CqM61CB39qyUxGyd02FNsjxx9NP8Z6m4CMwweIF4A3gMiMHqZOgyz42hb/7W?=
 =?us-ascii?Q?wyyPRvMhC6G54by/rja5fgWBA1bro6HgCIFHqjY0KGH2sbnvmwI7kR/mYzsy?=
 =?us-ascii?Q?1V91l+19D8VxojLuj794o4CZ/cxmZqo0HezlrkSyuvBe0rXfTVX5dayFZ73N?=
 =?us-ascii?Q?O6bylmzbUIzuPph4Wg0L1NVj4Ba3Q6AxwC6GEpdPc/eKrkOT1KGuwSC/5f2u?=
 =?us-ascii?Q?xZJ/G6GvzzsmmdcAUcV4re6kN4AKvzARKUOwHb9gpBbEcP2MJvwGf6gxf15k?=
 =?us-ascii?Q?zglVkS9Ci04M2LmSUF90O7V0u0J4A8BK3aVdAmAtSGY1N2NgsWJJmglYUm3V?=
 =?us-ascii?Q?2Ba86bPE/jmujdW16CR89CmgObdnVXmVAYBUrTuuHIe5HLvac8bfUqPU3uta?=
 =?us-ascii?Q?OQ6lLGX1YG50AfPqfyA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91828cfb-52d7-435b-cb33-08dce307b759
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:29:06.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQrkHgZlR6xZmXmDNIE7qQm5KT8IZo3Mjt0ioO3MvDchzXbGEN//w9P+HppM8ONj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494

On Wed, Oct 02, 2024 at 01:26:32PM -0400, Steven Sistare wrote:
> On 10/1/2024 5:03 PM, Jason Gunthorpe wrote:
> > On Tue, Sep 24, 2024 at 08:05:37AM -0700, Steve Sistare wrote:
> > > @@ -622,6 +630,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
> > >   			break;
> > >   }
> > > +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
> > > +			      unsigned long offset, unsigned long npages)
> > > +{
> > > +	unsigned long nr, pfn, i = 0;
> > > +	struct folio *folio;
> > > +
> > > +	while (npages) {
> > > +		folio = folios[i++];
> > > +		nr = folio_nr_pages(folio) - offset;
> > > +		nr = min_t(unsigned long, nr, npages);
> > > +		pfn = page_to_pfn(folio_page(folio, offset));
> > > +		batch_add_pfn_num(batch, pfn, nr);
> > 
> > I think we technically need to cap nr here as well?
> 
> Do you mean cap nr at max-unsigned-int and loop over the folio?

The max that can be put into a batch entry

> > Why does this exist? I would expect you'd call memfd_pin_folios with
> > the correct offset so that the first folio was the right folio, this
> > is how the pin_user_pages path works?
> 
> We need folios_start for the case where the 'if' branch below is not taken,
> so the folio was pinned by a previous call to pfn_reader_fill_span,
> so the requested start_index for the current call does not necessarily
> fall in the first folio of user->ufolios.

But that should be handled by keeping track of where we are in the
array, not searching it again..


> > > +static void folios_unpin_partial(struct folio **folios, unsigned long offset,
> > > +				 unsigned long npages)
> > > +{
> > > +	unsigned long nr, j, i = 0;
> > > +	struct folio *folio;
> > > +
> > > +	while (npages) {
> > > +		folio = folios[i++];
> > > +		nr = folio_nr_pages(folio);
> > > +		if (offset == 0 && nr < npages) {
> > > +			unpin_folio(folio);
> > > +		} else {
> > > +			nr = min_t(unsigned long, npages, nr - offset);
> > > +			for (j = 0; j < nr; j++)
> > > +				unpin_user_page(folio_page(folio, offset + j));
> > 
> > Don't loop, we have unpin_user_pages() for this
> 
> Cannot call it, I do not have a pages[] array in hand.

Ugh, still, don't loop, this needs a new mm helper then

Jason
