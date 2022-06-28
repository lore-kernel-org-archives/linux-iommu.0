Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E5AC43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 07:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 097104050C;
	Tue, 28 Jun 2022 07:54:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 097104050C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Vn21piGG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id My-Nq-b1Z6p6; Tue, 28 Jun 2022 07:54:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1E6140374;
	Tue, 28 Jun 2022 07:54:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1E6140374
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A5C3C0032;
	Tue, 28 Jun 2022 07:54:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5829EC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 100436072A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:54:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 100436072A
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Vn21piGG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LYlqA15c0pqi for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:54:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38AED60D9C
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38AED60D9C
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1MuBUn1RPKCDd2M4ayaTLjdwXyzJql1n6HQpvxS3+Ab8qOhaIj7fc6RBjvHpQNGBNMNLY8ZbJkgqJ9lcZ0Xe87hx1NNcdS/8tOO5EB6030fjthijxywrCSrueF9mbKKEIgj9JF7m4SjLe8nZSR7FS0Rg4ajsD+mRq1tWCif5ZR4RCxQP4vkWujaSByKYvydZN6Ow26CQRSTSrkgd9y5Ga67qoMLvaWKjvjryddUj+NHaOAKkaGQZpVahZcNHqMNneMfoOtgkrWg6iOA3r2eaQ2Y7X+Qy0iGKEy5gz16OKe34Aa4uTMrRXm0Fd58k6fY3+Ho0LusXSu2/h1HdPX6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1imsx/+mT1nKwg8nC7OcMrVBOyRFhtiVAjOdM3xhv60=;
 b=cpDkh57JZNJwiauIbbhK0R2lgMT9bu582X/cvvFALcp8TTGfYqqWCxwrhrIK43OC/OSRKk0ewRHF/A2wJlcdbf/LzF/eVL6Yo2RnM9C+OjGEqZt1+0EE9mWlQsaSVAhNg2DzxZXQS4czzMCALjnpQ7yhM5l2rsJgaE+2S5SpJjJVD6r6ezbVUgsLQLnLCt0xrY7WQBYbOcY8p/CmIExTRJAul09SvSzlZJHQKemSZ1T8ffprJ7s+EF2flHYto0rKiKqdAcFb28GxNIKbrNGgTywe5aO7GtBN6tmj4ySFoGdSenImpruuD+ytXyM1rHyxRk0gk4OpYKdmzqxGs7MO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1imsx/+mT1nKwg8nC7OcMrVBOyRFhtiVAjOdM3xhv60=;
 b=Vn21piGG4rOFnRJCnmzz4eYauq0Mps0ZO0E7JxepcJevERW0X7mRGz2jIPLrho0IguoF2Dxe+GirJ8f/CHRPJunNb1yv4n1Z7MgoPs4rpn/zjk9FS38MLFjvR77bTD2N2yHPICjrHFTjbiDCa0GDU9o7vPd/67RUFMt1XbzUlAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 07:54:03 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26%9]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 07:54:03 +0000
Message-ID: <19df95e3-3598-8414-0201-1ebc30b6f159@amd.com>
Date: Tue, 28 Jun 2022 13:23:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 7/7] iommu/amd: Introduce amd_iommu_pgtable
 command-line option
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
 <20220603112107.8603-8-vasant.hegde@amd.com> <YrQgXfPWjsHvQLij@8bytes.org>
In-Reply-To: <YrQgXfPWjsHvQLij@8bytes.org>
X-ClientProxiedBy: BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20439c6a-c350-478d-8c77-08da58db5e32
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lh5KFID2t8V36Bj1J0kW5eKhv6Ai+Sy2Z3HK2rOx/MNmbihb/Ozd6tMa7F5jjdUp2EVgW6oFe2U1GSNWFPZhNVEt+3fTR2Brkq5/hKrPmmQfJm014RXZG02n4X8MQ75UgLnEhmgyCePgnB9UTWwt7sE8FsCqbe07Kw0sgKQDrS7ksPWWULIKOvqe6ZDPym2J+820NVLqssGWL7Qb4GeXFfgY36l+oLyCPdqWNmiNtQkuqzzBkfJ0Y9RycYOjb5ApKDt4R8ztbH2WBw81pPHoAaQMyxBtgq8IMLfebV+Ox7ibB+QTa2bl83rBZtpZhbYJHvm4uPQoxVrkiwv6PA+C3MMpY9h53nI3dxyEr0IoOkio9sKW6AWgt2NdG6H1eLP3+K5TTD3W4/qVKCzzpkMIk1LXGI4/5brlaTzhyVVL7bRos1ndcCxRxA6jrdYXSqjzActR08J0jXbfAPAESvGdp/ekZbxZBCsisMv/3bQD1rP5B6anKg29M+wKNRRuxdq2XZUuujKw1xPxv3tqCXjL0VZ1ZoeV2RhoLXMZPt+LWl1fy4buqIZ/jMotIJ80JnyjTBuvLgUE7ZiANrDR9Vaj1e8qT7wwHp9UhBW7ZGMjS1P8xKL9t+y4bTQvIvqokcsHezTy4ZokMR/Z6jyogNH9HMsrGtKIRuZAEQBB47vjIVbdN0NKjyUk39HVUcfmYJ+ycUb1b3xG6hH7+U8fJ5//X0Yy2mhBtzClGVIKm0mADBSzeOS6utkYMi7QkNKJxgBfYjGP0E4t/Dz/NF82A84JiQi4MgVaYnakZAu/dx0rtOQHX9yTbmihPSWNTwblLu7qV1DVb9yprT2/Pn8mskGAEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(8936002)(66556008)(36756003)(6512007)(8676002)(6486002)(26005)(66476007)(4326008)(66946007)(31696002)(5660300002)(316002)(478600001)(86362001)(6916009)(4744005)(31686004)(38100700002)(41300700001)(2906002)(6666004)(44832011)(53546011)(6506007)(186003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnZEODdYQzJsUUVKUWRPLzZlaVhjWmhkUFgrbXZGbnhRYWxFZC94SFFLUjVQ?=
 =?utf-8?B?cUpYOGw4U3NzOEdmV0RJODlWamFaSnlRVDEvSGdLTFlqNlZLZC9UMjI3OWJS?=
 =?utf-8?B?OFNiMVZQZ3BoaVlKWlFrMldtVUVhU0Q4RmFCa3dKdmZmeHBManl0K1B4SWJI?=
 =?utf-8?B?Zkl3S1g1MXMxOTlzS2hCTGJKR3BkWFNZT2FIaHFhYWhiOW1OenE2RkxRejZV?=
 =?utf-8?B?VUJabWpZOE1CTnp5NTZFVDRjejhpeFRQNHdPN2tXRTE1MmhiRzljRG83UjFW?=
 =?utf-8?B?ck45MmhTeVFPeExBWUl6QkFHaFp4dmlZeTNKcEpKS3d0aWNVV1lGcDBGZEhU?=
 =?utf-8?B?NG53Qllyd1Z3dlAvUHREMkpWYnFKOTlZVExvd1h6dERqM1FDS3hRSDcvRklD?=
 =?utf-8?B?ZEdXaWM3THRWb2VCZE5sMnJGMW1HbTBNbExlM1JVdlBudnBuQ1I3OUVPQ0pR?=
 =?utf-8?B?QmF1SXZIOG9jUUJwQjdJNVJkQTFBb2F3UkhiOU5SY2g2d21nZVdESktlQ3Uw?=
 =?utf-8?B?UWtXSUc5ZEY2Z0FXOWVnUHliMStBVnAzUVRHZFExbDBieDJBZlBNWGk3SHow?=
 =?utf-8?B?bkJhOUc1dm9WOGtranRmbEs3aHU0TGFBWDJhSWNRV1lUSUtVbXdpQSs3Y3Jj?=
 =?utf-8?B?UGhtTGh3cGZEb2dvckIxb1Rtd0F3UE1NbHdHMWdCY1N3RWZuc213YkZUeVR3?=
 =?utf-8?B?TjlTMjNDSDRyVjUxS1JnR1hCTzNmSmNLZUNLdzgxWExmZ0N6WmFHbGFyN1Zo?=
 =?utf-8?B?YmJNUEoyVXlmNU1GZDZFeFJ1ZWsvYmNRb0Q1eUtMUkJZZjR2SFNScDF5NVdz?=
 =?utf-8?B?TzBnQ3RkVXNxT1RKd1NLT1hLZkFZcTUxbWptMFJ6QnM2aUx0dlR0bVVlbmxy?=
 =?utf-8?B?eVQzaklJOXQzNGw4NEZrNGpUcnRmdHFNS0tPSDl6dDM4UE5MbmtlZkN2QlBI?=
 =?utf-8?B?Nk9CM3lBTW50MXR1aEdXQnlqQWp0dnlUOUdiaWZ3eXA4V0h5NUNHZWE5QWx2?=
 =?utf-8?B?bGdMRUdxTWduN05Pdk9MQk1EOURLV1N6VVZnWWdWY2YyQ3ExdWcvbTFOTVd3?=
 =?utf-8?B?TEgvVks4TStvYzl0OUtXOThBWDFUYUxMeXRrSmZqcWtWQ3NaWDJqQTg4M0Rz?=
 =?utf-8?B?WWJSY0RLd0VUdWNNejVKcTk2eGdGdTlFbDFGaVlHNVc1V1ZDclNwWTgvK0Rj?=
 =?utf-8?B?TGJFZ1V2VEpUVFNSeFhhdEtXMTNSWFh3UnBLdWcrMXFTZ2taUXFxS1AwWTFO?=
 =?utf-8?B?MzM4cytBUlZWb2lwb3JlN01Ld01zK2lwZkNCM29ZZ0UxMWZrVFdYNGtCZE4z?=
 =?utf-8?B?d2tjSUFnTGdxZEhZaE51Zlp2SFVKNm1xdkhmaHlHSWVoL3NkWW0vQVlyZS9p?=
 =?utf-8?B?SHJwYVlFMlNib01GOTRNRFhOU3dZc1NkaEg5QlVlSC9YLzU5T2JMbXJYMnhX?=
 =?utf-8?B?c2hoMzIxY1VUUnJZNVVJUlZFZGxiZzNpYnRubVF6clBwL3p3YmRtQm02T1Vv?=
 =?utf-8?B?dHpidUJUY1RlcFpIeGhMYXdPVUJEd2k3TGZuQVk5dEFLenNTTHU2ekFCVFE0?=
 =?utf-8?B?OWtwR290NUQybkt4czFHN2dCUExoc3E0MHR0cUt2T3cxWUdoTGYvcEFOd09F?=
 =?utf-8?B?Lzh2Zlc3c2FhMGVDR2Nzd2lXVjkvYnB4eEp6NVZBZDJiTkdXUytLb3dmbytu?=
 =?utf-8?B?M2pXM3o3SU9iK281Mjh4bFB0aW1oUkFBbXFvZ1hWbTZyR0xSV3g0WHJzclNX?=
 =?utf-8?B?N0x5aTZCaXBmZGVaNXQwTGJ4OWhvYytaYjgyUndrVCtiWVNhSVRtTXNjV3RM?=
 =?utf-8?B?b1djNlVlYVhCbVN3UG9jOFBzTnhoUkNXY21EV2ZVQlo2U0tPL0QxbUp3VTNi?=
 =?utf-8?B?U1pnWkt0Sk15bERING12Q2RteTg2a2ZYTW14R2tyUUhSazJFLzBxMlZUYjU3?=
 =?utf-8?B?aVJYczVpWlBuTXVPKy9OWjBGRFdIcGYrS2o3WjRzZXlQUUpGYk1zRXFxeVZM?=
 =?utf-8?B?cXhtckhQRWx5MEZJaDJ4aTIwSExORUxXNkhIeWhMTHMrZXV1VEwzNkRJdVUx?=
 =?utf-8?B?SysrRjNLV3g2YktwQlJkSUt1QjFuZ1AvT1dkSXFwcmdCVnJFRi9OdnBOV0V2?=
 =?utf-8?Q?DxoIzLPX37Xt8ETwwvl06bYRQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20439c6a-c350-478d-8c77-08da58db5e32
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 07:54:03.1412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaJLQRKcKhIXuAO9uPwY4ttHyNbXYrD1WU5MZtWLO7SgYaSkIWNlt2ioY+y8UZpIj8D/biJcaHZL0qBg6RPq+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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

Hi Joerg,


On 6/23/2022 1:42 PM, Joerg Roedel wrote:
> On Fri, Jun 03, 2022 at 04:51:07PM +0530, Vasant Hegde wrote:
>> +	amd_iommu_pgtable= [HW,X86-64]
>> +			Specifies one of the following AMD IOMMU page table to
>> +			be used for DMA remapping for DMA-API:
>> +			v1         - Use v1 page table (Default)
>> +			v2         - Use v2 page table
>> +
> 
> Can we handle this somehow in the amd_iommu= option? Something like
> amd_iommu=pgtbl_v2|pgtbl_v1?
> 

I think it will complicate the parsing logic. We do have `amd_iommu=off` option.
How are we going to handle `amd_iommu=off,[pgtable_v1/v2]` ? 

-Vasant
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
