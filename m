Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03D6C433E2
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 02:42:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AFB20663
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 02:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="dmPwwi/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AFB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7266A85F37;
	Fri, 10 Jul 2020 02:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id horyDitkgG4G; Fri, 10 Jul 2020 02:42:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 605BD85E06;
	Fri, 10 Jul 2020 02:42:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5606EC0865;
	Fri, 10 Jul 2020 02:42:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 923DBC016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 02:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 888C989709
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 02:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DmSJ628e7tSG for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 02:42:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 99586896F8
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 02:42:36 +0000 (UTC)
IronPort-SDR: x/wV8S96Gcpx8+wc5UWqBmD9n09OWmMXHFKOsAf2sYbrrB5E7qvgrCJLfTWgCXgnyky0f8FKBH
 GBLFgTxhoeQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="147231218"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; d="scan'208";a="147231218"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 19:42:36 -0700
IronPort-SDR: PZrqN4El/DtGqdKhDlP27CSgZSYbT5CDaj8wY59kZ2eZelphZU3PNxJ6+nK32aykaUpE8vtAo6
 azaOqF7SDOfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; d="scan'208";a="323410594"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2020 19:42:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 19:42:35 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 Jul 2020 19:42:35 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 9 Jul 2020 19:42:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 19:42:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDWeJy5NgiKflkciJ1ImC++xzKMj0WC1UgjeVR1ZDMJnOe6oxrVDGursTyfqBvkiGTqZ8WIikIVGtLhRbAuLf/XXXqUYCWMx1jwRVNan+7VIK+D7JJXZcmpA15qw7CvIPzcrGDCqcUdgVG0itXVGH0y0hcNowUvkjQmP3yMWdH+hN2q4vxI7Hj1cD62TX6FEOb2MGFOKL1RCL1EKNf2udcpbPkSIA7NYFsD19/fAjBfiqejAxZzmLrJfanzQvJ5Ts9/VS9TnPla7iGMYOPFHRVs9OdN7Kg8VnQJg5RB0U+JU/WgDOHjVVJzg3HuMz1JCYQpmFWjqxoOYEtLYRBSg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nik6OlexRhqTj09ALTCecKHegT48NWZiiyyT0s8Iu8w=;
 b=jfQFUl8bIzKlGmvku22/xBERlWg9Q5vVyATnGFuKd3ZyU6tn7iYlglL6I3fmpp16AyzSkE67bwd430gNon5rYRkkSOx8RnwgIVWft0AyupvVAlrDBvNRXU/R4t8Y339FMaWo5RjpNTEbOu9WrSiLPev3DkKA7qjQM5f+nGybhpxMRacz8p+U18ZiGHDKPt+EjVMCG6aGTlVbT3zr3EPSyxFRqTkFCPd9qa+nyaCayhybBqKCQu06UwFW2g/A9kYHzFL9ukWg3aIfzLnt3Nq52pRXuKOrFZqD5S3yXhpZ/P5i2g2YvnwvSIOs4JM6RMfh8gn+4SRNjzTpKDZqEc3aqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nik6OlexRhqTj09ALTCecKHegT48NWZiiyyT0s8Iu8w=;
 b=dmPwwi/8cCX72W4Zs1Q4qzOkZw/dNez0L16m4E7QoKtmV8KsCh355P0V9YCUaIO6eFe1DwEQPD1Kb3Obs9JFKVRtN8O+h7USeS/EsFqcCB+gV2Tbme6vXblLi+olFHpQ8pJB57xlEB4lYcg/+ZpA8jUAQ2FCOGDOKGagHUQG7Uo=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1391.namprd11.prod.outlook.com (2603:10b6:300:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 02:42:30 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 02:42:30 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v3 4/4] iommu/vt-d: Add page response ops support
Thread-Topic: [PATCH v3 4/4] iommu/vt-d: Add page response ops support
Thread-Index: AQHWVcAM+avb7Y6qlkuRLGDQ/735sakAFvrQ
Date: Fri, 10 Jul 2020 02:42:30 +0000
Message-ID: <MWHPR11MB164546581C5F6B6B77AE28C88C650@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200709070537.18473-1-baolu.lu@linux.intel.com>
 <20200709070537.18473-5-baolu.lu@linux.intel.com>
In-Reply-To: <20200709070537.18473-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e7e353a-ae40-4fca-3a62-08d8247ae461
x-ms-traffictypediagnostic: MWHPR11MB1391:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB139156299B0F6ED0FDDE41928C650@MWHPR11MB1391.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2E4mTW+CN+dPnuR0SV8p0fX4n+uODB1AT4EilunmM2Go/RcR9/6OXVBM5Zkb4bkpstl1xr4l7YhHrVZZcH9UIq1JxbA/o0HwtWbVXccYqUAEc1Uul8oRRFLEqw+BIPCQltewGq8Eg9tEUY1PQ2m9SwaDqxGGd6+scH05KdXZ46cU5h45H3e6Cd83hMYG5xsOLbSL9t4h1bLO2vP4v5sTn/cZwdTzkgyDRiaDzAZ6fb4BKbmOBOJ8ytOBsXSaypF5pYM54Y8mhz81TxZajbvR7k80h3pszjmeH/tfyhSikBVL/0pdAzcMMbIwVLylsi+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(54906003)(55016002)(186003)(66446008)(9686003)(83380400001)(71200400001)(26005)(66556008)(8936002)(64756008)(66476007)(33656002)(2906002)(8676002)(4326008)(86362001)(7696005)(316002)(110136005)(52536014)(478600001)(76116006)(66946007)(5660300002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: jgZIWCU0KLNSnSA7cYBUbTGgI1eLCcwFJjrVIKWBZH1UjsqRKCAcFbWdus/sJZqd332nmBJYIJFwG0hdCNd3C3ouL4g8qIdhlREEhGxaBwaA9S7poxvV9woxuc4QQf/NdX8/E+qOmXPAg4xgzo9rzNvItl7ssqQ3Kd4kcDw2pV0FNIDJ7W09AApt2jHF72hrAAJBzpuZyB2Iax2aVsxlQJ+OCjPtMju+v/3R97iBahHDqFPT7prlsOPmQOD4LNg1L9F6tmUjH2YzTu09hiYefBrrXQhb362qzDn/FFN0LekYX9a0fWmftR1AGqnO7ukz3KF5xVhDcIOzcx+Xq8Rtqm3N9maaQiLQgab34xw69gyTO2j6PWBpR6/GfSdj1xCXxcZ9g4XfIkG3vX//U5TZKWhqaVlE+2Qs6SQAjeSo4tH458Wy724F/86D8GtAK6WyNjpXZ4Bax7iMxbTbL8SqyV5sV5q8GUuFc1zlpqC+In1FRGKYQE1JtBroTpWoxpdK
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7e353a-ae40-4fca-3a62-08d8247ae461
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 02:42:30.6453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EI38hnIf1WuKuf1MQWF0oCrmMGkiPtkdlEju89xyK0tp4W1BR+gy+/2oMed0FuAlfmdpeeDCWzRSByXnVW05sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1391
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
> Sent: Thursday, July 9, 2020 3:06 PM
> 
> After page requests are handled, software must respond to the device
> which raised the page request with the result. This is done through
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
>  drivers/iommu/intel/iommu.c |   1 +
>  drivers/iommu/intel/svm.c   | 100
> ++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |   3 ++
>  3 files changed, 104 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4a6b6960fc32..98390a6d8113 100644
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
> index d24e71bac8db..839d2af377b6 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1082,3 +1082,103 @@ int intel_svm_get_pasid(struct iommu_sva *sva)
> 
>  	return pasid;
>  }
> +
> +int intel_svm_page_response(struct device *dev,
> +			    struct iommu_fault_event *evt,
> +			    struct iommu_page_response *msg)
> +{
> +	struct iommu_fault_page_request *prm;
> +	struct intel_svm_dev *sdev = NULL;
> +	struct intel_svm *svm = NULL;
> +	struct intel_iommu *iommu;
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
> +
> +		/*
> +		 * For responses from userspace, need to make sure that the
> +		 * pasid has been bound to its mm.
> +		*/
> +		if (svm->flags & SVM_FLAG_GUEST_MODE) {
> +			struct mm_struct *mm;
> +
> +			mm = get_task_mm(current);
> +			if (!mm) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +
> +			if (mm != svm->mm) {
> +				ret = -ENODEV;
> +				mmput(mm);
> +				goto out;
> +			}
> +
> +			mmput(mm);
> +		}
> +	} else {
> +		pr_err_ratelimited("Invalid page response: no pasid\n");
> +		ret = -EINVAL;
> +		goto out;

check pasid=0 first, then no need to indent so many lines above. 

> +	}
> +
> +	/*
> +	 * Per VT-d spec. v3.0 ch7.7, system software must respond
> +	 * with page group response if private data is present (PDP)
> +	 * or last page in group (LPIG) bit is set. This is an
> +	 * additional VT-d requirement beyond PCI ATS spec.
> +	 */

What is the behavior if system software doesn't follow the requirement?
en... maybe the question is really about whether the information in prm
comes from userspace or from internally-recorded info in iommu core.
The former cannot be trusted. The latter one is OK.

Thanks
Kevin

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
