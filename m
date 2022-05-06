Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B6CC433FE
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 10:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AD81416B5;
	Fri,  6 May 2022 10:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id odhw1oBIhZM4; Fri,  6 May 2022 10:42:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AEC27415F5;
	Fri,  6 May 2022 10:42:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CFC3C0032;
	Fri,  6 May 2022 10:42:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBF07C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 10:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A453C4026A
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 10:42:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pA_6syxB2b49 for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 10:42:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56C9040025
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 10:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651833752; x=1683369752;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5ai2cPclVhWwzJ8KE+JdneVb0I12NxRc16n/qnVM+To=;
 b=L3rPhLh0n+6PwVvAcHcw2Ne9wLKjDtV2PezLQdIMW72H36sCRSCprGm+
 lrjoIM+JhgsupRmOAMLnMwjuMQHGKxwrmwsOIOP2Rntcsw9IdApyTR9JB
 kItPC6Z3IWtMFSlMt8X1hNMxX1fCZivaBMh0Srnwa6jE5jNFlmETLJAos
 KnyO6t+/5w2D8qQrRTwUCREjLu3OAAVz8wojBFra9q6YZLh2zn4n3VTLk
 aPR/EDNK1HWXC8hwtovlJgUut8t7mFNT+DXVVfch84jlPExGCFvGDbTP5
 r/cHdwFwMu866gSlDYs/nzyOKOEFQOB5M7qJQSisG5QWJc2XhaxwU2mYP g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266024199"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="266024199"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 03:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="695122589"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga004.jf.intel.com with ESMTP; 06 May 2022 03:42:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 03:42:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 03:42:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 6 May 2022 03:42:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 6 May 2022 03:42:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCI1EcrYIc9XPclt3urE+GXQ7BB4mbWxW7DFTZnxPlZiN+YLtG5byMNUDxZeIfOFdoJk/Kfk9kasNOwrk5JHB0o7vY1eKXIM82KF9ZLGdo18tiXV60ECF5MKf780lzhlq4d1MFw8m82+RGExMWE9orolKfxPg8HyT0P28gz1zN3ritzOFopkODvgwOLBOb98t2wYHnabjlePVaRZe8/M5ieJSm3zKMXo5Rf1avGZWeJkg9FM57WnqOXMmnNaI1n4+8Amra56ydOJZcmT6IA39Bsb7UvXbCTSSmPsdiMz8loWPtHVYSyqogmVT9S8YOyI6dP47Kbb9VSZZSoxUg0q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR/KYDjB0CUDdOHEV/R95UYHnAdwddf+0HadNAkPmvo=;
 b=IFPIsTLBkPXf7qqve2hCMEYhirjDBF5NtYSA08Uzi7yvrq1CFzLEfj0simCAsxRI98EE7OOYt4bNPVMrXmjCwhzit2qyJtJyHOvhql0RfW3z30Oayu2YgY7xjVXVaKAhPJZ5PjLnQN6xcULNSTmifYtIaRexcQ2N9C1lfEOkmObS1RFsHIW2ehHxxw3MEt3bsB37TikaheGrC2tA00CX2odEfZQ5F3a55CElsSRFUAvVEhgsMqA3FPvK9dvHWLakUr6ETZp876YVDCeTctGyvsX1TS3+n4jsddpeQGX4q1XtwW/40YnNMw9j5BN4IIh5gf9G/l5oqzKrHhZ7r7V6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB2017.namprd11.prod.outlook.com (2603:10b6:404:46::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 10:42:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 10:42:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>, Jason Gunthorpe
 <jgg@nvidia.com>
Subject: RE: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Thread-Topic: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Thread-Index: AQHYOu2EhhTTZTsn5EqajxaIjlC6M6zNmzGAgAAclACAAWiFgIA2iT0AgAAE2ICAAP5AAIAAbGoAgARd/oCABXnXAIAArI2AgABQHYA=
Date: Fri, 6 May 2022 10:42:21 +0000
Message-ID: <BN9PR11MB5276CACD8AB1EB092A333CC78CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323165125.5efd5976.alex.williamson@redhat.com>
 <20220324003342.GV11336@nvidia.com>
 <20220324160403.42131028.alex.williamson@redhat.com> <YmqqXHsCTxVb2/Oa@yekko>
 <20220428151037.GK8364@nvidia.com> <YmuDtPMksOj7NOEh@yekko>
 <20220429124838.GW8364@nvidia.com> <Ym+IfTvdD2zS6j4G@yekko>
 <20220505190728.GV49344@nvidia.com> <YnSxL5KxwJvQzd2Q@yekko>
In-Reply-To: <YnSxL5KxwJvQzd2Q@yekko>
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
x-ms-office365-filtering-correlation-id: c1092858-eb5a-44e7-5f2a-08da2f4d19c5
x-ms-traffictypediagnostic: BN6PR11MB2017:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB2017431C9244D9D7704148AB8CC59@BN6PR11MB2017.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3l8iu8e3Aznivel/yeWmMjuipzNtrKsxKeESxTpBO9F2Xu9RY7aHDQIknSCX+yAxjHN/yZpNxWcm5moQB4aj8FzRKCOnCFKFbEwRRbA2/QM/t5iskXrR+1vuM6R/XSVnDBJAzmnyyTP9lousnup1cI5j7QSxZnb15dsegWiZrOGqKcDqxhGmSVaPcD1b2syAx17uI25uE5r1Zgjm7JPNDGp+JjvJtYQVuF/qg2fCncBnjWjSMktUPya2ntIpuBh0Aphb/V72IRWdyqIv0AzovtiJbYs4T3WFyLz7yTLcgQIANFXNmrudJrqLJrrQU3mqBNlj6WDOWdn2rq+voVGZxEcpAHHoci1PdTnPxnImI0ptIMOpuQZ3azxEw+5TGa/cMe7XRLI1JnYnZSemt14jexJOBmFC4nVR0MHRFU4uKwlycIEku7H3N+DdjvRfSqjWxVHv0lVC1PzofzBMtO/MitLBEVt5gmDwiccFwikzQeiBxDKP1ec50Vk/w9fgV1qLT2KruNJumhnBlh3sSeFVdYjBtckGUZqBhWXm4308UbRw8oLa+T/bzbXBNaPrkqHzNoZdGrfbBJu09hE1JtKoHEon5X9ZC/ndaWNK6iSqVHz5OFUITG7JVHNltO4cDbTCZ6ll4IvafR4lgS4zR+VqT3Op+Qlu88mIOmu4V4Dm7IPXeO4hF6k9GMWtlLM5y2qhkV2tlu+rCO5ZcmwDqrnx+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8936002)(7416002)(52536014)(38070700005)(38100700002)(122000001)(76116006)(186003)(71200400001)(82960400001)(2906002)(4326008)(54906003)(66446008)(316002)(9686003)(110136005)(508600001)(26005)(66476007)(7696005)(55016003)(33656002)(5660300002)(83380400001)(8676002)(86362001)(6506007)(66946007)(66556008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RTN9VKyU5ZS8CXAbSQfVGDonZvE4hZpntL5ZORC2PAXkFS8iHarer399wyPi?=
 =?us-ascii?Q?aH7F2XGcEcGm3g861xi18VqyL92Z/OCMGj9OfnrEFzeDb+m/6pZYEBAjFgwk?=
 =?us-ascii?Q?N82D8rqgsOCs9wNR33oLtlOAtFUdkW0Yf6laH8V2sbBIcqoSG5/wRGdWLG/j?=
 =?us-ascii?Q?CeHedtLZeKscK2WkmBoovqevaI6nbI0PZxwfAw9FxNcad9GwZwWMWE8W+9fg?=
 =?us-ascii?Q?+aR2METITO3qQBrDvvvQOKmcTXVswWJdEtZk9CFg42LZbVxczqjogHkYMxbT?=
 =?us-ascii?Q?XRPuqW1fNObLfJbG3flwojyCc8UDVoR/hRXHIph1FdGda3eq6tOXvcb76Tp3?=
 =?us-ascii?Q?u872BBWK6nxEn7Xplfzjywzi+sMIGbcRufj10rwSi58+/OQaH252/NVjuagD?=
 =?us-ascii?Q?dWhQoKCYC3OvTcIBw2zKTysR6cOG7gmpepYam9SVuD6IDHYUppx1d5zObGGg?=
 =?us-ascii?Q?2+NNdx+utDUTcAaSKJEw1shK/vmOeC8rHivkKjxM6h525RddEjFVthgguxsr?=
 =?us-ascii?Q?/Qf46NPI5vwtOPB0pb2nglzlIZ5VnqTsG8dztTRsQCdG7YJJM5mIv9i5G1fg?=
 =?us-ascii?Q?MTAFWa6LQqpHob2LnjBBGQn0wJQcFmElG6cdYTFAtP5Mtg4IJ2sDKVsqWZfa?=
 =?us-ascii?Q?DasgL5obBqh94+D8/etI1+RUFFFSYjVUSPv2mVwM0Rl3nfhUmJ/eZcopkw7P?=
 =?us-ascii?Q?Jeiv2z2Io2zoBc2ITV+H1RrHtuQn6kMngJkAKbiZKfV8h5hTbvQj+oJpi6+n?=
 =?us-ascii?Q?hlHMeNguGsiaE57LcAa0mmss2gTh4xUrfyC1uKln4ms/9/yJP8/xyCxGl/nE?=
 =?us-ascii?Q?MoZLg0kZU0gHsrHDgULMTcRiJK+JZOiLWdD0tlYgfnwXfS83rJHRn5mkz/KD?=
 =?us-ascii?Q?k48wDmrq2jdSqQiE0NXjapJPb9sBDs359zk6Aol9PVHJXoFO84oKeLRA76Za?=
 =?us-ascii?Q?HXbVtblTheF4whgASReqcIWzLyXZqww4MQJ9aGIep3r01DnzL1lK1mZ8qExo?=
 =?us-ascii?Q?5WGKIyY5bB5dEq3gVY0Mc4kEEk9UWNWLwZl8J/rhSf4SkHrxmk2n4dxXqrY/?=
 =?us-ascii?Q?Z9ajpp8od8ea8o23UoU3zhFbqQybzfvIEy50+Ca99xsR0ZHqUgeiXYnLm8Y/?=
 =?us-ascii?Q?nrAuoPaFy6olSq2a4jL829qhC4XoF45TRXYiTDILoafYlDXTMYnqbJPyh1DH?=
 =?us-ascii?Q?h2yQlm5HDnTK218ryecdyE+RthVdqKv2d95OYk5g8lWk0pUcpVMcWyI4QUQU?=
 =?us-ascii?Q?b9LEDP2SoayMJMRXhJw0HAoit3T3r2PSa+hahCku7RNvGkYg759OFz0LFqmy?=
 =?us-ascii?Q?s8wc84A8h6nHtijXLJr/31w38+bGwB9Cp/m6xBySOQ6NDameYol0b/sOkYpm?=
 =?us-ascii?Q?puordOme3KssstvDkok+NK1w8HKaV/lzz5Or7yEkfkgbmhoovvNc1bGDYPmx?=
 =?us-ascii?Q?Y8Vw/jBVNWWEHJc+FV6mfqNJy7yhUJt+7dHYZFUwhgxOgrKuiWWAyS7Dl85+?=
 =?us-ascii?Q?1WwWsu9PWqGX9PjwSiKGwtz8+/cDec57Runb7vW7WOqc7ZHES475ubbnAG4a?=
 =?us-ascii?Q?rCyNZgHgGtLMSBFvushZofm+NsOnONTIjlvVtXtGC2nsMFKPSLB46rqW/KT6?=
 =?us-ascii?Q?uNIzg5RzSuAtyP7ym85zgTpQE+BMSnlR7RqYhW6RpZDCgHImXw4vTSFwbZqG?=
 =?us-ascii?Q?UYyKuyJ8QhYmxj8dTAWWaoufcxyTJVZaAI50Z0UEfPQ7MB8QSep3oneRQQOU?=
 =?us-ascii?Q?kJtbczsmYg=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1092858-eb5a-44e7-5f2a-08da2f4d19c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 10:42:21.6918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v78GKNZmga3f+W0uq/834jXjSV4wvdrPQBVrfi/DJdg//Pyiu7Zsp3oNc7G6vwpccSsF4zz0rgtLoJyFxS1nzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2017
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
> Sent: Friday, May 6, 2022 1:25 PM
> 
> >
> > When the iommu_domain is created I want to have a
> > iommu-driver-specific struct, so PPC can customize its iommu_domain
> > however it likes.
> 
> This requires that the client be aware of the host side IOMMU model.
> That's true in VFIO now, and it's nasty; I was really hoping we could
> *stop* doing that.

that model is anyway inevitable when talking about user page table,
i.e. when nesting is enabled.

> 
> Note that I'm talking here *purely* about the non-optimized case where
> all updates to the host side IO pagetables are handled by IOAS_MAP /
> IOAS_COPY, with no direct hardware access to user or guest managed IO
> pagetables.  The optimized case obviously requires end-to-end
> agreement on the pagetable format amongst other domain properties.
> 
> What I'm hoping is that qemu (or whatever) can use this non-optimized
> as a fallback case where it does't need to know the properties of
> whatever host side IOMMU models there are.  It just requests what it
> needs based on the vIOMMU properties it needs to replicate and the
> host kernel either can supply it or can't.
> 
> In many cases it should be perfectly possible to emulate a PPC style
> vIOMMU on an x86 host, because the x86 IOMMU has such a colossal
> aperture that it will encompass wherever the ppc apertures end
> up. Similarly we could simulate an x86-style no-vIOMMU guest on a ppc
> host (currently somewhere between awkward and impossible) by placing
> the host apertures to cover guest memory.
> 
> Admittedly those are pretty niche cases, but allowing for them gives
> us flexibility for the future.  Emulating an ARM SMMUv3 guest on an
> ARM SMMU v4 or v5 or v.whatever host is likely to be a real case in
> the future, and AFAICT, ARM are much less conservative that x86 about
> maintaining similar hw interfaces over time.  That's why I think
> considering these ppc cases will give a more robust interface for
> other future possibilities as well.

It's not niche cases. We already have virtio-iommu which can work
on both ARM and x86 platforms, i.e. what current iommufd provides
is already generic enough except on PPC.

Then IMHO the key open here is:

Can PPC adapt to the current iommufd proposal if it can be
refactored to fit the standard iommu domain/group concepts?

If not, what is the remaining gap after PPC becomes a normal
citizen in the iommu layer and is it worth solving it in the general
interface or via iommu-driver-specific domain (given this will
exist anyway)?

to close that open I'm with Jason:

   "Fundamentally PPC has to fit into the iommu standard framework of
   group and domains, we can talk about modifications, but drifting too
   far away is a big problem."

Directly jumping to the iommufd layer for what changes might be
applied to all platforms sounds counter-intuitive if we haven't tried 
to solve the gap in the iommu layer in the first place, as even
there is argument that certain changes in iommufd layer can find
matching concept on other platforms it still sort of looks redundant
since those platforms already work with the current model.

My two cents.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
