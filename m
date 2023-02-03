Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9379D9
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 16:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVTZS8fjOviccXC99/PBHueIyHYxkymngTs+1FtNqtUsj0koKmj9cU6M4IXL68KPKuEdjYfseWHuYKLr3zlSjQS6R+nRqLdPuNvCXQ8E7th+wlbitDLE6b6xqcdRx9DVEq0ZBPnB5FrJ3TP0d1ZQXkCufXUMxVQa7vmNTCEvbO/chafMJXCY9W0W9vHbuDHweyp2MP022HSeVR0M9x/8L8HrUaeKEqeig55h17rIiBgLRVSvSUDB/ddp64VuPML/NBBwRxpN0A/8QXb/f12GNOn4pra6twQz+d4B8paXVZJFTXbDLGBIFzo83Q/J0oxPpZo+PX1azRZiGj4aPZUExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEFhg/28DQdjBf6q5gsTfzkmnzpp2Wm3ZTh6zuy+Ze4=;
 b=l3juse0pNo+9hnI6OH/BoUP3Tl6fPbI8OY+UGakXpZA0RKY7tRdyAhmxs4VWyUeEVpq1GV5umFn5WMYCAcU7Fb68i/mVqLFIT9BIdXkgkavGLjJWJltxTHhpq35q5bVDO5lqxufHxRw10KrQA4tUdvdOW2r4p2qSBbVSAR05wccvfr34lbKYokT0jh87BZ3NOA3nVokpfuOb8fU0EIDlDlGTFpZQtPMnFPqHKEnIAYtlG6O8UQBP0Le0QoZhZDxbQOtq8FFlKhdaTp3lKfgzRHF+ri1rgSMtI+MSe9UrQj+IhIGhMAL80A3Ozr0u/M8uvZ8bBDcwIRqolJXMSXXwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEFhg/28DQdjBf6q5gsTfzkmnzpp2Wm3ZTh6zuy+Ze4=;
 b=rqw8Z76F5hHm7+0cI/72rXt7UFdRL43S1aH1sEPBFtIVYAob1tzXl4HwaGbYKWWELhFqizsjXFT7BTVIqoV7aJPkbuD63TZ7suN3tqePjrqYie4RQr5Spc3B2dEHHH/vl2XFn9iVekUvXkRYWSjnAnL711PHkkcbaUDYMVHSZiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 16:52:17 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%3]) with mapi id 15.20.6043.038; Fri, 3 Feb 2023
 16:52:17 +0000
Message-ID: <2dec28fa-3de6-ed0f-6d9f-0aba12be5052@amd.com>
Date: Fri, 3 Feb 2023 22:22:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] iommu/amd: Call BUG_ON in page fault hanlder path if
 domain is NULL
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
 suravee.suthikulpanit@amd.com, Matt Fagnani <matt.fagnani@bell.net>
References: <20230113135956.5788-1-vasant.hegde@amd.com>
 <20230113135956.5788-3-vasant.hegde@amd.com> <Y9zVnkfEp3bC+UfL@8bytes.org>
 <8f161d2b-2c00-5a91-5799-36746af5b32c@amd.com> <Y9zsE800/NhF8unH@8bytes.org>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Y9zsE800/NhF8unH@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a062137-e004-4ef8-d5ea-08db0607020f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zGTgD0FbAOKZxBbWBfb+A5/G5ysYlFXFHQHBJyrRQVlA+iEFGBbUxFv7sdNKarCV52yB2meSXulEFJTwitshJ22Xuli6AIzRbCzL7yD3ygXlBG+Xy4b0KOCevsHGIw9H9WPLNvoB2G87Eapd1VC+l4wtA711Bamc5vIuRHfrl45f4zZ31nT0aTrD93eQ/xEyfzoIgLYEHmD6wenfeC7hU1/pCOydxVtO1z5v5FyrO5lRrEZiI2U3xVzrC92/RejJR1ijrNaStm36aklX/5MtM6TWHZ+c5YGtc6O7lCnxCifM+SmC/H7UZKFE6Cc2JQ0JaiD0+2SHDrylBQEZvz9jME96ZATKvUGbNWAfRtQU9SnKYjBd80sknSaPs3ENdyeIoMOfi8Ac+GTh9CKO4Ghsi+I+2HV1LpdiXaV6b+CCsium0a5O4MVwA5bTMcpHgiv2DOkQnpzZx/r5/K6uGs39fzpkzrl0bXMPu1n/i5yEn5gw5/7Kz3qyconvf2Q72ivqz2CXwFriL/s+HnyNN8g0WPRqF5Cxld1n2IaABZyCPnjS4gy+LcW9RCHpNUrekvrRGadxpwY/19dO8L1my1hNmRcytQgAMcC44eh3uUE3B78sSsQ5zrAnABmjQntabxHAj1GcM292J79OsLlfgfMYHWZF2l7Bcvx9KKOVw4+SAsRrImn/bOs7Obhz8+D9QrxD1WnxB+PWGGeywytLULEv7mgHAKf2M0Q8f/TVa5SS3Bk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199018)(26005)(31686004)(2616005)(31696002)(86362001)(186003)(6512007)(83380400001)(38100700002)(36756003)(41300700001)(8936002)(4744005)(44832011)(66556008)(66476007)(6916009)(66946007)(316002)(2906002)(6666004)(53546011)(6506007)(6486002)(478600001)(4326008)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2MxTXUwMWkrbEZyMEdjcnRyU0FTMWpZdG1SdTBnMC8wZ2prT21HMjJ5eTJJ?=
 =?utf-8?B?UzgxczJSME9GNFZBTEVVaXNvT0dxWExMSFZaaG9EOWVPQ2NpUGtKMk8zOUdM?=
 =?utf-8?B?RjhxQmFaaUxvQjdKSUxEM1hQV1hlV1A2QlB6RHlpTHNnc243dEpYMHFWRU8y?=
 =?utf-8?B?TG42cUNkTUwrM3dYY1VhY3lrbmJWdmNxbGt4dXBLYnI1SURiSnFiR29aeTMy?=
 =?utf-8?B?ZFFLQlcxUHgxM01sYTV2aXJtWWdGQWFMVlpsN29rNjhhMkloT25PTVM3amtt?=
 =?utf-8?B?eExwMXdYUWI4VVYydjlsbWRVRXVoZXE3UHIxMHNvbUQ0RXA3RjVib2tsREQr?=
 =?utf-8?B?SzEzc3dhZHc3N2w1STFnMVJvRVVkOEc3V3FZcUxtWDEzRm9VMUsvUFYvQjdD?=
 =?utf-8?B?Y2Y2NjFuckxKNkhTZnNuVG9UKzVNblFsOVdyZzh2T3o0MTZ0eURIWUtDNXp5?=
 =?utf-8?B?bThZVnN6RmcxcSs3c3BBYmxHRFMxNnZDWWJVa1dybTFzYklqNFIxTnpCVmk2?=
 =?utf-8?B?MGVOc2NPYVZ1cVNIUmVWa0Z4NTZ2dGpWVnN4R25DSmFza2cxT29jOHd3UStX?=
 =?utf-8?B?ZEZ5bmJJVWJvcEwwanRock0xQzRMSWtWQlFBcVhoU0x1RkM5bHBpNE1tSDE4?=
 =?utf-8?B?endad3BnZTVaRm5KeXpuM1pxUkovWVo4RUpmcnF5cm55Z3o5VkhPRUZ4WEZv?=
 =?utf-8?B?a1A5ejh3YmNVVVFLQ0lCVk5jdXg1clhTc0d6K1F2Wmc3WDhZNERvWnRKbzBB?=
 =?utf-8?B?ZXQ4b3lSOTArU0M2cXR3QythSDF5WlJTdzg5bCtmckprTHFHWDV0TVVlbEts?=
 =?utf-8?B?VjV6ZHFGOXdtdEFKOUZmRzF1ZVJFaGNjMzNSNXJRZlRZUkZSZFRIdlhmUGVP?=
 =?utf-8?B?UDVSbzVwdkhZeVFrYTFzTHN2REtZNVVOa242b2Y1emFPcGZMSUxCNTgzdTlk?=
 =?utf-8?B?Um9MRkR1KzVtY3EzU2xRcmJsb1dBeGNxaFN4b1IrK2xyK1hpdk5tRXJsaSsr?=
 =?utf-8?B?d0k5ZHc4RE13UFBJTHdCdmM1ck9RdmFJUy9UTlpBZ0lCazJjZVdNZUJvUzU0?=
 =?utf-8?B?UUxHS0ExK1Z6d0QvenZyYkUrcFdQMXpLQi8rSUJjTFdLVVZITDdJSWFNYktr?=
 =?utf-8?B?TFZCV2JlNmppQlNXVjdQWjVHbnptc3pHQU5GZGd4TjJQNUJKNUF6aXZhd2V0?=
 =?utf-8?B?OTU1U2dPNUpPN0k2OFNtY0JiWEx0TlNNS2tJVkcwMHMzSkpSMnRoVkFyaVhY?=
 =?utf-8?B?MUtwd3RqRnk2dUJMMWlFZFpteVlaNktncFdXaVNJUzFxMDJuaE44eXZieTBC?=
 =?utf-8?B?bEt2aTNvVEdkNnNJSWlmcE5tdTRMaU8xVVJHSXRPem9QRUdjbVRNYVB4M0VG?=
 =?utf-8?B?WFQvMHZJWGMxanpDeTVLeVNaYkl5OWN3WXBTTTN1SWVWRTFOcmUvNENBUmhv?=
 =?utf-8?B?VDhIVkcwUmJzU1FIbm45QStzd09sdXJld204T2pkMG1FQUtkYWVvNUgvZXRM?=
 =?utf-8?B?Ky9iUE9oZUlva090OXpCRkNSbFhzQ1h3ekE0ejNSYnBVSVFUN2o3bTJMRWF4?=
 =?utf-8?B?SUZkZHRzN1JlTWlqa01CczRrb3NiaGJZNjZLT3lwKzB3aXlqclpGR3RhdGV5?=
 =?utf-8?B?aGU5Z05nY1Rab09oMWRZZ0Y3QjdJZi9iQmxRazZ0OW5xYTA3WVFvRC9Pb29M?=
 =?utf-8?B?OVdzR2p4TUVETnZnYTdqYUNLMUV2R28zTGt0b0RvYktOckZWQkt6RUVVMGFl?=
 =?utf-8?B?T3BOcDV2VGVlN1pvaXltNC9ud3BnWnVOclE2WGtaaG4rZHBSRk0xZC9pTnFr?=
 =?utf-8?B?aG0vRmlveTYwRmRmSHRWTGl2bkVYazI0OHBZRnZmNWtpN21ldWN1ZWUzL1JH?=
 =?utf-8?B?ZzdmN3JEekJZcW9pWmdBdFdXc0RaQ0piRkpxMTdqeTV3VUdQS3VncU5RckVD?=
 =?utf-8?B?OGdIOXZnNTVwS1JnM0dFOWVoYWViZUtkV3p0QXdJWE5mQ2hlRzdmWDJ6TEd2?=
 =?utf-8?B?SmpMVUJ5bVV1RUk3OE41bHVKSDY0dmpudy9qUU1ZRGxtVk9HNEJqNU1tMkdi?=
 =?utf-8?B?R1hJYlNJVXRXYUMwdnA0SGRybytrWkVQRTlZL2RRVmJkT24vTzMzTExqd0ti?=
 =?utf-8?Q?2xD6K32MTQi6M2ciHAHuvH4TB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a062137-e004-4ef8-d5ea-08db0607020f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 16:52:17.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcNwddzzs97ANXPzmLokDE8nbKhgmh4LATKB6jepoeaBYV3mBicjn4PqtZpAIoAmuVRxW9cykJYHhL8OhsDEEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638

Joerg,


On 2/3/2023 4:42 PM, Joerg Roedel wrote:
> Hi Vasant
> 
> On Fri, Feb 03, 2023 at 04:10:33PM +0530, Vasant Hegde wrote:
>> Initially I was thinking of logging error message and return. But it will hit
>> device faults continuously.  Also we don't have nice way to recover from this
>> condition.
>>
>> So I thought crashing here with explicit BUG_ON is better. But I agree with
>> Robin's comment. We don't really get anything extra with BUG_ON. We should be
>> able to figureout crash reason based on NULL pointer dereference easily.
>>
>> Do you want me to just add explicit log here? Otherwise I am fine dropping this
>> patch (3/3). I think we still need first two patches from this series.
> 
> The best for now is to print a ratelimited error message and just return
> from the handler. The ratelimit ensures that no misbehaving device can
> flood the kernel log.

Sure. Let me fix it and send v2.

-Vasant

