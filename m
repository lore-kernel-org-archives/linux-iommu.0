Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7592C433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 06:19:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8979C20759
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 06:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="DoFjdvYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8979C20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 45220878A5;
	Tue, 30 Jun 2020 06:19:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qXcIXmg05qgT; Tue, 30 Jun 2020 06:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 92437876D5;
	Tue, 30 Jun 2020 06:19:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83E3AC0865;
	Tue, 30 Jun 2020 06:19:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1303C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 06:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9ACD3878A5
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 06:19:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6xHG513PHA8 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 06:19:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 65370876D5
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 06:19:20 +0000 (UTC)
IronPort-SDR: I64JetkaBlqw88Jv8YbIfLtFtprLzyaqP+1sWHdpLBHNtViWd3+DmDMyFU8ZM7nqMMq6m0dkb1
 k1zo3ElYTlog==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="211221317"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="211221317"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 23:19:19 -0700
IronPort-SDR: CT19O4v1OL7Iblc6mBTE/llx+WDf06v7LUIj/kfAYdP7YvS7rRQQ7A+u1UxvlEyZSOhepqEpA+
 lMrsCjeCwvNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="321296709"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
 by orsmga007.jf.intel.com with ESMTP; 29 Jun 2020 23:19:19 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 23:19:19 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 29 Jun 2020 23:19:18 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 29 Jun 2020 23:19:18 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.58) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 29 Jun 2020 23:19:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo0GUM0eAg1c8tHrsNe6b6jH2PYSj/mod1Q1micr2UKHSKvAQg9cROpscNRcxSScRrEKkm9i7Kmo2QpVfHfXhQt/Mk+J6kpK9wbUe04xlLRKDNLVD2qKK85WrUlB2ti4Ap9aZ7fzzMuuey8Djd602JGv0yhQLeI5m3z2Q2AAGCZS+RIUnVVOBG2x/hk2epSvYNdat+6fSJ/jEVO7zRqWATVD++eHlxEjZzUG/i2hWuYH+iFf0oY4gvUKRyZv37MutUvu/xUUB1OKTuSXja3PdBP9gE1v6jpTkE7GBXwKIwr+xJqqi/019wQyKrJ6Fxm2eODd0JUrRNkM7zw4Bu0sPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPzkxpZvpkmcxQqaY8si4eDaz2UV32JluTs2xxrC//M=;
 b=GtfFDcbI8e5h6bJb6EiXnCMXUKqW1duG/+Qb1aO21YjWbOE55B7MH28FgPEzWblX0kk1WHp6tXyS4Ks4shKq8mEjw8YHboUx9Tasw29qikGVeHrS9clUm0sPzY9DWvSq52MVYqlICmMSY4UugOmXidcoqE8gayfQxibTwR8TQPocRjQYMqW5TTGx5xw/Ispu0BJx75STNr4ajLPm/PxQkc0fknqO7GPY3uQP39CDZDYdfQx78h+Qq1fOr+X6JlfMBwrs9tmFvevEkxRGR9YWGOpIJJAhGmuFvIfE6zPI8c47pAmv9dCNlmlVduu7R5w2Eee8UiF/NW15bq3wxE21og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPzkxpZvpkmcxQqaY8si4eDaz2UV32JluTs2xxrC//M=;
 b=DoFjdvYP8jUAiZjEswMdMOo0bROBJHOyhCzdpK5S5hO0NA3gDSsbzb5e+Ey+HM/6G53CmhVhMlZhu9Pxwl4NychLumfaBbw2UeeypgBXkSh4o9ZHU+xplmguhYEF5lGKhVYlPysuOroVztwbwWaraTgdRLmL1kQJmL7l5qPTBq4=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB0063.namprd11.prod.outlook.com (2603:10b6:301:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Tue, 30 Jun
 2020 06:19:16 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 06:19:16 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 4/4] iommu/vt-d: Add page response ops support
Thread-Topic: [PATCH 4/4] iommu/vt-d: Add page response ops support
Thread-Index: AQHWTORpzKVpnGuNLU6RQJAsChsNEKjwsO+A
Date: Tue, 30 Jun 2020 06:19:16 +0000
Message-ID: <MWHPR11MB1645B92B81D6A1F7EDAC24848C6F0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200628003332.5720-1-baolu.lu@linux.intel.com>
 <20200628003332.5720-5-baolu.lu@linux.intel.com>
In-Reply-To: <20200628003332.5720-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b0cd7fc-8c52-4ffa-1224-08d81cbd8426
x-ms-traffictypediagnostic: MWHPR11MB0063:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB0063D9651F2FC9B143701FC98C6F0@MWHPR11MB0063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nuqKF5WOqABcTolvtMfaH5/SoTCpHWYBGNvIpUIpFxXv4xXOo8vwQWB3l8yix4zVVVeF3yeg/nuRMQ9CEjxuISwJlYVA/h118Ea7j4LLBEqoBwirOfqdEYSUK6dvL3iJ3HoimFM3RkpRT4m64osfX2RnIWpljZQrwf5j4/8aPpEHYJQVim5VwWEJCxFNj60mRuAyBBrsV3kwXXflPJLqsieS3bnM0DxwKH5J+BUVmyaYGK3qu8TJqaTL5ZOY3ss0K9n6braPdQiwxBvsJ6lBZhyHpkAbgTN6zQJjPxC2B8XS9HIiGWCqwQIj/oyKAuaiRSGxeZyPbSEAgMC0lanuNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(186003)(86362001)(8676002)(6506007)(66556008)(26005)(76116006)(2906002)(66446008)(64756008)(66476007)(83380400001)(9686003)(66946007)(7696005)(55016002)(8936002)(478600001)(110136005)(316002)(33656002)(71200400001)(4326008)(5660300002)(52536014)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 3RKaPkYfeGCnOPKHo2n6E27XSyKL/2lCCUMdY7hkyaVZEmJdvJkRzLMBBskx9TYXqwosMcF19KUzVDJZCp6KPQghEw8+tlxqAWDHMjYQTn1ZsJ9wasCyq0aCgNkPt9G5INHAv4rCV72qVpQzm2v9lIPOWrV2LVLNm1LsokYfzxya+UXX2y1zRl3drkPYJxfefvKB2PZEuGnYapBAaCe+oEZD8IDmhwpm8RTNXh4Ga3VgsXVNopObRWgoqexGbs61ueuHxIz/5W+MuDusjAea5omwgsHd0/xhrN2tEg1ITiNLDQh/K5qr7fvMG599IEjXOeWr6Yx1LCG3KZpn7QOyq8ZPMjj0VObVxfvKRTtL0Af503UdvZqCWKeK3HFJkvdRDXDtSJ57H5TMS0+wnxRsE2btCDNwHybEshPiYSEoeTS5ocR9Q1FDw3Zwy3/Fwwpr2DT9b51nrfj/4JmlGxj0mthn/7KcmdIeR1m/JbrXas/Njn/8+ftAVKmtPQDztTTD
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0cd7fc-8c52-4ffa-1224-08d81cbd8426
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 06:19:16.2380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsOqGwiQiTGCZM3GnoVt7NyJy36iiIYfSWvqmYgaaIQ8bR+ITdWF9A+BBw7aGyIipohtt+4+OLQyJfgK4MJaVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0063
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
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
> Sent: Sunday, June 28, 2020 8:34 AM
> 
> After a page request is handled, software must response the device which
> raised the page request with the handling result. This is done through
> the iommu ops.page_response if the request was reported to outside of
> vendor iommu driver through iommu_report_device_fault(). This adds the
> VT-d implementation of page_response ops.
> 
> Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c |  1 +
>  drivers/iommu/intel/svm.c   | 73
> +++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |  3 ++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index de17952ed133..7eb29167e8f9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -6057,6 +6057,7 @@ const struct iommu_ops intel_iommu_ops = {
>  	.sva_bind		= intel_svm_bind,
>  	.sva_unbind		= intel_svm_unbind,
>  	.sva_get_pasid		= intel_svm_get_pasid,
> +	.page_response		= intel_svm_page_response,
>  #endif
>  };
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 4800bb6f8794..003ea9579632 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1092,3 +1092,76 @@ int intel_svm_get_pasid(struct iommu_sva *sva)
> 
>  	return pasid;
>  }
> +
> +int intel_svm_page_response(struct device *dev,
> +			    struct iommu_fault_event *evt,
> +			    struct iommu_page_response *msg)
> +{
> +	struct iommu_fault_page_request *prm;
> +	struct intel_svm_dev *sdev;
> +	struct intel_iommu *iommu;
> +	struct intel_svm *svm;
> +	bool private_present;
> +	bool pasid_present;
> +	bool last_page;
> +	u8 bus, devfn;
> +	int ret = 0;
> +	u16 sid;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;

move to the place when iommu is referenced. This place is too early.

> +
> +	if (!msg || !evt)
> +		return -EINVAL;
> +
> +	mutex_lock(&pasid_mutex);
> +
> +	prm = &evt->fault.prm;
> +	sid = PCI_DEVID(bus, devfn);
> +	pasid_present = prm->flags &
> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> +	private_present = prm->flags &
> IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
> +	last_page = prm->flags &
> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +
> +	if (pasid_present) {
> +		/* VT-d supports devices with full 20 bit PASIDs only */
> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX) {
> +			ret = -EINVAL;
> +			goto out;
> +		}

shouldn't we check prm->pasid here? Above is more reasonable to be
checked when page request is reported.

> +
> +		ret = pasid_to_svm_sdev(dev, prm->pasid, &svm, &sdev);
> +		if (ret || !sdev)

if sdev==NULL, suppose an error (-ENODEV) should be returned here?

> +			goto out;
> +	}
> +
> +	/*
> +	 * Per VT-d spec. v3.0 ch7.7, system software must respond
> +	 * with page group response if private data is present (PDP)
> +	 * or last page in group (LPIG) bit is set. This is an
> +	 * additional VT-d feature beyond PCI ATS spec.

feature->requirement

Thanks
Kevin

> +	 */
> +	if (last_page || private_present) {
> +		struct qi_desc desc;
> +
> +		desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid)
> |
> +				QI_PGRP_PASID_P(pasid_present) |
> +				QI_PGRP_PDP(private_present) |
> +				QI_PGRP_RESP_CODE(msg->code) |
> +				QI_PGRP_RESP_TYPE;
> +		desc.qw1 = QI_PGRP_IDX(prm->grpid) |
> QI_PGRP_LPIG(last_page);
> +		desc.qw2 = 0;
> +		desc.qw3 = 0;
> +		if (private_present)
> +			memcpy(&desc.qw2, prm->private_data,
> +			       sizeof(prm->private_data));
> +
> +		qi_submit_sync(iommu, &desc, 1, 0);
> +	}
> +out:
> +	mutex_unlock(&pasid_mutex);
> +	return ret;
> +}
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index fc2cfc3db6e1..bf6009a344f5 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -741,6 +741,9 @@ struct iommu_sva *intel_svm_bind(struct device
> *dev, struct mm_struct *mm,
>  				 void *drvdata);
>  void intel_svm_unbind(struct iommu_sva *handle);
>  int intel_svm_get_pasid(struct iommu_sva *handle);
> +int intel_svm_page_response(struct device *dev, struct iommu_fault_event
> *evt,
> +			    struct iommu_page_response *msg);
> +
>  struct svm_dev_ops;
> 
>  struct intel_svm_dev {
> --
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
