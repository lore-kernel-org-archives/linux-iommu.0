Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C24C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 08:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4B48F40A17;
	Thu,  5 May 2022 08:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id smxzSlDpoHtu; Thu,  5 May 2022 08:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0D37040A8B;
	Thu,  5 May 2022 08:34:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC09FC0032;
	Thu,  5 May 2022 08:34:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C0BFC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 08:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58FB941913
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 08:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nxfrXeF8qdDd for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:34:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 620F04190B
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 08:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651739653; x=1683275653;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xnIw97ae+ekLUV6/r3AEtNVzUhnQxvfLvHAW3qq7n04=;
 b=nWs4DWWcRzKHkFgkJf9z0Iqu/j6liVGeYQFo6qflljGmvy6R6lYWKFuy
 BI0SeM328ajdrkXwQr60RUDI80h3XWhwj1vE7LXu/smUUoUUxy4tM8QQS
 oxC6cB0/8TkGaFTanORhrVOJ7yJjvvVIbt76zcgZcE7ZdL/tJbLQdSKwt
 BiXzgMijrN0iO/s2GqPlgwO1rUdc6MlNqJwZsjc0tlA0RTDuNBS6zzysS
 KN1lG1wxsYjjdyjssR4lNOr/C46Vjg47R9/Utl/CvYJzqdRpyOFr/mc+h
 jx+8zv+ONlH95U5siArxUVYBTXAn43xL2xmnsWHsIYNYcqV2zehTpvZzW w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="247950878"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="247950878"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 01:34:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; d="scan'208";a="563139867"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga007.jf.intel.com with ESMTP; 05 May 2022 01:34:12 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 01:34:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 01:34:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 01:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHN0pEHYq3XLiqOS858GcNSO5+HaVsrp0qerU0c6VuXCU+/hWzQqbPArGjw/ZKj6GKXH8SqFGhtpko+OhNh++omZA/9Fl54iIRfffowClkY4cg2gopQLusni3+wcmOpBLLfg+WanimuizIgFSaksCxs/GTQoOdwUn4i2FxETEDGp1CvCHActPuPi/bi7heEA+n7iIA1WpLfrMnXnzcb+Vr2DDF+KnByr1TyMipI1FdJiFZcvojvDUF7J67DxlM5I9CIqBagfi5aO+TrO/2JUt8318oGaOcUlFlMlTHue4NlJsEGhcLQxvpt7yBh1MQEWuCXwXxMHKgIn3f/iSmaR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdIS15fZ3mYNQV0bkdikYnNZFJQEhU2t/Lvqw3s9BN8=;
 b=gZxZNth9rsMA+s0YqoD3lgauG25tosOycRRF3+WfiF7/DGf+HX1N+vrvQEN0assvaqBnq3IiYSdx6DQ6uWshYonONnQhpsaKcM5DmYJ2vhSporm2DAwV2o24ONw2+IYWy5bcHw59NDPMKOVhFwH7tT8J1eRgH2oYjixWBR1F4dRr+k4Vd9osbSrmZeMCInlM/9vUsTUF+f/MAjnkXUhqc79Hwj7KxOAOlt3Nb73O0cZZgxdeqXW9xjFo8YxBQ1zjJczAnL5rEeujXSYybvC695RUaA2PoSL5BxCKyqA4nmzlxKZ47F2srgL4BBHCGQcDniPJB1J24zXayD5F69hw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6393.namprd11.prod.outlook.com (2603:10b6:208:3ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 08:34:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 08:34:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v2 1/4] iommu/vt-d: Block force-snoop domain attaching if
 no SC support
Thread-Topic: [PATCH v2 1/4] iommu/vt-d: Block force-snoop domain attaching if
 no SC support
Thread-Index: AQHYYBzn76sZ0hZmSEq4viShn9k5Cq0P9IMA
Date: Thu, 5 May 2022 08:34:09 +0000
Message-ID: <BN9PR11MB5276C9D35BF09F019264B19B8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
 <20220505010710.1477739-2-baolu.lu@linux.intel.com>
In-Reply-To: <20220505010710.1477739-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0ad5a7e-0931-4c3f-e58a-08da2e7206a9
x-ms-traffictypediagnostic: IA1PR11MB6393:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <IA1PR11MB639326649012CD155505965C8CC29@IA1PR11MB6393.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LQYoZ5l1isyah3sJR0FuXjSolWH051wf3BjIcVcFliEjIwThyFunpBN2YaXxICiCYizbUbCmnDjKhAm8iwYNy0snLB7ZsAaBsqFpsBYWxL6X1v6ERk1QR46MtERB8a3qS0ie/jLMOBpVM6Ac1Nbkp46kiOgrNX96coijCTbLzJRnZLRx404FqRfyGLU77Eu3jdtgGUXD7+7A+tg3shekPMA5dDTq+Re7ucQbmFHOiFzF81LfY77Wm4K6mCUGhAvdNZm4Kk8YP0qV5IYo2rmpkMd4c0ayyy1aYnkI9NyguxqjgBRlOWkPeTOJnhz8D4IhpvTGkU6MSEtYaCtJfAIPN0BmNCicNnUl8zWIvlKBvzPH8zMxR71xtwGrS4u7mSB1tSEn0M/3VB6g9XAZamQ7r+62RcZMQFBayz7aOAF6aCde8qFnOg+WpiwlCCMoM35PpgU/ZXMdej1Or9L7OtOWUD1kI+dJpQ7VYFm38NoxCHxWvkFTHHrrBrM/jQvmvHpxSUJsaEmBCE8jdZK9FZ8PzI/JBApsRFoXQSnkYECHPUrzJUer1ISrHcmCotEtPDYpfbUCfuah/dmIasZLYl03+GudF7o8DOMDtdhwmLEysHb79I0Mkz0cMI3vipKb96MegmM7pklDLz8RVNLa/w74rdysFu4LrBZouxmMCQGwSTN2j1royDGUPIiNm0Hp8oi5d+mSnIfm5/GgJRbfsF6oBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(38070700005)(9686003)(8936002)(52536014)(26005)(82960400001)(38100700002)(122000001)(2906002)(508600001)(5660300002)(110136005)(54906003)(6506007)(7696005)(316002)(83380400001)(71200400001)(66946007)(66556008)(76116006)(8676002)(66476007)(66446008)(64756008)(4326008)(55016003)(186003)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VCSh5IVmJae/BMiy42PY0yUUEjmRic+VnaVFO/sY8ov9+Ide4k005b5RFnOk?=
 =?us-ascii?Q?UYtiiuHtIS4BnNLx4e6fv6n3xJvbauZ2wU30n7fpOTYl8akLlG+9C6VHW3IU?=
 =?us-ascii?Q?MqM82557ZU1hpvcVw3DRLzlXopXDyVLayNv0OblvPk6uEFoXHyWFBjrpDrDd?=
 =?us-ascii?Q?E5iGu4nxdAGn6SdlKqnmz1UqrYQzJcDdkl5vn/5GOB8YL+po9LK+Ar++wqft?=
 =?us-ascii?Q?QIjv5QH/MxPAgrdS9+9WmLmotAPJkYiEOb0v7PURX8TpmzTTZNOW0gOM0yhf?=
 =?us-ascii?Q?SYsivBh04xhExs0+rReXYJS6prfbk8bxZV1JHaZPmqNTxWqowsk3DJBJbZSE?=
 =?us-ascii?Q?Gpxe4DdemOlrZ+kbqQvtWFdf6DJWxN+P/ILJ5loE0msxFaYocHA9SML0ZdGD?=
 =?us-ascii?Q?52C9B3Rcfs3NGRg9NT/8xhvFOnu7nVVxRdfoBxybA0C61E9AaTeYZpzLm6rp?=
 =?us-ascii?Q?SLpQoAMGSKndsjUFu3GY6mFo8d/rMW3TpN5upadikVfDgb/zO0AyRWrRkrEV?=
 =?us-ascii?Q?oXryvL1vvAXqN9GTi9F7/QMaupeQKHc2h9+pUeaWUwcxjMc6yQ/DnRwZ2yfm?=
 =?us-ascii?Q?+6Bjfs+jUFGjb/VQTawmHpmhgWPMBgKxP74FFTmMSSjJoCE6aT0gXKitzOFp?=
 =?us-ascii?Q?PqLm/Cg+8hakjFW8l9s4JWBqALefj9Xkpn802WeGxIqQZo8xy/XNLBdCV7oW?=
 =?us-ascii?Q?xoIYUJ6MTNa8jD2gWk2nK4qnyxxanf+yyqKOha9XfqQN1ursLOIXR1cfke8c?=
 =?us-ascii?Q?oTEmoqTP50MYK1AM7yLWv/1frY1MH8I1LYs0C3cTbn6UuwpDbyEKmgty8kQ3?=
 =?us-ascii?Q?mq5YWGp+q8ALxRSrpLX2+vbQWL7Wss2AJkwQAmtyAf8TyJCzDRdCGHs06H3k?=
 =?us-ascii?Q?s6Bz99TojRNSvNBgzkRfJ26Ks81I/ta7RGa2GZ9vlePrZok3mbotPciRGhHQ?=
 =?us-ascii?Q?irrJEYwZH8k+moJyKlEalArUJ5IH1VGf8VXE1p2ZueRZEMc6vPJ/UpJuouqc?=
 =?us-ascii?Q?Hi797EFuxQkZ+jYVeBA4vGTkeAv2FYrpSxKVYpV1l0GstXELnSHjgDqs/8uH?=
 =?us-ascii?Q?cYB8fX4gdGfIjn9cw2ppn3DRQWW6fceEuNrMAESlil1HFl6UYjRYKKOKHLsI?=
 =?us-ascii?Q?TNDy5sFrpb/fw5mmAqxe9GzbSzAMKF9Si1Xc3P8kmuSa4NdjYb10kdXHgZQT?=
 =?us-ascii?Q?G3Y1EglNrTp1B7v8nCySecC46y+VkZUUYqPFqZR79CDw/L+IKg8auzbi2w28?=
 =?us-ascii?Q?WwA/7MnfDqpNSy6vHmUn3qKCZ10ykQZ74qGBhLTY7zi1gX0cMoL904+gyAcN?=
 =?us-ascii?Q?CjqRiMmBOPZZTZaFbhrCXnaRNTirs8I9UTxDZvJZ0QyUW1HwDSCtqUiDj+39?=
 =?us-ascii?Q?QLLcoGZb5GQ8WSSoVFqGc+KzmCUZW5V7OiAbsZiR+aXyUqDN5JwRxXbQZ83C?=
 =?us-ascii?Q?Bb9ACtx65YyXnwAeXVgK/WHk59H4lh7YyjZMXf7HKGRdk6c1/3n4JZSiAN38?=
 =?us-ascii?Q?0m//0dHdkV+KHM0ImnRjtl6gr9m5HYPCoV88we62fUpu+XR9z7umoUJxQZSf?=
 =?us-ascii?Q?yhlrXuPI7zXf1Nj702eKMRzjPY5tyqPqO9XAJQT4AFG7XWmD/cASb+FzCYyJ?=
 =?us-ascii?Q?IfWaz+gMDQsOHKfSxuWud2lqSX5IVtwAf0tsz9YQL1bKgGR+VXVohOt9mdw7?=
 =?us-ascii?Q?0iqHklC2u51oy2qECgCEfNUtjVfZoCEWy07qoFWKIyX7ZrnE7+617y4x+80n?=
 =?us-ascii?Q?cpmkGfZnBw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ad5a7e-0931-4c3f-e58a-08da2e7206a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 08:34:09.8981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q34Iw/rQ9k2KJwWsFYwJIKf3iN7a8hR8NAsIfeHBBgml5ipDN3yyBllKOuVwbu9Qhtdeoe+dKLK6kV8Zu/jxSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6393
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
> In the attach_dev callback of the default domain ops, if the domain has
> been set force_snooping, but the iommu hardware of the device does not
> support SC(Snoop Control) capability, the callback should block it and
> return a corresponding error code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> ---
>  drivers/iommu/intel/iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cf43e8f9091b..d68f5bbf3e93 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4354,6 +4354,9 @@ static int prepare_domain_attach_device(struct
> iommu_domain *domain,
>  	if (!iommu)
>  		return -ENODEV;
> 
> +	if (dmar_domain->force_snooping && !ecap_sc_support(iommu-
> >ecap))
> +		return -EOPNOTSUPP;
> +
>  	/* check if this iommu agaw is sufficient for max mapped address */
>  	addr_width = agaw_to_width(iommu->agaw);
>  	if (addr_width > cap_mgaw(iommu->cap))
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
