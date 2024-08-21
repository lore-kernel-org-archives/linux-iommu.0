Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250B7D07D
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263447; cv=fail; b=DLjKMRSiTk33jHRUg0+vmQTnJz96HXvHPnHhMKgjdKSwXllzo/rsKt1636rcJEv1ITv4MYm7WcSJtqATs1kTRdnF8c8ZmBgT/RdtIXtVS7qQa9huKVFTO4bfmVA9c+0jWuFiI5A2esD++rP8TEi62vEfHTUlLm0ACa9XVTjw/Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263447; c=relaxed/simple;
	bh=u0lAqL7rjFHIXofPYT8jRYUjFIYQALqKAotXo5DAo/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hq9H8ngkugcXWTeiFHeOGSsuWkRwEvC4r07VeSZh5JwA8tC/U4rMt//rsGNQyfQVmc4rJ1FTabEkYWKn2jm81SxQCYfd0gf9KmPiAu1DJlvpvOPUpRXNg18LOpNRgnV+QJw6zjcfXw3l+/os6JBYSIMaqE/DCf0fQnbFfm6KD1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D5qn3m6B; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D5qn3m6B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1pyCL8pW+NblOQ9auRXbVr9hdxfAkzpxd+kJh6QunWwlSTeNSI9UgF2Z8Lvcb6ZSNSXvDFe8D04xFn1ij5YNb01WqAoIoVvBNy3FDlLJk0gcqu/kVTm8OIW4Owl/d2In2cOIzQC/NrvyYzn5e+PyAbHe2rGvDaVi1sGZyj+KCoc7t+3eyQcNUHuSRfEXl8TTtbhIflzsG3D7othuexoY7Ki0CKqO818VrxgJl83nw1sgSf/z31wE5RENeKC/BXdftH0pxvKFK2nDvUJjYndjFEivPY5SnLQziW5jbUezS0zRE/9z+xdrO9yrO+zarnNT/ksvEZfzfKl6xbpdjfmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxI/wiw4sWEg5BmCqUII4tlU/t6hehYGDHB0XZco7WE=;
 b=fCygxo5JdebCAa6xikp3es6Colg7c+HZ+66xA+V3nO8rBITc5HcgIJY+JuopUJ186FFnKA2n66C0JhqOmFm5yv8ghF2idN5tqj8qi4cteG3jw1nExV3goR0isvqRgVyNIWy4gE0TX1pSAhg4QtjFRbFlXW9J1gNicbtbllOYpaaGo6rw5emtpeYgTH62/uzSOhNmdPpkywb8pQVQ8jqxYrblJlB7aftk+ec6lbn7STb2h8iCg0V6wHpYyiarpZsOG5KASFeHTwT5QwYv+OY8tWEPCIruEOPRZYoOcVVnTldZGCsSl0Mr52+TPVViRixNmgmGAJP7nN9IlQH/OAHS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxI/wiw4sWEg5BmCqUII4tlU/t6hehYGDHB0XZco7WE=;
 b=D5qn3m6BoPI3Q6xZAte8AZyB0AAIT1HNcN9kEukF8mxA3q8qPl/pxi17H2VePq46V/6huuuTPORi5uAMbleBOUGA31jom0Xm1VZRF5COgp7KWSZLJz0uxo8p3MPpwzNB93e3qy+hV3dEJLu3PIpVzhSnolGLbl4QD8Wxhycun5Y3qiF3i8CHPZ0erUUkz2MbQ7gCYAq8RLPMlhVcE0UwmMI1DiBwioBvK950aVZdmGlYczRXcUWSaT2TrMf3q87GoNtaHnQ45stxemsS9gIGJm42HNJ/aYR3Rm6RH66YO/lOTZycLc5uGcEtkNpuNsfW8OcexIZLsM3irnRSejhb0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 18:04:01 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:04:01 +0000
Date: Wed, 21 Aug 2024 15:04:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC V1 0/4] iommufd live update
Message-ID: <20240821180400.GM3773488@nvidia.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <20240722155500.GI3371438@nvidia.com>
 <3329e042-e4b1-40b3-9875-623f26386609@oracle.com>
 <20240806125602.GJ478300@nvidia.com>
 <54f33881-26e4-4b7f-bbdb-89f4cb207be9@oracle.com>
 <20240808195252.GE8378@nvidia.com>
 <53e7ab6b-9419-4808-b429-a88faeb3f6a7@oracle.com>
 <20240819145908.GH2032816@nvidia.com>
 <ffa07fb2-6554-40cc-8af6-e6b3a2cfacdc@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa07fb2-6554-40cc-8af6-e6b3a2cfacdc@oracle.com>
X-ClientProxiedBy: BL0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:207:3c::30) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b59c70-2bc4-4eb2-2393-08dcc20ba2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eu16++HW5Ke7pNBh5zSoNV72zvESLr8Gc8149sB/BgQ4gZPooDMpDClLgkLL?=
 =?us-ascii?Q?fZXqUtOy0cfZR/Q2dAKJtfRGqghjX6fHNTnySRJJOeiEEx8yybAkRBwGPJ8n?=
 =?us-ascii?Q?gwK8IIo2YpeqBfoolWMOCWiAnCHcbJwqkm+7Exbnt2+rC0fk2yq4xmgzefqP?=
 =?us-ascii?Q?z77b/k/tTf2GqaBuwFz4OJRD8HNirWXrhOZK4AUGIZ83x4fchkP7c9YeZaH9?=
 =?us-ascii?Q?kgGT6B09EN1rmBqsdjksA33p6srVspTCEopsVfAoOCYwyIgqq0GuWELpUPI7?=
 =?us-ascii?Q?N3wMynmXzYQufHiMNeM4q4MU+Ric27B7rg9mk5MXAa7hak29JEQE9Iv7IbbN?=
 =?us-ascii?Q?MOlPJL7ZUUVz4HT+nb7izxXAMU4bEcOVofagKuwFw+1mAMPd0EXRWznHFAk6?=
 =?us-ascii?Q?huXkD1LIlzyTTcG7s2Bqse96gMIBVTvUFlXIr5O1mEl4Ez9hW9lAhCY3Bo18?=
 =?us-ascii?Q?bT5Lh9Ahipnp851KbU7Sdf5OSE5tOR9UtF6W0LX7BQ0keipvobtiLnKo14ey?=
 =?us-ascii?Q?KFZFf2Np/XoJv9z10m5GprjDbCqGfsIXQ64nXcdjyPWqdQIRTHr9fNeWpd/k?=
 =?us-ascii?Q?dbfnl1WmA0G2Py8P0tBvsjUGIC8bwKB51hVvb/9VU3omkhQV4nA0gUo5FhoW?=
 =?us-ascii?Q?6u/+RF5Nuc5QDw/8N7cayoguAUiFIV+uzJizBt1e0GVcsQhDI6G84ESjnIR/?=
 =?us-ascii?Q?3th9TImcQDFhJJ47Cdtuwo3JcL/ah2Ls+Yfef5innG7hbj2+4oblLsoFdQr1?=
 =?us-ascii?Q?p1kj1yZmTcAp7a+Qos5ErqPklM43QD5hwHcYj88uBWLf/dv4IZrlqZAkSAYA?=
 =?us-ascii?Q?3OMslDQPtA76pVpQZ8QiadUycVx4+XC4QoSxLI2xXR+vzYWKDyWzrIXhl7w9?=
 =?us-ascii?Q?PkcuPzRKaiWZisQMM0OmDeV1a+MMkrh3W7B9VhXW+bZ+EY2M532ObHkcSsNk?=
 =?us-ascii?Q?OG42qKkKo07t09w+CevJm4o3spS2knjNhBS5b3HOQsf8XyfEDM9X3KJnJUyv?=
 =?us-ascii?Q?YkS+PJxo+L1v8oz3iqVF0lvoLytrXFnKjwtGnWFH1UJ9/tJ5UeBzxS4YzArP?=
 =?us-ascii?Q?T3mGCz365uLOHaHfpSps18m9Tw4WaGBCPkAeCPj+NZw2drfTLgghsbsQz73w?=
 =?us-ascii?Q?VmytsNgrQhtgSUqbMvmdloLBeEzz0SxfePgJ4RuFzAn5+CgmGr3yg+cty34M?=
 =?us-ascii?Q?Q3oXyFRvIS/nYvNz91D7CH2NZRymocCN3carw1o5fIvIcItSb3aQ4xr2iYm2?=
 =?us-ascii?Q?PZCN7tNravWY17wYtAlcPpMqvqPDRlo5cBAJRttaT6R6wbUSZij3ffMIZ+yk?=
 =?us-ascii?Q?Xq3zscRV5XEWFv20LHqGmLoypPcGNJYXCRdppF/Va3Dxog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F1BqTpF333hLSea2nujvKdsN1OatjBFtltBEzqbrUMHdnlyLW1KeR75Lrc2H?=
 =?us-ascii?Q?srgfpbVce5f4Ouz6qLlr8dR1g+7QtWUEJenwaQSRZcK7AcYZNcQnE3MBXsMJ?=
 =?us-ascii?Q?u83lIRA/bn+9K6AvRh33TGE20oaOIW9U1P8beCEz0MU7+p6+oy8TBOvswGkQ?=
 =?us-ascii?Q?NnWdmYne+EzSxq9lQMXEtEVr805a4CAFEZcRbl84PRRuD/8iVFYnZMsAwxMd?=
 =?us-ascii?Q?oncLDDcsDWFGntPg8EeTEeJYHlN6ACK6+s5TJzjxAe3IYOeWoeWty/6Z+ExA?=
 =?us-ascii?Q?J/0pZFFcaFO+G+eLmMucxvKrDbBDJSS0elo3TBn+UDuzlNQhCDfikEJY+EYj?=
 =?us-ascii?Q?v/qTc3zqyeGr3VVKx9oL7nGZcAzxTbvtmCa+B1ytpZZvoFIZ8rd8azrG8Bat?=
 =?us-ascii?Q?bVFuwyR5qveL/IioCsupFkyqBdBMqGg2vna+tNi2S36hisMTbJbEWqd2EqL6?=
 =?us-ascii?Q?FnXOOErs0t5SR7y6HXAj3p3QEuc9i2reBUz/juip4PUrj/FV3blb17XGrk6z?=
 =?us-ascii?Q?MadnVO51jbrx0e24EDNctbdWcDIvy+i1UQA28Qud3sh8XH/yvZrrYCHtW8LO?=
 =?us-ascii?Q?JI9ZtyCuYVHjSvNhwNpDSmsOi9QRrBPAzLhxz1RiiAB8Hiw0fpxvuKjj3QYO?=
 =?us-ascii?Q?JwGirP/Kl+4aD7G58ulnAX1BqXDfUxb41TzhclEswbgkwRxW3AQy3b2i44Fa?=
 =?us-ascii?Q?HWLNnYeLrcGuLmsJ4s3J86Fcrqbn3lCdufc3u6S5ZyGEEUF+luhSNbGxiwJQ?=
 =?us-ascii?Q?k/zQL/7rToBbLnuzw5b9WtuDQjK0vqZeS201Ft7mZElv4P3wvcOGePJlKdhg?=
 =?us-ascii?Q?Zab0Id6DU9AUtUyJN6973uD6s/KezgfN+9WTZBuHGnBmSFAryb1CNpOopqmG?=
 =?us-ascii?Q?52XiSeYynt44WUHLTWG7g4felPErEY6gjlgmlYYvdBaKeHXvvTfnUaZwJng/?=
 =?us-ascii?Q?sOKokfje9DkZbiZlFgMzIPI0orx8yJRUgPQFEZ5wyaTLqtJqFFewEYtJyGv4?=
 =?us-ascii?Q?MUJjx3UWSPc9VsokcqCittyMj2EbEnPvBLaz2db0tnzPGkBUtvIph4aHo+ss?=
 =?us-ascii?Q?B8BGuHfFHz1VYW5t8IsMPRX5UuJjzzLsJuGHs+XRWg6f3S4Pg71B7f1GEJqc?=
 =?us-ascii?Q?3HU6+RB5VbGUWMREJblMmdPJUIWYZSrhHwyt1rpLrz09zFpdyPl+Ayp8gbzK?=
 =?us-ascii?Q?9/ZQzpaYhrgqXh8DWvwURBMSUGf0M1FxZws7neDPDOg2joZoTo0wa5XVbP0P?=
 =?us-ascii?Q?YhpDh7CyLxKjRRBDOY92iWN13M3h2qfWwU1mWY7Kxar8N09uleP1xYPeh5Px?=
 =?us-ascii?Q?SXFeq+/x1BBDHDbxSyw/OPXxvwFLXR9B1RABdEBi6XOYbRH0FaoX8Q/D29FV?=
 =?us-ascii?Q?lTGP978PXOHlUVMRcWRWO2Z30zZWtx6f9yU15VgDSDAjFFwdQbBc5wxA3v29?=
 =?us-ascii?Q?3H2G7Ph/vpdbQISyu4LTWtfGPLrc8/osVF09PckOgVh0x6UUsrHG/4U74a3C?=
 =?us-ascii?Q?gWd8Oci8jCJ3EejgO0e4Ranqv6A62mtC7bov12WhMain9aSin99fEA7GCeXS?=
 =?us-ascii?Q?ObIA3qC784e9HT+afC3UK6zyxCgISBzISOakMOYN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b59c70-2bc4-4eb2-2393-08dcc20ba2f3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:04:01.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH/ZxbRpMASE4ir4BjbkP216Zb3bSGn92gVsE5vDHtD5q8mELojEhNozb0S+ZhFt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

On Wed, Aug 21, 2024 at 01:54:04PM -0400, Steven Sistare wrote:

> memfd_pin_folios() returns an array of folios which must be saved and
> later passed back to unpin_folios().   That's a slight bummer, since
> currently you save memory by retrieving PFNs from the iommu as needed,
> rather than saving all of them explicitly (with the exception of pinned_pfns).

You wouldn't save the folios directly. The existing PFN mechanism is
fine and already works with folios memory.

The mismatch betwen gup returning pages and memfd_pin_folios returning
folios is fixed up by adjusting the folio refcount back to page
granularity, then treating it the same as a bunch of pages and using
unpin_user_pages() as normal.

gup.c already has code that can do this adjustment it would probably
need to be exported. Something like:

folio_refs_to_pages(folio, len);

Then don't change very much in iommufd, just stuff the folio's PFNs
into the existing reader mechanism the same as the pin_user_pages()
flow after fixing the refcount.

Jason
