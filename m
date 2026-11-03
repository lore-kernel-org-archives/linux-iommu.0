Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793716735;
	b=f7oH9jGyW/ya7dc7gD+zLjI0Jac2bLmz29uN/Cqc50JpArI7nKEy6XeAL89DVnjbAZST
	 pJ1XRu8aXzAIAr2pQQCEI1zC9dbYoauDMdB+JQOMQqQ4nLhZOvaImxT9wLU2amS/8EUce
	 iGmIgBjmSN9PGBMkQOWNKz0J+LdgsFdwD0ekU6BkgovTw80gXxLCSB8SfcqzXXY8kd3pS
	 O7t6+hVLQ86veWXMOfDus25LR1M1q+WPWz2EMWr8o4owlDcAjwO2nMmSZLIRtDiDJgSPG
	 jZlji00Jhx3MFrDL90iobb+Etxk9biLnD9KHaCWm2H15eo22oNsPO8CBVvFpKqyb8hA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716735;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wScaEU7zbedwCZF7Taw4KIJKXyUEy34MOR8r6OQgxjo=;
	b=pPzQ62l2dVzvOppbXxCLUeujUEy9YRe9jAca7Tm8/TYiMsIFAxb0bGYjb0oSfEo70TpV
	 EMC+8L2REBAg6vr04MMXCjEY1k0NMLYYWT/4RofejlLy3yODFi+/1oAMhUsaaWnf856ho
	 e9r0szkgKCoRU8G2U7iW3SvDYLV2HUgrXtNGMWBnPwBs6f6QQaKufvCM3gy3ClqTiEmC3
	 Xxb7DM1c4I7K7+oZFm/kl5XwKUfRrlxg1A4cMSTX+KdEGJLZxUBIjsr+nr3/47oc5P4Qs
	 MtNspCA5Lx5W7nOXTqExigDDk1PxxosGQ9Y6JsYBKe5bwEbUVJe88JX6apWoNaRBHoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jnWcfZrb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.43
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE73606A326
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 14:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE73606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jnWcfZrb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=um5O3lakQcYnfryMrIXC+n4t/moQvleNNSXJFZx6z/YwL0C6MBtr0YGvpERpaVP1TEU4rgRZoBywWIOk2H9pX6RmWdpMZKJMaUcgz8dBLSsh1Yj2F0fOU3Low1CxgBNC1RpP+ZNOMSJc/yOlZ/68u9DGREa4Gr9XhgWH7vtwFBeMPiclhgzOqFhWWSTdoJoYXleMt0Dg9PA+SO1nC9ug5mQzqe6Rp3W1GOpMPW+aAg/NXvzOs8cYlyIYeOurBjB51Mtsv51f/9yxm5qVQy88c9o2ttBXfer+zLkjKabQuxEiQ+/jyBXOzc5ssVtHAv5sFYf1OXbyS25ZoPbz46GK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wScaEU7zbedwCZF7Taw4KIJKXyUEy34MOR8r6OQgxjo=;
 b=axkfw+UODgYaVH5uo9pg5m9X0UOkxXnXPxKSzFdWPmUMl635GRaTQCOIpYPrZzQMlPmIyuNahmQeRPg+BJBWOzpvOfg1uNudnXZ82GLwnx2sZSYExqtnmcR8m39vyEsL/UR6Dfdw5jpUte2/KqVs6ibvcUHPzqgnf3Sw3FWy12w8PUqJsvnmxIgywSAcmbGqeVSZqgJIwT8bYhERqApA6VpT/w2LOIOBfHuKdHOyVcyOnXMkKr4cPe59cGxyspdRwRZf64bGxmZvsgobJC8dC9UnjhH8MGaFe3nzxjFWTLoho3XMIsVkgHONIxj/PHCHubJnidiuhW8BU/KdyVYkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wScaEU7zbedwCZF7Taw4KIJKXyUEy34MOR8r6OQgxjo=;
 b=jnWcfZrbkNMJcVungC16M0uJ9gX1R2TgvYb5xYSpv9qcQJnwkzGj0n03Fiahhy5r4wRTDHF1WAu0kdH+S2otonnFDE1iPXzoDwUYYAYJZK9FZkLW5zVtc0qyCURtU1v74C2bz+bgBm7pGEcvO7YdDjGrU1A1lVsCtLcOP5fw8aM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 14:38:50 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 14:38:50 +0000
Message-ID: <6a3cf464-6c1b-460a-9ee5-5468ded48e0a@amd.com>
Date: Tue, 3 Nov 2026 20:08:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD IOMMU NULL pointer dereference during boot with
 v7.4-rc1
To: Jean-Christophe Guillain <jean-christophe@guillain.net>,
 iommu@lists.linux.dev
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <97e7c46b2c3b8a0af2a458649349798c4ecc55ff.camel@guillain.net>
 <aa03a31a5d700da89d2d20ce92a16c9629d20702.camel@guillain.net>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aa03a31a5d700da89d2d20ce92a16c9629d20702.camel@guillain.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::16) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5af6d7-24d6-4249-aef2-08df39b82cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|4143699003|56012099006|261028144727099003|261026140227099003|261022105027099003|261026121527099003|261022075727099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9Y8e1fXUlwssKo37NRQiAEeAy+CEvYMthvzOEjHA93ZkoNshtNT/+kfqYZRU9Vo2kapRIk8T1A33Hy/41kazlmeM7Q4p2m8J8F8y32kREQw8ofHg0HSIDw8YilEzpskmzpepjwvSZRA2fOqa7m1Zw//66CEDn3qzgetW8BDDjwaFv/JfxohQFhu3l9VrUUVk5pOpB2IxDyRsZ+fUucRq7VsccTDy+b7k6MGXNiKjLwDns3EXgp4ZPjhQ5ts8vaf2vGBkxk0AhjeNTcIyFCD6bIktGKxNQRvNcqQ7AWHhlY5BOxp+1ZKcmHM4Q4YzDGSxivcONOClR9IjMAZPxhGXwSrBVbmsbML1d42LiloDr2lexafcIcVudVfsKNAsRr4MWOVmRr1h4Wq+gLiM/r64pCAOYdfkSunE8uPUGkxe5DxbimzsWjBz4issVfh+PSoP/xOrbmNe3fNQrJZWjQUDrTOf/yBCsJLp8zAu24zDLz5sRfpJysouPQ20OivyHCbeZXpP20spWrR22894+DRoFhtgVOJDAxTpUEEhDySOdD9sUs4/oGCCe/5N72dem10pIL0ccXrpKiwMKLVDxiyfPbl8qvSZc6J1OO+nAtF/G/O//LmsLqs1U1b7w0WmQJLTeHyqsNsDysUgDpaf+btPBU4mEinrDhgz7uYpYVlyrHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(4143699003)(56012099006)(261028144727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y010bWhRUGVvUGhDWDNwQjRuZjhIT2ZRVjBrMDd0c1FaeGw4U3Q2aVNBRUlS?=
 =?utf-8?B?cGNJU2J1NmxaN2pKYUE2OFhIdXk3K2VkcEJOZU1CTmhPZHVYczhvUys0WnNP?=
 =?utf-8?B?SzdFdmhXeDhwSTY2UVZNaXNEd1JkbnkxUEhpSG4wdTliV2JZQnJJdXdTK1dn?=
 =?utf-8?B?UDROaUVCWkkxalZXVDVLZk1Oc01VUGhUZy9mVXhQaFhRUXhZcFpKTHpVaE13?=
 =?utf-8?B?b3B1K3UyclRVdGV5Sjk0ZnlLVTJDUXRyOWdPckNMMmU0ako1RU5xVjBrdkhj?=
 =?utf-8?B?WUFXYUh0dXpaczlpcGJHY2MyY1Jyay81Z1BpRjNRVHl6bzJNQ2FsSWVHZEFv?=
 =?utf-8?B?eU1HS0MyL1BjUVRCenkxbEJMdWFXMFRPME51REowaVBKeTVZZUVEaUJaTXd6?=
 =?utf-8?B?RENTZ2hQMzZWbGw0SE50WlIwNEM1SFdkdytzdzZyN1ZZTzNqY1hYQmdsZ25X?=
 =?utf-8?B?RWFINWliQWdhMFNXM3d3QTV2RkRXa09VMWNwNnZXcjdMd2JWdHJzYzBDb29y?=
 =?utf-8?B?dnp6MDdsbkhBOXpxN0Q0Q2djcGcrVGNubnByaVZKMFdYY3JDZXhjL0o4Mncw?=
 =?utf-8?B?VmNsTC9qYllWN3F4a25jZXYzZGlKMmx3VzJyRUFGcjlodjl2RkxjWHAveTVx?=
 =?utf-8?B?R1E5aVFUa0Zac2Z1MC9HeGpKQ3JPbGxYL1JoOWEyKys4cjhOTjJYRW90OVZr?=
 =?utf-8?B?NXNJMjJsMUNYd1JxclB6aWQ3WWM0WEM2QzVDK2xnSTFZWHhzWW5kc3BscDlS?=
 =?utf-8?B?bUJueFEwWkUzYUltV24rWkpNQWlWVzFSd1JkOUVudWt0R1lESWJJZkY0TUZz?=
 =?utf-8?B?bHZUaVhGVU5YREFqU3V6ckgyUjhVOGV0T0o4d2N4eE5XV2hubjk5MW5YZ0pk?=
 =?utf-8?B?Uk1PQ3g1aWtOb1J4OUhQMGlRdnhBVkQzWFRCa1lZa0pPZVJxQXdMaEp4MUtl?=
 =?utf-8?B?RkQzMVVUcDJMS3psb2pxOVRaVEpRSE4vVXZRekFiMEdTcHhvRzNjOFJpYkhw?=
 =?utf-8?B?aVh0SzBlVWtLbVh6cm85VU5CeXNxWVhhU1FjalNHc2plNGZ4emE0NGJnOStB?=
 =?utf-8?B?TXZ4Y21KVU4zOGgrQ0RrRnNLZWNUR0pCSEd0VTNJZFdMUFZlV25LemNxbTBB?=
 =?utf-8?B?WURrU2plV3hkQmpGZVU3akJOUlVlam9RRzc0WGZDSyt6amFSSGtwR3VUKysz?=
 =?utf-8?B?OGN4NDlVcXEwRm1NVVlNZG1RbUZYRWUrdGdYWnZPV2h2VisrRXlNdHkzT2tn?=
 =?utf-8?B?TlVXUHBZekdnR2NDNlR4dG5rb2ZKcVlQZUlwNitERVJZRU9tUExJVVJVUnF5?=
 =?utf-8?B?N1A5Ky9LN0l5V3hYWUQ2NWZsbnNudFVIUGxJQ296eUo1N3BNa1Q2US8rbllj?=
 =?utf-8?B?TmpwczdNaUdTOFVjaUllNVpxdXhvZE5HSmlIdlphWWVFUkNaM3gyVnJQenph?=
 =?utf-8?B?OXVjN1NTbG05TmFZajJzdHQ1SUptT2dQTU9uK0pzLzhTM2NFN3RZN01sSjV5?=
 =?utf-8?B?K1VPVXE3QjFxdHZRUm9zWjZ5NEZqUUUvL1p3Znk3NUhTc2d4UXAvczdQT3Uy?=
 =?utf-8?B?NGFma2M5MFFkbC8rYnZZUmw0VkNyWEYxVGtQWXVETXRoYVJ0QkVxbGhXTGhM?=
 =?utf-8?B?RFVvaWNqU1doYlBjTmJ1RHRQcGFicE1XdFFwRythZWF6WVhoVHFtMi95Qml5?=
 =?utf-8?B?YWdFK3JVYlk4U1dyWCtRNXE0aUZPQzBkeGhOSkthTEhyc1N1d1Evc2xZMkZV?=
 =?utf-8?B?dG9QNGE4c1p1MjN4NGZQZlpVa2kxcjNjZ2tpMitLMnBhZ3V5RUdCS3QrekhG?=
 =?utf-8?B?YnJxSlg0OVZKL2ZqenZkT0cwdk9zUGxPamxHaDhsb3dudndQTkxUK3VnRkpz?=
 =?utf-8?B?NkNGWCsvSzRyZ3FDdFBEZGtRTUU0NmNoWlBhVWdIMEJzNHdyZlE2dy9uVFpQ?=
 =?utf-8?B?dkIva0UybGt3cHhlL01Ha0pXVUlzQTV5UEt4bEFMaFNLb3VSVDM1V1BZUXRM?=
 =?utf-8?B?Y2lvQXRMYnQ4SlErRnh2L3B5RUFHNXpuNFFtaU56RmZhK0w4THEyWGlXL3M2?=
 =?utf-8?B?bnFFSnhFbFhlb1hnQ2xsYjZzVUtsNWFtM0JSYmxMcHNmYkdJM1EzcGlJQzZX?=
 =?utf-8?B?alpDVmtpbzV5aXo1bzhXUXZXQnBNbFJHTFJ3RjBTMlNGRHhScm1aZTd0bWFZ?=
 =?utf-8?B?NW5JRThXZjZUUlFUM1Bob0NkUjhuZXgyUzhqV3I4eHZnamRlQmVJU3V4a1dR?=
 =?utf-8?B?ZWNjT2Jrb0ZNRkhENllRMVAzV0JwOXo4WGVTZVB5NHl4M3NPWFpIUGk1QUpt?=
 =?utf-8?Q?pncv6Zonp4+Kru50//?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5af6d7-24d6-4249-aef2-08df39b82cd6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:38:50.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdyFL0cYxxjZxoYh02yK/ynVC0Vr2M35O+DQ38rvdKNClWP1NC0u3YuxIEjZWl/s+VhmmCeuWxrNGG6aqeELiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

Jean,


On 11/3/2026 8:03 PM, Jean-Christophe Guillain wrote:
> Hello again !
> 
> I managed to boot 7.4-rc1 successfully with a small patch.
> 
> I'm not an experienced kernel developer, so I used an LLM to help me
> investigate the crash. The following analysis was suggested by the LLM,
> but I tested the proposed change myself on the affected machine.
> 
> The likely culprit is commit bf5bdfd1f8d4 ("iommu/amd: Force identity
> mode for selected GPUs only").
> 
> This commit introduced the following line in
> quirks_force_identity_mapping():
> 
> if (pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_ATI)
>     return false;

Thanks for debugging. We we added quirks_force_identity_mapping() we assumed
upstream_bridge is always valid. Seems that was wrong.

Patch looks good to me. Can you send proper patch so that I can pick it up for rc ?


-Vasant

