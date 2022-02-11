Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB58BC433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 22:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A8A083E61;
	Fri, 11 Feb 2022 22:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9EuDDSO-MPAA; Fri, 11 Feb 2022 22:00:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 863B483E51;
	Fri, 11 Feb 2022 22:00:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58E25C0011;
	Fri, 11 Feb 2022 22:00:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC99EC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 22:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD5B460E5A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 22:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 55CgLLoOSmYR for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 22:00:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3AE6C60AC2
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 22:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644616838; x=1676152838;
 h=message-id:date:mime-version:to:cc:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=CITimWb5ieMVL8+eI+RkkxN4zcJlsfWrf99ICqoKahE=;
 b=oGRefXiRXmFSpVNpyFReSuPXvl8TFdHBFiaMr4ariB/TqHOAkazAElU1
 pvkEN1eERZwLU8D3l7W/3s7ywnnoq0DpPPlIEcIscceYhtEnjRUBVM1Ql
 E3HFwrHZRM46kMXRHXhxXdOi20XlJBpdgenKXYbeLvHkRf+XqW3I74WL5
 9x0Y9PsXieu8PQXDLIYgyTsPowzM5zGj41uIGwO6qcJ8ls1SOBJZRH1El
 ygPrBIaivNFMRFTRKjWZ1Fxzhsa1uwlUM7vesYSaxbJ78NQ7urwkjfkz9
 Y6pkamCLNw+lYKQItWxgCwzESudSxlyXqPXwpWerA8+kRz0TYsKlSH+iy g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="233370349"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; d="scan'208";a="233370349"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2022 14:00:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; d="scan'208";a="542257070"
Received: from nsmdimra-mobl.amr.corp.intel.com (HELO [10.209.96.127])
 ([10.209.96.127])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2022 14:00:27 -0800
Message-ID: <79060ea1-8392-58d7-5a27-ff173e830403@intel.com>
Date: Fri, 11 Feb 2022 14:00:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <20220207230254.3342514-6-fenghua.yu@intel.com>
Cc: iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On 2/7/22 15:02, Fenghua Yu wrote:
...
> Get rid of the refcounting mechanisms and replace/rename the interfaces
> to reflect this new approach.
...
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +--
>  drivers/iommu/intel/iommu.c                   |  4 +-
>  drivers/iommu/intel/svm.c                     |  9 -----
>  drivers/iommu/ioasid.c                        | 39 ++-----------------
>  drivers/iommu/iommu-sva-lib.c                 | 39 ++++++-------------
>  drivers/iommu/iommu-sva-lib.h                 |  1 -
>  include/linux/ioasid.h                        | 12 +-----
>  include/linux/sched/mm.h                      | 16 ++++++++
>  kernel/fork.c                                 |  1 +
>  9 files changed, 38 insertions(+), 88 deletions(-)

Given the heavily non-x86 diffstat here, I was hoping to see some acks
from folks that this might affect, especially on the ARM side.

Is everyone OK with this?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
