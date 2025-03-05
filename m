Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6852512CB
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197205; cv=fail; b=Fh11xJfp+cDPxdi/qAgBY3sLEfSInuAlChD1Kz1qC+ouXeW534alftn0bBysFVnd8ZRlWyoZd6bcfUUvJKtNv6g8Ecau5iQpo87ebqkIteeqJhQ8z0xwUYxECzQQ086VxIVhPQAp3Oen9g33reZIRtc3XiqxIy2JFb8lG3kDmLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197205; c=relaxed/simple;
	bh=RU1Hv/Cyvk4ttmazGkNcJW68lLhnNIRHvU0sFBkWlJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tkjw7ljLMWrBEDmmYMxV3IPCIyH2dT7ztWG4pNc+dMaL84Z3dJURS4IS584kmvtGTaBCsHx5I11JZ1uVTi3Gfrj+VSlXcTNmEvIoL09y3d8H9fhuin3roXW8w24U+ZTimcG6cNuf6RIrlc8kDN68IdiT17OJ4bFJxVYvNUskK+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AWdyl1WA; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AWdyl1WA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q65i327HO1WJ9KE9H+PQuaBs2dfbu/ke7SrXswvUo2FEYnGOhQITA2V4Cxgsc6qMQ1HhBeivB/zJ0tVq2Od37Y4WNCcBwab2z69uaKzredkvNgYCr4rySmhWsT+FznUPLJ0MlrsiDqa5IY8st/4bfFQRAvh6AcyXU8YY4GH//wpGz0SJ2ytdXqsON3JsYKHVsSoB/8E1hXvLgi27Z7kQV2bdbIVuH93MWaB22E2DWbTQJTvxfj8mpMVSlZsPhbpdHd5Fb9HIw9Vo5rn5/b66TOabgg3U5waRPlAvOFloWU0xqgZMZDMJ4LzZFn+rig/dARqDcpwIV4xeJx2+ZQvYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXt21lzLalGRJOt6gb5gP9dXab89HyRBu8J0ASpcztI=;
 b=JQtFlMI4K6dQHT3oD/1NFHTnHlhPV2opfKyPa/ErP4tmdApHoKSKQYIfKedONB7jORhOxNrsb0HNuzaMLI8n3Vqbo2Gs5FYjgkgzQroWUWAtnoexGBBmEt/6U1f0e0788y9frnO7h2iLBDjeVa+c/2RmUliXsLGTBgbi6vDmU7vgyltxLcWXOqqaB4FAGiHW+QQJxj3A9ph1t4oETErCCmjWtIuYxjlIMTCjIO1jHRlVNcCdi9s3M4rUw7Crc9s1oRv8jqlaLGdmZGFdVIttVpwZcKoqNvoMcul22/gjTElrEFCDVBXKxFAoPZdb3HKHOrfBEfMgcWfUML5yMsa09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXt21lzLalGRJOt6gb5gP9dXab89HyRBu8J0ASpcztI=;
 b=AWdyl1WAwuQ9ehOVO62qYDQ5i1xViF1Ke1tL6h+Lmuo9mkyTXmsAGTFmNjy0q4G/cjY7WXn9Nv2hRkO1s+eoNJwH7iPtQrc8ucoz7FyjO8d9JSga1Nrre3MwHcTVu0zfTLhz88Ebhy8cMibNMlFs7KTT0whVykdb/APL9qQWmQ8+ijI2MH92O9MKieHXnc+PF9CXkycCX3Yz2Hb9pqNWA2gUKA2d9VV3cyaS8TKvKZ2esK+cqaWOWDn1MCfe3mxqybovncGFbfJZT5oLuvnEjo3VJvhpv8tGoslDiXQhK7b9I9sXavJMQ5oBiH9CmSrZvhvcehWRPoSUhgSAo3FeZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 17:53:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 17:53:17 +0000
Date: Wed, 5 Mar 2025 13:53:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iommufd: Move iommufd_sw_msi and related
 functions to driver.c
Message-ID: <20250305175315.GD133783@nvidia.com>
References: <cover.1741034885.git.nicolinc@nvidia.com>
 <01eef75aaf5326067d8a237496ca67395994760a.1741034886.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01eef75aaf5326067d8a237496ca67395994760a.1741034886.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQZPR01CA0180.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 14405467-58ac-47a6-94e4-08dd5c0e9bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Ed+23tG5nP0KNRy4+8XhNFM0hIcNC8HlIz9wdNnd+lXrw2XlfBC511Gp6YI?=
 =?us-ascii?Q?aqhwxR9B6MCqgpEtKXGzcKVupdBtfnFW+Iy4DXLVw68ZpNKGDZOX9essOsVt?=
 =?us-ascii?Q?G+jRyay8R6HyYfULiL1uXPC7cDZCMBr7zybV2fRetQLuRhH5+f8ze8NAOtV9?=
 =?us-ascii?Q?DdqhqiRRPVRKQ7v24QVogM1yuXbk7RvUZrOzuqnUU6GcEdLAobz3BppTHkbQ?=
 =?us-ascii?Q?0xZx19uora+38ze2rnOH3iqEFM8dCzHMv0sdoLF0IBbTrOWYf7w9DmCBUDPu?=
 =?us-ascii?Q?TiIg+ycEXWK6bpm/skjYrUL/2XxRfHYUg6vqoTbA6XUtYDs1J5LQqpdLF5Lc?=
 =?us-ascii?Q?Y7reLASiuQksxetueiekLPzGbtnfpt4avIZ7Z5f/oDS3fbNE/U3PtjGD40NE?=
 =?us-ascii?Q?MlnW6uKc9LlWqk3T7k2MKhZLtFZUqvnRRaHX9dnBZfV01z+zJdVIplxESbNQ?=
 =?us-ascii?Q?2xqEGB7Dzi1e88pKhUltv7JWzIBwtOlpW1a2y0aEBoc9xy+/StFzp6WkFVVj?=
 =?us-ascii?Q?WgcFoBfUSeIZJynXaFs2Mh4BWHhKmbk32/cXdJPv69/cQEbCjKGkrtdXlW+L?=
 =?us-ascii?Q?YU2fNV+szRbnJWxApKDpVkyEvfI79tksVTqO4LIKGx5Xg2F169p5P9dBuTC2?=
 =?us-ascii?Q?jXw4AblXdHmuiTVJlpq63qtB5D/pbdcGY9O4UUSsfM2HErXAeBWHPKJlnXKv?=
 =?us-ascii?Q?f9IJEv17HwXzffXLbP5yznodESlKFlpD+5SwEvyO317Zwt+exjvmjiffOD/5?=
 =?us-ascii?Q?nmghEWmJ+Av8FHZP+4d8oBrHa24BAFcvyPdGhx15ITWtlc9iPUEYY2wDo8fX?=
 =?us-ascii?Q?60vG3gUhRIavxViqkm53qC5lXcg8r5IlesxX12UL8cmgcKN6HKVNqyhj5j95?=
 =?us-ascii?Q?U9LzjvPDH4BHw0yORrG89nU8zmpJillH4dMtFA7EZUR26ZMIRfSEW1TxOWfP?=
 =?us-ascii?Q?77N/+6DCbv1q6Sm1ZnQFGvgiF9gyGbBTuLdOuyYNnDoATOstOfkPFEeL89R8?=
 =?us-ascii?Q?0RXUCh9h+5l6fWfwY9hg/ScxE5kQAUNQVKD+9nNM4R3tlNNDvDjcYLU2ppGZ?=
 =?us-ascii?Q?+avOoCbX6x3nJk3dcGPvtP5ef509YpCHJYkXT3T4FgI/rNHd7MMPellGZuQ+?=
 =?us-ascii?Q?1ouKnj2ZovnlWq6vCIIocmIfPEiJo1PcgcyQsyyEixG/eE3XcmXIhDJWAhKO?=
 =?us-ascii?Q?t8hOgIgS6zrnPjukXgHw/V6QkVYm0yHeGrbiozNi5E1RoF6XekwouR09omll?=
 =?us-ascii?Q?jSsyQVPzkp6E+KTD1O/7wuO+yZaZzN8r0DazGiTXUanY8pU6TmKZzd5z66Tj?=
 =?us-ascii?Q?W6T++c/Onw4g7nkN1V3uupqFXpiXWE5kgg9ksyIPBKC7rXJPBslJFSi2TsTD?=
 =?us-ascii?Q?SzJ6+6pV1jd3uQ19TRExq084etAY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pUoe7RDb7WIba+t5+3513eWKUXtD/c8QvC9HUoappSYLg4ooAKbFrW9Qawa+?=
 =?us-ascii?Q?wPAa6+xxdpXnmvbWxtTWqyDR+i4M7o8f/ISL2Ts1zoKEwfobmzpOLSaVhiOw?=
 =?us-ascii?Q?aDZzSmoHNb2JssogIeSTAZKn2Owmh/KiiphWpzyWcqgldTnac7k4bxGAp73G?=
 =?us-ascii?Q?/4cOYNmZPT196jkBZ8kS+OGENyG8g1z/GxsmXaYV8eL4Mgyt4QBRQoktOTIb?=
 =?us-ascii?Q?wgosMPKJN+O+XcUu+y9imiXXUzAuUakLGLBjT5w9ukMqIdt3ljLvf5YMBEoG?=
 =?us-ascii?Q?pvyGfibrXEXwk6eR0QPTbbKGWoBKtmrtz+/hFJ7/eP6YxOVQJgKYOpIBvwxl?=
 =?us-ascii?Q?jzMF3Ol/LF4Vg2JBTR3geD7kgw4Vt5XHTs0iqfMXc/TMetDiHWzF/DEds94D?=
 =?us-ascii?Q?m0FZph1YmSSKoIfDOLva/ujG1vRobT09m7v/cYJfUP4RfR1LlvuSqdg9Bpu/?=
 =?us-ascii?Q?b/ZpFDlbdK/3sf/AVt+gV+aLCSbEzeTz+a3BqelgiRZYi9byzDXmOTN872XX?=
 =?us-ascii?Q?1xhhrzzsoB7JgtiLPN2Eku/6+i+AX5UzhWcgxnIg7W5ydDxXYVD6Gnr+FYkV?=
 =?us-ascii?Q?0oWSgvdddjeFtxs2CdvxSXWFtu9QWSzIBhXvuCyUYPn6fw22DYfI5XMTUx+P?=
 =?us-ascii?Q?QfHkosFogOQV/fcM9r31wgjuTFn/KMtSYe++YDI6SrVy96KXiXhkye+7M0+e?=
 =?us-ascii?Q?WAa1cFVz+aMlraNgrKiAAyrR9SS4WpyxiWuo7Y1jaOP4JE6ZknhkN+KDBrA8?=
 =?us-ascii?Q?iSfcd1DZNObKQ56Sr0KzAHnKR2uCodR7WUe/xU1osMBPVKnE1TmEimLEMz7V?=
 =?us-ascii?Q?HAd5f7YRghu38V5il2AuKv4HFOiuidLyJX+09O3Zmym5Wa+mme85k6sUqZAj?=
 =?us-ascii?Q?ReyYJO59BVKzjgKASkSXEC/t79VicX1dh30XL32hqBguG9NXIHiaBcoS2Cod?=
 =?us-ascii?Q?ZoTwyh1YfpyxioaU63LvObZLl64Tq9+3oHlkmOQ5d/PwV9R96RYRBtM0IXcn?=
 =?us-ascii?Q?qiAP4ZPaxxDaBElBu6jZStNs2AJZbLzD6lXy2GOst9aPp+ZXb1IMQ567KGnL?=
 =?us-ascii?Q?qoovV4tqnbawV83L3acYpSBcX6LMQHeI6jr5J8pplCi562uv7TkFTLgP+g5S?=
 =?us-ascii?Q?p8hDfyPbXxedMrTBGtz9dScamlbaCtfEGvA/0PFI1zdIOmDmale7Om7Fd0n/?=
 =?us-ascii?Q?v6mkSpH3GR3npj33+vDrEjdBJ5TfhxxWMOiXRFEJ8AtfC/u0Vj6KfgusBIqX?=
 =?us-ascii?Q?C8JxVxiyOl1D/gjNPDSLxNMEJci5CZH/uT1v7UqydKGyDkIv5eiqH46nGmXR?=
 =?us-ascii?Q?uVKlflPp+p1q0GcW3K/T6ARaLQb+YuX4jSdrEpAuDXfBy4jXvHO/pWA29tcL?=
 =?us-ascii?Q?dwAnGLjEJgjr23fEmP/xwTKbJcC05dc9DfyqJCFxmH8Q5XiQtZAXcz6Xey8r?=
 =?us-ascii?Q?ClOkoOHLSBVamXTyHwQFKD/IecY1CcZSHqfz0fD8Ym53xiKbO+S6GwXiLJ/2?=
 =?us-ascii?Q?S0W0xGic1zvxO1W0iZ5q1CwPEsncEs1vIK2LwdB0659k0e7jGwoOJDAb/6d4?=
 =?us-ascii?Q?PEZrlYDgqsXrgaYykIt6kAtD/TNAdA5Ki5INE0uG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14405467-58ac-47a6-94e4-08dd5c0e9bd3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 17:53:17.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0MpMKVpGPqD0YNyKyqxNQgaCOl22O93Tqclt5cMotAIgn6awCq7zawwhg+5KQRE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

On Mon, Mar 03, 2025 at 12:52:51PM -0800, Nicolin Chen wrote:
> @@ -458,6 +337,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>  	if (rc)
>  		return rc;
>  
> +#ifdef CONFIG_IRQ_MSI_IOMMU
>  	if (list_empty(&idev->igroup->device_list)) {
>  		rc = iommufd_group_setup_msi(idev->igroup, hwpt_paging);
>  		if (rc) {
> @@ -466,6 +346,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>  			return rc;
>  		}
>  	}
> +#endif
>  	return 0;
>  }
>  
> @@ -682,9 +563,11 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
>  		}
>  	}
>  
> +#ifdef CONFIG_IRQ_MSI_IOMMU
>  	rc = iommufd_group_setup_msi(igroup, hwpt_paging);
>  	if (rc)
>  		goto err_unresv;
> +#endif
>  	return 0;

Lets try to avoid these ifdefs, maybe a empty inline, or maybe just
need to put a if (!IS_ENABLED(CONFIG_IRQ_MSI_IOMMU) in the right
spots..

I'd also include the size measurement that you did in the commit
message

Jason
