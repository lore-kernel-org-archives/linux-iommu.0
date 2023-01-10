Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA628F8
	for <iommu@lists.linux.dev>; Tue, 10 Jan 2023 08:18:41 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id c124so11000000ybb.13
        for <iommu@lists.linux.dev>; Tue, 10 Jan 2023 00:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq6kbFa9Q6XePoTGZMyOqndZFFNOA4hEyY3g6DmupTM=;
        b=peSqu6O2atn6rcoXsO2zx056ilEHN6U4fJ0NwepwoB9a03kpyGWlsG8S+S4f44GhvU
         EomHOSgabfexEYSUmzfCosXXWVBOZsuiRslBuuSRgU+keh/2x8TA7MvepwuS9VPu2Ddm
         UMY6JOeug81X3/FaWz3EYU5q9ZlZk3OJ1VZxDOiXhY93tvHjU1I49Gwcfz0axXtEBboV
         pZo8S18ayW+eMwynh8wWT62o1Hek5swzQJ6xzAndMyPYLWDYNNY6fZdY8tgklzfYDv4B
         jkAjhJb47GCRwwXXEIrK/nZ2njMYdMh/YiWPKWmOKCOpiBT+/kwie4t/xc4BiR8JhLGi
         1ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rq6kbFa9Q6XePoTGZMyOqndZFFNOA4hEyY3g6DmupTM=;
        b=Dm0NZmZv/OO5acBBwnztxPFkdblT4/swDaU7Oc+kCtk9mu6aL7EdW5Urue7RT6bP11
         nKpBIoUor9Vjff7kuYi0kO3A/pE5O8wMRleVUJOyJmXJxtiRNUZms1RdEJGDuRxS/JyR
         bwwMNKVucORto2acI6Hw23bxsSu4FC0hnvVlDZqMqKrunSCBubO/FG8JKz9g1/uuqzwU
         m451EZjSCarm4z6nue583qKKQ3kqLU8z1JbhgYJRGZFloH/DR4p2MvduuyfFiJm8XOjy
         bxAPK0/YSIC0s0BDigyW/c3Bvpwkm+gE8TVh1LtalR6S0UZ5cp0nhbM0dCLiOZsirgo7
         Y6pw==
X-Gm-Message-State: AFqh2kqQ4QVMXiUzJBM31SmHsf4jZOA6Bu1Wy+vaEsFjFGAwz07JeMfp
	w31vqKNMVEzFEq4xWNQ43r3UPZon3NIskS/lQFvqqw==
X-Google-Smtp-Source: AMrXdXuRBov6hoRRwKns5OAP09txTff/z7ySQGBUSEs6TNAFQ9Usf4qJbJA5b0gLCb3g8S1mE0oGzUkYOtYbbFCRf1I=
X-Received: by 2002:a25:4903:0:b0:770:d766:b5e8 with SMTP id
 w3-20020a254903000000b00770d766b5e8mr4722239yba.24.1673338720651; Tue, 10 Jan
 2023 00:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230109174511.1740856-1-brgl@bgdev.pl> <20230109174511.1740856-11-brgl@bgdev.pl>
In-Reply-To: <20230109174511.1740856-11-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Jan 2023 09:18:29 +0100
Message-ID: <CACRpkdb7C763xYvZKc=6-oZtGGtqSwdNK5j_aA16f6j7bR1yqw@mail.gmail.com>
Subject: Re: [PATCH 10/18] pinctrl: qcom: sa8775p: add the pinctrl driver for
 the sa8775p platform
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Manivannan Sadhasivam <mani@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Richard Cochran <richardcochran@gmail.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	Yadu MG <quic_ymg@quicinc.com>, Prasad Sodagudi <quic_psodagud@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 9, 2023 at 6:45 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Yadu MG <quic_ymg@quicinc.com>
>
> Add support for Lemans TLMM configuration and control via the pinctrl
> framework.
>
> Signed-off-by: Yadu MG <quic_ymg@quicinc.com>
> Signed-off-by: Prasad Sodagudi <quic_psodagud@quicinc.com>
> [Bartosz: made the driver ready for upstream]
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Overall looks good, Konrad has some comments to be addressed.
Is this something I can just apply in the next iteration?

Yours,
Linus Walleij
