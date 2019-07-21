Return-Path: <SRS0=CCc5=VS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38004C76195
	for <iommu@archiver.kernel.org>; Sun, 21 Jul 2019 16:58:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0868A2184E
	for <iommu@archiver.kernel.org>; Sun, 21 Jul 2019 16:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JWhLyO68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0868A2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DBE69949;
	Sun, 21 Jul 2019 16:58:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 156D82C
	for <iommu@lists.linux-foundation.org>;
	Sun, 21 Jul 2019 16:58:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
	[209.85.208.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 75A83E6
	for <iommu@lists.linux-foundation.org>;
	Sun, 21 Jul 2019 16:58:23 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id h10so35210691ljg.0
	for <iommu@lists.linux-foundation.org>;
	Sun, 21 Jul 2019 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JIuU92ucT6bQTXAcxJLrdNS8BLR+pSqNO48JgC8/dJw=;
	b=JWhLyO68Hrib0GO70cuR1VtthguReGEJ9R2mWF5MJMmuYYlNXh0tejOJPwrZW3bQ+y
	oCIboqjxklsU2/gyMVnv8F9oSF6QM2yijtblZ5RueBaDIQOHmT2bW8TxAQH19XPN1G/a
	h1YfAYY2AemzRecXuSFS2X4NUgGnNqLq2BwWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JIuU92ucT6bQTXAcxJLrdNS8BLR+pSqNO48JgC8/dJw=;
	b=HFNIk/ClKUONc2k3UtGAT2F8Jjlc5zYbPz2uo31tv+3Dc5G4r9w6Cg3Va1xZMaqa23
	hp7TqW9YZdWtF2BbnlefL4o22fOKFk370u8YUyypio2+TNvj/3C44U5WX1bNriIBs1Hd
	G92OGnVBamneqPsIVrVn6xCndsF1moHDlP+1hEgfI3rVSnxymLWlFAZxhXZ+MW68f5L/
	Hm2RVdS9zxSkQekK1sP3lpnn9YjCynS8uGdqdIp9Bl1Iv6yaOaKiYo5TbqQI/verZoCL
	odfef0l2QDIYvbp8fIfv0MuJMHS5hYiIMXyWnwgF0k3x4ZQMXroyCKQWQgRJPHtV/w9L
	dMIQ==
X-Gm-Message-State: APjAAAUkI9Og/g+bFBvN3UaLmuKRetYacflKFb5L6qZm/mWEnaqxD7IF
	9qZbMeZydYzA1pFUYXyDylZmk6QMHqi0Gg==
X-Google-Smtp-Source: APXvYqwU6LGzMxNB55aP0pb8OsIWmPkuLPFRqW04hTzfmTsgLnnD8wkIScrHgDRP5PshWN6cQg4AEA==
X-Received: by 2002:a2e:858b:: with SMTP id b11mr12389342lji.159.1563728301270;
	Sun, 21 Jul 2019 09:58:21 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com.
	[209.85.167.46])
	by smtp.gmail.com with ESMTPSA id l22sm7037077ljc.4.2019.07.21.09.58.20
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sun, 21 Jul 2019 09:58:20 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x3so24976509lfc.0
	for <iommu@lists.linux-foundation.org>;
	Sun, 21 Jul 2019 09:58:20 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr18859096lfp.61.1563728299917; 
	Sun, 21 Jul 2019 09:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <1562861865-23660-1-git-send-email-cai@lca.pw>
In-Reply-To: <1562861865-23660-1-git-send-email-cai@lca.pw>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jul 2019 09:58:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwd9vT1h7jKMU_E4ae2QLFFH69UxcXpO3J9YqEApdUNg@mail.gmail.com>
Message-ID: <CAHk-=wgwd9vT1h7jKMU_E4ae2QLFFH69UxcXpO3J9YqEApdUNg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/amd: fix a crash in iova_magazine_free_pfns
To: Qian Cai <cai@lca.pw>
Cc: iommu <iommu@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Jul 11, 2019 at 9:18 AM Qian Cai <cai@lca.pw> wrote:
>
> The commit b3aa14f02254 ("iommu: remove the mapping_error dma_map_ops
> method") incorrectly changed the checking from dma_ops_alloc_iova() in
> map_sg() causes a crash under memory pressure as dma_ops_alloc_iova()
> never return DMA_MAPPING_ERROR on failure but 0, so the error handling
> is all wrong.

This one seems to have fallen through the cracks.

Applied directly.

Maybe it's hiding in some fixes tree that I haven't gotten a pull
request for yet?

           Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
