Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984FD24293C
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734945; cv=fail; b=qdUsK3xYPTDQ+8b3u5eN4ny8GOFfowe0Xx9oYTW+35Rwp0TAHpq73PNV6jTrGEdKxCe4lAcwIw5rxpyEYkdZ8p5ew1+ztrv45IVg0CSiATSkE53o/ZqHwkiRUQRICtJnEWdyXQL5zVBJHJJQrMtkcm5bSa981vTCg6F85Qqedz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734945; c=relaxed/simple;
	bh=oO5kZmNCbxGqkcrWGyuLxAmcRPjjDHA1da7S39Iep8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NC8uXEOve7kumUQ32PgQgAQYPrbKoc1cntsrI14yW5zqnLdjuUHZlfwf85e1Cb0NB0o6T3Z1J6f33Bs2/wlBbCMVihLMdJMM9ScX0/QeZ18ZUpaNiNLPEYoa8eq57e6Qn3cPVIqFwioF53J2Qzrge1FnOD/4MlwCrR+ruR6mlss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w/p5NH8H; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w/p5NH8H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN0rXr4QRbfHEfuz+SrWPWUhIpvbOvTHSq5QDoKXeJUYwC/hino3DkzrTMvp4eKL+WOMcdShLn7RSXOvl/DsGDSYT2OzgNyCTkOWssD0RCjH1zFQ/SgAdrjSvAdz18CQWVA7Hy79afk7rlz8cMQ7Jt4J3xjum1hBms31MdvfzVELzX99F9OeVknLNl2W4ZgEaqjBLSlnzqDHjWlpCMehrcyyiqpBfoAgL297Y2JA7goR9t8PlbHtObG+enHf7mwI07qTLS65+csFDpUeq4b9r/4r84XLaYyGfn0+VqLgxH4iNP0kq4qKuJv/f4xpcK78OP6SVm104iMh0lzaPRk03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUJ67cCPk5sZoLpEe3bmyQC5q2yhCwznil5zsptCAeE=;
 b=qwPQeCz8IuHDmfoaP007wpowhNO0ODwOxt+oWkpjKBEYhKThKUaJL3IrDRBD6e1SxgqRtsOoIpLcYyceeaVd4NIEJyE8S8B9OnB+AWrRiAXafo5Xa/QWjs9IkAZ/uvOngiyfQ9m8RujRzo8ft5HcoDCR6XOmmWh6mMwfW1Wlop7TOFfjKKGH3Y8w5B7uMJyNOYj6iTw7kUNArJRZeFHG99ZMoqWHxN/4KhwMSolyv4tptaqBpLV8CSQcSsIJUOAByo9p7+B1zAggD7kruGpZEKmpscUU+fpNFdAXg5+w9Zxalr+ciaA7w5gWgOFgkBetIfWE3ouYaQg2AH6dvJ1DAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUJ67cCPk5sZoLpEe3bmyQC5q2yhCwznil5zsptCAeE=;
 b=w/p5NH8Hlw7q4tAZ3cXtfSJ1KELvIQTla6qKJigfAU7qERl2rep6TC4pbe0ub75kXEN5vUK+bX/RE7TzjIS0thwg5gbd65ZrF4vCtgaMDk6UL7WRubeh0Z+N8NoyL/OfTMxwULgKVoTmCXIHreEvf0lxvh1xNaLqvBd2+lum6vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.13; Wed, 29 Oct 2025 10:49:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 10:49:01 +0000
Message-ID: <4571f444-01ca-45e4-8465-745e16c1b73d@amd.com>
Date: Wed, 29 Oct 2025 16:18:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Enhance "Completion-wait Time-out" error
 message
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com,
 Santosh.Shukla@amd.com
References: <20251016150809.5465-1-dheerajkumar.srivastava@amd.com>
 <tgugv7ebuxtnp6ou5jnt7od7jmccsipblqityiinhkgratosu6@bxsr73hpiiny>
 <01c81b5e-d6a3-41fa-9758-37661e115483@amd.com>
 <5uof463yi5zq6y3rsjqdifktvqxe4ctb63koz4qgbwvjgiudlg@qtjxrrymt3mj>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <5uof463yi5zq6y3rsjqdifktvqxe4ctb63koz4qgbwvjgiudlg@qtjxrrymt3mj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 2007b60d-6579-4764-d505-08de16d8c4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXJWcVVSWk5FRSsvSjg2MGpPNC9jTGJJMm91TTNFd3ZTMUVRb2hrUU9EOW8r?=
 =?utf-8?B?WGIyK01VTkZJTG9RYTVubU45UG1iQkVqM1NXdnJsR2tKOGVsaDZxTnFLWHlD?=
 =?utf-8?B?d25MYk01ZkFxSW9FZ2hwYmhOMDNweFV4TFFSMm55eGJsQ2UxQk9oeWVBQkNu?=
 =?utf-8?B?emZMYjVzcU9zVUZEWjNaRkJObHJpSWN2WmxER2RXQ0ZtODRZQlpKa01kRFcz?=
 =?utf-8?B?eWFKYWVDUTFwRW5uVmdGU2JGNDJ5czg4RjBBUHNyNUxhaHBPNFR2ZUMyK2Vq?=
 =?utf-8?B?U05EYkwrS29yc05veGNKR1YwVHYyWG1ZTFBvbFdMNEE3aDRDTzc1WXRheUJk?=
 =?utf-8?B?ZlZoaFZvMGFJOWh0bExoaEgvSW9JZXdDWk9JUHo4ZmdmU2VDQ2xFbTg1bmVE?=
 =?utf-8?B?QUxvWWtZM3prWmFnM2dVUVBXL1VLSVRMOU5RTjZwWmJNMGZWSUxlUjYxRmhP?=
 =?utf-8?B?QW5xQ29oNmdqK3VqcXhIbVdKd3VnTlpnUVRoSERyQ3NMUFAxaDdGTXJQcnJp?=
 =?utf-8?B?SkZiSzk1RU1LRjJ1RTlKQVBSSVk2NVFLSlFpZ1ZpWlpmWUFUZDBhZFJiWjZE?=
 =?utf-8?B?Y3lMQm9YelBzd0hXMUpUbkU1Ty9zYVl0Um1YakVwZENXWk1ma25vUFZRUmtk?=
 =?utf-8?B?YnZia2p1RGtNelU0SnorNC8zQTB6bkZKSysycFM0d0ViOGpFNlp1YmQrdmdH?=
 =?utf-8?B?ZmJwb1FMVGs4MHdEbzlOM3Z0MmpPWXRaK1dCbjZ1Vjc0Tmc3ODArTFpqc0Ix?=
 =?utf-8?B?ZEdFL3M2bDZTck8xYkdMTGZ2T2hhaDg0SGxLNzh2dURzTWpra2ViRFB1MU01?=
 =?utf-8?B?L2R3aFR0TWFYdHovYTFsc3JmdUZ6aWwxdWx6ZklBZkxpeWZselpXM0lvMVpZ?=
 =?utf-8?B?UGt5Yi9xQWVCQ1AwblRrSXFrTHc0VnZJaG1STEMvZHFCS0ZNQVJwREIyekJ4?=
 =?utf-8?B?Nk8zRndQSlQyb01RamZCZFZkdURhMTB4QzQ2SlVnUENVWnJ5TlNWZkFYK2Rm?=
 =?utf-8?B?Z2VnTmNHRDRQRVJDL1MyaUJFKzh5SnJqODdiR1BSU250SUVlSUdiSlRNSEpl?=
 =?utf-8?B?RzZNZGpzZjViN3dGRHliVmNpaHpDZnJEVWpjaUMyMGp0c1JsZ3UyamQxL0JG?=
 =?utf-8?B?RzAyZXhrVEc2bzVjcW4ybHBBVGZyYzVKLzBqWmNiVjh2MnNaSVZnb1FTd2Nx?=
 =?utf-8?B?bVN5a2NZYUtrcm45VmE4Y21yV3N6SklwYlFLcUQyekFQS1ZPSDFJY0JBUDdn?=
 =?utf-8?B?QURacWhMcnNGdzl1SUhta1FraGtuSERKOTZlZmROT0RDLzhZcUk1anRNR284?=
 =?utf-8?B?NmFWODE2SG55UFhIY1pDSWRvQlA0MWF6d2JYUFk0NXEwdFNaNjdHSXRqbUJZ?=
 =?utf-8?B?K0RhTDZzalFqQnF6WlQzNWIxQ3ArMDZsK0srZCtNeVBQSXNGdW1FYTYzT3FI?=
 =?utf-8?B?S3pQS3ZDdTFUMUVmdWNZdDRBUTRWNHkvMUlhVGQvWit5TktNdEJRRDBTVlRj?=
 =?utf-8?B?cUJ3aTFscTN1cHRZUnBVOXJWWUp0UVQ1THpOSTQ4bjdNVW1ZYzVJdmljZmhT?=
 =?utf-8?B?N0NhR2xidW9lMjh4Rmg3RGJXVnhsMDZnWFo2QkwxbHBacGcwM1A2TExiWDZ0?=
 =?utf-8?B?dlJwN0p0ZkprK3pJa3EvcXg5Qnlrb0oyY2gyL1Q5Ymo5N1pxbnlpOVdJWkFK?=
 =?utf-8?B?N2lEVnp6YjVEMHlVd2YvYUtWSXFob3NEejVDYjdHT3d3V1BWODAxNmYzeDh3?=
 =?utf-8?B?Wjdud2xTZy9iZytTNnFub0JhVHVHNFBoRDNHTjRuQW84SFVrSFdpLzZnbFFi?=
 =?utf-8?B?TENtaXpwMk5jbTZQZjRZcERuSWZ1c0ZPdno4WHAyN0VjeHFMN2FhS1Z5TU5x?=
 =?utf-8?B?UXBlZUdrcFdENGhFMmtHK3ZhUWlkSUtFOG1QNU1yQStOQVBoZUZydXIrbVM1?=
 =?utf-8?Q?CjzVun+2B9wuEW82Lxbz1yOuDhppguDa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWFxNXVuWEh2RlhjaTJGTzFZbVZJM3ZLN3lzQTlyUy9UYi9JSmFOaGRuSGFR?=
 =?utf-8?B?a0ZSV2FYKzI2VG5wbG9xZitOanYxZ1N4Tk1ScWhoR3k3MlY4TFNSQlV4cERJ?=
 =?utf-8?B?ZzZNSlFYNmtCTDVrbDBlRGdDbGhzdXVmT1M5OThDOHJXL1gzbU1zbzZjSEd1?=
 =?utf-8?B?MFV2VnhKelN3SnpFb1hsZ2Y5MDB6NTk1bUF5Q2ZIODM5ZU54T0g1Ti9xbXZs?=
 =?utf-8?B?Y0JsbHpzbHBSN0JDQXRLc29FYm1SY1JkYWFlK2c2em9FRUpvMFNMU1JMcGRp?=
 =?utf-8?B?VlB6RkRJcWxndGNIcEVtNlVHZTE1YXprS0l0RlpKaG43cGlSSVpsdjdkZWd0?=
 =?utf-8?B?S2U0ZXZ6Yng2THNPUFo0Q3lmaEpHeEpjUUNoaXNHNzBDK0dnMGdpbTQ1RzN0?=
 =?utf-8?B?Q3ZCNi9TUVdGaFJrWlFFUkNqVXhMdWk5ZUNtRE1pMTJIUVFTRzdPZjV6YXJr?=
 =?utf-8?B?blhaR1J1RnErMXI0NEtiOVA1UDB0a0F4OW1aaTFPaytwS3hoS2x6cC9yMFZC?=
 =?utf-8?B?dUZZN3VqangvalRIZE9zb3VDY1Y3QTZ4YVRuazRHOUFmUDNGb3BlaHR3TVFO?=
 =?utf-8?B?MWw1OEtWOHM2dmNJUjNzamMwNGYweUt0NUpWL2FIZmxFSW9Tc2pFbWs2MmV4?=
 =?utf-8?B?RThuamhMaE9GeUhvRitnS2JFdWczWFhxcXp3ckdobUpldG4vZHd4dlhxR0Vx?=
 =?utf-8?B?S3hVOG9iaUR5RmUzZGNuVHVvbjdKMnFDVVkxWEdlTTJhdzZNOXdqWmR2R1NY?=
 =?utf-8?B?Z3Q2QS9iaDgrZjNwNlVabVpUSWU3Mkh5VzlUeVB3SGh3VmtjTE9VOXRvb1Vn?=
 =?utf-8?B?NHB2S0xUSzd1Kzd0T0ttL3BqMkpRZFcyMFhvR0pvcXN0TTNEclUzNGlhTzAw?=
 =?utf-8?B?WEwwVnRFajJiWWVBWG1SZEszYlVPbGlEZXpWdTNwY3lZSTFZT1VUeUdwTVRv?=
 =?utf-8?B?eXpyOEpOSjR6VUFMcnRTSXh3VzQzWXVjNWgrTXRXbGZURCtBN05VUE1mRS83?=
 =?utf-8?B?VjZHMFNhRUNhRy9ocURuR2h6SjJiQ2IybEs4cFBRd2o3QlhIMEJIYWJUZ1lj?=
 =?utf-8?B?dGxrRDRZcWlVVEQ4RFJNSENCOHJDZ040QlhMejh3MTBlaXp4UGRHQTB0RVY5?=
 =?utf-8?B?NERCd1NIVCtjU0JHM2x1TVdoNGM0YkMxd1lGRTJ5TkE3clphMXc2ZHU3ZHFz?=
 =?utf-8?B?WGQ3MTRMdEJjdzhFU0w3clRvUEtZWStkYlZRQmROK0RzaHZ2aGhjTStJZVdo?=
 =?utf-8?B?RUo1b0hpblpVUldsZGxOdFNxblcwRW1hWGFpSEhjMFZYdHkyRDJZVG04T29M?=
 =?utf-8?B?TW1KWE1IMzIwV0pJSGRldmFRVCtHZG1HZGxucXljNnlmTS9YWUF6UEdlMnNW?=
 =?utf-8?B?bEg3TE1SVjM5dzdwY0RWa3FKVk5pNS9PbjYzejkxN2xnbEJOd2VRZS8vcU8r?=
 =?utf-8?B?eDJFTExRcHlZNFkrRmM4dXd5MUkzNVJtR0JmQXljVTdXLzcxT1FvQTJDNXNx?=
 =?utf-8?B?NzY1ODVlN2pZS09HeUxIb2FZejZMRWYzQS93NXNiSkVrVE1kOExqWmovdVZr?=
 =?utf-8?B?cUVtdDU0anluNXl4S1U1T0RodEJha1UxTkZsYTZoV0p1SmlLS2R5ZElHWUpT?=
 =?utf-8?B?Qks1T1JnbmkraVZvMDk2UEVjeHF0QStnemE4SHhwVlAybkFtOERoUjFKRHZz?=
 =?utf-8?B?NkhodlNGVlF3RXlCTjFlVzVaYU51a0ZPbFJIRHBNbE5UQ0hQNHRGNWxIZUVl?=
 =?utf-8?B?MWpNanRFUmxIeTFYZURCZkhnazRUM3RhQloxZmQzSU1oMW1NNHRwRnFSb2FP?=
 =?utf-8?B?R2J0WFdXNGk5S0NsS1BxUzBHK1R5aE9sZUIvWERSZ1lHNld2ZTV0b0t4T3g1?=
 =?utf-8?B?Sllxa1FxRGR2bUFxem1iU0MyK2tOWGwvTjNwaFFGM3NhMi85MEZ2WUN6RkRD?=
 =?utf-8?B?SDZKUjVjUGhSQjdmUG9YRFJTT0dmTFVpNDZ5WFlyQlBZRnBnSjBuOEFrcHdh?=
 =?utf-8?B?SklGZk5VZW1VVSthbVNwL0JzekN6Q3V6R3g2Uk90VUFEdDMrckJnNXBSa1pv?=
 =?utf-8?B?L08zWXp4Zy9sdG0rdHRTcjU2L3MzTi9RdDlBNmtBRE80bmk1WVNPUFVYNzJT?=
 =?utf-8?Q?RKdbSylBZLbFbEXPaeoXFFAXr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2007b60d-6579-4764-d505-08de16d8c4f5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:49:01.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZOhAvcEFW6v6rfTO1j7Ta9cXxoi1dcRfw5memFeiVBXf82cKgXlBjDiTumI2cKclE00YgdXo5TeMfXb9bqZFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506



On 10/29/2025 2:00 PM, Jörg Rödel wrote:
> On Tue, Oct 28, 2025 at 02:45:16PM +0530, Vasant Hegde wrote:
>> We have debugfs support to extract entire command buffer. Also many cases once
>> we hit completion wait timeout, buffer won't progress.. and we will hit
>> completion wait repetitively. Hence in V2 he has removed printing entire command
>> buffer.
>>
>> Do you want to log entire buffer once to dmesg if amd_iommu_dump=1 ? (for first
>> completion wait timeout event).
> 
> I think there is some value in printing the command buffer contents at the
> point in time when the timeout happens. When it is read later from debug-fs,
> the state of the command buffer might already be different, making debugging
> harder.

Ack. if amd_iommu_dump=1 then we can log entire command buffer to dmesg once.


-Vasant

