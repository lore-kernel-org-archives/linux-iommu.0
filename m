Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2991FE44A
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893367; cv=pass; b=O80X0tK/Op1K6nXvOAeqRy0yiD0v+a7cAeB1pCq7rH6cMekUf8YRi8UTVewUXV3rotjVrvd7l5eD6SOyU+DCC9pVD6sR6LLML5zzCvX9QSOGXP/IMd9sa9HoIOmY4rEBlJTdW/WzWPxJkedy8uwjhbWEpTmcgKTmzVdv18Hh44A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893367; c=relaxed/simple;
	bh=jRjHDbuXKLMn6PiuB+tFuhgDq4MLCM9aKggiyanaEng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8OqsHXG9QLBGzaCUnQAsSk1nZ25RPHBmOn4z/BPpT6RdoT1ATCA9+Hv9ra0/f7RmPO0M7oGbu6DE5641KHFeK2W++qHKobN7OY3Dp2Mwh62hd4xavOzfuuOd4lNSK2OEHJ/VFeNZ5OxNH7J7Pi7JJJH4yFTC2Jb7EVcp3G0Tdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MM5zqwgL; arc=pass smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MM5zqwgL"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-1497f78ebc6so788172c88.0
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 15:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790893365; cv=none;
        d=google.com; s=arc-20260327;
        b=lQp+MPC7AHY8ESlSwOn5YOaRHbL3AQsAaPaNfsQOnJNoCiio2+xHp5wJjmEeCbx9ci
         lkUM+ky6NyPXZq9gc9nmVFu4+Uz3J50ZU1FgyzCsWe9nQBYdFioYe0cxzAwy/byev/MT
         h69JU6x3UFuG4Uxy8K62j0VQabbNDU6j2B+NN2GkRenjfzQpDbUG1Rnul4sHzhoUAb2C
         m4N4ZhKiSGOK6ercKH9KKp5iq17EYCOtLfEwfgfE+egGJXYqoZcBrD2eVd5ay7OthMuI
         RqQJnsyjsHyAU8uaketApvnpCiuRu+HTV9uwsC1yvo42D0K2yQpBbUd6aYgLlFGUZCcN
         yTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wfKwgJtYMsEYEWlSf+SsfhmhLRaFUNim0MEAFnPkGYc=;
        fh=xk0/dF3YR9Hrt26j7kp59U+MrY1kQ//2tMXGyzQBi/A=;
        b=P49V6NHMQepKUEe2vqii9mjLEUFS5RqPokvOPgLYq9K7HXjdvQcerMw0+2KqjmSsGQ
         LqpB2ZnAlSAmz1quqqdVKQquE47vah42HBqG2DRpBeh4ILAbXJUGkud6pJ5KfzSNO68r
         MovMybJTvChNI4LAvJ0mIuImtmOIsOKv+88z8G6M0V3FiWFMb+VRC9CjcyL4b8ytvMqn
         /vphVbamKv3w6fOsyNZLPLtiw+S1wTSVpLkae5VCrVOmyOeq60E8mIC8K5mokkiHjT8W
         M6I5t5Hj5hNWhIQ1gpntHyVyw+dDrWrGXCL3hoM9KLvPGu+Jj28alKhmcrViCg6iXJK3
         ZXqQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790893365; x=1791498165; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wfKwgJtYMsEYEWlSf+SsfhmhLRaFUNim0MEAFnPkGYc=;
        b=MM5zqwgLk2LCZe7o2QUG+vBIaXrXG2/gH0F1yFIwHyVpBe1eOCraQrIYxUZl940ilG
         pClnc/NT+TTgnwncQvCx2QPRom9y1YB6OMM9SViz8stK9AZ1ldpXOmrbgTOLshC3uVfy
         BAfD4he5tlUbr9OUDlRDNB//eIqNJ1QDyD33i20B+MRLX2GqT67f9X0xoPP2y5A7lLit
         lwAsjlxziNfBwuedYxCvj8lx1E3tyakGHctV1JJQLyrWpezVexd+d1Gci1jp37h1047M
         /WE9n4XmZtr5burbcBE63Z5a59Qm0kydVZQsiLWrKdP5YkGg41q3/hFkVgv4abDReXBd
         g30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790893365; x=1791498165;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wfKwgJtYMsEYEWlSf+SsfhmhLRaFUNim0MEAFnPkGYc=;
        b=j9rdPA86Et7HHjDzQuc3pZtO/DaDgoxpo94A1UfmZ9Rf/g7TfGp2mG9pYKkj7COT1y
         pJ1yX8UQBbs/gHbEM0xYNKfN5vT2xNGVViIjBolGtGarz57LYw+dHAg4H6pqGxxSdhbx
         xXLBa1bjDrMcHSIO5qaWAkZZLlldU5m7Wgx/edLoCf1LqHjfQQuDSi0D0OQRvwJOqOlU
         QyPVJZe5/gP8IEak6eDizx+NngoEMs5hDQezxUPFF/fzY8y0ZSogWBZkxGAaCAkyWJPH
         NAb5VeHsCokt6i0FHCie1D9GRui+BOntuy1UTvEgF+rgZvseE3r9BPQigdWmUEZxqjxX
         SazQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmkTLUqmeAyJ3yJcPOcf8C96Chj6FWny6BXYbptUD0envc3MS6IAVupG7GWPLHsb1zJLe39A==@lists.linux.dev
X-Gm-Message-State: AFuF++khmLo2UDaczQEAoYnpH9h2otGOhID7D/+PBGPfbMY3Fy9VjenT
	bscBEwPN4C52lXuV+oSFJuF5bW+D8rJCMifWRI7gmYkrGwSIeAY5n1sxuTWQ3RMiocTvIhdyr3D
	woIotXrttoKjD5JD0EmXl1pIhF6ssb/itTxULNrlP
X-Gm-Gg: AYBFou3V5QT8+6luxJoR2EbV2h3Eu7fnmoBWe68mZ5q+g2gOiKZ1LIA8yc//L+OmG7S
	r9D6Ea+ryygThUElGYY28dncD5LHbVihU4WaGnYjiDKxQzDQI4YD5fmQsBhU5LJplCZT4vosZrW
	Uled64yCEA81hlxdeSZZSUB5QJBgQsVitNQxQEFGpvXOuSQsTTneC3Hu5W3kZ8UQ6rQU5Y30Lfn
	FtfaagaGfm3a6ZC+vImxU/yk9R4jhdxV/yPNghrsQCibvRysP/jj+oEEotflq/DNje6KBUZ5ibU
	Z1JVdW73QcnKmjlYlCTIuNg6S2s3elTvLn2WyeFivtsXNY3yU27WVKbDhBphm7iH
X-Received: by 2002:a05:701b:42d3:20b0:143:72b1:9004 with SMTP id
 a92af1059eb24-14f5cbd2c4bmr587221c88.45.1790893363916; Thu, 01 Oct 2026
 15:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260517114026.6817-1-vasant.hegde@amd.com> <amc-s_W_TjLYnbw0@8bytes.org>
In-Reply-To: <amc-s_W_TjLYnbw0@8bytes.org>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 1 Oct 2026 15:22:07 -0700
X-Gm-Features: AclHuK_pUfvqEqlIhxon9tDrY8mIgK0Ky_lHDUxAV5-XvBm5W49T2B5l4bbA0VI
Message-ID: <CAJpZYjVRRsof8KsgOfGL1ZBE8zM5hTY1+U5PHdz9=gkSfeRw9A@mail.gmail.com>
Subject: Re: [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Vasant Hegde <vasant.hegde@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, x86@kernel.org, 
	dave.hansen@linux.intel.com, tglx@kernel.org, bp@alien8.de, hpa@zytor.com, 
	iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping for attention.

Thanks,
CT

On Mon, Jul 27, 2026 at 4:26=E2=80=AFAM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> On Sun, May 17, 2026 at 11:40:26AM +0000, Vasant Hegde wrote:
> > IOMMU performance counters are accessed via MMIO space. Currently IOMMU
> > PMUs uses a single global cpumask (iommu_cpumask) shared across all AMD
> > IOMMU PMU instances. This prevents collecting per-socket numbers
> > (ex: perf stat --per-socket).
> >
> > Fix this by adjusting cpumask based on IOMMUs NUMA node.
> >
> > Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> > ---
> >  arch/x86/events/amd/iommu.c | 29 +++++++++++++++++++++++------
> >  drivers/iommu/amd/init.c    |  7 +++++++
> >  include/linux/amd-iommu.h   |  1 +
> >  3 files changed, 31 insertions(+), 6 deletions(-)
>
> Acked-by: Joerg Roedel <joerg.roedel@amd.com>
>
>
