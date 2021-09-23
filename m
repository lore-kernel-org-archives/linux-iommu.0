Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D417C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 16:07:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F5A6103C
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 16:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01F5A6103C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB845606B1;
	Thu, 23 Sep 2021 16:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jmhuPfnILsrH; Thu, 23 Sep 2021 16:07:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9481D60692;
	Thu, 23 Sep 2021 16:07:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C2E2C0011;
	Thu, 23 Sep 2021 16:07:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9A94C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 16:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8A198403E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 16:07:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QKpt4_2N2qeD for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 16:07:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F5488403B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 16:07:15 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id bx4so25476460edb.4
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DLOxhnwH/JaVIhRbDcxcZPpiYGHLJbtd0CRIGAWnOsw=;
 b=QMXOiJ6n28J2emY/y7cY9+DD4h8Pn0KRvNWmJxYGi/2iw91Mhhsv5k4E/yi6SvFmH+
 cwsdxpHCcIaSp+pnaMQx9j8vfDg38b4ujoTb2lzS4jvwjrgaoWuJfcNbrdzMUshkRDfy
 wyxZpTZP4dsY0GDCSs5bbcT3wFiFu+kSB/Akk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DLOxhnwH/JaVIhRbDcxcZPpiYGHLJbtd0CRIGAWnOsw=;
 b=cZtQTho7uO/jIcddhL+p/Pkp3mv/slDCE4yjjIKvUJ/JICkp4fFZFAhUGwHJCXwlnJ
 y8Fqz0FzwC8V+Y4xcWduVaaaZehzmYPcnDybdCXgXTSLAlqLs8cNeBk2xbdTy24rCdJP
 QSliWovp/332fpRZ4ZdjMigwHynSCg9PJ6b6IJyhFZQSj1ERJ9krqkaQ5ohPKfoJKAsu
 oGxjFTJpPXGTw6JS9UX9Ml1k8CNx0mmWRkSsWRQxjpEiU0bHwRLUTu2/R5ZHs3/G4ai1
 F1GLmvrXtbciPDl9+XQwwipA0au0nFtq7E87jtIDajH8wdd1kVpP6DrHy0GnWnEUrXlc
 Ksng==
X-Gm-Message-State: AOAM531O5u62sktOSp8ZPMRMBToLEHHc8qUQDgOCbp3seBseG93IQdkw
 UdcqnCXlYxqBwA1KzJpFGUQKN5Y+2WSR2X6QkqbUBQ==
X-Google-Smtp-Source: ABdhPJyj1lp+/m1SqoYKWvV5onrjzwq4M3sFYTC1Jh6GpD3PSIjL6jABsLKHTX9o+sxT4viHcqMMOQ==
X-Received: by 2002:a05:6402:336:: with SMTP id
 q22mr6407741edw.53.1632413232912; 
 Thu, 23 Sep 2021 09:07:12 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com.
 [209.85.218.52])
 by smtp.gmail.com with ESMTPSA id bj21sm3256918ejb.42.2021.09.23.09.07.12
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Sep 2021 09:07:12 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id o20so256638ejd.7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 09:07:12 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr5950451ljc.249.1632412922441; 
 Thu, 23 Sep 2021 09:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210923074335.12583-1-rppt@kernel.org>
In-Reply-To: <20210923074335.12583-1-rppt@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Sep 2021 09:01:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJB8H5pZz-AKaSJ7ViRtdxQGJT7eOByp8DJx2OwZSYwA@mail.gmail.com>
Message-ID: <CAHk-=wiJB8H5pZz-AKaSJ7ViRtdxQGJT7eOByp8DJx2OwZSYwA@mail.gmail.com>
Subject: Re: [PATCH 0/3] memblock: cleanup memblock_free interface
To: Mike Rapoport <rppt@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>,
 KVM list <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 linux-um <linux-um@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, iommu <iommu@lists.linux-foundation.org>,
 linux-usb@vger.kernel.org, alpha <linux-alpha@vger.kernel.org>,
 linux-sparc <sparclinux@vger.kernel.org>, xen-devel@lists.xenproject.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Thu, Sep 23, 2021 at 12:43 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> The core change is in the third patch that makes memblock_free() a
> counterpart of memblock_alloc() and adds memblock_phys_alloc() to be a

^^^^^^^^^^^^^^^^^^^
> counterpart of memblock_phys_alloc().

That should be 'memblock_phys_free()'

HOWEVER.

The real reason I'm replying is that this patch is horribly buggy, and
will cause subtle problems that are nasty to debug.

You need to be a LOT more careful.

From a trivial check - exactly because I looked at doing it with a
script, and decided it's not so easy - I found cases like this:

-               memblock_free(__pa(paca_ptrs) + new_ptrs_size,
+               memblock_free(paca_ptrs + new_ptrs_size,

which is COMPLETELY wrong.

Why? Because now that addition is done as _pointer_ addition, not as
an integer addition, and the end result is something completely
different.

pcac_ptrs is of type 'struct paca_struct **', so when you add
new_ptrs_size to it, it will add it in terms of that many pointers,
not that many bytes.

You need to use some smarter scripting, or some way to validate it.

And no, making the scripting just replace '__pa(x)' with '(void *)(x)'
- which _would_ be mindless and get the same result - is not
acceptable either, because it avoids one of the big improvements from
using the right interface, namely having compiler type checking (and
saner code that people understand).

So NAK. No broken automated scripting patches.

               Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
