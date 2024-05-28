Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF81791EB
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929000; cv=none; b=aZE2LrPMIQKfEqtjBSN3KZ3yHTyoj3Uj0QJ8EuppplWk9hhcMVLx4itEMJKlmFLLC3dQti3QsHxlvbV3hVU/nxQcNM9mWNc7/PdHn43NJ6D0PjWe1TRez1vmQhRqLefPG5UXwyzNRvHhEmTNcZZEj/hDuEwgQMY5dQ3q6hiEEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929000; c=relaxed/simple;
	bh=v3UA2P9PCxB8qntJE31kD9XfJFvq4KatvUFPs4H+tUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVPkP4eZzmUmJm72rYb8oH9iLeMYO7H2nlkn9wnZrj8moZonUn+m42HkNbU7QqEcL8oMkN7aiQWHHmiac7VamP8nczf6/p9yvJyrVDZ8GEL2FxP7+nyQlqj0d2YkVC+TyQ6yWtfKGAihpWKJ/XV+wI0BIDPdBBkjgwpyqDZN1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz9RRzsP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz9RRzsP"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-627f3265898so13653647b3.3
        for <iommu@lists.linux.dev>; Tue, 28 May 2024 13:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716928998; x=1717533798; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6c+gB/X9iAcVqDwC6K909E0pFQqaKG2V4g+DKkKYBg=;
        b=Nz9RRzsPxDHB9AsmoRbSymANnqfJLobBKz6h9951LrYrd09A573Yi+EAAnIKbYDb3D
         tCtDRuoCsxi3vgjbl9MJ7XLGnEMyD/cn9lFHKXGciBNPJ0n6yOnWvGn5fc+mPE5JhT29
         EKvl/GTG5iC+YU0u82Uf1t1ob665lwE67j6QOWVM5DHwZRTmhWEcT/CzOYEAQ00KozZi
         O3NanXjmiLBD+A9rLpdbv4lzCIRfGKGPlYXUUeYoZJlIw3ofuVhOkbCSHyhwoIx3VD2M
         YLHGERoeefnZ0i+MRXIbWyChiSf3BHmmH0g4KomA5UAOGSaKfSG8nJp6aUs+sPOGNIpE
         Ltgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928998; x=1717533798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6c+gB/X9iAcVqDwC6K909E0pFQqaKG2V4g+DKkKYBg=;
        b=QmPcUOiqM4SDzQPzD0fbgRsjQicky/4V9hfiO3fWk+pf/hO4+YTnPOD6Uu3hGOesFV
         6wkgThW06wNxcR/4Byfnk604Fxca1r0AY/13mnKo0lnHeg52w4RmsMywU4MqQTidUT+W
         V2H+nUKd519tk0I7B/rAeUNf5GdBUjuPpRrOHwfFCR29wXkLir+ZMh7HwgwTCSsfbmr0
         op4A2mRS+QSt9sQFIxqiYJf8JQx+xFTq9ytdHilE5uIXFvMsyYyn59m3dOF7/0Jr0nX+
         wU9k1lkGgCi10TtrKh4vmYICIp5v71IsChL9bjjcoY+i/vVKtqWltEJE8E9Mt/cXSkAc
         v3iQ==
X-Gm-Message-State: AOJu0YwdqL+pHi9tyODpM0g9vhMpDo9l5CQ8YL2DUATljKUqVpxKqePH
	Vliohz2Gbf8n7jgIbza1XGIsyYk+Ud4MUdTzok44PyfXywg7wz/Va+NC+avcp2W+5pLm9QiIAfA
	UVJZljsoq7RedTx0kJrcSvJ87xEI=
X-Google-Smtp-Source: AGHT+IGyCjDZR5C5Qf9B22ksCqWNg2oK1ssvknPAK6bzyqgf0xqsvt7Mi4w5pGUpLdhSN+tWIJQrMhYb7AVhCryVkF4=
X-Received: by 2002:a81:7cd5:0:b0:607:d285:4d7a with SMTP id
 00721157ae682-62a08f22920mr124646377b3.52.1716928997609; Tue, 28 May 2024
 13:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240528163940.48789-1-vasant.hegde@amd.com> <20240528163940.48789-2-vasant.hegde@amd.com>
In-Reply-To: <20240528163940.48789-2-vasant.hegde@amd.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Tue, 28 May 2024 21:43:06 +0100
Message-ID: <CAP-bSRb=42vFpGyT+BFT4_+Muno7jWqmofBmGoskWReDhL8MpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/amd: Fix Invalid wait context issue
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	Borislav Petkov <bp@alien8.de>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 17:40, Vasant Hegde <vasant.hegde@amd.com> wrote:
>
> With commit c4cb23111103 ("iommu/amd: Add support for enable/disable IOPF")
> we are hitting below issue. This happens because in IOPF enablement path
> it holds spin lock with irq disable and then tries to take mutex lock.
>
> dmesg:
> -----
> [    0.938739] =============================
> [    0.938740] [ BUG: Invalid wait context ]
> [    0.938742] 6.10.0-rc1+ #1 Not tainted
> [    0.938745] -----------------------------
> [    0.938746] swapper/0/1 is trying to lock:
> [    0.938748] ffffffff8c9f01d8 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x78/0x4a0
> [    0.938767] other info that might help us debug this:
> [    0.938768] context-{5:5}
> [    0.938769] 7 locks held by swapper/0/1:
> [    0.938772]  #0: ffff888101a91310 (&group->mutex){+.+.}-{4:4}, at: bus_iommu_probe+0x70/0x160
> [    0.938790]  #1: ffff888101d1f1b8 (&domain->lock){....}-{3:3}, at: amd_iommu_attach_device+0xa5/0x700
> [    0.938799]  #2: ffff888101cc3d18 (&dev_data->lock){....}-{3:3}, at: amd_iommu_attach_device+0xc5/0x700
> [    0.938806]  #3: ffff888100052830 (&iommu->lock){....}-{2:2}, at: amd_iommu_iopf_add_device+0x3f/0xa0
> [    0.938813]  #4: ffffffff8945a340 (console_lock){+.+.}-{0:0}, at: _printk+0x48/0x50
> [    0.938822]  #5: ffffffff8945a390 (console_srcu){....}-{0:0}, at: console_flush_all+0x58/0x4e0
> [    0.938867]  #6: ffffffff82459f80 (console_owner){....}-{0:0}, at: console_flush_all+0x1f0/0x4e0
> [    0.938872] stack backtrace:
> [    0.938874] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc1+ #1
> [    0.938877] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019
>
> Fix above issue by re-arranging code in attach device path:
>   - move device PASID/IOPF enablement outside lock in AMD IOMMU driver.
>     This is safe as core layer holds group->mutex lock before calling
>     iommu_ops->attach_dev.
>
> Reported-by: Borislav Petkov <bp@alien8.de>
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Fixes: c4cb23111103 ("iommu/amd: Add support for enable/disable IOPF")
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Patch works for me.

Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
