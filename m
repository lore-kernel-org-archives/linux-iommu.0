Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90C195
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 08:43:38 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id m17so346673uap.7
        for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 00:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CwD8DaTV7HbTR4hShcporK6xZauIpXkKV4HSg2vJsOI=;
        b=aqcrT+v6oIoHD135mvgEusjsxtXhZ8taKAVLc7UdJ3YFZPQ4YP8snRUewKE8gM1u8J
         Y7G4B11Fi1ayid0O9YB+z4drcZqc5ztn92ELVRALm1ynv9EY2lhSugneJzgFaykWgeRl
         Cw+RE47hrNjjpf0Ian1DEYImJr1XUDm5Bqh0kp7GsEUm3Kmn322BuJzh4PB/tCprwV2O
         CmCK9N3o0Qx6QnEBye6uQA2Y1lCCZXm1vrE2hQyRPilw9kdS/syex7rek/iNu4uoQ6GK
         IYYaAoVIw7wvYW1Y1gNAEstfnJlM4/BFiiMgDmUGrfdHLsvb378PbLfw/7o7OsKJpmpN
         bP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwD8DaTV7HbTR4hShcporK6xZauIpXkKV4HSg2vJsOI=;
        b=JrquG+iq147+IpNzWRkFZTuR+QUehY4B+0fkyaG6scnvNp2VHrPw7347r7WbtpPrlu
         jCxI+Hv7f351y0L4yyvGHVcACi7ZS8P8jOiRExrfS1NBFS0db2+/gig9fJvbsBhOftFA
         NQMIutxUGh1hdQQCSfNVizP7vs1FyKavfLuju4QZf5j891gk/FLnohA4/SmIgPwIBm6y
         Ejc/Cv03MX764p8E2y4W1KEbSdpVpF/OSyqCbhpjeejUqK+eZZMxgHvHjZ/jTZ+7/TZh
         7ed7JWf6AjGauQHzRQ3mtwJk3nOlsvKPSRyyppf6KtiwM6WWhtCh55h5FgTL4pXtNjHI
         S4gg==
X-Gm-Message-State: AFqh2kps/g/c4sScU+fs0JrK+SHVGogYPwQk40N5cAfoDVowdQqPHEQF
	i3jCqaprpLsXZsA0gVTtTUV3aK6WNJk/VnARkkaJKw==
X-Google-Smtp-Source: AMrXdXvkfjcS4LxHkJp5jmtmIoknkiHBM4iIQVohRz8hS301Ex+SgUvD6mSYEC8kFB1/MpTkU7BZ5sY0Jb+cvbiq4rI=
X-Received: by 2002:a9f:3748:0:b0:5ab:8b60:2a44 with SMTP id
 a8-20020a9f3748000000b005ab8b602a44mr1179224uae.33.1674117817192; Thu, 19 Jan
 2023 00:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230109174511.1740856-1-brgl@bgdev.pl> <20230109174511.1740856-11-brgl@bgdev.pl>
 <20230110162654.sm7yzyzfucbmuyhx@builder.lan>
In-Reply-To: <20230110162654.sm7yzyzfucbmuyhx@builder.lan>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 19 Jan 2023 09:43:26 +0100
Message-ID: <CAMRc=MdcqfRATCzwpwLskFqZdtS6ELJtyuVGvNMq3Y33uS+5mw@mail.gmail.com>
Subject: Re: [PATCH 10/18] pinctrl: qcom: sa8775p: add the pinctrl driver for
 the sa8775p platform
To: Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	Prasad Sodagudi <quic_psodagud@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Yadu MG <quic_ymg@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 10, 2023 at 5:26 PM Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Mon, Jan 09, 2023 at 06:45:03PM +0100, Bartosz Golaszewski wrote:
> [..]
> > +enum sa8775p_functions {
> > +     msm_mux_gpio,
> > +     msm_mux_atest_char,
> > +     msm_mux_atest_char0,
> > +     msm_mux_atest_char1,
> > +     msm_mux_atest_char2,
> > +     msm_mux_atest_char3,
> > +     msm_mux_atest_usb2,
> > +     msm_mux_atest_usb20,
> > +     msm_mux_atest_usb21,
> > +     msm_mux_atest_usb22,
> > +     msm_mux_atest_usb23,
>
> Please squash these to a single msm_mux_atest.

How about staying consistent with the sc8280xp which is the closest
platform to sa8775p and do a group for atest_char, a separate group
for atest_usb2...

>
> > +     msm_mux_audio_ref,
> > +     msm_mux_cam_mclk,
> > +     msm_mux_cci_async,
> > +     msm_mux_cci_i2c,
> > +     msm_mux_cci_timer0,
> > +     msm_mux_cci_timer1,
> > +     msm_mux_cci_timer2,
> > +     msm_mux_cci_timer3,
> > +     msm_mux_cci_timer4,
> > +     msm_mux_cci_timer5,
> > +     msm_mux_cci_timer6,
> > +     msm_mux_cci_timer7,
> > +     msm_mux_cci_timer8,
> > +     msm_mux_cci_timer9,
> > +     msm_mux_cri_trng,
> > +     msm_mux_cri_trng0,
> > +     msm_mux_cri_trng1,
> > +     msm_mux_dbg_out,
> > +     msm_mux_ddr_bist,
> > +     msm_mux_ddr_pxi0,
> > +     msm_mux_ddr_pxi1,
> > +     msm_mux_ddr_pxi2,
> > +     msm_mux_ddr_pxi3,
> > +     msm_mux_ddr_pxi4,
> > +     msm_mux_ddr_pxi5,
> > +     msm_mux_edp0_hot,
> > +     msm_mux_edp0_lcd,
> > +     msm_mux_edp1_hot,
> > +     msm_mux_edp1_lcd,
> > +     msm_mux_edp2_hot,
> > +     msm_mux_edp2_lcd,
> > +     msm_mux_edp3_hot,
> > +     msm_mux_edp3_lcd,
> > +     msm_mux_emac0_mcg0,
> > +     msm_mux_emac0_mcg1,
> > +     msm_mux_emac0_mcg2,
> > +     msm_mux_emac0_mcg3,
> > +     msm_mux_emac0_mdc,
> > +     msm_mux_emac0_mdio,
> > +     msm_mux_emac0_ptp,
>
> msm_mux_emac0
>
> > +     msm_mux_emac1_mcg0,
> > +     msm_mux_emac1_mcg1,
> > +     msm_mux_emac1_mcg2,
> > +     msm_mux_emac1_mcg3,
> > +     msm_mux_emac1_mdc,
> > +     msm_mux_emac1_mdio,
> > +     msm_mux_emac1_ptp,
>
> msm_mux_emac1
>

...leave these two here as is...

> > +     msm_mux_gcc_gp1,
> > +     msm_mux_gcc_gp2,
> > +     msm_mux_gcc_gp3,
> > +     msm_mux_gcc_gp4,
> > +     msm_mux_gcc_gp5,
> > +     msm_mux_hs0_mi2s,
> > +     msm_mux_hs1_mi2s,
> > +     msm_mux_hs2_mi2s,
> > +     msm_mux_ibi_i3c,
> > +     msm_mux_jitter_bist,
> > +     msm_mux_mdp0_vsync0,
> > +     msm_mux_mdp0_vsync1,
> > +     msm_mux_mdp0_vsync2,
> > +     msm_mux_mdp0_vsync3,
> > +     msm_mux_mdp0_vsync4,
> > +     msm_mux_mdp0_vsync5,
> > +     msm_mux_mdp0_vsync6,
> > +     msm_mux_mdp0_vsync7,
> > +     msm_mux_mdp0_vsync8,
> > +     msm_mux_mdp1_vsync0,
> > +     msm_mux_mdp1_vsync1,
> > +     msm_mux_mdp1_vsync2,
> > +     msm_mux_mdp1_vsync3,
> > +     msm_mux_mdp1_vsync4,
> > +     msm_mux_mdp1_vsync5,
> > +     msm_mux_mdp1_vsync6,
> > +     msm_mux_mdp1_vsync7,
> > +     msm_mux_mdp1_vsync8,
> > +     msm_mux_mdp_vsync,
> > +     msm_mux_mi2s1_data0,
> > +     msm_mux_mi2s1_data1,
> > +     msm_mux_mi2s1_sck,
> > +     msm_mux_mi2s1_ws,
> > +     msm_mux_mi2s2_data0,
> > +     msm_mux_mi2s2_data1,
> > +     msm_mux_mi2s2_sck,
> > +     msm_mux_mi2s2_ws,
> > +     msm_mux_mi2s_mclk0,
> > +     msm_mux_mi2s_mclk1,
> > +     msm_mux_pcie0_clkreq,
> > +     msm_mux_pcie1_clkreq,
> > +     msm_mux_phase_flag0,
> > +     msm_mux_phase_flag1,
> > +     msm_mux_phase_flag10,
> > +     msm_mux_phase_flag11,
> > +     msm_mux_phase_flag12,
> > +     msm_mux_phase_flag13,
> > +     msm_mux_phase_flag14,
> > +     msm_mux_phase_flag15,
> > +     msm_mux_phase_flag16,
> > +     msm_mux_phase_flag17,
> > +     msm_mux_phase_flag18,
> > +     msm_mux_phase_flag19,
> > +     msm_mux_phase_flag2,
> > +     msm_mux_phase_flag20,
> > +     msm_mux_phase_flag21,
> > +     msm_mux_phase_flag22,
> > +     msm_mux_phase_flag23,
> > +     msm_mux_phase_flag24,
> > +     msm_mux_phase_flag25,
> > +     msm_mux_phase_flag26,
> > +     msm_mux_phase_flag27,
> > +     msm_mux_phase_flag28,
> > +     msm_mux_phase_flag29,
> > +     msm_mux_phase_flag3,
> > +     msm_mux_phase_flag30,
> > +     msm_mux_phase_flag31,
> > +     msm_mux_phase_flag4,
> > +     msm_mux_phase_flag5,
> > +     msm_mux_phase_flag6,
> > +     msm_mux_phase_flag7,
> > +     msm_mux_phase_flag8,
> > +     msm_mux_phase_flag9,
>
> msm_mux_phase_flag
>

... change this one as you suggest...

> > +     msm_mux_pll_bist,
> > +     msm_mux_pll_clk,
> > +     msm_mux_prng_rosc0,
> > +     msm_mux_prng_rosc1,
> > +     msm_mux_prng_rosc2,
> > +     msm_mux_prng_rosc3,
> > +     msm_mux_qdss_cti,
> > +     msm_mux_qdss_gpio,
> > +     msm_mux_qdss_gpio0,
> > +     msm_mux_qdss_gpio1,
> > +     msm_mux_qdss_gpio10,
> > +     msm_mux_qdss_gpio11,
> > +     msm_mux_qdss_gpio12,
> > +     msm_mux_qdss_gpio13,
> > +     msm_mux_qdss_gpio14,
> > +     msm_mux_qdss_gpio15,
> > +     msm_mux_qdss_gpio2,
> > +     msm_mux_qdss_gpio3,
> > +     msm_mux_qdss_gpio4,
> > +     msm_mux_qdss_gpio5,
> > +     msm_mux_qdss_gpio6,
> > +     msm_mux_qdss_gpio7,
> > +     msm_mux_qdss_gpio8,
> > +     msm_mux_qdss_gpio9,
>
> msm_mux_qdss

... and have these as qdss_cti and qdss_gpio.

>
> > +     msm_mux_qup0_se0,
> > +     msm_mux_qup0_se1,
> > +     msm_mux_qup0_se2,
> > +     msm_mux_qup0_se3,
> > +     msm_mux_qup0_se4,
> > +     msm_mux_qup0_se5,
> > +     msm_mux_qup1_se0,
> > +     msm_mux_qup1_se1,
> > +     msm_mux_qup1_se2,
> > +     msm_mux_qup1_se3,
> > +     msm_mux_qup1_se4,
> > +     msm_mux_qup1_se5,
> > +     msm_mux_qup1_se6,
> > +     msm_mux_qup2_se0,
> > +     msm_mux_qup2_se1,
> > +     msm_mux_qup2_se2,
> > +     msm_mux_qup2_se3,
> > +     msm_mux_qup2_se4,
> > +     msm_mux_qup2_se5,
> > +     msm_mux_qup2_se6,
> > +     msm_mux_qup3_se0,
> > +     msm_mux_sail_top,
> > +     msm_mux_sailss_emac0,
> > +     msm_mux_sailss_ospi,
> > +     msm_mux_sgmii_phy,
> > +     msm_mux_tb_trig,
> > +     msm_mux_tgu_ch0,
> > +     msm_mux_tgu_ch1,
> > +     msm_mux_tgu_ch2,
> > +     msm_mux_tgu_ch3,
> > +     msm_mux_tgu_ch4,
> > +     msm_mux_tgu_ch5,
> > +     msm_mux_tsense_pwm1,
> > +     msm_mux_tsense_pwm2,
> > +     msm_mux_tsense_pwm3,
> > +     msm_mux_tsense_pwm4,
> > +     msm_mux_usb2phy_ac,
> > +     msm_mux_vsense_trigger,
> > +     msm_mux__,
> > +};
> > +
> [..]
> > +static const struct msm_pingroup sa8775p_groups[] = {
> > +     [0] = PINGROUP(0, _, _, _, _, _, _, _, _, _),
> > +     [1] = PINGROUP(1, pcie0_clkreq, _, _, _, _, _, _, _, _),
> > +     [2] = PINGROUP(2, _, _, _, _, _, _, _, _, _),
> > +     [3] = PINGROUP(3, pcie1_clkreq, _, _, _, _, _, _, _, _),
> > +     [4] = PINGROUP(4, _, _, _, _, _, _, _, _, _),
> > +     [5] = PINGROUP(5, _, _, _, _, _, _, _, _, _),
> > +     [6] = PINGROUP(6, emac0_ptp, emac0_ptp, emac1_ptp, emac1_ptp, _, _, _, _, _),
>
> How is it possible to select the first or the second one of these
> functions when they are named the same?
>

I think Prasad and Yadu (the original authors of the driver) followed
the example from sc8280xp:

c0e4c71a9e7ce (Bjorn Andersson 2022-03-08 14:11:32 -0800 1804) [156] =
PINGROUP(156, qup6, emac0_ptp, emac0_ptp, _, _, _, _),

Do you remember what your original intention was? I also see that the
GPIOs repeat in the groups definitions:

 980 static const char * const emac0_ptp_groups[] = {
 981         "gpio130", "gpio130", "gpio131", "gpio131", "gpio156", "gpio156",
 982         "gpio157", "gpio157", "gpio158", "gpio158", "gpio159", "gpio159",
 983 };

[...]

Bart
