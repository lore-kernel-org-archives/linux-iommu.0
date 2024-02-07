Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825612232B
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297231; cv=none; b=lzQxDlD3xHeBmAvWQATiekIc/G3aSL2M7Am01wcmvHJWXg6+QmmYwzuXc8RsAUxpFtwoW1UU+iww/V/9b6UUBxTasWSRt6S5F7zvDbNjuyGIhn2ZbE+nWPQiL841e8f4gMvR6a7BeiFtYdX9cpxXTT8ydv+oSUmKB0sN40O5I7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297231; c=relaxed/simple;
	bh=TqmxnL7LhKGRFaus9OcZ6Eu3Xvu+lsumuH85X4Jj9qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfMZRAbKdWy1PmrS9mtqOu3x2HbVHL0laiBrH5UXYCh/Pp/JHrPM93qNmkcBVDChbORB74g9Dk0U/Yr4CJQ63vYOAweWHWpEPrL7DQfYJJ7gInUBM1xm+wFtsYvQ97e+zUZ1SypgkRlMjtvrnvPg3UzqEgM/N+sk9Yxv39+DUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60480ce9933so3652977b3.0
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 01:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297227; x=1707902027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eg3v7z1mB1AjuBlJK36dadneR0u0gyBpWirpxI2xans=;
        b=i7HFFzNg6aktbQmps/Es0Sc7+vdp6VHtimkPDnMkazQ2h9pzcbK+y1RMtMRDWe9HFF
         rx+Af5Gj33BwsLIUeGXWhes8pYP/Zpnte3Pl3A2u1hu5OJ9dfNIhJ/n0a079LZymE5Zg
         PLyRtIpw05UO+w9RYpLzfiAq3+bX5e6/BBBsiAiFUyQeoj98n0VzY8aTdJIM6sxzYkK6
         7G+IzRReuBZcK2ZAbNY3fIClKaaxlHlGWmH7pCZaRjBRWvyGWSMjTNok/xlSwF4rLGzB
         CfOvtu/zEDnz9tCHPuxIzTtHAd8WDD9KNrxEISvNUSV1lc6aoIIGpo/DEpP3t29pYWXx
         7cqQ==
X-Gm-Message-State: AOJu0YyHkjNNX0FOASzm6rXQAImIFx9utNvy6B0mkjJyXXKE2h373oNt
	nRzffJyWEW77vt8q2ckv8i6a1d0oLIWBhpi71/kHJX2TXdr2gnOvnHAuMl5f2Qo=
X-Google-Smtp-Source: AGHT+IG9rzZrTRI4HWyl5DffZq/YJUrzzTew2rl4YFjdWwy0SZMZ/1GyjJP3K+Abw+jP9MjICTiMXQ==
X-Received: by 2002:a81:7309:0:b0:5e7:4cd7:7449 with SMTP id o9-20020a817309000000b005e74cd77449mr4615010ywc.49.1707297227380;
        Wed, 07 Feb 2024 01:13:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX09EB/PXSCNY7SEamMGPCTwS6ZOsuz2sVZUWPDXwo64MxDBZA7s5RjXQfY4+4FcuUb0Wnc3imDEJX9fGde3CX7KSbvEWI=
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id w192-20020a8149c9000000b006029c00d1d4sm188730ywa.43.2024.02.07.01.13.46
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 01:13:46 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d5206e96so369577276.0
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 01:13:46 -0800 (PST)
X-Received: by 2002:a25:84c3:0:b0:dc2:65da:d3af with SMTP id
 x3-20020a2584c3000000b00dc265dad3afmr3965372ybm.65.1707297226259; Wed, 07 Feb
 2024 01:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de> <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
 <596b3bda-3bef-4e28-b9dd-08b96da97097@web.de>
In-Reply-To: <596b3bda-3bef-4e28-b9dd-08b96da97097@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Feb 2024 10:13:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXiszyYM0kc0iqSTDLAXKg_AKmYdc51_8oNwpQUbOWcVg@mail.gmail.com>
Message-ID: <CAMuHMdXiszyYM0kc0iqSTDLAXKg_AKmYdc51_8oNwpQUbOWcVg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/ipmmu-vmsa: Use devm_platform_ioremap_resource()
 in ipmmu_probe()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	kernel-janitors@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:16=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Feb 2024 15:00:23 +0100
>
> A wrapper function is available since the commit 7945f929f1a77a1c8887a97c=
a07f87626858ff42
> ("drivers: provide devm_platform_ioremap_resource()").
>
> * Thus reuse existing functionality instead of keeping duplicate source c=
ode.
>
> * Delete a local variable which became unnecessary with this refactoring.
>
>
> This issue was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>
> v2:
> The transformation pattern was adjusted based on advices by known contrib=
utors.
>
> Examples:
> * Doug Anderson
> * Geert Uytterhoeven
> * Robin Murphy

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
