Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB13B14A7
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743856; cv=fail; b=VA4V9tfUjKdpqnssDT75eM0eXkKF0tAthXmY43hLBP71+74npJCeH+J3ixvE9J28OHr2pfvTRzwII0FKOoy7eACddCtxct6SQ6AQ+txLQ2wFp5CGAIqxZmpjwd8GE6uaCd9yj7GV2N7j9XdTbYeMP8LO1ciJFc6q+CTy2DhP5Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743856; c=relaxed/simple;
	bh=NNaweVRv1KU93/qAsS8y6lFpWroSi+M2qS/Mpy6KdRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=avmhPWpjtB+g4eREisxasvjfIk07nEqoslV7dWFnBvGMFtkLCMsOy1Cts11gRZZrn9mVFw4wtENf6kC/9xebq7/4x2GNzmawqr9vr/YUZQ0F0ZdyzXg2vvz6HEqxZT0W7ZouZkyBvX8Qzgzdtr8tk4taa6Nkr+6xGh3PQy1c1Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kKJntqSr; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kKJntqSr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qclr7VxgZSfXFwZq1CbuydHWW2Y8EYlczjfKGj3dNMUhVhdhyLNX0AbqEoJm4GqNy9TA/hHVgPw2kY1TAlhTA5Hf582EtShZmFqGZ59gida/dxSgNO+3ZywmCQAw9TIhdNPBPFSavSFvkjck1KtMiC6Zc/KM8CilBmVrWUJn7t2G7P6cHmjgbaDuPTQQQTJyhjmvJYjy7uGsHqU60XpjLkXajbS8GW3NrXgsyi5h/E66xK/D11cFlfFNbDs+wapoMA1qqrcrPH0DXZr6DizPmZq0XXVNXZA0/cmC4B7BRgHydfthMJL8yDLSyMQ4SYVurn6Zif3+w4pxZiJSerppOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P45yz2cjTYX9jtRfD8xzuosOYRiXew7wnzrxpKhTIhs=;
 b=DsRqclydZm1BvuxNuli3ZNQb2MGlvJ5KbN1o1VUF1tycqEKDAwz1hnIuPER2b6EZre9cS4kZbi745rOsmS+Nc9+XF3qwwS9JEU9h32HDZ21yIhhG0jpyjsJyVnTFWhoFqAY3w96aLC+lQ6EQL6RVesMknFUFu9ftThYUweqkhMJo2xSBfjptEpiNd4QP1pPNscJoRPoC34TX6+jCCyP2O/GGfg5+qltxUF3pXA9RQYIf0PV4HVjQt3ptf2HO4b4OECAzOTyhToSYmBYZh+ZfQ6LG1/DzSLpFulgp5wAhdQ3mA3REGUHMgjZh/oiG4B0cPbama3RGKsbMMm/6RL75xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P45yz2cjTYX9jtRfD8xzuosOYRiXew7wnzrxpKhTIhs=;
 b=kKJntqSr+NBeTGmAb0sN2Z9wLXKE54I/WJXFk/Mqy49qQMezaTsbNVVLVQrVVbucGXD/W6iDg6yMHhqCU03dEn9H/zPXaWYalCTRJJitHQeP2Aw5U/cIl0MxN3Cn41iJI8wjqnQFbB4uzcUOoeQRFvtYJfRISdrWSXtGSSbRYUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 11:30:50 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 11:30:50 +0000
Message-ID: <978fb015-205b-405a-beb5-64c73e1f6d9e@amd.com>
Date: Wed, 26 Aug 2026 17:00:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled on
 Family 0x19
To: Usama Arif <usama.arif@linux.dev>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, bp@alien8.de,
 Joerg Roedel <joerg.roedel@amd.com>, samuelcrossley@gmail.com,
 "Srivastava, Dheeraj Kumar" <DheerajKumar.Srivastava@amd.com>
References: <20260817160642.418302-1-usama.arif@linux.dev>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260817160642.418302-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::10) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed233d5-e9bb-425c-d0b2-08df03657b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oSmHIbAHFMf0IbJx2fTJt8koXQ0ILkoqO7zBTqMCxZ79tE9YmpoPRIFf3KYQXLBUrGw4eOtQxidFXcZCKFtigWUE4mlv+W7fGp1/IdUXIFyRDi2YtbDqF5d+rNChiWvh1xuZyWAzxtCwCga0ZxMCT2MDoGYj4SQcXdJvuFSGX4I76cspqFpQ8De0QrxVYlH/FOe484SWH4wRxBS2JoYy48Eho/nMh0xKIC/Vc1VYSdwdYrXQVVZv+fTw84rbxGAP3IlWuhYUfGOyjNPKc9xy7zvfA68FSxfEIuBekHNCX8JbZo6edQjTu/gK4a7meQgS6kqiqK21+hYrs5uC+YjvMz+svK6abMjbxOfKzuYbDtUJzgHtfSi1WxQzSm7p9x2B2+DIFdyakm+EgqXHUCTmQLU8xc5SYnlanGo9lwh1Xq3nsZTrKaxCnrngE+XS2+sAUYCLyMlL0vRIfB3LmI0EpDrE8rXXjH2kwydtdofLuKUUt+d87dVBGzI9PFeIrm7ziHdktW21LgYhBKEpibxXr4fhDkY+wc02H94lSDgkTB8oOQ/heESZ03JugcjJ+wwMotn451y/nDUeegRjS42WPP1CJQx7XFFeUOqm2k9F6KGgNTChNIBrrWY9C8CgWd1C3y4mUgfObaMgaPECQjRmeGRRhH4gW4MguEyD7ssRbyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFVjbFBHTnU1VmlPc1d5Wi81c3BlY3JuOWN6Y0Jxb0h6Y2ovbkJXV0RzdHlr?=
 =?utf-8?B?MEF2YWdjbkZ3UFRyNUxFYXF3cGFDQk0wc0dNNlRPVzNUYVd6bkp3R0ZOWS9L?=
 =?utf-8?B?R25sc1ZLUWFLZ05xY0dtVjNNaURId3RxNjRHcTBPVWJJVDFyQ2RxSVorZEl3?=
 =?utf-8?B?bGtta2ViWE1oMDlvWWIyalFpN0VTYmZESjFOZFpQN1lFSjlCTFNxTmNpOGdw?=
 =?utf-8?B?MEpWOXM2VzF1OE5JL1JLSTgrMnNlWVNHS3pLYkNUbjVwUHN6SHJ5UllEZXVC?=
 =?utf-8?B?cGhrVGN2ZHNaQVhFenFBN2FaMjBIRTBvL2d2amhJdGpLZm1CK3I3ZkpzVS81?=
 =?utf-8?B?SGFGVlFpRjJXUjVWWEU0N014TWovdnpQMzdXUnFzV095L2pmdzduc0pKcklC?=
 =?utf-8?B?T25xNmRGSFQ2V1BQSXlsSlFGNnhDRmhjZFptVWZUei95czNjVmdTcjVwZi9O?=
 =?utf-8?B?bzhQYWZPbjhkb3FjN25Gak9ZL0o2emx1MVpqam1OUVJoSzFqam1wYm10NFJ5?=
 =?utf-8?B?OEM1a2N5akdLS0ZVaXNrcUs3MUdUMWFwdU4vYXMxZnVIdm5WOHdaSHVKTDkx?=
 =?utf-8?B?dkJjRFZxNG55TTFLNWlrOElvL0xBTmV3d3EzZ2s1WWRNWTFPMWRYeE1HYUM5?=
 =?utf-8?B?MkNrdkhVS2RqSDNTKzM0V2drSXBBT1FucDNQV01rbm1RNVI0aHh6bXM0VGk5?=
 =?utf-8?B?aVVGZm5PeWNxTWh4ZnJzRnBOU21wR2xYU2c5SW8razh0bHkveXl2QlZuSDBw?=
 =?utf-8?B?UmI1dEJuVEwwRm9sT3h5b0c5UjVIdi9uUEIyZ2RmNFc0cVV2bFJ1NEhNWGti?=
 =?utf-8?B?ZWpzTGdCdWtEVmQwQ0R1WVNhVWlEeTRtUEZ2Nmc4aCtOMy9KZnhNTFVQbkJN?=
 =?utf-8?B?Z2RQRVZDcWIrN1BDdUJPdC9oVkIzV1lqd1FFeExoT0EvSkVLVU5CUVNBUVJz?=
 =?utf-8?B?UWhVcTdsWHBORE96Q0J2UWZEeFJNb0V3NVpkVjJrTmFCQVpiTW15alhqWGFL?=
 =?utf-8?B?dXdtWUllQUo0SHQ4WjF6MzF6QWRzUjNSWWxydTI2TFVYNFl1WlNDQWF2eUpi?=
 =?utf-8?B?WEkrL2RyNFFKWXpPdCt3ZWJhSDNBbE5tTWNRT3owTytZS1U2SzdyNW9lUWtN?=
 =?utf-8?B?SUNDMEc0RjhDbU9rcmJsOXBPMnhPTjF5L3dvMk94WWptNEE0VUxxVW5laFhN?=
 =?utf-8?B?c2U3NWdIK2QwcVMwTXVMSW5KQTllL05iSmhQei90aUJQVlRqd2FzQ3B0SU0z?=
 =?utf-8?B?MlJLeHFvd0d2STh1NnNDTEgrNmp1MmI3Wkt5MEtTSnVlWjNaTEwwYVhyVGxr?=
 =?utf-8?B?am5IRkZ1M3pVTm42Z2MybUNWTzZoaEhzczRxd3JoWlJhQnZuVU1aYXBEWCs2?=
 =?utf-8?B?bmZJWFpHR0liL2VYUDlleHdJQWFON0haMHpDeUpXYUU4bW1kT3ZaRUpkd2Zi?=
 =?utf-8?B?dWpyRDZBMlZGeG1CR2tYMCtPMnI2VTVjWEttTUJwZXhSem0vaThxQWdYNmNR?=
 =?utf-8?B?R0RGN2o2WFVJdGs2NVJKOWMvWUUzc2llZ3YwS3VUOTAzVU9TYitRRWxkcXg2?=
 =?utf-8?B?UDJCNkNEYVUzODJuQmljRlp3WDFPRTdyTW9lb2JzZ3hIZjArRzlYNGlNd0xD?=
 =?utf-8?B?R0NlSnM1clhxaWNOLzIvZnc4eUFLLzN5c1o0OEcrdXZnSjVIdUVOQkwyaXQr?=
 =?utf-8?B?OUM5RTl1Rk5WWWpUZ0h2R1czVHBwdXJXMklXQnprTUhXQVpxeWRDVDJzOFQy?=
 =?utf-8?B?VGFSUCtyekxpRW0xakRVWVZEeGU2dkRsWHJPQjBKbkVQdFZReHRmMUk1OXZz?=
 =?utf-8?B?WkZiclJYd01FQStOYXdjd0NpUTFGd2xnK0IyOVByeG1PRkZUTjh3ZlpQdjFZ?=
 =?utf-8?B?SEhPU09Qdnl5SXpFdzdxWm5DbEVVbW5mSmkrVmZLY0ZDOGwwV0RIUU9tMFJm?=
 =?utf-8?B?anZkOS9iK3hUODdXa2ZobWpSM1NYU0NSYnU0VDQ4dHcxcklRcTJvcWdhNTcv?=
 =?utf-8?B?K3BUa3FjVldOZFlkWmw4TDBBcGdsUnJGc1RwK2U5SVpTV0JvL25xK0txMjg3?=
 =?utf-8?B?Qk9BZE02RWVabUtxL1pJL25qOTdZUEluUUlKcktwZW1XdzZzQlBEU1dianlS?=
 =?utf-8?B?ZG9odFh4dXRIQzhRNzQ1NkV2WlZBSG9UK0ROdDV5aTFZYmltN3lQd01BOUVH?=
 =?utf-8?B?dWpVUktvcWRFUExZZGp5QXFPWi83ZHNhTDZGQVAyMUljek9VODZ4Y3hoOXV5?=
 =?utf-8?B?VHV2Rk53Zkk0M1lPQVZoamdhU3NpemRyV212cjVyU3FJK3NTMUJ4ZnhMTGk1?=
 =?utf-8?B?bzhTSXJoTnBCQzJvUEhaSnF0U1dScVVick4valpNeUd6T1ZNS2EwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed233d5-e9bb-425c-d0b2-08df03657b33
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:30:50.6196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXcW4E/XHB9N409zfR1QXPte6YExJXEwQPorr+ZnejsNiBKs5L6XFHGUFs/fOHZEbkpf/2eGvRryNvNbCS3tuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225

Usama,


On 8/17/2026 9:36 PM, Usama Arif wrote:
> On Thu, 13 Aug 2026 19:28:55 +0530 Vasant Hegde <vasant.hegde@amd.com> wrote:
> 
>> Usama,
>>
>> On 8/13/2026 6:48 PM, Usama Arif wrote:
>>> [You don't often get email from usama.arif@linux.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Mon, 20 Apr 2026 08:42:02 +0000 Vasant Hegde <vasant.hegde@amd.com> wrote:
>>>
>>>> This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
>>>> Event log and PPR log buffer sizes to the maximum supported value (512K)
>>>> on affected CPU families when SNP is enabled.
>>>>
>>>> Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
>>>>   - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
>>>>   - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)
>>>>
>>>
>>> Hi,
>>>
>>> This series seems to break kexec in our production on Milan hosts with SEV enabled.
>>> This is on the 6.18.43 stable kernel backport.
>>
>> Do you have dmesg?

We downgrade the firmware version to match the version you reported and able to
reproduce this issue.  But this is the CVE fix and I'd recommend you to upgrade
the FW. With latest FW we don't see any issues.


-Vasant

