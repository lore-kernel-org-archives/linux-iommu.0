Return-Path: <SRS0=0/W0=IO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FABC433DB
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 18:10:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F6865108
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 18:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F6865108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D50FA43003;
	Tue, 16 Mar 2021 18:10:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hrclxQlbWonF; Tue, 16 Mar 2021 18:10:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6AC23414EF;
	Tue, 16 Mar 2021 18:10:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C629C000B;
	Tue, 16 Mar 2021 18:10:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D9B3C000A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 18:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4305883852
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 18:10:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id baLWWvKfyA1p for <iommu@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 18:10:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::621])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE22083848
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 18:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHZpifMgfDA7X9U6FNNNzfypW4IQjuY73zVrO3tZiDLrFFKq9MRFMYPYGSMCrwAuZ+bQz4Hv3rzmnUzP09UEve1Y1QHF2JMlDOGlD4NjQ7O3EkHEoT2jlAK6M12IoEPx7qdJ/Y2xzUMqKuCAkDS1q7JbGC50rrpdlbTo6uDKV12seZxS69RP7jOLB6ts/uldG01Lc4HEndEKpBH8JlUm/g6+EY3rrsLvdlPbhI4y1pZaSzMJhFmP4Ix0cVAGc9YasF6Jlg2YtlVNvnCdF9CG4LE/HKmJnIG1oiLPTCgD/Y1Ccz+ofwb98xBoEWcKLU5wqfv84PDGlTWcPgL3ZAnX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLM4fabmxUPIyVowLS8a1rnY82CL1NKQYQichpfrHKw=;
 b=aA8GqPIJnrARMokoCxcilVattGQSKRiB7oXsOuYjby7RLxRIafpdHFYARN0i2pRDVMbrMZWm2WszDINKZ2z//NbtpJL7nOR1/l7Ehzjl3GF5Jpsjl1Tbg2dA17q+SKC29JRu9IuCn8RgALlrqZrQ5VVUcsbsMrWEWH9R8A2kLiJTuJ5mOX+j4PfNTKjQLZwQqjYK6AUaNnWHTq/Xa/HCSduYtEUIWby1LHoXcIQRSeFzo1AmvCM82i7Fb5mciIbJ9rpMv61nDOaYIfLN/TF7n6jLS56yTk6udY+tUbZk6TKL/mco+GwOGIbsQRgfYnTlxvXAF/07q/wU8irzZEyULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLM4fabmxUPIyVowLS8a1rnY82CL1NKQYQichpfrHKw=;
 b=qD8NQVPq/cIFr/xYTZgsP72Xqa4E9E8gso9VNHuiSoW3elGQJvD9LGPZw6hjbGnG/WtiPTksQpovdXfFBroOeJ8vfH5BgrfE69uPzgqkojg+uDdgjjYh52ViHLzbo3vtt2LFfjy9htcEEThXBfen7mJZmtl0CZqd8KMdJ7GXQaLQKXmW6Yqh7M7bOAt/b2qjLUF5MgCUfOedqWzTH5sH5zopiXGYYvn8G0tvddqvU9PeTzUJJa30IJ5HAhVhov4zSIkR/jL2mUIz+cCtx+c4qqDBsPkUlJJaObtVBrZqP35g5kN0ZaJi80QKNO5yxY3J21csci+4/14ttPVb1DskMw==
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 18:10:19 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::11bb:b39e:3f42:d2af%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 18:10:19 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Auger Eric <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "maz@kernel.org" <maz@kernel.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v13 00/15] SMMUv3 Nested Stage Setup (IOMMU part)
Thread-Topic: [PATCH v13 00/15] SMMUv3 Nested Stage Setup (IOMMU part)
Thread-Index: AQHWvZ0by+yuuitxUU+rB5qiY4c55qqGB4zAgAD4JoCAAJ9P4A==
Date: Tue, 16 Mar 2021 18:10:18 +0000
Message-ID: <BY5PR12MB376487CE3B3C36E59BEDEC5AB36B9@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20201118112151.25412-1-eric.auger@redhat.com>
 <BY5PR12MB3764285E7E8064B636132C65B36C9@BY5PR12MB3764.namprd12.prod.outlook.com>
 <d9934ef7-3bf0-b004-3fe9-e0adbcae5c05@redhat.com>
In-Reply-To: <d9934ef7-3bf0-b004-3fe9-e0adbcae5c05@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0df35358-a62a-435e-b5d5-08d8e8a6c220
x-ms-traffictypediagnostic: BY5PR12MB4901:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB49016DE5C105411FD54867DFB36B9@BY5PR12MB4901.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6vh6F6SbsnPLshOnA/QT5xpYLC9xZAHLnAhMfww/PfOgLmZYTezzIbJfCwJdfZA4kHD/KbAdykMDJ0ZIdPV2akcwFb0gqZnlI5APO5EdApLFj0zAF61TQZ7bz/LUX/4OnxukI60Lg97wC7tRs6UZjTfNvmu0H0CyiSB3KGGnQ+lzKfb8CLdvxvwRYYSKZiOMFGQNcp8y90590hw5yWVMIV2TPZNql+uqBPrvoGzz/XP3R0v8TLBCSi7mUa5p5JoGTY8oonry373OFIq2RupBWMjwUk/caphyueWtoah+mlXB00y0TLSpQHEWvKgGDg/TNcQ1ZaGzR292piwP7I5RpkIY2rJnhry9bavrCxLzkQJB+xoY4blsfdLRAp0sJffn+bra+KYbqL+gHnsnb1wXxq0utUX0nWAUdI+vTV9JzynRfus0iw+gxoozdVhrQjT3nXgl0D3LGzhlbhPy6kjq6AhhOQZEGepqYR16Hqqt3N7fXtyFln2+JraKQ18hPYlT0wCr/vvAIr1yQRw7E/ozVGoSmn8CgsqcZ10NF5TV4BalVNP07F+jGOEUgTHCbf8c7rW4S5Lp1P2yLs5UOEey+0x5m0u0qZJqDU1pJF0CxRg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(9686003)(55016002)(186003)(5660300002)(8936002)(8676002)(478600001)(26005)(52536014)(2906002)(316002)(107886003)(7416002)(6506007)(7696005)(54906003)(110136005)(64756008)(71200400001)(33656002)(921005)(86362001)(66476007)(66946007)(66556008)(76116006)(4326008)(83380400001)(66446008)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?cGJJMUJoc3cwYVNkVEJRbE81YS9vbkNuQW95NFBtL1pMUlNhMEkxQVJTajM4?=
 =?utf-8?B?Y0EzM1gxV1V2VVh4cUlYVEhJRlpMb0hHTUsyT2U4NDgyWHByT3FKb2NUbnpU?=
 =?utf-8?B?ZGE3ODNwNXZIVGhkdTRIL0Q0LzV3U1hlVlJvZkJja1NMYTR3TmNBY245dEho?=
 =?utf-8?B?cStTUXZPaC9lUVR6SW45cjhKZ0w2QzIyeFVmdXlLdmJ6L3Bma3hjTTJiV2Fi?=
 =?utf-8?B?NXdwTGFadytGei9YbWZqN2NTZVNmWWFDVXdaQXdrRmV6em1BU1hoUEQ4Q3BJ?=
 =?utf-8?B?eGhyUktvRElwblQwcjVhb1U4NGhNbGdENlkwb2dPbW9MbUpWZlRvMkZkdlhC?=
 =?utf-8?B?Z0RZRzNMMEdIS3B1cDBlakE2R01Ba1NleVlxa1VTNG52K3JIekpRd1FWM3gv?=
 =?utf-8?B?c1ZFSElMTEwrQnNpSnBCWGQ0RmxlcVZYYWpiQTcxSjlYc2pFd2ZlYURLZnlL?=
 =?utf-8?B?d29ZanRWTk5GclZ1MGgxSXFWWUFhdzk4V2lOUXI4ZjFQQTNCVlFRd0pBZG5x?=
 =?utf-8?B?ZXo1T1c3TCswT0E3eHFiTDBGZmMyeVAvdEFKdGhoZ3Y4MTR5c0ZZd1RlM0ZF?=
 =?utf-8?B?NHM3clZ5YzNDcUpNckF5Vi9WQTdnSkRsa2hveUJNQ3ZkYmlaSVpQNm9Ea1BY?=
 =?utf-8?B?eTc5VFpkLzBTYU4wZE84VDFHREd1c05zV09iS3B5WmIwcG9KQXQrRU52TGxj?=
 =?utf-8?B?WjVSMWVjWGxFR01VL24zdEVYT0J1NU84bVlaRFFWUCs2M1VYYXRFcVlJUkdC?=
 =?utf-8?B?MFNLYjFmZnNQMmxQMFM5Z0VjK0JkMitMY2tqcGdXYWcrN3cyMm1MWVpXNlVM?=
 =?utf-8?B?L1NXZjcxWmVpWk13Q01meTYvUWhSMkhmT2xKSktqUy9IajdjWWxZYVplQ1lZ?=
 =?utf-8?B?SVVFQWMrTGVhZkVWY3NUSDV0T3ZEeTRFS0w2RWhBaXZOL3Bjc1ZPL3RqUy80?=
 =?utf-8?B?SmNyZURSVDE4K2hidExaQW5POStqSzBDZGMxTmxhcEhzay93QysvNk4wOEZI?=
 =?utf-8?B?VkdkU0d6eVRVbFYyanhJQkVYYTRoQTNLU21pOHN4bXgrSGVBY2FaTEpsQjAy?=
 =?utf-8?B?UVE3eVZRKzdhVWo0dUowL3ZhbmpvWnVQdjRtbER1d3NDd09ZVmJ2QWFLMENS?=
 =?utf-8?B?T1VPRDRETFJqYTB0b2gxclViSUkwc1FKR2hEcHpXV2xwRlZBNzUyd2hPOXNs?=
 =?utf-8?B?clk3b1hSa1ljaGFaZ2pUdVV6Sm5XaU9pb3Fhb1dOU0RsWDBObE1aOWNSTEdK?=
 =?utf-8?B?TXJLYkVWU1lCZEU2L3JCWExyOTRZd1NseklXdUxKd3lUbHYvSUJINWRINHNY?=
 =?utf-8?B?L3U1enhSWUxKMTJsMk1jSXN4bFRQa3BuNm5LMk5NbEhVNkxIL0NWdVZ6R082?=
 =?utf-8?B?REkxeXRDK3hJNmExb3ZaSjdBbDZKY1p3ZkxWQVJucENpTzIwWFQ1MTF1ditu?=
 =?utf-8?B?Tjh4QmNjbGlPbW8rZ3dGYlFOS2JVZkxwNjhzSHlCYmhZN2Q0MmlYTUsxWmVM?=
 =?utf-8?B?OVpVU2c1MGlWNE5HNWdZYTlHZVBpQi9nMjZpbDRXRVhwa3dYTkpTOXFoOHZY?=
 =?utf-8?B?dEZpTnowamZ4SFZxSEZjOVB1T2krVFhHSmNLbGhRbGh1OUdqZnUva0UvM2kw?=
 =?utf-8?B?N0llYzFiM3BVdWhzZ2c1RUJtMFpCR3BZZWx2dmlaQ1R0U1ppSCtrVnZXcU5M?=
 =?utf-8?B?N1o0MUEyam8zY01wWXNoa1F0bXBnajRlN3E5TGVSSnVIOWFDRko4YTJXemNq?=
 =?utf-8?Q?IFiLkkSIbm2AaRdC4aSueyLHZQfz/ulfz6P6QUp?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df35358-a62a-435e-b5d5-08d8e8a6c220
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 18:10:19.0035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KFfG4hFejACqDNjmbjZkPIOgCk1TZcfsDXYo6wT4AsOeXs2ZTRUYeWyE+kvnHyNhnqm+DivsvdMtf50Hqp24Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Nate Watterson <nwatterson@nvidia.com>, Bryan Huntsman <bhuntsman@nvidia.com>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Pritesh Raithatha <praithatha@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 Sachin Nikam <Snikam@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> Hi Krishna,
> On 3/15/21 7:04 PM, Krishna Reddy wrote:
> > Tested-by: Krishna Reddy <vdumpa@nvidia.com>
> >
> >> 1) pass the guest stage 1 configuration
> >
> > Validated Nested SMMUv3 translations for NVMe PCIe device from Guest VM
> along with patch series "v11 SMMUv3 Nested Stage Setup (VFIO part)" and
> QEMU patch series "vSMMUv3/pSMMUv3 2 stage VFIO integration" from
> v5.2.0-2stage-rfcv8.
> > NVMe PCIe device is functional with 2-stage translations and no issues
> observed.
> Thank you very much for your testing efforts. For your info, there are more
> recent kernel series:
> [PATCH v14 00/13] SMMUv3 Nested Stage Setup (IOMMU part) (Feb 23) [PATCH
> v12 00/13] SMMUv3 Nested Stage Setup (VFIO part) (Feb 23)
> 
> working along with QEMU RFC
> [RFC v8 00/28] vSMMUv3/pSMMUv3 2 stage VFIO integration (Feb 25)
> 
> If you have cycles to test with those, this would be higly appreciated.
 
Thanks Eric for the latest patches. Will validate and update. 
Feel free to reach out me for validating future patch sets as necessary.

-KR
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
