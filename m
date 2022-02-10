Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2187EC433EF
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 03:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF27782884;
	Thu, 10 Feb 2022 03:13:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AWEzl1jAculS; Thu, 10 Feb 2022 03:13:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AEF1D8274E;
	Thu, 10 Feb 2022 03:13:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EB47C001A;
	Thu, 10 Feb 2022 03:13:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44190C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 03:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23DFB40308
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 03:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2QUlEx6lJUuD for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 03:13:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 825BE4027B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 03:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644462797; x=1675998797;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZcyIvusHwZnfRVfKt2PwWs6i0TMwMkq3rmt+VlQRRGM=;
 b=h3zM5TecLiM1PKMjh/F6EWB2LAoFjoKcUEmnOm1VuuxkcDBTDwizmkVs
 zcdUnBS9d7xig1SXcJ+tVaGpxDY4ogBB3+TrMMwH2Izr98sya21seIxnS
 Sf5ZL8J8BZzh2ncKM2fm8u31Al5PoVXzRQqcOEuvh9lZw+2vZZ52dfW5h
 6lWs8EHlFQms2eZ4nTYe9z+cfXDL3OvnQK/iRvdBdAHrLzZmKSCq9iJ9O
 AAghwDr1YjCAYO0McOpZJoT0d9AVyYGfXNsT9ytU9mirhAkRvw4dddpua
 iFE9AZoi+kGtbqggMZgVhKPlbAjNYTT3Muu9FL1zT7kxxnW76MjJK9t6Y A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="229370299"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="229370299"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 19:13:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="485527252"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 19:13:16 -0800
Date: Wed, 9 Feb 2022 19:16:14 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220209191614.5a3b42d4@jacob-builder>
In-Reply-To: <20220207230254.3342514-6-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy
 Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

Hi Fenghua,

On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com> wrote:

> @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> *dev, struct mm_struct *mm, void }
>  
>  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> -	if (IS_ERR_OR_NULL(sva))
> -		intel_svm_free_pasid(mm);
If bind fails, the PASID has no IOMMU nor CPU context. It should be safe to
free here.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
