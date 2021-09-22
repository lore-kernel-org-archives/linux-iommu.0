Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5DCC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 00:54:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C9B61165
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 00:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95C9B61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F33A40417;
	Wed, 22 Sep 2021 00:54:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BNd34eAfDm3T; Wed, 22 Sep 2021 00:54:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2226E403F9;
	Wed, 22 Sep 2021 00:54:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08DC1C000F;
	Wed, 22 Sep 2021 00:54:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CEBAC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 00:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B78C80E34
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 00:54:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k0BVATrz56cT for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 00:54:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 861FE80E17
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 00:54:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="221605316"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; d="scan'208";a="221605316"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 17:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; d="scan'208";a="557164829"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2021 17:54:08 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 17:54:07 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 17:54:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 17:54:07 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 17:54:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1BNwHVXLSq0aH/R6epw0Gw1+yTUjVbek7ewml9yyOJeHdmitgMjfeDqBmU90/SQTbo72C7O2tj8J9o5bSGoWCEEDT/5SsgViY9/lB9i1Aw05xThmz/uUZSUVV6qJ8eMhP9fHfyGQ5hzhq4o3EIdy13knhfGcPig0DlmxmFKQ2Rgq+JJorZJP5+tzqMVaHN/CZPzSy3IjlV/lrB5RZ3w8hmcF2QD5XDapNv6AxoqnH46y1q2p0PCXdFSJjL1K78V8JmK8lhTsUa6r8MByHHJuGQ/bLixMLiIYeKgS1a2XyXGTreRtWQxzR5QTFoUUbyhMrXxGpSJZ/bOtwTgJmiCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SsdZPIsJ5kC6MfCsouaIWLHYciH7gQlPQJ6UgNtVAEk=;
 b=BeHsgiBhLOTMTv4SLM1WkHDJaXGkMrPzhOhSLlVpY6G5QoHxM/bkn137sMaVvCnPZ+puaTmZH4pGGJojeA3f9iQVGs6Sng+6I/uiDEcyIRF1xeGXEXs1V3wVsbgrKg3JG93iF6ebQ9qrXcWyvpW1ajErsmoX6Hit1AxP5OZgUpn/2W6+1F5kcrB5iiIlvwhEoKH6tMuZ2f9RFLMzzhnQCyw6mKHyUiyKO1D0Rfm+bPP+gOR21BHSUpSjXcg5CMzDQ51lH0So4J4PbjlY7YCejMS9hBlyPgeWaPp7UerR/NHcMfAI28wt1P7l/dh1AI3+Z7XlUVsT7GTrBejoUZZkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsdZPIsJ5kC6MfCsouaIWLHYciH7gQlPQJ6UgNtVAEk=;
 b=IWqysa7pknDdXtcTIXg8osE/txe78JiLdnvICDpLal7MBSf/PDEutfhKxccXHqhIKr+6kzAv6GIbQzWupgKUR6pXM9QbfSo2/6klY0Nq5tBbKHqENp6Vn7hD+1xJJIc0fQzHwJpm+xWqchU8CDmpuCv+6hmb/lql9wC9Jd5fXFE=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN0PR11MB5757.namprd11.prod.outlook.com (2603:10b6:408:165::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 00:54:02 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 00:54:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Topic: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Index: AQHXrSFwNP3/pIcrZ0iM9X/cSoy0lKuuqYQAgACO5rA=
Date: Wed, 22 Sep 2021 00:54:02 +0000
Message-ID: <BN9PR11MB54330421CA825F5CAA44BAC98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
In-Reply-To: <20210921160108.GO327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c77587a7-0301-43b7-a73c-08d97d63788c
x-ms-traffictypediagnostic: BN0PR11MB5757:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN0PR11MB5757128CFC0612059849F3738CA29@BN0PR11MB5757.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ywtQnQzu8jDHCYjdOn3gURKP+uqgCn5SiDz2aiwIjilguY6wgAFm3WkYLWdnPlMCfWcz2ZbCV1p5bdyX92bVaT3xswV6aLe0ub2KEyOY+xW/bPlkYvcWwjEAIhnEK0jdTUaxhZ3UOawoZ5+mUyHwdr7VmdHq1PzreBIEfd+CLEv449xgIInpka1G71scahLA9ELAlD+BdzhRD+fZqj0bwJOBW/pERGutksVC7eUiLJXGQxhD154AMgvu4WoFwu+vq64lUKuXIIDVdc4DRWuegzH4dL/MMvUUyxAKVFx5ugBOmh3duRhOBos/l7CDEKjMipwSKCDAw27Fc539yYX+si2z0CWnUo54SUtoKkVKZ/Dc2xOQe1DWF72jKosW0vTjzDA89rBttRUO3Ml54ohuhxwP1OIT6HhlVl/R+MvUOpsRY/XCpJOxoaI2t3KPyi/pRQHyBU1RStcqfyG00Sp2BeDpf7kvlZHj5S+NhTIkDPqKSUF682Bk++5Sa7hUQACxIdwES4PxJLazPmJEqskGjE0IMsiU9iCjNUt74oX/gdVkAepzO28s/7UrkgzOv9Z0fNnOgzmxpaH3nY+6HKQ91v7LX85krO13Rn9KyY0EjJE8LWBODKIEUYisG6N1uZ4vBnW2BAk5shg936+R2THHINlWAfHOucD5yvmLjiZp4d1kAJWyPJw/QNjQ+w5Q+HgsWbzBFLvqss1Z9Eqkb6NRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(84040400005)(64756008)(7416002)(38100700002)(55016002)(9686003)(66446008)(86362001)(7696005)(52536014)(76116006)(66946007)(2906002)(26005)(110136005)(4326008)(8676002)(8936002)(6636002)(122000001)(508600001)(83380400001)(6506007)(316002)(5660300002)(66556008)(54906003)(71200400001)(33656002)(186003)(4744005)(66476007)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U8EYrz6RO18KhfyV/t5WcgoszsSjeFY1zLmBPDQZYZQAzBj4RqoYh+89Kfdw?=
 =?us-ascii?Q?lH1Uv065QPyywkJkSMTXXoXrl2WHclmTI5UN7Wv/D4Tz4Dm6qr7HaUgmXsUK?=
 =?us-ascii?Q?pEdyjxkmOFd69xSYoMY6IGTYaUeu0CZtgYDhK0mp+IbjasYaY9GvitvE9HeS?=
 =?us-ascii?Q?KPAtY7+kuc4tMty9biWP1URjWlwtczLg60uCr5NSAz7e2AHrh2SvvniCe245?=
 =?us-ascii?Q?uEhev8yeVshIuTZoAQ5zeiPZW/jHUGBcyhmjP1LODFws5Lq4PtA32U1do11y?=
 =?us-ascii?Q?NErlPtgcBqMCouohBE2Tpaz5xOUtqoEotLxaEQezHODasusJyFIbRcL/bvCF?=
 =?us-ascii?Q?p0VDRSFzAkwLROFG3zc7kr5hfXbdoDsIVLGzwryvz3qH942TZvnszCxLbWzB?=
 =?us-ascii?Q?3o2DjxPgM7xYk5qVjRx8UEnzox7hJKR5me5pET5SeBLLrkXava+3KfrflNSR?=
 =?us-ascii?Q?7MxAtT/+pKuQlm/DfA548I+QKXzM8/y70xkSIxsxT9u4/OkPa3nhVKNfL58T?=
 =?us-ascii?Q?Fcg27XqDCoIwF+JcGMC4F0ADfJqxYAiHJBu+elGRSH5wCATjbrLetEkSQxBQ?=
 =?us-ascii?Q?sjRZARF7grB6B4v/uVnJzGk3DEm2J6R6BUfF8vAKibt2Os560kjvvvFpmNmx?=
 =?us-ascii?Q?XCgk7mDEBGabEkOvOkZL5w9aOusYCc9Nb3ZJx0HAwMgfWbQNL88lsuMMNsAr?=
 =?us-ascii?Q?ya9dtirgojuoVU/zwE8Z8JUyL2iPo25zuF8ofSDLBB51ldfT76Upy100YMwm?=
 =?us-ascii?Q?UrmbXquJHG7DgM7kZeiHmzKhtlti94yA3jtyyIjOQVtGZLVO8vbASjUYOues?=
 =?us-ascii?Q?vTOqGEB9dCCFgrGWS+MfIC2/wy2oTjYdC8GqEBUZ4UGHMSGqTDZQGmeOO50u?=
 =?us-ascii?Q?qLtRjQKMDxt/UWYtbXxPxtIBJuKbckV6J1cZ7iIUTFxvS1d8U8335y4Gitj3?=
 =?us-ascii?Q?nxaKDcTLLRoF1uz2CBeg6dy3If/ituk9YwrfmLVzNjPejRGaoVEWH4P79rkW?=
 =?us-ascii?Q?1FkNf55Qxeh7N1dk/ypx/y76vAosTVlBVoIjAks2wfRyhctK1p7vt5N9UAGR?=
 =?us-ascii?Q?8CYoA0ubx5voCboH01sE5CDC1ODsQnDI3r/sJwJCs9Lzcc751Xhm7UkvCcOc?=
 =?us-ascii?Q?Y6yngKKMEs1vIOizG3EhDDu/D/SfVVEwt+mSs5AhcaonUjfdd9ni+Kk00Xf6?=
 =?us-ascii?Q?OeshlU9L2wHrfZ08VMoyiG4hOf0DOsBRMEg8up1VZSO2oIgFU+NLDh253GGS?=
 =?us-ascii?Q?GNE5YwK/vdndIEXLDOcj6BEAwn/gHPtASPx4wjXsN1lVrd91IFhotyQVTMsY?=
 =?us-ascii?Q?t7s=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77587a7-0301-43b7-a73c-08d97d63788c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 00:54:02.5681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFRwmihzxNtQ8+5eMn62ZiTUSzB1iOVB9FUspuYwR0R7DYmuWwG6aP2Q8+aPlVqltXLcf2kfmepxYdmWxS6xDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5757
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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
> Sent: Wednesday, September 22, 2021 12:01 AM
> 
> >  One open about how to organize the device nodes under
> /dev/vfio/devices/.
> > This RFC adopts a simple policy by keeping a flat layout with mixed
> devname
> > from all kinds of devices. The prerequisite of this model is that devnames
> > from different bus types are unique formats:
> 
> This isn't reliable, the devname should just be vfio0, vfio1, etc
> 
> The userspace can learn the correct major/minor by inspecting the
> sysfs.
> 
> This whole concept should disappear into the prior patch that adds the
> struct device in the first place, and I think most of the code here
> can be deleted once the struct device is used properly.
> 

Can you help elaborate above flow? This is one area where we need
more guidance.

When Qemu accepts an option "-device vfio-pci,host=DDDD:BB:DD.F",
how does Qemu identify which vifo0/1/... is associated with the specified 
DDDD:BB:DD.F? 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
