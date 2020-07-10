Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC376C433DF
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 02:24:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7454C20725
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 02:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="pQFE02Yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7454C20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40CED89968;
	Fri, 10 Jul 2020 02:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oZwDKvEsm5Dt; Fri, 10 Jul 2020 02:24:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 72E398995B;
	Fri, 10 Jul 2020 02:24:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57CD8C0865;
	Fri, 10 Jul 2020 02:24:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A39C4C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 02:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8B56D20404
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 02:24:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dR0mQlDBpcIn for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 02:24:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 22FC720133
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 02:24:33 +0000 (UTC)
IronPort-SDR: 5/RFYWPdfFO1fY+zG3S+SQpDnK/eL//zriFOeGSlNfZXauZ3zE8n26PBVe1gBm2d/A1HxwYVM/
 DeUtcITSoVyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="148127795"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; d="scan'208";a="148127795"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 19:24:32 -0700
IronPort-SDR: cKJcC/3yWSSf52ojLQGjb5iGWgo8Z/segPYvVAn/QbG6jzMjP5XHwwuI8hRVEQ52zEjPiM4Vjp
 1fyif/GFO5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; d="scan'208";a="315171588"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by orsmga008.jf.intel.com with ESMTP; 09 Jul 2020 19:24:31 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 19:24:31 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX116.amr.corp.intel.com (10.22.240.14) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 19:24:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 9 Jul 2020 19:24:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9+gch+SEIjQTu6TTqFn2+f5SDXn5KWutK6lK3N5BPrqKMP5EOJ1bB58nsBG7H9zghF8P64e2xiZqk+8K78aIHJN7q80Yzl/QiNvyxEpv4SnDW8gxdueSBIDgwHMThy5vSlE1VozVPh0ecla9UxvxWveFwJ+WECO9h6+3V6A9XnDqIIRQhy/Os1PhFWoA092o7leCLVN2yUQZCNWxSxpbpikRPMXhQutit85IVbmExnWANhXXHbjb+vyJW+dTI40iCwd4SoWiCBbgF0CfkJbUub/Ckgh3kxyAKDEwpV25J+E3/R8ssMmrQZrb2/24pzWub3FTOWpzLDZ5sX3SsmuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc+5U31Q3TfEieRrmndFuLm+BX/CT/23LZPZiafQORE=;
 b=d/19c4rLDiP00zlcqsCeMYt5NnACHYiDCDXRBvmfGW2vCOqtm+hoDgnl5SEJCUsqOiRf6hE2/KbushqPkDPGN5hKBxGQ0wX4fD+8eSCkPf+4Jpn0Jv5k1RL+VE3MFVarV1Q/Us4msG3PJ50C/JKR4v9V9eO6pchKLSTvBwbtusow+BFz3EJPKtOE+lpQBrraPNbK5SJw9UQu8WyuRNYvgbCwX11lxiabJmRIt6iaVDh877eSiq3i094QM53lvTSfYea112vOZKxSWwRkABMlBeRmh7r3h47HtVbdLghZGSjOHyU1gZJaYCNcNFD7x3dKFjtJHYJz87xLnqsaPq23Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc+5U31Q3TfEieRrmndFuLm+BX/CT/23LZPZiafQORE=;
 b=pQFE02Yj5+DtRnGEC944K8HJdzRnME+Kem666djCN2to08RezWQeOAEE+mrBObrrYUtcPjopgYCfUd93Yve8m8JsXC0OZLxKTYUq8b/ORSg0noLcEmzSfrBMftZsUC6S1cBn8+40JsTKMZHTp7yiMvKRt/xGYSsTXrzBQdEauzs=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB2048.namprd11.prod.outlook.com (2603:10b6:300:27::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 02:24:28 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 02:24:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v3 3/4] iommu/vt-d: Report page request faults for guest
 SVA
Thread-Topic: [PATCH v3 3/4] iommu/vt-d: Report page request faults for guest
 SVA
Thread-Index: AQHWVcATiLcxEN9TpUqQRpsLe6VV7akAFYCA
Date: Fri, 10 Jul 2020 02:24:28 +0000
Message-ID: <MWHPR11MB1645D22D2CBCECE1257CBFEF8C650@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200709070537.18473-1-baolu.lu@linux.intel.com>
 <20200709070537.18473-4-baolu.lu@linux.intel.com>
In-Reply-To: <20200709070537.18473-4-baolu.lu@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: a8cca2b4-e3be-469a-e1c7-08d824785f01
x-ms-traffictypediagnostic: MWHPR11MB2048:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB2048F0543AD18AF3049128A48C650@MWHPR11MB2048.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oiuJmz7uujWSsE3Z/Wd2Z4JbFqpMTcQPz5whaSqVFrLAiq5b6OMpwsr3XhK+nTQi74k8dRblDjxlquEmHVUhEn2tEa6/0ruUNhUvv8llz3gBlPTTaTIQFUaX3QG4XDjCxrXop1FsBF4Am7Ews6OlNdTXAkgggHFKvywtKFLD4Md1PN/g2Qha11Y04GIcgjKVoCL90VtoKGNJw+p1KjUkpwoZ1yjsTYPk0IvnuQqIsa0Rjl2Ems+teC1GumuffpQTSKUOSdQOzpqvkAnc7UzOel3pWXbcfC6Y2EEOtHTVk+CXQd8FPoTorvHKgcjnYr3VsAPDJAAZJKsIxcvfiyFA9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(8936002)(66946007)(110136005)(26005)(54906003)(316002)(7696005)(478600001)(64756008)(66446008)(66556008)(66476007)(52536014)(5660300002)(76116006)(6506007)(9686003)(71200400001)(33656002)(55016002)(186003)(83380400001)(2906002)(4326008)(86362001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ILlL4slf92uh+3vY6FIn7AdaZsXvqX+Rrzm355tNBB+PSZmuzCRjJmKyqsupoFoBO4sCovAvb1p2n3UmWSytdg5YCO41+ZFXumCJndgQt7xNXZ4s8Aw0CUrB+cEoRfNRcpPUaQZIXvqvTvQhtA/dTDWhoxlUG/9DYE4/9XmouKg+Qh4A35XoZT2FVHueLMsl39McfrNea69/PsoPPKmTYDTqRm9l1+F277A0lhth1dKqGenGwdJq+ZDw5ZsOn9B7m5XE0wk8YDf8TSDpFFXnwyva/HG2JO/5q9Jx3kvcmi0aBAPJzxSUut64Ng1G5tCa8AFak+aYEpsE/7XmJ9XFeXryodBqeexzzFVljca6Tt6XANlowtc332XV5FmweB4cc2xNbsSGsCDOGQgTPFBUDyly4ziFr556Fgawo+dyPTE+V6tgTBHRNDq76bbEmEkJyrkIH3J8+1IXXkVeJctGu6kle2n2bp9MfnkADXa7g4eHXzuEV46OPEcQiq2yO/rV
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cca2b4-e3be-469a-e1c7-08d824785f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 02:24:28.0280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gc0cOvCdz3QExbdu+VJtwMevPGt5sAx9hKsgYXIIN694lGnnyiD2SViIr/6QGU/O0VemCtzc14dO2n95oyMvug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2048
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
> A pasid might be bound to a page table from a VM guest via the iommu
> ops.sva_bind_gpasid. In this case, when a DMA page fault is detected
> on the physical IOMMU, we need to inject the page fault request into
> the guest. After the guest completes handling the page fault, a page
> response need to be sent back via the iommu ops.page_response().
> 
> This adds support to report a page request fault. Any external module
> which is interested in handling this fault should regiester a notifier
> with iommu_register_device_fault_handler().
> 
> Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 103 +++++++++++++++++++++++++++++++-------
>  1 file changed, 85 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index c23167877b2b..d24e71bac8db 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -815,8 +815,63 @@ static void intel_svm_drain_prq(struct device *dev,
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
> +
> +	/* Fill in event data for device specific processing */
> +	memset(&event, 0, sizeof(struct iommu_fault_event));
> +	event.fault.type = IOMMU_FAULT_PAGE_REQ;
> +	event.fault.prm.addr = desc->addr;
> +	event.fault.prm.pasid = desc->pasid;
> +	event.fault.prm.grpid = desc->prg_index;
> +	event.fault.prm.perm = prq_to_iommu_prot(desc);
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;

move the check before memset.

> +
> +	if (desc->lpig)
> +		event.fault.prm.flags |=
> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +	if (desc->pasid_present) {
> +		event.fault.prm.flags |=
> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> +		event.fault.prm.flags |=
> IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
> +	}

if pasid is not present, should we return error directly instead of
submitting the req and let iommu core to figure out? I don't have
a strong preference, thus:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

> +	if (desc->priv_data_present) {
> +		/*
> +		 * Set last page in group bit if private data is present,
> +		 * page response is required as it does for LPIG.
> +		 * iommu_report_device_fault() doesn't understand this
> vendor
> +		 * specific requirement thus we set last_page as a
> workaround.
> +		 */
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
> +	struct intel_svm_dev *sdev = NULL;
>  	struct intel_iommu *iommu = d;
>  	struct intel_svm *svm = NULL;
>  	int head, tail, handled = 0;
> @@ -828,7 +883,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) &
> PRQ_RING_MASK;
>  	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
> PRQ_RING_MASK;
>  	while (head != tail) {
> -		struct intel_svm_dev *sdev;
>  		struct vm_area_struct *vma;
>  		struct page_req_dsc *req;
>  		struct qi_desc resp;
> @@ -864,6 +918,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
> @@ -874,6 +942,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
> @@ -892,24 +971,11 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
> -		rcu_read_unlock();
> -
> -		if (WARN_ON(&sdev->list == &svm->devs))
> -			sdev = NULL;
> -
> +bad_req:
> +		WARN_ON(!sdev);
>  		if (sdev && sdev->ops && sdev->ops->fault_cb) {
>  			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
>  				(req->exe_req << 1) | (req->pm_req);
> @@ -920,7 +986,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		   and these can be NULL. Do not use them below this point!
> */
>  		sdev = NULL;
>  		svm = NULL;
> -	no_pasid:
> +no_pasid:
>  		if (req->lpig || req->priv_data_present) {
>  			/*
>  			 * Per VT-d spec. v3.0 ch7.7, system software must
> @@ -945,6 +1011,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  			resp.qw3 = 0;
>  			qi_submit_sync(iommu, &resp, 1, 0);
>  		}
> +prq_advance:
>  		head = (head + sizeof(*req)) & PRQ_RING_MASK;
>  	}
> 
> --
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
