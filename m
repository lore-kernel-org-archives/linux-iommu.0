Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB07C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 13:58:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BDB64E86
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 13:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BDB64E86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DF5E837A4;
	Wed,  3 Mar 2021 13:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ygzgGC_tWJkT; Wed,  3 Mar 2021 13:58:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8B0C837CD;
	Wed,  3 Mar 2021 13:58:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93744C000A;
	Wed,  3 Mar 2021 13:58:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1CAEC0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 13:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AEBA400FA
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 13:58:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=nxp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MvkE7DqPt4SR for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 13:58:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC286400FD
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 13:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVIqvpbn7ZgySHDpDuATbBiF0xvxKbWV77BngEIXroZPqtE/L0YszMo+Zc2PMBPnoFak1RZbOdDCAys92eNJTfPLPyKz/74Cyl38CBtyGLDJj+f0HNYJuknRBract+3rO3UrgfHrQJomsC4WbKRI+Vk6YC/ZSBB9z7vMfaIftdjyYyTMA6IhqeSuC/mAyaHP6CyqPk1inquZMOGfFJqDYbMEvCb4cLrIDdJnWKSSwl1Kp0EdxR0S8C5UUvdiq4GuDqSxEZdKWpAx46agcK/xt1/FmgX26GNux8PzbDI58l5p5XzVQGzxdC2qYYSr2wNSCpOmzL8ouYS+o0N390Llvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9lFXCfyq5FtYrHqcZNlIUcYB53K2WNRT86q51SnmoY=;
 b=C3nq68vmA8rCRd5pZQd/lDoipg5TgxQHwBffHRJmgjIyOIjr24m3GsQeR/w3NHLa2VHqBzpRv/HUktax8/A5PIL8lC8FULBFC3BbT2RpVnFMb2q56rBPvZUC5q2bi7fNstpsBuB8Ch1Tkj+tNo/5TDi2mQylXNfwl6whK1UPbqJqpW+TNLzLUPezVolNHt6v5k7tdr8GiabhJgomCuw+tLsllfJLIR2pDrY/Atd5vPxTABFJAV8/guqiEcBpHtTDGaZR/xJ6t71tUAfXM9lqHb0a034xOofXuraHf2GBbHJivooliX5eMfpmRl6PDbb4dsYteSKHp86xF+3LOUSKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9lFXCfyq5FtYrHqcZNlIUcYB53K2WNRT86q51SnmoY=;
 b=aUB+73M3rs3RGgDL0wB9sg3Hf3keuNC7P26kUPpccXBGE/ytAQisDqRYbErTTEZqcebX4NqRjHe7SzMmfzXOHfmSVPdZ3N4Z3bcRW7qjRfs6rqU09B4EyqGn5LneH2PW3NjUDPVfuYM+ZLyNywwD7wqo1epbN4/weh71NQvgHLY=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VI1PR04MB4592.eurprd04.prod.outlook.com (2603:10a6:803:75::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Wed, 3 Mar
 2021 10:26:35 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba%5]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 10:26:35 +0000
Subject: Re: CAAM: kernel BUG at drivers/crypto/caam/jr.c:230! (and
 dma-coherent query)
To: Sascha Hauer <sha@pengutronix.de>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
References: <20210301152231.GC5549@pengutronix.de>
From: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <a52e0a0f-a784-2430-4b37-fb9fdcf3692b@nxp.com>
Date: Wed, 3 Mar 2021 12:26:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210301152231.GC5549@pengutronix.de>
Content-Language: en-US
X-Originating-IP: [78.97.206.147]
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.213] (78.97.206.147) by
 FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.16 via Frontend Transport; Wed, 3 Mar 2021 10:26:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92fad99b-3647-4a12-288c-08d8de2ed27d
X-MS-TrafficTypeDiagnostic: VI1PR04MB4592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB45920E6A3005B188BC3290A198989@VI1PR04MB4592.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KHEN9RS1gm1/ehLQkHe0U5mbW/0k1jOuSkbQsJB5slUPvP4TtK5fEDM1dJjTgyzXgJ7yQuKJDAFXau4B0s3G1y7ZjYEbvGqM+hlOUfRTio13iiElRXqEaRm9u+V+GDHbOCgVTrdTZFtwEw4A/kQXcMAR07APR0Lls4Kds6vwkXdYCXLpjlN2YwZg7x8TsneHQzMIk5jqNmJEOTjN/54K7vDQnsopRjgWVYqKCyMbi7zKprse6gUHkzfamBU6WqedKgy0MMAsGov9u7N5ggJO/iUfhpQ15TYWyF7j4atvOQSxsbBaPYQLKhi8cMpxLGEwXyw4LnZsh0WMRE2FzBjasWG0Mx3ZViyypiDtKGQFQHuS6Eqrnlczel3YkjADuE2QLkkK3VhGRvQzdji8GjzsmiSZVVPN+RtijMsxJKv+0dxsyownPVzoy8DNnklset4Emxw4Ka8MDSfQhagNGm/D5utEQrTBNS6Su+E0m/qTByGtwTwVQXwE4QEuDSErfBdGHyChNzTrQtCtE9qujGw8CYvUmsJCIIOpLu2e3FP5oBeQnSgbou3Q6BY9z75Gg1zx9xFNdSzZipL4tuZIYQphn56GhPlpP36fmZmCgztK8L/V3y8hv5KpieeMBYvaGeHx9F8oVK2pDSuh3GXq/9tc1smV2zhsxi1H6EKkF2j+8k+9yKhHCNGHsmYhOZaUwnd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(7416002)(31686004)(83380400001)(8676002)(2906002)(45080400002)(66946007)(8936002)(4326008)(186003)(16526019)(26005)(52116002)(66556008)(54906003)(2616005)(5660300002)(66476007)(478600001)(36756003)(956004)(53546011)(966005)(86362001)(31696002)(6486002)(16576012)(110136005)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cDJZalVzbko4RWUyR3U5Q2RWTXZyVllVbDlqUXhYOFg3TDRha2sydUJkY0Ju?=
 =?utf-8?B?TUt0bkQ5WmNzb01XaFNCVGdVMWNMYVA0ZkZ4OEljYUllQ3BqQkZVVkJVMUNN?=
 =?utf-8?B?L21VSldoYndWLzFyUUJuc1dPZEJVQ0ZkY0lpQkxVblNTOXp6L2cyTG96ZXJl?=
 =?utf-8?B?TlhPV2NVd0F2bnZLV3lkcXh1Q2xmY0JaeHZhQ1NpMEM2UmtIbmZuVmJxeXZN?=
 =?utf-8?B?UE5Fa1RzZSszNFdTOEp3OWQ4NW15RFRxcVJEWWRVbUl4ZGxjK054QnBYb1Bi?=
 =?utf-8?B?dmdzQmxJeC90Skp3dkVDUXRCVy9IWEhndTRzcTV5a1FKT0FlUUxBeS9Cdjhp?=
 =?utf-8?B?SHRHaU9Oc09MZW8wcEY4TXNmUVB1d2tCekJBNGZkWDFXN3Z1bm5mMnRXMEk5?=
 =?utf-8?B?Mm1MT3JPVWVWMVdPb0x0WEJ0aStqdFJxQ1RaRkJWaE5YN2JUdU1nS1FUVmdT?=
 =?utf-8?B?Y2JWZXZHSEttb0lMUWdSLzVRbGdDRnpKbUJUemZEa1BVd2lkTUVMMEdiU1dR?=
 =?utf-8?B?RGZCSEdDSWV3aVNSTHZENUVQeWtoVk1pSEkxdWVTc09oYTkyVkVpZ0VGNkVH?=
 =?utf-8?B?NkttRmpmNGNRaGdYbWthQmJ3NWZlUzJzcGxBQSt3RGVvendIS28rbEdGOXd4?=
 =?utf-8?B?dzFOc3dzRWJoc1hqbzE1Q3JDT3pTSFBNSUJCc2RxamFQdjB6akNRYWVwN1VP?=
 =?utf-8?B?VzA2cTZjOEszR2wxMjU4dUEzdmRWRjBLWHY1S0dEYVB2cUxGY3ZHRENKOXB0?=
 =?utf-8?B?WG9pbHZwRk1aRFV1RHVTTE5jU3F5KytScVk2TFVicXQ5R1ZoanlFL204QTBw?=
 =?utf-8?B?NzE0NHowa2N4bERKeGxyYmFHTlpZbUs0YlRrK0V5ZHlsaU10ejgxd2t1OWt4?=
 =?utf-8?B?UW05MHZJQVF2UlUxaEVCSlBWQktpdnE0N0I5QnNHQjJQak4rR0dIRUtXY3Fr?=
 =?utf-8?B?bUk0WlBuR3dmSGNYZ1pSRjJUS0RzV2x4eEVlNlVtRWhJYVZobkJLWTJESE81?=
 =?utf-8?B?OGpSWDBlSTkxeVBuODdIYWZpRDFBT1hIL29oZVZUNVNjV3NtUDdhb3E4bGxN?=
 =?utf-8?B?elJyVnh6RU04WmZuSHFJeHNPZnVVc1loNEFqVWpPU3I0VDZDUWJyaUlyQ0Rk?=
 =?utf-8?B?WWN0ZXg4c0JuWlcvRVdHWlY1NlNuK3pOb0ZZZ2NZL1JNTWRQK1Q1cTF0UE1p?=
 =?utf-8?B?OTg2ZUc0NHFQaFQ3K3RmajlNZVJVeGEzRHljczJNS3NSaGtoZ0kzWUVvWGVj?=
 =?utf-8?B?VWNFRUdmQnZNdG5XdkRXVkdselpPVmliNGRGOEZUR1pyKzVqbk94VUFCejFm?=
 =?utf-8?B?NlVkS1RWeGdodU8ydVNpT2loNlo2S2MxNkJ2NFhEWnFnTXplaGVnNlB3UmZF?=
 =?utf-8?B?U1pHbVRaN0hPVENUOExUcGJGV3hObmZKQkxLbE5FWEIzd2QwbHV1ZTNjYmNl?=
 =?utf-8?B?NmxFM0VmL0NPU3B6dGxGYlpvUiswUjRwR3VoT05KUFN0M2x3ZUxJdEZ3WCt1?=
 =?utf-8?B?SGtTUGFBUjlrSGh0cFc1WEdRWHRVV25kVTRoRnhEdVFuVDk3YWNGK2oxWHlK?=
 =?utf-8?B?WVhDR2FQeHBKcUdHQWF3akdKU0UvTWVIZGI1L01ibkp0SlpOQ0M4RDRuVzJ4?=
 =?utf-8?B?TzlsTjB4andFaTVuVDdQNkVBZFRFNnVSVWhQNVMzSnkzZnJNOVZTeVp1cHFW?=
 =?utf-8?B?ODFNLzVXZWFYMTFvWDhLbTIveHEwcEpiNGJWU3BWSncyUnY3ZHNLdHF0Y1pQ?=
 =?utf-8?Q?mecpq3TnHtxcMRLEVLcQbDS0ia3ic9npwVLuY+F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fad99b-3647-4a12-288c-08d8de2ed27d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 10:26:35.6803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+KOcgM4tmcssLRjBXY6nusTgDVdzVmkdHvj23nqbXu4MaA+8XpRrBE6mEtu85nNGfeDk7bsjwsMdFwwvRQkmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4592
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Christoph Hellwig <hch@lst.de>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Robin Murphy <robin.murphy@arm.com>, Greg Ungerer <gerg@linux-m68k.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

QWRkaW5nIHNvbWUgcGVvcGxlIGluIHRoZSBsb29wLCBtYXliZSB0aGV5IGNvdWxkIGhlbHAgaW4g
dW5kZXJzdGFuZGluZwp3aHkgbGFjayBvZiAiZG1hLWNvaGVyZW50IiBwcm9wZXJ0eSBmb3IgYSBI
Vy1jb2hlcmVudCBkZXZpY2UgY291bGQgbGVhZCB0bwp1bmV4cGVjdGVkIC8gc3RyYW5nZSBzaWRl
IGVmZmVjdHMuCgpPbiAzLzEvMjAyMSA1OjIyIFBNLCBTYXNjaGEgSGF1ZXIgd3JvdGU6Cj4gSGkg
QWxsLAo+IAo+IEkgYW0gb24gYSBMYXllcnNjYXBlIExTMTA0NmEgdXNpbmcgTGludXgtNS4xMS4g
VGhlIENBQU0gZHJpdmVyIHNvbWV0aW1lcwo+IGNyYXNoZXMgZHVyaW5nIHRoZSBydW4tdGltZSBz
ZWxmIHRlc3RzIHdpdGg6Cj4gCj4+IGtlcm5lbCBCVUcgYXQgZHJpdmVycy9jcnlwdG8vY2FhbS9q
ci5jOjI0NyEKPj4gSW50ZXJuYWwgZXJyb3I6IE9vcHMgLSBCVUc6IDAgWyMxXSBQUkVFTVBUIFNN
UAo+PiBNb2R1bGVzIGxpbmtlZCBpbjoKPj4gQ1BVOiAwIFBJRDogMCBDb21tOiBzd2FwcGVyLzAg
Tm90IHRhaW50ZWQgNS4xMS4wLTIwMjEwMjI1LTMtMDAwMzktZzQzNDIxNTk2ODgxNi1kaXJ0eSAj
MTIKPj4gSGFyZHdhcmUgbmFtZTogVFEgVFFNTFMxMDQ2QSBTb00gb24gQXJrb25hIEFUMTEzMCAo
QzMwMCkgYm9hcmQgKERUKQo+PiBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFP
IC1UQ08gQlRZUEU9LS0pCj4+IHBjIDogY2FhbV9qcl9kZXF1ZXVlKzB4OTgvMHg1N2MKPj4gbHIg
OiBjYWFtX2pyX2RlcXVldWUrMHg5OC8weDU3Ywo+PiBzcCA6IGZmZmY4MDAwMTAwMDNkNTAKPj4g
eDI5OiBmZmZmODAwMDEwMDAzZDUwIHgyODogZmZmZjgwMDAxMThkNDAwMAo+PiB4Mjc6IGZmZmY4
MDAwMTE4ZDQzMjggeDI2OiAwMDAwMDAwMDAwMDAwMWYwCj4+IHgyNTogZmZmZjAwMDgwMjJiZTQ4
MCB4MjQ6IGZmZmYwMDA4MDIyYzY0MTAKPj4geDIzOiAwMDAwMDAwMDAwMDAwMWYxIHgyMjogZmZm
ZjgwMDAxMThkNDMyOQo+PiB4MjE6IDAwMDAwMDAwMDAwMDRkODAgeDIwOiAwMDAwMDAwMDAwMDAw
MWYxCj4+IHgxOTogMDAwMDAwMDAwMDAwMDAwMSB4MTg6IDAwMDAwMDAwMDAwMDAwMjAKPj4geDE3
OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjogMDAwMDAwMDAwMDAwMDAxNQo+PiB4MTU6IGZmZmY4MDAw
MTE2OTAyMzAgeDE0OiAyZTJlMmUyZTJlMmUyZTJlCj4+IHgxMzogMmUyZTJlMmUyZTJlMjAyMCB4
MTI6IDMwMzAzMDMwMzAzMDMwMzAKPj4geDExOiBmZmZmODAwMDExNzAwYTM4IHgxMDogMDAwMDAw
MDBmZmZmZjAwMAo+PiB4OSA6IGZmZmY4MDAwMTAwYWRhMzAgeDggOiBmZmZmODAwMDExNmE4YTM4
Cj4+IHg3IDogMDAwMDAwMDAwMDAwMDAwMSB4NiA6IDAwMDAwMDAwMDAwMDAwMDAKPj4geDUgOiAw
MDAwMDAwMDAwMDAwMDAwIHg0IDogMDAwMDAwMDAwMDAwMDAwMAo+PiB4MyA6IDAwMDAwMDAwZmZm
ZmZmZmYgeDIgOiAwMDAwMDAwMDAwMDAwMDAwCj4+IHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6
IDAwMDAwMDAwMDAwMDE4MDAKPj4gQ2FsbCB0cmFjZToKPj4gIGNhYW1fanJfZGVxdWV1ZSsweDk4
LzB4NTdjCj4+ICB0YXNrbGV0X2FjdGlvbl9jb21tb24uY29uc3Rwcm9wLjArMHgxNjQvMHgxOGMK
Pj4gIHRhc2tsZXRfYWN0aW9uKzB4NDQvMHg1NAo+PiAgX19kb19zb2Z0aXJxKzB4MTYwLzB4NDU0
Cj4+ICBfX2lycV9leGl0X3JjdSsweDE2NC8weDE2Ywo+PiAgaXJxX2V4aXQrMHgxYy8weDMwCj4+
ICBfX2hhbmRsZV9kb21haW5faXJxKzB4YzAvMHgxM2MKPj4gIGdpY19oYW5kbGVfaXJxKzB4NWMv
MHhmMAo+PiAgZWwxX2lycSsweGI0LzB4MTgwCj4+ICBhcmNoX2NwdV9pZGxlKzB4MTgvMHgzMAo+
PiAgZGVmYXVsdF9pZGxlX2NhbGwrMHgzYy8weDFjMAo+PiAgZG9faWRsZSsweDIzYy8weDI3NAo+
PiAgY3B1X3N0YXJ0dXBfZW50cnkrMHgzNC8weDcwCj4+ICByZXN0X2luaXQrMHhkYy8weGVjCj4+
ICBhcmNoX2NhbGxfcmVzdF9pbml0KzB4MWMvMHgyOAo+PiAgc3RhcnRfa2VybmVsKzB4NGFjLzB4
NGU0Cj4+IENvZGU6IDkxMzkyMDIxIDkxMmMyMDAwIGQzNzdkOGM2IDk3ZjI0ZDk2IChkNDIxMDAw
MCkKPiAKPiBUaGUgZHJpdmVyIGl0ZXJhdGVzIG92ZXIgdGhlIGRlc2NyaXB0b3JzIGluIHRoZSBv
dXRwdXQgcmluZyBhbmQgbWF0Y2hlcyB0aGVtCj4gd2l0aCB0aGUgb25lcyBpdCBoYXMgcHJldmlv
dXNseSBxdWV1ZWQuIElmIGl0IGRvZXNuJ3QgZmluZCBhIG1hdGNoaW5nCj4gZGVzY3JpcHRvciBp
dCBjb21wbGFpbnMgd2l0aCB0aGUgQlVHX09OKCkgc2VlbiBhYm92ZS4gV2hhdCBJIHNlZSBzb21l
dGltZXMgaXMKPiB0aGF0IHRoZSBhZGRyZXNzIGluIHRoZSBvdXRwdXQgcmluZyBpcyAweDAsIHRo
ZSBqb2Igc3RhdHVzIGluIHRoaXMgY2FzZSBpcwo+IDB4NDAwMDAwMDYgKG1lYW5pbmcgREVDTyBJ
bnZhbGlkIEtFWSBjb21tYW5kKS4gSXQgc2VlbXMgdGhhdCB0aGUgQ0FBTSBkb2Vzbid0Cj4gd3Jp
dGUgdGhlIGRlc2NyaXB0b3IgYWRkcmVzcyB0byB0aGUgb3V0cHV0IHJpbmcgYXQgbGVhc3QgaW4g
c29tZSBlcnJvciBjYXNlcy4KPiBXaGVuIHdlIGRvbid0IGhhdmUgdGhlIGRlc2NyaXB0b3IgYWRk
cmVzcyBvZiB0aGUgZmFpbGVkIGRlc2NyaXB0b3Igd2UgaGF2ZSBubwo+IHdheSB0byBmaW5kIGl0
IGluIHRoZSBsaXN0IG9mIHF1ZXVlZCBkZXNjcmlwdG9ycywgdGh1cyB3ZSBhbHNvIGNhbid0IGZp
bmQgdGhlCj4gY2FsbGJhY2sgZm9yIHRoYXQgZGVzY3JpcHRvci4gVGhpcyBsb29rcyB2ZXJ5IHVu
Zm9ydHVuYXRlLCBhbnlvbmUgZWxzZSBzZWVuCj4gdGhpcyBvciBoYXMgYW4gaWRlYSB3aGF0IHRv
IGRvIGFib3V0IGl0Pwo+IAo+IEkgaGF2ZW4ndCBpbnZlc3RpZ2F0ZWQgeWV0IHdoaWNoIGpvYiBh
Y3R1YWxseSBmYWlscyBhbmQgd2h5LiBPZiBjb3Vyc2UgdGhhdCB3b3VsZAo+IGJlIG15IHVsdGlt
YXRlIGdvYWwgdG8gZmluZCB0aGF0IG91dC4KPiAKVGhpcyBsb29rcyB2ZXJ5IHNpbWlsYXIgdG8g
YW4gZWFybGllciByZXBvcnQgZnJvbSBHcmVnLgpIZSBjb25maXJtZWQgdGhhdCBhZGRpbmcgImRt
YS1jb2hlcmVudCIgcHJvcGVydHkgdG8gdGhlICJjcnlwdG8iIERUIG5vZGUKZml4ZXMgdGhlIGlz
c3VlOgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1jcnlwdG8vNzRmNjY0ZjUtNTQzMy1k
MzIyLTQ3ODktM2M3OGJkYjgxNGQ4QGtlcm5lbC5vcmcKUGF0Y2ggcmViYXNlZCBvbiB2NS4xMSBp
cyBhdCB0aGUgYm90dG9tLiBEb2VzIGl0IHdvcmsgZm9yIHlvdSB0b28/CgpXaGF0IEkgZG9uJ3Qg
dW5kZXJzdGFuZCAoYW5kIHRoZSByZWFzb24gSSd2ZSBwb3N0cG9uZWQgdXBzdHJlYW1pbmcgaXQp
IGlzCl93aHlfIGV4YWN0bHkgdGhpcyBwYXRjaCBpcyB3b3JraW5nLgpJIHdvdWxkIGhhdmUgZXhw
ZWN0ZWQgdGhhdCBhIEhXLWNvaGVyZW50IGRldmljZSB0byB3b3JrIGZpbmUgZXZlbiB3aXRob3V0
CnRoZSAiZG1hLWNvaGVyZW50IiBEVCBwcm9wZXJ0eSBpbiB0aGUgY29ycmVzcG9uZGluZyBub2Rl
LgpJJ3ZlIGZvdW5kIHdoYXQgc2VlbXMgcmVsYXRlZCBkaXNjdXNzaW9ucyBpbnZvbHZpbmcgZVNE
SEMsIGJ1dCBzdGlsbCBJIGFtIHRyeWluZwp0byBmaWd1cmUgb3V0IHdoYXQncyBoYXBwZW5pbmcu
IEknZCByZWFsbHkgYXBwcmVjaWF0ZSBhIGNsYXJpZmljYXRpb24gb24gd2hhdApjb3VsZCBnbyB3
cm9uZyAoZS5nLiBpbnRlcmFjdGlvbnMgd2l0aCBTVy1iYXNlZCBjYWNoZSBtYW5hZ2VtZW50IGV0
Yy4pOgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbWMvMjAxOTA5MTYxNzE1MDkuR0cy
NTc0NUBzaGVsbC5hcm1saW51eC5vcmcudWsKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDE5MTAxMDA4MzUwMy4yNTA5NDE4NjZAbGludXhmb3VuZGF0aW9uLm9yZwpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1tbWMvQU03UFIwNE1CNjg4NTA3QjVCNEQ4NEVCMjY2NzM4ODkxRjgz
MjBAQU03UFIwNE1CNjg4NS5ldXJwcmQwNC5wcm9kLm91dGxvb2suY29tCgpUaGFua3MsCkhvcmlh
CgotLSA+OCAtLQoKU3ViamVjdDogW1BBVENIXSBhcm02NDogZHRzOiBsczEwNDZhOiBtYXJrIGNy
eXB0byBlbmdpbmUgZG1hIGNvaGVyZW50CgpDcnlwdG8gZW5naW5lIChDQUFNKSBvbiBMUzEwNDZB
IHBsYXRmb3JtIGhhcyBzdXBwb3J0IGZvciBIVyBjb2hlcmVuY3ksCm1hcmsgYWNjb3JkaW5nbHkg
dGhlIERUIG5vZGUuCgpTaWduZWQtb2ZmLWJ5OiBIb3JpYSBHZWFudMSDIDxob3JpYS5nZWFudGFA
bnhwLmNvbT4KLS0tCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS5k
dHNpIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDQ2YS5kdHNpIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEuZHRzaQppbmRleCAwMjVlMWY1ODc2NjIu
LjZkNGRiM2UwMjFlOCAxMDA2NDQKLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWxzMTA0NmEuZHRzaQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHMxMDQ2YS5kdHNpCkBAIC0zMjUsNiArMzI1LDcgQEAKICAgICAgICAgICAgICAgICAgICAgICAg
cmFuZ2VzID0gPDB4MCAweDAwIDB4MTcwMDAwMCAweDEwMDAwMD47CiAgICAgICAgICAgICAgICAg
ICAgICAgIHJlZyA9IDwweDAwIDB4MTcwMDAwMCAweDAgMHgxMDAwMDA+OwogICAgICAgICAgICAg
ICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNzUgSVJRX1RZUEVfTEVWRUxfSElHSD47
CisgICAgICAgICAgICAgICAgICAgICAgIGRtYS1jb2hlcmVudDsKCiAgICAgICAgICAgICAgICAg
ICAgICAgIHNlY19qcjA6IGpyQDEwMDAwIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb21wYXRpYmxlID0gImZzbCxzZWMtdjUuNC1qb2ItcmluZyIsCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
