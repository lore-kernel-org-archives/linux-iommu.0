Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1931CC2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 18:02:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AD420758
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 18:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="f2aSZcdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AD420758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5025F204A6;
	Mon, 23 Nov 2020 18:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fq4qErfCYbaW; Mon, 23 Nov 2020 18:02:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B16982048E;
	Mon, 23 Nov 2020 18:02:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BCBFC0891;
	Mon, 23 Nov 2020 18:02:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31264C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 18:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 10445204A1
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 18:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hd1UGbasqUAQ for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 18:02:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by silver.osuosl.org (Postfix) with ESMTPS id 0577E2048E
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 18:02:22 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0bbc00fb0727400affb1c1.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0b:bc00:fb07:2740:aff:b1c1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3641B1EC0527;
 Mon, 23 Nov 2020 19:02:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1606154540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=xtMDdGoh35RkLAIsz7N5HjR9j3emBxSjEOFAExKDeNc=;
 b=f2aSZcdh8OZzmfkr6JyU3ifN3gMbslL96AP9w9gh/2nUTfaq74KiblFA/c4vmvSBfO/3qw
 nQx0z1d7UpIhG5L3TKnsJwbeveEtfjqLa0UPJEhsVSRvc6dhUJPyHgCR1Xr3fNRIoz6X7B
 4XdWgx5L/9RazH73ATR9+Gb4pNOlkQA=
Date: Mon, 23 Nov 2020 19:02:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201123180215.GG15044@zn.tnic>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic>
 <20201123175632.GA21539@char.us.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201123175632.GA21539@char.us.oracle.com>
Cc: Thomas.Lendacky@amd.com, Ashish Kalra <Ashish.Kalra@amd.com>,
 jon.grimm@amd.com, brijesh.singh@amd.com, dave.hansen@linux-intel.com,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, mingo@redhat.com, luto@kernel.org,
 hpa@zytor.com, rientjes@google.com, tglx@linutronix.de, hch@lst.de
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

On Mon, Nov 23, 2020 at 12:56:32PM -0500, Konrad Rzeszutek Wilk wrote:
> This is not going to work for TDX. I think having a registration
> to SWIOTLB to have this function would be better going forward.
> 
> As in there will be a swiotlb_register_adjuster() which AMD SEV
> code can call at start, also TDX can do it (and other platforms).

Oh do tell. It doesn't need to adjust size?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
