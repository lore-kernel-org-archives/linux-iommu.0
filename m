Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB01AB6E5
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972169; cv=fail; b=M8DUAa6uES0L8jLF3PYxT5WW1uMmq0slhazi0FK/jnnI4SwGfDYctNw+aZT/ivxrrj0W1k8clPYNVx3HNoTxCzOOw1b/1qJjLe+iKRvPRS51Meap+hY/+vfhdOhe0twde1C/lxUPtcjo4wq74IREtDdmXBchecD/WfKaaZanN50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972169; c=relaxed/simple;
	bh=TO+/00rhzxZNZzyC2jHDajoN7d/d9SThwJ4wA9BIB7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bYmJvyzUkga2WEiuFS054pshWwC1X/vzwPCbrq+f7lGGqrO1vE7qyTggDeI0qvx3L9+jbwJfaBNVAvwkd6fUCvJsGP30Hh6LGBOlnAmCXp5LGOZ6C3KXUIzrKs+DUrX1/PrYWm1eMQaQtkBsGDZrhlbtyaQk/FvOO9dG7ysqcL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dCM8iK+c; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dCM8iK+c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nC7Td2JNWW9ZCtaGXPjw+FsQ0a1O5QVK1duUSmGtrU3hx+iK6JS+6uZxnik8W4uYgTwRM2pt9oJuMK7lVXiQgOC7SHdoUBngorX77ukuaUQtZepJ+2LfXVhWK31fzC4Cm4i4Gbl25n1lVa8Gr7K0X98pFuePvnGhRaLtDORTpMjRbmE8JMOUkeRJm0MaE1oJ01UKDAwwRC2SG8g71pbU+mPWu8M5XtX06NCiTIRZVgb0lAgul/d6lHPoYs1vOrrlAjHKx5qWUQYe7OLZMY+tM36uUAUMftKu/Zd0P9a3WpWaZikNzKmdZOZIkG9dZ8jPYajCAKYbNAiV78AzSOVcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABsTH4HFz0P9rYwHMtRWHmseTDQt3qKBmyOSjeBe8Pc=;
 b=AYtO0PzAhds90cM+ibVGHZtW//sXVjgciXZmThBkCWwBRfFSvNtewH6OtoCNjIYi0eFcdSslMnZrZ30GgEKUs2UiiXc7E6dTcj7fkk709OS5FuM9DUQXW4njZDNfPY9DFNrzYjFot358SJGpgO0CiTQA8HJIYhupqXifOasan5sukvraza7rAjJb0fsXkL0N8FF9QrDAgR3xRUDSMdqjBMJA/lKlZWBJu4owgEV0tABgt1QhKb54AjvabHjoR/YnAIRQ4GZdslaj/ZIqLdOvaEDRyX4K94BhKoXQEUrP6YXxglR5UBg/+0A1r/qqcp+JZw2BJ355wlK51bsUl9zzqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABsTH4HFz0P9rYwHMtRWHmseTDQt3qKBmyOSjeBe8Pc=;
 b=dCM8iK+cr7g3U3K0f+waWCAM7gkc+NbTJoTa3/M7uwBHf7RnVK/Jix+4gzujThFOTMO3Vej9HPaUNZRYhL48ZKWB6bwaSqwFuQB54cgYiukobUXcOVowoZ04Hpx0jTgPfr4sTBjml/NVLYxs4q/jm6F/gvZQuOvLXizPoBXNuho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 16:16:02 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 16:16:02 +0000
Message-ID: <fc5b7217-49b5-4ca0-b4f7-0eab5000a2e4@amd.com>
Date: Thu, 3 Oct 2024 23:15:53 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] iommu/amd: Introduce helper function to update
 256-bit DTE
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
 <20240916171805.324292-3-suravee.suthikulpanit@amd.com>
 <20240926194607.GP9417@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240926194607.GP9417@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b89524-c7cd-4726-e188-08dce3c6accc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUFEcWgrV2JkV05yWHlQdDdlUTBmbWlZRi9ORTlDemg4WXpuWDFIWVMyd3ZJ?=
 =?utf-8?B?Tk1EaEs0SitPczdSd2hidHJxVmNEZ3dob1dwTDNBcFdpa0cxeVN4Qk93ZGYz?=
 =?utf-8?B?RUYwL0xEdWJVbmErdVZob1FKQTVIRllSWldXTFZ3Yi85bjlCbThybm5hWkNv?=
 =?utf-8?B?aFdmLy8yZ3dnMnJHMnVJTmc3SHUwNFdpNUZSa1hTTWtVQzBsMzVtOTJPMU5u?=
 =?utf-8?B?UlF6YjNNeU41Z1NocjdrM2NZRXNZYlM2dnJiQUdhSTV4RFUvekF0YXF5Nysx?=
 =?utf-8?B?RHF4STRUand6SytEd2NEY2F1SVhMN1ZKajkyUkQxM2x3bVpnc1NKaSs0NEdM?=
 =?utf-8?B?SW11dWt3bkZMdWFqOCtIelVmZmt0SVI2ZHhOb1VOSmZlNnhwY2JrSzdNYUQ3?=
 =?utf-8?B?UXRaT01vNVozT0dUUmdZUTVRZHNYaW5kcEkvYmNHdTVtMnRqUDZ6ekJvWU9G?=
 =?utf-8?B?WXA3N1VwM096WGdCM0p1ZmgrZXFwZUxqVDlUUkVyRUxTcmlnTUY4WXVWTnpi?=
 =?utf-8?B?OHg1R1c2WlZMbHhJS284Y3dMTHhUdC9YMUF0VkRjTEhONFByb2VOMkdsT1lr?=
 =?utf-8?B?V2dWYUNPTzFpcElpSWRWcHhtSkVkSFVtbElTWnJWei9xMVpRWnF4dzEzY2Vl?=
 =?utf-8?B?azZadjVxOE1ncEpMRnBUNE9NODcrM1pQemR6OWpZNGlzT0ZrUnNseU9EWDZR?=
 =?utf-8?B?S1hDWTFtWDduQi9WalV4cnk4RGNHazM4VGtFd2lybXZVUjRmUExVUXgydG45?=
 =?utf-8?B?U0NPRkgrNkpkeXBLeHI4RVBpNmtVb3p6SHhHR3BVaFN2VUI0bEgxSFpSYzRV?=
 =?utf-8?B?Y3NJWUtDRHNOWkIzeUhNcDhhYTVDM3VyZFVSTXdNRmRqMG55R2xxVGhIdDh2?=
 =?utf-8?B?azNLTHp3SSsxRWgrWmV6bzZNN3ZhVDdFb204V0MzWEZlV1BVNEZKMzJTSzJw?=
 =?utf-8?B?czlXa3hyamYzZUIzOGpRUTNTSkpLeFU4SjdmeStmUFBFSTJIaWJtU3AxUzZS?=
 =?utf-8?B?ck1JU01JcGd4TThEU0tBTHhvaU8vNmpua1FPaytXV2h3eldjS1cwdW5YblFT?=
 =?utf-8?B?dW83Z2I1bWtmdlhsdThOUXplUWcwWDNpdEN0NzdPSlM3L3BUSEZNVENMZGRn?=
 =?utf-8?B?cE5TaTNKK1pqWit3WVdSTCt0YzBHOW1mY21RamdQY2hEbnVSUWFLOW9aWllE?=
 =?utf-8?B?QW5OczMvRVdtdG5SUmdmdCtFUUNXbmFUd3YwdHQrTWFQaTdONlY4TnlqWDJM?=
 =?utf-8?B?TW1qUGQyRElFVGZzMmZ1YndpTzVGUUo0Y29IOU9DajhndDEyNnpVS2FGT3lG?=
 =?utf-8?B?R0tKbjJuMndHVjU3cEp4cy82V0xVUkRmRmlwZUkxN2w0aVc2WlRxRFpGeUZY?=
 =?utf-8?B?amd4bUxNcEs0Z2ZteEc3MWNKeTNjMGNLNGFlT0pTSFZ4YzdjSHE2S2l3L3hB?=
 =?utf-8?B?QmdtR0lyZzBuV2FaVFRoOUNwbWo2RlAweDF2UWd1eGRYWndFRndnMkVidU1T?=
 =?utf-8?B?Z3Rpa3Z3S0hoT28rVjNZanU0eEJnZG9FbjRsbkMxV2w2V2hJb1Rkb3ZUQklW?=
 =?utf-8?B?V2xMbGRkQzBtS1d2MDhuNmY0aWpqb09IejhESSt6Z3BNUGxSS3E1ZjNkUzV3?=
 =?utf-8?B?SU5YZTJTTStYaFM1N2hnR3E3M3VDWnBzVTgzTHpJNGZyekpUOFVzaFcrNlVL?=
 =?utf-8?B?Qno3ZUpuQUtzMnNNRmh4MjFKamhlSmZyNEc1Y1didHlDaTZrYkt4cjd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjMvcnI1TmZlUU9LcFBjTXNMN3VkNzkwcFFDVWlIWm9jbGUyVHZCZ2JTa3R5?=
 =?utf-8?B?Z1N5SlFtd3orT1NPUjdYN0VxY1l1K25ycTZVTHZmcnREOG9TNVdCc3haWFVD?=
 =?utf-8?B?bVZ4NTVZbExIVjlISDdHNVI5V0I5T296c2FucmdaNUl2Y0Z5eHdVS1h5ZlFK?=
 =?utf-8?B?d2I3R01TY21HWWN0by9kL1QvbGtTSFZBMWVFaGdkQjlQNjVSdXhtenA3R3R5?=
 =?utf-8?B?ODc5U3JXS3cxQjg5UDE0Q3VlM09vY1F6S1RRc2pKYkpZZ0dUTEoxSUFoN2tO?=
 =?utf-8?B?ak9VWFlWcEU3MWVhSDI0Q0RBUi9xcUM1WVdFaGdMRlhmUnJ2NHhVQmRsS3kw?=
 =?utf-8?B?VHZWMTQyNlJNOWVsVnZDRExhM1lpNE1RVEplbm92R0RSL3A3Rkg3UXZKTWlQ?=
 =?utf-8?B?SVFpL2x3U1h1NStQWGtFYThEUkl3UmU3R2toNzl5cCtsZ21RRHN2QTlnMzB4?=
 =?utf-8?B?aThiYkl1dnBMK2JmQUpUZGxPQ2N6WDgxOXFlUWZFWUM5eDZJcXpJR0VXWnlH?=
 =?utf-8?B?RVFsa0ovYXBpRm5FaUR0NjNJVjdLbFIrQk5lUXh5RjgvSldSa0x6c25KZExx?=
 =?utf-8?B?LzdBY1ljYlI5K1c3V3dteExGckFmL04zbXJ1RjkyOW1tekRPY25TblhLTUFz?=
 =?utf-8?B?ZXN4RkRRQnpwRVRmZ00wZk5BK2E2UFo1VU5FQ0l0Sk5uN0ZSbVVWd3EyZUpl?=
 =?utf-8?B?dnI3UzNrZkR4SThwbjM4L3hMQStCaDhBUXRvU0pwR2R2dS9TZE5RSDlDdW9G?=
 =?utf-8?B?WnF3SC9kR3huc3dNOTdRdUFqVHphd1A4MUdzbzFTM2dXY1ZaY1lZMjdsQmZw?=
 =?utf-8?B?M1hoTk9wcm4zVUM2L0NwdWJicXhSQ0d6V1FmSnI2UzFNRFB0N01ZM1pXSkNX?=
 =?utf-8?B?NnNLb3VnUWdKek9CdjhMckwyYVZtY2RITmhPZGxZSklrWlZLdXlmMFFPVkhh?=
 =?utf-8?B?Q045aWY2cGxES1lvUTRrWWhrNXZRTEV3UHJLY1hYS1JKc0tWbG84QTJmdmZR?=
 =?utf-8?B?UmJORXExaUNkTE5nd1dVYXZyZjVVZXRnZG9pazlrNUUrNysvWGRyTkp4eW5y?=
 =?utf-8?B?T3JNaCt6R2dBaGIxNklaQkluU0UyektkL0xBdWdUdTU0U2xURUpFaTZraGxx?=
 =?utf-8?B?UlEvc2pnejVUM3dlK1BjT2F0Y1NhSWxmY09nVWpDMjVKMERTQ0h4Q3BKbzU5?=
 =?utf-8?B?U1EzMEhQV1d6bUs3a2FNYk9XbUVDaDV6WnlJSGpXVm1WaTNmdEZMMFJURDl0?=
 =?utf-8?B?Y21ZQisrL3paYVlCQm95MzNCMU9KTVNOb2VzYm1YbEVyTGd0VW5BRzdhZXNQ?=
 =?utf-8?B?MlZvWnYwMU10NExpaVRGMGJXY1QxNjkxdUVmdUREUmRQSzlONW1wYUxTMTZ4?=
 =?utf-8?B?YjR5TWYyMmdrVkhlbkpINVoyd3VwSHVwZVU5OFlvTHMrODQzNWc5eitPYkhn?=
 =?utf-8?B?Z0NjM3c4dk5PN1pZc1l6dStqRnRYMXJYTkhFT0o2aXVCRkdINEJGOTZrZTNR?=
 =?utf-8?B?dm0xbWNiM294YXA5aXpmcCt2R3hESUJXUzBSdG81a1BmQStMQmZWQWJucDI4?=
 =?utf-8?B?aUcySXhHNklabDBGek0wUTZQdFYvZkhkOUUvQkxBMXRCUzdRWm5lMnp1K203?=
 =?utf-8?B?ODV3ZCt5UFM2Rm9ZRXVrdEQyYnN2NXFwR1oxbnhpWW9yTVlRZHlDaFRudGJm?=
 =?utf-8?B?VTh4dXN4eTlRL294OWRoZFVDU0FyZGZYcUxBbzVSMjNzMEtEMUJIV2kyaWdo?=
 =?utf-8?B?QTJUckxUbk9kdlNaMDAzY3VpcVBYSUNxOVhLelpNN0NuOXBVVGY4WlY5R25U?=
 =?utf-8?B?QjU1d1pTalVEZnZZYkxUT1NqR3RJZjVUalUwbzNIRkpLdVFya21iS29UVEFn?=
 =?utf-8?B?cEdTUUNwKzNoUEVkTWtLUzhqUlUydHNIeFZqRjlnWGp6dmZZalhmRmpDcUx3?=
 =?utf-8?B?THFqT05GWm1mb1JYcGVJK3lXUktEdFllMFcwWE1BTHNNaWN2d2tWUU9BQ0xn?=
 =?utf-8?B?Q2tkbWpTTHhYcVVvMmsyaVR6cEdDTThoRFB5cGd1WENja3NsNDdCQklnR3o5?=
 =?utf-8?B?aytvMVhLU3lxR053RFpEVEdwSjRaSjZWYWprSUR1RGNtR2l3NDlMdUJUajl2?=
 =?utf-8?Q?vr2eUV6I4GxG+NO7jIA0bN4QN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b89524-c7cd-4726-e188-08dce3c6accc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 16:16:02.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/SYQY6zc+wFIeTD4uTu07NxD0Dz0/qdgbJp4LTS0UHFU0SAYlRLCfUeBbuGxMTeQTwNgHUnQHpPpWq3v/+UkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769

On 9/27/2024 2:46 AM, Jason Gunthorpe wrote:
> On Mon, Sep 16, 2024 at 05:18:01PM +0000, Suravee Suthikulpanit wrote:
>
> ....
>
>> +	if (!(ptr->data[0] & DTE_FLAG_V)) {
>> +		/* Existing DTE is not valid. */
>> +		write_upper(ptr, new);
>> +		write_lower(ptr, new);
>> +		iommu_flush_sync_dte(iommu, dev_data->devid);
>> +	} else if (!(new->data[0] & DTE_FLAG_V)) {
>> +		/* Existing DTE is valid. New DTE is not valid.  */
>> +		write_lower(ptr, new);
>> +		write_upper(ptr, new);
>> +		iommu_flush_sync_dte(iommu, dev_data->devid);
>> +	} else {
>> +		/* Existing & new DTEs are valid. */
>> +		if (!FIELD_GET(DTE_FLAG_GV, ptr->data[0])) {
>> +			/* Existing DTE has no guest page table. */
>> +			write_upper(ptr, new);
>> +			write_lower(ptr, new);
>> +			iommu_flush_sync_dte(iommu, dev_data->devid);
>> +		} else if (!FIELD_GET(DTE_FLAG_GV, new->data[0])) {
>> +			/*
>> +			 * Existing DTE has guest page table,
>> +			 * new DTE has no guest page table,
>> +			 */
>> +			write_lower(ptr, new);
>> +			write_upper(ptr, new);
>> +			iommu_flush_sync_dte(iommu, dev_data->devid);
>> +		} else {
>> +			/*
>> +			 * Existing DTE has guest page table,
>> +			 * new DTE has guest page table.
>> +			 */
>> +			struct dev_table_entry clear = {};
>> +
>> +			/* First disable DTE */
>> +			write_lower(ptr, &clear);
>> +			iommu_flush_sync_dte(iommu, dev_data->devid);
>> +
>> +			/* Then update DTE */
>> +			write_upper(ptr, new);
>> +			write_lower(ptr, new);
>> +			iommu_flush_sync_dte(iommu, dev_data->devid);
>> +		}
> 
> There is one branch missing where GV is valid in both and the [1]
> doesn't change. Ie atomic replace of a GCR3 table.

Not sure if I follow this.

> And maybe this will need more branches later for the viommu stuff?

I will take care of this later once we introduce the change for vIOMMU 
stuff.

> But otherwise yes this captures what is needed just fine.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
>> @@ -1256,6 +1342,16 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
>> +int iommu_flush_sync_dte(struct amd_iommu *iommu, u16 devid)
>> +{
>> +	int ret;
>> +
>> +	ret = iommu_flush_dte(iommu, devid);
>> +	if (!ret)
>> +		iommu_completion_wait(iommu);
>> +	return ret;
>> +}
> 
> Maybe this doesn't need to return an error since we can't handle
> failure to flush DTE tables..

Okey.

Thanks,
Suravee
