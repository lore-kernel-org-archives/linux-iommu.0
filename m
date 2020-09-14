Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A30FC43461
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 19:25:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276C2205F4
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gnuP2iOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276C2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1E051203D7;
	Mon, 14 Sep 2020 19:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCN8o9NOy9ZQ; Mon, 14 Sep 2020 19:25:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CDC561FD21;
	Mon, 14 Sep 2020 19:25:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F723C0864;
	Mon, 14 Sep 2020 19:25:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD07DC0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 19:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D82FB861F6
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 19:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c5HDR2ZZNi4c for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 19:25:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7C5A4860F6
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 19:25:22 +0000 (UTC)
Received: from zn.tnic (p200300ec2f09260089ebb5f4b84dd95c.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f09:2600:89eb:b5f4:b84d:d95c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 264B51EC0593;
 Mon, 14 Sep 2020 21:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1600111519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=kR4nOLZKKMG9ABqKtCK+wPeLMHx2mjIWcwysWLS4COs=;
 b=gnuP2iOdu1c/oi+BPLzEjpOg6v7KYFcBSqANMcJp2ekMO+eohvlwHsLKsE+htqnmFsxl/u
 OWY/tas3cbbTiADdrR7SQD8gXcqIWX7J8hu53zR7KFViT+ffxE8gPvGPOdFLOrWfPLYiZB
 16i/tHesK6hVA0UXilB5sPXnR+8Q8Jg=
Date: Mon, 14 Sep 2020 21:25:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v7 9/9] x86/mmu: Allocate/free PASID
Message-ID: <20200914192518.GH680@zn.tnic>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-10-git-send-email-fenghua.yu@intel.com>
 <20200907111843.GC16029@zn.tnic>
 <20200914183715.GA437309@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914183715.GA437309@otcwcpicx6.sc.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Tony Luck <tony.luck@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Jacob Jun Pan <jacob.jun.pan@intel.com>, Andy Lutomirski <luto@kernel.org>,
 H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On Mon, Sep 14, 2020 at 06:37:15PM +0000, Fenghua Yu wrote:
> get_xsave_addr() will not return NULL because xsave->header.xfeatures has
> XFEATURE_MASK_PASID set.

Ah, you're setting it in the line above.

> I will remove the unnecessary check "if (ppasid_state)" to optimize
> the function and add a comment on why the check is unnecessary.

Ok.

> I addressed all of your comments and will send out the updated series soon.
> 
> Thank you very much for your review!

You're welcome and thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
