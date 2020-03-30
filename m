Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF3FC2D0EB
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 05:40:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A1920780
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 05:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A1920780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD8DA877A6;
	Mon, 30 Mar 2020 05:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80s2npJ6o4BX; Mon, 30 Mar 2020 05:40:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 07E9A876B8;
	Mon, 30 Mar 2020 05:40:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFF76C089E;
	Mon, 30 Mar 2020 05:40:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7CFBC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 05:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AC55287799
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 05:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rrB-YJ7j94OC for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 05:40:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C4F53876B8
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 05:40:44 +0000 (UTC)
IronPort-SDR: OvvlnXffpDN7fzsI+bpZI1a998sF0DbUWpg8gpyBzMapq99dQXq18DIZgcxU5UTRcS1zTGuNRt
 17BFOk4hYWUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 22:40:43 -0700
IronPort-SDR: KDuq/8rh8ShxvxI24X4QrSsJUHtOH6r8q3F8rh85Sj1ZDizd/xQbpfH5hM0QN48/GbglFrTCva
 vYa2p3RKQvXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,323,1580803200"; d="scan'208";a="239668276"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2020 22:40:43 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 29 Mar 2020 22:40:42 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0439.000;
 Mon, 30 Mar 2020 13:40:41 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Christoph Hellwig
 <hch@infradead.org>
Subject: RE: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Topic: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Index: AQHWAvq+z2SPyfblHkGvV1oKjQsO9ahaFEoAgAB7VgCAAS14gP//zqQAgAEODYCABAXlIA==
Date: Mon, 30 Mar 2020 05:40:40 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200326092316.GA31648@infradead.org>
 <20200326094442.5be042ce@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
 <20200327074702.GA27959@infradead.org>
 <20200327165335.397f24a3@jacob-builder>
In-Reply-To: <20200327165335.397f24a3@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>
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
> Sent: Saturday, March 28, 2020 7:54 AM
> 
> On Fri, 27 Mar 2020 00:47:02 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Fri, Mar 27, 2020 at 02:49:55AM +0000, Tian, Kevin wrote:
> > > If those API calls are inter-dependent for composing a feature
> > > (e.g. SVA), shouldn't we need a way to check them together before
> > > exposing the feature to the guest, e.g. through a
> > > iommu_get_uapi_capabilities interface?
> >
> > Yes, that makes sense.  The important bit is to have a capability
> > flags and not version numbers.
> 
> The challenge is that there are two consumers in the kernel for this.
> 1. VFIO only look for compatibility, and size of each data struct such
> that it can copy_from_user.
> 
> 2. IOMMU driver, the "real consumer" of the content.
> 
> For 2, I agree and we do plan to use the capability flags to check
> content and maintain backward compatibility etc.
> 
> For VFIO, it is difficult to do size look up based on capability flags.
> 

Can you elaborate the difficulty in VFIO? if, as Christoph Hellwig
pointed out, version number is already avoided everywhere, it is 
interesting to know whether this work becomes a real exception
or just requires a different mindset.

btw the most relevant discussion which I can find out now is here:
	https://lkml.org/lkml/2020/2/3/1126

It mentioned 3 options for handling extension:
--
1. Disallow adding new members to each structure other than reuse
padding bits or adding union members at the end.
2. Allow extension of the structures beyond union, but union size has
to be fixed with reserved spaces
3. Adopt VFIO argsz scheme, I don't think we need version for each
struct anymore. argsz implies the version that user is using assuming
UAPI data is extension only.
--

the first two are both version-based. Looks most guys agreed with 
option-1 (in this v2), but Alex didn't give his opinion at the moment. 
The last response from him was the raise of option-3 using argsz to 
avoid version. So, we also need hear from him. Alex?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
