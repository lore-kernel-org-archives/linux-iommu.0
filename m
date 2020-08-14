Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FECAC433E1
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 08:04:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B772065C
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 08:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="CAYVWUDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B772065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BE9C724FAC;
	Fri, 14 Aug 2020 08:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SS53SEerO0ST; Fri, 14 Aug 2020 08:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A8B042046D;
	Fri, 14 Aug 2020 08:04:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 877FAC07FF;
	Fri, 14 Aug 2020 08:04:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85253C004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 08:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7D1F887F39
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 08:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8A+Cn8APZEYi for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 08:04:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8DBE887D3B
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 08:04:32 +0000 (UTC)
IronPort-SDR: plPwXnIl2+9KbgXQYHINCMCSMR9UBylwtIxAwrm2mgbj3jC1ItQ2M2EXeGXhDnyVVjkKX7ywLy
 q6eZYM5p19BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="134430906"
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; d="scan'208";a="134430906"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 01:04:31 -0700
IronPort-SDR: ujHSCwuwX5rvQe0NiFOTmIa9AF01udBLN2BkdhMLlNsz4p7OJf0lu6147jr7RGL7cfJKCP1XY3
 7QbjtATjSTFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; d="scan'208";a="369839071"
Received: from fmsmsx602-2.cps.intel.com (HELO fmsmsx602.amr.corp.intel.com)
 ([10.18.84.212])
 by orsmga001.jf.intel.com with ESMTP; 14 Aug 2020 01:04:31 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 01:04:30 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Aug 2020 01:04:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Aug 2020 01:04:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 14 Aug 2020 01:04:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKKJvVJlJw6Xw4PsFWq717sij2/lSn04R2IGPapIiasvPTGLaBOZKO4/+NF+TKt4oSUOKNcWzPholQ+kHwLd7i/RE/q8tBlvC307zZUmDPgqZRwSp9Sv8xlBuVwRdFcMGBeXG0ghURwo9gB7BjEbXV0q+2H5jozHMq72wayHGTKUjUszQUnbSwTOhQCbq+6GptbLsdMk5+/G1UfvA9Y/DBPbEk7w0AQ1Yf9EQRv/f1rC7GSB8YWxi1oEmy7MwD0UEB/UhKSiRFUbjmvsmXzc9sgt+yLqK4oluHJBr7RWuq01xP9zIEQCb1EXRyiHguH57j16pH/4elDa0A+XkqBImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idtRZA57xfaRUh46gfc2kvUxgQab3KeAsOwC1O10AhE=;
 b=ccf/7DJHP9pa/gp5JrbatCUV9+VC5S7hstyWSn9+G/756OzwVHkKBIxYUnYTzcRy6mtIBqcjXsAQOUqpiwTxAY2UPjFXXmgjVgThZFjr7ZdIcLqiffQaLzalIV9PArRGCD+V6odAHhCLKI7KYMwC95zKfRYTjdhDaFQ87kOgD50ByIuUFPw2Et+FVEI95ZXsSgvJLXm9Tz0NG/k642f6COp0qdX5qG6q1D1E0akgANNXWNS68enqDKWUCJWPbDHLfy5iI8lpTFRqqdRXOZESR6tFliqo+SKNrzKiHe66S7eLZO9z5pHgHggexdAdUqGJ52sjCJiucDs6pT9drpVQmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idtRZA57xfaRUh46gfc2kvUxgQab3KeAsOwC1O10AhE=;
 b=CAYVWUDjwaoqo3baF+oiVyfqcOAkhJdJAg5bkmJQy2lwjnJm4jMf5W2iNCTEAIBtKtpv7ngYNN9+15gOYLMu/qKz6J4ZuKA4OcVxtvcLF8jxcEtuZ2d1X9wHcG+neeni53uplI0piW+R0g4qtpnA98PZPrWd5Ima6FaEToe8czw=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1674.namprd11.prod.outlook.com (2603:10b6:4:b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Fri, 14 Aug 2020 08:04:28 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3261.026; Fri, 14 Aug
 2020 08:04:28 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v6 06/15] iommu/vt-d: Support setting ioasid set to domain
Thread-Topic: [PATCH v6 06/15] iommu/vt-d: Support setting ioasid set to domain
Thread-Index: AQHWZKdLZpvd5TQUUESePx5zY7Axxak2PXYAgAEWcvA=
Date: Fri, 14 Aug 2020 08:04:28 +0000
Message-ID: <DM5PR11MB1435CD15D0C713E7D1B7E8F8C3400@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-7-git-send-email-yi.l.liu@intel.com>
 <ae43dda5-01aa-adb1-d21d-2525cf4f4d95@redhat.com>
In-Reply-To: <ae43dda5-01aa-adb1-d21d-2525cf4f4d95@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b1cb32d-998b-4f74-efa1-08d84028ab20
x-ms-traffictypediagnostic: DM5PR11MB1674:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1674DFA5E58E59E0E295A134C3400@DM5PR11MB1674.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gE6zJ5u84WP4ouQUfxfmlcUcEvOb8ZhUHhFTS/Xn7ocfCErYN/I/lpxgbi4bQtn9RsKdAHgwmOF1+1i6FzaZ8S2joTkEWtN8eQB6Yep2hW17AXoPERNDsZXQejtL+e55ZPtLm4hX52RqZ5sT6H6KYpRMFY7t1zl7It9mIMvDF6ga7u9rqsIrOR5h8Znr5uZr9UX3f1/qlV6g1+gEa4eDO5xfLWndUNYwf8kNHcFkqkLdZNYKO1YXUMrMqQQX257UQMr1MCTYfMIgw6GK2MWwOga5uNZZyCt3tV78zGV8iLNuyq+MEv74pbHVllmtkMHuGRWDsydey09GqAQbKX0dvya0BBniv8+MvaOrs4YGey8f0HTXNTiLrud+5MGZdolanQkQP4ZL8Q3yg2Y8GbK1zQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(66446008)(7696005)(6506007)(53546011)(76116006)(4326008)(186003)(8936002)(33656002)(26005)(83380400001)(52536014)(66946007)(5660300002)(8676002)(966005)(71200400001)(66476007)(7416002)(66556008)(9686003)(2906002)(110136005)(478600001)(316002)(64756008)(86362001)(54906003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: x0geWRlWubq65K0+d5pl30kacCHDuM1OK/BKgVsaOWJ1KbtQzDfeM9anfpEUnuvuV33CsgxVAndSiREuLG8gEAVSK5C5c7b9f2TyTeSDpW2zPXKqkUhnfG//UWEGRflAIO+BEZYGzVzQmdnryOq8szNwn+LrgdPvnS/7j41TIzKW5Alf6fzSb/iPR8f2ROEkh1WdWiDduArOJHP91h6z4H1dvLgGC60e7hJsXBq5yuXP5pFByKzXVdhkiMoKWGHNvHnC2dRH1BVKcgDqxFKfFzmTfjcD0Rlg/E+8VkXVyJ8+gLRGASKpXaLBqUM3fl9iC05GMUyaITIXy9JqQaXXqgPqAx7M24V/FUucOoeiK3qV0PiZ8Sdr5ljYjvo36BPRjIK8PIN/LelIN6iHnXwCZ/UongGbwunZexxQ97EKWvP4VgTOzi8mmsZnA9DucjyMzo7pqcqJ5ro6L7JKT3SN1CMeKiIpKgrH12Mq9EdgexgNVjuOUhEyhz14tEDV3gbjG8RtEyn5md3uSZqoGYEMNC3UbCOY+pfDy+HMj3dRZIeikSkDuzhq4rvUdEaXlF3Yry5ZATZKaNe0Mn77zQTC/cgJ5vOoBAMzk6wtNm8YN/NdFBO0wbLWPp/bLF8EsdJZtbMQlpKH8YHGuLzzUHQgtQ==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1cb32d-998b-4f74-efa1-08d84028ab20
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 08:04:28.5127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hMzGOQmhY0CI8Y8cpzZGu2mNhjgMLHaWX3i+Phxqeo6s2aIN/SGvM3LlKRrPAhaCOoe83D8N8UPr4bHOHuxAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1674
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
> Sent: Thursday, August 13, 2020 11:07 PM
> 
> Hi Yi,
> 
> On 7/28/20 8:27 AM, Liu Yi L wrote:
> > From IOMMU p.o.v., PASIDs allocated and managed by external components
> > (e.g. VFIO) will be passed in for gpasid_bind/unbind operation. IOMMU
> > needs some knowledge to check the PASID ownership, hence add an
> > interface for those components to tell the PASID owner.
> >
> > In latest kernel design, PASID ownership is managed by IOASID set
> > where the PASID is allocated from. This patch adds support for setting
> > ioasid set ID to the domains used for nesting/vSVA. Subsequent SVA
> > operations will check the PASID against its IOASID set for proper ownership.
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
> > v5 -> v6:
> > *) address comments against v5 from Eric Auger.
> >
> > v4 -> v5:
> > *) address comments from Eric Auger.
> > ---
> >  drivers/iommu/intel/iommu.c | 23 +++++++++++++++++++++++
> > include/linux/intel-iommu.h |  4 ++++
> >  include/linux/iommu.h       |  1 +
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index ed4b71c..b2fe54e 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -1793,6 +1793,7 @@ static struct dmar_domain *alloc_domain(int flags)
> >  	if (first_level_by_default())
> >  		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
> >  	domain->has_iotlb_device = false;
> > +	domain->ioasid_sid = INVALID_IOASID_SET;
> >  	INIT_LIST_HEAD(&domain->devices);
> >
> >  	return domain;
> > @@ -6040,6 +6041,28 @@ intel_iommu_domain_set_attr(struct iommu_domain
> *domain,
> >  		}
> >  		spin_unlock_irqrestore(&device_domain_lock, flags);
> >  		break;
> > +	case DOMAIN_ATTR_IOASID_SID:
> > +	{
> > +		int sid = *(int *)data;
> 
> > +
> > +		spin_lock_irqsave(&device_domain_lock, flags);
> > +		if (!(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE)) {
> > +			ret = -ENODEV;
> > +			spin_unlock_irqrestore(&device_domain_lock, flags);
> > +			break;
> > +		}
> > +		if (dmar_domain->ioasid_sid != INVALID_IOASID_SET &&
> > +		    dmar_domain->ioasid_sid != sid) {
> > +			pr_warn_ratelimited("multi ioasid_set (%d:%d) setting",
> > +					    dmar_domain->ioasid_sid, sid);
> > +			ret = -EBUSY;
> > +			spin_unlock_irqrestore(&device_domain_lock, flags);
> > +			break;
> > +		}
> > +		dmar_domain->ioasid_sid = sid;
> > +		spin_unlock_irqrestore(&device_domain_lock, flags);
> > +		break;
> nit: Adding a small helper
> int__set_ioasid_sid(struct dmar_domain *dmar_domain, int sid_id)
> 
> may simplify the lock handling

ok. will do.

> 
> > +	}
> >  	default:
> >  		ret = -EINVAL;
> >  		break;
> > diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> > index 3f23c26..0d0ab32 100644
> > --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -549,6 +549,10 @@ struct dmar_domain {
> >  					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
> >  	u64		max_addr;	/* maximum mapped address */
> >
> > +	int		ioasid_sid;	/*
> > +					 * the ioasid set which tracks all
> id of the ioasid set?

should be ioasid_set. however, ioasid_alloc_set() returns sid in Jacob's
series. but, I heard from Jacob, he will remove ioasid_sid, and return
ioasid_set. so I will modify it once his patch is sent out.

https://lore.kernel.org/linux-iommu/1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com/

> > +					 * PASIDs used by the domain.
> > +					 */
> >  	int		default_pasid;	/*
> >  					 * The default pasid used for non-SVM
> >  					 * traffic on mediated devices.
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > 4a02c9e..b1ff702 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -124,6 +124,7 @@ enum iommu_attr {
> >  	DOMAIN_ATTR_FSL_PAMUV1,
> >  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
> >  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> > +	DOMAIN_ATTR_IOASID_SID,
> >  	DOMAIN_ATTR_MAX,
> >  };
> >
> >
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

thanks :-)

Regards,
Yi Liu

> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
