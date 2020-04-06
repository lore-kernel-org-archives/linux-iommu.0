Return-Path: <SRS0=BbwH=5W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EB9C2BA1B
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 06:29:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6D620719
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 06:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6D620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0F23F87CD6;
	Mon,  6 Apr 2020 06:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qK7JvPNHGAz5; Mon,  6 Apr 2020 06:29:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7DDBB85205;
	Mon,  6 Apr 2020 06:29:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F96CC089E;
	Mon,  6 Apr 2020 06:29:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CA40C0177
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 06:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 873B987CD6
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 06:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w+b69XYCK-29 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Apr 2020 06:29:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B352A85205
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 06:29:37 +0000 (UTC)
IronPort-SDR: 9hK/IFX+es9EoIA34+pPpd5rNVYwKsnDHOYjc+Ft1vSZ2lthF+e0clC+pFYNakxeaKCHyFrIDL
 Pkz/q0MGAniA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2020 23:29:36 -0700
IronPort-SDR: 7e5L34Y+rt3E7GG9GfybLo7T4EOEtglNQ7+WMHvNTxahyFk7KZ5UFlI+0W46C7I61/CGt+apdu
 m0aSTz8EJbJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; d="scan'208";a="285778220"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2020 23:29:36 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Apr 2020 23:29:36 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Apr 2020 23:29:36 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.138]) with mapi id 14.03.0439.000;
 Mon, 6 Apr 2020 14:29:32 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "jacob.jun.pan@linux.intel.com"
 <jacob.jun.pan@linux.intel.com>, "jean-philippe.brucker@arm.com"
 <jean-philippe.brucker@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, 
 "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [PATCH v10 04/11] vfio/pci: Add VFIO_REGION_TYPE_NESTED region
 type
Thread-Topic: [PATCH v10 04/11] vfio/pci: Add VFIO_REGION_TYPE_NESTED region
 type
Thread-Index: AQHV/tNxynbYpV5vT0iLn8klxfIfp6hkUe3A//995QCAB+uK0A==
Date: Mon, 6 Apr 2020 06:29:32 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A222F4C@SHSMSX104.ccr.corp.intel.com>
References: <20200320161911.27494-1-eric.auger@redhat.com>
 <20200320161911.27494-5-eric.auger@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A21DBDF@SHSMSX104.ccr.corp.intel.com>
 <893039be-265a-8c70-8e48-74122d9857de@redhat.com>
In-Reply-To: <893039be-265a-8c70-8e48-74122d9857de@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>
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

Hi Eric,
> From: Auger Eric <eric.auger@redhat.com>
> Sent: Wednesday, April 1, 2020 9:31 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; eric.auger.pro@gmail.com; iommu@lists.linux-
> Subject: Re: [PATCH v10 04/11] vfio/pci: Add VFIO_REGION_TYPE_NESTED region
> type
> 
> Hi Yi,
> 
> On 4/1/20 3:18 PM, Liu, Yi L wrote:
> > Hi Eric,
> >
> > Just curious about your plan on this patch, I just heard my colleague
> > would like to reference the functions from this patch in his dsa driver work.
> 
> Well I intend to respin until somebody tells me it is completely vain or dead follows.
> Joking aside, feel free to embed it in any series it would be beneficial to, just please
> cc me in case code diverges.

got it. Please also cc me in future version. :-)

Regards,
Yi Liu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
