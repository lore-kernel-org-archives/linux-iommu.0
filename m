Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1421C433FE
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 20:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F8F441A56;
	Fri, 15 Apr 2022 20:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZXWzG-z6ul5j; Fri, 15 Apr 2022 20:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F3E0419F2;
	Fri, 15 Apr 2022 20:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3DF9C002F;
	Fri, 15 Apr 2022 20:56:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D5CDC002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 20:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0930841C3
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 20:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K-OVyFMNWYqd for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 20:56:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37618841C1
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650056191; x=1681592191;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TEr+410Cz7xxJFaUMGK2Bokxa0fZlL+QKprnPgzdbCg=;
 b=duJ40oIW24bvVUJtQtIDn6ZhPDvt1LMQvhVZgZWonGNXz22aV4envZ4A
 Lkb0kfdcpY8H6kP9saQMA7w8LGr7ZJnwyrNhIh4YsNTB8MSTm+3FesEeC
 FC6dFebExAeOW4mPdm6ccApjnyQ5NIZ56LsPjcqWCXVBUZThGvx6SpA7y
 Nbeh7zePYSxD++LeWTipHryYflSUKx//AKnABCPFdBbSSG+6qBBqhF59n
 SFaHWyBztfAJsxoVo2pfN2aIdkIeZ41LAcMVFors3nk5kHe9r8wGNgYBS
 v3bjRwnryLKNIutzZcwcM4hGv2LSdWgybABchm48stU0CeLZT8mhIF77K Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262689078"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; d="scan'208";a="262689078"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 13:56:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; d="scan'208";a="528061240"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 13:56:29 -0700
Date: Fri, 15 Apr 2022 14:00:02 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220415140002.7c12b0d2@jacob-builder>
In-Reply-To: <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 jean-philippe <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
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

Hi zhangfei.gao@foxmail.com,

On Fri, 15 Apr 2022 19:52:03 +0800, "zhangfei.gao@foxmail.com"
<zhangfei.gao@foxmail.com> wrote:

> >>> A PASID might be still used even though it is freed on mm exit.
> >>>
> >>> process A:
> >>> 	sva_bind();
> >>> 	ioasid_alloc() = N; // Get PASID N for the mm
> >>> 	fork(): // spawn process B
> >>> 	exit();
> >>> 	ioasid_free(N);
> >>>
> >>> process B:
> >>> 	device uses PASID N -> failure
> >>> 	sva_unbind();
> >>>
> >>> Dave Hansen suggests to take a refcount on the mm whenever binding the
> >>> PASID to a device and drop the refcount on unbinding. The mm won't be
> >>> dropped if the PASID is still bound to it.
> >>>
> >>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
> >>> allocation and free it on mm exit")
> >>>
Is process A's mm intended to be used by process B? Or you really should
use PASID N on process B's mm? If the latter, it may work for a while until
B changes mapping.

It seems you are just extending the life of a defunct mm?

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
