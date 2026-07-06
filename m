Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1207348477
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367274; cv=fail; b=BvuU5OYU1bQTW4UjmEwEj1q36bXzWzh7QEktAU+RdW4nAb55pssflVIppDLzWlpbSlsGUXHzkiYCCOoMqHzO7WjPi42VBnbOb77xFfgfS9nwvWrMlrd5ipVyCkur/gUdXC6xmKuntO6S/FR+I5owWg+UkkCHKyQgyava1tQpUdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367274; c=relaxed/simple;
	bh=3wH0qq/C6Sk0zIyyK0fqICyganDqDCI6zDMCO0diHaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nRw2xutVx5fqwj9VV5E/EgM0afDvErY10GKDLRjqyyugBzIZkCajYCwEqsq1z9pQBEIUJh0/KFYkl2vzh2byNWgXRBHnlcIUOHEwnyTsVHp6tiZOoajR8RT0eWYhhECtLD6UmSXny9SWwu5tHCR2orKeI4x1QWlqcpFaio1LOek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ajNEgKnl; arc=fail smtp.client-ip=40.93.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ajNEgKnl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwAVQz/60ouOYRibbFPpfyQSjmMIkznneOtdpTj7e8Zgwb2b4zyfZ5+CWxRNtPYrltVVpP4bZOdas0Iyr2EFFHxjWhi+guJWVJA0wHD5EDhamCUecadmrCRPWPthoHW60geQfwWr5m4p0KibPJoHZcseSbedJkCkCyw2FQLq1MpJkHCNb/d2qY9d53cg7R5GeiOq6cM7qUhmfzSRGqUe3K7zicTZxd6mQMLhkaVuFKT4QSYJxVObnXBAowyhrZ5dP341glYCFGTTSfoXPFbb0TbC4iDuhziLQi/RYHBlmnFYg+xnsEVj6IfJ60AWUajSSQ6+9U3x19E2Gxdtixpx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etIwecKS+WSl6RtCWQlv1iwM+xogvPO/th1Fq8cA+EI=;
 b=MsqugM+KdU2qAMlySJRaoi/et/1U2zcwVgmEXm+2r4eXexQWcfeRgH4lz2MiciYM52wgpKIjN0mwsYFbwfiiYgpgcPO01B9Pj3MCLSpD5xCR2nBvLxtGLMlBERevu3FsY7r0lVbzb6SLNJV4mo9yk1pF5trAhBCC+mRnuasnTqP7lTjjre0icfHtZ6uEBu3T8dEov7N1duInregEY227QTYy3ELQ+kX9nw3i4E17HX6/eFAZ7RmSP2lwNpHRaasm/px0sEUSH35evxEBPv/gEDq/zBha+TwTha3Jd8pudehwfXyTwzZoOJUAgSGj2q1pyIAzyJ6bKyYpLUNPJ3AVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etIwecKS+WSl6RtCWQlv1iwM+xogvPO/th1Fq8cA+EI=;
 b=ajNEgKnlboUdinU8a6rwf3z5BJHAgNwJg+qhshUHsn+F/qUReJzoGkmmcHUhGVjgEiaGzdf1Q7M3GaC7TgMuUIVChLXMpK9zlmnPB3yHZfcCYf8d6w3GYMev7OGDl9hCKb+NsegPSf8hr1IVaAOfbwHk4om0sGHABYJg0FYgaT4LYqL8ZIJ7TSf6Y4tIJ6+vJ34OLHE9BLG0vZ5EqZ2GskOXcV8w4sBCZ9oiBBqG6zCAJSNrvmNUt1hyo752kgF9yoQF1o23MOViKjS+F7t6jI2chRlzd7o7cGTRb+EUidqQT1rM1C5Wc0wUqXn5c8C79RnBmcLZx9+/y7P0TWTSSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 19:47:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 19:47:38 +0000
Date: Mon, 6 Jul 2026 16:47:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org, Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iommufd/viommu: Publish a vDEVICE only after
 vdevice_init() succeeds
Message-ID: <20260706194737.GD118313@nvidia.com>
References: <cover.1783311134.git.nicolinc@nvidia.com>
 <1e05999347f4bf583edbc6a1312c857d5548708c.1783311134.git.nicolinc@nvidia.com>
 <20260706172356.GB118313@nvidia.com>
 <akvuf1fIXTBY+/Jg@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akvuf1fIXTBY+/Jg@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcaccba-9f7f-4b2d-9abe-08dedb976f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|11063799006|5023799004|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	i5gM6w7PlWPGVJt5YlASzrnYjuJOb5vUsM90Kdjy0yghWYmlZ97uE37zTz1pNsP0VIMOq6hahG3CDIcBoGiQdhbL9Q3g0qRgw+TsOKX2VJTsQSeYtTl2KMzuQq/sVFoY7ul4OdkBdPJc5d2mQ/Khp7+0C2OqqNUyYc4e5K+UksBIOi9bK5KUiQlng9m3/iHu/55B582lbIN+1b2PthmF0NsRnrRaWP2tpkE/Nz4Ypv4gmATsWAa40JBq+Kzgb16LE/QTjE7RSWfTPAxd/yn3OZhZ+lVr9gXBlDBLh0QCY8lZoi8zQorDKU/r/Rnxu/ylRSp+Dc2qPKDRznpM7men9vMksPLczRqlNKooP/3ITNHsx3GrnJKqRnfEuDf7DG3LXkKnTSIZAGtpqoHwFrTs6mKa78bsMawkVSN6vmlWV8g3DetZKNrFVaIgPsYgqomsagFtcmMPYcod+NcdQ+5L7kMHcAGGj2x6xLqkF00LI0X98NMY+Ztfeucq5sP9GSficeFabJHQ0PmWmzRyvS7e0YiURyXj6zBzJ/X8xkoJd95Oeyp5UE2cAArnaN7lJ1ITZX9rkvClEM3xatJ6yIDgYeE5wjBCGD4dq2S0rmI+2Yew9+EAiKdl0GVAP2kVsxcsA5CSbAYm00WNCDelCJ1rG30QbZDDEi4KcWa22R/AIS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(11063799006)(5023799004)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wJ6glzd7BrPozMdFVI8rcniJ4X0hCctGCN//mOR5LgY2eGUOZNsOTOhPvfSa?=
 =?us-ascii?Q?3I0Bg2zX3celCTKTbUyXu7hxAkYcxT2dohitdkK97S6phettFMXbZmmtdIDy?=
 =?us-ascii?Q?rtivPtL42MHJ58RV2if2fBzgu/R38i0tM97DFbgJlEcwKVtrIiS5YmepDsI4?=
 =?us-ascii?Q?ldoe3zKJwHCwn6236ke29STbKqQbwt/cfOq2J9HOzUCz4EmrIMhriIwkth6s?=
 =?us-ascii?Q?gq1FDAEMrK/T4tHj7MdebVfb/3bpmF686ojWACw2tFvLeojTZmA+PBIXY6Tw?=
 =?us-ascii?Q?UqqJi3fi6OlZ2AhVD0wU0ZYvtCRQBREl1/jj7RrUZv0u7VXF0tCOG0s2wqir?=
 =?us-ascii?Q?vuJcxBtZ7vayGwlTWaRS1nBcbi4JpfOF6C0Ap5GvV2JF50FX5pxiModIPRU7?=
 =?us-ascii?Q?RAb96mghBxZmXqOkbqLYfx5sCo4+a7gT5LxYzk0SxLaqPDRZjWZbWGlDM2Nv?=
 =?us-ascii?Q?5i3iFqyrBEd4OoXAlO/8X5GJJvMaa7t5ApBeBCnPpyd7RFPXDhwoD4DcgNsi?=
 =?us-ascii?Q?Frmx/eO5/UfMJBg5i1iuyZfpjOiFPvItQ09N3Kcy3ZGaqIt+8wzL+cKWgUPg?=
 =?us-ascii?Q?r6AxjKZQIb7hjGFr4lRkgsnNnZU37H8zPgcJzhFQIA5DwB6p3kDxjNnaC6ev?=
 =?us-ascii?Q?zS/3R4H9Icc/gyJZJ6g0zONaOeYhKP7+mY9lIVnwwSiWzWB52+2Lm+RtKpDj?=
 =?us-ascii?Q?e4CC+lhDdPfPC8VFvjcFrVJgtDL6KSDpSZMpRBun8czWQA+sIsy7e7Wzk3dY?=
 =?us-ascii?Q?ZM31VFshO/4K/ZXfFFmyfKTxMZjosFAFFrd9NVoLHkMvExt8UcK+5E1FmSlY?=
 =?us-ascii?Q?mHgwQCZZzkUjttXGteDlCSREsyMPtq9IYl3+kkjdsBUnaMZx4LZGXKWjOzA5?=
 =?us-ascii?Q?17joHKyJKhx8zmIOvh4GICkrD0mFoO3YcmuTtJ6SLkoguM54mz9erC+wpNij?=
 =?us-ascii?Q?vnawry8u/wMCldMsHklBb1owYx06PVcEWrL7nPojQO3tDe1bDp8z3dgO0lhU?=
 =?us-ascii?Q?+jbf2m613IC865eNhVrugQOFmjnGo+qF6A4G6SqFXPdLeQha1mWIJRGef0J9?=
 =?us-ascii?Q?21Sq12Rvh5KC7YJV5GRnMeo3uaEB4AV9UxcbwFbUhQ0m4ydZ2lZhNnOWZHDw?=
 =?us-ascii?Q?xmsZUnk+N6e35EmZRIsKtJmnpuwUOEprDD2GeEXEHo+OEAfNtUgGMBGBeQzy?=
 =?us-ascii?Q?KxCfbfI2c36tgjErYp5MFvwEwc+fCb6XCeNzow3JpCwlp0qqAlKhkJoD1MPX?=
 =?us-ascii?Q?59+wpc4kFj7ugsI2G18SKca8zy3/f/RUSdD9l/z1toyIvwbM+/dp3DRcyTHN?=
 =?us-ascii?Q?65jSPJ6W0q7fQKpmxVQ4NcjdeByyGyZLoqF24rzyqK7tHkt2xZcKqn0PUOgQ?=
 =?us-ascii?Q?QuIxkweP+TaC341gTnDZl4NkRQwvaq+Ne8BfLLNaNRn5oQiqENFgc0zqjds5?=
 =?us-ascii?Q?qhlL43zoKd+XoPkFcoUKt7G/23oWFHQCqrqqTG8xpJFlERFdp3qj9fviAMAz?=
 =?us-ascii?Q?yMBv09a3neC7dFumCmNtzpXnsezSoyDQjaFkLWURxuhwjEXOuR9chJT6SJTT?=
 =?us-ascii?Q?WCbExk/f7IP9EduxVsM861KHlfRHgbCmX3tr0GOKxbQxdjDEnEr7kkxtk8lP?=
 =?us-ascii?Q?pXB/GVrYRNrnFJy+/WA0mW4ZPayR+q652lnx+3HmfDH02dra59NaEd6yFbIa?=
 =?us-ascii?Q?MPVKzlAkbNo9Zjz8SM+cJcYJgXXgGImzQgPSnF7nhdhya/nx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcaccba-9f7f-4b2d-9abe-08dedb976f0a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 19:47:38.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzSjCng7lQndjOXk7SG8EHriHYWMZPncijniRYguubuXYoRm/DCA4Zwi2cCrh0aB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

On Mon, Jul 06, 2026 at 11:05:51AM -0700, Nicolin Chen wrote:
> On Mon, Jul 06, 2026 at 02:23:56PM -0300, Jason Gunthorpe wrote:
> > On Sun, Jul 05, 2026 at 10:36:10PM -0700, Nicolin Chen wrote:
> > > @@ -218,18 +218,28 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > >  	 */
> > >  	idev->vdev = vdev;
> > >  
> > > -	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
> > > -	if (curr) {
> > > -		rc = xa_err(curr) ?: -EEXIST;
> > > +	/*
> > > +	 * Reserve the slot with a zero entry (reads back as NULL) until the
> > > +	 * vdevice_init() op accepts the vDEVICE. Only the xa_* helpers hide a
> > > +	 * reserved entry, so never use a raw xas_* iterator on this xarray.
> > > +	 */
> > > +	rc = xa_insert(&viommu->vdevs, virt_id, NULL, GFP_KERNEL);
> > > +	if (rc) {
> > 
> > Why xa_insert() not xa_reserve() ?
> 
> xa_reserve's kdoc says:
> "* If there is already something stored at @index, this function does
>  * nothing"
> 
> By its implementation, it wouldn't return an error on duplication?

Yes, OK that's a good reason

The way I usually write this pattern is two cmpxchgs, the first
NULL -> XA_ZERO_ENTRY and the second XA_ZERO_ENTRY to the final value.

The latter failing would be a WARN_ON condition, but this is fine too

Jason
