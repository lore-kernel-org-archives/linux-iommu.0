Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D341E04BE;
	Wed, 15 Jan 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923081; cv=none; b=g6HrAvfcBwEXVGZX+0YZgjV1cJOn/Y3FqrZFX1H7jGm1oL78eLBtZ9PHtSmtEcKQfj0NCoyP71u42Brvxq0uCixlEyvAdKuvm+maorThfwbK7E/MTT0TvHmfC+dRvx3UUP1fZl+3yl46NIBYthCQfuUIesbKAeODSTwDnjtfF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923081; c=relaxed/simple;
	bh=DeeXX8V4qNCj/nNIFb72otntWdvZMUjv7VKrUZtiTyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbKK3agKQ/o0DNBR0IErACXgxJBYjWyTqzrshkmGi6x8/mcafo240H6pEfYJkwjbkrlRm1+fzWwdr1eKIoxthCA+yOO4ES8JxN49pj6fix/kdqogmp8u3G5UD2tKNkJH3gHW01qq/rvc7GWck1m7cy711fL4XlU6sEjCOuy4Pbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2MjLhG7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2MjLhG7"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166651f752so143087605ad.3;
        Tue, 14 Jan 2025 22:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736923079; x=1737527879; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DeeXX8V4qNCj/nNIFb72otntWdvZMUjv7VKrUZtiTyM=;
        b=h2MjLhG73QULkjh6/LO/TJNYPhr450oLCMyeaRXSKFoXrtadlBSjzDWtAX6NK3VNT6
         xVFY9NBSEaWGMubvSwUFnlzmdCa6uXbVbyH3nT4qxsWUKuF/S5jDeOVTL3UogoUT2b7k
         X8HkQYuehdq37IClVsS6CQqJ5nhyvAd1SdvD+7AO8Usb7vj7E96vqeizQOT++yRRvGjs
         Rr+WU4g+tlx6QC5h+07goKESLLJ6vQGDizdouLkXsh7h53wwN0f4g1r8s8WIeTHegoRy
         r5WoZCBLb8zBlkZhoGDc/xFJ1Zo596fFdNDgUsbFhQ1lwGKIvd/oIAqiUc+LWqAqB98Z
         2/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736923079; x=1737527879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeeXX8V4qNCj/nNIFb72otntWdvZMUjv7VKrUZtiTyM=;
        b=SaplLV6D6uLs2lcfkAnE8KIBzMhLLXXVk5iqgm3IixzV9x+/xK2WyQfl9R/TgHRUfR
         4mNHp/IBBX89u2wYDCFVGSg/ZFf9NqG0OTDuKW0A5HOeYLunStA8dOTwHBjPwlfSnzGa
         KreOopfI4UPCgFKgnFyQXRJ+aQ63EO8XrgTrI65dS9HtebPLe0LgWNA4nyIlJhvd+Tgh
         7eS8DNSSD623ObmBNLll0Quc9aUsC4wXc/qos/001JuTCDgmrMerfkR86ecl8goMQoXC
         E03skCPo0S9fL4Lpip6wCbkY/gzP5YxHQRzsUL4WQedFZccbYiDqFKhnkTZdYUgLOPjv
         rvgg==
X-Forwarded-Encrypted: i=1; AJvYcCUmnTViQIsBNDIDsliFUdoUO4wMPZwzUQdzjIoUnWxrrKdpInYLC+A9uvSWK9jQSvaakj8BaRoPk8wawAs=@lists.linux.dev, AJvYcCWSdH1XrekNYSu3Qzs3A5eG29R+CRG/Mm1ZaIk4gFr5d6lR2oayWaqbNcLuvrtMoD5uwNV5tA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yws+/1u8hP+3P+YO/AVUT0LQdZNvkCDPYFZQqosbEYfN3B/nme9
	0EeOIMLXgvnZiLHlBJQMi8QL7rDWvXryWrXTFucMBjo39OaBWcdI1bpPFh44LUldUacu2P24Ofo
	fT4DHaxPPgsDZyDpvpbNG6KvjZpU=
X-Gm-Gg: ASbGnct+jpk8pJZa3QkjfCyx+KhXyThAIrub3kzcBTCy13hkYjvXTCRQc4LWtR2p8DD
	/skz4KN56frROMG3hcg+d7KkDdHVFiEr1zhHciIjPoJHS/0EDARokgqFMKC91kQKQUgWs
X-Google-Smtp-Source: AGHT+IEtlsZBoTLyH7bctfVhdE3Hgj0ldBoJBXJMa3OO6Cm5zOvn5pt4QNw+F1gkxmQZcLOAvuOEOGIjk+k0xKPLEmw=
X-Received: by 2002:a17:902:c406:b0:215:3fb9:5201 with SMTP id
 d9443c01a7336-21a83fe4b43mr463249525ad.44.1736923079279; Tue, 14 Jan 2025
 22:37:59 -0800 (PST)
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
Date: Wed, 15 Jan 2025 06:37:42 +0000
X-Gm-Features: AbW1kvaUsKoAjd4YX0symRsTqpgY7AJbLMSkdBzJvPBjtNC_gann497SFL8XyWQ
Message-ID: <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
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

I finally got the chance to run some more tests with some interesting
and unexpected results...

I put another disk (WD Black SN750) in the main M.2 slot (the
problematic one), but kept my main disk (Solidigm P44 Pro) in the
secondary M.2 slot (where it doesn't have any issues).
I rerun my test: step 1) copy a large number of files to the WD disk
(main slot), step 2) run btrfs scrub on it and expect some checksum
errors
To my surprise there were no errors!
I tried it twice with different kernels (6.2.6 and 6.11.5) and booting
from either disk (I have linux installations on both).
Still no errors.

I then removed the Solidigm disk from the secondary and kept the WD
disk in the main M.2 slot.
Rerun my tests (on kernel 6.11.5) and bang! btrfs scrub now detected
quite a few checksum errors!

I then tried disabling volatile write cache with "nvme set-feature
/dev/nvme0 -f 6 -v 0"
"nvme get-feature /dev/nvme0 -f 6" confirmed it was disabled, but
/sys/block/nvme0n1/queue/fua still showed 1... Was that supposed to
turn into 0?

I re-run my test, but I still got checksum errors on btrfs scrub. So
disabling volatile write cache (assuming I did it correctly) didn't
make a difference in my case.

I put the Solidigm disk back into the secondary slot, booted and rerun
the test on the WD disk (main slot) just to be triple sure and still
no errors.

So it looks like the corruption only happens if only the main M.2 slot
is occupied and the secondary M.2 slot is free.
With two nvme disks (one on each M.2 slot), there were no errors at all.

Stefan, did you ever try running your tests with 2 nvme disks
installed on both slots? Or did you use only one slot at a time?


Bruno
