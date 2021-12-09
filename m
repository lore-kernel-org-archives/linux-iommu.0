Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27523C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 17:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCC35403D4;
	Thu,  9 Dec 2021 17:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ayJQ1uPqa2i; Thu,  9 Dec 2021 17:04:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 915FD42256;
	Thu,  9 Dec 2021 17:04:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A11EC002F;
	Thu,  9 Dec 2021 17:04:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0114FC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF82F612B9
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gA2zfSEpgcKs for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 17:04:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B1B26126D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639069476; x=1670605476;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Hu8IWPpqaYWvoYRfgiAlV+K8HC4bEA3MgGocGhWIN5c=;
 b=nSA7TCyQqR5quE9kblaAQO1/XfCEGMvnbQjyICVknZYmBtkz9qni190T
 O+qY8jeIlq6hpkf5NJyAJ28qmhQBrC0jg6yCAdN1b4nbpceLGFzRt+mjv
 s9FMo8zgTwnUY+HfJzDlQGOyctlkMnWztmdRO10oaXWZPS1xFt9lSKN+H
 eQYrL3Ot1AeYC1vzkiEyBB9azIlYblHeBSlBY3seb52BnVqQ8FO1uV9R7
 JCZSw+3mT2DFgvrL6Xwooe4gmd0qt2509apQRp87B5LldY0cTDHya9nJ9
 20+SB1G9BmtDtBqzXxQcMffF1l2TfpY64O9bwdVUB7jVkvbJdRsLYS7E4 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="324414979"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; d="scan'208";a="324414979"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 09:01:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; d="scan'208";a="503566698"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.123])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 09:01:32 -0800
Date: Thu, 9 Dec 2021 08:57:15 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 2/4] iommu: Add PASID support for DMA mapping API users
Message-ID: <20211209165715.GA566788@otc-nc-03>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <16408193-c8bc-3046-b32f-9274bf0b415c@linux.intel.com>
 <20211208104939.732fa5b9@jacob-builder>
 <BN9PR11MB5276676474FA6A35016B6BB88C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1b3ee13d-0148-1156-52ad-b96bca51cb6f@linux.intel.com>
 <20211209083249.7d775512@jacob-builder>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211209083249.7d775512@jacob-builder>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

On Thu, Dec 09, 2021 at 08:32:49AM -0800, Jacob Pan wrote:
> Hi Lu,
> 
> On Thu, 9 Dec 2021 10:21:38 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> wrote:
> 
> > On 12/9/21 9:56 AM, Tian, Kevin wrote:
> > >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > >> Sent: Thursday, December 9, 2021 2:50 AM
> > >>  
> > >>> Can a device issue DMA requests with PASID even there's no system  
> > >> IOMMU  
> > >>> or the system IOMMU is disabled?
> > >>>  
> > >> Good point.
> > >> If IOMMU is not enabled, device cannot issue DMA requests with PASID.
> > >> This API will not be available. Forgot to add dummy functions to the
> > >> header. 
> > > 
> > > PASID is a PCI thing, not defined by IOMMU.

True, but RP is just a forwarding agent on these EETLP prefixes. I'm not
sure how RP's will behave if they receive a TLP they don't understand
and I suspect they might pull the system down via some UR type response
when IOMMU isn't enabled.

> > > 
> > > I think the key is physically if IOMMU is disabled, how will root
> > > complex handle a PCI memory request including a PASID TLP prefix? Does
> > > it block such request due to no IOMMU to consume PASID or simply ignore
> > > PASID and continue routing the request to the memory controller?
> > > 
> > > If block, then having an iommu interface makes sense.
> > > 
> > > If ignore, possibly a DMA API call makes more sense instead, implying
> > > that this extension can be used even when iommu is disabled.
> > > 
> > > I think that is what Baolu wants to point out.  
> > 
> Thanks for clarifying, very good point.
> Looking at the PCIe spec. I don't see specific rules for RC to ignore or
> block PASID TLP if not enabled.
> "- A Root Complex that supports PASID TLP Prefixes must have a device
> specific mechanism for enabling them. By default usage of PASID TLP
> Prefixes is disabled
>  - Root Complexes may optionally support TLPs with PASID TLP Prefixes. The
> mechanism used to detect whether a Root Complex supports the PASID TLP
> Prefix is implementation specific

Isn't implementation specific mechanism is IOMMU?

> "
> For all practical purposes, why would someone sets up PASID for DMA just to
> be ignored? An IOMMU interface makes sense to me.
> 
> > Yes, exactly. Imagining in the VM guest environment, do we require a
> > vIOMMU for this functionality? vIOMMU is not performance friendly if we
> > put aside the security considerations.
> > 
> The primary use case for accelerators to use in-kernel DMA will be in
> pass-through mode. vIOMMU should be able to do PT with good performance,
> right? no nesting, IO page faults.

But from an enabling perspective when PASID is in use we have to mandate
either the presence of an IOMMU, or some hypercall that will do the
required plumbing for PASID isn't it? 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
