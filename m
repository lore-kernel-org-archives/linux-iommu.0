Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF8BC433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 08:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFCBD60E76;
	Thu,  5 May 2022 08:43:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XIHP4pGDN4rv; Thu,  5 May 2022 08:43:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 856FC60E40;
	Thu,  5 May 2022 08:43:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D646C0032;
	Thu,  5 May 2022 08:43:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A04DC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 08:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A8F240480
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 08:43:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HKe5UvGd9W6k for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:43:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F9BD4016B
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 08:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651740223; x=1683276223;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SUc2K6comdlnqrnKwcvWNUqsJz6XJNkXDu/OllKP8Uc=;
 b=XOERPfai3kTyd3gSxSkxmMJ54tnTMPRBcZu8a1kw5FpV2YkShfjZYU2M
 0e2uPaOHScf3omWYBbbPiIECqj0npO9VGAQkw0AT6n14TIEbxBu9FKnuJ
 syMy2wktCCd/0071C+K6vKbFd6GwErpZv86PZ7s5iaA0AYUGQsKrrSZii
 mq33MBbEFXqCRcNyJILbRVWvRHTY0Mnu3cpEQigfSSyLrYvqJMx3hfCFh
 m3X+lfyFpMKxiFkFZ0y7Dol7KkRXAaW3VkbaxROhr6LjebZdhlVn0VXtL
 adhTyitVRroLeOyiFyrLCeeNQZouKG+gSCssZD6H66c1pswdSDf7xFhYL g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267930085"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="267930085"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 01:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="517422892"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga003.jf.intel.com with ESMTP; 05 May 2022 01:43:42 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 01:43:41 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 01:43:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 01:43:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 01:43:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPi/2I1PhBmK9Dk27VKY6eCk3K28oPJ5/IgUzN5bkZetTlbq3tf9JBtO+GkRxJjA2QwhuqpIwRRKOBKZX3kj6ECT9wOWv4RYYEb4lTlHGXHR0ueA4i6MW30S9uBwFUCpnyWxNKiR01emxJ4v8EAATqkiQ3rqySzKIcYH/3VcibyM/rwz9s4jFp1gsfUod/WXI1/UhwXIWJO3LFF2DES794QW3vozYKGS9mWYs73Wcy1gspOdy1cuGkrUYFyyHrvSGW7J8V8eauQ416U4tHaqjYMhvt4JXPRerWyEUcYSr/ZTjVsmTMmATel0Hme7InbSrFfSF1U9kh0zyZXT+jwuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYefwLX9f7oWwcdeIp/GLxp6FWE0Thz3wlEigzaLV6s=;
 b=P6UeQcPTHxrFcPcLx9hKu5ujkhkHliieSNH/xygxQ9kOnTteyeLO5T1w7aE2IVi12cFZPgnytac8sGmKgzeIg+XMumlpWm7IuIR2vaHu6kcxZZE7J/MJT5ZvATR3lh3NXD7aQBBpyqhMVpEdUlM/Bi8phUwofNbJNMt2EDOYZQl32uU/ganOjN6Gh13CuqsSism1GDf+jiXCdIKf8L0CFu63tdv6y0VejaG8AmoPykbez2gGPlIPDWvUVW2mnezxtwyH2xJO5ABd3ZthXyYCvh9uZ49W4nl2qrGJxyUq/AFb5s8JagiBPrzWoGRtKSg3trKNEb58ZmrULXPYBNM16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM5PR11MB1561.namprd11.prod.outlook.com (2603:10b6:4:a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 08:43:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 08:43:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v2 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Thread-Topic: [PATCH v2 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Thread-Index: AQHYYBzuZSlvkCOXq02FfaKKbfyMgK0P9qKQ
Date: Thu, 5 May 2022 08:43:39 +0000
Message-ID: <BN9PR11MB5276F768185B4CB64C2D027E8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
 <20220505010710.1477739-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220505010710.1477739-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d69200bc-516d-4b78-fb76-08da2e735a44
x-ms-traffictypediagnostic: DM5PR11MB1561:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB1561A3527F4ECD26333BD29F8CC29@DM5PR11MB1561.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ufh7gzMsJqOwq++W/yVlIduBcMokn04XZ0PamfwktjaRD+d3zElppJvvqN2HGISMBf2QQShbVw4wX0YDHlfshF0jmoD0UzgptdZZqH6AZWPHKCSD4iBXUqMNDoFGg0T/5BnJYaSFYFsdlTvvXC5+ABLAwPCXo3CBd1C6BZiKSeQZTM5l9V66nk3D6LFkAqnyBe0R5PbE+PyiC1eG7nho1dxg0p6uqYI+9aF0Poyf4Z+NDhDYFCnsblB4KUhI4e9FzzqF3EzDBxDlqss6IOrBeoYK09vx/TMhtaV0OAf+0gaL8yV2AlrD11cAdCjN8MP0xHmpe0qsylijW7Kl7uwmhKGdzD/87QKhahsxOAstOJJ0lpqeXstWYL0S2MF9hPkFLaVLWwGqQ1+dbImbw3r18yWd42pf9DAuZKA9bjlAQBWsS0R1fAZpllDP/MAkt4QxukegojKMEX1DCbGQEfzh/wog6rfDEOfppEh6kDGj5K2pINKo3/exhyAD/Y93XIJWolxLfa0Yb+O1Ff7B3Oh8vAAwFbFArdr7dhltHnuL8w0GKPZp1XGr1U8iODG8rJdAPaHrTfZ725+46GdS20OYY+SUHVffrga7YOGm15JNK4kz950SHxgICzonVpytYQhvg63Fm3T49AIldb1ESscldhD51mD7L9PZ6HO6GsoUxoKMNOIyVGcn0yA5Mtn2wbXvuCD7oGO8cQKqdUXcOpFa3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2906002)(33656002)(83380400001)(316002)(64756008)(66446008)(5660300002)(66476007)(66946007)(4326008)(76116006)(8676002)(71200400001)(66556008)(110136005)(508600001)(54906003)(8936002)(52536014)(186003)(6506007)(7696005)(26005)(9686003)(38070700005)(86362001)(38100700002)(55016003)(82960400001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dLflfZH8Vc9EYWAd2K75npHIPLRdx5DHHAvah1AGk/4iMrG4ADAMtDEHolfu?=
 =?us-ascii?Q?RfaNFlPkhnkNUF5T6c38JKPPQydloJUbQVEgKpaZVzNUzmU61PY0bQDf3A1Z?=
 =?us-ascii?Q?ak/dtn280VVGqPIimJ7/ZakogVC5373JkVyVQWnOEmpqy92BcGkQYpz4yIa5?=
 =?us-ascii?Q?Yq6lpIcc8HWkRbYkSH8Wkiqqo3OH1R7WbOEwm43TdLcpYklp4a3sA3FmvkTc?=
 =?us-ascii?Q?SLQPLD2q5uVqVw2qOY8idFOnH6oGWckAxg537Vj68jgAbi3VkXcYLw3sGu9q?=
 =?us-ascii?Q?H9qmnpQybPM+IVmIFIa+CXFlLLFJYDFNoIwBHVj7HzIjsoUVgRY0zpWmDyCk?=
 =?us-ascii?Q?3Fr6SCIOhvQDEX/HyA+iLGuYFoSfkV75lZt21LpyPfY94AVBBF6VUBGS0Jls?=
 =?us-ascii?Q?tmB7gdcI3nDcldlLl4V+wl4wPgPHCMnpWq0kXOoi2RBUtIHG0/KCW4DHqdEz?=
 =?us-ascii?Q?IBI4QsYxWdHUuIEOdHxoI0sjxucdzpdtwY/jG3OInB/QFHghvwNd2W08mH8O?=
 =?us-ascii?Q?NrvKFxmBL/Y/Lsg1eFhjY3xOnjkJ7KnqikUyIEgOHb45cWK7IbZWAnzeEWYx?=
 =?us-ascii?Q?yY2ltfMhv2rjsNE2IAYz+NYy4j9P3R+HCx6zQtc7gPshGUeDM9EazqvZhKSJ?=
 =?us-ascii?Q?0U2QZpqxP/6h78ljDz7g34FQHeUOoJmtFXoz0Lo0bOufAlc7wW/DbL0vn4sS?=
 =?us-ascii?Q?QdVhxgA9E7OMW8SseZUyz47Wfjbard6fp1yiN6OC1QNJuYLmGWS3HoMzFC1f?=
 =?us-ascii?Q?CO/Uo78C0pA2yeSV+zGRBAiChTzyARQOV26lCmbXe8ntC3VT3BJxw6D9Tn23?=
 =?us-ascii?Q?xtyiQtDsXsBvX6lbRuMxE0gC4DN3gEii9VaOZuKZmuTshYTMkyCfyxCu2gcL?=
 =?us-ascii?Q?/MrVHMUAcHZae6RdBoGZpuEn62EFV+N1sZq93t6iG63tBzUakabEGjtsON3l?=
 =?us-ascii?Q?k3dhMuHUDiW2Jxo2VURb6QfdpZ9q4qtSgEDHPceW7QKvEd8TISiy7bSR93iM?=
 =?us-ascii?Q?eSDfLzOz9KTvtcH7efbA6q3rwovPo1a6IBZHxzLAiRlAP50AAb0nT54Z4OJ+?=
 =?us-ascii?Q?jhOGtXTHz6nTm5Yi7g+84rrBOQgwmCHV5HQ5JkJe5DuOrtemgVwswp/0xUEw?=
 =?us-ascii?Q?TaNSN4wSrz8P1uE8qvg4g3w6llAAwUyP09+2d4Dl+DqZEionirvvvmAad0sK?=
 =?us-ascii?Q?9s94K3MPVxP8RYtxAs9L12jSE8f3tYV2Cbm8ioMwc4XkF/y5V51ym30qu38H?=
 =?us-ascii?Q?sWN4ikylRW7x7pZbZ/0aebsxsnyOaPQFv7kovXjMc3EpJrbQSW2o4mvNSVwV?=
 =?us-ascii?Q?s8zlcmDMJqNtc8uOKp2rREnBCFvBduNGdKlzUjV/tYi0v2osdo/JHPnOb9bg?=
 =?us-ascii?Q?iic3KwPWwnhxUty7g/Zz6dqmLBFSVA4Rztx0HvV5pJpXKtbCrT/uJRZeq42Q?=
 =?us-ascii?Q?CGfxtQHI4V5EvUG96/XBKI+HBIuIJcU0lq6jnfbA8DzciKxrQkMAxl4flCSr?=
 =?us-ascii?Q?dF18lzOHYxsSOkvOFjUzboemEcnwI1ulBBuZLJDTAzoZ5Tz8NNrgR+e1D9qw?=
 =?us-ascii?Q?UUOEn0AcNLroehVmMpkZd/lERcDL1/NhAu7nGaDm8I1hvPFdcU1O1eE+HXX1?=
 =?us-ascii?Q?Rb60hUOM2Bjj5Ie00mIX/ejD/wXLzodRuff0d6VFeIbHqXLi8NkKH3VgecPH?=
 =?us-ascii?Q?jyKiK/TVVHyWKXi1+XZhvghSEGYjXXaUu59GbC3WqwSyfyqkoZZQJ6IO0ngE?=
 =?us-ascii?Q?onRllgCSKg=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69200bc-516d-4b78-fb76-08da2e735a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 08:43:39.6621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zs1048R4LN4RxkG6gDK809TJI/xPkDdggla9f5YzrSfmb+/0l1YxfegO2WRM1fEcFYpADAOznt71fB/2WJuZHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1561
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 5, 2022 9:07 AM
> 
> As domain->force_snooping only impacts the devices attached with the
> domain, there's no need to check against all IOMMU units. At the same
> time, for a brand new domain (hasn't been attached to any device), the
> force_snooping field could be set, but the attach_dev callback will
> return failure if it wants to attach to a device which IOMMU has no
> snoop control capability.

The description about brand new domain is not very clear. I think the
point here is that force_snooping could be set on a domain no matter
whether it has been attached or not and once set it is an immutable
flag. If no device attached the operation always succeeds then this
empty domain can be only attached to a device of which the IOMMU
supports snoop control.

>  static bool intel_iommu_enforce_cache_coherency(struct iommu_domain
> *domain)
>  {
>  	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> 
> -	if (!domain_update_iommu_snooping(NULL))
> +	if (dmar_domain->force_snooping)
> +		return true;
> +
> +	if (!domain_support_force_snooping(dmar_domain))
>  		return false;
> +

Who guarantees that domain->devices won't change between
above condition check and following set operation?

> +	domain_set_force_snooping(dmar_domain);
>  	dmar_domain->force_snooping = true;
> +
>  	return true;
>  }
> 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
