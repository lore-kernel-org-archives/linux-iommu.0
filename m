Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0986AC10F03
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 07:12:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F6620685
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 07:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F6620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A562A1A30;
	Thu, 25 Apr 2019 07:12:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9AC191A0C
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 07:12:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4DC7074A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 07:12:05 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 00:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; d="scan'208";a="152203197"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
	by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2019 00:12:04 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
	FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Thu, 25 Apr 2019 00:12:04 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.92]) by
	SHSMSX108.ccr.corp.intel.com ([169.254.8.147]) with mapi id
	14.03.0415.000; Thu, 25 Apr 2019 15:12:02 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	"Alex Williamson" <alex.williamson@redhat.com>, Jean-Philippe Brucker
	<jean-philippe.brucker@arm.com>
Subject: RE: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
Thread-Topic: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
Thread-Index: AQHU+ixO5S5+AaAF5kG+2g9ZvMdrCaZLC6IAgAFX7DA=
Date: Thu, 25 Apr 2019 07:12:02 +0000
Message-ID:
 <A2975661238FB949B60364EF0F2C257439E840F5@SHSMSX104.ccr.corp.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
	<143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
In-Reply-To: <143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2ZkM2E5NjQtMjBlNS00NDBmLThlMzMtMWZlODkxZjUyNDk3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNURNT2gxTlZBZnRtMG91SUZnenJzaTJNNmozRGlleGdBVXlOOE9TT240eXR6TFQxN0xrSnFMaVdDNDgzVTZaMiJ9
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, "Raj,
	Ashok" <ashok.raj@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190425071202.kvaqeEbJyo5o_hhVYTH8hizukgZu6TdHefCnXXQIdLc@z>

Hi Eric,

> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: Thursday, April 25, 2019 1:28 AM
> To: Jacob Pan <jacob.jun.pan@linux.intel.com>; iommu@lists.linux-foundation.org;
> Subject: Re: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
> 
> Hi Jacob,
> 
> On 4/24/19 1:31 AM, Jacob Pan wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> >
> > If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the IOMMU
> > driver should rely on the emulation software to allocate and free
> > PASID IDs.
> Do we make the decision depending on the CM or depending on the VCCAP_REG?
> 
> VCCAP_REG description says:
> 
> If Set, software must use Virtual Command Register interface to allocate and free
> PASIDs.

The answer is it depends on the ECAP.VCS and then the PASID allocation bit in
VCCAP_REG. But VCS bit implies the iommu is a software implementation
(vIOMMU) of vt-d architecture. Pls refer to the descriptions of "Virtual
Command Support" in vt-d 3.0 spec.

"Hardware implementations of this architecture report a value of 0
in this field. Software implementations (emulation) of this
architecture may report VCS=1."

Thanks,
Yi Liu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
