Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C38C433DF
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 05:50:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DD02072E
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 05:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="TVOm3P1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DD02072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 333F4895FE;
	Fri, 10 Jul 2020 05:50:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fOMfCSosBU6T; Fri, 10 Jul 2020 05:50:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5354C895CF;
	Fri, 10 Jul 2020 05:50:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3007BC077B;
	Fri, 10 Jul 2020 05:50:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF12AC016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 05:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6D0D689499
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 05:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pKTzaHxe4iRE for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 05:49:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4DD378946B
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 05:49:41 +0000 (UTC)
IronPort-SDR: JuhaH4+QAuG7gRUz2Ubv0HgV4tyykmYJvuJBKBBsZ4llurVOtMCpjEfu1ey905i8p4tB/B9fxr
 iogILeC5+Ybw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="136360151"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; d="scan'208";a="136360151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 22:49:39 -0700
IronPort-SDR: bchubPE4SMeVtG5TX4i3WiS+mcoC3Grj603ZOtbLvzLHQfKgWguMCoRDkWl5Pm3TxE4LHAb/Lm
 Q8q5SHM2O4Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; d="scan'208";a="324495012"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga007.jf.intel.com with ESMTP; 09 Jul 2020 22:49:38 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 22:49:38 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 22:49:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 9 Jul 2020 22:49:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP45rpwchYjRUUvG9DVYdeUzqG1yNtyjEhQPlrdKZGOuC/wGg4vOZQSjpP0iVKCK5qAEgnq++LZlb3iMzv8CYTEK+xnAqu0mhbFml+/sAHyuePhIz+uBsgwZG4jPOFD4ss7D0k6sRMBzzpGodfVqcM9lD9SOTL7ebetsrGKhq6QS0mvcTeL6I+W00+KqtybqeHlFS9O8SC+BnLidkmXnu1m+rzzWt0PQ118uCwtwQ74STxn3ZuieJq8mqF9oY/C7KhiEfr+aEwT33h4ZMNeMzR3fRmqkNs8wmRIMLCfxUyZEYqb0rregPDN6y6V5arpcwA1zOSswOqM6CHkvNtKb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9If5RsxQ3u2i9WodtwoiHSv0PtR1ZoRMVd9OrdMKNc=;
 b=F+CY8NjsUJfWfeEQ46hZfDY9SzFHP3t9PARsPxAXg4jJVjrq/+ayG8fJOxGKWl0jnhgpD94c7/NYAIYiOY+TbIiX7f6qpD2VJQX0t5cIZZniCXDU49OEC6WYeRQ/98Z5iIBjk93wBL+qSSNdQRJ+ZYB22XRJP3O62HXJz2QvYF1AUV2gFryun9ZAHQj2bfXum65M3CwHqlIZYzgdI87XgEgDQ6J1xqYzTvwa17BVUFcUKBCFf5tWnsDsuaW69OY3eF5ho+B4b8nZnuedn9Z4Y2hj8zhJcdTfPkS7EIRYXrbIRR5Y6xnKZv3TZQ59XwtzOf/iUs4P7qkUKJ90jfh5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9If5RsxQ3u2i9WodtwoiHSv0PtR1ZoRMVd9OrdMKNc=;
 b=TVOm3P1qCFBv+PyqOJzPGtdTV1Tn0r+PenDCuMyXGug+3k3GsOw+lJ49VJ6w5mChV7GuDM7jgdNwI8Ihq8S4CimEMDJworTrpD4qMUwZNtpb+STRbG2dMSMum5UKQjFFgXwKdu6x/IkWUu1N3zdG1SlGlMiyL/6g7OcXRbBemtQ=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB2045.namprd11.prod.outlook.com (2603:10b6:300:29::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 05:49:35 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 05:49:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v3 4/4] iommu/vt-d: Add page response ops support
Thread-Topic: [PATCH v3 4/4] iommu/vt-d: Add page response ops support
Thread-Index: AQHWVcAM+avb7Y6qlkuRLGDQ/735sakAFvrQgAA1wACAAAGkcA==
Date: Fri, 10 Jul 2020 05:49:35 +0000
Message-ID: <MWHPR11MB164513189877BD3734F589328C650@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200709070537.18473-1-baolu.lu@linux.intel.com>
 <20200709070537.18473-5-baolu.lu@linux.intel.com>
 <MWHPR11MB164546581C5F6B6B77AE28C88C650@MWHPR11MB1645.namprd11.prod.outlook.com>
 <cbf470fe-933a-54d5-e215-afb32d40165f@linux.intel.com>
In-Reply-To: <cbf470fe-933a-54d5-e215-afb32d40165f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccd2bf79-f24a-441e-ba20-08d8249506bb
x-ms-traffictypediagnostic: MWHPR11MB2045:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB20458172A7D3C2DB0C8076BA8C650@MWHPR11MB2045.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IX0QBCokXNGSN7ICEJTgFv8ZPBV68ZGKRq9+xdVTvhBLxXul3rzZGtUZmwioT0U89QaUFZd5bgkuF3VI8002aWmVI+LdIRPTl0xAfdc07ABFgwJ1plPi4BM1hAoLAMpPYflHwjQgXoKv85zijRtQle0p5L9quhWUoPkdbOFEWTDKp9O+ORp+tMu5F2PtHQrHbKcXyBPfjkbvIvgPv7kbzUVzETp93CqbQWDQpECm2xVy76yWyxhGpEgmjBZlyC0xc8Gs26GyJuICX/5ozIkI+/xVfAqaAfT+ICaYkHKsBMKU57RGzL7xaJ20/1nAvrGBTnrTh22CUIPHfxSKxgoUQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66946007)(76116006)(2906002)(71200400001)(26005)(8676002)(64756008)(66476007)(66556008)(52536014)(5660300002)(66446008)(186003)(33656002)(9686003)(8936002)(4326008)(53546011)(55016002)(54906003)(7696005)(110136005)(478600001)(86362001)(83380400001)(316002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: N9LyF+QtwdC8W8aae8tmJv+M5iOw56/Be1fqVMh3bcFTtT7tTBQNPy3lFXoUZAO/YZVPHJ7ocbN6PMtNdO+iHkBKLtVZyKCz6+ac40hHqMY6Mv9tO4CivxRxoeU2kQHfmdr+q8jfpnD815DzwGlu6Ief2O2KZd0chVKGr3l1BNUqbcTQIfpS0xv3YU1fJ8SFtn6mREZpziDQPAwHfsElXxY2X4+hefVVzJxZjbTCqoe4ZQ3Lcg4TKAijWB18IkZp28Gn+kt/mot/E3YBOxcJ6uDqhVAGmpTODbp8pDuxTKRGfaqTWZ2ZNRENHwc+bNIcT419mQzotn2Kt/QQ85YBGu7qwQThn6DWMOd4A8MXQ6/LU8vbXRSj8e+Kfxwrx7raamEs81rA+tqVz1OG6q6FWL521r8xbbR9Qg5diCNX8jztBMOodMY2lvSY4kYNhaJ1UdxhmYPI5gDUxj+qtVArDy2+YKdyczQZBIe8CnKov6Xu9uDvRHk0i64EQ9kl4uPb
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd2bf79-f24a-441e-ba20-08d8249506bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 05:49:35.3828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3YFldo8VF7/eJfPR6CnnXE38ewokTYa0LKUxvKFtknSbyDJOHyAk9Nh/lko9aLX0VRqPUpUvUZj338zw5kopA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2045
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
> Sent: Friday, July 10, 2020 1:37 PM
> 
> Hi Kevin,
> 
> On 2020/7/10 10:42, Tian, Kevin wrote:
> >> From: Lu Baolu <baolu.lu@linux.intel.com>
> >> Sent: Thursday, July 9, 2020 3:06 PM
> >>
> >> After page requests are handled, software must respond to the device
> >> which raised the page request with the result. This is done through
> >> the iommu ops.page_response if the request was reported to outside of
> >> vendor iommu driver through iommu_report_device_fault(). This adds
> the
> >> VT-d implementation of page_response ops.
> >>
> >> Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
> >> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/intel/iommu.c |   1 +
> >>   drivers/iommu/intel/svm.c   | 100
> >> ++++++++++++++++++++++++++++++++++++
> >>   include/linux/intel-iommu.h |   3 ++
> >>   3 files changed, 104 insertions(+)
> >>
> >> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> >> index 4a6b6960fc32..98390a6d8113 100644
> >> --- a/drivers/iommu/intel/iommu.c
> >> +++ b/drivers/iommu/intel/iommu.c
> >> @@ -6057,6 +6057,7 @@ const struct iommu_ops intel_iommu_ops = {
> >>   	.sva_bind		= intel_svm_bind,
> >>   	.sva_unbind		= intel_svm_unbind,
> >>   	.sva_get_pasid		= intel_svm_get_pasid,
> >> +	.page_response		= intel_svm_page_response,
> >>   #endif
> >>   };
> >>
> >> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> >> index d24e71bac8db..839d2af377b6 100644
> >> --- a/drivers/iommu/intel/svm.c
> >> +++ b/drivers/iommu/intel/svm.c
> >> @@ -1082,3 +1082,103 @@ int intel_svm_get_pasid(struct iommu_sva
> *sva)
> >>
> >>   	return pasid;
> >>   }
> >> +
> >> +int intel_svm_page_response(struct device *dev,
> >> +			    struct iommu_fault_event *evt,
> >> +			    struct iommu_page_response *msg)
> >> +{
> >> +	struct iommu_fault_page_request *prm;
> >> +	struct intel_svm_dev *sdev = NULL;
> >> +	struct intel_svm *svm = NULL;
> >> +	struct intel_iommu *iommu;
> >> +	bool private_present;
> >> +	bool pasid_present;
> >> +	bool last_page;
> >> +	u8 bus, devfn;
> >> +	int ret = 0;
> >> +	u16 sid;
> >> +
> >> +	if (!dev || !dev_is_pci(dev))
> >> +		return -ENODEV;
> >> +
> >> +	iommu = device_to_iommu(dev, &bus, &devfn);
> >> +	if (!iommu)
> >> +		return -ENODEV;
> >> +
> >> +	if (!msg || !evt)
> >> +		return -EINVAL;
> >> +
> >> +	mutex_lock(&pasid_mutex);
> >> +
> >> +	prm = &evt->fault.prm;
> >> +	sid = PCI_DEVID(bus, devfn);
> >> +	pasid_present = prm->flags &
> >> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> >> +	private_present = prm->flags &
> >> IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
> >> +	last_page = prm->flags &
> >> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> >> +
> >> +	if (pasid_present) {
> >> +		if (prm->pasid == 0 || prm->pasid >= PASID_MAX) {
> >> +			ret = -EINVAL;
> >> +			goto out;
> >> +		}
> >> +
> >> +		ret = pasid_to_svm_sdev(dev, prm->pasid, &svm, &sdev);
> >> +		if (ret || !sdev) {
> >> +			ret = -ENODEV;
> >> +			goto out;
> >> +		}
> >> +
> >> +		/*
> >> +		 * For responses from userspace, need to make sure that the
> >> +		 * pasid has been bound to its mm.
> >> +		*/
> >> +		if (svm->flags & SVM_FLAG_GUEST_MODE) {
> >> +			struct mm_struct *mm;
> >> +
> >> +			mm = get_task_mm(current);
> >> +			if (!mm) {
> >> +				ret = -EINVAL;
> >> +				goto out;
> >> +			}
> >> +
> >> +			if (mm != svm->mm) {
> >> +				ret = -ENODEV;
> >> +				mmput(mm);
> >> +				goto out;
> >> +			}
> >> +
> >> +			mmput(mm);
> >> +		}
> >> +	} else {
> >> +		pr_err_ratelimited("Invalid page response: no pasid\n");
> >> +		ret = -EINVAL;
> >> +		goto out;
> >
> > check pasid=0 first, then no need to indent so many lines above.
> 
> Yes.
> 
> >
> >> +	}
> >> +
> >> +	/*
> >> +	 * Per VT-d spec. v3.0 ch7.7, system software must respond
> >> +	 * with page group response if private data is present (PDP)
> >> +	 * or last page in group (LPIG) bit is set. This is an
> >> +	 * additional VT-d requirement beyond PCI ATS spec.
> >> +	 */
> >
> > What is the behavior if system software doesn't follow the requirement?
> > en... maybe the question is really about whether the information in prm
> > comes from userspace or from internally-recorded info in iommu core.
> > The former cannot be trusted. The latter one is OK.
> 
> We require a page response when reporting such event. The upper layer
> (IOMMU core or VFIO) will be implemented with a timer, if userspace
> doesn't respond in time, the timer will get expired and a FAILURE
> response will be sent to device.

Yes, timer helps when userspace doesn't respond. Then I'm fine with
this patch.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

btw when you say IOMMU core or VFIO, does it mean the timer mechanism
is not implemented yet?

Thanks
Kevin

> 
> Best regards,
> baolu
> 
> >
> > Thanks
> > Kevin
> >
> >> +	if (last_page || private_present) {
> >> +		struct qi_desc desc;
> >> +
> >> +		desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid)
> >> |
> >> +				QI_PGRP_PASID_P(pasid_present) |
> >> +				QI_PGRP_PDP(private_present) |
> >> +				QI_PGRP_RESP_CODE(msg->code) |
> >> +				QI_PGRP_RESP_TYPE;
> >> +		desc.qw1 = QI_PGRP_IDX(prm->grpid) |
> >> QI_PGRP_LPIG(last_page);
> >> +		desc.qw2 = 0;
> >> +		desc.qw3 = 0;
> >> +		if (private_present)
> >> +			memcpy(&desc.qw2, prm->private_data,
> >> +			       sizeof(prm->private_data));
> >> +
> >> +		qi_submit_sync(iommu, &desc, 1, 0);
> >> +	}
> >> +out:
> >> +	mutex_unlock(&pasid_mutex);
> >> +	return ret;
> >> +}
> >> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> >> index fc2cfc3db6e1..bf6009a344f5 100644
> >> --- a/include/linux/intel-iommu.h
> >> +++ b/include/linux/intel-iommu.h
> >> @@ -741,6 +741,9 @@ struct iommu_sva *intel_svm_bind(struct device
> >> *dev, struct mm_struct *mm,
> >>   				 void *drvdata);
> >>   void intel_svm_unbind(struct iommu_sva *handle);
> >>   int intel_svm_get_pasid(struct iommu_sva *handle);
> >> +int intel_svm_page_response(struct device *dev, struct
> iommu_fault_event
> >> *evt,
> >> +			    struct iommu_page_response *msg);
> >> +
> >>   struct svm_dev_ops;
> >>
> >>   struct intel_svm_dev {
> >> --
> >> 2.17.1
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
