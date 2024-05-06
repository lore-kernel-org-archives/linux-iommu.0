Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722871411C8
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983926; cv=fail; b=NB25P8DIMAzbGVEO0W4d4YmcThCLYzKR3oRZOjoVx0mqSF/rC72zXvQ9f/JKlkUSkK6uF8YGCDqIvFJ6SwbtI/U5Oss5+D0bVMNQGSZdUdpL8+tu2K+IFcheCHemRLu7xLcVTfJGcWftqjkNC8+dSEC4qN7o/3lOgKZVqbA53mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983926; c=relaxed/simple;
	bh=r09r6FwsNBAeowMtHnzxybHNyhst5KdpdKaEOagBdC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FOM1EjTFepZT8lmhsvzBUaTIAVHyLJ6jQrdDXLOmPKfqzmps6SuaT4icO5+19E9QOlbtSG0VgxnJxQw3NJESKpPMiBvh1MOuTUebHUo/UUcAH0GqhNnjZVxNlZUHFJo6RVXCaLGKGW5RCA8zLU818sQc/GSYn3pTUWRvY1dQDlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qNcXudFS; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qNcXudFS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evw3vCxcOXQSKk0NhdALXATkszaOEax+A57cmw2FggvvebzqNG+A3DWk7TvfyaUS89Xz/qBG8JG4PaWsP/7cCETGE+JAlDemNMA60Fp2lkEZWdk0yCyNwN1z81Sn1JD9j/twDuW5zuKR3gYz6LNF0Reosk4gLbt2+jPizCD08SCHzRAe51gAxN++qLnCD8H9+LPqAnljGdeHK72zTnS2ZiHTYX6f8WOJ2BExidAlCTuznGwWQ8/s20QH03Z5jX7AEo9xIVU3vaDJH/53DDQNOVdda5LlHnN07KKftRAS4viPW1eUvQQTilo9unucmc/nc03+j3ltt7nJSkinSZFkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD2YrZTlv85+akLWZ4qf2f80/lHVYaSc0HynsIUMW6g=;
 b=QUogYlSMFdZxHRMpkyiaaS+idPFqaohXGFaPnNdL5cdeehNVpbiJEz7x2cqtV2U46BwkxXBYtO2m87Etb2u4x4MCtcwE0+C2TovGxYJsooNUZhGrRNmyjY45eJFNBHCi962uf/VtYGgt2WGAulCbSSJ9YtpCd9frnnMJPu8k65Fg3wH1at5h2jOe2HI7q0HTb7uLrZnkUJn6xLFtNUZIrAUfAJaqNVM0+mGyXl1Z1rxkQNnvtwuYXTCiPDLJ7N9lV8OXrZ0A0zagbgw9qVj9ndODtq4mzIw40aVUHpe1DE6QqrlQrcHzLpASgUknf+iETTdP8VEwevPMVtODPDFI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD2YrZTlv85+akLWZ4qf2f80/lHVYaSc0HynsIUMW6g=;
 b=qNcXudFS57ibAbmXS6SLwfCNpudf9n/wKeFcrNmOlEPzHoILe6oUyuXc624qOoK4g0Xj/hI17x0Ss7WHrRbkGyEWswMMcJGXxH4tTq62H+/6O9Thry3iz21A32l6vz24dPY1aY0BE/WpPHOl2PQkSExQlC/Gnp4zkMiULHu31AI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Mon, 6 May 2024 08:25:20 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:25:20 +0000
Message-ID: <775a0d96-e831-462d-b10c-66d2bb2df97a@amd.com>
Date: Mon, 6 May 2024 13:55:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/15] iommu/amd: Setup GCR3 table in advance if domain
 is SVA capable
To: Joerg Roedel <joro@8bytes.org>, Klara Modin <klarasmodin@gmail.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, wei.huang2@amd.com,
 jsnitsel@redhat.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
 <20240418103400.6229-8-vasant.hegde@amd.com>
 <333e6eb6-361c-4afb-8107-2573324bf689@gmail.com>
 <3488f733-c920-4e2a-86f7-05dc1779685e@amd.com>
 <2a0d574d-6a3b-4344-9571-840eee569ae1@gmail.com>
 <ZjiRs2rTmgJ_hXwu@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZjiRs2rTmgJ_hXwu@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::33) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: dcab3df7-e1bc-4ba0-5f6d-08dc6da6110d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enczelR3c1pEY05FM3RsNWhxSStHMjRXcDY0OUxlK3duclYzNGVVUGdjQ2Rw?=
 =?utf-8?B?dCsvYlJ0VlVOMkVGdEwySGNwS2xmSkp3ZDlBYjhhRnRnemdJcWZvMkZhUWFP?=
 =?utf-8?B?M1UrVUFSVU5lVllnNnYwTzlkVWhUQkViLzYyTUVLUDJpSUl3dmRsVERqNU9F?=
 =?utf-8?B?WWJENm1kUEtHdmtGZmd4WnJxQ2FFTFk5bXZvejVSeFByaHd4RGtyUkl1TFlB?=
 =?utf-8?B?cmtva1FZZ1drVkl6Z3AwQmVieFVOaXpJdmdRNDByUC9zZ3ZJUmlYR3dMd3BO?=
 =?utf-8?B?U3VkbFcwRndtbDlib283VFB6WTZQQytjb2kyYmNleE83cW92SExjaGZwQW5m?=
 =?utf-8?B?SHhuVi94UURMTHVRZFNRK2VYRlZTTnU1TVJ0d2pHRkYxZVRtSlowemN2UUlL?=
 =?utf-8?B?RkQ1b0FUd3kvRDJQZThCc1lhRGdnbzdybVJJZS9CR1JGUzFXYjRJZGtqcTZ2?=
 =?utf-8?B?Nm5qMzdYa0RlQjEwRWdCQ3I4VVIrVFo4QTJNSS9VWmV0NjFLVXVkc3pyTGNG?=
 =?utf-8?B?RzMrakJneElZVURUeHZPbC8ycmZHNXBsUFA1aGJIVS9hU3NCK1lMdUFQOE9Y?=
 =?utf-8?B?UzkzcmFFOXZRWWx3ZllZVm9QVTk4L3lneXROWmh3YjY2dnBxN1doZlF0RUVY?=
 =?utf-8?B?VnVDdnRSdGVhalVjMkJBSW1DZWEvK3hNT0dJWFY3MWVmeHgxUzM1YmdQU0kv?=
 =?utf-8?B?SHVpREY0K0xpZFpTNG0rdjhwdUZyUGgrT2lEcGROanQ5SkVVZnQ3RGp5Ukox?=
 =?utf-8?B?UFJFTUh4U0hMM3d5WmlGNkpBZ3hlRHJ1K0paY2RaV0NTL2FKOUx1YTE4SWYv?=
 =?utf-8?B?MGw4OTZuOGRCYmdrNTRkL2UzUm1UTzlKeDFVamthV3cweXNJYTVoQ1piUGxr?=
 =?utf-8?B?NEF5ZnBmRzRKeXhLN1YyZ1grNjdYTGp3ckNZUU5jSkJQRHFrYTEyam9yaHI3?=
 =?utf-8?B?UktZcVVycEswM3hNL0xKclRoZ1BTOWVrS1YzS3VqWGFhdThEZkxDZVlqZ2V3?=
 =?utf-8?B?UmdmaUJKUGwvYUppQWZ6clEwY0NDeDFSOW5OVnBnR0tUOFU5K3hhdFYvRlMr?=
 =?utf-8?B?VmF5eE5lbHNwVWptSk91U2k4ZFlFWnN1TEhEQmk2S3QwNjBvS2RTZUQ3anJH?=
 =?utf-8?B?YWp5WTcwa0hwR0RJaTRMRXVhL3IyVFJCVmZRYW1vZ0ZnMFBFK1MvN2xBRnBv?=
 =?utf-8?B?bko2ZGVSaU0wUlA4MWRJbG5GcW13TjU1MUVsNXEwVHA2eEpDNzRiejZZNldS?=
 =?utf-8?B?RjdoWjZDUlRrK0E1Y3VoOThmYTl3TmZ0TUpnMGRjd0tXR0ZxV3FneTVhdmxp?=
 =?utf-8?B?QmZmR0Z4L0dZZzNYRHltUThPbTNSd00zRll5M0R6cEVIVmF1YWRIMXNoYThP?=
 =?utf-8?B?SkVFVnFURWkyUWdQMmtrN2hhTFhwblFDZnAxVDBvMlVUcC9FTDRobWxtYk8x?=
 =?utf-8?B?N25CRHN5ZzBEaStOb0VwMWVGUFZZN3JKdE50cnEwYmhuTVVEa3NQZEJOTzQ2?=
 =?utf-8?B?SnhkK1o0M2JkZmZFc0JFbTBoank5eWtjKzhOVXZJekNocUZVUjRld3gvTVlM?=
 =?utf-8?B?bktlTGlyRFg3bUx2a2M4dlhCRVU1T0V4Y2N2VU5xZWtCWVFDRUlpZEwvUWoz?=
 =?utf-8?B?WDVkV3FoVFhWdzNVenpWckJNYXhndVRSMUdvWUdZditacmdZaTFMQmEvcGsr?=
 =?utf-8?B?UHVhZDVZWFpPZFBQVnhaYkxIN3hkOE5tQWVFK2ZrVFZkN1JlZ09GbGFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUVwK2w4a1h2N0lLbzNSQUtMTk5uQksxd3RDc1pjOG1VRmJFNWlCbVJjd1Vi?=
 =?utf-8?B?TkFiRGZ2QkVtV1Rma1RacHRWT3NTYm5makl1WnpxdmJhT25GZkd3cThYUkNP?=
 =?utf-8?B?ZWtsRXpYVFdYSGZ5dUVnaVdPZmJvQ3BPbEdHOEc5Qk1CVTJJTE16bXlVa0FC?=
 =?utf-8?B?SnM3YUlFMUo4R1QvQnZsa2NqeWlnVm1xdUU4V2RheUFsMGFMWkQ5M3NIcTIw?=
 =?utf-8?B?ZmZhckRtdnlHaS9Wb3hkRGxYUWVMbDQyak45Q1RLTUl2RFgvbjROT2FGU1Q2?=
 =?utf-8?B?d2pXRVBRam8wUjdBWmErZmo5MnR6a0R5WHBCVHkwT0JKY1JHTURMeFJSOTJa?=
 =?utf-8?B?ZFBBSXJIbkZ6Z1pnNkFXOWxEQk9xZHN3QldEUUdsejlHdTBhbnhCS1V5cDl0?=
 =?utf-8?B?YlVvLzRCVlBwL2NJVDlNRTJVbUNHUm53Q05FUC92dWRyYzRaL1hZRXlsQ1Fj?=
 =?utf-8?B?WWNaMDB6VFAvQlg3akdmR3lwZHFLV2FuYXZFNUxmaExMVmNhSWpsSmw1MTE2?=
 =?utf-8?B?WFdCZjQ5OUpZLzNGeWtRM1ZmZm5VMDlMRnAwbGFXSlNRQVBLOFoydVliRktm?=
 =?utf-8?B?cC9lQ0NlVWtMVU93dGR3bVR1RDU3WWZmWDFpdUQ3QzBtU2N1V3NCMmJxdWlZ?=
 =?utf-8?B?azdCbUZ1V0Z4Mzd2Vk5uVjBkNXFIbEpVcHVLUHVQblNKZFZFU3NkaWFLUUdY?=
 =?utf-8?B?TUpYOTU0RWRIMGl4VEtYMU9XYWZQOFdPSFBrcjErb3ZCQVBhckgwcjNtVmsr?=
 =?utf-8?B?UXpLdVdzRXFqMjJrNTdFK0x1MTBDTTAzUExkRzZEZEtxWlB0SWVuVjYrdllv?=
 =?utf-8?B?S29Pa3h5Z1FOUFVMSS9GZ2gyVElVVkZxamViQWV6Szc0MEhnNlQ0Q0grRytT?=
 =?utf-8?B?Z0FXcVZJRmtudEl5b1VxdEdSZ09UMndhVzIrVUtybnkvMGJxQThyT3dBZk1t?=
 =?utf-8?B?bXR2TVZhVGZLMi9zVU5lbW0wLzV1SkU0NHZDSlkzSVNlWjFWcjEwVU51cUlp?=
 =?utf-8?B?Z3N0by9NYzl3UGcvWEE1ZGVQcDRSZUpUVmZYSXZpUmdRK090bjhFUDZsWTA0?=
 =?utf-8?B?VHZxZnlXT0ZPOEVxWWcreGNPRXhCRjRuMkFIMnBqTXJ6aHJyQmVBZCtCMVVI?=
 =?utf-8?B?WVFPSFgxZVFtQUUzbHhXMmNiUXlyWmo3b1VwTUVKTXFwMFhQOGd6aE9xdy9s?=
 =?utf-8?B?WmhMY3Q2SDM1c0VoUkhiVVUxL2tKQ21kZXl3VHhsdGFrTkNHQlBjMnVHeTRC?=
 =?utf-8?B?RGZsb2ZtQUJNVUtNNTVkZlY2SmRNUEd5ZHVDL1pZNmdtRVhWeEZKbnluOEpC?=
 =?utf-8?B?dTR2Rkcxb0VORlFDOHZKUTJhMUhPUWRJb2JubmJrRElBcVpPYSswTkdYREhR?=
 =?utf-8?B?NDZWNkpISWhZSnlYUjk4QVN5N1ZJOCtaQm40ajRsUnpBT3RwVi9xc21DL3Y1?=
 =?utf-8?B?VWJPM3BzYVdGSFduNFlmeWQ1MFRFUXUyczdzQ2N5S2NaMkZIYklRUEhNWCtT?=
 =?utf-8?B?TjQzWWsvNVZ4b0pDVmlrVWNid0lVaHdoNkhsM2N2ZzhFaXQyUnZVRGxNUXBr?=
 =?utf-8?B?UGoxVXhaYmxuRnVGeTRmUlpzdmtybzlTTUtuRWNSSXYzMlhTejV0UFlCWnZP?=
 =?utf-8?B?NVJxVlA3aXdXMzRVakk2ZVRnMDZTZEdxNnJLdlBuaDBnc3RRRFZqQlBiNzZo?=
 =?utf-8?B?QjhSVVlZSnZjY0JmSXl2K0dId1ZDbERpVjlKNFVkY0dBUFN4SE9ZWGtZYUNw?=
 =?utf-8?B?R05aS2kyN2hOV3ZsZmFyUXpQbk1yb0E1bXlNeU1PTllUd3Joa2hRT0tnM3py?=
 =?utf-8?B?eW5hODlRb0VPTi8rdjd5b3VHUmQ3dDREUEtZUnZaQmdMYUxWalEwSDNlMFpZ?=
 =?utf-8?B?MSt6RHFKYTE1VkQyOFJ4MVY1UHN6WnA5RkdvcG1ONjNubFZmTXlyU1RjZDBD?=
 =?utf-8?B?Q0JqaWc1YVR3SFl2QTZQbXQ1S1B3YS9LL1JkNVhFS21Rd1F3Mi9RdCtLeDJB?=
 =?utf-8?B?VCtiTVhKa01YRWt3UGEzWjBBZDNqQlJGRzVEeGhPc2wvaVRvMWdyRjJndERh?=
 =?utf-8?B?ek1mTEkwMk56bURjQW1NY2lpMzYzUDkvMEp1QlZmWWx5elVsVGtkeVlqdVQr?=
 =?utf-8?Q?CybuK8Vn3hOxEhDhOiGPHyemx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcab3df7-e1bc-4ba0-5f6d-08dc6da6110d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:25:20.1960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBx/UQkp24tUFOYgREtngIAOSPMWhDZYiBl9sk3T1tmNzvoDYMWB8grCHmoTQl+jMNLrLdPzQulKvoVikQ48jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165

Hi,

On 5/6/2024 1:45 PM, Joerg Roedel wrote:
> On Mon, May 06, 2024 at 09:47:50AM +0200, Klara Modin wrote:
>> This fixes the issue for me.
>>
>> Thanks,
>> Tested-by: Klara Modin <klarasmodin@gmail.com>

Thank for confirming Klara.


> 
> Thanks Klara.
> 
> Vasant, can you please send this as a proper patch later today,
> including a Fixed tag? Thanks!

Done. I have posted proper patch.

-Vasant

