Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32307C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 11:20:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57DA613F1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 11:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57DA613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0FC8400EB;
	Thu,  3 Jun 2021 11:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id plosz-J56xMk; Thu,  3 Jun 2021 11:20:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99A84400E7;
	Thu,  3 Jun 2021 11:20:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A4F0C000E;
	Thu,  3 Jun 2021 11:20:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 542FBC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39B7F400EB
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:20:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oi5Y4DI-zaGx for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 11:20:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C0A8A400E7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:20:30 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77519613E6;
 Thu,  3 Jun 2021 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622719230;
 bh=yvu1ioWFgeXoiNI15+SCoMtyfAMfsZdkNLqkvbW5ChA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kuUpuVw6pZ0+xCWatONfbiD7PZPYm3CYPslvjBhz43wurBSp8e/Lf/cepm9y9RA6j
 SpU7YOwwjb6x0MbNkWXmUiv5Vz0O+A4iSJ9Z64Kk+vU2ws5lda5ih7wn2WGdIYDaQl
 lg4xvtwu9Rps0VVIJk6B2Wb0BoB4H9O+dtg1uCZkqCqEQaT3V/2v/O7znsM8iXuT2W
 53UM+etyclo69iNcWVx1U/V8ZjuS9Fg6c4mtjrT+5MWmPdevIHvqUGXsYxlwP+pd5I
 DDMjDH8C18ecxj8lpm1JP4sBrgkoHaDy0hXVBQFRKIL9cbWzUx6xQPAGnT+2U7uQii
 zWOzBxa1vF9Wg==
Date: Thu, 3 Jun 2021 16:50:26 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Message-ID: <YLi6+vICUmu07b0E@vkoul-mobl>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLdZ7bZDPNup1n9c@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLdZ7bZDPNup1n9c@zn.tnic>
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

On 02-06-21, 12:14, Borislav Petkov wrote:
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 2 Jun 2021 12:07:52 +0200
> Subject: [PATCH] dmaengine: idxd: Use cpu_feature_enabled()
> 
> When testing x86 feature bits, use cpu_feature_enabled() so that
> build-disabled features can remain off, regardless of what CPUID says.

Applied, thanks

-- 
~Vinod
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
