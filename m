Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76378A34
	for <iommu@lists.linux.dev>; Mon, 24 Oct 2022 14:43:24 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d10so9138785pfh.6
        for <iommu@lists.linux.dev>; Mon, 24 Oct 2022 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yNlbC46TRfjO4MlnZn1FExj0FUKTIwH3UKORF5U6sGQ=;
        b=Es4EpEZ/7KfCCu148bxUT/ZLAQEL0ffN31umqtfqIXtsryPyfHG+ijveeoWKdsEwVj
         ws4sgofwj9mtFyX2I267cCUryhK7XVxZrv/G2Si85eoPil+68AHaBRSif3XAivi5oTQY
         DexBaHc6prK1fIwXD6GmNF15ISuAOrO696BEuOeH1086yi8dP/RWh+S4bO4wtWOkA2fs
         2DU8KpcteUjVK9qYftwK7zChRMjbRw6tfis762SxkZTKJd5tTHZdN0spJ3MAE3MkHJC7
         GgfsUnZTt7d6OgKjBbJz3scyB3jKoFqzHVZRvfgGE3/5W2erU6C5RbkJdd0IDFQ1NIYt
         OA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNlbC46TRfjO4MlnZn1FExj0FUKTIwH3UKORF5U6sGQ=;
        b=aNseAXzHSsTZ3C6h774AIcVihR5EHLdlQzTVv9xUwBED1ewQ+B/BR8ge1miQQsqsUX
         KvVG5hP1Qv7KJXqkMNwn5N2/Mi3IUlIcEeZ5PIDOqFJ4tzN2+5QCRoiEMuedwMhyiRFt
         GVpwZrQLD8GYq3CNdap0k1TXTQpKkGiimbYaiytt+doRtdRSnzU48jBuy2q/tHLYr+y7
         rHcTYUntKXf137pOCda5jF0n+xgOZdtz5uSQ/WKdXdW7+AoRhV+rfqAnuG4oQE09Bv/F
         IAKoOKIEACXYLdj+u/YtT0WpYsvM/DES54PngrAF72F584r09I+ocUchvgf1COpJVg6/
         YBjw==
X-Gm-Message-State: ACrzQf2+1RUkxGYEgmr9oGMZsHdYCMaI6x1rfWYNxBw0Gf6oZzfKDojq
	NKoYfZIZCcixzudOVeGob7XwbC0411OT1VMiNpoDIg==
X-Google-Smtp-Source: AMsMyM6+V/w0F6e/qRcCahdqfRhPnjp6+cR997qvbEEy/9S/U2WRfm/VN7WYHMlx96GtCA7fnpWGoD6JgkAz2IDYbOE=
X-Received: by 2002:aa7:888a:0:b0:56b:c5d0:d17f with SMTP id
 z10-20020aa7888a000000b0056bc5d0d17fmr6264306pfe.25.1666622603809; Mon, 24
 Oct 2022 07:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
 <CGME20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228@eucas1p2.samsung.com>
 <20220726200739.30017-2-semen.protsenko@linaro.org> <7e9e509a-0ef7-087d-e379-14fb58e3e14f@samsung.com>
In-Reply-To: <7e9e509a-0ef7-087d-e379-14fb58e3e14f@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 24 Oct 2022 16:43:12 +0200
Message-ID: <CAPLW+4n-Lf6je61rxdJ9nJnX9h9F8F-y+qikG7eFF0avQpMV9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/exynos: Abstract getting the fault info
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Janghyuck Kim <janghyuck.kim@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, 
	Daniel Mentz <danielmentz@google.com>, David Virag <virag.david003@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Fri, 12 Aug 2022 at 14:25, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Sam,
>

[snip]

> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> I'm not very happy with converting the sysmmu_fault_info arrays into the
> decoding functions. If I got the code right, adding v7 is still possible
> with the current approach. The main advantage of the array-based
> approach is readability and keeping all the information together in a
> single place.
>
> I agree for the items listed above as 'minor functional changes',
> though. Those sysmmu_fault_info arrays might be a part of sysmmu hw
> variant to avoid decoding hw version for each fault.
>
> I'm not sure that the linear scan is so problematic with regards to the
> performance. You really don't want your drivers to trigger IOMMU fault
> so often during normal operation. It is just a way to get some debugging
> information or handle some exception.
>
> You mentioned that the transaction type is read from the separate
> register in case of v7, but your code (here and in second patch) still
> relies on the reported interrupt bits.
>
> Could you try to rework all your changes in a such way, that the
> sysmmu_fault_info arrays are still used? V7 is really very similar to
> the v5 already supported by the current driver.
>

That's actually how I implemented this patch on my first attempt.
Really didn't like it, because a half of existing sysmmu_fault_info
structure doesn't make sense for v7, and some functionality of v7 has
to be implemented separately from that structure. I'd argue that
previous abstraction is just broken, and doesn't work for all SysMMU
versions anymore. It's easy to see how much difference between v5 and
v7, just by looking at corresponding get_fault_info() functions I
implemented. For example, the transaction type is probed from
different registers using different version, etc. There is also the
need to handle new VM/non-VM registers on v7. Also there is some extra
functionality that will be added later, like multiple translation
domains support, which is also quite different from how things done
for v5.

I'd show more specifics to demonstrate my statements above, but alas I
already deleted my initial implementation (which was exactly what you
suggest). This callback-style HAL seems to be a perfect choice, and I
spent several days just experimenting with different approaches and
seeing all pros and cons. And from my point of view, this way is the
best for providing actual solid abstraction, which doesn't require
adding any workarounds on top of that. I understand that my patch
changes the very conception of how IRQ is handled in this driver, but
I'm still convinced it's a proper way to do that for all v1/v5/v7,
especially w.r.t. further v7 additions, to keep the abstraction solid.
Not that I'm lazy and don't want to rework things :) But in this
particular case I'd go with unchanged patches.

Do you think it's reasonable to take this series as is? I can try and
collect more particular code snippets to demonstrate my point, if you
like.

Thanks!

[snip]
