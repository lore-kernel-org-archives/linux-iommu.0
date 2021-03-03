Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198A4C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 10:28:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F2664EEC
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 10:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F2664EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0382B6F5AB;
	Wed,  3 Mar 2021 10:28:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IgnmknPNoIX1; Wed,  3 Mar 2021 10:27:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0E7C6F573;
	Wed,  3 Mar 2021 10:27:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4B49C000B;
	Wed,  3 Mar 2021 10:27:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A89BAC0001;
 Wed,  3 Mar 2021 10:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 966E783A68;
 Wed,  3 Mar 2021 10:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com
 header.b="13KR/VmR"; dkim=pass (1024-bit key)
 header.d=armh.onmicrosoft.com header.b="13KR/VmR"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ak_jyXz8V-6P; Wed,  3 Mar 2021 10:27:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D1B6E83A0A;
 Wed,  3 Mar 2021 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V232EsKkFBTVpnt0R31nSNuSWOEyQtkjaMq/GSfNHjw=;
 b=13KR/VmR/G9sa9qveAKyS7rXbxdU5rHjS3NPgGkalY2Dxdnoc9//Jq8jxzghlMUgWomz+o6EHzEiFr6hayGR3+wbicksqA6ffmbNXbktFAGopRHnfRRe/eMJDO5v9rWl6KpWxru8wnIx3qjMnaLBVynl492rFvWckQVxaMdgpRM=
Received: from AS8PR04CA0177.eurprd04.prod.outlook.com (2603:10a6:20b:331::32)
 by AM6PR08MB3622.eurprd08.prod.outlook.com (2603:10a6:20b:4c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 09:55:25 +0000
Received: from VE1EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:331:cafe::27) by AS8PR04CA0177.outlook.office365.com
 (2603:10a6:20b:331::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 3 Mar 2021 09:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT020.mail.protection.outlook.com (10.152.18.242) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 09:55:24 +0000
Received: ("Tessian outbound 9eff4099a602:v71");
 Wed, 03 Mar 2021 09:55:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6a95f1a8aec8f799
X-CR-MTA-TID: 64aa7808
Received: from 7b13f9fd79ea.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 B117D26A-A390-475B-971B-BFDD1C8485DD.1; 
 Wed, 03 Mar 2021 09:55:17 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7b13f9fd79ea.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Wed, 03 Mar 2021 09:55:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W08h6SHLe9ixoo2IBkg/eTx3MV7CCHEphfQMymJtdVEuZJOkxfLUqUtj31XlNv6nhLOTIV1OziXw8tx3nnTQqcq680wIcf99BPGLfwoxl5XQq6FqV9DPOhxNBwd6ZPBDpph7NFR7ZK/BF6hHPufJESZqRwofccDaxpy+abQABE32La0aI3pVmyMVCTS1bGnlbt5ntwxUfNZEFackJqVe2uBzbpmXEItiNtayzuwpsJNHAlzeZGT48HkrIapUw+AmMxF/u4zoNbzCUDdw2LJvBhTfUm/s6vMKWl/Rtp6zJGtaf4S9wqyUGqr3EN8h63BIWVf92ImJQo6hAPjq5OYXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V232EsKkFBTVpnt0R31nSNuSWOEyQtkjaMq/GSfNHjw=;
 b=YVOHu9SCkvrpJCPReOovgcMl+ZuCmQAw4NSx//qyFNZ4GHkaMiz/l64idO4IdOvIn5CqXpiKjQxurxP5nEasULWL8aAXoL0xSKmaE8v+l869EV5sYPNa6JlorVGIPutwa/WrV1ZTOLyAsKri4XygjM5S8jEGSCOggEexRdcNtuqSQF5uMyDBVZtfznGS72R7e3TRBphRKFCrG/+WJUxdaCtQx6UgRlzofwmzdhJvcCLuwy5fEF/h6g8V7+Rk7lxiY6OXYYf34faC81pj49bTd0j6IsQ6F8MN4Fi/uVIbYIp29kM+jqnGCU7oV5M5UolqRy5iOA+1+4SzURBnZxQEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V232EsKkFBTVpnt0R31nSNuSWOEyQtkjaMq/GSfNHjw=;
 b=13KR/VmR/G9sa9qveAKyS7rXbxdU5rHjS3NPgGkalY2Dxdnoc9//Jq8jxzghlMUgWomz+o6EHzEiFr6hayGR3+wbicksqA6ffmbNXbktFAGopRHnfRRe/eMJDO5v9rWl6KpWxru8wnIx3qjMnaLBVynl492rFvWckQVxaMdgpRM=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM8PR08MB5633.eurprd08.prod.outlook.com (2603:10a6:20b:1d3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 09:55:15 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 09:55:14 +0000
Subject: Re: [PATCH 1/2] iommu: Report domain nesting info for arm-smmu-v3
To: Auger Eric <eric.auger@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org
References: <20210212105859.8445-1-vivek.gautam@arm.com>
 <20210212105859.8445-2-vivek.gautam@arm.com>
 <28c0204d-2a5e-4eb9-d869-9dbd6edab55a@redhat.com>
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <203f0aa1-e7d7-f27f-fec8-6583c0425ebd@arm.com>
Date: Wed, 3 Mar 2021 15:25:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <28c0204d-2a5e-4eb9-d869-9dbd6edab55a@redhat.com>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: BMXPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::24) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 BMXPR01CA0060.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 09:55:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0577be10-49fd-4bad-012a-08d8de2a7759
X-MS-TrafficTypeDiagnostic: AM8PR08MB5633:|AM6PR08MB3622:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3622AFD0A850492B2FCD8A9089989@AM6PR08MB3622.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: n4EigMvLDXJ66nb704v7mpKUc7HUI/iiVvPuZm3UKc7MN/JX8TuRLIBLV/kT6V+jitn7/4uqQ+4HJCMKmMJaPn0eO+PAs5JxDMJZrAVvKvTsq3Oj/2BjZyw2YiTZV33zhu6yQRqDN+5i3T/GpfLbwmPPxczLIED8Is0ZXiKiXHINRgZNYFvxSxoDc+803n9LTnfxZrJjLT0iPn6GGAKVvNIIRmd8jLnJx98c/EAbLsUUBmPTZMYQdUkbhseAAQ8eneXHvdmy02bqg+zr7SlfO+rME+kCpe7L0fhr7aWV8ySka+rgDITZ1vZLCsMwbIXRQeXL3HNeVFNkWeMMFgeYq3KCiZHJKtwnCSmsOamKVq2xLB91zY1n8CBkk9cSSNk2iKljVmQLfLkWfCKCB9lQTFQ0xdIE4MbXfEt/EA6+ULHHfxN4p8iBo/mVirGvbp+LriouyLYER7VUwbGVaLoVDRj3y2Y7p1j0BLL//kdLJtnSbM0WjHqjEin3ArOm6nEWGwL8nVWfPpm7/X02fw72sJc7eJhimdFeXjZg1cQ9xGLWZ8ZB/g2fCJZ6LCCig5Db0aCh/AljGYTJLElH856C8nXtMURSxBwiH1l5vNDQAbrg+z+DOV32HKR0GlgO9WVzHf8DxGl2KataR9aL1D6GGYbpACkevgiS8L/Ks/OKM8PNzWcbbP8jz3+5HCcY9rFq
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB3268.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(5660300002)(66476007)(66556008)(966005)(4326008)(8676002)(83380400001)(16576012)(66946007)(31686004)(316002)(956004)(31696002)(7416002)(478600001)(53546011)(2616005)(6666004)(52116002)(26005)(2906002)(186003)(36756003)(6486002)(16526019)(8936002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dmJDbGpRUlRlQURKYjJwQ2N4TUpUOVRtR3A2blBNQjJSSk9aTXFweGJDV3k5?=
 =?utf-8?B?aDJWamZzUmZLTzQ3Yi9JWHlLQkFrSE5hYnR1M0ZoUTU1dWlKVUJPN2p6VFMz?=
 =?utf-8?B?YkZnc2NreVFxWDQvUzQxWU1hT2FJaTFSVDE4M1Npa2ltOGdvN0ROUHlCQVZq?=
 =?utf-8?B?WW1JZTkvbnA4c2orRXZRTkxBSzhvTDBRbnh3c041VVBKS25WU3RZVUJ4V0pm?=
 =?utf-8?B?c3JSOGV5aW82TFFpLzdkYzdkajZwVDJYN04xVXlabVdqZWZ2djh6TTBUb0l3?=
 =?utf-8?B?UUNFdjJpSHNJSllZMWJtYlRNUXNmeWZXT2ZqWmdDLzdmZzVHMlFxaDNBajdC?=
 =?utf-8?B?UUkwcHEvUDhnTHk0YVg5TGR4N254OXExUk5jYkJ5cmQ3aENmZHBucXJaYW11?=
 =?utf-8?B?aGl3djJtMWlnaUorWjN5RXUrSFJxQ2xPZi9GaHM5UTlCbUhKS25EbTFLSE90?=
 =?utf-8?B?NmZ0T1hxVWtSY2ZmZ2Z1WXdoNWZhV2lNdnZoeW1PL1FvZHp4YVY5cks0SHVN?=
 =?utf-8?B?eXoxcXI3aU9SekxEZmpROUdtQ1ZGUlNaWUpadWlwbFpCSkU0MXNadlpYY3kw?=
 =?utf-8?B?dVdKQWx3RWwralZya0tHODF3bGQrUkN6OTZod3l1QmUzbmtWVjhnaHFJK2N5?=
 =?utf-8?B?TXgxN0l5YVJZY3BRM0xpemFRUnFkSGZlN0YvSHFZbWxtcVhRWXZPYUdjdDlK?=
 =?utf-8?B?cVROaWZYRnd1dUsxUURtOTNtT0ZoT0gwZGc3NThaNlMzNTdYTU9ZUjc2WjJy?=
 =?utf-8?B?YmZjSHpBRFhFTVA0WGdWS0NVdkg4dHRxbW5lU1JWbGhRdytaZ01aTHZraGdG?=
 =?utf-8?B?U0djK3NtbkNKc0pCZWR3d3dabi9qWUtCb3RqaFd1NGFmRjZWamExcnNsTHlZ?=
 =?utf-8?B?VXVQNXN5NWFmcjVqYUhqRkhUUGw5SnkxK0ZCY3RBam4xU1lLcUxvclU5aXBz?=
 =?utf-8?B?d1FTYmZHcG5IdnhVUHFJV1VNbjlQMFFCQnZCZmpNR0Niekk4YU44dmh2czFw?=
 =?utf-8?B?dzVrdWxDeWgyUkNkeWVRS1Y1T3VycVo1K3dMYXVMTk1vVGhOUkpvSzFQaWYz?=
 =?utf-8?B?d0lUbnlTeWlNSisyNG1rYjRGS0FtbnduMStGSjVZcndhVnVuRVppUSt0VGRp?=
 =?utf-8?B?NlMzREtLdXJJR0tqdWdFVUwyVTNvVU5oSTZRNDRLRFNFZzdQMjZVY1EwdXE5?=
 =?utf-8?B?TmRUZzY0eXQ5di91WlY1cHpTbXlsUmN4cHdVZkVDUDRlblZiWDZVV3JPaVBQ?=
 =?utf-8?B?Z2ovUndLUnM4Qk9PWHBYaVRMTXJtT3ZrRERFSGljYUFaaUlQRXlvQ2x4RHhx?=
 =?utf-8?B?Qk0vRks2OGd4R2dLbXFOeVFnaUFRVnQ1NkxYRnBwUlBDaXZ1T1d0S3FkZVhJ?=
 =?utf-8?B?RS80L0hSUVF0L0dnSVB3NFUzaVc5Z2dQbCtoOFBmQkgwZ2RtWXhPZUlmSG9q?=
 =?utf-8?B?SnkwY25FbGFZa05Qc3lWSXUvaHdmZ3lJU2grQjgwUTZtR0ZnUFh2dDFhbG5k?=
 =?utf-8?B?UGd0b0NzSEU1WUxkc1MvcDltUXVZREMySnVQL0RORGpJbkM3QXJmS0dqb053?=
 =?utf-8?B?b3FXcEMreldwQUpkNzgrOTZNdWdaTmVTL1FwVUtENGFJbkp2eUczOExpbHJ4?=
 =?utf-8?B?WWJzekdxT2ZnRWZUbzJsaG9vVktQWGFCRG0ySm9VSk1acFNKUmJzMjlISWhF?=
 =?utf-8?B?cU1wSjdrOTFBREVWRlFoSkRPbjRFZTlveS9WL3QxZ2VwZEEzM3I5ckVyRTJ5?=
 =?utf-8?Q?oFcNUvjTeBikT4FjnihzmQvPi3oq+Kg+B3v0BPe?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5633
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 889256c1-e286-431c-f764-08d8de2a70f9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QExvwvSinepvYTFhFKbHbKYv4QdbWaxfQNiS+bsXHD218WmaJX4k7j5hFIEE+mX/7MXy0xXzI3bMz2IrNBCExWiBya2EUCRkOmQAbaKgDeRWTKdbBWvFrFg6RDDVUMxL8PMh/hIbwAgd82a3AuVvDKmAGXC8bV6KgLb9hibDxIJKikejJUq4HeQ4EOFJVE+L8IHL9d9SP98oUzieKkXYnRt7S3SkeY3hD0am1kg3TVBvRR3p5N9uGQx0HUw7g9bbe15r6vtFkRKiXoH6AeDnl1tNxDjW4Lj5aQSMi0EuUPbpDhO3J/Mj4KMQlZLlmasYhUKofXZYPEsszF+Fa7H3u01qdb/mSvA135p1nVxuimvYFRKo0ocOwK9nFCphBoU7qQo+eG3p5DJQBEnUhQwwF96cKYCZ+P+eEX/KNaVVkvX5Qmca5czUq5oipyXDzX7+8zmJgNnmF0qfVgCTh30XsR3JRQMmgD5yO4ltWaz+5cxvQ5u/xRCHLJVM8+ohvNbNmxbolYtZmevzgOzvIOsu4+IU4qItM4CtdRY70bvM7Hf0xmvYWpj4/LA8G2SmcKNU4ZaRV2E2ZDMmrpZq+9bQtzl5t6i/4F9FYeeYrApfru5SQxsQOgIma/hdUzZ/nraHPxHbjmitq7S3X6wQ1G2QffKzBOQuMopv8Qvc2GipbvWAYEXNOtP9fcsCUW18rwGYAJKkeZjFCJUOchap1srRJbANivUmrTaQ5VyuX8x6rI18JKz4a5xxkEqBs8jHBxnan/VFrzuqoeEvuo3QpwJ+bA==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(356005)(16576012)(5660300002)(478600001)(2906002)(36860700001)(47076005)(81166007)(4326008)(316002)(36756003)(956004)(450100002)(107886003)(336012)(2616005)(83380400001)(31696002)(6486002)(82310400003)(186003)(53546011)(26005)(70586007)(70206006)(966005)(82740400003)(86362001)(8936002)(8676002)(31686004)(16526019)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 09:55:24.3530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0577be10-49fd-4bad-012a-08d8de2a7759
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3622
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, alex.williamson@redhat.com, robin.murphy@arm.com
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

Hi Eric,


On 2/12/21 11:43 PM, Auger Eric wrote:
> Hi Vivek,
> On 2/12/21 11:58 AM, Vivek Gautam wrote:
>> Add a vendor specific structure for domain nesting info for
>> arm smmu-v3, and necessary info fields required to populate
>> stage1 page tables.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>> ---
>>   include/uapi/linux/iommu.h | 31 +++++++++++++++++++++++++------
>>   1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> index 4d3d988fa353..5f059bcf7720 100644
>> --- a/include/uapi/linux/iommu.h
>> +++ b/include/uapi/linux/iommu.h
>> @@ -323,7 +323,8 @@ struct iommu_gpasid_bind_data {
>>   #define IOMMU_GPASID_BIND_VERSION_1	1
>>   	__u32 version;
>>   #define IOMMU_PASID_FORMAT_INTEL_VTD	1
>> -#define IOMMU_PASID_FORMAT_LAST		2
>> +#define IOMMU_PASID_FORMAT_ARM_SMMU_V3	2
>> +#define IOMMU_PASID_FORMAT_LAST		3
>>   	__u32 format;
>>   	__u32 addr_width;
>>   #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
>> @@ -409,6 +410,21 @@ struct iommu_nesting_info_vtd {
>>   	__u64	ecap_reg;
>>   };
>>   
>> +/*
>> + * struct iommu_nesting_info_arm_smmuv3 - Arm SMMU-v3 nesting info.
>> + */
>> +struct iommu_nesting_info_arm_smmuv3 {
>> +	__u32	flags;
>> +	__u16	asid_bits;
>> +
>> +	/* Arm LPAE page table format as per kernel */
>> +#define ARM_PGTBL_32_LPAE_S1		(0x0)
>> +#define ARM_PGTBL_64_LPAE_S1		(0x2)

Thanks for reviewing and I am terribly sorry for coming to it with delay.

> Shouldn't it be a bitfield instead as both can be supported (the actual
> driver only supports 64b table format though). Does it match matches
> IDR0.TTF?

Yes, it should be a bitfield rather, and it doesn't match with IDR0.TTF. 
This is
  to hint the stage1 table allocations from viommu.
  Please see viommu_setup_pgtable() in the patch at [1].

>> +	__u8	pgtbl_fmt;
> So I understand this API is supposed to allow VFIO to expose those info
> early enough to the userspace to help configuring the viommu and avoid
> errors later on. I wonder how far we want to go on this path. What about
> those other caps that impact the STE/CD validity. There may be others...
> 
> SMMU_IDR0.CD2L (support of 2 stage CD)
> SMMU_IDR0.TTENDIAN (endianness)
> SMMU_IDR0.HTTU (if 0 forbids HA/HD setting in the CD)
> SMMU_IDR3.STT (impacts T0SZ)

Right. The idea was to start with a minimal set of configuration.

But as you rightly pointed out we need a scalable solution to this problem

for arm-smmu-v3. I am now thinking if we could even use the nesting_info

for arm. We don't want to end up adding flags for all the feature bits.

Let me know if you have any suggestions.

Best regards
Vivek

[1] 
https://lore.kernel.org/linux-arm-kernel/20210115121342.15093-14-vivek.gautam@arm.com/

[snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
