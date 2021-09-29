Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10169C433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 05:39:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD32A613C8
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 05:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD32A613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7714960668;
	Wed, 29 Sep 2021 05:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TD-c6mw4h3cy; Wed, 29 Sep 2021 05:39:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 437E7605BE;
	Wed, 29 Sep 2021 05:39:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A3F7C0011;
	Wed, 29 Sep 2021 05:39:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32D08C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 05:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DB0980F5A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 05:39:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7VYbHfcjF2rN for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 05:38:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA47880F3F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 05:38:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="205014903"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="205014903"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 22:38:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="554488235"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Sep 2021 22:38:58 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 22:38:58 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 22:38:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 22:38:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 22:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogE/u2h9WxtJiIbtAgPkQ0GTeS33cTRGtrXtS9e0AulDdrxi4UEgiKFJG348ADqW/wywYG/R6sZ4Cxq8zPTZLJojBphZsv33iLqwnqIcdmNg0GD3A3tcVI2Gn2H7Kka4jq3ENm1DN7CK0r5NP8OVzdMOwaV/QcGgnmPdd/EWOb7zN7yRYMW9/yqVak++Po4fbeTSnUdHNScF4+Yl8paM/BHixTJ2YRjyg7IZ16V57O7dts0GzgtYJMtuZgNTJDyxH9XjMY0Apd9+T3u/B2RZEmjJU7Um45maahOBggfgjEzNEPKoHNCCwvh0hZusxCQ3VBr5ipw/XFSQqdWqothrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ZF02I6vkdCus+vkusK2OXBdwIbc4nEJjHsdMpv7+HWI=;
 b=eI6QY4hNJP7nM43eICYu7Ze/Yc3FZ65ApOcon4j472PRIiHE5uTp7hRyBuO4AXPcUi67prS8LhGOlIxTJpOYKRWea4bTxyWN9Sb+1mrIPdmsK7/MiCe9vP78REOsLw+aaufmIdOheCqUNMkyD9WYf53q0gW3/YAMciWpQox1pv3cdpopFpSoTukzt0ifX3Wat03LK2gYUdDkT8UaBRtFpOWjyatT8QW3hvbv7MWfTMtnkKERnpwR7LHYhNwN5zzH0/W/kuJvs89DPoW3xMS/CoDA6kmWoPGG6eKuZmTM3N3YoEeRrEJHhFecJHivuNWe7drVm5YssTuYshK14mzkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF02I6vkdCus+vkusK2OXBdwIbc4nEJjHsdMpv7+HWI=;
 b=qXPiur6aSd0hWTkv0VvwwJgfDmmrMVxFkHkOZKxuG8StbxfPdtr7CCvDRq1KV+BdQHTJqs+6OGD2HZwmwFttVT1ofH6upCOQ3VKL1/vx2L2eUciozlj7EsynzFFN49xdp+YW9AzP92dvLyUK9FUch0WHcZAq07T9tayiFkcgu5g=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB3891.namprd11.prod.outlook.com (2603:10b6:405:77::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 05:38:56 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 05:38:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: RE: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Thread-Topic: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma
 interfaces
Thread-Index: AQHXrSF9WDj+Z+DU+UqMJ7tQK2Edmau6gj6AgAAJv4A=
Date: Wed, 29 Sep 2021 05:38:56 +0000
Message-ID: <BN9PR11MB5433E1BF538C7D3632F4C6188CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com> <YVPxzad5TYHAc1H/@yekko>
In-Reply-To: <YVPxzad5TYHAc1H/@yekko>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 699210bd-34a4-4367-66e0-08d9830b6e00
x-ms-traffictypediagnostic: BN6PR11MB3891:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB389121B103040FA6CFEC7E228CA99@BN6PR11MB3891.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o8eptUbqx3oUYosx8ggzcAzrGtJGI4/287sCRNXXjsqRmzIWv4POcQnAGJjX5ryp6m9Wwm4jq/dV9Y4YrUeVhBFR8cy/exvzC0lnFy73ju7QqBbZVZZDbuKhqiKMwOkFhJ4a3r4Ai6DFMpmDhzfECLiU64mm+I6rhLUxgg6m/IMwxV0IpxDhY5b+Uzeih8xAu7O5cc4VxOQyZ5L8od9ePscYKu+2yNmhd6VUbz+5gKCSnXRxPOpnXiQK2IH3RvHENnG8JsLCuoq76mBlctNAjTBJgdWj3erJNEkHEzS5ZNsyaBC1bh8XSYiXSUe8L+aIeBXLywAiZShYOdgXxgKRSZPu++JFxwb8qnVgqEVT/Pm6rsQw2jbvS8E0tlnSB3PmEvHRIJu3jpWmx9B2VgwGtZB83MSHL0FMTVUEOp+Q2Esut6usVggwSDSHhnFuOSZxpaU6mKt8Dkuo2NwXP8n4s+Kq34iL8E3NyTWBS/9n7J+l8PNitZBW7HzdvGHcFFvQT+7oimMKSuMsBZtjf6Vmg9J7VJSAd0hFS1EyhAJLnXU0q8bgj/zk7c2xsFjdN68qek5BQBkOYmpRE47Ls5m0+BQf3YkF4FVdqgjI1kg++M2/o8nhEEkvgGTqGeoWMpOfIzI5tS1scZjoPMoM7vrHl4tGloBsZF6rAqFblj0VGmRAQ/fqywVlLBpvhlHTJjJOM9XbnQqjEYGKukrXElBx+s/R3PQMdg8wyjymxrludE+hOaeW/rWRG+e+8Jv8RYYPxJ2xCkBPmc4RGRJ+rA7bxdUAmNGhtZzmu/LyEml0/hg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(64756008)(66446008)(66946007)(38070700005)(66476007)(66556008)(33656002)(6506007)(122000001)(83380400001)(26005)(8936002)(71200400001)(966005)(9686003)(86362001)(8676002)(52536014)(76116006)(55016002)(110136005)(5660300002)(4326008)(6636002)(186003)(2906002)(316002)(7696005)(38100700002)(7416002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UIX+QJbyS/k+PN7PVEO1qvsvrhhw7HcWdY+5Ql4F1038d637xfFi3ifWNhIs?=
 =?us-ascii?Q?H55UXXhK2fpa6CwSGxPvurThlgkT0EIF79y+Kxc3OuGxUaEAMuJp/sFAS8kY?=
 =?us-ascii?Q?U1NYDAH/4vZFuWHxH2K/cPx3s2L0xRrlcsLjpwqsMT4t0LMqSYs7y1Dczus+?=
 =?us-ascii?Q?u9MFe56UJJ+WixKsiyTMECQQsy19tYkteD0Z16IjupuQjbHqAAJjKGg3VRg9?=
 =?us-ascii?Q?93zz9LNxjvXEKHBGEEN+U+4z4cgS4o9dUIAzSnW3ObiOakQ0pnfUjvRHWmBK?=
 =?us-ascii?Q?F/ECn6VhKXAtteaIrWyq5qAZLuTUp3gzOceBcMqjdHNIQiETIfJPzg+gz+I+?=
 =?us-ascii?Q?5sayVDngHJ6MW48KYtVkF3vJn90jWeDGBAcirHnIqkC3BXwfb956DBZhs5o6?=
 =?us-ascii?Q?e5+snMch/riMJHTrKT8EhwNYA6siZHpq03STHrM4JkwWzwF+UEg/gCyXX+dX?=
 =?us-ascii?Q?pVz8BHkDRjvKucItBQzhOBxDZ9C0O5AlVNaR1JXeY4fv0hcmML1fcLsC4Rg/?=
 =?us-ascii?Q?v06JHBK3w2GGXM2cZv3AIfjJyEsnuiKxoQEAebHeVQcgk0HDfOSxUPachiba?=
 =?us-ascii?Q?1x5RpP4oSWyijmjsfVdSHIzeXHJOAyETNVQhZPAi86Y3OvRk2Yz7r6b/+37i?=
 =?us-ascii?Q?5EARU9OEUWaKGXr0kTMHeQ6TTDarJH5rB3tLvNuTXr5hWZsBDjt7cyvQNp2Y?=
 =?us-ascii?Q?UgT8gutgSyNcfsbQifCuo0chEHOagz4l0ilbEL6n0NmLL3JbdDxTiSoYSJpp?=
 =?us-ascii?Q?G18CQSf+rCvJAsiTAwu4blm5/mta/DdlzDTm/a+zI85bS6kRVJIszrUoPvb5?=
 =?us-ascii?Q?TNKkceUJhYsMDLJK86YGY3ignau3mcxHxYCya00dpsyvjDdhCKFNkL9IkT4Q?=
 =?us-ascii?Q?3dEL8LWX18RfSvMkyVUvCPW/HyCr7d69irW1+FG/lxeTczn5qfv5BmvnbC6o?=
 =?us-ascii?Q?hBJ5Bz3tMcmTo+YTqwEKDVJNatQZRN8OTwtYHQQ0HCHa8SEyjX8rbodD8qLj?=
 =?us-ascii?Q?8BfIJgQcqlcvsofyrUkUd0elOIp2zmVqD7PyN6lRPeH+nFw+H5sfvgDk1OHC?=
 =?us-ascii?Q?EzP6f3YVwDGa/kVgZAZs73+5F1YZlT3SSg/JH/y8KsEJk/72a8dzsk/zslVv?=
 =?us-ascii?Q?vG67y9m6pKpxEJCVMOiL447M3FD//4gV6P9+yVerbJs5giRC9p5kNVNeRVkS?=
 =?us-ascii?Q?0bJet/NqGhpaznh2rosnMjgcFUUbyHoultHfgRzf6LLzTz5+HP7vJfZuSYR8?=
 =?us-ascii?Q?6WHR1506qbQt/wY6oBKTiDaJAk/NC8Cuj7Qwea9YGjHOqAU7lxI0DifsD2q9?=
 =?us-ascii?Q?RZVrxthPXIvqWX+/Nsm4vo03?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699210bd-34a4-4367-66e0-08d9830b6e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 05:38:56.0326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5qJggzBb8vwaqRAhRMZN9gAGtQaJhbQPWvWfV2nKkVbQeHFj69wSzYjPuuXXVBUYeSqeHa1W1Jpnp8U4NIZ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3891
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
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

> From: David Gibson <david@gibson.dropbear.id.au>
> Sent: Wednesday, September 29, 2021 12:56 PM
> 
> >
> > Unlike vfio, iommufd adopts a device-centric design with all group
> > logistics hidden behind the fd. Binding a device to iommufd serves
> > as the contract to get security context established (and vice versa
> > for unbinding). One additional requirement in iommufd is to manage the
> > switch between multiple security contexts due to decoupled bind/attach:
> >
> > 1)  Open a device in "/dev/vfio/devices" with user access blocked;
> 
> Probably worth clarifying that (1) must happen for *all* devices in
> the group before (2) happens for any device in the group.

No. User access is naturally blocked for other devices as long as they
are not opened yet.

> 
> > 2)  Bind the device to an iommufd with an initial security context
> >     (an empty iommu domain which blocks dma) established for its
> >     group, with user access unblocked;
> >
> > 3)  Attach the device to a user-specified ioasid (shared by all devices
> >     attached to this ioasid). Before attaching, the device should be first
> >     detached from the initial context;
> 
> So, this step can implicitly but observably change the behaviour for
> other devices in the group as well.  I don't love that kind of
> difficult to predict side effect, which is why I'm *still* not totally
> convinced by the device-centric model.

which side-effect is predicted here? The user anyway needs to be
aware of such group restriction regardless whether it uses group
or nongroup interface.

> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 5ea3a007fd7c..bffd84e978fb 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -45,6 +45,8 @@ struct iommu_group {
> >  	struct iommu_domain *default_domain;
> >  	struct iommu_domain *domain;
> >  	struct list_head entry;
> > +	unsigned long user_dma_owner_id;
> 
> Using an opaque integer doesn't seem like a good idea.  I think you
> probably want a pointer to a suitable struct dma_owner or the like
> (you could have one embedded in each iommufd struct, plus a global
> static kernel_default_owner).
> 

For remaining comments you may want to look at the latest discussion
here:

https://lore.kernel.org/kvm/20210928140712.GL964074@nvidia.com/

It relies on driver core change to manage group ownership gracefully.
No BUG_ON() is triggered any more for driver binding. There a fd will
be passed in to mark the ownership.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
