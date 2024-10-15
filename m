Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F02178FA
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995453; cv=fail; b=SmberDWgfxPmwmiCf0laKbSV5d3oWy+hiVfq5844FAZxpmMg2IkXsNqX9/JShybTu5RaOCzj7CTRFI1fECamyYpiplq+VHEp51rsM5bkBF1K53ueNGwvicfV45s9Rne5jUfn/049avvUjO1I3GCmGJFLPUPmXiV1yxWXX5wZwGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995453; c=relaxed/simple;
	bh=i63LI9kuvY2FjuKd+NDrmZFCJNZDlN65yeD+u2/pc8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eBjrcb1hHPOYJvDoeasArrqesdoqncXfdQS8/v7G8490vUAt2YL+OpjzDYBRmAuBCzF9H5gBm9J0TYHOVtb+L7vboiZgvOVm+IiujYa9wsc/cmEI6PqcXAIbmtYdjcoy96hZjZV6QnwZY0O2Oea4a0RRg0BrWOeVWWAlXHVz5BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VN8XKUoY; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VN8XKUoY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRy+ZbJ22YDhnjaqLbuXlgkVev9/OxhUKX4opDfMXse+jnLrVEqSTe8g8FPF3UkFIXx1T10oLBYMv0Pu9Jp3STs6kr41WVHX9kbyRCoYvC2zRfQKKWKEERr0/+nmX4fxjmYmL5kry4sLOjZEC686iDYfQQ8s2gR93pUByOzgRCBGa+ftfNo/8cXuIaYv+L3pODb6RHjaHsTZTli3xoBsn5NOXPT4jKhTzIRlBB3H4jy0tjvLSTmgRMg2NKtbx3Nd2eickwFLrkM5GQu0z1qEe9CjMU/5OgS1HJuJonIoE8ev6lT/soYhc9UH5b9wT0IqpUVB/MjtDsW1/dbV62MH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmYHq753aDC98RpHZ0B1g7alPz2Ez5PXnz6YJqhQof0=;
 b=jhA+TmykU6IYA1fZ5o41JshlzbA6LSW8zlkiYFCpuvh/7sxY0mKrPHQNIjW+vXhpak/Vz4YGY2ZInsFiDxkDrN49b9NFq53YSWBp8usxyOxLbv1+re5spV1n8XX4Fbumv00BHergWrwNw1jd/Dvh+CjKEx4ZXK+ICv8H6Jsl9NYYGSBqMg41NC/u89actYJ2QEPRkwlqFEoIkznuaNTMr4Av4OFeZ2zklnp3PT3GWSMceWFg7RAAYUv7tWIgRWu2qExU95SIPglsejIeaSuooCMG0GfK/m1EzPJc9DcoXoV3ZrhB7vj0cHXCD1zLxhZ92zLlEx+U4I8z6mQC/tIAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmYHq753aDC98RpHZ0B1g7alPz2Ez5PXnz6YJqhQof0=;
 b=VN8XKUoYn78PpVKBGZVR2DsPV30xvjGpS2onWvOs6Bbgq5Z/mUAqr9d8Ofhv8AAEpyA4yujWdzmvI+sj7ygV4TzzAaz4U8yk0jg8UTD/tJQ6zL/qlW+su0AeWqzfelnMQDqSeZ0iAbgLx1TCdOWyDaephvcXDYMyby9H3dRBqeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Tue, 15 Oct
 2024 12:30:47 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 12:30:47 +0000
Message-ID: <24421a38-3d65-48bf-a40b-7a5b15f9b1fc@amd.com>
Date: Tue, 15 Oct 2024 18:00:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] iommu/amd: Reduce domain lock scope in attach
 device path
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-7-vasant.hegde@amd.com> <Zw4p7Gc099DtQ_f1@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Zw4p7Gc099DtQ_f1@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: dce0d15d-f448-4ec0-299d-08dced152a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU44a0Z6alFzUG14cm5NY1Rpc1VLYkc1NlhOSE05Y1JTSHdOUGJTYXc0d0VZ?=
 =?utf-8?B?ZVM0VFF4ek1NcDhvcHN2dnFwbXRHNTVKdnJVdFNMdEI4dHM1YitUNHVtMWVw?=
 =?utf-8?B?TlJkQ29aOVFML2txMEZ2UDd0OHVNUGRuRW51UnFrdWhtaUxuOVlXM2c0TENs?=
 =?utf-8?B?bHVUdlhybnhMSDhFS2lHeHpLUW10VkFybWFJMGRtS0owNmFVQTlIcEY0aStG?=
 =?utf-8?B?cTBCOVNENGMxK3QxZFBuWTVYYjVBQVViSEdaNDd6YnN0UUduemlJQmM5QmFk?=
 =?utf-8?B?L1JlWEh4MFlhWkhWNHFKcGw0SjVEb0I5QkY2bk94ZlJlUTlvQjNCbWNYYm13?=
 =?utf-8?B?L2xhdk5LRjNNVUZEdDZ5TThzWEpnY0dxWmFRRGNteXhDbUlsK3Q4WGR0Nk0z?=
 =?utf-8?B?Rm4wQlVFdVlUK3c5MWhJVWNMbzBwdUdjUitOWm4xKy9GSlN1akZ6V1ptTGxL?=
 =?utf-8?B?SG1NSDROZmNlZDBkSlRzMEpHaVdsVXU4UkduTVhXWTBLZVBLT2F3NjEwRzBO?=
 =?utf-8?B?RTBJS1YrcEVlNmRNdGk4RkJDZXVGZEhFK09Kc0kxWWpFMVo4UjZuTWhGdytM?=
 =?utf-8?B?UDlYWkNwaklJbTk1Qm00UUZGSC8yT0FvQkExK2J1WndMVXJBZTRtNHFXTkFJ?=
 =?utf-8?B?ZEh4MWJESnhTRlFGaTZxZVcvUnZHcjI5ajNEejZJbmd3OGYvaE5qRGhmZEts?=
 =?utf-8?B?KzFhVExyWVc0TFJIazcyY0JZR3VlZVhab2VuMzMvVUplNXE0clVQMWdRTCtZ?=
 =?utf-8?B?WEdQOWR6VS8zMFhKZitoaDFDTStFekZmaEpqUlVHQXdEaG1yOWZVa205Wk1S?=
 =?utf-8?B?ZWlrWCtjRmdVV3lHT1RyVCtJQkV2S0tHMnF1SzNFaU94Tjd3RkdoSE9pTGsz?=
 =?utf-8?B?Z2hxY2xGU083dWMyLzNqTlVKdHJTY3d2KytqWVVLNEpBVEgzdjUxcWtKVzY2?=
 =?utf-8?B?SEtTUFkzMnNsUUFLUmtQK25iMm05cC94OGxXVjMvd0dsVTR1Yk5YcGYrd29B?=
 =?utf-8?B?TVJubFlSaXVnazdnK1JtTzROZ2E5KzlqbjhSRTQ3RHNMY2FybnByTlB4Z1or?=
 =?utf-8?B?ejErYXNLYjNkd2U1eGN2bk1nTnRLb2NwTUQremw2akhVVGI5RFhGOXlPSVJh?=
 =?utf-8?B?WkxIWnVnUEFVYzBzUmc1WWU0N1hzZ0NOMndPYXZyamUvZXdpWmVhRElscEth?=
 =?utf-8?B?eDFjUjQvTVFPbmxiUHlMaE1uVWo3RkVhellONXJlZC9HS1phNVg4QnN2YnhY?=
 =?utf-8?B?NkhlNUlzZlNBcVBlUjJmUm5DUHpOdzVXZFFUYkNBY1MzWS8vOEJVNnNTOXM4?=
 =?utf-8?B?cGFYS0doaHZQaGRhWnJHYUxCU1NSZzRLQS9TaFFUdnlkWWRqWjdSdlVDVkJp?=
 =?utf-8?B?QkxSZE5tVFBFV29SWEZVUEpCdFZ0YW92RDR6THhrK1JBREd0QVVqODlZMXdG?=
 =?utf-8?B?TnlIaTRFNnd0NEtVZXVYaTl2c3JlTXNwZ2wyUTNzaHJVeEdya0lnUGdsbFJP?=
 =?utf-8?B?VDliNEZ6cTVQWWtaaHdlZWFuTkUvNXZLUjl2Y2ZjSEJZamVidGd3d1Aza08z?=
 =?utf-8?B?WENvV0NTUmhWSFhUeVc2VTBWVDNRblBsYzFKSFdJWG13czBXY25HWUZlNHpC?=
 =?utf-8?B?NTJxOHVvVFpva21POVpvVlUzbFVzZjZYUDZFemFGaGthNXJXMVFoWE9yNEdX?=
 =?utf-8?B?aWtyN1NKaXh6OENrVmNMZlVmSUZHTUZOMnZ6ZFJEVkcvQ3h1SllZSWJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWlMTnRtREZKajZCTC96d0VKSWJIdEl6cllIN2NQYmxhekVSOFJRSUVud1or?=
 =?utf-8?B?OERmL3g3N3B0aHN1SFphUjhNVEFGL2ttejlBdDJxbURDL3pSdTcyMDZBa2JN?=
 =?utf-8?B?Tm1CN1JPSFpFazJhSk80SEJNZUFsMlZnZVJTem5qNVNtV1pGT05FSnVEZk9x?=
 =?utf-8?B?OTZlOXBJVWs1SHk1c1A1RmQ3TXNmU3hZQ292VkY0cE9kM055N3hwTTA0Mk15?=
 =?utf-8?B?L21mQWJocGRuaFhPSTZqcXFYTmdaRHp0SnpTSi9JeTc0TzhWdEo5ZmM3cG41?=
 =?utf-8?B?L1JEM0FNUlFxalpEeGl6MWRGK3Y5cjJ1bWxIN3paMXdObnBHZndlTzFuNlhZ?=
 =?utf-8?B?MGRsd3VGaERUc1hiRzBpZFhrTlllV3F0dlRxVVBKNElVVFBGa1JqdUNYRXNW?=
 =?utf-8?B?QU13V2ZPNmtyanF3dEhTL1NGYlNuU25nMnhMei82SnZ6NGFadmh2Z0xnVnIx?=
 =?utf-8?B?QnFqRUlZWG92RzljODF6dWJyVjBaaXB0N1N6K252REs1NmZHKzVSRnkyU0d2?=
 =?utf-8?B?UU1oT2ZNNmJ1RXo3RlNXVSs5TW40WkdaUlRFTDBpdVlUKzA3NjB5Z0FlazBQ?=
 =?utf-8?B?NUxYbHQybWw4WU9FWTVraGpKN3lDZEtuNjRMUGNyNmc1OTVqL29vSDFlNThK?=
 =?utf-8?B?VzFNK3pTRTZlQy9meHh1SnNYTVJjRTJUeTlsNFNaN3VZSG96c0ErWVBBMmlQ?=
 =?utf-8?B?NTRFcW12MEVZZWJvWmtoUklVNWI0ZCtTanNSYTlYVW9ERG0wM1VEekFFVGVK?=
 =?utf-8?B?S3FJU3RwQnlFQ3g2cTM0cU4vVi8xckl6M2I4UlRsQUx2UDg4OGJHMityWXA5?=
 =?utf-8?B?VFNCYXNTT2V0ZmU2MjN3TVFkQnpuM2gvN3pua3pJT0Y3NVY3UGwzMGdrN0RD?=
 =?utf-8?B?Z1dUcWhuSTQ2dlJSRHNNU2ZjdEtvSHJESnEraHhOd2M3UDdhZXBXckYvQTJ2?=
 =?utf-8?B?T25oTEJpcU1EdGFVWjhKV0NSM3JaVThseFV4QkE2RUVFMjdsSEREenArT012?=
 =?utf-8?B?QmlIZ3ZWVFhmbGV2K05ScldFVDdqMDRQNnl3SllkNFhQUW1RUFZLdFhwTnBC?=
 =?utf-8?B?WEFnQWR3QWl1NFhubHJHY2hheHl4Y3lNb3lCRVlDQ01DdStUdllRQ2FvTHV0?=
 =?utf-8?B?bzRSb1JEclg4SUd0Si9nMjVSMFFUTk9hbDAwcGdlaVlTOFNHN2l1Uy9OWWFn?=
 =?utf-8?B?eU5hOTk5Wk1NS2JybVBHYkwvNlBNNVNTbEJGb2NoWTFLd2xjc0pjZi9LSlFK?=
 =?utf-8?B?c0xsQTltUmEvNFVvdU5kWVhQSW95UmhsdkRuRHRtNzYyVWdxWlFka2x2WDhD?=
 =?utf-8?B?OWdOSSs1MkNjejZ6MVJtNGZFZm1Jd0gvZEU5MFlwbGNqdU1PVVVRN1A1ZXFm?=
 =?utf-8?B?aUErTmpEOTJRNDdLU2w3eVNWUTcxU0crdmpEV3JjbzcwV1F4MjBTZE1URzNR?=
 =?utf-8?B?b2lRTGF6Wll2SElvditLWUd6UDJyYUR3MzRNMDlOZ2QxM0RJc0lxdEJUOHdD?=
 =?utf-8?B?RFNUNzFpaE1uc2FVbFNtWHhrd0hTdWNxdUpCYVFENmM0UU14dC9QSm1saU5m?=
 =?utf-8?B?Ym82dXhVa3kzT1FwZy9hMk5hZ2Qrc0c5NG9Lb1lZbnM2d09lZTNEVFVDSm5r?=
 =?utf-8?B?cjdXcEZJYXZnYjYzbE1LekZTaXcweFpzSkNwNWhtNXgzZ2dmRDNZVnlWOHQ3?=
 =?utf-8?B?eGhFZFI2R2FkYzdMMEdJOWNCK1o5bll3eFpwcEdOeVY0RERiNGJsL2oxZXhW?=
 =?utf-8?B?cFY2ZlNVRktFVm8rUDh0NlZRSjBwUXUvdUVIQXNDOWNPZ0NXbmRhZzI4b01s?=
 =?utf-8?B?M255a3VSTnhCZGRWQU1CMkdPYWpjUEV4UzZSNHJNSU92QjZaS3JvYVRQVXZS?=
 =?utf-8?B?S0s2aWtKc0pySkg2UG9jalFVWmtQdUhpVFpjMFR4aXhiMldUdUhMVmc1d04y?=
 =?utf-8?B?UzcyQmtNc3hpaUdQK293QWRqNlpHSlNXdG1BWXBkbjlkZGZEUW5zd2lZVUo0?=
 =?utf-8?B?L3JKQVlSVW9MeXhOMEhQSWJWQlRLZWVJWmU5b1BzTGVWVllHbXN1M1kwYmtZ?=
 =?utf-8?B?K2xvYVp4WWI5S0FUa0oxUG9RbW1SVHJXRSt0Kzd5TVJVZXA4TkZ4RmpwRytk?=
 =?utf-8?Q?ePJGhot40+GCry4OijPbaa+LF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce0d15d-f448-4ec0-299d-08dced152a86
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 12:30:47.1202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uOuNJH5bnlsT50+JjxUxtudoEbXm/8DD/9MKyK3Eo0aFWtZJB/+p5S8QRU2mJxayg2jyDbjfnZlNjD080EC1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641

Hi Joerg,


On 10/15/2024 2:08 PM, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Tue, Sep 10, 2024 at 06:58:08AM +0000, Vasant Hegde wrote:
>> @@ -2119,11 +2135,8 @@ static int attach_device(struct device *dev,
>>  			 struct protection_domain *domain)
>>  {
>>  	struct iommu_dev_data *dev_data;
>> -	unsigned long flags;
>>  	int ret = 0;
>>  
>> -	spin_lock_irqsave(&domain->lock, flags);
>> -
>>  	dev_data = dev_iommu_priv_get(dev);
>>  
>>  	spin_lock(&dev_data->lock);
> 
> This patch inverses the locking order of domain->lock and
> dev_data->lock, have you checked all places to make sure it is safe to
> do so? Has this change been tested with lockdep enabled?

Sorry. I missed to explain this part in commit message.

With all changes locking sequence will be :
  group->mutex -> dev_data->mutex -> domain->lock

In defer attach path (iommu_deferred_attach()), core call attach_device() w/o
group->mutex lock. So I retained dev_data lock.

I have manually audited this change and also tested with LOCKDEP. Its all fine.


> 
> If so, please document that aspect in the changelog and why it is safe.


Sure. Will update in next version.

-Vasant
