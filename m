Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599DDC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 09:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9382741CDD;
	Wed, 22 Jun 2022 09:59:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9382741CDD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xGz0sueF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8bRshi8o941U; Wed, 22 Jun 2022 09:59:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F293442403;
	Wed, 22 Jun 2022 09:59:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F293442403
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1768C0032;
	Wed, 22 Jun 2022 09:59:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67A9AC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97FC8844FA
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:59:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97FC8844FA
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=xGz0sueF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l-53FwKIOxsB for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 09:59:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EA1A844DA
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EA1A844DA
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 09:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzzQdRA8KwbNkeRo9LK70jcOkwtLyvSJuzH5Iw7mjumezecpMEbywcD5DAN8dJnE/H1V3+IVdy6fmw8t/EveXSnfiZ2mVO/v5q0J3lSp4kw1yK0VyJBjGKuR6z33RxjB7EuY6RLdhvL8edF61LWcJxLQl2XjVfJ4jHLfTnkzE7otxrUAyUC6slG0sGLdHyXzZvqvj8RK1qklq9SDKkBvIhv4WouF5Xk8tK4BOve0aHg9MZlAVDs1XROgV7unWT4rBfTzrcduEcocesFe/TZWuf5cbAwEUmRo6iuq2LFrxVYhK3opahx8FVpnu8qP4fMjqvxB5kiDr+hitM8Tb+Rp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdfVSjypSNG6tGhMldOttV/FVnyimtk+hSQvx3Id+O8=;
 b=XleovYk0uH0VtKc3CnkcuI/YbwzBvJFl5pfEsHVFr1xXD8atT5Zt4MO9Xr5mSDUiek1bEARj9NzrGp4ks7R/NKxUFz2CKufmYxKdA9alOPSCTOQb1sbaw3wPp8GsjMtRPY9WagX/7MercZF07sJ3wQYeWJ6Qj1JkKy3V0UuPdaxnrDn131k5Zhvu4ui1rBtyQSLX5J5+8tgOCiI/PIMGQo/fr3Yb+8FWhJ4vpqMyQu0D9E8A9KX5wzTMaH27/pHbhrQIBDFPfZQj0cqQ92B5lu34+vLpQEPXc/xGk8cV5jvAZQEbzsCI6fqAKS73lnev4p+9NwuaC+mVnIWc4HzbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdfVSjypSNG6tGhMldOttV/FVnyimtk+hSQvx3Id+O8=;
 b=xGz0sueFLd9t5TW2j///WJwUZ2mfF/vROLa6jwqDFCyPkcBu2tLh2uuJ66wrZFBv70EDPAmc0L53XIktJXZOEIlf26Bmc+Z9WlLNpYSoSYBkUwvKFZBCu6Nccp9EYFY+GyKAz9E0KLCsDhsPtx6GvYMMvM+BWBuwo4AkYw75Jkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB3828.namprd12.prod.outlook.com (2603:10b6:a03:1a4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 09:59:48 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26%9]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 09:59:48 +0000
Message-ID: <0a006487-6cee-21ae-1768-056d12d8dee1@amd.com>
Date: Wed, 22 Jun 2022 15:29:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 00/35] iommu/amd: Add multiple PCI segments support
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
 <3b3b668f-64e1-1713-9126-59c7313bd894@amd.com> <YodnVsHH8B6ypep0@8bytes.org>
 <b4fc189c-f5f6-b1c3-4ad8-5cd07b4a34b8@amd.com>
 <eef9b8c4-7227-5adf-643d-45ed075e39b8@amd.com>
In-Reply-To: <eef9b8c4-7227-5adf-643d-45ed075e39b8@amd.com>
X-ClientProxiedBy: PN3PR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1461b36-91e7-4b60-4cd0-08da5435f122
X-MS-TrafficTypeDiagnostic: BY5PR12MB3828:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38286FD142179B3629300ECD87B29@BY5PR12MB3828.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBaC4JeDNftbFu3zv/gcOsgg3p00uEMkuyLTZchAqqL3sdTsvkmk7wboigL9f8TX+OMdOEpu18IkgCthCBdkDKACdSr6Lb51KJrX8DGVueI//a6FlgIEmOocKyDGt1wGC5yEVvlnwJhpcz2XnGKGbuLBlGn8LZ9aRRuFG6vGZG2RvyUKBmUWUvTg6mOgZbngkeNNJwGuL5qtMFBM9nih6iEWOh2Ggu/VsxQXY215fOaMP4Gdz4/ZHkpVncHAK5bnwQBh9x0In+XLYDqchzt/ujPhMXJZ+gIIFX5DzhlgeCefR/PBarH644SHXw192HUeUu+eO2krEA7sLaN/u0VgXDZv3KNW1xSG0SY9WCWU0PeULHuqBnkXOPnVlwQKgFhlJTI5A1GzfHn9Ud0Hgwy78IJHGuiiswZvLF0KgyhZHIv5MN2wmZo8HfIsYrzOkCgfjuZzCt13hniHe33WQkzZANV9BLo4X4/azUUWj0gGQ9SgjHGCCIddlU2ayWabzTfdrmgtmrldnYp9Eu74ekfEPl74Njf7GGcREomy/7ACjK3vLMmCecGbe11hvegbCqANhpNHAyDYdUIMR9JM7ro4Or7xohVl4CS8t/AWmCZj1NpuOewFkl7tcpf2WOX8N9NogKdhQ2qM4JzY2wvsBlCnMUGozyi6XLSSUi+uSgR/Gp2m8P3YVafH/GGSCEmlW+TyfIXrt6IEJdpbnPz4mIQ1Uvmv9ADv0xDib6XAv7fXhZzfa0zJWyetcSgtXNpdJjxpN3sIvQCSP8BICa4azh5xEmd7Y/utweo1osFmU0Pv82k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(66946007)(41300700001)(8936002)(186003)(26005)(5660300002)(83380400001)(6512007)(6666004)(4326008)(8676002)(53546011)(66556008)(66476007)(6506007)(31686004)(6486002)(36756003)(44832011)(86362001)(316002)(2616005)(478600001)(4744005)(2906002)(31696002)(6916009)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjIwS3RKRUVjYVEyTERKcDVPdHIvUUZ0alRzalhJV3hDWjRBbWdnUDV1T0Qz?=
 =?utf-8?B?aWRtYW5IRVhoR1FVZ3lkSmw0RDhKWGI3dVY5dVVFU1FMS1Q0ZkNtQUFGamND?=
 =?utf-8?B?WmFGQTA0eHF2QzY1alBUd2c1L1lCaTVwWUE2cE1idFBQeHV1QXZnM3EwUlBK?=
 =?utf-8?B?M1dLRUFNUWNlWGtSMy9CWUxNSTJXb2pQZU9mbFlpR1VnZlR6dFJGWWNXL2RI?=
 =?utf-8?B?Zi9nR1I5aGdEZ01TRFE3cVhZMVJpVkl6RDNGNUFGL0RHTHhURGY4U1EvWEdL?=
 =?utf-8?B?WS9KS1A1b0RyODdxNWFhMy9xY1RJYVdpa0VnMFQyVnZoOHFqSzFSTzlpbTRy?=
 =?utf-8?B?QXF5eWZnb1g0dkhndU84THlIb1NtSWQ5bjBhNmJNVUtweFNEZzhFNG9iN1R1?=
 =?utf-8?B?L2RNSlhzOHpyWFJ1ZVA2d0xBQTBMVlpQSTlESEVUZ29yaEd3ZUxNM3VxS1lE?=
 =?utf-8?B?TlF3dGpXaVlGemk2OFhzclQzQ3NsVDdkL2Z2VE9PdmFBM3dXaTk5NEtVK2Fl?=
 =?utf-8?B?VmFESzdnZEJ1bUtqOHRLT0k2OURyWEczaGx0R3FTOVBCZm5aaDUvRUQ5cjNL?=
 =?utf-8?B?N0pLWDZBck5yOU5GNmtsNDBvVkRQVjBOai83WFNneW1ZMUhOL3k2UWhHelFv?=
 =?utf-8?B?WGw4ZkN2OFN2Y205SGVxdExONTJsMFc4Qm5Gam1hNkdWc1FrUzcvdXR0N3Zu?=
 =?utf-8?B?cmNOQ0JoNWdlWU1yQ3lWYkZzUm9iaWNJSjBZTnZ5WFZaRHFBdm94ZFE0RU56?=
 =?utf-8?B?YjNjcHo5d2l4eHpkakMra2Q1WklEcDkxZ0dqU0QwR2ZHWDkxWGcvLzkrN2dV?=
 =?utf-8?B?UDc5NTBLM0xXNkpIV25SaEZUQnlSbFZoTGEvQ0F0WlN1RE5qWTBBQjhsUjV0?=
 =?utf-8?B?bStheWFjcFNJQjgyaGRScS80MStvQStWREJCYytZQmFzUHQvZkNOcWphQnVa?=
 =?utf-8?B?Ry9ZR2RXZWM5QU5teGYwZ1RVSndrcW90c0tlcmc0RFdtQkpGemVFSXVsaWNX?=
 =?utf-8?B?NlVRK3VyTnB1cWpidFJHK2FSOXA2OEV0VlluaTJxV2ttNFVIQWRRU0tSR08z?=
 =?utf-8?B?bWxGdmpxOVJOVUlzK2U5T0Rkc2t6bnl3MHlMcktnMFl3b2Y3dEszakF1V3du?=
 =?utf-8?B?OFNydU9MMGRqR1lzQUJyd3lUTEJ3dHV4cXBOVHI0aXR6UnZOVkk0UTZEK2ZB?=
 =?utf-8?B?Zmg2cERkZEYzS01GaEVRNjFSVzM3K0NaMXh1NVZOYUVWa1lHUDBzZE1rNVVV?=
 =?utf-8?B?TXJzY2t5N0NCbGNybm1lWDZmeklzaWRQKzk5d2hMNlAyZVlXeDdsUU9kNVlW?=
 =?utf-8?B?Y0hENkNOTjdxd3pzWjI2SERhdGZsU3R1RU9FQVMybHBzdTBGMjVnOUs4dFV6?=
 =?utf-8?B?ZDduMFpaSDRMRHo0czd6OFhOaWM2b2dZU0FvbXZHakd4bUYvQkk3cTl2WnJN?=
 =?utf-8?B?eFd5N0hWVDFRTUw5R2N5TzR5RURqUnhkQ2o3M2Jta1AwckJmSzdJK0VTbk5x?=
 =?utf-8?B?MmFvN1kyK3ZHTHo4K2tJTnlBL1FpUTFRZnVrU2x4WVYyc2RsVHVLaTJuN2ZN?=
 =?utf-8?B?T0tnOXRrTE5ScGMrVHY3VlVMWEpMcS9nS1AyRkt6VlFxUEsvd0U3Nk5pbjFk?=
 =?utf-8?B?UTAydlFPODE3Yjd3eklGK3BMMXd6bXY4MnFtTHFQM2RpOHlvSmtOTGIwUmpW?=
 =?utf-8?B?Z0Rad2hHK2JPUG1pZ3BJZk4vcFlJT0xQM21HeUdEN0RuL1VidnByYXhESHFE?=
 =?utf-8?B?eHdWY3l0dTNNUmNlUlZtaStGUXhQRlpCWWExeitjTjlTazJ1M1Nsbnh5OVMv?=
 =?utf-8?B?aXpQcWx2L2gxVTFPSnN2UjJPckgvVnFRMjc5YmVlMlFjTlZDVWlOQmE5VlZ2?=
 =?utf-8?B?SlczWkE1REdES1RUMkkxSFZMYUZLcWNpZG1jMkhSdlBNSEZmSk1BNEpkVW9n?=
 =?utf-8?B?cnhKR1dwdTBhcHBhMTNxcnJGdkZPT3F5eE9pOFpJTTBJTVI1WUxRZXNqdGpz?=
 =?utf-8?B?M0h0YXRiTnd3TGM1MnZIMzRjSW83SWIzZFo0Qm1hRVBtZFNBeTB0WFJSWkJh?=
 =?utf-8?B?bEVyZmNHWjIvZE9YSVpCeHlxSWZHNWlIQUdmMnJTV09jL3djMnc0djVjc2JF?=
 =?utf-8?B?NUdYZENmd1hnOWlOMTRuKzRWcDlvYlpmS2JHUjd0MHU4NXFMWTFaWXBjUlcw?=
 =?utf-8?B?TW9TYmk1OE9KMXc5ZjVaQ0NWY0RnVzlmMW9vNzBqNUdiK25UT25uOFR6Z2k0?=
 =?utf-8?B?d2E2SkQ1Nmtaay9UTzVIdnJ2NXNvVWkzZkErY3NYM3duSzZ2WlpTTURrMDBJ?=
 =?utf-8?B?NVV0Y1oxdEVuVmtvUW5vUUJGaWltb3FtcnBJa2YrOUhrTnZHcDdhUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1461b36-91e7-4b60-4cd0-08da5435f122
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 09:59:48.5340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkUChbABjB06F5O876/SMK4bwvaGrKHYT5k/Y6i3Nuj6vwvAawEHsJnbcpHShLznSCRiWnA7UZoJUlHDRMYX/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3828
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

On 6/7/2022 4:17 PM, Vasant Hegde wrote:
> Hello Joerg,
> 
> 
> On 5/20/2022 5:42 PM, Vasant Hegde wrote:
>> Joerg,
>>
>>
>> On 5/20/2022 3:33 PM, Joerg Roedel wrote:
>>> Hi Vasant,
>>>
>>> On Fri, May 20, 2022 at 03:25:38PM +0530, Vasant Hegde wrote:
>>>> Ping. Did you get a chance to look into this series?
>>>
>>> Sorry, too late for this round. The changes are pretty invasive and
>>> merging them at -rc7 stage would not give them enough testing before
>>> being merged. Please send me a reminder after the next merge window.
>>
>> Sure. I will remind you after v5.19 merge window closes.
> 
> Ping. Can you please take a look of this series?
> Do you want me to rebase patchset on to of v5.19-rc1 -OR- latest iommu/next branch?
> 

Ping?

-Vasant
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
