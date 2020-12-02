Return-Path: <SRS0=nZOb=FG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216F5C64E8A
	for <iommu@archiver.kernel.org>; Wed,  2 Dec 2020 10:45:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624CE221FC
	for <iommu@archiver.kernel.org>; Wed,  2 Dec 2020 10:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624CE221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C4C912E24E;
	Wed,  2 Dec 2020 10:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ysjrb-O1x8bN; Wed,  2 Dec 2020 10:45:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ED2BA2E24B;
	Wed,  2 Dec 2020 10:45:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3D30C163C;
	Wed,  2 Dec 2020 10:45:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 367A2C163C
 for <iommu@lists.linux-foundation.org>; Wed,  2 Dec 2020 10:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3210C87924
 for <iommu@lists.linux-foundation.org>; Wed,  2 Dec 2020 10:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A8ErncwZL992 for <iommu@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 10:45:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8704087921
 for <iommu@lists.linux-foundation.org>; Wed,  2 Dec 2020 10:45:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzekZpwimYDiRNJHgWsZ1LaajV+cjjilPEMJtj397J+sil7v8O9H5QtJAPUMmHPg9JJkFPRgTnDhBXoDLKLsMwmMeqh1cle40GRStLy7U2NZltQjpg/1vXi37vRCpZ+uE1h6QssDZD/z71SzHMd4Gu/V0XrgreCZTCaPw/dp0ejX3wOLLH62z9JMlMttqWc3BvaNpI2zNaxza1kS0F8E0e9fExKQlBnQbMcMMlZjAj7dgBFZn+CjLFAwIvnaRwOCnMz/M3lpX9wp2cfZkENiH9ThXnwXn322ac6yLLk1elsV6nPauLH8E6eFnAhYvYYukStCMU/Kzo5wQcucWBlmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6RPdFe492QyL7bjb1cwo6/Rl9vjifuf3p+So0eSeys=;
 b=WNQtYOuwqn8I7riJ9VhA8lUnOjNXFo2v5rapgZmE48A8uR/CmFAFm0QzrBaq4CZpg2FuSowguDsucwmGK70tTEExLzSjlq1yThQG3/6l+enxkp5EwtLwGrZdLRZsPJQcAMIgRKqH5uzNP1CYlw9UgCYeBQKkQVCeSqSbv60s217dtPmM7kZuYog/BKBM7eLMa2F/7+/W4rgjs6CDUhBkbvqE4t7oAywaVxChUYr3Droyok2bMJ/YuuCw8WvYM+DZ3/LDq0rpD+L0eeb9km1ktPmWRnObONprVTWTedwyXtaQM12L8D+KFlLO+1HmMsf02emrvKMVzf2yRtov+p562g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6RPdFe492QyL7bjb1cwo6/Rl9vjifuf3p+So0eSeys=;
 b=hhKkiO5TTRAVdKzL/Etwz6S/cUaLMzlTQ4FMInq5MyCcYlAg71wmQchI91R2afUyKeuOZsqUfRAjFtQj2nHc4iog9BevlWQGc9IZu/rGxaQGy7rH0TRngXoC0wDnZ8xR3fiS6FgxQNdgvFmHW558mM6AcmDWmEKh9bpAcrO23Sw=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB3792.eurprd04.prod.outlook.com (2603:10a6:803:20::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 10:29:32 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::6467:fb5:1181:e8b2%7]) with mapi id 15.20.3611.032; Wed, 2 Dec 2020
 10:29:32 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] iommu: arm-smmu-impl: add NXP hook to preserve
 bootmappings
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20201125155009.18453-1-laurentiu.tudor@nxp.com>
 <30296756-9b8d-4851-87f0-8c4bd41110e9@arm.com>
Message-ID: <74e4f42a-83bf-fa88-a807-5c3a60aad4e6@nxp.com>
Date: Wed, 2 Dec 2020 12:29:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <30296756-9b8d-4851-87f0-8c4bd41110e9@arm.com>
Content-Language: en-US
X-Originating-IP: [188.25.99.172]
X-ClientProxiedBy: AM0PR04CA0093.eurprd04.prod.outlook.com
 (2603:10a6:208:be::34) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (188.25.99.172) by
 AM0PR04CA0093.eurprd04.prod.outlook.com (2603:10a6:208:be::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18 via Frontend Transport; Wed, 2 Dec 2020 10:29:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b21a36a-0fe0-4290-b740-08d896ad27f6
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB379227B54413FB1CEEB3F134ECF30@VI1PR0402MB3792.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Vl94ULevMTqxJMXYdTRxnTo1WGExAFbGDmPHS92DaC1feTDnFqsi+LSo69mWO8KsaEMmBTcxO1Q+CU5OBzgyKN8mBic3NMAxGtDFk8V5uejcemEP6i44LjNv3WhqbcEj0tjwIB0FFshjldDsixt7c2JWHNuFJsCQFD5a4SHtd1q244/Jxi1vxrf2fCt0kkBzn5I/uK1RxlnilZGLGoiPpkdVchsaVAQ9tWUvagd/HNY0actO3kQrzoiVdXb6oFnKPr53lKE18N+ANqypLJBsDLw8/HgoEK3K5k+PYyqmLn/s6JIYf7hQuvla30YI52dOuIBeqkjVnGYMEG0LctIRsmAQfTS7Bfh7TRP70lHWoY8j/TW/JCK2xKeqY1UUtwd/EoorKV6lVK4e+0eQqLLEksFQKJmmS+NPq8ElQsvXBSWYSqXyyJqYUmnXuHDykU74IULA5/GDYol2kSckqdfx+XbwtOAvChsVJsmhWEg4198lPqSbPDvnhccQny7Hh52
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0402MB3405.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(316002)(8676002)(2906002)(66556008)(6486002)(2616005)(956004)(966005)(86362001)(16576012)(8936002)(31696002)(66946007)(4001150100001)(36756003)(5660300002)(83380400001)(186003)(52116002)(66476007)(4326008)(53546011)(44832011)(16526019)(31686004)(478600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dk1vYUNLV2I1eHYxM2s5aC9HUzJGd1VzVXkyV1NZaWtCVU5lMjhBd01DS0dJ?=
 =?utf-8?B?VVAxY09keGVaREVFMU81OEE2YllZd3gwdkMzWmU1N0dxdE9oM1hFRm1rK0Vi?=
 =?utf-8?B?T1dQb01ucUNXR0hjelZoaWEwSWN1M1YwWVI0MFdHU0JwTE42USt0eEl3VWx6?=
 =?utf-8?B?RFpvRjhwNHVYbUNjR01YaXpZQUJZbEJLMUpJNkp4TE5EaDdLZDhvMmt6OXQ5?=
 =?utf-8?B?dThVQjdsUXYxbkVFVXMwaUNMSzNOcUJpRjdYVnZHeTdObitEVXNwYkhzZ1BT?=
 =?utf-8?B?c3pWQVN1VndCckVOUEIwSStBekpoVU1COVc5L2FhVTUycXhGVDMvajltVXh4?=
 =?utf-8?B?Uk9SV1ZEVEVxSUhlM1FpQU5QeUMrMmZKNWdNb3BBVEltN3NhcW5qUERsMWhJ?=
 =?utf-8?B?cXhHMFJUbC93ZGNmanpFQi9Qd3hKMkJvSHB6RWNRdkRaMDRmOFhZU3JCWjlK?=
 =?utf-8?B?MUVZUDRjWkZOQ2NHenJRNlN1WXNIamx2ZnlhWWEyeGJKNnZjV3dDN05EWkxJ?=
 =?utf-8?B?a21sNGh0NmJYeXR1Uk9vL3hnNTVrQ213Q1ZuVzNkQWR6QlJEVkxJUjBWUjNY?=
 =?utf-8?B?SG9zYm9ZQUd6ek5TT2hPSW5ZcEJUeTFCQjhrMU5RdDd3VFF2bFV0T01uK0hi?=
 =?utf-8?B?OFViNFVxc1pMalVWWGkya2draXBxZnk5Z21NY0MzYzdoMW1ueXArQlVjTWIz?=
 =?utf-8?B?MVVHVjNlVzJaOWdHVmRFVmlXcXE0N0JBSmFVODNIeTErZmg3WWRHUndNd3B0?=
 =?utf-8?B?Q0V4bXo5ZlYySjlPWHVIN3JzdVI0NXdjeUxBdlhLUnFxYjJPRXo0ZHM4eXd1?=
 =?utf-8?B?OFdSWUVZclJML3pPTjV3VnlHNkd4WlNRaFlQNGRKZWI4N3lEM2dLalFML2pv?=
 =?utf-8?B?aklFVkxXcS9LZGpjYnZHY2tNLzhKZzJjejRrZndCTUhXYTFGVWtoZVF3TnhQ?=
 =?utf-8?B?cnpJZFZvS0tVYlNxUDJkUGdDK3RtbjFBdm9SVGhrcnpzdGJrTFArT0lDeEJw?=
 =?utf-8?B?TnRndm9odUdUQnNYRktVNDhySkE4OUtwUTFxQm53UmtXT0l5cGNKajQ5RC9R?=
 =?utf-8?B?VC9tKzM4Nm90NlpCU2hXb1Q2K0NMS2t5QWxqdVA2NjhMOTRnbE1ya3p2Y2J2?=
 =?utf-8?B?aW9JSTF3TG9uaVFZcEVBNHdDcGpodytvUUNKbUpROEkwcmNHOG82Vy95a0dv?=
 =?utf-8?B?V3BnWnRqN3IzV0Q3ZVBHRjM5SGxRdFhXejllSE45Q3VpRHZSMjZBT3piY2Rt?=
 =?utf-8?B?aUVnV3Erb3ZPVHVsNUllMlN1clp1S28wc0w1c1BVbGNja0YrV1Nrenkxd1F4?=
 =?utf-8?Q?651+cgXSDdjT6rsRifX/Qcxuy2IO0K4uQd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b21a36a-0fe0-4290-b740-08d896ad27f6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 10:29:32.3460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctZmzkTgDO8cBP94en+aNx8CqOFlFCvCM4OWj3ags8KSye99+Lg5vHF6+SBi1HepAnjRv4N9OAZWjYdgCVqTlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3792
Cc: diana.craciun@nxp.com
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

SGkgUm9iaW4sCgpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHksIHdlIGhhZCBhIGZldyBkYXlzIG9m
IG92ZXIgaGVyZS4gQ29tbWVudHMgaW5saW5lLgoKT24gMTEvMjUvMjAyMCA4OjEwIFBNLCBSb2Jp
biBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMC0xMS0yNSAxNTo1MCwgbGF1cmVudGl1LnR1ZG9yQG54
cC5jb20gd3JvdGU6Cj4+IEZyb206IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54
cC5jb20+Cj4+Cj4+IEFkZCBhIE5YUCBzcGVjaWZpYyBob29rIHRvIHByZXNlcnZlIFNNTVUgbWFw
cGluZ3MgcHJlc2VudCBhdAo+PiBib290IHRpbWUgKGNyZWF0ZWQgYnkgdGhlIGJvb3QgbG9hZGVy
KS4gVGhlc2UgYXJlIG5lZWRlZCBmb3IKPj4gTUMgZmlybXdhcmUgcHJlc2VudCBvbiBzb21lIE5Y
UCBjaGlwcyB0byBjb250aW51ZSB3b3JraW5nCj4+IGFjcm9zcyBrZXJuZWwgYm9vdCBhbmQgU01N
VSBpbml0aWFsaXphdGlvbi4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTGF1cmVudGl1IFR1ZG9yIDxs
YXVyZW50aXUudHVkb3JAbnhwLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11L2FybS1zbW11LWltcGwuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysKPj4gwqAg
MSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LWltcGwuYwo+PiBiL2RyaXZlcnMvaW9tbXUv
YXJtL2FybS1zbW11L2FybS1zbW11LWltcGwuYwo+PiBpbmRleCA3ZmVkODljOWQxOGEuLmNhMDdk
OWQ0YmU2OSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNt
bXUtaW1wbC5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LWlt
cGwuYwo+PiBAQCAtMTg3LDYgKzE4NywzNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFybV9zbW11
X2ltcGwKPj4gbXJ2bF9tbXU1MDBfaW1wbCA9IHsKPj4gwqDCoMKgwqDCoCAucmVzZXQgPSBhcm1f
bW11NTAwX3Jlc2V0LAo+PiDCoCB9Owo+PiDCoCArc3RhdGljIGludCBueHBfY2ZnX3Byb2JlKHN0
cnVjdCBhcm1fc21tdV9kZXZpY2UgKnNtbXUpCj4+ICt7Cj4+ICvCoMKgwqAgaW50IGksIGNudCA9
IDA7Cj4+ICvCoMKgwqAgdTMyIHNtcjsKPj4gKwo+PiArwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBz
bW11LT5udW1fbWFwcGluZ19ncm91cHM7IGkrKykgewo+PiArwqDCoMKgwqDCoMKgwqAgc21yID0g
YXJtX3NtbXVfZ3IwX3JlYWQoc21tdSwgQVJNX1NNTVVfR1IwX1NNUihpKSk7Cj4+ICsKPj4gK8Kg
wqDCoMKgwqDCoMKgIGlmIChGSUVMRF9HRVQoQVJNX1NNTVVfU01SX1ZBTElELCBzbXIpKSB7Cj4g
Cj4gSSBiZXQgdGhpcyBpcyBmdW4gb3ZlciBrZXhlYy4uLgoKUmlnaHQuIEkgaGF2ZW4ndCBldmVu
IGNvbnNpZGVyZWQga2V4ZWMuCgo+IE5vdGUgdGhhdCB0aGUgUXVhbGNvbW0gc3BlY2lhbCBjYXNl
IGdvdCBhIGJpdCBvZiBhIGZyZWUgcGFzcyBzaW5jZSBpdAo+IGludm9sdmVzIHdvcmtpbmcgYXJv
dW5kIGEgdG90YWxseSBicm9rZW4gaHlwZXJ2aXNvciwgcGx1cyBnZXRzIHRvIHBsYXkKPiB0aGUg
Im5vYm9keSBzYW5lIHdpbGwgcnVuIGFuIGVudGVycHJpc2UgZGlzdHJvIG9uIHRoZWlyIHBob25l
IiBjYXJkIHRvCj4gYW4gZXh0ZW50OyBJIGRvbid0IHRoaW5rIHRoZSBsaWtlcyBvZiBMYXllcnNj
YXBlIGtpdCBnZXQgaXQgcXVpdGUgc28KPiBlYXN5IDspCgpJIGFncmVlIHRoYXQgdGhpcyBpcyBu
b3QgaWRlYWwsIGJ1dCB0aGUgcGxhbiBoZXJlIHdhcyB0byBoYXZlIHNvbWV0aGluZwp0byBib290
IHZhbmlsbGEga2VybmVsIE9PQiBvbiBvdXIgY2hpcHMsIHdoaWNoIGlzIHNvbWV0aGluZyBvbiBt
eSBtaW5kCmZvciBxdWl0ZSBhIHdoaWxlIG5vdy4gSSBkbyByZWFsaXplIHRoYXQgd2Ugd29uJ3Qg
Z2V0IGF3YXkgd2l0aCBpdAppbiB0aGUgbG9uZyBydW4uCgo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzbW11LT5zbXJzW2ldLmlkID0gRklFTERfR0VUKEFSTV9TTU1VX1NNUl9JRCwgc21yKTsK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc21tdS0+c21yc1tpXS5tYXNrID0gRklFTERfR0VU
KEFSTV9TTU1VX1NNUl9NQVNLLCBzbXIpOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbW11
LT5zbXJzW2ldLnZhbGlkID0gdHJ1ZTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
bW11LT5zMmNyc1tpXS50eXBlID0gUzJDUl9UWVBFX0JZUEFTUzsKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc21tdS0+czJjcnNbaV0ucHJpdmNmZyA9IFMyQ1JfUFJJVkNGR19ERUZBVUxUOwo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbW11LT5zMmNyc1tpXS5jYm5keCA9IDB4ZmY7Cj4+
ICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY250Kys7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9
Cj4+ICvCoMKgwqAgfQo+PiArCj4+ICvCoMKgwqAgZGV2X25vdGljZShzbW11LT5kZXYsICJcdHBy
ZXNlcnZlZCAlZCBib290IG1hcHBpbmclc1xuIiwgY250LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY250ID09IDEgPyAiIiA6ICJzIik7Cj4gCj4gVGhhdCBnZXRzIHlvdSBhcm91bmQgdGhlIGlu
aXRpYWwgU01NVSByZXNldCwgYnV0IHdoYXQgaGFwcGVucyBmb3IgdGhlCj4gYXJiaXRyYXJpbHkg
bG9uZyBwZXJpb2Qgb2YgdGltZSBiZXR3ZWVuIHRoZSBNQyBkZXZpY2UgZ2V0dGluZyBhdHRhY2hl
ZAo+IHRvIGEgZGVmYXVsdCBkb21haW4gYW5kIHRoZSBNQyBkcml2ZXIgYWN0dWFsbHkgcHJvYmlu
ZyBhbmQgKHByZXN1bWFibHkpCj4gYmVpbmcgYWJsZSB0byBtYXAgYW5kIHJlaW5pdGlhbGlzZSBp
dHMgZmlybXdhcmU/CgpQZXJoYXBzIEknbSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IHdvbid0IHRo
ZSBNQyBmaXJtd2FyZSBsaXZlIGJhc2VkIG9uCnRoaXMgYnlwYXNzIG1hcHBpbmcgY3JlYXRlZCBi
eSB0aGUgYm9vdGxvYWRlciBhbmQgdGhhdCBnZXRzIHByZXNlcnZlZD8KCj4+ICsKPj4gK8KgwqDC
oCByZXR1cm4gMDsKPj4gK30KPj4gKwo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBhcm1fc21tdV9p
bXBsIG54cF9pbXBsID0gewo+PiArwqDCoMKgIC5jZmdfcHJvYmUgPSBueHBfY2ZnX3Byb2JlLAo+
PiArfTsKPiAKPiBJIGJlbGlldmUgeW91J3JlIG1vc3RseSB1c2luZyBNTVUtNTAwLCBzbyB5b3Ug
cHJvYmFibHkgZG9uJ3Qgd2FudCB0bwo+IHNpbXBseSB0aHJvdyBvdXQgdGhlIHJlbGV2YW50IGVy
cmF0YSB3b3JrYXJvdW5kcy4KPiAKPj4gwqAgc3RydWN0IGFybV9zbW11X2RldmljZSAqYXJtX3Nt
bXVfaW1wbF9pbml0KHN0cnVjdCBhcm1fc21tdV9kZXZpY2UKPj4gKnNtbXUpCj4+IMKgIHsKPj4g
QEAgLTIyNiw1ICsyNTYsOCBAQCBzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICphcm1fc21tdV9pbXBs
X2luaXQoc3RydWN0Cj4+IGFybV9zbW11X2RldmljZSAqc21tdSkKPj4gwqDCoMKgwqDCoCBpZiAo
b2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAsICJtYXJ2ZWxsLGFwODA2LXNtbXUtNTAwIikpCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBzbW11LT5pbXBsID0gJm1ydmxfbW11NTAwX2ltcGw7Cj4+IMKg
ICvCoMKgwqAgaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgIm54cCxrZWVwLWJvb3QtbWFw
cGluZ3MiKSkKPj4gK8KgwqDCoMKgwqDCoMKgIHNtbXUtPmltcGwgPSAmbnhwX2ltcGw7Cj4gCj4g
Tm9ybWFsbHkgeW91J2QgZ2V0IGEgIndoYXQgYWJvdXQgQUNQST8iIGhlcmUsIGJ1dCBnaXZlbiB0
aGUgbnVtYmVyIG9mCj4gY2FsbHMgYW5kIGVtYWlsIHRocmVhZHMgd2UndmUgaGFkIHNwZWNpZmlj
YWxseSBhYm91dCB0cnlpbmcgdG8gbWFrZSBBQ1BJCj4gc3VwcG9ydCBmb3IgdGhlc2UgcGxhdGZv
cm1zIHdvcmssIHRoYXQgZ2V0cyB1cGdyYWRlZCB0byBhdCBsZWFzdCBhICJXSEFUCj4gQUJPVVQg
QUNQSSE/IiA6UApJIGRvIGhhdmUgQUNQSSBpbiBtaW5kLCBidXQgZm9yIG5vdyBJIGp1c3Qgd2Fu
dGVkIHRvIGhhdmUgYQpmaXJzdCBpbXByZXNzaW9uIG9uIHRoZSBhcHByb2FjaC4gT25lIGlkZWEg
SSB3YXMgcG9uZGVyaW5nIG9uIHdhcyB0bwpoYXZlIHRoaXMgcHJvcGVydHkgaW4gdGhlIE1DIG5v
ZGUgKHF1aWNrIHJlbWluZGVyOiBNQyBpcyBleHBvc2VkIGFzIGEgTkMKaW4gQUNQSSwgc2hvdWxk
IGJlIGFibGUgdG8gcmVwbGljYXRlIHRoZSBwcm9wZXJ0eSBpbiB0aGVyZSB0b28pLiBJbiB0aGUK
bWVhbiB0aW1lLCB3ZSBhcmUgaW4gY29sbGFib3JhdGlvbiB3aXRoIG91ciBwYXJ0bmVycyBvbiB1
c2luZyBSTVJSIGJ5CmFkZGluZyBzdXBwb3J0IGZvciBpdCBpbiB0aGUgYXJtLXNtbXUtdjIgZHJp
dmVyLgoKPiBCdXQgc2VyaW91c2x5LCB0aGUgY2FzZSBvZiBkZXZpY2UgZmlybXdhcmUgaW4gbWVt
b3J5IGJlaW5nIGFjdGl2ZSBiZWZvcmUKPiBoYW5kb3ZlciB0byBMaW51eCBpcyAqbGl0ZXJhbGx5
KiB0aGUgb3JpZ2luYWwgcmVhc29uIGJlaGluZCBJT1JUIFJNUnMuCj4gV2UgYWxyZWFkeSBrbm93
IHdlIG5lZWQgYSB3YXkgdG8gc3BlY2lmeSB0aGUgZXF1aXZhbGVudCB0aGluZyBmb3IgRFQKPiBz
eXN0ZW1zLCBzdWNoIHRoYXQgYm90aCBjYW4gYmUgaGFuZGxlZCBjb21tb25seS4gSSByZWFsbHkg
ZG9uJ3Qgd2FudCB0bwo+IGhhdmUgdG8gc3VwcG9ydCBhIHZlbmRvci1zcGVjaWZpYyBtZWNoYW5p
c20gZm9yIG5vdC1ldmVuLWZ1bGx5LXNvbHZpbmcgYQo+IGNvbXBsZXRlbHkgZ2VuZXJpYyBpc3N1
ZSwgc29ycnkuCj4gCgpJIHJlbWVtYmVyIHRoYXQgc29tZSBtb250aHMgYWdvIHRoZXJlIHdhcyBh
IHByb3Bvc2FsIGZyb20gbnZpZGlhIFsxXSB0bwptYXAgcGVyLWRldmljZSByZXNlcnZlZCBtZW1v
cnkgaW50byBTTU1VLiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIHJldml2ZQppdCBhcyBpdCBzZWVt
ZWQgYSB2aWFibGUgc29sdXRpb24gZm9yIG91ciBjYXNlIHRvbz8KClsxXQpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtYXJtLWtlcm5lbC9saXN0Lz9zZXJpZXM9MjEz
NzAxJnN0YXRlPSUyQSZhcmNoaXZlPWJvdGgKCi0tLQpCZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
