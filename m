Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FDDC433FE
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:51:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412866124A
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 12:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 412866124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20807613D0;
	Wed, 22 Sep 2021 12:51:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9P77f73E-Le7; Wed, 22 Sep 2021 12:51:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1EA60613C5;
	Wed, 22 Sep 2021 12:51:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 088D5C0011;
	Wed, 22 Sep 2021 12:51:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3975AC000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 263014012D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3o1njHBjLC2c for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 12:51:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1515B4010E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 12:51:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="287252349"
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; d="scan'208";a="287252349"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2021 05:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; d="scan'208";a="557449403"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2021 05:51:46 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 05:51:46 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 05:51:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 22 Sep 2021 05:51:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 22 Sep 2021 05:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA79twLS5gs9OxiO+/DUYDwL3Pg5jMv9sYHgKdafkNnqL1XAotGkH9edGO7viAoduM9by0a/X9d/66LjR9m8eKSfIgZuXMiGXbPPGmenpoJsPG5Z4T38MOjLf9e2fJ6NLvp62e0qx5/j4J9fpFX8lSuWjIoejVtga41lY0KCmY6eVkVtvHJezWn+P19C5Pl1zCqksVDB67BJGa74O7+FT9KFNtn6GGlLrGkRhQBQGtjqQ94DuPR0XDXTbFjtCetSvv0Gloc12qxCTYmcv53yyXjolTfbh6AF2J0/BKBsEA3csAZwIyf9GTmx+8MWl5hW4SKsP2bZQ0eKqusZM5djGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=QlHyXmMTaxdeZ2nJt4J2Fbo087iZX08KhN/RL4BPaMU=;
 b=DqO0XEwCxa/H4STnBvtR9VuSNH25E+4wpPFuv2dDX8WKbN9d6sroKCWBHFb4Pkj/UQ1rZed8wF+CKqk9O7p7XnhC+BRf0WS0lldZTQSqjMemrNNcJMGvJHVxjjPdvthhbAy9PJH4M7olO3u0pe+D+g5fRdKYXmI5bEOOQaxKx8W/bSk/3glCeCxi3X09EtSbYjZx1c6doH0W6FPOMwUwXRr6WgNyVAWsup/DRqHotr8psbgc082rVl7gM2j0pibcLHC1ZWIxE/lDD4if+3M1hrKO2wtoHB+vcryl2iX7+H0ufUMW87Oe1xCdnnEIY43f4iXsTDsl/sQFG4Zbygs8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlHyXmMTaxdeZ2nJt4J2Fbo087iZX08KhN/RL4BPaMU=;
 b=vQE2fzPPaBcliUUGXHX5HSXQQpee7Pzn+hR4Uy6pTwhBAikkKvCQLtpSBYU3iBAdZYT7WaUeC2CzlAwGgnSKjS9fgtzlsYHfBKlRUbPNJtQ7Pl89/koYG+th5Wdd7KhvQbpo96VrT7OEmpyAqDhYkPAsUfVJNAVJ0+mybJpPKr4=
Received: from SJ0PR11MB5662.namprd11.prod.outlook.com (2603:10b6:a03:3af::7)
 by SJ0PR11MB5647.namprd11.prod.outlook.com (2603:10b6:a03:3af::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 12:51:38 +0000
Received: from SJ0PR11MB5662.namprd11.prod.outlook.com
 ([fe80::214b:62bf:8e9e:4b35]) by SJ0PR11MB5662.namprd11.prod.outlook.com
 ([fe80::214b:62bf:8e9e:4b35%5]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 12:51:38 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Topic: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Index: AQHXrSGQLQh7Daiwk0GPvXz/w70Xfquuxm8AgAE+jLA=
Date: Wed, 22 Sep 2021 12:51:38 +0000
Message-ID: <SJ0PR11MB5662A74575125536D9BEF57AC3A29@SJ0PR11MB5662.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
In-Reply-To: <20210921174438.GW327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2203161-ae7b-4732-28c7-08d97dc7b7f1
x-ms-traffictypediagnostic: SJ0PR11MB5647:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5647C42741C1ED745D44687DC3A29@SJ0PR11MB5647.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7cS+R/dwGXJDBdNIWVeycnZ+4Wub+OAwnJ1nZMctBy4CNhjoCu7RIEBZp+1QTwju9/pI4fpUBLlRBFWvT4uQS7OVfhZQmIbgKtpS0DsaSGKQf//EhmvcU+vdF91ubdu92xgTBskuPY5/dxLpFQu70C9ySj7Xjedl7AAdMLZpFoyzfubVFuwR/r9PkE0nBuH2NH0dTn/Razh5McWb6Vc3YDwYh5hNubjZVoswjhN0dCTcMuSO2RSbkmlcnlW+tJ2F3yuuRvL317vgTZSf2IATLIOTJd3APY8xa67GrpIOwfZaq4KylnzRQ2kQgWZF5TzTZ+1oI2IkXG95UQQCV3HKTFmsifYSXmRy1NjfdTrm1crumGQ61zrI1cL6pgOJmGSNVI/I/2hqFT4ZZQmcSV2NvEgmeLRvUP3U/r9/epX2uY6MEcF98tDeGoMSBPdt/cRZzoHnjMfkt2gyX7ChI8JACpmj92m1mLMreXwxxE0Uyu/ps5tfZ0i4cxFv2yKc/tmqN6158gchZPngFit/PM8d8YLMPX8d8dz42R67SM5SRcyxCuKJ9jHzRQZ2JrdlMPgI5NSD7GZAa9d5mJ1Thti4pihxb0s5w5VffQhODs04FXRnPp+hr5IzaPrZKQRRLZsMcwDEVg/O0srcFjac571+AZb4gRkf/UjZXpShVZMG3VIJLaw6kUMGLb5KpwfoB76bu3jkwJ5tkUpxfjXPb5VFKxQmqJyHK7HuWvd0WfGQ4lI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5662.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(83380400001)(66556008)(33656002)(8936002)(66476007)(2906002)(186003)(6506007)(6916009)(54906003)(26005)(8676002)(66446008)(55016002)(316002)(71200400001)(64756008)(7696005)(508600001)(122000001)(38100700002)(38070700005)(7416002)(5660300002)(86362001)(52536014)(66946007)(76116006)(4326008)(84603001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xfoiYwp9h3btyPR1oXdMVuqH0X8csqsep3FMP5jcKQ2+ItIp/DijDHeuVOrP?=
 =?us-ascii?Q?e3jTwgHs+hXjz989Lryy9uMDwqApMNmmXM5XHVi3ZtatvqEDlHh4H6/mKckP?=
 =?us-ascii?Q?0989t6jOELaho8PNLKOW6Z7jlI95UIRwNZKByEsog3FHiKxA//qgjf3b2wQp?=
 =?us-ascii?Q?q7PQOZPojmu0TiNSEX5MZK0k6ucaI6ukyIOMGo0ybvtK0B88llb8l3xumiXl?=
 =?us-ascii?Q?wSa7nVfynwYMrlCL18EFr3WQV2hVz53unMvqvaKaq4Rsu9zYqAroeIPFIs6X?=
 =?us-ascii?Q?26RI5GHz1llMCC5vAlO5+e1R8vuRne9GziorKFja6gFBvTHEatEGrw+ciZCU?=
 =?us-ascii?Q?mgY0vK9EcqJnUmNMghEFUJ13bzSQpOg0qmcbZjUTF+ycVN1HI+4/LRTNZY+L?=
 =?us-ascii?Q?gtdDOA47uG2u4u/kdfIRVxI0Ll9nHvBIBlhgPyK4xtQC7Wk2V0jo7Q6i9CYV?=
 =?us-ascii?Q?XGUeAD8rby4Q+K4M+HH7lFTRkUvf8Cp76bYl43Zz+CZNUHVdoegjS80uTBhL?=
 =?us-ascii?Q?hAUzHa4z85VtEb9qT0UB/xqEtkM7bhYAgdPmZju5Aumb8FM+QZ9BJ/Mubaeq?=
 =?us-ascii?Q?Ssnc6oUdCJmc+jzZARhUZ5qZd1LvwTf44AekUI5ptozLJi+LSMGuiT40eMAc?=
 =?us-ascii?Q?+xKNMTwcLHt3JTdBzV5Ty/uPWXNWpYKYt+vrJhlw4cl+bw25ZKqwtCso5T79?=
 =?us-ascii?Q?AGgYoy/Wc1eiaG3wt527uXp8XEBheWScmbJoyvi0Ga2v0R/yLbYzW+8evHRh?=
 =?us-ascii?Q?MsvP4lhcOJq9PJvUL1KHuQn2DBZTnCLsPn73C7qliIrbUW+tEne6ISvzpQCF?=
 =?us-ascii?Q?ng9ehPB58VRiNaKG1w1eAbHbDYrfXAt5/AuezfcdY9aqEEYgeWSUt6aQY15Z?=
 =?us-ascii?Q?YzKtdV4EkQXWpewzb1IqFIG9evAh09BiyuypHxqdwL7q9bhVLTpcW6aP9oAN?=
 =?us-ascii?Q?9raAv/CJfdKFsAdlD2JlxgEju6LfN0biGSkRhRQid3p8OxSCnMl9J1f7YVi2?=
 =?us-ascii?Q?66X/VuLSlw9W6/OAExdpe8nkmqg3oGTzrByOf9LxI8ggYKU1FsYAZeQscuIl?=
 =?us-ascii?Q?HGySjykhpnQ3eJN2lip2H9/xVR1mgxOms7RBpQS376J+xI8XiM/mM8XXCsJn?=
 =?us-ascii?Q?gmHU9peNHjiYjinUkZnAQQMklRsm2J5cxmNh3ZntDv7akMoI6Di5hK1Qze3S?=
 =?us-ascii?Q?4mzWun1VIpf2f12YBKrdzdK1llpzqNViBUhs76wwOUho9JMIWyzjwHyaNfyr?=
 =?us-ascii?Q?AZYeJqY/xn0XorZ0mLX9401x9c9dQ+OIScozYjDC3Aiv9GGJVE+yqdte58Ov?=
 =?us-ascii?Q?WMJkp3zATZF117trGc34H1U6?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5662.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2203161-ae7b-4732-28c7-08d97dc7b7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 12:51:38.6211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RD2wJNpwLtYYJUqG+i8suWPK+b4T0mnmG5czzyvKgcji8c1GZKQMpLrUeKHFfoUMuhkrsjcrHhk4QBs0hS1pXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5647
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
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
> Sent: Wednesday, September 22, 2021 1:45 AM
> 
[...]
> > diff --git a/drivers/iommu/iommufd/iommufd.c
> b/drivers/iommu/iommufd/iommufd.c
> > index 641f199f2d41..4839f128b24a 100644
> > +++ b/drivers/iommu/iommufd/iommufd.c
> > @@ -24,6 +24,7 @@
> >  struct iommufd_ctx {
> >  	refcount_t refs;
> >  	struct mutex lock;
> > +	struct xarray ioasid_xa; /* xarray of ioasids */
> >  	struct xarray device_xa; /* xarray of bound devices */
> >  };
> >
> > @@ -42,6 +43,16 @@ struct iommufd_device {
> >  	u64 dev_cookie;
> >  };
> >
> > +/* Represent an I/O address space */
> > +struct iommufd_ioas {
> > +	int ioasid;
> 
> xarray id's should consistently be u32s everywhere.

sure. just one more check, this id is supposed to be returned to
userspace as the return value of ioctl(IOASID_ALLOC). That's why
I chose to use "int" as its prototype to make it aligned with the
return type of ioctl(). Based on this, do you think it's still better
to use "u32" here?

Regards,
Yi Liu

> Many of the same prior comments repeated here
>
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
