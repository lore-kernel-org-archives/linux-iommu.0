Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2391FD0
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsOWM4H+ssj6MK3b24nCOaKlJoN1wLCIaAhzZV/Z+pGD78uXFanwMcyfAQaCv03jAdCsbsPvoDBlhu2wk+Wyg6kuGrlbT8MMaaU/Fo59jPxXyVw2OFULncivkixCb20gLXdNZUzRCB1VMZVNrJBQHR881ciQy0jhdEh7LMCVwC3gud+EcbxpTarp0ToZbDUxYVgN0s/6rOS6rIyy2bHRFeBcd82ECP5ME38dqoCdPYFj7tHfQK8Sss2lZUrL75dJVW8Y+Iwm4FVrI5sFNTlDrvoB9tZbDqYSkIvN6LQbEtsTI1GigCJSaaQdnZhhTmS70t6Jb1W3zhzhT/7+QawzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kcB0UdQVFJEIfd0CCsb42wg//KSFD59uFpzvd+VT0U=;
 b=eGtC/II6WPNkfLB9g6UMwhhgRLscjQ5g7XDlvNPwT1+OXEGaeR9k+dV+3606V91oYSgXT6nhveyYgNKG2Wz8bU/ej4y5FB3AtB3hw8w4E5QiSmoeBTDfFB7jG0nFAGKS4Mxzx4yHLfiT5YrKYBPc1gYTb0THCpfk/qpuHFiI76gip61F4iVwKUlyMSZwDQWxxnYScqoSpoQ3rxBLki9Lo124elU7Ry9f0fxAvJ02fzcsCAC8S6zon32leNk30pZMKuZ6rmEFBa0NToTrwvR91aqBx+UkAmrZB87KCrc01qmK93cO+dBADGL8OSWwSprk3RWCE0i8n3GDP5M/eZ9mGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kcB0UdQVFJEIfd0CCsb42wg//KSFD59uFpzvd+VT0U=;
 b=pgPRAzJ+ffghWQfOqmnK2e8g6ZSodYSKHKiVSy9s5OBA3/kAlA/WxPSHe94D4//DXAOVNBZTsb+dQJKxQ2UvKcA8bjleKm0IQZfjMP5CtyBC98U7TMPodFQyCaFOIuEOIgPjB8np7GL6Aq2DdjOTs35o+ecNABLCrkbnvyL2cOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB5375.namprd12.prod.outlook.com (2603:10b6:5:389::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20; Fri, 4 Aug 2023 06:40:17 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 06:40:17 +0000
Message-ID: <aeb3cfb2-854b-e669-6c64-b797f2b8c07c@amd.com>
Date: Fri, 4 Aug 2023 12:10:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 13/16] iommu/amd: Introduce iommu_dev_data.flags to
 track device capabilities
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-14-vasant.hegde@amd.com> <ZMPS8IGzwSWdnNWv@ziepe.ca>
 <89614189-9dc5-f643-9594-6fbcdda5ace5@amd.com> <ZMekLADODWhaQqbT@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMekLADODWhaQqbT@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB5375:EE_
X-MS-Office365-Filtering-Correlation-Id: 6153f6d4-2d47-457e-d07b-08db94b5aa37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	91zXlo2u7Sx8fxpk8I70g3iussrP2YXufgKcGagG1Sl8uImKH6xSELSdTk5SZ3hnZs5/h30b1U385UPLQR+iYVci1QcKb+EKeOrKdU2fODdYearcO0qy38FR+dSjPqwSw7iAg+owQNhHsrbf9jzX6SVv5xRQhjtY0St91qSDiYiF3b7DE2zEgWSxUYWpoHrI/q8MppwAu5N23FZ8LDr9wEe16TXExjyO6FuUGKZbE9AcrFVWGjpI+oLPWYf28hHJQu346qZM/rRXYn6veErQ824+zDQdWjI0QtjvLlU213hMRSqRriWBNO5DnD76CWUwKLKxsslZaUgDwAwVXZJ6+XnwVkCt9zJkVJVMxs0X4aASJZUXEcuUkLR6hhu71gcwmkGbfykPleDPFzrgmFyfqi8b1cnoBTBN9yzxGh5+uQnV+vTd3TsSNjJOun7yUOo2MbGXHP5DYye7Ohv87DkTBWhnmMwQn+ZtfPlUm9m53R68NVdPtoelQK6U4g0OMmzGh55lpqA2aKled8sOjwmWdOmhHaSUBBMiYrrXTOPqTnV8Dui24ebR3THgn/MZOSVR+cJy0f/UTT8UrllywBsxb+HeV1fPhUciz2C6cvcKxodGtLtOsrnD6UKBpMwBEfrBXPRw5xibH8hHvekUJ9VyrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(1800799003)(186006)(451199021)(41300700001)(8936002)(8676002)(53546011)(26005)(6506007)(2616005)(31696002)(86362001)(38100700002)(316002)(6666004)(4326008)(6512007)(6486002)(478600001)(6916009)(36756003)(31686004)(4744005)(2906002)(66476007)(5660300002)(66946007)(66556008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmdZQmxRaHdnUFZCVVVkVm9wMDY2YTI5Vmp0Nm5RZUI1T3FEaGV2Qll3OGU1?=
 =?utf-8?B?ZDMzb1lDVDQ1MDhaOVJGQXQxSFJSR0IwdGxsM3NBRDNpK28rNGoxZUNGSnEx?=
 =?utf-8?B?a1BLVlhzTG5Pa01SSGFDaS9HRXpGUEhqU1EvV1d0akxTc08vYUdRWGlubXps?=
 =?utf-8?B?Sy90b2VNTVpnOW9nbURBQit6QXBOMms1WDVqc2p2UnFzRzR0TXJUMDhzUjdP?=
 =?utf-8?B?TTBnbzNYcWVtSGVuSkJwcU5wYXg0YW9zVXc1WTVzMTNRVEFGUURsUXBkc2VH?=
 =?utf-8?B?L0tCZ1M4eDREOGFTNHBFVG9abWNEK0UwMHRkLzlwM1k1UVNkd3VXKzZqS3I4?=
 =?utf-8?B?WG9sZ091MXJQUDhNSjdoOU13Y3ZXaGh4cUNlT0FuWnBER2N4YTgwaHkrZnFw?=
 =?utf-8?B?cGZWSVhIL0M3SXF2UmVSU2grVlA0Mk9JT3hSVDhHaXUxTnc0eVlZMTVYdkRY?=
 =?utf-8?B?NHJ0Tnl1b2dyaG14UGVERUcyQ2ZHR1I5cGpITWhhb3RKVHM2WW02LzhVRGVy?=
 =?utf-8?B?RXNWOENxQ3V2Q2hkUDBvRFVpZWZPS3krQTVGbmVQL3UwZUoxYUJoOXNFejNv?=
 =?utf-8?B?dDdTZGVGeFh1Z2MzcnBTNGV4dWg2MlVpdnREb0tteUtEejFHdWdtSDRINDZ6?=
 =?utf-8?B?UU9PNXNNM3h3NUNQcm9YRXJsVGw3eE91alRZRUhtWm90anRaU000S0Zoa2M0?=
 =?utf-8?B?RDVldGJNOG1uWjJ3dE0vM3ZMTDBRc3JRQ3VwZEJuRDZVc0ZITVVIL0pORXhq?=
 =?utf-8?B?dG9Xa01oN1VYODV0Z0dUMEJtVFYrTE9XVEpvZUNJcVZDbS9SR2trcDFNb3Jx?=
 =?utf-8?B?c1ZQSklVUU5UM2xyTjEvTWFkcWduZHJJaWlLZnA5Nm50VFNJTmtwdGxKaEg0?=
 =?utf-8?B?Qnd2WnVRWTdIUUkwZ0hidzlDVDE2TWlDTDRnN1JjZGFxbW8rYnMwbHNwN2ZB?=
 =?utf-8?B?VDk4UGhjWE5pR3lBb3pvcEgrZlcxOXNIZC95VXFYSmtUb1Uxd3dRS3BSMWpq?=
 =?utf-8?B?ZXdxaERVN0JwME9ieVlGcGhkeCtGNXhuNmZNNmt1QnpGZGVidmZlS2tuVzVR?=
 =?utf-8?B?ZHBja2pBSDFCdjJhc2prS2NVblY2QlAwaGVPY1FyUTNtVkl4dnVoUGV1YThk?=
 =?utf-8?B?ZU1VYjNxREloOGk5cjhVbUE4bHdSUGc4eXAvaWpaNmFkbVNxUUQ5V1BBakFR?=
 =?utf-8?B?aFRnMWlKZk1vZnAxRm5UOGQ4QVFuV3MvdGEwK0JJa0l4ZS8za0tvYmZIYnpv?=
 =?utf-8?B?Zm1UcUNGRGVYQXNyWXhPeHUzRW1kMldSdzJuVXUrWUF5K0p5OTRiaGJNc3ZR?=
 =?utf-8?B?ZHhrZVJ5elJFZ2gzazNMQzFxQWU2ZFVqZzlyYmI2anRmVkgza3ZUUmFoMUY0?=
 =?utf-8?B?VmpyUERISlllMHdmT1loYTd1ME5hbitJdStLSEs4dy9CQ1gxM1kvbmcxTzc2?=
 =?utf-8?B?akUwQWVBbjdtdUMrbExvSlkyVGMreXZ0QWkrNzhCTVE1T1RZZHMvOFM3ekZr?=
 =?utf-8?B?RFV1QmVJQ1U5Yk1OUm0rMjIvOGxqRXhkbW43VjBEWEdlYmVjYXc1RzNUU0o0?=
 =?utf-8?B?bStpcFVtNHlCZFptWXhmRnNJQm04ZWI3N2xVVzBISTJvWXdXQ2kySzl6by9Q?=
 =?utf-8?B?MWR2QStyc041SnVBb3ovYVFQcmhmenRHT1EyaUx2UGdvWEd2VHZnNm9XVFA4?=
 =?utf-8?B?amZITHJCbWY3U3Q4YklMZmZEUDVEUkxDeWRra3o5em96eHJkeTdhdWUvdVJT?=
 =?utf-8?B?U2EyWjNnTDBvWE04NTduaGpSWDdaZkdYQXR4OXlhMk05a2ZRWE9LdnBHa0xU?=
 =?utf-8?B?Q0JEQzJXUVd6YjZIT0g3VWlxYTlSYVVWeFNDOEQ5d1F5Vy9GYUlpcGhuRklQ?=
 =?utf-8?B?eXJSbVlrMzhXRzR1aW15dzNKVjBOam9VRTBCYmxJRmdCdmthYUtpUDNidWhJ?=
 =?utf-8?B?NXcvbTQ0KzluNkQ4a0RYekJmTDFTeGtCOEZKUWxZUGw2MWRJSGZsTkNYaHhq?=
 =?utf-8?B?alBZSHVEVW8rVVVtRkFsczU4TGxVb0RRZENMVGdVYzRaMThGVmp0b1ozWmlp?=
 =?utf-8?B?T0pLdjd3VGkzZXZVeW56SEtFcC9lMktHT2o1cHg0NzMzcm92WTNNeUZ0RDdC?=
 =?utf-8?Q?gmo0kqN2dIfmUBv2KbFyfxZjG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6153f6d4-2d47-457e-d07b-08db94b5aa37
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:40:17.2596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNygzDYFKT4WvOD/ENEkeCyhJ9XFq0GdLieV78oWsg0LcRJ70wAcfYv1gGR+61g0Bj5AuuSgCGVTDtRQVZb0dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5375

Hi Jason,


On 7/31/2023 5:38 PM, Jason Gunthorpe wrote:
> On Mon, Jul 31, 2023 at 01:27:49PM +0530, Vasant Hegde wrote:
> 
>> I had to dig git history to understand why its implemented like the way it is
>> now. IIUC it was not for broken GPU. We cannot switch from V1 page table to SVA
>> (iommu_v2 module). Hence they forced device to be in passthrough mode.
> 
> That has nothing to do with identity. It means you need to select v2
> page table when working with the GPU.

Thats correct. GPU uses IOMMU v2 page table. But we cannot switch from V1 page
table to V2. Also we were not having v2 page table support when they added
iommu_v2 module.


> 
> We really need to get this cleaned up properly

I agree. We are heading to the direction of deprecating iommu_v2 module. And we
will cleanup boot mode domain allocation as well.

-Vasant
