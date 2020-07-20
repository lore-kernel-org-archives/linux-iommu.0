Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBCCC433DF
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 08:56:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956FF2080D
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 08:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="iVyEk1tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956FF2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5EE8585EC1;
	Mon, 20 Jul 2020 08:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WVoq68WMOcY5; Mon, 20 Jul 2020 08:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BFD985EAF;
	Mon, 20 Jul 2020 08:56:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57C0DC0894;
	Mon, 20 Jul 2020 08:56:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F932C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 17FBE2107F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L9R2+CS0C+Mq for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 08:56:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 50D96204A1
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:56:29 +0000 (UTC)
IronPort-SDR: 0uef6Z0y6kvTu5rI0QUz0kDpAk+nyrMuucSBJRc23BbxuvAaqRfBI4yEwDH5BhjsaItWMafCQZ
 fb1dSmkTeZXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="214557469"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="214557469"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 01:56:28 -0700
IronPort-SDR: QdnT6yWfcqaoCdeuAdxmyIQq9iCXEOmyfLU+LmgrzxKrnC7/q/ylrg+fg/W+Vj5wFblLSjP13i
 1oOaGa8xXDjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="327467837"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by orsmga007.jf.intel.com with ESMTP; 20 Jul 2020 01:56:28 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 01:56:28 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX116.amr.corp.intel.com (10.22.240.14) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 01:56:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 01:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYoPpIGeBgDdZaWAlJTfgFAZlQC6uHSveN32h9OQrp/hPMuixSjDT92Bp+/FWwXqEKBa/zxzEzkT1DIPgdmPFhTGWkbJBU7T2gpFDRUtMjP92XOTQXSQ9+U+l/g5CjX0Mc3V93dsLD10C/QIBpg4qUKJO3TN+3aSo7aTn7yVBH9BAqGQ52/VjwUVl8Sv2jlul3o0mYns/bjBYcL15iMftbP2eC5muEHI142WsVR0MMpYs9w5n3acD/QC+DzRXUUbuq0q/dOHWk513jEum+qahEzmnMEKx4pQZbjJCfFnt8MMaJXGPfkon1wHNeYPXy1o2jrPyaXsJaImL9HDBpePwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCr4/WD7eudKHgbfMKsrVSfaV4EaD1xbGzNdicODRlg=;
 b=npJjUh5XYlxU1u1lzXVfPIRh5lf+IVDCONHRrirmo+ggaSAqp4xTUkbboOnbE3CMpOvg5iTMzeH3H6LWU7XBAnPR4loZGSM2iKUYIRZdW7sJVjwRkN84TNJNTsITLlWLa5/HVM7yndrBLRh3EN17AAYqKniQ98PWj35KsalVtanBdfOzsiNmK2PRHgB1LBDmRhoghGYDH4mQKa6VaYC5Nu0ExNq8YlwsLABmbenDGPGYcGduE4SA40/jTuQKOBtxIPTkOlUXyckZkzJQWuuHuxNrP2hFA5wl5tRSYfDvZ9wC4NBZ+OtroZDfl4P3lwM3jKktyt2ZleQSiM8RVaC5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCr4/WD7eudKHgbfMKsrVSfaV4EaD1xbGzNdicODRlg=;
 b=iVyEk1tqZTVLA/yFDRbu0lT9nZ7f0vDbs74UL0THQ17+8c+F7O1jnVh1vKyeyRMTTo3p5FkgKrycpZbdK/uSrOzdkQjHlV8V7y9Qsx86S1XEgcwJUvSlKQkD+FpPlidHoOxVE5UrCZ7iCWMYjtPaEz1NpdaxKNLUnjHFLM5zaqU=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1580.namprd11.prod.outlook.com (2603:10b6:4:10::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Mon, 20 Jul 2020 08:56:26 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 08:56:26 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 07/15] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Topic: [PATCH v5 07/15] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Index: AQHWWD2nYKBu6Gwf40GbEJAh2ZBN9KkPFO6AgAEg6mA=
Date: Mon, 20 Jul 2020 08:56:26 +0000
Message-ID: <DM5PR11MB14358F4CB0AF28568DB1406EC37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-8-git-send-email-yi.l.liu@intel.com>
 <6199a51b-3459-c596-e651-bb30d3b3d645@redhat.com>
In-Reply-To: <6199a51b-3459-c596-e651-bb30d3b3d645@redhat.com>
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
x-ms-office365-filtering-correlation-id: d21e1a0f-c269-4258-3405-08d82c8ac921
x-ms-traffictypediagnostic: DM5PR11MB1580:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1580B1A2DE58D0852F144E1EC37B0@DM5PR11MB1580.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Xg2lhrIw7QuHu6S74PRmrj/P8qAUPmUKC11Il0dx/3SMJhJWbEHrvTyAi5mp6ZZ0dbk9i0+8IqP+0KY+w4QU4St320MYIgjbBKuu+EX2KvK+TMLPOX5heKBaJhQGovDwGG2S8lintPrUemnLpSlNfFiqfys0FkA7sYjmGC9VRnr654SHGBwQ/P96ID8KEB8T9E8pmD/0wB+7DL8Ns+S4Y89TWXLhKVQdF/X+spPVk8c3NMSf2mZgfpra9xcD8KrRcqGYvwbv2S25q5TZZovmEkzP/Klb32adkKoDehOqYpvZ2FDtr6oZng7jdm5qAQOhHlffooWiCIr4OnBTQjgzoK3A+cHQ4O0+sMHLyldDSgPv/PT7VEjlqAxJjauOmzJ7P4vn7bEajDdRFGR4kwsJw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(30864003)(54906003)(110136005)(2906002)(9686003)(5660300002)(8936002)(83380400001)(4326008)(316002)(478600001)(86362001)(8676002)(33656002)(66476007)(66556008)(186003)(66446008)(53546011)(6506007)(52536014)(55016002)(76116006)(71200400001)(7696005)(26005)(7416002)(64756008)(966005)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: XVfH7HjxYCtaN0ub0INWIEWW8ImVit/e5PluRmW6zfi6PIIE02DKK/GyHsSX9SZ/Kr+gv2/aMCRfKot+FzYEwl61gNzhkQWIpUfMx5G5SEe4ns0pYgR1zCsr7IomNqYpGjHh8IfRbuVJCpQVURyONsOrGSL/3HDwhjpOaAd1k4/jg22lv8ILQC8vYIN7PFmrkJSHXsAL16TYYWwy14uNULLpBS5uTIxnrF+Wcc5DBCtty1METC6qHu7HfOBSoO9FUSW9rXiLdUkYeGOg4VD5urCHFWGWNMKYuZbl2Qi0u9/AJ0879NQaNv1SGqrT2mb9zJN/BHb3ElG1V1Dk1+EekIIpr4CJVZ9Vn96aWJEm/lAHhTP1BbDz/eyXhMStrWp/9U3gta8RYUTEXcGBZXbOsnXju3Esy7ZBVApEbe4fdnm0Jg17ONRoGIoZ+XNShwRPHEN6hGkFw2rx34SltaNc8RpCalbTg83oe9H5TgdYE6vzgRyLiGyaKD8Dqny5Cgl9
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21e1a0f-c269-4258-3405-08d82c8ac921
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:56:26.2401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cghCq4XY5i6ey8L3zZWvZVjpy+AKqxAQlA2KVkqV1m2jfk9SnRwELwkoiHJEuPi6hyCThI2vV4D59CzvmRQkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1580
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
> Sent: Sunday, July 19, 2020 11:39 PM
> 
> Yi,
> 
> On 7/12/20 1:21 PM, Liu Yi L wrote:
> > This patch allows user space to request PASID allocation/free, e.g.
> > when serving the request from the guest.
> >
> > PASIDs that are not freed by userspace are automatically freed when
> > the IOASID set is destroyed when process exits.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v4 -> v5:
> > *) address comments from Eric Auger.
> > *) the comments for the PASID_FREE request is addressed in patch 5/15 of
> >    this series.
> >
> > v3 -> v4:
> > *) address comments from v3, except the below comment against the range
> >    of PASID_FREE request. needs more help on it.
> >     "> +if (req.range.min > req.range.max)
> >
> >     Is it exploitable that a user can spin the kernel for a long time in
> >     the case of a free by calling this with [0, MAX_UINT] regardless of
> >     their actual allocations?"
> >
> > https://lore.kernel.org/linux-iommu/20200702151832.048b44d1@x1.home/
> >
> > v1 -> v2:
> > *) move the vfio_mm related code to be a seprate module
> > *) use a single structure for alloc/free, could support a range of
> > PASIDs
> > *) fetch vfio_mm at group_attach time instead of at iommu driver open
> > time
> > ---
> >  drivers/vfio/Kconfig            |  1 +
> >  drivers/vfio/vfio_iommu_type1.c | 85
> +++++++++++++++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_pasid.c       | 10 +++++
> >  include/linux/vfio.h            |  6 +++
> >  include/uapi/linux/vfio.h       | 37 ++++++++++++++++++
> >  5 files changed, 139 insertions(+)
> >
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig index
> > 3d8a108..95d90c6 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -2,6 +2,7 @@
> >  config VFIO_IOMMU_TYPE1
> >  	tristate
> >  	depends on VFIO
> > +	select VFIO_PASID if (X86)
> >  	default n
> >
> >  config VFIO_IOMMU_SPAPR_TCE
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index ed80104..55b4065 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -76,6 +76,7 @@ struct vfio_iommu {
> >  	bool				dirty_page_tracking;
> >  	bool				pinned_page_dirty_scope;
> >  	struct iommu_nesting_info	*nesting_info;
> > +	struct vfio_mm			*vmm;
> >  };
> >
> >  struct vfio_domain {
> > @@ -1937,6 +1938,11 @@ static void vfio_iommu_iova_insert_copy(struct
> > vfio_iommu *iommu,
> >
> >  static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
> > {
> > +	if (iommu->vmm) {
> > +		vfio_mm_put(iommu->vmm);
> > +		iommu->vmm = NULL;
> > +	}
> > +
> >  	kfree(iommu->nesting_info);
> >  	iommu->nesting_info = NULL;
> >  }
> > @@ -2071,6 +2077,26 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  					    iommu->nesting_info);
> >  		if (ret)
> >  			goto out_detach;
> > +
> > +		if (iommu->nesting_info->features &
> > +					IOMMU_NESTING_FEAT_SYSWIDE_PASID)
> {
> > +			struct vfio_mm *vmm;
> > +			int sid;
> > +
> > +			vmm = vfio_mm_get_from_task(current);
> > +			if (IS_ERR(vmm)) {
> > +				ret = PTR_ERR(vmm);
> > +				goto out_detach;
> > +			}
> > +			iommu->vmm = vmm;
> > +
> > +			sid = vfio_mm_ioasid_sid(vmm);
> > +			ret = iommu_domain_set_attr(domain->domain,
> > +						    DOMAIN_ATTR_IOASID_SID,
> > +						    &sid);
> > +			if (ret)
> > +				goto out_detach;
> > +		}
> >  	}
> >
> >  	/* Get aperture info */
> > @@ -2855,6 +2881,63 @@ static int vfio_iommu_type1_dirty_pages(struct
> vfio_iommu *iommu,
> >  	return -EINVAL;
> >  }
> >
> > +static int vfio_iommu_type1_pasid_alloc(struct vfio_iommu *iommu,
> > +					unsigned int min,
> > +					unsigned int max)
> > +{
> > +	int ret = -EOPNOTSUPP;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (iommu->vmm)
> > +		ret = vfio_pasid_alloc(iommu->vmm, min, max);
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> > +static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
> > +				       unsigned int min,
> > +				       unsigned int max)
> > +{
> > +	int ret = -EOPNOTSUPP;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (iommu->vmm) {
> > +		vfio_pasid_free_range(iommu->vmm, min, max);
> > +		ret = 0;
> > +	}
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> > +static int vfio_iommu_type1_pasid_request(struct vfio_iommu *iommu,
> > +					  unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_pasid_request req;
> > +	unsigned long minsz;
> > +
> > +	minsz = offsetofend(struct vfio_iommu_type1_pasid_request, range);
> > +
> > +	if (copy_from_user(&req, (void __user *)arg, minsz))
> > +		return -EFAULT;
> > +
> > +	if (req.argsz < minsz || (req.flags & ~VFIO_PASID_REQUEST_MASK))
> > +		return -EINVAL;
> > +
> > +	if (req.range.min > req.range.max)
> > +		return -EINVAL;
> > +
> > +	switch (req.flags & VFIO_PASID_REQUEST_MASK) {
> > +	case VFIO_IOMMU_FLAG_ALLOC_PASID:
> not sure it is worth to introduce both vfio_iommu_type1_pasid_free/alloc
> helpers. You could take the lock above, and test iommu->vmm as well above.

nice suggestion. thanks.

> > +		return vfio_iommu_type1_pasid_alloc(iommu,
> > +					req.range.min, req.range.max);
> > +	case VFIO_IOMMU_FLAG_FREE_PASID:
> > +		return vfio_iommu_type1_pasid_free(iommu,
> > +					req.range.min, req.range.max);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)  { @@ -
> 2871,6 +2954,8 @@
> > static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  		return vfio_iommu_type1_unmap_dma(iommu, arg);
> >  	case VFIO_IOMMU_DIRTY_PAGES:
> >  		return vfio_iommu_type1_dirty_pages(iommu, arg);
> > +	case VFIO_IOMMU_PASID_REQUEST:
> > +		return vfio_iommu_type1_pasid_request(iommu, arg);
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
> > index 66e6054e..ebec244 100644
> > --- a/drivers/vfio/vfio_pasid.c
> > +++ b/drivers/vfio/vfio_pasid.c
> > @@ -61,6 +61,7 @@ void vfio_mm_put(struct vfio_mm *vmm)  {
> >  	kref_put_mutex(&vmm->kref, vfio_mm_release, &vfio_mm_lock);  }
> > +EXPORT_SYMBOL_GPL(vfio_mm_put);
> >
> >  static void vfio_mm_get(struct vfio_mm *vmm)
> >  {
> > @@ -114,6 +115,13 @@ struct vfio_mm *vfio_mm_get_from_task(struct
> task_struct *task)
> >  	mmput(mm);
> >  	return vmm;
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
> > +
> > +int vfio_mm_ioasid_sid(struct vfio_mm *vmm)
> > +{
> > +	return vmm->ioasid_sid;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_ioasid_sid);
> >
> >  /*
> >   * Find PASID within @min and @max
> > @@ -197,6 +205,7 @@ int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> >
> >  	return pasid;
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_pasid_alloc);
> >
> >  void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  			   ioasid_t min, ioasid_t max)
> > @@ -213,6 +222,7 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  		vfio_remove_pasid(vmm, vid);
> >  	mutex_unlock(&vmm->pasid_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_pasid_free_range);
> >
> >  static int __init vfio_pasid_init(void)
> >  {
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index 31472a9..a111108 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -101,6 +101,7 @@ struct vfio_mm;
> >  #if IS_ENABLED(CONFIG_VFIO_PASID)
> >  extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
> >  extern void vfio_mm_put(struct vfio_mm *vmm);
> > +int vfio_mm_ioasid_sid(struct vfio_mm *vmm);
> I still don't get why it does not take an extern as the other functions
> implemented in vfio_pasid.c and used in other modules. what's the
> difference?

it's a mistake from me. should have "extern" :-)

> >  extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
> >  extern void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  				  ioasid_t min, ioasid_t max);
> > @@ -114,6 +115,11 @@ static inline void vfio_mm_put(struct vfio_mm *vmm)
> >  {
> >  }
> >
> > +static inline int vfio_mm_ioasid_sid(struct vfio_mm *vmm)
> > +{
> > +	return -ENOTTY;
> > +}
> > +
> >  static inline int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> >  {
> >  	return -ENOTTY;
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 46a78af..96a115f 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1172,6 +1172,43 @@ struct vfio_iommu_type1_dirty_bitmap_get {
> >
> >  #define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
> >
> > +/**
> > + * VFIO_IOMMU_PASID_REQUEST - _IOWR(VFIO_TYPE, VFIO_BASE + 18,
> > + *				struct vfio_iommu_type1_pasid_request)
> > + *
> > + * PASID (Processor Address Space ID) is a PCIe concept for tagging
> > + * address spaces in DMA requests. When system-wide PASID allocation
> > + * is required by underlying iommu driver (e.g. Intel VT-d), this
> by the underlying

got it.

> > + * provides an interface for userspace to request pasid alloc/free
> > + * for its assigned devices. Userspace should check the availability
> > + * of this API by checking VFIO_IOMMU_TYPE1_INFO_CAP_NESTING through
> > + * VFIO_IOMMU_GET_INFO.
> > + *
> > + * @flags=VFIO_IOMMU_FLAG_ALLOC_PASID, allocate a single PASID within
> @range.
> > + * @flags=VFIO_IOMMU_FLAG_FREE_PASID, free the PASIDs within @range.
> > + * @range is [min, max], which means both @min and @max are inclusive.
> > + * ALLOC_PASID and FREE_PASID are mutually exclusive.
> > + *
> > + * returns: allocated PASID value on success, -errno on failure for
> > + *	     ALLOC_PASID;
> > + *	     0 for FREE_PASID operation;
> > + */
> > +struct vfio_iommu_type1_pasid_request {
> > +	__u32	argsz;
> > +#define VFIO_IOMMU_FLAG_ALLOC_PASID	(1 << 0)
> > +#define VFIO_IOMMU_FLAG_FREE_PASID	(1 << 1)
> > +	__u32	flags;
> > +	struct {
> > +		__u32	min;
> > +		__u32	max;
> > +	} range;
> > +};
> > +
> > +#define VFIO_PASID_REQUEST_MASK	(VFIO_IOMMU_FLAG_ALLOC_PASID | \
> > +					 VFIO_IOMMU_FLAG_FREE_PASID)
> > +
> > +#define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 18)
> > +
> >  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
> >
> >  /*
> >
> Otherwise, besides the pieces I would have put directly in the
> vfio_pasid module patch (EXPORT_SYMBOL_GPL and vfio_mm_ioasid_sid),
> looks good.

we discussed in another thread:-).

Regards,
Yi Liu

> 
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
