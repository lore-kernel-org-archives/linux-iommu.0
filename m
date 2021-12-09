Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71787C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 17:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 02CF94213D;
	Thu,  9 Dec 2021 17:30:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sSg3Itg2Nx58; Thu,  9 Dec 2021 17:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6BD1C42139;
	Thu,  9 Dec 2021 17:30:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 356DBC001E;
	Thu,  9 Dec 2021 17:30:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF9BEC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA61C61C83
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:30:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23l5Z_OiGNiQ for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 17:30:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D98E361C82
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:30:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="324423815"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; d="scan'208";a="324423815"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 09:30:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; d="scan'208";a="680417004"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 09:29:59 -0800
Date: Thu, 9 Dec 2021 09:34:17 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH 2/4] iommu: Add PASID support for DMA mapping API users
Message-ID: <20211209093417.58767913@jacob-builder>
In-Reply-To: <20211209165715.GA566788@otc-nc-03>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <16408193-c8bc-3046-b32f-9274bf0b415c@linux.intel.com>
 <20211208104939.732fa5b9@jacob-builder>
 <BN9PR11MB5276676474FA6A35016B6BB88C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1b3ee13d-0148-1156-52ad-b96bca51cb6f@linux.intel.com>
 <20211209083249.7d775512@jacob-builder>
 <20211209165715.GA566788@otc-nc-03>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>,
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

Hi Ashok,

On Thu, 9 Dec 2021 08:57:15 -0800, "Raj, Ashok" <ashok.raj@intel.com> wrote:

> > Prefixes is disabled
> >  - Root Complexes may optionally support TLPs with PASID TLP Prefixes.
> > The mechanism used to detect whether a Root Complex supports the PASID
> > TLP Prefix is implementation specific  
> 
> Isn't implementation specific mechanism is IOMMU?
> 
I agree. In case of VT-d it would be in ecap.pasid bit.
> > "
> > For all practical purposes, why would someone sets up PASID for DMA
> > just to be ignored? An IOMMU interface makes sense to me.
> >   
> > > Yes, exactly. Imagining in the VM guest environment, do we require a
> > > vIOMMU for this functionality? vIOMMU is not performance friendly if
> > > we put aside the security considerations.
> > >   
> > The primary use case for accelerators to use in-kernel DMA will be in
> > pass-through mode. vIOMMU should be able to do PT with good performance,
> > right? no nesting, IO page faults.  
> 
> But from an enabling perspective when PASID is in use we have to mandate
> either the presence of an IOMMU, or some hypercall that will do the
> required plumbing for PASID isn't it? 
So the point is that we need either vIOMMU or virtio IOMMU to use PASID?
For the purpose of this discussion to decide whether iommu API or DMA API
should be used, I am still convinced it should be iommu API.

Unlike IOMMU on/off for DMA API (which is transparent to the driver), using
PASID is not transparent. Other than enabling the PASID, the driver has to
program the PASID explicitly. There is no point of doing this dance knowing
the PASID might be ignored.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
