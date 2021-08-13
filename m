Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD7C4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 16:54:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7CF60F51
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 16:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E7CF60F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D300940284;
	Fri, 13 Aug 2021 16:54:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lLcX6sxnnBjB; Fri, 13 Aug 2021 16:54:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2435402BD;
	Fri, 13 Aug 2021 16:54:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8503AC001A;
	Fri, 13 Aug 2021 16:54:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB518C000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 859D9605DF
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sYV-BsqGMXNA for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 16:54:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57CF960639
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 16:54:04 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0a0d00fd43514a4e38f781.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0a:d00:fd43:514a:4e38:f781])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 804C41EC0411;
 Fri, 13 Aug 2021 18:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1628873636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=/84z6Jt71TwxTIyDYITeuLKD4Ta4roESLEjk8oftwvw=;
 b=nnPxnFFLQXpCfOvbEt0Av0rUZgOj1mCuG52fzxh3GPPNWTGmksMlvf0COZbS6GeG7w/U4X
 7mZL51Ynycu3lBpXmVHvv8/wQCm+WKZrzwUcxFqB4d6xvMbh86UVysShSR99PoH2kwcun4
 oA4KUqxbZo0t2RUufvPoKKaeCKXRSRk=
Date: Fri, 13 Aug 2021 18:54:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] powerpc/svm: Don't issue ultracalls if
 !mem_encrypt_active()
Message-ID: <YRajyuHdlJuO0shK@zn.tnic>
References: <20210730114231.23445-1-will@kernel.org>
 <871r7cks8x.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871r7cks8x.fsf@mpe.ellerman.id.au>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, iommu@lists.linux-foundation.org,
 Claire Chang <tientzu@chromium.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Aug 02, 2021 at 09:20:30PM +1000, Michael Ellerman wrote:
> Will Deacon <will@kernel.org> writes:
> > Commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> > introduced a set_memory_encrypted() call to swiotlb_exit() so that the
> > buffer pages are returned to an encrypted state prior to being freed.
> >
> > Sachin reports that this leads to the following crash on a Power server:
> >
> > [    0.010799] software IO TLB: tearing down default memory pool
> > [    0.010805] ------------[ cut here ]------------
> > [    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
> >
> > Nick spotted that this is because set_memory_encrypted() is issuing an
> > ultracall which doesn't exist for the processor, and should therefore
> > be gated by mem_encrypt_active() to mirror the x86 implementation.
> >
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Claire Chang <tientzu@chromium.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Fixes: ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> > Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> > Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Link: https://lore.kernel.org/r/1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com/
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/powerpc/platforms/pseries/svm.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Thanks.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> 
> I assume Konrad will take this via the swiotlb tree?

Btw, we're currently reworking that whole "am I running as a
confidential guest" querying, see:

https://lkml.kernel.org/r/029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com

for example.

I see Konrad has queued this for 5.15 in his devel/for-linus-5.15 branch
so if he sends it to Linus in the upcoming merge window (right Konrad?)
then I can base the rework ontop, once 5.15-rc1 releases, so that there
are no build breakages...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
