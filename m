Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600EBC433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 22:34:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC89161038
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 22:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC89161038
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADCD260785;
	Wed, 22 Sep 2021 22:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U4Hji351O2HZ; Wed, 22 Sep 2021 22:34:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D0CC760609;
	Wed, 22 Sep 2021 22:34:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2C92C0011;
	Wed, 22 Sep 2021 22:34:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18870C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB4A04068E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:34:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IA5kEasCzjf6 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 22:34:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD7224067E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 22:34:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="221829473"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; d="scan'208";a="221829473"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 15:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; d="scan'208";a="474861602"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2021 15:34:44 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 15:34:44 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 15:34:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 15:34:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 15:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkvLIfHPrQmkBU+NibtZDINwqllSn3/ktets2ysS7JNTxPoDORm1aRwAk4/WhcKzdJPFDKnM98dBPZN7M4vxijZa015ZQjEcyA1fz7ntSX6rrMsOChbEAlzFiIWrt2tcL9koBVfYg7Snh2bqZB9MIXjaH3A9pbjCcBq5/MAF/ghTvOOCGLV2Dkczh14iSbgndwYzXsqBF8sF1G9rKn/BjN2UFbEcFn8Zxr6C2Fje0vEKMu8I7lEnAw8WD3urJnurGoq1Kk1aFIsoVrVLKOAImspO+XxR5JJWTH5VcuIAyYMGDO9NN+ejUgqQ9QxU9RIC6hAVjqVeXOcOKlybSifIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=w/75khrrynZ5IBbgDAOesqE9d1ME4zTDkoRBF8ZUuLs=;
 b=U/0ZcQVlqNajt04of2ftOBq+LunjM+P9rbMHzciQClNdDlWc4swN3LQOMGnGdPuG5S9Y25wahLFAvsKkY9OnMowFZCCqkfNCf/b8Van83A3iz9Eqr3sTjgFe6JPlphGk8eI5IsxP7uc6BiYib8sJbiHNk9pN8x/bAOqfTRy3+lRsiTwaoZWkjSFieQJivm5IG8N+EASxMHWP+fPd5SbkY3hW0CDFDcJjlw9uTWepdgkj8R2d0TEU+qZG8KthlH4GfFzjCJoP+fxSVtSy91yvpvR/ib1do3oeVCdEm8vra598Q/cypXO3ZUGsdVvxxmiM8k25dbTKBaI37ISyhKuDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/75khrrynZ5IBbgDAOesqE9d1ME4zTDkoRBF8ZUuLs=;
 b=VbBZZJEIIXXFvHTO7aiJ/mEGelQd/eBwnrVbMX+E9BhnwnOYbSJWfA1t5x2D9l3p/VZEXGpRk9szZ0SIMY3xDvrMwwFECS6Edc1n8/OhempYmsnogiiM6Y3Se3684g4GebGpsT8ScdOjLjhsvV43cLUmGvWN9wEKaCN9CcXP82o=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1537.namprd11.prod.outlook.com (2603:10b6:405:c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 22:34:42 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 22:34:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: RE: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Topic: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Index: AQHXrSFwNP3/pIcrZ0iM9X/cSoy0lKuuqYQAgAB3MFCAAB2WgIAAjDNwgAA0YACAAIKvAIAAJpDg
Date: Wed, 22 Sep 2021 22:34:42 +0000
Message-ID: <BN9PR11MB543366158EA87572902EFF5E8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922005337.GC327412@nvidia.com>
 <BN9PR11MB54338D108AF5A87614717EF98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922122252.GG327412@nvidia.com>
 <20210922141036.5cd46b2b.alex.williamson@redhat.com>
In-Reply-To: <20210922141036.5cd46b2b.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec6faf97-c456-40c7-0cdc-08d97e192bf0
x-ms-traffictypediagnostic: BN6PR11MB1537:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB15372D87C97DE809014BB6118CA29@BN6PR11MB1537.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPsUzWgKvA0O1fOZrz5J6/xaPPY6pi3aTJuq/3W3eM4xch4RbFV11uX+mcQ7uJIUTd8ubb05r5KbRk1ZYCWKdGCtciCQUMj9RWIimItP31zKI8+pvQ3ZG1yIrhCUm74tvSRDcnymkm5bdUj3IyzaHWKV+OT84PNvY8wneBVV+nGnqZbu/SSUcjXL3j0x9raKrXyzFclN5BKcCiLpmOj0hvryQY/IPYRlXxOkPBk2pK62L1oeQWLwMzdSTWwN0UNa6T7KziantRYkPZcQtJBiU1pK4kSb+TOtQC4hN2vBYeM/9wYILLSmwydyFEk1t0rHqjjwUeF3HK5NyxAtF8LBaSlBJ8XwykZA9tBKnB1lQET2bM/vwn2428w4g2zY+d5rkNtYbxtHyaPP7OgJfASlcxYVJQ4AK9idE5J5H2ZdU2l7k+dHl0IXnw7xWIqnu71mGwXSO2X4BHqVX7bjXb5UfJHcW2cBxxFFNMP5AdF3Kqs8Nj67tB4WJh+dZKc9oWkTE2X05mWUwckuwRURMGY3zGVM5enXA0yP//tw86ENcScwaM8ETy4B7ghFSBoQDWmRv55mHWd5rnD8IB1KgO45+Vvdcyuu+C2sRV9yjtj9IaGtm/5iXZsvo/bs2k6lv0L/BX1hUZHh82nqGTLkO8ZpNr+ucCpvqKsR+S7AGuU/6uTKOW8+slXrvRj822u5wHO4qWKJmY6OFsJq2rkrDLBYqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(7416002)(76116006)(26005)(8936002)(122000001)(186003)(7696005)(33656002)(4326008)(508600001)(38070700005)(9686003)(316002)(6506007)(66446008)(66476007)(64756008)(86362001)(66556008)(38100700002)(55016002)(8676002)(110136005)(52536014)(5660300002)(66946007)(71200400001)(54906003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RsaHJw3uLolBUtUj4Fd9MAnpcxnOkK9qREJL/E/F/3JeJ9OGNZQeshldR/Mx?=
 =?us-ascii?Q?QZ332jvnDq8elS7YusR6c8iHvjbYQYSdl448F4JSXZz0tdAdF5IhY2PkIKuY?=
 =?us-ascii?Q?blYyjWpD0rrtLpQWseym8D5Mu79WMc0t7KGf7u+0BbwAk66XEVeNwHBGsTyP?=
 =?us-ascii?Q?UjlTdpDZRUCAJNhJ+/cMcKn9NeSgbSeQf6dGC9WIILHadXdxemUjlZ6QscYT?=
 =?us-ascii?Q?yN8g5IT3iH0/EmIXonpaXZvd1RrBXS71ho3hLezxfMrOxf8v07NY4WndSRMK?=
 =?us-ascii?Q?++QCQxC8EA8T1BaSNUUv4v+i4NV3MNcSegCrqH0YzbM9Q4/KsYyETEfc3ts+?=
 =?us-ascii?Q?H2j1ovub0HMR4bYJkE9uElqOLv7T9kgJBZLETkqkCtf6ukhFSIwefW7dTuYN?=
 =?us-ascii?Q?eJi01PM2EqJun8NS/NHj4Q7txcKgaSxMwCIyLcRmUVCAhK2qAsZDBy2YVZQ/?=
 =?us-ascii?Q?mLwqowvQvrgQT8iOiBfX/xoOd0zYBCkuAxBmygrQdEi9KBHjTPm5UfzAMpVG?=
 =?us-ascii?Q?efgJ4FpL3c3hEtCHoeYWV5/FHrEiFo+aHTt0QsZ4kqyzr7pBJ3fPML4tfe/h?=
 =?us-ascii?Q?Bz09RIar2XMd040k5TEsuXdBQfsZW+k6JMjX0ydocxVITZ+OskvI5XE9o2aX?=
 =?us-ascii?Q?Zjfedak2mn01GPItjfRR3btCf0aB0EthowRIsjHFA00GB7yDROsTzwSq4vEC?=
 =?us-ascii?Q?n9MzTFaqHq9LaCPBIn+i3soGmUA6ayFw3r4OzqGCPjsgeamLqeFZCs0oc0zM?=
 =?us-ascii?Q?t6VlUJZTP8V2R3x1kmnRMwrGfxNqjJWSI03Pcnen/280QDeZTpcbnOyPQ9Bo?=
 =?us-ascii?Q?y1hbbXVP/NmnoY4/jlBhTgLVQrWQho3T2bKGTMgnqDMr0+cyoF5PlpR5H5gO?=
 =?us-ascii?Q?QL9MmmYIAM23OrCpf/tV7rDqIxeReC6gtW9pPhAka6W3zfybJhB4nJj/5vud?=
 =?us-ascii?Q?TQODLSnw37nFBrUOy9VOTLOP/QSEIg9ZkdlmTMZwkzN5XFf4y9O4sCtGv57h?=
 =?us-ascii?Q?XV38tAoGmbKzJUuTn2LSBm7ANxEUaCjnw+uRJElKx7xQk1R+va6UgbPESPq/?=
 =?us-ascii?Q?cEpFUL5coBSxCiDyeOG58PQ153dgY04IADu0600Y4QJDulQi0jMQ4Pt/DoIW?=
 =?us-ascii?Q?1e0R+I1du9QWBHguDoPrHoRpIQxuWLqiT1mHTgDEzqSNBz2EH2faEPe50qmH?=
 =?us-ascii?Q?aGVe91oPrOehtheo5RUK3L9yfPehBTI4gd4bdOD+UUuDGRhVenJ+i066uw4a?=
 =?us-ascii?Q?J5CRavRI69k7bnDXdJlpmisdnc/fq0BKQK7URraWblRpRqYCCrk06pvKQs3w?=
 =?us-ascii?Q?7aUkiakAWhoWjaXu0ZoRTzUq?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6faf97-c456-40c7-0cdc-08d97e192bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 22:34:42.4238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dOSzTg2AJQ1SV3lMf0Ib/3pJVcwipJyuPExwrqs55h//77gun8ZfP+r3w2UwedTpWtOjwczQd9jO+hF8oMHRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1537
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Thursday, September 23, 2021 4:11 AM
> 
> On Wed, 22 Sep 2021 09:22:52 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Sep 22, 2021 at 09:23:34AM +0000, Tian, Kevin wrote:
> >
> > > > Providing an ioctl to bind to a normal VFIO container or group might
> > > > allow a reasonable fallback in userspace..
> > >
> > > I didn't get this point though. An error in binding already allows the
> > > user to fall back to the group path. Why do we need introduce another
> > > ioctl to explicitly bind to container via the nongroup interface?
> >
> > New userspace still needs a fallback path if it hits the 'try and
> > fail'. Keeping the device FD open and just using a different ioctl to
> > bind to a container/group FD, which new userspace can then obtain as a
> > fallback, might be OK.
> >
> > Hard to see without going through the qemu parts, so maybe just keep
> > it in mind
> 
> If we assume that the container/group/device interface is essentially
> deprecated once we have iommufd, it doesn't make a lot of sense to me
> to tack on a container/device interface just so userspace can avoid
> reverting to the fully legacy interface.
> 
> But why would we create vfio device interface files at all if they
> can't work?  I'm not really on board with creating a try-and-fail
> interface for a mechanism that cannot work for a given device.  The
> existence of the device interface should indicate that it's supported.
> Thanks,
> 

Now it's a try-and-fail model even for devices which support iommufd.
Per Jason's suggestion, a device is always opened with a parked fops
which supports only bind. Binding serves as the contract for handling
exclusive ownership on a device and switching to normal fops if
succeed. So the user has to try-and-fail in case multiple threads attempt 
to open a same device. Device which doesn't support iommufd is not
different, except binding request 100% fails (due to missing .bind_iommufd
in kernel driver).

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
