Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616BC12B74
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KuYDG/eU"
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox27IpHkTtGjp/2V/l+dro8geH69/qkJ8kg+zOL13cWpHD/e+rlnmen5xbQyYRAqqBwZFT3TZgJjeIh3iot62wNLlfgmQDllfTpg9Kp077I4u/CoTRfj5jikhTwcbFjA0/uzV8hWXP3i8HPXux8i6jbBjX8/LkdmZISrjzTwHyHwJ/XGIx2wXAiTRaoAfNi7kVCtXIuUraWrOc53E/svOMUVxnJqSlyRfueyaDHURn0SXym1nMjLhW8teDvkU0GbHLFzjugf3K8bPOERfNLTRO+mmwirC4HuHHucNdRYOEzMUXMNbb80U7iTLmxmwZLzQInpiRsGEbTK9bLrePg6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G61KdXViUg8AaHWaiNvLu1X3QxRBgPjup71jBY2d6CA=;
 b=McDYE96YC84XT2Kx41z48hTeSFfQozrKoaIeYRV6JA8nqZe6Fz8/ZJfw1p9VRdQbtBnWAJhRT6vXQE5TJPKiyDaAtCJKbYtpcAbhEsWCd8Y9gOioWpSkPAtfM0JpMj+2psi/SSGckAyKvtjetia7pMcQwtB2y5LxtFT25wMY1Y/IoZPsa2k8akVGGvi4daGMZweoRDh1I67bKwPUnJay60XgtlnPRkGK0x2FSWfqiRrYowsvdS7ziqNj7oZih17c5HPQSzX6q/zGq8Wm3xVQjEezKQ5alPTWcreNXmk2joxS00DbelS0Tj3y+3zWUfV8lIebgmBuhrqbhkIJXsfBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G61KdXViUg8AaHWaiNvLu1X3QxRBgPjup71jBY2d6CA=;
 b=KuYDG/eUJuLeFA5P8vROSGlgUAcpM7bkkN5GJ0peV9EuusQMfq8rCHScdPkr7xv1TBdahORBMDrG2gAscHInIAOyc1wWInQW0m7Dhs59r3AjMJqPAhx70u6sFpKfm4Gt98CmXMFTVUgCMsiBGUqwg3ZgLEd3t6BKpGaBRoBd3qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 11:30:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 11:30:25 +0000
Message-ID: <fa3a1313-107c-ae0e-fc01-85e2fc8888db@amd.com>
Date: Thu, 5 Oct 2023 17:00:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 0/5] iommu/amd: SVA Support (part 2) - deprecate
 iommu_v2 module
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, wei.huang2@amd.com,
 jsnitsel@redhat.com, jgg@ziepe.ca
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <ZRpkDHZrfnFIjQ6v@8bytes.org>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZRpkDHZrfnFIjQ6v@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6c7993-e8ee-4a69-eb91-08dbc59677a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BFFr1Dj2wbgIS7dGA4TgFyt6r6LumN8t/+r/wjdQt0kDG1thq9hpiPV5Ii/RuNQo7KRCt8ASx4IKkW3zn0tAvgAAN/R3Vm4GVZlYO1sWjBIHPjvg44jhf/53VWMFr+njLbwi62YpqnumVh5/cxnACipmanozknnc82r2mk1Agd7MdYoYUo+JRBRA0QrJiCXVo6HmARxXtwqEu0Z8f/pr4t/q5oXLR2H3ZEL212vWJzFgPeT5vjdY0/swWqOg4FHLqy5JhbsHAaXVUHysc/nb0NMRr258nd3coCSbsIe4cdWD7mYBa1x7OMmxSuVfc7tHuBDtj3GnjNvKob2yqjxfHhczCRf+qUI8D85BoljWmFZQfIIpWD3x2g2GQbQricpSqNET4sFLESLRxGA6XIzvHFu276x9MH4xUut6R1zQ64VeLGlp31w5FKrVfcj2UyOpgmprg8P0tD4bqTBEkDQThgQhzpBEOIpKJOQbqD4y/vJFL0Cjmz6MGfD1HCK5iN3YHjGND9bTgGWOdgYuKN9MARLq9Io9oRJf+Qo/qB7m85TGDXRUDVG1ny6iO4E3eZB2o3xyh/w0J7TITDy39JUO9v/+GsPpm0fA3MDz7RINTuzT+/TQ8DS7fZYWV7ci/F7E6+nmof6b8U9G1jd9TKtfqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(66556008)(66946007)(6916009)(316002)(66476007)(41300700001)(53546011)(6512007)(26005)(36756003)(6666004)(6506007)(478600001)(6486002)(38100700002)(31696002)(86362001)(83380400001)(44832011)(4744005)(31686004)(2906002)(8936002)(8676002)(4326008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0J4QW9jY2M4OHlmMUNZdjF3WEg1UEovaFBvRllHZU9DSC96M3hZOWsxd25h?=
 =?utf-8?B?czh5Zy93MERzSXV5K0NxSUgwcFgrdkhGTjBXaGdFYU1VOS9iUDNkdmdFRDU0?=
 =?utf-8?B?RzFsNHg4SDlyYUxtaVhGSUFZbDdLL2N5VHJBdU8zZFo3dkpQSmIyS0ZlK1Q2?=
 =?utf-8?B?eTl5R0xNVUQveUU3SVNZVkRqVkhQcUJjZkNDaGJBWGJiV0QvOFlqMEFDdTk4?=
 =?utf-8?B?b0I4V2UvcXovbFhZR0E0bzNPakJWcVBpRSthZkhaTXN6MnBsTTVRYVh1bDV6?=
 =?utf-8?B?bElsK2dJMHdmcGFkWEhHM0JKcnNmZmZ4SnV2MjJMeVhzdGNuSElNVGJsTEo4?=
 =?utf-8?B?YjdRUW5HVW41dDdsSXBWWlgzeWVFRVZqNFluL20rYXJWMFNsL05tNU9aejVq?=
 =?utf-8?B?Y01BUHpuTXBsVXVTUmRWUnFVVFJ4UzRhWVpCSzJsdU5XRkk3U2xNZ08zZk02?=
 =?utf-8?B?ZjVKRFltZk5NRTBleFZ0N0ZJYU9BTEh3emsvTmtLTUhkQWhLMm9LU1dQQ29q?=
 =?utf-8?B?c0hYV1BXZW5EdjFHUW1BUWRMUGhxV1R5QmlKczRPTWZDSzk0Q0dCUTRXQmZS?=
 =?utf-8?B?c3p2eHFLWlhFalc1MVZtVUpiNmVFeGxXME85L1RhbjNhb2pkL3dpeGozVXR0?=
 =?utf-8?B?OTh5cWVGNjFZVlZVRk5KTmM0RlFoQUY1a2NaZnZFOVJoakI3eGxxbXBsRG9h?=
 =?utf-8?B?WTJTeStiTDRHc0QvV0ZsN2lEWEIvMGxibFFKRmV6dEl4cTJyYW5HcFFpSkdz?=
 =?utf-8?B?eWVEUFRTbUpRWk91UDlFOGlhdCtWUzlReXRsT2tGbHRJT2pKeVEvczF4enlx?=
 =?utf-8?B?QzZGVlNSQVlvUGJuOXRkRURjNW5VbVk3YS9NUHBrRm5WQ3FHdk9lajhNTVli?=
 =?utf-8?B?cytaVTdINmNmVjNtVGFvRDJGcGxBc0JiaXVLeVZ6TFZPWllzRmxHelVzQzYx?=
 =?utf-8?B?ZHZvVERZQ2N1OFZOdDRqSGFZNHRXU3FXOVhnTDlvQXdWUWtkcW1pazJBTnky?=
 =?utf-8?B?Ylc0cEltYS9QZVlhMjluczg5NXlPZDNwVXlHblFOSWJ6Tm94ZkNDT3EzbVBw?=
 =?utf-8?B?UHp4ZkFheGo0YkJqSXc3QkcrQTN6ZjJHWU9FcUxHaVp5TGNNSlV6WGVRaFNC?=
 =?utf-8?B?OXdncGxOT09RSXh1cGMyNVR2ZmNIQ2U1ZlVoVzFzekY0OW04RldoS0tJbHVk?=
 =?utf-8?B?K1Bsd0M0eHBkSUVnd3pYbUVjcFhIenByaG9rMFJEeHJaaDdrMXZHMVlOa0xs?=
 =?utf-8?B?WXZ4eW9uMVVIUWJwZ2lJbkpYRkxqRjRZRHFOYm9WaGlxMGE3c0FwV0lQcnV6?=
 =?utf-8?B?YnJ2YmUzVjdoY0NxSVJaS2R6M2R2d1o3TzJEM2VxSzBmTWdEWjFFS2tVbUw4?=
 =?utf-8?B?R0JMT3I3Z2JoM01EcW91cEpYMHlXTE15bDhveXdxNDRpaWV5elAwTDNOR3lH?=
 =?utf-8?B?eEt6VDViRWpaMmFMcC94SFFKTWxVL2lNWkpSQlRyb01YRGNDZDNWeUdBc1NN?=
 =?utf-8?B?MmtaZUZ1MDA5emlEb2hhdW5LR2dmdEhHaTR6YjE2YXc0eThvODFUdzFSaVcw?=
 =?utf-8?B?Nnc3Rlh0dDhyNmRjOElNeW9XMFFlRmhFNUFQcnE5alFzWFlhdFNDbGMyb0h2?=
 =?utf-8?B?UUFCT1Q2c1BiSXpvaEcvTW5vZitrQXBEdHRidlJZTjBHNnhEYXV3b2FNc1N3?=
 =?utf-8?B?S0NFSGhsYVg2Zit0Q1I1SVRSWURwWHprTjZzS0UvYm9SNE1BSXRucFgrTlI1?=
 =?utf-8?B?aFA4VUxVL0FDdTBNNXBIWGxIVnRWbjE0UHkrdmlQbzNGOUdBZDlhK0NQM2pO?=
 =?utf-8?B?d2NqbXFJc2xPRUFDbjdsc2s3K1dyZ3hHOFl3RTg0MGRYblE0cGNTQjBHdld5?=
 =?utf-8?B?QnlxYVVQZ1R6dEdTUWEyRjF3NTBJUTBQZ3gwMU5Ld0JRenIweThQaGJTem5K?=
 =?utf-8?B?VzZuVzJvRnEwS2tyQWZHLzBDY3dzNnY5UWFOM2EwdWhjRm9vR1NFZWdOYXRp?=
 =?utf-8?B?OWM2T2dISnBLSmpFRU5Xdm90QTNrYzVvQjNNTTdLQzBHYUh0SW9ETFFQY0RG?=
 =?utf-8?B?MGRHazBZdXpteThLWDcvZG5EbCtnd2RtOG5kZ1UyODZ1THlOenNvRnQvOVRF?=
 =?utf-8?Q?FwTCuTYxAcIFUsDrGSxJm1+lL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6c7993-e8ee-4a69-eb91-08dbc59677a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 11:30:25.1441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d55uvbBLVWJMWQrNX/oQzq2O7oV5jSN/HOVJg5yn5nbldkxbo7Xgmp+TeOLi/RwmqIYIbr7CTaE7Xdu9O1e1PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210

Hi Joerg,


On 10/2/2023 12:02 PM, Joerg Roedel wrote:
> Hi Vasant,
> 
> On Thu, Sep 21, 2023 at 09:31:35AM +0000, Vasant Hegde wrote:
>> Vasant Hegde (5):
>>   iommu/amd: Remove iommu_v2 module
>>   iommu/amd: Remove PPR support
>>   iommu/amd: Remove amd_iommu_device_info()
>>   iommu/amd: Remove unused EXPORT_SYMBOLS
>>   Revert "iommu: Fix false ownership failure on AMD systems with PASID activated"
> 
> Alright, since this causes no regressions for Radeon, can you please
> re-send with all Acks/Review tags? I will put it into the IOMMU tree
> then.

Sure.

Thanks
Vasant
