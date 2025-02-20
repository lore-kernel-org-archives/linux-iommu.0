Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A331F1315
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047211; cv=none; b=ojTKcLeOOwWFUOmaknNGBlp60OvqDhBBLEJcQ5yg1ASG04MyLPdvkk6XfbBq0XJFwyzTG76MrVXXiJQ9uUhnzZ239YyJ6J8xvR0hN/clHlNNsvvDSW8N16Ou3Td4H9HXJbp1lZ9q7gXO9yyah4r3HlD6dqMfAsWFED9jsM3eiT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047211; c=relaxed/simple;
	bh=7hCRk/ZZGsREb/zcnks6gWvtIsasTKNvtsrHkWuFWBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKllzTNwz442Dpp/bdiIBiaEIEaUzpn7y6+ciFnqngNuj+xdW+Iolr4PxvV3XW7opLBrVtn9YonD7+h6ck1Ya2d46fEkt+yoKLpBn5OqF/MfW0B80y66nYb1s5pXbSPihfH/kGtY2jMDbaQfsCPoNrOdMG/zGB3K0H8hUUoE2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4bbbaef28a5so279980137.0
        for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 02:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047208; x=1740652008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXlZkLtFbkOA04y6wqiHk28O5YC4J8t4Yh5yJXv6QnM=;
        b=lU1iyHMHLzXtKDw70V81dIrpHULEtYaoUSltCpNRh2z4gEucydgJEa2E7At53tSUh7
         wSuK1URq+38r7Ru4x0x3/OGRraxJudWJ7ckadDe6fzJCWEH7yvE6PzIVpB4+Kvj0ix3V
         yY23wyCj1jNN4lC1oaigT4Xn97BpBo0jYKxN2beKR/cev2U5BG9GEv9D34u2n9rB32w+
         j4kgdgTI8tirkcDEOW/nNcDZZvKCEdp9gC/jfOLt8jSpCe2XI2ry5Akd1JZJSBvVSPbp
         +QrOrEo7TktRpgeA77Bf5O0qaRR1SUr5TZvsi3ylgo4Xoq3R2UgyK3esx5s11RfwzCdZ
         BfbA==
X-Forwarded-Encrypted: i=1; AJvYcCUCeqeoOqRsquVjieT7y8njiln1N4rDTg+0d4W30pwFl6obSwvMbsEwTT+Je+fh3Uf6DysMww==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd6EdZyJUvvJ/28x6KOilp5rpMLVEIsALdsXITmNVbvJ/RCTLt
	1QjgSpba3DeKkRFH3+RHrcdlH9iLPGbw4SK1kV9oX/oF1YzOpnn2PpIFVx7C
X-Gm-Gg: ASbGnctTx170fmlLeqTCdeYIyQHd+a9BYo1+LGUqQCUUUPalYWFI/+kUA9g2rJr4NxJ
	pbRWAj+9ejnhcUZy2pfaaJx+w/eT7UfEJkNiUXAd10mveVErCvdPp22jCYtAOw5+HfpBXyZnrfz
	YgiRK0GyEktlRrnxtjBerU9ANNS11eOhssejkJnrwy3b0JDT6YX+pGdBnC4ITzUCgmD8piGEhfT
	9k50URlPlQHMI9qqswB2OXg2fRPs5dP94HgE2z16dJHfw6WeBKIO9Uu5vkAEZ+I/i5xx3ygrwFi
	6vxpcbHDQe874PRws9uXkpN/t4o38pvZK5ZcfROhP9HwDtzKk4jnM/BQ1Q==
X-Google-Smtp-Source: AGHT+IGvkvAvDTY2K+JKqMmpBLuxOoPd3RBONznsbUrWKDjj+cX6/f8GHfQDT+3MXwt1hxvpvsaheQ==
X-Received: by 2002:a05:6102:2910:b0:4bb:d962:62b with SMTP id ada2fe7eead31-4bd3fe38804mr14108965137.24.1740047208358;
        Thu, 20 Feb 2025 02:26:48 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e8583c9dsm3316126241.13.2025.02.20.02.26.47
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:26:47 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-520b9dc56afso226213e0c.1
        for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 02:26:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgN1atcc8DWL1PJ+aewR6s9k/ZhrsAwp0R3Xp0j0b2NKfRDJ1fb0DSW7VKHSaT2OBWoErznQ==@lists.linux.dev
X-Received: by 2002:a05:6122:3d10:b0:51f:4154:c1b2 with SMTP id
 71dfb90a1353d-5209da3cd8fmr11832934e0c.2.1740047207465; Thu, 20 Feb 2025
 02:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ff5b7c88eea8b126ed76029fb57254f29542aa22.1739976486.git.geert+renesas@glider.be>
 <a88b0a48-f7a0-4791-8ea7-a1e599c3313a@arm.com>
In-Reply-To: <a88b0a48-f7a0-4791-8ea7-a1e599c3313a@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Feb 2025 11:26:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUv=47vMmN1UXzFuPotjLJbHPewmz4Uozm+3DuiFasjFw@mail.gmail.com>
X-Gm-Features: AWEUYZnwJCxfhi79EJYpNxgj3_us2bimwf87oFgKJ_SuMD0k5ozIi-i-wp2ym30
Message-ID: <CAMuHMdUv=47vMmN1UXzFuPotjLJbHPewmz4Uozm+3DuiFasjFw@mail.gmail.com>
Subject: Re: [PATCH] iommu: Spelling s/KConfig/Kconfig/
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Wed, 19 Feb 2025 at 16:16, Robin Murphy <robin.murphy@arm.com> wrote:
> On 2025-02-19 2:48 pm, Geert Uytterhoeven wrote:
> > Fix two misspellings of "Kconfig".
>
> Honestly after 6 years and no obvious complaints I'd be inclined to just
> drop those two paragraphs referring to v4.x kernel behaviour, or indeed
> maybe make a move on the aforementioned removal of the whole thing....
>
> Otherwise, frankly when the same thing is referred to 4 different ways
> in the space of 6 sentences - "this Kconfig", "this config", "this
> option", "This Kconfig option", "this config" - I would argue that
> capitalisation is not the biggest issue with this text ;)

Note that now commit 0d2cdc35e805eb50 ("io_uring: Rename KConfig to
Kconfig") is in next-20250220, these are the only misspellings of
Kconfig in the whole tree. Let's hope they don't spread by copy-'n-paste
;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
