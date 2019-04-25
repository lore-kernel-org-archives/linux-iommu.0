Return-Path: <SRS0=4mi1=S3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480ABC43219
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 22:59:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7565E206BF
	for <iommu@archiver.kernel.org>; Thu, 25 Apr 2019 22:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7565E206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E001F256F;
	Thu, 25 Apr 2019 22:59:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C142E2568
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 22:59:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9206F786
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Apr 2019 22:59:14 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 15:59:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; d="scan'208";a="294613245"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga004.jf.intel.com with ESMTP; 25 Apr 2019 15:59:13 -0700
Date: Thu, 25 Apr 2019 16:01:56 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
Message-ID: <20190425160156.4f5decaa@jacob-builder>
In-Reply-To: <c847182b-6e5c-5344-a162-29e273a489fb@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
	<143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
	<A2975661238FB949B60364EF0F2C257439E840F5@SHSMSX104.ccr.corp.intel.com>
	<c847182b-6e5c-5344-a162-29e273a489fb@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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
Message-ID: <20190425230156.u_rMdgbhzFClGfmFaDrHbwAx_f6TPZKetn8XYklwv0Q@z>

On Thu, 25 Apr 2019 09:40:31 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Liu,
> 
> On 4/25/19 9:12 AM, Liu, Yi L wrote:
> > Hi Eric,
> >   
> >> From: Auger Eric [mailto:eric.auger@redhat.com]
> >> Sent: Thursday, April 25, 2019 1:28 AM
> >> To: Jacob Pan <jacob.jun.pan@linux.intel.com>;
> >> iommu@lists.linux-foundation.org; Subject: Re: [PATCH v2 09/19]
> >> iommu/vt-d: Enlightened PASID allocation
> >>
> >> Hi Jacob,
> >>
> >> On 4/24/19 1:31 AM, Jacob Pan wrote:  
> >>> From: Lu Baolu <baolu.lu@linux.intel.com>
> >>>
> >>> If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
> >>> IOMMU driver should rely on the emulation software to allocate
> >>> and free PASID IDs.  
> >> Do we make the decision depending on the CM or depending on the
> >> VCCAP_REG?
> >>
> >> VCCAP_REG description says:
> >>
> >> If Set, software must use Virtual Command Register interface to
> >> allocate and free PASIDs.  
> > 
> > The answer is it depends on the ECAP.VCS and then the PASID
> > allocation bit in VCCAP_REG. But VCS bit implies the iommu is a
> > software implementation (vIOMMU) of vt-d architecture. Pls refer to
> > the descriptions of "Virtual Command Support" in vt-d 3.0 spec.
> > 
> > "Hardware implementations of this architecture report a value of 0
> > in this field. Software implementations (emulation) of this
> > architecture may report VCS=1."  
> 
> OK I understand. But strictly speaking a vIOMMU may not implement CM.
> But that's nitpicking ;-)
> 
CAP.CM (caching mode) and ECAP.VCS(virtual command support) are
separate. I think we are mixing the two here since both are sufficient
condition to indicate whether we are running in a guest.
> Thanks
> 
> Eric
> > 
> > Thanks,
> > Yi Liu
> >   

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
