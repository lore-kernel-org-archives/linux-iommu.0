Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C99C433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 10:34:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25CE64E65
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 10:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25CE64E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A6C4D873A0;
	Fri, 12 Feb 2021 10:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c-x22k-zViUz; Fri, 12 Feb 2021 10:34:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 83BBD873F1;
	Fri, 12 Feb 2021 10:34:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7217CC0174;
	Fri, 12 Feb 2021 10:34:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4669CC013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 10:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 41ABF84177
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 10:34:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58_zEJw71pVY for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 10:34:16 +0000 (UTC)
X-Greylist: delayed 00:15:54 by SQLgrey-1.7.6
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30055.outbound.protection.outlook.com [40.107.3.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C1D6285F8F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa8nKtxZn8hFAaTBZsj3WR27nA+is46V5zQmG51N+xw=;
 b=dA+0J71kh4u3wpZXmltxcONGeujLABdBSDWR8sLdGrLqfQqs05G4gxF/HRaMMxMSQ9GS9veKSBBZIYmXvrBT0xqKCRLteCYa1Q2xD8rlR1lJo5C9M2rDr44S7UO0B2vOe5OhfTde8NaRXbsSzRTTl+w9bzTO/fO/kU/eDEMi17Q=
Received: from AM6P195CA0100.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::41)
 by VE1PR08MB5581.eurprd08.prod.outlook.com (2603:10a6:800:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 12 Feb
 2021 10:18:18 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:86:cafe::91) by AM6P195CA0100.outlook.office365.com
 (2603:10a6:209:86::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26 via Frontend
 Transport; Fri, 12 Feb 2021 10:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 10:18:16 +0000
Received: ("Tessian outbound af289585f0f4:v71");
 Fri, 12 Feb 2021 10:18:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fb035c4c1db6b764
X-CR-MTA-TID: 64aa7808
Received: from 5976346a1a89.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 E08BDC85-762A-452F-898C-66E0A42570FB.1; 
 Fri, 12 Feb 2021 10:18:10 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5976346a1a89.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Fri, 12 Feb 2021 10:18:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwNexPvpjPIinrKLCnBpg/qYemHAMOnvcJh6NKb7wTme89v2K1L0lG0o/m7SZlnER1zLfPM3UTlnuEoUSAzCaIY+Y9dvg0aRbaRe271IlbIEiwXmkVoFbdrclNsoUHe47snc8DTG9/v0fjt4+A3jmcuGKCtcSnbzX7zDo2sq89F/wJQAzWWR3hAkFQ4rWm+gJsAb3CETUUf7sk1GleKegrkpV1hDqFAnhveaM6j//WskMx6vRnxn2LweEFQTaC9ZlzgehY8O9XBSPTGF3SyKdXgdeutqr/dmPjyCt5HwF/Aae7QxdtMw7EiXIEvv0wZCEY5ijKCdQmbJnJYtzKSRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa8nKtxZn8hFAaTBZsj3WR27nA+is46V5zQmG51N+xw=;
 b=chqt2vTFLpG7/y37CnwKCafg0FqJ1RaZOb9JHOaMzNzTThPiI+wKYMj245Lo00m6lCg+uC0Ku8jvd161HpZ3bX96yu8VvQ/ACYZtiZW2+3dYlhWWFuXRPg1R4XvoD9xvODKTzwm67AB/y6lenQR/BFEez0Zv0T4I3rrwcFpiID+ICcj+wzPEgx0RVPQ1T60M2oEHCZV/rmbtd95bBtsE9QMcmnSGwqUEWD/SnFFs9yjYZF0VOuPfqoUgZRxzSycxSCjFSC45LOdpFz1LNpmu533tkgOJZ+ir4TH7TQn7EGRrFSKcGEbZluwjc5GUrnCWMJmzNVzvZnWIj75P6JP//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa8nKtxZn8hFAaTBZsj3WR27nA+is46V5zQmG51N+xw=;
 b=dA+0J71kh4u3wpZXmltxcONGeujLABdBSDWR8sLdGrLqfQqs05G4gxF/HRaMMxMSQ9GS9veKSBBZIYmXvrBT0xqKCRLteCYa1Q2xD8rlR1lJo5C9M2rDr44S7UO0B2vOe5OhfTde8NaRXbsSzRTTl+w9bzTO/fO/kU/eDEMi17Q=
Authentication-Results-Original: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM4PR08MB2882.eurprd08.prod.outlook.com (2603:10a6:205:c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Fri, 12 Feb
 2021 10:18:09 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3846.028; Fri, 12 Feb 2021
 10:18:08 +0000
Subject: Re: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
To: Auger Eric <eric.auger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-3-git-send-email-yi.l.liu@intel.com>
 <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
 <DM5PR11MB14356D5688CA7DC346AA32DBC3AA0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <CAFp+6iEnh6Tce26F0RHYCrQfiHrkf-W3_tXpx+ysGiQz6AWpEw@mail.gmail.com>
 <DM5PR11MB1435D9ED79B2BE9C8F235428C3A90@DM5PR11MB1435.namprd11.prod.outlook.com>
 <6bcd5229-9cd3-a78c-ccb2-be92f2add373@redhat.com>
 <DM5PR11MB143531EA8BD997A18F0A7671C3BF9@DM5PR11MB1435.namprd11.prod.outlook.com>
 <CAFp+6iGZZ9fANN_0-NFb31kHfiytD5=vcsk1_Q8gp-_6L7xQVw@mail.gmail.com>
 <9b6d409b-266b-230a-800a-24b8e6b5cd09@redhat.com>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <306e7dd2-9eb2-0ca3-6a93-7c9aa0821ce9@arm.com>
Date: Fri, 12 Feb 2021 15:48:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <9b6d409b-266b-230a-800a-24b8e6b5cd09@redhat.com>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::25) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 PN1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend
 Transport; Fri, 12 Feb 2021 10:18:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be064acf-e154-4dee-40a9-08d8cf3f8373
X-MS-TrafficTypeDiagnostic: AM4PR08MB2882:|VE1PR08MB5581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB558177A1CEAA48268E398CE7898B9@VE1PR08MB5581.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: OSwBnga0wCJvs/DLQoJgmjw4cCRcIzhLdta/Iu5R3khAclST594rGq7hnGiAcMlZBQhLJcwDD4D/oGuP/jeduL0YNTAvQ87fF6c1myr/PslmKuBAYswTV1sNjxdpgWAjB++MgV98k/tHpnxbIJkMj1W53ee5/AtqItOEBLrU1wLA6zCdWxW1EfG1QdHN4CSo2Hj2Rc4TFlbeAbDzePf8NnCCApf60vm24XjKgFzsWZWqpgypwwrg+dGnSpZs3GhGjuI1JoaTappnSRazvcisOAPKiCml7n0cZ3kx7qpklI7X2l+4cXZOdSMrVSnrelpglFERA9O45B/JDec+GDF2au4LgxEFKkAPxk4QauLjBFur3rPy6SY6BGaSOQwkr4gOYzE1yk4slqSTzi55XB805rGv+4R0WqFItGNGb4eNTbmt1mus1qT1ieIXf3Y1H6FKVg9Jw6S/KmTSX+8vo2HwBJrvDsJJfF6mx+l8okT83ILdya4aTfaaBu/UGvh2FjEpzRruhTTfoxyZXMP9qAguKmaSgr4+DGWkamroZnjD0HJyV77H6f0+5B/5CYaQocjeQ69IoDjueKu8dxW8vARJtsB9lNWEIS/e59hYsuTczOs=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB3268.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(31696002)(52116002)(6486002)(7416002)(5660300002)(6666004)(2616005)(316002)(31686004)(16576012)(956004)(2906002)(86362001)(110136005)(54906003)(478600001)(8936002)(53546011)(66556008)(66476007)(26005)(8676002)(186003)(4326008)(66946007)(16526019)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z1c4cjNwTkFIczFkM3hiNkZPckkyNURhUGNaYTV2TUV6ckFkOUZYNDFJN2s1?=
 =?utf-8?B?UDh0L3Brc2N6WXEzdHpseWJlUldWSzFoa1d3eXZIWkJPUE11ck93VEFNSklO?=
 =?utf-8?B?NFZ3eVEydWlrQnFQbkRMQ1I1RjkyNmtjOUEyWFI4ZUV3N1pKYmxjSEsveUhn?=
 =?utf-8?B?MHdwZ0hWYmh4Sk9vcWhzL0M0OXFrMWdTb3h5ODViQWd6YjVQNGtuZkNONFFC?=
 =?utf-8?B?TUZsMlVtMk1KdDdBcnBMdkRVUzdtS0VYMXBQcXpMNU95SUVpbGExcWxOUlRZ?=
 =?utf-8?B?TnRjSkJETUZjWktJM01YTXJqcFFSTVZRMzNYMmRyQUFsZkd4WTRJZzNtZGp6?=
 =?utf-8?B?UTR2RTFsT3lPakhwb252Y24wSzFKYVU3R3RGdGlHMmNXSzlIYlNmMzJtQ3NM?=
 =?utf-8?B?Z2oycmFwVnNlTGIxR3BUblFQMy9BTEg3RSsxc3B1Mzl2REdyQkdWcUE4SkxV?=
 =?utf-8?B?bU91ajJQN24yYUNFdFptY3QvaEUxYnhPazFJU2I4U0tuS3E5QzFhaURVdDlK?=
 =?utf-8?B?NHFBdXFwa0RMUnFXeW4yOGVDZG03bUlxT3Z0ZGhwVXhITkNkcFRlTGNkMXNt?=
 =?utf-8?B?U040T2xjTE9wS1YzbWNOSnNsQlNZV0paOE5UWWp1bGNzZnpZM2R6K1FsU3li?=
 =?utf-8?B?alhidVM5TTJTOXprRjl3Rzd5cC94d2o0L284OTdaUjBYK0d5bGZwbVJvQnND?=
 =?utf-8?B?MEswSlVEM09lQmdQek9UMEJxUVFFaitnQktMS085N1JkelZJRzN2TVpxcTRs?=
 =?utf-8?B?NDN3bWdES25Pdk9SdGp0bkxlOWsrSUpBK1VKNUdXVTFCL3N2SmJVaU02akFN?=
 =?utf-8?B?ZU1NZWpEZDdHNXhVQkNWTUlDZ2Z2Z2ZSU3kwZDg4N1BqMFdYanVPTkd4enlV?=
 =?utf-8?B?VzAwRy9nK3ZvR05JYTV1MXpjMVo3WDd3c0VqQmxVQUZXL2FrQXRSSUdDMjZ4?=
 =?utf-8?B?Q0NYdlJDZmpwYkplWm9ZTmRRaGlENks1SmdaKzkwOTFTWWYzS241ZE9vNHo1?=
 =?utf-8?B?TEtzL29QbDhvcUllZ3NjWTU2NGprZHV5L21jNDlOY0tzQ1JiSUM3eHBWNXdt?=
 =?utf-8?B?UVpuVmxuTjc5UE9oKzZjZlJ4Qy9IT2JEMUxzZFZDRXVYQ1VJeUkrN05DcEtM?=
 =?utf-8?B?akUwVmtnYW5xVDM1eExzUnIwWkdjQzR4MjliNEFYaGZCNGEvZ3oxUnlUT0lK?=
 =?utf-8?B?U1loVjhlb3JHYnV3ZGh6QUpMNFIvNWZnanZUODNBY21SYmdrMnFKMVVIZEhX?=
 =?utf-8?B?cWI2dzZFcXFrZ0dPWlZEL3o5YS90MjFFNUF1OGhPbWUrR3Z6NnI4V2h0aHd3?=
 =?utf-8?B?VUx3Mi9MN0ZiWnBoNkRtOUlRZXZFUlhZbDRRTjZvM2NWMzJDTHR2R3A1UTNS?=
 =?utf-8?B?c0k3b0R6YVJTcG1RL25Vbk1aVzg4WTlaak5FSDFGZURWY3BkM1phZHN1MDJm?=
 =?utf-8?B?S1BUcnBJK3BibDE3YlpabmFuRUE1WWRFRCtuNnhTOVAzM0h3TTZCRGQvNG01?=
 =?utf-8?B?djNRclQrTmtOVzIrbXJBaXE3dUdyZVNXbzUwOElNU29tTUc5L0Q5ZFdJS04w?=
 =?utf-8?B?bU5Cdk9GTjJtY3VScUlEdlA2VDZMdFlwZEdrSmVaTEhuOFZLT290VHlxeCtW?=
 =?utf-8?B?d3c3QVgrUGFoMzNPYld6MkdHdzhxUDR3WS9Dd29OUXRmdVlkMU9DMWtrZjc2?=
 =?utf-8?B?bU9ueE5FSWFGZ0tEcjVQOWZ6dmtMTXhKRExBM3Q4QVdFb1Znb05NZnltOFI3?=
 =?utf-8?Q?0NP2GD1B8i0dFuENpuKkT4105zck7pllIEVjrpN?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2882
Original-Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d91b85fb-4b49-43ad-e268-08d8cf3f7e80
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsMd/uXxypJYbQ5PciA/CQAZHsocJUCfcGLaiqKUmo0AUj/aso7cFYiuYb7DOouHY1ZXk5g1lshpVtSeyYzCvgfgASmsiJpsTvVWMtJQT4ahUE6HYK9ToODhcp26sXZrGXr8WSnLDHgPJ3GTYeLuGj4cmNZb04ncHtqZRAMDv8axu17XTPv063hvNcdd1i9H0FTJdkwn9Py8rtbbyyvqrUuYjtKvc0cVL0dZOnPdqaWDBXjFpMYHGOdHWmqroHJ1xEOLFv3Eqgm7RnRXqAl7Sdv635Xa6mIMV1U5gS4vBmmXRMYsUQxG1TthnOn9qXroamz4w445Wm72G0BDnwUW/JvJQ/WARPFZ2qd5lS0H/0pmV2yJWVT9VfDcOzsxSt4NTvuBzriujx8qhuqylG33q/lKBCRZwkboDDTtb26A2G/6fJ6066TD9sYzfuC+mDgBLVl31Tw1LYerF2+I9cIGvaY/5mlSYn27XmGro7j1kQkdyy902DCoJdLekElCE1tifa4foTaO8BIK9C46L8SL0D538EPgDvQquhKDOQnIaLq7W9f33lM8EBjVdZ6ofVN9jMt8Wy1O9eF/GofJDsjt7YVvopiwEFA7oiL8D/BUst4KSY1GDtGuhKC9x6dvZmHDAxIoBK6riANeIgIEIM/lREOdYeGIIFR+xiDHoi9Ado5Z+0F+Xqf+QbMm7mcXaxZv
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(478600001)(5660300002)(8936002)(36756003)(356005)(70206006)(82310400003)(47076005)(4326008)(81166007)(36860700001)(107886003)(336012)(70586007)(2906002)(316002)(82740400003)(8676002)(16576012)(956004)(6666004)(31686004)(83380400001)(6486002)(186003)(53546011)(2616005)(86362001)(16526019)(26005)(31696002)(110136005)(54906003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 10:18:16.6113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be064acf-e154-4dee-40a9-08d8cf3f8373
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5581
Cc: "Sun, Yi Y" <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, "Tian, Jun J" <jun.j.tian@intel.com>, "Wu,
 Hao" <hao.wu@intel.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgRXJpYywKCgpPbiAyLzEyLzIxIDM6MjcgUE0sIEF1Z2VyIEVyaWMgd3JvdGU6Cj4gSGkgVml2
ZWssIFlpLAo+Cj4gT24gMi8xMi8yMSA4OjE0IEFNLCBWaXZlayBHYXV0YW0gd3JvdGU6Cj4+IEhp
IFlpLAo+Pgo+Pgo+PiBPbiBTYXQsIEphbiAyMywgMjAyMSBhdCAyOjI5IFBNIExpdSwgWWkgTCA8
eWkubC5saXVAaW50ZWwuY29tPiB3cm90ZToKPj4+Cj4+PiBIaSBFcmljLAo+Pj4KPj4+PiBGcm9t
OiBBdWdlciBFcmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Cj4+Pj4gU2VudDogVHVlc2RheSwg
SmFudWFyeSAxOSwgMjAyMSA2OjAzIFBNCj4+Pj4KPj4+PiBIaSBZaSwgVml2ZWssCj4+Pj4KPj4+
IFsuLi5dCj4+Pj4+IEkgc2VlLiBJIHRoaW5rIHRoZXJlIG5lZWRzIGEgY2hhbmdlIGluIHRoZSBj
b2RlIHRoZXJlLiBTaG91bGQgYWxzbyBleHBlY3QKPj4+Pj4gYSBuZXN0aW5nX2luZm8gcmV0dXJu
ZWQgaW5zdGVhZCBvZiBhbiBpbnQgYW55bW9yZS4gQEVyaWMsIGhvdyBhYm91dCB5b3VyCj4+Pj4+
IG9waW5pb24/Cj4+Pj4+Cj4+Pj4+ICAgICAgZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9mb3Jf
ZGV2KCZ2ZGV2LT5wZGV2LT5kZXYpOwo+Pj4+PiAgICAgIHJldCA9IGlvbW11X2RvbWFpbl9nZXRf
YXR0cihkb21haW4sIERPTUFJTl9BVFRSX05FU1RJTkcsCj4+Pj4gJmluZm8pOwo+Pj4+PiAgICAg
IGlmIChyZXQgfHwgIShpbmZvLmZlYXR1cmVzICYgSU9NTVVfTkVTVElOR19GRUFUX1BBR0VfUkVT
UCkpIHsKPj4+Pj4gICAgICAgICAgICAgIC8qCj4+Pj4+ICAgICAgICAgICAgICAgKiBObyBuZWVk
IGdvIGZ1dGhlciBhcyBubyBwYWdlIHJlcXVlc3Qgc2VydmljZSBzdXBwb3J0Lgo+Pj4+PiAgICAg
ICAgICAgICAgICovCj4+Pj4+ICAgICAgICAgICAgICByZXR1cm4gMDsKPj4+Pj4gICAgICB9Cj4+
Pj4gU3VyZSBJIHRoaW5rIGl0IGlzICJqdXN0IiBhIG1hdHRlciBvZiBzeW5jaHJvIGJldHdlZW4g
dGhlIDIgc2VyaWVzLiBZaSwKPj4+Cj4+PiBleGFjdGx5Lgo+Pj4KPj4+PiBkbyB5b3UgaGF2ZSBw
bGFucyB0byByZXNwaW4gcGFydCBvZgo+Pj4+IFtQQVRDSCB2NyAwMC8xNl0gdmZpbzogZXhwb3Nl
IHZpcnR1YWwgU2hhcmVkIFZpcnR1YWwgQWRkcmVzc2luZyB0byBWTXMKPj4+PiBvciB3b3VsZCB5
b3UgYWxsb3cgbWUgdG8gZW1iZWQgdGhpcyBwYXRjaCBpbiBteSBzZXJpZXMuCj4+Pgo+Pj4gTXkg
djcgaGFzbuKAmXQgdG91Y2ggdGhlIHBycSBjaGFuZ2UgeWV0LiBTbyBJIHRoaW5rIGl0J3MgYmV0
dGVyIGZvciB5b3UgdG8KPj4+IGVtYmVkIGl0IHRvICB5b3VyIHNlcmllcy4gXl9ePj4KPj4KPj4g
Q2FuIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW4gdXBkYXRlZCBzZXJpZXMg
b2YgdGhlc2UKPj4gcGF0Y2hlcz8gSXQgd2lsbCBoZWxwIG1lIHRvIHdvcmsgd2l0aCB2aXJ0aW8t
aW9tbXUvYXJtIHNpZGUgY2hhbmdlcy4KPgo+IEFzIHBlciB0aGUgcHJldmlvdXMgZGlzY3Vzc2lv
biwgSSBwbGFuIHRvIHRha2UgdGhvc2UgMiBwYXRjaGVzIGluIG15Cj4gU01NVXYzIG5lc3RlZCBz
dGFnZSBzZXJpZXM6Cj4KPiBbUEFUQ0ggdjcgMDEvMTZdIGlvbW11OiBSZXBvcnQgZG9tYWluIG5l
c3RpbmcgaW5mbwo+IFtQQVRDSCB2NyAwMi8xNl0gaW9tbXUvc21tdTogUmVwb3J0IGVtcHR5IGRv
bWFpbiBuZXN0aW5nIGluZm8KPgo+IHdlIG5lZWQgdG8gdXBncmFkZSBib3RoIHNpbmNlIHdlIGRv
IG5vdCB3YW50IHRvIHJlcG9ydCBhbiBlbXB0eSBuZXN0aW5nCj4gaW5mbyBhbnltb3JlLCBmb3Ig
YXJtLgoKQWJzb2x1dGVseS4gTGV0IG1lIHNlbmQgdGhlIGNvdXBsZSBvZiBwYXRjaGVzIHRoYXQg
SSBoYXZlIGJlZW4gdXNpbmcsCnRoYXQgYWRkIGFybSBjb25maWd1cmF0aW9uLgoKQmVzdCByZWdh
cmRzClZpdmVrCgo+Cj4gVGhhbmtzCj4KPiBFcmljCj4+Cj4+IFRoYW5rcyAmIHJlZ2FyZHMKPj4g
Vml2ZWsKPj4KPgpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBh
bmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZp
bGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3Rp
ZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50
cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBv
ciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
