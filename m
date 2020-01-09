Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B8C282DD
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 21:54:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F9B2075D
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 21:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F9B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2528C8841A;
	Thu,  9 Jan 2020 21:54:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gTDW9vYhEs8A; Thu,  9 Jan 2020 21:54:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6DAB188408;
	Thu,  9 Jan 2020 21:54:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49EBDC1796;
	Thu,  9 Jan 2020 21:54:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8A96C0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 21:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9061088408
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 21:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C4D-e7RfJEpY for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 21:54:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E7F0E87E80
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 21:54:00 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jan 2020 13:54:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; d="scan'208";a="236219578"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002.jf.intel.com with ESMTP; 09 Jan 2020 13:54:00 -0800
Date: Thu, 9 Jan 2020 13:59:03 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 06/10] iommu/vt-d: Cache virtual command capability
 register
Message-ID: <20200109135903.74b0220f@jacob-builder>
In-Reply-To: <0f704b87-aad7-c864-91ac-423a05287f21@linux.intel.com>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1576524252-79116-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <0f704b87-aad7-c864-91ac-423a05287f21@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
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

On Wed, 18 Dec 2019 11:25:27 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 12/17/19 3:24 AM, Jacob Pan wrote:
> > Virtual command registers are used in the guest only, to prevent
> > vmexit cost, we cache the capability and store it during
> > initialization.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/dmar.c        | 1 +
> >   include/linux/intel-iommu.h | 4 ++++
> >   2 files changed, 5 insertions(+)
> > 
> > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > index f2f5d75da94a..3f98dd9ad004 100644
> > --- a/drivers/iommu/dmar.c
> > +++ b/drivers/iommu/dmar.c
> > @@ -953,6 +953,7 @@ static int map_iommu(struct intel_iommu *iommu,
> > u64 phys_addr) warn_invalid_dmar(phys_addr, " returns all ones");
> >   		goto unmap;
> >   	}
> > +	iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
> >   
> >   	/* the registers might be more than one page */
> >   	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index ee26989df008..4d25141ec3df
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -189,6 +189,9 @@
> >   #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
> >   #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping
> > Control */ 
> > +/* Virtual command interface capabilities */
> > +#define vccap_pasid(v)		((v & DMA_VCS_PAS)) /* PASID
> > allocation */  
> 
> Has DMA_VCS_PAS ever been defined?
> 
Good catch, it is in the next patch, need to move the #define here.
Thanks!

> Best regards,
> baolu
> 
>  [...]  

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
