Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301083D88
	for <iommu@lists.linux.dev>; Mon,  8 Aug 2022 17:19:12 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id z6so6177895lfu.9
        for <iommu@lists.linux.dev>; Mon, 08 Aug 2022 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KbpI7aX4OJn+9ta7EZh2prJEXa1vTXGHPmj5GWJjFZo=;
        b=zlnytlGmuMZ+psy1MdlUiNxuXSiE8ZCQ3Gv5Frvlh8cCNKqt2vz3RyTbRK256z5CKX
         ZiuNuhAA8KA12Bt3I+BbNroQ91a8BPiMqx26a8cX96K41jkiGVK44WiqKCvPLcROB+9h
         RMY9cVTGaADY3Uew5DmA0cBp4ZUot3wxoLoTqCOQpZLlYII++6Brua3pyU1+ydwOM6IJ
         BUIgerP4Y+W2XoSWVc4fw9+o932Bj9skOfT3gBECuXD55/9/WtQgc5G5Avryql3RS6ZX
         KJKJOgYLQ3PSDLNrWyUjEk0LQY6DhY4+0EDzjqUJLHD/X7Z4ysu2yu2jnnBvISNlVRJd
         fEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KbpI7aX4OJn+9ta7EZh2prJEXa1vTXGHPmj5GWJjFZo=;
        b=TDnp1gSeq8e4o5h4KMICW6YPD3SDcdunIBeYLZFCvExndfNEwSFtU7r3Pjv2TL696G
         lNlt7YzDb4W/cdxiBwMh0nkskaGorDdIG4QFocBmdB5OAUQtPXWdrHOF5O6D+cY32OSB
         ORTlc2Z0LRavPUhm5ZsuEzvvZQ1R+Z70N5LxtmErm6F4zEzVejMGs1xdgCHYw1e87CyE
         4wXqad99YdfwyUitAklAl4pLaaaQ7rCO4GFBYAGXQJDMMJFZkueASO/jOG/3yvjT3tud
         NUECQ4pFFEAOV2KulrArusO88bZZDitmWaRk1xcA8Br+dETbR6GB16VoJLj14uFXTpy5
         8zmg==
X-Gm-Message-State: ACgBeo0zZKmxpweuUelhLSpSg2gCuViqp3ldIBXA7RyWDMPsOCFt5ufD
	DQuvImy6YDEFWdzHKEu/Ff1RCQzIOzsi320/y5F1+w==
X-Google-Smtp-Source: AA6agR60RUwt3/4FZq6vv68Rd14ohShJ+6I1vuQ8pNpdWDWPZ27+sATnt0BnfGxwaXqeGnKcTp+CfCCKh4dFy7ZrKgQ=
X-Received: by 2002:a05:6512:2306:b0:48b:26f3:91b1 with SMTP id
 o6-20020a056512230600b0048b26f391b1mr6621555lfu.11.1659979150181; Mon, 08 Aug
 2022 10:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
In-Reply-To: <20220726200739.30017-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 8 Aug 2022 20:18:58 +0300
Message-ID: <CAPLW+4kG9V03edHFXWJumuK+tmWiiwF5B7d2O6+Mb_XmfBY5Jw@mail.gmail.com>
Subject: Re: [PATCH 0/2] iommu/exynos: Add fault handling on SysMMU v7
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Janghyuck Kim <janghyuck.kim@samsung.com>, 
	Cho KyongHo <pullip.cho@samsung.com>, Daniel Mentz <danielmentz@google.com>, 
	David Virag <virag.david003@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Jul 2022 at 23:07, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Exynos IOMMU driver implements fault handling for SysMMU v1..v5. But the
> abstraction currently used is not suited for SysMMU v7, as it has quite
> different fault related register set.
>
> This patch series reworks the mentioned fault handling abstraction and
> adds fault handling support for SysMMU v7.
>
> Sam Protsenko (2):
>   iommu/exynos: Abstract getting the fault info
>   iommu/exynos: Implement fault handling on SysMMU v7
>
>  drivers/iommu/exynos-iommu.c | 208 ++++++++++++++++++++++++-----------
>  1 file changed, 143 insertions(+), 65 deletions(-)
>
> --
> 2.30.2
>

Hi Marek,

Can you please review and test this series? I only have my E850 (which
has VM-capable SysMMU register layout). So it would be nice to check
if it works fine with non-VM SysMMU v7 and older versions.

Thanks!
