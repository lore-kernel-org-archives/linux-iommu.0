Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A0BC433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 03:56:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C40C6115A
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 03:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C40C6115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC459608FE;
	Wed, 22 Sep 2021 03:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xUWisGNfgBGj; Wed, 22 Sep 2021 03:56:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 471D0607FE;
	Wed, 22 Sep 2021 03:56:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 230D3C0011;
	Wed, 22 Sep 2021 03:56:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 079E2C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 03:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C72F2406CC
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 03:56:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gs5q_YnAZO71 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 03:56:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8904C406C2
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 03:56:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="210746994"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="210746994"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 20:56:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="518445328"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga001.jf.intel.com with ESMTP; 21 Sep 2021 20:56:02 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 21 Sep 2021 20:56:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 21 Sep 2021 20:56:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 21 Sep 2021 20:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiJy7BRbCEJFT1Oc8+FsfAjm0EcAbZQcDNpbjNH3kRIkzjfRqYD2FH+HJAF2pOaNVoG28DqtHa5WyI6Sec6rWPnlRVMM2nS9Cse3as9CUO6cCB2NuaaszKrSJrCtXZNw1i07Pz/T+UY323Qbpa9oNiVhM5Kqkwrsy416RQtg/X7Xa2LPI3SqTquDGR/ctxZAOzQeNWjBr7ocRVVbWdNEe90Ddx1+0NDc8nsE0DLpnDhMO5GSd13bqEhC9DthODg4e/9w9HvLQw6ycTuJfgVZ8GUwmC2ts8m/6lQYtJYX91MySiblLecvMlNBfL3dUpeePRh5swmrNZCf05W6DMQjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=A4t8iRKRW8/OHk7MmD3wk2A4qGgO0tiS1PTTxaXQuBU=;
 b=GBqJc8MVNYQKtUQCvRQGBFAhzEIxJzrPtumhmO1lq9WLhuS5htxszP38GoskUQfWRArRmvq1fVL0u9gntT5tdGXFkuWD6q4jWTmQnO6Ti9kqTBkm2tshE28ZqKD+ZRWUwmrnnHULdhWujoKnMd6kw+moKazzrWLHciqpdbbhWlLrmO4+hvSHXsWdZI+2botIa+H8cc2/vPunJ65bP/W2g/IzEHy0RfRwUlqbb/oe/KtEbA0xxLEUIia4Mwvbtgy5HCSEjJN+9VQlrcVQKNDzfsBaTPmaep1RF+YNjKfvMeDWSZpfJE5B7IgotgK1KbTacdpSI9ZdZyGzEqtiHForYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4t8iRKRW8/OHk7MmD3wk2A4qGgO0tiS1PTTxaXQuBU=;
 b=aH1IpnowKvmaEq+DH2l70VY1W/cehHnbjp/n9L3I7OQNnMww7ACzxBWQWV/3mJN4BeEhl1XxfGNhqSna6MGkmmY7cPiPsBtCm/NiCiKa5W2bEgUZIVe8x+CL2ZlSeuPPKYPGj75t1f4wRdPsjPf/fIymc7ZdoKdX49wQZRIAKuE=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB3889.namprd11.prod.outlook.com (2603:10b6:405:81::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 03:53:52 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 03:53:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [RFC 14/20] iommu/iommufd: Add iommufd_device_[de]attach_ioasid()
Thread-Topic: [RFC 14/20] iommu/iommufd: Add iommufd_device_[de]attach_ioasid()
Thread-Index: AQHXrSGezXWDqkj89kuFN1ZDWKFxuauuy0yAgACiHzA=
Date: Wed, 22 Sep 2021 03:53:52 +0000
Message-ID: <BN9PR11MB54339FF0B126A917BF14B44E8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-15-yi.l.liu@intel.com>
 <20210921180203.GY327412@nvidia.com>
In-Reply-To: <20210921180203.GY327412@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4feb2ebb-8559-4e07-1699-08d97d7c97bf
x-ms-traffictypediagnostic: BN6PR11MB3889:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB3889F7A6C4E01B5F5B202C368CA29@BN6PR11MB3889.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88lM2XT1PY8U+42QEaz1uqtrCPWwZrHSD1Nrf0iCDTg14oRA2SNlol1PJ4LJ7tod1JUJsbGSMgcrnBZcG5pBngA46Na8CIcvH2r6cBHn/Bhrs0lxTFT1FAPYPAVroRrmLdy5AY22OkT/d8agd6QkEI7ygn/EukzNOOmkiOA8Wk2fkYZnBXrvDl78utkot0A2gnv+kk1cLBqg1+/9zl4fshXFk0tFpBHUhKA4Pe1Qc74t/O2gnJsqwaey7vLhSMoRWUq/q1cxMM7o1Rge/Xengh+8e/yf/WQWiaUM88vfqEyQMNM6T6pTQYJKtnWG/Ll1vhlzoz675/RSsUPAtLx1YX5tb7/MFPZuTRGXqEdIcBP/qFBp9hNIdLtH84WxhIOxjDohPsYM6LafEM2e1uTwExEGDMQyUypqM9bB4WIJZSEZ4va2JjDI8HFNDWnHuOhx80THkvfPMOFPzJYwfJtBjcjcCmDZj3+5pOkjga+2LCd3ll//dEZqj95/bZs0yddHYAQ0Lq+M8pJP7iPk+C8iB1TycSnC3qpidZmZ1WqpCT8XxTadYq7av2+prs0U763rmrTFzVHBBwcSvP0CxjBlfQ3bGwtAdhKrHuyZ23/cEFeXZOd7dJCj5yVPIVwzjcfa9pn1JLawkJb+U2gzuoEk2gtQP8yjmKFl+9QAsbG81sY1uIWiLdq720nCR0u2tKGZOH6Oy0xRbiTXdvuKET34+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(186003)(33656002)(38100700002)(55016002)(71200400001)(9686003)(122000001)(38070700005)(64756008)(8676002)(8936002)(508600001)(7416002)(2906002)(6636002)(4326008)(66556008)(66476007)(76116006)(66946007)(5660300002)(6506007)(86362001)(66446008)(26005)(52536014)(7696005)(316002)(110136005)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9FoAh84PXM3peQ6b3oEmfbLDBDOqDrZ5kuKM0m+4nAHtQAjan16qmao7jx1K?=
 =?us-ascii?Q?/2i3E8BUq2kHKvnpEluolM6nzAWImSjVfVTdNl9UWjbjE6C8DHsyNZZ1Gc+5?=
 =?us-ascii?Q?JPW+NPgBFP6QeEmiX/hAAUCZeTMeTUlIFQpjjoOw0Hgj6v9DLW0ZiJeRHIHd?=
 =?us-ascii?Q?JNMflk9WmoUOdj1cCRsneqYfYOlQrNip0fh6QBocFFR9uJZqHtZug87c1H0b?=
 =?us-ascii?Q?Vtb/tIPFbiPB0wW0+4Z3OjqgKdC8wcI5XkxEhR269aLVv2/2dH0r1UF9R7QV?=
 =?us-ascii?Q?Ja0TIOjW4RiwycdiW38GagsFIVUQTkkBdPPXVPs1BhwqVxg8bcRzXJDS6S/m?=
 =?us-ascii?Q?RmoL7U5p2p1814W3hdqdyFWwYKXqQ37LQu+v+7t5ZYPySVYFb7//z9n2cOqP?=
 =?us-ascii?Q?1tS8+J5sSI4saMbDOfWBUeWXBxHzOOfaACrXekOxERgQai2RDap2aEqKorxS?=
 =?us-ascii?Q?1xAit4q/4oJI/6Dx0pZ4bEim7uuDsMiLSvOhjDvNKJNjJ+r03o6cO4L+aD04?=
 =?us-ascii?Q?GDvt5K/X2E0+ZGqXFyPs2/tgJf3ioFvvoDZsxo4iF9bQTxzXQnss3lnp1LjA?=
 =?us-ascii?Q?11PBmIZYcFr99a2EBBNoUFwmS3DCtjmcVv8RHfFZ3Gglne9TSudDjhZckxE6?=
 =?us-ascii?Q?3m2tPNiSQmtTrF4QudozrG+K9BQij5wh4dSeoLtTTroqqC0EigHcbx1WuYjU?=
 =?us-ascii?Q?PqGdeM6uO2d00FBsMKtBn7mTV9n+A3lNsBs8fQM6W9JGelpbN0fv6KJ1n7/U?=
 =?us-ascii?Q?ee3WuCCGKj1Uu3YQ747+XHsjcfmbmrJdoDFI84zSq+/mx6ZcOS8nIvGoSacs?=
 =?us-ascii?Q?uvpvX/78g/PAhjJ63it+u0s5UcJtd1wlNEN5zTNr2ZQGlOh4ykxkd5OmXXBP?=
 =?us-ascii?Q?q4bG+FWfrh0qEr7dDEzvYoc+ywmyy5knBO5zKn/RsOzLuAVauzUf2HCE+eQW?=
 =?us-ascii?Q?99dvHHHt5XiRV4T3XFePQi8+hWXRQi/DxS8l7tJWHzchi5MagrjK12FDXfh6?=
 =?us-ascii?Q?sDRldgVO6/hUFDypE2unIK+jn10o6RvOMCs+3+yaUOsOsjvyL/gDUpXErDZ9?=
 =?us-ascii?Q?8T2Mm5TipYfXVO0I0e2kGD6ASOKCa9QQ8CCAAVJHwxe+BkiO4YMcW2Rx6tcN?=
 =?us-ascii?Q?oODZ+nbwbHBjB3ii626CNxUgU6nFviwVNu6zkAx4AX8xRhCdlnbyLFNX1Sez?=
 =?us-ascii?Q?chRU8jsAHqliPxkaPgHtKHBlEwEFJBbD33s6hskcv9actK+1WhxHb1wKbTyP?=
 =?us-ascii?Q?aO6im2tDf+AdcVsZIpQJmTcHjyyWYQRoPqC+wuZS0W/E3eTsQ7SfhZ5bbL51?=
 =?us-ascii?Q?fbl72nQUnzUcqNRAdUzW5z9Y?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feb2ebb-8559-4e07-1699-08d97d7c97bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 03:53:52.3461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZ2WI1g1ahDW5zLfq4JmkzAAUVMvhxf0IraRSt9o0mfmQlHaddDlLnrLmipOoWRmNmiNHULrCgZ4/rC9jBdDJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3889
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 22, 2021 2:02 AM
> 
> > +static int ioas_check_device_compatibility(struct iommufd_ioas *ioas,
> > +					   struct device *dev)
> > +{
> > +	bool snoop = false;
> > +	u32 addr_width;
> > +	int ret;
> > +
> > +	/*
> > +	 * currently we only support I/O page table with iommu enforce-
> snoop
> > +	 * format. Attaching a device which doesn't support this format in its
> > +	 * upstreaming iommu is rejected.
> > +	 */
> > +	ret = iommu_device_get_info(dev,
> IOMMU_DEV_INFO_FORCE_SNOOP, &snoop);
> > +	if (ret || !snoop)
> > +		return -EINVAL;
> > +
> > +	ret = iommu_device_get_info(dev,
> IOMMU_DEV_INFO_ADDR_WIDTH, &addr_width);
> > +	if (ret || addr_width < ioas->addr_width)
> > +		return -EINVAL;
> > +
> > +	/* TODO: also need to check permitted iova ranges and pgsize
> bitmap */
> > +
> > +	return 0;
> > +}
> 
> This seems kind of weird..
> 
> I expect the iommufd to hold a SW copy of the IO page table and each
> time a new domain is to be created it should push the SW copy into the
> domain. If the domain cannot support it then the domain driver should
> naturally fail a request.
> 
> When the user changes the IO page table the SW copy is updated then
> all of the domains are updated too - again if any domain cannot
> support the change then it fails and the change is rolled back.
> 
> It seems like this is a side effect of roughly hacking in the vfio
> code?

Actually this was one open we closed in previous design proposal, but
looks you have a different thought now.

vfio maintains one ioas per container. Devices in the container
can be attached to different domains (e.g. due to snoop format). Every
time when the ioas is updated, every attached domain is updated
in accordance. 

You recommended one-ioas-one-domain model instead, i.e. any device 
with a format incompatible with the one currently used in ioas has to 
be attached to a new ioas, even if the two ioas's have the same mapping.
This leads to compatibility check at attaching time.

Now you want returning back to the vfio model?

> 
> > +	/*
> > +	 * Each ioas is backed by an iommu domain, which is allocated
> > +	 * when the ioas is attached for the first time and then shared
> > +	 * by following devices.
> > +	 */
> > +	if (list_empty(&ioas->device_list)) {
> 
> Seems strange, what if the devices are forced to have different
> domains? We don't want to model that in the SW layer..

this is due to above background

> 
> > +	/* Install the I/O page table to the iommu for this device */
> > +	ret = iommu_attach_device(domain, idev->dev);
> > +	if (ret)
> > +		goto out_domain;
> 
> This is where things start to get confusing when you talk about PASID
> as the above call needs to be some PASID centric API.

yes, for pasid new api (e.g. iommu_attach_device_pasid()) will be added.

but here we only talk about physical device, and iommu_attach_device()
is only for physical device.

> 
> > @@ -27,6 +28,16 @@ struct iommufd_device *
> >  iommufd_bind_device(int fd, struct device *dev, u64 dev_cookie);
> >  void iommufd_unbind_device(struct iommufd_device *idev);
> >
> > +int iommufd_device_attach_ioasid(struct iommufd_device *idev, int
> ioasid);
> > +void iommufd_device_detach_ioasid(struct iommufd_device *idev, int
> ioasid);
> > +
> > +static inline int
> > +__pci_iommufd_device_attach_ioasid(struct pci_dev *pdev,
> > +				   struct iommufd_device *idev, int ioasid)
> > +{
> > +	return iommufd_device_attach_ioasid(idev, ioasid);
> > +}
> 
> If think sis taking in the iommfd_device then there isn't a logical
> place to signal the PCIness

can you elaborate?

> 
> But, I think the API should at least have a kdoc that this is
> capturing the entire device and specify that for PCI this means all
> TLPs with the RID.
> 

yes, this should be documented.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
