Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3967DC433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 22:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC66A6114A;
	Mon, 16 May 2022 22:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9CTCnwSmVXkD; Mon, 16 May 2022 22:54:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B565A60EB2;
	Mon, 16 May 2022 22:54:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 863D5C0032;
	Mon, 16 May 2022 22:54:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97970C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 22:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7655C4052E
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 22:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MGz9Izx3QVO0 for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 22:54:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98AE04010C
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 22:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652741677; x=1684277677;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mA98VrZe/rix7Ydo+Yw58bcGuuP+5pWFws31EDCu4pc=;
 b=GJ2HmiRTfHt0GFd+PBAJpe00m29jlzfTm+RvzPlg12JBkrNFLYegQ4Dh
 P9ojGH2GHHGrxPVK1BI3UOVUjKyRAk6LJmhRSPs2g7yCeir2SC+Dxn6R1
 /8KytsGJviOR8xMli4ZAW21TxivtWJJpK8XJOwHrN00lvKOPTA+UlY2zr
 QldY7H5fI576Ra91f5NoUVoBIVvQVGggr4rqJRxT7Ety0oSMfFtb5Po79
 NFGjmOdx1lVUvs/5jeVVvuVagyPOlSb7Y6CWDwwrKDe95AUxGiu0szrA2
 yX9iA95e2mtp62rXvD8CDueVInC7A3RUEqvYLiFkXdpDbx4c3EzrerE/E g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="258548142"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; d="scan'208";a="258548142"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 15:54:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; d="scan'208";a="544585021"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 15:54:33 -0700
Date: Mon, 16 May 2022 15:58:22 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 6/7] x86/boot/tboot: Move tboot_force_iommu() to Intel
 IOMMU
Message-ID: <20220516155822.6130dd03@jacob-builder>
In-Reply-To: <20220516180628.GL1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-7-baolu.lu@linux.intel.com>
 <20220516180628.GL1343366@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Steve Wahl <steve.wahl@hpe.com>, David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Ashok Raj <ashok.raj@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Ning Sun <ning.sun@intel.com>,
 Borislav Petkov <bp@alien8.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>
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

Hi Jason,

On Mon, 16 May 2022 15:06:28 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> Unrelated, but when we are in the special secure IOMMU modes, do we
> force ATS off? Specifically does the IOMMU reject TLPs that are marked
> as translated?
Yes, VT-d context entry has a Device TLB Enable bit, if 0, it means
"Translation Requests (with or without PASID) and Translated Requests
received and processed through this scalable-mode context-entry are
blocked."

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
