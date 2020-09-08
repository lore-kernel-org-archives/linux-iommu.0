Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA08C43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 03:38:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA78F2075A
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 03:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I0BLY64q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA78F2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6885B870D7;
	Tue,  8 Sep 2020 03:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j8stVsdfQ-jO; Tue,  8 Sep 2020 03:38:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 469A2870BE;
	Tue,  8 Sep 2020 03:38:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20F41C0859;
	Tue,  8 Sep 2020 03:38:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF48AC0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 03:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A4C5184FB1
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 03:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z7zExT08QQde for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 03:38:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B8DC884B89
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 03:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMU/fNALy6x7W2x7RXv21vohk/2WYpnxaE2UMpBE6CTXnUCGnyxIjU5GQBxMxIhRCDKbGt1TttB+XSM9BLwq4t/OXNaIOp8vyDvM4clg8AhBvVyCq6YwlAzaHUzbveQ87P8jPolU4LqWxlrz2wk1NDIOOdNxVYmAXfURyiohlNuDgLGHHKWlsvbana0ys467IKLNSUXk9tGwDGVOXpMBfFz+JY1OU+KUwiL4UxMDwHpADvURuS+FKQWCoAhaVDTjD1MzlB2QEe++8AX6aitu2ORSbUJ81HWuqHF2sDyM3DQv088LbdvaOLhFbtz1VrlXGBMoA85dIi2MkpfXVHAPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMSrwMj8TyhNgTxOcaC+9crzrDCjzGUWzJ/c76uOJ8s=;
 b=R4nsBCnZW+8fBISL1uk+csNThs97ruC1CseR8LJzAlyUaAwYMLTzrxQN5wqhoJSBPma0BUCbwIeAKm7ngW8ktEU5KkKlHk9Fd5J7XmSTcAoG691RHN8WCUovl9w14veMonQ1UdQdsZu4Z0LgW7TAWnEwEkvA6U23w/5B0O6OS7zfuk2IerW5pAcNnx+QIp1T9lmgAUEO0IexAMTyGFyTX5PY91lFwU4cAR4BmTiPJ/+sgfgRednRUEFHF2DnrZBNzccZtWRVwHAn9x3VMQHaeBHgZUxlejYcXUqd1on+X709MHNeKDXCiUHcvs4LXW2NoM3yp68f1HKg/bB6Cc4D3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMSrwMj8TyhNgTxOcaC+9crzrDCjzGUWzJ/c76uOJ8s=;
 b=I0BLY64qO+KRKESlcm19xtlp0XF2RRdxpG99a58ZQlq0+Cvu0g6/SGn7NEgZZlRSLfpjoqh2T/wpWm45JSFyUidduf26nj7n+uk41vhlus5NrF0YUk87GRrHRope9rqyU+69Zml3Czd6p0R6idPik8wPGxiI4mwComxv6uQdGxY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM6PR12MB3339.namprd12.prod.outlook.com (2603:10b6:5:119::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.17; Tue, 8 Sep 2020 03:38:16 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::a0cf:1440:da79:9df5]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::a0cf:1440:da79:9df5%7]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 03:38:16 +0000
Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Joerg Roedel <joro@8bytes.org>
References: <20200824105415.21000-1-joro@8bytes.org>
 <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
 <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828134639.GW3354@suse.de>
 <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
 <MN2PR12MB448849D3AD019749DB64A146F7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828152943.GY3354@suse.de>
 <MN2PR12MB4488BE2F12F85BDBC91E2C0CF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200904100556.GU6714@8bytes.org>
 <MN2PR12MB448843EC6D3D5B71613BEAAFF72B0@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <61776061-9f26-a3bc-9776-0d1772e2b266@amd.com>
Date: Mon, 7 Sep 2020 23:38:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <MN2PR12MB448843EC6D3D5B71613BEAAFF72B0@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::14) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Tue, 8 Sep 2020 03:38:15 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d84e3572-54f9-4580-2fd5-08d853a89efc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB333962C79DF7A65C7908327392290@DM6PR12MB3339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obq2NSmNFDZ684lM9fhsXp+cYLwKaHzcQm4N+K1gUVl3V5bX7HpXepo+9k0q28ZHzJomu8fi2xszcK8dJdWBn4/hyoFghkF8CPr5aoW2uvd0fYRObw9Mv1aIinNu/s8te9jiIVYllsstatm7fmPnr2aeCOmByuztwFZPIW3pWC2E7QiRzjNuHmZnFGamgtGCz41aLlBBCE9sf1aiwN+wfLhXTLDC/T5LrWZGcklRFcqwAmCrrb8Eov87fonVnH7kOfe9PjaNEQimLu24+jBLlI1qVdYLCuCd0jkVn4u1h1HS1UimGs8lHy0/3v1tA63zejsLy0pxg76G/t+XXIKIkGfX02zl335kGxGkpNk0tgwXSVm7AyVVmIV7aH7ZzuWQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2407.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(66556008)(8676002)(2616005)(44832011)(66476007)(956004)(66946007)(52116002)(16526019)(26005)(31696002)(53546011)(16576012)(316002)(86362001)(36756003)(186003)(6486002)(83380400001)(5660300002)(4326008)(31686004)(2906002)(478600001)(110136005)(54906003)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Oq/oPsrsWUFv+SaX85p6As3lSWrxH0DLVMTueiG7iOAKxq27MM311wdwhk5OP3XN4VovGnxMLM2TqffpPTtsxTqgJxwdXKe6OOL5bZZbhYKfZfF6l/ggPd7ZC4jD68r2SIgxDA5cx41HUgQ59ruepwMAknUHTBXXrxcitsymbbU0x4Jp7Ea3Qan7w3sbOGyY4Lc72O66AhlQprFIq1fc8iJwF6kVr846bzaPHAT0/F4ZU4bj7ZnK2WeI1b/7uGsgUd+ephgMagH97VEGCBXJB5bhEes6/m5HpQBAtdLTC9gU83N1GP9BWOYsXJuBA6LN0ISz58lNu24h1KRl4kQpFa7w+kcZT04snSd2tu4gGD6jkUeCUJKizv5V5kbmiM1jMW3tOFOSm8tmbD6RWnM8d1mKfLSngQrzmn2TnqeTCJYEyhixNwyoWzlbamIa4Sp23REHqk2tBAOk2iyYPEXQTW908CNw3gF2saZwoIz9kbm8b9rsmSjlE/PgoEoSTMxHpNj/9/5neYID/uICGCQOzyJPRYeul5PcyT4oszU+ycpDTjx9dH2GjBKbsWKRCK03p6/50/rDA2U0eIb3kEUrsx3rV36QwR3Dyf/ho4YO/jZxTtBIRWKlJ7MxTCweLESxct6vM+NNJMCrL93ow9OjBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84e3572-54f9-4580-2fd5-08d853a89efc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 03:38:16.2382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61Oy3QEPGJuyuw4zXgGlRbDOJAclzbQqfioiuYHERaYeV+HGKk4X3JNugLWjkpyyTBAGiBKr3EobNUad+/ESgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3339
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "jroedel@suse.de" <jroedel@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Am 2020-09-06 um 12:08 p.m. schrieb Deucher, Alexander:
> [AMD Official Use Only - Internal Distribution Only]
>
>> -----Original Message-----
>> From: Joerg Roedel <joro@8bytes.org>
>> Sent: Friday, September 4, 2020 6:06 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: jroedel@suse.de; Kuehling, Felix <Felix.Kuehling@amd.com>;
>> iommu@lists.linux-foundation.org; Huang, Ray <Ray.Huang@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>; Lendacky, Thomas
>> <Thomas.Lendacky@amd.com>; Suthikulpanit, Suravee
>> <Suravee.Suthikulpanit@amd.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is
>> active
>>
>> On Fri, Aug 28, 2020 at 03:47:07PM +0000, Deucher, Alexander wrote:
>>> Ah, right,  So CZ and ST are not an issue.  Raven is paired with Zen ba=
sed
>> CPUs.
>>
>> Okay, so for the Raven case, can you add code to the amdgpu driver which
>> makes it fail to initialize on Raven when SME is active? There is a glob=
al
>> checking function for that, so that shouldn't be hard to do.
>>
> Sure.  How about the attached patch?

The patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thanks,
=A0 Felix


>
> Alex
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
