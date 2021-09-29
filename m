Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCBEC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 22:34:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9357361452
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 22:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9357361452
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CFAD60BD2;
	Wed, 29 Sep 2021 22:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W2A3JaMbsKpq; Wed, 29 Sep 2021 22:34:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 22F7A60782;
	Wed, 29 Sep 2021 22:34:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBB79C000F;
	Wed, 29 Sep 2021 22:34:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F09A2C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB53B421EF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:34:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLSPb2OGyP39 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 22:34:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B62C2421DD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:34:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="310602560"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; d="scan'208";a="310602560"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 15:34:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; d="scan'208";a="479512265"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga007.fm.intel.com with ESMTP; 29 Sep 2021 15:34:35 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 29 Sep 2021 15:34:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 29 Sep 2021 15:34:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 29 Sep 2021 15:34:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 29 Sep 2021 15:34:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZq3bSuGMRjButD2IBPQ4BYvLtsU/u7a5EWH2RpVIonrV8YNaF37j9xFF9+sOBS1Hsf+Dglh5aucV464IyyiGtixC9obcXdiirOWQlGMIfXPFZzVWzYhakHAEV4nTQ/CzytAnPQkDJgjYJFFwZ/6aZ+yDDdxQguueAENCYxtGMDMyItWySqxMq7h2C3gSBcUAKEHndV1UOa+7jyIVR5WwYwOMGU1hgCzzyFtxAQBgu458IhxgxntvtRPLJIrBF1Rd3tWeAaBy7lo/QFQyCIezEwhI4qc+BLEIC16hZl7//sT0R5W7FUsB/0n/2Z7oxboBq9p2iVaMVv3vmUdnys6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=JrwPRk69Oy+noQmKgeJmQEo1RFiiQJfXh6buIAtHq6k=;
 b=c8HHhqJrmlDy/CT4uncn/y8zxKmhXmrqDAra0yTB9nfhbJ/vRTvjeFg9qK8RH+BRPVxRdRPUpHfZ/UqiKx0OAJ5waw+WOo4w8WPk7XR+HNQpgqHAU6JmLWQCegxu7KKjDmI+hIo6oDGa4cosZe1ZWBJzsoC68tu0kvD989VcebnvJ2ZDTpNtznYhSf4oTkg+WK8oL8YXqjFY8XwBA9dwdOReNPrp5tFZIMrmGzL+yZ3wrz5azYyVnHSy5RryFMWA1eX+fLB6cUA/BeilMO4EcICV+szn7Jb7eZkw9FGldAtURc9PYlBISbt0WB33baBXbVojoDq5EL1LsQytFfRtjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrwPRk69Oy+noQmKgeJmQEo1RFiiQJfXh6buIAtHq6k=;
 b=anrsbseWbON+8JoIUR1fSK4w2tKFObwrRJ619qGp1ba40mXmkeduAL2TYl1a7+IPImB2nQt4M84Jfx+08jUXMDt315eNnlwdB22xN+7l79q1p7Uu1P6Jyh+hOG8PWptmWK59SuBUfj5rCPM4oPywoQwZ6AlXACys0E3EJ2fKD1w=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB2019.namprd11.prod.outlook.com (2603:10b6:404:3f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 22:34:29 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 22:34:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 08/20] vfio/pci: Add VFIO_DEVICE_BIND_IOMMUFD
Thread-Topic: [RFC 08/20] vfio/pci: Add VFIO_DEVICE_BIND_IOMMUFD
Thread-Index: AQHXrSGD1s8CLHCzb02iYFtNvU/Mhqu6lHYAgAAIGmCAAGQPgIAAqVkA
Date: Wed, 29 Sep 2021 22:34:29 +0000
Message-ID: <BN9PR11MB543354BB34FC69D9237DED5E8CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-9-yi.l.liu@intel.com> <YVQBFgOa4fQRpwqN@yekko>
 <BN9PR11MB54331D06D97B4FC975D8D23B8CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210929122801.GQ964074@nvidia.com>
In-Reply-To: <20210929122801.GQ964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0887c62e-1049-4681-97ae-08d983994cf7
x-ms-traffictypediagnostic: BN6PR11MB2019:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB2019C41123BF0CE806813C5E8CA99@BN6PR11MB2019.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mbQmaUolsO3zCt0QNRKXIW7WWFE9bFJ0Y0oL8LSS/V5sfH2DXdN3T8t4KcWyanPE2vv3+BFQr2CTd9Qa4pxGcPoyaCk+Ow21io+WESEnFV0Wy+5R+hj573jsiFJQIvsKZHLenucZqBNxjj6LMxLz3z00QuJGZ2oF5PvRmWhE2gx27ZeKMUU/d/2u+XcCYtFY6TijMTrK+zUBcsmhguaHHO09XV97u46AjpcAaR0ddHptSIQmzecZC4Mwjc2jZ8tk7L2+9wStLZnKd9pTDP/C5L9JeWB2D6G0Izg/7bErd8Jh29zSA1Kip2NLQLp1n5WyFbHmogDeieLxOtg5y+iWAygfauHw0tINf4VmlVm0C4aLKJXhlr4dkRhZ4sxvBHBYa7HMTTTGNBXC55FpiZ16dTEomnT8h78C/N2Q6XWwuItMrkH9P4Be1+jGeBrQYgEKErrMYMuIZHEwPneAW99kBxLmHyY/btgAGiWOVf4hiZdHjaXUJaLCBfV/En/vqAavdJ/j9cZhnPD0Jv+8na6EedGpfzJbUFVmqkaBjxDQzU3Vofk9HuNCZeLHn2ygN9K6TJiT2Z/CS2nN5pC0Yc5vFEV52CtWHIldC2MmgNPLWB79kRnvZ4cJ6wfbekfN72kziohC3yljnogoq3boUtFlstQZJJcKRwKqvIECJNEwq6xc8GPJZfOfKRcnRmp3VNvkOhzZsHVUU7PE4KK70xjfKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6506007)(8936002)(33656002)(316002)(55016002)(7416002)(9686003)(52536014)(5660300002)(4326008)(54906003)(6916009)(38100700002)(66946007)(76116006)(8676002)(64756008)(66476007)(186003)(508600001)(66446008)(38070700005)(66556008)(83380400001)(7696005)(2906002)(122000001)(26005)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SD6Nbm+2FGSZoI/v81vDBSKJ+6X0iQ29wfStZLm4M+iwml149Chft96n7Mu2?=
 =?us-ascii?Q?tdjuL5T/7Q1cgO0L5fmCsQTlX9CI98UQWmLF1rZF4ZgYvzeLI6vXuprAtszV?=
 =?us-ascii?Q?3ADN6sSxPSyrPJoqiI8dYK8Fgp19p/TbxXk6m7dPsgrw2lUjjpHWfC/7Rc+q?=
 =?us-ascii?Q?BzuJdRP871REZinrAZqv9uwr/Y8IWPac/QRscUo7vaTEU6lv71cb2eky9/7O?=
 =?us-ascii?Q?xfNwgyYyxwSTP2yTOOdq7DkqHME+nd8ujKTIAtqMb8LymCoFdFeHngblQo3M?=
 =?us-ascii?Q?5mourK9TEAOm7XodEbwta6hB1y4tX8cDz+86hFP4btkhiMsMPjC9pnLQmjjh?=
 =?us-ascii?Q?UibES5ybJ+QBVkDA75kaUzk9nK25th7IoKFGuaMy5QtQq2nNpQSfQYLI+Bdl?=
 =?us-ascii?Q?qz2Oq/iJqdKsZqCPG5+3vzZSgW9926NU0ge5piERBahsv4qersr5kh891KAd?=
 =?us-ascii?Q?5FdsoTQfsksbRljlTwco7xmL3j62HRzMgdWjTBYQ3kf+tRoL7Z7WOsprLg5O?=
 =?us-ascii?Q?fPKV/Xk73BJXI306O7BRigVQl2WWEWRiVjq+JNCo5ZBzPp0ri6gE8MP2P6K2?=
 =?us-ascii?Q?zE3+09cjoR61qNdAtnHbWRY9zajLg6NeUIFPA4rFC/5WleXLQetF7y4kRTw8?=
 =?us-ascii?Q?/jSzilgfnu3n9aPzZ9ImPRrR2UM+aMH4vhKyCEj2zTzyou1/JkIrwpQXZO7/?=
 =?us-ascii?Q?MtibS3gwf7gSVoGx4Ma5I3zi6hen+ug1kY+HXFQ/XPOJiKelPX5QVz/NOE2i?=
 =?us-ascii?Q?184aOVXmj2oBDM6A3ThXk/qBeId2DoEGRV+MuQdHQAAN8hERu5Ucul3b2hKp?=
 =?us-ascii?Q?/AYo+D35B0kjsirfsarywL20x2zgXmsov9Ybou95d88jt0YL64MRyd1n20vY?=
 =?us-ascii?Q?2ZLttanEW0GUcBAx0pSgGBVmBzKpMQX85l+w3/yjcZ/nrj4VmcE3REI7pZun?=
 =?us-ascii?Q?7bunrTnskCzNxOAz8XliRvgTqfCpF66HgKNGs08/c5T8RIBwU3vPIXe1QfBa?=
 =?us-ascii?Q?AwKOZRRpxoUE0zftb7l2KNKE94Zk53LgmQeFYXUningiwBHfHGFau5x6G5mX?=
 =?us-ascii?Q?lYKg5oG6zKW2hmL8wPfw07rW66MzKA6JJKOypm7oJ6gY2sRFgc8uL6nNP1MV?=
 =?us-ascii?Q?Q7JbJvBOENRKUZSJcAhc08x8yp55pRLpr33UJ+Nt/UOh/C3rmMPEnSq2p52z?=
 =?us-ascii?Q?rTChbIiharcsfg6uqckmuipd+hwTtpfa239yVo8mZsAd25z9i+7d7JFd0TWw?=
 =?us-ascii?Q?YYEcye7N9jvlJL8jM6OLheSq/KYXKB2buq95xCcju14oXVbTspsZ6CA4rxMp?=
 =?us-ascii?Q?QQSKm7is9AUHQBbJVbstkmnl?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0887c62e-1049-4681-97ae-08d983994cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 22:34:29.2831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EzIH6KgrpzAfZ0JdZTW/QORjl3WSd/s94cOEBK78iUKqmoglLGjEnnabkXPwR0WwD41GJ/TU661YKMnMyN7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2019
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
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
> Sent: Wednesday, September 29, 2021 8:28 PM
> 
> On Wed, Sep 29, 2021 at 06:41:00AM +0000, Tian, Kevin wrote:
> > > From: David Gibson <david@gibson.dropbear.id.au>
> > > Sent: Wednesday, September 29, 2021 2:01 PM
> > >
> > > On Sun, Sep 19, 2021 at 02:38:36PM +0800, Liu Yi L wrote:
> > > > This patch adds VFIO_DEVICE_BIND_IOMMUFD for userspace to bind
> the
> > > vfio
> > > > device to an iommufd. No VFIO_DEVICE_UNBIND_IOMMUFD interface
> is
> > > provided
> > > > because it's implicitly done when the device fd is closed.
> > > >
> > > > In concept a vfio device can be bound to multiple iommufds, each
> hosting
> > > > a subset of I/O address spaces attached by this device.
> > >
> > > I really feel like this many<->many mapping between devices is going
> > > to be super-confusing, and therefore make it really hard to be
> > > confident we have all the rules right for proper isolation.
> >
> > Based on new discussion on group ownership part (patch06), I feel this
> > many<->many relationship will disappear. The context fd (either container
> > or iommufd) will uniquely mark the ownership on a physical device and
> > its group. With this design it's impractical to have one device bound
> > to multiple iommufds.
> 
> That should be a requirement! We have no way to prove that two
> iommufds are the same security domain, so devices/groups cannot be
> shared.
> 
> That is why the API I suggested takes in a struct file to ID the user
> security context. A group is accessible only from that single struct
> file and no more.
> 
> If the first series goes the way I outlined then I think David's
> concern about security is strongly solved as the IOMMU layer is
> directly managing it with a very clear responsiblity and semantic.
> 

Yes, this is also my understanding now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
