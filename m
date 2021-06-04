Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7646FC07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 08:38:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2966140F
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 08:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2966140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9C4D4062F;
	Fri,  4 Jun 2021 08:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m02y1DTJAzRy; Fri,  4 Jun 2021 08:38:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B87804062C;
	Fri,  4 Jun 2021 08:38:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D763C000D;
	Fri,  4 Jun 2021 08:38:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 773A2C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 08:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6513F40212
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 08:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id arKM_LNDkRO8 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 08:38:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31CB440200
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 08:38:32 +0000 (UTC)
IronPort-SDR: a1NiUWYNm/WdhhoVtr4LHH+IO5zO/NHcMKZFf2nt6wJUAkOZ+dwjvfjeVpb+GewMkoPnTy1DU0
 DE7ZH6xMDXog==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="289881510"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; d="scan'208";a="289881510"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2021 01:38:32 -0700
IronPort-SDR: c0Wg9vaBv8Y2jyx5J7hx/aIo89DiQ+KPhTsYvfcHRgJC2/Ie65veakSTUbHpm8GwVuNCbyQUVd
 kcAcc9oF6Gng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; d="scan'208";a="448184176"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2021 01:38:31 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 01:38:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 4 Jun 2021 01:38:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 4 Jun 2021 01:38:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFbHLc9e15LJ22Ko7ze+jFoSn7IQa2b7xddEmOvS7nesHxu+szDcgv8JBU5BBjOtvttaX3k8EBfa9Kmf+8GIHle6dn0VXmdGirPzp9GjfwwhNUI5oK9JqN1MGd/qxbIOuK/kxEyTw5cHWAI2E3LF7Q5HFc+Y/yaCSmwKF+SmjE3HPeKDV3jy0osUeJsyfBFY/OyC5sw7AHaAQQSU+FYsluWFPTF8t3YZ+fP5iueCdAUjAPoTBdDPL1qM+M5hmJK03SdzA0AIMnf0R0cHKLLz+37HhZ4KVBUzf56XUufkYA0NBM16VFMzL/lrwf+9oSquzpOevQFPVRK0PCUxyoOOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW4S3TSUhMbEMHUZtE+0d2Ukx09uGorK4tZIC4g2fzU=;
 b=e6Q7qN99Fl9RM/iXAnb96w8wx3DskJYHT4weUUK/iL+zMj2/vw//hKuNmq0hi0RkJ7I58p7ZxCL7+sYC4WhHxqF10B64tvNvu61yTOfO9wG73L+KCqT+hrdefXV6fY38CNLNJLVnz9/cWzQ5BoX9HTrYOqQcMi41SvXxBo1IGdrx8vKsCbJmiqZABafdV00wqHBvwu+Eq04M61P+FgXcMTiffeIO5XN2f5jNpKuwnoSpiQ/JG/a/JkRIFHHqoCFNzKx6Wm3tyJiNxOjeFd5OPQG9ybwdd3HD+65jN94oXUsMdFHOkM/aEbUJc82N9MS6Ra577lnAcRh+hB+D3vcwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW4S3TSUhMbEMHUZtE+0d2Ukx09uGorK4tZIC4g2fzU=;
 b=MD/jSnzwKRQ3vNApbDr5D6nl1rhLaF/hDo8mCIJYxBP8AgwLSavY50k9z4AgmLfAu7cMVFHh2iTj4zJtrhpiuRxhg+opmDkuGtzRry6P0cKIc3qibrOv0Pkx6ldBrcDXnsONYmhmftBB33ZsTaYrEGFjdOTdMaLDkExSHnDGHTo=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (10.175.54.9) by
 MWHPR11MB1407.namprd11.prod.outlook.com (10.169.235.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Fri, 4 Jun 2021 08:38:27 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4195.023; Fri, 4 Jun 2021
 08:38:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBL2ymAAKTbxpAAKSt7gAAHpf9wAB1YcAAAAm5sgAAA1YgAAADonIAAAEmcgAABzCaAAAHbfwAAAYTsAAAEeLUAAAiRJwAAFF14gAAPozMAAABMSwAAA0bJgAAVeTBA
Date: Fri, 4 Jun 2021 08:38:26 +0000
Message-ID: <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <20210603123401.GT1002214@nvidia.com>
 <20210603140146.5ce4f08a.alex.williamson@redhat.com>
 <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
In-Reply-To: <20210603154407.6fe33880.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db973ed0-df5d-4e18-5b04-08d927341f81
x-ms-traffictypediagnostic: MWHPR11MB1407:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB14078B981C93626299C04BA78C3B9@MWHPR11MB1407.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mz85HfdCzMQWsiH92iRVnG5FEjBWjPLc0SYv2xBciCAsy4y8bK70NrmTsvzvB/LlrnsNV/2oAAoCVWhLa8zHqP7rIGbmSzBhndNoNutpX28hIBWn/ONZmTXfVoNZw5kzOB8tThCM1XSyEemk4GD0GkCNfUQBzfIzF9dIpnhp04NlfSg117ZQQ5q9G5aM/AydZF6bjGiZ1BttWObt0hpGOv9hBP7nvMzMA3W7u4LcykwTJhUorPnOIuZnn/bmVLesss/H065WyyHG3F/czJE+QxEQnYgP8VCJIL7PEwoWoPanKa5c9RKYzHCSKKTWJRwvNMbtl+R0Y/bonnipp+xoYWI5jIECn37G22kB9dIeBstDqQRHJT7q0Eojvq5R5KLpUjMfA2J0ul4Q+Z8pxwxdM3L20yMPNrjU5/u7kOqs3M9xLKK+D3zR0f5gtp1eKzJBvz5dsYUZL4238b1DHXePrsX5kpzpzAFbrkz0gSmV9ZGsq2dpLk29wELcnR97Edntg3FPlbZT4Zod2kpF7vaKFrq5toueSdV7nqR3Eedm2uxX02fnRt1OoZ9YpoP8GvfDq8Jxn3OKX8jPFUG+Qd+lm14CfYx88Q4qfO43UqSgPeY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(136003)(396003)(366004)(39860400002)(7696005)(33656002)(38100700002)(8676002)(122000001)(8936002)(71200400001)(9686003)(6506007)(83380400001)(26005)(86362001)(478600001)(4326008)(186003)(2906002)(66476007)(55016002)(316002)(7416002)(110136005)(54906003)(66946007)(52536014)(5660300002)(64756008)(66556008)(66446008)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LZdpYuq4lxuqgNMsDManEC5QoBNKdW4xHBAAnPiQ/H2zikgDcxDNT0eeSMG0?=
 =?us-ascii?Q?2093K0zrf7A3hLW9Mlk5ac1bMvH7+OYIhz3nt6RktoHGuMb0nhkenD2W56iV?=
 =?us-ascii?Q?EXzL1Tt73xWFcoOUWr3vOVsQ1KgpBU15jXxKDmbLo0HrGkAndORPUOo0Qzkt?=
 =?us-ascii?Q?r4nGlW5FvV5peQP2f2PTVBbEPgekBYMPgYREEXgaZeZBzDlvh99e7Z5J5mCK?=
 =?us-ascii?Q?sTZAoLcyqJjRNIXckUZoIIyDpzXcdV7Kpilq2kwq8p0qPoAntCfSUMbQzBKl?=
 =?us-ascii?Q?iS4TmTZ5/pGUlK7DeW9XRNkqz7gTj8PD6elqrb600yBg+H+PUXVnTC3VaXhr?=
 =?us-ascii?Q?Wc0aNTTmh1E2C70LHoyUq3O8W1CEHqss5ZFWYzVjpCa0TdGIP7pAopSmbaCw?=
 =?us-ascii?Q?gUdYp7qdgXGHU57beAQ+BDnMfFLR4j9wD+ArDnVJ45ZrhkIwtf2U8NPdRyoP?=
 =?us-ascii?Q?bukt4c05ETx56nAXvB2Y1P34BuvDTvC7oocj38w4gpF6AgaVxjO7SXs16bur?=
 =?us-ascii?Q?5JB3B717vR56IqeQQ1USiq/UOhe8yKvSe1UeNG7N4rLoUx5E7hkjvLkNAITo?=
 =?us-ascii?Q?LjP7NKeO4PEBw1xPKpscjt1o9Dy8AzYoG3sRgd8sWtcCgOIw8Uv9cFe7lRPg?=
 =?us-ascii?Q?c4r0Jyc84d2CaDxkA6qZrgJIl4cIUEMNMG+eWZauL+8hMEXPnBEcX6y5BRoi?=
 =?us-ascii?Q?vUA7X1AoFfBMqcJviGstps4Jl6XykKuv6b1yDsrhd/vxng5y9JN5NovHZbGO?=
 =?us-ascii?Q?/q5mG+wb96g92Z4wVhgCyAAOa4NZRbDdnNIysvV+L/CAni21dgNxqPpQ4tJs?=
 =?us-ascii?Q?1hjrv+USeWNdk7YEPAghuhB517HNDNN9buVu2To+aPuXyPsBzarHP+eoVk13?=
 =?us-ascii?Q?/seHNYvJym6KEY66jLTCEqhBgk1x3zw3c0iOTDBA65v4YTnMUFZ2egJCBRnh?=
 =?us-ascii?Q?xaqh9Y/PTdMxHb9N/IRFjagZzwDU5YgFaI/7bFGbrYs+f1XWBucarh8GK7ol?=
 =?us-ascii?Q?UTCTKLw2e1I0AeTx6C6pZrIVhveKJbQyW43WfNhucIipQbt3wiSEvmvzKr4l?=
 =?us-ascii?Q?uoaDHimhNMtCQbb/Uof2J8hjkAUzr/ebvel2lfEf72SuoXx0nuUuK6W6F+ho?=
 =?us-ascii?Q?lbHo8D4gXUFDuXzm7D4ilDG9hBtw8+fhXELfk7iVUCl1RTjJo70xCVpxG1tc?=
 =?us-ascii?Q?4bE4ss3XzlK49HW4PvHu7T9q8kAdqQGqKkj+e3Mx7lVXLjho7M1CEQtc7P9O?=
 =?us-ascii?Q?gP6yc+Xc3RItD9m9squQDZd6gP+e9kTk1Rb/JGDzIAEl6YuV2paPyY17J32w?=
 =?us-ascii?Q?x4w+lLge3O8IbtHk9LGMTgqU?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db973ed0-df5d-4e18-5b04-08d927341f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 08:38:26.8210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ppqx7NpWjdHDMEnGxHZJJnAbqCNNdoir5c3j28xdOnKSG1sxe4Bxi+x4zpML0G0q7rnilP2pGWpljfFRjiMnLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1407
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, June 4, 2021 5:44 AM
> 
> > Based on that observation we can say as soon as the user wants to use
> > an IOMMU that does not support DMA_PTE_SNP in the guest we can still
> > share the IO page table with IOMMUs that do support DMA_PTE_SNP.

page table sharing between incompatible IOMMUs is not a critical
thing. I prefer to disallowing sharing in such case as the starting point,
i.e. the user needs to create separate IOASIDs for such devices.

> 
> If your goal is to prioritize IO page table sharing, sure.  But because
> we cannot atomically transition from one to the other, each device is
> stuck with the pages tables it has, so the history of the VM becomes a
> factor in the performance characteristics.
> 
> For example if device {A} is backed by an IOMMU capable of blocking
> no-snoop and device {B} is backed by an IOMMU which cannot block
> no-snoop, then booting VM1 with {A,B} and later removing device {B}
> would result in ongoing wbinvd emulation versus a VM2 only booted with
> {A}.
> 
> Type1 would use separate IO page tables (domains/ioasids) for these such
> that VM1 and VM2 have the same characteristics at the end.
> 
> Does this become user defined policy in the IOASID model?  There's
> quite a mess of exposing sufficient GET_INFO for an IOASID for the user
> to know such properties of the IOMMU, plus maybe we need mapping flags
> equivalent to IOMMU_CACHE exposed to the user, preventing sharing an
> IOASID that could generate IOMMU faults, etc.

IOMMU_CACHE is a fixed attribute given an IOMMU. So it's better to
convey this info to userspace via GET_INFO for a device_label, before 
creating any IOASID. But overall I agree that careful thinking is required
about how to organize those info reporting (per-fd, per-device, per-ioasid)
to userspace.

> 
> > > > It doesn't solve the problem to connect kvm to AP and kvmgt though
> > >
> > > It does not, we'll probably need a vfio ioctl to gratuitously announce
> > > the KVM fd to each device.  I think some devices might currently fail
> > > their open callback if that linkage isn't already available though, so
> > > it's not clear when that should happen, ie. it can't currently be a
> > > VFIO_DEVICE ioctl as getting the device fd requires an open, but this
> > > proposal requires some availability of the vfio device fd without any
> > > setup, so presumably that won't yet call the driver open callback.
> > > Maybe that's part of the attach phase now... I'm not sure, it's not
> > > clear when the vfio device uAPI starts being available in the process
> > > of setting up the ioasid.  Thanks,
> >
> > At a certain point we maybe just have to stick to backward compat, I
> > think. Though it is useful to think about green field alternates to
> > try to guide the backward compat design..
> 
> I think more to drive the replacement design; if we can't figure out
> how to do something other than backwards compatibility trickery in the
> kernel, it's probably going to bite us.  Thanks,
> 

I'm a bit lost on the desired flow in your minds. Here is one flow based
on my understanding of this discussion. Please comment whether it
matches your thinking:

0) ioasid_fd is created and registered to KVM via KVM_ADD_IOASID_FD;

1) Qemu binds dev1 to ioasid_fd;

2) Qemu calls IOASID_GET_DEV_INFO for dev1. This will carry IOMMU_
     CACHE info i.e. whether underlying IOMMU can enforce snoop;

3) Qemu plans to create a gpa_ioasid, and attach dev1 to it. Here Qemu
    needs to figure out whether dev1 wants to do no-snoop. This might
    be based a fixed vendor/class list or specified by user;

4) gpa_ioasid = ioctl(ioasid_fd, IOASID_ALLOC); At this point a 'snoop'
     flag is specified to decide the page table format, which is supposed
     to match dev1;

5) Qemu attaches dev1 to gpa_ioasid via VFIO_ATTACH_IOASID. At this 
     point, specify snoop/no-snoop again. If not supported by related 
     iommu or different from what gpa_ioasid has, attach fails.

6) call KVM to update the snoop requirement via KVM_UPADTE_IOASID_FD.
    this triggers ioasidfd_for_each_ioasid();

later when dev2 is attached to gpa_ioasid, same flow is followed. This
implies that KVM_UPDATE_IOASID_FD is called only when new IOASID is
created or existing IOASID is destroyed, because all devices under an 
IOASID should have the same snoop requirement.

Thanks
Kevin
     
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
