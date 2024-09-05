Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2319ABA2
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537939; cv=fail; b=c8JnPKSu6bPxA6oizssytu3m0SvjdgzX21xBAKud6um+NYx1sFtjlqPWtiV3IkEbdeZmi2NTtsNC3a4FFzDweXOich9WvEEFxdgYm7NPGPNOX1AwobpiflbhoU7z4mZ9ie4wkAYbvKRHYwEc/QpDQXWIBCL/ANdWsDcKdh7wLTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537939; c=relaxed/simple;
	bh=L4Fm4c2wYZSashPYfY8l9L6SB6ssJv1iM/+Ebhd+Jpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VQKKypRrLRW83akboGSTfB1eYkOBpw85BZUQg49q/Er/1DXLx5hvi6815NygZMD3krONmJVlywCIu5w8XrvVPniUlaXBnp3u5+bDnBagx1zwJ2Y70Ei2gVFGFjA+q6c4KcQvcOil2YvRfMQjf070clQ+3G/Ktgl1wc1Bwe7toI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QDwcTqSo; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QDwcTqSo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3hSyRM9AKXJXucGfe9PBvW/i41lNzA8ebqZZq8Rv9uUTT87OzquJtIH928bLnx78OvGkWPXJ/m+79ZbkG9yWXzd5kBYI4WkJ67ixcL6ymJjz6BcxfiptlqkmQnktRKpmZ9rL6UVFh/UQQIQftWZv5U2rpYy+QZX137++efmL4TNXjOuyOFrTJHYX4q8i6sooyDOWN9VZKG+uGaH8f7ksS+mPsZ7E1LPj++9aDd2a5QPgacpIrmfHkNpCFZTOyhQH3fU442Jclki7XBoPFkMW0dqFIYakbwGgrwyM7S76GSUI+0DHL4syl7KQ886MLGBaALjUe8GW8S6YpEpnRymEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r6fzjxMbKiGKk9qqiQ4TzmgeGmxa9tkTIjd/6upth8=;
 b=Q4ge64FTjMQTENw9TiVXo125zvJ2XE4rzK1S1RWn8zU3/XkCvgf+e0BgvTvmVmDIKUVF/RgfdCkEaQaqcOGyLjqO/UngIaN2/Pcr4VgoGAhaNoU6BKLALN+YFRnfK2pp73xON1ywqQPXFPh1ocxpOwaK/QpL3/TDPWYB5HoLxIdkHkvDKBFzvxDwbgxPMcQ01F7IBLr3vKzdRmsw3c5jOOApoRNVWrEKZwwRm0v1RdHsPYG/dVaV//rpBgEPaxuQDoFlQm9iCbJx0Pi3RL6fTX6e5fg9fv8GCodBloO5K/vfBSy3H95SZCs9+TkCqMTkJw/16weLJjLueTrzljjpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r6fzjxMbKiGKk9qqiQ4TzmgeGmxa9tkTIjd/6upth8=;
 b=QDwcTqSo2wwCvtKWrb/rEEWtGkwiJCgNTSwWh3wZ5G8JW8fxAtqf3SKohN4Ol9mnhHlju04h3MNkCjtVp8oEiTjCo/6GIiQ8FbJ13ZqtctNAH/m7wdTqWKjR8C9rFew3VbFVIzgyCGQDXp7kTGc5JHTN+brwBbZ/3Dc2SMufSzA6g+tMyascvL6Ah+4wwhgfxnHrRSPae4v2APaqKjI3mKOv8nBi6nF2qM/wXCy1jlsWKHjTPzjCfas3HGS6kmS3/IWulwgV/RZXro2RxUamvc/7cvFu/K+PyR7XPYQTa6kCfEJtcJLYANlkoWw23KDLxA/cjwNa5CTHgEgd8qAKIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 12:05:32 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 12:05:32 +0000
Date: Thu, 5 Sep 2024 09:05:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Add kernel parameters to limit V1 page-sizes
Message-ID: <20240905120531.GD1358970@nvidia.com>
References: <20240905072240.253313-1-joro@8bytes.org>
 <45a3ae40-6e59-43b4-ae57-d159bd2b54df@linux.intel.com>
 <Ztle72HfrjBjlJGa@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztle72HfrjBjlJGa@8bytes.org>
X-ClientProxiedBy: BN0PR04CA0131.namprd04.prod.outlook.com
 (2603:10b6:408:ed::16) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 681a4e16-ce53-49c3-77f8-08dccda30abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jnwj8h0pWmAP+l1YieZJIHgP7Du6IyHcynhO3hUln1U/F+UcbpxPfwEPnDBl?=
 =?us-ascii?Q?BPziYYconk4YorhsPAo1wcfs1BUZTSe6E5BvHI9i1woeujZ4YKPuVJOXtFZJ?=
 =?us-ascii?Q?nPzrunl3OooLtSgXzd3MqI1N3J8nQMX9+jL0ibDrV6aT5dG7QrxRbtvfAd3k?=
 =?us-ascii?Q?YmFcX53Q6e3JJRA6j5Uq6QmolA0t85L2pqBgUFCoa1rAzL/jmPEc7yqdr5qp?=
 =?us-ascii?Q?Zg2XqcRXFQfNDXzaCvdL3GPJEslafwwsJwt2ilDj3Kr15G4TaC94rFh3fFKz?=
 =?us-ascii?Q?FpCDBECsr6Cle5QD5TeRu4qLtzIyKUyi2vvtUllG78Ns9BjuVnk9Jr6Mijgl?=
 =?us-ascii?Q?/9BSXDQ3GizUxNCj6Deu/QhJr81T568g7sHm0M8F4QiCCRJGKcVnaInsdqQ5?=
 =?us-ascii?Q?ZP91RO9mMajYQgKDzMbL9WimXZRk8lxh5ugiYvmPYXzB6Sof4TLMRfWVSZxH?=
 =?us-ascii?Q?YfE4+Ab9/D8GZ2KM2ibhTCDly8g3dDFQQbWsEQbrm+KfjV1q6QKTL7YQrimD?=
 =?us-ascii?Q?J58xQUu967kKNFnr0HzZZJ+eVbDlm+nkvQFos5PAK0AOlSKF34cdHZ4QAoTx?=
 =?us-ascii?Q?lXbyUSl/DCYH03RE+DRUkJXVAPUjMBeVFYBkubwl1cWAZ+TpuESfTYQ+D3gJ?=
 =?us-ascii?Q?1ZWRSexgCIrnfztW/B64myw4yag2sBfTxq3kzbGRfVXaR14cr0HlA7+wKDSd?=
 =?us-ascii?Q?HqEm4v+bYxI7s84eyA/GpRNfJvmF9ngxAoxfcAuCdV9Ep2OuYKHgFdwTBvtU?=
 =?us-ascii?Q?N72nEgKqSCznpxnQv62m596w/4ZHAX0mVUgTjR3xnuF3iZbxGelMmh0kj5sx?=
 =?us-ascii?Q?FCjlFydZt76G9SRUC2QTYLhe8Y/eyhFr8D8oCWSZIlGtCxbmDgmI0dOBHbww?=
 =?us-ascii?Q?Y8lfJ6O6c/diCWz/hTK0FqN35Y8CtXjitkFm+Tjz7O0TBESnof93r0gsSGsC?=
 =?us-ascii?Q?DhCF7MV0r2ZsjB+QNjg582/vnBOMXhuFszxghbQ4vSjWliMz2Uert3swJcn/?=
 =?us-ascii?Q?Ck9g1yAD+2tmMOo8/KExiNLCKcwR5SJp46sCjI4mcbAfyXzyM5E55oAijthK?=
 =?us-ascii?Q?nEp1bKhgNU67jtk1lIOYiFKHdZUqcu9p9dQ+iyWy7lRLdeaN7718SCeq62SZ?=
 =?us-ascii?Q?/R2OriEf83FFnb4uGa+Vi/tRuisCT0A8ntU41GD/3kVS8Jt1qqpJqh9sHPaQ?=
 =?us-ascii?Q?oaG+hA6TL3WEUVHK2OkOmAyvqioxQ3DHX8MLLcCGtrXezPin7HEKSvbyarQF?=
 =?us-ascii?Q?OH98ZGxPFI8a6NPYlpo3y0vZgAex0FklgK3SreVpKzMuxWpFywNpQgy9MeJH?=
 =?us-ascii?Q?AuE+e60ESK/36Ht0AnpWr2mUfnHQr5zjxEq/KWuBfqfLag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/NrHdZ/lXbmf2umstPQ/rNjSssoOAaUnvlKD+8O7jxfNGaI+ACaPGGr05RNq?=
 =?us-ascii?Q?36DWF1YlEwcLEOCGi/zzF4Ukr4nxOZ6twMqrP7FU/G36QvR20qia3bGxS3iQ?=
 =?us-ascii?Q?mqdulXh3ij+PJSsaibYiQtWPwuHfjzlWvvGmm04G/2IFqBsb4vZJ6nwgJWHd?=
 =?us-ascii?Q?pHl+dTohgFfJwS6OXITlIPZVJr6yKlvKGqPDHjF5vizpxMI1odOfV/aoIyLD?=
 =?us-ascii?Q?UqDutEiC0fRgxbKELppHPLZuyZa5uzd3DaLr49Q+Ewu7RCOK08KwoTdbDaUN?=
 =?us-ascii?Q?+DOJbIoAJtyQG6FDZy/M2Q9EG1jHPM/DDyXUUjyQh1+Vn5PY6/bWfUzYIJ59?=
 =?us-ascii?Q?MKmBsox/Wp8cgtSiEfVALZTM4mDf+Y49tZfbWJNsthSE+hrpc9vCPo9cSU0l?=
 =?us-ascii?Q?ngcxe9jcplEQ8fyvW1/xeeMgdcmfITmVLBoGS/gjUpSHDfg+lbOoG3LvDt8a?=
 =?us-ascii?Q?lDE7oo6btlEOMmO1B4EBgAjyPOg2xBRrypQ7aodSR1NKoiT4xmFssxEbZs/b?=
 =?us-ascii?Q?wH6bkjuZGA8ugGOSL0WlckEAlPDtPuubE1qMMEUpxMw3yymwN10918dJCDPk?=
 =?us-ascii?Q?RM+8C7AOKv/GD07haUhnHhALEm0khPlBovPg88uFBHlihWZymJps0ZR3z9Vq?=
 =?us-ascii?Q?T/7eL0A0F++n/ygopgY+OLHH0wV4LlH/3LcZRyRItFeIlfgqtc4V1PBqHBJC?=
 =?us-ascii?Q?wO92T16cTTII88ganwA323zAbjdScQXz+bRerzRMPTEGNYqpVXmwz9cRCbwW?=
 =?us-ascii?Q?vYRNm8TkpmEv6Qf8XdYF3r9FKLI7/n9WSxS2MkIJvDy2wktW8az4m8pctIUp?=
 =?us-ascii?Q?doCm/mtUpclXoYs95BewzfTHj3S3BVA4ybYENzzhJP+ixGjSJqrEr3jFByip?=
 =?us-ascii?Q?ru8RTUAd1KEqCFY0Gaul8TlpXWj2a1NmMlh51KNNHrevNCWkAXnDpehbdixh?=
 =?us-ascii?Q?Kle10tBcU07f6eV0Ftj8Ftp4+akAHlHvQ6ijLjRLHFCHOJOfBQmnNb5rlyyn?=
 =?us-ascii?Q?nZz0g1RkrIppmzLEG/A7ZKcj1zx2NlJnKZFI1wzzeLbkKg/mCOHB7uLOK3rA?=
 =?us-ascii?Q?6yvwt+j951/lLgOkMBaNmm22gx1caF+V84YqkK5YbKb8AXKkBE5GGLYf4Txj?=
 =?us-ascii?Q?1yZT+Pf8NiDUwzb3hZOEtVAgJbqHZtrYy0XJRzUUrNWpLGibHF/ki/1wzbde?=
 =?us-ascii?Q?bRYI9/GIebW3xtf0rihRZv6YZAEuS6iMEmpcZLSL5j5CcVyeoWr3MkMLZ8sl?=
 =?us-ascii?Q?zuw5Zq8AGyKRuWakXR1+YzefEkY0SPKjAi+bwkpJJsDTHzyfeIHVRSKjidhg?=
 =?us-ascii?Q?dEsr4ibmRlwelUc/JkV2NtqWGFXERr5+4/3ajtp6+erYIY+KMMQl314M/h69?=
 =?us-ascii?Q?GvGdDOlsZ3C15VuRDcOhGaxiLrZrMNkFIqme9nbfAOStN5WOBCfVMKN0cliX?=
 =?us-ascii?Q?g0wVaNn1DeG39jvRMTFZMTxDiM4aBQAMk5bXg8D/1lXt1hWbqCLBxJiEdP86?=
 =?us-ascii?Q?Iqm+rNMY5/Cq446RZTwE72wKe2Ht3ytuQkMxmANBntf9gmSHa3l3EI1uR2bS?=
 =?us-ascii?Q?zFdA4bZhcY1d0x93Er5YT7YfFU75xpa3ZOlX3hdI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681a4e16-ce53-49c3-77f8-08dccda30abb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:05:32.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WELQp28sIrhn/Z17c8WplQ5mt6X1WycPZvvShgu2+RVx6pmR+nS9WjU28W5BMrQI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672

On Thu, Sep 05, 2024 at 09:34:07AM +0200, Joerg Roedel wrote:
> On Thu, Sep 05, 2024 at 03:31:08PM +0800, Baolu Lu wrote:
> > Is it possible to consolidate these two into a single
> > "iommu.nohugepages=1"?
> 
> Generally yes, but that requires to touch all drivers to make the
> behavior consistent. We can start this effort on-top of this change, if
> desired.

Let's at least use the same keyword that already exists though??

Jason
