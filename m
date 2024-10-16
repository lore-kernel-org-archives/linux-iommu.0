Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066051F80D7
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068983; cv=fail; b=PUyfIcbYM+0NMSvw6biAgeO2s0IzNi2QVpUnBgA7LPrN0irrndmlQMdlOPvTL4xV9Vbgx44fH0735wOZpaRV9jVuRXPgblQaC0OrQEacdLAsOg4H6AGz2B1EpmToCy8uifXSY/ViUUklP42lORN9EJmxarHKV5jtN0U0LbFwVj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068983; c=relaxed/simple;
	bh=Wo6CMvBPYPbKSSMvw6DupMv1UzizCvKBV/YdxCckUSQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQOeZ6eDGJcg5V4ytRuYAdjS5+nh4JOPz3HH+l84GETzzxBE1bEV8kZKknEbmQRvCMNSnpvuvtiSgJk8StcscpaXrF+JwxulCuzTT9sUndYAiFFXavo2Wn3P80/paCQ0PZe0qXyPZTe+/pH94Y1zd+3RPS/qZDEjOFVJGAA73ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DFvGF+pf; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DFvGF+pf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS272j3XGqqcsgTHaKH8Wv48LpgSU1FZJeyM+X3Rer2kVfXleTxUlDpHScfE+CTWAzrVw9MCdTJlNyF5J8xXNbNN842HDar5RUitylA8OSk8gY6M6MFW4WWEP3TaMeoBy0SZIBP1lHLzYA39DGTWH00tiFtqhqw0UcXP5dgyJmxz2okjNDZu6OgZnkJGe6cQhorHUcWmCDbhOdp4kkVNlAQjv6TtFWpWWnCbb5APhDRIiOkxuNFMxeklfTbYcVP4pybG6RLVLXhJPv4cT02s7XrjQwLCWiB3zkbA5pzRWmSEwVWE3+tyLb34rCqERNmvTuzeEKKGV4UmPQaMKbq6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLHWm9w1HntsRx/ocwVtsiG2ogDRCHRXAAwa9sZYNg8=;
 b=a7jj2/LBubDLJMbqVl13LUti4XWtAv0IRUS01/GkW0Nopc9u0HeHrA1nH/a4W4Hr7tnjLL8AIZ1KWOjjTZRSWizcePc7i1XTuo/XZfwaMnbCIPvQytbYe/d/ChuUwx3/R7Kl/9PNknZvNtr3NujFEzV2Is8NKdDeo2fJ8oNS1H0TCIqlS2cA1q3DKD1EGJOmzStF+zdfrYPmJ+vYaLn2jJUL/au9Z8lSNaPG0G+rMOS37atcNY9TFUfaWHP4rm7AZI+cWtUO3DW8RYufjd6LL/9moWyK6lRbHHujBMb7E3MBCitF9tmAS0W4PY3tjy+DEK/46BlzMf7v2fge/1g10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLHWm9w1HntsRx/ocwVtsiG2ogDRCHRXAAwa9sZYNg8=;
 b=DFvGF+pf9Ly5rU732gtYT7rIz0Q0KBO9g1RFjQTw5t3XtVsJxcrXNTx309KorZCS048TlaGJGBr8gfXFpvMZWze9DiLDJyuuQ3tjus3dYmfshdIOlnylDlX0uF+6/M2CEZBzrNC0I2trNtRdOK7eeIIadU4loZwrmR8ed8RuIKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Wed, 16 Oct 2024 08:56:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 08:56:19 +0000
Message-ID: <c98245b4-4c51-4791-8808-673ef7b9c2f5@amd.com>
Date: Wed, 16 Oct 2024 14:26:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Add support to change domain to blocked domain via
 sysfs
From: Vasant Hegde <vasant.hegde@amd.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20240722115553.6005-1-vasant.hegde@amd.com>
 <20240723130507.GK14050@ziepe.ca>
 <e7a6ce53-c473-44d0-9177-b7dafa5c6aa5@amd.com>
 <20240723164448.GM14050@ziepe.ca>
 <110c57d1-1a84-44e6-bf71-ab5cbae12120@amd.com>
 <20240723173228.GN14050@ziepe.ca>
 <dda7c011-d427-48b6-8a1e-7a011f23ed77@amd.com>
Content-Language: en-US
In-Reply-To: <dda7c011-d427-48b6-8a1e-7a011f23ed77@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0237.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: dae79f97-a380-41ab-2bc0-08dcedc06689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkphZ2gwTEoxdVVMeVBwUitrRFpKVm9HTHdMbDZJcUI3bHpyTktNbWtVRmM2?=
 =?utf-8?B?RVRkWXVpZzR1dnZzRUVsZ3NuWHpXZTc3aUJVMGFhaEJ2cGhia3dnR25aaDZP?=
 =?utf-8?B?c2g4eXlHWkY5TFFBZUhIYzAxSFBPMzhZT3FvMFZNaG5ORWVyb3dSOXVIMzRa?=
 =?utf-8?B?NkcxaHFucXM4QmdmbklLVFBucXBFcHdQREFPMEcvQlVYcjRPMzZQdUtGVm9t?=
 =?utf-8?B?cEx2bFM1bGFlYTVrQVZ2c3N6V3pnMXNubk9SaExGTUJ0dmZKeXZOdm5OK2lT?=
 =?utf-8?B?cEZ1cUpKUEtHWnp4QzR6TndZTFNnYld3cUFVTGpVa3hHbDllNDRNdjd4L0xv?=
 =?utf-8?B?b0I2QTlmNnE0RXEyN29WSjZicDZGV1M4MmFNc2tMb0xHS2dtTWFUY1FqUW9R?=
 =?utf-8?B?cXptU0txcHNGaUdkSHBrM1RGU2lWbXVWNzMyc2puZ0hneGtiUlprNThKa1J2?=
 =?utf-8?B?YTVBZXNUZ25tODI5dWdBcVpLWUt5Vy8ycjliQ2oxTXlTWXkyeEszU1JvNXl2?=
 =?utf-8?B?S21ITytiVW9oSldUdHU5RE9EeDRReFF3ZHgrTGRybFJjNUlPUkU0ZzVkUFQ5?=
 =?utf-8?B?NXJnbWlzaEcwc0hBbE9UK2tDNWxyQkZ1QWJvOXREZm05bkFyNWhHKzRtNUFH?=
 =?utf-8?B?Q2gvUE9Nbk9EYXBYeTNLV1ZSQi9WK1RtcXdnQThSekUvR052V2hjdmxXRU90?=
 =?utf-8?B?aWxubUp3QkhjNUlIN2piRCtCUktxdkNaSkZIbHhuaXQvRlozT3VPS2NmR2Nq?=
 =?utf-8?B?REc3V0VyOEdBR0JBYkE4QU51T0JURmgxQllyR3IzNUs5M2xrUWxrZkViYUdn?=
 =?utf-8?B?akJrNFFWQnAxQ1hqQ1JLNWlHaS9Dc1ZhM05VeVQ4YlBndlc3QkNIb08xNXJ2?=
 =?utf-8?B?UnUyOUY5VEx4L1hzaWIwbFBUZEdxL3ZjNEF4NHlpeWVWR3RQYnE1UWF4SmNG?=
 =?utf-8?B?U2lybElsV3BXN3o3OTRMOHFCN3Jkc2lsYXZqOHZuRWFqeVBQWW5TcWJnTFZ1?=
 =?utf-8?B?cDhuMEFxTlRCVEIxZ08wUnc5MklETHBRL3BZNFlydVdPV1FoZ0dDSS9YUWdU?=
 =?utf-8?B?OUdtZEpKNEdsdnBJSGlOODBXNlBKeXczSDM1UEtzNFgvWi8xOWhpYWJlUlFm?=
 =?utf-8?B?TWx4SFg3M3huK3FoWFA4VWlyLzg1S3lZN1ltaUVocEJjaGRJSlhac1g2RGdW?=
 =?utf-8?B?aG5ubjlYUkFYWExRS1dlZ0c5VTVmcW9YYVlzbk05WWF4dUFGRndFaG1qak9V?=
 =?utf-8?B?Z3pSTGhwUTVKaGRMbVU0TFozWjIvOGk3aE54ZXJrellaSjVTUVhYTDdyYnpG?=
 =?utf-8?B?a1lmU3lISEljOGh6dFhBOENMM1p0YVNzREplRHhYNXRpT3pVTGZma24vWXlG?=
 =?utf-8?B?QnQwRTFQVTFOa3VDUzgrbVVMMWE4RXhDaWowWCtoWVVGWldNS0dWUTVRM2xs?=
 =?utf-8?B?V0ltLzc3VTIrdHp2RW9OWVg0YVM4eVVsOW1TZm9qazN3bW00SW8zVnNYMEZT?=
 =?utf-8?B?M0VHRzM3RCs5ZHJVSm96cmZjanpWVXZuTnJKQ2E0V2x0eUlKamVvYWg3VjVT?=
 =?utf-8?B?dDNpcThSb3NyWGlENEV3QkF2ampXcHNMU0FaeU95UW1jTmlKWEdNU1h0b2RK?=
 =?utf-8?B?TUJuSGlrS3dXK0pqelNiR0NBVFFpU0RQdzZJd2FldnZUeUVoZ0l1UmNyL0x5?=
 =?utf-8?B?V3JuaTdibUcvTTI0c2wwOVhBdjhaU3RmMTNqOHZ6T0xVS2w0ZmFMajhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V212cXQyNC9wUGZDZm5Odk9lZExpUzE4RkpDVHN2TWxWSjVabFpKUFJ1RzNV?=
 =?utf-8?B?cXhNWldidzZlZmdUV2xDQ0dtWU9kR3U2bTR0RmxGeFVWOEVpZEFyaW9ETFI1?=
 =?utf-8?B?b1FtSm5naUYwWUJGUDc3bTR1T01zdy82V0U5MnJqZ2lUNjcwb3FVK3liN0hI?=
 =?utf-8?B?VExmNUN5TERGQ2RDS0hydUs1dW1BcUhta096c2NUcDZiZmdtdnQvdGhRZXEx?=
 =?utf-8?B?b090dGNsVzVIci8zMGJnL2Q2akdYZnoyOEM1VnlZcEpweXYxdDBKK1AzcXR5?=
 =?utf-8?B?dmdFUlljblJObW1mV2hSdVM1QklwYTMzZVZOUzRZamhWYXpJU1dUczRZUUdm?=
 =?utf-8?B?UzZGcTVIR3lnK3R5QVRyYlYrMTRYL1dtS2lnalhwWkZLZ2pXTVY1YXFoVVFB?=
 =?utf-8?B?SVpIUWZXUlRBbnRNeEpwRTZEUllkV05NeVBmSFRqVGgrckQzOGQ1T0FrZzdv?=
 =?utf-8?B?QkVXZmlNMGtKOGFRTHR0TDRicS9Fb2ZZcUZHMzRraTNBbVQxOTVpNDRLZHEv?=
 =?utf-8?B?YXppMXhzTHV1a2xrQ0lmVXNZKzdraityRjk0YnJ2MVhOVEI0c0ZKanFwVG5y?=
 =?utf-8?B?M3hPcllSWVk2d3lab1VlL21uWjBTdHA2YkJORFVWOWhjazVmcUhmWXp6T1NH?=
 =?utf-8?B?S2pNU1QxZ0ZCOHZxN0RHTUY5akFPSGQrdDFSckYrekR6SnpjZlFZRnp1N1VS?=
 =?utf-8?B?VXpqd2d3Q0d5Y3o5UnlTOUl5dStlWFc0YkYxcnI0cWJqUWZ4S3B3VjE3cVNx?=
 =?utf-8?B?MnJYSTJpUTVKTnFTS1VtQVlEaTRXVkovZ3NsSHRFTGZRS1VYNXVPOEdkZ3J0?=
 =?utf-8?B?YkI0c2tBQk0vWGEwQ2duUGFrNFBHMXBQQTBXQTI0Vk8vYUJTT1FHZFFVOGVH?=
 =?utf-8?B?N0h4dXBRNTRYS2dkU29ReUEwRXRsZzZzTllhM0gzRmpXQjZ0bzFuWVJNTG15?=
 =?utf-8?B?TEFxU3VDeWF6WjFCeklic2Y3MTdjSStITmZWejZFak1MK2h2bVFEWXlPUDJE?=
 =?utf-8?B?d3E5ZnZUT0VKMmVmUytCeDJ5cCtmT2EzTGo2aDc2ZTh5VWhLZ3JCWTVFV2FB?=
 =?utf-8?B?ZlpkMTBLVTB3Z3U3STFwWGRXTmp4T0l5QVBDanErQmFtVTJIa3dKT0dkb29C?=
 =?utf-8?B?VE5Ga0VwVEsvMHlLU2VqS2ltc1hwR0k1Nzl6SGNwNlQyb1pGVU9lRFJCWDN1?=
 =?utf-8?B?UlNsdzRvS2tibStuc2dqMDFkYlc2Y0VNR2Z4NWhuUUlWQkpvVFh5WGdKNFZ2?=
 =?utf-8?B?blhJM2E2ZVdCWHVnRDBYWHdyaTl1OXFsVUhTdTYwcmVLYmVJUU9kdjIvNldZ?=
 =?utf-8?B?a0F5cm0rUVRqcnZkUGZPQXJkeW1IQ0RWYjZBMEloVXRDbHhXWUI2REJweE0z?=
 =?utf-8?B?SlI1RVRJU2szaEJuYVlZcEZTeEx3MWs5RjFMT2VlL1pNZm5GeXN6N2lyMWEv?=
 =?utf-8?B?bFdHZk80Z21ZdUxrQnViYitCd0ozY1lidFAwVVJLRm5DMUk2Y1c0dERFc1Fz?=
 =?utf-8?B?WWxvNE83ZlhsSlZxaEFGYnB0YkdqNkphdTRYWDUvakhDc3ZtNEVnZFNZcnZZ?=
 =?utf-8?B?RFlaN3R0MHdybGpOQUwyQU5ERjZHSTRUYTBxcXhCN1plRUpJNnlsNXd5Wndn?=
 =?utf-8?B?MXdsMHRFNVFRWkVxMVdFamhxVk9nZ1VZWmFDd0xmMHBtNmQ4R29XQnJrSHlk?=
 =?utf-8?B?c3J1cGl3TlBMOVR3RlRLQUxpSkhhUy9aRm94R2FtdTJGQkxDalJHRXZVQ21P?=
 =?utf-8?B?REEwVmozOHQ3a29pWjNENStQWmJlc2xzRW4yM0VjTW1QcmdQVnMzU3FyM25S?=
 =?utf-8?B?UG40SUpwYUlrQWt2d3R4V3pvQXM0RisvOTY3bytGanBSSlcwU0VtalJvL25D?=
 =?utf-8?B?cy9kSkZqa1JJMVNPb0pPTjdjZ2w4NkxOY1o4UnJ3YVFZK0N2SVNjNDdCc0Q3?=
 =?utf-8?B?NWd4OTBtUmY0YzZVNS9KajNRWUlsdlR0QnB6VmZpZmxlV3YrUUljUUhtamps?=
 =?utf-8?B?R09WU2w0SmN2WkF4RDhodEZTVms1UXNUclJ2T05NSmkxZTd4TWpMWkttejBq?=
 =?utf-8?B?RnZlbUM1Zy92dzlDUzBvbEVYQUFuckhOSnZlb1I5U1RxUEJ4UzBReFFycGV6?=
 =?utf-8?Q?nPICZZPaKlMab2+ZA6JHxrr/5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae79f97-a380-41ab-2bc0-08dcedc06689
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 08:56:19.3117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RA8neAYNAF0hufIyOV41VXdOZvZlQuWI5UoBGMVuZlzEjBKCsbKHhw7ocDYMEzLM9RsVMz6/WXWl5Pn5uZxxkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268

Hi Jason, Joerg,



On 7/24/2024 1:55 PM, Vasant Hegde wrote:
> Jason,
> 
> 
> On 7/23/2024 11:02 PM, Jason Gunthorpe wrote:
>> On Tue, Jul 23, 2024 at 10:16:51PM +0530, Vasant Hegde wrote:
>>> Jason,
>>>
>>> On 7/23/2024 10:14 PM, Jason Gunthorpe wrote:
>>>> On Tue, Jul 23, 2024 at 10:08:52PM +0530, Vasant Hegde wrote:
>>>>> Hi Jason,
>>>>>
>>>>>
>>>>> On 7/23/2024 6:35 PM, Jason Gunthorpe wrote:
>>>>>> On Mon, Jul 22, 2024 at 11:55:53AM +0000, Vasant Hegde wrote:
>>>>>>> Add support to change default domain to 'blocked' domain. This is useful
>>>>>>> for debugging.
>>>>>>
>>>>>> But how does it work? 
>>>>>
>>>>> 1. unload the module
>>>>> 2. echo "blocked" > /sys/kernel/iommu_group/<groupid>/type
>>>>>
>>>>>> If you set the default domain (aka the domain
>>>>>> used by the DMA API) to blocked, then surely no drivers should be
>>>>>> bindable too? 
>>>>>
>>>>> That's correct.
>>>>
>>>> What prevents binding after being blocked though?
>>>
>>> Device is in blocked domain. So any access from device will be blocked.
>>
>> My point is that is just going to make any driver that binds to it
>> malfunction. The DMA API does not comprehend a blocked translation to
>> fail all DMAs. It is great for testing because you call all the DMA
>> failures logged, but not useful otherwise.
> 
> That's right. Purpose is to test blocked domain.
> 
> I'd expect someone changing domain via sysfs knows what he is doing. Hence I
> thought its fine to add blocked domain support.

Can we get this merged?

Currently other than this patch we don't have any way to force devices to
attached to blocked domain. So testing BLOCKED domain and confirming we didn't
break anything becomes difficult.

I have been carrying this as out of tree patch. I apply this patch and run my
tests . But its nice if we can get this patch in upstream.


-Vasant
