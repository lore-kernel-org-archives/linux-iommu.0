Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1674C433DF
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 06:30:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00AF20657
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 06:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="D4YxXBNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00AF20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5EAC488055;
	Mon, 17 Aug 2020 06:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hNSqEqKG7ppp; Mon, 17 Aug 2020 06:30:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3124788047;
	Mon, 17 Aug 2020 06:30:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14357C088B;
	Mon, 17 Aug 2020 06:30:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0713DC0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 06:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DEC4A88055
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 06:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F3xH6XvFymbs for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 06:30:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D8FA888047
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 06:30:23 +0000 (UTC)
IronPort-SDR: cR/hQohx9OfyPV7WUHVXwCQFEL3lTNd6g2EklgNImVpYg0zy5KhEYNSpiYuz/12KTh3A/abY7L
 mNSp1szDHysA==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="134704438"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="134704438"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2020 23:30:22 -0700
IronPort-SDR: CB3JJBB4eB78X0RhFDKtTjKtvEjrdVenCuPk1zyd8ATIHmqDyO/Jn6O44rAuD0fc4NNd1yxORs
 W8yqreBjNMmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="336188063"
Received: from fmsmsx601-2.cps.intel.com (HELO fmsmsx601.amr.corp.intel.com)
 ([10.18.84.211])
 by orsmga007.jf.intel.com with ESMTP; 16 Aug 2020 23:30:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 16 Aug 2020 23:30:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 16 Aug 2020 23:30:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 16 Aug 2020 23:30:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXexKWYDI45emDOAaW+D8GglXnV/pfC1Lydnag3O2ztgW4KbTKfUpMfz+oKZqf5RAAZAYjcNNzSAQIgHcGeLOfuvFoeHdBYJt8UlENqGYVkaiNiv5uk1VsjwJLpCPrCAb1KfpPIgLm0ybrULTsyJpg6BEhlcQNYC3sH4pKw2BvQXy+N9QM3Fqks/hn/HUCtTqU9it0TRy+oL6W0bkaG8SiBdpbAgVgZe4oE+FAj+Ha6tDzAV9IE43pTS7SIAXyh+VStmUEallbXzrEJMcgUeJHys1fb+xcMUvoEbyb7Z4sBrOezzY9anjeSeF6V6yHyGhcUvKGD6m4ORJBwbL6mj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuDeQ4AREPbmYvKEI5icP+TuatF5iuJ9geKCUbttbrk=;
 b=f4ZkJBZKEJFxZXwxTjlA0JwGwNJ6927jRwb/G+1jadUl10QVbLKNqkxkocHenoZAA25ThrWacTgfB5SrEcqjQ5lBbGpSVM1QCMdChRcBFU918YEtuTNM4X9tas8OS/LDa5iXNl9iVySN7Y61fnb4vU+rp6zQkQsvVGN6VhleX2I1MB5tAYQsmII7ZqDIMLqaG8FcGz7SqdeDKkAKG9BQac3ejy4enyWWyTryzrW5GKZSaGYTdBX+h3RJZqDnbuLDma4arb1AVP7Rt7GHuda0YuvUVVVFnWAUeyXBW561Tzx+u/ul68tn64YW+6HSPYKCcTYgf8PshKgn7WDdJhjDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuDeQ4AREPbmYvKEI5icP+TuatF5iuJ9geKCUbttbrk=;
 b=D4YxXBNjhh6Nbuw9exV+MDIYhc/Ul/tHmKxoiiS7WsIaqkENo0RvAfl1pZzpjhScb8Y0tdltDTEMe+LgzMzqg7zy5bsUWi6vFcj0mmbpqqNiTEtx2XfaqGSew/F3Mjct2cPobTYQnAe+oeibT7k+L1M2+IUZJeVdhkmxak9j8m8=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4441.namprd11.prod.outlook.com (2603:10b6:5:200::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Mon, 17 Aug 2020 06:30:20 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3283.027; Mon, 17 Aug
 2020 06:30:20 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v6 10/15] vfio/type1: Support binding guest page tables to
 PASID
Thread-Topic: [PATCH v6 10/15] vfio/type1: Support binding guest page tables
 to PASID
Thread-Index: AQHWZKdLPXEeLFoo+Emu87CHPiN7Kqk6t6eAgAE39SA=
Date: Mon, 17 Aug 2020 06:30:20 +0000
Message-ID: <DM5PR11MB14359783713BD31E00C553BDC35F0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-11-git-send-email-yi.l.liu@intel.com>
 <d54e0327-70cb-d58e-e521-e647f0cc024b@redhat.com>
In-Reply-To: <d54e0327-70cb-d58e-e521-e647f0cc024b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.230.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ab25b7d-ead0-4c55-693f-08d8427703c3
x-ms-traffictypediagnostic: DM6PR11MB4441:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4441A88D3956B87915E7C47CC35F0@DM6PR11MB4441.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: htf9gvlzc07LkoZSgpzyv3NEswoJlyyh3W+20PiHvMEJCu//L5GcgfHJxoTYhbsgBmh9ogXuhC9anC4YmQj5kRFqs6RuUMCoGtlTFIoIMs8/Bt8424aXycL9yG5G35kXRu/eBA1ZIlzoqNdLcIUWf4xGP3ni1tBP+yi72YGytbXta6j1hQWI8UcDWMBRs6L+B4ovlR1Qsd0oW1tpzbrP4jTTJp+p2IrhOGewPZa/zKPEyfGJN7tDNtir6GYBqaEAbcrgkWEhQYo2Ys1YniYRNpHhUj8LNJuV7yPeaKYxkKBAStuVf05/oMG8lF8fOdFzKy6BeOjhnszadOrwrz+pPolfaj5tx9QbmWD6xROCmQmV2LLn9s5LsB+xKSuU8lESXVFwqgHBehn/L7dDpUlPoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(30864003)(4326008)(2906002)(33656002)(83380400001)(66946007)(66446008)(8676002)(64756008)(66556008)(66476007)(76116006)(86362001)(8936002)(110136005)(478600001)(54906003)(5660300002)(7416002)(71200400001)(53546011)(55016002)(7696005)(966005)(6506007)(26005)(52536014)(9686003)(186003)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 0lDAVmvCTiCh88PkYfkLk9Lr0h5PVVcUdjsfHJeHMCYubMH9LFjcX49kmp9o6OWM/F8Oz64KtghPcembS/54pqLHpDWxS6gvHp2THFJ1WUC8XAFg+d184lfhnNYU0Mp1rMjUBgDJAtoAqoYi6GkZ+fI3XzSsOZd7qJJUkIKOyoWGr9OInUI5TXVMUuXaT8b7O668/dfuehqVC0HDAx7plqBR7uJQ4UltdPuqMh+S4Lmf2gO7OvNKNoFgoV+2QLkT/RQasthqc4IEIt8fvtd/9CItlmXRiwVOM/+83n2N3UEnI3Mo4V2REqTN6pKkDEd5khAaLKRgds08NpW70/eSYcpYPNSPlezJHaSo1Q4Qyqo24wBgXUTZ/RiHy7tpECQOGCnILQLBywN2OODO6THmG0hEB9vYzSw65MC8oXJQ38EbVj+5PvENpHnkiBqRiGb6QGhCcT2GACHUNW6h8CmTimlIwOTSWawKjzWbPayT1+3TwSS5egEXpIWo+EOqY0mqFf5KTRy+BhF655pw8Bli7pKZHFMpc5bARt7Cs05Hui845oT7ENIABQYOn/kQdGx0OyzewQVbFZ0U0Wl759GNMicDbg6anEqwhun2I0rphqEPuGoioeu1IXhdxnSFW9ws9KnjBSqeXJfsl7z3DTrwOg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab25b7d-ead0-4c55-693f-08d8427703c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 06:30:20.2785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T82598TymB/CpInYRJHeFlWZJOb9uMK1ct9MOpiQ+Q3H9+nwaWBN+AKU8uwzD6Ggz/1XbV5Nlp15huxk/x9HkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4441
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
> Sent: Sunday, August 16, 2020 7:29 PM
> 
> Hi Yi,
> 
> On 7/28/20 8:27 AM, Liu Yi L wrote:
> > Nesting translation allows two-levels/stages page tables, with 1st level
> > for guest translations (e.g. GVA->GPA), 2nd level for host translations
> > (e.g. GPA->HPA). This patch adds interface for binding guest page tables
> > to a PASID. This PASID must have been allocated by the userspace before
> > the binding request.
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
> > v5 -> v6:
> > *) dropped vfio_find_nesting_group() and add vfio_get_nesting_domain_capsule().
> >    per comment from Eric.
> > *) use iommu_uapi_sva_bind/unbind_gpasid() and iommu_sva_unbind_gpasid() in
> >    linux/iommu.h for userspace operation and in-kernel operation.
> >
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
> >  drivers/vfio/vfio_iommu_type1.c | 161
> ++++++++++++++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_pasid.c       |  26 +++++++
> >  include/linux/vfio.h            |  20 +++++
> >  include/uapi/linux/vfio.h       |  31 ++++++++
> >  4 files changed, 238 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index ea89c7c..245436e 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -149,6 +149,36 @@ struct vfio_regions {
> >  #define DIRTY_BITMAP_PAGES_MAX	 ((u64)INT_MAX)
> >  #define DIRTY_BITMAP_SIZE_MAX
> DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)
> >
> > +struct domain_capsule {
> > +	struct vfio_group *group;
> > +	struct iommu_domain *domain;
> > +	void *data;
> You may add a bool indicating whether the data is a user pointer or the
> direct IOMMU UAPI struct.

yes, it is helpful.

> > +};
> > +
> > +/* iommu->lock must be held */
> > +static int vfio_get_nesting_domain_capsule(struct vfio_iommu *iommu,
> > +					   struct domain_capsule *dc)
> I would rename the function into vfio_prepare_nesting_domain_capsule

got it. :-)

> > +{
> > +	struct vfio_domain *domain = NULL;
> > +	struct vfio_group *group = NULL;
> > +
> > +	if (!iommu->nesting_info)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Only support singleton container with nesting type.
> > +	 * If nesting_info is non-NULL, the conatiner should
> s/should/is here and below
> s/conatiner/container

got it. thanks.

> > +	 * be non-empty. Also domain should be non-empty.
> > +	 */
> > +	domain = list_first_entry(&iommu->domain_list,
> > +				  struct vfio_domain, next);
> > +	group = list_first_entry(&domain->group_list,
> > +				 struct vfio_group, next);
> > +	dc->group = group;
> > +	dc->domain = domain->domain;
> dc->user = true;?

yep.

> > +	return 0;
> > +}
> > +
> >  static int put_pfn(unsigned long pfn, int prot);
> >
> >  static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu
> *iommu,
> > @@ -2349,6 +2379,48 @@ static int vfio_iommu_resv_refresh(struct vfio_iommu
> *iommu,
> >  	return ret;
> >  }
> >
> > +static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	unsigned long arg = *(unsigned long *)dc->data;
> > +
> > +	return iommu_uapi_sva_bind_gpasid(dc->domain, dev, (void __user *)arg);
> > +}
> > +
> > +static int vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	unsigned long arg = *(unsigned long *)dc->data;
> > +
> > +	iommu_uapi_sva_unbind_gpasid(dc->domain, dev, (void __user *)arg);
> > +	return 0;
> > +}
> > +
> > +static int __vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
> can be removed if dc->user flag gets added

yes.

> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	struct iommu_gpasid_bind_data *unbind_data =
> > +				(struct iommu_gpasid_bind_data *)dc->data;
> > +
> > +	iommu_sva_unbind_gpasid(dc->domain, dev, unbind_data);
> > +	return 0;
> > +}
> > +
> > +static void vfio_group_unbind_gpasid_fn(ioasid_t pasid, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	struct iommu_gpasid_bind_data unbind_data;
> > +
> > +	unbind_data.argsz = offsetof(struct iommu_gpasid_bind_data, vendor);
> I do not remember to have seen this documented anywhere, ie. on unbind,
> the vendor data are not used.

right. perhaps needs to doc it in Jacob's patch. @Pan, Jacob jun

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
> > @@ -2392,6 +2464,21 @@ static void vfio_iommu_type1_detach_group(void
> *iommu_data,
> >  		if (!group)
> >  			continue;
> >
> > +		if (iommu->nesting_info && iommu->vmm &&
> if vmm is set, doesn't it mean nesting_info is set?

yes, will remove the check against iommu->nesting_info.

> > +		    (iommu->nesting_info->features &
> > +					IOMMU_NESTING_FEAT_BIND_PGTBL)) {
> > +			struct domain_capsule dc = { .group = group,
> > +						     .domain = domain->domain,
> > +						     .data = NULL };
> > +
> > +			/*
> > +			 * Unbind page tables bound with system wide PASIDs
> > +			 * which are allocated to userspace.
> > +			 */
> > +			vfio_mm_for_each_pasid(iommu->vmm, &dc,
> > +					       vfio_group_unbind_gpasid_fn);
> > +		}
> > +
> >  		vfio_iommu_detach_group(domain, group);
> >  		update_dirty_scope = !group->pinned_page_dirty_scope;
> >  		list_del(&group->next);
> > @@ -2926,6 +3013,78 @@ static int vfio_iommu_type1_pasid_request(struct
> vfio_iommu *iommu,
> >  	return ret;
> >  }
> >
> > +static long vfio_iommu_handle_pgtbl_op(struct vfio_iommu *iommu,
> > +				       bool is_bind, unsigned long arg)
> > +{
> > +	struct domain_capsule dc = { .data = &arg };
> > +	struct iommu_nesting_info *info;
> > +	int ret;
> > +
> > +	mutex_lock(&iommu->lock);
> > +
> > +	info = iommu->nesting_info;
> > +	if (!info || !(info->features & IOMMU_NESTING_FEAT_BIND_PGTBL)) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out_unlock;
> > +	}
> > +
> > +	if (!iommu->vmm) {
> Is it documented anywhere, besides in this commit message that
> IOMMU_NESTING_FEAT_BIND_PGTBL requires
> IOMMU_NESTING_FEAT_SYSWIDE_PASID
> (in uapi doc)?

nice catch. it is not documented anywhere. VFIO_IOMMU_NESTING_OP_BIND_PGTBL
should work for the bind with pasid or without pasid. perhaps, I can add a
flag in vfio to differentiate the two bind cases. is it workable per your
opinion?

> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	ret = vfio_get_nesting_domain_capsule(iommu, &dc);
> > +	if (ret)
> > +		goto out_unlock;
> > +
> > +	/* Avoid race with other containers within the same process */
> > +	vfio_mm_pasid_lock(iommu->vmm);
> > +
> > +	ret = 0;
> non needed

oh yes.

> > +	if (is_bind)
> > +		ret = iommu_group_for_each_dev(dc.group->iommu_group, &dc,
> > +					       vfio_dev_bind_gpasid_fn);
> > +	if (ret || !is_bind) {
> > +		iommu_group_for_each_dev(dc.group->iommu_group,
> > +					 &dc, vfio_dev_unbind_gpasid_fn);
> > +		ret = 0;
> ret is not correct in case bind previously failed. You should return the
> original ret in that case.

right. will remove ret = 0.

> > +	}
> > +
> > +	vfio_mm_pasid_unlock(iommu->vmm);
> > +out_unlock:
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
> Checking against VFIO_NESTING_OP_MASK is not enough precise enough (I
> mean OP_MASK should only encompasses the actual supported ops). If a a
> userspace tries to use a new OP in the future and if this runs on this
> kernel version, you will fait to recognize the lack of support.

yes, this should be fixed. this code only ensures the high 16 bits are
valid, but failed to check the lower 16 bits. the op counts from 0 to
2^16-1. so I may add a MAX_OP macro to serve the purpose of failing
unsupported op usage.

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
> > @@ -2944,6 +3103,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  		return vfio_iommu_type1_dirty_pages(iommu, arg);
> >  	case VFIO_IOMMU_PASID_REQUEST:
> >  		return vfio_iommu_type1_pasid_request(iommu, arg);
> > +	case VFIO_IOMMU_NESTING_OP:
> > +		return vfio_iommu_type1_nesting_op(iommu, arg);
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
> > index 8d0317f..e531d4a 100644
> > --- a/drivers/vfio/vfio_pasid.c
> > +++ b/drivers/vfio/vfio_pasid.c
> > @@ -221,6 +221,8 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  	 * IOASID core will notify PASID users (e.g. IOMMU driver) to
> >  	 * teardown necessary structures depending on the to-be-freed
> >  	 * PASID.
> > +	 * Hold pasid_lock also avoids race with PASID usages like bind/
> > +	 * unbind page tables to requested PASID.
> >  	 */
> >  	mutex_lock(&vmm->pasid_lock);
> >  	while ((vid = vfio_find_pasid(vmm, min, max)) != NULL)
> > @@ -229,6 +231,30 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
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
> > index a355d01..e835c23 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -105,6 +105,11 @@ extern int vfio_mm_ioasid_sid(struct vfio_mm *vmm);
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
> > index 6d79557..9501cfb 100644
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
> > + * This interface allows userspace to utilize the nesting IOMMU
> > + * capabilities as reported in VFIO_IOMMU_TYPE1_INFO_CAP_NESTING
> > + * cap through VFIO_IOMMU_GET_INFO.
> PASID alloc/free are handled through another IOCTL so you should be more
> precise I think.

yep. will add it.

Regards,
Yi Liu

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
