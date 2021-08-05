Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFFAC4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 16:26:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC88A61152
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 16:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC88A61152
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AB5360AE3;
	Thu,  5 Aug 2021 16:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VRIkcIQMn9ub; Thu,  5 Aug 2021 16:26:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2F0396065D;
	Thu,  5 Aug 2021 16:26:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0164EC0010;
	Thu,  5 Aug 2021 16:26:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C536C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F3A083AA7
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3VLhhgFyYhpe for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 16:26:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::605])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A566D83A82
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUGHmNZMDi/GnTsVkH5pZBo4V4w3YAruca0X1NRQj0iCiBoEc/0myyNybdxacuXCGrZkd7yOOMZvkeAqpds7rRXbQmZlv2BYqkMlP7mPwd2oeHDSaAj1OYj8ZCvVW2z/JjH1oFuVHxGYU0H4NUym0XhEUGGGfBwRDrsSPACePB12nRMNaxIBwIjcpeT5HRm04E9jKhq2/eqgwM1V+wTIP10BAga9H9P31/5B+Tr97PyYDZrml+LL+dzfjRAnFCP0IKswNcGZX/MmqpbrbGS+f5tEDpeRHkwVRnDdxLOr6r4AtAWxWuBjg5fJYEwNFDe4jW66zJVL9fzCDspPkuHZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acAIqdvXac+KG9Suf+rqocOWbVezFlyojWZa5zrwlNQ=;
 b=K149u9fGtFnfP/6uUUTncXuufdvtk8AfQgx9vPkgj5+EZnz6tp3Rn6QNGD9c16FQTlnDxowM5zqk2CFA0ew0HtsbVb/m3HYNoyvSrb37ymynSJpUtMiqrRKEQMwiJr3/mxkQOSXxizgA/ImO5RBbTpaaFYIMWhr8mYx3D99wQ8j6n2V0dmYUW2vVKEVxwvIXWRDlpE1vDBLNBttlDoFPcszRvyFk18SMfF82f0wgCp/u1xet1H6VDgdRFPFVi0rzkjhvJiUhVP+ftFl/TW4/haMUZpc3cunJBP3Q2wxkM9P+9KpmxPrSJDiQLc8NT725NbTckIkE3gCvpYWa0EODNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acAIqdvXac+KG9Suf+rqocOWbVezFlyojWZa5zrwlNQ=;
 b=uZQJz/yOKpU6dVx0RSgPKCOlE23S9sfltBUCvhJpMnQN8gBnO/fh4j02dbuzDQZTSw0dtaYNdNphnJpU4X2wxIXltE0dccZgFJzieH+6zqGQYOUHvbVL0mDxh9rfBsA2ci+O23NGtJxXzk4Y0Ma9QvA/NPOgagI8aiXnU8LdwJc=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.16; Thu, 5 Aug 2021 16:26:27 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1dbc:947c:2913:449b%3]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 16:26:27 +0000
Subject: Re: [PATCH v2] iommu/amd: Use report_iommu_fault()
To: Lennert Buytenhek <buytenh@wantstofly.org>
References: <YP7jbfRFxMeFONKl@wantstofly.org>
 <8cc39d3c-6086-cfe3-9743-901c51ad4bab@amd.com>
 <YQNksD4G1SS/yGM2@wantstofly.org>
Message-ID: <0d353fc0-79d0-36b7-eeee-ba27249bb258@amd.com>
Date: Thu, 5 Aug 2021 11:26:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQNksD4G1SS/yGM2@wantstofly.org>
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:806:120::27) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.65] (165.204.77.1) by
 SN7PR04CA0052.namprd04.prod.outlook.com (2603:10b6:806:120::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Thu, 5 Aug 2021 16:26:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af9809d4-2243-4dcb-b560-08d9582dc62c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5216:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5216E13F671CE25CD0754F4CF3F29@DM4PR12MB5216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oM5MnvcK9PPWaI1DGYR49o/+afG9mZ/p2r6shC9j3pwmUm+9vgCxqc1Xhu0QO8cGR0COEq9GWmvfzJcbVWrjF0uRRMdrCylm1tL5Kah4aa9rqFQOyJv7QFhaPX4FHPgogFTh+jPfit5/gEJHsykdQ+Qm7SiwwG5ebU+HjcFIupTkV6Jd/kULCESL+9T2/Gr4Ozp1v35DmIj6ki7YtJzxhD/OV90h0+5TWdwFoPftbC7lFw+u7+7I4fauppG/qMgxc/mjK3GCvYbodwVFuji8fy3DspsnCQk7QIuTOhQwZ8LG/ipGZO+hpeuKZLACvearBu3q/s9YOweA+0jmoozZnIBat28hHI3O0iLG2VXFwSz0ky1Ky2jdVzDFb3L+dWKDp8W0dswmdbdT1ngE4hjRbucrZPRQCE6TSPkP/OjihOGqAdkHNXipNWO61KLe6z1yVD089Fc2hVA+f8G4/NaR7oDs1VYl8ZSbIns4XVaZ8kU+i+a1AD4D7Ey+xeIfJs2CRYPgF0WM2L0AKM19GOL31zrWiqnhc2fqPtYMrg1+SvATzJfVZRgBFim7gMX7KFZQU4APWEUFB7S45DtXLiUsArP3zh3oxUPhMNizkzsYNF0nLCA0/mnmV0mFWCcHv1/ofHk981tAFIighWTfsGNvqAOtmV96W/OhYbFN4kmQDk8vQEl9yYuf6JSNWBemVx3u/4cEIbNimnBVH8Y2FzyJGf6NdYp3XnGbrnhwTWxt4u5J/l4aJLpFMq2/6lsK/fEazxM9Bt34ol3CDy6pE3WtVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39850400004)(31696002)(52116002)(956004)(16576012)(38100700002)(478600001)(86362001)(36756003)(38350700002)(4326008)(6486002)(316002)(2616005)(66476007)(2906002)(6916009)(66556008)(26005)(5660300002)(53546011)(66946007)(8936002)(83380400001)(186003)(31686004)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW5PR1JSckpXeERaSXpaWHFHakY5SFBBbGNQUWVONjN0Z3lyNDFmUHRHSjRN?=
 =?utf-8?B?ZUIyeGU4MVpNUFRFTCtQYThFMWZjV2svcnNZUnR1UEkyK0p1WXp6QkVYYjMx?=
 =?utf-8?B?L3kwbGEwenlOdGhvb1BaOWQ0eUFoQW1OV3pzbnRkR1Q2bWkzNVEvVVM4aFow?=
 =?utf-8?B?M08rcytZY2srMXJJZ25JTHFrbXZIbTZiUHJiU29HLzZCTmJ0eXRZNkMrVmlo?=
 =?utf-8?B?a2hHTWJxM0xZdmZZTnhVdEhkdDZCUVM2OVFNaXFOaUhSME5GVVk4VnBsZUgv?=
 =?utf-8?B?RW5ScFRKbnk1UStMSUcwRGxQM1kyRTFzM1ROSHplMWpsNHB4akRBWnY4VnUy?=
 =?utf-8?B?ajBRdVF3TlBZb1Zic0JLaG1rbTlySG1NVngwTlJMOWhoQ1ZyU2lkQ1BuaUZQ?=
 =?utf-8?B?RFV6NGpKMENZdlArUWxWU2Y1SXByWGcvUGNJSGgzUEF5Wk15bDRyL09hMjJB?=
 =?utf-8?B?NFRia2p0NHhCTEt4YnQ4ckErYzdLMEpVdEk2Q2daQjFVRWhiUkFROC9ZRHRL?=
 =?utf-8?B?YXBheE5jd3o1VGlPWExleWQ2amFuNnFTOE5zYk9wYisxWUJIMmEvbWpjZXdn?=
 =?utf-8?B?NFJUN29nUjlXaHhNcS9CVkQwaC9aM0dqOVduN0RKOU1KS3pzMlU2UFhxb1V6?=
 =?utf-8?B?QUJaSGM5amlNZVV5SnkyQTNHaTgyZWVVTDYzdXRyTUdCMlBtTmtyKzE0MGps?=
 =?utf-8?B?Rko5VkhmQTdmWmR4RVV0OU1waVQ3R0NZZHc5a0RlYmFGYkU5UTkvS0VJQ0FX?=
 =?utf-8?B?TEFkSFE0UGlrUEZTc29Qa08vbFVrZ3ZwVDFoWkd4Z3VXbVdtbzZSZTlEM0Er?=
 =?utf-8?B?b1o0emYrQ2Nxa2p1OGU5eHJKcGZpZEhHUWpWMFpkODhCL055ZzRmQmtDRVkw?=
 =?utf-8?B?eFdKMDg3cEQ5TW1QbkFvUndWclNJUGNreldjSE5PNUdnQVZHQTNJUDgrN1lx?=
 =?utf-8?B?TGtuVmtUMnVoVWxOMkxkL3d2bUM0M1RpQk1jSVBtdzZiUTViWGR1Z28zWDRt?=
 =?utf-8?B?WlhjS2FmS0F3dFlZUWVFY0oydjRpM21SVW1YTWhkMXZldGcweG5YcWVISUNZ?=
 =?utf-8?B?bmxYNzU2ZTYxQUZQSFNHckwxbmRVMkgyb2o4cG1QdTBUb1dEaDFMV1duUW9K?=
 =?utf-8?B?VEdxNmRUYVdiQ212ampMYXBXTWlKUCsvSnRLVXZtS1NzeGNjUWRYYXJLL0V3?=
 =?utf-8?B?Zk9tQTQ3anZuc214SGRaZlFXUGpSdVNDeXludW1ydWFqMGg1b1U5MTNHTDh0?=
 =?utf-8?B?bFpUSlZDdTd0R3M4Q3FpMXhLYXpqV2k4WFlyVTRBNmRWNldGdm45ZUcxaXI1?=
 =?utf-8?B?dG1Fald3TzU2ZVBEb29vb05sb0UzYTYzT3VpRHg5cml1dW1iVUNnUVRFeGdp?=
 =?utf-8?B?RlpKS0lJcjl2ME9hS1FnbmJhRzFGREVyM3AxNkwwV3c3eGliVXhhOTVtSFNs?=
 =?utf-8?B?K1RJdmk0ditubTdvN2VnTEJBSnRLeDlTOXh2ODNkczRjem1XTWZBMFpVSVNR?=
 =?utf-8?B?d24xbGk3RjRHS1N2SWV3aExxd3U4dGNEdWVOLzZsQ1ZHZno5Szk1eWh4OW0z?=
 =?utf-8?B?Mm1WMVVEY3NFYWVXTy9wSldLOGlCTTFoby8yMGZ3QWVxVk9hYk1LY3RuZ2Rm?=
 =?utf-8?B?NmNkdWpTdVlLbWN3OE1VSm5jN2M5Z28wZ1pIZ2FJMkNHdVlLdmlodWcvSTdH?=
 =?utf-8?B?ZzBCV2x0bUNnVnFZY0FZemdzd2VXczd2cWlXMUgrdGJjSWE0RDFSRUxUZjJN?=
 =?utf-8?Q?N4BGchXxS+GvxTllq/ogMLbnQvjHpYqZQsDKhxR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9809d4-2243-4dcb-b560-08d9582dc62c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 16:26:27.2531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FUMtDAk0Lc6S+lpBVOOGUCCWY5OS2a3h/DTHjjBk4J/b/qbg3vfE9/c9RUKcMTwboWUZnPGKswKc+GpGGGuGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216
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
From: "Suthikulpanit, Suravee via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Lennert,

On 7/29/2021 9:32 PM, Lennert Buytenhek wrote:
> We have three cases to handle:
> 
> - EVENT_FLAG_I set: IRQ remapping fault, don't call report_iommu_fault()
> 
> - EVENT_FLAG_I unset, but the request was a translation request
>    (EVENT_FLAG_TR set) or the target page was not present (EVENT_FLAG_PR
>    unset): call report_iommu_fault(), but the RW bit will be invalid, so
>    don't try to map it to a IOMMU_FAULT_{READ,WRITE} code

So, why do we need to call report_iommu_fault() for this case?
My understanding is we only have IOMMU_FAULT_[READ|WRITE].
So, if we can't identify whether the DMA is read / write,
we should not need to call report_iommu_fauilt(), is it?

> - EVENT_FLAG_I unset, the request is a transaction request (EVENT_FLAG_TR
>    unset) and the target page was present (EVENT_FLAG_PR set): call
>    report_iommu_fault(), and use the RW bit to set IOMMU_FAULT_{READ,WRITE}
> 
> So I don't think we can merge the test for EVENT_FLAG_I with the
> test for EVENT_FLAG_TR/EVENT_FLAG_PR.

The only condition that we would report_iommu_fault is
I=0, TR=0, PR=1, isn't it. So we should be able to just check if PR=1.


> We could do something like this, if you'd prefer:
> 
> 	#define IS_IOMMU_MEM_TRANSACTION(flags)	\
> 		(((flags) & EVENT_FLAG_I) == 0)
> 
> 	#define IS_RW_FLAG_VALID(flags)		\
> 		(((flags) & (EVENT_FLAG_TR | EVENT_FLAG_PR)) == EVENT_FLAG_PR)
> 
> 	#define IS_WRITE_REQUEST(flags)		\
> 		(IS_RW_FLAG_VALID(flags) && (flags & EVENT_FLAG_RW))
> 
> And then do something like:
> 
> 	if (dev_data && IS_IOMMU_MEM_TRANSACTION(flags)) {
> 		if (!report_iommu_fault(&dev_data->domain->domain, &pdev->dev,
> 					address,
> 					IS_WRITE_REQUEST(flags) ?
> 					IOMMU_FAULT_WRITE : IOMMU_FAULT_READ))

Actually, IS_WRITE_REQUEST() == 0 could mean:
- I=0, TR=0, PR=1 and RW=0: This is fine.
- I=0, (TR=1 or PR=0), and we should not be calling report_iommu_fault() here
   since we cannot specify READ/WRITE here.

Thanks,
Suravee

> 			goto out;
> 	}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
