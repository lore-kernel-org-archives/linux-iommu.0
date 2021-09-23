Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5579BC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:22:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9DC61214
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 12:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E9DC61214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB6F8842C7;
	Thu, 23 Sep 2021 12:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 821Gnd9ntMkj; Thu, 23 Sep 2021 12:22:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5EE0F832E7;
	Thu, 23 Sep 2021 12:22:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4840EC000F;
	Thu, 23 Sep 2021 12:22:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB6A9C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC92B8408B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4rQJxB-DZXw8 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 12:22:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD8C6832E7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 12:22:27 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="309387099"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="309387099"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 05:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="436581274"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by orsmga003.jf.intel.com with ESMTP; 23 Sep 2021 05:22:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 05:22:25 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 05:22:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 23 Sep 2021 05:22:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 23 Sep 2021 05:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrBSsF/HgVfKPeuVKHX1WIw+mzi4VDfsAcnB2MkfPpgeYnvgCP8BmQGR2ng/+owMC4gFOAZnM0rDov/cJF77XRzXbrxcIVbBxsrZkYhVnNwP3nl1irjzbDjW1qdt2exDEyJ2rkEWE4JxhCasock4gd6/I+ZqoMNSA8ek5pt06Ex3UjgliTCdqO19GQyhewO2Pl/im74kN1eeb2iGFKTsGiI3Wse6tKQucMn02ii6F/PWuG1zcmwbwODXx1/oZrsVxHG4qF7wTV4SnMjZqlzG1klWWT/7EDkKaDzwc0c2YoeQN96tBK4G2pIzQ0J0DJ4vjFlR4L4jhca1d6aAa/bZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=aaHNWugjrqpC+e2V3rbdCf2LA/VD/TeNvmcjn23KCvE=;
 b=ZJxxzsdPLGd9PDA74Suwccq2hlFtlnJgnRK0ifYzq0Nngs0kfxzZAuK+ILGvIYnBM/mmBenAYKwbzAakUYy5JedsPc4g0kaQzUl/ZpftvCy8cybOjQgqNP55wscKsC71PABRcsmbaRAEYUWg12DvRakHbp8v9ChMEitzuaQxVXEZrvvbNT2CtDLibxZlcP7F0JzaODyDgePsFMVyr0FP08jjSusJCNuPX2z4H/Vzc37pjScXDYXu3Pm7BpXzzAvHEmqDC61T5CSMVB0wz6/qiMVkBjePcrmJJmB1EXtPRAeXdz/F2W1b7nVZRbUgZfisSamyK8CztMgfAvECgEX/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaHNWugjrqpC+e2V3rbdCf2LA/VD/TeNvmcjn23KCvE=;
 b=P+nojdgxMqoa+fw6HR/ABsK1+rf+Ql5h7/gbJRcTagf6XBvqJUGfzrRKfhKIwe2D86Ea/OITC2gkhkbpw2CsLnZwrYJCu9fyeJ/RqubGZMlHjvBQRjRvtA9f9waGW7JCEQppnr2wnqzErJWr+ehpzIwuj30WlxEHpFw83wNr7qY=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5465.namprd11.prod.outlook.com (2603:10b6:408:11e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 12:22:23 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 12:22:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Topic: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Index: AQHXrSGPLoYXtOF3o0iA7Cse+/LM66uuxm8AgACjoWCAALKBgIABNQdAgAA7IoCAAAByIA==
Date: Thu, 23 Sep 2021 12:22:23 +0000
Message-ID: <BN9PR11MB543309C4D55D628278B95E008CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com>
 <BN9PR11MB5433A47FFA0A8C51643AA33C8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923120653.GK964074@nvidia.com>
In-Reply-To: <20210923120653.GK964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b76409a-4761-43bf-cd66-08d97e8ccc56
x-ms-traffictypediagnostic: BN9PR11MB5465:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB54650E9FD08C4FED9D09B3208CA39@BN9PR11MB5465.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nykdTrtfwNUsT8PqiQmkSUQIdUDJ4NEib6Wb0vAGE21z57y6DX91tDd7D8B7u4nJcUY/ch61jlo81sG7ZsPNhJHP+3RfGrxwZtu/Q9l/jvlxGW+/8BrOHt/rerXh35/FZ8gzxJ7/sAH9Vrv1DAOgc/BZhP8ROfu0rD4bt7xLnITJ+8IywAqYsJR5Kb8ZstpU0XXaqsyu01bz2TcXkC3J+biAavM8GtqZhnPTwuCHhO4fTvy1fwdJGlkCttEjuHVsGu+XFfFyi9NHse3IRKt70Quyu/GPINuAf9x1fvCw/1a1RQvUEa1Yo2VY2EUOxn5uGfwN9Gapu+q8PrXVne0ZqktDEyDupb55jLDsl3CqNy5H1s9BlfPn95EBft9RhGRxOak2g7GbVKCzG6r0gHwa6oL/Vb1Iu9+lZ5M4CqhFT6YTfniwaFC/AWXWKu/cAz9nU/HvHjs2HRUau3tqUXYeRnN7VTyiED1BwJ2A5q2VQX5GhAeLNOaHgBky2LAWZazVHZdzWSFvv11pr236DksgjvGaQW6WGKaI68lob5viCeKBHjOB1eDz9HKeQaxBzsdvAhgYpDnEBNSg5nGdGjjQ168UnGaZesMlsstcrQGuvz7v04BCNItwJGsjovsyz41WJi9UyFCJ0YKRYD1gVWOpXyjoTT9w3+AENKgLpD7WnrlbB5bXQYqES8JGzojx2KKjM+G7jmgemEqgBW3/t9XYWU2FLgGObnalGUqzFBVif8A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66446008)(64756008)(66476007)(83380400001)(508600001)(8676002)(66556008)(5660300002)(86362001)(38070700005)(186003)(8936002)(76116006)(26005)(52536014)(54906003)(55016002)(2906002)(7696005)(6506007)(7416002)(4326008)(6916009)(9686003)(38100700002)(71200400001)(316002)(122000001)(33656002)(84603001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p5n9RgJ7FX+xKNCUFRV+sS/wc9DvLBpaZT/lhwaLCSupZPwD9KX2SDAfTKTa?=
 =?us-ascii?Q?qMelCUkAdpQL74SJCZUe77grz8F5FXVtuqgJr++/CxhkUVFlkwIYCPl0apGC?=
 =?us-ascii?Q?TgifpGSOJ7ggToprVg8mjpEloul52lQewE9v10heopmq2hJS7ioxEExFljQt?=
 =?us-ascii?Q?M5uBWEl58DOpe4mzkYTIeDSS2dDJOJXkOnNsGYK5zoM+3BJ+iZXMTGG7S22h?=
 =?us-ascii?Q?UxJojfOZgzGV9hcGtxZuQ95NTadr6xvjzU2zjRYiek3o0Q12Uv3VY8BW2b8c?=
 =?us-ascii?Q?dj7mkp3/xbiIPwUo2gSa0jiihWNPSHHeuTRJnQtus351OVUSwsJaK6ykD8Kz?=
 =?us-ascii?Q?dj2jXIl5KBliIDAvHB/zMtXaO8q0A06F5JVihA37Xj4BEG7ZjX7oh3CusrAP?=
 =?us-ascii?Q?MLkSzDTQlquaKkH54dFaek+ADnw71fLCkNB4/KkMHT4J3JjN9bRYbXkfSPMQ?=
 =?us-ascii?Q?sCmCPdeTzolPywFGYWv8O9GUDwPpIshVOuB7Y2fby6B6NHeFSEjG+Eu650d7?=
 =?us-ascii?Q?lk3Y/lkDRNNuvcQXUO+3UzuNv/0zv5by2VWPNmdU5LAuuJBR7TtCQC7LpqQS?=
 =?us-ascii?Q?xWT6vVWrl/kW1kzM5rEq5cn+KjZQcOL66SDgN/Z79Kn29Z7AcKKoFrWiMO7s?=
 =?us-ascii?Q?witeKqX4d+UdLKY7OkZsakiFcTj4tw6d0lzxBrBPHgXy6Sah9uAu22QeDKBx?=
 =?us-ascii?Q?GDwhzriNRuPgJNLuI/gZSFuR/EV8YKSzRPc+eqVAMArDjED7z0hlnyZ2Ycri?=
 =?us-ascii?Q?oMAKB3qSorxVdS7cSPOeNTIWB/mH7pAWX1xzvJKR2gev4DmDoQRh6jOykTfz?=
 =?us-ascii?Q?8HTjlt1Erw1ZxWb2/ExYrqbMaMaNhJbfYaDjMKc2Jfv2GOZaID5ChElyBbHY?=
 =?us-ascii?Q?WKuhCSM4esLxcE3e9fVcqh2X4ovi3RBVNxtEz399aulUoaAwlX8dZvotYpxj?=
 =?us-ascii?Q?oxctqI02gwHaWNsZCrosAio6BBHYbgUA4NW0gl7ED7lFaxlTCNM5EzWhAok/?=
 =?us-ascii?Q?DI2x2G0XaUwYbp7Jgu2pJvQK9UYezKemzR/2vxaMSJXBtjpnO4VhbFk7Tz9c?=
 =?us-ascii?Q?EMFLV25pgatM8bq5Rr1/E3YsCpo3f5W/N7he7Aer2H434dfDCzkYKYv9Gs7s?=
 =?us-ascii?Q?ED/oMQe/8DwvGFGiHdxC1aGMOmp8wVaewGYZVRLkOzDmgaDhct5FBOdMf021?=
 =?us-ascii?Q?hReQhyxlX6kuL99mqz6iBBouu2U2cVUV38mYAVNMHFL5bF0jyB/crZDwyege?=
 =?us-ascii?Q?dg0DC6MxlgXk1LqGDpxjZCGoqz3OrRa98edZSzidxXiQ5sC1lLfYBRPa0zQA?=
 =?us-ascii?Q?sQk4CdgL2L6wtQIQoIs/HNv1?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b76409a-4761-43bf-cd66-08d97e8ccc56
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 12:22:23.6794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYLv0HuuSsxl2LkuVQiXZ8hTRdy5Is12+pk/EycHu/Hz29WM0xZjCRcdXPp3b7LFmO19GYKaBwSp01tSDkzMSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5465
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
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
> Sent: Thursday, September 23, 2021 8:07 PM
> 
> On Thu, Sep 23, 2021 at 09:14:58AM +0000, Tian, Kevin wrote:
> 
> > currently the type is aimed to differentiate three usages:
> >
> > - kernel-managed I/O page table
> > - user-managed I/O page table
> > - shared I/O page table (e.g. with mm, or ept)
> 
> Creating a shared ios is something that should probably be a different
> command.

why? I didn't understand the criteria here...

> 
> > we can remove 'type', but is FORMAT_KENREL/USER/SHARED a good
> > indicator? their difference is not about format.
> 
> Format should be
> 
> FORMAT_KERNEL/FORMAT_INTEL_PTE_V1/FORMAT_INTEL_PTE_V2/etc

INTEL_PTE_V1/V2 are formats. Why is kernel-managed called a format?

> 
> > Dave's links didn't answer one puzzle from me. Does PPC needs accurate
> > range information or be ok with a large range including holes (then let
> > the kernel to figure out where the holes locate)?
> 
> My impression was it only needed a way to select between the two
> different cases as they are exclusive. I'd see this API as being a
> hint and userspace should query the exact ranges to learn what was
> actually created.

yes, the user can query the permitted range using DEVICE_GET_INFO.
But in the end if the user wants two separate regions, I'm afraid that 
the underlying iommu driver wants to know the exact info. iirc PPC
has one global system address space shared by all devices. It is possible
that the user may want to claim range-A and range-C, with range-B
in-between but claimed by another user. Then simply using one hint
range [A-lowend, C-highend] might not work.

> 
> > > device-specific escape if more specific customization is needed and is
> > > needed to specify user space page tables anyhow.
> >
> > and I didn't understand the 2nd link. How does user-managed page
> > table jump into this range claim problem? I'm getting confused...
> 
> PPC could also model it using a FORMAT_KERNEL_PPC_X,
> FORMAT_KERNEL_PPC_Y
> though it is less nice..

yes PPC can use different format, but I didn't understand why it is 
related user-managed page table which further requires nesting. sound
disconnected topics here...

> 
> > > Yes, ioas_id should always be the xarray index.
> > >
> > > PASID needs to be called out as PASID or as a generic "hw description"
> > > blob.
> >
> > ARM doesn't use PASID. So we need a generic blob, e.g. ioas_hwid?
> 
> ARM *does* need PASID! PASID is the label of the DMA on the PCI bus,
> and it MUST be exposed in that format to be programmed into the PCI
> device itself.

In the entire discussion in previous design RFC, I kept an impression that
ARM-equivalent PASID is called SSID. If we can use PASID as a general
term in iommufd context, definitely it's much better!

> 
> All of this should be able to support a userspace, like DPDK, creating
> a PASID on its own without any special VFIO drivers.
> 
> - Open iommufd
> - Attach the vfio device FD
> - Request a PASID device id
> - Create an ios against the pasid device id
> - Query the ios for the PCI PASID #
> - Program the HW to issue TLPs with the PASID

this all makes me very confused, and completely different from what
we agreed in previous v2 design proposal:

- open iommufd
- create an ioas
- attach vfio device to ioasid, with vPASID info
	* vfio converts vPASID to pPASID and then call iommufd_device_attach_ioasid()
	* the latter then installs ioas to the IOMMU with RID/PASID

> 
> > and still we have both ioas_id (iommufd) and ioasid (ioasid.c) in the
> > kernel. Do we want to clear this confusion? Or possibly it's fine because
> > ioas_id is never used outside of iommufd and iommufd doesn't directly
> > call ioasid_alloc() from ioasid.c?
> 
> As long as it is ioas_id and ioasid it is probably fine..

let's align with others in a few hours.

> 
> > > kvm's API to program the vPASID translation table should probably take
> > > in a (iommufd,ioas_id,device_id) tuple and extract the IOMMU side
> > > information using an in-kernel API. Userspace shouldn't have to
> > > shuttle it around.
> >
> > the vPASID info is carried in VFIO_DEVICE_ATTACH_IOASID uAPI.
> > when kvm calls iommufd with above tuple, vPASID->pPASID is
> > returned to kvm. So we still need a generic blob to represent
> > vPASID in the uAPI.
> 
> I think you have to be clear about what the value is being used
> for. Is it an IOMMU page table handle or is it a PCI PASID value?
> 
> AFAICT I think it is the former in the Intel scheme as the "vPASID" is
> really about presenting a consistent IOMMU handle to the guest across
> migration, it is not the value that shows up on the PCI bus.
> 

It's the former. But vfio driver needs to maintain vPASID->pPASID
translation in the mediation path, since what guest programs is vPASID.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
