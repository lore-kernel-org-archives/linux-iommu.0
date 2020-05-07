Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2FDC47247
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 05:46:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABB920753
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 05:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ih4M75ZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABB920753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AA64120503;
	Thu,  7 May 2020 05:46:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mfLMVvCwSllh; Thu,  7 May 2020 05:46:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3DFA62051B;
	Thu,  7 May 2020 05:46:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1625AC0865;
	Thu,  7 May 2020 05:46:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B8F7C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 05:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0F10087F08
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 05:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CbCue78vsEOl for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 05:46:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 076598763C
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 05:46:00 +0000 (UTC)
IronPort-SDR: 1I0WR6st5K6IqhgCJT3slSJTT+7BGBpXhcVgGQugOAhWEAaubRmWgSmaXd9KfVJLGLzuBAD3hE
 yKQsWCYFh5EA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2020 22:46:00 -0700
IronPort-SDR: L7z7w0jeTxaZMcrzyhxGv/L7qAizwiFF2UZKQ5MqI4l9ehus4DhCEMH3OSyGWTn3LGPbRmmfQS
 wxPxmXHD9Ykw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; d="scan'208";a="251422934"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga008.fm.intel.com with ESMTP; 06 May 2020 22:46:00 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 22:46:00 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 22:46:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 6 May 2020 22:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XimBa4BNxQgEOYhD7hI4c7DjJh3Qyl7hF7G2KJZ465Epsazjl3vn3Hd+3+o1HWMss61Fpz0NF19aPDcMkjkb1aOW+CBS3bf2FAaTfiA+IMOkfOGOaWNJ/B0Wq01vMpXrdBXwpsV904ZtKkfUcFVcyGNehtijhV3Mml5OjgmQkXAR37A6OLjx+/rMpPql2AjFOI75hpSt+MK5nIg6MMNx91NLZ7F6oISBT3S5jS0fcWP1YrP4ZwCEInyiSx7hYTRto/00yx6EpI/NTX5Vdc6Vtbc2BoYrwHCi9/gZWABkabIPMLNZTc/QQiIUNtDXjHUXLcx48lTnymmPhEWs/Mf3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spuK+oBlTNGAKyf+OWTivBMpQyBO0VDs5rmXoVH1kmo=;
 b=eRG8o0LrSThuc5FLzIoJ9ThK0nDHOKG//ampQy6DTCrH59BA83fOo6dMFtPQc9UvHCkhdQwmTzP+bS4A75U/Zq1qTM3sZcU/o8UY6ZK7oTSHd45vs87+P71uPAioB0vSXFsyfdD6CHSVtLSrUk6/33EiehW1Ca2F1LYd9TJzXVuVQRLLzG/CPaOgxzQyvI7wAgVXd+I+OF+Rwd5nfD9tJz4lRZ2qMneZQ8BmzF31NtJU7ShBWWjCeZ9wNgczXV/cQKWhvhhvUgvKqstTU2Kf18YxI0p4n4HCddOWCcmdcpOFwfYyBguvzJcolgGpq4KFw6Ufb1YieAOIebxdLSbGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spuK+oBlTNGAKyf+OWTivBMpQyBO0VDs5rmXoVH1kmo=;
 b=ih4M75ZX5rRk3207vYy2V/wZkNw5s0kJuq1+/x8o7/SWiFByJ/eyjAxeVzMGLm/Tg5vx2DIeZWPiP6hyYG80LlDP1e/RK5HBjZI4oyvCHdinC3CHDEu1vysvF7+lf/yUYVx3WkbylswynRU1z+FXkIePIxeFGJjCS+wevaK4ep8=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (10.172.53.140) by
 MWHPR11MB1872.namprd11.prod.outlook.com (10.175.54.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27; Thu, 7 May 2020 05:45:57 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be%9]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 05:45:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v4 3/5] iommu/vt-d: Disable non-recoverable fault
 processing before unbind
Thread-Topic: [PATCH v4 3/5] iommu/vt-d: Disable non-recoverable fault
 processing before unbind
Thread-Index: AQHWJArS9bHSXYAkjk+yfEGapC3IHKicG8bg
Date: Thu, 7 May 2020 05:45:57 +0000
Message-ID: <MWHPR11MB1645CE4337BEDBC4598318A88CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-4-baolu.lu@linux.intel.com>
In-Reply-To: <20200507005534.3080-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ebcae53-1b4e-43b0-1439-08d7f249ea50
x-ms-traffictypediagnostic: MWHPR11MB1872:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB18721921CA7B0346904A13E88CA50@MWHPR11MB1872.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+Wvg7y32lK3t6IOrqtBwX1NhCqwUEaICYQ7uTY7Ddk7+10wT72fX+Af5ikcJBvZDBNJmFnQCpW5M2D+J+oGkhuPt/0cEQ9bN3GOBTt7taOqCwWcLnpol5ThuxN9KuOouZvYceqkfW7ZbspMTVUf8yurL0UvwbbEicHY/Si4pNBM6ytoxxvDgyNtEBG+MSQcNv+TKgdxhMBYjlUgW5dHX7OlCMsllDTvbxIFo0yK/nNArRHBr43NSNidoXr5CefEGl9xc1ZIzUx2G30aNImdSm2jG/NXKcT3c3xBYE/lkWjhkj3AvF1cyEQ2elNCXxWSijeJyAvHsN5yIHmzLRSe5/avTXtnx6YN5ER6H6f5temR03xvazHodsHHUDklA6ZegtUyOgYva+vFzPy5mnmZ1y7d3oKJg8+G47Iynmi5Nl0MSd8RTTdIZwIo1xmA7kAHMymGUPKsSzqpK5DJOMAxoBHfL5g40y26xeC5ytFQ6WQRJbBjdT6alPyPlTwecSLJNywOqzI4XDx9ygyIJWZWgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(376002)(346002)(366004)(39860400002)(33430700001)(8936002)(7696005)(83280400001)(83300400001)(83310400001)(83290400001)(186003)(26005)(83320400001)(86362001)(8676002)(478600001)(4326008)(52536014)(5660300002)(66556008)(66446008)(64756008)(71200400001)(6506007)(66946007)(9686003)(2906002)(110136005)(54906003)(33440700001)(33656002)(316002)(66476007)(55016002)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: tHfDLzZNT5JcE4aqGPtCKCpDElYXfUAGWz7rDi6yJoaxKOv91IWbC6BW/fTp92V18LobeKfB5fF6nle8zmDmRHY6xN/qwS7VDjqKmQpJBns0XlmCJjK+LyIS0tjBoTGuo+Yk06wVpdMTZ6yTB7uB6P/L+eSsoD+ImBVcS6muxs/yfAPr+OQVeIUgsXHQ5hwzpPBkMmISwnnDzV/Qu6WXggGe9monLcyKdR09tKAZAy1kIFfJY6C/9agUag1EvG63SHLqvnI+TC8HS+xYpLeuUGTOp1Oyt6UEdTkTUldzK2bxiCkK5ZvX8BCjb0Xcy6A0LauEYBHpb39xK+cYKiUokJNFepYFhAT/bYuTbYQ3JhgtjvLva/vRoew8jOOw5mYkKv/XIoQjFl2bKaJq24irYfmWkfwyUR+Lt+f/Wn/XfNO7mfd/V8gCS2QpKEv2eoJegwnY/a3PjMI+ocGtVL8zSO1Kn1kLnAnsr9/RS6yiNK08EbnHfh3bYYxSnznErO3JOri6Wk155mMAQDkC1zCwS57SXpwyAfMaD2kZfpxKfaKEj9SFNo5pp8lpmPMjCupltdgRnI4KvyKoygLteMA+EN22Fl5//qAe/fTnl2IunkrWlbm+4k3aKUbU09bwvDMbDWaS9Gi8c8fzpIHTetezoJTEi6jriHjfIfF81wIhgdcDCbEypRUAJrV0469B8FUlGvEVf7L7EUHD3ISPHCoYo9bJzBPB918yHwXPqyuvjHhabNnQNXEO8oRk1rJWPr3gKn13frRUEeOK/a4cUkpBwfyCnZKt7TTRscQIHVJ1AZI=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebcae53-1b4e-43b0-1439-08d7f249ea50
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 05:45:57.3145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucFbUriyqtq29Hb1QbM9QxyBM4UQt2nhm9AXuqgzQyb01A9+kg9J25yEIKvu3oODup8xI3Aza4LIhc9o/nesDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1872
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Raj,
 Ashok" <ashok.raj@intel.com>,
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
> Sent: Thursday, May 7, 2020 8:56 AM
> 
> When a PASID is used for SVA by the device, it's possible that the PASID
> entry is cleared before the device flushes all ongoing DMA requests. The
> IOMMU should ignore the non-recoverable faults caused by these requests.
> Intel VT-d provides such function through the FPD bit of the PASID entry.
> This sets FPD bit when PASID entry is cleared in the mm notifier and
> clear it when the pasid is unbound.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c |  4 ++--
>  drivers/iommu/intel-pasid.c | 26 +++++++++++++++++++++-----
>  drivers/iommu/intel-pasid.h |  3 ++-
>  drivers/iommu/intel-svm.c   |  9 ++++++---
>  4 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d1866c0905b1..7811422b5a68 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5352,7 +5352,7 @@ static void __dmar_remove_one_dev_info(struct
> device_domain_info *info)
>  	if (info->dev) {
>  		if (dev_is_pci(info->dev) && sm_supported(iommu))
>  			intel_pasid_tear_down_entry(iommu, info->dev,
> -					PASID_RID2PASID);
> +					PASID_RID2PASID, false);
> 
>  		iommu_disable_dev_iotlb(info);
>  		domain_context_clear(iommu, info->dev);
> @@ -5587,7 +5587,7 @@ static void aux_domain_remove_dev(struct
> dmar_domain *domain,
>  	auxiliary_unlink_device(domain, dev);
> 
>  	spin_lock(&iommu->lock);
> -	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid);
> +	intel_pasid_tear_down_entry(iommu, dev, domain->default_pasid,
> false);
>  	domain_detach_iommu(domain, iommu);
>  	spin_unlock(&iommu->lock);
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 7969e3dac2ad..11aef6c12972 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -292,7 +292,20 @@ static inline void pasid_clear_entry(struct
> pasid_entry *pe)
>  	WRITE_ONCE(pe->val[7], 0);
>  }
> 
> -static void intel_pasid_clear_entry(struct device *dev, int pasid)
> +static inline void pasid_clear_entry_with_fpd(struct pasid_entry *pe)
> +{
> +	WRITE_ONCE(pe->val[0], PASID_PTE_FPD);
> +	WRITE_ONCE(pe->val[1], 0);
> +	WRITE_ONCE(pe->val[2], 0);
> +	WRITE_ONCE(pe->val[3], 0);
> +	WRITE_ONCE(pe->val[4], 0);
> +	WRITE_ONCE(pe->val[5], 0);
> +	WRITE_ONCE(pe->val[6], 0);
> +	WRITE_ONCE(pe->val[7], 0);
> +}
> +
> +static void
> +intel_pasid_clear_entry(struct device *dev, int pasid, bool pf_ignore)

Hi, Baolu,

Just curious whether it makes sense to always set FPD here. Yes, SVA is
one known example that non-recoverable fault associated with a PASID
entry might be caused after the entry is cleared and those are considered
benign.  But even in a general context (w/o SVA) why do we care about 
such faults after a PASID entry is torn down?

Thanks
Kevin

>  {
>  	struct pasid_entry *pe;
> 
> @@ -300,7 +313,10 @@ static void intel_pasid_clear_entry(struct device
> *dev, int pasid)
>  	if (WARN_ON(!pe))
>  		return;
> 
> -	pasid_clear_entry(pe);
> +	if (pf_ignore)
> +		pasid_clear_entry_with_fpd(pe);
> +	else
> +		pasid_clear_entry(pe);
>  }
> 
>  static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
> @@ -533,8 +549,8 @@ devtlb_invalidation_with_pasid(struct intel_iommu
> *iommu,
>  	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
>  }
> 
> -void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> -				 struct device *dev, int pasid)
> +void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct
> device *dev,
> +				 int pasid, bool pf_ignore)
>  {
>  	struct pasid_entry *pte;
>  	u16 did;
> @@ -544,7 +560,7 @@ void intel_pasid_tear_down_entry(struct
> intel_iommu *iommu,
>  		return;
> 
>  	did = pasid_get_domain_id(pte);
> -	intel_pasid_clear_entry(dev, pasid);
> +	intel_pasid_clear_entry(dev, pasid, pf_ignore);
> 
>  	if (!ecap_coherent(iommu->ecap))
>  		clflush_cache_range(pte, sizeof(*pte));
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index a41b09b3ffde..e6dd95ffe381 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -15,6 +15,7 @@
>  #define PASID_MAX			0x100000
>  #define PASID_PTE_MASK			0x3F
>  #define PASID_PTE_PRESENT		1
> +#define PASID_PTE_FPD			2
>  #define PDE_PFN_MASK			PAGE_MASK
>  #define PASID_PDE_SHIFT			6
>  #define MAX_NR_PASID_BITS		20
> @@ -120,7 +121,7 @@ int intel_pasid_setup_nested(struct intel_iommu
> *iommu,
>  			     struct iommu_gpasid_bind_data_vtd *pasid_data,
>  			     struct dmar_domain *domain, int addr_width);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> -				 struct device *dev, int pasid);
> +				 struct device *dev, int pasid, bool pf_ignore);
>  int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
>  void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
>  #endif /* __INTEL_PASID_H */
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 83dc4319f661..9561ba59a170 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -207,7 +207,8 @@ static void intel_mm_release(struct mmu_notifier
> *mn, struct mm_struct *mm)
>  	 */
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> -		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm-
> >pasid);
> +		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
> +					    svm->pasid, true);
>  		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>  	}
>  	rcu_read_unlock();
> @@ -400,7 +401,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int
> pasid)
>  		sdev->users--;
>  		if (!sdev->users) {
>  			list_del_rcu(&sdev->list);
> -			intel_pasid_tear_down_entry(iommu, dev, svm-
> >pasid);
> +			intel_pasid_tear_down_entry(iommu, dev,
> +						    svm->pasid, false);
>  			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>  			/* TODO: Drain in flight PRQ for the PASID since it
>  			 * may get reused soon, we don't want to
> @@ -643,7 +645,8 @@ int intel_svm_unbind_mm(struct device *dev, int
> pasid)
>  			 * to use. We have a *shared* PASID table, because
> it's
>  			 * large and has to be physically contiguous. So it's
>  			 * hard to be as defensive as we might like. */
> -			intel_pasid_tear_down_entry(iommu, dev, svm-
> >pasid);
> +			intel_pasid_tear_down_entry(iommu, dev,
> +						    svm->pasid, false);
>  			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>  			kfree_rcu(sdev, rcu);
> 
> --
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
