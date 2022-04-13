Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EEEC433EF
	for <iommu@archiver.kernel.org>; Wed, 13 Apr 2022 05:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64F6782C2E;
	Wed, 13 Apr 2022 05:46:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ajUnjBpxi1Ft; Wed, 13 Apr 2022 05:46:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D32182ACD;
	Wed, 13 Apr 2022 05:46:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37175C002F;
	Wed, 13 Apr 2022 05:46:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00267C002C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 05:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC6F082C18
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 05:46:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id As8stYFR5Gxi for <iommu@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 05:46:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5901782ACD
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 05:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649828773; x=1681364773;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IrNsHOC0jQhqTNGVvI4WqlFCg4JXfzht0G6G+u7v/NM=;
 b=cMx0dTcgULv/NaG16mAMWwM3jAtlSifluRvE8MD6kR6HPC/M8QZwJTQ4
 YmW8COqPemgBVOx2e8BrmxkFqYsgJtGuwuAfnyblSyCgVrIRZenv1V01W
 G9FrHbEpHGK+hjmmNWq39nXJQ76XmhnHh3f4t6n03L4/UJan10tlU+MRX
 eZ2uUtQuirJaAfzjy4m4aBrGmIxh4PWr6uMKCKexDcmJEQl/8tCt4mTxO
 sSVeK72SRY+PA1SjjPyGSgWkXp2BgmWqG3gH+yEmBy2r4cpcCiPhGr5W/
 BA7RWYP0LaOrqlHBI6drFTALqgEhuUM/MHmRIHfBwF/XB+zpTeQi1LJsU Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262023272"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; d="scan'208";a="262023272"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 22:46:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; d="scan'208";a="552060313"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.23])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 22:46:10 -0700
Date: Wed, 13 Apr 2022 13:46:06 +0800
From: Chao Gao <chao.gao@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Message-ID: <20220413054600.GA23023@gao-cwp>
References: <20220412113805.3210-1-chao.gao@intel.com>
 <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com>
 <20220413010157.GA10502@gao-cwp> <20220413045958.GA31209@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220413045958.GA31209@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Kevin Tian <kevin.tian@intel.com>,
 Wang Zhaoyang1 <zhaoyang1.wang@intel.com>, linux-kernel@vger.kernel.org,
 Gao Liang <liang.gao@intel.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, Apr 13, 2022 at 06:59:58AM +0200, Christoph Hellwig wrote:
>So for now I'd be happy with the one liner presented here, but
>eventually the whole area could use an overhaul.

Thanks. Do you want me to post a new version with the Fixes tag or you
will take care of it?

Fixes: 55897af63091 ("dma-direct: merge swiotlb_dma_ops into the dma_direct code")
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
