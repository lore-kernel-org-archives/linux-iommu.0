Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50CAC433DF
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 10:37:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FAB22482
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 10:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="wbwiARgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FAB22482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5317387D6E;
	Mon, 20 Jul 2020 10:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GaEl+xZ-i049; Mon, 20 Jul 2020 10:37:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6A34D87D63;
	Mon, 20 Jul 2020 10:37:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C750C0894;
	Mon, 20 Jul 2020 10:37:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 390F1C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 10:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2812384539
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 10:37:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tm8YdD9CzwJw for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 10:37:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BB5D680D45
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 10:37:15 +0000 (UTC)
IronPort-SDR: 3VRXRFmbVBK2cQLBkAxzF8CevF34WP1pV3j2JaEIjV6co7dMUnhqFwKAFeF3UZehppOp4vn/qf
 W2MH5LbwpeqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="149871656"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="149871656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 03:37:15 -0700
IronPort-SDR: AbHTpq5onVr5nlqgYecO8i0iyDmFQk2sTP99LIbY5IDLdQqLEWhXXKcp66KsknFckgYMgEeDb3
 BFh020cMcSrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="361981434"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP; 20 Jul 2020 03:37:14 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jul 2020 03:37:14 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Jul 2020 03:37:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 20 Jul 2020 03:37:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfIiqEdPBdhz/Ho/8UybkFadKIwks5dI264WtKj63xqOiHiEWuXkYkt3EH10ofHlUIPa5oHhY3f4s6nvdfqnnLkrpJ1IGfuQ11iq33okaxIXZ8SponNEytzaMRvtYsThNIDvgqY5D9NHka89tDptWfUkRnQ9wHjMy5usavUN6VqyCpgwZNiJA9aCCBjmVCIqxqhIe1Q8xdrE1U8Zf3ObWfZmFXEaoWqGGV/ilYxckKWR8yl4MBVeZsONu23tcTYlSWxHxW/jwd8Vj9ngpkf73cZdS2NWlQPn1gvhKq4vo0XtiSzjWH3p/LC5xIaktM6ZGBOtGRVXZJB7e3UCwhh5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RJEy/fHSkBbYzEW8v3N65QEFvoMFY97XayXjJevs8s=;
 b=JlRU9cgDDUkREzGI/0OgmPh8bGaPiRcNUZ4SqAI6qY90AQ8M0hBIMn4Q7DlOQ+surM+4RzKq5uGqa++x3IB2P6exDAY9XFjAqbMjxKCuscGcNHP+210TzcrKIzszI82wfQ2AShR7lOyqOSHWKcufZl3ppRjSycJ/bltdAvGBls9fuqHPzHWphtMtJrDLVpoMGiCXFl8GciJoF5H0/XCpesNpKAHmzch1oVQtzEQdkBn2fHwlKS/csPMhmgW80DAvaEmynC76c8SVmioSt/B3Vq3DzTQnE0/SEylWgc8zcZFCHAKqID+4tOC2xAVkRCRZxNWPwlpMSru+6hk/vjZ88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RJEy/fHSkBbYzEW8v3N65QEFvoMFY97XayXjJevs8s=;
 b=wbwiARgzCOOHPQSk5ORB0kVAIodhsgYdM6z7qwuleMut63hxhMF38u+0pnG9INsJ4hYs3aTk3F8f3Xu95C3NYE+Jm7fn2G1j6NwHrA2iG7Igp9s/avR+C/Q91ZlLHJSGOy05ekcFBMBgy4GoCJaYa4uR8tJVkiF+YTPMbXMEi00=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.23; Mon, 20 Jul 2020 10:37:12 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 10:37:12 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 10/15] vfio/type1: Support binding guest page tables to
 PASID
Thread-Topic: [PATCH v5 10/15] vfio/type1: Support binding guest page tables
 to PASID
Thread-Index: AQHWWD2woCISNiegiEOCPm/TTFcJNqkQQjGAgAANUCA=
Date: Mon, 20 Jul 2020 10:37:11 +0000
Message-ID: <DM5PR11MB1435ED80402F9F10127590F5C37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-11-git-send-email-yi.l.liu@intel.com>
 <c51215a0-3462-1303-1295-7d71675cf469@redhat.com>
In-Reply-To: <c51215a0-3462-1303-1295-7d71675cf469@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95c81ec3-451c-4d92-f9db-08d82c98dc9a
x-ms-traffictypediagnostic: DM6PR11MB4723:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4723FFE68BEE358756603EEFC37B0@DM6PR11MB4723.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: obyMlVSHWnvGbegeb45Wl8Nj4Lx4vXIY4dvViUvZz1pQDRtMg0aqfjFYPO/L0amLVFzbeH8uuSYmiPPEy0a5tJiEp4jO3YL7qCaFk2WPhoHxeqRwq/Ll5kDbhJ1w67as5QoEUnoYYWNUZZOnPnVtTKmBAtoRS7Egw3tfUOBdSxWrq/Ngo8VCYlwOWcDQnNlplx8vaonlXslgIeSSS/9k8HXB8+byFrQlTHV4LWgiLUvcBE28I2fHe0uRD2lfJj/KyaOEd3lPQi2TdmZAZhcVySKulj01WatVZC4aVt8aXhtXjnQvxhw7S+Qs0TztO70kWMFDxopMLwWQm0KT5rMb32s/hEw1ppXCOn7OdJDE/B6Q54NyICdYTTOOm3MNjlm0gW94Xk/Nv5ksKhPiuOGv3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(4326008)(9686003)(30864003)(478600001)(86362001)(54906003)(110136005)(52536014)(7416002)(186003)(2906002)(76116006)(64756008)(66556008)(66476007)(66946007)(316002)(8676002)(8936002)(7696005)(66446008)(53546011)(71200400001)(966005)(6506007)(83380400001)(26005)(55016002)(5660300002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: zfAZ/6lxN+azSi6h7OlYeNm/NJDLDVqDp4DsSSmWgHat7c5ISVHdqlSBU81ioARa/MebCbthzBfAKskEqLBu5Mojy4uq+lEdNkPg4ElEeuXYz2uZNxqjrROziugKARYWGzxFw0EY6lQOlgZyLV4d5IYYYPXIsajiMT5KClofzeMfYbM4xlHNj/32b7gR+xY+FT8IZ7p0r3Ux2FBQ6tuZmYmJMRJleulPQgf7VCccWG0FnYN/DR6gZkQYDpBfd3DIVet6Yc3JveOG6L2Hx8Fgb96XnhFiLm9DunlA/cByCfGR+kz5TM659f/ec/g5TUwil85IwXPWfHwQfiiQIdZbTgMUjBxH2enCwkLQIOZ+hOtNs7+gePu9c1x7dxwt+7N/c23DQZ86ACnOzjcwRF/ZHV3sAYVFItNOAN5bTls9R/jDm7fef+N3xXPtFpupeiOX+QPdVgU1JNwKWl+wiaAUnae3DX81vCtJkbXZUbYkgimsbVHRIauc7HSL6MfcG58V
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c81ec3-451c-4d92-f9db-08d82c98dc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 10:37:11.9360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpVLJH/lO2/uuCa+M9euCfz93Jlb0VgfWkuLNGDkD1vktPexLP1eXaA2G1Rzt1P/Urn2xHZBOgGUyL6Cwl6sDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Hi Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Monday, July 20, 2020 5:37 PM
> 
> Yi,
> 
> On 7/12/20 1:21 PM, Liu Yi L wrote:
> > Nesting translation allows two-levels/stages page tables, with 1st level
> > for guest translations (e.g. GVA->GPA), 2nd level for host translations
> > (e.g. GPA->HPA). This patch adds interface for binding guest page tables
> > to a PASID. This PASID must have been allocated to user space before the
> by the userspace?

yes, it is. will modify it.

> > binding request.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v3 -> v4:
> > *) address comments from Alex on v3
> >
> > v2 -> v3:
> > *) use __iommu_sva_unbind_gpasid() for unbind call issued by VFIO
> >    https://lore.kernel.org/linux-iommu/1592931837-58223-6-git-send-email-
> jacob.jun.pan@linux.intel.com/
> >
> > v1 -> v2:
> > *) rename subject from "vfio/type1: Bind guest page tables to host"
> > *) remove VFIO_IOMMU_BIND, introduce VFIO_IOMMU_NESTING_OP to support
> bind/
> >    unbind guet page table
> > *) replaced vfio_iommu_for_each_dev() with a group level loop since this
> >    series enforces one group per container w/ nesting type as start.
> > *) rename vfio_bind/unbind_gpasid_fn() to vfio_dev_bind/unbind_gpasid_fn()
> > *) vfio_dev_unbind_gpasid() always successful
> > *) use vfio_mm->pasid_lock to avoid race between PASID free and page table
> >    bind/unbind
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 166
> ++++++++++++++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_pasid.c       |  26 +++++++
> >  include/linux/vfio.h            |  20 +++++
> >  include/uapi/linux/vfio.h       |  31 ++++++++
> >  4 files changed, 243 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 55b4065..f0f21ff 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -149,6 +149,30 @@ struct vfio_regions {
> >  #define DIRTY_BITMAP_PAGES_MAX	 ((u64)INT_MAX)
> >  #define DIRTY_BITMAP_SIZE_MAX
> DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
> >
> > +struct domain_capsule {
> > +	struct vfio_group *group;
> > +	struct iommu_domain *domain;
> > +	void *data;
> > +};
> > +
> > +/* iommu->lock must be held */
> > +static struct vfio_group *vfio_find_nesting_group(struct vfio_iommu *iommu)
> > +{
> > +	struct vfio_domain *d;
> > +	struct vfio_group *group = NULL;
> > +
> > +	if (!iommu->nesting_info)
> > +		return NULL;
> > +
> > +	/* only support singleton container with nesting type */
> > +	list_for_each_entry(d, &iommu->domain_list, next) {
> > +		list_for_each_entry(group, &d->group_list, next) {
> > +			break;
> use list_first_entry?

yeah, based on the discussion in below link, we only support singleton
container with nesting type, also if no group in container, the nesting_info
will be cleared. so yes, list_first_entry will work as well.

https://lkml.org/lkml/2020/5/15/1028

> > +		}
> > +	}
> > +	return group;
> > +}
> > +
> >  static int put_pfn(unsigned long pfn, int prot);
> >
> >  static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu
> *iommu,
> > @@ -2349,6 +2373,48 @@ static int vfio_iommu_resv_refresh(struct vfio_iommu
> *iommu,
> >  	return ret;
> >  }
> >
> > +static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	unsigned long arg = *(unsigned long *)dc->data;
> > +
> > +	return iommu_sva_bind_gpasid(dc->domain, dev, (void __user *)arg);
> > +}
> > +
> > +static int vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	unsigned long arg = *(unsigned long *)dc->data;
> > +
> > +	iommu_sva_unbind_gpasid(dc->domain, dev, (void __user *)arg);
> > +	return 0;
> > +}
> > +
> > +static int __vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	struct iommu_gpasid_bind_data *unbind_data =
> > +				(struct iommu_gpasid_bind_data *)dc->data;
> > +
> > +	__iommu_sva_unbind_gpasid(dc->domain, dev, unbind_data);
> > +	return 0;
> > +}
> > +
> > +static void vfio_group_unbind_gpasid_fn(ioasid_t pasid, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	struct iommu_gpasid_bind_data unbind_data;
> > +
> > +	unbind_data.argsz = offsetof(struct iommu_gpasid_bind_data, vendor);
> > +	unbind_data.flags = 0;
> > +	unbind_data.hpasid = pasid;
> > +
> > +	dc->data = &unbind_data;
> > +
> > +	iommu_group_for_each_dev(dc->group->iommu_group,
> > +				 dc, __vfio_dev_unbind_gpasid_fn);
> > +}
> > +
> >  static void vfio_iommu_type1_detach_group(void *iommu_data,
> >  					  struct iommu_group *iommu_group)
> >  {
> > @@ -2392,6 +2458,21 @@ static void vfio_iommu_type1_detach_group(void
> *iommu_data,
> >  		if (!group)
> >  			continue;
> >
> > +		if (iommu->nesting_info && iommu->vmm &&
> > +		    (iommu->nesting_info->features &
> > +					IOMMU_NESTING_FEAT_BIND_PGTBL)) {
> > +			struct domain_capsule dc = { .group = group,
> > +						     .domain = domain->domain,
> > +						     .data = NULL };
> > +
> > +			/*
> > +			 * Unbind page tables bound with system wide PASIDs
> > +			 * which are allocated to user space.
> > +			 */
> > +			vfio_mm_for_each_pasid(iommu->vmm, &dc,
> > +					       vfio_group_unbind_gpasid_fn);
> > +		}
> > +
> >  		vfio_iommu_detach_group(domain, group);
> >  		update_dirty_scope = !group->pinned_page_dirty_scope;
> >  		list_del(&group->next);
> > @@ -2938,6 +3019,89 @@ static int vfio_iommu_type1_pasid_request(struct
> vfio_iommu *iommu,
> >  	}
> >  }
> >
> > +static long vfio_iommu_handle_pgtbl_op(struct vfio_iommu *iommu,
> > +				       bool is_bind, unsigned long arg)
> > +{
> > +	struct iommu_nesting_info *info;
> > +	struct domain_capsule dc = { .data = &arg };
> > +	struct vfio_group *group;
> > +	struct vfio_domain *domain;
> > +	int ret;
> > +
> > +	mutex_lock(&iommu->lock);
> > +
> > +	info = iommu->nesting_info;
> > +	if (!info || !(info->features & IOMMU_NESTING_FEAT_BIND_PGTBL)) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out_unlock_iommu;
> > +	}
> > +
> > +	if (!iommu->vmm) {
> > +		ret = -EINVAL;
> > +		goto out_unlock_iommu;
> > +	}
> > +
> > +	group = vfio_find_nesting_group(iommu);
> is it realy useful to introduce vfio_find_nesting_group?
> in this function you already test info, you fetch the first domain
> below. So you would only need to fetch the 1st group?

this function was added to highlight the singleton container support
limitation. perhaps, it can be replaced with list_first_entry.

> > +	if (!group) {
> > +		ret = -EINVAL;
> can it happen?

guess not. may drop if vfio_find_nesting_group() is dropped.

> > +		goto out_unlock_iommu;
> > +	}
> > +
> > +	domain = list_first_entry(&iommu->domain_list,
> > +				  struct vfio_domain, next);
> > +	dc.group = group;
> > +	dc.domain = domain->domain;
> > +
> > +	/* Avoid race with other containers within the same process */
> > +	vfio_mm_pasid_lock(iommu->vmm);
> > +
> > +	if (is_bind) {
> > +		ret = iommu_group_for_each_dev(group->iommu_group, &dc,
> > +					       vfio_dev_bind_gpasid_fn);
> > +		if (ret)
> > +			iommu_group_for_each_dev(group->iommu_group, &dc,
> > +						 vfio_dev_unbind_gpasid_fn);
> > +	} else {
> > +		iommu_group_for_each_dev(group->iommu_group,
> > +					 &dc, vfio_dev_unbind_gpasid_fn);
> > +		ret = 0;
> 
> int ret = 0;
> 
> if (is_bind) {
> ret = iommu_group_for_each_dev(group->iommu_group, &dc,
>  			       vfio_dev_bind_gpasid_fn);
> }
> if (ret || !is_bind) {
> 	iommu_group_for_each_dev(group->iommu_group,
> 			&dc, vfio_dev_unbind_gpasid_fn);
> }

got it. :-)

Regards,
Yi Liu

> > +	}
> > +
> > +	vfio_mm_pasid_unlock(iommu->vmm);
> > +out_unlock_iommu:
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> > +static long vfio_iommu_type1_nesting_op(struct vfio_iommu *iommu,
> > +					unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_nesting_op hdr;
> > +	unsigned int minsz;
> > +	int ret;
> > +
> > +	minsz = offsetofend(struct vfio_iommu_type1_nesting_op, flags);
> > +
> > +	if (copy_from_user(&hdr, (void __user *)arg, minsz))
> > +		return -EFAULT;
> > +
> > +	if (hdr.argsz < minsz || hdr.flags & ~VFIO_NESTING_OP_MASK)
> > +		return -EINVAL;
> > +
> > +	switch (hdr.flags & VFIO_NESTING_OP_MASK) {
> > +	case VFIO_IOMMU_NESTING_OP_BIND_PGTBL:
> > +		ret = vfio_iommu_handle_pgtbl_op(iommu, true, arg + minsz);
> > +		break;
> > +	case VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL:
> > +		ret = vfio_iommu_handle_pgtbl_op(iommu, false, arg + minsz);
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)
> >  {
> > @@ -2956,6 +3120,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  		return vfio_iommu_type1_dirty_pages(iommu, arg);
> >  	case VFIO_IOMMU_PASID_REQUEST:
> >  		return vfio_iommu_type1_pasid_request(iommu, arg);
> > +	case VFIO_IOMMU_NESTING_OP:
> > +		return vfio_iommu_type1_nesting_op(iommu, arg);
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
> > index ebec244..ecabaaa 100644
> > --- a/drivers/vfio/vfio_pasid.c
> > +++ b/drivers/vfio/vfio_pasid.c
> > @@ -216,6 +216,8 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  	 * IOASID core will notify PASID users (e.g. IOMMU driver) to
> >  	 * teardown necessary structures depending on the to-be-freed
> >  	 * PASID.
> > +	 * Hold pasid_lock also avoids race with PASID usages like bind/
> > +	 * unbind page tables to requested PASID.
> >  	 */
> >  	mutex_lock(&vmm->pasid_lock);
> >  	while ((vid = vfio_find_pasid(vmm, min, max)) != NULL)
> > @@ -224,6 +226,30 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  }
> >  EXPORT_SYMBOL_GPL(vfio_pasid_free_range);
> >
> > +int vfio_mm_for_each_pasid(struct vfio_mm *vmm, void *data,
> > +			   void (*fn)(ioasid_t id, void *data))
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&vmm->pasid_lock);
> > +	ret = ioasid_set_for_each_ioasid(vmm->ioasid_sid, fn, data);
> > +	mutex_unlock(&vmm->pasid_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_for_each_pasid);
> > +
> > +void vfio_mm_pasid_lock(struct vfio_mm *vmm)
> > +{
> > +	mutex_lock(&vmm->pasid_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_pasid_lock);
> > +
> > +void vfio_mm_pasid_unlock(struct vfio_mm *vmm)
> > +{
> > +	mutex_unlock(&vmm->pasid_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_pasid_unlock);
> > +
> >  static int __init vfio_pasid_init(void)
> >  {
> >  	mutex_init(&vfio_mm_lock);
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index a111108..2bc8347 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -105,6 +105,11 @@ int vfio_mm_ioasid_sid(struct vfio_mm *vmm);
> >  extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
> >  extern void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  				  ioasid_t min, ioasid_t max);
> > +extern int vfio_mm_for_each_pasid(struct vfio_mm *vmm, void *data,
> > +				  void (*fn)(ioasid_t id, void *data));
> > +extern void vfio_mm_pasid_lock(struct vfio_mm *vmm);
> > +extern void vfio_mm_pasid_unlock(struct vfio_mm *vmm);
> > +
> >  #else
> >  static inline struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task)
> >  {
> > @@ -129,6 +134,21 @@ static inline void vfio_pasid_free_range(struct vfio_mm
> *vmm,
> >  					  ioasid_t min, ioasid_t max)
> >  {
> >  }
> > +
> > +static inline int vfio_mm_for_each_pasid(struct vfio_mm *vmm, void *data,
> > +					 void (*fn)(ioasid_t id, void *data))
> > +{
> > +	return -ENOTTY;
> > +}
> > +
> > +static inline void vfio_mm_pasid_lock(struct vfio_mm *vmm)
> > +{
> > +}
> > +
> > +static inline void vfio_mm_pasid_unlock(struct vfio_mm *vmm)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_VFIO_PASID */
> >
> >  /*
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 96a115f..a8ad786 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1209,6 +1209,37 @@ struct vfio_iommu_type1_pasid_request {
> >
> >  #define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 18)
> >
> > +/**
> > + * VFIO_IOMMU_NESTING_OP - _IOW(VFIO_TYPE, VFIO_BASE + 19,
> > + *				struct vfio_iommu_type1_nesting_op)
> > + *
> > + * This interface allows user space to utilize the nesting IOMMU
> > + * capabilities as reported in VFIO_IOMMU_TYPE1_INFO_CAP_NESTING
> > + * cap through VFIO_IOMMU_GET_INFO.
> > + *
> > + * @data[] types defined for each op:
> > + *
> +=================+===============================================+
> > + * | NESTING OP      |      @data[]                                  |
> > + *
> +=================+===============================================+
> > + * | BIND_PGTBL      |      struct iommu_gpasid_bind_data            |
> > + * +-----------------+-----------------------------------------------+
> > + * | UNBIND_PGTBL    |      struct iommu_gpasid_bind_data            |
> > + * +-----------------+-----------------------------------------------+
> > + *
> > + * returns: 0 on success, -errno on failure.
> > + */
> > +struct vfio_iommu_type1_nesting_op {
> > +	__u32	argsz;
> > +	__u32	flags;
> > +#define VFIO_NESTING_OP_MASK	(0xffff) /* lower 16-bits for op */
> > +	__u8	data[];
> > +};
> > +
> > +#define VFIO_IOMMU_NESTING_OP_BIND_PGTBL	(0)
> > +#define VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL	(1)
> > +
> > +#define VFIO_IOMMU_NESTING_OP		_IO(VFIO_TYPE, VFIO_BASE + 19)
> > +
> >  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
> >
> >  /*
> >
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
