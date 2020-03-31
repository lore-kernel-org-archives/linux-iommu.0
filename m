Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45297C2D0EE
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 16:03:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16713206CC
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 16:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16713206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E56EE86B9A;
	Tue, 31 Mar 2020 16:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MZ5nbtPgj96B; Tue, 31 Mar 2020 16:03:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A07986B88;
	Tue, 31 Mar 2020 16:03:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44E95C1AE8;
	Tue, 31 Mar 2020 16:03:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A53EC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 16:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 76E3786AE5
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 16:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v9JSklZ47k6H for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 16:03:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BF2368697D
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 16:03:38 +0000 (UTC)
IronPort-SDR: m5ftOqnPKvE4v1U0mFxBqPrUyZzJVAYMNywxgSu7n0pYN9YoXOqvGNVTx3Y9xr6aNFVdBLKxlR
 R2gQJl9TP1yA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 09:02:57 -0700
IronPort-SDR: i3YcuqOb7259MzCg51qQzr7zRWRdSHCZlHRjXjPHkSPzX8Syzb4FVL8NB/MFk0tDCUOYsULuoO
 7MWXEsVJyP5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; d="scan'208";a="272809187"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga004.fm.intel.com with ESMTP; 31 Mar 2020 09:02:56 -0700
Date: Tue, 31 Mar 2020 09:08:43 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH] iommu/vt-d: Fix PASID cache flush
Message-ID: <20200331090843.59961e03@jacob-builder>
In-Reply-To: <53be1d27-6348-56db-7eac-6734f92f123d@redhat.com>
References: <1585610725-78316-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <53be1d27-6348-56db-7eac-6734f92f123d@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Raj Ashok <ashok.raj@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

Actually, this is not a bug. The current code has:
#define QI_PC_PASID_SEL             (QI_PC_TYPE | QI_PC_GRAN(1))

Which already has the type and shift.

In my vSVA series, I redefined granu such that I can use them in the 2D
table lookup.

-#define QI_PC_ALL_PASIDS       (QI_PC_TYPE | QI_PC_GRAN(0))        
-#define QI_PC_PASID_SEL                (QI_PC_TYPE | QI_PC_GRAN(1))
+/* PASID cache invalidation granu */                               
+#define QI_PC_ALL_PASIDS       0                                   
+#define QI_PC_PASID_SEL                1                           

Please ignore this, sorry about the confusion.

On Tue, 31 Mar 2020 11:28:17 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 3/31/20 1:25 AM, Jacob Pan wrote:
> > PASID cache type and shift of granularity bits are missing in
> > the current code.
> > 
> > Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table
> > interface")
> > 
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 
> > ---
> >  drivers/iommu/intel-pasid.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 22b30f10b396..57d05b0fbafc
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -365,7 +365,8 @@ pasid_cache_invalidation_with_pasid(struct
> > intel_iommu *iommu, {
> >  	struct qi_desc desc;
> >  
> > -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL |
> > QI_PC_PASID(pasid);
> > +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> > +		   QI_PC_PASID(pasid) | QI_PC_TYPE;
> >  	desc.qw1 = 0;
> >  	desc.qw2 = 0;
> >  	desc.qw3 = 0;
> >   
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
