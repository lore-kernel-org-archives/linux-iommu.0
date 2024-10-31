Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC93191F95
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366120; cv=fail; b=aHu+rlOoJydLBTiuBR2Iof7EHncvl7SOJ6h8dXgS95vpUsTeVV/B9bM5idigbAqAqKwqN2n5HGoLwIuDDiMvTP/OXpM9YRnywrpKA5PBGQVgRNqjvKOmfTBUWGZTrJJpoa2l56J3TxV1loPDNp5J1aeFZBsIC9uoRdRzC4J0OIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366120; c=relaxed/simple;
	bh=Gsd7s5yLCC3gyDGKmUFO03aZcYMmi8v6cLYYe6WFdhM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MfCYj2Wm46pCH+W4P1qL5Ve19hC0EDprV18kohHl9dBmDGeK3mloEQPCxDL3RDHCIKmVO+JNlHycMkUUBdJBChgAMfFcorHb+YyabJummeKj+c6szbDXszEwgqd63fplyhMf3EMe1huI/N2rCKUf0DcZgZgo8Hck9M8EaC+Ilkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oWdj/43+; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oWdj/43+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWlZZhaQj5hWaEcF5+uQDn29qSPEr/av9/CjVLmPrBmFfKQTdkWw7E+CaCq3KinxcEktGLCtHXcGPayBw8P7ZDNpiDLEi+PH2Qq5+z/eGS7iUbiEc/IKrn7CAA6goZ5HyQN21WShCrF4PC82e+Q87vpyhlKA5FNTJuTKq8WywBXcjCDPDk21303JmVk107yQq3ftzL3rv8wYXTdzhZOYFMCj3/OK7aaKnbun/lz8YyXov+ji7FG1pxl67QU/y7f6e7Ci+bzFkSWYKFoA0M868MJEnDGneg/HjW3DrpFasDPNMnFpEb7ordVKuuUnSqYjKcqlHi23ZdWspvlm3e8q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXD6aKspWGiMFA7MWaAimBP8eiSwavbDY6KdRbNXkek=;
 b=aVvpC6hDsEmwqWPGn1Nd4Iq9LP5dYLWFjVJvj8m4kuuId5jnVLfWM1Z8ziTGQQ+aSpEkLCzyoBoggNKpZn2LZgHxshbZ0+ZjuOu6Ix+b2NlWf55spXWhqhUcQaWrOiJ5716Wwn7e/jnCMKmF6WbMjOyad6/pL2uGQ07AWOxtBhs8BydQLUqhzMgnxths/7Wf1U6hxJirAPk5H38JCgay7XBw3H5LJJ56z5YgcrJMhHhfOzFXKMav9SVSzb0khwgHHQEZ/N0c6qiLWBF/2I/RhObWpPJqmladjYudcl5ugmEKq1ImqOw4von7BiJ8jmDLUBsqzpVAPyHwn6It/1Ax2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXD6aKspWGiMFA7MWaAimBP8eiSwavbDY6KdRbNXkek=;
 b=oWdj/43+gnlfbIJ7KXbGe5t24V8QhsbTlrAmXTiGSc76Wla+SB0Hfa+tDzS0xzlI7DCDqpONipsn1TDMuNKz6Ox8LCl+LVLWv8uxSG1YnF7rhr/z5ukWZFJBgvjr0JkiX89UgXbV52OYnTlzW+ls9hruL49VHYxlAl9hTJngSPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Thu, 31 Oct
 2024 09:15:15 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 09:15:15 +0000
Message-ID: <e617c4ae-c5fb-444a-9649-ffc7d41f79ba@amd.com>
Date: Thu, 31 Oct 2024 16:15:02 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v6 0/9] iommu/amd: Use 128-bit cmpxchg operation to update
 DTE
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
 <20241016142237.GP3559746@nvidia.com>
Content-Language: en-US
In-Reply-To: <20241016142237.GP3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:820::34) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: e01d42a1-6839-420a-2188-08dcf98c87c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzBLR2VzaVpjcnhRMFBwOTdreW14UjVEb1o5MDdqaVM2bTN2S2c2ekhnQ1h0?=
 =?utf-8?B?bVk3Sk1kYUJWbzI1V1Q4VTJmaGxCOC9ja29UQzNZS3FQaDZuM01qeCsrVE9G?=
 =?utf-8?B?YkJkT0U2Mms2SXRIZmkwYnYzRWkyZnl3QWV1WWcwcEVBUzVOSVRBd1MwOEJ1?=
 =?utf-8?B?SlhDTVRGVnN5ZGZ0cElWbHo3VndlWDE1RWlNOWRUN0Z3Q1JueE4velVtN3hk?=
 =?utf-8?B?WktYVnlPVGxjWHBML3hpUjJvQ0d4RDFiYWt0anNoZnNNUUVCdlFpU3ZFU0JU?=
 =?utf-8?B?a2w2MXVZYnN6TDl4bm5KSitHbXM0U1ZLQnA4a3luUUIwQmlJczNIekpDZUNl?=
 =?utf-8?B?VllxN1dXKzFOSWlCRmJJUitXR0dvWi9aWmEweC95VU15Sko0UVRVdExKUzRC?=
 =?utf-8?B?VjNzRXNaWlUxVkQzREJMUnFYQksrcldHOEx0M2ozcUtmUWptQVkwZjdnOFY1?=
 =?utf-8?B?UU82d2dxRSswOUgxdnBkRDNNNDRmdnh3T0IranlwUmFkdHIxYTR2S1REZGVF?=
 =?utf-8?B?ekFyY2dPSVArbWNNNWV3NllvbTlyT2lnWHRkdzRtcHMxa1ZxelJrQzJGOWMy?=
 =?utf-8?B?TkJ1MEFJL3hrL0cvUlQzNlE4TzFvYUhaeFIvckFpZlBYaEpaUDlQR0dIbVU0?=
 =?utf-8?B?YXI3dDNjRDRkeEdwV2FRcXZHcVFDN3NaMkZQYU5aaE5xNUNiam1QNEJsdU1v?=
 =?utf-8?B?cWJBZ0lWQktPTlQ4WDMydTVQQktDcHRaTTc3SFZBVUJNZ1Z4TlJOa0hwOGIv?=
 =?utf-8?B?c1RPcDRNQmpMdkFLb1VpSDhYbFJyNXN1RHVJbVpqS0t1cDR3ZkpQN0k5UGRF?=
 =?utf-8?B?R2d2NStMVE1vR3NpaDJxbDlXUlNlN0E1bUFiaFYrVVVlNXdmb1JvUXFNMkp0?=
 =?utf-8?B?ZUlOYmhNNjd5YlhCUERCc0pQUDVLZFIxZ3lBanBvWXB4U0xRWlJvbitFSHlF?=
 =?utf-8?B?RUx5cGxvbnFBUE9RRG1nTWFGMEF2eUk0NmZrb3BDOW5DK0ZRZklLQzM5d1kr?=
 =?utf-8?B?aUFxQndMUEJtNGdRRlQrUWlmdUdmT3Q2R0FIUUY4QWc2N0J5cms4L09McENK?=
 =?utf-8?B?TDcwbGFvNW9zeVNMZ0V6WFkzOUExekVTTHJad215UXJlSTdnendPQUZuNnRo?=
 =?utf-8?B?OFhEQTN5SGJqbmU0ZUpPYlhJS3NLTWljWEZwMk4wdjRnMzd0SW5xMkVrWW00?=
 =?utf-8?B?ME00WTRNeHNGdDA4TkU4YmVydEZiSGM0L3J2VnNZazZQWlhSbllHKyszR2VP?=
 =?utf-8?B?ZHRTcU9sMkpDbG9uK3gxVndVSWRQWU44Tk1aMFB6d1FPakloV0pXbGtySUQy?=
 =?utf-8?B?Y0xNQnlkRjlBMStkd042M2hWOHlkOVdmQXFyb084anBzWVNYdkptcXlIOHcz?=
 =?utf-8?B?VFJiOGZsYlFrbFZpeEVhbCt4dzJITER4U1ZhRTZIcERpYUdiWElxa3VZUHJu?=
 =?utf-8?B?SElaRitJRytVUFhObUJQKzJKTzZidDNWeFRLQkppYkNkUUQ5NVRyci9ZZmRW?=
 =?utf-8?B?SnRYQWc4SGJLTW1pa0J2YW0yd0Z6WXI3SGQ1NGJITE9HMWxYelhKeVNHUFl1?=
 =?utf-8?B?M2JtK2YxNnd6YVhUdjlYQk1BYTF3T0NOSGwrL1luTGM3SU1EQWpOWG80UG9F?=
 =?utf-8?B?QkhIQVhMbEhRdWR6MzNjd2hYeEVtZHVRNE1kcVFrYUtMN1o1ZUV6ZVMxUHpR?=
 =?utf-8?B?bUNUZWhoNmh4K09LZjh6MjNpN0RBK2RQYlF5VW9HWEZrRmVlVlZGOTc0M1Zj?=
 =?utf-8?Q?m116/o8mK7V1QOGg9Irjw5iJhlrz/TxzTrwOJIn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtqK25WY0lCaElXLzl5VlJBYWRKVTRXQXFpY3FTWHkyWE9Ba1FNeEx2WjFC?=
 =?utf-8?B?S1RzRkNDTEZ6VCs1R1VZT21ueDNpcmR0Rzl1STBTUnRvbXljWFB1Szk2WWN0?=
 =?utf-8?B?ZUJCRWhiSFZWRnFoQTUwRlpZQWtheUpWRTJIWGdvTURqSXRBTlg3bnZCS2o0?=
 =?utf-8?B?d2xoOUsweEk1QmpKUG5jaGJ2MXlnYTU5RDlLTjlveno3a1lsN1AwTy9oWFY0?=
 =?utf-8?B?RnQ0eTZOVHNRSlFWcmhjcUNMdHlOQUNBRkVsTTNHVkZKL1puTWpWY2pRM2or?=
 =?utf-8?B?aisvd1JNVHQ2Yk50TWxKRWFNbkYrUzF0ZTNIYWhHWklTTzVNaHZCckdFa2Fv?=
 =?utf-8?B?VzFjSjNrbDRRWXFWZDVlUzQzSjFjNXkydi92SDl5YjhYT0hvSGN0VC90QzZz?=
 =?utf-8?B?empnL29FdVJnZE00bnlMYUVJdTNsVnN0Y29XcDFQenJMNThKcjBBMm9NZTk2?=
 =?utf-8?B?dDkrWEx0U29SbmppY3NtKzE4OCtLdU9aNmFYb1hoME1tQ2xnZkhuSGtBV05h?=
 =?utf-8?B?a2FpbFhnTStvR1Y3b3VOcUg2eVFlc0RVaFMxZGNYdStWTEtrYVRkUnZ5STEz?=
 =?utf-8?B?aFROenlRdFRPNHNMTWUvSGVPQUR5a3lOQ1VoaFlLYTFvdjR5d1NkTm9ESlJl?=
 =?utf-8?B?UVRhSGZiQThPNVJMYmFrMFQxUVBYeEpWNS9pUHc3RzF4SXRzQUtEcHZiYmN6?=
 =?utf-8?B?L1o1TTl0MzcreEFvSnVGQTI1ZU0yT0hvUUVyYmhnZWFUUFN5RVM2NHlWeEFK?=
 =?utf-8?B?MUdRZEZ3OHYxSmNOSzlxNzFEazNJNWREYzg3d1ZJdFZkQ3Azdm5LTk5JYVFG?=
 =?utf-8?B?bTNveXF2eWxTLzd0Q3Y5N0ZVSUJyMGRHbVdlRTdhRXdYYzAzTGlia3k0dmdw?=
 =?utf-8?B?UWZEVElzMHhWQ3JXN2x4eWN5eVo5RVg5U1M2K0RDSTZidjhydmNuSXlvSzVH?=
 =?utf-8?B?cDBJRGNERmRjOWo4bWhnM0hKQ0dQcFFIMFduaGxXOGQ1N0xOSkZBM2pBK0hK?=
 =?utf-8?B?SXRWb0xIbDlDWG9XNjkyS1RUYVZEa1ZKak5rNTJ4VzdEaEJsQ1U3aG52Qkds?=
 =?utf-8?B?cXFqSjNydnEwUDhwT1EyelE1TjNnMlBuWkhVTS9VNWZJRWpkZFVEMWxGbHVM?=
 =?utf-8?B?Mm42WURhMk5oT2dTMHBNL0tDWXJpN1V0aysram0vVmtma2V3cFF4ekcwYnkx?=
 =?utf-8?B?bHp3WnFLTjNiWURaUUJ5aWhoTlRWR0l4dUZUTlJBOTJpbUFnUU4va0drZUpG?=
 =?utf-8?B?V2FsTndXbjkwQy9yczZ1Q3VsRDFLSVYvdDRlZU1qdjcrUHVNdkRvdS93Lzkw?=
 =?utf-8?B?N2I2SElHRm5JNjRaeFF0TDNucVQwN0k2UFgyVmorRTd6UVZmb1kxK2FkOVVJ?=
 =?utf-8?B?bUcxNEl5cjAzcFBsL1pWVzNhOGE5OGFJRUhvQjRoM2JGcDlOc2RKQStFQ3NP?=
 =?utf-8?B?Sm5xaDNhT29GTG1wSGN6elRnSEUyNHFkSzhsekpOZ242d01NRnI2RjNGTVk1?=
 =?utf-8?B?UGpoVlBEeWQyc3l2L09oUVljZ1d3TE96RGl2bnpEZitCZmIvWS9oZnVNSys3?=
 =?utf-8?B?SVd5YU9vMkFJb01sbkdSaytKbXNRZ3FGMmhoNHY2cm45UTdXeWVNUXFDb3Na?=
 =?utf-8?B?NFNNMTZpbWFjUmNpcmRKZEtQSU5Za1d0TlB1bmN0MFVUMENWQUFMYk84NlZD?=
 =?utf-8?B?UFF6a2M5QWVTK1BJS1phR1ZGYzBOeWQ3UFN0WDdtMVF4eGVXUlZTeUdMazVF?=
 =?utf-8?B?cG5WTkxtcmVhQ28zL3I2MXFUakd6Q2tpWE5pQ0FMNU50M0hqdkpESnZSd1Rl?=
 =?utf-8?B?dHFvc3ZmU2FwcCtCeUhxcEN5c0V1QVh4YVRZQ1FqNTZOYU9EY1B5MGNGbEV5?=
 =?utf-8?B?UFYzdDFkQzhaejR0SU9vdTVaZkhvb0lBS1VldUxNMi83eUdIS3ppRnpCOWt5?=
 =?utf-8?B?QzFKWWhVcFRnTTVYWnR0RStNYm80aHk4RHNXb0FKd3FWeXZ1V1R4NWdVUkdS?=
 =?utf-8?B?UndZSUZIVCtzNEhzdHI2Z0FzdHpkNE9XTFFyc05meDN0dnZKTE96YmNKeVht?=
 =?utf-8?B?cE1ndStQYnhCVUdWNDMzblBkLytEN0hHd1Q1RnZsNjlCZlJNQ3gxbDM5WFhM?=
 =?utf-8?Q?y8diqLi7jGBZibKgK3vhK0sEa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01d42a1-6839-420a-2188-08dcf98c87c7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:15:15.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRXepcUaVLT8Qp/ZY99wOY7bP1EWX6q8c5gZ3Ggjnx1pjY4RzqKZZ3yoVjHa7gpyH2xNWx9fN9uNI0A6Tcx4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

On 10/16/2024 9:22 PM, Jason Gunthorpe wrote:
>
> ....
>
> I wanted to see how far this was to being split up neatly like ARM is,
> I came up with this, which seems pretty good to me. This would
> probably be the next step to get to, then you'd lift the individual
> set functions higher up the call chain into their respective attach
> functions.

I like this idea and will look into adopting this code when I submit the 
nested translation stuff (right after this series) since it will affect 
the set_dte_entry().

> .....
> 
> static void set_dte_entry(struct amd_iommu *iommu,
> 			  struct iommu_dev_data *dev_data)
> {
> 	u32 old_domid;
> 	struct dev_table_entry new = {};
> 	struct protection_domain *domain = dev_data->domain;
> 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
> 
> 	make_clear_dte(dev_data, dte, &new);
> 	if (gcr3_info && gcr3_info->gcr3_tbl)
> 		set_dte_gcr3_table(iommu, dev_data, &new);
> 	else if (domain->iop.mode == PAGE_MODE_NONE)
> 		set_dte_identity(iommu, dev_data, &new);
> 	else
> 		set_dte_paging(iommu, dev_data, &new);

This will need to be change once we add nested translation support 
because we need to call both set_dte_paging() and set_dte_gcr3().

Thanks,
Suravee
