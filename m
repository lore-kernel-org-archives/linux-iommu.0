Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AC3C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 11:42:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29B1613E6
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 11:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29B1613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80C8A83E35;
	Thu,  3 Jun 2021 11:42:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id euVnmmbpxGYE; Thu,  3 Jun 2021 11:42:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7337E83E29;
	Thu,  3 Jun 2021 11:42:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CB35C000E;
	Thu,  3 Jun 2021 11:42:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 346D0C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B76183E33
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id as1Z0-1Inl35 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 11:42:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9852D83E29
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:42:46 +0000 (UTC)
Received: from zn.tnic (p200300ec2f138500cdba27e87082b0ea.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f13:8500:cdba:27e8:7082:b0ea])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 150541EC0523;
 Thu,  3 Jun 2021 13:42:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1622720563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=kHR69sSnlQU4XT3ZHfXIo1egrOHDxOfisxy4DiTmTKs=;
 b=kxTskGjoKduUe9Ji81kD1Z5sBuTuPnicMYhK3yQJ0UXYvJ/lQ/oc4VEEcDmMfLXmdJjaWF
 teI8hWz63WIbrXIAQzoIDmoF90c5/fxWASmN5YqLktqoXry4oF2BSDlEryi6efXNbVkWPH
 yfNpQ3QVGrQvZPApZmp4Zd75MjNABjQ=
Date: Thu, 3 Jun 2021 13:42:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and
 remove update_pasid()
Message-ID: <YLjALi9hoxv2kubX@zn.tnic>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-10-git-send-email-fenghua.yu@intel.com>
 <87mtsd6gr9.ffs@nanos.tec.linutronix.de> <YLdZ7bZDPNup1n9c@zn.tnic>
 <YLi6+vICUmu07b0E@vkoul-mobl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLi6+vICUmu07b0E@vkoul-mobl>
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

On Thu, Jun 03, 2021 at 04:50:26PM +0530, Vinod Koul wrote:
> Applied, thanks

Actually, I'd prefer if I take it through the tip tree:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/urgent

because it is needed for the following patch by tglx:

6867ee8bcb75 x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove update_pasid()
db099bafbf5e dmaengine: idxd: Use cpu_feature_enabled()

if you don't mind.

I'll be sending this to Linus this weekend.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
