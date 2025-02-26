Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01CA222578
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587710; cv=fail; b=pk1ajI60smLc95aW/PrubJ4lzBM9WbZygEOEVl3aw4ZhOf8sBNZPQDpXahKKFNATjGNU6xnkU5O9w5hdLI/wsXpUlqtwlxy5Sqvi1iKS6l/3GqwQCYXUb0VxO/2P2JzPgb5jFNraRisD4C7nZGjy5FEiJDpS1JT7G63dANDay30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587710; c=relaxed/simple;
	bh=Pu02gf2DOLJwtEDXmF/wJGU8kpeoT4dpvQlkXzoOyL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z5YAFv0ubiQINX75+LiGf19RRzV1/zS5SNoUGZUReKXc5HovpZyGFs/0ggMoaXth0V42WvH6t4xfWnGA5f9ePSeioiQxVZQIViMJ+xYtrCtO4HZJ/UAZ2YVZTf/NH5sosF2OuUAxgyTaT03AuOMzThXNaGttBVseKCLk2yVp67s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t++HXdK5; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t++HXdK5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP68LLuV4xG+BLOyfYRQqikSb8f3xIaOZEY6orcJ7majbDV9j5pI3yB8PAMn58iP0E2i1h93g7DYGSd0ogKOPnFXYrWQ0jLY3v+OL8gSatFs+Cj2CTo1MLGxc0tBnmkrs8y5SujP3ui4nrloDx8xyrpjwcyfDhWSdMMYhCRHpm3r1gvo7nWNQoXP8J4qXTku4Ps2/QNzjNbBseBdpvdysYfHfduC80clFQ/2lu3V6R1IZLb/O2UhK3NKdFMQmrgvT0pOWnQZJ1CYzPXI3sUzMcnUgCl1WanTkYl/+FvrC6Hz63147wkb/3twSQIjMYfnBHnhzicS7qwVk6vM+yjoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBJ6qUxfc1bLgSsvbvNuok4ndxJ2Su+yaiFw0bpcQJ4=;
 b=rQ0eChZGaRH1f4KJoIr3Q2nnYuS3KC/ysGF7dnLz4QZ2F+OxyxvSCt89T2M2/tKiHk/YKrIKSPmIykXbmtc5OH7X/T0KO0nU5dwm9UgXSlQld9EFI4l70IbxlwLkG2elRRNOItA2zjI+YnxKtTRS02BucikQ6tPVGow1zG/2yk6/DBHbivfAc/CS5qT+KnJY/q1HayJ1fG7uyFWQK3xOVg5BreEp/5BuFlblRWNXpK7i/f6V3F6UIHqd5QGT2DAaIlExbXyiDIpt0FUwY36OYfMUR2bT5bhAkZnL3wGbUe17bxGf3YelIsCsm46fwP+X4Cb4dd5qUs4/rtvlK0jqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBJ6qUxfc1bLgSsvbvNuok4ndxJ2Su+yaiFw0bpcQJ4=;
 b=t++HXdK5+mzlLy9g+hgswvHbAoZrBTtAOjNenI8olUQ2i+6mBNQW6ioqYSq4q9Y766dejKmsvq3XYCfFTDpT4zoNXGlLPcWuUrSCJISntjMuo99aAqHkJEI/36dfYoQ4Zp7Ctvcz/CrCjNVM+VZvefYAUWde6Vx8QMqRQFdhEL5Y/wU5NdKamQI7C+Nxm+QwwMhKBnz8jNsTCbjd/8zbhmxFp2lGJ2Yyirw2V+t22k/rDqIs0ntzJOVCbp/mBTPqOmGwv1ZJH6l9zcrnF6wmz0o5QVcprBuiAXNEv9pWae6KW2bTGvE6THSO6XWPQRK6GuhNwoHC6AqU2o73ZS98xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 16:35:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 16:35:03 +0000
Date: Wed, 26 Feb 2025 12:35:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, joro@8bytes.org
Cc: Vasant Hegde <vasant.hegde@amd.com>, dheerajkumar.srivastava@amd.com,
	sarunkod@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com,
	will@kernel.org, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH 1/1] iommu/amd: Preserve default DTE fields when updating
 Host Page Table Root
Message-ID: <20250226163502.GC28425@nvidia.com>
References: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
 <f87e897e-028f-43a7-9557-e65778267fc8@amd.com>
 <20250107180146.GO5556@nvidia.com>
 <b3ed5d5e-4b9d-445e-8d2b-3b315322ff2e@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ed5d5e-4b9d-445e-8d2b-3b315322ff2e@oracle.com>
X-ClientProxiedBy: BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bea20fa-2a8e-4ef9-e2ab-08dd5683856e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awF9eYM4O3/Twy9ZTUbcO58i3tMbxPnldCPC/SEmsxEZMrnyGdbh7LB9i1EW?=
 =?us-ascii?Q?g/Ddt/IBV/wfPtlfvZe660X/HxYRjZxCpxHMCZg0Ig9tCcQfifjBbgy5sTYk?=
 =?us-ascii?Q?WLPjC3r0IGSwGizK6M8JxIxjH8hfGQst3tLdpDWB4yRSQt7QwoV4dTVaX2qX?=
 =?us-ascii?Q?Y7t0vptRgej+wu8IlJdEZyn/87Mbc2LNU9Xa9JF7ZHJWzlOXEQoMtHvzn2aB?=
 =?us-ascii?Q?CaFc2qg+iBUpwZ2kQQsCrRk2G+Zxb2bCRFDyHxMC7u13wERW8NseH08a5pe6?=
 =?us-ascii?Q?zpJEdXWdeWBI2IEzSO883y3JLgszzqCop9N1bU2yOhoP+iAgY+mURBT+KNrp?=
 =?us-ascii?Q?fKvbKSgFWlxocONRfnPk+S4KmCAn+DeWaJcgVb13gigImF/OEgoxc9FgxscR?=
 =?us-ascii?Q?L9vdhOcVu6zQw/QGEkAzZzcG71qdGPEe0vXkg3YGshrUxulZ6Me0lNeHJ0Ye?=
 =?us-ascii?Q?npu+bDpbPudXWty8thStT8SohQh1ZdAgQB0+uAeBaDbb96p2anrGwsaXImzN?=
 =?us-ascii?Q?E8opzX0wLF1RHehTh8tusMdtQYQzda73eXWPWHgstTGXIqL+VZ2wFqHNBMIp?=
 =?us-ascii?Q?O1lQedYno18oBHpWgJgIQU3SsYkyi9xRcpl0wRcMOwcSWTFqKi+P/bRfjKbk?=
 =?us-ascii?Q?wfoyuVwtoyX8eSYpq1QA9ur5TovVlgjcKgCq8U+AbLo56IzHBEhfaTYpU86N?=
 =?us-ascii?Q?yGWQU/P/kuL9Xt7AKRYKxq422gag4UHV2TQsKWKkcr1q2Q24KH4B7EZ8io29?=
 =?us-ascii?Q?r1tK+2vxEtSf5pcaE0LCOXaXnB1+yqNjOGsWmwKHfNM7jvBBbD3Ldy11MjmN?=
 =?us-ascii?Q?uvoBC05a7ESUc41lFp9xSPEw8NWXwbFWoZXAUFwWEVYlZzFjztA7SIvwcdSa?=
 =?us-ascii?Q?NaaRiF9sJrvI7AG+hZ0caSSu0hT/oBZawIbo7OyGM0aw98pMTZSZAOejiMBB?=
 =?us-ascii?Q?Ka7fQ6FTaeG/NAbULq8n/emP0LhR4rOc2b08HpLgVvBwgAMb4y2gIt1noXua?=
 =?us-ascii?Q?q/OCpoBBj34RYZEk+mFD2HVlvRSzUbCg9DDtOZ2srHn1z7GdO1bwvNyuY61D?=
 =?us-ascii?Q?Ru1vYH4GLRkvGkKBfo5XyOB3agCauLISg4swPg1Rs2xSM+BFJikjrAiLRTSd?=
 =?us-ascii?Q?Fl3zD0NlOGuNQWMqAClrgIeMWD7Pq9djlHq1b79UDs1sPa8IRECqh+E+AgT0?=
 =?us-ascii?Q?m2QPnf/a/y2qh6P6aWzoxSudW+TGoWCar7pE0Sz0X3UqhdXOaFFzUwp5UqsH?=
 =?us-ascii?Q?+LqYgF8V2jq0lhyEc6+F5A4L0h00iW+W+dKrTM8rwtmfLiiGlG1UDngAZntY?=
 =?us-ascii?Q?BLUdpMXwrbPxlfbSkMmNjaQpyUG2ZFkegdOHLGh4v3LWBSMVwJaYQitgjw2b?=
 =?us-ascii?Q?C8qROP3eqB71N4WexGdejZuLvu5R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BSsbgISr2Sa0SEZDvtSoc0xdhczVO35p/Xn6DnxswXNNl0a9EH9zTzlYu5jE?=
 =?us-ascii?Q?iSsKVORiJcrXanFDsFjGW4wOYqtv5dZZZOxoRG6xdCZn58Rn7NPQpK+xNIhc?=
 =?us-ascii?Q?d6B1ZHpHoS0UsUDg0FCz5xJBVLWO1I4X+BatH8OKwQoU8LMTqXirCy0XdaL+?=
 =?us-ascii?Q?3blpBbu0O1tedfiPRV+nPTu2sxPrAF+jxNeH1a/qdH/KYQUwihcmQJx+wiJL?=
 =?us-ascii?Q?ZodsUmrqqJQZkdPRQ7DcOezSD+y2CugSSTdFMNHsyu09W6qpXEmmr91qn5nb?=
 =?us-ascii?Q?D/favVWRIaloYo6XbFF48cZWJBAswkBeJmrin9AUSL5o05efjG4MzH4FcWAr?=
 =?us-ascii?Q?InLig0xMJAPZEwRqt533BX/hzkr2i3VFCy0/iyXDcahZpvTvNhe/s7uk+ndr?=
 =?us-ascii?Q?M37WYCRk4xzTJIfqtpx64oPK/hbZTCQ4KO0DHU8xvcsU9Chj6iKBG1sPqzd0?=
 =?us-ascii?Q?t222IWm+2clKBurZUIHxgthoH33Y50JFm09pmna89gXSVvYkiX57pPRJG9ch?=
 =?us-ascii?Q?E/AxqtoJlHy4b3zrJAeGWF1dEwkZWUMTKXa5vaJ4Gixvrkf9xZM6ZaVF0YVM?=
 =?us-ascii?Q?0Ayc+mg5PKd2BhVhoHCtkbjPPVhoCU0ejp/qaF+lJkA8hdx4ClYAW6Him06N?=
 =?us-ascii?Q?StpG4VmjX1AupgBOTebzH8vGlAo4Hhy2M0DDlhLn1JMgMjvIGG9KNmQt47Vk?=
 =?us-ascii?Q?KhdIcvO4AH+F1dW3LLC+Z/ImyX38cap/hOXNFZ0BiRaqoZ7kEHvR3Yia6K6h?=
 =?us-ascii?Q?4LzePHNv0QZILYhO2RhVaQGZou2Rz+ybN2HrQTmR1LYLwVxljXLUTpgcK96C?=
 =?us-ascii?Q?uJ1mfCrf37xfJoy/lg+m7fQEExH4z5jH5KvQtvl/SXHJLsI4v1O4It3E8wub?=
 =?us-ascii?Q?eM12nWDG4y2oKWO/NyFubW/vnB6bDhTORCr48jlOQ81MOhq1KHPgpzPp4+eb?=
 =?us-ascii?Q?s7NwyGKvXFs6jSJeXGLK5x152A3FxBPBAxSwOhUkPV0bDLVlqQrTUAxheE72?=
 =?us-ascii?Q?aYgCSnk8lOUA8gsFj+AhalDTvLGQ4oapd/hsLRkqgVxN62tuM6UcorT2a0z+?=
 =?us-ascii?Q?Gfy+0b6GdwAYIAldqIaxmJr0cWIKjhmV3fc/mPyysliyIvKiMHkey1sk+M3E?=
 =?us-ascii?Q?pBr/YuY9FaNY5a+AkP7+XaWcBtxQZ0GSMyjBc79U16MnKHWO8vtTxWrmtvb1?=
 =?us-ascii?Q?bmyOtkO91IMtOUFRHdnk5gXNW43MFwKkECDyxOkl9raJGsP6FuGARpHpmNoq?=
 =?us-ascii?Q?569YQrAe+HM70tOpzKku0BaenRGgOhHcHR2mbXs9cYCqzADNzIs1Sou74HuO?=
 =?us-ascii?Q?9jeUNMCwsZ5u5QbzOoDWQauuk8pqIEQfa5ACylqxItcpMbp7jiLm+m4T6BBq?=
 =?us-ascii?Q?Ic/d6AIxM6AIDmIPp7pskTnRLxEp9pkH4FndAAv5+bGOb8TXuJlueu5wRoE3?=
 =?us-ascii?Q?CETPiUHn4f4oj/cSwLWL1A6oJ2aUsmEPg1WI/8qj2gVPvSn18GbcZSVDobtE?=
 =?us-ascii?Q?9lIZW4AYukFxmmzIa4O85gMUqIhOCiOuo3j95g4W5+qZgveKNCPF5FhzEk97?=
 =?us-ascii?Q?lPlP28oxFXaRdnjwpSVSB0HnBKz9QoKW5FEIQbz4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bea20fa-2a8e-4ef9-e2ab-08dd5683856e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:35:03.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+pdSz7mRTE8KVd0gzUTBuk4pCX9l+H10q+pg89jbctqwBgw40akIsUVf0hJENB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

On Wed, Feb 26, 2025 at 11:19:46AM -0500, Alejandro Jimenez wrote:
> On 1/7/25 13:01, Jason Gunthorpe wrote:
> > On Tue, Jan 07, 2025 at 05:45:38PM +0530, Vasant Hegde wrote:
> > > > @@ -2052,12 +2052,12 @@ static void set_dte_entry(struct amd_iommu *iommu,
> > > >   	make_clear_dte(dev_data, dte, &new);
> > > 
> > > This fix is fine. But with all changes we have done in this code does, do we
> > > really need make_clear_dte()?
> > 
> > > How about removing `make_clear_dte()` and moving DTE_FLAG_V to
> > > write_dte_lower128() ?
> > 
> > The V flag should just be set by the functions building the DTE,
> > write_dte_lower() should accept a fully formed dte as a matter of
> > layering.
> > 
> > I'm hopefull Suravee will come with something like this:
> > 
> > https://lore.kernel.org/linux-iommu/20241016142237.GP3559746@nvidia.com/
> > 
> 
> Suravee did say he would implement the suggestions above in the series for
> nested translation support, but that might take a while considering where
> we are in the cycle. Given that this fix is straightforward and has been
> reviewed by Dheeraj, are there any concerns with merging it in its current
> form?

+1 to take the fix

Jason
