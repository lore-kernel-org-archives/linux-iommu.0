Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48247C433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 22:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E779541841;
	Wed,  6 Apr 2022 22:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uVItamKsqWpx; Wed,  6 Apr 2022 22:11:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 946B441844;
	Wed,  6 Apr 2022 22:11:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68CD6C002C;
	Wed,  6 Apr 2022 22:11:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE8FCC0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 22:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBE9A408C1
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 22:11:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="MDuDrMsL";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="/JM3+JRb"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3xQnB1ijTsx8 for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 22:11:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 531FE40198
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 22:11:31 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1649283088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjO+FcQEbzxNg96q+CVmF00/Fnf4v+c6IvBo4ypadGM=;
 b=MDuDrMsLXT/GQRVb1ZTFGX5T1I+FdkjJWTul1ShjgI4pL+Dl8SLAHZGvNn6gjOifz29Aij
 LtwQGLnBbbAaxhNsSJHXixYSJPAkT5PXM/LIHVVsjwRHIA82U5PyFhHwUhMHpnjg9DkUpK
 XDWhiJALkz/J82FdRql2L4Tn8dExuRbpLwTkBxOkzOggDC9O/J7n4iyYlkAgRFii0kky9M
 gRCUhTIW+opQ9cHKacXd0v31t0o4eyOWXV/GnPY9wHGeXfgphZ3nvpglWFHLl+iKOJVNf0
 bx7RuROx41KU9bEMsqOpKLZpSHOyBvPMo89txpgbl+CjlIz2XxqPfK1OS2X4oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1649283088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjO+FcQEbzxNg96q+CVmF00/Fnf4v+c6IvBo4ypadGM=;
 b=/JM3+JRbyPJzN47EjFTCmy7kGOujjw4LAotjVETTRqG+McDzrvIwV7iirZ2G3TRLNTSinL
 FgoFrheKZGhP44AQ==
To: Reto Buerki <reet@codelabs.ch>, dwmw2@infradead.org
Subject: Re: [PATCH] x86/msi: Fix msi message data shadow struct
In-Reply-To: <20220406083624.38739-2-reet@codelabs.ch>
References: <20201024213535.443185-13-dwmw2@infradead.org>
 <20220406083624.38739-1-reet@codelabs.ch>
 <20220406083624.38739-2-reet@codelabs.ch>
Date: Thu, 07 Apr 2022 00:11:28 +0200
Message-ID: <87pmltzwtr.ffs@tglx>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 decui@microsoft.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, maz@misterjones.org, pbonzini@redhat.com
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

Reto,

On Wed, Apr 06 2022 at 10:36, Reto Buerki wrote:

> The x86 MSI message data is 32 bits in total and is either in
> compatibility or remappable format, see Intel Virtualization Technology
> for Directed I/O, section 5.1.2.
>
> Fixes: 6285aa50736 ("x86/msi: Provide msi message shadow structs")
> Signed-off-by: Reto Buerki <reet@codelabs.ch>
> Signed-off-by: Adrian-Ken Rueegsegger <ken@codelabs.ch>

This signed-off by chain is incorrect. It would be correct if Adrian-Ken
would have sent the patch.

If you both worked on that then please use the Co-developed-by tag
according to Documentation/process/

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
