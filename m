Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB829CA
	for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 15:23:27 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so5657458pjb.0
        for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 07:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TDClChrfZ3CM22ZB33Zhm+2Cm6wH/+CI7RGcO5VoIOc=;
        b=AYVTaF/tvAYpuIo2cO2xMxmq3YZvWi6+P+eVf4M2dI7HOuiq+2MDwl9LaSf6k0Q2xf
         NPHYSfR6YtiIB6asp9gGjWy6wsf5bQqUmdZKu8QRBhEQexhf4MPLOISEx2aK/8TtHlRR
         9I0GHuT1G2mp1O09pJVNg/G1QrXj+crjTKvH5W/otSK3mQHE5PUZue0pcWA0IzIY7YIa
         T862w3cdjToAA1KJ8OLiVpzIreW30gXsmU2eQRnmzGYKrelk4mTnN/8Jp6campkRPvy0
         8rzwDwpHB0AKhWdyF6sQB12XHCcM6n9NxBPz8QOhnuMGRR88luDh6utQet3lP0CHMrwn
         QQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDClChrfZ3CM22ZB33Zhm+2Cm6wH/+CI7RGcO5VoIOc=;
        b=QemUp1r9iiXk/dnUpHHbAefptji5wpU6OsCe+Vn4wY8Zq8UcKu+t25GdkOICj8oMwY
         LdmmG/qzp5zatMH9QN9vBVGdGSoMaX78KNP52vdzWp6CKVMNQ7rLNUdAk/0HloRjRBEg
         eicgpaexecbJgzBYEi4ju3TuvkRu7It4Teeo7gNB2elby6Wk8+osGnr8w8NWzzWEeX4q
         M4IYu0KopYbokD12tTHLjz7TPa1nS2XYUNn7VdBZXXKRhi5rbkHXkD3FSZYvdnRAe2tZ
         kjZZrDpT8KBho+JSCsMNuglXQ8hG+q23ZTnrwEqEZvz5Vq9Guh9WEdITkM3g9HI7zspU
         gh4Q==
X-Gm-Message-State: AFqh2kpDbFf4QIcBb5sNGjRpws3A3cyisEA3iuZdZAEANFWs9W+86KA0
	K1lBhzbxAFAyWakEHfCud3WUlt0OGeXhX/CrR47sng==
X-Google-Smtp-Source: AMrXdXtPZ0oPZ7gYP9RSL3je4qwX/SGfRW2HgVpAuXOcyTc9fXtZevwi3y3gE3yeLHcQmvVrDyFyxm2Jmt9mOlc9J18=
X-Received: by 2002:a17:902:dc83:b0:189:9ee0:cca4 with SMTP id
 n3-20020a170902dc8300b001899ee0cca4mr578301pld.74.1671722607302; Thu, 22 Dec
 2022 07:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
 <CGME20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228@eucas1p2.samsung.com>
 <20220726200739.30017-2-semen.protsenko@linaro.org> <7e9e509a-0ef7-087d-e379-14fb58e3e14f@samsung.com>
 <CAPLW+4n-Lf6je61rxdJ9nJnX9h9F8F-y+qikG7eFF0avQpMV9Q@mail.gmail.com>
 <CAPLW+4mPeX-cQR_oLKh+zPwEXuwfQtk2t2USP77C6Y9UmgYq_w@mail.gmail.com> <3751c425-aefa-a3b4-62f4-53d7e369bc1e@samsung.com>
In-Reply-To: <3751c425-aefa-a3b4-62f4-53d7e369bc1e@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 22 Dec 2022 09:23:15 -0600
Message-ID: <CAPLW+4=-cqQPmQi57_ARn1C6LqK+LffrFEgLqi6Lwb=YJ7sRSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/exynos: Abstract getting the fault info
To: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Janghyuck Kim <janghyuck.kim@samsung.com>, 
	Cho KyongHo <pullip.cho@samsung.com>, Daniel Mentz <danielmentz@google.com>, 
	David Virag <virag.david003@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Dec 2022 at 07:20, Marek Szyprowski <m.szyprowski@samsung.com> wrote:

[snip]

> > So, what do you think about this?
>
> Okay, go ahead with your approach. If I find a better way, I will rework
> it then. I would just like to have the code for fault handling for hw
> v1, v5 and v7 similar as much as possible.
>

Thanks, Marek!

Joerg, can you please apply this series? Please let me know if I need
to rebase it first, but I guess there shouldn't be any issues, the
SysMMU driver doesn't seem to get updated often.

> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
