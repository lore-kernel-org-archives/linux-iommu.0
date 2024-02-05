Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04EF168A9
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128554; cv=fail; b=LvFfM9nwl8KCK+KHPtP7nHBUf/aPX+YFq1JVXTA1rcqZM/HAW477+F7NuDhfvKeSqgwnEKwagfmtgW6ca7K9F2LczRDIyXWPTl5V20F2/JOcqoJf2ZHyr9lUWk7jPKIXUiuyAt64ZHVC8xP6BoXpidn8RMdy7dSLj9PnA44u8qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128554; c=relaxed/simple;
	bh=ZnzDT0cMqTEHr1hakhu50ST3lyMib3uRQwyTnHLySXo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VwNQipdRXoz81rb+hMSYdJ4TedrJ+P9f6miiFq8bqb+OiE+vJDRjerhD/K/bWG/wvYOND91bW7wMn22VOHhzfFyhQYO9X3lzlN1B8Bzz72qn+jZF+IyqiALDuDEeXkp5ex7Qgjx0NEfQUwwCsk20JE4XhqSKWxj02HagTresLlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r0dVHNZn; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r0dVHNZn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2wz9ozbSEwPEGzGJIIS+xIrYceJx1V7w5/9Z/ZrjyLJej1YzGfqpUYgCU+0T4qbylQ6jWD2op/Ig1zQA32CyYWtnXY2DzYccsPPz1ynCnYWYrs9wP/HLzuMkA5kYikhdUEAJtroae2G3+8Fus92CvX1YYPIyy1io1/P6DjbhMggNjsONs0OMFiRYdAbF+z1uwB2zKJ9pQOjuXaBhH1VzxDo/mmE4H4lVeSMeSZrjhNjNUigPJHJiC3Dft9+GJG/aNdfEuVjeAGMJTAojzfIQ9vVGg1v7ya3oQKr+2NXw0/q5KVBe0ULuGY4htZVynzNPl7lszR5k3BOuFDezv5rPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpsOeRNADAlkpJb8iVdOEGD+zepsgEyco+AItgswmPY=;
 b=bQ2bcuuBJE9RMth2vRP7HnObbDu1scPR9gkjxX0l6La2DFuoLPre/4tz+ax8gzJEM4oSYJMN3G1HDu5udpgfZpvNpvWjBp1rvU5iui0Hh+M+t0/jTgj4Vl1cJE5LVWIvT9rID5aO0ThrAvoFsp5Kd2toKWukxxy6LbpbCzTBt1dv8JVroN4KGvWqiBsgXYlVqoc9jlsSlQLn1aZF4oVfxuJk50qqUI5fYTokOqZJJw1Ew7CU+Q12FrJrm64vl1Z608vCo3Xtp5NnPYd5KZqpAutbyJkG1WoXUrgKJnEpJwGOLRTLkwJrlUtvlK0PZxM/9Nqk0/7vbGfpR1TqX6ABkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpsOeRNADAlkpJb8iVdOEGD+zepsgEyco+AItgswmPY=;
 b=r0dVHNZnh+/f9M7zuZ7XLUVHGQfubhVig78JF8AFhAQ//Aq1Nj+diXDp2YSfPjMy1NwShYG9BdtO+fDwUGdQwSmUxn2vF8ugkIgGgFuRG79HgOzbi4ITGDfPFeRozTpOawwtJz3ATNdjswgXXPnPmWYWCopfe2LaQBg4B+Gx5wA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.17; Mon, 5 Feb 2024 10:22:29 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Mon, 5 Feb 2024
 10:22:28 +0000
Message-ID: <12340fba-e9c2-abff-6349-a4aaf64737e5@amd.com>
Date: Mon, 5 Feb 2024 15:52:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 09/17] iommu: Introduce iommu_group_mutex_assert()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240125121135.8217-1-vasant.hegde@amd.com>
 <20240125121135.8217-10-vasant.hegde@amd.com>
 <20240201172611.GJ50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240201172611.GJ50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 3990f05c-7c11-4b4f-db91-08dc26345b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hJIMbDt6BJdUyNmRkTbkLfj7Z0bTnQZ7gjJoD3lXgQNtddc0Q9bIU9PXWTBxowHjCeNwNAAvqTkB6jPid2ge+1wkYlOrVLmooK6pETzMpmhsdKldKEJ7JHoOO9RPTi0N/A9XstGEt4voo9myeqR51VYX9upm//OmRhAsLssMYZq+mbPnX3mwnBTKxnekLCGDQqZ+NPnGXpwrTjiNWLoTQxOJ5kIgKgN4uB/JDL8+8gq7urex1lcbNDk1tHOJKaN5y1yZTqaJ0/Qx/FllwXvkmUo+w8ZuI8s+bGNOOFOxGDz3hGESgnwGhjvFphlIjJsHoobS0mgc+ipLy1JORCEg6RBPk1DPI00HGMb/LPq3uskgFarKIo6yfFhMMdsaCq1blvWGnOftt44qlnyQqLH3IZC9U/jelWAVynglNZS2PIaITKu9qEt52dJkvFTpfy5OJrml0rIe0f3/XnbMVQIDD+8zHZG0bB8Ei8xfrytgbNszwz0jLWbRtD0LQoT7eO5DKDtu4sCgR3JxfHTBTfP/6g4lhd6Fpc4E/M1rfARPTCOpjKVBzVRS9CnnJzOV3KknAW52QLGqIwewmYEX+kfk6MRDz5UetF9cqGwUDU8sfC5o1AoAzORbwY41eGuH4lVqSIZK+zgLK+G9M/D0VsE4JA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(83380400001)(26005)(86362001)(53546011)(6506007)(478600001)(31696002)(6486002)(2616005)(66946007)(66476007)(66556008)(4326008)(6916009)(316002)(8936002)(8676002)(31686004)(6666004)(38100700002)(44832011)(36756003)(41300700001)(4744005)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M29PTC9FYm5WQVRrcHJ1aEFyUVBOMkdybEF3bnd4MHZFenUvMDM2cVpPQzhM?=
 =?utf-8?B?QVlCWmtpU0ttV2YyUEZxdXdEZFVva1o5Ui9PV1dqSzRHYTlQczJaMGhVNGVD?=
 =?utf-8?B?aDlZcHorS0NEMFdSeWJVN1JqM0htbUNZSjBia1E0YzNXM0dhVEhySFhhN05U?=
 =?utf-8?B?bnlUblNNS094RUhHd05RNE5lbERRQkdlSlZtNWxCcnZ1Tjl4R0cwVGladlFw?=
 =?utf-8?B?amVDTVBER2tFZ0V4OEJQUVhLdHViZUpXZ20yQzdSSGdzKzB1L2wxZUkyQlNh?=
 =?utf-8?B?V25ZYlFWdlBUTHI4cUpRNG9PV0ZEVDhYRlhVVW5neDM2YnZiQjZZRVhQdU5N?=
 =?utf-8?B?ZXlXUFdSVk9sZVFqN0VGMjhLNFBnWm9QMnNmTkpsZkloMzlqK3VnMzdidk01?=
 =?utf-8?B?R1YrMm8vQXNDM1p3RlZDS0JFTmtmcm1wekgwUjMrbFVhamRzT3A1VUdWRlUz?=
 =?utf-8?B?MDd6U0lPVG9QWFlPYTJzL2svMi83bU9TeFppUmVuQ29ieHhkWDMyYnM5L1Vh?=
 =?utf-8?B?ZkEvN2lPTkZjSG04YmpZaTZLUVdaY1dJTWpaT1l4ZkM3OXFMU3R6bmRjRS9K?=
 =?utf-8?B?b0dyZzRsS0hMODUyOXlDbHlOc2h6Tk9La3RwR296cW0zaEtsRUd3MDhlSENH?=
 =?utf-8?B?K3NaQ0dFTFFiT2EyZ3loYjM2eVUzQkt0UVZ3WGE1S0ZZNS9Hd242Z2JGZkhm?=
 =?utf-8?B?ZDhGRGtKQ25VdW5vb3ZPQzVEa0dlVXUyZXZSNDQzWExlbk1oU0dLQms5UmQz?=
 =?utf-8?B?SDFEUW9US0JaYXEzdUNVRGZIUjUxRlp5TzQ4WWJnN0RzRnhmZWVwdG1JQmVE?=
 =?utf-8?B?M2FUWVBEQy9QcmRIQWRnck5jNjlSVXJWVWZaVkFsdjdla1RpTk9kRE43MlNa?=
 =?utf-8?B?QjBhVXVvOGUvZk1iMmVpSnd0OG5OSkFRTWJPeEN1VVBPK0F1LzFkVUVCTlZx?=
 =?utf-8?B?Z1ZCWThTa1V1dUp0RzgvZ1hrdW1sS2VTY1hzRU10VEZQQWM5NkdrUFU0TEJZ?=
 =?utf-8?B?NmZPK1M5ZXRjUTZ2a0ZwOERuVHhQaDRkQ1g4ckNYVTRML1hXeEZLaTI2VVFv?=
 =?utf-8?B?cnJRT3lrM25lTTZNUkRrSHJlUGVJYjdHZU8xVUt5R0wwNlk1ck84dTR3U0dG?=
 =?utf-8?B?WGx6MVNmT0lYcWc2UnF4S0J1T0htU3c1RTAzdTkxcWJHck9mTnRLY1pJeFJY?=
 =?utf-8?B?aTlNQ2JlZHdHaEh3dDZ5WTIzeXBCU2U2Vk1EKzFvL2wxZjZ6V3NuVzBiUkpo?=
 =?utf-8?B?aTQxa0FIWFhYVDNqTGZUcjhzS0ZKMkFHSWQ3TUtCcWd5WnFLdW1HcDRxYTUz?=
 =?utf-8?B?dk5NNXBJOTJtczBOTHVJVjhFMWNmaU9oOTlMb2hiMVNxMnVaMjhnalVMTlZL?=
 =?utf-8?B?N0ZRWHBXYnJYY0tjcnJWdjZiT1ZyWHUzTGFFZ2V1WmM4MHR5V2Q5YXQwajJT?=
 =?utf-8?B?dTRJdDN3OENvbEMxN09NVlZQT1hoV1IxZFlpRE14NUcxaHNwRmxLN2szTkRp?=
 =?utf-8?B?a01CTGpaR2wrRUUzS3dCVVU3WmFMRlVwS3FEa1E5ZWFqVFJ4UmNRa2hnYjB5?=
 =?utf-8?B?V1V2VmxkZkhKV3VNK2RLcFBzYkJRZW9maTRWM0N2WE1GK01ibzVnYmZReWhC?=
 =?utf-8?B?WjRIRkdUQjVpNmVFUlp0NWxoVDF2VE5JZGx2N0tiamZPeDNwbGZZcTNvOWxI?=
 =?utf-8?B?aWkrdkF3NXQyd0dUNG5jenQydWo3eG5ad0IvRWdiVi93N3djS05DZWc0K1Fu?=
 =?utf-8?B?VDJ2TmcxeUQvaTRrdnZtVHFYQ1pqNm80KzNyMVFQcXl1VlozRDcvR2krSklv?=
 =?utf-8?B?YjVaRk84WjJJelZmU21FOGRCUHY4ZjIwVm1aRmlsQ1RUcDJLbjM2VkNiVmZD?=
 =?utf-8?B?TVdjMy9IbC9lUS9kcjRqMFhvS2VkMjNqNU9sUCtBMFlTWHRrKzB2UVNqSlBx?=
 =?utf-8?B?ZDhHbVZ1MitORUQzd3BhWjhUY05TUC84VFZjWnA3V0Q0VTd6TFlHTE12N0Ir?=
 =?utf-8?B?d0dqZnYwTjRBQWtpdEJxSE5ydmRkUXNvV0xzS0E0L2FQeXEvZmN2cXp2eHA3?=
 =?utf-8?B?TElxYVJjUjRueDhZY2hRaEsybHVVRVduM3VoYXVkT2x3MllwWW5FaUwrcjVm?=
 =?utf-8?Q?A6P3G2aItkJal5blfCsV7erbX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3990f05c-7c11-4b4f-db91-08dc26345b0f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 10:22:28.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0qh/nYELmSu6VWvIrOD+qO6petlr8sVLx4JQf+mIiwSnrUSDZxn25NjKpcWYKeXlmwXS1wnQ/nY/flHS9Hn2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057



On 2/1/2024 10:56 PM, Jason Gunthorpe wrote:
> On Thu, Jan 25, 2024 at 12:11:27PM +0000, Vasant Hegde wrote:
>> Add function to check iommu group mutex lock. So that device drivers can
>> rely on group mutex lock instead of adding another driver level lock
>> before modifying driver specific device data structure.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>>  include/linux/iommu.h |  8 ++++++++
>>  2 files changed, 27 insertions(+)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
>> +#if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
>> +extern void iommu_group_mutex_assert(struct device *dev);
> 
> The extern is not necessary, there is a general shift away from using
> it, not a reason for a v7, but FYI

Right. Fixed in v7.

-Vasant
