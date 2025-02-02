Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C103AD27;
	Sun,  2 Feb 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738485169; cv=none; b=DLVpZktvplKOYFno8kc/3lUBqFo9zNWnNXXDjHhfC2slExKY3vhRjS1W30qw0pb1441Qwn5ySd3nkQ6FKDcjUqKa6/6OYTlWeq/HgRGXMQsnI012Jelxw1SKIMFbzR6uckSSb+3u9ke0+U19NZcIPR1FTYzDnnTxJjManWS63ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738485169; c=relaxed/simple;
	bh=h5gZJXr1gG8fo7EF0ILDnAS2K7ODCxc8o+NZCCDv9tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFWU/+O2UFJKajkjLNx1V//gfa0ElSWG7vncCfvGN37b2nGZiKFvC1Eyr+FDxbDkq7p5mg6GYlTKy1gYqrJli2x57Opuczh47MEFkCAyhS9fPDGnlxTP+GqfwPr0mMBhd7eCDHAjG2K2tr62Ys1/sWENteMmBa+wFQy29BCrYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhIpfbzT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhIpfbzT"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f441791e40so4397282a91.3;
        Sun, 02 Feb 2025 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738485168; x=1739089968; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h5gZJXr1gG8fo7EF0ILDnAS2K7ODCxc8o+NZCCDv9tQ=;
        b=VhIpfbzTnqkGF6t1hvCEo8MFGEsSEdh+vdvJ+EjHwbprXn2Btu7VnvXh+Hf92yO2W6
         QDLV73EbuZoAkGPdbpKrIrGq/iLtZzMWFus/JExyIUhoBGEJuoAuJ7ra9aeZPBm6aNev
         DocuTepIj6wcb8Vi/ZRUwT0AMOTFYJ5xqOTuL5oJF8TQLyLYRGewxcQGP6KGle63D/sH
         DMP7/ji8vEcCuNxObv4gAXGADOonR1IrA0CgrFgsY35vYsI58gycyAJWVUowdZWE4OnA
         Snju9S+LJ89LHhcNxc/YPgKDWsvYzaUUfqhVeb7uICpayY0vXY0WuO7K4seEkb+yvd+Z
         ZV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738485168; x=1739089968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5gZJXr1gG8fo7EF0ILDnAS2K7ODCxc8o+NZCCDv9tQ=;
        b=sW6JohGkffnN/uYVBlTQRAhWNRSg1lfrn/e5SEVjKqT6n8Qr4kDYV7B3diw0iOO5VG
         aMwk02M/7OLysjiRBXd9tugv8IXbHWPaP4VGaYPszIRml6twl0lRoTLzJd5K/QqSSTyD
         XWN+zbTfxLU92mFMvk09Ij4g5myiVPqwWkd/h6Z1K0Zyl/s552fqhIs+rSmcj8MiKAYa
         fMiNdWg/XWyiKOi8rJ1v2Wm/ENVx4J9MdsBTfecTr367xeKpA8QOg06YgHRHk3NbzT+u
         F+McF4j+Nu1N/72t1XX5DGd01Irb/m0ffDDXlOIXAh/9iLo9LOza+aN0ZHWTnuRccWww
         /LZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hWogWSCIg4ejfFeoWXIGpvP98A4yZ7TYsReQG7IKvSJka+6O6okNBa5niNuWM+SwDCZYbQ==@lists.linux.dev, AJvYcCWjPq4J6IfXKntR8fqpmZr9KrRCdFP8XNDN7dFC332L91aFtmRfawegvG7buAm6zfwAwMpCmDGFilxBDh8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxhJgk+QCI1ew18x9KEpDT0tMiKZ+w4uttlnosPHR+5QIWHrDdh
	2rngHiX8gQdnHucqIdPqIdRe5vnWHmal6/ibmItemWH7IhuJlLopsL9KOxxhd3eL/Lerz9Itzop
	0wMgHsNkwEMGxv2ycEfXb7JN6274=
X-Gm-Gg: ASbGncsl5bB282PrJ962R9uHpoKSt7/G2JNfMc0oMK6LP/6REHlF/bAEU6vC75Iv6Ir
	WcdD6W2jKTF0N+kli6NG/f2OwmIK8ewgZpi3VCxeJU15T6umYWEb5hboMXeOTT47c4ysqBiK2gc
	B6Xeu6r+Wx5/WBf7LlvpJl8o23Mzc=
X-Google-Smtp-Source: AGHT+IF4Xed2UK/m1b70t2nhQ8MCa/ZGxcKczWbWLCesTg1dtRBkKclSXAXCoFAdI2mFiGLkTfshl1Z+s2zbAA4wYng=
X-Received: by 2002:a17:90b:2742:b0:2f2:a796:26b with SMTP id
 98e67ed59e1d1-2f83abb3480mr24835867a91.1.1738485167545; Sun, 02 Feb 2025
 00:32:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250109082849.GC20724@lst.de> <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de> <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info> <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
 <20250128074133.GA22435@lst.de> <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de>
 <Z5jTKTfKUeLm4uJT@gallifrey> <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
In-Reply-To: <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de>
From: Bruno Gravato <bgravato@gmail.com>
Date: Sun, 2 Feb 2025 08:32:31 +0000
X-Gm-Features: AWEUYZkyNSsitq97aeori6flZ7edGQ2TehN5fCXAeaoGoRvqgLYMRyksBa46SfI
Message-ID: <CAOBLbT8V5DkuXzzgp2dPOZkGomqiLa_cdC=e=uWBtcWpP7L=Ww@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Stefan <linux-kernel@simg.de>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, Christoph Hellwig <hch@lst.de>, 
	Thorsten Leemhuis <linux@leemhuis.info>, Mario Limonciello <mario.limonciello@amd.com>, 
	Keith Busch <kbusch@kernel.org>, Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I just realized I replied only to the bugzilla list. Sorry about that.

So I'm forwarding my reply to everyone else who was in CC and may not
be getting the bugzilla emails.

> > Is there any characterisation of the corrupted data; last time I
> > looked at the bz there wasn't.
>
> Yes, there is. (And I already reported it at least on the Debian bug
> tracker, see links in the initial message.)
>
> f3 reports overwritten sectors, i.e. it looks like the pseudo-random
> test pattern is written to wrong position. These corruptions occur in
> clusters whose size is an integer multiple of 2^17 bytes in most cases
> (about 80%) and 2^15 in all cases.
>
> The frequency of these corruptions is roughly 1 cluster per 50 GB written.
>
> Can others confirm this or do they observe a different characteristic?

In my tests I was using real data: a backup of my files.

On one such test I copied over 300K files, variables sizes and types
totalling about 60GB. A bit over 20 files got corrupted.
I tried copying the files over the network (ethernet) using rsync/ssh.
I also tried restoring the files using restic (over ssh as well). And
I also tried copying the files locally from a SATA disk. In all cases
I got similar results with some files being corrupted.
The destination nvme disk was using btrfs and running btrfs scrub
after the copy detects quite a few checksum errors.

I analyzed some of those corrupted files and one of them happened to
be a text file (linux kernel source code).
A big portion of the text was replaced with text from another file in
the same directory (being text made it easy to find where it came
from).
So this was a contiguous block of text that was overwritten with a
contiguous block of text from another file.
If I remember correctly the other file was not corrupted (so the
blocks weren't swapped). It looked like a certain block of text was
written twice: on the correct file and on another file in the same
directory.

I also got some jpeg images corrupted. I was able to open and view
(partially) those images and it looked like a portion of the image was
repeated in a different part of it), so blocks of the same file were
probably duplicated and overwritten within itself.

The blocks being overwritten seemed to be different sizes on different files.

Bruno
