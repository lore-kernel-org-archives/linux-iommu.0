Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4223205AA7;
	Fri, 10 Jan 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507879; cv=none; b=nUwep8vk7HovhNB1yyHk3uCtCkHxT06Cic/8Bsbzl4M6KwdI7PGZuWQg3zbtQcs0dOt+kdpcMa/ZHY4ujXolwX7vhampHAfTGoUg62oY1ziD4wSe7N7FGk2CqlUFeiDM3RCM0POMSWxQRj9fmFjMdhIn4CGCIeCMfodE2T0V7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507879; c=relaxed/simple;
	bh=NNT8lim6HOEzWvQTMaikg/pT2u/9CHClCe/IHmsqHdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3KbsmIfcLXAHemAgge2Dpk7m46XwbsoTaKeM9Al/b5KxIIBNU6nolI4WQlPAvT/6ZQQRXZKTI1Ck9EEQBTR+qJY9Ag/IHLJjVDXCy6PIa9oMZWfPHscmmGFM1a0I8k0AJwpPRlnRr+xLpPwz041EBBksO+L9YYRh36mwerD7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyTc3kH1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyTc3kH1"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so2611227a91.0;
        Fri, 10 Jan 2025 03:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736507877; x=1737112677; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XBGILMKbPORy8DLEp8X2Qh3B2A7Bk9CG+PKoCeUe1Jc=;
        b=GyTc3kH1tr6oizFYZa14IHQ1ZPeGFWhodlQRljdL6+kMfoWHplnPCw/zzaUb25AzU1
         maJm8H3dyFrEpF15N/DgLq1S5vUK7YwdjlpV0pTqTSJaR3jt78qsgI+WSfDUAtNojj4a
         bSfCV6iJA74yDvMYo9EZpJ+6GCH8p0iuOzF5uwkB1TlNI4iN+NemQPVNtvvoJcXKVZjf
         +En2wmxainMds+sY5CaH57JXsAFvvo4ukT/JhaNQ10O8Ii/9PYXFcWkL/GNsSjkpERwu
         4TM+czLOocAVulOdLhBXBkTi0uFZnMLf4wV3zS5/DyjelZ5kAQRSXpz3RJdPjvrpFc+q
         VCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507877; x=1737112677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBGILMKbPORy8DLEp8X2Qh3B2A7Bk9CG+PKoCeUe1Jc=;
        b=SzywvxHQ5qYyDULYV3NDpfhSL8icAJciwdX71LjBBbWP16EmufuWvHB4RJuPZElaBf
         spBd2Ruv5yjK1V+GMwB0vuvkXuz+nuHJCghQuUzGneVTXwV1EZVPcRq07LVZblHJshPf
         kYmJd7T0G3pW0TQNjpQXBbQp46OFjJloXHD8m6fQwSRxp4cgyRPzD/apLmXHzE7B9QTi
         3Gbz6Pfvrlg7RDtfbjtRBLACH2sOZ15s7D1AmLU8ROCX3wzHjd1HB4Jd2jqkpgAXweFt
         I+iWz4CW0A7u3kPKhceSLcZiIp8w9YgGI+VxJvC/rWG9FkNHEk/QokRu60TQujn6kI0x
         FLKA==
X-Forwarded-Encrypted: i=1; AJvYcCVrYj7WtgZbuZifHoMkEk2GTLgMNdlNJc27ONGULR2pqyLRDLP+exk0ngYJmVZBB3o8ZV9PhQ==@lists.linux.dev, AJvYcCX5voH3d4N/kCgCVrFHXp7YMkmb88iEGHO/3SlrD2GlrJkeBavPoaWiJZAeNjRDAGlQ0Y0D0w78SF+HPmc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzA6CFg6XYF0bJgIq+kFcMGHMG39zm8Vu/A0J7S0n2Az7RYRSId
	1ao2jctYCgZj1DcNh1BU0MfqT+7AkcOO7XkkBwkFGfpR54Oh/p4q4iFpo703yxr2JNKJQLXnQ5F
	mY96R0YSGOc66lElTQZc4RNEC1qs=
X-Gm-Gg: ASbGncs4LzBnhaCxdLjc+ckXrPTCSHH7toEF3Zwk42MBEfkjM2lC+OTqa81FNjiTblO
	aFJunuBc3p+Y0FF4cV9NpRs+ZT4BWEsCBjwrVFG7poSEOpSOFAaKaOEInM5Bz00XCkEfe
X-Google-Smtp-Source: AGHT+IFYbBam4o4hPnqv5ECFznzUa81yzrzUmG6GTq7IvWKxjPCuMu/wl+xlLxnUadOXAssaCN8aC2NTJbFj4BQYFvU=
X-Received: by 2002:a17:90b:2b83:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2f548f103e9mr15815078a91.8.1736507875452; Fri, 10 Jan 2025
 03:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
In-Reply-To: <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
From: Bruno Gravato <bgravato@gmail.com>
Date: Fri, 10 Jan 2025 11:17:39 +0000
X-Gm-Features: AbW1kvakzUWN3Ty8_Iw5S5n0dcdWHYdfxgarw1RZaaaHPbcJ6gOq-a2NLJaQBdk
Message-ID: <CAOBLbT-hrN3hOHbhwkzokR_NXRLH9AgF4GNMi-=LP7Fuqwba_A@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Stefan <linux-kernel@simg.de>
Cc: Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org, 
	Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

Hi,

(resending in text-only mode, because mailing lists don't like HMTL
emails... sorry to those getting this twice)

I can reply via email, that's not a problem.

I'll try to run some more tests when I get the chance (it's been a
very busy week, sorry).
Besides the volatile write cache test, any other test I should try?

Regarding the M.2 slots. I believe this motherboard has no chipset. So
both slots should be connected directly to the CPU (mine is Ryzen
8600G), although they might be connecting to different parts of the
CPU, right? I guess that can make a difference.

My disks are gen4 as well.

Bruno


On Thu, 9 Jan 2025 at 15:44, Stefan <linux-kernel@simg.de> wrote:
>
> Hi,
>
> due to Thorstens hints, I'm trying to reply to both, the bug tracker and
> the mailing list.
>
> > --- Comment #13 from Keith Busch (kbusch@kernel.org) ---
> > If I'm summarizing correctly, we're seeing corruption on Lexar, Kingston,
> > and now Samsung NVMe's?
>
> The Kingston read errors may be something different. They are described
> in detail in messages #108 and #113 of the Debian Bug Tracker
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1076372
>
> With the Kington, I never saw the write errors that occur with Lexar and
> Samsung on newer Kernels (and which are easy to reproduce).
>
> (ATM I cannot provide test results from the Kingston SSD because the
> Lexar is installed, the PC is installed remotely and in use. Thus I
> can't swap the SSDS that often.)
>
> > # cat /sys/block/nvme0n1/queue/fua
>
> Returns "1"
>
> > --- Comment #15 from Keith Busch (kbusch@kernel.org) --- as a test,
> > could you turn off the volatile write cache?
> >
> > # sudo nvme set-feature /dev/nvme0n1 -f 6 -v 0
> Had to modify that a little bit:
>
>    $ nvme get-feature /dev/nvme0n1 -f 6
>    get-feature:0x06 (Volatile Write Cache), Current value:0x00000001
>    $ nvme set-feature /dev/nvme0 -f 6 /dev/nvme0n1 -v 0
>    set-feature:0x06 (Volatile Write Cache), value:00000000,
> cdw12:00000000, save:0
>    $ nvme get-feature /dev/nvme0n1 -f 6
>    get-feature:0x06 (Volatile Write Cache), Current value:00000000
>
> Corruptions disappear (under 6.13.0-rc6) if volatile write cache is
> disabled (and appear again if I turn it on with "-v 1").
>
> But, lspci says I have a
>
>    Shenzhen Longsys Electronics Co., Ltd. Lexar NM790 NVME SSD
> (DRAM-less) (rev 01) (prog-if 02 [NVM Express])
>
> Note the "DRAM-less". This is confirmed by
> https://www.techpowerup.com/ssd-specs/lexar-nm790-4-tb.d1591. Instead of
> this, the SSD has a (*non-*volatile) SLC write cache and it uses 40 MB
> Host-Memory-Buffer (HMB).
>
> May there be an issue with the HMB allocation/usage ?
>
> Is the mainboard firmware involved into HMB allocation/usage ? That
> would explain, why volatile write caching via HMB works in the 2nd M.2
> socket.
>
> BTW, controller is MaxioTech MAP1602A, which is different from the
> Samsung controllers.
>
> > --- Comment #14 from Bruno Gravato (bgravato@gmail.com) --- The only
> >  difference in the specs between the two M.2 slots is that one is
> > gen5x4 (the main one, which is the one with problems) and the other
> > is gen4x4 (this works fine, no errors).
>
> AFAIK this primary M.2 socket is connected to dedicated PCIe lanes of
> the CPU. On my PC, it runs in Gen4 mode (limited by SSD).
>
> The secondary M.2 socket on the rear side is probably connected to PCIe
> lanes which are usually used by a chipset -- but that socket works.
>
> Regards Stefan
