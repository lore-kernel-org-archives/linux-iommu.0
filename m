Return-Path: <SRS0=XPcP=LW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748DEC49EAB
	for <iommu@archiver.kernel.org>; Mon, 28 Jun 2021 02:04:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDBF61A2B
	for <iommu@archiver.kernel.org>; Mon, 28 Jun 2021 02:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDBF61A2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC42C82CB7;
	Mon, 28 Jun 2021 02:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XUCVQzGMgMcL; Mon, 28 Jun 2021 02:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A0FF282ECF;
	Mon, 28 Jun 2021 02:04:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74643C0010;
	Mon, 28 Jun 2021 02:04:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61692C000E
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 02:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3836B41D40
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 02:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mRV1AaAvRmEq for <iommu@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 02:04:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7918E41BC7
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 02:04:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="188255662"
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; d="scan'208";a="188255662"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 19:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; d="scan'208";a="407551707"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga006.jf.intel.com with ESMTP; 27 Jun 2021 19:03:59 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 27 Jun 2021 19:03:58 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 27 Jun 2021 19:03:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Sun, 27 Jun 2021 19:03:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Sun, 27 Jun 2021 19:03:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkuLZi2omvgKFgXVRq0nJ3okOgyh3mu6VIIY0XUjNcZg4T6LEFriBU7odalP24TG78sYU3pLMcl6aw3cg4PoS+rH3clv3Zf4tL3YjC4CVb+fFsFAhWq2r7z/k64NbkCCpwHgT8/H6xB0zMSIPV3YbRtX2EzOptbbZJGLEnNvELLUytj90WH/osCpCSUcVDcsPRxtoGD+zmnARQq7+MRxCJDQYXyJGATYYwyFfvuYNnLhQu7K9x0BP1crZWq78leD4mUSRSZQiqImEz0X5xztqtnN4oc+W9Gggwv51gVr062s3cO1AzSWs+XsEN6LTuv69AfdrNg4WufhAR+OlpvbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1psENUDQGysgPnVlZVXe+heZCWBP7HBnDwGwLqixS6o=;
 b=SCcG8vqVLvMRLVit3EVtlBqJGlVUbkzU8oU8mKnprfPVtxz2aM36u8/miKelrgHQOq83YPFxjHU22w9YcjY29gqopYipDT8v7h89gcXGUGu1iyA33OTcfMJnFkfyqRu0cLulo5n0+Wuu/Z++VI5UKn+AA35jUxEyZjrNe7PgNWLEup9cQsbcDw3IYWOd7XM2QtMJD6q2JokSXCCw/kyNdbp89ffpQ3JyjYQMtVCa88DEF9g/xN02imAQ8sXZK6cb4I1PRrIZDshvxJmr4ngINV83q/DfDwb9yDjRx5jUNjkhc5inL/0FqcFiUQKcRP0co43Z4nPpMJIH/V11dSwSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1psENUDQGysgPnVlZVXe+heZCWBP7HBnDwGwLqixS6o=;
 b=LEKIWNmy+WeosP2Og01zMn435OeIGEmKXT+8/K0uEirrO14pJDQ0uTsoYurHUHX0ooua0Ts1dzGpU9fgO8+TD06qp3hvLq8B1e/b3zym/B6CWd2sXetScIIVTRJliokvGGlRx+K7/LUs1ZuR33FDaocoRne9zDcpZgw78Aq6MZY=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5532.namprd11.prod.outlook.com (2603:10b6:408:105::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 02:03:56 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::2539:bbbd:5109:e36a]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::2539:bbbd:5109:e36a%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 02:03:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: Plan for /dev/ioasid RFC v2
Thread-Topic: Plan for /dev/ioasid RFC v2
Thread-Index: AddbO/WEUAFl3MPnRsG8exiH8bwEagB7l+uAAACIfoAAAdwYAAADDw6AAAHKgwAAANd4AAAAacwAAAT4QwAAK587AAA0n7GAAAYKlwAADDvuAAAgbLGAAF6lSYAABO0WAAATSRtQAB5ymYAAEyKHQAAmZhSAAAo/ocAAK16TAAAGdqAAACJdiVAAA3a7AAEa314AAD0+zwAAe3StQA==
Date: Mon, 28 Jun 2021 02:03:56 +0000
Message-ID: <BN9PR11MB5433DCBE6DE1EC27CFB9D3738C039@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615101215.4ba67c86.alex.williamson@redhat.com>
 <MWHPR11MB188692A6182B1292FADB3BDB8C0F9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210616133937.59050e1a.alex.williamson@redhat.com>
 <MWHPR11MB18865DF9C50F295820D038798C0E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210617151452.08beadae.alex.williamson@redhat.com>
 <20210618001956.GA1987166@nvidia.com>
 <MWHPR11MB1886A17124605251DF394E888C0D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210618182306.GI1002214@nvidia.com>
 <BN9PR11MB5433B9C0577CF0BD8EFCC9BC8C069@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210625143616.GT2371267@nvidia.com>
In-Reply-To: <20210625143616.GT2371267@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d13a04cc-feee-421a-1b75-08d939d8fcc2
x-ms-traffictypediagnostic: BN9PR11MB5532:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB5532691C0B8B2374C29078C88C039@BN9PR11MB5532.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RKSyvXqggl9tMLzYBkCSRCftR2yuaY0Yq1+cFLcrHYDT3VwzSs6WCwux6mTHFMAZrzscxNy8rA2t2EQFTtvUWXcABsc8eAA78TYFVLQbBq/9UKtuS2ydGNjT3IF5JPqKMPHmYxK2U6CSkOAYcl4PQzYrsi3KXSuPJIEFRpEcns6ihGnnbvE96Trxy1V36ugMU11YUuwoZ+mjj/c2HUE007UBlp81n7nR5sC+Zl6YHW8ZWDEfzsQZ6Fu/BG7fU+hb6Uk+A68PrLoK2e3u5wBMwdBotLhFGH+uAaGSa3sxIvgzijcms8gGx2AMPm7v9eOGe/I2KxJsaMR5xd9mj3A6CkIOpH4zGXxdYUSYEQNN2HMYaY4oQuicxFdRWGOuEWaevbl+bjDw9V8zaPB7UScalLR+ZKGrfEYsI4VBnNoCQbAtJeZ4X6g3ufVmGLSEftNkx99rIM5T0JrYZAKf+3TNS7pBVRnQ26JucaVqkBl9+5KgRgk1xRzJjgkqM5tvbU/DOSdK+UqZV6+GFKiFy6O0T2t6QFcH7BZTJIzQd1L0/jzvW4d8jR/pUGEh+gPo35l2ZN3Mq+KY2gXt2Ph5Orjd6mTMNDiX1Z2kvgh+X5xeYfQGM3/vJ9gI/QmPn4kqdh4QloJO3cfwv8lfOOh3RoxJFTbwTDu3ex0IEZTfqOEMdgqBSse4dE3ZcUUwIqw7PDLAgpWVLABK7IQCmyqs5viyL+UyB4wb0XJnY732UgBwVGhMCRI0gUN8VTnkAIxoSMR1y85pAgWR1OXzVk3oRMCuLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(346002)(376002)(396003)(39860400002)(966005)(478600001)(45080400002)(8936002)(86362001)(83380400001)(8676002)(6506007)(7696005)(2906002)(26005)(55016002)(186003)(7416002)(9686003)(122000001)(6916009)(33656002)(38100700002)(54906003)(52536014)(4326008)(5660300002)(316002)(66476007)(66556008)(64756008)(66446008)(71200400001)(76116006)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qeWzP62y/LPxvMRk3yys6in5trc5jES+kv1R4SXStHddtkRCVJA5V6LQS4oT?=
 =?us-ascii?Q?cf6/hMBY7Q5PH8S9dTY3EmLt5gpTVgSzOeRZyP0bvxM5zmRKap2YLslrDdBy?=
 =?us-ascii?Q?DSKXX+qh8ctdlGRDDjRu1cIbnK+uRf96zMWQ5ZzZIpFZIZw6etGk4Wy2jhuM?=
 =?us-ascii?Q?KVIsXOXiPmCjrJwrD3bCQj6rn841SZf3QsUgSnSu04EMLPcpfjyhrfKp7LHr?=
 =?us-ascii?Q?33pyl0hORmLDcp3syS1Dj8WyIXvZhS37QgDDhqiAF6/aInzoLcSdFr3U5ImX?=
 =?us-ascii?Q?bWvUAgHTMy+Nse3yCSWyAW1VI7lnEUhuDehGwoNAb/CuA3eG69o91nD18OOZ?=
 =?us-ascii?Q?+M8O9DysB60fLW13aOUkJUVdVvsEiiI9suwpPR/yXuRKNP57I8IwqUgCt1eJ?=
 =?us-ascii?Q?Jp7ry2X/qDi6ncT1judFgxQPMABUDESSqA+9Wtp8OT4hIuKiEMoGXggSSRRO?=
 =?us-ascii?Q?+kAoTbAbsZ2KUSVmoXTfbKNCP0Vw8ozzwSMOHSYJU70XCChbgLAHuDCyMKKL?=
 =?us-ascii?Q?M4FMZN14YzaoVYhtS22FQ1KQaLHZdno28sqM8CGTPlmIMD2K54KsAt1AKX3j?=
 =?us-ascii?Q?0i5+JgpqAaasdHH7ltJUb3JM27ktZ6QOlopyU+y+der9MmqyLlF5KUt2j2J1?=
 =?us-ascii?Q?Bu7dFy8pVzqi/XFf7LZrIsrcMC1POcMafxarBb4AnkMQUOWxif48k8ZQIniT?=
 =?us-ascii?Q?cFMkQvghdx9IkW3h78lIFcJPUaezyt7TWOoLoHSMLEHX+5w4EIKDRBRK8WU4?=
 =?us-ascii?Q?MdR4ANpQQTGHNYHQwiMgBXfLqPct4EwWyTS4BPa/Bjhwpo4Xxx0kiQRRb058?=
 =?us-ascii?Q?FBGk4Y241XBvG3E+YkixMA1TPxSF0lda4DbhLW6e1dk/G7ZFRAegYexPjd8b?=
 =?us-ascii?Q?+iclUHXSu+zF5oJNlPox/suf/ngzxoTtofSkkQSkEd/oMDnCmhCoVjzeHkvi?=
 =?us-ascii?Q?4UxrE4AD65ITRm0ZkzJs3O0VXe/Ssj1aYlVUJ7InsTwI2HAsmRIcI3fTpNW2?=
 =?us-ascii?Q?VrljzCcz+mDV7VnxGomKTW6VJJTAAJV9Gh3/LfcdWneb4mVwjSa2PUivLlF0?=
 =?us-ascii?Q?C919PDzxaw8jGI8AodixgInVrSgpIS7vnXgCKLL+9OgTpTDf98Ljg+Durv1k?=
 =?us-ascii?Q?zZS0JL+ICJmkgqsX9bxdR5ZEXtY225RUQhrquLwcHc+IrHbOwQCxihCki3tD?=
 =?us-ascii?Q?rxHbHtXWJo0URgjbMnFfKQ3S9Ab7qr5133g3P+tKUh+EfYAMxEYH7bSe5hh0?=
 =?us-ascii?Q?t3mfRr8SemZF7YgmupaWUi3TBYGQyCtE1gR4XArzTssIklMewgXIBFyD4fX4?=
 =?us-ascii?Q?IHOJl7ub5jylGszwnGJBPq3B?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13a04cc-feee-421a-1b75-08d939d8fcc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 02:03:56.5048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZbQiVDbgpZYTULSuTJnvgHhfsyMyszKMrmmEjDCg09lqR1q+MpQzzS2c5Qeewe4axvtPOm/kGMbS54JiT26WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5532
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi, Jason,

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, June 25, 2021 10:36 PM
> 
> The only thing that needs to be done to get the 1:1 step is to broadly
> define how the other two cases will work so we don't get into trouble
> and set some way to exclude the problematic cases from even getting to
> iommu_fd in the first place.
> 
> For instance if we go ahead and create /dev/vfio/device nodes we could
> do this only if the group was 1:1, otherwise the group cdev has to be
> used, along with its API.
> 

I may misunderstand your position in last reply.

The bottom line is that iommu fd uAPI and helper functions should be
device-centric (no group fd carried). This is what this sketch tries to 
achieve.

However I'm getting confused on your position on vfio uAPIs. 

At some point I feel you are OK to keep vfio group fd:

    "For others, I don't think this is *strictly* necessary, we can
     probably still get to the device_fd using the group_fd and fit in
     /dev/ioasid. It does make the rest of this more readable though."
https://lore.kernel.org/linux-iommu/PH0PR12MB54811863B392C644E5365446DC3E9@PH0PR12MB5481.namprd12.prod.outlook.com/T/#m1b1d2b4d6413e3b32ba972a97c2c6a16bf491796

But you are also obviously against faking group for mdev. 

Combining with the last paragraph above, are you actually suggesting 
that 1:1 group (including mdev) should use a new device-centric vfio 
uAPI (without group fd) while existing group-centric vfio uAPI is only 
kept for 1:N group (with slight semantics change in my sketch to match 
device-centric iommu fd API)?

If yes, some assumptions in this sketch might be changed. For example,
with /dev/vfio/device node I'm not sure how the user can pass {iommu_fd,
device_cookie} to establish the security context when opening the node 
(not via an indirect group ioctl). Then it implies that we may have to allow 
the user open a device before it is put into a security context, thus the 
safe guard may have to be enabled on mmap() for 1:1 group. This is a
different sequence from the existing group-centric model.

Anyway, appreciate if you can elaborate your thoughts so we can further
think about them. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
