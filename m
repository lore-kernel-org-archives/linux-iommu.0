Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ABE1FF1D3;
	Fri, 17 Jan 2025 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121003; cv=none; b=DWJkQIiCLm+m9q30DoTrZca4W73JLzhkTOljZwYibEBmoyPfcEAaGqHAU6VURCuDmN7WJKu79ArecGI+OkX2SZkbKN/V94vKHStQ+hw5oJDhoQbpgCwx6FtG1OAqa1LQdvrbIdxp4xofcByfgtxDW5bSzRm5sfga37223hbKgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121003; c=relaxed/simple;
	bh=QVo7L/phiOwok7BqC1abUFsogRLeFl2Re0mMohXr1z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EODYvIz0hLj5R4MvRNJYAcNuwWniZ+H6hCJ5y5d3BjaZVS54nynlgaAtOfx5QF0r35BkW2KWf7rAU0otuHLGmg/7Jo2cAF4wK0R+CFsYZCIHEN9u1CZDIBU8qtycTt9u968KOEB6emz07jG2Co7rU7DNaza1f2zP1kd3LSr/EBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9wu+q4c; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9wu+q4c"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f441791e40so2950864a91.3;
        Fri, 17 Jan 2025 05:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737121001; x=1737725801; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVo7L/phiOwok7BqC1abUFsogRLeFl2Re0mMohXr1z4=;
        b=B9wu+q4czSZh3xunHzZT6GP1m7KMY4cSGTrSzmLXe8GeKJ7a2LvnqlU3rlswr2x8SF
         nG6ru1wufaMImaqi7YvgWZf5dTQGcy5YQK0rdCpyUWwR7Q1ZQMtheJv1oa1n3HqsQ12H
         JnZu03nMZDoGstevunygozqxjzwwQevgsWNOpm8xDu52HbfmuLHxgRkHtcrk1fHCZnDo
         x+96IWY1CQayHT1Z3J7fvu5KijX+MZFJNMmbqRwwmicrNtoglSCmrDKqsoHcnmjU/7lw
         u2CLYN7FxAps6dwkqU5uNcMCr4DOW4UkwWG99F27MnENrlvS7G14j6b7SKvd8OLAA4GR
         M8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737121001; x=1737725801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVo7L/phiOwok7BqC1abUFsogRLeFl2Re0mMohXr1z4=;
        b=BWdgB2+HSARyrFxaE33E9OBKrTvpxLDWSj6ypHginHW0ezQdpgQ2Xr96kTA9lBH+x9
         gAMLdFf8StHAKrmWH8OMMC1EQFe5yttRP6QJ7E3xJLQAIxis2bNi2+9g6LCIhoFfnO8X
         qIwcYJEL+KRwuFK7cgtp2r5a3NGVPy2XjEQss1YK7jn+7L9cZGwwd6zxeXsIyE2dGG80
         nV5JiU6jGQt1UAcYNI5XpYYAzfpc0x7YrNO20ZrZsxXEZfgoFul7fq1VWb2AaAFvNvUJ
         B4zqq6+wQNiJViAcsBxAkEdCn60ylosxAQZc4oKSYhwl3XzQ2LqDP4rJXNNcFUisyKl/
         +Ozg==
X-Forwarded-Encrypted: i=1; AJvYcCVAhI2y2kwb57xwiDvwky6esFQZLcfkttDKrN49ZbEUfusBxY12iIEUaO7+ZnRHxt5We8DbJA==@lists.linux.dev, AJvYcCXJDI1+v/pkjFqDx748UPlZEqyK5tlvUvB3WFOoWSUxQim5FsnKPcXO4KWsDo6l7/OZ1Hl422EMBOCNWLk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxYB8sPE9mzVYA86OkOf+yaj94oVVQBQxvFQmnuZWRAN47CW7vL
	H1JO65Cj7HevflazUP0UsIK4SSt9Lit+mut/a7hXBh6geGeT6hVhcg7729NfY6Iva29WispNMJN
	wYd5KUzhzG0pUF4HqwEgXH/uoXd4=
X-Gm-Gg: ASbGncvwxBZ/2tl90hRmd4i3EkKtNxrgaBb1QFrYge59eLm0Cuog2bOK/o9llL4vw7D
	+yj90QuzXixe+oTyev9klteEu57Oe/lpfFOlwfErR627JMtuj2aEYo6/ZgLq452YvnFr0
X-Google-Smtp-Source: AGHT+IEHTPv5hTMRK4zXvRVqJQFfmEi87cZRYjPzN5FnPgoIlZsbqiWaV272Z4i2e3oeYxmEo6z79pG4EFV4U7uQ5JI=
X-Received: by 2002:a17:90a:d44c:b0:2f1:30c8:6e75 with SMTP id
 98e67ed59e1d1-2f782d98026mr3192289a91.32.1737121000939; Fri, 17 Jan 2025
 05:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
In-Reply-To: <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
From: Bruno Gravato <bgravato@gmail.com>
Date: Fri, 17 Jan 2025 13:36:24 +0000
X-Gm-Features: AbW1kvbkbBkK34A4Ax02ZPC_Ze-dz19Wri7acxvdXEP8qeEWMyEJBFXk8nhdLsQ
Message-ID: <CAOBLbT-MFfEw_JYdGOJYxN7S_gjPmG27fMotCwZ==s0i4pdRYw@mail.gmail.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Christoph Hellwig <hch@lst.de>, Stefan <linux-kernel@simg.de>, Keith Busch <kbusch@kernel.org>, 
	bugzilla-daemon@kernel.org, Adrian Huang <ahuang12@lenovo.com>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@fb.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jan 2025 at 09:51, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
> * Not totally sure, but it seems most or everyone affected is using a
> Ryzen 8000 CPU -- and now one user showed up that mentioned a DeskMini
> x600 with a Ryzen 7000 CPU is not affected (see ticket for details). But
> that might be due to other aspects. A former colleague of mine who can
> reproduce the problem will later test if a different CPU line really is
> making a difference.

One other different aspect for that user besides the 7000 series CPU
is that he's using a wifi card as well (that sits in a M.2 wifi slot
just below the main M.2 disk slot), so I wonder if that may play a
role? I think most of us have no wifi card installed. I think I have a
M.2 wifi card on my former NUC, I'll see if it's compatible with the
deskmini and try it out.

The other reason could be some disk models aren't affected... I think
Stefan reported no issues on a Firecuda 520.

I ordered a Crucial T500 1TB yesterday. It's for another machine, but
I will try it on the deskmini x600 before deploying on the other
machine. I should receive it in a week or so.

Bruno
