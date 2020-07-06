Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B59C433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 01:29:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCA32070C
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 01:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="RnjdxkR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCA32070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB0DD8873F;
	Mon,  6 Jul 2020 01:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SgIojIfOkEBj; Mon,  6 Jul 2020 01:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0F16488707;
	Mon,  6 Jul 2020 01:29:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC213C0888;
	Mon,  6 Jul 2020 01:29:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E865C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 01:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3D342889D4
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 01:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3-SyBT5E+0oG for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 01:29:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CE01D8884A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 01:29:37 +0000 (UTC)
IronPort-SDR: Fj9y1ciMR2bUXKG3qT/yAqHAx9Zy5EZt1gB0cvDYchXPpSYTJoVUXRqhLEhw5EycDmQRMQcKBI
 hh1UuqVQoj+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="148847373"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="148847373"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2020 18:29:36 -0700
IronPort-SDR: NbLsibavuApzyyE7/vj+NK/ksuZfPLJpxDJt4anVzvYM3jjP4XRNVHzAMFUI085kigQp2+wRdS
 YFEC3k7EWgvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="266412703"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2020 18:29:36 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 18:29:36 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 5 Jul 2020 18:29:36 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Jul 2020 18:29:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 5 Jul 2020 18:29:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt3tUoB+roEqUMN7DDYNcthCzUBrI0LDAurtKVf7djyttAAWQT+k7dE3/IogYnjiRE54u38o3K5R/vWVSFfZ8wEIlvZ/MOdrwmE9ovR42ZjkjscZW8HD8Zt4KPYfNdYx0lt7fp7CbcUW2HJnv5uNmqIOdFd63ws9dVm1MI1QWXvStXFByeXnNT/geZKCRt2v4NKXed3NPqfoBtdSWPFYsA7o3VKqNiuR6d2+GNz5fnmIpOUZCeLm6pWZ/F0KEgZkES0i3WWUUngRqa50/zdWwtc63YPBn++R2UdR91yFFuFNjQWUSvTXLHNBh6nPgagbgGRD9PBlnaQQIjXc3iyflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwVOyKK4CCBOqg58q7xPAl2hR1kyKcXZjfUrGlhcXEw=;
 b=md2bleDmX7QC0S0PWZHZbWgKsYFPV2glcS73HsSJwG2chAJn9AY/Vy11SKAK/N7aDHw/xHZ+2q1ifN0iFpC7qpUR3Hsw7N99jDqXXoDIhsZEyDuS77kGW7AiL7gA3pCUqKIsnAibvr890zqWrtYdwTGczJFb7EzA1o6vu7yK/q7o7V3lCX55q7DN3KdQ7EHJ5BiKOiUc7CD2g0VEyuOdG9QmSFKLJLnBMq/B/2SP5N6q9beV/U560LcJYQp+D4snOSkMDgSH+hq3ZrLhIvMnw9z2q6aZZz30GS6omiAxyXcXGH+7NH0Q34K783b7yIUIJDLOA3hYAZtz9ElRrm+DFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwVOyKK4CCBOqg58q7xPAl2hR1kyKcXZjfUrGlhcXEw=;
 b=RnjdxkR3z2veKOjOu1wfJHOzZqcDMa1Lzgjw/7EShxCRlM1JxN/stFdGF6WHa4IQkeMW4Wf/U4EDtvu2KkU4Yx7FgSSXWpArPCjLFQ2+foiH0jQxAfqIQ1lJ1dTWMKeiNUeD36+BxpmWKM2gZU4RAGLUwxpvHb4E5PclaLq2Jc0=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1293.namprd11.prod.outlook.com (2603:10b6:300:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 01:29:34 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 01:29:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2 3/4] iommu/vt-d: Report page request faults for guest
 SVA
Thread-Topic: [PATCH v2 3/4] iommu/vt-d: Report page request faults for guest
 SVA
Thread-Index: AQHWUyyukChEQzBHHE2t9ZcjAFLs+aj5vlKw
Date: Mon, 6 Jul 2020 01:29:34 +0000
Message-ID: <MWHPR11MB1645466566F629CE524ED9C58C690@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200706002535.9381-1-baolu.lu@linux.intel.com>
 <20200706002535.9381-4-baolu.lu@linux.intel.com>
In-Reply-To: <20200706002535.9381-4-baolu.lu@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: 5eb9838b-6223-4a96-bf74-08d8214c0a5d
x-ms-traffictypediagnostic: MWHPR11MB1293:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB12934B9946A70E7D97F448578C690@MWHPR11MB1293.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9nnP4fTkL40Ba/S0Au4GlLujkFKngPeGKbu/uvenbiGbs7I2GZpdxnwIfzfk6/oTJztDWOsEiso7k34TJ4M9nTRL72/eoYcASov5pvP/qBbhpMu9Cov2aZcOJDRhI67N8xU4mqpE/JEzIuLjpyhLcrWT9sn3bdHvG5p6ht3GgvMMXLYmefvg1+CmfqxS2UJnlqjMlfxShI9Lvom/bqyfZuC1wySmyqqcap2c83YrNTEU6AtvDvu/ZzaNcDJUh+NQyl2Y34FVMPpiSDHhD5dLrxYpijmkgV+cxwYYi40avPlcZXYDvUcyxOuoPwfNHKHY6PLt87TaTS3QcUG4fSRPng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(478600001)(316002)(54906003)(110136005)(9686003)(86362001)(8676002)(26005)(33656002)(52536014)(83380400001)(6506007)(5660300002)(2906002)(66476007)(66446008)(66556008)(64756008)(55016002)(66946007)(71200400001)(4326008)(8936002)(186003)(7696005)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: D/NYhj6AJUBRl/QJOW9S2QP+/7FeIwvQnYd+bQB49g3r4pvi29ujpql5Qhj2EbMuFYbYW8FcZfN6r9hgOrdKEYtoh6HHybO6j2kWdxxJFsPZS37SsimehaOJLrjHDvneWm20EUMlZ/E37Hg4Fpi/4hp1st6wutwWfrvpTWAfjNmxnY7Yh+wsN5a39iIPZx44JniLJmMRjygDj34Zom+HYf21riIy2705jrL+38iRbOhugTHNtkWn3o9eP2hC3nkWyZbwS9VhfG7brlwIeviofQyxl/37pMELP1qHdmfvdiTzLGhlLpE1z+HuisBhYqcFmzd0lDaccXhLBLmr+kAslWDp2PBxg27uIwKOoAyVZlE3lun4V0XI4kUTWXpQFy5feKkDhWGE+o5Z85bpNqHu/GWOLpuPRP/rj2cf4EqSjbRK53+DpwFOhitW65RtBB3AY/I9gVJPdrLnnO4WtYDX6BmZo+FrRpgEDjnpxDIijgbjKp7HhesA78tlZLWE+bPm
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb9838b-6223-4a96-bf74-08d8214c0a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 01:29:34.6722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3VSfBqHjAo8PN6kt7rqbKQ52m2aj6hBRt1s4pxFgup7xEAtOAhadr4icjzk3P9V+B5DUeJfRI7vJYcyFVzxGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1293
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
> Sent: Monday, July 6, 2020 8:26 AM
> 
> A pasid might be bound to a page table from a VM guest via the iommu
> ops.sva_bind_gpasid. In this case, when a DMA page fault is detected
> on the physical IOMMU, we need to inject the page fault request into
> the guest. After the guest completes handling the page fault, a page
> response need to be sent back via the iommu ops.page_response().
> 
> This adds support to report a page request fault. Any external module
> which is interested in handling this fault should regiester a notifier
> callback.

be specific on which notifier to be registered...

> 
> Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 99 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 81 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index c23167877b2b..08c58c2b1a06 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -815,6 +815,57 @@ static void intel_svm_drain_prq(struct device *dev,
> int pasid)
>  	}
>  }
> 
> +static int prq_to_iommu_prot(struct page_req_dsc *req)
> +{
> +	int prot = 0;
> +
> +	if (req->rd_req)
> +		prot |= IOMMU_FAULT_PERM_READ;
> +	if (req->wr_req)
> +		prot |= IOMMU_FAULT_PERM_WRITE;
> +	if (req->exe_req)
> +		prot |= IOMMU_FAULT_PERM_EXEC;
> +	if (req->pm_req)
> +		prot |= IOMMU_FAULT_PERM_PRIV;
> +
> +	return prot;
> +}
> +
> +static int
> +intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
> +{
> +	struct iommu_fault_event event;
> +	u8 bus, devfn;
> +
> +	memset(&event, 0, sizeof(struct iommu_fault_event));
> +	bus = PCI_BUS_NUM(desc->rid);
> +	devfn = desc->rid & 0xff;

not required.

> +
> +	/* Fill in event data for device specific processing */
> +	event.fault.type = IOMMU_FAULT_PAGE_REQ;
> +	event.fault.prm.addr = desc->addr;
> +	event.fault.prm.pasid = desc->pasid;
> +	event.fault.prm.grpid = desc->prg_index;
> +	event.fault.prm.perm = prq_to_iommu_prot(desc);
> +
> +	/*
> +	 * Set last page in group bit if private data is present,
> +	 * page response is required as it does for LPIG.
> +	 */

move to priv_data_present check?

> +	if (desc->lpig)
> +		event.fault.prm.flags |=
> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +	if (desc->pasid_present)
> +		event.fault.prm.flags |=
> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> +	if (desc->priv_data_present) {
> +		event.fault.prm.flags |=
> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +		event.fault.prm.flags |=
> IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
> +		memcpy(event.fault.prm.private_data, desc->priv_data,
> +		       sizeof(desc->priv_data));
> +	}
> +
> +	return iommu_report_device_fault(dev, &event);
> +}
> +
>  static irqreturn_t prq_event_thread(int irq, void *d)
>  {
>  	struct intel_iommu *iommu = d;
> @@ -828,7 +879,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
> PRQ_RING_MASK;
>  	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
> PRQ_RING_MASK;
>  	while (head != tail) {
> -		struct intel_svm_dev *sdev;
> +		struct intel_svm_dev *sdev = NULL;

move to outside of the loop, otherwise later check always hit "if (!sdev)"

>  		struct vm_area_struct *vma;
>  		struct page_req_dsc *req;
>  		struct qi_desc resp;
> @@ -864,6 +915,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  			}
>  		}
> 
> +		if (!sdev || sdev->sid != req->rid) {
> +			struct intel_svm_dev *t;
> +
> +			sdev = NULL;
> +			rcu_read_lock();
> +			list_for_each_entry_rcu(t, &svm->devs, list) {
> +				if (t->sid == req->rid) {
> +					sdev = t;
> +					break;
> +				}
> +			}
> +			rcu_read_unlock();
> +		}
> +
>  		result = QI_RESP_INVALID;
>  		/* Since we're using init_mm.pgd directly, we should never
> take
>  		 * any faults on kernel addresses. */
> @@ -874,6 +939,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		if (!is_canonical_address(address))
>  			goto bad_req;
> 
> +		/*
> +		 * If prq is to be handled outside iommu driver via receiver of
> +		 * the fault notifiers, we skip the page response here.
> +		 */
> +		if (svm->flags & SVM_FLAG_GUEST_MODE) {
> +			if (sdev && !intel_svm_prq_report(sdev->dev, req))
> +				goto prq_advance;
> +			else
> +				goto bad_req;
> +		}
> +
>  		/* If the mm is already defunct, don't handle faults. */
>  		if (!mmget_not_zero(svm->mm))
>  			goto bad_req;
> @@ -892,24 +968,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  			goto invalid;
> 
>  		result = QI_RESP_SUCCESS;
> -	invalid:
> +invalid:
>  		mmap_read_unlock(svm->mm);
>  		mmput(svm->mm);
> -	bad_req:
> -		/* Accounting for major/minor faults? */
> -		rcu_read_lock();
> -		list_for_each_entry_rcu(sdev, &svm->devs, list) {
> -			if (sdev->sid == req->rid)
> -				break;
> -		}
> -		/* Other devices can go away, but the drivers are not
> permitted
> -		 * to unbind while any page faults might be in flight. So it's
> -		 * OK to drop the 'lock' here now we have it. */

should we keep and move this comment to earlier sdev lookup? and
regarding to guest unbind, ae we preventing the fault owner (outside
of iommu driver) to unbind against in-flight fault request?

> -		rcu_read_unlock();
> -
> -		if (WARN_ON(&sdev->list == &svm->devs))
> -			sdev = NULL;

similarly should we keep the WARN_ON check here?

> -
> +bad_req:
>  		if (sdev && sdev->ops && sdev->ops->fault_cb) {
>  			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
>  				(req->exe_req << 1) | (req->pm_req);
> @@ -920,7 +982,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		   and these can be NULL. Do not use them below this point!
> */
>  		sdev = NULL;
>  		svm = NULL;
> -	no_pasid:
> +no_pasid:
>  		if (req->lpig || req->priv_data_present) {
>  			/*
>  			 * Per VT-d spec. v3.0 ch7.7, system software must
> @@ -945,6 +1007,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  			resp.qw3 = 0;
>  			qi_submit_sync(iommu, &resp, 1, 0);
>  		}
> +prq_advance:
>  		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>  	}
> 
> --
> 2.17.1

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
