Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C0194132
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374443; cv=fail; b=itsVpC3biZ02+U7IAqOPyiOXeDURXyMQhZ2lzzmABil7JqRXaIajLqAqNtFeowVhTRf4i09XG6ccyDj4DoPiPI5H/yNLWTOxAjpxZbasWklBIqiAda2dC3PLmvFHh5RrNqXKyDFcRMI7CvGsyspuqNYmBPwaEIfAnTvB6kStdYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374443; c=relaxed/simple;
	bh=7hvznawxOglC8R1iuKb4713cgFFOEYlQeZiZAEERo4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEm5OAg2TVN5rIoXgvsxU2275OLEdLAjtQkl5/Cli1KogKiNuAISxEaEg412VzBBP/2JLmgU/alM//h6Oj2UIwLOI28OBPMI+NSM+OvIYZ6C5xt25GvNP6GppBYx6HpnD6YkGKO6XiJvU+J3S6y4eg1hQND7VE9NaR7HmO2JXdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VCjaktVR; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VCjaktVR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbpNtXZacDkhO2M3woOCc7Zy2oz0qtoIBl898WgksXLl8+Lwlhay69252GpaFrtoXc5jhTRsFgQmgc4T4otm3/fqz1vAFHVDeNpvotMPyouFPhK8jFLVLPozPqvaIbmPcEeUsQ/YEfIQpKwTst/yDV9DttiZ9oVNW0pU8I8Whp97k7Sx9glwmTRJ76qWEGVkb+HJZtWEU9L8V6tDR2sTT3/2zebiqNn/VirjqDj4FTpNlCv9Yc3T6kilWBLfxifcLjAYlsp03AVuW1SXgj5xir40fOBfU+Ep0LAg4AHkiNdEQisidOIvsaNa2HC2tcU4X0NHntDjlDJtbu7zj4LtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBTwdJA/17XGEblqvoCHTux//aUD71XjRmZr8xs5juU=;
 b=XokUE8mEWUoUhwIljJIZ9hAAQWvJYBMRRNrb19+cYmuSo/31BGp/a5ezEnKL9Ch76zOMDzk2l1UZDITLgPt0VUSgpUhqsjFxpOkXTnfc38XQtTaE930QKv6yhanBUo3VjjEeYi6lct5lL4MmNyp4WoV/WzJieNvEsMrJkUOIZx1oFXEhp+/wCmhF+3hzMIQ42G14tIcP42/MbQq9exxEbeLkXBzE+ziBuGdf6yMbcPfoJaUlFVbrJc/xUi9TKMICTMeBJgHacZN8V7rowanscl5TTLz4iPh0tyvNF8waQzMgcLn+rM8eeUuf/FO3yPGLvAC/Xhm+TcIRTx+8QPeE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBTwdJA/17XGEblqvoCHTux//aUD71XjRmZr8xs5juU=;
 b=VCjaktVReinbIC0SlPpyy6G10Y2CFHfFfOwccGSZFi4CiLl2Wx05KEsdGbQdKVyfu+/xXjzrkW5QNrEykr4sRt96aUaswZavchQGgCIHc9lvlr6508MghpcHc2ocWJ8LoCtct0Rj0ZMA6vvdNDkMudM7gAhHta2/SWK4lgpqpB94WjNsZLMsPh6CuYLnaBf/RZ/sqEv12zil/iB/5FSgDjc09rUxAx+XbmImWkNOgdFv514jo0endWzBnpGTQG7JlA+Uy8fXeufSSF6s157zhwlt8A/SnzBviJWFy2MiX6Ev/uox6AdtajYHFH4S4xMG9dTrymKlho5BsVC+MPCUrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Thu, 31 Oct
 2024 11:33:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 11:33:56 +0000
Date: Thu, 31 Oct 2024 08:33:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v6 0/9] iommu/amd: Use 128-bit cmpxchg operation to
 update DTE
Message-ID: <20241031113355.GC10193@nvidia.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
 <20241016142237.GP3559746@nvidia.com>
 <e617c4ae-c5fb-444a-9649-ffc7d41f79ba@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e617c4ae-c5fb-444a-9649-ffc7d41f79ba@amd.com>
X-ClientProxiedBy: BN9PR03CA0575.namprd03.prod.outlook.com
 (2603:10b6:408:10d::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0337b4-9e30-49c8-2b00-08dcf99fe7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+mD9pUEpo1Ov9qlp9F4iGYh9qvBuJtFQlSgB8LMsuMZsao36P5xf05TJRysx?=
 =?us-ascii?Q?9AjDIfemSaqOi4S0oBbWiDS7yttkuqHvOz3dmHSUdmrAZkAY03cHJEbfpf0J?=
 =?us-ascii?Q?AtKQ6AxlWW0D4ab6ANXoqXqNO1TAqGMD8DV7PztA0mKjJ8vMui/pDFpWTM+1?=
 =?us-ascii?Q?caSwqc71NXq9pRH9AUi6S5nQCl3Rv8WiWY4XaLj6RWV4XGmMkylTdMYRIaOT?=
 =?us-ascii?Q?Cu+Rb6ZIMzRsIuuHkppCsw7qg6Vpn6zhUwpcPpFSZYuaRfex1BoFYNa6QzOW?=
 =?us-ascii?Q?OgPFm5QkHaPYbhwHLcncv8cq59FaUBAZTUONCTndn90yWdccXgXussnl1s3M?=
 =?us-ascii?Q?4WicrUmsKNJTqskNiUNU8+lAbj6r+E+PVGy4fDvC53qfnZ7bpANp5G2Q5KEI?=
 =?us-ascii?Q?b6p3x/ug25mvyjXBjGdhIiXQd3xTxlgqcxjdu6slEgKUhH4raFexGLp0NWbH?=
 =?us-ascii?Q?dAoVkZlIue2gPkaw3jzwDNdtFm1bUNm27ejtbBcUGousSFeIMeXHBgRK69HG?=
 =?us-ascii?Q?tww32k4wRvdcDrEdwpgZUTvl0Qa+39puSP9aDPqAKaJPJh+1oq8tdkefWokn?=
 =?us-ascii?Q?ZkYvVOI2b+zZLSeASa/GuZHPAWPxJWDUL8Jv8V280X7jua7mi44JxckYiiOU?=
 =?us-ascii?Q?ZsUEKhfyV9m+saZqezaj29npYBgqPWtpwh6zV875s8ENsslNS8FbfTfpm8mq?=
 =?us-ascii?Q?m6wONyUliKhEOXF52kqw+PdUjmeJC192fiIT4LZyZGxlz1BpOajKeMeZ7QPk?=
 =?us-ascii?Q?hIbQrbFu9/235h2SYobMAQhe1Zhp9m4tSGWemlkxLLbi/9Vuuv5Jxvt13gN+?=
 =?us-ascii?Q?rTw38r6k/IoWTizdwTOsq2iDc+t16egS/FvsOABUAg2DoZLPCMqD/YaEwi8i?=
 =?us-ascii?Q?XVIWzp//D5peUelsiUVTJGzlqALMJQg+hvLNCsErsdLPwDTZAvKcqTGhMAiH?=
 =?us-ascii?Q?1UpcMziphVNToXxeydsB4Wer6VDPH6HC1kFwH6a7e/B7WzGAFHvvRzckowiY?=
 =?us-ascii?Q?vP2xTf7uP9hLRJx/os3PeqUJq+P6uTh6qcHHH1GO2lbqsYwoq6pH7xkf6HHH?=
 =?us-ascii?Q?RlXAnyvIgHvWvxj2frT+PrXpTbWfrao9WokTbugI54XM8yoyksDuFtpo9Hnz?=
 =?us-ascii?Q?tOKO9Xi/C8o853Ck+I1xPu3ft7pu4bEEz12o4f76J9yx9FQaZamYAMAprHKA?=
 =?us-ascii?Q?hHcSeRSLMiWlr6sTa5sy7cXeW+JvSqLlUiOv6S4zf8jETa/CvPvDA7wQh9WU?=
 =?us-ascii?Q?ybkld0CSh+ZO4fYWlbIK4AI7fs8WZhwYtqJuIAXf4m/Zf5yflmziIzjfIklv?=
 =?us-ascii?Q?CQDModO8WzWI4ytkTVhpmm9N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GvfYAdH/Qx2yYk9HrZsEB+hu28vbLoZ/YV+hgTdYQU2kJYv37mh4i1+Uhy8c?=
 =?us-ascii?Q?QDaGcgrTfLY/z6XmurcH1Gwjoo6cfuRILC+rycDFdQUD/OZBYteeMZnUlRTS?=
 =?us-ascii?Q?KcBnAeQ03xqLDZ6IKCAPVeyZLJJMZBusEVJADLEyaFmpbxBltCpxca/lkyiK?=
 =?us-ascii?Q?G5t8minIDZ4P8+soFcfmJVox/JouIqxZb5cuYBYGYX13IP+ML4/cYqzEk4r4?=
 =?us-ascii?Q?8T1tlESnPOt7n84TsNISYhivSXMiocGfQ+9hHSJblEvCysfiWGKhX162OdCj?=
 =?us-ascii?Q?+5ntk3EON2LdlqSYfyPGW5/9yIOxY+0IHO5zOZNyO8JPiYut2V81RI0K35Vf?=
 =?us-ascii?Q?BgbjjAqY4V+23DSj0eqvAYPpUlHR1eFj5gndNJpsVKK5aQsR5cfbPSJXCU4q?=
 =?us-ascii?Q?CIRwvy99lbfVuZk7H351BjWOFBhFLDvREBtJE+/SQ2LyMCbCJbIzeI8UGS2S?=
 =?us-ascii?Q?aFPdLrfgZZbjqNFE0xIv9IP4boylmtkOreYyaJt0JeOrWKlwm/xbw0w3qsxq?=
 =?us-ascii?Q?HOv5r5aHfSSCUBrBgypq8dTqrwVwNOZgI9t5IjBV3/p3OAnnOFqeWpj/wgTH?=
 =?us-ascii?Q?av/LVji5iJRqJcp9Ku+cNvgLeWMlIFx50KIe7bv0muyufDM1fzDfDMid5NUi?=
 =?us-ascii?Q?+pvh+Ryye2bCUdGP7egxm8O4TrLxjcx/ewWZfQPG38yFIZ0Ejb42aJ/4ELha?=
 =?us-ascii?Q?N/KDZAE8fA7r2KnjPw2//r1v+6tQreC8kFFGRWEEJSqzyAzsoKSgzEYSULhm?=
 =?us-ascii?Q?ZJwyriD1NBLwTappTveGjWW3+4L0akkFXQfmAOtCNA1C3cBO6ldyn/6bNNHj?=
 =?us-ascii?Q?cTDMklLPFwilO1S7Gsgb+A2SgBKQBLSDf3ruwT5svdU9tXYH1rK8pfXn/Nr6?=
 =?us-ascii?Q?Qt7PCb0RIxiue3ru37DghQ529I+OrbCZ8/oe39Iuc8x5XK+ab/hTN3p2jO5u?=
 =?us-ascii?Q?5us3th9OE0RSZeIzOoQuXEw4Hmw7CTGRw35Ea9k5AuNXWN/ZHA8IRazmipEN?=
 =?us-ascii?Q?vzdfKK/cQrebo0X6A7Vr7F9sUJGp0+ypJbAtvX0+maVES2mrfel2tpybtUU2?=
 =?us-ascii?Q?ZozXgckPolLerz6tkLPMA2s3oaKv4ZwTlBL0knET2AORBTyIavY7HSRts3yj?=
 =?us-ascii?Q?lHZt7vkh970YW5YfI8eZAQXkFznhdGXKAO/YC7FXdtnPUt9WahF2yFRjN5ws?=
 =?us-ascii?Q?a8rXsNZB8SxhFpSpsG2QuTOFBzh/lOLdcyhFjoP10KpYFdSI2oRii5681oZQ?=
 =?us-ascii?Q?hVkzMBZfzGXlNMXcHOj8WMGQbKK2Xw6BZS1wWxTTUkFj09cNEQEGo1afYkQb?=
 =?us-ascii?Q?OGWpiwpAzg0a/C0pQNntVsbvJXtBYjfdc9HX9cJmr0DDASmoVlgrnuAUsm6n?=
 =?us-ascii?Q?XX2T9iY+5oeuRxR5ZGodnujBnKoZBuHMZSmBhipRsIH9RZ9rN6t4pzhZlu1h?=
 =?us-ascii?Q?5m8yL6Bf5VP0O4eXrChMI6VZR/aquEkl8Fzt+5JsvlHYdSL5S2/y7QTFNd50?=
 =?us-ascii?Q?7U3P/IeBloPl9rLoGE2kDMP43DHh7smo4qciVLPFX5Jlv+042OH9NvNR2TRd?=
 =?us-ascii?Q?J6IF9VDLScWCl415GE4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0337b4-9e30-49c8-2b00-08dcf99fe7f4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 11:33:56.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kxDC/yoG/QedNb6XEI2cu6gDtM3s7g7npMzNrTppwMdF0H7BZQGOkwdLB+Krzp3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804

On Thu, Oct 31, 2024 at 04:15:02PM +0700, Suthikulpanit, Suravee wrote:
> On 10/16/2024 9:22 PM, Jason Gunthorpe wrote:
> > 
> > ....
> > 
> > I wanted to see how far this was to being split up neatly like ARM is,
> > I came up with this, which seems pretty good to me. This would
> > probably be the next step to get to, then you'd lift the individual
> > set functions higher up the call chain into their respective attach
> > functions.
> 
> I like this idea and will look into adopting this code when I submit the
> nested translation stuff (right after this series) since it will affect the
> set_dte_entry().

Yes, I definitely want to see this kind of code structure before
nested translation.

> > static void set_dte_entry(struct amd_iommu *iommu,
> > 			  struct iommu_dev_data *dev_data)
> > {
> > 	u32 old_domid;
> > 	struct dev_table_entry new = {};
> > 	struct protection_domain *domain = dev_data->domain;
> > 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> > 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
> > 
> > 	make_clear_dte(dev_data, dte, &new);
> > 	if (gcr3_info && gcr3_info->gcr3_tbl)
> > 		set_dte_gcr3_table(iommu, dev_data, &new);
> > 	else if (domain->iop.mode == PAGE_MODE_NONE)
> > 		set_dte_identity(iommu, dev_data, &new);
> > 	else
> > 		set_dte_paging(iommu, dev_data, &new);
> 
> This will need to be change once we add nested translation support because
> we need to call both set_dte_paging() and set_dte_gcr3().

The idea would be to remove set_dte_entry() because the attach
functions just call their specific set_dte_xx() directly, like how arm
is structured.

That will make everything much clearer.

Then the nested attach function would call some set_dte_nested() and
it would use set_dte_paging() internally.

Getting to this level is necessary to get the hitless replace, which
is important..

I hope this series gets landed this cycle, next cycle you should try
to get to hitless replace on the domain path, including this stuff,
then adding the nested domain should be straightforward!

Jason
