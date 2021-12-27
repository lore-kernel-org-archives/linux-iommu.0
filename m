Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5186BC433F5
	for <iommu@archiver.kernel.org>; Mon, 27 Dec 2021 17:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9355404BD;
	Mon, 27 Dec 2021 17:52:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vO8eaXl5G1KF; Mon, 27 Dec 2021 17:52:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8861B400E5;
	Mon, 27 Dec 2021 17:52:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FE2DC002F;
	Mon, 27 Dec 2021 17:52:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89762C0012
 for <iommu@lists.linux-foundation.org>; Mon, 27 Dec 2021 17:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7762040922
 for <iommu@lists.linux-foundation.org>; Mon, 27 Dec 2021 17:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2OWQ1oEu1Rp4 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Dec 2021 17:52:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B6AD40197
 for <iommu@lists.linux-foundation.org>; Mon, 27 Dec 2021 17:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640627559; x=1672163559;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uivZtDQsssJoVXCGHwOl0scNNO1XH+LQhL6LBCEbZQ4=;
 b=Ns7u/ZLNoSb4INMdN5O5r9JshF/uXxSK/AF2oJgMo6uTVnxkoKVwqvr7
 Y21CucQygI6DvS1ZOxS6ylXQvL3oubzIEwAV7iOITMTXwhnI4VCeDRWh3
 MNi+JE4VLRn8WiajH1NI849bVhFhWl0f0ZwdRaIFwsBq0RhXR907XG579
 cWMUE8ik8guKtZ+CmVP8dr4vEDvSyN+XOQuokY6nZQcK5WEHDaFDrW0Mw
 G5gwmvSa7DUpcLsPF0WFpkIbx5SY3FOCwHt6FvYcB9uJ/SQvs98BLqMzh
 5UetD7SwGEqqMxEC8VV6rrGyuzi0OtHjrUbHPCxL3R5Y0lQSLy1lHEUjU w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="241201025"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; d="scan'208";a="241201025"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Dec 2021 09:52:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; d="scan'208";a="615408490"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Dec 2021 09:52:38 -0800
Date: Mon, 27 Dec 2021 09:52:36 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v2 00/11] Re-enable ENQCMD and PASID MSR
Message-ID: <Ycn9ZKgCjRWK9JC5@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
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

Hi, Dear Maintainers,

On Fri, Dec 17, 2021 at 10:01:25PM +0000, Fenghua Yu wrote:
> Problems in the old code to manage SVM (Shared Virtual Memory) devices
> and the PASID (Process Address Space ID) led to that code being
> disabled.
> 
> Subsequent discussions resulted in a far simpler approach:
> 
> 1) PASID life cycle is from first allocation by a process until that
>    process exits.
> 2) All tasks begin with PASID disabled
> 3) The #GP fault handler tries to fix faulting ENQCMD instructions very
>    early (thus avoiding complexities of the XSAVE infrastructure)

Any comments on this series?

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
