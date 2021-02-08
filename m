Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6246BC433DB
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 11:57:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9EA64E79
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 11:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9EA64E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 589F2204E8;
	Mon,  8 Feb 2021 11:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aWdWHuVKLMjq; Mon,  8 Feb 2021 11:57:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1BD2420101;
	Mon,  8 Feb 2021 11:57:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEB4DC0174;
	Mon,  8 Feb 2021 11:57:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20E38C013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 11:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 18E53868F8
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 11:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Kgu6eaMed0n for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CB7978669A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 11:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFFYQH/JWngaGUe8pVvO1p+ynbJsxloV9CrWyfj+1pKuRrZXIPycqIj/VE8zfeibbBrZ20+1qXNAJ2WtGEoKbK7zYItOwA655S2lA54+LA8cgskVnUoJU0bzbVcKnuHwjgUIcgbjsmIMDWS4Xe17BKOLvdEm5SD8P1yv4hqxGZBr3PwWLd6FWjKaqt585T2BBZY5bPnTngr9SITon2+oOVvuxCMdkEx0QLs0deB/tUDDP11Tptm5jno7NFkfPE3/hmw30cbY/Fi5ReKkI3z8rTH2WvM7SCAaI0/clkm1Ws3d45H4VC8ki+KzsjEevgcJpzckz7h+AFGixUmHrnWlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7MTaBkiF5OAtYp4a2e17etjJMCMjcUA5frgKRR8zsk=;
 b=gGZTTPLMSgmtirpTaaOut1nj8XxsU/RCGa2WLTTMOylvbGw+oKUjhXdpad2fszL3ZMJN5AsR0cOzTrZScM5sLxHu8oArGvQFZbpz5+PAGGviz3BUF3LjWjim+39D+mTYkRZU8MuwGiRvDQgI/cwGFZDlFCmM6r1AdVM1VM4NebUY0wd3RsGoUb2tPb3Nxoy+PoNG6JnY2ErKUqKo56g01pIf/0ZQydg1+K4e4q2dXKPxoiJMNgPdj1Tk7qqx7Ktf7P7jLyRkB+01woIbsq1rioXVit8Yh/rKedA70U/Zm3E1/T8ejDbgU2BU8/Qw8TpuFOc2IR4kAW1R4RQqCSN2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7MTaBkiF5OAtYp4a2e17etjJMCMjcUA5frgKRR8zsk=;
 b=K5ykk/HqfbjFLd6h8GabmYMPW5WO68GLaS96+iUHint51LsgdP0+g+e5VgCUe67CqElLtrlyU0+5IpmwTIv0gsV5orzWj18rXL3voMfitZISZ9XsBP4i/ZbCH87qNv/W7QZC06S7r5VM0A51CkwH/P61jbbf08sDfPjf8WbF0mk=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Mon, 8 Feb
 2021 11:57:45 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 11:57:45 +0000
Subject: Re: AMD-Vi: Unable to read/write to IOMMU perf counter
To: "Tj (Elloe Linux)" <ml.linux@elloe.vision>,
 iommu@lists.linux-foundation.org
References: <b44a9f38-adc2-f1f2-d544-c907920a7452@elloe.vision>
 <9ebcadaa-301d-2b59-04ae-be9a243c7ac0@amd.com>
 <00a54bdc-6495-d43f-744c-0df269e5d3d6@elloe.vision>
 <e868f04e-7754-310d-aafe-b8ad926359d7@amd.com>
 <a64f18be-7bf9-f355-0960-6322c1f8e3f8@elloe.vision>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <df81a928-dffa-e123-7462-e5e41ca5ebea@amd.com>
Date: Mon, 8 Feb 2021 18:57:36 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <a64f18be-7bf9-f355-0960-6322c1f8e3f8@elloe.vision>
Content-Language: en-US
X-Originating-IP: [61.90.27.73]
X-ClientProxiedBy: SG2PR04CA0189.apcprd04.prod.outlook.com
 (2603:1096:4:14::27) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (61.90.27.73) by
 SG2PR04CA0189.apcprd04.prod.outlook.com (2603:1096:4:14::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.20 via Frontend Transport; Mon, 8 Feb 2021 11:57:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73f8430b-dd98-4f38-bb36-08d8cc28bf29
X-MS-TrafficTypeDiagnostic: BY5PR12MB4146:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4146B1A2E3310CD274EA5357F38F9@BY5PR12MB4146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GO8cZ5m9hpw+8fp2Ge0H4MM8DGBo50YgljAnN9/WQJiUJ8CGpRBAcj6S1I09AUa2hHpQDuEEBt4Yc1+hZcbFh608QXOUO2aHnGNaYNf+yRQNpY36V+4G0+Mh07QzGQ7Ei98DwHT+qm5TJNWOkIJm739YChbayaYYGlHer0qEvjxlAeuvXiJyV5Dc3Eo0040D1ij3R32eQGsz7wCxdW+car5mrBGE7vx8ubhBGWliHHN+m5pDrjOAa8q7Mcaw/5kH2Clwk65H+cDXIo0M4fsQd4Yirv2eJaUd2lwtP4Q64ZlASG+bOMRK6ZVpIMGCp3HHaL/ey4F2esr9ynU1+mFpwo5qA+7+16JMfaoXt0S1MNinwyWCXkjBnp4rg42f0QY5HVl9f3x207tjGXYWsPrx6nAlUkf8UU1+T1ml8lQiOz3Djlngr9kpKLyv4cysZyunLuR6o/0ABfDya14NWo9/RygtvAH/+B9jot6e5NwSp0zwL+9/Ek3TPXI4fxYRfhZsRlpyUXbVYKM3yfoCTqDVwnSnggw1Vgc6LvSI+dL6r1KPpr8PnlpWJWcV0Lt+gEtfdlxyedkzsqPtl2my6dPAwAwoLFm/bhdK+MjOLuzhR5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(66556008)(6506007)(316002)(956004)(478600001)(53546011)(8676002)(86362001)(5660300002)(2906002)(66946007)(2616005)(26005)(6512007)(31686004)(44832011)(6666004)(52116002)(66476007)(186003)(36756003)(16526019)(31696002)(4744005)(8936002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RWNUc1ZRQjdoUSt1dko2clFuaVI5R24zekx4QkdlR0NUS3hrLzVodmtsZzNt?=
 =?utf-8?B?bHZIODRWV2NmNWFEZHVkSXNGRStDNENPWG5aaFhIOHl5d1N4N2UyeERhWVdv?=
 =?utf-8?B?SnN1enNKblltbm9VRWRodmVKejhyYXExODlhT3dreml2RVVRM1hRaThtbjZ1?=
 =?utf-8?B?NEdnYWlza1NKYUZia3lKbDB6Z2IxUVZLUitwelJ4VDFPeUk2a04rWnl4YW1L?=
 =?utf-8?B?ZHFCWk9GNG9OM0FablByb0VwTTBXaXA4aGZaVUdFcXJFSVJjKzBuUXN2dUxw?=
 =?utf-8?B?WVZ6eUhpaU9HTHZtN1dQTzUzSVhkcDhvSTcrenNaQStRTGhxQVpXUzdpRGxw?=
 =?utf-8?B?MXYyeGtlOEsyU2ZaYklTakdVb2pNb3ljZnZJNThmTmhBcWJKOFBaay9aQytB?=
 =?utf-8?B?VXhNYXNoeWJkc21aSGFkR3JDbWtWTjIzWEtyVlI2bDFRcWk1UURtajVwSVFJ?=
 =?utf-8?B?bUFhRjU0T1hvYm84U2NxdUtzTkRuN28reHlOY1R0bGxZZW5pSE5kSmZIMi9H?=
 =?utf-8?B?cEZYOGFDRDIvcEM0VjI2VmovZC9aMThrYWV0QnAxSVV0QWdaTXNad3JCQW9q?=
 =?utf-8?B?WlppREVNdnY1TnpnOW1ZMnZ6bjlQZmFMdlM3Q1lqeWNtb1NXODJSWjc4M2d3?=
 =?utf-8?B?THAvdnlSZlFFNGJ6a1dZRSsxR3p0V2MvYU5HZkx2Si8yMDUzdFRKQzJFRE1z?=
 =?utf-8?B?S0lCZ0kzYStIU0tLM01Uc0prNmtXekpmc08zUldEYXBNY3dlK2pnTzdUMmw5?=
 =?utf-8?B?Y2JtZFdzTmtJUE1mY0lsRmkyZTJsQytpZHd0ZEJOL0Mzc2FHU1dLTEUzS0g5?=
 =?utf-8?B?ZHMvRmc5Zm9ZWXROUjZoVkJBTXNmd1BnRStZb3NYZlIwL1Yyd0ZxNjVHMUJV?=
 =?utf-8?B?NHNDd3gzWm5wSFdhekU2N3dKZDArcEZqUEhKV0E5QUhaNklFQktiQXB3cXV5?=
 =?utf-8?B?K0piSE9Nb0FKNmdVazhNNzhRWHhqM2sxSWRyS041bzUxanhqZ3JNSCtwVG80?=
 =?utf-8?B?UFkwZXg2emxmWlRVZDJjL3IwZmg1bTFocm50NXhxK1JtMG5MMHM2SjREaURB?=
 =?utf-8?B?ZjlIU0Ria1YyOHBtV0M0ZUs3b2JhMG1GQ3ZENXJ2WkhOOG9OSE1Sa2pMcHFL?=
 =?utf-8?B?d2JJME5YZ09zSXBOU0tqYXNDYlRwdDRkK2NuODdUWGhMaW1BM04rRlFzU2Ux?=
 =?utf-8?B?N2NtQ21xa1pmSHVxUUkyelo0NzdyYUZsWGJHWVJ2WWp5TVkwUkE2STBIOEFs?=
 =?utf-8?B?VU9QMm1QOCsxaGlrQVY2ZWs4eFVweUpzT3dPRVlQTmJodjhBM2NqVFlEdytC?=
 =?utf-8?B?WENOWnltNEZ5ZC81UWhyUHBLUzVMVEdRNEdOUm5HdVArTSs1dmRpdDU3U2Mw?=
 =?utf-8?B?dy9mdjRFM09WWWdaZVNrUDg3M0loSjY5d1FFMmVOK0I2MUZrckRZSzVkbHI5?=
 =?utf-8?B?aGVIQzVZZGhrbXl4bW96b2VuSnVWQ1JqbGdFVnM0aEZyVU9rMnpRMHNmOEpp?=
 =?utf-8?B?SFF6dGZlTjdFa21OZFdUYnJZbkNXNmhzSW85eklyd25DRzFBelFDZFBKUmhG?=
 =?utf-8?B?UWlkUHJma1FMK0IzbWlFU1I1Zmtuc2xydjJtRUh3YmRWeGV2b0lZTFVZQWJG?=
 =?utf-8?B?My9rZmRXS2ZrRkZUY0l0MEhvaDVvdGFyODlpUEtMQ3hqc3hPVzdXK2JzL2VI?=
 =?utf-8?B?cUdaTHk2WkJyS1ZoZWhCVVRYWHNnZE82Q0N1a28wVE5Hem1ndWVnT3c2WW5D?=
 =?utf-8?Q?HBZAsNT+W0oe/JMis4B8TpCENlJjYaEP9lFcIfc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f8430b-dd98-4f38-bb36-08d8cc28bf29
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 11:57:45.3195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWHQX0M+SBPHbiKFCpE1pvUMAokCxnpvcSaja6KKaQuiZlxrPt3+Tp5+qyV1+iqU4vpxDUV+uaOvdZYQe+QSaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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

TJ,

Thanks for testing. I will submit this change upstream w/ you as Tested-by.

On 2/8/21 12:18 AM, Tj (Elloe Linux) wrote:
> On 06/02/2021 04:02, Suravee Suthikulpanit wrote:
> Would this be in any way related to the following from the same device:
> 
> kernel: pci 0000:00:00.2: can't derive routing for PCI INT A
> kernel: pci 0000:00:00.2: PCI INT A: not connected

This is not related, but should not cause issues.

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
