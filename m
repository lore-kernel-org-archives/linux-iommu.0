Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E1C433E3
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 00:37:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E6820738
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 00:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bckDzB+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E6820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 92FBA88585;
	Fri, 21 Aug 2020 00:37:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pqz4auZa0f4x; Fri, 21 Aug 2020 00:37:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D73D188528;
	Fri, 21 Aug 2020 00:37:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA68FC0889;
	Fri, 21 Aug 2020 00:37:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17403C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E197C22CD4
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YV4sMNdhfsAT for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 00:37:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by silver.osuosl.org (Postfix) with ESMTPS id D262A22C6B
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 00:37:28 +0000 (UTC)
IronPort-SDR: Yh2C2KY6vDE3JNxzoCum75EDm5Wl9tCNDmlb9iNCnopX540LjY15/1NUxjieNkdX+KrqCgYl0f
 6A/yJJRXFELw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="135493274"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="135493274"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 17:37:26 -0700
IronPort-SDR: kCyYDthlA3mVwQSroXOg1pDcZL97EQJzOio2xICG4GGxXyF7kToVCsqOlQ3EcHPlXLsEc+V0zS
 anEfxWE5o0gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="297770135"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com)
 ([10.18.84.213])
 by orsmga006.jf.intel.com with ESMTP; 20 Aug 2020 17:37:22 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 17:37:22 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Aug 2020 17:37:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 20 Aug 2020 17:37:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dljY6UsTAuotqyaoayGF/nVq4VaIPNXS6A6MjDTpLscH1Ep8tHzBNNqaOiPmvkBBlH0GCKLQqifo15Y1modYU5JqS5WGKuqClZ9OYhftqy02enm1S9a4kT9kPTClbf1vXC0c1Xg/WkmSTkweqaaOGo0tNQeZbXCEHPEF7Jtr1jVG0BjFnthPN13riJe1eH6UL0fucSOCBYabC+U09nfKYSCL9Fiv1t754ceLKnYkSIxRgS7GjDJiXrDzE6W5nEMdlzM0nTknkukrVNOBfRiHdSJqKS8G/n39cXJe97/1Y8KwY/FAbtHnGi4/JIAHC+QxfJkKMGJ6jBzia4juez1xgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jkRmw/aQiPdsZJaqTtzi5hjvUGMdUbCEHAAegKFi0A=;
 b=Y8z4moF2TDvn690fJXw1qLxoJdHZLolgaOjSCg6ybvsnpzDVGhIFCltqtFa2nxyH0k3u6But6dwDCrpoghW2FEvLeH152TyxLU8oOmI9GCA4QfByCo07OEin8n+HSlzIg2wT+eAu6zkqiz8V5ES08u0f+hXE5cq6M3hUSOoIOPSHAZTa8ZjmPYCdelda7G99lqMjWGtPsJwWBbzjujQjr0p7BZmB2si8s49ragk+EeytvPjF4KTcWG9sa9TDFTpx6zwZsncJHE5ubYqSuk0bB3KDO2ETDwotPht5oe2YIWtW46jKNrxVH86+sO4tNOax8uA6cMTh5CHxkHslj9n65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jkRmw/aQiPdsZJaqTtzi5hjvUGMdUbCEHAAegKFi0A=;
 b=bckDzB+ztbzR1+myfn3umjBF/KXWzEkUYW5kjzk+lQyS4FuYd3aKywP24ysqZMNuBjh7g4TgYdUhTCi9/cUW6iCB6OlhIf47aBmwp+vGcf7ooWcli0uIMzbxd4vgAJeVgTJDE0xGjwd47G+zvCG7uYQxlE1FyWKbpy7nv329Trw=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3708.namprd11.prod.outlook.com (2603:10b6:5:146::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Fri, 21 Aug 2020 00:37:19 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3305.024; Fri, 21 Aug
 2020 00:37:19 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v6 07/15] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Topic: [PATCH v6 07/15] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Index: AQHWZKdG9Cu5qyN/2EiULCi4Ic3bNKlBngmAgAA3G1A=
Date: Fri, 21 Aug 2020 00:37:19 +0000
Message-ID: <DM5PR11MB1435B790F169ACDFFEA03D68C35B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-8-git-send-email-yi.l.liu@intel.com>
 <20200820145127.61ed8727@x1.home>
In-Reply-To: <20200820145127.61ed8727@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.229.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1012cacf-49f9-49b3-3d92-08d8456a5c6c
x-ms-traffictypediagnostic: DM6PR11MB3708:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB37083BD007EF668FA55CBADFC35B0@DM6PR11MB3708.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sP4PHcUcE+YLjn+FEoXaajcUIQkph90im20CmH1jg3Tpw7+Af68xxQ9pEThkEgOvOy1YrjN114pw8VGw9Ag1adt+NgdN0JJhnQoxe0XCH3frLcW2EriVGcr8oNCpxT8y2ujiFPqIo99j2BprmJLgoIO0sPtwBFNGNMFqnYNDqpT5uFaTjYdJRKnDHXb22tvqV5eUDrPWdIFg+p+tMSxYQXIubG7dMuH4hmUVnO9hUibgX9wsuCXEQzYQbjmuc8YAiFUZW7SEsnB1thWOPTycD1BzWrwfojBLkV+PmCZJC2oy3oK+DT4DntiV8CZU+3uWfh6aZvrs4eM6HEloAN5sCwV4Nx5y5YRme6EXcoX3uqDjkkltfDMvoA3dduZDkMqbp25eM71JTReMWWi70ySbrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(6916009)(66556008)(4326008)(26005)(71200400001)(33656002)(316002)(5660300002)(64756008)(55016002)(66446008)(83380400001)(66476007)(966005)(8676002)(86362001)(6506007)(76116006)(478600001)(66946007)(2906002)(8936002)(54906003)(9686003)(52536014)(7696005)(7416002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 65Qczth310gDpiDM0aqSboSktpopqeIrbROah1rxl92lOQjez20kYHpXhdS0BlarN1LpiB4S2lge8WIMuylPi2Pp0g1niaDVm2vz8/xEy1eYl9Xwg80gGfcinibOWHFbIQbG6dE3K5Z1okm/JVJJJfA1gkTdwrhQ2+mQhj1sjpqOY3BUhzFTshch3Zkjpdw7p9NO9Ih7b6vxYeoC8sLYMc+Hg3nbbmEwuXCmQ7IY+7Y+m6l45S/UIWZknQZy3zPhIUb8zP6GX3VP+vrjSbIxZT3HOme36pn0M+7czSZrvNEDeERDwBB8REmexcRmC4jnnjusgx1RsDG+NfHAK1BFlRi/grqhqAeq7zXUyiV1HXlUE7mp39XMY//wW5mYMsxlzDqo3AjCvgmgObiIKN1svbeHqT8Q0uga3m8hVmcwKnYlMoJObapRzOlwrLCxvRBTiGXqqXUdigsyOzjsZXUBETeFuN19cc6o7zRAAPFZPkxf6wX2isZ/3AZJI1g2GJdA+oKOlvuSLsvqSTTk4odg+ynyiaNTy3BsOUfx6yrfQNzSWZv+w1Ulxm0Pk6lw08F6UoVt80ORysW9zALWbD445R1DAp8Y1Zmy72UT3ObGl2vPa1xIRCPMDZ5H25h41k5PInvawm0Xen6f6+iKj7VO4w==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1012cacf-49f9-49b3-3d92-08d8456a5c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 00:37:19.0203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3O4jILeMeUcNGoC+QHu61cs6Hn+ofUkurY5mwgeQ0Wuqym6rIwZYNwA4YD6uS6hh8j5tr//mdKBzISF7qw7ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3708
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
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
> Sent: Friday, August 21, 2020 4:51 AM
> 
> On Mon, 27 Jul 2020 23:27:36 -0700
> Liu Yi L <yi.l.liu@intel.com> wrote:
> 
> > This patch allows userspace to request PASID allocation/free, e.g.
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
> > v5 -> v6:
> > *) address comments from Eric against v5. remove the alloc/free helper.
> >
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
> >      Is it exploitable that a user can spin the kernel for a long time in
> >      the case of a free by calling this with [0, MAX_UINT] regardless of
> >      their actual allocations?"
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
> >  drivers/vfio/vfio_iommu_type1.c | 69
> +++++++++++++++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_pasid.c       | 10 ++++++
> >  include/linux/vfio.h            |  6 ++++
> >  include/uapi/linux/vfio.h       | 37 ++++++++++++++++++++++
> >  5 files changed, 123 insertions(+)
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
> > b/drivers/vfio/vfio_iommu_type1.c index 18ff0c3..ea89c7c 100644
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
> > @@ -2859,6 +2885,47 @@ static int vfio_iommu_type1_dirty_pages(struct
> vfio_iommu *iommu,
> >  	return -EINVAL;
> >  }
> >
> > +static int vfio_iommu_type1_pasid_request(struct vfio_iommu *iommu,
> > +					  unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_pasid_request req;
> > +	unsigned long minsz;
> > +	int ret;
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
> > +	mutex_lock(&iommu->lock);
> > +	if (!iommu->vmm) {
> > +		mutex_unlock(&iommu->lock);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	switch (req.flags & VFIO_PASID_REQUEST_MASK) {
> > +	case VFIO_IOMMU_FLAG_ALLOC_PASID:
> > +		ret = vfio_pasid_alloc(iommu->vmm, req.range.min,
> > +				       req.range.max);
> > +		break;
> > +	case VFIO_IOMMU_FLAG_FREE_PASID:
> > +		vfio_pasid_free_range(iommu->vmm, req.range.min,
> > +				      req.range.max);
> > +		ret = 0;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)  { @@ -
> 2875,6 +2942,8 @@
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
> > index befcf29..8d0317f 100644
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
> > @@ -202,6 +210,7 @@ int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> >
> >  	return pasid;
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_pasid_alloc);
> >
> >  void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  			   ioasid_t min, ioasid_t max)
> > @@ -218,6 +227,7 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  		vfio_remove_pasid(vmm, vid);
> >  	mutex_unlock(&vmm->pasid_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_pasid_free_range);
> >
> >  static int __init vfio_pasid_init(void)
> >  {
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index 31472a9..a355d01 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -101,6 +101,7 @@ struct vfio_mm;
> >  #if IS_ENABLED(CONFIG_VFIO_PASID)
> >  extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
> >  extern void vfio_mm_put(struct vfio_mm *vmm);
> > +extern int vfio_mm_ioasid_sid(struct vfio_mm *vmm);
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
> > index 0cf3d6d..6d79557 100644
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
> > + * is required by the underlying iommu driver (e.g. Intel VT-d), this
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
> 
> 
> IOCTL(2)                   Linux Programmer's Manual                  IOCTL(2)
> 
> NAME
>        ioctl - control device
> 
> SYNOPSIS
>        #include <sys/ioctl.h>
> 
>        int ioctl(int fd, unsigned long request, ...);
> 
> 
> ioctl(2) returns a signed int, how can it support returning a __u32
> pasid and -errno?  Thanks,

yeah, pasid is 20 bits today per PCI spec, so a valid pasid won't use
full 32 bits, so I used it. perhaps I need to add a field in the data
struct to return allocated pasid. that may be safer. do you think it
works?

Regards,
Yi Liu

> Alex
> 
> > +
> > +#define VFIO_PASID_REQUEST_MASK	(VFIO_IOMMU_FLAG_ALLOC_PASID | \
> > +					 VFIO_IOMMU_FLAG_FREE_PASID)
> > +
> > +#define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 18)
> > +
> >  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
> >
> >  /*

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
