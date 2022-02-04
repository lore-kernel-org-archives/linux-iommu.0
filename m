Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2D5C433F5
	for <iommu@archiver.kernel.org>; Fri,  4 Feb 2022 23:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D3B040519;
	Fri,  4 Feb 2022 23:58:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uBDnmFEh2Xd7; Fri,  4 Feb 2022 23:58:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E693040004;
	Fri,  4 Feb 2022 23:58:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5905C0011;
	Fri,  4 Feb 2022 23:58:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09DF6C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 23:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E98A24019C
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 23:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gEmunSzsgesL for <iommu@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 23:58:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3469340004
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 23:58:38 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1644019116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGG+8m9FDJcTBlNTm2rGW7J3KpLFh6WAlzYPrg8D8XA=;
 b=q8awpzQl2BviFbJfR8uRC1lxGHv8i+UynGOYNdEwp/+gcxxeeLfY6elBW7YsE1/R7yTPL6
 wSrUXNNGDh72fA55nM8Pf97lVC4r0fYE+OBS0ETTFA05t/6XwZtOmpVN+dJ+TifDSFEdMW
 q7vYgVLV4luzveN51m1Al50l8PmhmLyCqpnbVfdxNrEZwu+z5Av9pw+JgJet5cRErBfJFF
 n0DLmcWgzHErTNEdkEshcYQdNJRcU42oLo9jCKqzM0N/xbeH0wYZjWtl7kYcNzNgUBpVqw
 9frBN1ZfKjlDYxGUILzlX+dM9zpiMSAxOYXEStZDw6wU54QUIRdEZocGNXBvzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1644019116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGG+8m9FDJcTBlNTm2rGW7J3KpLFh6WAlzYPrg8D8XA=;
 b=8PXiQzaB6ZIsilh5I34F7mtIbgvAF0htL3btQ0SZG7iVI8hLDY65Xh/QF7xAE3Ww4QNB8y
 iNzLS4/+XkcvU/DA==
To: Fenghua Yu <fenghua.yu@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy
 Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok
 Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v3 07/11] sched: Define and initialize a flag to
 identify valid PASID in the task
In-Reply-To: <20220128202905.2274672-8-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-8-fenghua.yu@intel.com>
Date: Sat, 05 Feb 2022 00:58:35 +0100
Message-ID: <87leyqb2vo.ffs@tglx>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

On Fri, Jan 28 2022 at 12:29, Fenghua Yu wrote:

> From: Peter Zijlstra <peterz@infradead.org>
>
> Add a new single bit field to the task structure to track whether this task
> has initialized the IA32_PASID MSR to the mm's PASID.
>
> Initialize the field to zero when creating a new task with fork/clone.
>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
