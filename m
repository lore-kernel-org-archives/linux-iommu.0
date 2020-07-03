Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36115C433E1
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 06:46:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C3C208B8
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 06:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ZkzHKcYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C3C208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BAEE487D6A;
	Fri,  3 Jul 2020 06:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TowrGlE0IvBU; Fri,  3 Jul 2020 06:46:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7CA1287D61;
	Fri,  3 Jul 2020 06:46:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51EC8C0888;
	Fri,  3 Jul 2020 06:46:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9FA4C0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 06:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C5F0C264B4
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 06:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PdAFdPjhHEMm for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 06:46:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id B9F15263F5
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 06:46:30 +0000 (UTC)
IronPort-SDR: r0VU9coCnWyiBnbZC/zHce1xlqGw4aCy66JSi62U/D1Xz4GWkUI5zzs2Z39ZshU4zyncBlUpSg
 XEpcs5bFoT1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="146190921"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; d="scan'208";a="146190921"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 23:46:30 -0700
IronPort-SDR: 41trkA2f7ClwWo0wprHcVbQsyL9O9IRQSHDtSm/TPYbGiXoRXYw1DJZfIG63T5P/JN2B7DdKaC
 0YNuKc2GCEwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; d="scan'208";a="282203515"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga006.jf.intel.com with ESMTP; 02 Jul 2020 23:46:29 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jul 2020 23:46:28 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jul 2020 23:46:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 2 Jul 2020 23:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhjz4gx4tn8kTRyuQ59qvMUtP1uoMjjbL72T6oVaT78FR4zSl+Fjxhc1w0mejcr0/OgtCeyGnlu/okz3QqtLmb859bMqzjS2Y0sLJiJ+thldXNkKHcNB5v6vM3NVRAWu5g73WqV4iqOQERLoU7TTAq+lUolrBP/A5+iTD7PfBjmm4sFHwDyL9OIPmRvb/9BrYmqOxI0Zs14GSms2/Mxxibzq8AeYurl7bPuqXg5b26WqccQ925qROAHra2eKRdgg8+BKJWPxz/hcQpIpWXcWitg/ZbSBhgHIb0FewCCkDxtKT7jLtcX2u8sZhAl/JRqD5Kf+7UDjrBOKdJvFuL6i2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xZ6KH+naFsvd9La3XKWiVXFzkAprKxM/lfIHM/Xc54=;
 b=UjQOxwgk4sP4MBXerQ6ATRONK0He/UEnvSiDJr/uDz5iZNy3GPAWc9bG2xfcjeIRzSN2YvLPjbTliWRLClX2KBPb+iHYXqe3OvZ++YrGXc5eMJg3akiYcNef8lzgugBZgZ/Klmad969wRbIbjH1XtzCHJz1HSfDB39Rd93GZNAxHlZpG3sNBTS/1cdMHpe88UjwLNYqEHryHQDER5UidVF9/kdKuluW+eOSQYT5huNWrcEu+A/SwQaoEVDTXz4AlKtYBrCxDGMOAHQOU8dNq7IO+yYPMiLeHFeULeEf/lLcA7c/RYR2Q4sjeJ1zLZXPLY28WJOlGZ0eEUwV6P96QZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xZ6KH+naFsvd9La3XKWiVXFzkAprKxM/lfIHM/Xc54=;
 b=ZkzHKcYjLT8b8350BdS8c+WLEi17SczVO3VTcnaRHKWXHXVZ59KfHCyHM6Z58f2oSaJLUTReDW4vUjaWsCaNPi+AN7o4ZlHcqw/1whwW3EfM7qviIFiXfo/FvMUIZnvAEM3mbmaEJYSlVo+AEzGKQmmhS/OXrcJHQotqq/g0j5I=
Received: from CY4PR11MB1432.namprd11.prod.outlook.com (2603:10b6:910:5::22)
 by CY4PR11MB1384.namprd11.prod.outlook.com (2603:10b6:903:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 06:46:27 +0000
Received: from CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a]) by CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a%4]) with mapi id 15.20.3153.027; Fri, 3 Jul 2020
 06:46:27 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 09/14] vfio/type1: Support binding guest page tables to
 PASID
Thread-Topic: [PATCH v3 09/14] vfio/type1: Support binding guest page tables
 to PASID
Thread-Index: AQHWSgRRwNgRMunGUEedAhlBOpGfgKj02PaAgACZO7A=
Date: Fri, 3 Jul 2020 06:46:26 +0000
Message-ID: <CY4PR11MB14324A4BACDD3D39CD965333C36A0@CY4PR11MB1432.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-10-git-send-email-yi.l.liu@intel.com>
 <20200702151941.2bc63f10@x1.home>
In-Reply-To: <20200702151941.2bc63f10@x1.home>
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
x-ms-office365-filtering-correlation-id: da142363-4c62-46ca-e281-08d81f1ccf52
x-ms-traffictypediagnostic: CY4PR11MB1384:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB13845845DB5EAC0EABAB4E08C36A0@CY4PR11MB1384.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTWaiik77cZjW4Ckj8mwINUuZuiGmDPvoKe/Jm5lNJhjgRgV6105N+nuKKhCRU7w9IrZJKIyJHsYVh6yabV8Ud3VvCBQfGxaEB69d/YQaneGDKkfye6Gi8g0X4R3s3ipEstyi6cbij4bdXdTHBvCpMjqSyvOpIFJhKkzVoGpyRMfUchFd6Od33Q64TnpyY2ZMYApiX90fvWag0xN265rxn1+ia+odRC0DXgbyCIJmI6uvlVwVu3GWcSWql6niqvuHNuznhAF/4+ejNWm9LTVrlwAH44Ee0eQwlS9NpBSiNX1E6XCT/aOWnhysPm9eHWvBrPuFxu+SbhGaA69T1cJXM+e70SBSuLEl+ZfKOA5mtJXFz5yGK40CH8NPyj+mE/GoS40IPnXB/QdMhzLS1VWtA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(54906003)(186003)(316002)(52536014)(478600001)(8676002)(4326008)(2906002)(55016002)(7416002)(9686003)(30864003)(66556008)(66476007)(66446008)(64756008)(8936002)(7696005)(5660300002)(76116006)(6506007)(6916009)(966005)(86362001)(83380400001)(26005)(66946007)(71200400001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: e4IbUAa2o2Hd032z8O+PCLwZNyTQNf6+ykFFVtkYMxPDDpUs7I0celyWTD4pEqG75QekQOzpzFWbxxW7syKttMSLVbu+bNdzBxVwbcijLeTsR43Jk89dG0h4Bi1wwVfBHe1dzI7nqwRMXw2IdvbN+CaTrqYXo7S2k2g1vFslaH6j4LDiGljin0n+O1hZQQoEoRTatd2wj9Jv5lh/iBtibaa83dt6KAFC51C5FJrUDQqEidSNkxJ/FysmT8hYmtdAY92/AMAqxF2flY5mc2jF57VqVvQOJGjfMLfBy/VTz/TNDLj7rIgocmc3ZXs0hQ82kwltvLco2k+QhoDQhuldjOPvm/2w4y0yBHIeJkiCbyNVYO9RrVGWYIZutv7NRHxeFmOL1DajYjgn4a80WiI222gAIqkUv2K7Q7ZfGeiK6IQOiCo/smpm3vDbGNiEK8zWrS0iSXQl0bwDbbEvGjY5EdXIfIxiDZKzY85SSlDe0hosFRUurVrNjEahB34JPq6A
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da142363-4c62-46ca-e281-08d81f1ccf52
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 06:46:26.7997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHiFRyzFLNnxh7i7CpEDKpuTsDyh6/FQpnGke/grUrXbYh1gclnudJoHs7gjzCy88ULFy4AFby7V5c6u/hkHSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1384
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>
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

Hi Alex,

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, July 3, 2020 5:20 AM
> 
> On Wed, 24 Jun 2020 01:55:22 -0700
> Liu Yi L <yi.l.liu@intel.com> wrote:
> 
> > Nesting translation allows two-levels/stages page tables, with 1st
> > level for guest translations (e.g. GVA->GPA), 2nd level for host
> > translations (e.g. GPA->HPA). This patch adds interface for binding
> > guest page tables to a PASID. This PASID must have been allocated to
> > user space before the binding request.
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
> > v2 -> v3:
> > *) use __iommu_sva_unbind_gpasid() for unbind call issued by VFIO
> > https://lore.kernel.org/linux-iommu/1592931837-58223-6-git-send-email-
> > jacob.jun.pan@linux.intel.com/
> >
> > v1 -> v2:
> > *) rename subject from "vfio/type1: Bind guest page tables to host"
> > *) remove VFIO_IOMMU_BIND, introduce VFIO_IOMMU_NESTING_OP to
> support bind/
> >    unbind guet page table
> > *) replaced vfio_iommu_for_each_dev() with a group level loop since this
> >    series enforces one group per container w/ nesting type as start.
> > *) rename vfio_bind/unbind_gpasid_fn() to
> > vfio_dev_bind/unbind_gpasid_fn()
> > *) vfio_dev_unbind_gpasid() always successful
> > *) use vfio_mm->pasid_lock to avoid race between PASID free and page table
> >    bind/unbind
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 169
> ++++++++++++++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_pasid.c       |  30 +++++++
> >  include/linux/vfio.h            |  20 +++++
> >  include/uapi/linux/vfio.h       |  30 +++++++
> >  4 files changed, 249 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index d0891c5..5926533 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -148,6 +148,33 @@ struct vfio_regions {
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
> > +static struct vfio_group *vfio_find_nesting_group(struct vfio_iommu
> > +*iommu) {
> > +	struct vfio_domain *d;
> > +	struct vfio_group *g, *group = NULL;
> > +
> > +	if (!iommu->nesting_info)
> > +		return NULL;
> > +
> > +	/* only support singleton container with nesting type */
> > +	list_for_each_entry(d, &iommu->domain_list, next) {
> > +		list_for_each_entry(g, &d->group_list, next) {
> > +			if (!group) {
> > +				group = g;
> > +				break;
> > +			}
> 
> 
> We break out of the inner loop only to pointlessly continue in the outer loop
> when we could simply return g and remove the second group pointer altogether
> (use "group" instead of "g" if so).

how about below? :-)

	/* only support singleton container with nesting type */
	list_for_each_entry(d, &iommu->domain_list, next) {
		list_for_each_entry(group, &d->group_list, next) {
			break;
		}
	}

> 
> > +		}
> > +	}
> > +	return group;
> > +}
> > +
> >  static int put_pfn(unsigned long pfn, int prot);
> >
> >  static struct vfio_group *vfio_iommu_find_iommu_group(struct
> > vfio_iommu *iommu, @@ -2351,6 +2378,48 @@ static int
> vfio_iommu_resv_refresh(struct vfio_iommu *iommu,
> >  	return ret;
> >  }
> >
> > +static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data) {
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	unsigned long arg = *(unsigned long *) dc->data;
> > +
> > +	return iommu_sva_bind_gpasid(dc->domain, dev, (void __user *) arg);
> > +}
> > +
> > +static int vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	unsigned long arg = *(unsigned long *) dc->data;
> > +
> > +	iommu_sva_unbind_gpasid(dc->domain, dev, (void __user *) arg);
> > +	return 0;
> > +}
> > +
> > +static int __vfio_dev_unbind_gpasid_fn(struct device *dev, void
> > +*data) {
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	struct iommu_gpasid_bind_data *unbind_data =
> > +				(struct iommu_gpasid_bind_data *) dc->data;
> > +
> > +	__iommu_sva_unbind_gpasid(dc->domain, dev, unbind_data);
> > +	return 0;
> > +}
> > +
> > +static void vfio_group_unbind_gpasid_fn(ioasid_t pasid, void *data) {
> > +	struct domain_capsule *dc = (struct domain_capsule *) data;
> > +	struct iommu_gpasid_bind_data unbind_data;
> > +
> > +	unbind_data.argsz = offsetof(struct iommu_gpasid_bind_data, vendor);
> > +	unbind_data.flags = 0;
> > +	unbind_data.hpasid = pasid;
> > +
> > +	dc->data = &unbind_data;
> > +
> > +	iommu_group_for_each_dev(dc->group->iommu_group,
> > +				 dc, __vfio_dev_unbind_gpasid_fn); }
> > +
> >  static void vfio_iommu_type1_detach_group(void *iommu_data,
> >  					  struct iommu_group *iommu_group)
> { @@ -2394,6 +2463,21 @@
> > static void vfio_iommu_type1_detach_group(void *iommu_data,
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
> > @@ -2942,6 +3026,89 @@ static int vfio_iommu_type1_pasid_request(struct
> vfio_iommu *iommu,
> >  	}
> >  }
> >
> > +static long vfio_iommu_handle_pgtbl_op(struct vfio_iommu *iommu,
> > +				       bool is_bind, unsigned long arg) {
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
> > +		ret = -ENOTSUPP;
> > +		goto out_unlock_iommu;
> > +	}
> > +
> > +	if (!iommu->vmm) {
> > +		ret = -EINVAL;
> > +		goto out_unlock_iommu;
> > +	}
> > +
> > +	group = vfio_find_nesting_group(iommu);
> > +	if (!group) {
> > +		ret = -EINVAL;
> > +		goto out_unlock_iommu;
> > +	}
> > +
> > +	domain = list_first_entry(&iommu->domain_list,
> > +				      struct vfio_domain, next);
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
> > +			iommu_group_for_each_dev(group->iommu_group,
> &dc,
> > +						 vfio_dev_unbind_gpasid_fn);
> > +	} else {
> > +		iommu_group_for_each_dev(group->iommu_group,
> > +					 &dc, vfio_dev_unbind_gpasid_fn);
> > +		ret = 0;
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
> >  				   unsigned int cmd, unsigned long arg)  { @@ -
> 2960,6 +3127,8 @@
> > static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  		return vfio_iommu_type1_dirty_pages(iommu, arg);
> >  	case VFIO_IOMMU_PASID_REQUEST:
> >  		return vfio_iommu_type1_pasid_request(iommu, arg);
> > +	case VFIO_IOMMU_NESTING_OP:
> > +		return vfio_iommu_type1_nesting_op(iommu, arg);
> >  	}
> >
> >  	return -ENOTTY;
> > diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
> > index 2ea9f1a..20f1e72 100644
> > --- a/drivers/vfio/vfio_pasid.c
> > +++ b/drivers/vfio/vfio_pasid.c
> > @@ -30,6 +30,7 @@ struct vfio_mm {
> >  	struct kref		kref;
> >  	struct vfio_mm_token	token;
> >  	int			ioasid_sid;
> > +	struct mutex		pasid_lock;
> 
> 
> Introducing holes in the data structure again, mind the alignment.
> This wastes 8 byte.  Thanks,

sure. also it's likely to remove @pasid_quota. so it should avoid the
hole as well.

Regards,
Yi Liu

> Alex
> 
> 
> >  	int			pasid_quota;
> >  	struct list_head	next;
> >  };
> > @@ -97,6 +98,7 @@ struct vfio_mm *vfio_mm_get_from_task(struct
> task_struct *task)
> >  	kref_init(&vmm->kref);
> >  	vmm->token.val = (unsigned long long) mm;
> >  	vmm->pasid_quota = pasid_quota;
> > +	mutex_init(&vmm->pasid_lock);
> >
> >  	list_add(&vmm->next, &vfio_pasid.vfio_mm_list);
> >  out:
> > @@ -134,12 +136,40 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  	 * IOASID core will notify PASID users (e.g. IOMMU driver) to
> >  	 * teardown necessary structures depending on the to-be-freed
> >  	 * PASID.
> > +	 * Hold pasid_lock to avoid race with PASID usages like bind/
> > +	 * unbind page tables to requested PASID.
> >  	 */
> > +	mutex_lock(&vmm->pasid_lock);
> >  	for (; pasid <= max; pasid++)
> >  		ioasid_free(pasid);
> > +	mutex_unlock(&vmm->pasid_lock);
> >  }
> >  EXPORT_SYMBOL_GPL(vfio_pasid_free_range);
> >
> > +int vfio_mm_for_each_pasid(struct vfio_mm *vmm, void *data,
> > +			   void (*fn)(ioasid_t id, void *data)) {
> > +	int ret;
> > +
> > +	mutex_lock(&vmm->pasid_lock);
> > +	ret = ioasid_set_for_each_ioasid(vmm->ioasid_sid, fn, data);
> > +	mutex_unlock(&vmm->pasid_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_for_each_pasid);
> > +
> > +void vfio_mm_pasid_lock(struct vfio_mm *vmm) {
> > +	mutex_lock(&vmm->pasid_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_pasid_lock);
> > +
> > +void vfio_mm_pasid_unlock(struct vfio_mm *vmm) {
> > +	mutex_unlock(&vmm->pasid_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_pasid_unlock);
> > +
> >  static int __init vfio_pasid_init(void)  {
> >  	mutex_init(&vfio_pasid.vfio_mm_lock);
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h index
> > 8e60a32..9028a09 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -105,6 +105,11 @@ int vfio_mm_ioasid_sid(struct vfio_mm *vmm);
> > extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
> > extern void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  					ioasid_t min, ioasid_t max);
> > +extern int vfio_mm_for_each_pasid(struct vfio_mm *vmm, void *data,
> > +				  void (*fn)(ioasid_t id, void *data)); extern void
> > +vfio_mm_pasid_lock(struct vfio_mm *vmm); extern void
> > +vfio_mm_pasid_unlock(struct vfio_mm *vmm);
> > +
> >  #else
> >  static inline struct vfio_mm *vfio_mm_get_from_task(struct
> > task_struct *task)  { @@ -129,6 +134,21 @@ static inline void
> > vfio_pasid_free_range(struct vfio_mm *vmm,
> >  					  ioasid_t min, ioasid_t max)
> >  {
> >  }
> > +
> > +static inline int vfio_mm_for_each_pasid(struct vfio_mm *vmm, void *data,
> > +					 void (*fn)(ioasid_t id, void *data)) {
> > +	return -ENOTTY;
> > +}
> > +
> > +static inline void vfio_mm_pasid_lock(struct vfio_mm *vmm) { }
> > +
> > +static inline void vfio_mm_pasid_unlock(struct vfio_mm *vmm) { }
> > +
> >  #endif /* CONFIG_VFIO_PASID */
> >
> >  /*
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 657b2db..2c9def8 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1198,6 +1198,36 @@ struct vfio_iommu_type1_pasid_request {
> >
> >  #define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 18)
> >
> > +/**
> > + * VFIO_IOMMU_NESTING_OP - _IOW(VFIO_TYPE, VFIO_BASE + 19,
> > + *				struct vfio_iommu_type1_nesting_op)
> > + *
> > + * This interface allows user space to utilize the nesting IOMMU
> > + * capabilities as reported through VFIO_IOMMU_GET_INFO.
> > + *
> > + * @data[] types defined for each op:
> > + *
> +=================+===========================================
> ====+
> > + * | NESTING OP      |                  @data[]                      |
> > + *
> +=================+===========================================
> ====+
> > + * | BIND_PGTBL      |      struct iommu_gpasid_bind_data            |
> > + * +-----------------+-----------------------------------------------+
> > + * | UNBIND_PGTBL    |      struct iommu_gpasid_bind_data            |
> > + *
> > ++-----------------+-----------------------------------------------+
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
> > +#define VFIO_IOMMU_NESTING_OP		_IO(VFIO_TYPE,
> VFIO_BASE + 19)
> > +
> >  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU
> > -------- */
> >
> >  /*

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
