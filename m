Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555391420D8
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350806; cv=fail; b=iW+DDvUw6I62ux70D+JbTqexiWXYIivW85/suW/M1a2uSdSEN0LFchw380oyBu85cNo8oBRcyK6ZHQgseZUwrcLV0+YNxmqAWzlrlpdkxUDCCmAkGjG4B+pZIoY1sM37GJtwCGYICtrvuMgJt0NW4a7Vm3+xw0wnvBmSiXEtK6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350806; c=relaxed/simple;
	bh=sRqM/KS9am8N6RAcxo11+IzxftNgcQJnZkIKkduGDSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G9BPaDd610FDFZbmAT7L8CC6A+IlgQzt8ruMQvbeujN4Xo11QuH6YOIv1hHGnHJy3Rw3C96jdHtI6buQ9rV662LifhwrEgPgL1h0KvwFdvlPYvj42zq7JDeyM4/o7kaG3N8khlEIC6eCJ+ORRfq4iShicNdC8o8+21RS0kQKaLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pe1zbMxi; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pe1zbMxi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ba2hN+Fi7LPHS9KZ0N5+fedP/s/212bn9H3A8wjG5Xa+rMilnXEmZNfAkP/RPzQ0IfdBPBk6KwR8VtVKmjkoPDke12pbxbpF3uHhIaoUL8TL/f6/tAQjZyx7g6HmJnYrF8vqb/gb/7wZTbXFYAhCkxb5DBf4pLGobqXVpEC+Yyf/F7Y0/AMqxN1b+MlkGTJSKdHtoD4mmlldgdfSvob+O+UGQog7kDTvI4nZrmC4eNamGbeVyqZK2MEx6tRRFiARp1QGqLQ0KLAXNPxCuvO3DekzkjDc9iX7E+W1pQ04GyqOSravJ3R1zWjmnp6j3s4L6cRtOReOHkAVOYs3G7ZsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT3qxxK0oLQYr97TL4sNi8KWIp23cOZuwAO2TWkQ3i8=;
 b=rfz+Eb9qUy3VUT0zHTFU01TlIIbtt5s2tBzNAvBK4P+Me0YGxwhoHl9Jy80dvmICwEKwqJd6co9BnfotkmJg0prgvLUct9V88k7Dgi9TzZNvd005+PivCuDjINSKXRCJGrS06AbADt9XedqFKL/H/06PVSYA4XzeH3+htNSC1uqCs2cZxYRR3n1Igb1BJEZgMRkqec2onrRbo/FRBzt6k0dq1zx1bTl37ubteFXisXaXdXZwZGrqPUCol06NHeoN/1N/M46KYYTCbV7r2a0WA7ijS2Yi5vqurJE2R20b22JDxf1Y41g+txWQxQ6i7Z2wuLZa//GtmSeCVwasHmFY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT3qxxK0oLQYr97TL4sNi8KWIp23cOZuwAO2TWkQ3i8=;
 b=Pe1zbMxiqJGBPb/M3r4L2mx+5ACYw1wBEP80xFh9JTDtS3IxH9OopPVSX3WZ6+9ZWGU0W76wr1VYKD1XjsTIECndREKAoL6IrvQEAB27fo6FkukQfcPWtsb66xVPaJ2dI+7BwsOdrv78/NXlZzwm9LnhirAXcsEwiFBpADFmOzTWBB6itmkc5bCfsjchY32hIJqBBwkuYtvu2ntcoSs+/3CR7i+wz7CGWiiJCTSKW2sepQxkuyjPcqaFCXVguMrEGaW3GkrrVWkBNXUoT0GVUS9aqrUBJ5kiDLWQmaVKgqxGIxXWljpqZAyWuXwY6dpSox6KaT3m14B4Q5zNdUaf+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.31; Thu, 26 Sep
 2024 11:40:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 11:40:01 +0000
Date: Thu, 26 Sep 2024 08:40:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, linux-mm@kvack.org,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
Message-ID: <20240926114000.GW9417@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
 <d25fc25f-34aa-458b-973a-f7de2438b837@oracle.com>
 <6aea6530-9f9c-4a9c-9c9c-2c29e8ae9e9d@redhat.com>
 <98004c8e-f941-480e-b1be-8f6fd925871a@oracle.com>
 <dd50a217-d492-471c-b708-a400c04e8444@redhat.com>
 <Zu14fVDpw1RWYevL@nvidia.com>
 <27f8ff84-76cf-40ee-b391-e226218e5600@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27f8ff84-76cf-40ee-b391-e226218e5600@redhat.com>
X-ClientProxiedBy: BL1PR13CA0404.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e87d17-72f0-4721-ea4b-08dcde1ff4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lO6dgidYtCjBaT1KvLCCzfrmki2zPMOxu7vFF912ZewQd456/WKn+b53iuzg?=
 =?us-ascii?Q?xLnm9GLkVXxu1FuzzKYTGQX7xS3pG3vs6QmRJ4N07LzmT51sAXw76+mlxf6s?=
 =?us-ascii?Q?5NN73aSSPBUyo3G9Ou1KAC/lB/SAPWJ7BiAge8+Yd5RVQz5XKa6GherB1Cpd?=
 =?us-ascii?Q?YB4PIZg0h8WxUYt/XO6DmvDmndlpzDwbT0db3i6XYvJ6b4ABviwFQFPH2C3d?=
 =?us-ascii?Q?XIEIpwwYGAbp97goGcklR9OmWweJ/BJgxCbQJKDLbfgjcKlBM+zeycC8c9R0?=
 =?us-ascii?Q?yc7M9LrYK6Oenfc+MNukXD+LYnToDbHCUZuVYfvsWc9f3jdQFE5vel5nC2ne?=
 =?us-ascii?Q?UjbDeJrzmVOji17+yAswi4g9ub7AYAe3IFFLHez1PVioaMRzl0wi67cNyCxL?=
 =?us-ascii?Q?BEM2/J5TZFCB9TIBTxvc5HUGIahCKj50wF/RSeI5qTZFKsJMzT5YQNtbfTaZ?=
 =?us-ascii?Q?fFQZiMI36Re7Hm2WdS385CZLtzF1dHQPAh8z4Hbn2xDqm98GMdAWlGQRNxzR?=
 =?us-ascii?Q?n5DFvRdq7uDkjLGvz1Q1GeUDzAYqOLWMxYqtCWGH6wFHl/QvyFdD1LbqVw8l?=
 =?us-ascii?Q?R80jT8V0inxr5mqA2SZFBhF547ZuI21lv52tbYzbWe1rqdvaCUl5ltX8waq0?=
 =?us-ascii?Q?/tf9iFVmsCoLngRvu9+A8YhwCyc9toRbUfgNLofvg5YwunwWa23AgiKZCKMR?=
 =?us-ascii?Q?nbPBSl8obFttFmf55sk8Qt0pZFCjheGoOEGw9LktsLfwTW38SEXLVrjrFBkI?=
 =?us-ascii?Q?prlidWlsLRORRJAyDSdGmrmG5EahafXwgntrne5Kao+S2yYb+eAIWFpJ7xm4?=
 =?us-ascii?Q?Yq0YtkxORDJN+kv6P0wh/MSTmbM4/rYq5LVp32NRyxngVFS9dSPllzvdg/v2?=
 =?us-ascii?Q?ljAPZRFeLTPzEfaklHRWL6gLDAIkIf2BluGnk4T9N5JPpgpUZs09BUuzs5mG?=
 =?us-ascii?Q?1vIS8yZ3CjqJ5fZeYVH3JOYlHaoJso+Ef3hhMaUx/RxOZQL5M8nZCaFHbmWy?=
 =?us-ascii?Q?jCDmBSfaDWr4WLpZG6RRWAloyKndcfLbxc8tROLLRFa7boMyAy3+3E/4rATJ?=
 =?us-ascii?Q?klClUcwXke6IZ9jClRCSsXto94yvYrDsvWeKldaew1PENuc7Q9cB65AEbZBj?=
 =?us-ascii?Q?zhOlf6YGyxVJ/exPbdVz35/gJ9CNEsqZTFv61/ZoEc15iADp7Sw6M5jFd8Nc?=
 =?us-ascii?Q?nfBE/Mf4r6pBLBs7pCoEUqDshWMLOY4YEvR004cN1vmS4WnhevVYhByIL3r0?=
 =?us-ascii?Q?IS4HeQOgMrUYdPvP3ua58A0GhHgJTP+LFF+ByjtQuLeTjUEcs8t6TzXoa+Kk?=
 =?us-ascii?Q?U/9BgKBOKrlleZu4ruXXzBhQXSaBp4onK9f/cH8qlrFF6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ujKshmyYM7FxIFoghUYvMG80WTtkoX0ZqMB9WbGavHMocpR9jP53e98iDaUg?=
 =?us-ascii?Q?DPjBv3zdkgEgFoIKV+MHJx7IVKM6GEQCnIIHey54Bg39h9GEb+FBfOQfoqZn?=
 =?us-ascii?Q?UlAazFdXUwjV9kDw8d+Oe3ley7AkROgH1wkfYF/b/3ToFh3Cy8KIF5+E/JL2?=
 =?us-ascii?Q?P9JkG9Jvm9y4GotDnZ5nHWfMRUaiqYGLXDfGmSGGqFQ65+3vH6gFLI1eaxYe?=
 =?us-ascii?Q?GaVNKoMTvmOJ8jEmi1rxS0Fh3RcCqivEH0zlgNGJjLg5fPOlKRF2xsZrOw4j?=
 =?us-ascii?Q?u0G1rjiFqKIgvxOgyJWtePsV38lcMPVfG6wg9OSLIIxqtUp/z3FURFSCREDv?=
 =?us-ascii?Q?kksiPleg/0t2ndnrsBuRmV/S2A8+37cj2NRvrojsQmfs8QkWYUPiR/vvHNXu?=
 =?us-ascii?Q?r6DE7OC5u3qQCPDJrIFwRP3hQCQcLdNad59rroHRcAQoyXoctOyIMCrYLjvq?=
 =?us-ascii?Q?/SSexpXBJHroXJ7hgYQSBaVREQkC7TZ+MEUBT3C1SWLHdWSVMK8TIc19uQ6U?=
 =?us-ascii?Q?p4NSe24CT4SpAI3leDCGl4zi+HpSAFMnfar7f8n28nbjz2UFlv23ljzj+bAz?=
 =?us-ascii?Q?RJxQ9mmKgrmWm8PR44mv5Sm1/KMQwWCB1tBBg2KJho56YXn6/ZI+z9CxkxYe?=
 =?us-ascii?Q?wBU1mRPJeoLNxdt0ZTPnEDyRFawcuLc4gTob7mG5OslgESQw8L/RxlT28Qn2?=
 =?us-ascii?Q?zXaYErGcwsekKrONHRzots2MsqzH+WZ8DzRnME4AoOlz0GWkepXGb6qT0oeF?=
 =?us-ascii?Q?nOIZEn2lahNKAj0uL0TP+ZIxoxm98brhxhJ3Z8HVJ5faUSrtkCpL6AB74SjA?=
 =?us-ascii?Q?y0Eo/5krEcyOVAiNEDbGwZAeCm8JEHE9XaV62jUr7sYFnRNDxv2kPn7wbHci?=
 =?us-ascii?Q?Z5lbm339aIaqQvC7he4lgyoajfcOJWPapOee0PQKLrzhfRRtVtlbieX2F03b?=
 =?us-ascii?Q?jgp8ZOPKq9o3nJRtsseV/BEojnp1vaOR3aTmvUBYlEYdmLj+e2Hw9rpMfSaa?=
 =?us-ascii?Q?gJunjkiT7Dwp5RpQKtPGhgKzFW6tamAKl8/Ygk51KN0LpZVucrHYJRXTRbtM?=
 =?us-ascii?Q?V+ckTUJM/VImhm1mke6zlvzYMEnvDdOv1bNMa+N7tCI+GQfYpvwf8LAZF9LP?=
 =?us-ascii?Q?5+UCdeQ5vTv3iRiieIpuEjGyN6QT4lV3an6WrdnzEr7Iw7kr53GwsgbTzRD/?=
 =?us-ascii?Q?g2v1DxjF4eoS1IwKQKffT0nwAob43UwIUpODlp8GCSkuzSsE/iAN3gxThAi6?=
 =?us-ascii?Q?RcKO5CnkwL7JZBKLlSO+Zgr/yo+FM8SpgSTdQyP5KIEhMwjB1KHovAvel5Ks?=
 =?us-ascii?Q?EgGa+sfhDSoLAJgGnhTpBCBIYjPByAodioe3fsR9dVfxc1nQsoRCh8icdKpP?=
 =?us-ascii?Q?5QwgFPUstsDwaARZUJMIASlB+pQVCXsemT9vcGkpJ+ytsgJIb81uaZC/5Dlh?=
 =?us-ascii?Q?Dn+ui0DYaM43YLDRK+xoKjSjiX/lmDD+j5j6MXBE+fUy+c4DLb30XK2V+DQX?=
 =?us-ascii?Q?WfMhimWw1cgsH7+zlLabgQCx0o6XngQ8WriH/Xq/GK7BHCFMYwEQG8iF7uOD?=
 =?us-ascii?Q?eTHxQGOCWgEq198EUPI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e87d17-72f0-4721-ea4b-08dcde1ff4da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 11:40:01.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWw3lz6eJSLtdgosYmDEAmkBdojxKVVTcjr9OqCvztpdBNtX8Hzttq8AjeVtIjdJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792

On Thu, Sep 26, 2024 at 01:32:09PM +0200, David Hildenbrand wrote:
> On 20.09.24 15:28, Jason Gunthorpe wrote:
> > On Thu, Sep 19, 2024 at 10:11:38AM +0200, David Hildenbrand wrote:
> > 
> > > > > And repin is really misleading. We are simply adding more pins to an already pinned one ...
> > > > 
> > > > Jason suggests a better name in the other thread.
> > > 
> > > I would prefer something that simply adds more pins to an already pinned
> > > folio. Much easier to get.
> > 
> > Yes, but also nobody should ever want to do that operation, it should
> > always be part of some kind of "splitting" sort of behavior..
> 
> I remember patches from Dave Howells that needed that for O_DIRECT handling.
> Never say never ;)

Wouldn't O_DIRECT be the same splitting thing?

> Adding is much more intuitive than splitting ... just like we add references
> when splitting a THP, using folio_ref_add().

Well, sure, it just seems harder to document so people can use it
properly.

Jason
