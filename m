Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A942416B0;
	Wed, 15 Jan 2025 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946877; cv=none; b=BOfsJdN3mCFSDWYwBMbwt+E07D7+XOlGO338Iiaz9KNh9gTlZWKRMh5dnlDLGslP95sSGutKOCMSnWsw08v54NxZ05eBmgIM6NKHty0EapZFjjsHbpDEorS0UROcOgF/UtxYm1nZeOQm1fEnL6xhFRpgEw8tzSIG7U8eTLnGbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946877; c=relaxed/simple;
	bh=WLxwRRuw0llt35psltVkoiEy1XeX4CQMuRjqCc1Wlhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUmRt7BWVe4c2ww47VLU2QUBUI05xZGpoGdhOe1HkNL55ydPoHnw+5a3DBWs4acBpEthfxQTFJI68fkhIC77LH/o+uYbz8wFiX+hT/2lcxDMmoqsStDDfwONUSl6PX1ZRxFOy2NZyeGNNztRw2VPPDN/qlHxRTMO0SiOjo30IzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXvRcoaY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXvRcoaY"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so8363852a91.3;
        Wed, 15 Jan 2025 05:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736946875; x=1737551675; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A9Nhc81z1QBg0/4jfG0c6X5JbsRpDWcMGWCj2xBov+4=;
        b=FXvRcoaYxnIz0nXtmyEu61m6b7KNpKC2dS3GrS8Fkb/SeXWZojjX7stSpZEkdkyIw0
         Qmof7yrdGDv4kKHUOovAA7ecA2q+/z+PwjBi2i5irX3SG3sfvkx+7vScw3NJBOn8ze9O
         VoUYi0at8JQBiP8uVUMU4v8npyzxNZi5CG9LVO+k+Eork91WNrHXgjlhKCFFCN4cT7lq
         8eKRSU02p6ImVAEnJzYU/5iLgtrvr/wRG63w4pr3HzGWoG3ZTUsB7mIk6+vGd4sRc5AR
         5IyOZ1A+jClavg8YIoJyYSxw4h4T2hMKH2R5Krrq4WZKz5qFmq96GH9tZo9Xt3yI30NE
         P1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736946875; x=1737551675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9Nhc81z1QBg0/4jfG0c6X5JbsRpDWcMGWCj2xBov+4=;
        b=h+DpZVVeyyIq7ZrBj7HzgLQSM++7wpwxtJ0FrRBb8hRlBBeNcxrHqH1IO/gcW4QUTn
         BOa9JIsentVOK5HxZcII6IUF1iJ9E6B07MvYNuhHLZXHHPUSJJKLexGKpGz6qBiktLjf
         6eOuZMvOHeNSAjG5QiOJmqot8ZiFzuxynb39eI4qvy5rQW+yqPmxOQv9TACqLdGCDtnS
         Yvp70uDD/pMBFO3G9crFG2C4zvuhaZqLbjWr8GXWN+mCMJ8v2h+6FoM1Wt5drpXaG70Y
         t8Jkr7syzFUrJ/sZihs8gyW+SGs/6WSg37AfgN/mGZp2UftH+8MLDr4Nn0He6nzgua13
         pPgw==
X-Forwarded-Encrypted: i=1; AJvYcCVtRxED8HiO53EZF9itBkDBFUe7ifOhMKeWRKCoB/EoG/AynP+1bHyidcr4EptdeBK76YK0IQ==@lists.linux.dev, AJvYcCWnHeaa2YkYmqGUI21Q6IYqHyVRD4SaUsPHiw9A4Jv4914Rmpg5F0IQ0gfPzZBn0aV9szZieuCHpzR1uZw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/UK3/ju7ZafFWFFOO9o2XBqVmRnSEaCbKMr1NoxFwP32JHnOa
	8h89dgURWpdtUDKxR8bAuceK1FtVoxLWTzr5pGym7KvSpJTwy6BVqxGbp9OBJ1rj7+kRUfBWt8z
	uHuDpimPrtHf3CndsQFihk8VzHo8=
X-Gm-Gg: ASbGnctyfW1/D2O8ux+eGK8j6bEwOKwGgbSB+696wCw5/5ZWT84SGn7Xk4VRI65vMqG
	pMQssMsI7T8p2Az6xGzmYZzy3kkGT2KhoxnhWD+EMj9wSTDi31VlTY6RxQyL3uS75fGIu
X-Google-Smtp-Source: AGHT+IGQ0R7x9YXj/h87iEBx+CVBf8QtEg+teUTy3q3W8ZCMxJ01VQONo6Wys+qd9jQey7KW+xhI8Rtvci604JXrJgs=
X-Received: by 2002:a17:90b:2f4e:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-2f548e98ea9mr38312650a91.5.1736946874762; Wed, 15 Jan 2025
 05:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <6c2a34ac-d158-4109-a166-e6d06cafa360@simg.de>
In-Reply-To: <6c2a34ac-d158-4109-a166-e6d06cafa360@simg.de>
From: Bruno Gravato <bgravato@gmail.com>
Date: Wed, 15 Jan 2025 13:14:18 +0000
X-Gm-Features: AbW1kvZTTan8HgtPgAtw62bza1hvMNTlO07oElZfaQ_VFWMvcxTcAudnz_hCQFw
Message-ID: <CAOBLbT9LrqdHQ4-gGkRyB+vU3WnGo8f7X7m2=qK29+x=3QpzPw@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Stefan <linux-kernel@simg.de>
Cc: bugzilla-daemon@kernel.org, Keith Busch <kbusch@kernel.org>, 
	Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jan 2025 at 10:48, Stefan <linux-kernel@simg.de> wrote:
> > Stefan, did you ever try running your tests with 2 nvme disks
> > installed on both slots? Or did you use only one slot at a time?
>
> No, I only tested these configurations:
>
> 1. 1st M.2: Lexar;    2nd M.2: empty
>     (Easy to reproduce write errors)
> 2. 1st M.2: Kingsten; 2nd M.2: Lexar
>     (Difficult to reproduce read errors with 6.1 Kernel, but no issues
>     with a newer ones within several month of intense use)
>
> I'll swap the SSD's soon. Then I will also test other configurations and
> will try out a third SSD. If I get corruption with other SSD's, I will
> check which modifications help.

So it may be that the reason you no longer had errors in config 2 is
not because you put a different SSD in the 1st slot, but because you
now have the 2nd slot also occupied, like me.

If yours behaves like mine, I'd expect that if you swap the disks in
config 2, that you won't have any errors as well...
I'm very curious to see the result of that test!

Just to recap the results of my tests:

Setup 1
Main slot: Solidigm
Secondary slot: (empty)
Result: BAD - corruption happens

Setup 2
Main slot: (empty)
Secondary slot: Solidigm
Result: GOOD - no corruption

Setup 3
Main slot: WD
Secondary slot: (empty)
Result: BAD - corruption happens

Setup 4
Main slot: WD
Secondary slot: Solidigm
Result: GOOD - no corruption (on either disk)

So, in my case, it looks like the corruption only happens if I have
only 1 disk installed in the main slot and the secondary slot is
empty.
If I have the two slots occupied or only the secondary slot occupied,
there are no more errors.


Bruno
