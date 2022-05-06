Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C9EC433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 07:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95D0983F6E;
	Fri,  6 May 2022 07:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5y7h-qce62h9; Fri,  6 May 2022 07:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 79C04833A8;
	Fri,  6 May 2022 07:27:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D4E7C0032;
	Fri,  6 May 2022 07:27:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 887E6C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 07:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60F2540946
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 07:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="W2dKLfnE";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="T7Hx4WW+"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2NZAVrhmASEe for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 07:27:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3F7040935
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 07:27:13 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1651822030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xakABXFY9Z5z2nqAlfMNh0e6jCaMQ4odsl0rcH2ghzQ=;
 b=W2dKLfnEOSERd1apR9HtgE9ASNwL7y+lAkClkWOgX2Lhp+lylULGJ5BSRl9lZ99M7Qy1BH
 9fU6WotLcCssSQqmVJ+wsQhgM+QwR+LfbwZQXY+GQqEb6x549J6rDVaSXlCQ7ty68cciQJ
 Z1w/l/Cdr6DcXK5BWGo0ScM7f7FM6pypWlNzNqRsPSjm3FTGhMfZJ8mCseDRQuVc0zu1KD
 uUe4tGMIyQeijEkxoVQxh8R7ec3GO3zMdB33AcdkVGcFqpZzKartMbEqeMkUWRELnYCcsS
 u7DueCrDCjtKj3GNC6gcqhJg9disisP5x3AMDUTOyBmqJFpZuAkSUv2jQBEqIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1651822030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xakABXFY9Z5z2nqAlfMNh0e6jCaMQ4odsl0rcH2ghzQ=;
 b=T7Hx4WW++4BYEa5AE2IMsUVWNGTKjEe0DfVfmMlSOrMEthSd3yPV3kP8nvn0ehU1YKtlDG
 EAiOLVB6C2oUrGBA==
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Fenghua Yu
 <fenghua.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Borislav Petkov
 <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Tony Luck
 <tony.luck@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ravi V
 Shankar <ravi.v.shankar@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] iommu/sva: Fix PASID use-after-free issue
In-Reply-To: <da5eafcc-1cb0-07fc-aa0d-0dccb8b8875a@linaro.org>
References: <20220428180041.806809-1-fenghua.yu@intel.com>
 <8f50c673-fe92-3c42-993d-43e65fc7235c@linaro.org>
 <da5eafcc-1cb0-07fc-aa0d-0dccb8b8875a@linaro.org>
Date: Fri, 06 May 2022 09:27:09 +0200
Message-ID: <875ymji0j6.ffs@tglx>
MIME-Version: 1.0
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

On Fri, May 06 2022 at 09:49, Zhangfei Gao wrote:
> Will this be taken for 5.18?

It's queued in tip core/urgent and will go to Linus this week.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
