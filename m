Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85953C433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 01:47:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1152070C
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 01:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="MkFN28sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1152070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1818A85EF0;
	Mon,  6 Jul 2020 01:47:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyGCj_NszGT5; Mon,  6 Jul 2020 01:47:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3A1F685E7D;
	Mon,  6 Jul 2020 01:47:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A317C0888;
	Mon,  6 Jul 2020 01:47:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A817C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 01:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0E98120373
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 01:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CpT7RZz0oznw for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 01:47:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 7BC1020352
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 01:47:16 +0000 (UTC)
IronPort-SDR: gjuv9/Slkzila+OIgvcm8U1wnxY3z8tcGWfpclih0oKDsT4VX9B/T5xTeHfUQmVKSw5EjEt/nc
 kb7u/BNof5pQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="208854642"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="208854642"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2020 18:47:15 -0700
IronPort-SDR: VVqWsVn5GsmNU6g9s2B96s3rX1P/ORXZlmdNUc1rmw/Hv4i6chdIMjPGwkJJC0OfaLFOtHpY5+
 dMwzHhrHbuJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="482545788"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2020 18:47:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Jul 2020 18:47:15 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 18:47:14 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 5 Jul 2020 18:47:14 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Sun, 5 Jul 2020 18:47:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1jNAZyfj1ZcEXHWy4DThGz+viHMc2SktTd+moJ8qTtCbcaZFw4B+7Jba9RILuMLYkDoOqoVI7Rv82z9jIMAjlT/MSte5seIs/2A93oYItoXUnwMBTIRpWwfCY3+JcQ+Z/OarRDRnNRV7LaALv4uHDJt8+tLIIPI9uNuGo0Lowf/TVZ5d/CBEFfDj5kZqH3bmT9V1O/0V/Rz8rD7CuiseM9rQEJTgUEYk9reU9XfYOn3LZwKzIRN1Am1zWbf/CCAeJ5vnq/Gt6iGmwH5cDO8hz5OMrttfn5fMpsii9+4V1vh4vvZtoFCa42lS63r7yNKHbhgZvMfWxzG+iHUI4g1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9pYJtqsrLtkCmDSrwLovrs/+ejrLQcpeLTp3FkrH+0=;
 b=oOkgc7QP5ngu7MrR8Fllptr7u4MvjNpyAG2in+d7TRnoqwQa8eEFxyAvx2gNhCjv9wT1iC5FwVsl4EBTUkVx7kKPfxS6XWEWYD1ZTzgIMK4Pf9ACG6OqIHkpuGozlZyYTO2mVJL/beJsCMf3LedciNCwn5WRx2PHdQsm0EqVe/oO2FJqTrZ+EXitEccncEoIiJyEVpDq0lvsKub6PEj9UaElVm5QylAhSaYSR4E1ZjQK04TswlUO42RhGmdfFRcI/S+mZpc97+j16LO4C0ejB6TsCoPgjcmiXeoASfzihmirpo8wTzmqIH1wIJ29lijT2HOxKrHyhXN5ZpbqK2z73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9pYJtqsrLtkCmDSrwLovrs/+ejrLQcpeLTp3FkrH+0=;
 b=MkFN28sc/+tffPFochBTIFdWVsxs61rp5QJe9wvZHPcnL385BzBE3+YV2fjQJeALN/GhLpljQP5vipTDH6/KCYLI2LewEo36+mBjQdtneRXF+E6y5NPKQ4oCO91cdkkQPAHE27FX8PpEttTA1yc0UtI1S9JdmMd9XSoElzllrtI=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR1101MB2272.namprd11.prod.outlook.com (2603:10b6:301:51::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Mon, 6 Jul
 2020 01:47:11 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 01:47:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2 4/4] iommu/vt-d: Add page response ops support
Thread-Topic: [PATCH v2 4/4] iommu/vt-d: Add page response ops support
Thread-Index: AQHWUyyuiLpVdTV5FE6AQZrllhR4/6j5w4YA
Date: Mon, 6 Jul 2020 01:47:11 +0000
Message-ID: <MWHPR11MB1645D608AF261AA7DE8FF6CE8C690@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200706002535.9381-1-baolu.lu@linux.intel.com>
 <20200706002535.9381-5-baolu.lu@linux.intel.com>
In-Reply-To: <20200706002535.9381-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69819732-37e6-4228-8942-08d8214e8069
x-ms-traffictypediagnostic: MWHPR1101MB2272:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB227212EB9011906B3FE538C18C690@MWHPR1101MB2272.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3HMjrv3hzuR6R6Ly+tN7wjbwLq4pUhwW3HQ9vmvU0YbAMWUqpBFEfOXaOvoCyHjombbu5MlHrO0pVjdLVMqFaRN+c2Zh3UnzJuozAG44TSshhqThEg7ErxyR4vStE1ty054I81AOnKpK2Qo1jp+P85Sbm9wmW7nzbntKbJLsI0aboKWkdl1XGFJmohhtU2EzA4/Jp6Xc/FHYajxCQu+juApgFRs/0s0U8HDCabjxrP2CXCiQtnfYkLGhQWBlRPc+JGUEEc+qXtCUGM43doeYWo+ERlQ/QjWlWPIeZueKOQ4V5AkrqJ9xtK1conVeNWVeHtvEPlwJOQLFFIA9kDA2GZr5eYGY+8Bw7zsXJjzM8ZH+cvVUZ6armE73NGD0dCmEYOx95N0z2FOtrT736J8MqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(478600001)(966005)(5660300002)(8936002)(4326008)(316002)(33656002)(2906002)(9686003)(54906003)(110136005)(7696005)(186003)(52536014)(8676002)(55016002)(26005)(6506007)(64756008)(76116006)(71200400001)(86362001)(66946007)(66446008)(66556008)(66476007)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nNNIyV7uSa5gDvYPGiMrD+ViXQWIqFk2s8T97/hfyf/nUoccy17r1tZK7YeDN6ma31Me50LELA7QdVRGHFp2bI/KDrrcoR3c0uv6OWbOsK3YK7EMz+HqNDIefeWGHI2J2QZe6lBzhYok0zlanYZTnBftVWNLggUJrxnVh+a1YnGXRhY4stuVcorjmPHgDEsKgSKqWU0N78Dge7anxGd6XPwtPyNXG9kDB14qzWTQqnLvesPIWFVsZ0XFRn8s/8ND9d/n7rN8WObk2WzIWsT6VM1N5ydi0UHfoFZ/RbC6ZF7Ih84lD0VHbxjGBtXM1JfwAAyMR857lV/BXLN3GVo+X1J8oSg1T7d/aRYoMGMURXzpfN2lRATEq5W952V8hqUR83pJIxa66ESXOIXtM2wT5olYXuzUteueyrCBJrSlal3NNioED6nVlA85YHlXVFdT/yGsFbSUI7qX3xSienlO/dIRW7dStvZrONBrr0I1YC65fJdLlFL+7j8csQUpT7Xy
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69819732-37e6-4228-8942-08d8214e8069
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 01:47:11.7331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EH8uYnn6rrbNmqNs4ieyTOHeMqhWdLBaZd+Yv4PT0bQx7yOyuLkQmXcSTEnlBoLm9xDc6EdVyBBzpTMniHTUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2272
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

> From: Lu Baolu
> Sent: Monday, July 6, 2020 8:26 AM
> 
> After a page request is handled, software must response the device which
> raised the page request with the handling result. This is done through

'response' is a noun. 

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
>  drivers/iommu/intel/svm.c   | 74
> +++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |  3 ++
>  3 files changed, 78 insertions(+)
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
> index 08c58c2b1a06..1c7d8a9ea124 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1078,3 +1078,77 @@ int intel_svm_get_pasid(struct iommu_sva *sva)
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

but we didn't do same check when reporting fault?

> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
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
> +		if (prm->pasid == 0 || prm->pasid >= PASID_MAX) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		ret = pasid_to_svm_sdev(dev, prm->pasid, &svm, &sdev);
> +		if (ret || !sdev) {
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +	}

what about pasid_present==0? Do we support recoverable fault now
with this patch?

and who guarantees that the external fault handler (e.g. guest)
cannot do bad thing with this interface, e.g. by specifying a PASID
belonging to other guests (when Scalable IOV is enabled)?

Thanks
Kevin

> +
> +	/*
> +	 * Per VT-d spec. v3.0 ch7.7, system software must respond
> +	 * with page group response if private data is present (PDP)
> +	 * or last page in group (LPIG) bit is set. This is an
> +	 * additional VT-d requirement beyond PCI ATS spec.
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
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
