Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281E6C433E0
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 06:38:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3D923122
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 06:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3D923122
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1D74F864AD;
	Fri, 22 Jan 2021 06:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qnk422j7RNa2; Fri, 22 Jan 2021 06:38:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7AFE984707;
	Fri, 22 Jan 2021 06:38:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51A33C088B;
	Fri, 22 Jan 2021 06:38:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D61D6C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 06:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C163F22708
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 06:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XwvDOMdi-M+H for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 06:38:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 0BE23226EA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 06:38:48 +0000 (UTC)
IronPort-SDR: mZfEckLPQd1sl0KaPcuq7llCzzPbuvM6pTETVRzWgSMIs8Ai745KnOQNjLsoAWZMuprG/dbN/t
 GXvGSZIVCZdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="198147985"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; d="scan'208";a="198147985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 22:38:46 -0800
IronPort-SDR: XCjM7svZT5UjKFliAlRUADgUlXAYMNUgeXZ7pw30B9gDf+IgZbzBcrubD3iq6Crl+cVd8jr4bp
 9XRr1Z/zLDGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; d="scan'208";a="467739448"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2021 22:38:46 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Jan 2021 22:38:46 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Jan 2021 22:38:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 21 Jan 2021 22:38:45 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 21 Jan 2021 22:38:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRBGsFMuYSQIxP1/CVP9/Qyut0Tl5hpyq4wybYCu3Y8M2Bj6VTVqRIjTuKa6i0lJoLgTYZYF4qj0J5BCA4WA2hmxydOwVxijby225h443UPtAueml4x579rDQXZ0bsLuDL9s1rtD5XqMOT3dWpwS33FMtStGKxmpTMB89vdMla/+yzKJ20DwSSOqf7t8c7/q0HQ0K2g8QNL02eLQOwGjKNCIrt9bnEpCXYnXIuCtJXc05WSH62aKCLK0ecMyY9F+fxcUFfmb7F8D0Zsqvmi/S1ltFXKjTiMqGSuZVJ2jbyE7yF6dPIuFICUjl+M+ROdT5YT9qgaIrD+4m9KvFHi+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDgt4n5/+ilY8W16SwF5Tpp96Aodex5UuN4ZGoScCfE=;
 b=G0yLhxi6jgW4IfuRNJWPBoUG6rDHaPdhlQS6pXfrr69Zs88djYVBVsl1261xqHCJZEjz12HA1H38ylN8UxtXvFxBpi2E2P5VcjMl+mzJB14wJpU825v9GkNQVYbQFyr6yXZpxn7otwzE9k8Aiayl/qLRAAgyP0zkS8P97mfN3FEKJ6cZcJA2PDHMfxAXhAx3Wclw9CUekj/uwrn/EofIK266UuBZpuvd2Dh853XFDg6j76qRcEi/c+aa2Ui/xoAozc0KFbK3chgq6hVtStFqRdz3dmwTlzRFs8+jS/OVzc9LOddrZHM+JVu8azKCa7eA1tLLy0wUbeRmOx0wY3jtCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDgt4n5/+ilY8W16SwF5Tpp96Aodex5UuN4ZGoScCfE=;
 b=FXWDsx9bPoJn6S45qZvg8GBjOMY560Wn4ayfTqAi1Okf1q90xGIxENWglPV4U/9hBe0gN2mNJJUldtUrqA6I/20zl7l35blWTMOqZRTQgfOOJzBK20njzDuGEIexK2sFza+aurOpiJ/CgWwNXv+5TqLy1hqf1InlvivvrksAVX0=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2077.namprd11.prod.outlook.com (2603:10b6:301:4d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 06:38:43 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 06:38:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>
Subject: RE: [PATCH 1/3] iommu/vt-d: Add rate limited information when PRQ
 overflows
Thread-Topic: [PATCH 1/3] iommu/vt-d: Add rate limited information when PRQ
 overflows
Thread-Index: AQHW75g+RLZFpZHZgU2TQsFksxSAmqozMHIA
Date: Fri, 22 Jan 2021 06:38:42 +0000
Message-ID: <MWHPR11MB18862D2EA5BD432BF22D99A48CA09@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210121014505.1659166-1-baolu.lu@linux.intel.com>
 <20210121014505.1659166-2-baolu.lu@linux.intel.com>
In-Reply-To: <20210121014505.1659166-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea75dae0-6e3d-49b4-6baf-08d8bea05c76
x-ms-traffictypediagnostic: MWHPR1101MB2077:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB207700374AAE8B61C0989E258CA09@MWHPR1101MB2077.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k5cLuwDPpX9zfyKIns0LHltZ7WzVS6MunumU7aoM/9BpYUispndGHOKWnzMBC2gcxHF9hkwagoz9p+jFU5HE5JYPhTDNIIECPEdEUYGsUzO+Zk4rAU22YnOpAv6pqTc28uSUrZ8xx1ewIeduT2XbTgnIlM/cJwpXLmxYV+6tSytTW5js6Dnu31Bk14I2bC4y8OfO7+WeYZQKnMhAt4j5/xGi3fgFVlgn2uS+T+Q7qb4nDZ3qCsyk99hI/Zy27ZqtqE2oZXgorEaH15fxahV+/hiyk3kvfHVZNb+x4SvJRcCMig8kPZbomtjzh9vUqQxA1G7V9DwlumcC10H9l1jUYpoofQlbTsIhbvOKTrQc9E85GmvWyI18mkdb1RIjm/fvc1YDXhOZWRUJWbZpOTP02Ph/Ark19C3FlsNZSYGggqAIeK4E0d349On/rGn0WqX9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(7696005)(110136005)(316002)(71200400001)(4326008)(5660300002)(55016002)(8936002)(9686003)(54906003)(33656002)(186003)(478600001)(66946007)(76116006)(86362001)(52536014)(26005)(66446008)(6506007)(66556008)(8676002)(83380400001)(64756008)(66476007)(2906002)(20673002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2xfOuVHqEFHpjvc48nPm20koSqQud7U29V2c7c8b3mNpeEbdMY8nTZRAf1qz?=
 =?us-ascii?Q?fJLiUkvZEq6McXtMZKf6Nra5Qer2j4/AiOpa7gv8u+5PD/2SZSNvMY84S/a2?=
 =?us-ascii?Q?mp89eeKgxtIWUwdT48PRauk0ieGpp6u74NiP4xJchO77Z1IfS7sYk+6uQ+ye?=
 =?us-ascii?Q?DD+ajzn4jFYM2aJFD7ce6auGY8/cFioewolQE1LtROChh8jUG+xjqVw8+kNV?=
 =?us-ascii?Q?7auorduj+O5Km+Rqu8f70RIKaMaSg1nwyASUNQi9k1I42QDdKC7dy0rEQXtq?=
 =?us-ascii?Q?AjpiAcEEdrvhI3BwCo+ofSmTnS13xHGtX6SgWPZExeaqXJFGwo9odwWbLOyA?=
 =?us-ascii?Q?0XZxW9UCzegRB0DoPwRXvQ6hvF1sGXGNUbGB4q6ezYzKUhXAcMPY4GVxc77j?=
 =?us-ascii?Q?pIYPe7LclcyFT0vT/8S8lUslX1IEbFLY6SMCfcPELH+6/3r/45vBhpjPEY0s?=
 =?us-ascii?Q?m0VizmTjrDtZNbECDtrosf1UV6ZxmcogvfNLD+h+sXHeYh2wmd/V0FlUjQvM?=
 =?us-ascii?Q?wCCGcgwRIJ18dmh5+1LiresD0iyE12kQ74uiKGjOxRjPYXqh8rCuj+v2YXs0?=
 =?us-ascii?Q?iRD1czagaSC/fct+/V0ClJzbkXhOfbyELjUjVUvYBV821jSbR3M4S29JGrH/?=
 =?us-ascii?Q?HrIJyplYgZocDowjKplYhnyRjr7R936RQB17lYU+e51AnInDqcXqs8BOGtv+?=
 =?us-ascii?Q?ophXlyOPz80kyOfgD++4waSUwaVrSWmmMRpc4iIzMaLgPp+oaFOj554h+TJD?=
 =?us-ascii?Q?XPobphhLoQkgHa+f4hRQIDo01K+W1uqdtJ3kxMWlG+JtVCuyMBooV6CpcWD5?=
 =?us-ascii?Q?kXRqmyU2cs5T0M0PAWUSsdB/IRDLpHlkQXT2IF2PYuqJWaMaR31kWTyxvaIF?=
 =?us-ascii?Q?2zh6E2eE4kKZN3XRVf3jkGo7kGWXvqTEGFACRmowRfg4C6ET57x9J0+/9w7H?=
 =?us-ascii?Q?ptp88Cl9g1HzV3WRTFbn10UdWxGlAnn1Ei0D1hI97MU=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea75dae0-6e3d-49b4-6baf-08d8bea05c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 06:38:42.7644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lIQEO12fQp4NzBnHr7ulMwsTRYmdgXqkc9UqVOvJv60s58VidhQtCLSWw/exlmrjPh4ZAOQVxwZjKJDbJ2IIUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2077
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
> Sent: Thursday, January 21, 2021 9:45 AM
> 
> So that the uses could get chances to know what happened.
> 
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 033b25886e57..f49fe715477b 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -895,6 +895,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  	struct intel_iommu *iommu = d;
>  	struct intel_svm *svm = NULL;
>  	int head, tail, handled = 0;
> +	struct page_req_dsc *req;
> 
>  	/* Clear PPR bit before reading head/tail registers, to
>  	 * ensure that we get a new interrupt if needed. */
> @@ -904,7 +905,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  	head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
> PRQ_RING_MASK;
>  	while (head != tail) {
>  		struct vm_area_struct *vma;
> -		struct page_req_dsc *req;
>  		struct qi_desc resp;
>  		int result;
>  		vm_fault_t ret;
> @@ -1042,8 +1042,14 @@ static irqreturn_t prq_event_thread(int irq, void
> *d)
>  	 * Clear the page request overflow bit and wake up all threads that
>  	 * are waiting for the completion of this handling.
>  	 */
> -	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO)
> +	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
> +		head = dmar_readq(iommu->reg + DMAR_PQH_REG) &
> PRQ_RING_MASK;
> +		req = &iommu->prq[head / sizeof(*req)];
> +		pr_warn_ratelimited("IOMMU: %s: Page request overflow:
> HEAD: %08llx %08llx",
> +				    iommu->name, ((unsigned long long
> *)req)[0],
> +				    ((unsigned long long *)req)[1]);
>  		writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
> +	}
> 

Not about rate limiting but I think we may have a problem in above
logic. It is incorrect to always clear PRO when it's set w/o first checking
whether the overflow condition has been cleared. This code assumes
that if an overflow condition occurs it must have been cleared by earlier
loop when hitting this check. However since this code runs in a threaded 
context, the overflow condition could occur even after you reset the head 
to the tail (under some extreme condition). To be sane I think we'd better
read both head/tail again after seeing a pending PRO here and only clear 
PRO when it becomes a false indicator based on latest head/tail.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
