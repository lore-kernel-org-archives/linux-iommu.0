Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A510C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:06:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B419461A1B
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 13:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B419461A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 79D27401CA;
	Thu, 25 Mar 2021 13:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NtotO7JI5pKY; Thu, 25 Mar 2021 13:06:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 485114016B;
	Thu, 25 Mar 2021 13:06:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C814C000D;
	Thu, 25 Mar 2021 13:06:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5BE5C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87BEF84066
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJyzUdCAOEvF for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 13:06:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 110998405D
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 13:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiP7uXGk6SpdnjHfEBLXR+nDSfTb8HG3Q10ejdhDZ9ww5Ju03pNQ8iRt4cgzOi5pQYzD61TqfidYixxnnX6UrVmtkUXZ+LehB/FHO8/EXfWip98v/ATfWqi3wymjtVAmTjxHXICXv2pb+pWUXy0/o/cTMLzbc0ETGsJ2TOoaY+iIG04Sq5UN/5/1CneTrdnjesYFV9RdbWHTXe7v/KfGT7bAvcLhB+2N+A9ZWI5h8eYkYbtU1tbPYFSk/+/N8Ld1WmqI0MV+RKmVvHkKFVxYHwJCYV9S+rLykVKw4aBWXMXRCZoAi31ESOTAgWIA5ter6r34F6wvMIBb/KLhM6OGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEDDo/jfzaynQccNMxeOsb8m7Ja4rOTcp/yQZuIX2QY=;
 b=mTJJTT8vI8Rl04rYR5QfbY83XCrkXT1Z/yySbUHB9pr1H0JRFw8meG6RGxt8UVhXCsG2aeBHgPB3r/xOx3kFWyOtQE2cW1c9eXwWCZWHd3idFckRKiHlQ0PpfAVlg7YwtueZ7rErrq+CQtzbS9zG0QYCMnBxZsRyYg5n4R6h16zn1V2wJvwOOEyUBQdSWGoarS9xFvOs4WkqgH0zjFGn8Rw+CppZb48YHaAG67uXxw1rfptsZeP+VBV+++Ux6xp7+z6iCxV6iZpwDfrVC9sbwrCUDNvXWOJWUzzjB+B+a8xXl8OqXNduiY2El68lza8EAxqCy7bcqikbQRkow/5eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEDDo/jfzaynQccNMxeOsb8m7Ja4rOTcp/yQZuIX2QY=;
 b=aKk9u7NsL4n3MAu3Oc2a41cRsGlH92VhRx0mrj/Ylmvd0aJDnFQ2VwOnsDFDJ3GzBO41WZJnqz5nGInlb8DyAyyXTEdljv5ANqP7PSzvGQoqSYUUYtK82ebRqYvAFr2EoPs7744kyQmvAkPjst17v2MrnvV9IWgxwggEYcrZuOo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 13:06:15 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 13:06:15 +0000
Subject: Re: [RFC PATCH 5/7] iommu/amd: Add support for Guest IO protection
To: Joerg Roedel <joro@8bytes.org>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
 <20210312090411.6030-6-suravee.suthikulpanit@amd.com>
 <YFNyUZg0JAgBLWwX@8bytes.org>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <ac209589-f351-d8a9-e47c-0ae622fd0b13@amd.com>
Date: Thu, 25 Mar 2021 20:06:05 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <YFNyUZg0JAgBLWwX@8bytes.org>
Content-Language: en-US
X-Originating-IP: [124.122.77.106]
X-ClientProxiedBy: KL1PR06CA0063.apcprd06.prod.outlook.com
 (2603:1096:802:14::31) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (124.122.77.106) by
 KL1PR06CA0063.apcprd06.prod.outlook.com (2603:1096:802:14::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.28 via Frontend Transport; Thu, 25 Mar 2021 13:06:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b690cc3-7f25-4ac8-9f13-08d8ef8ec5aa
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2597ECE954E86F272E208B64F3629@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dQdiUeTB8Hmsm9kivX/GuTi8r6VFyyLEYyi6rHrRJvMFNPbMMEbCU+Zcdrs+EHQ6P+hWGa5zCuyRT2RLYglt5AxxPd3LN32KAoM4dwUbISYQIwegIXVxg2L9AUSLUaRrGoqbdZRuJkYcE2wSqjhEnK753MZvf7yfTbdx6Z5EndoEV6t3gU46wdpjj7ofmHWCP6YCo+AJlBPxaTG/S/oL6boNK0GoXNVy2Dw6BWxR1WuP1EI3iULqox8x1YdmbfSiIlKPtJ4jjjmvO1dD6lCklf5W8LL52G/JHGr0+68lN/GEQiIxasnlGGBV4Z51PrNeQ4cr5qxepOKpYLywJxqCGYEVJpJp61CZ36wvp2CyQ2jti8VMGqXi1h1pbtJsMCZ4cxgxrU+gy9q2am+9Ms87N8js+2FNveOz37QvgjYgT5dxcxB1j1k27TkJFlT7FJxz/wqOD5yjQKfY8XoEBOISDEh/+vpcsAAW0hvP2r4u9x2f6MYiL6W1vtaklZL+CF+GKcRaxHrnLNfzam4b2iJVvNVC7wsConzuV/BRInSECZsygd+k5nOrwiugdqvhGHd897bgNiyk3ro8AEqz8qbghDnSlWDebOg8sAxkwn19hBwhxKhMllb/hUejIX8rFl9XkznLYpq/LS49Zu3LydJ2Nj4XVZ+GdijmUaIbmwMHEPz6KGUEfTiXHJv683PBGY3OmGoUpz7mumoBpP0ZDN0GDu4/5hKf8LNH4HXjZmVEuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(186003)(16526019)(6916009)(6512007)(31696002)(26005)(38100700001)(66946007)(316002)(66556008)(66476007)(52116002)(6506007)(36756003)(4326008)(6486002)(83380400001)(53546011)(5660300002)(8676002)(8936002)(478600001)(956004)(2616005)(44832011)(86362001)(2906002)(6666004)(4744005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MDFvRHlIdFZiaGJhaDBhU1puc1FYdVhhUHhQNHlMdWdIKzZjVHBHUFo5elEw?=
 =?utf-8?B?bXdsZDQ3TUcxZzdTNXV2RmkrSjg4ZlZXR1F1MWFNTzdweC91QlU0Tkl6aXRL?=
 =?utf-8?B?WkJNbzlSaktrOHhsMzByeUtzS01kdE91ZVA2aHQzeEM2RlZudmhoL0RkZkc5?=
 =?utf-8?B?TmRhSi82ZWdSTE9iNmVPR2o0WEREY1ZkSTRYY3hyTGNXL0s1YjBpRXdZNkpT?=
 =?utf-8?B?dU5HMTNwSWtKM1NnVXpvQWs0ajBXNlFNYnY0WFNyVVhXQVp3Ky8vR2kzazBC?=
 =?utf-8?B?MHpBMk5CdVJISE1LVHJwQi81ZmEzWEczaVprZTNCYTlqU2swSzJNaXhXQ0NU?=
 =?utf-8?B?bmg3YUl4bTJCZU15ODl2czZtaHg3bmtwQmQyL1BNQW5xNmYyL1JvQWg2N2Vp?=
 =?utf-8?B?QzlYdW9KS0lYT2hxS1Ntd0x4aXpJM2ExakNtU1I3ZlF6ckhyVG1MVkw3emxs?=
 =?utf-8?B?cVhmWkQxV3Q3RE16MWloTVFLT2hweUNJQUk4RW1NTHpoMjJ1MU10SERVVTJO?=
 =?utf-8?B?VDRqVGFWaTdRZ2RtZW9TQWRqMll5eW5tcFVDMEIrbXlmQm5KWUJOREtwUVdT?=
 =?utf-8?B?TTd0NklTTUhZZjlHK0ZNMFpPQmVFRU9FOUlmVDN0QlRIOUJiR2FIUFlGQzBP?=
 =?utf-8?B?bmduZnFjQ3pEUlFobEZkVjkvVnRPeVRHaU5KRVcvTWFmVVJSd01mbkVXUDVE?=
 =?utf-8?B?NUVqY0g0OEo1MmlORG1Ndlh6Y3NJK1JweHY5enJNdTNRcTNtYVk0VkYvSFd3?=
 =?utf-8?B?MHRBWWZCZlg5M3BMNXpSMmM5bC9waGUyaEFsR2ZyYk1yakszVWdXMVRBT3I1?=
 =?utf-8?B?OXQzMVFCS1dRUmlKZms1dUJwMlJJVi9rbFAwdk5TTlZGbDhPMmFZSGdHdDc3?=
 =?utf-8?B?M24xaVFCSjQ1S1lXUlh2Rkg3UEIrNjBNSEdEM1ErQkUvUnRmWDFpY0N5d2hU?=
 =?utf-8?B?TXR1aEZEaS9sdnliZWp2ckVFNjV2K1NuMXdPbDBJS2VjZ1hRSXB4RU9ud1hj?=
 =?utf-8?B?MGVXa0hmaGNyYm9rYkNqb2lHbTZXeEthVnhxMjNieENhZ2oxa1RhaldBTm9h?=
 =?utf-8?B?WGhRUFNJK1N3UVJnOWcyRDZ3MUZjUzZZbnBSNlBJSTFISGRkYzVmMC83dGdp?=
 =?utf-8?B?bWhaREZQcEZKQTRFMU9HTGFDMUI2c2VxZmFwYThvVE5jQTJHdWY3Q0FTbXM0?=
 =?utf-8?B?VmUzNXcvZStCbEtmcHdZbkdVNzdhTjJQeUpmOC9ZZnpPaEphQmtPcUVJREo3?=
 =?utf-8?B?Uk83S2U5YUI2cmZmZVBtWVFaWHpYaktaWUZlUEZHVThlQ2xFSWhYWDg1Q1l2?=
 =?utf-8?B?L1VYRDhrSU5WL1d1aHV4bmJQT0RoTE1nT1QrNjc3ZllDMVlVMFMwMXRZZmFL?=
 =?utf-8?B?VnNxdDdNMHVpUWQvYkdmeVYxMG1wMFRPcDlDaXZRVFUzV3lZN2J5dXBUSEIx?=
 =?utf-8?B?WWFjaW1wQmJjWGhoZFdYWDlUUVRzNUxBT2NOWnZOVTE2U2VJYmZsTE5Na25L?=
 =?utf-8?B?c0pjSDdLcEZDS29lQmYvOW1ldksxNy84OWd0aDBCRWJlRGUzNjkvcXJvUEEr?=
 =?utf-8?B?WjJhcUZmb3g5aDlBVGt5TjFtMnd0cHdueDlhMi9WbW51dzhsQ21wWUcrdTMr?=
 =?utf-8?B?elVlVERoQW9nNmtjUmRJaGNlcy9vUmF5bUxsdko1VEhEdW4rYU02OUF1cDZI?=
 =?utf-8?B?YUl1cVNBUDYvZGlialdQMm9DMlBSZEhrTjdqZndTLys0QzNuT3VPYW5qcVhz?=
 =?utf-8?Q?5jPinNjz52CY2qH2edbWdpiGqEzxNQnbCMPMQpJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b690cc3-7f25-4ac8-9f13-08d8ef8ec5aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 13:06:15.5781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wx83H/Zyk78X8yZZ0Ty3UG0JhlXRByVku5ihjWHh+U/pKYfXvzcQESpdJL/FcQ9NpCb7MtL3wPh2sFUhyAzz4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
Cc: iommu@lists.linux-foundation.org, Jon.Grimm@amd.com,
 linux-kernel@vger.kernel.org, Wei.Huang2@amd.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Joerg,

On 3/18/21 10:31 PM, Joerg Roedel wrote:
> On Fri, Mar 12, 2021 at 03:04:09AM -0600, Suravee Suthikulpanit wrote:
>> @@ -519,6 +521,7 @@ struct protection_domain {
>>   	spinlock_t lock;	/* mostly used to lock the page table*/
>>   	u16 id;			/* the domain id written to the device table */
>>   	int glx;		/* Number of levels for GCR3 table */
>> +	bool giov;		/* guest IO protection domain */
> 
> Could this be turned into a flag?
> 

Good point. I'll convert to use the protection_domain.flags.

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
