Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10028C433E0
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 07:20:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D508E207DF
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 07:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="RV1FOv8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D508E207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9BFB286BBD;
	Mon, 20 Jul 2020 07:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V3HAS5Ws5F35; Mon, 20 Jul 2020 07:20:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CAF1F8666F;
	Mon, 20 Jul 2020 07:20:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB077C089F;
	Mon, 20 Jul 2020 07:20:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D60B7C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 07:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B95F22107A
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 07:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B-lkKKczTg8w for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 07:20:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 3498F2083F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 07:20:42 +0000 (UTC)
IronPort-SDR: lq8oAa6tNcU1QQXT5PORWqSMY2SS+c4WmP4/JhdVT98C7u444lXortJGrvc9au8EZw/aZ+daPz
 fGxdc/Y/6OIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="151209757"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="151209757"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 00:20:41 -0700
IronPort-SDR: OhayfH2uMfthA5db7dh0ksWVGis0yVJeFLZ9Y6mKctrqpaPhcR/tvnhz5OHEMLsOGy44Uri4O4
 78BL4e7Z/hOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="361940056"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by orsmga001.jf.intel.com with ESMTP; 20 Jul 2020 00:20:41 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 00:20:40 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 00:20:40 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.59) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 20 Jul 2020 00:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOB0X4/3eNok1obl0W91CJ5nATFUjKoPXsJUJCRn2voppLFu//TKijZaXx1oKuGfiODl6cLBHVMFSU3JP9hmWy7mtKYogwQSsC7ZgCqcuuCyF83dqnXKHqNlHL9DAtnVcKZocnIGSELt59VV5vlbPOnfdJzA/8CgQYv3auR7GzAnEeoTTBMrVtzHowyGFfmfVprDtX8GvHapv8Bvz7FzW32ivvxKbS6d+5nWRw8hm12i5C4WRDTdQ/limDvub0V5ojWk1+J7mYeC8uAoxOmIvPLn1fRD0aDhONQYu4RYq6/D9yBIrqyB/k5zbXMU2xCKBxoGjHCXpWCyVGIZBnnb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W0daj2ef5suQ7niJxvtakKtD1Z6zjFx5uiVU6kvud4=;
 b=BwBiXnjgkofhyfNJ0LIGKhG8P75tmt0KlIDcNbwBAxkoM/3FNbjTW/XzlYnCyBrogJNsv4Yz9W0KaMSXGOkT6q8KFiuFkyDgkzQoAfFp+zXohnBusgmXQOcaKCe3Uvj7a+wQKp2vv89Hx9WbCOaBCZ4CEg+jDXtgu+NTo27GdOfNDWhwZRA3k1oUw5jf2to4RqmIGaqG0J9Bk2Epskx5chnlJ+6woEJfDDyU4q9Moh0lm0i3dApM3jwjiUpYudEyLAfkNNttBM/FWkS6P2QBWqH0/0augL4oTGU4ZsrZ03OeiMsEwWcDEgbvOBzpiZDzIyfOrCDhZ1jqDlEKgVLsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W0daj2ef5suQ7niJxvtakKtD1Z6zjFx5uiVU6kvud4=;
 b=RV1FOv8XP8HJFZHUdTv8FrkeCD2nzL1wa/wbeJnZrYdH+rhn2iwKCnev6QJX60s5ZXUPkx6gIq9bAufxvbpSACozM+uoxj7LoTMbliqfu61GqRjTQIyOwpoOfh1HItIE2rbye062haieK6YOK4vpXA/kD036VXFXvhXF/97dseg=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.23; Mon, 20 Jul 2020 07:20:27 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 07:20:27 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 02/15] iommu: Report domain nesting info
Thread-Topic: [PATCH v5 02/15] iommu: Report domain nesting info
Thread-Index: AQHWWD2l24VL7ljS90uDgo6kI5uKT6kL/mYAgAQRbLA=
Date: Mon, 20 Jul 2020 07:20:27 +0000
Message-ID: <DM5PR11MB1435E32D70ED3BB1BF56F94AC37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-3-git-send-email-yi.l.liu@intel.com>
 <99c20ada-b7e8-44f6-e036-ab905d119119@redhat.com>
In-Reply-To: <99c20ada-b7e8-44f6-e036-ab905d119119@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2baf3bec-cf34-40f4-8deb-08d82c7d60b3
x-ms-traffictypediagnostic: DM6PR11MB4722:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4722EB05FC9643C3299100F0C37B0@DM6PR11MB4722.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TthiII4+Pps/bGOR5xs12nJGp0COCjn5NNsM4yKD+riJeFMDcIr8b/n9NVeVVnvfcMJE6QpXqNP4rW+PGZLclsO9uUsQ1/vSpjC34v6MmjbiHrXyB3de6cn4+ujoXLzK7jHdP8RKSBuNPX2ARwPPSeHHXmdQj1wy31hFomhqjYKHEpNnuzqfV9nbsgqT0h7j+yCc9PPL7KUrEYtem4EWbmmSpYsaQ6beG4yOETx9UG/Oa0N090KLbZ/XUbnS8DqqFQzCZfdhgDVf+y+ROldk5Quey0WkfdJ+PrVnX4W3ltDOmXahqOXk3ETL/8qFXuAkyHshz38nyGhAtW5NFxgb6OGsNNhINTrw8wj0y/cQ0HhXlqdC43fTQTnwO3jlLTrPznU7R9+EA3g7gxAuLgEC4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(66946007)(66556008)(76116006)(966005)(64756008)(66476007)(7696005)(55016002)(86362001)(2906002)(9686003)(66446008)(7416002)(8676002)(83380400001)(8936002)(26005)(186003)(33656002)(53546011)(6506007)(52536014)(54906003)(110136005)(71200400001)(5660300002)(4326008)(316002)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: A6s5e0nZcxnmcrR2TUsu3EEtdUiwz36dsX+/XFVgXRFNMlJg2HAmgTUttm1E88F+fPziMrbphyefNpnVGE7A5fhph69hCwgBgK2zAZj0yVpB+nfiV+Wc7gZU9oOzywGa4f/ebMhYuVQYVca4GKxgXgBxPvl3Z6vg0zN4OWq1NYwIGV3IvKrC2ltDS/M0KKIDYo5ZAWVlA6eGZiC7eM85rM+RDiWYmkH2txFVcw1/9YCIkQ+4YAfLa3A8tew0B/HbEb1R8eG83O9npFoO0nv7vV704hV52rtBugYDgH51xhhowCihbjJb9cCVJCti0ITXzdDdVTNHNfUV1zI+CQ2KqoXCv4wJ0RKV0tkUdvaWgveE3+cPO0GzFoFPddA3rdIqfu3TBnc/FjtQlPmhQ6oes/KllXzfrrLnWjUYhZpSfLcsqHuzFoiJH0iDiiITs18JKH3A8zJZ6kfpDB4SI3cFnN+I0DFj0Uox1jxz49VcNrfOr0tmyv7T4/TN6lNnPmfm
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baf3bec-cf34-40f4-8deb-08d82c7d60b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 07:20:27.6280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYw02umRKVyAIDCzHuK7pfZ38svyF3lc3nRlYqbeBY+2Q6ZwTGPO+fpMEQlvq1CrSDz+Nyfn4yxfSgrX3k1tog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4722
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
> Sent: Saturday, July 18, 2020 12:29 AM
> 
> Hi Yi,
> 
> On 7/12/20 1:20 PM, Liu Yi L wrote:
> > IOMMUs that support nesting translation needs report the capability info
> s/needs/need to report

yep.

> > to userspace, e.g. the format of first level/stage paging structures.
> It gives information about requirements the userspace needs to implement
> plus other features characterizing the physical implementation.

got it. will add it in next version.

> >
> > This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can get
> > nesting info after setting DOMAIN_ATTR_NESTING.
> I guess you meant after selecting VFIO_TYPE1_NESTING_IOMMU?

yes, it is. ok, perhaps, it's better to say get nesting info after selecting
VFIO_TYPE1_NESTING_IOMMU.

> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v4 -> v5:
> > *) address comments from Eric Auger.
> >
> > v3 -> v4:
> > *) split the SMMU driver changes to be a separate patch
> > *) move the @addr_width and @pasid_bits from vendor specific
> >    part to generic part.
> > *) tweak the description for the @features field of struct
> >    iommu_nesting_info.
> > *) add description on the @data[] field of struct iommu_nesting_info
> >
> > v2 -> v3:
> > *) remvoe cap/ecap_mask in iommu_nesting_info.
> > *) reuse DOMAIN_ATTR_NESTING to get nesting info.
> > *) return an empty iommu_nesting_info for SMMU drivers per Jean'
> >    suggestion.
> > ---
> >  include/uapi/linux/iommu.h | 77
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 1afc661..d2a47c4 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -332,4 +332,81 @@ struct iommu_gpasid_bind_data {
> >  	} vendor;
> >  };
> >
> > +/*
> > + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
> > + *			       user space should check it before using
> > + *			       nesting capability.
> > + *
> > + * @size:	size of the whole structure
> > + * @format:	PASID table entry format, the same definition as struct
> > + *		iommu_gpasid_bind_data @format.
> > + * @features:	supported nesting features.
> > + * @flags:	currently reserved for future extension.
> > + * @addr_width:	The output addr width of first level/stage translation
> > + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
> > + *		support.
> > + * @data:	vendor specific cap info. data[] structure type can be deduced
> > + *		from @format field.
> > + *
> > + *
> +===============+===================================================
> ===+
> > + * | feature       |  Notes                                               |
> > + *
> +===============+===================================================
> ===+
> > + * | SYSWIDE_PASID |  PASIDs are managed in system-wide, instead of per   |
> s/in system-wide/system-wide ?

got it.

> > + * |               |  device. When a device is assigned to userspace or   |
> > + * |               |  VM, proper uAPI (userspace driver framework uAPI,   |
> > + * |               |  e.g. VFIO) must be used to allocate/free PASIDs for |
> > + * |               |  the assigned device.
> Isn't it possible to be more explicit, something like:
>                       |
> System-wide PASID management is mandated by the physical IOMMU. All
> PASIDs allocation must be mediated through the TBD API.

yep, I can add it.

> > + * +---------------+------------------------------------------------------+
> > + * | BIND_PGTBL    |  The owner of the first level/stage page table must  |
> > + * |               |  explicitly bind the page table to associated PASID  |
> > + * |               |  (either the one specified in bind request or the    |
> > + * |               |  default PASID of iommu domain), through userspace   |
> > + * |               |  driver framework uAPI (e.g. VFIO_IOMMU_NESTING_OP). |
> As per your answer in https://lkml.org/lkml/2020/7/6/383, I now
> understand ARM would not expose that BIND_PGTBL nesting feature,

yes, that's my point.

> I still
> think the above wording is a bit confusing. Maybe you may explicitly
> talk about the PASID *entry* that needs to be passed from guest to host.
> On ARM we directly pass the PASID table but when reading the above
> description I fail to determine if this does not fit that description.

yes, I can do it.

> > + * +---------------+------------------------------------------------------+
> > + * | CACHE_INVLD   |  The owner of the first level/stage page table must  |
> > + * |               |  explicitly invalidate the IOMMU cache through uAPI  |
> > + * |               |  provided by userspace driver framework (e.g. VFIO)  |
> > + * |               |  according to vendor-specific requirement when       |
> > + * |               |  changing the page table.                            |
> > + * +---------------+------------------------------------------------------+
> 
> instead of using the "uAPI provided by userspace driver framework (e.g.
> VFIO)", can't we use the so-called IOMMU UAPI terminology which now has
> a userspace documentation?

the problem is current IOMMU UAPI definitions is actually embedded in
other VFIO UAPI. if it can make the description more clear, I can follow
your suggestion. :-)

> 
> > + *
> > + * @data[] types defined for @format:
> > + *
> +================================+==================================
> ===+
> > + * | @format                        | @data[]                             |
> > + *
> +================================+==================================
> ===+
> > + * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd       |
> > + * +--------------------------------+-------------------------------------+
> > + *
> > + */
> > +struct iommu_nesting_info {
> > +	__u32	size;
> shouldn't it be @argsz to fit the iommu uapi convention and take benefit
> to put the flags field just below?

make sense.

> > +	__u32	format;
> > +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> > +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> > +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> > +	__u32	features;
> > +	__u32	flags;
> > +	__u16	addr_width;
> > +	__u16	pasid_bits;
> > +	__u32	padding;
> > +	__u8	data[];
> > +};
> > +
> > +/*
> > + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info
> > + *
> > + * @flags:	VT-d specific flags. Currently reserved for future
> > + *		extension.
> must be set to 0?

yes. will add it.

Thanks,
Yi Liu

> > + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
> > + *		register.
> > + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> > + *		extended capability register.
> > + */
> > +struct iommu_nesting_info_vtd {
> > +	__u32	flags;
> > +	__u32	padding;
> > +	__u64	cap_reg;
> > +	__u64	ecap_reg;
> > +};
> > +
> >  #endif /* _UAPI_IOMMU_H */
> Thanks
> 
> Eric
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
