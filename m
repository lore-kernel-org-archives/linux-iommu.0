Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0C1ABEA7
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689308; cv=fail; b=mYKyRDOjyp16fFCWqJ6bTFALxQmEvTKL8x6/GfqyCOPlX/kRWA4EUkLQwJbZqSF7Jc5x3SB7OLcKT1mUZlmkGAuLWq4kgiP2+tRMXdty8sNcudXqikiQCZgFBUUCFMnjby5vwOhrmpICC+nJs4l8V/xG3GAVarZjYyOEbtBSBeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689308; c=relaxed/simple;
	bh=rEE7V9Tg+mtcXe9qNlUeX+Q/rKa1TIHBSZy8jQUJnD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=upu5lwz4DGietBNyohOqZd5/JJtWkr3pghlp7egfpJ7nXuznptfbGwoxwFbD/+0ren/DiB1R0rqmIpuUUqArwkzYs870xZhgNzp0a7SUim+5G0cO1aru4NUOZ1qJ2NjThValv63yaa/sAAC0UY5U40pSvMbJsDnQtS39wdn68wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AsjQz12D; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AsjQz12D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVNK6qQsaDay8VGbySMhN5+FY3r3RYre1iXBZ5+1pNTxcbsNCQdRsYPrviBqgdIFq7UNGq95LF24/HrQIwKFdJpCjc64lM9l9plM2Z6MHqhoILyiYi4Wo80hO1/t4CnE6G9ciPERCpPumBVvsOqp62djH00PjwM/Dihb2TZX1KzLX9lhg5/K/N05hVp27mr6V9nTv3662oZc9GoIt8IFSBanelFSjtge4Hd0aD4oCvCModatEP5A+/WIx2uyd3vR4h1xU0jzoeZhOxRavOdw9HbdUXTjUNn1TyrK8Z3WPPr3+UzldyVjC25gv7gfR8ZbU4W5Zvhe4wcflFAxubhc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cka2slhU5HTu6yI0Kmsn2G4ZR6WF/Dt5t2qjWaacpcM=;
 b=t43hHZy3JQfSaYsJun0EI2oGM0tfcmx2Wx6FxRT3PuxXc9brqGp3pQcz4JM+hFY38RJ4NY52CfEsXxx+1/1j6RkrlsmlAdys/6421Z9mkki3lV/ReoHprt5AiPB+XuMWjFt15m59GSztdYgQM3z7Ii4kRWF/XafrwtpW1aAyF84rkKE97LBeMqM5Im/6+4i+0tUs1ENPFZ8i9nDlOUUjh/MlVCtKvzQrRYdhgeSWO7SWzxugHwxYRdMbj17gyghAAC4zXBF+bTusMPAmPorpPSV52cSQFCNWXdrqargm2nquRmcNIYSymfqHk9+prmr1yRJlEc02IMjt19vUlgpz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cka2slhU5HTu6yI0Kmsn2G4ZR6WF/Dt5t2qjWaacpcM=;
 b=AsjQz12DitgACSnydV2pG38/lfUAlqRRInuWH3rUYQoXfl+qFLdVmSMYjpXTGTYdku7yde6RRXG9EIeX3BXMgtGQA2BVGZj5toxUZFj2sSUkkUivzgA2BsWYLBJ+QTR2K9O89zigIUKyKzRH6rUcKNTB9eBd5PYFVviOsOmgQyAsodsVqIztNUUAPsivfZshPNxfb28kjHdB6pLnXa/LFDg3N2D0dieW8K2Tk/V/uZ3RiwqAuRrXi7EKR/5QUfoL+Ll1y70kU+Infi2dSmmjc880bP1wrNDXGdkmUWF9rvM6p7zOf58wU9ubRkwyHTJ5BSbLjaqInmeLV0b7lYGCJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:15:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 13:15:02 +0000
Date: Wed, 23 Oct 2024 10:15:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Steve Sistare <steven.sistare@oracle.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V5 6/9] iommufd: pfn reader for file mappings
Message-ID: <20241023131501.GE864191@nvidia.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-7-git-send-email-steven.sistare@oracle.com>
 <BN9PR11MB5276252C632C19F2647EE9D58C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276252C632C19F2647EE9D58C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:208:530::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2418c602-f90a-403a-96e9-08dcf364b41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fTYzoWH1fsOlLw7+h4neqGaCD3LrThrzwQ5jPPXShILrS3zc/+oMtH/Yjq9i?=
 =?us-ascii?Q?vH2F2B+7h1G1RNRXMt07BXgYixs5WAg2wTtP7S9YChx+CiUx8vqpK+xi43mj?=
 =?us-ascii?Q?2LSMZRY0F9SNTnISo1Zr34IhoQqSbU4+MRkKhbbNOb+tD8n/wyYZuduHKHbs?=
 =?us-ascii?Q?bOmstZiar2toe+6hEVo4tlwta05qOovrhJ7s0UEGTze4s1OT6oTyn1wei2sg?=
 =?us-ascii?Q?EnJ6xDUs4z8h2+1xivEBCauEE0ixqeigjnjvkdYmK/XUQt2zbFQe37h8Whml?=
 =?us-ascii?Q?bvM09ea6v/vOpUtxLtmnbZZSok0H/lDmuanWQkDRatQeQnMxImfSUMdaw6Vh?=
 =?us-ascii?Q?36MY5Sz056gPxktqkPWIzS0Mj6C32v0X6TgHpBNTZnSf0XXAfUUeHiSY/A0v?=
 =?us-ascii?Q?p8+IU85g6Ts8VI+NU4WXe3lOjXoXHfUnIGh42bu3YqVwmFFynE6+jTo02y/i?=
 =?us-ascii?Q?n5zUt160u9M+0Ysk1t9VDZ9oMJBmzGS0hAE/CGI4Y0qzK5lebK7NIOIuulG5?=
 =?us-ascii?Q?Ulpqz0Kh8eCOtn7BGt/oL5EUYMvzCkRncHhqCJoFE++UCEl7WJKlICiodAY3?=
 =?us-ascii?Q?paniJUl25M84uAbblT6342atcqbgm0AloZX4NROiKJ1OCGNm7CeVuEbUQHZ2?=
 =?us-ascii?Q?FE5hFkQN60ixwpJBlrTYPqy7UMRxGRqakMxyJqcS1g3918I2aJ+0lUL9pf2J?=
 =?us-ascii?Q?97DVJr7iU4epcZt9pTDevI4cRK1Dbc8j/FkdmewO4Dldh+OCQkIW4zeIE+w1?=
 =?us-ascii?Q?Rt/QGmQitrhtyd3mduOQ9nZpck4O/aC5AvvD7Eqq8l2X8sXR4g0HxThQKCpf?=
 =?us-ascii?Q?XyV0BWwQkbmhbhxCqZQ2NEf47mTdGXRoAAcBo5O/R+n+Q82UIsKVDyt9indA?=
 =?us-ascii?Q?sdaM8+2xHsc4xDk/gGaV6ocqiphD0Sng/Y5O0wB4OPD0vKDtv+QWHR/+amt0?=
 =?us-ascii?Q?cgKlFpEuG3Y/dt+/boXj3yCC/iIHCy2GoYFLrS2D8cCUoMQ/scjGsr8YXmaM?=
 =?us-ascii?Q?FNcu1gjeJghemN1ovzRjYPjgHtoBs2Akfr3RO8z3AxnKHJici360Ho2hEyiY?=
 =?us-ascii?Q?OxciUVL8tU2acNVMF70fTM62TDUDJTnFtWbAZPEELBdOm2eoI9IE612DEbim?=
 =?us-ascii?Q?R19Ti2Qq4d5iz5T3KoLWkc4CxD0IMhz85NI33RsLZW7GxXSF7BH1AcpKqdYF?=
 =?us-ascii?Q?F6Wz07UIPUD+wBc7lHQrKfUSKkrYb5FmMmZ8qQnN3PBhx6tvU8xD5l4NpvVg?=
 =?us-ascii?Q?o3DABCJsiK3Mw/HM9rRoxQiEqokjL/Lf9iRGqTEzWMetl1BM13Xx8Wzau8u9?=
 =?us-ascii?Q?Xg4jR7W1crk1npZAXrHJxBkr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6g8e34Vv7xaPBxCNa6U+D2bsOEW03RSkRZvg5WKjYO4nusZ0H8O2oamlgSes?=
 =?us-ascii?Q?5AljRBbRQv4+HY+c8D1hj2v83nekcSeNGk/jEIVuqPNSmp9AHamXcHS3jFoT?=
 =?us-ascii?Q?K+Fea9cDWTN+uIKuzByJa9OFMJwvH0vLrK9WeLOGqHgcXivgmf1pU3ncoZMJ?=
 =?us-ascii?Q?YwOD2AHXtb2XodOh+qp0dNQwj/202Y+Zpr33hwCf8yKgzuKPFFAuNYhlZv3+?=
 =?us-ascii?Q?9npc+yFid0IXz36jENyLSXs2a/whyZofBKr+THCK2JUCuJwaGeldduKrstQ8?=
 =?us-ascii?Q?7Bzqvc3crL0uJ0zrN7Ly2dgeaUM9UPAaYrGpgIh4ztt/sou5sYUfEnUAfpQu?=
 =?us-ascii?Q?/FWkkqW6rDRdFAuThjhcRxIb1k/hUJQ6HGZVACo/ou6m1s4DATsZyrhwt/n3?=
 =?us-ascii?Q?zYdDTXUbzji5kLnCrUpvZJeXPgu5MH9KY7O6+Q9lx0eImatOgFimZZgrgl8B?=
 =?us-ascii?Q?LkJ9R1oQtE3gz4HHVM2lG8Nw4HkvNkR2ILYaQlN1m/BnrsWH08IvBfkvb6pc?=
 =?us-ascii?Q?UA3bOG2FZ5ooscnRj1iqyzAeZpSvpxdSE2VttJxMCuZzgqY82TrzSFlJ/CbU?=
 =?us-ascii?Q?pZykRpVURQO9sJzEnGtLSVDXL28GKD28jYdbyefiUuq2JJXRFuNBSna1QQ8Z?=
 =?us-ascii?Q?Mj9AphMENo+HC6OqZ+r9GIyX4WfQX+K/IJt+L0uL12/14njoGq4mOdr5pnFr?=
 =?us-ascii?Q?gFLLSm+VEkI7BouJgoe20F3KKd7p/6gH/Ldn4WGyzgLEOTWxvE/dVmaG6pkt?=
 =?us-ascii?Q?ygxrirR4U8IsWbBPb0A9RfoDm4LTP5ZuDP+UOPYe4mJMmyxQy4N++S0NfUEU?=
 =?us-ascii?Q?NQE32tgebqq5VW5pD5GfeTKe2hN79zlg/98mKB8q1gvYlgb2gCP5Vrk480OS?=
 =?us-ascii?Q?cyjutTZCAA8cjBUtJZoyYLXYZMuvmfKaP0sYPgkQYjOAj2osTwGQ27mhvCsN?=
 =?us-ascii?Q?KNVjvqqrRDK0G61y5anF7HA/cV9Y+vZj/6UwZ6srdoOCTV138sqtZ4m0pWfl?=
 =?us-ascii?Q?mnr7G/HMM8AEP5BMFgPZhnnpECHURMygePgYH6dtlpH1x68KwP0alPIXnMi7?=
 =?us-ascii?Q?RaI6tjea6eJey+osBWZGY7wcIkWiyqkhVWOJHcvDXDNxlbCyPKEcJbNWullu?=
 =?us-ascii?Q?jE3qGt6evibFagWVMRlV2+0M9QohqHFuQek9JFp9ZFCVjCQ2IL6oePPiTI+W?=
 =?us-ascii?Q?3AORGgt6Pfq3Kyy0kEH0EpGei/1Lmrs875BUIUEn/sUcM1g857AeqRZ9wj4S?=
 =?us-ascii?Q?I0d1h4bEX5zoJJbAk9QA1ZBJitinvUjjxI71iUn9UH3xiRzYBDXcQbo5DDv2?=
 =?us-ascii?Q?agN72XCQpEIGKJljO+HcNxFlh+7jz4+UhSzWH8WIvisWTRv3idg4mrp3J5p7?=
 =?us-ascii?Q?si0PE/6y7p1znk0g4lOSOEmq3N4D4vCZHvBl/d6jynK5bveZSQUiMHX6Lq4M?=
 =?us-ascii?Q?trWo8TJAbz9BP9ydLNM+RAtFPgQ+8xeqtu8jvE9s+DNSwd/Gh3308wxqOBxs?=
 =?us-ascii?Q?OUMfTPB9tnwWnyEUwsmNUKZGnn53oJSNJSqOd/UGcInNw7yokvCocl/hQST0?=
 =?us-ascii?Q?oqOt1Hy2nZR0YMVsAQ94JJXVkG2swZ5iPevehOEX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2418c602-f90a-403a-96e9-08dcf364b41f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:15:02.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P158Yv+LshbV4hjpEhL+5cc2eBN/LwV+FXnCzdzG+LZCJxpeqdg+T+VCbn55ncKK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042

On Wed, Oct 23, 2024 at 07:40:34AM +0000, Tian, Kevin wrote:

> > +	for (i = 0; i < nfolios; i++) {
> > +		struct folio *folio = user->ufolios[i];
> > +		unsigned long nr = folio_nr_pages(folio);
> > +		unsigned long npin = min(nr - offset, npages);
> > +
> > +		npages -= npin;
> > +		npages_out += npin;
> > +
> > +		if (upages) {
> > +			if (npin == 1) {
> > +				*upages++ = folio_page(folio, offset);
> > +			} else {
> > +				int rc = folio_add_pins(folio, npin - 1);
> > +
> > +				if (rc)
> > +					return rc;
> > +
> > +				while (npin--)
> > +					*upages++ = folio_page(folio,
> > offset++);
> > +			}
> > +		}
> 
> dead code as user->upages is NULL for memfd (echoed below)?

It can be non-null if we go down the iopt_pages_fill() call chain. In
that case it will hold the output array for the access's page list for
mdev type drivers.

Jason
