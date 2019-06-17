Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B194C31E5D
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 18:54:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4965B2084D
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 18:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4965B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EDB55D12;
	Mon, 17 Jun 2019 18:54:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 804B1CDB
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 18:54:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
	[209.85.208.176])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3E2D788E
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 18:54:10 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id v18so10385808ljh.6
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 11:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=66m4iUUvYIXxs91ImWOwQpe/gowMn0dh9jwp7NXwltk=;
	b=jN80uRmwpecwAmzjJUkftPzbjQv73il/87q0S4xqdss0ObuBAm/psUyUem9OJJgWhd
	0q+ANi1CPjKr4Pwz6vhn7zYphAt+Ates8Gb/wV4Lt4Kiue1QHJVQGWaoPkoFALcZ6kP5
	as+SzO6ocrCrva/1OB6Ihfu86QyhIh5gVHmnUoxI/7o5lHwVR/WJfPCRHq1K14ynbxH5
	/IpYM2jwOqo46U6+2gLLgKKV19uPIezWQPSjs9+lOEKkzXCqDk1ASwbFb78qF74+itzx
	HYMHRiui09NdzFT4aOd0T3GkhuhypeU6DlVYyMRzHBcmReF+shh8nlYaMY+dHlOMx0dI
	uGrA==
X-Gm-Message-State: APjAAAVsznrngqySOFWUBLB4nhZTN4e73A9fC8oxi2N4ArHNVPs+6bMV
	ZFvmxFrMItK7ERMUEA3unmC4fJYHopGTm6LibLc=
X-Google-Smtp-Source: APXvYqxmc0OIHh1u8In/WbFdOyPZmFDCbAj41wxY9ICm/ETICkV5L88DRwCmmCfwk1E5mh9JaqqSXC67mdkWs9VyE/g=
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr36540791ljl.21.1560797648597; 
	Mon, 17 Jun 2019 11:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190614102126.8402-1-hch@lst.de>
In-Reply-To: <20190614102126.8402-1-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Jun 2019 20:53:55 +0200
Message-ID: <CAMuHMdVPU5RQyX4FnHFEhxXZeG3v0uh_-t2FB=vAzQ8_3u-gSw@mail.gmail.com>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
To: Christoph Hellwig <hch@lst.de>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Christoph,

On Fri, Jun 14, 2019 at 12:21 PM Christoph Hellwig <hch@lst.de> wrote:
> can you take a look at the (untested) patches below?  They convert m68k
> to use the generic remapping DMA allocator, which is also used by
> arm64 and csky.

Thanks. But what does this buy us?

bloat-o-meter says:

add/remove: 75/0 grow/shrink: 11/6 up/down: 4122/-82 (4040)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
