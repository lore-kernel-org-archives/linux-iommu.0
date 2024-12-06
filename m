Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58449BE46
	for <iommu@lists.linux.dev>; Fri,  6 Dec 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468784; cv=none; b=LHwZRPlCHpJYpxQarVlF6vcY3ErAirBsPnSNgWFKZClE5zhcHYd0vWv9GP7NEykMOt4z5OE2WfKh5NLHSOOMFSFd1h+J5hlftTH1B2/z1sq+p5olhs6Fj6M/6/f0KKZddbcffwCJKd2KsrdC4hmKpkrCDLeZmHoiR47LofobNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468784; c=relaxed/simple;
	bh=MK/IhNxSgejMFBRxBYLLq/Vwg2y/SQRmiazddy8SyTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6LEc+DGaZ8lxwt93ERLV98WXrUsPKHEVOWgGT60WgAaRMA3L5wVAvr7ToF6Ue09Ebz13NLJ9YXf0X3vHyDp45rtKQjY/sr8U7rNUFyriPCuPJ77K7obNgHJRKu1hxfZ9FLoDUxFKnY6Nes5vCmtHD+J/yZNbKjEldNOFl68Cmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKF6Y/W0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKF6Y/W0"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30024c73101so13701181fa.1
        for <iommu@lists.linux.dev>; Thu, 05 Dec 2024 23:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733468780; x=1734073580; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DQonzwxQTSP4xOxfibkeem1n9wtDkmxWgdzvZNrDp6g=;
        b=SKF6Y/W0EuyGh+PCBoEnycE0ISNy/GW241g4r2d5wKXA+1OfQpiwbt7K1Lk7E1z75n
         E9viI/eVL7AoDU3570efS/ylgZv11t5iagfTPPicPverbxEvkSepAcnPunlcmQcUtSXG
         8fQRdx39KlHMd+ffK/kDQaTMCiMDdr/XALjUQ1p3YpQFef6faqBNw68GWoi664Syfz9w
         3tOSY/Zqoq+Bxv3aCbrVmFniq37EbenuY13cue090RYYdUNjCT7peLrREMMF1a0Xmk7R
         eRY6XwZO1L63C4kD1dyBwTy5R9HBnbYfYKu9QPkzHb8/JiPNQ2GDs+jKWKF8tTDtToHT
         +Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733468780; x=1734073580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQonzwxQTSP4xOxfibkeem1n9wtDkmxWgdzvZNrDp6g=;
        b=fn8c8ItlYTQvh5koJvKoTmWl1W5vB0qlk07gQP6eP7a2yKFA3HXpPNkwzE+wtmqxyP
         KLOILpHQmYYX6NYYeAlCcQFfIjfe1TUWGaIa2O+FMYHEZ08js+z1EADewRkCSFsEHW3+
         Z6wpZo8ZvhgqB4hyMsHXj59qwnHbavKkbPt4hkv7cghaPoyz/0k5yzR3w7CXBHdcuqnm
         2UbGiCQGcreFCnFu/gyklZ2EkWObdV0SVo8jSD8pCM9nKO7C80Ds+HU13dsr7V0fqi9J
         KBYgBbxq9SDuG8UdOPPRNw0kwpDDULWtd283rkeNh8oeayua/iTDmrT1p+Tu21wGP+tJ
         Asxw==
X-Forwarded-Encrypted: i=1; AJvYcCViaQMJaz0QqDkviPbFKOCFPBlZnAEqVTc2b0z3P5xrFNIPhv1IVImrtSdHnhGIeShKI6TuuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIoXS3ttin07etFiYvqYR3JV2+lcIwXNzBgBYO0sqDtAHzB6cN
	o/WB1D3GHzbqGOTCpTjcmObYHhBM9h/u6UsX44G3gIGbnaVBnmBtmNHm/Dpsko8iqLAdOhPWHCQ
	TTE4eLSdXYuKS72c/mm0xiCQICWS85w5IMW0F
X-Gm-Gg: ASbGncvOstek+gHO9QezputdA5TgYAo+E+kCYOZ4lSKbLej1iCeBsCWmYcpD+OTbvBO
	IMJtegnvUNZKB9Y46zwnd196IVND3Vk2noqqANhfAY1UKLo27qjeceKeOF2i4ajwy
X-Google-Smtp-Source: AGHT+IESRHSPJ/mq9imt5mTW4BMf6/BbwaQHeC6qIFHNxc+sY+o5+mqJj2zEBSDni0rWqdKb2/ZsJPH4OVdGLYUo8MI=
X-Received: by 2002:a2e:be11:0:b0:300:159a:1638 with SMTP id
 38308e7fff4ca-3002dee4cf6mr6619391fa.17.1733468780250; Thu, 05 Dec 2024
 23:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <72ad8ca7-5280-457e-9769-b8a645966105@pengutronix.de>
In-Reply-To: <72ad8ca7-5280-457e-9769-b8a645966105@pengutronix.de>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Dec 2024 08:06:09 +0100
Message-ID: <CACT4Y+Y5_8KYm2bjKPiwk5UP2Y_AbowV8c_Ai5UPmOn2GD+GEg@mail.gmail.com>
Subject: Re: Using KASAN to catch streaming DMA API violations
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: kasan-dev@googlegroups.com, iommu@lists.linux.dev, 
	Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, elver@google.com, Kees Cook <keescook@chromium.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 15:54, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello,
>
> This is a follow-up to a discussion that took place in the Kernel Sanitizers
> Office Hours (IIRC) at this year's Plumbers Event in Vienna.
>
> I had asked about how KCSAN could detect races due to DMA[1] and Arnd
> suggested that we could use KASAN to detect the CPU accessing buffers that
> it doesn't have ownership of. I mentioned having implemented[2] this exact scheme
> in the barebox bootloader's KASAN support and promised to type up an email
> about it to help getting a similar functionality into the kernel, but first
> some context:
>
> The streaming DMA API is used to annotate ownership transfer of buffers in
> memory shared between the kernel and a DMA-capable device.
>
> The relevant kernel documentation is:
>
>   https://www.kernel.org/doc/Documentation/DMA-API.txt
>   https://www.kernel.org/doc/Documentation/DMA-API-HOWTO.txt
>
> But I'll give a quick recap. There are four key operations:
>
>  - dma_map_single() moves a range of memory from CPU to device ownership
>
>  - dma_sync_single_for_cpu() can be called on all or a subset of the range
>    mapped by dma_map_single() to move ownership back to the CPU
>
>  - dma_sync_single_for_device() moves back all oo a subset of the range
>    mapped by dma_map_single() to the ownership of the device
>
>  - dma_unmap_single() gives back ownership of a range of memory to the CPU
>
> It's a bug for the CPU or the device to access a streaming DMA mapping while
> it's owned by the other side. On many systems, that bug will manifest itself
> as memory corruption due to loss of cache coherence.
>
> To make it easier to spot some misuses of the API, the kernel has a
> CONFIG_DMA_API_DEBUG feature, which will run sanity checks when using the API.
> It can't however detect if a memory access happens to a buffer while it's
> owned by other side, which is where KASAN can come in by having CONFIG_DMA_API_DEBUG
> record ownership information into the KASAN shadow memory.
>
> That way accessing a device mapped buffer before sync'ing it to the CPU is
> detected like KASAN would detect a use-after-free.  When the ownership is moved
> back to the CPU, the memory is unpoisoned and such an access would be allowed
> again.
>
> I had implemented this scheme[3] in the barebox bootloader and it works ok:
>
>   BUG: KASAN: dma-mapped-to-device in eqos_send+0xdc/0x1a8
>   Read of size 4 at addr 0000000040419f00
>
>   Call trace:
>   [<7fbd4980>] (unwind_backtrace+0x0/0xb0) from [<7fbd4a40>] (dump_stack+0x10/0x18)
>   [<7fbd4a40>] (dump_stack+0x10/0x18) from [<7fba2360>] (kasan_report+0x11c/0x290)
>   [<7fba2360>] (kasan_report+0x11c/0x290) from [<7fba1f44>] (__asan_load4+0x54/0xb8)
>   [<7fba1f44>] (__asan_load4+0x54/0xb8) from [<7fb2e52c>] (eqos_send+0xdc/0x1a8)
>   [<7fb2e52c>] (eqos_send+0xdc/0x1a8) from [<7fbb6544>] (eth_send+0x154/0x16c)
>   [<7fbb6544>] (eth_send+0x154/0x16c) from [<7fbb7114>] (net_ip_send+0xe8/0xf8)
>   [<7fbb7114>] (net_ip_send+0xe8/0xf8) from [<7fbb7d10>] (net_udp_send+0x68/0x78)
>
>
> The aforementioned barebox functionality goes a step further and also used
> the shadow memory information to detect repeated syncs without an ownership
> change. While this is not a bug, my impression is that this is unnecessary
> overhead and a diagnostic could help correct a developer's misunderstanding
> of the API.
>
> I hope to kick off a discussion about this with my mail here and perhaps even
> motivate someone else to port it over or reimplement it. :D
>
> [1]: when CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN is enabled
> [2]: https://lore.barebox.org/barebox/20240910114832.2984195-1-a.fatoum@pengutronix.de/
> [3]: https://github.com/barebox/barebox/blob/master/drivers/dma/debug.c


Hi Ahmad,

This looks great. The example stack you posted - is it a real bug, or
an injected one? Has it found any real ones?

Added the link to https://bugzilla.kernel.org/show_bug.cgi?id=198661
so that it's not lost.

I guess this memory usually does not come from kmalloc, right?
Otherwise it would be possible to use kasan_record_aux_stack() to
attach the stack of the last sync operation.

Re repeated syncs. If not all of them will be fixed, then at least for
the kernel it should be under a separate config b/c syzbot does not
tolerate false positives.
