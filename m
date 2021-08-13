Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C186C4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 08:45:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0BC6103A
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 08:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE0BC6103A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=motorola.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78ACF407A3;
	Fri, 13 Aug 2021 08:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20fXy5Rc7bDm; Fri, 13 Aug 2021 08:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 135BC404DB;
	Fri, 13 Aug 2021 08:45:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE981C001A;
	Fri, 13 Aug 2021 08:45:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B05BEC000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98556606EC
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=motorola.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mjfXTBzpZCk7 for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 07:13:15 +0000 (UTC)
X-Greylist: delayed 00:13:01 by SQLgrey-1.8.0
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.114])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BEA6606D4
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 07:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
 s=Selector; t=1628838012; i=@motorola.com;
 bh=maHcRjPqYfq2HQ7s9pw1M5J5JvrDRy8iNd+kUDngLJc=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
 b=nsnYL6SWBKhXBTFFtvQMO7sxeiKZ6gqmbqC1XF6e+2yv3tLrmEKPA9/J+0v3ykY1X
 wRZP0ynU1f2wpaQdOxMaheyu1akQcxLEsUUmE8NlwkMIugaQ/T7ulq3b6OFtuInNal
 7dlAS82XxGZMby0GjcoU3EqtiQPggy/06aJ0jjkAoG21LxW81C52aSrsYDIHFQkGgf
 3LSL3iuDrRMLu66dH05Uo1F6LwBiLmsU8V3ooW/DAqUvnAKvcHBUQTp4xvpyLVCABB
 XFt1NVq6lcDmx/sTKB9Pli31eXVKvfuk15nroHApL29zyWbW4ZVIx214dLp9lU7MZu
 AMOHcicE7txUw==
Received: from [100.112.135.86] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.us-west-2.aws.symcld.net id ED/11-15021-B7816116;
 Fri, 13 Aug 2021 07:00:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wTZxjHeXvX61HpdpQffYbCsgZiRtZSIJt
 n6pAtM6tuSxaySEIy5RiVNiuFtUWK2SJRcREsQyEoDajjh/xYgVLZUGSQlTqmZnFghS6Ls0gR
 bEDYQDaUwXqeOvbf577P93nf7/PmHhITXxREkWqzSW3QMzopIcQ1CV9slR2ASEYxbFXQtZ02g
 n7Y+QijW7+5wqPPDSjpm721BP27bY1Pt7tuC+jzD+cE9A/zPj5dObrETxWqbGdsSDVR1yVQOd
 qOESrHnycFqp9OP8ZVlZ5mpLr8azGhmuu/RajKu9uQasER86Ewg6/VZ+WZM/ma/u5ZIn/5TfP
 Cyc3FaGFbKQomEdWEwdxQcCkSBvhHHKb8Doz7+A7BkNstKEUkKabO8uB8PKuLqTsIWquvILab
 oOLAMuvCWQ6nruJQ3EmyHEalQlf5LMHpO8BRvohxLIdV27dPGA/0HqlxP+kVUR/DTO8/Ai5RN
 FTfvcNjGaMkUFdt5bMMVDiMD18nOI6A+xOrfM7fgGDJnsPp0TBytgxx/AH02CZ5HL8Gl09dwN
 lZgIqFVWcRJ+fDlyvDGCfHwd8db3NyDLRZxnGOX4bq+jkBx5vA6+l5mqCCAKs3nX0SoBpxGC+
 7hHEFBZxZchFcoS8UmixdiJtFA5Ot9Rg3byhcrfHhFSjeum5M6zqbdZ3NGsiHUa9CZ28CZ3kF
 qsrGBRzvhuMjF56yEi4NrvGsgasxyolgeqGLt77hHApuQ1uyDNocjSmX0epkiQqFLDExSZaYn
 CR7I1nOHJBlyQuMskK10SRLkjOFRrmxKPcTXbZcrzY5UOD3zc4/sv0iOj0zL3eil0ieNEJk/z
 mcEb+QlZddpGGMmr2GAp3a6ESbSFIKoqHwSEYcalDnqM37tLrAEjwrAxkiDRfxA2sgFhnzmVy
 jNocrXUPJZMX9unqMdNU11WNiXJ+nV0dJRIckASvFWjUF+ucHPVuoERQdFSZCQUFB4pB8tSFX
 a/p/3Y8kJJKGiaLYU0K0etPz+/yBKLxAlA5lBBvFxPxXiirm2ScqPdHbicLbfM3g17le9JE7+
 ZdF7+KD/URTQ0jPhrvHItX+lMka96clN5HoK8W0VNzIPPC2NGa0yyPsFGnZMNb5G52wb/Rd60
 Kw7z1zmvyd2phdJSmOUMfjPf2jsYrRleVDQmeGZ7XdLXp06/gfukW/ZnRw6vt70a9PVB3dehi
 lZq84TC9m9u1u/lyizdif0eCyp+6I7TfMWIgpj5l6vyM5tm16Kv1UVXoLQ2nf+uygrqhiStnu
 D7YsSzKVqzeowyccG3cSypI419i1vixfyR7vwPS2sZiYv3T3Vo76S0ucKdiNtYO+jdLu5pbNv
 vkQV1rj9bRde7fYByZPRFiluFHDJMZjBiPzL7thWqnLBAAA
X-Env-Sender: zoujc@motorola.com
X-Msg-Ref: server-11.tower-355.messagelabs.com!1628838008!289747!1
X-Originating-IP: [104.47.125.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15632 invoked from network); 13 Aug 2021 07:00:10 -0000
Received: from mail-sg2apc01lp2057.outbound.protection.outlook.com (HELO
 APC01-SG2-obe.outbound.protection.outlook.com) (104.47.125.57)
 by server-11.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Aug 2021 07:00:10 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kdjzv/RuqZUxfDr9tRfIx8rOqcnHAaNpDZtgZZHmFLBOsktRvgvusHShCvO8hI5fGKCmfOSIW2TfgQ1DbwIxZTgwASpiPsiOI2dR/QO7u7OlxfVfFQlptZ8gveIg+BLBT+Tcvy5c+GsYMH3vOvOD0QEJANqhNPl/K3OVnQg6VmlHv0ei+WSqBjyN2t14k5MieHinZErlxIiLCcr14ZaO3Y7lLEnKZQgqZkB6N/g9aOITGa5CeVxD8Vj2reVijr5f1d+fTwivfpLHlgN4bV490LEXP9iSSip+DM/20Ri5Ai8FQeHYig8vZ2Yard0uVxBvRGjzesJ8XCzKhiHZuIH9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maHcRjPqYfq2HQ7s9pw1M5J5JvrDRy8iNd+kUDngLJc=;
 b=c5RcWfuCKCjwFrILA7Anzj+iqAyXit0VpLNrlJsR1ggP0Cu+X11GMIxRbJ1LEMYtkbIG0cvmg2xJgN45uEOgdnjHGIRaaVaCbagi1sjNeIwcU+K7lxrJLeRlQDOVl65jCX0zLTgDtvTSK5pR6OzB9BGK0bf95zEJukVKMkdfl7yk6XYDxi6YouD+rvPDV+z7/yRyb2QkfvW2qsaLBm7YKJwiwhpJQAPw7sOIyvzzA1nFuBeLMEpzNjI9AmZgyQmBtNIY4wCf/Dxcc+B3W2GAWdfKqV3V59Ch1eGsLjuYB229BD/MRewkMO1bHArETLzCr88Sp7UcH9iYyRtdGHHpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from HK0PR03MB4177.apcprd03.prod.outlook.com (2603:1096:203:9b::11)
 by HK2PR0302MB2628.apcprd03.prod.outlook.com (2603:1096:202:9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9; Fri, 13 Aug
 2021 07:00:07 +0000
Received: from HK0PR03MB4177.apcprd03.prod.outlook.com
 ([fe80::3866:22b3:d4cc:6be2]) by HK0PR03MB4177.apcprd03.prod.outlook.com
 ([fe80::3866:22b3:d4cc:6be2%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 07:00:07 +0000
From: Jichao Zou <zoujc@motorola.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "minchan@kernel.org"
 <minchan@kernel.org>, "david@redhat.com" <david@redhat.com>,
 "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>, "hch@lst.de"
 <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, JianQi
 Yang <yangj@motorola.com>, Yanjune Tian <tianyje@motorola.com>
Subject: An cma optimization patch is used for cma_[alloc|free].
Thread-Topic: An cma optimization patch is used for cma_[alloc|free].
Thread-Index: AdeQD/l5FWbWirK9SGKJhUkkmda/hg==
Date: Fri, 13 Aug 2021 07:00:07 +0000
Message-ID: <HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d30c6cf-9ad6-42e9-d7a9-08d95e27fc2f
x-ms-traffictypediagnostic: HK2PR0302MB2628:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0302MB2628A010FD2881B730DD91CDD5FA9@HK2PR0302MB2628.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYxFhCOca29t+Ao6hP5F/bR0cfeB7OshZx8OAXR3upJFGiJVAvTNkN7Acv2PVh4uWNfHDNKKvIbBfrWzoBrmHTP4KzWtQFlwVznmfzNtZIRUuDEWwJ8It9FP2ZLqOjWGeHvWQ//F4w7gvZ5wKFT8Rwzviv1pO/foLR4D3qltIx4vd/hPBx0DAM7K8zh4JQyThgzJFQTkSvcp01lYYwy4rfvcgpnnQfBYfqkOcVNjXnPzffh2ZwNc+buZVk/0m2IaT1DlKGDkBN7nWmd7GF60FBj1iG0Z0odoiHbBewDMzpeyXXwSO/+Dh8NOTukAG3nIfjyQvD39NdAuXzrTgM5UzUlWNr+ThAQy93ibpelXLC6ziWtx1zgknb73mYwuSZ9KsIQK1/Hk0fTM5LaQGRmQs/54dbyLiAsDtkIciSUT1Md1bXh+pGcMluMQdqVaXmVXFO323wbXjQrH5RpJiBaa/MQLFL/4+NGmup6uCy1y8j0wtndlwhWVPgSjxGo3Y9CMQflA67X6yHoDm8uMZssk32JGb+IQgASWj0ETet5O1Xlx4bhQLDhITW0CLLNsqFsfgL+T2mzPHYThV160iAcqiICmXJz+ETZElhBdLGzaf3KvddZ80/uYru5/jKgKNnrG2QsbqZ0TTh+EJrDDVq6GFbZZZpqn9Y/w0UNbDXLRqgTqE3hQy4LHbJkZZzreMkyZEJis2V8k9I2ka+NPPWTngX34b5i151hGQz3X1fStCxE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK0PR03MB4177.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(71200400001)(110136005)(26005)(186003)(76116006)(6636002)(55016002)(2906002)(4744005)(921005)(9686003)(66556008)(66616009)(52536014)(8676002)(66946007)(66476007)(122000001)(38100700002)(99936003)(64756008)(86362001)(38070700005)(6506007)(7696005)(5660300002)(7416002)(316002)(33656002)(478600001)(8936002)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTRicEJ3TEZoSUM5QzkzdThlSzZiTkZaYVlxb3ZhQVpIRWZNeW1RdG5qdE9D?=
 =?utf-8?B?Uy9oOVA1RStxcFcrRTNqTUlWTWZuWHNRMUZMK2hpZURzZW5UbkYyenh0elhX?=
 =?utf-8?B?MHQ4NFdpdVJyRnFLTjJzWmNmUWowVWIxMzA3R3VycXZ1Z2lkRnN4V1JRMWZX?=
 =?utf-8?B?bjZXMnJHZE9CMjVUZDZCZlZ3UTR5S0NjaGYvOXZOUm12OFJ5OW05K3Rhck55?=
 =?utf-8?B?NXNkZlFHWWxJK25uTUdKV1JYUkovcWRXYVpGVkZBZDNrOVFhdDNsNWYvMFZu?=
 =?utf-8?B?WDRGNmZPZ1ZRSG5TTG1IUzdZa0NBWmgwaTQwaEVsenRLZ3VaK29CV1NsRlBT?=
 =?utf-8?B?dEVLeFVXdkk2MFVwNjB4V0g4OCsvWEVCSmJCc3E0eUxKaG1ZRndSVGpPVUxH?=
 =?utf-8?B?K2hsQW9JV2FkK2Q5dU8zTnFvd3JWUGtsS0dKUGlYRHc5Mktyc1FPQW5oeGFl?=
 =?utf-8?B?WTZWSnQ2YUhDbXdRdlIrM01VZGhzU1hzTVhKTkdiRW9zb2JXcUp2VEhrbEQv?=
 =?utf-8?B?V1JmeEduVEFRY1d5eEc1QStpa0IwWUhsc1FxT2xYSFhqYlUwcVBraHAxZmJI?=
 =?utf-8?B?STBNc1YvQW00K00xZEV2TUQxYWgyalhqa29neEh6RmtMc1NJUjBJMWVsSlpj?=
 =?utf-8?B?bEM3cmN0bUQ0UXlnZzFoVnhmQlROQUlnOEtNQlJDMmxwaHYwOVF5MFRqeTYz?=
 =?utf-8?B?Z1RYeDlrOXB4UkV4N0Y0YkF3aGU0bjVlZzlsdktNRXAwMmxRbUFyV0R6R1pr?=
 =?utf-8?B?N3Jvci9yYjltdFNLUnRuT2RvQXNCWk83cEliakgvcmswYXp3QWltOTJCTHN5?=
 =?utf-8?B?WUhHb1NDdUk5QnR6ZVRLT1VGZjdFVEk1OGpGc3hrajU3UVh5cTc5SFBaRUpR?=
 =?utf-8?B?R3JnRUhnZjBxQ0NFQjc4cCtpRmVMSEJHZld1WStSUlNoVU1lQ3E0eHpRUUQr?=
 =?utf-8?B?Um4rRGhPZC9aaUlFbStPdTFHTEx2U0RRTGdFdnhNNWFocVF4VVl4MUJtZWk4?=
 =?utf-8?B?NGJKWnN6UTh2NFZZTWhaNDQyZStGLzVWeHJuNUJpbFV5ZG5iQ1QyTTdESXFa?=
 =?utf-8?B?d1R1ZldQdnhjOW1IbjJQQjRyQS9TdGxjWEpRZ2FjU20yVkhtOWprTFhpbW8z?=
 =?utf-8?B?clVYdjNkT24vVzIyUXZlaTNTMVVBUkozQ05UMHpYZEJSV0lTY0VxMTU4d3lG?=
 =?utf-8?B?OFlGT05TTVdrTDRvL3RSZjMxSENPSnI4U0pwRHcvQytSbm1zdjBGZUhqVC9R?=
 =?utf-8?B?elBwVGRpMnBlaVRWa014NnNPeXhoZ2hZZzF3aU55MlR2SmdLcytraHk3dElW?=
 =?utf-8?B?REIzVWg2VWY5SWV2QThEQU5pdGZ6b1Nnc3l3QVhnN3RPNktnM1luKzN5R2Fa?=
 =?utf-8?B?SjkvaS9WK2U3dnk3ZDFwbTRnZjJuU1FVaVQ3V3N4QjNlelZCaURjNWEzaEx0?=
 =?utf-8?B?NDc3clhDSUdSOC9YWFp4dUR1UlpUdnZOYW52bllrWFFZejZPZG1FbURTR3Nz?=
 =?utf-8?B?VU1kc0psUWpYWnlDQit4dk1iUGJjaXp2aWNld0hmQkNybGZBKzZMeDNneGwr?=
 =?utf-8?B?R0VLdm9nWkVKai9NMTBnRVplaXFDSUJzelJmYmt5RjRrN1lHRUc1bkxaWFda?=
 =?utf-8?B?ZGtrb3VTMkZxdS8xMnpHSkY2MzdxbzlnSkw4MjZONXZQU2lJQTVQOEp3NFdm?=
 =?utf-8?B?bk9DVld4c2JzK2ZjR0J2S3FnOHJvNzFTQUprR2R6VGVEL0xNckxaNXlNTWxu?=
 =?utf-8?Q?Vt6OJ59giYahv0Zz9uwxdNzhZk9NGTtD/bS+MQ+?=
Content-Type: multipart/mixed;
 boundary="_002_HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9HK0PR03MB4177apcp_"
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB4177.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d30c6cf-9ad6-42e9-d7a9-08d95e27fc2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 07:00:07.6145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fEv2JkUAiInyWoPTcnXu923Pt3iKI+7fc/uhfzzbwsVgKo9PPGGJ65ZRvUL5hLahqJdIoCQUuPHUf/D5dhihpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0302MB2628
X-Mailman-Approved-At: Fri, 13 Aug 2021 08:45:09 +0000
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--_002_HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9HK0PR03MB4177apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

UHJlLWFsbG9jYXRlwqBDTUHCoG1lbW9yecKgdGhhdMKgY29uZmlndXJlZMKgaW7CoGRldmljZQ0K
dHJlZSzCoHRoaXPCoGdyZWF0bHnCoGltcHJvdmVzwqB0aGXCoENNQcKgbWVtb3J5DQphbGxvY2F0
aW9uwqBlZmZpY2llbmN5LMKgY21hX1thbGxvY3xmcmVlXcKgaXPCoGxlc3MNCnRoYW7CoDFtcyzC
oG9sZMKgd2F5wqBpc8KgdG9va8KgYcKgZmV3wqBtc8KgdG/CoHRlbnPCoG9yDQpodW5kcmVkc8Kg
bXMuDQoNClRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzLA0KDQpab3UgSmljaGFvIOmCuee6qui2hQ0K
QWR2aXNvcnkgRW5naW5lZXIsIFNXIEJTUA0KTUJHIFJPVyBTVyBCSiBQRiBCU1AgKENOKQ0KTW90
b3JvbGEgTW9iaWxpdHksIEEgTGVub3ZvIENvbXBhbnkNCm1vdG9yb2xhLmNvbSANCg0KDQoNCg0K

--_002_HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9HK0PR03MB4177apcp_
Content-Type: application/octet-stream;
	name="0001-cma-optimize-cma-allocation.patch"
Content-Description: 0001-cma-optimize-cma-allocation.patch
Content-Disposition: attachment;
	filename="0001-cma-optimize-cma-allocation.patch"; size=4988;
	creation-date="Thu, 12 Aug 2021 10:14:42 GMT";
	modification-date="Thu, 12 Aug 2021 10:21:04 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhODJkYmM0NmUyMzQzYzM5NGQzZWRjYWJjYmM3M2VhNmU5ZjQwM2RhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKaWNoYW8gWm91IDx6b3VqY0Btb3Rvcm9sYS5jb20+CkRhdGU6
IFRodSwgMTIgQXVnIDIwMjEgMTg6MjA6MjEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBjbWE6b3B0
aW1pemUgY21hIGFsbG9jYXRpb24uCgpQcmUtYWxsb2NhdGUgQ01BIG1lbW9yeSB0aGF0IGNvbmZp
Z3VyZWQgaW4gZGV2aWNlCnRyZWUsIHRoaXMgZ3JlYXRseSBpbXByb3ZlcyB0aGUgQ01BIG1lbW9y
eQphbGxvY2F0aW9uIGVmZmljaWVuY3ksIGNtYV9bYWxsb2N8ZnJlZV0gaXMgbGVzcwp0aGFuIDFt
cywgb2xkIHdheSBpcyB0b29rIGEgZmV3IG1zIHRvIHRlbnMgb3IKaHVuZHJlZHMgbXMuCgpTaWdu
ZWQtb2ZmLWJ5OiBKaWNoYW8gWm91IDx6b3VqY0Btb3Rvcm9sYS5jb20+Ci0tLQogaW5jbHVkZS9s
aW51eC9jbWEuaCAgICAgfCAgMyArKy0KIGtlcm5lbC9kbWEvY29udGlndW91cy5jIHwgIDIgKy0K
IG1tL2NtYS5jICAgICAgICAgICAgICAgIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0KIG1tL2NtYS5oICAgICAgICAgICAgICAgIHwgIDEgKwogNCBmaWxlcyBjaGFuZ2Vk
LCAzNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvY21hLmggYi9pbmNsdWRlL2xpbnV4L2NtYS5oCmluZGV4IDUzZmQ4YzNjZGJkMC4uNjhi
YzE0N2E4MmE3IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2NtYS5oCisrKyBiL2luY2x1ZGUv
bGludXgvY21hLmgKQEAgLTQzLDcgKzQzLDggQEAgc3RhdGljIGlubGluZSBpbnQgX19pbml0IGNt
YV9kZWNsYXJlX2NvbnRpZ3VvdXMocGh5c19hZGRyX3QgYmFzZSwKIGV4dGVybiBpbnQgY21hX2lu
aXRfcmVzZXJ2ZWRfbWVtKHBoeXNfYWRkcl90IGJhc2UsIHBoeXNfYWRkcl90IHNpemUsCiAJCQkJ
CXVuc2lnbmVkIGludCBvcmRlcl9wZXJfYml0LAogCQkJCQljb25zdCBjaGFyICpuYW1lLAotCQkJ
CQlzdHJ1Y3QgY21hICoqcmVzX2NtYSk7CisJCQkJCXN0cnVjdCBjbWEgKipyZXNfY21hLAorCQkJ
CQl1bnNpZ25lZCBsb25nIG5vZGUpOwogZXh0ZXJuIHN0cnVjdCBwYWdlICpjbWFfYWxsb2Moc3Ry
dWN0IGNtYSAqY21hLCB1bnNpZ25lZCBsb25nIGNvdW50LCB1bnNpZ25lZCBpbnQgYWxpZ24sCiAJ
CQkgICAgICBib29sIG5vX3dhcm4pOwogZXh0ZXJuIGJvb2wgY21hX3JlbGVhc2Uoc3RydWN0IGNt
YSAqY21hLCBjb25zdCBzdHJ1Y3QgcGFnZSAqcGFnZXMsIHVuc2lnbmVkIGxvbmcgY291bnQpOwpk
aWZmIC0tZ2l0IGEva2VybmVsL2RtYS9jb250aWd1b3VzLmMgYi9rZXJuZWwvZG1hL2NvbnRpZ3Vv
dXMuYwppbmRleCAzZDYzZDkxY2JhNWMuLmQ3N2MyNzQ1MjQ0YyAxMDA2NDQKLS0tIGEva2VybmVs
L2RtYS9jb250aWd1b3VzLmMKKysrIGIva2VybmVsL2RtYS9jb250aWd1b3VzLmMKQEAgLTQyMSw3
ICs0MjEsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBybWVtX2NtYV9zZXR1cChzdHJ1Y3QgcmVzZXJ2
ZWRfbWVtICpybWVtKQogCQlyZXR1cm4gLUVJTlZBTDsKIAl9CiAKLQllcnIgPSBjbWFfaW5pdF9y
ZXNlcnZlZF9tZW0ocm1lbS0+YmFzZSwgcm1lbS0+c2l6ZSwgMCwgcm1lbS0+bmFtZSwgJmNtYSk7
CisJZXJyID0gY21hX2luaXRfcmVzZXJ2ZWRfbWVtKHJtZW0tPmJhc2UsIHJtZW0tPnNpemUsIDAs
IHJtZW0tPm5hbWUsICZjbWEsIG5vZGUpOwogCWlmIChlcnIpIHsKIAkJcHJfZXJyKCJSZXNlcnZl
ZCBtZW1vcnk6IHVuYWJsZSB0byBzZXR1cCBDTUEgcmVnaW9uXG4iKTsKIAkJcmV0dXJuIGVycjsK
ZGlmZiAtLWdpdCBhL21tL2NtYS5jIGIvbW0vY21hLmMKaW5kZXggOTk1ZTE1NDgwOTM3Li5jNTY4
MmQwM2M1ZTkgMTAwNjQ0Ci0tLSBhL21tL2NtYS5jCisrKyBiL21tL2NtYS5jCkBAIC0zMiw2ICsz
Miw3IEBACiAjaW5jbHVkZSA8bGludXgvaW8uaD4KICNpbmNsdWRlIDxsaW51eC9rbWVtbGVhay5o
PgogI2luY2x1ZGUgPHRyYWNlL2V2ZW50cy9jbWEuaD4KKyNpbmNsdWRlIDxsaW51eC9vZl9mZHQu
aD4KIAogI2luY2x1ZGUgImNtYS5oIgogCkBAIC0xMjQsNiArMTI1LDE3IEBAIHN0YXRpYyB2b2lk
IF9faW5pdCBjbWFfYWN0aXZhdGVfYXJlYShzdHJ1Y3QgY21hICpjbWEpCiAJSU5JVF9ITElTVF9I
RUFEKCZjbWEtPm1lbV9oZWFkKTsKIAlzcGluX2xvY2tfaW5pdCgmY21hLT5tZW1faGVhZF9sb2Nr
KTsKICNlbmRpZgorCWlmIChjbWEtPnByZWFsbG9jYXRlZF9jbWEpIHsKKwkJc3RydWN0IGFjcl9p
bmZvIGluZm8gPSB7MH07CisKKwkJcGZuID0gYmFzZV9wZm47CisJCWlmICghYWxsb2NfY29udGln
X3JhbmdlKHBmbiwgcGZuICsgY21hLT5jb3VudCwgTUlHUkFURV9DTUEsIEdGUF9LRVJORUwsICZp
bmZvKSkgeworCQkJcHJfaW5mbygiQ01BIGFyZWEgJXMgYmUgcHJlLWFsbG9jYXRlZCBzdWNjZXNz
ZnVsbHlcbiIsIGNtYS0+bmFtZSk7CisJCX0gZWxzZSB7CisJCQljbWEtPnByZWFsbG9jYXRlZF9j
bWEgPSBmYWxzZTsKKwkJCXByX2VycigiQ01BIGFyZWEgJXMgYmUgcHJlLWFsbG9jYXRlZCBmYWls
dXJlXG4iLCBjbWEtPm5hbWUpOworCQl9CisJfQogCiAJcmV0dXJuOwogCkBAIC0xNTksMTMgKzE3
MSwxNSBAQCBjb3JlX2luaXRjYWxsKGNtYV9pbml0X3Jlc2VydmVkX2FyZWFzKTsKICAqICAgICAg
ICB0aGUgYXJlYSB3aWxsIGJlIHNldCB0byAiY21hTiIsIHdoZXJlIE4gaXMgYSBydW5uaW5nIGNv
dW50ZXIgb2YKICAqICAgICAgICB1c2VkIGFyZWFzLgogICogQHJlc19jbWE6IFBvaW50ZXIgdG8g
c3RvcmUgdGhlIGNyZWF0ZWQgY21hIHJlZ2lvbi4KKyAqIEBub2RlOiBDTUEgbWVtb3J5IGR0c2kg
bm9kZS4KICAqCiAgKiBUaGlzIGZ1bmN0aW9uIGNyZWF0ZXMgY3VzdG9tIGNvbnRpZ3VvdXMgYXJl
YSBmcm9tIGFscmVhZHkgcmVzZXJ2ZWQgbWVtb3J5LgogICovCiBpbnQgX19pbml0IGNtYV9pbml0
X3Jlc2VydmVkX21lbShwaHlzX2FkZHJfdCBiYXNlLCBwaHlzX2FkZHJfdCBzaXplLAogCQkJCSB1
bnNpZ25lZCBpbnQgb3JkZXJfcGVyX2JpdCwKIAkJCQkgY29uc3QgY2hhciAqbmFtZSwKLQkJCQkg
c3RydWN0IGNtYSAqKnJlc19jbWEpCisJCQkJIHN0cnVjdCBjbWEgKipyZXNfY21hLAorCQkJCSB1
bnNpZ25lZCBsb25nIG5vZGUpCiB7CiAJc3RydWN0IGNtYSAqY21hOwogCXBoeXNfYWRkcl90IGFs
aWdubWVudDsKQEAgLTIwNCw2ICsyMTgsOSBAQCBpbnQgX19pbml0IGNtYV9pbml0X3Jlc2VydmVk
X21lbShwaHlzX2FkZHJfdCBiYXNlLCBwaHlzX2FkZHJfdCBzaXplLAogCWNtYS0+YmFzZV9wZm4g
PSBQRk5fRE9XTihiYXNlKTsKIAljbWEtPmNvdW50ID0gc2l6ZSA+PiBQQUdFX1NISUZUOwogCWNt
YS0+b3JkZXJfcGVyX2JpdCA9IG9yZGVyX3Blcl9iaXQ7CisJaWYgKG5vZGUpCisJCWNtYS0+cHJl
YWxsb2NhdGVkX2NtYSA9IG9mX2dldF9mbGF0X2R0X3Byb3Aobm9kZSwgImxpbnV4LHByZWFsbG9j
YXRlZC1jbWEiLCBOVUxMKTsKKwogCSpyZXNfY21hID0gY21hOwogCWNtYV9hcmVhX2NvdW50Kys7
CiAJdG90YWxjbWFfcGFnZXMgKz0gKHNpemUgLyBQQUdFX1NJWkUpOwpAQCAtMzY5LDcgKzM4Niw3
IEBAIGludCBfX2luaXQgY21hX2RlY2xhcmVfY29udGlndW91c19uaWQocGh5c19hZGRyX3QgYmFz
ZSwKIAkJYmFzZSA9IGFkZHI7CiAJfQogCi0JcmV0ID0gY21hX2luaXRfcmVzZXJ2ZWRfbWVtKGJh
c2UsIHNpemUsIG9yZGVyX3Blcl9iaXQsIG5hbWUsIHJlc19jbWEpOworCXJldCA9IGNtYV9pbml0
X3Jlc2VydmVkX21lbShiYXNlLCBzaXplLCBvcmRlcl9wZXJfYml0LCBuYW1lLCByZXNfY21hLCAw
KTsKIAlpZiAocmV0KQogCQlnb3RvIGZyZWVfbWVtOwogCkBAIC00NzEsNiArNDg4LDE2IEBAIHN0
cnVjdCBwYWdlICpjbWFfYWxsb2Moc3RydWN0IGNtYSAqY21hLCB1bnNpZ25lZCBsb25nIGNvdW50
LAogCQlzcGluX3VubG9ja19pcnEoJmNtYS0+bG9jayk7CiAKIAkJcGZuID0gY21hLT5iYXNlX3Bm
biArIChiaXRtYXBfbm8gPDwgY21hLT5vcmRlcl9wZXJfYml0KTsKKworCQkvKgorCQkgKiBjbWEg
Yml0bWFwIHNob3VsZCBlbnN1cmUgdGhhdCBwZm4gaXMgaW4gdGhlIGNtYS4KKwkJICovCisJCWlm
IChjbWEtPnByZWFsbG9jYXRlZF9jbWEpIHsKKwkJCUJVR19PTihwZm4gKyBjb3VudCA+IGNtYS0+
YmFzZV9wZm4gKyBjbWEtPmNvdW50KTsKKwkJCXBhZ2UgPSBwZm5fdG9fcGFnZShwZm4pOworCQkJ
cmV0ID0gMDsKKwkJCWJyZWFrOworCQl9CiAJCXJldCA9IGFsbG9jX2NvbnRpZ19yYW5nZShwZm4s
IHBmbiArIGNvdW50LCBNSUdSQVRFX0NNQSwKIAkJCQkgICAgIEdGUF9LRVJORUwgfCAobm9fd2Fy
biA/IF9fR0ZQX05PV0FSTiA6IDApKTsKIApAQCAtNTUxLDcgKzU3OCw5IEBAIGJvb2wgY21hX3Jl
bGVhc2Uoc3RydWN0IGNtYSAqY21hLCBjb25zdCBzdHJ1Y3QgcGFnZSAqcGFnZXMsCiAKIAlWTV9C
VUdfT04ocGZuICsgY291bnQgPiBjbWEtPmJhc2VfcGZuICsgY21hLT5jb3VudCk7CiAKLQlmcmVl
X2NvbnRpZ19yYW5nZShwZm4sIGNvdW50KTsKKwlpZiAoIWNtYS0+cHJlYWxsb2NhdGVkX2NtYSkK
KwkJZnJlZV9jb250aWdfcmFuZ2UocGZuLCBjb3VudCk7CisKIAljbWFfY2xlYXJfYml0bWFwKGNt
YSwgcGZuLCBjb3VudCk7CiAJdHJhY2VfY21hX3JlbGVhc2UoY21hLT5uYW1lLCBwZm4sIHBhZ2Vz
LCBjb3VudCk7CiAKZGlmZiAtLWdpdCBhL21tL2NtYS5oIGIvbW0vY21hLmgKaW5kZXggMmM3NzU4
NzdlYWUyLi4xNzc4Y2IwZTY4YzQgMTAwNjQ0Ci0tLSBhL21tL2NtYS5oCisrKyBiL21tL2NtYS5o
CkBAIC0zMCw2ICszMCw3IEBAIHN0cnVjdCBjbWEgewogCS8qIGtvYmplY3QgcmVxdWlyZXMgZHlu
YW1pYyBvYmplY3QgKi8KIAlzdHJ1Y3QgY21hX2tvYmplY3QgKmNtYV9rb2JqOwogI2VuZGlmCisJ
Ym9vbCBwcmVhbGxvY2F0ZWRfY21hOwogfTsKIAogZXh0ZXJuIHN0cnVjdCBjbWEgY21hX2FyZWFz
W01BWF9DTUFfQVJFQVNdOwotLSAKMi4yNS4xCgo=

--_002_HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9HK0PR03MB4177apcp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--_002_HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9HK0PR03MB4177apcp_--
