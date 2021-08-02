Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F94C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 02:49:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CDF60F35
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 02:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 73CDF60F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1DBCF40017;
	Mon,  2 Aug 2021 02:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 64c-GN7uzVoj; Mon,  2 Aug 2021 02:49:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C4A440018;
	Mon,  2 Aug 2021 02:49:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EAB3C0010;
	Mon,  2 Aug 2021 02:49:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 374C9C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 02:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2940240018
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 02:49:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UCjztCM8Z_s2 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 02:49:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01C6040017
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 02:49:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="193654020"
X-IronPort-AV: E=Sophos;i="5.84,287,1620716400"; d="scan'208";a="193654020"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2021 19:49:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,287,1620716400"; d="scan'208";a="440346648"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2021 19:49:50 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 1 Aug 2021 19:49:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 1 Aug 2021 19:49:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 1 Aug 2021 19:49:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 1 Aug 2021 19:49:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLKWBmyujwuAaEj5g3Qs7rHKbu8ntlLVIVYXZxB3xvutV+QCHIE5xhc1K+AGQTdg3baYp6Y/JRV/O+vHfoY/AgEhlijxrd3Kb+/6C+wt0cV57nnHBVRpKPOE2yhPxYyWbUgq+HUedzcwFzNaqQ26Jk0RnnGyz0CGjWnlLUyBva1+YpZ9wp/6C2IKM+gLp1ZZrqgppVnzEZ3lHEkLab6KMGxlrEqZACc30ayoDWm00pSgMxpeXBqVhrJtDukQBwThNnoos09ybCG634+tLMgt33zZ0K9NNQuFzYQB7FaB+xYO8q6baguSAvq4hi3ynQgxmdTTqehQqAR0v5nzbtExOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3H9okjLEqTjUGC6tW1StPvzyPunrUP7Fu5H1/4EEHE=;
 b=YQNIpngP8XEY3ZYd8r0o7f0YDop6BN2TNXoV0QmnN0i4A+6uCkRlKdXOtOolJ+vsEknGoZr6lqG0p/97rANFsG3p5Hx8wDvJ4NmMMwD0hWIRftdvzAwgfpsT8Lru0CRKEG2uFr8fyo4BYrxN9HjMe0Jj8H1BEKIXj04x+7a0NiUtytJwSODDD9mCgk/TXDyRu0/nYr7JeDGKMPFT6LJZPYWrHNnC+I4YgT+YIiya4GTePF4ET6N9EdvL30c4T9HY1v24FDNZqFRISEWeCRO3I38+ZMilTblOmneTJBThrM3VmiQaao0ISpYSWt0N7yWv+4uShvNrA3wD7VDvrbhGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3H9okjLEqTjUGC6tW1StPvzyPunrUP7Fu5H1/4EEHE=;
 b=SdQFCUfoQvBC7408gfftwjqiOan7LDFUnTp0xiKjFvk/U6ajc6Fzc8JREHf7zXSvjpDIOaBuCgN4uDO0xxJhCaUR3QUZnOO7WpMTGuT8Mu7UpQCC4KQ/ElebQ8GIWMnUJDzu1zglupZNpfes5U90c+jjiUm7Guo+OtsnzhBUDZM=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB2018.namprd11.prod.outlook.com (2603:10b6:404:4a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 02:49:45 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134%8]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 02:49:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: RE: [RFC v2] /dev/iommu uAPI proposal
Thread-Topic: [RFC v2] /dev/iommu uAPI proposal
Thread-Index: Add0lrMH87IsTsl5Rp6WN1oQU6kGMQNQxoYAAN4kDIAAfDtbgA==
Date: Mon, 2 Aug 2021 02:49:44 +0000
Message-ID: <BN9PR11MB5433C34222B3E727B3D0E5638CEF9@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YP4/KJoYfbaf5U94@yekko> <20210730145123.GW1721383@nvidia.com>
In-Reply-To: <20210730145123.GW1721383@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65f6dafc-f0d6-4bde-b96a-08d955602f69
x-ms-traffictypediagnostic: BN6PR11MB2018:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB2018D05D0FD6089868505A1B8CEF9@BN6PR11MB2018.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgL0JjCfuhPkoY8MsJp9zEJ+TH9g4JJSxwL18oCFHOvmQSNlhG7kBDoSw1e3Yh8VayUFJ429qjfp/+UpBV+m697eCbCTaNwkN8DW7ehq2Sht0ZdJvXPF7OMWc+OlZ5IBUE7gy7BrYKSjF7ZPjtEopykcm7J7BqzEN3uNvTIipDTx6dALDyt1/tA39yMd08MDV2HCFL5WgP6AiM5N9pAdg792o2ua9GesfT9S4K65wA8K6vU2gcjYeMiUxiATwKR+RnTZtpGPYR/yTYtURXtYa35GI4rCvcd8sYLONM+343rO5KnttcvDxfft7sqE0O1Lq7nnh0s+PWZGNBO4TnK2HAzRRaupfUgvf1eqE4m4tn+JKdZm2MGR62hIyyF8jT8sRAs3ycF7qL0WgJrK+L/w7OxBZGUEk08g2rsN7VkskWDAyUpI0iMxd9czql5NLGlq2H0fq66M9T/897bP21X7Tq4bWxHI7pBWb0i5o38bglVVZdeYvp7ka7MfTrR2Kf+PXkPBT364bGDvCOPZCe1GXwqErJCGzr+YmAyXpNi1wSNnE9MqtxYoW1pOnEcl8d2xAazSwJV4/aKiSB9uw4cPSMM2YJOZKPiDZ3k3kj2M2eJO4HyaVrmKZZsGWsN2Mob1ZAODFy+URus9rJogItaeo7Y1m+fSBBXboWvxVu+5TTf4HXQces/wkJS2v3wp1vUJOD++QL7HUF5eMUrJ22wocg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(7416002)(2906002)(316002)(4326008)(6506007)(38100700002)(71200400001)(54906003)(33656002)(7696005)(110136005)(478600001)(5660300002)(8676002)(186003)(52536014)(8936002)(86362001)(66946007)(66446008)(64756008)(66556008)(66476007)(55016002)(122000001)(76116006)(38070700005)(26005)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3n3cX4nCDlpCt1I+3ZaAwGJqJkJ3Yc/AYD+Lm+/KlSm51elMXQYXc2MfJT6r?=
 =?us-ascii?Q?GnKZlRfFwlBMDLEcV4SDMax39eZNYHFZm+IGH9FrBc/OzPabFuLtdBzT1maX?=
 =?us-ascii?Q?iFtUpnnzHK+VLUMkfrw4BodEJRDr2AZNTVJaqYT21jihWTkFHQAx/cOcySeV?=
 =?us-ascii?Q?9tey+G3nNoBJGHWbfnZbUSX6moCCrsvvmgaMzPUTucFuV3jB3yS2rnJ/ywQl?=
 =?us-ascii?Q?r+fMwwp+yqdoMUN7sbs48TmZlTc7TTQBItzf/N+6HSjhgwYCtMiTOuT17Kmz?=
 =?us-ascii?Q?ItEo/Hba3Ze3Wo+2CxQQYR5QaD1FZPLH1UKSUf/jqSwwYZp0W5jy2tlsJf/w?=
 =?us-ascii?Q?yqmdWAOWJ1LkXSv85aADX2OC6rKkEitX7cI/wxX+ovamhq2HAvMtjoA18hKI?=
 =?us-ascii?Q?aviJtQ/sPNxe8UGhRK8KEZRBOX1Bx8wO8FMvYXKMgs8vpp/V7daPLoBg+FB7?=
 =?us-ascii?Q?+llsLiMReKo6/JP0uauJJzvYUbyodv7KzlQozMdsF9CftMwJNe40lxz2ORBf?=
 =?us-ascii?Q?60QawwfhNiQCwQ6LFCbYn5i5TpZX0zv1n1Nv5vzygnaSULs31s2936/yGieQ?=
 =?us-ascii?Q?tlsAmOKtanNWhPCMqcZJlGajLByQ3x+lorOy8U7oazSSNt++TqgFyLoEfra8?=
 =?us-ascii?Q?Me1CQwmViGOFKjhZSBvTf/t48d3jge64003nnzyLovNkqWvJJ5IyoYTJLO8X?=
 =?us-ascii?Q?bCo5Wdd9NLHSyRbWwWiAdI9OO2vxOss52XMQ1iLVxGN8/J5DjUs6L5pbr1qn?=
 =?us-ascii?Q?xIM64IXKUUxwnWFBXmhOl3H9J63r2nzxESKcHWRTcvxa+awoJ/6dfZIkUFTV?=
 =?us-ascii?Q?L2yck5eI40eYmSF6hnfwMaUBUF1RtNhLkBiCtYhIt+Vc5MpbL2YpIlJF72CV?=
 =?us-ascii?Q?IaxQZRhSmJwKSQHrXn7fuMo3NeGgABNTAfB++iAAzfkEmzJRwZpd+TwCFzQJ?=
 =?us-ascii?Q?JWzD1HarQHxLXDPQWeLmGijcxY8pVCWXsOrUNX72WwXXVt6NEimNQYj33kST?=
 =?us-ascii?Q?uCPp1SD0BhovMbiyRaeO1WWhYs25O+G204cDeTcNRH6PIEUnLNeoqVqWpxWl?=
 =?us-ascii?Q?RzxSYxYQ0sYi1sk18GctCD3zws/sglTV3DLS07YmCxe/BQTQ0xwHPSTuUmU3?=
 =?us-ascii?Q?l0utZQqAAynBpmuz9+jyJb9tvVZGDNakaDylT4xkxlnxSfrxrCD3lR1TYmL8?=
 =?us-ascii?Q?sz5Pd5dgDNyY0CTWNDN/WM2iP5QiM52RAMyH6eOVl+AQO9ywtzV4ZXgeuB5s?=
 =?us-ascii?Q?NORGbuEsrGnpiOHhIGfhTZ8n5yXKTt74xusV8NA4PItlMQEwO+EL7OUC+GGd?=
 =?us-ascii?Q?QtpR1G6UMqG9BnCOEOwkZPme?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f6dafc-f0d6-4bde-b96a-08d955602f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 02:49:44.8403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7E0Xf9LY2cW31wX+fYrbAP4xixD0BT5fF/ENp+7MrPGx0QZA+ayFxPnP86tZ0kTMzI5P4Xb9p8YcDMUp7PIXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2018
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, July 30, 2021 10:51 PM
> 
> On Mon, Jul 26, 2021 at 02:50:48PM +1000, David Gibson wrote:
> 
> > That said, I'm still finding the various ways a device can attach to
> > an ioasid pretty confusing.  Here are some thoughts on some extra
> > concepts that might make it easier to handle [note, I haven't thought
> > this all the way through so far, so there might be fatal problems with
> > this approach].
> 
> I think you've summarized how I've been viewing this problem. All the
> concepts you pointed to should show through in the various APIs at the
> end, one way or another.

I still didn't get the value of making endpoint explicit in /dev/iommu uAPI. 
From IOMMU p.o.v it only cares how to route incoming DMA traffic to a
specific I/O page table, according to RID or RID+PASID info carried in DMA 
packets. This has been covered by this proposal. Which DMA endpoint in 
the source device actually triggers the traffic is not a matter for /dev/iommu...

> 
> How much we need to expose to userspace, I don't know.
> 
> Does userspace need to care how the system labels traffic between DMA
> endpoint and the IOASID? At some point maybe yes since stuff like
> PASID does leak out in various spots
> 

Can you elaborate? IMO the user only cares about the label (device cookie 
plus optional vPASID) which is generated by itself when doing the attaching
call, and expects this virtual label being used in various spots (invalidation,
page fault, etc.). How the system labels the traffic (the physical RID or RID+
PASID) should be completely invisible to userspace.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
