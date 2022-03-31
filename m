Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F546C433EF
	for <iommu@archiver.kernel.org>; Thu, 31 Mar 2022 05:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5EDB41DBA;
	Thu, 31 Mar 2022 05:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qyn7d05U3gzU; Thu, 31 Mar 2022 05:41:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D287941DB0;
	Thu, 31 Mar 2022 05:41:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BDF0C002C;
	Thu, 31 Mar 2022 05:41:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AC19C0012
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 05:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E638960C0D
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 05:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QeOD9x03vDSh for <iommu@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 05:41:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EEFE60C03
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 05:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648705287; x=1680241287;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/0TLdDJp1ZyMGFPLeKZuC+0lrHDQl5oEG/3aHNgZqVM=;
 b=U0OCwB6i7L7UV+A40fSaINoriDqHvSnIhzHFiJGZG/TWzW0IYlm6xDm+
 T2c93a9rmfIszKd06+YIeq/mcndZQoHe/hJlOALYLi4Cd58Vmj5HMRXBJ
 EawQPPgaHeXrRZgUorzKXNKI4LLSvXa8uSw583TU2ojAHC52Ip1G+Y/eK
 2/tBsBbqAddAQUdV21dwcq7IsZBDNZXGVty6DmOA2nEvm2rJqHp5aJW8a
 ErA9hcRgE9BICmo+bQwgfoqQa+15K8jIVlPWXISXiHa4FTXEnf7BX5XWu
 yr+muLq9n4W9h6U1E2RhewJEb755ZmJvm0eM+HnB0MsbNkHGE5UEOGRfV Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259908900"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; d="scan'208";a="259908900"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 22:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; d="scan'208";a="566160488"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by orsmga008.jf.intel.com with ESMTP; 30 Mar 2022 22:41:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 22:41:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 22:41:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 30 Mar 2022 22:41:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJn1hQDgVXORy14wUaULFWVNLv89T4Z5XFA6Ge7HuhLnqpins0+BpTdLLHzArSMGp8t3d46wjjNNhKWn+3TK8JWdt/+3smaN4SabuZ0HavSsTmFEfXux59kyXK/iYMLugLrKQlXbcmi03OmMSfSYSqDw57cOFCKEImstww2tjtQDU5YpyWyFuIPVzZVeKEgDIPuEaC8U7VD/sQlGRrWe0p81NmURepV9KqqPdvEJuEm7x1sg2M/bqXpW2ZBc+Xb4YauMtSNbx7F4nmxdB7UvOlQkk+zNHQ5GNHB+yDS21pRI8x965YIXgVLcd/i8EttihaOFbNwCyUGwWc6G6m9kUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=807Iz4ciVubdrNm9ryVFz47xWUJ3AtFepJjoj2x3xUU=;
 b=msxmskWDdLFNxaJk+sG1kBD/cLA+G/oYeheG3Zh44DR8r649jAAOeidesph/2j9LBIGF9jn/ik07s97USsrqqNF+kN43RuQw2XrUHWQfuBDw5x6qeqOjpXhRwOxkKaSEkepzJhyvlbDaN/G9hACqXMj1vTscHh1gEq2CrwWHFYGt5SGZWJCwiynBzvZlf/CB2O0ZJv8/FqzxXFf35dgmm3ZWSSc5RWjqjE4I55L03HCsJw1kZJLIl/xtYpQuPQ5GWh2yX+Mx1LDdiAIJ9rOPjsBoiBk9S9Xg9xb3H3Nqoicl4K4OII78q25hQWzf0c4yLPRSHCsuryJVaB5GRx3LqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN8PR11MB3827.namprd11.prod.outlook.com (2603:10b6:408:90::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 05:41:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 05:41:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: RE: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Thread-Topic: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Thread-Index: AQHYOu2GUDY5OA7cJEqND2xJuT5HJqzY++yAgAAPfuA=
Date: Thu, 31 Mar 2022 05:41:23 +0000
Message-ID: <BN9PR11MB52761227DFAC6E3D322BEDF98CE19@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com> <YkUvzfHM00FEAemt@yekko>
In-Reply-To: <YkUvzfHM00FEAemt@yekko>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a15c835f-3b48-4cab-3bcd-08da12d9172b
x-ms-traffictypediagnostic: BN8PR11MB3827:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB3827B2664FDC6BFAD8A315528CE19@BN8PR11MB3827.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICQmcZoJAGbXdTIPsri+HL8VtDk4hFKK3uNffGRZ0hji9aO+8aBjAMYfkZTioACYJ9ajM149VVVexr6Wpcv+LIjKo/9wv60FaX2Q8Fj3vRkSXdsRmnGsIXQc4o9raVPkDajqwbJNuIcKnNXlLuSzTUTNGIZnP1ofvmYh9Nnm40MAflRo0/DwyYzAEj+t3ASNNtz6TH4ZEXMCOkthRoaFjZAKbVmPFCrRKcm/erg+GNESHcs2volvF1KK98Havl6mFO5BCkOTXFD3Oz+wubNn3vmSivJHvT/DfEx+V7CdhutXoo4LLLdjw45VmmswIVV6YLxophQ5fqpFgdH2825ab3fUgyioIMPwUE74eBVyfkSNYkgH2Xf7ymm3gxGP8T/JGumi7Sfas53R4nzPVgelv7JaFQ9e5EgCI3D1DEwk2xrmKsFbgODQ+5wm3oLsYME+L7T1dm2EhGSDteT87jjmFp/UEfjeCe96U+Hhi6RQ7ji6rZrZ5v5TWGkOOoRgJgjKxtN5gK6Lo0yc9W433ZhV13+hGLcaHMLxgVyDi1umiH93vhAUtiPClGhWlOOYD7M8FBYpKn9L4xuJlSXsRAMSpk3EoTi6V0SkKWWWJTCw9uU2Fnr4W8kOM/pNZB/b4FkzIVy8XKNNhJvEFsFBe48YcXdxzITMz7B6RFT68DMtXbDXp+aM0Qm7BL2BBTiSb/TpDX7DFm7paC5C+Nf5+UwAcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(33656002)(64756008)(316002)(4326008)(110136005)(54906003)(71200400001)(86362001)(8676002)(66476007)(66946007)(66556008)(66446008)(76116006)(83380400001)(5660300002)(8936002)(7696005)(9686003)(38070700005)(52536014)(26005)(186003)(82960400001)(7416002)(55016003)(38100700002)(508600001)(122000001)(2906002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6HUwYjYToOieGaCJjGMpl/QyMLtvyW1vGAh23Z29wL1TibjQzKvfLcOzG2r/?=
 =?us-ascii?Q?8/cRi1VVwxjYFUNzEQJol3ZJMyCyskRgS9xTRebzHQIHdbWBMNsh5chcynjk?=
 =?us-ascii?Q?xtR1eUFkl8WSd9TRi+HNf2jVtVoEKFvP/SGESfWa0li9JsEd1VyTIAMOkH4Y?=
 =?us-ascii?Q?tXnsIWQIJVwSEQiGHpZnkwO8dYmzBIUO/kzYT+21uHAcnBd2lFXQqhnmtXvA?=
 =?us-ascii?Q?6cpwMCBD6g9tZR+5NDqCXO8RgFr9U5vDexIWLZ6GQ1Fq8vwdqPJcauDiZNQ1?=
 =?us-ascii?Q?si7voQFokv+g41YqL6h+5iZj/3/0fLU7U95P4urRFRoF+eQhbB5dzo4Q3sSz?=
 =?us-ascii?Q?MD4lrKlhcDE7cy5nDWMJkC4aJTujVcb86MB8vPTDCQ3KT/NOpd5J4qGMa7VO?=
 =?us-ascii?Q?ihdpCmpTsiFIf8jvl5QbGVRq3m1BZAngFU9DKeOUJxXG6LZeBFumKechM8T0?=
 =?us-ascii?Q?RWGuDe2fEwh73tkCK1XR5qnU4DAbpMorXojVnt2gl7FjsgMchoUugfcfgILP?=
 =?us-ascii?Q?LQ1GyQE9cHM1iwPgCW2V8tyjE0ZZl519f0IP5kPVOIMluPddaf0Ymt8lfTLq?=
 =?us-ascii?Q?SoOIHafxoRlZLJ6psg/KgJiWYZ2/QP+IIGLeYb0Cs2HYFN/L7kajgziMURKm?=
 =?us-ascii?Q?4HXK7tqflVz1tKeLIla5dvzxpcHh3MYLd0rkWQkVgeaavvSQfS18IB4Eb7QP?=
 =?us-ascii?Q?yxcIJwAgI1tgBPNDMDtolsKS2EC7r2H1oUI2UIvcdhSABvyzEdCnkPfX/H/h?=
 =?us-ascii?Q?w1srrLW9Tt2HpGoKFeaC2nHOXqYcsAsKs8fStGUg/ZRF+OhqLwcbodwxcUZG?=
 =?us-ascii?Q?PUTMnQKiU7aEP3fBxpxFd55A6/ANjSaXnYWZ0Ahya/zQYeN9aEWMU0ukd3fn?=
 =?us-ascii?Q?h/yx7DnJkaa2QrD/a+OLRzyS8/OBSkpEBAuRJbD1+RdD6ZL4emLACIYXqoq2?=
 =?us-ascii?Q?jCRka/wgs8W87rgivZZTC+YdTLYewWEfWPf1j49SBkMZ8rcelitkVcWOP3HN?=
 =?us-ascii?Q?olyPNTvnJ5h4m1UWBLcMR/coFS/wAgGJwIqyqHXYvemEvodrlp5H9w44M1er?=
 =?us-ascii?Q?b+EFQ+muX3v5yqxfNUTc5dQDBtNI44u5MbYBDGT0tjz964Ot8Yw3p6xQHdnu?=
 =?us-ascii?Q?LeBxGpWdavjp2xlt8gLFqWCFyPOm9SF+ZdNwuoeyw/MtS3qEoI94NHQp81MM?=
 =?us-ascii?Q?KzlZuVtKpXUYg1bbrzuDMISpA8QgcHTNuNLw5CFhuOg3NF0gRL7T4eZomXN3?=
 =?us-ascii?Q?rvobWIFlqF4dhkPERuXv+TzX9RO/hfwgOKQ3Nf4tmfQR7PMY5vI783a+ANaV?=
 =?us-ascii?Q?fB2smepSK9wErWVPGsbJOmxe2/Hsqw/yKKjD3eYCDe1u1F2WudNFEKFMNNIX?=
 =?us-ascii?Q?YLskLEx82hAOnEQER+GD6tGkCa4it8YovFwmWSdY9bZtTn+pq6wHmt+FzjC6?=
 =?us-ascii?Q?gWQt37Pcc5YQ0l5TOiCfiGq9A1c9nX9CmM4/WhKIXRDVsd9JZpl4VG16ym4O?=
 =?us-ascii?Q?MIoITAhSrYOjwqiQdrdEzpktJw/LvExY40yJdBYTutQlOjsJ4ei7WUeTzMbG?=
 =?us-ascii?Q?QQrxmYoHVlAs+8RplLAtFlIJGSdIKnXiPX2R/qfthUaSDxQbEKqQSiIP73+G?=
 =?us-ascii?Q?rTOt4bSCL9cZCA1iHxf5nEjK0ZTLhFpBOGZ+MLy0o7muxNKpwn9UxuZnKwc7?=
 =?us-ascii?Q?2K6OeZxtEk9C0/oHbKD5bi2aYeZC3CP4eLQlDh/cfDazgxmBvqT5h7LCkw/m?=
 =?us-ascii?Q?2KzkuSVGuA=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15c835f-3b48-4cab-3bcd-08da12d9172b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 05:41:23.1634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfx5ts7Am7e/w4C+5ooEb8KuFXD26+gfQPYmNkNKLN6S1oUuEGhPQdWBElUEPPEeB0A2mqrBer2Ymmog68FArw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3827
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>
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
> Sent: Thursday, March 31, 2022 12:36 PM
> > +
> > +/**
> > + * struct iommu_ioas_iova_ranges - ioctl(IOMMU_IOAS_IOVA_RANGES)
> > + * @size: sizeof(struct iommu_ioas_iova_ranges)
> > + * @ioas_id: IOAS ID to read ranges from
> > + * @out_num_iovas: Output total number of ranges in the IOAS
> > + * @__reserved: Must be 0
> > + * @out_valid_iovas: Array of valid IOVA ranges. The array length is the
> smaller
> > + *                   of out_num_iovas or the length implied by size.
> > + * @out_valid_iovas.start: First IOVA in the allowed range
> > + * @out_valid_iovas.last: Inclusive last IOVA in the allowed range
> > + *
> > + * Query an IOAS for ranges of allowed IOVAs. Operation outside these
> ranges is
> > + * not allowed. out_num_iovas will be set to the total number of iovas
> > + * and the out_valid_iovas[] will be filled in as space permits.
> > + * size should include the allocated flex array.
> > + */
> > +struct iommu_ioas_iova_ranges {
> > +	__u32 size;
> > +	__u32 ioas_id;
> > +	__u32 out_num_iovas;
> > +	__u32 __reserved;
> > +	struct iommu_valid_iovas {
> > +		__aligned_u64 start;
> > +		__aligned_u64 last;
> > +	} out_valid_iovas[];
> > +};
> > +#define IOMMU_IOAS_IOVA_RANGES _IO(IOMMUFD_TYPE,
> IOMMUFD_CMD_IOAS_IOVA_RANGES)
> 
> Is the information returned by this valid for the lifeime of the IOAS,
> or can it change?  If it can change, what events can change it?
> 

It can change when a new device is attached to an ioas.

You can look at iopt_table_enforce_group_resv_regions() in patch7
which is called by iommufd_device_attach() in patch10. That function
will first check whether new reserved ranges from the attached device
have been used and if no conflict then add them to the list of reserved
ranges of this ioas.

Userspace can call this ioctl to retrieve updated IOVA range info after
attaching a device.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
