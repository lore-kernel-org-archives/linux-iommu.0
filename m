Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5652C433FE
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 15:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4B5CC40AA3;
	Fri, 20 May 2022 15:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id krS1WHdSYm8p; Fri, 20 May 2022 15:15:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3421240A8F;
	Fri, 20 May 2022 15:15:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EABEFC0039;
	Fri, 20 May 2022 15:15:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73C31C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 15:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A35F40A91
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 15:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kpC-kdCTucOF for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:15:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3E5640A8F
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653059710; x=1684595710;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+n6IA7s8ZdVDI7H47AGS442JizFaVM8WMDKQdIxObGU=;
 b=Bq+Z8R3oHXZBvcYLoB+RcXj0ezuflCo4j7PTDW0CAeBANCXukKXbKj2u
 6LKq6T9Y1rQJKCvGhNlsuQckRhSJCbBIbTUXpe0tVqGBRwSQnnaxJNliS
 scnlqjmuNYro/vbxAMZLsNAwewq/5w32SLwY153lHtFNvmfUadXb4xy98
 JO6CAedXWUNXmghGUMx19xJF9XZl8hKPZw8UrdLthtzHKDetp2EpNDttZ
 bIX4Qf0FfkboZ9XgTydmMJ2SQ2zIXP66fKy/nXLf2QYFkr3nxrf0/IE+I
 5ePyJtB1RlwgWtDYheFvMb8MvK64gCRuLaHHos7c62OIjTw0R8GxX0nx8 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270215989"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="270215989"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 08:15:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="899363103"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 08:15:07 -0700
Date: Fri, 20 May 2022 08:18:58 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 2/6] iommu: Add a helper to do PASID lookup from domain
Message-ID: <20220520081858.486602d7@jacob-builder>
In-Reply-To: <YoXoTFeSdnBILj/2@infradead.org>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-3-jacob.jun.pan@linux.intel.com>
 <YoXoTFeSdnBILj/2@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, dmaengine@vger.kernel.org,
 robin.murphy@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Christoph,

On Wed, 18 May 2022 23:48:44 -0700, Christoph Hellwig <hch@infradead.org>
wrote:

> On Wed, May 18, 2022 at 11:21:16AM -0700, Jacob Pan wrote:
> > +ioasid_t iommu_get_pasid_from_domain(struct device *dev, struct
> > iommu_domain *domain)  
> 
> Overly long line here.
will fix,

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
