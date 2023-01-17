Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641323DF
	for <iommu@lists.linux.dev>; Tue, 17 Jan 2023 12:45:54 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id d62so17666132ybh.8
        for <iommu@lists.linux.dev>; Tue, 17 Jan 2023 04:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vxknlLDnsxojLcmQ59vK0ZLgoKiVLvxFkDDOG8faM4Q=;
        b=uqcNVH96+N3QhwEoMwCX0XF8bNjcpWqYdeKTdHchHyJ1W9LW/wuK5nUhmLsPUlqcjz
         7kV/qMP8k1vWUT7gagwrWaw7KqPt9kl/O1+irrBaSgnivLTfRy1btFgNHs0Gl7SiH9ji
         A532CpWpeNHRHouB4wkT/dQOWzRCmCVnPNfD0yz9tD2N5LAH6g28XDE2L5EmjbPp6huX
         HmiS0kgY0TYGihNMa3JOOZNERhi1bTob47MaH4+Nrpum65ConMPIFPErUsUSkUeMwqmm
         3hVtI2/l7sxxTNcHAoq5MxayhbFf0SXOt3b2IzUI8MGo0MOoUV//HbK6Oam84fX+IabD
         kN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxknlLDnsxojLcmQ59vK0ZLgoKiVLvxFkDDOG8faM4Q=;
        b=07s4y7hAkfT+g/GDXs0OVCC/eGB+mJN3fKAiWw9TQGCiA93I1k5KJHdjzFm+xSXq++
         H/xd213vndQnS/jRQqrlzC8HVajD6OjfB74lZ7Pi3h1CzFIP4AYlbciGVoPQ2BKNfNFp
         Sl0YZiSf41qReWNOtPzNxOpCIguqbjCJmo8/AVoEXK448ln+P4ua/4suqFmCZw89QRWK
         wtge4XjF8oj3m8Yemir/BM4llZRrYcpiP83YGEJEZ8db2HDhj/oK0oIcvSRqnZKORtT4
         3XxcZhmVVKK3OFMva2jeVC6K7PQrBMriLkWJ5GmgWZhLNybgWQgGt4d2LGxkmUJgstuV
         7UMQ==
X-Gm-Message-State: AFqh2kqIrWwtkTxIjzoesOJcKCaAnFhJMGOmIIj4wmMvLhzD3iEVhk6b
	uaRWsvuGStTMWFHM/k9E5ZWpm3cOO2HdSnQ/hsaCVg==
X-Google-Smtp-Source: AMrXdXuPODb5km1vVWLEOajbQIs4XSX8t9jdXpVQTtsxlKrB6VmMItgiux+DXoc2jwTxQ8qklnWstNG6QM+ZlY6ut2o=
X-Received: by 2002:a25:ca81:0:b0:7d2:891e:ee59 with SMTP id
 a123-20020a25ca81000000b007d2891eee59mr439542ybg.152.1673959553051; Tue, 17
 Jan 2023 04:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230109174511.1740856-1-brgl@bgdev.pl> <20230109174511.1740856-3-brgl@bgdev.pl>
 <bbd21894-234e-542e-80ec-8f2bb11e268e@linaro.org> <843eed4b-552a-a529-83ed-b813c1346c5f@linaro.org>
 <CAMRc=MfTynAACwy+hB+FxOQ=-gA+307viz7LCUk8zmn4H7BaOQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfTynAACwy+hB+FxOQ=-gA+307viz7LCUk8zmn4H7BaOQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 17 Jan 2023 14:45:42 +0200
Message-ID: <CAA8EJpp=w=PurE8GYBOPWmz5GnuXPo8Wyd=Xho0M_yNRciG+0w@mail.gmail.com>
Subject: Re: [PATCH 02/18] clk: qcom: add the GCC driver for sa8775p
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Manivannan Sadhasivam <mani@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Richard Cochran <richardcochran@gmail.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	Shazad Hussain <quic_shazhuss@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jan 2023 at 14:44, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Jan 9, 2023 at 10:06 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 09/01/2023 19:58, Konrad Dybcio wrote:
> > >
> > >
> > > On 9.01.2023 18:44, Bartosz Golaszewski wrote:
> > >> From: Shazad Hussain <quic_shazhuss@quicinc.com>
> > >>
> > >> Add support for the Global Clock Controller found in the QTI SA8775P
> > >> platforms.
> > >>
> > >> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> > >> [Bartosz: made the driver ready for upstream]
> > >> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >> ---
> > > [...]
> > >
> >
> > As the driver didn't get to the list, I'll comment OOB.
> >
> > Please use clk_regmap_phy_mux_ops where applicable (PCIe PIPE clocks).
> >
>
> Looks like it's impossible for this platform as the PCIe PIPE clocks
> have two parents.

That's the point, please check the history of other platforms. XO
becomes the 'off' state rather than being a separate parent.

-- 
With best wishes
Dmitry
