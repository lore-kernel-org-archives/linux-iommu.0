Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F16C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 14:18:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C3360F56
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 14:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 88C3360F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B16960BCE;
	Wed, 22 Sep 2021 14:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1yksGt-SI8y1; Wed, 22 Sep 2021 14:18:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F0DF060744;
	Wed, 22 Sep 2021 14:18:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC25CC0011;
	Wed, 22 Sep 2021 14:18:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08CC9C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 14:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0527740215
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 14:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OX4VCP68Xq92 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 14:18:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4374D401FB
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 14:18:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="220406829"
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; d="scan'208";a="220406829"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 07:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; d="scan'208";a="518600360"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by orsmga001.jf.intel.com with ESMTP; 22 Sep 2021 07:18:06 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 07:18:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 07:18:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 07:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K37k3dkzt0SF1YG9gqrubllJIh0EFfRc2QN/tA/+soX31pYx83+SLSpJt0X3AufOxW/9d0lIv/x9FlofLWg9IB2eRhbqpw52NMCNr6ygr4cRJ4/wsq6J5VIAL6bd8CNP9Amdfpx/5Ow3LpFGAfWV+VmmXA7Vs0ARNhgGICXEu68GwTtHl4LAfyn3pEbp1rIToRWgRfh6+Q6S3fOgog5Z2WYFBMwD4jrieev5ORkGSClL1/K5bbFrEuRHe8+H147/3VWLV5piRZt6cFjGqh/fZvgl8oFUzBKdgiAIL5oE1PvB6AFCrdh6MGUkpDBZa72Sgdr9hNMhcMh6D2RGJeh47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ngLfJKnI2mPCXl57TxzZWFaAw7lf1vDeABL0mKA7e7E=;
 b=QWHK60JPLos3wuYEHNT7zH72N1EabLJ3nAgxLQfGTk/E7UpHjdosftm2OxWgz6Ge4WTcS6D0SGmIcaRY7cqSVIwBWUwMQlXcNnGu1ALHLsHFin03aqjK7gqyUMz3xVoFUZO0qciWo543ZTs4SDCkTegfVE3rFPjanSTTs542YFIUaJAHQgFP4qda3DuCIQa37L7WoWlpi50EAa5Iln+VPqlEeHozA/IxQ5lSeaegYLUyg1Zdca9etGwUl8SPreXVcQGBV3fhrQIE9Rg9WP7E0FUf8vCaeApVP5K18EPxnQFsvFt7OVgzP3cNNl4p+SbzL/JF9OA96LlUlsehFLN2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngLfJKnI2mPCXl57TxzZWFaAw7lf1vDeABL0mKA7e7E=;
 b=nxSUn+Y1fiu+CkTv77/2CuoDRHxxXwEHtP2CgEI6efLkwCkgfen+7tcbU63gcWr9Ub17HHBf9qvHxaTEgDen75PbJ+L8HmgYl23B5IAc3EaoZSnPM82UG4FlToOtyYL96UzFkc8RTuqDzy1OnhOxFSiKblGqE8jQSakp/1PUXKI=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR1101MB2145.namprd11.prod.outlook.com (2603:10b6:405:51::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 14:17:56 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 14:17:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 15/20] vfio/pci: Add VFIO_DEVICE_[DE]ATTACH_IOASID
Thread-Topic: [RFC 15/20] vfio/pci: Add VFIO_DEVICE_[DE]ATTACH_IOASID
Thread-Index: AQHXrSGrvqwDmY670Eehf+r4QAc6S6uuy+yAgACk0sCAAJgXgIAAFfCA
Date: Wed, 22 Sep 2021 14:17:56 +0000
Message-ID: <BN9PR11MB5433D992DE87A7F8E09E24CF8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-16-yi.l.liu@intel.com>
 <20210921180417.GZ327412@nvidia.com>
 <BN9PR11MB543319F29F0260EBE2A9F3478CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922125833.GO327412@nvidia.com>
In-Reply-To: <20210922125833.GO327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb483d66-456b-4b17-58ee-08d97dd3c611
x-ms-traffictypediagnostic: BN6PR1101MB2145:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB2145951B5BDAF378637FC57A8CA29@BN6PR1101MB2145.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itJJi3QEtto3ooKfxCdTIC+wTsafflT22TQcADEytZo5llmrbDb1cqXphFHwxD2vAk6w+a5Nu1TPJ+dgodOCXgXzmqJIcT7b/sjM+0oNUhwppvF8H0wHBZ6N+Oikc2foNAG50/uiAHechklR0Guf+I13YyiKIsN5QQxcaQp6xxc0HBxqQKa5+UhrhafZY4DEAOMYdFP1xsvt8h5iIEzOOAwj3dh6cJA/Kbo2YwrOZnPZSwWBox7K3bE0EO43erVSRR0dpncHshcI1qID1mFlwuAk3dSOzKwlcXPoGFlCGjkziaabmmt9/miL0SIp/5b3ttglHS3XOBi3Gienta8i6GyaEsafmGve33IxmvReGP6BZM+VlporRX/KM2YGGelHDpHb9GSXHGshGNmDCEDIQLbn5cjxVsKtHcz9BEW07EBlCzpSwB/kLmJ5BY4Oyxh5+D4Q35bJqtQtp8PBEEiAtYGBv/hXSjMOUJZkYNRXH4rznKPOZ5glMFJpHvDJ3gj6kXC4Zdzjz/eoYfDTjlZTUlylUH/9C9UFarwvTiys66YWYQG6e8Gmb2pSCGw9d5vUEupS+ZQq4UUowiVRMcExS9JhL6axnrEHQyUdPV00wvG6IO2kXXdXbvkLyNIhZ7FX+xhK4Medm4Ma+H67lngC8vMRT2nUaNbeSay3S2B0xsQ3Oc0SLB9iauaIwrrVrbzkqozimry3gkY9Y1XRpYg6uw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(8676002)(38070700005)(33656002)(26005)(66946007)(5660300002)(6916009)(6506007)(7416002)(186003)(7696005)(54906003)(122000001)(2906002)(9686003)(86362001)(83380400001)(4326008)(66476007)(71200400001)(76116006)(66556008)(66446008)(508600001)(8936002)(55016002)(64756008)(52536014)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HsQ66fNu0xlLRCXqHxqqKddkwsAVhkmff6z51UMIdmXQ5F8NjF55BLo2abHI?=
 =?us-ascii?Q?NY3hyCFXUGZ2bn2Fj7tGVmfN/XW1cSnR/gd049s51kMpBEMWOLTx7S352ZAJ?=
 =?us-ascii?Q?aAdg5KlW7qDES1FLT2Lwrzn6rLi1EIHO3K9PUUcqcUV1wqyigXhiOU6vVR4j?=
 =?us-ascii?Q?XPIWNlw1bKUmc/PI8UzM/Y+iH2MtlfpxiDFsSJreCwu52vdthXDyQyAAWrTZ?=
 =?us-ascii?Q?45QAclNIu10+RdPWDMyMdgSfzGvhTM8R+Av1+X5yjdee6JdCzpU64+QFF1FH?=
 =?us-ascii?Q?eatXFsw5Xi+1l3rI6DtGK+Ps9WHcWslIEdusIoUwuS3G7YrntS07QdTZak7J?=
 =?us-ascii?Q?aKR88sYKwzDZNwl86WWs7Mo+Y2DO3xK7D82hxBz0bUw/NjLlU9gxI4XEoCf+?=
 =?us-ascii?Q?50YJ6XP0HOWYXBD2NBkhIvBFAQccdjwmJpMmSE62my1jsDw/9V0tQcOWHV2T?=
 =?us-ascii?Q?T+dEurKZtF22+HkJcr7IDmT//jZ+UDL6zr9jWEI0MMuxOGUYgmHpk/ZdqIQC?=
 =?us-ascii?Q?ZI+V2uDABcQJqx/hp/yPmqHBHHlMkbKCc6pQ2aiiCWEyaghrZDQLqHkLaUju?=
 =?us-ascii?Q?fKUwvijHhgmi0Ij5N1M2K8rxNCTMNGCY/mnpFb06pJVIFyLg5lHa7nblBAnS?=
 =?us-ascii?Q?72QGEKbo7j40pcCiSe7sBo4nbCxfAer9x/nKVCMKmTWme31E7hXc313CRHQo?=
 =?us-ascii?Q?izVWbAHQjLGq2+DFuJvvslMIEOM8mmP83SKFceL8HMMGUBXLYqk+3+R00hT/?=
 =?us-ascii?Q?JCvDpQ/omxY4Jitmpl8UTMi4gVeDIKIgnv44Gn7pseHay28LsjTTYW4ii2tX?=
 =?us-ascii?Q?fVXij7/ysOZGpbWEYjX5YLuncKWYu6fP/d/nkdBQ0/9tsHuPdULlvFN0Mwvz?=
 =?us-ascii?Q?kh41BiN3Y8fsw6IzBaePZPltYbEeBrUOpyXHU0PsqPyTng3pA2BAopHZk+LL?=
 =?us-ascii?Q?ZEJi92J9yJN1LH2Eeju8h3gH+cK8qIce7kh4GaFg/EzpW9EItbtL4NSKKSK3?=
 =?us-ascii?Q?B6GwSLLqjgavt07aqJeH60GWS7nrWPQCvtfS3e4dMz1Wf/WlcroIjv9JmkHA?=
 =?us-ascii?Q?iekD3GuRw0oEJI6/g1juCKGvgY3glGc5A7jhOS/kkLUhyBqCK/xDGmAOd4cW?=
 =?us-ascii?Q?XObz8XZ5EZ0BnH20MrqYk9g2YK7s94+o+lzvoeFbR28rWB1KFr2WedjUZzRb?=
 =?us-ascii?Q?pEp01h9Mg8b1KY4AoE5BuOGzXPtDBYm8OBB6a0n8zOxWdMykw8cr3BonrUXH?=
 =?us-ascii?Q?GbmdAdomdQW9l9oFZrMvhTGXDDtxFnhNe5LIRr7upzHzxjXGlPXVUM+EsMAZ?=
 =?us-ascii?Q?0SLscLeJUvxBYMQ2trTRrr/R?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb483d66-456b-4b17-58ee-08d97dd3c611
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 14:17:56.2241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jhs0TYsyM5NkC7KMYgtL6/DW1a+AeCXReyhMIA+w2R+5cFXm7HY7tr90Z8xTU32k/46y1ppsD1JtJDKRX01Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2145
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
> Sent: Wednesday, September 22, 2021 8:59 PM
> 
> On Wed, Sep 22, 2021 at 03:56:18AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, September 22, 2021 2:04 AM
> > >
> > > On Sun, Sep 19, 2021 at 02:38:43PM +0800, Liu Yi L wrote:
> > > > This patch adds interface for userspace to attach device to specified
> > > > IOASID.
> > > >
> > > > Note:
> > > > One device can only be attached to one IOASID in this version. This is
> > > > on par with what vfio provides today. In the future this restriction can
> > > > be relaxed when multiple I/O address spaces are supported per device
> > >
> > > ?? In VFIO the container is the IOS and the container can be shared
> > > with multiple devices. This needs to start at about the same
> > > functionality.
> >
> > a device can be only attached to one container. One container can be
> > shared by multiple devices.
> >
> > a device can be only attached to one IOASID. One IOASID can be shared
> > by multiple devices.
> >
> > it does start at the same functionality.
> >
> > >
> > > > +	} else if (cmd == VFIO_DEVICE_ATTACH_IOASID) {
> > >
> > > This should be in the core code, right? There is nothing PCI specific
> > > here.
> > >
> >
> > but if you insist on a pci-wrapper attach function, we still need something
> > here (e.g. with .attach_ioasid() callback)?
> 
> I would like to stop adding ioctls to this switch, the core code
> should decode the ioctl and call an per-ioctl op like every other
> subsystem does..
> 
> If you do that then you could have an op
> 
>  .attach_ioasid = vfio_full_device_attach,
> 
> And that is it for driver changes.
> 
> Every driver that use type1 today should be updated to have the above
> line and will work with iommufd. mdevs will not be updated and won't
> work.
> 

will do. 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
