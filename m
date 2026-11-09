Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214238;
	b=hymvZBCVWGQuwUIqE7Ev9LhI0mb4TQ2woIvBPTAVdEfr3De/3nEcb3sFAdrWJ3/kQt4P
	 Xgo5bEn2zu7RYmlvmgyVe9moDB0oXpO/hFSVkvCsnV3C/kSHq9uEOsnfdWmTU5Tx9UJwV
	 jVbcWu52jX4NcHDzOjT8ISWqQO0sjdNPNIQVVLMLmlGs/OB3LlW5du61Cw8PrGu36foK6
	 G4SOXmBXukR6goJ3PThAYIEs2v//nQueTcLjBYsVb33JV0Z3vKB2nPx7zmyv2qRlja3eL
	 Z16tO5wz8xvQd1TEdAUsuhx0wbeSNAG90lV0GWsbP5tA+toUKBC411wE2VtzSHCYl0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vjj4rdSbpcMkkjnNoByhSOYk/2BEXBPon42q9R20zeY=;
	b=ryjpYeC1KEMWsjZA9sbNnYtofuCBKvk3diNWKo6S7Kwt3tbYYcIGMrf/jY4LjVl2UKqQ
	 4vol9GbRrQcAf81U1KQPrTter6GQBAhoN92NLE0Vwl5DknxmlpzPXOjnquUrl0YMdVQTz
	 Cfktd3NBfgwii6XaCIAte5xrYYKTV5zUfYN2iuSH0RftZpzbF2hcC2IdFeZkl+ioqsLS0
	 FectWfHkQODNZK2xMcRFRE0vaNnBLLjK7h6uGs2wewU5WZYGV3wpH1/L4EBf3KUovOs7U
	 6sWyB0CUFvtrW/7wb++Br8uvW6lagBwXWNeRXVp+OzS8Y5xVolQLeY+NMuWUkql7dyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpAGTtQ8;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EB606A323
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 08:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86EB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RpAGTtQ8
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so5478875e9.3
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 00:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794214236; x=1794819036; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vjj4rdSbpcMkkjnNoByhSOYk/2BEXBPon42q9R20zeY=;
        b=RpAGTtQ8VhddT3RKknymSaauGoGicxY4DpLihs3kKesJVVHpCx4G2bBL2WPGw+s4Gl
         YG6yUWS+lTa8UX5pbeJuq+iYxm3HrOt3JO1gWRIgzruMTUQq/+InVDpATJ7Z8HbYZ0rO
         HPdtfR6l6aMUeNR4lzt8ECrawh1wfvsgsi2nBW2a1s8TUW542V+RADSOwR5trlq6mCIR
         wyVJhG5V8kZFXYg3zhdr2sSpIeWhxeYzhYKukVsjPVEoFEhvD3sA56fKQHWhCW8aGtI9
         LMPSzjyRXaYj9qyYOWHD2lHzDe5reL9zXOvbgKp34G24gTJOfeC9DwpwaAkq70d7YJSs
         R6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794214236; x=1794819036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vjj4rdSbpcMkkjnNoByhSOYk/2BEXBPon42q9R20zeY=;
        b=eR25k0b+M8pi8AP934ppBEK/m7Zf/mkc9ckxWLX2IHcw4xAdz7EDWmEw1mlg4Sz2Bf
         b6wLyTJzOTL0NOarwlHW/kyCSxo7gQpeQuxt5wk2xE4A/4C5m7Z5dRfeAU2kiFf6nnr8
         w2YIZBYC855CHoKDEg3rzQGcnRnepHBsFzZPjSIWBhDxwjz1wmVCURO3JHHSSjOh2P9B
         C8tFGpWxw8vJE2k5fsOmX5cYPvleWBisCEpGaodwcu1OHHOLtgeuhCvqhINbNmOTTYQn
         iH0Mhs/2xRB7nSM8vyJ1cp3PPuP0nCbSCnofQrPuelBWyA4+UJ/fWW+VCxAa6eJfNAMq
         8wug==
X-Forwarded-Encrypted: i=1; AL+hErF6l337HXawyUa5ivMNwHgp8/FQLKnd2D2pbgU61cTUODgvxrO052cr2dnvLIZnKTEBHDS50w==@lists.linux.dev
X-Gm-Message-State: APuU4Z9febHOxnBbY3OKWjr9E7DGIa4afhzfAJnfD6a88ZCLXQGfNj8U
	xHhEwqThEHQsVE2xi2GoFrNXPYARPV4O73SseLUbYY9qKkH/EQlN1O1M
X-Gm-Gg: AYBFou1V9WbFcLCXdlkZMqxni7SPsiFc7O57Bh0O584G8Gq5o1ZHjUqFXLXIY1Ff2CY
	nlw9MYVPQZa4iFzr91SEDIsSe+3rMGP6qWKAntkbU7ElHU4IXMtqnxiBd5ESuByd6sR0wIEOziE
	jynlX+mC9g/cBrtxx2JqfhJSGvaxTP0tJ0UiQ338aLvTPE7E6TFiGL1YWbEVOKkjyrCvdDNt1SB
	0CpmnNyjhI4SqidLPLCRidhblPC4vZ/criFSXvlHURGKMxoILfuFPjd87NtBAyZCagi4N+JOyWK
	nrS/ukknTkg3s83N93kytdhADCOoOUk7tbk4jA6yAjYKmxkekzdvz/o1h8rEl+XTfWttAYQtiP3
	RRxxXpv4PHfkcIQaSB+XeX+mPWAdTwDvJloAIEIg5Ouk2RNAJRHfchu+cDAHtYrQAs5Vkfn77QT
	JudDVKyFX+WlAvVRnBW1TapV6wdVhj5kSRpWLsibYadZUmwKFf/9d4QRnEFveqnqJ/frNson5NX
	IKmLuDOR5WiMXdhPLwg37nC5wq6xHXFcpcbP6RGBcflMb+B8YqMKBdao2/wTolRGSWHbf378Bez
	5SQv2vgOOLvFKGdJT014/ZXATnE=
X-Received: by 2002:a05:600c:3b1a:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4b963c7e496mr65389125e9.29.1794214235848;
        Mon, 09 Nov 2026 00:50:35 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502d5b1sm147015055e9.5.2026.11.09.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:50:35 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Guru Das Srinagesh <linux@gurudas.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Lee Jones <lee@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	Stanley Jhu <stanleyjhu@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Georgi Djakov <djakov@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 16/17] arm64: dts: qcom: Add initial Halliday dtsi
Date: Mon,  9 Nov 2026 08:50:19 +0000
Message-ID: <20261109085019.1751534-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9dbfc665-089c-45f7-bca2-74caee322885@kernel.org>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com> <20261109-halliday-dts-v1-16-289114ab8197@gmail.com> <9dbfc665-089c-45f7-bca2-74caee322885@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 09/11/2026 09:29, Krzysztof Kozlowski wrote:
> Odd license, suggests you copied it.
>
> You should retain original copyrights as well.

The license is BSD-3-Clause because I used sm8550.dtsi as the template
for the node layout. The values come from Qualcomm's downstream
anorak.dtsi, which has no license or copyright header. v2 will add the
Linaro copyright from sm8550.dtsi. I'll fix the other comments in v2
too.

Stanislav
