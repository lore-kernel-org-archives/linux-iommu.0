Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780CCC433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 08:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 334BD4061C;
	Tue,  1 Mar 2022 08:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uUFNAOBscQbv; Tue,  1 Mar 2022 08:58:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8EDD24016C;
	Tue,  1 Mar 2022 08:58:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66E2CC0033;
	Tue,  1 Mar 2022 08:58:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9216DC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73A5160E61
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKNn4lqI02mn for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:58:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::601])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A2F8B60DC6
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COwrdKaatbZo82+LAHQeHGrP/lCdhOALhPrfxvAXnk5iz7gvg4qQ6NjBm8LS3PA9aUTCTFI0n+EyUdnzUKO/qmaGNzisJSRg1hP+yXy/weZJTa9AzmExD2aerb1mFDHH+gFbdQQXO/s5hCq+GQHgxMLWx9NAvVFSTkdZgja0tMgDpjXRkNaKUNZezB8Qkc9IpjGOg4dMj2b4wVpvpLzObgrbPSSIREL52ztmwB/Gv6+zMLTObgabDdfeGfyyLpriIPWF3fDKGLAQ1itGnALGBJU3qfJwvywrq0mscZmG2w36bLC4v2IBLVslvuiXqQ7Px3/faAVQknAxHjlLpHQC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKrYPhiHn238k799IzwUwpDaZeUnlRH9sTeWFogGiyA=;
 b=Z35y+H4OPvi2K/z1b8aryeVdZIwD15jv8OiJaxKbOTzcuGojdTi57j4mdp2ichDEc/+13BF3BrZUg6GY8MDEmSFgTlKagJR9+WTf81lv8r/P+o2dgnGxNy3c9vyrwmBTvXw8+cGNvn17Rf9GW337fyhta5ELkBMq/Etce6lgrblCDm69LzGFICIkt2FcwbsfSu1n2Gjp0Gb0p46/myWBpVPaqIPEAn4Ey3NMrkNcpxOKXfSM8bym7JT6CkcPecYEpnP+8i99+uvKbGP8Paaghdi20G7LL0WQj6Z125u1wP+WU5HSciagdxmdKW5qrLNfKzYLf8/KufzMZ4NLjcs1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKrYPhiHn238k799IzwUwpDaZeUnlRH9sTeWFogGiyA=;
 b=McaKh4jLhBbt2wuIkf/AEBg4AiBcsVKZrw4vkE+iZkcktEfFnhgqB6gO8hstbm4Nbs7DMz2DmxT8LjA0s3HliYmYPEnXRTb8QtS3oiy5Gvu6BuPrapEvlYDkGBhbmqVEa3TaqUR3+zu/A519VHB6lZoIGSKGFrS4NYst11Dd5tA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by MWHPR12MB1488.namprd12.prod.outlook.com (2603:10b6:301:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 08:58:15 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::1809:eda3:9de9:d3e8]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::1809:eda3:9de9:d3e8%5]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 08:58:15 +0000
Message-ID: <ce41a129-46b5-129e-7c67-7ab7615f8bf7@amd.com>
Date: Tue, 1 Mar 2022 14:28:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/5] iommu/amd: Improve error handling for
 amd_iommu_init_pci
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220221045916.19701-1-vasant.hegde@amd.com>
 <20220221045916.19701-2-vasant.hegde@amd.com> <YhzEU28x5FS1yAfw@8bytes.org>
In-Reply-To: <YhzEU28x5FS1yAfw@8bytes.org>
X-ClientProxiedBy: PN2PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::11) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 663abd87-36b3-4f14-63f0-08d9fb619ee7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1488:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14882A86A0D410D90C9ECC3687029@MWHPR12MB1488.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QGfg2I3pHwTdJHkvnOj6F0R00eJNdlt0/GZTsOOURnjwkA4VrEkXnKu1Wa3hQRQTgmueyriHtbzL7h74PoIdNM+DRBWzD1Mxl62VARQD9xs0HsLMGSRZ+S484sPiTBH9bij1pr+80U/zWM4SxuKRFG4xOCfmhTHQBhQxgF6AOX24bmeCPuMCbrC/3snqBxEuvGHJpI3VSBbxz+TKNM5ltunGm1Mx14AC/mj3ASuvPCSuhAUgVQ9Fl35SmmWk7oPRs+qeZV3OtqkJeY91qX9HZwLX4yZBkyBLYiB+jk79Pyc5vRfL55HsBNl2fTaYDoL16xeQw41gkpGeWYuRJurIkArBXxzAZqGzqbTgPkBko/AcN8HjXYhWJyJxvBGlZSh3ZwY/K+0p+hiX7+SuDYJQ6wYGb4LfQFQvYp5qBptsms3eMSlsN9ys+1IyUWkSdUL4JgRQQLYrSXH+ezQTvThpIU3vJ+myo3y/h/4eqMLBGq4d1IdH21shHeEuUWeEDYIoTYaSF+d7ynkcQk0vu8YfHgZscnYcboX0o+u6Qqqvnc3KYUYk3yHQ11yBZtsYqPCiNfxnFk2MrkYgGXny0SWo6LgMPCrgDk4PmwagDgcSh4TRfFtqWWixtHB9XIM0msVrkah60dRgXQmxFGI+GVfpPOGKCvFXft6SOrjt1CeXXrVuvcC9bR+eKsjA/rbOWMIqAfEA126v2Xf+pu9cxjlJImeN1mqGviBVfX4dKyV/08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2906.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(6666004)(53546011)(36756003)(6512007)(38100700002)(6506007)(31686004)(508600001)(83380400001)(6916009)(26005)(316002)(8936002)(4326008)(44832011)(86362001)(5660300002)(2616005)(2906002)(186003)(66556008)(66476007)(66946007)(8676002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXNDZnExTXZQa2RZOFBqaVVWb3k5UFdBY1hWdnJJQitIZnZzUkpvSmFOckMy?=
 =?utf-8?B?QVI0M0NQMG9UZnpkSUJTRnhNWG1tUE0wOFF0c0FHR25ZZWJJSDNEWFlOZC9a?=
 =?utf-8?B?UUdjSW1rWUROUzY3TGtrdlRRTDdsak5pUy9YM2ZFOHEyQ3NxS1hhYXR3T0dt?=
 =?utf-8?B?bGF1cU1CL1FkRWF6S2JuUWJGNnVZTjM3TW5IT1l0VUNHM3ZoR2k4aUllRkVx?=
 =?utf-8?B?VjBubHpVWWJiUFBmemVRSHpadk96NXNxQjZrYUtBTWlRK2RlZ3FXRzJwZnVQ?=
 =?utf-8?B?YU5JUkltNlNyK0xIQjJYbzdPWVhaN0p1dFE2VURBS1RQaWNqL3FITGE3QmdU?=
 =?utf-8?B?UzY1V0VPVndXN2VNeWhJdlBvbGFScDRoQndQV3NkNm5XRkV5Qml0N2ZqeU1z?=
 =?utf-8?B?MVpQb3liT2hrWHNJUjNrcm9GcC9iaTVuZklBcWYrVHZaU3hqV3NzeWRvQzZI?=
 =?utf-8?B?bENZL1BkeUZwSHRvVzJIWkkvWERRWGh6WERocVV0WFAzc2ZQTnJHR1pxS3hv?=
 =?utf-8?B?bU50Z3NvSGdDRnpubUlNbUo2cEQ5cDI3N2FRT1R5eGxGMmpsUFhQWldaN0c1?=
 =?utf-8?B?WTAycE1sak8xRlJ2RFZKZURSNW9BN216SENmLzd2NHJaSkdUQzRrVVJ1V04z?=
 =?utf-8?B?VEZZWkJCRk9SeTArNmJXM2xkN2xDOUlwYlh1aEdUdXJIWUg5Y1pPbis0MkZL?=
 =?utf-8?B?Tmd2Ymh2eUNFMzBDQWExQVdjeXI2Q2JLOUJSbVFSUVFET1Q5a0k5M2JzbHR4?=
 =?utf-8?B?WWZDU3czd1VKejlZK1pSRTVDTGRla2F6QW9GSWdYdS9tczJmZWRWV2h5d2cz?=
 =?utf-8?B?YnJ3c0RiK1A3MHFHTmZwNFE2Y3hSMHZtSWNFaFo0MVZPWWdROVVEcmtPZHRj?=
 =?utf-8?B?eUp6bXpyNDNPUCtTck1WQkYwRUYxNlorbnZtYkVSVHJISnhwU2I1UmRLZk5O?=
 =?utf-8?B?ODRNWXJST0drQThOVXNUdXBMdVJvc1oyZGFTN1NONTlueTBGaGk0d3NSTXdM?=
 =?utf-8?B?SHhrc2VPV1FzeWozeEpNQlZoaTZ0eXBNdm1KUzdscUFkamZTcW5BRUlKaHVX?=
 =?utf-8?B?NUJvWUdOZkRoUXRwNmhHZ1NENlo0MXRUMXVtdzk2cktwU1V3MGdJTXNPZGNY?=
 =?utf-8?B?YjArTDNsRlRldkQwaVNMZ0t0aXpWVERoMzdNTnNrTytwa3BlRGtZTk5MVzdl?=
 =?utf-8?B?bzRYR1dRWHJ4ZERRWXUvQno1WU1aMDh1K3Z6dkhTMFB6cTFEaElGeXR1ZGYx?=
 =?utf-8?B?Z2lMdzNsTjhZM1FLMEZ1cHArVC92cVlzcWtDUVpxdWFheHVocGNWMldGUXJu?=
 =?utf-8?B?YjZVbktZQkRONzFEVlVpMmlmSlIyQjlvcFB4eFIzM1B0ZzhvcGU5T0JHeVEw?=
 =?utf-8?B?ZUFTQm45Vnh1eVg2a2VSVGdmK2JVOEY2U1p5MmdHN1NpR3BjR2k1QUVKYWRk?=
 =?utf-8?B?TjRJS1dWd3Z4NTdGUEpET1FMQkpUMlNVbzlLZVpFVytlaU9meGlQUGNaSEUv?=
 =?utf-8?B?Z09kSWFTNEFwSU90dVdpaDMxcEJQczhRUHJKSXNvYk9SOUdmTVo2cTZYTEgw?=
 =?utf-8?B?dmxtSnNZcEdzZ0gwK0toWk0xNVFlYWR6b0lxbzlYS01YWVhJU3QxbnFzbzZO?=
 =?utf-8?B?Skt6UVhNd0tMOXpQUnlGb2tmYkdVM2RxRWdqTkNlNUJ5eG5uYmc3UFdDclU3?=
 =?utf-8?B?aUMzb3Q0NHVtakdSTElCRVF3RWR6K0o5S3RxYlpPV3BpOVpBVHdpSVltTENk?=
 =?utf-8?B?WHFlb2ZsOXpNNExHOWZzNnU4QnFLSFNPNzFGdWRSOUFMM2VhYlA3Y1c2VnFJ?=
 =?utf-8?B?Tlhicy9RazJnWWRTb2crK2U3ZTlQQllYYTJERDBRbEZLRms4RHRUMVBPdjJa?=
 =?utf-8?B?ck0va3k0SVFQcVpWb1ZzQjBucWw1VWpsRjB6emFrZmRLNUIzenRVNmlCQjht?=
 =?utf-8?B?Q0Z2WmcxcmpWNmt2dFNGK1VqMktYa010bm1pQmdkQzlPWWQzSnB5ZTBsaXRI?=
 =?utf-8?B?SVYvbnRPQ05lOVFGOTdqbGZCQzNVSWZXUDk5YTZvSmdwbWlpdXQzblpZaDk4?=
 =?utf-8?B?NUo2Skxxc3pwSTV2bklRN0lna1VseEFRelNqdnkxTmhJUFd6RFRkRmtNZ2hY?=
 =?utf-8?B?NHBsd01kdTFOb1d5Q1AvRldaVXNxMDlnY053ell2ZTdzbDFoZ1dCUHhwcFNu?=
 =?utf-8?Q?RionnVscj4G/REATNcBAgHc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663abd87-36b3-4f14-63f0-08d9fb619ee7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:58:15.0374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNSJRpK00P34A35rdgTynpx9aLqJ7AFNTIzzM/Rphcl36DT8ZL8ADQJBAMRrxbKp4byS4GkYZgdwG2XtC189og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1488
Cc: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2/28/2022 6:17 PM, Joerg Roedel wrote:
> On Mon, Feb 21, 2022 at 10:29:12AM +0530, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Add error messages to prevent silent failure.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/init.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 1eacd43cb436..770ac679b682 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -1942,9 +1942,10 @@ static int __init amd_iommu_init_pci(void)
>>  
>>  	for_each_iommu(iommu) {
>>  		ret = iommu_init_pci(iommu);
>> -		if (ret)
>> -			break;
>> -
>> +		if (ret) {
>> +			pr_err("IOMMU:%d Failed to initialize!\n", iommu->index);
> 
> Please make that message "IOMMU%d: Failed to initialize IOMMU Hardware (error=%d)!\n".

Thanks Joerg for the review. I have fixed it in v2.



> 
>> +			goto out;
>> +		}
>>  		/* Need to setup range after PCI init */
>>  		iommu_set_cwwb_range(iommu);
>>  	}
>> @@ -1960,6 +1961,10 @@ static int __init amd_iommu_init_pci(void)
>>  	 * active.
>>  	 */
>>  	ret = amd_iommu_init_api();
>> +	if (ret) {
>> +		pr_err("IOMMU: Failed to initialize api!\n");
> 
> And that "IOMMU: Failed to initialize IOMMU-API interface (error=%d)!\n"

Fixed in v2.

-Vasant

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
