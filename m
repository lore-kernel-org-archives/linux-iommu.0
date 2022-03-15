Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D83C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 08:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC79060DF6;
	Tue, 15 Mar 2022 08:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eq6uGOGRy2ZO; Tue, 15 Mar 2022 08:17:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3493C60B79;
	Tue, 15 Mar 2022 08:17:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF821C001A;
	Tue, 15 Mar 2022 08:17:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7E29C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 08:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0C85416A3
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 08:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l1u6SnngTg3x for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:17:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85C154168B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647332226; x=1678868226;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nD3SsjMd8cwh99K4n8qBQB6ucEveEI6iyovsPac1fdg=;
 b=Myr+9Jx5KJdYpyQhDp4vquCjnb67G690eMsB0ksHNltVsh1MC7QiUx46
 xyadidZT+aoA4xX5aCKUi5e2FFz6nf9CV+/7IVSXHs+zypiOFWVrniU5h
 2rizIHZ6BB+GgzwsdQJg2oKMpRduDlhTE4n+bvlBOHkMvdhAM7OIeyk4f
 oQiHMJvg8zv3v6rrgGCAx09smXW2AHp5bGQHaHDMFJ/E60rDwQMPZR2qV
 bFPrBmZkQinqG5UnZu0vXRXWsIaxckwstm163XSVch+lSVi6w94YSRUP5
 wmU0WjcKVnUUHfXvWn4DzKCj+VW+92PqMAAQttFDCZJ1TBoQ0GDDL9klF g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238410360"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="238410360"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 01:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; d="scan'208";a="580431974"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga001.jf.intel.com with ESMTP; 15 Mar 2022 01:17:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 01:17:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 01:17:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 01:17:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 01:17:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krzMv9AlmDGhuKHoRkBXOqIGbU9PB9GkJZK+FglVq6qHOAIOToLmXA0DsMJVZUF1jqoR3EBkiFaPAHEn3sZebQG8mQsk+w80ZVMKgWdL6XitWOVSm6Rd/3Knh4WlXEEEQ99AEDxMxF9uNBR0MBnbZv6u5RC627vIxYXQ3DwwEo+3ExjPwY6ZaUMRoY+ZJ5vOIY4exqh46jr2a95wife9UmZMfhXEiKGsIxaKqrWkbe9iBhRPJ/LfuAm02YnTA91bpSwpLbxfI2ks9Ue/sk8WjRE86mZQJUEEXtFLO8zLbVNGSqpDzDHFWMvxzAS2soDb0N/T7clRPAef21dtv4pJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD3SsjMd8cwh99K4n8qBQB6ucEveEI6iyovsPac1fdg=;
 b=ABH96qhCC+uiU41/miBnXmUkZUOT0YljONMIeW6QIsZKPDi7Mvwb7VjWB3gL4ii2VeMy2iKZflXYQ2Vg2GyXmFcyoUhLMUi+2kszLxySCpXySsbVTITi+SpI/K7iV3Kqu2ufNA4FdRc/Z6rMG/Gtgtm/cRwhjz9TP3jmbW23Tcw5LEwrtLqBzkPcyH9f4z8Qqj+SwM5njDYaax9A0O8zjB+1ziXYOh7/PZRYACUXj0XziSUMA/r2ETKZO/XK36e6PHtkb3QbVvgz9iTy95N0bo4kIAUIjEgPaerUN00W2q5XEkk06E5R8C9CF5SnYbdIEEJrOV3VPIm1KrP4nVv2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB3673.namprd11.prod.outlook.com (2603:10b6:5:145::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 08:17:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c8aa:b5b2:dc34:e893%8]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 08:17:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: RE: [PATCH v2 0/8] Enable PASID for DMA API users
Thread-Topic: [PATCH v2 0/8] Enable PASID for DMA API users
Thread-Index: AQHYOCoZX1e6IOSYG0mi+cTZStvSnazAGQ3g
Date: Tue, 15 Mar 2022 08:16:59 +0000
Message-ID: <BN9PR11MB5276F78A62AD159A73868C268C109@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66282154-8586-4029-788f-08da065c2dc2
x-ms-traffictypediagnostic: DM6PR11MB3673:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <DM6PR11MB3673B2EE7952F1A73A69D2A68C109@DM6PR11MB3673.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: znoz8ME89Hjl17S9Lii2oncjYfs6wSMfmH2behuW9pbFVK64WrDpvmHE+7ter0TTwhSVpks3eKVCxNIJCOohamltJvWqUpfxTan332/f2r75QJAQgJco0HBs8/qnr7stUrQjTEVrtirJ3/f6XROXlprfogu2MVQXMlhNGeSTpZ14GV8FfqIWA3oVGYaTuW5UJDLKNUYoMhh+w9xCwopjzqalmmjFMXe2hmMqPtv6BwAgTue9ea62+V6NGSQB+0rst0sQXMuSkPVPmGzRlULyi8oMFWuwJ7p8bCZVCfXl2E3L2hidC0VGg5UH52QFnlnXTne9JrbktktB3sp93IAmRPJUZIXRIzf/92cR6ygdNzIdkkK4pQRoHTYos9uprdHdQrNM9vOVCikA+0vxYyAyDqZNyfVi/vRfHY1At75L4DlDHzJza9cNJt2qHzfVeAoijlzZvEIVb2PgnVhww0Xu7KiRiTrsXA0yPSbdbM0rGkEFYQVyyDImuLm3AeTPMjqbA5sAZZWv953EaetasgsJSYyAaHyilIE596yXsM2OKxmSMEs2GKEgtxNrzBKmgq8Tc9QV0afIVPgm8ZgBvxCj4puDlNgmDbL6wJmjv/+VoDFjmzkCeU4aTJRO3ZqWkTWyKPbRTIaYmWeZI3a0XPmjcZ+pzkUcPnOfb8TKSgk5zjjuLJylW2x7MxHYtGUR4u7kg+yTAUhvsOAXfXGje0pRipzvqJmhP+Jh19kgtUCtF2sXG9kkdZXC9zytibcC090LikpfLKb2OET8EHiUpPQRMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(52536014)(33656002)(64756008)(508600001)(38100700002)(4744005)(82960400001)(4326008)(8676002)(66946007)(66446008)(66476007)(66556008)(8936002)(122000001)(76116006)(5660300002)(316002)(54906003)(110136005)(2906002)(6506007)(7696005)(9686003)(86362001)(38070700005)(55016003)(71200400001)(186003)(26005)(83380400001)(26730200005)(19860200003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uKto8fw3lnVK+fQcb2cMC1YzBk5H/Jo1OL7sau/w1gIrXap3OK0uny847TPi?=
 =?us-ascii?Q?V+wLYnki8ReXywKo9uTfTCk6bfMnCwRNf/gTafgl34L8hwqfuwXBMtgbDMPV?=
 =?us-ascii?Q?b5oEMjwHJRZvYgGxBvH44wdsfVespshB6V/cLnBH8GP4o2UQ0YZkZQdmLFly?=
 =?us-ascii?Q?B3HfFQBsfhIHbq5wTzhVzyN4WIIQYswuW5wApNRq4PCSbq7OEuMGPyr7gYQW?=
 =?us-ascii?Q?I0BltGrzcSZKMr6SjlYbv+RdzgSX8BwW8VQunmq7AgRKvylpiIxcCQySXHLU?=
 =?us-ascii?Q?SKdT7sX/5jSRVuxgqw9kultl+iHyxAbWecCwA77tTSFiTyQOLT8nXXullhii?=
 =?us-ascii?Q?sFeVK7U+2gwE2gFX3b/ldwzNrwMwvAcfSAL1JCMbDXBDujJhZmsthp2+1ckx?=
 =?us-ascii?Q?hy7KDMfE+WbUqzFC7A1vxxaPwqdVlP7DU6bRxkPkdUtrQp1wA8tM4o7Ub3bx?=
 =?us-ascii?Q?3fZ4i/F2kODpJaaNZhnWYAkQJ3w5BGOC76jgkDTh9PULRTBXoiKSkMvkulLP?=
 =?us-ascii?Q?80LdCj3Sv9snRUm98nYFefXiFKsPaPID6hUy29dRnuIgqQHq8fHgUcloKj/o?=
 =?us-ascii?Q?y0Q/byux6wqrFKMFUhHNcG2lH5aOVsDZBw+CWZR3ipS+4iB6CVmCCQc6nwVh?=
 =?us-ascii?Q?KhM3weAhfx1uGvriVb03BN7WI5tL39Kt9+XFEEEByScI0v4Vm3vwbKyxlbrm?=
 =?us-ascii?Q?+YOkJsWJekJo42tbUzRl3Z0a8PnigchizSguODH4xYfh/hvvoSXAgfC8wDBq?=
 =?us-ascii?Q?A8zxeDw4MRHA5SC8IfhZNOWTRCyoKi9NyhFRknzEa2b2yCDfhsxR3BIG2965?=
 =?us-ascii?Q?vxke6E69CkkY8ESt4uk38vMLUL4MyfOVpuv7J+ycKJq4q6K/TzzNF/X3jLoU?=
 =?us-ascii?Q?XHgKd1ECHTlPX56PNIvsbBsvG5VlQV4jAuBXwD0fF6UEuFJIDblZv2czacOi?=
 =?us-ascii?Q?YWCT/AZ+AsIS4Wgt3Gj1T9dpafW57Ry2fzmrN6/DBddj1Cf0M3N4CZEQf5VD?=
 =?us-ascii?Q?0d/2mjXS/mgY6c/OOMk+zY+7JLRSIqYqKCj7RY7Wme/wvrH9H+vjSqreBaLH?=
 =?us-ascii?Q?gfu11FnzimuZfGgULwpV3TToy0BJ22yTCfJo0wAlLlPw7XS56ELVBIGOBtjz?=
 =?us-ascii?Q?0Rnwt5AFg12Dbqcy/drNCwsBO+2ezbgyLqeu9aXBWnPsfwg6shBLvMRPxPTP?=
 =?us-ascii?Q?Ue6zPCHCpwNw3OdRhhgYHjU3GM4gJMtWbtYxZNX2OaKC2LAV1QZ7eHiQxNhg?=
 =?us-ascii?Q?M2lgyh9GSkFOxcd0/66wXcVjRvhxIGnw0vRq67WB6wtRWngTVC5qX4NvNDCl?=
 =?us-ascii?Q?qKx5Q5TBcFdm3X54oSXf7D5q1IQGKxIjSuEwOEtOuJKUbrl2TwkrA415HREh?=
 =?us-ascii?Q?Er3dIaJkIeQC9/bgqkEaSzVfTx6iCOY1yk0TQQc4VLZ6LpvGvz+qbbxUFbaH?=
 =?us-ascii?Q?AnLjdTy0BfHi7RWo5DtLTFWfVeCs6HTI?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66282154-8586-4029-788f-08da065c2dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 08:16:59.9730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GH4U8ScH95Y4Jea9W3pzXBA3d1oryfpdZwMF6Qmt9HomVajLdA5p2hMBY33mtZexpP219MroZD89N/oiYXpKCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3673
X-OriginatorOrg: intel.com
Cc: "Luck, Tony" <tony.luck@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, March 15, 2022 1:07 PM
> 
> Some modern accelerators such as Intel's Data Streaming Accelerator (DSA)
> require PASID in DMA requests to be operational. Specifically, the work
> submissions with ENQCMD on shared work queues require PASIDs. The use
> cases
> include both user DMA with shared virtual addressing (SVA) and in-kernel
> DMA similar to legacy DMA w/o PASID. Here we address the latter.
> 
> DMA mapping API is the de facto standard for in-kernel DMA. However, it
> operates on a per device or Requester ID(RID) basis which is not
> PASID-aware. To leverage DMA API for devices relies on PASIDs, this
> patchset introduces the following APIs
> 
> 1. A driver facing API that enables DMA API PASID usage:
> iommu_enable_pasid_dma(struct device *dev, ioasid_t &pasid);

Should this be called dma_enable_pasid() since it's about DMA API? Doing
so also avoids the driver to include iommu.h.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
