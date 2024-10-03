Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1D1AB6FA
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972172; cv=fail; b=BGm98unMy00PZeaQDXA6sY82MbNIK7CeIayJliwccihmaqlblpVC+G+WAMogzMCO51HUOnkFVATbcLzMl2cEIZNDXFfnHZOO/cRSTvLtg7hXCJLSYwGuQHIXyi1wVqULaSnI9CYbzAMfmN1l8MpD336uzuHWHKz4mI43bMVXjuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972172; c=relaxed/simple;
	bh=coTG01CeHOmkw+Q5dg3sZ2g5Vf0qDfLfHomGldTiDL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXcR2V4CT8U7P3yPHDz8xcQO34rjXagkIPeVmMh4QgQ/JpZUdxdqXINolwa2EiQ6WqWxoH19CH/dImaDVimiHbEaFIkieo4weQtprNj4rw70a1DzmNO2q77lLsfBmTzR97kQhXNHstOCvrtkjR2iYwnGjz4aitZJ7v4WU+ZvJio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w8pfAz/J; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w8pfAz/J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pj7JGgcTq0wTWHFvLkEKiBz2L0y3Cen2EEoK6knPLDmZthCNG8ZUwkKxb8eW+jsaHaeWWWNtOOrcCZfBAr/Ozd4HfNhb09E095En4BELSXK3dlvGrLETfqoI8BHgvWJzqaXe268KGiYdADf2/RNeBZc4WUpeVlsRekM1UUEedzmcbaG1yoffTEHhBQctTJKoGrsbkdlNIP1bkRc3SH/ig1IXIkkpzxNd0hcKOIEjakQdtvgoF8WFCx+onOkypGa/+mqT5wutIvy7q57w891Gc+M9HyVfHBKJZLlfCcijb0S26FxDwsSqPsHilaY5pMDUIxZxV3oUEc2W9Le2GeIcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb+JdAuIEYLdufNIc+OlwQAll1oe+gNCznKccovod2A=;
 b=N72vzYZV83wUlbdxlr1IixiW5ziI+1YvGRO7x5TuSJEYo+stXmcHm+IIkD60RkpAqf+ID1piSBx9C5FUrnaUq+PVr8npoDEPVlFp06fGmbg8jSCynZdns7X0WTZybE+z0VRKT8cIo/hAJQO/bhuB9JJgjT7ko9vrKegmtvLPois5lTzDBwoRDrGQANeQwnGGBGD81F1BA5/hBmGlm6B/0vN/fTQZ15fSTiI+P5E9ABWAGamdVIBv/o3+QhjdRTG5PENRuhgOYmhZlFat0WVMnsyLw4lsM/jT44Gfduj4LHAWBOmggE4pgxjRjKbtZoiZ+fe4GPUdwnrVj0dLuhLcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb+JdAuIEYLdufNIc+OlwQAll1oe+gNCznKccovod2A=;
 b=w8pfAz/JK4+6DC2TkSYi12wXjCYf7o/gsXA2R7JMv+FLwcGfIo6WS+8U9ogN+khzsa2JGpS5xXQAPTkI5DkKlJMVrFl7oHQfSHRYhcCCE605CzKF3amIFASoHORY1EkfujNNiAbIrsOoBz+uanIPuR11jjbeLyqrkvzPBjoag2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 16:16:08 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 16:16:08 +0000
Message-ID: <f2a87143-5879-4ec9-ab3b-b2a6df12566e@amd.com>
Date: Thu, 3 Oct 2024 23:15:59 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] iommu/amd: Modify clear_dte_entry() to avoid
 in-place update
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
 <20240916171805.324292-6-suravee.suthikulpanit@amd.com>
 <20240926195423.GR9417@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240926195423.GR9417@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c62d8e-c0e9-41d9-b0fd-08dce3c6b015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlVxYXN4WTBwTnAvRlg2dFowMStOVUxEVXlhVGlKekFKNnMrbUIrWGZkOEhq?=
 =?utf-8?B?THlXbWhBb3VaYlVCVWdvNVNuVDZJWXBYblF3TktGdFpmMnFOMnV3OHloTFNs?=
 =?utf-8?B?ektZYkhaSUdENzdjdjlhVHF6aTZFNGZCeE0zUjNZd2FuNTRoazFMTFdSYnBu?=
 =?utf-8?B?STNSY3BmM3pYaU5WK2hvQktwNHZiSThuZTRPMnZwSURHMzdhTkd6MzNvM0Fk?=
 =?utf-8?B?NllKb29vK1lscnczNVhnd3JGZWNiTllzWGtNZmU0RnMzb0tUaDhDQXk0ODYy?=
 =?utf-8?B?ay8vUzZMY0dUejUrdEpPbTIvUjJDeE1rL1JBMGxFS2k5ZXZCWTZ0MlFRalJp?=
 =?utf-8?B?eGU1eFpUdVBTb1pGbTNlNUpQOEI3MnJNQkJkV0ZVU29MdkRTQXNDVGkyR0dZ?=
 =?utf-8?B?bThaSzQrTHFCMHZhWVVpRGFLRzkxUHNINWVCbWxHQzJVN1RhdnhyU0Y5STNF?=
 =?utf-8?B?c2ZxK1BzVmRqSnh3Vm0yZ1VVWnZaMnJhR3dsZGpFd1Q3RmluK3RxTVFwdjVz?=
 =?utf-8?B?eTBqbFN4M2tNaDlXSC9PbzM1V2xsdmU0Si91MkVWaVpUTHpVVER3cDhUa0c2?=
 =?utf-8?B?dEIzUjIrblFaaGhyTFNvTC9iODhJRzJsYSs2NjhJT1NxT29xVjc1MExhWktz?=
 =?utf-8?B?RnpJclVSS2xCMGI4SERxVWE3c3dZVUxwdzRxRmNGOUlGSHMzci9IYW9xTURH?=
 =?utf-8?B?R0NzQUloSXJRRm1kdCtzZXJrS1gxSGRVbEM5ejJicXd5TERPL2JXL0ZyeDNx?=
 =?utf-8?B?SXpjSTFpSGFCRUpJS2pjRFVIYlVMQmh1ZWpkUjl1UDErQ2kzU3ZUZDllSzF1?=
 =?utf-8?B?NTJkS2t0WVEzNlpDeldRbkdpTENES2t4WlZRZUxFVHhmbVAvakJGWmdtZkhG?=
 =?utf-8?B?VzM0RzRvbXMrcmt0WmNscWpEL1pBTllIVjBpK2tzV3dDTTNxZWViUEE1Sklq?=
 =?utf-8?B?U3VPSndFM1d4SzdsZWdabEtFd2h3NkRSc2QyQjZ5cVdYMmVLZS9UTzZWcFZM?=
 =?utf-8?B?K3poeW1UbUtOb2VjR3kwMHFXYjBPNXNGMUtFSEMxT0lpV1BlSkNHbnJCRmFY?=
 =?utf-8?B?NzAwQXhmd01yMkRiVEJrT3NISEZiU3I4citRTElYTll6RnUvbTFjOWVmekVx?=
 =?utf-8?B?elBTaGJLTW9NVDZLUEMvNnNOWEhPZjJWajR4RFNzQkQ2elJDWnZBT254ejkv?=
 =?utf-8?B?T1pmeTdjcHJFd05YSWN1bDBEOHh5cldhdTg1U0dyQXYzOEQ3dWw2Y2F4cEVX?=
 =?utf-8?B?ZVREV3FKbXV3WFdiaHR6a0wwa0xUMTZhN3c4K0xxR1kvaHFWUjlENFNFRHFL?=
 =?utf-8?B?cHpUZUNrQXBWTllFaHl0VGZoa1B5MDRNd1VxN3pJWjM2b2h2RjVrVWxHQ3ll?=
 =?utf-8?B?LzdqaWRhYWZ1eWZJMWdxWlNtVXNFWUF0SkM2aGRLMC9jMnAxMzFxck0rT1p3?=
 =?utf-8?B?RmJQK3pzTGIzcHBhM2gwOXcxOGw1QkJ0TjBWM1FsaXdJVmhjZm95M3VYbGVt?=
 =?utf-8?B?WlNKL2FaRElIZzlCa0VMUGlndlVtQUxvL0YwTGFuZ3VhQ0tJZldtS3FXS0tv?=
 =?utf-8?B?MlZJWVkvMkJCY0F6U2JTRnNJVDRFYWpMTlpRczNsWjFnMG1SZVJGUzJHd21v?=
 =?utf-8?B?VXJZWHN2NTFmRGw2UkVHckxSUFdTNi9VS2VpeG43QzVBSDFNdWllbjZJOXdE?=
 =?utf-8?B?MU9udDdJcDZ1MHRkRVBMM21ITU4vMjRVZzJraTMzZ1RibmdLNmlscDlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTk2V3ZjMFpNVUJvbmplalMvUHB2T3lWWVlQSjNYUUZzVkdTa056NDFjRURp?=
 =?utf-8?B?akxFQ0Q5dE9jTnRaNzZ4aU4ya2dIaXhzVUVoaXBaLzNDUUJhekI2MWQyMnla?=
 =?utf-8?B?WFIxSkVTM3loK1h6cXNEWTBpMDhPS2hOd3ByRlVKeUVIUDBUZ21mSExxVVdC?=
 =?utf-8?B?ZjB0TVVGamNqbnI1QnF2V2lyc095THlNU0R3dHhwZ2dpOW43c0ZOYWxESjFz?=
 =?utf-8?B?TTRqK211U09pK2ZKWGM5bm5lSHJHSjJpdnAxWmJtK3kySXUvRENtbGtBK0Zj?=
 =?utf-8?B?QmxoYW1Vakdlakt2SHNNM2tERm5jSVlGb1hRanQ1UEFSYUg3d0psUVVIazFV?=
 =?utf-8?B?aCs2OStwTWJSUUo0OTZ4MHAzTTgzYy9ubXRpbU5xYzA4QzVBT2UyRk1EYk5z?=
 =?utf-8?B?bXlZcE5jMnJXT3ZVSWtOYURlVTNlT3JDSTlLY1M0TE5NQU5xOVB1elBPaSsw?=
 =?utf-8?B?THR0dVc4RVpQcHdvZnEyblRoQXcwdVNiaTl4cU40Yko3aUhBNUZhUHFSNjVh?=
 =?utf-8?B?RnA3M0tGNVpkNDc1bHk0SEJSU09JWFVFWWFQSzZ0TDdyMnpYMXZNcmdvUDBv?=
 =?utf-8?B?VlBNVWVIY3JKWTdSRkFjaWxtSENnVExjZnFud1ljVkplSUk4ckQwMjNwMENU?=
 =?utf-8?B?NUJLRlVBcGI2Wnc5VVMyMEc2ZldqR1l2MjZiOEJjOFVyazk2NXlIZ2czQldB?=
 =?utf-8?B?aFU1dHkzSGRtY0Z0WVIxTEVHMzBteVVOeGNad1RIZnEyaEJZOXJqbEhqWkZt?=
 =?utf-8?B?bXB0WGpsOWZmQXRzdDNHajZlMTcvckFzcTFZMWFEQUtGSElBdWt0NE50d3Rp?=
 =?utf-8?B?dTZydnlmcW90Y0VFVlBXSmtkTUJ4TGJUWlIxWXZySk9ac3VjeU15TE51NFpn?=
 =?utf-8?B?bHFkT2Y5VENTT0d4UnR6a0FpUmhOem1kSjZMNER5ZXd6K3h0bkZ3T3JJUVdN?=
 =?utf-8?B?TVVldWlIVVFZQW5SUmh5MXBweDl6cldyWTBWa2FYOVJrUzlxcW93QVV0Um1X?=
 =?utf-8?B?ZXhmemJ6cUp4amN0Z1dpN3FSMEJRSTZGMzBhYysvQjkzQnQxd1Z2NkVsM0xO?=
 =?utf-8?B?RFVvWENqWndBM0N6V24zSXVJUHArekNKa0srSmRtN2pMVkwrcm5OWVFjYkJs?=
 =?utf-8?B?TjFrNWhCNHdEeXF0d2EvazJkY2FXMUtsenNlRXdyZDhkSHVYb0hVeXlTamRD?=
 =?utf-8?B?c1N2NjRXbTZqVklrbjRUSE42SU16aS9xMlVJMWxSZGRkMi9NVGszOXc4T3NK?=
 =?utf-8?B?QzJmNlR1UmF1d09rdml0b042Q2lhaDBiaTBNT0xmMzV2OTNoMWErbmNOckJP?=
 =?utf-8?B?Q0UrbUpQbWd3TnFBcHEraVRIc00xOVR1amRWWENBU0M1VEVDWjcrYTdmS1g5?=
 =?utf-8?B?ZG5VZ2plNEg3OGpkYnE5bkdQQjN2anJtS1RCck54eTZqdFBoSFc2aUh6V1Fn?=
 =?utf-8?B?Wlh1ZXZwT2o0aFh3OGFzMVY4QkZhQWpyMnVBbUFuNGRZS1MydFN3RThTTEdz?=
 =?utf-8?B?Z3MzblVvbm5MMTR3Vm04S2lEQ3FOYkFTZ3pvYlk3RjJQZkZPQnR1RGVZaUt3?=
 =?utf-8?B?WURKRmtRc1NzY2V5OGtITDRpL1lQalcwV2Q0eFVoZ0lRR0N4Mk5rSnhtdE1N?=
 =?utf-8?B?dlNhUFJLWGNxcWFqSG9YSHBOd2VRMWZFdWNNQ1RYUGRyTUpMWjgrQ2xqNWdy?=
 =?utf-8?B?RHhFZERVUkFSL2FPWXhDNDFBVTEzZ3R5RmtnQ2F0VFVLUVZXNnFwMU44Q3E3?=
 =?utf-8?B?aFJMc1NNR0NBRnFyU1Z2WXNNckNReUJXNE9WWjFCSjE3WjYyaTFZQUFIWmE5?=
 =?utf-8?B?YnZCOW9LVVBIS3lvNHNFanYzK0NUd3YvblVrZGJzRHE2eHZ4bFh3NUlvL2J3?=
 =?utf-8?B?VzVUU0sxY1lVZVpXdmZUK3BwRUZ2TWxPZWZPZ01NRVJ4V0NjSHhHMW9wQWRz?=
 =?utf-8?B?MzdSZFQrVzVZbnFmRFI4UTlGdW9GUkZ5SkwzazUzSUp6am51Qno1eGxNV0p0?=
 =?utf-8?B?SkI5c2lxZFpQQThMUGxLdG1OYTB3b2RwdHFxTXVxM0M2Z1RXR01UcnZKcitn?=
 =?utf-8?B?dWtiU1FXcVA2Z1MxMFFCZVFDK3R4SW5HRjNrZzFTZVBuNnMxdGdqRERmQ2NX?=
 =?utf-8?Q?crzSobqpXB6mQzB+BAWSTWUYi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c62d8e-c0e9-41d9-b0fd-08dce3c6b015
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 16:16:08.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEnUSl4tYF2CKETOL7XNfSLZBwpYt0R2BJ3eqVSSTlFagjMa2Gl+znnHBTNTR9CM7FCd+fy0t95Hu2sMQ6Yoqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769

On 9/27/2024 2:54 AM, Jason Gunthorpe wrote:
> On Mon, Sep 16, 2024 at 05:18:04PM +0000, Suravee Suthikulpanit wrote:
>
> ....
>
> I suggest you change this slightly so the flow is more like
> 
> make_clear_dte(..., struct dev_table_entry *entry) {..}
> 
> Which would have most of the above. Then:
> 
> clear_dte_entry()
> {
>      struct dev_table_entry target;
> 
>      make_clear_dte(.., &target);
>      update_dte256(iommu, dev_data, &new);
> }
> 
> And then in the prior patches you can write like:
> 
> static void make_dte_gcr3_table(struct amd_iommu *iommu,
>                                struct iommu_dev_data *dev_data,
>                                struct dev_table_entry *target)
> {
>      make_clear_dte(.., &target);
>      ...
> }
> 
> And drop all the wild masking:
> 
> +       /* First mask out possible old values for GCR3 table */
> +       tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
> +       target->data[0] &= ~tmp;
> +       tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
> +       tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
> +       target->data[1] &= ~tmp;
> 
> Since make_clear_dte() already zero'd these fields.

Thanks for suggestion. I'll clean this up.

Suravee
