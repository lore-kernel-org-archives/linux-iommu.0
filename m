Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9339C433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 11:17:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4758C64DE0
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 11:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4758C64DE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0DD5686CC9;
	Fri, 12 Feb 2021 11:17:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Rt4OsKAX7p6; Fri, 12 Feb 2021 11:17:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 482BA869FD;
	Fri, 12 Feb 2021 11:17:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A152C0891;
	Fri, 12 Feb 2021 11:17:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1D3BC013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 11:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A561086CC9
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 11:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2d4qV8g23w9v for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 11:17:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30080.outbound.protection.outlook.com [40.107.3.80])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6C894869FD
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 11:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ulmpvo6mp+m2j2y3jOyxoGfBIAnXzPgon/L9N9EgQ6o=;
 b=HTAfmC/jvPlZ10NSOyMsEUvvy9PoFuJ/RvpCjUkEXdvIcgzWESQgOlbZkuIEmPC6V2sD+xuMEpcuJKpKS6ZYOLMDfhaNtdbOwJOfKWtnrOl3dhbeHz8IhUr5t4RxAwpuPEl5imYH+SHiFnu5B76wCTT9Qi2LV7UN/ZHOsbiE2Bs=
Received: from DB7PR02CA0036.eurprd02.prod.outlook.com (2603:10a6:10:52::49)
 by AM8PR08MB6625.eurprd08.prod.outlook.com (2603:10a6:20b:357::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 12 Feb
 2021 11:02:00 +0000
Received: from DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::31) by DB7PR02CA0036.outlook.office365.com
 (2603:10a6:10:52::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Fri, 12 Feb 2021 11:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.linux-foundation.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.linux-foundation.org;
 dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT062.mail.protection.outlook.com (10.152.20.197) with
 Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 11:01:57 +0000
Received: ("Tessian outbound 4d8113405d55:v71");
 Fri, 12 Feb 2021 11:01:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d8e85971c8850f1c
X-CR-MTA-TID: 64aa7808
Received: from 16b8258593cb.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 2A316B65-6831-4FE0-9917-2B22B28962E3.1; 
 Fri, 12 Feb 2021 11:01:50 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 16b8258593cb.2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Fri, 12 Feb 2021 11:01:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW6g7L42NLnPJlSMFa/Q9+KRCDfzrj0V5tcIdpF46WDc2uYbGdYIfo9cffPS7SCln8fcnhMSCSxZ3psq8l+sOsH5HgP3imf2t+idejFU9Gy2STrOQC7PDSBzVjsv+9R+LImfar7LbAm0DcLEsZBJrmzMVdFwYN39NLUtSeknjI6hLX7DNpIW/gII89h8KdrgkbdruRTepY6mkfh9DJDAf72X54AO3ToxnBDFh0A32L1IR5gu7K0btbv1J9BlRCdrTZqQlX/+ATfOu/Hs+miL56T3AywuBv0moeMOAo2IA5xn5GavLbD3Tp0Jgwo5mLwRftTO3siklp2DANK34iiiOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ulmpvo6mp+m2j2y3jOyxoGfBIAnXzPgon/L9N9EgQ6o=;
 b=naWYCV9J0uZvXE1P5KWlPD1lFWy9B4wPibWuSWLFqL2YLpl3z37uvQDMwtzNmhx9Mzbm7AV8MOsnOic1ljJclLiPC6OESt7Ynkv9h318sSk4n+Pg5s97rdHZQvTdQ95UXMH7WHRtaq48A0CrYzclP0KKmIuqs4CymeN+Lb+BnVqlC15onkxW5ezY+kxwU9Rgpa3O8spf7jjRNiLCcFFuX6ICchpjMy68LMvFbOD/ixVFZpmtbtMzoRqEupN8UNj6u0GGJfUt9Pf9oRZSbuWg7Mdw5Ipm9hFxyVgWy1AaOYwszaJfilez2rNt2XWyWAbT89tOIIXiwynDrp2WkDrtCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ulmpvo6mp+m2j2y3jOyxoGfBIAnXzPgon/L9N9EgQ6o=;
 b=HTAfmC/jvPlZ10NSOyMsEUvvy9PoFuJ/RvpCjUkEXdvIcgzWESQgOlbZkuIEmPC6V2sD+xuMEpcuJKpKS6ZYOLMDfhaNtdbOwJOfKWtnrOl3dhbeHz8IhUr5t4RxAwpuPEl5imYH+SHiFnu5B76wCTT9Qi2LV7UN/ZHOsbiE2Bs=
Authentication-Results-Original: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM4PR08MB2785.eurprd08.prod.outlook.com (2603:10a6:205:5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 12 Feb
 2021 11:01:48 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3846.028; Fri, 12 Feb 2021
 11:01:48 +0000
Subject: Re: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
From: Vivek Kumar Gautam <vivek.gautam@arm.com>
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
 <306e7dd2-9eb2-0ca3-6a93-7c9aa0821ce9@arm.com>
Message-ID: <0f159062-98a3-ba9c-e40b-732520a1d1eb@arm.com>
Date: Fri, 12 Feb 2021 16:31:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <306e7dd2-9eb2-0ca3-6a93-7c9aa0821ce9@arm.com>
Content-Language: en-US
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: BM1PR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::29) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by
 BM1PR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:18::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend
 Transport; Fri, 12 Feb 2021 11:01:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 646bced2-2f12-4021-af38-08d8cf459dc1
X-MS-TrafficTypeDiagnostic: AM4PR08MB2785:|AM8PR08MB6625:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR08MB66255776D5E4C2CC707A24B6898B9@AM8PR08MB6625.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: AJbR/j61eptCL4+FiyeCKqfoydP0AvDR1bjKaeTI3uKGa5D/VinOz7+0YXZ/IPUqvH7s3gi6/lgMOXQi0z0jB9+Ftrb06cjdGKVWmcN7MoiOf2+ICWchXJ2b7kkNMZ4/ksfviwFgEpRwY4Yidnr1Nm2N0VzQgVdSKg9Ozye0mEScvXKBEp64+w/106Z1xyrxOLMi6wI5TiBQpgF0wHlQMpvL//pCAYEEcj9Ni7cWh5JPkFaN9u53s4OGBqPtKGYsdDdkJIl3S8o7Gb+tHqaK8NqVo1h/z4BKE4CtBXLVlwEyMiPU5FUEFhlR3CG2PlP4QH0sCRnQ8+DdFN+gh9a9DoWMLeC9syClmCbxftMGysPmteSYt0GtYbSUEsi8rvzNKDcm7hEOPFKI5v+/bpA2M0MPBQEjvpUzprZyogmeq5QK+lSa7WbEFR0WY26e0lKmfvsuQTwiaEkirjiwaXcaV4TWuvdo9Oqt2A8EVIflvd5urNqpA8rJQO+43hW4pMyNcBiRBnIVMW/osEVraOIvuXpUgRja/TYduqcGks9qzZ1Ji6tFOixCXQy+qM5ysIIJsj/czVrT4IPSjrq5idSY3ndPTD7KKRuvuk6YQVAWmJ2887epxhHpsQx+3HQujJH9sc2IHWTQxAimEH4M9z1YyqvC2PN8Fw3k42v3uG6t/MxVyPtS6UrQZUgGt9Jn4bGF
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB3268.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39840400004)(36756003)(6486002)(31696002)(31686004)(186003)(16526019)(26005)(6666004)(966005)(86362001)(478600001)(52116002)(7416002)(316002)(66946007)(54906003)(83380400001)(2906002)(110136005)(956004)(2616005)(66556008)(4326008)(66476007)(53546011)(8936002)(8676002)(16576012)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NEhKdG4xWHNha2Z5SUkrbFp2eWxXclgvYldxR21uQVFiTFRHWTNBb3FyQmp1?=
 =?utf-8?B?T1BxL3lkT0ZNWjVTNHMrd09VZ2dPZVlTS0NuQlNJVVdpek1lSkltcnZSc0xD?=
 =?utf-8?B?YUtkNno5bUhNUU9vWWRqbHJIWm9rd1dYZVhwS1BWK0xVTDEvT01CcEt2TVJh?=
 =?utf-8?B?RWgvdmV4VGkvbTVoQ2I1WHRDVy9tTzBVZENTOVl0UGJNWnFBM2lJSmk2ZU51?=
 =?utf-8?B?a0M1M1hKekxseG83UXNJaWhiNmJKNS91UFh2aUNxUkxTcDlZUC9wd25kTE16?=
 =?utf-8?B?cWxraWtqdkkyRmpKbzlGaitUajg4Q28rMjMybWd5ckg2R2dSSENMek83RGZr?=
 =?utf-8?B?SzVaRnFFR1NYNWNoNTZqTkp2WGRrZlRQZVdEVjQ5RGxWRU55YXNwTGppVnZt?=
 =?utf-8?B?L2lGMm56Z1ZWNUlaRFFKanJDRmxZRmxPT3luR29JcGpMbzZybm9VSm1YcThv?=
 =?utf-8?B?V0tPNGlPaDZrS3Z0Y1ZaSFJ4MzJlUmFZNUwwcEtjVE1pT3hDQU5hcjYrUm1y?=
 =?utf-8?B?OWNHYmtUSFhYTWpxVzhvT0tSVk91dXdyS0kzUGdpV0VPeE5tQjV6THg2bzZm?=
 =?utf-8?B?M1NIRCtGWDJPOTJUeHA3cTZKdXlFMEVSZlJ0Vko3aHozclFCbzBINFlWczNV?=
 =?utf-8?B?WWRQeHJUR1hqSjhpb3kyMWNYMFpDZ0dSdnhGMERBdkZ4M2luRzJhR0Q3WURB?=
 =?utf-8?B?YUFxN1kxVGVHQkpFbDhiYUpBcnFkMDVjT0hNajhzSzAzbnNJUHowUnE1UUFN?=
 =?utf-8?B?VFFCcmxYMWFqTFBQTzB4TGZzZ1NnNUplM2l5M2Z0eVY2TkZpdy9TTUdPUnNF?=
 =?utf-8?B?THVnZ2tmTFV3elZqSDF0c2xQT3k1R3ByQmdKa1RoNFdSMGxMSUp0OEVXUWly?=
 =?utf-8?B?QzVlc3Y3bWI1WlIrTkJYdFZuMVIrNFprVjJ4d3NBb0MzWmFIYVpmZmgzaVEv?=
 =?utf-8?B?ZG1VdlZXY25uVnRPQnpROCthcTh1RHZ5L205dnhMM09SLzNxSjhnbCtFcUd5?=
 =?utf-8?B?TU5MWGhQRllCdGtwazc4RmJGY0tSd2E2dUxXMXZGV2xSaXU2Y0JXWE5VbTVw?=
 =?utf-8?B?UGVlWXN4T1NsQ3FxU1Fmdm45Y0ZTZndHMW9xMmJoUEZkWWd6UWlpZVBVbk9N?=
 =?utf-8?B?bEJxQTJselMxOWxhVGJVTWVWdjdmZ2V3Zk9qOUF5akJvRDFpTlR1NmI1cWsy?=
 =?utf-8?B?NVl6K2dkREZEcmF5L1dBQnhDVEtSbWxZdWZvZlNzYVhEL1ViUmJueWp2ZkRi?=
 =?utf-8?B?K3lDTWU2bnZyOCs3cFVjSWdBQWJZeFNKOHJLVkNqdytoMEJ2Mk44UmlvQU5L?=
 =?utf-8?B?VWkwcjhYemlHTHlrdXZlTXdRR0hWM3VveUNoeWl5U0VoaHdKTU9VSEl4OEFW?=
 =?utf-8?B?S2NrZkpYSWNGU2FjUWZVeU9wN1B5MU5PeEhLK1N6ck5lWFRVbHNocjFaTFp0?=
 =?utf-8?B?Z29HUUorTnVZZi84VE15b3BjVEl5b1pRUW12MXl0aWovL0xsYzl6bUZFNlJ6?=
 =?utf-8?B?UmxOQmdJaTFURkZ2Z2tqQ0FMZW5VYm5qY09wTHhCenBXWi9FdU80Y2pXeVJt?=
 =?utf-8?B?MWIxS1l0NFFqc3dsU3VvRUc1bkdHUDdGckFvSnJtRStTSmc2MEtra0pUWjJQ?=
 =?utf-8?B?L0hTS1VrbUZ5V2l1WEdKZTdWTEE0R093T0JFY29RanNxR01vL1ZjUHUrZVFZ?=
 =?utf-8?B?Nk0ySmhEU1lrNTcwVjc2ZWhHMEhpTDRHaWFWV0ZXaVc3bTkwMlBoYTgwOFM5?=
 =?utf-8?Q?ucPztYoF56MpBmB36iPFBfVvaXnvhg1Psf8hI/3?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2785
Original-Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 07e83b6e-e521-4e13-1013-08d8cf4597dd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZznqzaBk3R4qDblP58xaIZKIvltoE2v+SIImZMP8hmWqCnVt/VNGosQT4T53ZKJcC5cJGRkRF6UnaKzXB0NO+s1a98+pHHmIJONV7vszBAI2PnxYcIyJ0RNhCw4p4x9Tu25FoY5wViB6gxBhyhGXBbWCgzVu/hNF15B8huEgCFrt991bsqRGgPzaPgypZs0U9of37jZaMbWM4EWZFRhhTD66XTx5G6QcHJzjhTcnen5ZhembOx2WeaivfFxGOzMNS/M+w1o8cJapp4UQHFhPDXEi2td4qh9q/kgx/XkkFYiAF8eBS4QV7XqLzSFHzhIOHPd2dvbhiZ0lcx808AeG6tMMJQOj6gUhN5fMJvmlrV70FLbcB0f7yMrw2A+GTriI8/03ce63ieYvv9Ci1NiG1ZS8D7aHMC0R5UUG9O0CWHUKt5KgT4WrtS/wjMVs+z3wdPrCY7K6H/qnDtM6q085bcePFS2BGZlvVDO2jDKvz20Puk/gyRaVAn4YIccTn7ZJyU3itiWRfVU6pcaUbFk+/5to9Pw9Uq27SKEg98i7uuXO4+8MaQM7l3O6YRfLNg0rpzvKbRNRoaqqTXvUysQQRVjgqPEzdlH3cqrayKUmzuuC8s9/RiWp9097VIUvk+PSiQBhU94BYXynfKAWm44lT7r8Mk1jwYrIj12/aCGZOqlNCudZ1IWt3ajtIrXLvqPwWDxKESjXj2zC6T2XG8qOUz31snU4GK5+iBbdOqXtQoCl4EvJ5nxB+aqZN2nuv6jUVoLfm2RASePKfUIXTTwqw==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(956004)(110136005)(316002)(966005)(2616005)(70586007)(54906003)(70206006)(16576012)(5660300002)(31686004)(478600001)(2906002)(336012)(86362001)(36756003)(6486002)(31696002)(8676002)(47076005)(82740400003)(107886003)(16526019)(4326008)(82310400003)(26005)(36860700001)(83380400001)(6666004)(186003)(81166007)(356005)(53546011)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 11:01:57.9264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 646bced2-2f12-4021-af38-08d8cf459dc1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6625
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

SGkgRXJpYywKCgpPbiAyLzEyLzIxIDM6NDggUE0sIFZpdmVrIEt1bWFyIEdhdXRhbSB3cm90ZToK
PiBIaSBFcmljLAo+Cj4KPiBPbiAyLzEyLzIxIDM6MjcgUE0sIEF1Z2VyIEVyaWMgd3JvdGU6Cj4+
IEhpIFZpdmVrLCBZaSwKPj4KPj4gT24gMi8xMi8yMSA4OjE0IEFNLCBWaXZlayBHYXV0YW0gd3Jv
dGU6Cj4+PiBIaSBZaSwKPj4+Cj4+Pgo+Pj4gT24gU2F0LCBKYW4gMjMsIDIwMjEgYXQgMjoyOSBQ
TSBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4gd3JvdGU6Cj4+Pj4KPj4+PiBIaSBFcmlj
LAo+Pj4+Cj4+Pj4+IEZyb206IEF1Z2VyIEVyaWMgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KPj4+
Pj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAxOSwgMjAyMSA2OjAzIFBNCj4+Pj4+Cj4+Pj4+IEhp
IFlpLCBWaXZlaywKPj4+Pj4KPj4+PiBbLi4uXQo+Pj4+Pj4gSSBzZWUuIEkgdGhpbmsgdGhlcmUg
bmVlZHMgYSBjaGFuZ2UgaW4gdGhlIGNvZGUgdGhlcmUuIFNob3VsZCBhbHNvCj4+Pj4+PiBleHBl
Y3QKPj4+Pj4+IGEgbmVzdGluZ19pbmZvIHJldHVybmVkIGluc3RlYWQgb2YgYW4gaW50IGFueW1v
cmUuIEBFcmljLCBob3cKPj4+Pj4+IGFib3V0IHlvdXIKPj4+Pj4+IG9waW5pb24/Cj4+Pj4+Pgo+
Pj4+Pj4gICAgICBkb21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYoJnZkZXYtPnBkZXYt
PmRldik7Cj4+Pj4+PiAgICAgIHJldCA9IGlvbW11X2RvbWFpbl9nZXRfYXR0cihkb21haW4sIERP
TUFJTl9BVFRSX05FU1RJTkcsCj4+Pj4+ICZpbmZvKTsKPj4+Pj4+ICAgICAgaWYgKHJldCB8fCAh
KGluZm8uZmVhdHVyZXMgJiBJT01NVV9ORVNUSU5HX0ZFQVRfUEFHRV9SRVNQKSkgewo+Pj4+Pj4g
ICAgICAgICAgICAgIC8qCj4+Pj4+PiAgICAgICAgICAgICAgICogTm8gbmVlZCBnbyBmdXRoZXIg
YXMgbm8gcGFnZSByZXF1ZXN0IHNlcnZpY2Ugc3VwcG9ydC4KPj4+Pj4+ICAgICAgICAgICAgICAg
Ki8KPj4+Pj4+ICAgICAgICAgICAgICByZXR1cm4gMDsKPj4+Pj4+ICAgICAgfQo+Pj4+PiBTdXJl
IEkgdGhpbmsgaXQgaXMgImp1c3QiIGEgbWF0dGVyIG9mIHN5bmNocm8gYmV0d2VlbiB0aGUgMiBz
ZXJpZXMuCj4+Pj4+IFlpLAo+Pj4+Cj4+Pj4gZXhhY3RseS4KPj4+Pgo+Pj4+PiBkbyB5b3UgaGF2
ZSBwbGFucyB0byByZXNwaW4gcGFydCBvZgo+Pj4+PiBbUEFUQ0ggdjcgMDAvMTZdIHZmaW86IGV4
cG9zZSB2aXJ0dWFsIFNoYXJlZCBWaXJ0dWFsIEFkZHJlc3NpbmcgdG8gVk1zCj4+Pj4+IG9yIHdv
dWxkIHlvdSBhbGxvdyBtZSB0byBlbWJlZCB0aGlzIHBhdGNoIGluIG15IHNlcmllcy4KPj4+Pgo+
Pj4+IE15IHY3IGhhc27igJl0IHRvdWNoIHRoZSBwcnEgY2hhbmdlIHlldC4gU28gSSB0aGluayBp
dCdzIGJldHRlciBmb3IKPj4+PiB5b3UgdG8KPj4+PiBlbWJlZCBpdCB0byAgeW91ciBzZXJpZXMu
IF5fXj4+Cj4+Pgo+Pj4gQ2FuIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW4g
dXBkYXRlZCBzZXJpZXMgb2YgdGhlc2UKPj4+IHBhdGNoZXM/IEl0IHdpbGwgaGVscCBtZSB0byB3
b3JrIHdpdGggdmlydGlvLWlvbW11L2FybSBzaWRlIGNoYW5nZXMuCj4+Cj4+IEFzIHBlciB0aGUg
cHJldmlvdXMgZGlzY3Vzc2lvbiwgSSBwbGFuIHRvIHRha2UgdGhvc2UgMiBwYXRjaGVzIGluIG15
Cj4+IFNNTVV2MyBuZXN0ZWQgc3RhZ2Ugc2VyaWVzOgo+Pgo+PiBbUEFUQ0ggdjcgMDEvMTZdIGlv
bW11OiBSZXBvcnQgZG9tYWluIG5lc3RpbmcgaW5mbwo+PiBbUEFUQ0ggdjcgMDIvMTZdIGlvbW11
L3NtbXU6IFJlcG9ydCBlbXB0eSBkb21haW4gbmVzdGluZyBpbmZvCj4+Cj4+IHdlIG5lZWQgdG8g
dXBncmFkZSBib3RoIHNpbmNlIHdlIGRvIG5vdCB3YW50IHRvIHJlcG9ydCBhbiBlbXB0eSBuZXN0
aW5nCj4+IGluZm8gYW55bW9yZSwgZm9yIGFybS4KPgo+IEFic29sdXRlbHkuIExldCBtZSBzZW5k
IHRoZSBjb3VwbGUgb2YgcGF0Y2hlcyB0aGF0IEkgaGF2ZSBiZWVuIHVzaW5nLAo+IHRoYXQgYWRk
IGFybSBjb25maWd1cmF0aW9uLgoKUG9zdGVkIHRoZSBjb3VwbGUgb2YgcGF0Y2hlcyB0aGF0IEkg
aGF2ZSBiZWVuIHVzaW5nIC0KCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIw
MjEwMjEyMTA1ODU5Ljg0NDUtMS12aXZlay5nYXV0YW1AYXJtLmNvbS9ULyN0CgoKVGhhbmtzICYg
cmVnYXJkcwpWaXZlawoKPgo+IEJlc3QgcmVnYXJkcwo+IFZpdmVrCj4KPj4KPj4gVGhhbmtzCj4+
Cj4+IEVyaWMKPj4+Cj4+PiBUaGFua3MgJiByZWdhcmRzCj4+PiBWaXZlawo+Pj4KPj4KSU1QT1JU
QU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50
cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJl
IG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1t
ZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBl
cnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3Jt
YXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91LgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
