Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E8C47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:47:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F15613E7
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F15613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82E1460685;
	Thu,  3 Jun 2021 12:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yHK5QiBSCIS7; Thu,  3 Jun 2021 12:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46ED260679;
	Thu,  3 Jun 2021 12:47:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19D94C000D;
	Thu,  3 Jun 2021 12:47:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6402C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4BF0404F5
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G5s0aOIf1Yyy for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 12:47:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D364C4048D
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 12:47:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAE416139A;
 Thu,  3 Jun 2021 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622724427;
 bh=Su72vlEv6szuZvJdTn531CxoIL0BBrwp4O+j1wekIvI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WqP8lNYoU8Jc1bKjVXmNl7TjxqjpU7g3r26V2pgNhoXRfZ+5iA5+P+my9ZnKAvWf8
 FhLl7wxvQAifwtnr/Zo/gkmO4svx2LZrlljcHAvuTAWqY/5cDsuoJGGRkzLb6tlYRM
 lXBTHx8b5zvOXpQcB0ZkYFsfDYyY0OE6feHgoVIkRuMEjnSUerh6R2U0t/I1mqa0uM
 i5dZKGOi94gh8gnYwXu/wsA8dCs51dLHItLfv8QYrWXxOSmfvTYjmCSu2lylHD6MF+
 hCTpT0jMfRNvnaV9p14C6u3kA84QV4yuPCyDSezC9eRViu/zX9HblFrdSG5v8YP8+z
 2dcTq8nH5ARZQ==
Date: Thu, 3 Jun 2021 18:17:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Message-ID: <YLjPSAfBPIfQvmha@vkoul-mobl>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLdZ7bZDPNup1n9c@zn.tnic>
 <YLi6+vICUmu07b0E@vkoul-mobl> <YLjALi9hoxv2kubX@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLjALi9hoxv2kubX@zn.tnic>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, dmaengine@vger.kernel.org,
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

On 03-06-21, 13:42, Borislav Petkov wrote:
> On Thu, Jun 03, 2021 at 04:50:26PM +0530, Vinod Koul wrote:
> > Applied, thanks
> 
> Actually, I'd prefer if I take it through the tip tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/urgent
> 
> because it is needed for the following patch by tglx:
> 
> 6867ee8bcb75 x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove update_pasid()
> db099bafbf5e dmaengine: idxd: Use cpu_feature_enabled()
> 
> if you don't mind.
> 
> I'll be sending this to Linus this weekend.

Okay dropped now..

You can add:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
