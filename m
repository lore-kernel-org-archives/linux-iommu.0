Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD0BC433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 23:55:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EF720731
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 23:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EF720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B140D88578;
	Thu, 11 Jun 2020 23:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id erRStojBlWcM; Thu, 11 Jun 2020 23:55:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AEB3B885FA;
	Thu, 11 Jun 2020 23:55:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92676C0865;
	Thu, 11 Jun 2020 23:55:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BEA4C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 23:55:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3A6E2874FE
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 23:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P5XHmcP2GMSv for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 23:55:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 93B1A874FB
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 23:55:51 +0000 (UTC)
IronPort-SDR: 05mqeU6Khn7b6aPKrZJay8X0TCH2E3H/h2po4+g5I7fCdVMW85nDEqvTS/SB0Wg9h321gd1X3a
 TrUYF7IgR/dQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 16:55:51 -0700
IronPort-SDR: 4x4zF9SvzKmm9dyWY4ue1fzA7Z0jpOO7A56jcV2UPWtsr3bi7KKjOgihk+gEqKQhpjKD9m+RxM
 GgF6RmS9MIng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; d="scan'208";a="307124319"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2020 16:55:50 -0700
Date: Thu, 11 Jun 2020 17:02:15 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 2/3] iommu/uapi: Add argsz for user filled data
Message-ID: <20200611170215.7005042e@jacob-builder>
In-Reply-To: <20200611104936.5129e99e@x1.home>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1591848735-12447-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200611104936.5129e99e@x1.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
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

On Thu, 11 Jun 2020 10:49:36 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 10 Jun 2020 21:12:14 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > As IOMMU UAPI gets extended, user data size may increase. To support
> > backward compatibiliy, this patch introduces a size field to each
> > UAPI data structures. It is *always* the responsibility for the
> > user to fill in the correct size.  
> 
> Though at the same time, argsz is user provided data which we don't
> trust.  The argsz field allows the user to indicate how much data
> they're providing, it's still the kernel's responsibility to validate
> whether it's correct and sufficient for the requested operation.
> Thanks,
> 
Yes, will add this clarification.

Thanks,

Jacob
> Alex
> 
> > Specific scenarios for user data handling are documented in:
> > Documentation/userspace-api/iommu.rst
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/uapi/linux/iommu.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index e907b7091a46..303f148a5cd7 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -135,6 +135,7 @@ enum iommu_page_response_code {
> >  
> >  /**
> >   * struct iommu_page_response - Generic page response information
> > + * @argsz: User filled size of this data
> >   * @version: API version of this structure
> >   * @flags: encodes whether the corresponding fields are valid
> >   *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
> > @@ -143,6 +144,7 @@ enum iommu_page_response_code {
> >   * @code: response code from &enum iommu_page_response_code
> >   */
> >  struct iommu_page_response {
> > +	__u32	argsz;
> >  #define IOMMU_PAGE_RESP_VERSION_1	1
> >  	__u32	version;
> >  #define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
> > @@ -218,6 +220,7 @@ struct iommu_inv_pasid_info {
> >  /**
> >   * struct iommu_cache_invalidate_info - First level/stage
> > invalidation
> >   *     information
> > + * @argsz: User filled size of this data
> >   * @version: API version of this structure
> >   * @cache: bitfield that allows to select which caches to
> > invalidate
> >   * @granularity: defines the lowest granularity used for the
> > invalidation: @@ -246,6 +249,7 @@ struct iommu_inv_pasid_info {
> >   * must support the used granularity.
> >   */
> >  struct iommu_cache_invalidate_info {
> > +	__u32	argsz;
> >  #define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
> >  	__u32	version;
> >  /* IOMMU paging structure cache */
> > @@ -292,6 +296,7 @@ struct iommu_gpasid_bind_data_vtd {
> >  
> >  /**
> >   * struct iommu_gpasid_bind_data - Information about device and
> > guest PASID binding
> > + * @argsz:	User filled size of this data
> >   * @version:	Version of this data structure
> >   * @format:	PASID table entry format
> >   * @flags:	Additional information on guest bind request
> > @@ -309,6 +314,7 @@ struct iommu_gpasid_bind_data_vtd {
> >   * PASID to host PASID based on this bind data.
> >   */
> >  struct iommu_gpasid_bind_data {
> > +	__u32 argsz;
> >  #define IOMMU_GPASID_BIND_VERSION_1	1
> >  	__u32 version;
> >  #define IOMMU_PASID_FORMAT_INTEL_VTD	1  
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
