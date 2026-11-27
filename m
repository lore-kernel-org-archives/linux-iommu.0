Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795821307;
	b=OkoFxhrqXBt5UWWq16iUAJr3tq/bbNb664F5vKDV15iAl6y8FjdiZMSGMhKRb+WooCyG
	 h0KegIKq+mtV4yhQpUUHQbwAMX2jgApoYlXFkqHInnxVLgjGENTxZaPF8+MlZGvi+Zqn1
	 GGZk/UgRwx/831StwZ1NCjdgrsoVTkmpmqSzlvtwFsmfHuEUIKnVlUqQZqf2eLeoRm06S
	 /f1WPrfw0Y7/mZ1fvRqMPG1NN4E95+GJ1A7b1Cv21zRcDQTMQO/dk4n1wTxzSbD1ZXoLU
	 tI/fSZTR07N1QvNsMwQbrqTrM4aAq0nCqnjOyBoWoh/T+s4dd9DktJYMX7q+0SYPG9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U1M+MDeqlkODjZ50qKjXMO75f40J30DxxF3l7NYSGEM=;
	b=TlbFbuhmqzDahUCX1/KFetA3i99dFInzTxT+8zvnXHwVmwtgSEk/CyyI7NWTmShU6+wB
	 b1pHD3t7U9Vzr8sZpHyuYwm9CrHKfKV4p9/Yl/YOTBxVxV03bZRxtvkY1qo9mLy1mMML1
	 MOVbqFR0FncfUuYsKj+jw7nmaKMT5qM9hx9paoaECQDgVi6irEzU9X1gBKZbWUkOR5IDM
	 riOTEcwNsUyV2SIHqPgDrTKIFStNxlZGhgUKzhF6AoWjuEXPdnLmzgBWuL8rUpP8C+cuo
	 zNmnHPNPuTrhSRfeUiHE4Uf1342X3w7iAQUIs98xKDqxNU21d7KVvGrN/GmT8jqeD9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vabDjH7u;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68B606A33C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 23:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B68B606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vabDjH7u
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e46e449e8so5654793f8f.3
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 15:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795821306; x=1796426106; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1M+MDeqlkODjZ50qKjXMO75f40J30DxxF3l7NYSGEM=;
        b=vabDjH7ufz+EQoK3AA45FhuJjcfsEFN5E9nhHlhm3tIKkfKjVAFG8EJwS2MfbB6CT8
         fe2GMekMUStjbbQ6YplZheDzj8mgsLJ05/QMudPVn2vYdfEPiDiJI3tAf4rZSDK1rKyp
         cjEqTqxeWsDYMWs9woYQF1R4E8pBoCZb3jHLSrqH7avZKSLXXE6dHTaK+bc7cLXMFLif
         icR4Gp5zKQalKKYN5jzcDPqjgPdyg1OxEYL/FcyIHm9sjn0N9T4t7bMitrdxoaGHG3nv
         P3naiVVzl5n5fr5bf7+qXqU29tVwXRqxJpJFjOClu/lnWuLZSDXmRBd8tnzKIb3JAgCV
         d3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795821306; x=1796426106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U1M+MDeqlkODjZ50qKjXMO75f40J30DxxF3l7NYSGEM=;
        b=ROcWvVY82i6Rt/UlJyNLKSEkBS2OYTAu2el+nhUplNTLdA/0Wmu+ooC2uxbjiUZu1/
         UVM71Nd0x3Dj/OPoUXnH6F4y4+2v1CCkA5cTNkXLny9646vIVO9UND8SyCBdQFIH4NlE
         bNw/Qeu7er3yqFEFFSD989uqNixieCSLW2FC870Q+eHSKv4uIImgNgvrkUf+KjGsyLoe
         zkDMmpzIJsyCOVLX181SBinmi+2ey2qXN+I4KXKyfJOcgGdxfx1nbUoLCm9sf33kalrR
         qewot3FusQGJWbTHgW1koYluXuMTfi55M6OQSCZEMjNAKmJrF+hjd+heNg6/5+CzO/xv
         3Jwg==
X-Forwarded-Encrypted: i=1; AL+hErFBCPxjbyd84cUZguijBlzAq5Qck6nTcy1+DQlA2NHLcllrWZ2pkzp28WwCTF9VIBTtpXLvpQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/GVxzeTcA6OfIZf/Vdsee5MEr48dINOkvk0/kywIm/DCmBPARp
	FqQM5rdI5ZRl6N+eQHmMZfmngOXGrY8sjGO/PVE7GgZpFIpsqsQ7HNU+
X-Gm-Gg: AZFdTZdPRqgrh/O2cEIdcdQ/QL9m8WbBPqRqZVhCM4BV7bspkSVftQuDhfJlfTxdAAs
	JB0BU/r1mNiV9RcBLxVNg/m3NzSxFron7dgSk6u6tMa5hK6/PAz3eM8/6iKUT5lINiv3DbWF7u8
	jBE3REg3GBXnHWlbcNdkNBbSHCPb2lULRvVAt1J6hcjbPrRUTQVjUQsvykziB8yVmz3vaqRhACB
	hZkXYklpX9KiKr/56anCBqbZKPPu1iBQdjmXeIocu4zn5R/pIBimS9LLdknS6Xt0ehCkTiuRCHN
	z2ayKWzhpezome0I2N7287p28bHARwQADB5GHhqmE8RNmZc8RvuHu20rQBKTxzohzZ1UO81dIal
	RrCwJwpydJaei72d4OpcO0weybCJ9bkJsr2w5d/wQHUtNnzi5VYWnvEl3qKhbczCTPGOn9adigu
	10RtDusjC4RDsPsYwQWv4j3dR4hoP8M9OttDcmxzWN8U1N0Q0Dv+FSYIWbpgu9Sxi7sVmFpY6HH
	FXrGC4MSfFPEnCsJjR+23NioULqv/NtRxkuDm3tf4GskKMwCEo525wH7fYhP3K+h/ScByO52kms
	u14cLuqfMxnR7ryGgqpl0o1JKqY=
X-Received: by 2002:a05:6000:178f:b0:4bb:c85e:d565 with SMTP id ffacd0b85a97d-4bbc86e17b5mr14733028f8f.55.1795821305534;
        Fri, 27 Nov 2026 15:15:05 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm45269880f8f.23.2026.11.27.15.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 15:15:03 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Guru Das Srinagesh <linux@gurudas.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
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
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 14/14] arm64: dts: qcom: Add Samsung Galaxy XR
Date: Fri, 27 Nov 2026 23:14:45 +0000
Message-ID: <20261127231445.3623202-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87280d80-9047-405b-8dcc-11276d34d2dd@oss.qualcomm.com>
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com> <20261125-halliday-dts-v3-14-5c8311c0b70b@gmail.com> <87280d80-9047-405b-8dcc-11276d34d2dd@oss.qualcomm.com>
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

On Fri, Nov 27, 2026 at 02:58:40PM +0100, Konrad Dybcio wrote:
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Thanks for the review.

I've implemented support for almost all of the hardware in my
local branch and I have found that the headset exists in multiple
revisions.

So, I'd like to make a split:

rename: halliday-samsung-xrvst2.dts -> halliday-samsung-xrvst2.dtsi
add: halliday-samsung-xrvst2-rev22.dts
add: halliday-samsung-xrvst2-rev25.dts

The .dts files will initially contain only compatibles.
The real differences between the revisions are the DMIC drive
strength, the display panels and their supply voltage, so the files
will be 'empty' until I send my sound and display series.

Is it OK if I send the split in a v4, or is it better
to do it in a follow-up?

Best regards,
Stanislav
