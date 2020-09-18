Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88341C43463
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 17:09:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228D221534
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 17:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228D221534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CB90F87A75;
	Fri, 18 Sep 2020 17:09:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jWO92SdHTFtH; Fri, 18 Sep 2020 17:09:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3E55B87A29;
	Fri, 18 Sep 2020 17:09:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F912C0888;
	Fri, 18 Sep 2020 17:09:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50A05C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 17:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3CD2887A75
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 17:09:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bUJDI-cUGiig for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 17:09:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 46F7E87A29
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 17:09:15 +0000 (UTC)
IronPort-SDR: s9dUNjLo8DTFTvGoFiFPVr95uc03RYkDO5yC5OvZV5PcFUDFH2pxqkwJtvBY1Nja/U84IokPpP
 Bdo62S47pA5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="157387655"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="157387655"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 10:09:06 -0700
IronPort-SDR: 36xZojZG7hFQ6U+N7qlCL+5QTKGKJmvm3ksrt5N9Dqbfkd434G1c6xHARWB1J9c7oHdayituyf
 9Ut6ZjLCQYtg==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; d="scan'208";a="307938060"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2020 10:09:05 -0700
Date: Fri, 18 Sep 2020 10:11:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v9 3/7] iommu/uapi: Introduce enum type for PASID data
 format
Message-ID: <20200918101108.672c2f5a@jacob-builder>
In-Reply-To: <20200918094450.GP31590@8bytes.org>
References: <1599861476-53416-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1599861476-53416-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200918094450.GP31590@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Yi Sun <yi.y.sun@intel.com>
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

Hi Joerg,

On Fri, 18 Sep 2020 11:44:50 +0200, Joerg Roedel <joro@8bytes.org> wrote:

> On Fri, Sep 11, 2020 at 02:57:52PM -0700, Jacob Pan wrote:
> > There can be multiple vendor-specific PASID data formats used in UAPI
> > structures. This patch adds enum type with a last entry which makes
> > range checking much easier.  
> 
> But it also makes it much easier to screw up the numbers (which are ABI)
> by inserting a new value into the middle. I prefer defines here, or
> alternativly BUILD_BUG_ON() checks for the numbers.
> 
I am not following, the purpose of IOMMU_PASID_FORMAT_LAST *is* for
preparing the future insertion of new value into the middle.
The checking against IOMMU_PASID_FORMAT_LAST is to protect ABI
compatibility by making sure that out of range format are rejected in all
versions of the ABI.
For example, in v5.10, ABI has IOMMU_PASID_FORMAT_LAST = 2, then user data
with format = 2 will be rejected. So this user app will not work or
released.

Now say in v5.11, we add one more format in the middle and set
IOMMU_PASID_FORMAT_LAST = 3. Then user data with the new format = 2 can be supported.

Without the checking for IOMMU_PASID_FORMAT_LAST, at v5.10 time the user
binary may succeed and become legacy binary that we cannot break in v5.11.
This renders format = 2 unusable for v5.11.

I thought enum makes it less susceptible to programming errors than defines
by making sure the ascending order. I might have missed your point, could
you elaborate?

> Regards,
> 
> 	Joerg
> 
> > 
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/uapi/linux/iommu.h | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index b42acc8fe007..7cc6ee6c41f7 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -298,11 +298,16 @@ struct iommu_gpasid_bind_data_vtd {
> >  					 IOMMU_SVA_VTD_GPASID_PCD |  \
> >  					 IOMMU_SVA_VTD_GPASID_PWT)
> >  
> > +enum iommu_pasid_data_format {
> > +	IOMMU_PASID_FORMAT_INTEL_VTD = 1,
> > +	IOMMU_PASID_FORMAT_LAST,
> > +};
> > +
> >  /**
> >   * struct iommu_gpasid_bind_data - Information about device and guest
> > PASID binding
> >   * @argsz:	User filled size of this data
> >   * @version:	Version of this data structure
> > - * @format:	PASID table entry format
> > + * @format:	PASID table entry format of enum
> > iommu_pasid_data_format type
> >   * @flags:	Additional information on guest bind request
> >   * @gpgd:	Guest page directory base of the guest mm to bind
> >   * @hpasid:	Process address space ID used for the guest mm in
> > host IOMMU @@ -321,7 +326,6 @@ struct iommu_gpasid_bind_data {
> >  	__u32 argsz;
> >  #define IOMMU_GPASID_BIND_VERSION_1	1
> >  	__u32 version;
> > -#define IOMMU_PASID_FORMAT_INTEL_VTD	1
> >  	__u32 format;
> >  	__u32 addr_width;
> >  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > -- 
> > 2.7.4  


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
