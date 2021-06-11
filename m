Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A375EC48BE0
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 10:59:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB5C61246
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 10:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB5C61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B10360646;
	Fri, 11 Jun 2021 10:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WY3sQrBq061A; Fri, 11 Jun 2021 10:59:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E0B2760615;
	Fri, 11 Jun 2021 10:59:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C32F7C000D;
	Fri, 11 Jun 2021 10:59:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBA58C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 10:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2672839F9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 10:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=nxp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ksiQJNG7QXhJ for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 10:59:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02on061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe07::61c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B41728291A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 10:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnVXnQWXkQi3kNiP5B1YRGNZWDdgrZVzAdFGMIphynia3r0FutcwFMtmdhb+hWC1cjQxhDNOgPdl4QwQZfAT5ERaBsa4vET7Bw2RkD4HdoTFtwNgwxuJ0JiDh1dkE/0nF+oj5GRLddCZvZ7lYm92JexSyqUwumTzydjOsvrQhXal69dwJapH8HrGHZXNqXhFE+hfL5ronYYeca3RIZvr1l9jiuxblOsR9W7XSUA/eQz192+jtDjTnpPD5cD3V7U/PaSVpTieu46bBC5s++jA1MCuWATOLBk/FTFNazJAkcqdhvZdLAT4URK4QYND61hwjHAemH1Imi1pF2Gaac1bTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3E8Nmy2UfieGHnfdu8p9LdyQGZUbeElmzN6iIfdiB8=;
 b=T5DgQYv4HOF8eyBMQ+0sgfqYRlNrwNnyv+AZgj3HDonJdrjKGHRn1rxhwkHVVsXfMphoLwnUgGP5Wk3jOcnIy0WFvCksu5RZHhlmv9Lbxsppe3tOxihGJE+FNfuYdwUo13DE/t5WfvkBPiOhpUIhtsJ055sFIxuArF0/p3i5eQUF08dWyum2JV5O3g6D5bWwweQYtYhV3yF6a+30nB7Fah/otTdHtUInBsSF3tW9xI2g3v//BbTUajmCOAUz0UYblSW3rTgGI2+UJq6P6py8xGy/lRGUWO5QYgNiAFywdo97mQ1M0a5J9l1hymaCGHh/NTVFJjduiUoJW1s7Ux3jUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3E8Nmy2UfieGHnfdu8p9LdyQGZUbeElmzN6iIfdiB8=;
 b=s0z1VWAr0ZDtNayKlyBxBt/Me4dcga9jEkQXc9m5lDKK0jGWgus9u5KFG4IG+4TmPdu8B7nhXwa5o3dIUJyziqDAky64jQLByRekukhBsuqyOemQvwy/IbTnWuFk2YXoUgYP7R0PRfL+bSlbMUtryzt+kMclA/NqD6dkf8UyHYg=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VE1PR04MB7344.eurprd04.prod.outlook.com (2603:10a6:800:1a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Fri, 11 Jun
 2021 10:59:40 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::e8df:8117:d230:f321]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::e8df:8117:d230:f321%5]) with mapi id 15.20.4219.022; Fri, 11 Jun 2021
 10:59:40 +0000
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Christoph Hellwig <hch@lst.de>,
 Dominique MARTINET <dominique.martinet@atmark-techno.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 jianxiong Gao <jxgao@google.com>
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
 <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
 <20210611062153.GA30906@lst.de> <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
From: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <407997cd-dfa0-7b36-fa12-2baebdfcfff7@nxp.com>
Date: Fri, 11 Jun 2021 13:59:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
Content-Language: en-US
X-Originating-IP: [78.97.206.147]
X-ClientProxiedBy: AM0PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:208:55::33) To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.213] (78.97.206.147) by
 AM0PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:208:55::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 10:59:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44768021-b992-4394-c136-08d92cc802ba
X-MS-TrafficTypeDiagnostic: VE1PR04MB7344:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7344AABD54ECC607733D2BF998349@VE1PR04MB7344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7B9PLo8Zbg5cUtCWU491+r92y6lOlfdJECZjFXTQgQPzDoGEy9mjqwD+At3ZeTmI1TcebuycPt1YDgoVlFJ5N7AFEjnELHhQARqHPXvOLSnZdh4kLlTCBwywYMSuVy4BH+a7rJmYmM61z6myNbu2cm8pYLA7C8Y5gK1xkeORM7qDV/xbCXMxV+ulOB4j1v+R/z1b2zVP2AVI0CJu4Sv33jwjQjQ0GKuAXt1tjmXyEOf3OUJ/PyAlDaICNhPMPUBGsJPKOe0PbRyV0Bc8TrpQBZ5DiE5Ag5gKOwzUR9z/qv12tQ7xNVV5deCPrESI8e6uVlg/jhA2wm2BFe+ND9K6HBOLtcfT6MV1m0GV9IxhQuzPveQUYOIWMX6twKEsA7vcmtrIuYz0x5WW8TiY/ND/qcEjMGNESTDNnntCIRCWMmIvhEfL1JjERpvw/bqY8lzOZr+SPJvDkdqvbwPNJScITUPLF0bzjhAnf7huRt8T/QLe63cK0h+4oDYVGlZd7mPpkD66b/G+nSPymV0QnGhAPzXuV722XA4pYUORyC2uyCTKFgFuCWHsoXJbhI3Gl37Pb8jgDRdK+o3EmKtjvbOoaGlIL7MHqaJvla1T4fTcQd3wgRcYkcerwny3jdWgkyYrEwh9wl3/MjJ4xQwZ1ldxhJD1PwrqeG2JSDapZ56qd6BYoATqMObyKI3GP11D1m+AHmzLpsYPNRnBpll5kEybYJTHD2iUvFMwAW72Kk91c9bCKgslCeZxJ0ww0jOYvtVh8rcy6nN/nlWbMZsoYds3Y7nraWCRmJAZZEYp/0OzpjazplwPWCjQNnF9ThY8cXaMq4FV/IPFt7xGp7aylrcE3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(36756003)(31686004)(110136005)(31696002)(66556008)(16576012)(316002)(54906003)(38100700002)(7416002)(66946007)(6486002)(52116002)(86362001)(66476007)(5660300002)(186003)(8676002)(966005)(4326008)(478600001)(2906002)(16526019)(83380400001)(8936002)(26005)(956004)(53546011)(38350700002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0s3WFVrUnJLTlEwcWo3emIyZVVTa1A3dFNtTUQ4WEFNNnQrVkZJUUVPektB?=
 =?utf-8?B?WTN4ZXZnRWR0cmRJYmdxd0F3WXQrSi9ya1dUR2g5bzF5OW5YUVEybXMrdkVz?=
 =?utf-8?B?RWZhQVlpd3BucFp4TjlMWnhGV3RtekJzbWtnN2FJSGRGaER5SmZPalpKOE02?=
 =?utf-8?B?dFJFWnVwOFZXSWZWeXhoU0tZaXFNOGFZbEdXdEhWYS9iSmxUV0NyaU9zRlJP?=
 =?utf-8?B?NzdyK0R0dUs0bm45TFR1R2FOOVZXdGJ6aFJyR1FOSjVsbU5zYnRiSE4yMzYv?=
 =?utf-8?B?b1puR253VG1FZFpWV1hEdzZZcU1ldHJtTnRKQ1kzNms5aDdJblBtbHRUSzlq?=
 =?utf-8?B?alFJV1VaZG5xRWlzMXJvUUNvT29Sc0dtMnFydjdEdEZKT2hFVFZZOHRxd0hM?=
 =?utf-8?B?NW5BMWd5alZncVhCUlhSbHJ3Q3NLM1YwK2xocE9GZ05RUGxTTUpvV3d5bUlw?=
 =?utf-8?B?OWV5QS8wWnJ2cTBpSjNqN2V6QU5LVEhRMUJ6OEMrRkpzbnJiWEFxUWdhZlJw?=
 =?utf-8?B?WVNsM3FHNTVlc1JEdFc4Qml5ZFFpVDF0VVZkZHNXQ2I0NWpvMmdnRnk4OTN2?=
 =?utf-8?B?UFhJSmRmV2JNSE9EQSt2Sko0R0QxekpMb3dOSjFSYU81WE84Z3pNRjM3UXpk?=
 =?utf-8?B?TDMvUzJOdjI4dDA2QUl2MEVhUjFVMFlSaXVrTm9sU1kzWXM4UFNmVTVmaGx3?=
 =?utf-8?B?cFBmSVZjY1NIUWhqSkJJMXBjSmo4V1ZxUjNNMmxqVDdOQSt1V2dzVldCSnAz?=
 =?utf-8?B?d0pHNDFVMUJZQzdrTUV6L0F2bXVaRHFuQy9UUWFzc0xaeHl4Nm9mMGhyVmwx?=
 =?utf-8?B?VmV6cXlibHYvc1JJNnJLMzdkWllSOGxjQWR1anZ1OUNFSmd3dFRRRG5EL1o0?=
 =?utf-8?B?cHUyV05JeGUzWGlVS3hFcW1GVUVHOU5TWkVGVmh4SjBoRzRBQm9PV3UzUVk4?=
 =?utf-8?B?T2h0WXFwSWhIOTZHWHFlcDc3Z0tQdTZpVlR4RUFvdTRvWjdFc09TbU1VWkla?=
 =?utf-8?B?V2V1czhVcC83UithV2JiM1RzbXdJWGxTeVU1enRGMUlZdll5WHNnQ0VMdEZK?=
 =?utf-8?B?WVg0Y1dpRTdhZlRNVkNQMXRzNUQ2RVQ0NFpVZ0FneTFNM3hLSlR2L0U3WEc5?=
 =?utf-8?B?RjBaeTZKdWVXMFVMVGxUS29DcHRjeWhnTnRiTmpZUm9GVjdYbldsQnB0WkQ5?=
 =?utf-8?B?U1diU3dtbjhVb3NLRkpIY3lxSUplNHV3TktoOCtFaW5BMTdhOXZSWlpEQ1hF?=
 =?utf-8?B?ZGRTckpNZWlmZGs3STVYRTRkUGpIeDIzOHdaVExuOWQvTE9pU1lkY1QvdkJC?=
 =?utf-8?B?TnpGQXNrOXBob3dyNElhajlMdVBsUTJIS3ZhUTR6dzZRRU8zYTBSRFhKaEhD?=
 =?utf-8?B?ZllPT3dybmQyenBXTTJKK3ZJSTBnYmFVMHZkWTAyaXlIZG5DR1dpdEhpYUpy?=
 =?utf-8?B?VWVYaEY2REpkS08wOTNXcTdiZFcvUDlrdlcxVExNb0NQUVdBQXB2UlpCOFZM?=
 =?utf-8?B?ZWhIcWxuSVhSU2VCRENrWjhIc1BaTTh1UTBvRk9IY0hsT3ROeGFnazE1UXZU?=
 =?utf-8?B?Y0w3UGRsMWszT3FoSUU5SklXVmhpZnR1U3FiY0c3b0xuVm9sUHI4OXhSQlNu?=
 =?utf-8?B?T3RRcDhlZGZzTFpsSTg0a1FXZ1B1VXFJM0o3SmJjNEl6aVB6S2luSXFpN3JK?=
 =?utf-8?B?dW1XbzRxRE9ETlBSRTRGT0NwR0hpRFdlK3NSSDZpYnF5bkcwZk1wSC9meGNW?=
 =?utf-8?Q?qzAumuuRqSpRix4lQlxZv2uVoh85YggJRPIfcFh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44768021-b992-4394-c136-08d92cc802ba
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 10:59:40.2129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7cjaD1uX6ZMYyRqtDxzg3MfhtZNcbi/BeIHn7IJTrqPpdcvXdyaYqedGxr+kChLrtiOFG7KRuF7bZ+2pU5dMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7344
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Lukas Hartmann <lukas@mntmn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bumyong Lee <bumyong.lee@samsung.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Chanho Park <chanho61.park@samsung.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gNi8xMS8yMDIxIDE6MzUgUE0sIEtvbnJhZCBSemVzenV0ZWsgV2lsayB3cm90ZToKPiBPbiBG
cmksIEp1biAxMSwgMjAyMSBhdCAwODoyMTo1M0FNICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3
cm90ZToKPj4gT24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgMDU6NTI6MDdQTSArMDMwMCwgSG9yaWEg
R2VhbnTEgyB3cm90ZToKPj4+IEkndmUgbm90aWNlZCB0aGUgZmFpbHVyZSBhbHNvIGluIHY1LjEw
IGFuZCB2NS4xMSBzdGFibGUga2VybmVscywKPj4+IHNpbmNlIHRoZSBwYXRjaCBzZXQgaGFzIGJl
ZW4gYmFja3BvcnRlZC4KPj4KPj4gRllJLCB0aGVyZSBoYXMgYmVlbiBhIHBhdGNoIG9uIHRoZSBs
aXN0IHRoYXQgc2hvdWxkIGhhdmUgZml4ZWQgdGhpcwo+PiBmb3IgYWJvdXQgYSBtb250aDoKPj4K
Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMTA1MTAwOTE4MTYuR0Ey
MDg0QGxzdC5kZS9ULyNtMGQwZGY2NDkwMzUwYTA4ZGNjMjRjOTA4NmM4ZWRjMTY1YjQwMmQ2Zgo+
Pgo+PiBidXQgaXQgc2VlbXMgbGlrZSBpdCBuZXZlciBnb3QgcGlja2VkIHVwLgo+IAo+IFlpa2Vz
IQo+IAo+IERvbWluaXF1ZSwKPiAKPiBXb3VsZCB5b3UgYmUgdXAgdG8gdGVzdGluZyB0aGUgYXR0
YWNoZWQgKGFuZCBpbmxpbmUpIHBhdGNoIHBsZWFzZT8KPiAKPiBMaW51cywKPiAKPiBXb3VsZCB5
b3UgYmUgdGVycmlibHkgb2ZmZW5kZWQgaWYgSSB0b29rIHlvdXIgY29kZSAocy91bnNpZ25lZAo+
IGxvbmcvdW5zaWduZWQgaW50KSwgYW5kIHVzZWQgQ2hhbmhvJ3MgZGVzY3JpcHRpb24gb2YgdGhl
IHByb2JsZW0gKHNlZSBiZWxvdyk/Cj4gCkJvdGggcGF0Y2hlcyB3b3JrIGZvciBteSBjYXNlLgoK
SG93ZXZlciwgdGhlcmUncyB5ZXQgYW5vdGhlciwgcG9zc2libHkgc2lnbmlmaWNhbnQsIGRpZmZl
cmVuY2UgYi93IHRoZSB0d286CglvZmZzZXQgPSAodGxiX2FkZHIgLSBtZW0tPnN0YXJ0KSAmIChJ
T19UTEJfU0laRSAtIDEpOwp2cy4KCW9mZnNldCA9ICh0bGJfYWRkciAmIChJT19UTEJfU0laRSAt
IDEpKSAtCgkJIHN3aW90bGJfYWxpZ25fb2Zmc2V0KGRldiwgb3JpZ19hZGRyKTsKCkkgdGhpbmsg
YWNjb3VudGluZyBmb3IgdGhlIGFsaWdubWVudCBvZmZzZXQgKHN3aW90bGJfYWxpZ25fb2Zmc2V0
KCkpCmhhcyB0byBiZSBrZXB0LgoKSG9yaWEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
