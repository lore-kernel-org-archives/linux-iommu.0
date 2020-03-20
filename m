Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91070C43332
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 21:30:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612B220777
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 21:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612B220777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 353102549D;
	Fri, 20 Mar 2020 21:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V91vziejPF0e; Fri, 20 Mar 2020 21:30:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 867F1227EC;
	Fri, 20 Mar 2020 21:30:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 743CCC1D85;
	Fri, 20 Mar 2020 21:30:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6947EC07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 21:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 647E287D57
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 21:30:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cbGyk4pcGY+R for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 21:30:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BB01987D6E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 21:30:14 +0000 (UTC)
IronPort-SDR: iLO8MwBA0wKPIbb2Mv6sxHn0bG1VUeCBLB+v/VtEpmFbR1l4vIzzDkyx2RcDj5myE7ve9s0djb
 B2UXud7wxpYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 14:30:14 -0700
IronPort-SDR: 7wo3zcGm4hq6KANZAFHmC5DfE/INzc2Gh0T2bUeWgeTIJgm2mVdDyWIAeS/a6nuBHhqT5wGvv4
 +8bC7NPHAOAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; d="scan'208";a="324984109"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 20 Mar 2020 14:30:13 -0700
Date: Fri, 20 Mar 2020 14:35:55 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V9 02/10] iommu/uapi: Define a mask for bind data
Message-ID: <20200320143555.15bf7c7a@jacob-builder>
In-Reply-To: <c51ba1a1-343d-c458-1529-5f9fb11d13b9@redhat.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1580277713-66934-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <c51ba1a1-343d-c458-1529-5f9fb11d13b9@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Wed, 12 Feb 2020 13:43:43 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 1/29/20 7:01 AM, Jacob Pan wrote:
> > Memory type related guest PASID bind data can be grouped together
> > for one simple check.  
> Those are flags related to memory type.
right, will rephrase.
> > Link:
> > https://lore.kernel.org/linux-iommu/20200109095123.17ed5e6b@jacob-builder/  
> not sure the link is really helpful.
> > 
will delete. the patch is very simple.

> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/uapi/linux/iommu.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 4ad3496e5c43..fcafb6401430 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
> >  	__u32 pat;
> >  	__u32 emt;
> >  };
> > -
> > +#define IOMMU_SVA_VTD_GPASID_EMT_MASK
> > (IOMMU_SVA_VTD_GPASID_CD | \
> > +					 IOMMU_SVA_VTD_GPASID_EMTE
> > | \
> > +					 IOMMU_SVA_VTD_GPASID_PCD
> > |  \
> > +
> > IOMMU_SVA_VTD_GPASID_PWT)  
> Why EMT rather than MT or MTS?
> the spec says:
> Those fields are treated as Reserved(0) for implementations not
> supporting Memory Type (MTS=0 in Extended Capability Register).
> 
MTS makes more sense, will change.
It was from hygiene p.o.v. checking the flag to avoid touching these
fields.

Thanks,

Jacob
> >  /**
> >   * struct iommu_gpasid_bind_data - Information about device and
> > guest PASID binding
> >   * @version:	Version of this data structure
> >   
> 
> Thanks
> 
> Eric
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
