Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E687BC433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 13:45:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90369611B0
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 13:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90369611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60B9E80E75;
	Wed, 22 Sep 2021 13:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qIb7hQSUaoUe; Wed, 22 Sep 2021 13:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 414FB80E33;
	Wed, 22 Sep 2021 13:45:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C1B1C000F;
	Wed, 22 Sep 2021 13:45:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F13EC000F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BCAB60BBF
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:45:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qiZxxc3RUJ6O for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 13:45:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D008C60611
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 13:45:07 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="221706652"
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; d="scan'208";a="221706652"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 06:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; d="scan'208";a="435438093"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga006.jf.intel.com with ESMTP; 22 Sep 2021 06:45:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 06:45:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 06:45:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 06:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBCETkU7hoHxdC1kCq+9IK024sYAazalC0+AzHQTMGRT9yT4CPS4A0i9qpT5WAYBmSr+huzgY6lSEvEbir7OFatCAE8D2KobRwrkNRZVzyKpLYl9pAHmdC1pW5S1/zRrYcitcLiKDkDR5zriMSEeJCv/K1vKCdHt13DscasU3XONEAVpyAnuxtPt8psKGZ35vUul7tfJ4XNDdHQJmLjwLqWu5NkLrJm1DUc4nWvbIrjJNdgWBNBqpXzBUar+MUeeCGMurz/hdCQcmgTqWvF8Y8tmTw7w4PGSp6VV4O50wqEn6U1KEX6ejR33/2J/QW/b4C9Es6U+Q6MhPnY4g+7ONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CFWENkVdWUP6oyCpxmVbNE8wqsKnrA5UdC2QxJwC+EA=;
 b=jSGA6Vyrvtq/d1lZi/6CUIOwat1g4QYjHgbxDx3/eGtmWmt4jNgSdAzLLwefYAZkJdOVPPW3MYnppydiBmmK/WMZg1smUeqIsYahPz+5wHk7A4IkZqqb1GrbV0FE+yGXvSz6UmRUHsZi5XJHEIDAZtFyzUFGpPPlESek6VUF1EnaRmjXtxbO3ZoRBZMR0LLQzBSpvBLrb5ljV5DNrJCp/9NJ0a0MAxFO4dzjjGMvdpMmOI0i+NLJuoKVtsHJHASzDCvqXwoLWBpBBnpzC7yIhDeXImO22akVTgXYDr3DES520gBgKptohx9GMI7KeepmDzkZ+QOm5fl0jJ7peKIKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFWENkVdWUP6oyCpxmVbNE8wqsKnrA5UdC2QxJwC+EA=;
 b=QznSQM5DBRWyOvam11fmu6Ky26Bja6SFM123vVewh5SKRUWs9Y0+PUODw54Xcx7HuAmlLXShmKRwloAMiR3r/SGvSfTLndaqNontGWz4y/XuudjiTGdL9sxIbfnsZiD7r/BtXOvOdF9YNgdptgVHvqY9JwM1oMmGtzWwPS7ZuJU=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5500.namprd11.prod.outlook.com (2603:10b6:408:105::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 13:44:56 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 13:44:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Topic: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Index: AQHXrSFwNP3/pIcrZ0iM9X/cSoy0lKuuqYQAgAB3MFCAAB2WgIAAjDNwgAA0YACAABbJgA==
Date: Wed, 22 Sep 2021 13:44:55 +0000
Message-ID: <BN9PR11MB54338CA90323E2A15A8536CF8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922005337.GC327412@nvidia.com>
 <BN9PR11MB54338D108AF5A87614717EF98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922122252.GG327412@nvidia.com>
In-Reply-To: <20210922122252.GG327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ef3f1a0-f0e1-4c9d-2242-08d97dcf29c3
x-ms-traffictypediagnostic: BN9PR11MB5500:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB5500716A8082DA2CA4CBD6328CA29@BN9PR11MB5500.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s52EI1VDLiHrjgdi6sKJVvtutISg0YZWrL5r/MuoCP9hxLolZLe7rZnrs7tZvW8ARmGGbfwajLSqGHKTcpGgyg2rY01lMgpojAQnIdP6XnxpNufDqyTObFVPf8Q9xSsfqFLkLDca5CIg5JHUjADwduaa5u3lAWfkHlME29Kgeux1KxfM4zW0c963uabWvxIj4I1TsohQhQX03nQqTVMepRWCT6IgagICaH+t7JjXG0Fga3uki6e2DzVRNMsPrvsyED8IJWQUj/5BMIX/syhm5P0xZs4aVpqBk8te1PD6onWUKJssClEJedhFUI8JDhBJf2c97doWmcWCYR5IGKC7vQyWEYBxY+0tRJCp2aDSEmZnfm6dH5K0PdG6ESM5odrWhrflzkpjXSf5ArVcsLkFuqxi3M8LXBTBnK+Hd8pW2aAMyS5WKv5TImj+SlAZnqx6RMfdGkiQhIAVU8jcm9kFo9bUyam1wrO5In2YAtYaIShDdpWPcjfe43FhVs5W2294LPZ/+PlKBaaNywLHhJZ08FdnNktfOOYiB52+k4rej4kCL7D5nAsqWIz+WU6PHwjAY+zJV6TxLZF0fZg6bpydYE1i/0ucrhe9PNZiVGmlPlEXnD/foTOyy2YWSrw8IQOX0DB2G0SHNyvVUncDm+5UdvzNPz6t8ekTHPkdWT29kPyB0nSabhnS185QNup3Uo24ZAayeMZmF9WGNvMm72u7jA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(71200400001)(66476007)(55016002)(6506007)(9686003)(86362001)(8936002)(2906002)(122000001)(66946007)(38070700005)(7416002)(8676002)(7696005)(316002)(6916009)(54906003)(33656002)(4744005)(508600001)(26005)(52536014)(66556008)(4326008)(5660300002)(66446008)(76116006)(64756008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V7ohxXENqE5LdfO6IRfELZBVO2f2mi+IlCBoBrfMoVGiEvEuatcCH8is8BxT?=
 =?us-ascii?Q?DjZMvpvWHkw+Hmkj3AJ4dDLAuJ0p/Q0TsNb96koapWbx5wFaB2MTnsDULE+O?=
 =?us-ascii?Q?/KSu/iz4C1a9WoweJK2lnP5NvI8rIUeSrChHV5YTg36tc7Kb8DNQ9M1mU03u?=
 =?us-ascii?Q?X8mTJ5bcSvxFG9oWs6NpSm/IipOMhZxs+4TpLQ3QMPslowUecmmHNl0t8teM?=
 =?us-ascii?Q?0WZwYgS9AqrYUESCnfsCMFOetoAr7St+xOAPLxlr/Oox7khlO892xmgATIHB?=
 =?us-ascii?Q?V++SCG6XX1Xo0/tH9q+5QBTjC+8SyrYNhR1HdzZHlDb/KQYT3LhgY4AfmOT2?=
 =?us-ascii?Q?5LMUp8f5T3wpRtCs6iy2M7avDPJQ0RWn/bwuoBIirTVk4xtiSOm+4o0nysKF?=
 =?us-ascii?Q?YsUqlxRMwjPZBQxquTnM+Hj/whhgcPQcg5Tn7puygb2D6OGV36tWh8Cv+kcL?=
 =?us-ascii?Q?N0d36WTCoICjBoAU80MCn+MrcisLTvO6099U0z7lVzvHSzLhrccoty+keX1u?=
 =?us-ascii?Q?Vb5z2+cSlKayKPj7MUNlCmUNlrl+Y+m4SXm5dnbantjhdeY9hJ2aHWKu6U1o?=
 =?us-ascii?Q?XEbjtn6roUNTNe1Uy3/sT85eAlZ1GrRL6sKDPw8RPWe6NHo2u6YUnHA3qzwp?=
 =?us-ascii?Q?FDm2KaIS3+v0WzyBaczfs6ZUa9co71whs+ptTc5jY/7wMuM30Kc7ERyqsfPl?=
 =?us-ascii?Q?50wfE140rWPUp0u8fGIWxxjEsSFdDGrIF9L5Io3gjClrqJaBZv5qwqczYp+7?=
 =?us-ascii?Q?Ow/bwnIjnI/t8atXGzR0OXGEYY3gToSj7waJJv/oZ5BOI+h7zmat28x+h3Kp?=
 =?us-ascii?Q?K95ng42MCzY987k8U+sfP4RbaBcsPL3RoRyeakM5jWurHvht0ix+7h7mTAJ+?=
 =?us-ascii?Q?RfTroGthWtma8roNxfK7E/Zw81mS0w1LR2Obi5KAN55DObAhlY8R9vZSGEtS?=
 =?us-ascii?Q?oYxtEjDHVimzM8cZBOAgxcodPAA5n3pKyBl3ypVSI65E+Vb9tiLh1YesvXco?=
 =?us-ascii?Q?TFUB9+m9u1N4e/ffY29KSTQVJ/c+oPHeEfhtIVm19hsTlkzeUfq7yUA1M8eO?=
 =?us-ascii?Q?+7mPAsZqiieKzgU835UyJ9zDwBfqHND1gc56zVMa5L5RbKZ7n7/raVxIL64r?=
 =?us-ascii?Q?xUPqGLtfqXhfojzA5y7FYeaiATUoNReqPLtNtxo2C9c7r+G1ZWw6x9H9Y47+?=
 =?us-ascii?Q?Zrk4KH1Eom1x+diY2WGXMil9UaZdKyWmtvDcj6VVzl3esqtbj4HLag7v9GRU?=
 =?us-ascii?Q?HEmL1rJY1z1U6xXyLkAL0f+UWBWUKaLcbnv/GQhYSVMq/Rct9NL9NvTCsA62?=
 =?us-ascii?Q?V5NPL+qZcoNG11vPDs/iyCkZ?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef3f1a0-f0e1-4c9d-2242-08d97dcf29c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 13:44:55.9901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12tGWQHWnggEeE5vFNDLkxqxgFTdKnu5zEOtWeENFmUDs0TrnQlvpJmikK1FuPF3IztOlKsfGTx0DMiwsFzeOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5500
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
> Sent: Wednesday, September 22, 2021 8:23 PM
> 
> On Wed, Sep 22, 2021 at 09:23:34AM +0000, Tian, Kevin wrote:
> 
> > > Providing an ioctl to bind to a normal VFIO container or group might
> > > allow a reasonable fallback in userspace..
> >
> > I didn't get this point though. An error in binding already allows the
> > user to fall back to the group path. Why do we need introduce another
> > ioctl to explicitly bind to container via the nongroup interface?
> 
> New userspace still needs a fallback path if it hits the 'try and
> fail'. Keeping the device FD open and just using a different ioctl to
> bind to a container/group FD, which new userspace can then obtain as a
> fallback, might be OK.
> 
> Hard to see without going through the qemu parts, so maybe just keep
> it in mind
> 

sure. will figure it out when working on the qemu part.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
