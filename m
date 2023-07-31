Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3B17754
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 09:40:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YacxxNHU2PqIvj844m7dcPRwLRX63eMZEHys1jgF5+PgJXSVs1NFy8mnUcouXY2gH/8PrPWdVbBKJsBxoZ3zfc6mCJt4JeTzIgqmaOvOxhTUhmtO/q9gt8QQiz2uPiYx4ZvEcbuP8KrwWriDxX4fJcnl1hCr2I5Wvu3JcZULVe0AEduQWsIV9rrziw+TIzWWJQBMOE1Kw7VSv9RSaWXvjU7e24qtEenitXmCVypbdNXMqsF0gz7XugTr8bSUCKQFF/K4SKmC0l5Q5i8U2Qc3oIty+KLkr7klNIStuuBRGqw8dl0bOFjq6PNRZh5AGn8X+mnT7zWiukB4OlV4WPQzIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfwXlAObNIKdXjFjEM/qyfpsKsoExyqMIqIfI2y/F2o=;
 b=gZRA3MFMncErt2cInHZmrMU7vdOxchxKfa5TvMX7Nwc0aeldVYQpSGgXPzS5+Am47OBx/FuA9ODsTQDHfF7fH/PeeR4knnWVZjPUmj06B0FDJL57oRBFmHMnIPpM/N+sFLOH2UuPEuxyhVbvFRir5OKPCAY7EhccYvvY72fXIGSNadFKvwgB3NHaBcjGVFDPCEln4ZkTV0FB4FrbNRZWOd6VrDjzsGwrne9ra6+ARA7wy4Bni1/sR9IN7qQBN6Rzg+qQekA1oNuGZj8/htA6twbuyV6g9+RQl72OWnGCdFf7vy9kGC0hX8qpr1DRznDvO2feVVq9J0IF2YZw/8xUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfwXlAObNIKdXjFjEM/qyfpsKsoExyqMIqIfI2y/F2o=;
 b=HTEi8WeqKou0aCcammEm+FQLKcUoyE4tb7JZ4VgTWtx4dAmVyHoDL3Ofi0faRrAhT26gPLQW8TyseBcJCHo0aZp/7osq0nzccvI382OFzuOZw4GLKXtYOLrOEBNLgXjcTLJzsg2jn6MO7oDCkoptJb5J/bD0eXKs7i6fh8NHuS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:39:57 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:39:57 +0000
Message-ID: <cc002712-6d1a-936c-c562-2ee06246b2d8@amd.com>
Date: Mon, 31 Jul 2023 15:09:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 09/16] iommu/amd: Miscellaneous clean up when free
 domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-10-vasant.hegde@amd.com> <ZMPM8Vdo974Du14a@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMPM8Vdo974Du14a@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd73632-50ca-4eaf-df3d-08db91aa19ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iasrugoKyv037YiiAM4qm/qaPH5uxZOxcWb/Q2UrW/SC4l8sG2mGy4WXZrSy4459ptrpeXwWb/ZcU9a7OexQn0IxWB7zCkVU9BSq/z1n8ryKB6nWZuUhSbmBE0wF1SxSlzXeh79jTQOwfgZzEGX1OpmDLItyv/eR4/lt8srvN6m/QRNLHHrE25YpMOpw18+qzinkYrTKJbcTOok58fLi+Rlc3ZJlTwHBjemctBGphH69aimhp6Mf1eVSGPMoSptr28u9ZMOjqg9Eugxf7+uPfdEnjklZNJTbncFZ/hybPmxgbk753oEz6oOOjhP+X92IcNIIltvVGixyTfVIP6HDsrCgKTSTQqZ/VStlQH/oaLU4ibBHDQm+XAhqBYjr90WtULbSD7AJEZiRnDTsZTd2GABRAPKeitjMeaoGQbzyy4FwUIsHA+F1lQjTnul9IgUsTZ9ssfTFW7fSkhOJQRDhMZk8GvS+QpJkzSlHLeBskM9G1hDm8tQOR+KmHWmB4VDYivkO9KP8id+m8xpA97sSwoESw2Viz2zKVaj3URDRHENEDnhIDAtIZy7VJ43EXOOLgUE1TJjHn6DfIcnWxL4Yr1/vvLcCTF/YW59kfjrHOkV/J0O0VxqdpGrgBxldDsX05aQSkr25I6jahSqeudup3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(6506007)(26005)(83380400001)(186003)(44832011)(66946007)(66556008)(41300700001)(31696002)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(31686004)(38100700002)(2906002)(6666004)(478600001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEhyQ3JXdGdXbjBWK3FyUitZemZLNlEyd1NJeml3VVVQcmFScy82VE14Mkly?=
 =?utf-8?B?UUorSG84WksyN3BLRGxpRisxc0FoMmg1dk8zNHI1ZVdSOW5QVU1rOUo3Y2Y4?=
 =?utf-8?B?UW9aRFYwbmYvZnJtcE1rMHdOSEdxQ0RIeThIVzFyU21md3plOXhPS000NUsv?=
 =?utf-8?B?bm5FS2JFTnA5QWt6OGFPMytXQlE3Rmo4TjE4T0c1QXROcW1FVGVjMCtZVnlE?=
 =?utf-8?B?OVZ6cGlKWVluemNrYWJVeDhFQkhRd28vaUhuMURDSlgzR1hncFVSOXF6TW42?=
 =?utf-8?B?YTFEamtBZE9SY0JtQVd4R09mQU1Pc0VURGUzMzBreXFMQjBPdmxlZitSV2dD?=
 =?utf-8?B?Y05WSlB3Y3JscGJCTmF4M1Y4UmNEY0RNc3BscGd0WDlSRXVHUjJBY2ZXeVdC?=
 =?utf-8?B?dzNOaFN6a09lS05ZbzFDQlo3QXczTUZ6RWRwNW5KVFFnMEFibHV5Nzl4Rkph?=
 =?utf-8?B?STJoL25GeXJ6NlJsK3Q0blIrNjc4TC80cTFNN1E2QnE3TDA4Q3ZpYWQzWUNC?=
 =?utf-8?B?YUZkcXFqTW5sNmh0ekt1OEJHeUlHZi9RU05xcXErNGlXbEFzMnovUDE2cG5a?=
 =?utf-8?B?a1BObkh0M1BWSmxBYmFwOVhHWXc4QVJqL2NocVlSeDVnWU9kU3VMeXdFaHJu?=
 =?utf-8?B?VktQTDFiOGVnM2Y5MCtrY2VzWERRK3dNTkJ4bVFUbmxxbGJ4Qm9TS0hBeTZl?=
 =?utf-8?B?QTZRM0hLK25scGQwbnc0bmpHTEhsbGVaSVRhcVo1WE5jU3NmL2ZnUjFVcW9T?=
 =?utf-8?B?eUlEQlRVS21XS0xMWGhkS1FaSi8wZnJqaU9QY1g5YTlYYkh2UG5zMStOeGNN?=
 =?utf-8?B?WjZOMG4ySFlsU2tCMXdkVjgwRSsxR29pRlh0SEMyUEF1QjBnYjJkd2huZ1hY?=
 =?utf-8?B?NUhiWjlDMDNhRFUwUS9XV3F5SG1DNWF1Q0REZ1VUWDFGL2l2RXpDTWZIam8x?=
 =?utf-8?B?S1RkM2JmUUxjdFBld2NFRTlidHhzOEZvQmJ3dVZ6VXJSRURGSXdPck56bi9H?=
 =?utf-8?B?VkxPbHZxTkRXOUVrclF4ZFpqN1NxUDM3ZVZaeG1ZUXduTC9GZjdONmJ2VWF0?=
 =?utf-8?B?NjFxMzd4aVZFS0NFZ0JTUHVIK1dtSmgrcjZ2bUR0SHFlZEppWG1PTkIzVHFX?=
 =?utf-8?B?L0ZqR1VFOHdCbjN6Mkc0RURNS1RYTkw5N21VSWRNaVJUSjBlcHIzRXU1akwy?=
 =?utf-8?B?ZVdJeklGUjNUeG54b2txL0JYOVlJd0wvZGJEYmd4VkhSS1FVQ0pEMGkrT3Br?=
 =?utf-8?B?S1FUTDhSL0dqVnhRM0duVFpGZ3VUUFJoSXJWVGlGTmRTOVhwZVZtMXU0M2c5?=
 =?utf-8?B?b3JHVkErSktHTUVQcmJJT29pWWFuUEx1Z1hkdnZwemo5bDJWNEFYMzd3VmdE?=
 =?utf-8?B?N1VvcmJWZm5uYjdhbE9FcHdISkZ0WktuN05vK0pIaEtNV1FVazVaYlpFLzI5?=
 =?utf-8?B?NzZUUldOK2o2Q0NpdENjZDJrQVQ3NCsrSXU3Q0lybWxOV00xMTlkbThLMktQ?=
 =?utf-8?B?ejdCblZCVU9TaEM5UWIvQmFWTVlCSXhRSDV6cEJIMWczZFMyd0l1Y2JucHph?=
 =?utf-8?B?bGxiL25STzUySzBJd2l2WWQyK3hUbEdrbWpMYkR0TFVSZmt5aFpId01VcG8r?=
 =?utf-8?B?NFdvWXIrdjRUYURiTnBEUDVmcHF1akpXVURaNDI1WnRNTDYya0RtcTczTzJp?=
 =?utf-8?B?WHJ5c0lwT0gzdnF2b0dTWjliY0NOc3h1WU1HbFRSOS9lRlczZXU1WHRxeVZ3?=
 =?utf-8?B?a1RneUY0YUR2U3FCUnFtY2tKSVpmRGxXLzhSTGRuOWl6NHZFeFVmV1BVWCtI?=
 =?utf-8?B?UXhWckxDNERlamNvUzA3Z0RsTnBIejdmZEdoRGZoaSsxNC9nSzBMY1g5VGxt?=
 =?utf-8?B?R3BycHljR1RLUEk2a3h4THphS1ZvQ1BDU0ZMQ1pBUzF3cXQ2YmMwWDF1Q0N4?=
 =?utf-8?B?SHQvLytXT29wb1BabFNjTDJoNjc3dUh2OVgvM01ZNXQrZFE0M3pCbk1aQkho?=
 =?utf-8?B?TnNjNzhFM1JEWXVzZUYvSzVpTnRMRlJxdkFTQnVBN2tpQmNsOGt5blF0ME1B?=
 =?utf-8?B?ZW1zblNydjNTN2RPaUhHR01qUXptOUdScEdtR1ZJZmFIUDFqdzFuR0k3WmZ1?=
 =?utf-8?Q?nByd/OvudjVpyX36jFCMRofbl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd73632-50ca-4eaf-df3d-08db91aa19ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:39:56.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ur6v+uhSXi8Ui1OmHUeToBdlbvQ3CqgbB+6mhOfHTrUKlXarTG6L35kUjqZhiKOJQ59gB2zFzjlaHkdvtydybA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

Hi Jason,

On 7/28/2023 7:43 PM, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 05:36:02AM +0000, Vasant Hegde wrote:
> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index f5a05779573f..a0b0deb6fbcb 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2037,12 +2037,13 @@ void amd_iommu_domain_update(struct protection_domain *domain)
>>   *
>>   *****************************************************************************/
>>  
>> +/* Must be called with domain->lock held */
> 
> Don't write locking assertions in comments. Put a
> lockdep_assert_held() at the top of the function.

Ack. Will fix it in next version.

-Vasant


