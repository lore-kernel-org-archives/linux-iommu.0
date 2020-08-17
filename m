Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9C4C433E1
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:45:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143F72072D
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 07:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="pu7VuQtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143F72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E354F875AE;
	Mon, 17 Aug 2020 07:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0yLKdlUz9mSJ; Mon, 17 Aug 2020 07:45:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06A8887580;
	Mon, 17 Aug 2020 07:45:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1D3FC07FF;
	Mon, 17 Aug 2020 07:45:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0A05C0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DBAE08651D
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OFzX1UuCpMfu for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 07:45:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A0CBA861C8
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 07:45:11 +0000 (UTC)
IronPort-SDR: MjgPDusoUZzg5KCFaIUjOdoZFToXqzuSooXWcvd6TJKQYyRE4i1OL9ljKINT3kBVgBuY/NBDQa
 prHgrZHS9asQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="134167696"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="134167696"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2020 00:45:09 -0700
IronPort-SDR: 03tOiTjvFJ/T/TvwT0OpsQzkUpYplUlasHq9gOFnnzSArDT7WkKhb4LGfIn2wsKapjpwN3np4v
 UEaMIORluHkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="319626635"
Received: from orsmsx601-2.jf.intel.com (HELO ORSMSX601.amr.corp.intel.com)
 ([10.22.229.81])
 by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2020 00:45:08 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 17 Aug 2020 00:45:07 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 17 Aug 2020 00:45:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 17 Aug 2020 00:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAckd4QlQrVgU1Iq0/SvMPF/ABh2GoWigpl5QuoizfCuadPidI9zwz1SfyBg0ZqFaz5UTzq4ZAjNyATxYifZmEA7oeO0pFMm5p25CNjifpV3SS4/1+p3dYA/6nd+Mk8NLd7FLkNO2bbrxNl+SrOWJASUhffyYSHYc2zMybzngwN24SMZGuG+DEr4I6LDi0dRy2IiYw4biFglin64U6CfimUvNvcvKP1OQXN1oUqNVMmJAjBobLzZvfcTfKbqZ7f8jtJLrEyILZBSGaN6NTwBKMRtInqn0s1lHFky/kkuq5INedZJJFLS+ZzDUVCb6LRWTGt38GzbQ0sBB59BiJDAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdxA4Y2I/aXpPWkY+QYfLqSO+k9CkQz3Pxg54Ct9Cz4=;
 b=WeW+4389gIFGCJ34lxLHB7jb58zhvwhOGeLBqUFOynyXGSft6hvsPUu5SYatFX7nxm6bbDgSoIlYyYmmwlQJv182+9VGn6ZrRN9w7TR3rgWplt8a8mW3n0vb0V8DKdAL55DbQLvVpAwzd18cIkyxE+R3zXgZGTRE3ka+GgKWEEq/x0QCnj1RJGBQrq85tBUhvW09QTB2SX/ZU5C9mnmk7cJsBxRWFUq9wlRYOsa4vU6d3pimL9XLEcqusCGgaTBHSvBhYQSygdLjdaZ8GjkOL+MgmlskIdHclRBaCU+ta7Jp786NWlW3V1fadPJT5b4ZNLZ5VzcOOUxLIEOIJR3ncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdxA4Y2I/aXpPWkY+QYfLqSO+k9CkQz3Pxg54Ct9Cz4=;
 b=pu7VuQtmufPTxH0BFf6SEvMwRnfVT5tvIVlsNLsVq1s+tLA0risFgT2t+z1/SgSeCwrvp0ksShUkmR+Rxuvoc8Oreuj2QEa2yT+iweQPh/bxqPQvuxajQRlPw8dBKYGM1nm0Iu0PImOCrpAkXuS9AXLFmd4V9VhO4amNKt4TM4A=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1434.namprd11.prod.outlook.com (2603:10b6:4:9::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.23; Mon, 17 Aug 2020 07:45:04 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3283.027; Mon, 17 Aug
 2020 07:45:04 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>, "Lu, Baolu"
 <baolu.lu@intel.com>
Subject: RE: [PATCH v6 15/15] iommu/vt-d: Support reporting nesting capability
 info
Thread-Topic: [PATCH v6 15/15] iommu/vt-d: Support reporting nesting
 capability info
Thread-Index: AQHWZKdN2jQ/iA01+E66P0YDXHPJ1qk6wIWAgAE+lvCAAAuigIAAAGfQ
Date: Mon, 17 Aug 2020 07:45:04 +0000
Message-ID: <DM5PR11MB14352387C6990D0DF03B068DC35F0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-16-git-send-email-yi.l.liu@intel.com>
 <7fe337fa-abbc-82be-c8e8-b9e2a6179b90@redhat.com>
 <DM5PR11MB14351B5746A8A09E2EBCBEBDC35F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <83376141-8357-8100-54f5-2ccbf2e09090@redhat.com>
In-Reply-To: <83376141-8357-8100-54f5-2ccbf2e09090@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3df9c4f-ce91-463d-96d7-08d842817492
x-ms-traffictypediagnostic: DM5PR11MB1434:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1434B75C5281542ABEF6FD19C35F0@DM5PR11MB1434.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qngRo31bFxWcTl2vuXNCWLqg2saoWuSPSfYg92dyti977Tpc9l1kCbdf7AbpuG9JH/9LgV8BuzClLXfRzz1Cgt4/SOqsV7l14HfurTrzeZA6G8QG+WvzoviMfhOxK4Ez3H5dLxwLnytf9CtuicTS14PR5QYRFhH5dXUB7RswUpz6lSIMgngyrTAsHxcybvA/xArirPyMNq3riEhqx/wwlJ6Rr2oa8VyN7+grtd3+61yWMzWFvW75qc8oixQiq1N/gKkuU6LiGJ84YS1o5aViKY8bbwQ6mK2YW035QFW/z3nRhElaJGxZQ7170nPChtqWiT6YjCA9wTCEm3Ge72+4+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(66476007)(64756008)(66446008)(8676002)(83380400001)(86362001)(316002)(110136005)(6636002)(54906003)(66556008)(52536014)(76116006)(66946007)(53546011)(9686003)(55016002)(7416002)(5660300002)(71200400001)(26005)(186003)(2906002)(8936002)(4326008)(33656002)(7696005)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: UxMxfxq+tWvTbIvYiM5zyMcpLRH95nluZF0acefWElyMEk2oTSmE3qVCKivd1zntQJk8nrqP+AOGXx7J5TItTaNtLH6mwngtsf9IC2HBFN2zE19gll4/lZnTsHIZGKa3yObdnSe0eya2co6+PrxgfQOLdKLozqK9ls2bSwUOIjp6Eto+6/16azT73EexhLugEV9UeCeH5KW0v+/2y6aXYAa17suxbS5f84YOEf5uP5ziqdWzfs8IrwupghK/sRxo4REC+QrJmGRZJKleEYeICvspH6T1jmNBbQWw9c8uidz66dMTrGyu4qjedtyY1OOfnbNlHleGIkt2P8ghjD+JUANOY7x8mOUzbYTeJ9v4A/wBF7B7iqivbsofb/9JDF+6ricZdLIGdaYUrMNphc6AQ8a+Yeq17diksTJ5iVhpyCZkpy8zM5r5koHcstWfXbkhFjThjnvUSVsLTMe4DF7+tkC+Fs+Vj7gyi22XnV697KFc/qdn4mvwiKthoLaJk3VW3SDMPqsCVKQljMT3PCexCj5yWUC/EG48yAlM8scglpwkd48LGWlJxudb0BUe5fTlrS7epgsQXNoqmMzlhVNQBw08PsR2at9YGlJRNXTqAMy1n2qb1C8RPRB0zdLCjssQF0ZYvb6drpiOUcFWbTr2/w==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3df9c4f-ce91-463d-96d7-08d842817492
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 07:45:04.5014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYecwWa3j9m05fYVfcKSpzFBtfqeB8OudU2tz309y9u1iawMsQ18C+9a95e2b4Ar3r8HNsSOtAa5RBJcfKpodQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1434
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

Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Monday, August 17, 2020 3:43 PM
> 
> On 8/17/20 9:05 AM, Liu, Yi L wrote:
> > Hi Eric,
> >
> >> Auger Eric <eric.auger@redhat.com>
> >> Sent: Sunday, August 16, 2020 8:01 PM
> >>
> >> Hi Yi,
> >>
> >> On 7/28/20 8:27 AM, Liu Yi L wrote:
> >>> This patch reports nesting info, and only supports the case where all
> >>> the physical iomms have the same CAP/ECAP MASKS.
> >> s/iomms/iommus
> >
> > yep.
> >
> >>>
> >>> Cc: Kevin Tian <kevin.tian@intel.com>
> >>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Cc: Alex Williamson <alex.williamson@redhat.com>
> >>> Cc: Eric Auger <eric.auger@redhat.com>
> >>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>> Cc: Joerg Roedel <joro@8bytes.org>
> >>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> >>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> ---
> >>> v2 -> v3:
> >>> *) remove cap/ecap_mask in iommu_nesting_info.
> >>> ---
> >>>  drivers/iommu/intel/iommu.c | 81
> >> +++++++++++++++++++++++++++++++++++++++++++--
> >>>  include/linux/intel-iommu.h | 16 +++++++++
> >>>  2 files changed, 95 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> >>> index 88f4647..0835804 100644
> >>> --- a/drivers/iommu/intel/iommu.c
> >>> +++ b/drivers/iommu/intel/iommu.c
> >>> @@ -5660,12 +5660,16 @@ static inline bool iommu_pasid_support(void)
> >>>  static inline bool nested_mode_support(void)
> >>>  {
> >>>  	struct dmar_drhd_unit *drhd;
> >>> -	struct intel_iommu *iommu;
> >>> +	struct intel_iommu *iommu, *prev = NULL;
> >>>  	bool ret = true;
> >>>
> >>>  	rcu_read_lock();
> >>>  	for_each_active_iommu(iommu, drhd) {
> >>> -		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap)) {
> >>> +		if (!prev)
> >>> +			prev = iommu;
> >>> +		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap) ||
> >>> +		    (VTD_CAP_MASK & (iommu->cap ^ prev->cap)) ||
> >>> +		    (VTD_ECAP_MASK & (iommu->ecap ^ prev->ecap))) {
> >>>  			ret = false;
> >>>  			break;
> >> So this changes the behavior of DOMAIN_ATTR_NESTING. Shouldn't it have a
> >> Fixes tag as well? And maybe add the capability getter in a separate patch?
> >
> > yes, this changed the behavior. so it would be better to be a separate patch
> > and upstream along? how about your idea? @Lu, Baolu :-)
> >
> >>>  		}
> >>> @@ -6081,6 +6085,78 @@ intel_iommu_domain_set_attr(struct
> iommu_domain
> >> *domain,
> >>>  	return ret;
> >>>  }
> >>>
> >>> +static int intel_iommu_get_nesting_info(struct iommu_domain *domain,
> >>> +					struct iommu_nesting_info *info)
> >>> +{
> >>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> >>> +	u64 cap = VTD_CAP_MASK, ecap = VTD_ECAP_MASK;
> >>> +	struct device_domain_info *domain_info;
> >>> +	struct iommu_nesting_info_vtd vtd;
> >>> +	unsigned long flags;
> >>> +	unsigned int size;
> >>> +
> >
> > perhaps better to acquire the lock here. [1]
> >
> >>> +	if (domain->type != IOMMU_DOMAIN_UNMANAGED ||
> >>> +	    !(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE))
> >>> +		return -ENODEV;
> >>> +
> >>> +	if (!info)
> >>> +		return -EINVAL;
> >>> +
> >>> +	size = sizeof(struct iommu_nesting_info) +
> >>> +		sizeof(struct iommu_nesting_info_vtd);
> >>> +	/*
> >>> +	 * if provided buffer size is smaller than expected, should
> >>> +	 * return 0 and also the expected buffer size to caller.
> >>> +	 */
> >>> +	if (info->argsz < size) {
> >>> +		info->argsz = size;
> >>> +		return 0;
> >>> +	}
> >>> +
> >>> +	spin_lock_irqsave(&device_domain_lock, flags);
> >>> +	/*
> >>> +	 * arbitrary select the first domain_info as all nesting
> >>> +	 * related capabilities should be consistent across iommu
> >>> +	 * units.
> >>> +	 */
> >>> +	domain_info = list_first_entry(&dmar_domain->devices,
> >>> +				       struct device_domain_info, link);
> >>> +	cap &= domain_info->iommu->cap;
> >>> +	ecap &= domain_info->iommu->ecap;
> >>> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> >>> +
> >>> +	info->format = IOMMU_PASID_FORMAT_INTEL_VTD;
> >>> +	info->features = IOMMU_NESTING_FEAT_SYSWIDE_PASID |
> >>> +			 IOMMU_NESTING_FEAT_BIND_PGTBL |
> >>> +			 IOMMU_NESTING_FEAT_CACHE_INVLD;
> >>> +	info->addr_width = dmar_domain->gaw;
> >>> +	info->pasid_bits = ilog2(intel_pasid_max_id);
> >>> +	info->padding = 0;
> >>> +	vtd.flags = 0;
> >>> +	vtd.padding = 0;
> >>> +	vtd.cap_reg = cap;
> >>> +	vtd.ecap_reg = ecap;
> >>> +
> >>> +	memcpy(info->data, &vtd, sizeof(vtd));
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
> >>> +				       enum iommu_attr attr, void *data)
> >>> +{
> >>> +	switch (attr) {
> >>> +	case DOMAIN_ATTR_NESTING:
> >>> +	{
> >>> +		struct iommu_nesting_info *info =
> >>> +				(struct iommu_nesting_info *)data;
> >>
> >> don't you need to hold a device_domain_lock earlier to make sure domain
> >> attributes can't change behind your back (unmanaged type and nested mode)?
> >
> > do you mean acquire lock at [1]?
> yep either at [1] or before calling intel_iommu_get_nesting_info and
> adding a comment saying intel_iommu_get_nesting_info() shall be called
> with the lock held

will do. :-)

Regards,
Yi Liu

> Thanks
> 
> Eric
> >
> > Regards,
> > Yi Liu
> >
> >>> +
> >>> +		return intel_iommu_get_nesting_info(domain, info);
> >>> +	}
> >>> +	default:
> >>> +		return -ENOENT;
> >>> +	}
> >>> +}
> >>> +
> >>>  /*
> >>>   * Check that the device does not live on an external facing PCI port that is
> >>>   * marked as untrusted. Such devices should not be able to apply quirks and
> >>> @@ -6103,6 +6179,7 @@ const struct iommu_ops intel_iommu_ops = {
> >>>  	.domain_alloc		= intel_iommu_domain_alloc,
> >>>  	.domain_free		= intel_iommu_domain_free,
> >>>  	.domain_set_attr	= intel_iommu_domain_set_attr,
> >>> +	.domain_get_attr	= intel_iommu_domain_get_attr,
> >>>  	.attach_dev		= intel_iommu_attach_device,
> >>>  	.detach_dev		= intel_iommu_detach_device,
> >>>  	.aux_attach_dev		= intel_iommu_aux_attach_device,
> >>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> >>> index f98146b..5acf795 100644
> >>> --- a/include/linux/intel-iommu.h
> >>> +++ b/include/linux/intel-iommu.h
> >>> @@ -197,6 +197,22 @@
> >>>  #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
> >>>  #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
> >>>
> >>> +/* Nesting Support Capability Alignment */
> >>> +#define VTD_CAP_FL1GP		BIT_ULL(56)
> >>> +#define VTD_CAP_FL5LP		BIT_ULL(60)
> >>> +#define VTD_ECAP_PRS		BIT_ULL(29)
> >>> +#define VTD_ECAP_ERS		BIT_ULL(30)
> >>> +#define VTD_ECAP_SRS		BIT_ULL(31)
> >>> +#define VTD_ECAP_EAFS		BIT_ULL(34)
> >>> +#define VTD_ECAP_PASID		BIT_ULL(40)
> >>> +
> >>> +/* Only capabilities marked in below MASKs are reported */
> >>> +#define VTD_CAP_MASK		(VTD_CAP_FL1GP | VTD_CAP_FL5LP)
> >>> +
> >>> +#define VTD_ECAP_MASK		(VTD_ECAP_PRS | VTD_ECAP_ERS | \
> >>> +				 VTD_ECAP_SRS | VTD_ECAP_EAFS | \
> >>> +				 VTD_ECAP_PASID)
> >>> +
> >>>  /* Virtual command interface capability */
> >>>  #define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation
> >> */
> >>>
> >>>
> >> Thanks
> >>
> >> Eric
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
