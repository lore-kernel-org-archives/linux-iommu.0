Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D74185941
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517256; cv=fail; b=WjNHSrmpmG4BSh00c71bOWwHrBtQ4kvWWzFJBOhD7KPfqNnY8JND6Ar52h88i1HVGnPgnioEkwVy54Kl7mVOCdAJ2TIRuo8oOXfTvev7u6a+F5muoMcZUgElSVlvb+c+B4LhphouSLirAUAFjuFXzYhnk+8PW5kQ5sIIbMxFRG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517256; c=relaxed/simple;
	bh=CJer7SAp7nv+9dG5Km/8FyHc8e6Gv0pdplhXLsqGOp8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWPucDFmkE5FsShLIUNsHXesRoZljqaruV30ACR4IKfEBU8AM7Cxn7owyPGklvnsVtQ0xLQYnfnmMvwDU9bmpT7spDqgtqolUvQoIj91gUSSMQi6f6HUc/5yOtPtnqLJq+8wI8uSADrffmK2lbAOt4k8m7EXV1J8GnxlU6Yukw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QfB937sA; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QfB937sA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDSZRwPRgdl5GbRruv9W2YU9FYDw3SARvhau8BlH8Pobt3BOrwFbIu9rcqOMx2bO27EGzobA+86Yyu+q0jnZ2VnyqxrY7N+Ucf/r11xqOY9r19SVKYCULeUEY+mgz+ktRfHBijaPx7Vp71lj/lGgCCkgLIPy+789OK2srUNE4U0+F1l+zsDwt81QsLsW68avoZnLjnJ5PtjKZyADk7GTWq/uV5wIMW3L3yX8/OTR13wW7DcTeh1ZS48kjSVdJhaFnnUaNPcZ5K1zVgEdPYEZvv0rqGhDkzEWKRHPc6eW3T+hncl3N+HgMlUHnRPPDOTiY064SRtzULlyoSlqWnjh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/29XfKg+aiXSBuqaqkUMlqy+y8/+u21QMeVxOeilaOE=;
 b=BthtbXAArEamHmerlYbALikGRhs+DPWGgo2yZTleoytCzHgpQaxYxfxPWjVzR29N2Jfr/DSu9SfRmgP98RXX9Bw7S6HwdpQA8XeCiU2DgtXql8Efi2pj2Bj2ghxJGUxVJ+VXEuG4LTHQ5ppstE2hK800O7OjlyKfyY03NQkaoFM9iopq+AtyVyP9b3dq5oKmagJQ/afhxWiqYTEwambaAULXhuXA8bb5bOLsPd+aqz7Vx8SsNDcikXcZbG+JmDB6M/vuE4pvv/0uHpz+hR8EyjheumZWDH/uhAx44jA7ihxsjrRkIjkydBxEK21Oata4kZrHCN/lCEOLFPbAQA/QOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/29XfKg+aiXSBuqaqkUMlqy+y8/+u21QMeVxOeilaOE=;
 b=QfB937sAJ1t5Vnkzz2juIMEBb7Txm7egVSQgSQ7LdS26UKBuIcFMH2O/7Ttp7OFmjeCqi79ycWmEa0j6neF+Bd5slRphn8Dy/WRmyjvvBtIq25Q2vG/0oDSDoS2dhNZG2GS317vjFFsB2QVXY8ZSAdmuQ5W9XVdXM4HYP89CNgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 06:20:51 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 06:20:51 +0000
Message-ID: <096dc644-c42b-4d59-9306-4007d04b779e@amd.com>
Date: Thu, 5 Sep 2024 13:20:42 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 2/5] iommu/amd: Introduce rw_semaphore for Device Table
 Entry (DTE)
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
 <20240829180726.5022-3-suravee.suthikulpanit@amd.com>
 <20240829193402.GK3773488@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240829193402.GK3773488@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: c41197bb-ecb3-4bc1-7cb2-08dccd72e388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cks1TC9yWXdQTGprMkp2RmhwbUp2bWlwb3BZMXNvbHlKanIycUt2UFg2dk9G?=
 =?utf-8?B?dHBRT0p2MWxLMWQxRGY2N2prU1NwS3A3R05hd3FISzArV2kvdnFZRWwvbGxD?=
 =?utf-8?B?NUR5UmtKb01mTUl4dW5pMXY5eTR6S3NNTDNZV2VXWjdsUkdwOE8wTm1zSnRT?=
 =?utf-8?B?Skt0QnVXajdTWkFWSjRhNFhMWTA0aXVhOTVsbFBGdmlhakRzMGMxTnl1eTdj?=
 =?utf-8?B?dWZOYi92RkJRUEZWalZCZDBRRDdYSEpJSTV5a2YxVnRyVHFCR1pmTktjWFFI?=
 =?utf-8?B?NzV6ZHVZZERnNmlReU5RM1pQK2g1TjQyWUxtNnIreWdaZk5RZlo2em9JcjZE?=
 =?utf-8?B?Z1gvQlZUS2RkQ3pvamxTTkliVEtaZmJHL1dwRUxQRnk3YVA5SUFDUDduRG13?=
 =?utf-8?B?MnhMV3p5c1FPcEJWd0l6ZytyNGFmNlY0YmdUWGRvNlFvbmd6S3pkYjl3dHJF?=
 =?utf-8?B?RjlSVk5JaTdpeFd2RGZydDVUZ3FoVkdBUFRVVG52aWRqWEJERTNTSktjWkQ3?=
 =?utf-8?B?WG4vYWdnSEszSkkvWGhadkUzdkNHSlFJSnlaOUY0Q2NPK2haZS9zd1JlWWdM?=
 =?utf-8?B?dFBHMDc0cVVrck1NOVVCVDJzeGNmdksvSk05YmxsV0lTS2t2OE1JaGhLL1Q2?=
 =?utf-8?B?ZkdBN1N2RnBTR0FwemtTcnA1MDBxSEFkcmczT04xWHR3bkozdGJRd3NVSGpr?=
 =?utf-8?B?OFpoQWY1OUdhbFgxbnYvei83MCtSZXVJUjMzNFpkd1d5S3I0YnZ2bFZLZi92?=
 =?utf-8?B?Q3BPa1RGS3dQb2RUL2hzVm5uLzYrSHJadndwMDZ6SnppeXVkbXJVdlhvYmM2?=
 =?utf-8?B?NVh4NVZld0poTkxSS2ZobWVNSEVGeXZWQ0dUSVFzR0dMT2poS0JWYTFGYnF4?=
 =?utf-8?B?b3lGeUR6VS8vS3hyMHdRVW5vWXdsQjBnNVBHUjh5bW40MTdUS3hWc2NCMXBw?=
 =?utf-8?B?cWp4bGJvN0xKK3p4Tms4eEdjRDVxNm1sTGtoVTVtbFRrcjN5bGM3QXFYNnJM?=
 =?utf-8?B?TzFHeEMvU0lxQko4YlpPcENmUVNUN3RnUWRZK1JxcUdzZGlsb0R5bHlmMis5?=
 =?utf-8?B?WlBYaVBYOVZMN3Q4eUVBQmJ4ZmFUc29hMUdUSFFUTG1vbStQLzFBdHd2azVa?=
 =?utf-8?B?d3BFVmZDQXRJTFVDMEpQZTg3bERIbGoyK1Zxc0NDMTBXbGE1Ykdtd0h1aGY3?=
 =?utf-8?B?OEtiU1NVc1czaCtxNzdUdGgvTFZwMXNrUjF6d01HRkF0cWhlQzNRclZTYitk?=
 =?utf-8?B?Z2d3aWdJY013YWZHd1hSMHNWOC81Wk9BOFJIb1FVSlZSb3hXSnR0VGpCditW?=
 =?utf-8?B?T2xVSzJ0Ly94U3ZHMGp3NUVuRGxOMVJaRFJYYXR3VGM5c1hrZThuTXp3Y0RW?=
 =?utf-8?B?Y2ZqTWxQai9yY3J5M2pFQXJsR0NwOUdpeUc1enRYL0ZNVy9NU0d3SDJQUS8y?=
 =?utf-8?B?OXd5cHg0T2V2NU1xRzR3VnFoZ3orUENGeDhWK0xIanhLbzJmaGc1VWpycGtw?=
 =?utf-8?B?dnEweGhSNkl5dnU5dU5oRUtZV0J1cUttZjRleEFhUEh2UlRFSW1NT2RzSTlU?=
 =?utf-8?B?S0xISGdBZmdNaGVhcnFMWDUzeXU1VjRnNjIxV0FDZUIxcXZPczFNcHZPUHlw?=
 =?utf-8?B?N0VZMC9JaWxNMG1Obnh0azZudXFXUUNzZHN6dUtIaEliUmp0MXJhVU1kbXU3?=
 =?utf-8?B?MUZSbDhyQWJXWjBsczg1cVNJaWZNMkRva0tuMk5rQ2lSVFJzZE40bzJOaHBu?=
 =?utf-8?B?OE1pNDlRbS92QVg5eWVxY3lQTXN2K0M4cmFaNXlMOFZHblppaEZOY2h0bU5H?=
 =?utf-8?B?MHJObFBBNVh1bU42VGhaUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlE1ekc5SzJJZnZCUTdEbDFzdlQ4K281clR1L1Q0Z0w0UDFNMjVIMk4vRGRO?=
 =?utf-8?B?V3V1MEVnekZmTlNQa1VzZWxjejFQYWovRGtvS3ZKdE9xMC8rVkgrSmJuV0tv?=
 =?utf-8?B?cFNINWNDU2VlVXIvTlNhL0Z3ZDkraVFpdG9HUkRHYTAyT1FaaWtoeSt4aVZN?=
 =?utf-8?B?WURpUVNWanNNbWlGWXB4V21pRmw2OFhyQ2l4Vm0yVjhNNVVWamFJZGgrTnBR?=
 =?utf-8?B?V2FBSDhyL05SZElFcDJpa1grREZ5SnFIaDlTQWRzK1pXeGdLNURlMUkxOStx?=
 =?utf-8?B?OVBjWFluS2lQVzVvZ2VNbTkxa0YxbDVzOXdOdVkxbGFFQm55S0RNM3lJUmtt?=
 =?utf-8?B?dDRjTzdZN290dzZqYjFFTXhPeEpGSThhSHNQU3VnU3dGZkF3aGlLS2VsS1hy?=
 =?utf-8?B?NlNyRkpreUhqcTBVdzRvVWMyTjFLWmFDTlc0YXlmU3VVOEhiR0RaeW5TanNL?=
 =?utf-8?B?a3piMTNnNXVJSWJydHJVMzRiYkw2Z1ZUY2dQZjJnZ0tteGgvVUh2UmU4SHRo?=
 =?utf-8?B?c09WbE1SRVFQMHM4T1VLalhjcVgvc295Q21PUkZ1ZkFVY2UveFhQMXJSemtn?=
 =?utf-8?B?QXVDcEZtMGR1ZXFHcGZyV2YxQTZsZTJ1VytGQnVsY1NSdFhoK3FFWTVUWDds?=
 =?utf-8?B?YXhlcHJTRG1QU0VnbWxhWGtsMC9YMFhpOTJIUXNKV3ROR2dJdTBOemF3VEM3?=
 =?utf-8?B?amRJZGc3SEJmUGlMM2ZzdVdubjdTK3ZsMHRFcUNmMnFRVGYrZE51N3ExUVZH?=
 =?utf-8?B?cUFBMGxNTWFHUkdPc2M1NjNGaTJXQ1FITkhVMmQwalBrQis4SG8zQit2NUtE?=
 =?utf-8?B?cW9qV25ZcUFPcnR2OVVNaisrTXZsVWNJeWtVM0ZZYTRiRllISGlxTnFCeTRK?=
 =?utf-8?B?a0ZZTFZRamJKUklkWjQ1aDdjRG0xVjRLcUhvOGxhVUxMbFNLTHVqUCtiSlFO?=
 =?utf-8?B?OG1uMG9ic0RrM3hPdjFrWkF5S3Q3M2VZcXhiZHZFa085eG9jcUhrTkl1SEpj?=
 =?utf-8?B?bFBTZ1BJbzNabTRpTzl2dkJiQVdFU0c3YmhaaEcvbkhlZCtrSmRWbGlnRFlF?=
 =?utf-8?B?aWpzSlFJanZkMzI4WEdYZjFIWHRlZU5SN3JPRGtDWjU3WXNOOTZjK1ZPWEdR?=
 =?utf-8?B?alF4WVMzUkQ0dVlPYlBHSVVVNkl5S1R3b2MrYjR5Q050K2hsOFVsQ3R0QzVZ?=
 =?utf-8?B?eUlXdXRWWmxHazRCemRLWGIwcXdjdVRWRElwWVNSREdDMHhvaWs5b084bFE1?=
 =?utf-8?B?bjJ3K0tXcmNUV1NqU2Nhd3M0SHZjVFBHL081OUI1RFVoajdSVXJFOHhIb0Vj?=
 =?utf-8?B?ajNMcXZtSkRBQk5iY3E4R0lZNTJWeGczcEROaTNhMDJ1cW1oOURwanNtdzNJ?=
 =?utf-8?B?Y3BjbGdKS1o0SmFHY2JTMmJXZnhXQjR2bkxrc2JuSUZDUVpOZ01PUjdvUW1w?=
 =?utf-8?B?YlVwZlRQN0cxZUNJcDRXRnd5Y05aU0EyZEpBQlZDSTd5emJWQi8zdmNQeFZY?=
 =?utf-8?B?aWtGcDNZNTF2TGNTYVExUGgxYUhQTXR1aENkdkxvQysvNW8zMnptaXgvZGJt?=
 =?utf-8?B?ZE1ESW11cVJYL3BKVTVpY2R4WjMrMXlESU1LTkEzcUMrYjJKZkJwNzJzZHBi?=
 =?utf-8?B?L2FlQUgwNm1oZ1BlbTdteHEyZmxtcUN4dkZQT3crVktmcDJuZWpwY1lDQUdC?=
 =?utf-8?B?T2prRmZyYTNIWk5iekRMSndESXAvc29CUDlRemFoNGRhWlczVmVZeTNrL3E1?=
 =?utf-8?B?Z0JpYld6VDZQUkltLy91cVpnTkU1dTNOcW1wdlluaDJYRGJQc0Y2ZjVjcU5N?=
 =?utf-8?B?MEtuUDlsMk5mdkZ2bWh0M0VHbURtNk00RGUrclI5cmhDM21sQzNtZ2dTMjVZ?=
 =?utf-8?B?MTIwRmZqTUtHTjVoVGc5cXJWa0t2WExldTM1VW9aK1FNK3p0dmZsZjRRcXBp?=
 =?utf-8?B?WFByTDRzSmtENUxRZ21qQ2JaQmIzQzA1WkRHVUprYnRiZEZHMDhKamt5WEU5?=
 =?utf-8?B?a3AvbWRvNUtldVdWN3hQYWVFcFpXZzZMTDl4MnR6bWluU3NKQWJZREw0TDZB?=
 =?utf-8?B?WDhtR0pzMUMvam1TdUlEOE96dFVtTDZnUFdEVTdZMnJhK3Q5bnhaMXRSY2Rs?=
 =?utf-8?Q?9CwMmhwx5JgF6KKSofCPwQa4w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41197bb-ecb3-4bc1-7cb2-08dccd72e388
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 06:20:51.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GTeSY2L0y87CmPPZoM6KGLjWro2+uzomslyjrQc6zlPLulollRkHJJC2pGiQUhmtEI+x9zRW/PhYsn3IMLMbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645

Hi,

On 8/30/2024 2:34 AM, Jason Gunthorpe wrote:
> On Thu, Aug 29, 2024 at 06:07:23PM +0000, Suravee Suthikulpanit wrote:
> 
>> -static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
>> +static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
>>   {
>> +	u16 devid = dev_data->devid;
>>   	struct dev_table_entry *dev_table = get_dev_table(iommu);
>>   
>> +	down_write(&dev_data->dte_sem);
>> +
>>   	/* remove entry from the device table seen by the hardware */
>>   	dev_table[devid].data[0]  = DTE_FLAG_V;
> 
> The rest of this function doesn't seem very good either:
> 
> 	/* remove entry from the device table seen by the hardware */
> 	dev_table[devid].data[0]  = DTE_FLAG_V;
> 
> 	if (!amd_iommu_snp_en)
> 		dev_table[devid].data[0] |= DTE_FLAG_TV;
> 
> 	dev_table[devid].data[1] &= DTE_FLAG_MASK;
> 
> This should also cmpxchg the whole 128 bit quantity, you don't want
> the HW to see a tear on HostPageTableRootPtr.
> 
> Which is back to my other point. Don't edit the DTE in place.

Thanks for pointing this out. I missed the detail in this function while 
going through the driver to update the code, which updates live DTE. 
I'll change this.

> There is no such thing as 'clear' in the iommu domain API. The DTE is
> either PAGING, BLOCKED or IDENTITY, and any write to it should be
> writing an entire DTE for that target.
> 
> I guess clear is actually trying to set the DTE to BLOCKING?

Yes, it's called from blocked_domain->attach_dev() and when doing 
amd_iommu_detach_device().

> Also no need to get the lock here because you don't touch 128 bit
> quanta [1] which holds the IRQ stuff that is racey. This is already
> locked by the iommu core group lock.

Actually, we Need to preserve DTE[96:106] because certain fields are 
programmed using value in IVRS table from early init phase. So, to avoid 
try_cmpxchg128 failure, I need to spin_lock on dte_lock across the 
get_dte256() and update_dte256()

Thanks,
Suravee
