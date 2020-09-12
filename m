Return-Path: <SRS0=7x6w=CV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06191C10DAA
	for <iommu@archiver.kernel.org>; Sat, 12 Sep 2020 06:17:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A7B208FE
	for <iommu@archiver.kernel.org>; Sat, 12 Sep 2020 06:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="fFrbj9Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A7B208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CC65F20432;
	Sat, 12 Sep 2020 06:17:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PdvGhKZUtEgf; Sat, 12 Sep 2020 06:17:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 112652040E;
	Sat, 12 Sep 2020 06:17:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F4233C0859;
	Sat, 12 Sep 2020 06:17:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 094DDC0051
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 06:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 041E687419
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 06:17:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bss5A3GUciRE for <iommu@lists.linux-foundation.org>;
 Sat, 12 Sep 2020 06:17:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8BCCC87417
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 06:17:52 +0000 (UTC)
IronPort-SDR: eKL6LEb0ZJiRSHWIcS+5QjrFSnWxpDD9Xo/zZfJ8M12PvaCD9ubqXeea5wWN4iuqNilVuf7Ogq
 sBLS+jq2bpsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="243717062"
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; d="scan'208";a="243717062"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2020 23:17:48 -0700
IronPort-SDR: QGXmc3+Xv2hV0QbaIGULSxRBS5YxiafB+gOXK0XUEIpJ6RMfxryP6dBp6pineeXIcX30563+Ls
 A2FTwBvP2p9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; d="scan'208";a="287095355"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2020 23:17:48 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Sep 2020 23:17:47 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 11 Sep 2020 23:17:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 11 Sep 2020 23:17:47 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 11 Sep 2020 23:17:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqnoC3KMJr191UUuHJc5l/Ez0H3XUq5GUVss+iQ1xECOpC9iWCtaryOB8X/o6qMrzJMaCedKu3BD5jhX3kRGEJ1MUmDeEzhIGLR0ohKPC/lcbe2kJNue6xifl6GCjuYtSgmJxzD/qDfB0fGsIfGo/bGL+gJCIOohtPzNLt/MNtF5DOchHWtt2ZU3q3cASOoC1g5mdCZBKHflqVhmTNeilR8uxLZd5vRjZiX9GktepKtaWtdhDcFxc83HpGB8H01qOAYKVhFDljbTrtrplEZ6PPjHSwcp9FhJvAwiC+jy5ywRj2NNTE7ajH9upjb+TV9bkZQJpgtYqJbMwC+bpXtwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNVxDxcuRFBNldEe6Bl0iYDAUEhLJmBTZuKFgEibDLQ=;
 b=S141zBWLa6471szg2QlD1BbmSEsGyIsiSxzuqHj10lbDXMRqkeN9oGLZOiBvlrBM4H1//fGUm+SwMPbhY/lFhd1E/vfSSaDZZqJfhj2QHybLhrzv9861lJQTrgs77up9WAgHpkj5hXuY5RL2o6s9BvE38Or/ruJFbcPtBKHLs+GZwrWfWaHV0MC7akHp+bUNczTLNjbwu86mF6mxlR7Y4alb/xWVSeq8Vb/xfwsGGow5Goco+Zsoh5sKcVJZUdpVo937UJwbkPkBsojScs9qWV4BN4zdXdMvUtOKvIKeogeCmCD7WfZnZIPpP4DszegEv4sFEXeRER0sySQ+QzL9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNVxDxcuRFBNldEe6Bl0iYDAUEhLJmBTZuKFgEibDLQ=;
 b=fFrbj9Bc2IryBACKgxjK+SKDWumW05W4Kvo0EcrX39a61vTSn8CNMqt6a7WtN3YSoZUf8gz62ADM8PHqdia7YH++Z0/cZIIt8Kfts0GSoUBLcKeLJU14wtUPoTmdAZr8sWH89UrP1R+LVapwiXSv37DE1geBXSO+4PgwqKMrEHU=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1996.namprd11.prod.outlook.com (2603:10b6:3:13::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Sat, 12 Sep 2020 06:17:43 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::7053:1185:558b:bc54]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::7053:1185:558b:bc54%9]) with mapi id 15.20.3370.017; Sat, 12 Sep 2020
 06:17:43 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v7 07/16] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Topic: [PATCH v7 07/16] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Index: AQHWh18/B4ZCT17CmE6gLhMUkIK4Gqlj+OwAgACND5A=
Date: Sat, 12 Sep 2020 06:17:43 +0000
Message-ID: <DM5PR11MB1435AC984A714AA68F3840EFC3250@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-8-git-send-email-yi.l.liu@intel.com>
 <20200911153806.6dda06b9@w520.home>
In-Reply-To: <20200911153806.6dda06b9@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [114.244.141.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77f46dcb-79f2-4836-9f57-08d856e38f5e
x-ms-traffictypediagnostic: DM5PR11MB1996:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB19961C3EA7B2EAA02DE77AEBC3250@DM5PR11MB1996.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rEOJQmrV16aCpIFZhZ2D9GNGhY+IFLdJotSURbKU5SPQQS2OICeVKv+W6siBPJaZ32qA+aIm2ZJkZ0c74TEY7xj3VZ+IlJHjLpNNPioKAeszmiCIxnjjlPnslt7RqmI8ELYqZ41MgXyqN51wosbnmqQkIMANDUanzd5WdaingUG1tdAmgbz21PNvGazH1/64R8gVIJ/U2wrDOXW+n/E7ZQHZQL2iMCvHOiByLnhBMBc+tKPt42Z82k77WqjAb4SlmAVLufOdORv2u+f7kMN7FQYtyzNApyd3egOZriiapZRhWIWos6cIxfhPyKcK+eLWdeWLaDtcoEJZXNQlkMIZ+TO3qp5wUVE01mMnJVX5LU/HMAq+1HZrC/as9r0pZbf/iGApdWOf/g0Tr8ZRQYJtng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(9686003)(8676002)(86362001)(66446008)(64756008)(66556008)(316002)(26005)(7696005)(76116006)(66476007)(71200400001)(6506007)(6916009)(4326008)(966005)(30864003)(66946007)(478600001)(2906002)(8936002)(5660300002)(54906003)(7416002)(55016002)(186003)(33656002)(83380400001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 7qVVT6Jjgoyc+V4QDdYLs718ItVshpcic0Y54GDe3m7M1+5YB04Y/oNrOtR921V+d7DOABipA4tnQ0FLentSmK1vnWugmXFzjEXfbGDkPZXccW5R54nJyeqEBnpPUeuvNLhUBeuilgfcrQLLY/+8zAGZ65F03ZEx0TwaenhGo9R9zxtt8gEfXuZt0T6wOCyBmQOXn2tu+s/wFxxBbSF/6idactfAkOJsMob9jSkfEgN0cn2AfAtRN3O1XsBimDgM2InHgHoQlo72C1AopyzYIL6pNREaShi2M1IZI9Wj5vAciypRuI0XMs7pXdB3n6kaNXqxicKmFz7USwvWWOMKRTtncXzJ3yUIOkYxb4q44saKxToBf32BArOrGNyM7Dj18fLLAfsriq3Fh6i+6YrwyPyD8252Nb9ccHrN7uHRCZDM6rFAYB6j8tQHkTAosedq3OdV7TOlCSQLhQjDoQs9ygtdRJFbcESOcYVx865W9HF2ISINIQ65ToQz90GgMKhEzNwy3Xk84ww36zOSI+qlNNA6KExHEg0aKlByhh7DwZeZ9YpnlZtAEchCjnbvFWl0toX7gmTD5KHvvkanWPqKKueuH1iAja3l/KbNYvsuH/7ia8a2hhe9DqOqNYxK+K41zLNRAViK85nNECxegzTqqw==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f46dcb-79f2-4836-9f57-08d856e38f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2020 06:17:43.4153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmJjMBKbBDBZWm4kQnyXwRtfoLt7iRLLrIinM+DxGPXl7eh4M0jGZaQc06JmvJmguLuzfBRPzdX0x1oPxJMHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1996
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
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
> Sent: Saturday, September 12, 2020 5:38 AM
> 
> On Thu, 10 Sep 2020 03:45:24 -0700
> Liu Yi L <yi.l.liu@intel.com> wrote:
> 
> > This patch allows userspace to request PASID allocation/free, e.g. when
> > serving the request from the guest.
> >
> > PASIDs that are not freed by userspace are automatically freed when the
> > IOASID set is destroyed when process exits.
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
> > v6 -> v7:
> > *) current VFIO returns allocated pasid via signed int, thus VFIO UAPI
> >    can only support 31 bits pasid. If user space gives min,max which is
> >    wider than 31 bits, should fail the allocation or free request.
> >
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
> >     https://lore.kernel.org/linux-iommu/20200702151832.048b44d1@x1.home/
> >
> > v1 -> v2:
> > *) move the vfio_mm related code to be a seprate module
> > *) use a single structure for alloc/free, could support a range of PASIDs
> > *) fetch vfio_mm at group_attach time instead of at iommu driver open time
> > ---
> >  drivers/vfio/Kconfig            |  1 +
> >  drivers/vfio/vfio_iommu_type1.c | 76
> +++++++++++++++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_pasid.c       | 10 ++++++
> >  include/linux/vfio.h            |  6 ++++
> >  include/uapi/linux/vfio.h       | 43 +++++++++++++++++++++++
> >  5 files changed, 136 insertions(+)
> >
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > index 3d8a108..95d90c6 100644
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
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 3c0048b..bd4b668 100644
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
> > @@ -2000,6 +2001,11 @@ static void vfio_iommu_iova_insert_copy(struct
> vfio_iommu *iommu,
> >
> >  static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
> >  {
> > +	if (iommu->vmm) {
> > +		vfio_mm_put(iommu->vmm);
> > +		iommu->vmm = NULL;
> > +	}
> > +
> >  	kfree(iommu->nesting_info);
> >  	iommu->nesting_info = NULL;
> >  }
> > @@ -2127,6 +2133,26 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  					    iommu->nesting_info);
> >  		if (ret)
> >  			goto out_detach;
> > +
> > +		if (iommu->nesting_info->features &
> > +					IOMMU_NESTING_FEAT_SYSWIDE_PASID)
> {
> > +			struct vfio_mm *vmm;
> > +			struct ioasid_set *set;
> > +
> > +			vmm = vfio_mm_get_from_task(current);
> > +			if (IS_ERR(vmm)) {
> > +				ret = PTR_ERR(vmm);
> > +				goto out_detach;
> > +			}
> > +			iommu->vmm = vmm;
> > +
> > +			set = vfio_mm_ioasid_set(vmm);
> > +			ret = iommu_domain_set_attr(domain->domain,
> > +						    DOMAIN_ATTR_IOASID_SET,
> > +						    set);
> > +			if (ret)
> > +				goto out_detach;
> > +		}
> >  	}
> >
> >  	/* Get aperture info */
> > @@ -2908,6 +2934,54 @@ static int vfio_iommu_type1_dirty_pages(struct
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
> > +	/*
> > +	 * Current VFIO_IOMMU_PASID_REQUEST only supports at most
> > +	 * 31 bits PASID. The min,max value from userspace should
> > +	 * not exceed 31 bits.
> 
> Please describe the source of this restriction.  I think it's due to
> using the ioctl return value to return the PASID, thus excluding the
> negative values, but aren't we actually restricted to pasid_bits
> exposed in the nesting_info? 

yes, the description for this restriction is in the uapi/vfio.h. I
think you are right. We should restricted to the pasid_bits exposed
in the nesting_info. thanks for the spotting.

> If this is just a sanity test for the API
> then why are we defining VFIO_IOMMU_PASID_BITS in the uapi header,
> which causes conflicting information to the user... which do they
> honor? 

yes, it should not be in the uapi header. will fix it.

> Should we instead verify that pasid_bits matches our API scheme
> when configuring the nested domain and then let the ioasid allocator
> reject requests outside of the range?

agreed, I think it may be checked in the attach_group phase, if pasid_bits
from iommu vendor driver are larger than 31 bits, we fail the attach.

> 
> > +	 */
> > +	if (req.range.min > req.range.max ||
> > +	    req.range.min > (1 << VFIO_IOMMU_PASID_BITS) ||
> > +	    req.range.max > (1 << VFIO_IOMMU_PASID_BITS))
> 
> Off by one, >= for the bit test.

got it. thanks for spotting it.

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
> 
> Set the initial value when it's declared?

I see, will do. :-)

> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)
> >  {
> > @@ -2924,6 +2998,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  		return vfio_iommu_type1_unmap_dma(iommu, arg);
> >  	case VFIO_IOMMU_DIRTY_PAGES:
> >  		return vfio_iommu_type1_dirty_pages(iommu, arg);
> > +	case VFIO_IOMMU_PASID_REQUEST:
> > +		return vfio_iommu_type1_pasid_request(iommu, arg);
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
> > index 44ecdd5..0ec4660 100644
> > --- a/drivers/vfio/vfio_pasid.c
> > +++ b/drivers/vfio/vfio_pasid.c
> > @@ -60,6 +60,7 @@ void vfio_mm_put(struct vfio_mm *vmm)
> >  {
> >  	kref_put_mutex(&vmm->kref, vfio_mm_release, &vfio_mm_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_mm_put);
> >
> >  static void vfio_mm_get(struct vfio_mm *vmm)
> >  {
> > @@ -113,6 +114,13 @@ struct vfio_mm *vfio_mm_get_from_task(struct
> task_struct *task)
> >  	mmput(mm);
> >  	return vmm;
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
> > +
> > +struct ioasid_set *vfio_mm_ioasid_set(struct vfio_mm *vmm)
> > +{
> > +	return vmm->ioasid_set;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_ioasid_set);
> >
> >  /*
> >   * Find PASID within @min and @max
> > @@ -201,6 +209,7 @@ int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> >
> >  	return pasid;
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_pasid_alloc);
> >
> >  void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  			   ioasid_t min, ioasid_t max)
> > @@ -217,6 +226,7 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  		vfio_remove_pasid(vmm, vid);
> >  	mutex_unlock(&vmm->pasid_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_pasid_free_range);
> >
> >  static int __init vfio_pasid_init(void)
> >  {
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index 31472a9..5c3d7a8 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -101,6 +101,7 @@ struct vfio_mm;
> >  #if IS_ENABLED(CONFIG_VFIO_PASID)
> >  extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
> >  extern void vfio_mm_put(struct vfio_mm *vmm);
> > +extern struct ioasid_set *vfio_mm_ioasid_set(struct vfio_mm *vmm);
> >  extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
> >  extern void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  				  ioasid_t min, ioasid_t max);
> > @@ -114,6 +115,11 @@ static inline void vfio_mm_put(struct vfio_mm *vmm)
> >  {
> >  }
> >
> > +static inline struct ioasid_set *vfio_mm_ioasid_set(struct vfio_mm *vmm)
> > +{
> > +	return -ENOTTY;
> > +}
> > +
> >  static inline int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> >  {
> >  	return -ENOTTY;
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index ff40f9e..a4bc42e 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1172,6 +1172,49 @@ struct vfio_iommu_type1_dirty_bitmap_get {
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
> > + * Current interface supports at most 31 bits PASID bits as returning
> > + * PASID allocation result via signed int. PCIe spec defines 20 bits
> > + * for PASID width, so 31 bits is enough. As a result user space should
> > + * provide min, max no more than 31 bits.
> 
> Perhaps this is the description I was looking for, but this still
> conflicts with what I think the user is supposed to do, which is to
> provide a range within nesting_info.pasid_bits.  These seem like
> implementation details, not uapi.  Thanks,

agreed, I may move this comment (after refining :-)) to the place attach_group
where we check if pasid_bits matches our API scheme, and just put a comment
"userspace should provide a range within nesting_info.pasid_bits" here.

Regards,
Yi Liu

> Alex
> 
> > + * returns: allocated PASID value on success, -errno on failure for
> > + *	    ALLOC_PASID;
> > + *	    0 for FREE_PASID operation;
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
> > +#define VFIO_IOMMU_PASID_BITS		31
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
