Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EDEC47247
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 06:38:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857C92064A
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 06:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="k1eV09VQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857C92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6137A86AF8;
	Thu,  7 May 2020 06:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vD29zXmkfnJn; Thu,  7 May 2020 06:38:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E270786B93;
	Thu,  7 May 2020 06:38:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE5E5C0859;
	Thu,  7 May 2020 06:38:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DE93C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 06:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7D0C686B93
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 06:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SQ3QcC46qF3a for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 06:38:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E9DB586AF8
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 06:38:44 +0000 (UTC)
IronPort-SDR: EbbZ2eobrTnOhpS2+HBdn8+syH2YGFa7dxb44Vbi06nlgAgXQAE8DuPugU2hvlesjxPPTJO9FI
 mFVmNbKS2Yng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2020 23:38:44 -0700
IronPort-SDR: 5ZWsKnPIuFh1DHm85u+oo1AcsJe/pZZt1SL7bVA97bd8pTBUFt7+djTX2ruHmeuJzIfW7pu51I
 WycSwGVeuBEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; d="scan'208";a="435174009"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga005.jf.intel.com with ESMTP; 06 May 2020 23:38:44 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 23:38:43 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 23:38:43 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.52) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 6 May 2020 23:38:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de05xPA/FK+iIb0NtxJrLuKAqWzH4njWJv5qhoGhYHYkKn1RXNlh8ouhxCEFWDsg6FcE/F7bLusPVKb3qwG3BS/Se4joWLHpSd1q2GxNQi3kWYrg62dSCDRHSNWXswq2eSf03azseIgPJ9M0/IWDzPwrFFRCWEkXzOpcoGyaBYL40OpmPKgotq64oJnuoiOFxEKvgBhWKhMPcR+Dgux137mHd8yYPLvW8rw3dC17oymIDwREZZuyfsSZX4AqOskE5QB1ax9yw2k1fqaH9JBNFz79nb5WdjuY3ctfGf/MBoJMFRpYQthwdXDVnEHCTqwt0aW1YmnfGWbvIZehx1XS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbNu6tNEuPH2+CEFMlXU6SQoMxXtX1ow2JZum3DtkVQ=;
 b=FNGjTh0XL1T0wRzCqXxwIwI+hXFpnK23CSSdhukQjRunWn5PK5yNT+CY42JWfMO6mgSdpBLsjmY9odewgTIVXiymQPJ7+jOIPn9Vk3n9Y3RhPDaBaLemnH+FiiUWmXFo3YsvmqGl7/aW6sKPQtVpP5kgPSOQoQokntZh9B8Pj0FEpOsQjzdknpSsEPR3LUek1+eromIBfu00HSyU9BbLVo/VbNj465TBfLn6Oun30k74M5H6Ijh9/nkU1sQq0RhflE2D07x80QAsQVz6rHGnId5P0kCLFHwtBazZI0cDjzu43UaXRcUWtzF05aNLmipvYEZpDp1rG+wdNZHmO/i/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbNu6tNEuPH2+CEFMlXU6SQoMxXtX1ow2JZum3DtkVQ=;
 b=k1eV09VQi+6NU5m/yFuZaC/JDUTlcmLqI3TRMYGwkuu7m3yLxJzfKcwB3xOMmDapSftas5JN9H3xDJeAhQXpNNkfdWOc/YKsOFRxMe6fADz4bvtnpsgRNHP2pPAp8BBl2Hk9XbQ4UsRIBLjJQhP2gpzDyXKOcEUhS2P3qAuJuf4=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1807.namprd11.prod.outlook.com (2603:10b6:300:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 06:38:42 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be%9]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 06:38:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH v4 0/5] iommu/vt-d: Add page request draining support
Thread-Topic: [PATCH v4 0/5] iommu/vt-d: Add page request draining support
Thread-Index: AQHWJArBQRXqXuxhl02DYZwLTDc54qicK8cA
Date: Thu, 7 May 2020 06:38:42 +0000
Message-ID: <MWHPR11MB16452D6184F192F6B10784EE8CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
In-Reply-To: <20200507005534.3080-1-baolu.lu@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: 59874d9c-ea5f-4a21-6a03-08d7f25148cb
x-ms-traffictypediagnostic: MWHPR11MB1807:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1807DF9A4EA9178ED4852E3C8CA50@MWHPR11MB1807.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIOI7O1wb6h+ja3BYaDPVYi4fp+po7un1qV5t+P8uCVWPoF+SLJ6eQHKJxqpW9bIdDMondSuQjADZblLlnTLynEc58kkPqBaSmrL6FxLYbmjF23939Y/N6m0f3UDHXVdDjMqB7JvjKG9LilNZmZ7BbquKmVtJ1jN2wiNtqV5Tg5lXdMClK801Kic1IqgodA5CPrOX4lG7vxaHsvLrYDqJzxuugaNV+K0RtDSYDeVMR/tjAVgnm3XSmZL27ShKZ6ze8dULTeDSI9yuggrZ3F/pXm0Am6KLNJxlPahi+I1jF16SZDVYOXQ8zoZX5+d5cAsilssq8kpiT3NwqYKbDnufyyNfIGjiQTO5ClwOoe6/XqDKQaKqc2aikI7cEWY0DhusVut5CTJzOtb83glfF6KRInMUpskTvpjiCMj1XupmaHrRNqn4Kfu6FqQe7qtuk1H+abEpdnUKJjdukdsd1R58c/TurdKPNpNeeMNPr36u7MoweYgSGGjnriEbTHr5RjvfYryVpASE2LfUmz8zoa15Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(39860400002)(136003)(366004)(376002)(346002)(33430700001)(478600001)(76116006)(5660300002)(4326008)(110136005)(66556008)(64756008)(66476007)(8936002)(66946007)(66446008)(54906003)(316002)(8676002)(86362001)(26005)(2906002)(186003)(71200400001)(7696005)(6506007)(33656002)(33440700001)(9686003)(55016002)(83280400001)(83320400001)(83300400001)(83290400001)(83310400001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: y12fHcA+Tx9W4cQqKf9ZIKkyLgAOg+mY0+E00YQXkyh3spfxnUQelCOn9TSOXhGnMRQFRm6HorcfMeZSMui03UHb+Sw7NqnN4XluNf82e8G9wVBL8Oqgmth/LYg4lmegattCPPyA9ODe8q3h2F3zUlkXvalHfwfxOzXgIcEW4v0lBDZskg5WyZDKmShbAikTtIYcpXydYBOCr1399QRcxvgw6nuMDOJYNS/ytQ9mRDgMT+dHaMh9iUE1jIiOJic0dNm2/9k2CQEwCvvad96IYj5/WhjgaZOF7F2QfHG+ZNzj6ESSfSgBaaee3focSpb83xVlNQXLsLhk+9p3bbGuosuEG/cMZhEijROToCj5j4M10dElyP/1UUkVdPrEkmjIUPInDIzy8icy+Frly2K8uoPOON0iwqjxjPDazj6yTC/JVoRde7iPSNhLRb6vj+jGoxvNUTODPc/vEyb2t0VUm3h2n+92f5hLRHqGXmijtjFIqgkFxy5nnasL4tLIsznks1X5xJ7wTHrVUgP2R/pL1q4WuWi5221zDs/i/Ooi2yq9+l8Rsf8ceVERy8hjcQ4a4Bmxv35lTkeyRIIBIB87PqVSTvSmWDeKf9s+DjoqCIRwcfnPqT71nr66X1rNy4tIMf/qOyhLCV5BUfw/74/5kyLYMuFPtruLqS8ex2+R6yb7fEN0Lqc6MY6IOXlwLwVpKNvXSZLBWrdPGFpDf0CSlboxUdlCRfH6sbABZRsB8FOnZf4jiYigkd9VXHQRfDfSvfpSFN7Ii39kBdayFmKLcH+27ACnbyMddAVIKjb7OOE=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59874d9c-ea5f-4a21-6a03-08d7f25148cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 06:38:42.2158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjWP32XZdgGn/ZVye0uaPmwUbt48eZGWpFMfbrXF5kHQkXtB4MXyYn/CVbYejHQRhetdzheWS9wM2YIHZogsaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1807
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
> Sent: Thursday, May 7, 2020 8:55 AM
> 
> When a PASID is stopped or terminated, there can be pending PRQs
> (requests that haven't received responses) in the software and
> remapping hardware. The pending page requests must be drained
> so that the pasid could be reused. The chapter 7.10 in the VT-d
> specification specifies the software steps to drain pending page
> requests and responses.
> 
> This includes two parts:
>  - PATCH 1/4 ~ 2/4: refactor the qi_submit_sync() to support multiple
>    descriptors per submission which will be used in the following
>    patch.
>  - PATCH 3/4 ~ 4/4: add page request drain support after a pasid entry
>    is torn down.
> 

I think you should mention that this series depends on Jacob's nested
SVA series.

> Best regards,
> baolu
> 
> Change log:
> v3->v4:
>   - Remove prq drain in mm notifier;
>   - Set PASID FPD bit when pasid is cleared in mm notifier and clear
>     it in unbound().
> 
>  v2->v3:
>   - Address Kevin's review comments
>     - Squash the first 2 patches together;
>     - The prq thread is serialized, no need to consider reentrance;
>     - Ensure no new-coming prq before drain prq in queue;
>     - Handle page request overflow case.
> 
>  v1->v2:
>   - Fix race between multiple prq handling threads.
> 
> Lu Baolu (5):
>   iommu/vt-d: Multiple descriptors per qi_submit_sync()
>   iommu/vt-d: debugfs: Add support to show inv queue internals
>   iommu/vt-d: Disable non-recoverable fault processing before unbind
>   iommu/vt-d: Add page request draining support
>   iommu/vt-d: Remove redundant IOTLB flush
> 
>  drivers/iommu/dmar.c                |  63 ++++++++------
>  drivers/iommu/intel-iommu-debugfs.c |  62 ++++++++++++++
>  drivers/iommu/intel-iommu.c         |   4 +-
>  drivers/iommu/intel-pasid.c         |  30 +++++--
>  drivers/iommu/intel-pasid.h         |   3 +-
>  drivers/iommu/intel-svm.c           | 123 ++++++++++++++++++++++++----
>  drivers/iommu/intel_irq_remapping.c |   2 +-
>  include/linux/intel-iommu.h         |  13 ++-
>  8 files changed, 247 insertions(+), 53 deletions(-)
> 
> --
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
