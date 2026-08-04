Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B13F3260
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862768; cv=fail; b=Dv02YL/hfihj0qxvB/AkspPcuKH5GAstGaWVNYi/65/1AUi5gbpTZ0iaLj8UfWeFWistJYz4ZSWr8eBWbV2rnUpx7ohd07895OuYjWnAla2XYJc1r9Faq9vwnKR7XYv/a4FWggMYwFW+EJH5nzJGLo6oxuB6vUMXXPkpczgl1dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862768; c=relaxed/simple;
	bh=D9BeTLBR8oYShr7257OL3KUaZFX3+UQ4nWx7W6jFTNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ifQfm3nWGH1BErt3dNyZlclzj7YHkKqdXEB7urS4f2io1jzhPiBSOYFKFRSVsj5g5E11uGMEHk/QzlW0uENvwGxh8eftSwlFdDvhJKr5jd94DcVt57ZtN1wgkEk86r+7I2J/IStUp3FmBECbvvpY+s8HiL27kRGLqbKaNscLkew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IeOV8zRJ; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IeOV8zRJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLfnieXVKJispg8x+eVen3bsYe/paTxHyCkfmyWABVwuar0CZ2f0WzNuPkbSVvAkb2Us/swR/77chGp6bjsi2WZ3D/xw1XS7H1AcOr4RsZMmVFwoWS7gs5naVBGfQmG25Ro81Q430bGKU/VQyA0uLDwnT+UN1eRKPwMja+kOVWUsv1c4gperf1ynlRxviomlns1cxCZvEmoMlQHxAmAHHSaCt/zGq9hZDhrPQWgLP7cdlRsOnFqwxG6uFrDGy0hbG2ht2m+kfMn4rFFkqYMoGOSsc9d/cA9xdYq5WVrC4vQLOsH+KC8NDNccEgi7VeYTzD+xEqBaD1vdU+F36r5t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpfKcNw4fzqTFaxThUzzoued4xVn/RVuGXo2o8DxCbo=;
 b=wcF3Pho1kqQn4Cr0G26AT+Z30vlK/U5oshPs7DeM1SuaiSW7TD4ETFbMP+jft3qtKzQ3kHzXbPiLGuPIv8WsEmxoJp7WcS+wTreF7lmXR8hb67fHywSy+P7gJJd7xdDBPecjoch8RrrdqPbKqSdyoLGj1Qcu4TktaoebIOkMWyyuxb5S6ehQDDRTFlG5PPNsMZ7NytzNh4R8AkjUQdYKtVVaIPVuLUGBgMJiWkJPLB0RvwqZD00/elOYpNXzaJ+PiPyfyzNWsKxH/pC2QLXH7f+HDBCOeMzMk0smBWgbOM+UxPBn9gzrrQ7zq/br/3ATfx/88KFdU8ox6obYdZKZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpfKcNw4fzqTFaxThUzzoued4xVn/RVuGXo2o8DxCbo=;
 b=IeOV8zRJM+DAa3xn4KMJCqPJzJG+O8/GRNp0uYfo83ZdA4GOoWKm/nQHJziyQh6942xiWXQFe/cvZpV1ALMMBlAPrUayT6ofxaAUhYOeUo/6Ud3E1U2hUXr9ijLDgTyT9P5KOkmlgoo1IQinSC6oOeSlwz8in5RmGUAHjvNFeGAW5V3b/e4dGMGdUwRcDxOAv9BOZALNy3Nv5NwsPF8djbe37OvdCjisgmBE9PuMf2L72Kbg8KISPBxK/qJAqdFbIpXXHIRP2KSRcIH9aENoCmBJxPaRTWt5Jjd1O8bC6LbFIlWN5mCFCoFY9S4UL6BYv112pKQZh+X8wXiYOsrv6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 16:59:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Tue, 4 Aug 2026
 16:59:07 +0000
Date: Tue, 4 Aug 2026 13:59:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Pranjal Shrivastava <praan@google.com>,
	Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <20260804165905.GH27883@nvidia.com>
References: <20260706084708.8072-1-kas@kernel.org>
 <amiBagGKn-Aym1DK@willie-the-truck>
 <amiz6GQZ-XGlH706@thinkstation>
 <anHxBh-xGW9JXsa4@willie-the-truck>
 <20260804141704.GB27883@nvidia.com>
 <anINkO1l9Kz8lTVh@nvidia.com>
 <20260804161918.GG27883@nvidia.com>
 <anIXDd839UC/M2n/@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anIXDd839UC/M2n/@nvidia.com>
X-ClientProxiedBy: YT1PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 35967841-25a7-4a52-f4af-08def249b216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	85WSr1I2EBjoLszi55mv4IwHg4Q1y94Wk5AIKbpsmGBqz5yQ+PZflXxp9LXIJCspykr4msDeJag+Sq27zK5ZW4NYWuclS/MmzSnlt/Ro0Og2VYqsJqG+WLppA2Jeox4UzTuSTgWn2wX6/xhiI/WevfIPL0FiDYy4o457LEbkFwSrq7+Y0nRmfwAjLmsttj0UgnnuG9xqXsbFcAp4dT9Sqnl9kB+WEfGRE3tK3ILpGTal53yOdStIWrc+gGO+2HUnDLn9Y3n/brPmvgp4Vs519Wy/fQfAazcOMZXu1VeXSiDov3oX/QQp3mQ6wDlVwwaoHtoT2F8JJ+I7OV1Qod/ncuLKeEFanNA9Y8kxPgZamg7MQT8FNxKZ6Hj3oN0piw4/enKsL01ruHxUQNWSLsmBPUwvCiiS6A9k/uj4oHSNn9jGUSJoDQBpn0+lgXDATmbuO+L/bx010nO67sCrkyjA/C45rGVUcPkk8sLBt55VkdEJdTkOe1fq279X0gepnAUiuvLPZCDH26SddgESiSx4dsiCZivsh4Khxj1nGZPWirFX3csXyqMlvy12D3fuzk7Di1b5yMd0MQ+44miwZvaVk6RtLv/BocdZpVcQmc/zRYOKHw9n/qxmQNWABZsTLY4/skn8ZPuYRJIIMkyQMOL5ifVym4yAjjrnO/+1UR8HK1M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?78fdXD0Ki6zte15mv5eu6/CPNdVdMuXDjh2opud6Q/H5hVNO9/jVsu8K0xm+?=
 =?us-ascii?Q?kOlUFdFKSeTVo2Lqo2pFXpjFKoY38anz+/abRLWUFHYSdFqNFt/ZT5fhGSuv?=
 =?us-ascii?Q?pDTbjZl0J4Mcjm3h9Y7v9F5Ccf8Hoxdd9dto4ZCMnkGIK+y092aXgE2dnZxd?=
 =?us-ascii?Q?b7g5vp16ZExBroacEllKwZIUmktxAX0n2Nd4zM2xL3n0C32aRs6opGHPf+/y?=
 =?us-ascii?Q?C/y5YnRL6nmQ2jPTvhon0lFT25PnG8nLYGH6exXHlwohxWAZmr8BT1huQXk5?=
 =?us-ascii?Q?Iornnd5c0+g6WDVzaaL5fnP9LrELZYXPZo6Xa0CUUZx6emm/5b3OJChlShOR?=
 =?us-ascii?Q?m/+GA+7fif+C8uFtxerJJzumksmjXTc7WkZDfTpJFclbeRONd4wY+1ncx/6+?=
 =?us-ascii?Q?7fo1JN4HfCynGmiXNa+HrYojvpsHuhYu9KmU+6CQZrwlyl2uXY+pmXYewsFw?=
 =?us-ascii?Q?9u/yixbNVGCJybHhkqVhI3z0spCln+gVR0qEqNHGgMfcK1yitgPZtgotgbvt?=
 =?us-ascii?Q?YUQ6TRAEHhOXrzVu3nIO95qvCAHmfZfqWQ0UXH855u0OsAgapdcG/p3zU7cy?=
 =?us-ascii?Q?P/r1q1/EL67RSIMWfR1tm4oogVYNlLHa+W5ZKCy55rSeUIGgX/qBk5iDb78l?=
 =?us-ascii?Q?mCkYuBw5MWfWyU5qe35U/0Hx0n12L7K7MVIfeevfJ6IyJa95ayp0xohDOb4t?=
 =?us-ascii?Q?WZnouEIa9wWeEKMD0gFSpRT58nvIHAAbsem678LNHnzD6zyq3SboE0ZPOk5h?=
 =?us-ascii?Q?GsUfda13LMxC9lIKuxw8wJEQHHgkosnp5ON/jakXCRq6z4L++qyF7gknUTsv?=
 =?us-ascii?Q?KDW5xHGm6RUZdcuNn+Oe2lkPtmT0861aGUOHKx0R/hBtj45biWoNcHvjiNqs?=
 =?us-ascii?Q?qM5c7H6/28svXtrk5OjWxCNIGIVrEGUd99YouFmzgBjaeWqjNaff9/6473vq?=
 =?us-ascii?Q?YcDV+TufVcexIFzkzfra8xk9BDV8KeRtUDH5J9K05PZl/Akfvf9D+bhSbuXe?=
 =?us-ascii?Q?xpj7w6BLSeGXzWw6FeAEYEnLdMjmHX4XnW45YJ0myuvQdsz64OBaBYUsucG4?=
 =?us-ascii?Q?PVUvNuQOimD9wysnSSM17/4MS7qggBPBpwujj/NZN367p8M5x53l6uiA2rlL?=
 =?us-ascii?Q?HEnUa85RShCrHczHXm90mEHVFuCP7ju8wd7gKBjxuERqUJE3kKGOfUtKQJvF?=
 =?us-ascii?Q?qeAb549Ghd2xnXbMlFxQTg43Un/48zl1TZoniHeKritNwiNhkeRbO2XhSrlb?=
 =?us-ascii?Q?Jfa1ot1wAknB8zPxBwNM3rg3+T8JKFCngxfLTlOXuAlCB8vq81xujmT2n/bX?=
 =?us-ascii?Q?TKjUvYmcfsmqyZnyR7IKTJ1KpxTYDUbkHORN6vRqFQwHRXc+gMM8GAy/DRCZ?=
 =?us-ascii?Q?Qjt5ui3+fQZQ1XsJtWAsPs6jOtxr82QJFGhMzRM2ekFHoUatdpQ7N6w0K6MN?=
 =?us-ascii?Q?GWKa50ZcCmfT3rrAgF4vjyk2gWRg9ksaXTP8eEs7sqXoRE/eRxEr/Ci6WYKE?=
 =?us-ascii?Q?nO3CSWyvMRDwA1ma6UP+WSAwBJbJtUpien2ra7uj6QfbVjMMaotQt871HKoI?=
 =?us-ascii?Q?mFVLK8n7YF7avR3h6b9e5bBJ9GdnQSLdK69JkOA/UlQhW1zAw/iohTTD3gcd?=
 =?us-ascii?Q?R9/TazPh+4cbQQa8KKjh8bck0Cho7gUONAgd9TYtjqpCI1hLxhnCfFf+Zkyh?=
 =?us-ascii?Q?mj7XEwjbopehk3ALwiyxN3R7qGCtbzjbLTS89BpPVz5aptz8hNRf/7Ev4uUR?=
 =?us-ascii?Q?GewcHwIrYQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35967841-25a7-4a52-f4af-08def249b216
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:59:06.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tu4vXmRVCvvb/cJMGmflRS2SHmkqLcZ3MoqUknRnl95RfueSX8DkrQEEFF0beHZN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

On Tue, Aug 04, 2026 at 09:45:01AM -0700, Nicolin Chen wrote:
> On Tue, Aug 04, 2026 at 01:19:18PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 04, 2026 at 09:04:32AM -0700, Nicolin Chen wrote:
> > > On Tue, Aug 04, 2026 at 11:17:04AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 04, 2026 at 03:02:46PM +0100, Will Deacon wrote:
> > > > > > Would skipping their allocation when is_kdump_kernel() be acceptable on
> > > > > > its own, or would you rather see it done differently?
> > > > > 
> > > > > With Nicolin's patch, we can just avoid allocating the priq and the evtq
> > > > > entirely in the kdump case. We can then add a cmdline option to control
> > > > > the maximum size of the cmdq, which is useful regardless of kdump.
> > > > 
> > > > I would still prefer kdump do this re-sizing automatically, even if we
> > > > do add a commandline. It makes it easire to deploy than having to know
> > > > secret command lines :\
> > > > 
> > > > So functionally I still think this patch is fine, though yes it points
> > > > out more things in Nicolin's work too.
> > > 
> > > I will send a v10 of mine, to skip the EVTQ/PRIQ allocations.
> > 
> > I think Robin's point is to structure the v10 so you introduce a bunch
> > of tunables, including something like 0 size to disable a feature.
> >
> > Then have kdump default those tunables to the right thing
> 
> But in kdump, EVTQ/PRIQ are disabled, so my series should have
> skipped their allocations regardless of the tunables.
> 
> So, I think the tunables can be done in a separate series. And
> its use case might not be confined to kdump?

I think the ask is to do the tunables first and change your series to
default the tunables instead of doing direct kdump overrides.

IDK that anyone wants commandline tunables, but it doesn't seem like a
big task

Jason
