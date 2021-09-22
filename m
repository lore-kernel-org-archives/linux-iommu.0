Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB67C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 23:49:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8AC61038
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 23:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA8AC61038
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E14E605BE;
	Wed, 22 Sep 2021 23:49:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UbDWMdKBPriA; Wed, 22 Sep 2021 23:49:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4A3C2600C5;
	Wed, 22 Sep 2021 23:49:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F29CC000F;
	Wed, 22 Sep 2021 23:49:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68E56C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 23:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55DFF403F1
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 23:49:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rDLZbVGPK3SF for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 23:49:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 240E140138
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 23:49:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="223373308"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; d="scan'208";a="223373308"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 16:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; d="scan'208";a="613732644"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2021 16:49:22 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 16:49:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 16:49:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 16:49:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 16:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbhwXKOkxG33QCDkbwtRF7+8oMGpuanK6FvdLopMFZky61SVwmsVm+/nv+SIr1sg+1votGzAbPN+6PUrLmGXw/G6bwa2dMgcvAmtzFOFZYSAovDnB+DYINA89g4JblfmPNZX7nRZG/AA/7nhaMJv73IpD0o9k1mTmnxbh6XYHnLPOuV4ODwXjKxtaN+dQ8zOjDG26Hps7brjD9ODuzftt8a2yWn3KvVqAH3ftn74EMdpHzJop0dvxbm8eQ6PyRxt6Et+p4OYxyOXzVNXftX+vONcmmxg45SEUkHCsmhoiEZUiNmAljj598VXjIwFgBXdUlxsAoonUZO7E0+KZLa62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=TH7JcUQsQoNLmOba5BBs/WL71Q4X77ZOsEJQWoWxp5I=;
 b=GsHrqH5A/hQUHxKsdzchsAKNGgpGxcQxu7oMThAyBuqJAwD/Bctq3hkNnIV+/0vDnqD9Sciy9IltfNECLeSeFy16rlvDTCqYkh57Vn8jCxjihHSnKWwEkNNO384CeACHCO5zOfo4BAd0Azf63qsQip9L2LpZtDVOEZCl+l3GIgUv0i8n7clpbj2nxQox6FmPJmAx42NRAr7IzhO/L8z57JmTqFU1Kof14TMDC9ugpgNkHujCZufYw9LKuzwRXp1cDTKbH2kDXuaQhW2ybzGjdm/mF5u+6i0RwbeNC0PhkeZzcYegoHJVlkErlpEWzgTLLhKSP5DhBPRAu8L35L7WmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH7JcUQsQoNLmOba5BBs/WL71Q4X77ZOsEJQWoWxp5I=;
 b=oardsoebnUTtlRjVKh6ZuZcZ7muQC7uqNqgH3gpzOXK69uqhUK8Dv1VHK8K4iEfZoz4jVHt0SBtPACwYXlGB6xZpCS2gbYHRUjtWEMeYz+dEdhySgb23ExszdeZ5N9qCSoWF4L6Rl/NxyhpS5azhJEZRRuwbjTTaHHS9ggGPeIU=
Received: from BL1PR11MB5429.namprd11.prod.outlook.com (2603:10b6:208:30b::13)
 by BL0PR11MB2931.namprd11.prod.outlook.com (2603:10b6:208:7d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 23:49:16 +0000
Received: from BL1PR11MB5429.namprd11.prod.outlook.com
 ([fe80::8160:3227:5fe4:c494]) by BL1PR11MB5429.namprd11.prod.outlook.com
 ([fe80::8160:3227:5fe4:c494%3]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 23:49:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC 05/20] vfio/pci: Register device to /dev/vfio/devices
Thread-Topic: [RFC 05/20] vfio/pci: Register device to /dev/vfio/devices
Thread-Index: AQHXrSF8PdwE3l0WRkaTif5FzzsyqKuutGGAgABLSoCAAENA4IABUT0AgAApt5A=
Date: Wed, 22 Sep 2021 23:49:16 +0000
Message-ID: <BL1PR11MB5429DCBBC0ECB7B8958D2E658CA29@BL1PR11MB5429.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-6-yi.l.liu@intel.com>
 <20210921164001.GR327412@nvidia.com>
 <20210921150929.5977702c.alex.williamson@redhat.com>
 <BN9PR11MB5433D909662D484EFE9C82E28CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922151712.20162912.alex.williamson@redhat.com>
In-Reply-To: <20210922151712.20162912.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd4c3460-3c68-4476-f371-08d97e2396a2
x-ms-traffictypediagnostic: BL0PR11MB2931:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB2931CE092A8FFCBFDF8924F88CA29@BL0PR11MB2931.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MWaUMBNLE+zKjeq1CLcyU9tBN+bw9fzanbOIwTB+Gzvzw+cIrUPJPVIGvAjwZ45ik379tL/DvOFgQLpHQC8jQHHGfSF3WHRMP95OKYbZREd/VoKmuYf64cyASD8J9dWgfZD+VHKg1VNouu1uTc0lK4PZYvaeReqN2w3IM+5ZcPN/bgCw7cDzHvQrU9glCvTqE+bFGJ8cI9UlDFaUSM+bK80NV54Qz9j7df5h2VAMEXN28kJs/MswuAFBcNGQrEb+BG7M1R/+L7MLdtFVRG63gFeYrP7oWysdmGkFVcV4gVt0fp5IHNm1Uncdu8cZgrxcFi4ZQos4Q7gnWoKrQ6KpDY+JFJmRn8mogTNHmfzxsLo67LS1h5rWTZ/wldvova5bo8Cka7p7H2fxI8RSbokr0/+AGADhdMqaLavrecve96WU7NOKkN+JGkQ6ukFCZZ+KJCyvmffjoLk9LPtU4hN4MWYyfEL8Dgd+IAZMiktWXorNV1gLmXJdNPiFj2cVpcgFhz/YhuHaINTIOMFS6Ghb8aAlWARDoRWM6x335FAOx2wPBtfdn5N/IBIdnrzRZ5aYkjnWQ+LEXQSxAq2yi9fYF9puhGaSCpiF6EZTJUg3w8QQ27LjCRlrbpoAbxRUJdZw/EknCpo5vFU5VxMS9tZuSyqsHE9BAB4eSRXFvohui5CqkV0DtKF302ESZhnsKIO5GbUMDx4F9dyJKoCipdcT/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5429.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(38070700005)(52536014)(186003)(8936002)(4326008)(83380400001)(8676002)(54906003)(6506007)(6916009)(64756008)(508600001)(66946007)(66476007)(66446008)(66556008)(38100700002)(33656002)(316002)(5660300002)(122000001)(26005)(71200400001)(9686003)(7696005)(86362001)(55016002)(7416002)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d+KKbUUo/m0h2DZxGktSocCbRaDBe3oHobyHqjSOhHACl+lfzZ8NZ+fuYpoJ?=
 =?us-ascii?Q?MO4i91ikcdRSxdPUkawPwYmk0mT8EHO2j/SpS6NyOM6qnoqpIwj3ZMk2/6D7?=
 =?us-ascii?Q?X6aJXPUM6YZQ8Yd3e6Qfltj6ATcY9YH3lZ7DQuWg3EIWYU8Fwi+sxaUL7+op?=
 =?us-ascii?Q?YcSd8smd3KDGVPz8GF9BejA7yfRqUxyRXrWIjfwx5LRehqu1D+C0OE50j/P1?=
 =?us-ascii?Q?drsANLJSxs5BOZY3x7IVzue0tClxGmoa24cBdmeAfSKMvc/Ur6DmZ3aP95cQ?=
 =?us-ascii?Q?SQAzAZ/v5iMrlhazjhmdcCBPGyiAMb2e2NEeiwRB5wZmvwrz4TRrcsrEI86h?=
 =?us-ascii?Q?+HKz8hYqRsSlYj2eBKA8EIlLGIfWQX17kG6PuC9Cu1FHZ3anY3tXnCeCqwGT?=
 =?us-ascii?Q?VuzCaB0qI2u7zZOMtNnaiaVaaEZJq1Ikr7z6OVsIbhfF//UqrwOY85gR7O6o?=
 =?us-ascii?Q?tG4QXegrpIhT69Zcb2umyys454GJvdWty2aMW4DEm0nkzNUcy8EC/tJHhgEt?=
 =?us-ascii?Q?HnnRE78HS0AN+y7Zc49M21N3ofbyiJy7mEwkDv9zA6OfMH8VI+enlB+Tu7ee?=
 =?us-ascii?Q?leNbbYoHgRpUMddsWRXnQv00HqrZFsW8rGelb+7YsQO+YZ8HPEd5M65xwLgj?=
 =?us-ascii?Q?c2+e1t6YoyxhG6kwrKSI9SU6QAW/YQMo04QIyMIFaNGaikGZtJLCQDknkxd8?=
 =?us-ascii?Q?T4u7Emgi7xA9zSwGWEd2dps9yg6lf/LwI0z+VJspjaw7bzyMmAuhhnSvud/A?=
 =?us-ascii?Q?o7UfGUSjCFNFw9rtmKx+koKee1RRXNEha9DjyS2t7X6TtR1kBeeGfkoQvJxU?=
 =?us-ascii?Q?oJL1Ddd6CJKlCQEPbzyRnwaP4hkBHw5X45lPZeOT0wUdaZ9vrZfK4u1rksc2?=
 =?us-ascii?Q?UYmaplAwlUqCpm0rwROcYkY+L27FJU18CO9+pDLlWd9NM4bxS3w26hPzA+DP?=
 =?us-ascii?Q?dw6u6FDR0WzHgs0BiwjFfl0JiKLugcsXvEMd0a2V1RiWKl77b2ZQVeI3xSjM?=
 =?us-ascii?Q?84uf+sGsFoyjI0bXzx371jIfBvEupRkPYhK5YH0a2rBj+5dNshx5h8eTK1rw?=
 =?us-ascii?Q?oV58diur1Lk1DXkw88xW66USwd45RW1MuEatmimHm8+vq8xoyGuFWxnzR7Vo?=
 =?us-ascii?Q?Pw7pK+twk4WboWFtaHeM9OJmqFCWcngts6ya1njg3c7CyQMvc3yAv08rANKb?=
 =?us-ascii?Q?UOURd2sjDk7fCtKOt1Ec57lIjUahsnfvFvl8ZQAFRNs2DRhUV/W/pqd/oWkt?=
 =?us-ascii?Q?zHFsfDfP7r0CXBk6P77PDyOJsJIWV5/uvWnT2uPxFjHUNiz83vvvD6YJFwVD?=
 =?us-ascii?Q?X3nYCUo3uJ4SUwK2Jot98OGA?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4c3460-3c68-4476-f371-08d97e2396a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 23:49:16.2995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dp27FtNkiqsEbXadr84nZfDG0oyk/+B8PO0aK+7YN2JgSM9cjaa2LMOvTARCfNHtAcT/AqTCzIFO3Xg3caRu6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2931
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "lkml@metux.net" <lkml@metux.net>,
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Thursday, September 23, 2021 5:17 AM
> 
> On Wed, 22 Sep 2021 01:19:08 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Wednesday, September 22, 2021 5:09 AM
> > >
> > > On Tue, 21 Sep 2021 13:40:01 -0300
> > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > > On Sun, Sep 19, 2021 at 02:38:33PM +0800, Liu Yi L wrote:
> > > > > This patch exposes the device-centric interface for vfio-pci devices. To
> > > > > be compatiable with existing users, vfio-pci exposes both legacy group
> > > > > interface and device-centric interface.
> > > > >
> > > > > As explained in last patch, this change doesn't apply to devices which
> > > > > cannot be forced to snoop cache by their upstream iommu. Such
> devices
> > > > > are still expected to be opened via the legacy group interface.
> > >
> > > This doesn't make much sense to me.  The previous patch indicates
> > > there's work to be done in updating the kvm-vfio contract to understand
> > > DMA coherency, so you're trying to limit use cases to those where the
> > > IOMMU enforces coherency, but there's QEMU work to be done to
> support
> > > the iommufd uAPI at all.  Isn't part of that work to understand how KVM
> > > will be told about non-coherent devices rather than "meh, skip it in the
> > > kernel"?  Also let's not forget that vfio is not only for KVM.
> >
> > The policy here is that VFIO will not expose such devices (no enforce-snoop)
> > in the new device hierarchy at all. In this case QEMU will fall back to the
> > group interface automatically and then rely on the existing contract to
> connect
> > vfio and QEMU. It doesn't need to care about the whatever new contract
> > until such devices are exposed in the new interface.
> >
> > yes, vfio is not only for KVM. But here it's more a task split based on staging
> > consideration. imo it's not necessary to further split task into supporting
> > non-snoop device for userspace driver and then for kvm.
> 
> Patch 10 introduces an iommufd interface for QEMU to learn whether the
> IOMMU enforces DMA coherency, at that point QEMU could revert to the
> legacy interface, or register the iommufd with KVM, or otherwise
> establish non-coherent DMA with KVM as necessary.  We're adding cruft
> to the kernel here to enforce an unnecessary limitation.
> 
> If there are reasons the kernel can't support the device interface,
> that's a valid reason not to present the interface, but this seems like
> picking a specific gap that userspace is already able to detect from
> this series at the expense of other use cases.  Thanks,
> 

I see your point now. Yes I agree that the kernel cruft is unnecessary
limitation here. The user should rely on the device/iommufd capability
to decide whether non-coherent DMA should go through legacy or
new interface.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
