Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51897C07E9D
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 13:45:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8B861026
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 13:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8B861026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACD8B402AF;
	Mon, 19 Jul 2021 13:45:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YD78f3AP-y2s; Mon, 19 Jul 2021 13:45:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7DDBA402A6;
	Mon, 19 Jul 2021 13:45:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4655EC001A;
	Mon, 19 Jul 2021 13:45:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04CFDC000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 13:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E66F24035A
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 13:45:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=nxp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2SRbVNSJ3ITA for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 13:45:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe05::61b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7262E40356
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 13:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhE7nKv+05R41E7kJwuKZgDAabejP2VazOyHnIXipspoe00yHXosjLH+0O9Vwg0CJpeVNN+hpnZWpEvojKOR3UGHADu5bbpyPU7hYfJbDfi0zxuZ48Qtin/kKL3ahQTd+6bJ+oR30uB+XTJ77VY1dspf8hoBZIC6czPLXmlxA5g5oojNQUf9ZrfEAt+b27WJ7/taG9gAidx3ec2EbNPrHcg+8iNYNewllFbkj1MJveHTFjNfYWl3cOUUbt6pKEbINMEyeDh/A6Y8K3W0FhKr7WfqR4q9SoNSaU2SBrOLd51sBwJZ9BMAkHmlnH/RTqeJ44rHvQxj2odwrz9Tc7RRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMyIdAPFJo/3gdiPvscOdNtFoK0ziJ9yMuo0i9ODrj0=;
 b=nR5axgzDs7oXq0I5cr2buPuvea5+ovvHJsiwUZpmPjr5DWAKvBe09MutbXcnBhti4mXQabFL619XvcfWpYrpowJPOz3eYEsSXMIejWEOor0vAekWvXbb1bvqrmqzNSP6hT8FZ1EXgYi7BxLWKsFvrxGr/KzKCqPlQ2kcNi/7Evg2jmWJ7befmPuBj6b113pi3/dAOuKjshIbeLCN0o+VQpMD66O+1jgjgMc+uq6YRri/KG8ozONZhkD/mWe1w4ukoSYY1oPe6qV70An58gCBC3X/+TfCu7vR8Q8kMX5JqQDMvayrEFspYCG0eM4U+Ff/3wLOVs4/zVJGL4nVKXPRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMyIdAPFJo/3gdiPvscOdNtFoK0ziJ9yMuo0i9ODrj0=;
 b=TgixWQM5I59aWszjtFRasefsIIx2+mjnjd5whgIdNfoqnTAWX4Xt+1MbLl7uOfct8alL3/GKCxo0bAtjcNlgZoI2NxWScBrqWqTXnWtRYgLd29LQp1T9L29QekLlyVg3QObcwEA2vClPrVLw+52J+mpsaHFfeVfhfR6ckIrRDCI=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB3311.eurprd04.prod.outlook.com (2603:10a6:802:f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.28; Mon, 19 Jul
 2021 13:45:36 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 13:45:36 +0000
Subject: Re: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <35db3320-d6e2-721e-8d49-e5e2e80e2359@nxp.com>
Date: Mon, 19 Jul 2021 16:45:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.103] (86.120.185.232) by
 AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 13:45:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e80a487-eaba-4641-bedd-08d94abb7cdc
X-MS-TrafficTypeDiagnostic: VI1PR04MB3311:
X-Microsoft-Antispam-PRVS: <VI1PR04MB331139F666C51A3FEC5E33B7ECE19@VI1PR04MB3311.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQADlS6lUtYVmjhpXBmRwWKeug3kcWrnGyP00LqrWdjenrB9UK8blQHr3qmXmsk5EPgnhD3hjuEqm0/KI3Iw6DCYMpSjihWzo+dkYtVxDU7q7BHbUlTf0Z2auXIWgbhXv4iycX1KYDggJRPGnCb6Xb+p6nHeSnHmjI/sHuQGJWADo1vdUFx9mnaH2EDtfce8Wmfv3srfh1+Lix0HHcslVmQvg18PiC65vaAnhoshU9Gjkt4mKluniYDjpVoWB8I2ApLOIehyH91dj+ehaee8prM8Nq6kYj2vQiqdgDC1O1Sr0OoWXgfq4Z4CImP2rGed2+xZb07CV2U37Z5BNKS+5zEZ3XujMzyyHC8q2mXpM9pCazKNQUJBIIaabPWkM1FN5Kauk6daABVWQZoiV8vrIq7yshcx9ysGj+FIHfxrH6KGB9Q8+qk3Fcjk5sXG039GYkYAEz/5IxFkgmbEOCO/VHrB8IO5vXsh08q6UU+bi+/FYeCnfBjBRBgmhC2nUZ+3Bm+/BJ7ynu+pu7o5rr1i9A6HzKEy8HSrr0xXfM5TbTSH/eYb3j4Wrp6wTxQVSFvNRa3ZMuIlLdt0OYyxUivYA8qCQAQrssyczA5RbegdqJ913AXhgktnZxdXKrP9BtnVMrhNZDYOCVZ3NHu9e5CUB+Qlu3J1bWzf403UFlmWek+2Eq4q1RYxdXxswdWelnv0Ge4LBSQeK8jjdMJQiLiDq+9Fo3UjkUkg8kbBxjzwniXk2B1dnX0WjgFnFb6mFP7G7llZULmfT8vqteN5mapylQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0402MB3405.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(478600001)(7416002)(5660300002)(36756003)(316002)(31686004)(2616005)(956004)(4326008)(38350700002)(38100700002)(2906002)(6486002)(16576012)(44832011)(53546011)(8676002)(83380400001)(66946007)(26005)(186003)(8936002)(52116002)(66476007)(86362001)(31696002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0ZhMFluSDJEd1VHeVQxSVM2K0N2NnYrS25maHJKaWh3aitGV3RoUG9aSUZw?=
 =?utf-8?B?NnoyS29ibVRQZGlROTZ2NG9MaC9xdXpGNmttb0c5RFM5M0doV2Y5ZVRZYWpi?=
 =?utf-8?B?VXUrcTlXc2FEcjFlL1g1OFEwQ1VrZzlYdm00NDlCejgrQ2pBU2FhMmU2MW84?=
 =?utf-8?B?djNVM1BjQ3F1ZkFhSWcwVnI1RzlhUDRMQUd5RnJPcUJkdGRCd0l5OFR1NFF3?=
 =?utf-8?B?WXBlZlI5aTVLaWpHMHhybWFCRkJnV0tJVnBYUVhVT2ZvTDBmZHR2VHBEbnFj?=
 =?utf-8?B?dHdJWmp2eU9vYy8yU0JkM205cVFNc2RvR3FKcnZ5NExvbStESHMxNDIyaFFu?=
 =?utf-8?B?WU82SGI1ME11c21MNnJ2cXdYTWdpT2FDQ3IxQUhkdm51YnlmTGtJeFhKTTA3?=
 =?utf-8?B?dnBFamIvSE12VUU1amF2d3NrOGtPY2ErS1RlUjlidk81WGtpOUNGMzlpUGdC?=
 =?utf-8?B?bDl2WkRWQnRUQUJoN0RQcll5b2owbDI5NjYyRVBFNnVOa2QraGRDajIvTElV?=
 =?utf-8?B?Wmw0cDVIZlVJeDlWZy92V0wxUTZZTVB1ZmJGYVIyaTlaQlhFUlJjaWZ2a2Nh?=
 =?utf-8?B?YzJBSkk0TjYxZVZRVXRFcTVLd2xMZG5WT1lsck54cEtWMlZTdFRidDFaTE0z?=
 =?utf-8?B?ODhxVU1aazFlVmVFdjdtM3MxRlMrSVBHYUVNZng4d3VwVUFtSmVXZVNlUDBH?=
 =?utf-8?B?aHd3b1N3UnB5a1ZveUhUdDFBaTRLSksxUlkvM0puQm0rTXBLcThDZEg3UVBK?=
 =?utf-8?B?ZEFmajA1YngxTVVBVHREZEdEVitjaGlERnd0ajlZek50M01zZm5MaHZyZG83?=
 =?utf-8?B?TVBNK3YzWWpZZjkrZnE4RkFYN25MS2VoNUJtVTlWd3h2YWF3amg2MlNoMk8v?=
 =?utf-8?B?b05ZTnV5N3JwMmtHcXJrYlNRZXAwY3J5WVRCK1J2TTB6bmt0c2s0SjE1d21t?=
 =?utf-8?B?ekFqdmFUSjA3SjQ3YUhTakIvV1RaSE5NbG9OMngvSTVxWE5RY01DaFpyZEI1?=
 =?utf-8?B?bkpRdEpWazFyUVhha1hCUEZCais1RVVVc0RRdkpHNnh0eEpSWldvNFNFWDZS?=
 =?utf-8?B?Nk1zSEVWQk1CekthTnpJajZWRURtNjlhRXFiY2ZSMnVJdDFiYzc4Yi9Mak9P?=
 =?utf-8?B?elJ2WHB3ZWtEaTdmb0JIVkRpZXFuR2NqZTlzd0VZczRheTM4NjdlTGlsUDBh?=
 =?utf-8?B?ek91eUxpODZMVG5xREFRMk1RUDZ1REhEQ1ZyZHFFcS9tOTA2U2J6c1ZqbTEw?=
 =?utf-8?B?NXM3M0JkUGF0YjZscys3S0NsMDNFWnNUN3pyNVpvYVdVcHRqanZqK21LemxX?=
 =?utf-8?B?dzlSQVFCWHlOL1NicHh1SHh2d3BPR3ZYYUVKMXlxMEtrZndraVZZUDRXOWNQ?=
 =?utf-8?B?VWdyTEtETUpWM1VIT29aVFZRaWhLTmkyUW9CQTJvOXBoN25FNEpUMFc4M3U2?=
 =?utf-8?B?SGx0QXNDQnhwNW8zQ2xCSmc4bm5wYmYyNEhSZlpaVS9mNjNvOGw0WXRtSllB?=
 =?utf-8?B?bU0yVzhzNWhYYkdva250cjZBVURpSXkrYXIrMVVReHR4TzJISGZWRVViMVdI?=
 =?utf-8?B?VFAwWFlsRURtVStrQmRmcGJkMVM3OEZjdWxCbDRKN0YvbFdoT2daaHhmN3BP?=
 =?utf-8?B?cnZxT2lzMmMvR0IwSGk3ZEhkbFBVOUpTY0Z3RFgwa2F1bjhrYVNqSjVReXg4?=
 =?utf-8?B?NXJrM25vRWYxMWMrKzY0OWN5T0JYekMwMXFRQ0dSVlV0NFNHNFRCb0dzV05K?=
 =?utf-8?Q?hYUnChVg6p5r82FPxkPPf5+MPOZ6nmY8OJkIPco?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e80a487-eaba-4641-bedd-08d94abb7cdc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 13:45:36.7814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4WVInvvSg9itRpBGQOhsYTEGsUw9t7EdPwaGx1QyM8DPrVFegUFQB6iuPuzvQ2XBjd684DYgcrwWul9SR9oZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3311
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, wanghuiqiang@huawei.com
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

T24gNy8xNi8yMDIxIDExOjM0IEFNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOgo+IEhpLAo+IAo+
IE1ham9yIENoYW5nZXMgZnJvbSB2NToKPiAtIEFkZHJlc3NlZCBjb21tZW50cyBmcm9tIFJvYmlu
ICYgTG9yZW56by4KPiAgIDogTW92ZWQgaW9ydF9wYXJzZV9ybXIoKSB0byBhY3BpX2lvcnRfaW5p
dCgpIGZyb20KPiAgICAgaW9ydF9pbml0X3BsYXRmb3JtX2RldmljZXMoKS4KPiAgIDogUmVtb3Zl
ZCB1c2Ugb2Ygc3RydWN0IGlvcnRfcm1yX2VudHJ5IGR1cmluZyB0aGUgaW5pdGlhbAo+ICAgICBw
YXJzZS4gVXNpbmcgc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGluc3RlYWQuCj4gICA6IFJlcG9y
dCBSTVIgYWRkcmVzcyBhbGlnbm1lbnQgYW5kIG92ZXJsYXAgZXJyb3JzLCBidXQgY29udGludWUu
Cj4gICA6IFJld29ya2VkIGFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoKSAocGF0Y2ggIyA2KS4K
PiAtIFVwZGF0ZWQgU01NVXYyIGJ5cGFzcyBTTVIgY29kZS4gVGhhbmtzIHRvIEpvbiBOIChwYXRj
aCAjOCkuCj4gLSBTZXQgSU9NTVUgcHJvdGVjdGlvbiBmbGFncyhJT01NVV9DQUNIRSwgSU9NTVVf
TU1JTykgYmFzZWQKPiAgIG9uIFR5cGUgb2YgUk1SIHJlZ2lvbi4gU3VnZ2VzdGVkIGJ5IEpvbiBO
Lgo+IAo+IFNhbml0eSB0ZXN0ZWQgb24gYSBIaVNpbGljb24gRDA2KFNNTVV2MykuIEZ1cnRoZXIg
dGVzdGluZyBhbmQKPiBmZWVkYmFjayBpcyBncmVhdGx5IGFwcHJlY2lhdGVkLgo+IAo+IFRoYW5r
cywKPiBTaGFtZWVyCj4gCj4gLS0tLS0tCj4gdjQgLS0+IHY1Cj4gIC1BZGRlZCBhIGZ3X2RhdGEg
dW5pb24gdG8gc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGFuZCByZW1vdmVkCj4gICBzdHJ1Y3Qg
aW9tbXVfcm1yIChCYXNlZCBvbiBjb21tZW50cyBmcm9tIEpvZXJnL1JvYmluKS4KPiAgLUFkZGVk
IGlvbW11X3B1dF9ybXJzKCkgdG8gcmVsZWFzZSBtZW0uCj4gIC1UaGFua3MgdG8gU3RldmUgZm9y
IHZlcmlmeWluZyBvbiBTTU1VdjIsIGJ1dCBub3QgYWRkZWQgdGhlIFRlc3RlZC1ieQo+ICAgeWV0
IGJlY2F1c2Ugb2YgdGhlIGFib3ZlIGNoYW5nZXMuCj4gCj4gdjMgLS0+djQKPiAtSW5jbHVkZWQg
dGhlIFNNTVV2MiBTTVIgYnlwYXNzIGluc3RhbGwgY2hhbmdlcyBzdWdnZXN0ZWQgYnkKPiAgU3Rl
dmUocGF0Y2ggIzcpCj4gLUFzIHBlciBSb2JpbidzIGNvbW1lbnRzLCBSTVIgcmVzZXJ2ZSBpbXBs
ZW1lbnRhdGlvbiBpcyBub3cKPiAgbW9yZSBnZW5lcmljICAocGF0Y2ggIzgpIGFuZCBkcm9wcGVk
IHYzIHBhdGNoZXMgOCBhbmQgMTAuCj4gLVJlYmFzZSB0byA1LjEzLXJjMQo+IAo+IFJGQyB2MiAt
LT4gdjMKPiAgLURyb3BwZWQgUkZDIHRhZyBhcyB0aGUgQUNQSUNBIGhlYWRlciBjaGFuZ2VzIGFy
ZSBub3cgcmVhZHkgdG8gYmUKPiAgIHBhcnQgb2YgNS4xM1swXS4gQnV0IHRoaXMgc2VyaWVzIHN0
aWxsIGhhcyBhIGRlcGVuZGVuY3kgb24gdGhhdCBwYXRjaC4KPiAgLUFkZGVkIElPUlQgRS5iIHJl
bGF0ZWQgY2hhbmdlcyhub2RlIGZsYWdzLCBfRFNNIGZ1bmN0aW9uIDUgY2hlY2tzIGZvcgo+ICAg
UENJZSkuCj4gIC1DaGFuZ2VkIFJNUiB0byBzdHJlYW0gaWQgbWFwcGluZyBmcm9tIE06TiB0byBN
OjEgYXMgcGVyIHRoZSBzcGVjIGFuZAo+ICAgZGlzY3Vzc2lvbiBoZXJlWzFdLgo+ICAtTGFzdCB0
d28gcGF0Y2hlcyBhZGQgc3VwcG9ydCBmb3IgU01NVXYyKFRoYW5rcyB0byBKb24gTmV0dGxldG9u
ISkKPiAtLS0tLS0KPiAKPiBKb24gTmV0dGxldG9uICgxKToKPiAgIGlvbW11L2FybS1zbW11OiBH
ZXQgYXNzb2NpYXRlZCBSTVIgaW5mbyBhbmQgaW5zdGFsbCBieXBhc3MgU01SCj4gCj4gU2hhbWVl
ciBLb2xvdGh1bSAoOCk6Cj4gICBpb21tdTogSW50cm9kdWNlIGEgdW5pb24gdG8gc3RydWN0IGlv
bW11X3Jlc3ZfcmVnaW9uCj4gICBBQ1BJL0lPUlQ6IEFkZCBzdXBwb3J0IGZvciBSTVIgbm9kZSBw
YXJzaW5nCj4gICBpb21tdS9kbWE6IEludHJvZHVjZSBnZW5lcmljIGhlbHBlciB0byByZXRyaWV2
ZSBSTVIgaW5mbwo+ICAgQUNQSS9JT1JUOiBBZGQgYSBoZWxwZXIgdG8gcmV0cmlldmUgUk1SIG1l
bW9yeSByZWdpb25zCj4gICBpb21tdS9hcm0tc21tdS12MzogSW50cm9kdWNlIHN0cnRhYiBpbml0
IGhlbHBlcgo+ICAgaW9tbXUvYXJtLXNtbXUtdjM6IFJlZmFjdG9ywqBhcm1fc21tdV9pbml0X2J5
cGFzc19zdGVzKCkgdG8gZm9yY2UKPiAgICAgYnlwYXNzCj4gICBpb21tdS9hcm0tc21tdS12Mzog
R2V0IGFzc29jaWF0ZWQgUk1SIGluZm8gYW5kIGluc3RhbGwgYnlwYXNzIFNURQo+ICAgaW9tbXUv
ZG1hOiBSZXNlcnZlIGFueSBSTVIgcmVnaW9ucyBhc3NvY2lhdGVkIHdpdGggYSBkZXYKPiAKPiAg
ZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyAgICAgICAgICAgICAgICAgICB8IDE3MiArKysrKysr
KysrKysrKysrKysrLQo+ICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12
My5jIHwgIDc2ICsrKysrKystLQo+ICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21t
dS5jICAgICAgIHwgIDQ4ICsrKysrKwo+ICBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jICAgICAg
ICAgICAgICAgICAgIHwgIDg5ICsrKysrKysrKy0KPiAgaW5jbHVkZS9saW51eC9hY3BpX2lvcnQu
aCAgICAgICAgICAgICAgICAgICB8ICAgNyArCj4gIGluY2x1ZGUvbGludXgvZG1hLWlvbW11Lmgg
ICAgICAgICAgICAgICAgICAgfCAgMTMgKysKPiAgaW5jbHVkZS9saW51eC9pb21tdS5oICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxMSArKwo+ICA3IGZpbGVzIGNoYW5nZWQsIDM5MyBpbnNlcnRp
b25zKCspLCAyMyBkZWxldGlvbnMoLSkKPgpWYWxpZGF0ZWQgb24gYSBOWFAgTFgyMTYwQSB3aXRo
IFNNTVV2Miwgc286CgpUZXN0ZWQtYnk6IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9y
QG54cC5jb20+CgotLS0KVGhhbmtzICYgQmVzdCBSZWdhcmRzLCBMYXVyZW50aXUKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
