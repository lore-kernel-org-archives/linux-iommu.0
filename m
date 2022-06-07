Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9895C43334
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 10:47:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6856384322;
	Tue,  7 Jun 2022 10:47:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bANk7LIGlNAo; Tue,  7 Jun 2022 10:47:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5A2AA84311;
	Tue,  7 Jun 2022 10:47:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29515C0032;
	Tue,  7 Jun 2022 10:47:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7132BC002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 10:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D20140A06
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 10:47:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KRflJ4HSIwc0 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 10:47:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::61e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E42394036A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 10:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7HvBee1t9Usx54KrMjan/DNdg52qDiXe6/WyTjV79YOLzIeDSnxrl2qLon8it1crsZoUitJm2/bf8kBLvLAjFqHJIVwiC1FUxXV21kH+3BwtCiUTNaOU0Oo2qF8gsmZKspp18w59CVt1UceXRxYTRdcRLsgjKRVl397d12LcLNCITM0q0zTAL1uYmHvY0VZwn8rkmDM7Py8fVjPXvQC4IvgPmBnaYQOR29US05eEn3WUOkyS0Irq8QeuNYv+gMnZVQzYNiqoY3RsTa1/V9gcJ/GqFTaRlfagyRmXNq+CmLvO1eAU6JgMPyRdB1OF0GSpKYAnW6uXcJdZKRiHKEK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owP9UeGgmnssCT875v4IbqxdYmKSlCoQ3JbUTFspJbQ=;
 b=JA2/fWmFfNPfcQIOiRhRa4UWmnP89vBNfRS8LXid7crzk110ySdsbe2pdvTmTjWLIf2vK3GlqtdvQIF3ZU+GZgWyH4jJeCEE0O4HcgTl1rH8TdqU1oX/SUhU2d9Sd+0dSVRT2W145THCH9PkBhzpCzV0QjGxDo2FbzleS4cLPdzQVZq64EBBhb+Gew9Ea97iSJXWgiEdixClUKGzhcT0pjgbt+s22Uc0Uzh4QKF1tfiUMkDqIU2f9CRcCeaSBOEOJMVunNU5C4yht8rkbG9+KAnyn/YlRE8Ysp+qzo6oQe2F6XYAmSOk+iqsXmIjyHDRTh8dfYDR8coBkEaqVih5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owP9UeGgmnssCT875v4IbqxdYmKSlCoQ3JbUTFspJbQ=;
 b=Wo1TKjP8mbmwAsaC4JtUcM7iKqmH5I/f7qtbNic8fM/pUDL87obB5+fGCR/ZIlrYB4Zrb6hmz55zzHU72t900t2SfQdFzH4XzumSBiMIb2n7Pd6NZWfK1d8JDUB85mF+IcrWwDLxRKTlXDMz9INR3njluMkKAXpwsS92u2iUk/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Tue, 7 Jun 2022 10:47:46 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::84a6:480c:5f19:fc10]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::84a6:480c:5f19:fc10%7]) with mapi id 15.20.5314.012; Tue, 7 Jun 2022
 10:47:46 +0000
Message-ID: <eef9b8c4-7227-5adf-643d-45ed075e39b8@amd.com>
Date: Tue, 7 Jun 2022 16:17:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 00/35] iommu/amd: Add multiple PCI segments support
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
 <3b3b668f-64e1-1713-9126-59c7313bd894@amd.com> <YodnVsHH8B6ypep0@8bytes.org>
 <b4fc189c-f5f6-b1c3-4ad8-5cd07b4a34b8@amd.com>
In-Reply-To: <b4fc189c-f5f6-b1c3-4ad8-5cd07b4a34b8@amd.com>
X-ClientProxiedBy: PN2PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::24) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4685d71-2bcf-435c-fb6b-08da4873281b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32126FF4E8E78E2C25E2107687A59@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtNA1pGL2NCVCfealORcRO7xKZZjEO9n2o2XZQPdeDtiPM6EIWv5iNAOci6y0Sy1wFaAYBRsef82NlsctXStdfyyQnvt/QAPh/24y6Oxvmoy112uKkIeCo8Y12gTB/Tnv0IdD/HA9ED65N5+dI5B0belo3xSZXq/+oYKgsLsQ4LQGUH355aQTjSLaHfAdu65kDGR5l8q2/NlPIi61wKCuMMAX8z/ADWwAzvGPMfIomr2dAsE9VM8q5FUFIOrLFKixJIQS7w98pVi/g0AyUiIDNdE/gjaPOGYcLZjcKh/Qczn8hFH/hMJXs23fmUN3rpU/eOCJW9jz37Hc3HOkGaIh/4F4vheVmhrvddr/1L5wR07VhWiVTeBppjS0WrGFKq1wQPpGoEwJDZ7sN0T76RbAaUmxwo1jGZbUbEO1rzLrdjvgOUnjmtePb6Sj3GQyazXo9S6ZwwRgirPNJn/FRusT6VNf2xc3Lem/FAw6lD279u5KCnAEbH/X5KhJKUVLkU7SIpCOXx+t42XNnha78YMLrqTb/AG0WaJOP2UoSLqz6LcUVMeNUaPM3teGwifDYOZYPydsKIaU6dY19A4w32Fohqdgw7SPo2LYXHlFnMYTrw4xBcZkhtTwRSgLFz5SdczsJUyML8bYTcBHXDPiCEZ3rzb1WBwibLeWMuNVaZojlr1JOI4EltS6vWfV+MJc2cHEBV8Q+QqKsFTRUkbCCTscLouDrh5tRvA3WxCfvTt3/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(4326008)(316002)(4744005)(2906002)(5660300002)(31696002)(8676002)(66476007)(66556008)(66946007)(8936002)(2616005)(86362001)(44832011)(26005)(186003)(508600001)(6506007)(53546011)(38100700002)(6512007)(6486002)(6916009)(83380400001)(31686004)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3pQVzdXNXZ5Nkdyd2NLb3U3L0N5U2FFT3hQWHFuZHhlVHQvT3ZEblM2dWox?=
 =?utf-8?B?M2poblhjY1ZzOVNHamRNUS9PS09YcFY4YzJHZER1dE1pYW4wRjlIaERKaUd5?=
 =?utf-8?B?SkViK0RWSUZsSHl4NDFQSmJnWFpSVzV0ZEFnS1BXa1UvQit6T3Vuc2ZRNmJ6?=
 =?utf-8?B?WE5vK3VDSlhtemRUdEdNbyttaG1CaEYvYXhkNmI5ZzVHSDIzODB3eEErT29r?=
 =?utf-8?B?ek9DVjRranNqWEYyODNrd0s5bUV4c2s1a2xLRmMwWWNPNDlZUllQMGJ0Qk9t?=
 =?utf-8?B?UTBoeVppbnFVZTRiYUdGQ2lIVkZEMitsOFBrTG5IMDdDa1BsTTZjdjI2L3lX?=
 =?utf-8?B?VnlJVDdyU01JT0U3blc1UjZnQVliVnNaeVBZa0hWVnp4UXdjQytObURXMmVa?=
 =?utf-8?B?d3hKcU9Kd2lHUFpVeU40Wkk0L1dRbEJxbURFZDEwVVhWa2hrNnB2azNZMTVs?=
 =?utf-8?B?YmVBY1FQQ25rNDY0SURBbkphTTRSdGJpQS9sOHdDU29HdmU0c1dBUWtlN2I2?=
 =?utf-8?B?MXZEcndDSnkrODRlRlkxVHpibWxBODdCbW0yaW81RHV0TXl0L0tXNU5VckRH?=
 =?utf-8?B?WjM1a25hUzJHVGlGaVV4YVJRcEExNDlVU2djTDZRaU45Q1FrQU9YTnBGeWtN?=
 =?utf-8?B?bjdML1JFNkJWMXZlOUgxTnE0LzYybjE3MjMwdHc5QUVSQTR4TWFkLzRpVzV4?=
 =?utf-8?B?YUxFMWdrRzd2ekJHWUIwaXRIVlRJSElYcDNzZmpWVklwTjBidVp5UFBqcWcx?=
 =?utf-8?B?TmJTQStacXB3WHpqYjVCQzFjc25ISzVmT0dpTEFNWSt5RzhvUU1wN3JIamtL?=
 =?utf-8?B?SVhRYU8vQTFtYVYyNGZsb2ZJeE1peGdONjhiRmx4NEllU0Z2dXlFV3NtOEN3?=
 =?utf-8?B?YXdlWHBCbFBXWUtybmZPWDhGaW9yMytoTXh4aFNHMlJONlgwUFBFeDY0djFY?=
 =?utf-8?B?MUZQYkpoNEdNazdpejM0RVNRbGZOU01kUDJsbCsxZjJoSjEyK2NSdnBZSHBF?=
 =?utf-8?B?ZmtzZTFDN2M5Z0ZNK00zQ0pQVEZENi81YlBiM2xPb3MzYmtrd0JmNEd2Snoy?=
 =?utf-8?B?SmQ3ZXZTakNmazBreWtIV2VVOFZZM1FpMVIvOTdEUzFLUmZMOWs0NlR6SWMz?=
 =?utf-8?B?ZVk0NVJ0Njh2bmVuYW5VT1U5SnQzOWNHVEdTMFZWdWlPSmVoS2RuZlpaY3F1?=
 =?utf-8?B?VEoxamdTUGRsa2ZFUTBOZFQ1djdZdlJBQ2ZZcWVqNlNQQTg2bllGb1dQb3Js?=
 =?utf-8?B?OWJQWGIyTGc0cHFHTzVTOTlqdDhESExqb1hFeVBkTVlqaUlEcnNGMy8xN29r?=
 =?utf-8?B?U1NZdGVxcXNLYU1yUHpGTHZzTnExS0xkSG1jMk1SZVN6STJTcldjejhrc2NL?=
 =?utf-8?B?TGZsSjlTeEZWUU1WZlhyQXJYZkZDdlpIM1J3OVE5WTdHTUdyRzFUeWJFT3JK?=
 =?utf-8?B?amhHK0l2M3gzWkV4K0RuZHdzSTFEZ3BDWW8yYnN6eDVVME1kK0d1VnNlNUt5?=
 =?utf-8?B?SDFZaDY0czcrQUxNbDMzUjd5K3ZIWTlUSDRlZ3RqUVl4M1E4a0N5UlZDQlFQ?=
 =?utf-8?B?bEtDbTN3RTR1RVp1cWlhK3c3SUxWSE1SOU16YmtsdEhGdmdsVWUxS2hmcTVS?=
 =?utf-8?B?aUFlSnpEMjNRYnNDZGR6WlQwMEx1QklKL1F4bU50ekVmSGdyd3ZlS0NYTFNl?=
 =?utf-8?B?OE1VbnZCRDVGcUYxT0RGQUZuMjJmRFhsbCt3dmx0elRiRlIvTFJnMTJVbmtq?=
 =?utf-8?B?MktjN0YvcjNWRTBSV1V5OUpaT2JVaXhkblVhSzVobVdvZ25aQU41cVhGS2VB?=
 =?utf-8?B?dE1mNWF4UWxpOVJLTWp5STVwT0FIL1dydE5FWjg4R1JtVjRoZmJjRDBoNEkv?=
 =?utf-8?B?NVlMb2tqdWxLOWZXd29WTGQzOWtBeW5FZjVjMFovZzBpc2lNQnJIRm9KZXF5?=
 =?utf-8?B?anZ0WjJWTlpPVkk3djd6VVBSVjRBaXcvbllzcXBhK2NhNHltd05HWldBemVH?=
 =?utf-8?B?bGRxM0RtUUxwUGh5ankzR2hTc2Vnbm13M1pIL2ZnZ0o2STJZSHNYQlBqL1N0?=
 =?utf-8?B?N1J2SCsxcHZrMGRrVlRLaWorSndnMmQ4QTlVVG9PYVl1VVY5dU5sanpLRHVQ?=
 =?utf-8?B?SU44OG90eVEzSWc4UVVVTFlSa2FQS3JLNk9vRUxXOFNlR3duMEZhVWtOTHZF?=
 =?utf-8?B?dG9nTGl6d0ZiL3hsR0wwTlpESUJnV2Zaak1odTB4YWZxMm82YkIrcFlqSHNv?=
 =?utf-8?B?RThNRFllRDN6VTlXekpQU1dvbVBnd1JMeWdqc3BrWmZ4MCtNa1hxV3NJaEJ6?=
 =?utf-8?B?MXl5ZXI3bWZEOE1ockJVTnJCMkdwL1RJKzVaUFNXUGgxQllBZzN0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4685d71-2bcf-435c-fb6b-08da4873281b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 10:47:46.0676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJv8CZ4oqyyTdS5Mg543sz44EU+BtoFrGChjmiKLKdW20vPFae2ADA8TOIJRmX9FyZAuvqvSsUA7cAo0nOXpSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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

Hello Joerg,


On 5/20/2022 5:42 PM, Vasant Hegde wrote:
> Joerg,
> 
> 
> On 5/20/2022 3:33 PM, Joerg Roedel wrote:
>> Hi Vasant,
>>
>> On Fri, May 20, 2022 at 03:25:38PM +0530, Vasant Hegde wrote:
>>> Ping. Did you get a chance to look into this series?
>>
>> Sorry, too late for this round. The changes are pretty invasive and
>> merging them at -rc7 stage would not give them enough testing before
>> being merged. Please send me a reminder after the next merge window.
> 
> Sure. I will remind you after v5.19 merge window closes.

Ping. Can you please take a look of this series?
Do you want me to rebase patchset on to of v5.19-rc1 -OR- latest iommu/next branch?

-Vasant
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
