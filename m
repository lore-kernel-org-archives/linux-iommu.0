Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153D20D50F
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306177; cv=fail; b=eY22blpeP8QVTuY6Z/YhDfGZj0H4I+4bUPohUNAX1sYqA6lC78mAHlPy3TQrtISRh2IHuMiimIa0Y1IQfNjStt6CvL1JyP5basNcQoSne1xNPAA9Bed5Unsql/jD27BWFenAfI/w/BKDlU+jPNSXpesH2+9W6gxWeNrUzumZXvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306177; c=relaxed/simple;
	bh=D+PEi2rabGOR5KSFDNzObsNWKPNFfgxUGQRjo/hM6aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ThZJuxfE93c2gJQmxXPmMJObpyUWdg6n/jlC8zm/TFTjmT/mURPYcXOsLa43rkqbK1iBIX5EZ6XLlK+5QG8xUUKD4bfw3ohNRw6jzjIpd/wcD6kPPit6CpOx9xWjDnPCGNlOQ2WH/Uqoe9dGebFxw68K4pUaDa9SYsf5M4qFeco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SSRCg/P/; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SSRCg/P/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2O9ZTLy6+T01D3n63p5GjLHS/qy9MRYMBGGzAhbPrDgnGOzswHudnypsCW3ibxwJtvIOvydD/y1bKxz7Uw2J3QK4LiTzwk0FfmFzWrmWeIyDzMnsTMn8IHrigPT3On+bXQ0D6Xx9Lx8BC2bL6VveaUzaurGHgu46ITOZTuGfh8Vc7RSaFkjZCYpbCHSHWrCmBfa4idgrekXU/QucrbQS15dSh8ZX02YMk9p+GlFOmJK01UwoiILmvqbj0NcyI70KmjhkjoKGcMQiGWB5fD5EkUzAgcJpz+RVSC/hhY4UxAW22xY+I9hs8K92adUwD+1E+l6hpmO78pHMGo48YY3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3afmdM1PYhkmjF6ZDh8TIeU8Zs1ropeXw87HpFNZnJM=;
 b=PP16GVNHOs8TWpMy/mEXMi8+DRLf1o+btpwPsIQVNvchejmnDjHBNo8ZxlPBbspx8c1f3bw7VcUvRpAUzq89XXyypMVymqGhd9h5FlTqfGg5nOXphBxtrDfkDXVDlo9ZNSV3q5PTxZx529LncOU6jgtlsd1SQupDe95j4uyglW9zmoDQOJkvi8hRvrZ4k905F0g54j1z/dnFdcaaztAnGRWReHVdKYgGEDpIAC499iU6Q0OuZ++p1OE0Jv0Mkr3mvMI9NdcG5rlO3LksWoA85BD7MWUjv9l3Bv0XbDyDASOBbujPzjeCeaIHi2bJFWYZlVB/xAoPqqv03Afemmj8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3afmdM1PYhkmjF6ZDh8TIeU8Zs1ropeXw87HpFNZnJM=;
 b=SSRCg/P/LO3jZTrLe0C2QT455oPaYB4ULkzmqcBKVX6LLdM7KlzDBY05q5Mon/5RNcvBTePfBBD6y7ndFIMEqGLsn2OrbRIey/PG4EbQHjBq5bxx2Dcs+QZdQ2LZUR9PSNN2IQjYffV8ncYN0Ih+6m/1qO2BY9WW7JIDhrXEZpcXBIY/mMc0I6E8ouoetNRpL3KDiiW0ZbRXrfB/dzclysApLHtv11OxDsup6wCRIOAMzGiP9cxEFJrkG6/OvUcCly6Tbift5X0MreHa0BK1AatgyzCmXV0x95D+3niU84QGVt4EpGaet1CZv2ckHtZ+4BsVydYgPWvWsMph0Fi3pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:56:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 13:56:11 +0000
Date: Tue, 18 Mar 2025 10:56:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 11/21] iommufd/device: Move attached device tracking
 to handle
Message-ID: <20250318135609.GU9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-12-yi.l.liu@intel.com>
 <20250318123406.GJ9311@nvidia.com>
 <bafc2cdb-fea5-445b-a7a0-5a1fb390e3f3@intel.com>
 <20250318132652.GS9311@nvidia.com>
 <86c4cba9-5e50-4886-8253-0829e7620a85@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c4cba9-5e50-4886-8253-0829e7620a85@intel.com>
X-ClientProxiedBy: BN9PR03CA0404.namprd03.prod.outlook.com
 (2603:10b6:408:111::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 543a113a-10a9-4ead-43e5-08dd6624a3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s+8Ia5DFHMVHpvjvc9M/1ozTsU4P1JrCCh2oV0luDXN+mF416VPlJxOvcbGk?=
 =?us-ascii?Q?Tkz1VKQTY0D5OaLSMfDnXqreh3gMu+kyCTojm5SH4NynU58dTH+Sc2gWzKYv?=
 =?us-ascii?Q?2bkDQmPbVsXzJ1I3wOCro9PRibQNgqlUAZ8cvpY67WbFNR+DQQI6B5SrVJv+?=
 =?us-ascii?Q?9q/y2bwT9+SSLsv+fjtwKWxLpLSHzjafUJ8FLWgLj+5v/1vXUIDfC9vbxiIo?=
 =?us-ascii?Q?4VsCyqGihGnwiu+Vv68oWUI+vSgd6U3a+R78ymZzCLcczksyaltgeTfBngQQ?=
 =?us-ascii?Q?8dvk83PABY4sX9WMpSImOdk36trZ7V1LPM6sye/akYTwXBxF01Nbk/9ec3U8?=
 =?us-ascii?Q?+crFGu0eG7Fjq/LMAoTGe93BKr9MSM4YP7fNB5S0x8ElRXTgt+2v6CtZkTCw?=
 =?us-ascii?Q?XCIvMj8JbY5UZ33UaNJY/oOCaFVfZqgoJPjVUkqdpd35UfF4byY8UlJ2ECzq?=
 =?us-ascii?Q?rC6sIir60JE+4ae25SV//GgqEKi3ZbUn9/RlPOouDNO0CVF8xKWei8aGpz+j?=
 =?us-ascii?Q?PhskmkbZM3LpWwu6uNWzfukYyMVUmJFMhgLtcQ1i3JlRS3SG2KE7AZem3ZW7?=
 =?us-ascii?Q?ZnvhfEjsrfkfWI/lf+9/8q96iYJwbxRa0DqyzjK3OGlQINc+XNZT4BRK4PUE?=
 =?us-ascii?Q?ieRS8P1kuzDGzNnXLBWM8Kv2zFvS4o8vbzlPGMVRPv/ZlCWJ3JRWBXCdionP?=
 =?us-ascii?Q?pn2/Sps4AknqEcfMnGfIRIBQF1uZFNLhCIii88IXJFYRoUjTGK21rVH3hpw/?=
 =?us-ascii?Q?17OBaGpHuxO3wAc19iy+KlW81ePPxL07W0URfyHu1EyZA0ove3KZTf6OBD7b?=
 =?us-ascii?Q?WsjcxiBzxyE1K2c6ZLonFVuXubtm7gTcG+ojNlqbfPt+fFiAe//KPnR4Jgr6?=
 =?us-ascii?Q?/91AJ5x2Dov61YphJAckoLscb48Y4gQJvND4qUvTlZIw/OKCYHslrpU5H8tZ?=
 =?us-ascii?Q?xPKvz207je0wIws89VYC7XMzwmZZtkU051qKROYsEf/6AFU+jsRxAWzfJIDj?=
 =?us-ascii?Q?i6M5MYqSEhsJUfy6iML3j3ZII3ZIN4CubJLPGv1EQIJgnKmL8N4LpiPMXs0H?=
 =?us-ascii?Q?5F+dxG0ZnIijbgRp86HpIdmcHBkpP/e2qQeD3nWhXsEsDob+X2MIChmCAWDw?=
 =?us-ascii?Q?35R2xgU/ApAR0u9KyDyqwzWTM4HjO4ekmf+T/xkSsKpuPSL0Rz7VcUJPkysn?=
 =?us-ascii?Q?ttsSahMw8rbnjS6AsPENDpzuuj7SUdeUXZHsbLtjWlG8iEv1C08glR/SSutc?=
 =?us-ascii?Q?GkVZfqc5wuq2uFu16wRx7QrTMKEgYSvnsvFd2EwX75WJ5sOe8e38o0V0o3xV?=
 =?us-ascii?Q?6plT9UjHwKw2B8y9fEsxq5sAASeCcMxDTrEgYpLpONnxNggW0r/JGP+KNBn4?=
 =?us-ascii?Q?G+5jzCnf7a3+pyeJydVRtXCBlf6i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HKsiBrjCLyUrLTPOJZULr3/omkCofMDkD0u1YqjHS/F/LFKPGl8vudjJq5kW?=
 =?us-ascii?Q?kCVr5W1jBJkPAhe5SfNG2Cz4ezE6vBQx+4pmNFIOjvo4nv139Ul3WmFvYRly?=
 =?us-ascii?Q?T+wblpKdIrN2TztXJOazgkW7d8bqK42OFqQMHXbeKD9WBiBhyW093lwEJloC?=
 =?us-ascii?Q?coL9oCIyIcSHOjR7VyqJ6VD4tMLJYZMt2M38OriKzCXzsJ8i7cMxvVcP6isr?=
 =?us-ascii?Q?oAtwjjyYOa3ktsABHT+L22zFSF9urrBBzvnboTQdl4UGczEx2Fmbbl/k38IW?=
 =?us-ascii?Q?JQlRW7ANnOqFWKElT+fnj8HmIn03glWjaclY1WM0UNYoeFSEZqpQhlTF9Mpy?=
 =?us-ascii?Q?nXj5KWRan+0keO6eorvGC+noC8nlGHBP2jC4D0ZkuX50Uej8V7u9983atwAq?=
 =?us-ascii?Q?/15KtHq4IB0YzfHJbhRPRar9wA6HCOHpUlnugwlH8gNkfFtdTfulkF/nB43F?=
 =?us-ascii?Q?KF11V7VLmWzp+j/1v95JF0F1+fxEYoM7rAPD1SB/wecALZSvMeXe80AO7Ta0?=
 =?us-ascii?Q?B3VLU4F0EbTE4w0pYOnjTjsWgyKkfxxnM1zps06ojx73MD99QyWgCm6OGE/Z?=
 =?us-ascii?Q?7JDJIMqLMNlfDmL9IhORPMfIlP5QrcoWUJ+HcUXDbYgKPx7MrNcE0hVVAo0+?=
 =?us-ascii?Q?c9jAUKUUgcND7hzfi4GZpLnZYsv0e1yoDUiUkEopzy1BTV2IvRZKLVHclv5E?=
 =?us-ascii?Q?9W+HBpc1u46JOsSWizCaIcWBtsE8sjUB7+3RmzcN2ds1B3Mq/umr9m763Fdi?=
 =?us-ascii?Q?/EoQLbf6il21jRx9rnEvxs9Eu/QO2P8PFQCmgrBhbfZuLe07iQfkQ6gQQy87?=
 =?us-ascii?Q?P8qSswUhT1SoIFsZ1Y5+g/g37boVWcJYnPo4bgn0rxQGJkE1TULQK6+P9tI9?=
 =?us-ascii?Q?I/fvAD/4NNk2HzB5dAFb0hLYM1duoOoJqZyHJNSjpqxXcZa/ElD2bo1GDrRa?=
 =?us-ascii?Q?AgISdtcTtVvm9Gg44hT/JV1YfXFYHvTL836NET94kNB6NrFTAY5dVgy60wVI?=
 =?us-ascii?Q?G7LddvJuDKd6gDpdFm2mPd5g7PLKQgthbajmsqK44ExyZQ2eanmQz/W17zFe?=
 =?us-ascii?Q?aISmJwYq5CI3dNq2nswQYcAIU2JgMTOp7lUkGuwOhbamP9ZpXSMtvMD2mMoc?=
 =?us-ascii?Q?GBWCNUA0BACcM3IC7Rl35wWhBsV84CbAQq/Z/dWkrwm4jqCMcq7FIOyE1pGB?=
 =?us-ascii?Q?PLcEPQU/36aseQ07kMd4jSYDoHMNgm18GSigR3bLk7+WDW2aOtFtZLlhYVA9?=
 =?us-ascii?Q?p1J41LKHVcNURM+JQpK2+xvyU62/wscJkKseVWGttAuFOsl7C6bIug2655l0?=
 =?us-ascii?Q?tmT8Zu8BNxKarlO9XV8OCyM81LJlHNcPDT8wZTq4X+nykEjny5dUydBwPEna?=
 =?us-ascii?Q?S/ebwGRqdG7l+QkMICtBju4o820yIN5+Ho25ceIP4aPG2Zk/GyGQvoy1gY76?=
 =?us-ascii?Q?+tc1Qk+KfySneAY3h1tHWnNhaW7g3kU6ZTnK6JvmO6JXUJ0hlolD9j48k0B+?=
 =?us-ascii?Q?PLEc3k6RUQi7UVUkg5NiatLiPiZWTczDYnId0O74U6DAxaX4WhK4RkFgcgQz?=
 =?us-ascii?Q?UNZr/epE1rK4Q37ZIlwyB+bY3y+FzXWKABq/4rlm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543a113a-10a9-4ead-43e5-08dd6624a3ba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:56:11.0698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM9NpxllzSuK/XzmRX2nWjleI2a8nb9Dx/RmBX0hgKAepEafqLVlXi/R82oQfqAo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164

On Tue, Mar 18, 2025 at 09:50:12PM +0800, Yi Liu wrote:
> On 2025/3/18 21:26, Jason Gunthorpe wrote:
> > On Tue, Mar 18, 2025 at 09:25:56PM +0800, Yi Liu wrote:
> > > >     	struct iommufd_attach_handle *handle;
> > > > 	struct xarray device_array;
> > > > };
> > > > 
> > > > ?
> > > > 
> > > > I think I'd just accept the additional allocation and not try to make
> > > > handle re-usable. Every unique attach gets a unique handle allocation.
> > > 
> > > If so, we also need to loop the device_array and add the attached devices
> > > to the new device_array of the new handle.
> > 
> > Why? Just don't use the handle for that, as above, the handle is still
> > a pointer that you allocate, and this pasid_enty is another pointer
> > that is allocated once.
> 
> I see. How about making a new structure dedicate for tracking attached hwpt
> and device_array? Like the below. Reusing iommufd_attach_handle structure
> is not mandatory.
> 
> struct iommufd_attach {
>  	struct iommufd_hw_pagetable *hwpt;
> 	struct xarray device_array;
> };

Yeah, something like that would make sense. Then the handle is
allocated uniquely for every attach.

I'd also add info to the kdoc's that handle should not be reused as
part of the API requirement.

Jason
