Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F359C4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 11:26:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AAD61038
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 11:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9AAD61038
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=motorola.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71CF360BFE;
	Fri, 13 Aug 2021 11:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rAktbEevnvK6; Fri, 13 Aug 2021 11:26:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D58AF607D4;
	Fri, 13 Aug 2021 11:26:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEF14C0010;
	Fri, 13 Aug 2021 11:26:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99756C000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 11:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87ADE404C3
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 11:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=motorola.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wMGrT-hY8GB9 for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 11:26:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com
 [67.219.246.5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C8FC404BE
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
 s=Selector; t=1628853973; i=@motorola.com;
 bh=TQ5JXiozk8ai7t7MAkoOCmX4fk4QGLKL8hrVcOg2ypI=;
 h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 b=IIUNy/Tjr0JxNmZ21fMkeqS8o+Z1eTsCRLwbqLqVWj15hUjOOJRYGxPRrd7W/svFY
 h3ouca+OWSUIc6PwUvkvyglNskSCBjFW5dIVRVCx3B1Jd6ZS35jvY5pDy3I49oHLRA
 ouRARccz15krObPYsfb1IY9DHgUk66KR53pbqzEzusGUHeNCH7WXJvK/AnmJVLVnUN
 NN3HMFQ/ES9MH9sMWnn3wTbNoP5jQka6xkMtRnVOxwdyY/yIA9N32CbyS5CpDTKH0a
 eMqTXFA8E3phq7SBdXiD87GVrMyFPRtRFlrRHv3OCedG+7UJRgTcCiDxkc6m4cvvzw
 bcRDsm5lRnlxw==
Received: from [100.112.3.19] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-5.bemta.az-b.us-east-1.aws.symcld.net id C6/3C-28183-4D656116;
 Fri, 13 Aug 2021 11:26:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTf0xTVxjl9r22D8Kbj7bItQNxdYNNbWmNsjc
 xwSxsdCNkM1skmVvcQwrtVgrrK1vZ/KNuQ4coVBCilbaMAMNSras6OiASAR3yY2QMXDUgIk02
 HIY6AVkJsldedds/X8655zvfPffmXgwRVPPFmMpoUOl1lFbCi0DVSQe2SUf2rKXkg9UIWety8
 sh5VwAhz7Rc5ZB1nSnkr221PPK2c4VLnu0Z55NN87N88orfxyWrbixwd0UonTYnUE5Zv+cr3Y
 5SntL9VyVf2XtyCVVWeb8DyvabJp5y9vIoT1l+0QGUD93r3454j6vRZRcYP+Sqzxxf4RcupRr
 7Fs+jJmBOPQIiMEA0ItDn/pN7BIQz5BoKm4bXsMIPAP40MsIPEgFh58CTY0dRlkwA+JvLhQYt
 POIFeOx+z6ogIi6jsMbi4ASJkDgL4IUbfRxWqQCwoWJl1SIisuAtx+8giFHG7nO7+EGMEx/AM
 f8VDrvHCQQul9lXY4UTKbDd2oiwEeNgzd0JThAjRAy01lhWeyBBwIaOIYTF0XB66jGXPcY3AN
 4KmPmsEAeH7WWAxZmw9k5dyLwJmg4GGDPG4Ofh465idlkLK+3TofZE+PUDW6h9PXQcm0RZHA9
 r6mdD42PhHW8rL7gvJHw8WN17l8uSZhR2DiyFHHJoW+gJdTmi4IDzNtcMpJb/nMjCBEGIl6Cr
 LYldfg6eKJvkW1ZvKQpeP+VD6wDqANuz9Zo8tSGf0milCrlcqlBslSqk2+Qy6nNptqyIlqoo2
 iBVyKjPaBldnL9fmyPTqQxuwLzEnELwogeUzvhlXWAdxpFE4+cHRZTgmeyCnGI1Rav36Yu0Kr
 oLxGKYBOIH31lLCaL0qjyVMVejZd7zExlikRIRnvAuI+N0IZVPa/JYqQ+8hpmnrfUIduiSjam
 PvvqWqdcdDUztsTbWIwJUV6BTiWNwnPkOAiJoVhfpno5+8luGQZxYiIOwsDBBZKFKn68x/F+/
 B2IwIBHiWW8yUyI1OsPTBPeYcBwm3LmU6GA4A/WvJDZxjj/70c4Ka/+uxTVDqHOsuWLCkrrTk
 1Qw2P1lWrEosdJ4uju+/oAkvBrM5Un86xYPfYFwdggXe/d6A+bNLdvd0d6jk8K0pvTTc76lq3
 6FOXN3YcDU35K/MfeNDR0NaWl7u3/M6Nhw3+/8I6F12fTpvoVSW1RLPHXp9dFzF+WSdtq+nNp
 aElbs/FickTz+iWjG83KKasthvDRzZnd2lWci98Fcc8ZQ8pThFUtyBhqI6Xo0uCLY7AFeSb+l
 LTmxobwEDqS/P1TveXVel451XXtL8MvfnvEto1HNN/W4dY/w8NZOXdaOuNjRn5vLa4qwgNErP
 uWILYG1Uw83OvcnkBecEpRWU4pNiJ6m/gHcU8/fqAQAAA==
X-Env-Sender: zoujc@motorola.com
X-Msg-Ref: server-8.tower-395.messagelabs.com!1628853970!217662!1
X-Originating-IP: [104.47.124.52]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9979 invoked from network); 13 Aug 2021 11:26:11 -0000
Received: from mail-hk2apc01lp2052.outbound.protection.outlook.com (HELO
 APC01-HK2-obe.outbound.protection.outlook.com) (104.47.124.52)
 by server-8.tower-395.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Aug 2021 11:26:11 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs5XRiQXexKDLgPcmjrlVDdUYkLVySWzDrk+JNhIcFJoOfJr4IBv/7HoV/4lBuxQN5ieZjXhVH6uIBvMOSDXFqbk7Fk1C7npcRjd8QrRbvJwD+TTAtriE5yUx/3hWdoR6dCtsiEtg0LHYBmeGb6cnS39AGqYTXZzYuql6FmEk/zGb8rSAiiedIirZ8QGTYsu0tn1Pp5NFNgY/tbJklvgInBQRxLblQDx3NLTFOABaM6d3lgjejZv029vz2j8T2CuheSZ4bN+5nCg/DEfy8PnKGWCJgm3fOw0UzAcp3fEGx6ceayrdr50fKLUOd0pws2fIXNZ1C5IGaJaG8BYrT34lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ5JXiozk8ai7t7MAkoOCmX4fk4QGLKL8hrVcOg2ypI=;
 b=gE9lDKQiT0ggs6HIZQwWdPRKVEiKBViyB7kW8VKemhPbFIly5vJIbSRCJpgCs7Ok4yvL2NQNfwUJFcQA1ng14pyfDGOXzNt30WuBrkxhTvp3/gF8efoxXTG+LctsCBswKohDX490UzJiDubi7Aj+pzXgpNMD0/uYx1IvmalvFxTPArHxmltznyuE2iusjSmB0xyouy2212Jgfy7nwadWfGQFm6friMh0+GLjt1P66Hq1Suy4DE/13hGIInWTnSe2oNcd/4IZjIKiJ+1LAn1HNarlnSJiXjdix6bXmiZEy28OiUHpkjdiS3noFyBe6Wn0JNlGYKXhiapkoWZ4Ff7YdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from HK0PR03MB4177.apcprd03.prod.outlook.com (2603:1096:203:9b::11)
 by HK0PR03MB4627.apcprd03.prod.outlook.com (2603:1096:203:b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11; Fri, 13 Aug
 2021 11:26:07 +0000
Received: from HK0PR03MB4177.apcprd03.prod.outlook.com
 ([fe80::3866:22b3:d4cc:6be2]) by HK0PR03MB4177.apcprd03.prod.outlook.com
 ([fe80::3866:22b3:d4cc:6be2%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 11:26:06 +0000
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
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTogW0V4dGVybmFsXVJlOiBBbiBjbWEg?=
 =?utf-8?B?b3B0aW1pemF0aW9uIHBhdGNoIGlzIHVzZWQgZm9yIGNtYV9bYWxsb2N8ZnJl?=
 =?utf-8?Q?e].?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFeHRlcm5hbF1SZTogQW4gY21hIG9wdGltaXph?=
 =?utf-8?Q?tion_patch_is_used_for_cma=5F[alloc|free].?=
Thread-Index: AdeQD/l5FWbWirK9SGKJhUkkmda/hgAByYkAAAAgDAAAAw0cgAAAOKsAAAGY/wAAAPefsA==
Date: Fri, 13 Aug 2021 11:26:06 +0000
Message-ID: <HK0PR03MB417715BB2424508E24836E08D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
References: <HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
 <f5cd9fe6-3b62-eab8-1ff1-d3943d4bb85b@redhat.com>
 <HK0PR03MB41775573A48273BF128C7F72D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
 <ca497139-a6e8-cb66-e221-7fe4af2bda14@arm.com>
 <HK0PR03MB4177FDD7160ABAC3C8119984D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
 <52c0b1fd-d60f-5d7d-0b47-b3569678ebf6@arm.com>
In-Reply-To: <52c0b1fd-d60f-5d7d-0b47-b3569678ebf6@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9408375b-59b5-4446-7ae8-08d95e4d249c
x-ms-traffictypediagnostic: HK0PR03MB4627:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR03MB4627341BDB826ECDDFBE1B92D5FA9@HK0PR03MB4627.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MImzjKWMmPqd94kpAn39TQp+SymoNUzDJ46Jyhkv4vRl4E9zlSOGwJ5f632dJl+Z5NYkDZIVK47DpevdjG+1ZQRQxsYTh4t+dBE15dDA+4hFkbebVdYKgsIbQ75N/lD+Fo1IcjbC8sPX29r4zx3+bmN2UN1WQg1sMAfQlhI37MorJP88EwqG2SsrZWcIABnsGb713NxIA0UVz0mVeVmjlFTi37NYYaz4Beakxdtr9HVYus+QfW4XF23ER6XXlHaUe7H5AmR35iJuWdo39+wXCqe4SqEwv2gR4N87GVZAc7m5A+tyUuSwBLj1rDWdXM6JjfdIjCPHkg5rLrdEJr1e6I28DF3vxOWYVz+HR4A1BITHPI95k/hechmp3hbuJ03jiDd6ck6NozflyfuBV6m0FoPmSI2BAgvC9KWcb3sW2frPL4D+iEUZFrsXMv9iBT05NE2lJ+Rpcyx+nCILBeZf40B0dWlHgIEdGCEmH1jQ30CzT8laTsquY4JzAULEVvFuD59gBk1Vd06+vDWfSFkVtsy8TrIPumy1I43mC9rldBRe+/QbSwfuz47WaVjAscePozaclW64LABn1RynpHrSUogJRC07F7N33Gsw++xNFLjVlEj4F5OmJH9NB0iDi5SX3LN5bNFmLH4jEodhud6vQe8nrey6AK4LKdTd1GX2lRNBijV6bERRt6RDLCkqUgq7OxGAbB9EOKFvSxdPUIAG1+YvxF51YOpQoNJjmGG1KfEewwvFTdLHYTPQRT8FtDTH8yid/4FvzKoY7RRFPWMRQUMoK+ZQFM9DUQklzZPGM3fQSFr1fFKoKgAyIrO8tvg9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HK0PR03MB4177.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(33656002)(38100700002)(71200400001)(122000001)(86362001)(6636002)(66556008)(66476007)(9686003)(224303003)(38070700005)(5660300002)(53546011)(45080400002)(66446008)(55016002)(6506007)(64756008)(478600001)(8936002)(966005)(2906002)(52536014)(110136005)(76116006)(26005)(316002)(921005)(7416002)(7696005)(66946007)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDd6UUxSaGJOYUw1T2M4U3Q4VitBWkRVRVVtWWRzNmlnNUVrRHpPeExRUGpN?=
 =?utf-8?B?ZFRaRTdUQmtQL1dVTENRYUowM2R2OHNxQWxQTjQ5c0YwbWJ4WEd0L2tRNFZp?=
 =?utf-8?B?UzB2RERwZm5rRWhTK2h2N3V2Qm9NTk81MHZvVURKMmg2RzRLRGlMYWhCV1d5?=
 =?utf-8?B?RXI0S3VXQUNzOG1tQTJnYTRVMlhPM0gvVEJJYnFYRjY1dUY2bkxTYnord0ZQ?=
 =?utf-8?B?ak96R2k1enBnbnZUTnhXdlJrUHBwa0daKzY1MGVUM0Q4RENac2U4dE5oZ1U3?=
 =?utf-8?B?M3JMcjRZaGxxWDdubTk0RTZZbWxkVllnMVZ3dHJYV0xUUTJKQk9lWFdXbFJU?=
 =?utf-8?B?RlF4Q1JaMkJCbHpEMnhaOTM2QlpwWHVPQlozZUlwUUltUmFPZnV6RElVZFpO?=
 =?utf-8?B?MmJVajNteE0vVXFNcWtYOExrNTkxU1dPL2VBZlFlNFdIYjFoMnkweTZUa2xw?=
 =?utf-8?B?eHM2TitCbXU4WU1mVzJNTkU0T2x2QTVGcGZQbDVJMUV6d2t2MFpzWWc3V3c3?=
 =?utf-8?B?UXd6RVlEQ1JXWEpLcmpVdjdPZDg5S1V3SWdEcFlHQUpGc2JESUFBY01raTVo?=
 =?utf-8?B?RFc4TFlSSW1sWmcrOWxBSjVMS3FWU0pnQ2FLaFNOclZTNlhzeEZOcGJ4ZjFu?=
 =?utf-8?B?Qnl1T0VRVkE1WlpDTE1PN24wcldZQ0ZFUzlKRTMyZEdDcUFsdjBTc1JFS3ZV?=
 =?utf-8?B?cHFraGIzMXVHR0xCdlB3QUhNVmlkVjB3TW9CNHVCdkY2T2lydTZvYTlLcW9R?=
 =?utf-8?B?YXJVR2cvOXRPekxjRmx2VXpIUVZGYWpyRXRJS3FhUWdlUXozeFNkYzhNT2xN?=
 =?utf-8?B?Q2ZUZzdBMDFrNTlFeDBBSzY0UzFiL2VRNUpDanhBeWNKdDBidTVKM2NKRDV1?=
 =?utf-8?B?aE1RRXhsRE14NFZMS3cvcDN4WHN5NWhxMG1lY2xDQlhDaFdEaTZhZ3lFK3JP?=
 =?utf-8?B?aG9LYW80cUNRWFlHTkJyUmZHaWFVaDdFT1J2OFdCdmtnNkg0WUpTMlpSSFBm?=
 =?utf-8?B?TnhRN2ZpcVdhWmZBVXcxNHBsMExWRkZ0QTFLTFVJRmdDTTJRMHVMVHY4cG1j?=
 =?utf-8?B?OUJmbWsvWkJrRHhIMUd2d1hSZk94aEVBU3YyWmJvRk9SeUN1Q2h5SFlsYlNB?=
 =?utf-8?B?YkR1UDY4RUhQeURwOWNZZ2xhTFVYYzZxd2QrMWN5WUlhRDJGYzhYU0Z4dGE5?=
 =?utf-8?B?OUVuYk9lQWlWTmM5aDlobC9iMlhLVkU3SWFuRko1eDBXWXdtZ3RZd2RTRUZH?=
 =?utf-8?B?ZWM5ckYxSDl5TmJFUWtQOUQ5ekN0a3lTK09DS1paRGhrcmNrLzVFek5ydSty?=
 =?utf-8?B?Y2xWYnhUQUtQemcyaGpWOU9OT1lmWWIwQ1lxOHpqd211MjdkVlI1Z3ErL1pH?=
 =?utf-8?B?K3ExRmNDUWQrSFJtZGEycllGNzZRMHYxN3Y1ZFJ6MHJWbnhkeVBpUEpOMTBw?=
 =?utf-8?B?ZnNMdEJGeGcyY2t6a1R2VDdlbVdZaldWU1VOYzdCSFJNSGtIRmcyWktJaTFk?=
 =?utf-8?B?aFVxaTgzZnNCQlFHMWkxN2pYWVRUanQ0TUxGQUR0cDFyc0RSYXJsVnF6VXRm?=
 =?utf-8?B?VlU1MHptOUw3b0tTSE5yc0NraXRaSVJXMkt0aGFoUDNZR1FLajgzZFlDTlNa?=
 =?utf-8?B?cnYxbkVzVnZ4WTdqV0hadWczMHZnNTJFSjhXMVdGNWc3UEtUUnhGTG1lN0pD?=
 =?utf-8?B?d0t6RU9nNnRUZVRtck01V2pkL1RmZ1dZSWtBQ05iMyt1MGh6a2tXZ3dyWWJ4?=
 =?utf-8?Q?G4YarMSfC3rYFpaKPg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB4177.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9408375b-59b5-4446-7ae8-08d95e4d249c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 11:26:06.7714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jp6LYsH4YgnUUlIrrcvXDj6YmcAJUw+uUhZJKG1BfUIMU/mDhzovLSjRIS7KODAU4nqxD3TK0xhf/t9xUGNg+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4627
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

SGkgUm9iaW4sIERhdmlkDQoJVGhhbmsgeW91IGZvciB5b3VyIGd1aWRhbmNlIHZlcnkgbXVjaCwg
d2UnbGwgZ28gYWhlYWQgYW5kIHNlZSBpZiBzb21lIGhlYXAgZHJpdmVycyBjYW4gdXNlIGNhcnZl
b3V0IGhlYXAgaW5zdGVhZC4NCg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQoNCi0tLS0t6YKu
5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJt
LmNvbT4gDQrlj5HpgIHml7bpl7Q6IDIwMjHlubQ45pyIMTPml6UgMTg6MDgNCuaUtuS7tuS6ujog
SmljaGFvIFpvdSA8em91amNAbW90b3JvbGEuY29tPjsgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlk
QHJlZGhhdC5jb20+OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IG1pbmNoYW5Aa2VybmVsLm9yZzsgc29u
Zy5iYW8uaHVhQGhpc2lsaWNvbi5jb207IGhjaEBsc3QuZGU7IG0uc3p5cHJvd3NraUBzYW1zdW5n
LmNvbTsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IEppYW5RaSBZYW5nIDx5YW5n
akBtb3Rvcm9sYS5jb20+OyBZYW5qdW5lIFRpYW4gPHRpYW55amVAbW90b3JvbGEuY29tPg0K5Li7
6aKYOiBSZTog5Zue5aSNOiDlm57lpI06IFtFeHRlcm5hbF1SZTogQW4gY21hIG9wdGltaXphdGlv
biBwYXRjaCBpcyB1c2VkIGZvciBjbWFfW2FsbG9jfGZyZWVdLg0KDQpPbiAyMDIxLTA4LTEzIDEw
OjQ2LCBKaWNoYW8gWm91IHdyb3RlOg0KPiBJIGdvdCBpdCwgYnV0IGluIGtlcm5lbCB0aGF0IHdl
IHVzZWQgdmVyc2lvbiwgbWFueSBoZWFwIGRyaXZlcnMgdGhhdCBpbiBkcml2ZXJzL2RtYS1idWYv
IGFyZSBiYXNlZCBvbiBDTUEsIG5vdCBETUEgY2FydmVvdXQhDQo+IElmIHRoaXMgcGF0Y2ggaXMg
bm90IGFjY2VwdGVkLCB3ZSBjYW5jZWwgaXQhISENCg0KSWYgeW91IGp1c3Qgd2FudCBkbWFfYWxs
b2NfY29oZXJlbnQoKSB0byB3b3JrIGF1dG9tYXRpY2FsbHkgZnJvbSBhIGNhcnZlb3V0IGluIHRo
ZSBzYW1lIG1hbm5lciBhcyBDTUEsIHdpdGhvdXQgaGF2aW5nIHRvIHN0aWNrDQpvZl9yZXNlcnZl
ZF9tZW1fZGV2aWNlX2luaXQoKSBjYWxscyBldmVyeXdoZXJlIHRvIG1ha2UgZHJpdmVycyBhd2Fy
ZSBvZiBwZXItZGV2aWNlIGNhcnZlb3V0cywgdGhlbiBbMV0gaXMgcHJvYmFibHkgd2hhdCB5b3Ug
d2FudC4NCg0KSWYgaXQncyBzcGVjaWZpY2FsbHkgZG1hLWJ1ZiBoZWFwcyB0aGF0IHlvdSdyZSBp
bnRlcmVzdGVkIGluLCB0aGVuIGhhY2tpbmcgdGhlIGNvbW1vbiBDTUEgY29kZSB0byBtYWtlIHRo
ZSBDTUEgaGVhcCBiZWhhdmUgbGlrZSBhIGNhcnZlb3V0IGhlYXAgaXMgZGVmaW5pdGVseSB0aGUg
d3JvbmcgYXBwcm9hY2ggLSBqdXN0IGltcGxlbWVudCBhIGNhcnZlb3V0IGhlYXAgcHJvcGVybHku
IEl0IHNlZW1zIHRoZSBvbmx5IHJlYXNvbiB0aGF0IGhhc24ndCBwb3J0ZWQgb3ZlciBmcm9tIElP
TiBpcyB0aGF0IG5vYm9keSdzIG5lZWRlZCBpdCB5ZXRbMl0uDQoNClJvYmluLg0KDQpbMV0gaHR0
cHM6Ly9hcGMwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGbG9yZS5rZXJuZWwub3JnJTJGbGludXgtaW9tbXUlMkYyMDIxMDcxMjA2MTcwNC40MTYy
NDY0LTEtaGNoJTQwbHN0LmRlJTJGJmFtcDtkYXRhPTA0JTdDMDElN0N6b3VqYyU0MG1vdG9yb2xh
LmNvbSU3QzlmY2EwNjllMTkxNTQ0OTk0NmNiMDhkOTVlNDI0NTQ2JTdDNWM3ZDBiMjhiZGY4NDEw
Y2FhOTM0ZGYzNzJiMTYyMDMlN0MxJTdDMCU3QzYzNzY0NDQ2MTA2NjAwNDUwOSU3Q1Vua25vd24l
N0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJ
NklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1PWEZQNDhXdk9iY0JaWCUy
RndLV2lQdFFQTnd6Y1dIeGFLYUlyNU1BdmFxNWclM0QmYW1wO3Jlc2VydmVkPTANClsyXSBodHRw
czovL2FwYzAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsd24ubmV0JTJGQXJ0aWNsZXMlMkY4MDEyMzAlMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q3pv
dWpjJTQwbW90b3JvbGEuY29tJTdDOWZjYTA2OWUxOTE1NDQ5OTQ2Y2IwOGQ5NWU0MjQ1NDYlN0M1
YzdkMGIyOGJkZjg0MTBjYWE5MzRkZjM3MmIxNjIwMyU3QzElN0MwJTdDNjM3NjQ0NDYxMDY2MDA0
NTA5JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lW
Mmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPU43
R25GZjR6R01EUHpmZzFHR09vVXZkZEJJNFU0YnA3S2liMzRhcndrQkklM0QmYW1wO3Jlc2VydmVk
PTANCg0KPiANCj4gVGhhbmsgeW91IGFsbC4NCj4gDQo+IEJlc3QgUmVnYXJkcywNCj4gDQo+IC0t
LS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11
cnBoeUBhcm0uY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjHlubQ45pyIMTPml6UgMTc6MTYNCj4g
5pS25Lu25Lq6OiBKaWNoYW8gWm91IDx6b3VqY0Btb3Rvcm9sYS5jb20+OyBEYXZpZCBIaWxkZW5i
cmFuZCANCj4gPGRhdmlkQHJlZGhhdC5jb20+OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyAN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBtaW5j
aGFuQGtlcm5lbC5vcmc7IA0KPiBzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbTsgaGNoQGxzdC5k
ZTsgbS5zenlwcm93c2tpQHNhbXN1bmcuY29tOyANCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmc7IEppYW5RaSBZYW5nIDx5YW5nakBtb3Rvcm9sYS5jb20+OyANCj4gWWFuanVuZSBU
aWFuIDx0aWFueWplQG1vdG9yb2xhLmNvbT4NCj4g5Li76aKYOiBSZTog5Zue5aSNOiBbRXh0ZXJu
YWxdUmU6IEFuIGNtYSBvcHRpbWl6YXRpb24gcGF0Y2ggaXMgdXNlZCBmb3IgY21hX1thbGxvY3xm
cmVlXS4NCj4gDQo+IE9uIDIwMjEtMDgtMTMgMDk6MjcsIEppY2hhbyBab3Ugd3JvdGU6DQo+PiBI
aSBEYXZpZCwNCj4+IAlJJ2xsIGdpdC1zZW5kLWVtYWlsIHBhdGNoIGFnYWluLg0KPj4gCVlvdXIg
dW5kZXJzdGFuZGluZyBpcyBleGFjdGx5IHJpZ2h0Lg0KPj4gCUxldCBtZSBleHBsYWluIHRoZSBi
YWNrZ3JvdW5kIG9mIFBhdGNoLCB3ZSBhcmUgZGV2ZWxvcGluZyBBbmRyb2lkIHBob25lLCBrZXJu
ZWwgaXMgNS4xMC40MyBMVFMsIHdlIGVuY291bnRlciBjbWFfYWxsb2MgZmFpbGVkIGR1cmluZyBr
ZXJuZWwgc3RhcnR1cCwgYnVkZHkgc3lzdGVtIGlzIHJlYWR5LA0KPj4gMDEtMTEgMTQ6MjI6MDgu
NjUwICAgMjE2ICAgMjE2IEUgY21hICAgICA6IGNtYV9hbGxvYyhbMjE2XVtpbml0XTpjbWEoZmZm
ZmZmZmYwMGI1MDAwMDp0b3RhbCA4MTkyKSBsaW51eCxjbWEoZmZmZmZmZTg5ZDA4NGNmMCksIGNv
dW50IDIsIGFsaWduIDEgZ2ZwX21hc2sgMHhjYzApDQo+PiAwMS0xMSAxNDoyMjowOC42NTAgICAy
MTYgICAyMTYgRSBjbWEgICAgIDogY21hX2FsbG9jKCk6IG1lbW9yeSByYW5nZSBhdCBmZmZmZmZm
ZjAwYjYyODgwIGlzIGJ1c3ksIHJldHJ5aW5nDQo+PiAgICANCj4+IAljbWEgYml0bWFwIHNob3cg
bWVtb3J5IGlzIGZyZWUsIGJ1dCBhbGxvY19jb250aWdfcmFuZ2UgZmFpbGVkLCB3ZSBjaGVja2Vk
IGl0IG91dCB0aGF0IHNvbWUgZHJpdmVycyBjbWFfYWxsb2MgYXJlDQo+PiAJInN0cnVjdCBwYWdl
ICpjbWFfYWxsb2Moc3RydWN0IGNtYSAqY21hLCBzaXplX3QgY291bnQsIHVuc2lnbmVkIGludCBh
bGlnbiwgYm9vbCBub193YXJuKSINCj4+IAlJbiA1LjEwLjQzLCBjbWFfYWxsb2MgaXMNCj4+IAki
c3RydWN0IHBhZ2UgKmNtYV9hbGxvYyhzdHJ1Y3QgY21hICpjbWEsIHNpemVfdCBjb3VudCwgdW5z
aWduZWQgaW50IGFsaWduLCBnZnBfdCBnZnBfbWFzaykiDQo+PiAgICAJQWZ0ZXIgY2hhbmdlIGNt
YV9hbGxvYyBwYXJhbWV0ZXIgd2l0aCBHRlBfS0VSTkVMLCBpc3N1ZSBpcyBmaXhlZCwgYXQgdGhl
IHNhbWUgdGltZSwgd2UgZm91bmQgdGhhdCBwcmVhbGxvY2F0ZSBhIHBvcnRpb24gb2YgY21hIG1l
bW9yeSBmb3IgYXVkaW8mdmlkZW8gcmVzdWx0ZWQgaW4gYmV0dGVyIHBlcmZvcm1hbmNlIGFuZCBn
dWFyYW50ZWUgQVYgZnVuY3Rpb24gZXZlbiB1bmRlciBtZW1vcnkgcHJlc3N1cmUsIHNvIHdlIHRy
eSB0byBzdWJtaXQgdGhpcyBwYXRjaC4NCj4gDQo+IFRoZSB3aG9sZSBwb2ludCBvZiBDTUEgaXMg
dGhhdCB0aGUgbWVtb3J5IGNhbiBiZSBzaGFyZWQgYnkgbW92ZWFibGUgcGFnZXMgd2hpbGUgaXQn
cyBub3QgYmVpbmcgdXNlZCBmb3IgRE1BLiBJZiB5b3Ugd2FudCBhIGRlZGljYXRlZCBETUEgY2Fy
dmVvdXQsIHRoZXJlIGFyZSBhbHJlYWR5IG1lY2hhbmlzbXMgZm9yIHRoYXQuDQo+IA0KPiBSb2Jp
bi4NCj4gDQo+Pg0KPj4gVGhhbmtzLg0KPj4NCj4+IEJlc3QgUmVnYXJkcywNCj4+DQo+PiBab3Ug
SmljaGFvIOmCuee6qui2hQ0KPj4gQWR2aXNvcnkgRW5naW5lZXIsIFNXIEJTUA0KPj4gTUJHIFJP
VyBTVyBCSiBQRiBCU1AgKENOKQ0KPj4gTW90b3JvbGEgTW9iaWxpdHksIEEgTGVub3ZvIENvbXBh
bnkNCj4+IG1vdG9yb2xhLmNvbQ0KPj4gTSArODYgMTg5MTA4NjAyMTINCj4+IEUgem91amNAbGVu
b3ZvLmNvbQ0KPj4gdHdpdHRlciB8IGZhY2Vib29rIHwgaW5zdGFncmFtIHwgYmxvZyB8IGZvcnVt
cw0KPj4NCj4+DQo+Pg0KPj4NCj4+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4+IOWPkeS7tuS6
ujogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+PiDlj5HpgIHml7bpl7Q6
IDIwMjHlubQ45pyIMTPml6UgMTU6NDUNCj4+IOaUtuS7tuS6ujogSmljaGFvIFpvdSA8em91amNA
bW90b3JvbGEuY29tPjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgDQo+PiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IG1pbmNoYW5Aa2VybmVsLm9y
ZzsgDQo+PiBzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbTsgaGNoQGxzdC5kZTsgbS5zenlwcm93
c2tpQHNhbXN1bmcuY29tOyANCj4+IHJvYmluLm11cnBoeUBhcm0uY29tOyBpb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZzsgSmlhblFpIFlhbmcgDQo+PiA8eWFuZ2pAbW90b3JvbGEuY29t
PjsgWWFuanVuZSBUaWFuIDx0aWFueWplQG1vdG9yb2xhLmNvbT4NCj4+IOS4u+mimDogW0V4dGVy
bmFsXVJlOiBBbiBjbWEgb3B0aW1pemF0aW9uIHBhdGNoIGlzIHVzZWQgZm9yIGNtYV9bYWxsb2N8
ZnJlZV0uDQo+Pg0KPj4gT24gMTMuMDguMjEgMDk6MDAsIEppY2hhbyBab3Ugd3JvdGU6DQo+Pj4g
UHJlLWFsbG9jYXRlwqBDTUHCoG1lbW9yecKgdGhhdMKgY29uZmlndXJlZMKgaW7CoGRldmljZSB0
cmVlLMKgdGhpc8KgZ3JlYXRseSANCj4+PiBpbXByb3Zlc8KgdGhlwqBDTUHCoG1lbW9yeSBhbGxv
Y2F0aW9uwqBlZmZpY2llbmN5LMKgY21hX1thbGxvY3xmcmVlXcKgaXMgDQo+Pj4gbGVzcyB0aGFu
wqAxbXMswqBvbGTCoHdhecKgaXPCoHRvb2vCoGHCoGZld8KgbXPCoHRvwqB0ZW5zwqBvciBodW5k
cmVkc8KgbXMuDQo+Pj4NCj4+DQo+PiBQbGVhc2Ugc2VuZCBwYXRjaGVzIGFzIHByb3BlciBlbWFp
bHMgKG1hbiBnaXQtZm9ybWF0LXBhdGNoOyBtYW4gZ2l0LXNlbmQtZW1haWwpLg0KPj4NCj4+IFdo
YXQgeW91IHByb3Bvc2UgaXMgdHVybmluZyBjbWEgcmVzZXJ2YXRpb25zIGludG8gc29tZXRoaW5n
IGNvbXBhcmFibGUgdG8gcGVybWFuZW50IGJvb3R0aW1lIGFsbG9jYXRpb25zLiBGcm9tIHRoZSBQ
T1Ygb2YgdGhlIGJ1ZGR5LCB0aGUgcGFnZXMgYXJlIGFsd2F5cyBhbGxvY2F0ZWQgYW5kIGNhbm5v
dCBiZSByZXB1cnBvc2VkIGZvciBlLmcuLCBtb3ZhYmxlIGFsbG9jYXRpb25zIHVudGlsICphY3R1
YWxseSogYWxsb2NhdGVkIHZpYSBDTUEuDQo+Pg0KPj4gSSBkb24ndCB0aGluayB3ZSB3YW50IHRo
aXMgYmVoYXZpb3IgdXBzdHJlYW0uDQo+Pg0KPj4gLS0NCj4+IFRoYW5rcywNCj4+DQo+PiBEYXZp
ZCAvIGRoaWxkZW5iDQo+Pg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
