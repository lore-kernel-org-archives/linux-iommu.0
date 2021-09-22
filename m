Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9737CC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 09:23:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3795C60F70
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 09:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3795C60F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECCFE83F2E;
	Wed, 22 Sep 2021 09:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZCpFvKuZVJnT; Wed, 22 Sep 2021 09:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C4BD983F1D;
	Wed, 22 Sep 2021 09:23:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EB53C000F;
	Wed, 22 Sep 2021 09:23:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDFCFC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 09:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB455404A4
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 09:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BeLNH2H-n28h for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 09:23:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A97B140161
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 09:23:39 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="223597484"
X-IronPort-AV: E=Sophos;i="5.85,313,1624345200"; d="scan'208";a="223597484"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 02:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,313,1624345200"; d="scan'208";a="474492100"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2021 02:23:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 02:23:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 02:23:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 02:23:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 02:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrROQQWnTAg712eGuwr85y0NhvClGqzjup7D2OHkdUWzD1X8y21prIwvULA0r/wzGxthHncdeNTDCVX/WMJBlGx0rw6jBX9Br2D5z/1OWGb/BWsBM3w2l4GFF2hVwH+SADuStIAk+Sge4oRxEjYYQ5zd8RQjtdfVVxZC3BqaAwF48iJOn+hqjkPzSHwulnYOf9LPUFdKggteL3NU/ryo5I8aw9KUrncrUgqhckNlo3U7+OokxH9Vb3UYZhZI1QldABgpAJNlKAGomMPhQz9QO2WHQ/4EKzEIKRRfRGliUV4L+N2G0hcPhGenmEe9c1+uBR6WZwMYUh0jqL/dodExEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Pvo9xW0CC8yhO3PAbapJ/vRQTnAlsJf/VtlwXcCKazU=;
 b=hFXMJjwH0gceku662QwPFgVaWrc2UaGj4ZjAZfEDebHt+xQqxQjdy0ClpIP7HCglW14vABCny1Vl46chKZzKZqROqgGBX383uRg2lcGVynlcKCI9ptNcWSfsX63p+BO7lZbe93FveA4gVFdBMh85NHvEgIbNdkam6viPFXgLLZ6U6U0jriepJqXdRE79B3D4Unx7tSohqX9TlX4cOA/tDz5LhXRXqS99uFshHa4HkEzS2F6OuVrUE+XpetLYw0pLikn94vdpymiQe+rHsV/t12WVuAyo2e/zTVBSt7lOYCJcnqzotJLjgVopdK30hgGWKpF0M+fwfR58IapcP1sbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvo9xW0CC8yhO3PAbapJ/vRQTnAlsJf/VtlwXcCKazU=;
 b=JfqQrU5jQ2/IqZgOE6qtELqQl8k7UyAYQUlaxlukYmvimDZM81Kv5utajh09mfGrg6xd0M+/EXBs9/kns9gDG2lUotLXoInQFHYyLVWa7IVqyaf7gEZZOd7YKIox92m8OvAxkW57+lJ5Xw33Mn0FiGixrj6FtpiZvvhgPNpiZ5Q=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1460.namprd11.prod.outlook.com (2603:10b6:405:b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 09:23:34 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 09:23:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Topic: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Index: AQHXrSFwNP3/pIcrZ0iM9X/cSoy0lKuuqYQAgAB3MFCAAB2WgIAAjDNw
Date: Wed, 22 Sep 2021 09:23:34 +0000
Message-ID: <BN9PR11MB54338D108AF5A87614717EF98CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com>
 <20210921160108.GO327412@nvidia.com>
 <BN9PR11MB5433D4590BA725C79196E0248CA19@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922005337.GC327412@nvidia.com>
In-Reply-To: <20210922005337.GC327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98c6a88f-44b9-47bd-a6a3-08d97daaa6ae
x-ms-traffictypediagnostic: BN6PR11MB1460:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1460007AA4F281AFF983593A8CA29@BN6PR11MB1460.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GH6UaoOfEs3CyouWvvuebjKKQhPVubSzZlf9tgxAPeyUEuzglyB76BF4MESmJ0zEtMW7XcvC7nhhiLgIRueAb3yv+N1pGfU8/mcgaIzCG4gFRPRV1CzU0oJH2xlHcjmlsZPlQR5Z32V2Zg017KaXQ4CRiH4t5DPhwMNdiO2EZwl9zEcXDTsHnz/xudNug2tABbNl8g4cygRDwdkHMnTXXU6vNOsnOIqmEgsUK+raRNLYvKvEvzJW5ySpl0QdvcCrERtYhDqcH+2GbF9/YM4uk0iSdz+pOVolDuGYU9zB55bZ1CFLzTZKivD2AOHlaWXceqZIqPNBpam9o2x4WnX2xCUuFux35MhRgIRFLABRYccfcMI1EX1M9Hj5gaTmDkThd/H+MQE/Bxhzor8kjEAr3n13oCgyR8qxZEy8BSNLq6+ZrFQHMrsCCZ2enKOHM3n7rCiD0QIXpZoJEDrUFCbDyPQ4vdGRkPQouLY5uM41K7evXR9aQ6YHFpP9HCOjVkyckojuUhSt8WsdduWic1h5TMSxRilIDg5V8Eu/2dnUym22pE3wggOTBL44lg2/KwhqvfT9P5AC9Y+pfPqwo2RFUEtnG5VpT7GWMb3/lGlSgPxsAkt3FQyeWIdcv8F247cGcMDZtYnieFODkyOvZ5BnakFRszURR3wKzptOqme68ZWhYmduFwvW/yJSpPTDQxBf0x90/pR+oa5q1r3rJ9EJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(55016002)(6916009)(8936002)(7416002)(38070700005)(122000001)(4326008)(64756008)(66446008)(8676002)(66946007)(66476007)(6506007)(33656002)(508600001)(76116006)(316002)(86362001)(54906003)(2906002)(38100700002)(5660300002)(71200400001)(7696005)(186003)(52536014)(66556008)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?90/+I7q8lQBjcU3I3AsYWDgTlWP5HO8+upMhpMI6UmASHvpIVbHgnyMZNsIs?=
 =?us-ascii?Q?yjfUwKi5rBV4HSodYho0Lb/bcqTB94TvUlpsKKCtm/Nl9o6PbNuGZLgiTHFN?=
 =?us-ascii?Q?lVdvBZ00p/pIRhEkcndb5IlbTA3r7O6iyxT3uVJh7jZUlbnsOqEfxpt3WT9q?=
 =?us-ascii?Q?VzA+NSoEBAGpHIviircLj65VkONHYNTIRIHzrerSrnU4QNlTGgFm0x27+Yty?=
 =?us-ascii?Q?l8fh5HB0MG4D5p9ak1RHM+qqztWXfMYNsVUzHrCUzecS6XtWMZGHK2bfEvO+?=
 =?us-ascii?Q?Vyn7Q5Xs7StT7hFuqMATGCwguZzom5LcDUdeIgjhopoxept1DbLjFppBf1gg?=
 =?us-ascii?Q?TtInmEDgo+fIDdXjHGUZF+MrvJupwnNG99igfzPJrCleRcsg2gUzatsHlPh7?=
 =?us-ascii?Q?GjOdhwf8jIC3pK+3Nrnzjd1XLB3ZFxbJL+qzKSyZaTsa15Y1/R7c16B7JelZ?=
 =?us-ascii?Q?98ugkaBm6TcIMlLFxYyyerlpZ42adINM17MgkufzurZIQeKURRr7wQx1PbHy?=
 =?us-ascii?Q?kFSJdgBnmAwHFXGIqBiMIByG71gLtLbrwpEWV7Je+BAto+J2lSSlhJCvR2C2?=
 =?us-ascii?Q?PfDJhnTa8LXsxGg9TXThA0UfUc1zx9ZK69xTtO2qe6kwS3WMILMqsBX/nHeA?=
 =?us-ascii?Q?y53HJDp+4QPdr78UoOqQ5zvdFhdsjx1N+o/Uk9IpOq0MAFMaodIEm68xFgwO?=
 =?us-ascii?Q?CcwZM8+v14S78GuBYAlN3MfUwNVHL7smm1SLnO+HBgdfh6egw25ItkukUfYb?=
 =?us-ascii?Q?LENFmtea6VQBCeafE7VlOcqmuQ8HE0MDJu6l8T123AInawsRag2jqh3Ua+T1?=
 =?us-ascii?Q?5twZjOZXMD5kGddIjxMTJ/3PBD6oHg9qOahiCx1Fa6maKt8jCYR/a97V1h07?=
 =?us-ascii?Q?4MnQDS5zEGUcoDmCV94+hL1JyN18PUWZDYrL5IODGNf/AfZzfh4XR6JFOmMI?=
 =?us-ascii?Q?Nqrw2rXbsQz0SuvZrQDXnx9D20PYxctDoQssoFtpC2lTmHZ9WaFUskotbtP+?=
 =?us-ascii?Q?6xNaWwNF2m61VU/PxAbJ1PilzIR5A90k7LSSf5p9sHKJtaW2Fkq3taqC3KF5?=
 =?us-ascii?Q?Wq+80GksfM2ovY4hzZzQfSfnGCVyP/OxD+muXb7rGeRvqsc22xq1s7OAmDvH?=
 =?us-ascii?Q?9Ri4ByNuiUO+gaATFFAle/vjPmU61IfXWAV+Yl5k1pl70fkFu4CNRVoFreFr?=
 =?us-ascii?Q?H24XtLPavAjzyv+yy0aPGv2aLlTGl5b4QH9+SXCZ86YbnoQgdCyuB2dvRtrs?=
 =?us-ascii?Q?Uphjlo2/YN0Q/G+UtkdG5V9id8gMzmjEU8IYsnisyCK+N6JBjc8s5nMMnWc3?=
 =?us-ascii?Q?QKwahC8M9yxvIEMqHf1oToSf?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c6a88f-44b9-47bd-a6a3-08d97daaa6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 09:23:34.2334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+5oIMEby2Mq6cQpiBvvYkDdcvUV7zQCtCDSObRpY/yfKZHgPlK/aB61dy9A5JnJ8qiiX/s0/RRN5Jsu/m8XfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1460
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
> Sent: Wednesday, September 22, 2021 8:54 AM
> 
> On Tue, Sep 21, 2021 at 11:10:15PM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, September 22, 2021 12:01 AM
> > >
> > > On Sun, Sep 19, 2021 at 02:38:31PM +0800, Liu Yi L wrote:
> > > > With /dev/vfio/devices introduced, now a vfio device driver has three
> > > > options to expose its device to userspace:
> > > >
> > > > a)  only legacy group interface, for devices which haven't been moved
> to
> > > >     iommufd (e.g. platform devices, sw mdev, etc.);
> > > >
> > > > b)  both legacy group interface and new device-centric interface, for
> > > >     devices which supports iommufd but also wants to keep backward
> > > >     compatibility (e.g. pci devices in this RFC);
> > > >
> > > > c)  only new device-centric interface, for new devices which don't carry
> > > >     backward compatibility burden (e.g. hw mdev/subdev with pasid);
> > >
> > > We shouldn't have 'b'? Where does it come from?
> >
> > a vfio-pci device can be opened via the existing group interface. if no b) it
> > means legacy vfio userspace can never use vfio-pci device any more
> > once the latter is moved to iommufd.
> 
> Sorry, I think I ment a, which I guess you will say is SW mdev devices
> 
> But even so, I think the way forward here is to still always expose
> the device /dev/vfio/devices/X and some devices may not allow iommufd
> usage initially.

After another thought this should work. Following your comments in
other places, we'll move the handling of BIND_IOMMUFD to vfio core
which then invoke .bind_iommufd() from the driver. For devices which
don't allow iommufd now, the callback is null thus an error is returned.

This leaves the userspace in a try-and-fail mode. It first opens the device
fd and iommufd, and then try to connect the two together. If failed then
fallback to the legacy group interface.

Then we don't need a) at all. and we can even avoid introducing new
vfio_[un]register_device() at this point. Just leverage existing 
vfio_[un]register_group_dev() to cover b). new helpers can be introduced
later when c) is supported.

> 
> Providing an ioctl to bind to a normal VFIO container or group might
> allow a reasonable fallback in userspace..
> 

I didn't get this point though. An error in binding already allows the
user to fall back to the group path. Why do we need introduce another
ioctl to explicitly bind to container via the nongroup interface? 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
