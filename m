Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89792C433E1
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:05:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584762072D
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Xj7dLB2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584762072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0B03820392;
	Mon, 17 Aug 2020 07:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2czkKphzBeWk; Mon, 17 Aug 2020 07:05:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BC26F203E6;
	Mon, 17 Aug 2020 07:05:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98D1CC088B;
	Mon, 17 Aug 2020 07:05:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D71CC0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:05:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 06CE987F5A
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:05:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8-pK+ELI-2bc for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 07:05:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AC96287F38
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:05:38 +0000 (UTC)
IronPort-SDR: uvUuw/+C8+BS4fWuyR7Xi+AJpXCaVa3ANkDDrCdWqzq6YNQ8j+8YQA/oS85i5+p2fOJBbZ9gKV
 yWdketA1tYOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="152294373"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="152294373"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 00:05:38 -0700
IronPort-SDR: TN43f2icxfR863ncZGIkQjplb1UDaVnRk/WTXsGxcyEFJvLlVVbo1MKCbfaQscaYN3n6tKxiAF
 fPRk3V3RSAVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="471326703"
Received: from unknown (HELO fmsmsx604.amr.corp.intel.com) ([10.18.84.214])
 by orsmga005.jf.intel.com with ESMTP; 17 Aug 2020 00:05:37 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 17 Aug 2020 00:05:36 -0700
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 17 Aug 2020 00:05:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 17 Aug 2020 00:05:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 17 Aug 2020 00:05:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWkcBjv+B+OIFcgn7b/Z4FS4luOmcIB51+I8xlRfjj8eq91WZbcd98dW0UQXpW9G85sJT0bSUK9yk0OQCzGijsxa9XpM+7kTP5sfRZlQVjSNgCRFp17U25x2YlScfXH0ywcSREoqSyl9qoxc+uGNjmNz8MfVe0MhR9tOR/bz0EAjVgnwA0DVdHXiQmUq/JvjKSSZaEZ/B6I17x1NawaWPDqzBN/pufB/0fQPvdUQkBAp2m5gzdmRbWaSgGTnS50vpN7b+Vbbw9xzZ9c+fm5ECBV27tX6eQA5cHmIvP/1xbI4qcDomvYBDIjZWWIjU3pQxG9f9AU5zQUNp8Rjpd+lmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E2y0gamZxI1MvTMz7+cy3n6NWL1n6HzQDm3lXIew+g=;
 b=aSFKZpITrW96lm57sVs/ywXTwYzE5+CZ/gGFRQiSjZBwcXQ8cQBeyLpsd/dU3jPV79Jc7Xb6r8mFRZxPHPPamdXlei0ElFKaCvGWrnF7sAiZy/cPHi0Gf3m0HuabuLNGb12a50itNWOZa+sA+Pl2JU1S9TxNk/W7m5EF59x+VBl3wxyc6Wny3fQFmy5sl8vilxP0xCIqEgfTxxvwo/fIS/z+ADTX2neQhbBTkQbRQlob/1nmJ8n74EkVVd62+KWtrRkNGU+vHR40vltrgZ+t5RtcWIa+H3VFxtNjlstHrbeYKoowjvAkYnXIpZ5EyT0qIwM1A+9mBaztwdtEqDVUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E2y0gamZxI1MvTMz7+cy3n6NWL1n6HzQDm3lXIew+g=;
 b=Xj7dLB2LHVBEgoiGmFzjRBk1CfyVyOwg2/uYsXA9qxLiJd69fHalTciFIy3PUkV1BPNQp+pudvJ5MLPXHKoY/i9jl6Pq7HnmPGX0p+bPkDUkmEMN73PSh8/fcq2cHFS2TS0omHW8AlymCj4sA5Uqh+c2nUYGCtYWMkp7oSpnqDw=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.22; Mon, 17 Aug 2020 07:05:34 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3283.027; Mon, 17 Aug
 2020 07:05:34 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>, "Lu, Baolu"
 <baolu.lu@intel.com>
Subject: RE: [PATCH v6 15/15] iommu/vt-d: Support reporting nesting capability
 info
Thread-Topic: [PATCH v6 15/15] iommu/vt-d: Support reporting nesting
 capability info
Thread-Index: AQHWZKdN2jQ/iA01+E66P0YDXHPJ1qk6wIWAgAE+lvA=
Date: Mon, 17 Aug 2020 07:05:34 +0000
Message-ID: <DM5PR11MB14351B5746A8A09E2EBCBEBDC35F0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-16-git-send-email-yi.l.liu@intel.com>
 <7fe337fa-abbc-82be-c8e8-b9e2a6179b90@redhat.com>
In-Reply-To: <7fe337fa-abbc-82be-c8e8-b9e2a6179b90@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: baolu.lu@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.230.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5b7f940-534f-4d2a-eaf6-08d8427befac
x-ms-traffictypediagnostic: DM5PR11MB1692:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1692A26FBC6DFA45B63704CBC35F0@DM5PR11MB1692.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtYmnWKIVe/Jg1Li1eiHl+lYXusB650QJtbERigfmWqDROmLr/qxG1udZTZk15NiQHHFQZzGlaJ9Sqr7YLjTGC0jZOA5FY2iiH48s6/2XZUjtY4/lrrmEXo+yZVrESZaylFoCoFx2t/TZCZqNf9QM4IS+suIYhrcuY1TzYuzM593gtgUDKWfZ/Roz9qpGu7L81kn9fPU41141fG8FH/G5sS/qV2IiHSrb+B6MwCsXtJyeMREVgUdBqrSIqAOTMMQJ+D3wWZD/ePhwUozKPB0ICopb8HtyWREj5aTBuKVUmLcmKURSGWliy3kclr3FIRaaOQi2FiRsWjrt0MQ9C9T8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(83380400001)(7696005)(8936002)(52536014)(86362001)(4326008)(7416002)(26005)(54906003)(186003)(76116006)(2906002)(66556008)(66476007)(66446008)(110136005)(53546011)(64756008)(66946007)(6506007)(8676002)(55016002)(5660300002)(33656002)(6636002)(478600001)(316002)(71200400001)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: AmzYtsnEdNLMXxPlMsS/UhV0DjALEuFNkky+WGCN0YutNd06Qn/GWBeqrLWdqpahdlFK+1SdYGbV8PR2BXxU9QC5uYkz1n/UAjLZiepVrKWdUsSmBjrKiXAsiAq0a+bAPifGQGe2IaTVrqt+zbYMhsadct2L5GcXKfQYXvKkOQRtIS4TRDkXJqL4Ou7gN2AeAacuSvWndKnME7g/uK6nFWaWjXScUmZVa6vwS4aaCgt+l8F4BNdmspsviBsjBxLhbWgg0GvmA8Nq9ntwWpc6NCYoz3+puzOMOd8TlMKh6yoRpFDv0H/CZWkBppzXvn8IYYH2TdEKZ1Z6L7Bc4mjLCBP4JuFjSfGPZkzkK0ftm/SNmeNQN/t4LedsCRS31LI8tttpM3dnV+aKYfSg3xwoXdBXALfXHSsrjNjPNMK4unuwKlEYw/QyLOtxhe4Ar+lQsEMzi/KLBFJnydxY3z7ICGZtkFWVNRThODs9tY9K1hEJv/MKvkxwwFZV4eEKItgHPSiFbYX5N9SWeLsoWefU06w+3RfdZmNPdeg9COLNQLCKSkBRK++qzNmVnIDMqVOQb2uzEPYL50dtkA/Y09bQshYBYK4YG84fhll9z2nrAggr+dIOfv5Yami129JTCJQzVsfHAtY7tv3N8MwXe6xDtg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b7f940-534f-4d2a-eaf6-08d8427befac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 07:05:34.0403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZl48Ev4WVzCIWGv2zZK4k8ThwERWnYY+ZnL7RXC9U7AJ8H8nNZFxSLhu5JxyDP6Skkrfdc6gPEja2WJdk7sXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1692
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

> Auger Eric <eric.auger@redhat.com>
> Sent: Sunday, August 16, 2020 8:01 PM
> 
> Hi Yi,
> 
> On 7/28/20 8:27 AM, Liu Yi L wrote:
> > This patch reports nesting info, and only supports the case where all
> > the physical iomms have the same CAP/ECAP MASKS.
> s/iomms/iommus

yep.

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
> > v2 -> v3:
> > *) remove cap/ecap_mask in iommu_nesting_info.
> > ---
> >  drivers/iommu/intel/iommu.c | 81
> +++++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/intel-iommu.h | 16 +++++++++
> >  2 files changed, 95 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 88f4647..0835804 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5660,12 +5660,16 @@ static inline bool iommu_pasid_support(void)
> >  static inline bool nested_mode_support(void)
> >  {
> >  	struct dmar_drhd_unit *drhd;
> > -	struct intel_iommu *iommu;
> > +	struct intel_iommu *iommu, *prev = NULL;
> >  	bool ret = true;
> >
> >  	rcu_read_lock();
> >  	for_each_active_iommu(iommu, drhd) {
> > -		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap)) {
> > +		if (!prev)
> > +			prev = iommu;
> > +		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap) ||
> > +		    (VTD_CAP_MASK & (iommu->cap ^ prev->cap)) ||
> > +		    (VTD_ECAP_MASK & (iommu->ecap ^ prev->ecap))) {
> >  			ret = false;
> >  			break;
> So this changes the behavior of DOMAIN_ATTR_NESTING. Shouldn't it have a
> Fixes tag as well? And maybe add the capability getter in a separate patch?

yes, this changed the behavior. so it would be better to be a separate patch
and upstream along? how about your idea? @Lu, Baolu :-)

> >  		}
> > @@ -6081,6 +6085,78 @@ intel_iommu_domain_set_attr(struct iommu_domain
> *domain,
> >  	return ret;
> >  }
> >
> > +static int intel_iommu_get_nesting_info(struct iommu_domain *domain,
> > +					struct iommu_nesting_info *info)
> > +{
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	u64 cap = VTD_CAP_MASK, ecap = VTD_ECAP_MASK;
> > +	struct device_domain_info *domain_info;
> > +	struct iommu_nesting_info_vtd vtd;
> > +	unsigned long flags;
> > +	unsigned int size;
> > +

perhaps better to acquire the lock here. [1]

> > +	if (domain->type != IOMMU_DOMAIN_UNMANAGED ||
> > +	    !(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE))
> > +		return -ENODEV;
> > +
> > +	if (!info)
> > +		return -EINVAL;
> > +
> > +	size = sizeof(struct iommu_nesting_info) +
> > +		sizeof(struct iommu_nesting_info_vtd);
> > +	/*
> > +	 * if provided buffer size is smaller than expected, should
> > +	 * return 0 and also the expected buffer size to caller.
> > +	 */
> > +	if (info->argsz < size) {
> > +		info->argsz = size;
> > +		return 0;
> > +	}
> > +
> > +	spin_lock_irqsave(&device_domain_lock, flags);
> > +	/*
> > +	 * arbitrary select the first domain_info as all nesting
> > +	 * related capabilities should be consistent across iommu
> > +	 * units.
> > +	 */
> > +	domain_info = list_first_entry(&dmar_domain->devices,
> > +				       struct device_domain_info, link);
> > +	cap &= domain_info->iommu->cap;
> > +	ecap &= domain_info->iommu->ecap;
> > +	spin_unlock_irqrestore(&device_domain_lock, flags);
> > +
> > +	info->format = IOMMU_PASID_FORMAT_INTEL_VTD;
> > +	info->features = IOMMU_NESTING_FEAT_SYSWIDE_PASID |
> > +			 IOMMU_NESTING_FEAT_BIND_PGTBL |
> > +			 IOMMU_NESTING_FEAT_CACHE_INVLD;
> > +	info->addr_width = dmar_domain->gaw;
> > +	info->pasid_bits = ilog2(intel_pasid_max_id);
> > +	info->padding = 0;
> > +	vtd.flags = 0;
> > +	vtd.padding = 0;
> > +	vtd.cap_reg = cap;
> > +	vtd.ecap_reg = ecap;
> > +
> > +	memcpy(info->data, &vtd, sizeof(vtd));
> > +	return 0;
> > +}
> > +
> > +static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
> > +				       enum iommu_attr attr, void *data)
> > +{
> > +	switch (attr) {
> > +	case DOMAIN_ATTR_NESTING:
> > +	{
> > +		struct iommu_nesting_info *info =
> > +				(struct iommu_nesting_info *)data;
> 
> don't you need to hold a device_domain_lock earlier to make sure domain
> attributes can't change behind your back (unmanaged type and nested mode)?

do you mean acquire lock at [1]?

Regards,
Yi Liu

> > +
> > +		return intel_iommu_get_nesting_info(domain, info);
> > +	}
> > +	default:
> > +		return -ENOENT;
> > +	}
> > +}
> > +
> >  /*
> >   * Check that the device does not live on an external facing PCI port that is
> >   * marked as untrusted. Such devices should not be able to apply quirks and
> > @@ -6103,6 +6179,7 @@ const struct iommu_ops intel_iommu_ops = {
> >  	.domain_alloc		= intel_iommu_domain_alloc,
> >  	.domain_free		= intel_iommu_domain_free,
> >  	.domain_set_attr	= intel_iommu_domain_set_attr,
> > +	.domain_get_attr	= intel_iommu_domain_get_attr,
> >  	.attach_dev		= intel_iommu_attach_device,
> >  	.detach_dev		= intel_iommu_detach_device,
> >  	.aux_attach_dev		= intel_iommu_aux_attach_device,
> > diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> > index f98146b..5acf795 100644
> > --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -197,6 +197,22 @@
> >  #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
> >  #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
> >
> > +/* Nesting Support Capability Alignment */
> > +#define VTD_CAP_FL1GP		BIT_ULL(56)
> > +#define VTD_CAP_FL5LP		BIT_ULL(60)
> > +#define VTD_ECAP_PRS		BIT_ULL(29)
> > +#define VTD_ECAP_ERS		BIT_ULL(30)
> > +#define VTD_ECAP_SRS		BIT_ULL(31)
> > +#define VTD_ECAP_EAFS		BIT_ULL(34)
> > +#define VTD_ECAP_PASID		BIT_ULL(40)
> > +
> > +/* Only capabilities marked in below MASKs are reported */
> > +#define VTD_CAP_MASK		(VTD_CAP_FL1GP | VTD_CAP_FL5LP)
> > +
> > +#define VTD_ECAP_MASK		(VTD_ECAP_PRS | VTD_ECAP_ERS | \
> > +				 VTD_ECAP_SRS | VTD_ECAP_EAFS | \
> > +				 VTD_ECAP_PASID)
> > +
> >  /* Virtual command interface capability */
> >  #define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation
> */
> >
> >
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
