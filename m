Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE61C4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 09:46:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66256109D
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 09:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D66256109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=motorola.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F9EE80EAB;
	Fri, 13 Aug 2021 09:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yKY5bHbpbYQd; Fri, 13 Aug 2021 09:46:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4479380E88;
	Fri, 13 Aug 2021 09:46:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E1A1C0010;
	Fri, 13 Aug 2021 09:46:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F012C000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 09:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 60FBD6070B
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 09:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=motorola.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qiMxEfjYb8yY for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 09:46:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com
 [67.219.246.2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46415606E0
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
 s=Selector; t=1628847970; i=@motorola.com;
 bh=jtf0qfEVBSFR9OZwE66GX8xd2U6W042cRPIu1NOnJr0=;
 h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=sOAUNNqqwh5lkCiQ+8s0Ev8y1UOIljbUun/AgDQZa49eb0fBR8CLT/Fc4z2++CxaS
 m2Hggj5lyAirxGxlCnfUxN3exHnEr31GgpKDNpCPr7UQ5pujIb1BCBktt7+vw1L0PD
 g4wEZS4OdETGZmMHg08mH2BlfLGEQwewRIr7yAMPawuTXPmM/GOAeOQihTAPppZ2JR
 sJycCAkvh1VBimOVUpxdyhhrpMKsMgSkQRnMOp4UJnx5Grjdc5c8STJrbSSEipTXZY
 ovWWofgYzMamO6UZbD0ZZ/M9kVFRf1XLqymOJ1AdIlyoZluUKQGKaYmB58J3yVVlm2
 2Vb3Ut4iHYkeQ==
Received: from [100.112.2.115] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-b.us-east-1.aws.symcld.net id ED/00-03042-16F36116;
 Fri, 13 Aug 2021 09:46:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf1AUZRjHeW/3dteLw+W4k1cCzBvMwfGOO1N
 auwIZRNaEUJn+sCJb4rq76Tjo9lDICUnAAhNuAFEIkBDSTpK6QWuQIAkwNGAiYLCIH8LkADLA
 GaSU1C6LVv88832ez/s8z/fdeZdAZIW4D6FPtemtFsasxCSoMSj9ORUTuobRHJtQUmV1tRg1X
 7eIUJ9dbBNRlc066qeGMowaqv1bTH3e+itOfTo/g1PXZsfFVGH/gniHhK6tqAX0WPmXOO105G
 C001WA09+f+ROlCwfOA/rqrQyMnmnqw+i8egeg7zn990peEZss8Umpb4iN3bPFSHLDxtT+O1l
 4Brj/dC6QEICsQeDYtAsISTsK2/J7RUJyBcDrvb14LlhFyMhKEZxrVvNARg4DeKerSMQDjNwA
 T063ojyQk00oLC51LAMvMhfAj6eAAD4A0Dm0iPBATu6CN/tOYbxGuW57X+Vyg5SMg0v182JhR
 YEIdo3f5boJYhWpg99VhfNnAOkHi28PL59HSG9YXlwq5jUkSVjd2I0IWgEnxpbEwh0+BPDnRT
 suAD/Yc/YEEHQ0bKsfXqlvhtnd9SJ+FyQD4FJLmlBOhl1DP2KC3giz5ipWdvlDx8lRVNDrYHH
 VzMoYXzgy8BXG74WkHYODDy4BIfkNgT2uhyvuNLBioXXlVKMntI/cBXagKv3PjUo5IwgZCOsa
 goTyelh0YhQvXf5InrCjZBytBKgDbIu3mgxGWyJjMqu0Go1Kq92ieka1bauaeVcVr05hVXqGt
 am0auYwq2bTEt80J6gtepsTcO8wIRkJ/ho8mJpVt4C1hEipkH7RKWdkHvFJCWlGhjUetKaY9W
 wL8CUIJZROB6xhZJ5WvUGf+pbJzL3mRxgS7kq5tPV5DkvZZCaRNRkEdANEEPaJ8iqEOH65got
 /ZH7CxQ5HNRdby2uqEBlqSbLofbylO0O4ZpJvNqZYHo9+9K/0AD8fLylwc3OTuSfrrYkm2//5
 JPAmgNJLGs1PcTdZbI8dTHLmRJy5SzoFb87G/It8MkQW59YMvaE9PPs1hWU06pjmQM6pqVfzb
 g0HG16Xxt02dURsKUObdx3J31xfloYOwMjE9ifMlReObyjK1/51Go88l6fw1L7UtvajkuFfEk
 KOSlSRLzh37gh0tX0TdTE6bt1gtcTX8vbqM4zqgHv2nNIVIo7Noc6307b9macnGw2mPZJDluy
 S6ZjYc/tCXOlpkV3p9mePFhzs7Mv7PSLX6VGjCJA2BT7pe808+L5cF5ipk7MzQX14WO/0i7EB
 5S0XjmTtptRPjYDdYZvu6xY0+9bHXD00hW+PzDvcv99/+zthtr1XHnqE37i89HIoFvoDTbDa6
 4NR3wYF37s5/15IzOpOr0y5EmWNjHYTYmWZfwDczIESpgQAAA==
X-Env-Sender: zoujc@motorola.com
X-Msg-Ref: server-8.tower-386.messagelabs.com!1628847967!5921!1
X-Originating-IP: [104.47.126.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21916 invoked from network); 13 Aug 2021 09:46:09 -0000
Received: from mail-pu1apc01lp2058.outbound.protection.outlook.com (HELO
 APC01-PU1-obe.outbound.protection.outlook.com) (104.47.126.58)
 by server-8.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Aug 2021 09:46:09 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPiQF1RySV9pCYsFmpqSpHpY3W/Ggm+HFlA7uUCsdRMH0dR0/khGcnJwhHSlqECLFYPx9Koos0teVO3WiJ6TphQesDsVkqPUlEZ3Kf0NrTn2mclUT+e97ViXK0DfJvFqvYmMjCClAdD3bjZ/IfNvmXZSqQ4zs4I5FwYGp0C6lsXHeG4pOIOo2ItTHiKtk9jF+IVZr1OfSmkqdQGrm/6TDxMXYfnQFw1bTYs7kPDsD4e5cyTYtRHqJOAcboouPvN3A3PX7QdIyRbo+frW7nZk2vsC5Lp7bdHSjwrz2fJDPlAeyHzWaW3B3sI86UiPMjDenvsaa0RD/sUK3AkQZMucTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtf0qfEVBSFR9OZwE66GX8xd2U6W042cRPIu1NOnJr0=;
 b=k5H2n687kIRMJ66Pioem55inAm74/T5IEp3DHvsF83DOsyn8htGkhoUdtlfpRNkuGkMEJvLoTq2pEco7XGlb2jS5P4kpOACiJ3jAoPtbH59P199XBvBSAECvk4YZX9G91j3ArWT1c3w1l5T0Ho9VuhJRcxgnDgoS1858TZYY1bSa+l8vQ6MmlITMrQDetSfvnXVgbgtzQizwnciuydA64aZrgoSQ3eOVToQ1uG/+XxpsqE34KnmG6dOuLgKTCWoxSLeRL9yVhIR/R8L2RztkTb/BpAXwwry8z8QHvMlGcuOcbU0HkYCNLtj5Vb98Be5/rN0wTXCxgHkx8Yly2b6QCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from HK0PR03MB4177.apcprd03.prod.outlook.com (2603:1096:203:9b::11)
 by HK2PR0302MB2579.apcprd03.prod.outlook.com (2603:1096:202:3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11; Fri, 13 Aug
 2021 09:46:06 +0000
Received: from HK0PR03MB4177.apcprd03.prod.outlook.com
 ([fe80::3866:22b3:d4cc:6be2]) by HK0PR03MB4177.apcprd03.prod.outlook.com
 ([fe80::3866:22b3:d4cc:6be2%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 09:46:06 +0000
From: Jichao Zou <zoujc@motorola.com>
To: Robin Murphy <robin.murphy@arm.com>, David Hildenbrand <david@redhat.com>, 
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "minchan@kernel.org"
 <minchan@kernel.org>, "song.bao.hua@hisilicon.com"
 <song.bao.hua@hisilicon.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, JianQi
 Yang <yangj@motorola.com>, Yanjune Tian <tianyje@motorola.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFeHRlcm5hbF1SZTogQW4gY21hIG9wdGltaXph?=
 =?utf-8?Q?tion_patch_is_used_for_cma=5F[alloc|free].?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWxdUmU6IEFuIGNtYSBvcHRpbWl6YXRpb24gcGF0?=
 =?utf-8?Q?ch_is_used_for_cma=5F[alloc|free].?=
Thread-Index: AdeQD/l5FWbWirK9SGKJhUkkmda/hgAByYkAAAAgDAAAAw0cgAAAOKsA
Date: Fri, 13 Aug 2021 09:46:06 +0000
Message-ID: <HK0PR03MB4177FDD7160ABAC3C8119984D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
References: <HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
 <f5cd9fe6-3b62-eab8-1ff1-d3943d4bb85b@redhat.com>
 <HK0PR03MB41775573A48273BF128C7F72D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
 <ca497139-a6e8-cb66-e221-7fe4af2bda14@arm.com>
In-Reply-To: <ca497139-a6e8-cb66-e221-7fe4af2bda14@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e1f82ef-8256-4d19-c8fc-08d95e3f2c36
x-ms-traffictypediagnostic: HK2PR0302MB2579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0302MB257964947172CA1EC90D3268D5FA9@HK2PR0302MB2579.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3usvJZIR9BpXlhk0V14/xP7jVZ2fM43UXcE9snJLHUqG6epaS7WfSGuVd3xxX4tK4ab6/7klJyDODN4U/wZWmwwDmx0PABWBLB4FfseIGFhGSETavpjd+c3+PFKkTHtJr8jOg4Lszwi756XScZsZVAmCWtgLbUhJ+VNvlh3etjnETbj6ATOBXGk74Tc45VYT321M/vS5U63bwhJ7g1bZM9fgIElyt/TbG+whamafr4zXfRnlrfeZev3NP8/1A2Wtd5GCSULxAMWXesvdZrOrDAQN0Y7143se9AhsLrfeitGcCETNta2x5jajQYum8u//WZZpMxaveN5sdwS8zhQLHwW0fYCDQtm0f93eNNqPUJJcFVBEvoX8P1IjnL5fP0euUOyd/uBjxCEMMpOhFEl4HRYe0yzg/XtY2kHtK1+YRycbEoKX2GKDEBxctOwBXTJK77Hfid/ixB9Kj0bVk8BWv2n8sSepUG1MgBdG1r+5V7fZH9zMiv7To8e+r+ozGjf/rIDhMR3z1MDDXSwzm9XXrGcmy4KYNLrEWmE9vm8H1BHR2KXHrqlgpgs/rPS+UPW4Uv05/Ekpe2rzDOPXpWvEVzY5m93uGS3Nxrj8cTbUz6Qs3HB4C1L1IpfiCQS92tezzLBVlGYZ+CV2wHISp0orv2dZSkwX9DkmbHw4sCmpqYZPg9lrXQE/76h9+eHek+cYPLlIviMKbiZBUm3Uwfe0x/XWw3coQqsMCRYDtydJayc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK0PR03MB4177.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(2906002)(921005)(26005)(86362001)(5660300002)(52536014)(8936002)(224303003)(71200400001)(122000001)(38100700002)(7696005)(508600001)(6506007)(6636002)(66446008)(64756008)(66556008)(66476007)(66946007)(33656002)(53546011)(38070700005)(186003)(76116006)(110136005)(7416002)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmU5bHR0RytXZDBMTnFHdGswUkFaQlAwVzhqcFQ3K3M4dlNxVFZaR3NUTlN0?=
 =?utf-8?B?WkNJUm5haE9QVVAvcWl0OTlOTFIxYWdXN2s0V0xrNUFKU3RkckoxVmlJRXZm?=
 =?utf-8?B?VEF1dm1BQXhaY1Y0Vlg5MklhdEhPbFpidWxibVlKV3paeVY4ZkhMYks3VUpQ?=
 =?utf-8?B?WFJvRzZyNWl2aTlxams1RkFkb3pjUENqRFBnR2dYVjVMWjVtSWRvNFlaWjRV?=
 =?utf-8?B?dTQvWnRvVnBLQVNwbGVMTWJjWThCOHJORmhVdXRTaElOdjl4WnZRbkZiY1hn?=
 =?utf-8?B?K2JhYTRjNXhYVUt4SUlMc1RYMVFwNFJhaGJ2WE9YbDlZVjhDb2NuNCtwalVz?=
 =?utf-8?B?Q3NQSWJwenBpWHc2R3Rvbm5WR2JLdGVBWUNoQmZZQ1hMMnFKeTJrTzU5c2Nl?=
 =?utf-8?B?VVAvL3hYc3dDUElYcnpIMFRqVjBRS1ZQQk93Ui95N1cwQmJ3NUtrclNwYWRi?=
 =?utf-8?B?MStuSnRYV3JNaGQyL2hrSHJ2ditNNmkyYjJORkdtOHhaTklCRmU5K1cyd0FH?=
 =?utf-8?B?UEJGNWYyNjYyTmN6Z3plUWQvTk1vWCtKUXRiOWtWUVlxWXgrcjF2dlAxbFJm?=
 =?utf-8?B?VUhVdVJja0E0ODRnQUE2RHFnZWMxM2x6OWdOV1E5ZnZqeDhHMEI4dXI4RVBM?=
 =?utf-8?B?Vjczc2x0QTNoaGFtdFVvN1o3NVN3Qk4ySFZYMXU2MFpHQTI2R3FPZUVnaXRG?=
 =?utf-8?B?QWhqTjNOeEk3QitQRWxoWlJYNy9LdVlReDRBWWJNWTJYMkx3VGpIaHBLaDZT?=
 =?utf-8?B?ZXdHdS9iS2ZGeThTc08xSkNlQUNFekNRRis0TVROOGxBUUtMSGVFZGJ2TW01?=
 =?utf-8?B?Y1doMUExSmp3NlF1c2lkVkNYN0h5QWdWbkFjSnFLWWhFeUc1K2M3YjcyL1h4?=
 =?utf-8?B?QytMWUpvOFJuZ2FUV2pLbUl0QjVQSHJoaFhrSmVud3JDdGtJNUpjZ2QzT3Q4?=
 =?utf-8?B?TVJ0aXhXdVd5ZHVhZGVra2p1RXNzeXRDSlNGeXdJTjQ5Z2dsN3BWMFhCd2pt?=
 =?utf-8?B?MDVlWGlzVmNCbWtzOVJGMGRWUUxUOVQzUmZ0TUIyWXJvUFRHdG0zaVRwR25R?=
 =?utf-8?B?Q0VuR1oyZXEwM2s5R0s0SDNOcjZnL0J0anB6RmVzZ0U4elFBT3UwNlRuSGFV?=
 =?utf-8?B?eTJmTGJnZDhjWnExRElkNk0rcUJ1emxVbkorcjZrbjJLVzlNZTh6MGx4K2Rp?=
 =?utf-8?B?NGxrUGVuMVNYVWtiQm9LV28rZEViZS9INUVrSDBJdjMwOXFseUNncWExbzFW?=
 =?utf-8?B?NWpoTGxpQmZwTEgzY3Y3OVVia0g1bWdCbVpLMXA0bThCQTJvdkFhTkswc1lp?=
 =?utf-8?B?emFOUnZrT1RIZy9FTjdKM1I5YVJxNU1iTUMrTm1tNmkxT2JGZ1NiVWxicmdr?=
 =?utf-8?B?R0NPVEF6aTRLNXVWM1Bic21xNTU0Wml4YXZlamhKYjdUQVlmL0VXb2Zib2Zq?=
 =?utf-8?B?QmNzSzN5RjAyU0dFaiswcUlLSHFsS0FoSTBiTElnaVU2dEtLdldtNWdEdytJ?=
 =?utf-8?B?R2ZLUnZQS2t1akNxOGVjejFwQ1RZejdUMDFvREljd0RqWFdCREhOczM2Vlkz?=
 =?utf-8?B?aDk4RzNQMys4eUxXWkU2MjZBbkQweDhqdXN6TjBCY1I2NWNxT2ZXd0hFVk5Q?=
 =?utf-8?B?aTZaR2JXdDNDdkRpWkV0OGRNMDV0R3k5bU90dFJTbGZJV0dNdkhsK1VucEI3?=
 =?utf-8?B?ODJZdXdhSHFycEhnRDdRRHM2b01IZ0pVNXZidTZ0WkJLazFjK24rN3E4NmMv?=
 =?utf-8?Q?77MOoj041Ft4fBlCQ8wUnztgSMQqqO/WBi7Rsrb?=
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB4177.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1f82ef-8256-4d19-c8fc-08d95e3f2c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 09:46:06.6464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNa7vXHE2KnGHo8jD93G7Tq+jTDUIX3YioxlxqU76BR7hO4M9KnGwevLUJZT1QI0sDqVyKsiaUKC1dBgoagoRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0302MB2579
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

SSBnb3QgaXQsIGJ1dCBpbiBrZXJuZWwgdGhhdCB3ZSB1c2VkIHZlcnNpb24sIG1hbnkgaGVhcCBk
cml2ZXJzIHRoYXQgaW4gZHJpdmVycy9kbWEtYnVmLyBhcmUgYmFzZWQgb24gQ01BLCBub3QgRE1B
IGNhcnZlb3V0IQ0KSWYgdGhpcyBwYXRjaCBpcyBub3QgYWNjZXB0ZWQsIHdlIGNhbmNlbCBpdCEh
IQ0KDQpUaGFuayB5b3UgYWxsLg0KDQpCZXN0IFJlZ2FyZHMsDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2
LS0tLS0NCuWPkeS7tuS6ujogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gDQrl
j5HpgIHml7bpl7Q6IDIwMjHlubQ45pyIMTPml6UgMTc6MTYNCuaUtuS7tuS6ujogSmljaGFvIFpv
dSA8em91amNAbW90b3JvbGEuY29tPjsgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5j
b20+OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IG1pbmNoYW5Aa2VybmVsLm9yZzsgc29uZy5iYW8uaHVh
QGhpc2lsaWNvbi5jb207IGhjaEBsc3QuZGU7IG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbTsgaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IEppYW5RaSBZYW5nIDx5YW5nakBtb3Rvcm9s
YS5jb20+OyBZYW5qdW5lIFRpYW4gPHRpYW55amVAbW90b3JvbGEuY29tPg0K5Li76aKYOiBSZTog
5Zue5aSNOiBbRXh0ZXJuYWxdUmU6IEFuIGNtYSBvcHRpbWl6YXRpb24gcGF0Y2ggaXMgdXNlZCBm
b3IgY21hX1thbGxvY3xmcmVlXS4NCg0KT24gMjAyMS0wOC0xMyAwOToyNywgSmljaGFvIFpvdSB3
cm90ZToNCj4gSGkgRGF2aWQsDQo+IAlJJ2xsIGdpdC1zZW5kLWVtYWlsIHBhdGNoIGFnYWluLg0K
PiAJWW91ciB1bmRlcnN0YW5kaW5nIGlzIGV4YWN0bHkgcmlnaHQuDQo+IAlMZXQgbWUgZXhwbGFp
biB0aGUgYmFja2dyb3VuZCBvZiBQYXRjaCwgd2UgYXJlIGRldmVsb3BpbmcgQW5kcm9pZCBwaG9u
ZSwga2VybmVsIGlzIDUuMTAuNDMgTFRTLCB3ZSBlbmNvdW50ZXIgY21hX2FsbG9jIGZhaWxlZCBk
dXJpbmcga2VybmVsIHN0YXJ0dXAsIGJ1ZGR5IHN5c3RlbSBpcyByZWFkeSwNCj4gMDEtMTEgMTQ6
MjI6MDguNjUwICAgMjE2ICAgMjE2IEUgY21hICAgICA6IGNtYV9hbGxvYyhbMjE2XVtpbml0XTpj
bWEoZmZmZmZmZmYwMGI1MDAwMDp0b3RhbCA4MTkyKSBsaW51eCxjbWEoZmZmZmZmZTg5ZDA4NGNm
MCksIGNvdW50IDIsIGFsaWduIDEgZ2ZwX21hc2sgMHhjYzApDQo+IDAxLTExIDE0OjIyOjA4LjY1
MCAgIDIxNiAgIDIxNiBFIGNtYSAgICAgOiBjbWFfYWxsb2MoKTogbWVtb3J5IHJhbmdlIGF0IGZm
ZmZmZmZmMDBiNjI4ODAgaXMgYnVzeSwgcmV0cnlpbmcNCj4gICANCj4gCWNtYSBiaXRtYXAgc2hv
dyBtZW1vcnkgaXMgZnJlZSwgYnV0IGFsbG9jX2NvbnRpZ19yYW5nZSBmYWlsZWQsIHdlIGNoZWNr
ZWQgaXQgb3V0IHRoYXQgc29tZSBkcml2ZXJzIGNtYV9hbGxvYyBhcmUNCj4gCSJzdHJ1Y3QgcGFn
ZSAqY21hX2FsbG9jKHN0cnVjdCBjbWEgKmNtYSwgc2l6ZV90IGNvdW50LCB1bnNpZ25lZCBpbnQg
YWxpZ24sIGJvb2wgbm9fd2FybikiDQo+IAlJbiA1LjEwLjQzLCBjbWFfYWxsb2MgaXMNCj4gCSJz
dHJ1Y3QgcGFnZSAqY21hX2FsbG9jKHN0cnVjdCBjbWEgKmNtYSwgc2l6ZV90IGNvdW50LCB1bnNp
Z25lZCBpbnQgYWxpZ24sIGdmcF90IGdmcF9tYXNrKSINCj4gICAJQWZ0ZXIgY2hhbmdlIGNtYV9h
bGxvYyBwYXJhbWV0ZXIgd2l0aCBHRlBfS0VSTkVMLCBpc3N1ZSBpcyBmaXhlZCwgYXQgdGhlIHNh
bWUgdGltZSwgd2UgZm91bmQgdGhhdCBwcmVhbGxvY2F0ZSBhIHBvcnRpb24gb2YgY21hIG1lbW9y
eSBmb3IgYXVkaW8mdmlkZW8gcmVzdWx0ZWQgaW4gYmV0dGVyIHBlcmZvcm1hbmNlIGFuZCBndWFy
YW50ZWUgQVYgZnVuY3Rpb24gZXZlbiB1bmRlciBtZW1vcnkgcHJlc3N1cmUsIHNvIHdlIHRyeSB0
byBzdWJtaXQgdGhpcyBwYXRjaC4NCg0KVGhlIHdob2xlIHBvaW50IG9mIENNQSBpcyB0aGF0IHRo
ZSBtZW1vcnkgY2FuIGJlIHNoYXJlZCBieSBtb3ZlYWJsZSBwYWdlcyB3aGlsZSBpdCdzIG5vdCBi
ZWluZyB1c2VkIGZvciBETUEuIElmIHlvdSB3YW50IGEgZGVkaWNhdGVkIERNQSBjYXJ2ZW91dCwg
dGhlcmUgYXJlIGFscmVhZHkgbWVjaGFuaXNtcyBmb3IgdGhhdC4NCg0KUm9iaW4uDQoNCj4gDQo+
IFRoYW5rcy4NCj4gDQo+IEJlc3QgUmVnYXJkcywNCj4gDQo+IFpvdSBKaWNoYW8g6YK557qq6LaF
DQo+IEFkdmlzb3J5IEVuZ2luZWVyLCBTVyBCU1ANCj4gTUJHIFJPVyBTVyBCSiBQRiBCU1AgKENO
KQ0KPiBNb3Rvcm9sYSBNb2JpbGl0eSwgQSBMZW5vdm8gQ29tcGFueQ0KPiBtb3Rvcm9sYS5jb20N
Cj4gTSArODYgMTg5MTA4NjAyMTINCj4gRSB6b3VqY0BsZW5vdm8uY29tDQo+IHR3aXR0ZXIgfCBm
YWNlYm9vayB8IGluc3RhZ3JhbSB8IGJsb2cgfCBmb3J1bXMNCj4gDQo+IA0KPiANCj4gDQo+IC0t
LS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2
aWRAcmVkaGF0LmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDIx5bm0OOaciDEz5pelIDE1OjQ1DQo+
IOaUtuS7tuS6ujogSmljaGFvIFpvdSA8em91amNAbW90b3JvbGEuY29tPjsgYWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZzsgDQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1t
QGt2YWNrLm9yZzsgbWluY2hhbkBrZXJuZWwub3JnOyANCj4gc29uZy5iYW8uaHVhQGhpc2lsaWNv
bi5jb207IGhjaEBsc3QuZGU7IG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbTsgDQo+IHJvYmluLm11
cnBoeUBhcm0uY29tOyBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgSmlhblFpIFlh
bmcgDQo+IDx5YW5nakBtb3Rvcm9sYS5jb20+OyBZYW5qdW5lIFRpYW4gPHRpYW55amVAbW90b3Jv
bGEuY29tPg0KPiDkuLvpopg6IFtFeHRlcm5hbF1SZTogQW4gY21hIG9wdGltaXphdGlvbiBwYXRj
aCBpcyB1c2VkIGZvciBjbWFfW2FsbG9jfGZyZWVdLg0KPiANCj4gT24gMTMuMDguMjEgMDk6MDAs
IEppY2hhbyBab3Ugd3JvdGU6DQo+PiBQcmUtYWxsb2NhdGXCoENNQcKgbWVtb3J5wqB0aGF0wqBj
b25maWd1cmVkwqBpbsKgZGV2aWNlIHRyZWUswqB0aGlzwqBncmVhdGx5IA0KPj4gaW1wcm92ZXPC
oHRoZcKgQ01BwqBtZW1vcnkgYWxsb2NhdGlvbsKgZWZmaWNpZW5jeSzCoGNtYV9bYWxsb2N8ZnJl
ZV3CoGlzIA0KPj4gbGVzcyB0aGFuwqAxbXMswqBvbGTCoHdhecKgaXPCoHRvb2vCoGHCoGZld8Kg
bXPCoHRvwqB0ZW5zwqBvciBodW5kcmVkc8KgbXMuDQo+Pg0KPiANCj4gUGxlYXNlIHNlbmQgcGF0
Y2hlcyBhcyBwcm9wZXIgZW1haWxzIChtYW4gZ2l0LWZvcm1hdC1wYXRjaDsgbWFuIGdpdC1zZW5k
LWVtYWlsKS4NCj4gDQo+IFdoYXQgeW91IHByb3Bvc2UgaXMgdHVybmluZyBjbWEgcmVzZXJ2YXRp
b25zIGludG8gc29tZXRoaW5nIGNvbXBhcmFibGUgdG8gcGVybWFuZW50IGJvb3R0aW1lIGFsbG9j
YXRpb25zLiBGcm9tIHRoZSBQT1Ygb2YgdGhlIGJ1ZGR5LCB0aGUgcGFnZXMgYXJlIGFsd2F5cyBh
bGxvY2F0ZWQgYW5kIGNhbm5vdCBiZSByZXB1cnBvc2VkIGZvciBlLmcuLCBtb3ZhYmxlIGFsbG9j
YXRpb25zIHVudGlsICphY3R1YWxseSogYWxsb2NhdGVkIHZpYSBDTUEuDQo+IA0KPiBJIGRvbid0
IHRoaW5rIHdlIHdhbnQgdGhpcyBiZWhhdmlvciB1cHN0cmVhbS4NCj4gDQo+IC0tDQo+IFRoYW5r
cywNCj4gDQo+IERhdmlkIC8gZGhpbGRlbmINCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
