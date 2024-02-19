Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99D3C09F
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359888; cv=none; b=g1cnjXsN3BdERya/BOzjvgku5s04/rfpTluINl6vXN/Dv5zLo69QdyLj7GmCDvkQOnORpxHWWlOH6fBdH81k8rw/deM8fRQv6QoneeXVC1+iXAYko8Ideu0HbondBZYSnXyVqbfmZQbIOBNNckxKUoqaOVT4fMN7JDOLaGGlU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359888; c=relaxed/simple;
	bh=KC1W4movdiLyZiAw8wBIqLm4qc3oLkCh4hFtZmiJuK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbciGxD5HW4tUWd18JLNcvHYRnkfw+TVt3cZ7hHHXEFw38R1Q+ax7/Odu/Zsc45FFcP/Nu98BvbjMmoj9otWSORQ9LYBUjszpsZIqBQ77QnykHl1bPex9eko/mUkSi6w8m6YGzVSTj199SqqJaOC5aeBZwe7nZuaY/wlzk+Xn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hO0quN6M; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hO0quN6M"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6080f44d128so18789407b3.2
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708359885; x=1708964685; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NaDQiik2JDIL0PeKm9y0F/+8tJ/709psGRLRage4RWk=;
        b=hO0quN6MK1ROvMf3rK1AHWwNrTnxVp/9ky4FAteBPxX5CnxIs0EFR1itd2xBqiXqy5
         /ckJTf9ApofIl35iwHWC1mFY/hmm4enYKe81sALmWEC+SRswI0c+NlJlw2GPsn6v1sTX
         bIcsv4FLdBSdYkJPdBCKjQZh3KWJNh3KPw44AZETUaCTvcIFFydWzds2jfBKTzYx1UdK
         7EnbkOnKv5K0nzbY8xvLmrSypDhcfazn+EjieT8WTQloO3wKvXcRQzMeug5jX7HHIAwR
         Z4xjURNjxAyYyW7pLtTkQB14XpqDxSaS/96KD2Ek+TfO9WXUNt2VLhkqGw/NIq+toIfC
         cfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708359885; x=1708964685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaDQiik2JDIL0PeKm9y0F/+8tJ/709psGRLRage4RWk=;
        b=Eum8U23qYezLT//lxFn/Z1hHgqaj4L9xk6bL/oeBROFzakgcsFw4c0peZAZiFyMe2j
         ODZ35nEf3KH9oNTBJ4qgscyj5yTNebUs+D4/6kekcBTANVFd2R+vlbejs/IsgwpSyBNM
         VEX0e4+6lgJ1KXPYHudJ6UL41CE4sUuv1obufbYbVL6v45mcEtTeL6lmsAJBl5FrvAf8
         5N+JbvbFLnS/npHDRahnoD5gc3f6wKwDrQxrdVsDSTFW0tG6ApsKZKabS6d2FfeXJZ9H
         vs9PtG2avL5005Aw3fLwad1i3Sw4F6MmVJn2VJSSCjIaKwajge9e78n6dsKFfKQOLXT/
         M0sg==
X-Forwarded-Encrypted: i=1; AJvYcCXYi6BMUxtZJl+bheOizOVyBArR0+qPP/av1CH+JVkIv3GlzJILD+aCTo4uuPpse2Rueeo5q0TFeEM9ah+RQxN/abEk0Zg=
X-Gm-Message-State: AOJu0YxChK1hg+ou29GFZRHJc/PzQYf5YCcYUYQcTQMjQBU3zVZ2/4UJ
	QShiZ//uINa6ZoR1hcCeRQv4IdntBDFTQJVlJgw/g3DoyEX1uovmznQeV3HPuWZsvSaR0ueap73
	EfSKvV7X16CkKemtoWEBvxV+loaGYfUN7ETLx8A==
X-Google-Smtp-Source: AGHT+IHx9hq+4uomsfzHwHOMG8ybN0pw5/DIXd8a2PXMgziIVZttoFOdTG+jTLuvFw8vq/8af7tqw+B3h0ht9+/5HtE=
X-Received: by 2002:a81:ad09:0:b0:607:8351:bbe8 with SMTP id
 l9-20020a81ad09000000b006078351bbe8mr12764734ywh.14.1708359885613; Mon, 19
 Feb 2024 08:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
 <20240219-topic-rb1_gpu-v1-3-d260fa854707@linaro.org> <u7beg6ui3i6nxoaulc3o7ghfkvcsy46ps53k3jynrurdwn6o7o@ppyqoz4jsotc>
 <d212b700-aedb-4653-80e4-36320b33e51e@linaro.org>
In-Reply-To: <d212b700-aedb-4653-80e4-36320b33e51e@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 18:24:34 +0200
Message-ID: <CAA8EJppcqE3rODfFsgaMuN=TqiphvVOBh3UUV81GULrUdsGRJA@mail.gmail.com>
Subject: Re: [PATCH 3/8] clk: qcom: clk-alpha-pll: Add HUAYRA_2290 support
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andrew Halaney <ahalaney@redhat.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 17:01, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 19.02.2024 15:54, Andrew Halaney wrote:
> > On Mon, Feb 19, 2024 at 02:35:48PM +0100, Konrad Dybcio wrote:
> >> Commit 134b55b7e19f ("clk: qcom: support Huayra type Alpha PLL")
> >> introduced an entry to the alpha offsets array, but diving into QCM2290
> >> downstream and some documentation, it turned out that the name Huayra
> >> apparently has been used quite liberally across many chips, even with
> >> noticeably different hardware.
> >>
> >> Introduce another set of offsets and a new configure function for the
> >> Huayra PLL found on QCM2290. This is required e.g. for the consumers
> >> of GPUCC_PLL0 to properly start.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  drivers/clk/qcom/clk-alpha-pll.c | 45 ++++++++++++++++++++++++++++++++++++++++
> >>  drivers/clk/qcom/clk-alpha-pll.h |  3 +++
> >>  2 files changed, 48 insertions(+)
> >>
> >> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> >> index 8a412ef47e16..61b5abd13782 100644
> >> --- a/drivers/clk/qcom/clk-alpha-pll.c
> >> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> >> @@ -244,6 +244,19 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
> >>              [PLL_OFF_OPMODE] = 0x30,
> >>              [PLL_OFF_STATUS] = 0x3c,
> >>      },
> >> +    [CLK_ALPHA_PLL_TYPE_HUAYRA_2290] =  {
> >> +            [PLL_OFF_L_VAL] = 0x04,
> >> +            [PLL_OFF_ALPHA_VAL] = 0x08,
> >> +            [PLL_OFF_USER_CTL] = 0x0c,
> >> +            [PLL_OFF_CONFIG_CTL] = 0x10,
> >> +            [PLL_OFF_CONFIG_CTL_U] = 0x14,
> >> +            [PLL_OFF_CONFIG_CTL_U1] = 0x18,
> >> +            [PLL_OFF_TEST_CTL] = 0x1c,
> >> +            [PLL_OFF_TEST_CTL_U] = 0x20,
> >> +            [PLL_OFF_TEST_CTL_U1] = 0x24,
> >> +            [PLL_OFF_OPMODE] = 0x28,
> >> +            [PLL_OFF_STATUS] = 0x38,
> >> +    },
> >>  };
> >>  EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
> >>
> >> @@ -779,6 +792,38 @@ static long clk_alpha_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> >>      return clamp(rate, min_freq, max_freq);
> >>  }
> >>
> >> +void clk_huayra_2290_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
> >> +                               const struct alpha_pll_config *config)
> >> +{
> >> +    clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
> >> +    clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
> >> +    clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll), config->config_ctl_hi1_val);
> >> +    clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
> >> +    clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
> >> +    clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
> >> +    clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
> >> +    clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
> >> +    clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll), config->user_ctl_val);
> >> +
> >> +    /* Set PLL_BYPASSNL */
> >> +    regmap_update_bits(regmap, PLL_MODE(pll), PLL_BYPASSNL, PLL_BYPASSNL);
> >> +
> >> +    /* Wait 5 us between setting BYPASS and deasserting reset */
> >> +    mb();
> >> +    udelay(5);
> >> +
> >> +    /* Take PLL out from reset state */
> >> +    regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
> >> +
> >> +    /* Wait 50us for PLL_LOCK_DET bit to go high */
> >> +    mb();
> >> +    usleep_range(50, 55);
> >
> > I *think* you'd want to use a read to ensure your write goes through
> > prior to your sleep... from memory-barriers.txt:
> >
> >       5. A readX() by a CPU thread from the peripheral will complete before
> >          any subsequent delay() loop can begin execution on the same thread.
> >          This ensures that two MMIO register writes by the CPU to a peripheral
> >          will arrive at least 1us apart if the first write is immediately read
> >          back with readX() and udelay(1) is called prior to the second
> >          writeX():
> >
> >               writel(42, DEVICE_REGISTER_0); // Arrives at the device...
> >               readl(DEVICE_REGISTER_0);
> >               udelay(1);
> >               writel(42, DEVICE_REGISTER_1); // ...at least 1us before this.
> >
> > also https://youtu.be/i6DayghhA8Q?si=7lp0be35q1HRmlnV&t=1677
> > for more references on this topic.
>
> I mentioned this feels very iffy in the cover letter, but it's a combination
> of two things:
>
> 1. i followed what qualcomm downstream code did
>
> 2. qualcomm downstream code is not known for being always correct
>
>
>
> I suppose a readback would be the correct solution, but then it should be
> done for all similar calls in this driver.
>
> Although this code has shipped in literally hundreds of millions of devices
> and it didn't explode badly :P (i'm not defending it, though)

I think the idea behind the code looks pretty close to
clk_alpha_pll_stromer_plus_set_rate(), which uses neither wmb() nor
read-back.


-- 
With best wishes
Dmitry
