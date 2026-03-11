Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E031AABC
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235416; cv=none; b=gwAt/fUayTpiCeSqVgdMhmtJA1sm7WM8mlH0z+a0dZb/oFTePvMqKqe5fDXtFGelNhMs66T/nLaMwgBpBe76CDQ9ZUuLfA7eV1YJOwKrVXu1NmZIszfPszPtRP3cXBHIoZG8CMjYLPwkNFHPYcyMHW+KsKVHUPkuhkEIpaLRr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235416; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+cEq+Dsthh+IwXxvyMP7pAtM6C3ospAAAlPrNxZpDR5l6D0a1ygkg1N6ACim9A352xmeDuU5p797ZAwzi+L/AJiN2dWcr58X4/0QP/Nkddhn3854HiLTXtvPjeP8VnTh4QoTmmsmXoctQ8tiXpLt7nghe6P8sbt/ZT/ATquSk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56739adfa1aso10530390e0c.0
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 06:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235413; x=1773840213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=xQJdJ3SEqSQIAoGyQjIqbXnCdiaUo0QO06igMQs0ynznC+RM4QoTtP0jRcvTzDC7oL
         w+7xTDd1G6guMPd0cilNluxJecrabZNwmJFzhuRVAx/685Fn9MeInOHSGprj1Ojloyy5
         oK1Gur/naPGlj53PJVip963AIxE9shvQ2y8X5e0jEbgElhsstsbk2g9cYWtXKP129smQ
         o/iRTmaVAqZ8TMItsEcFUB6goGcaUbQvw3XZQqzCKKARRy6tNjrkNGb8BmDwctjX4HBZ
         QkeRt1FXZZwztXMgW+tBoUhcWtIv3bwyJMOrLEeAHMwu1rZW++kPXAYnWlKc1OCrritG
         HKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8cXGzdBhl8h6nLvekz5aBJ0Krg2sJXTgY4kGquBBkFGs9b8bOq+FUy4vDy9wyvOxze6eZ7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/ueb02K69CQPoMJtt+aLvPeKWG0UnCSLio9b99cerTWaP1gAq
	Ra667rHn2rpWhbLSBDXZmMEcFsEl3fQl/NaSu8RugVLlXl6absgZLXlBjKeP3xlC8uo=
X-Gm-Gg: ATEYQzxvxCmk9PZsB95799Sxe+6CPi8NCTnErfAvbYa37KJsPGVutjdgJp8Xeve7cZe
	U6M4XRGsEIPo44lYMegNr1oS6ixqVb16FVKGr7+ik9e98AdLwgxkDLqiNbXxInmLBj44ttrxSkg
	bAroxPW7XC6rnSrprUl+lIt3InIS5Gwln/OQ5S6PCU6jQZe7Ee/Tj9ShLj8F3JVniv+jzq6xqsA
	48a1CuV+p5RL2yx7y3pljeu4xbiRbXC2KYTDkbNtqvRgAQZ8hzCsbhiBNnZnjXc8cQ6r1KUHTrs
	LpnxC5y/71/af4GCcNoWXM7d+SRCxG4d5QAzOP2VE2Ie65bScCB53f9rZG+jz+ReoXctWZ6SY0O
	ta/PoaUEI9JIVZ2c81cjHjxfFle08BDv6Y0KkecjPwNjJH75vy0wjF06d5nphdJ9NkyXkMJJBGM
	96cIhXfv7QarwXFNetllz9nOfAV77AXbF6ryM4jnFgkteyfowHxzwehT33fK3k5xoQ
X-Received: by 2002:a05:6122:459b:b0:56a:f015:82c7 with SMTP id 71dfb90a1353d-56b4752d736mr953733e0c.9.1773235412965;
        Wed, 11 Mar 2026 06:23:32 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b4649c813sm917883e0c.15.2026.03.11.06.23.32
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:23:32 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2424114e0c.1
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 06:23:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6YyfAKl+IN4R00sNSQ2D+rUKB/y0G83XPfs54nCgV1Fm2DkOmWpycrIDA8kbZGiDNVi7tfw==@lists.linux.dev
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
