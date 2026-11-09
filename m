Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245938;
	b=AnBd9952GbF8aa/TvBZGcoaIwPQNh0zhzkETpJdTx2Duf9iGrWNlobdsdjcxbrswfwYv
	 zoy1TnYZZ2taxgCXAwK8UJnk9mI936jNbbHUKxfl/4pIRKZg7brkTpMTx5IB4mI2wQGr/
	 0yHjiVp2gYMEOm1/U/u2RC+c6oXDQbtWoqeMei6xM9LXIJlOztHAviFSzcAEuTqNyDUpb
	 o3rr47+9EGKMP6IuwlvQI38lmzlnDbr2WXaP3/MFwmjB9zsD2Djnn2crYY/ZADzvQl7Bt
	 K8M9255cyIBU2JFBefAmKnw782txNHZRnpn28HqfOyrs6ioXpLYnnCbG/t/cTRtU8cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VSgAu1YCz0/TBDQtz025D2yh3sRQq8BFfiF0sq3qrAw=;
	b=xfAUNGmGQCFRjI7Uuu0cfWteN2SUpFMmoTXsnO9trK905o8Iv/bqi1OEgaAkHiDOHBCC
	 I9+63MZIMrgUXv3qdl/em4ieEXCs2XeFBBMVee6MVd15iolnBvyGwke9SUChp4GoDUtlD
	 X4GJTLzZAKm8xjjMX4t6yZz7PHcJcizYt1ud0aiInNj0lTaeTXtJDl6dRJeuG9/sw9fov
	 TnV27Syi0fRgQ2ZUoTW4s11U9tUuIvZxrzzPPqCZf68Kz1jtuG9rLeG/KI68l/baZ7ssj
	 e7Dsj0CqRk2/UPuE3WE4hLQWWKPVwZq10/y2+Cu256mUAU1UeAb78OxqwFXphQ124qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G8TniTJS;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2689B606A31C
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 17:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2689B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G8TniTJS
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so9269805e9.3
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 09:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794245936; x=1794850736; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VSgAu1YCz0/TBDQtz025D2yh3sRQq8BFfiF0sq3qrAw=;
        b=G8TniTJSDzLdXNXKCFglJKd93ls7/mt4l7pIe7aU++0BjFRLy+XtiWWP4QslsWWgcS
         ccYcpIF+HrxyTaIvtoy4lhvPWgNgdW0f6JmaVmEmOfhvgMNBeJ5+R6Lpv7xfpXju+qO7
         xH63NB7V9V0hWQYPwR4DPT4X4VSx/E7GoETJkpg4BRMXa4VF+vh5NCmzdgTLujHXUsH1
         eexg5UReMMs0qBWPBSa6goxJ++NsYTS9fYUFdM5PI/TuNRRFrXmJGWDAWH0/E0Gq8iVG
         j6gSu1J9pNwKgvjKZ0A1nly6FF2XxBAOo//5M+cKUZ5CTrAHsDhCNcOxK3ZOdv/yp8Zy
         Z2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794245936; x=1794850736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VSgAu1YCz0/TBDQtz025D2yh3sRQq8BFfiF0sq3qrAw=;
        b=tuwqRVAlcyYKdePNAsHqxkNtFTmV8yeEFryYw5O2Kn6HpyFxTc8t1vdKhA3tekfa3Y
         9IDzrcWiwBpTro/KYUkq8P+qrc0D+UByqBmNxk2bWueumPQCqrzAZlhOFMhhK7yoMqE3
         y2hyqWDD19OxqFhutbpO/49y45lV0LCNzbh5yuJwUAZP7QNiw33Od9ZNStOciONvYXno
         g07+/Q1EVBujLqY7SxP0hqousN1QtqaJcpjU3j466bmppjWmBKsxwYkpTPzQ2J73G1nQ
         D/VQCbkfcJDxNqzI9NXXYuF9OTB/oX1r2fgUlQmu2n4M6pTmygPuke9LELJdN0SSfT+A
         P8xw==
X-Forwarded-Encrypted: i=1; AL+hErGqvzjwbdSqzbA1Dif9kSqTd7CaCVSHdJj7puVMgdZ+1ET6sk9sFtElY/qBuoc3EGY/eLYhGg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9wDDYA8dcLzKValt71yuK3oYWvJf/UJPQEFfh3t/bTJ4ev7BTK
	wt5uIOSqZzsQb4fp8Yf6TGJlgYlT7e/IKWgf7PlIfkpqqHlEGRPS22eE
X-Gm-Gg: AYBFou2C/JegnA+IH+mtuEFNIbmEpie2FUk4GgdUryWNVVD2L0ScXfwMVEVK+21bZYU
	5GWUFGWSD4ZYEr7KkUHKK8kxFVMBuAw9FhOagTAn16cyAdpwU3qCokb3i6m/+zhBz2mOzEq+OPw
	xTdolWol/u2b2zHowyJBpHZNV6pVjBRDR4J9MWNihkxwEXj0LXrQeVM8aX87oYiLATX90OrsBLw
	SDcHXH7rhHLH6cH+GFIBiER/eo4yRA13/rNSctzW4K0o7Bdj38QYyGnfqWMQs5i/LxdwBoWZ+ZQ
	aVso1rwgX44g99NPtXYWZTORKPWpFKOvK2YuioojDHIS/ilwdIR8fQ93IjwR3nIvPA5cxQwCzzN
	Dc7XBYhn6Zaie5H5YXtJDGYq5md8r9Ql1sDbHNU+wuFjYvN/gUE29xt9syTFGt5r9/+FQwiVwoE
	r/yr0QTqwTiqx8zAjxi+hQJRDjt89QxTOEOGYx6IPUmHAU5lPInBFslBkYuFClNQVGuPca2EeAX
	FGgzejDEFzZJAa8Q/MqihtASM9RAzZrbavDyyEGInN8q25un1YKkqJ1BBZaVhO/rawczo1LdiVt
	NKf+/crrMicV9ChWJfmXOjoA6+k=
X-Received: by 2002:a05:600c:608a:b0:4a0:1b14:e283 with SMTP id 5b1f17b1804b1-4b94d76329cmr92154365e9.1.1794245936334;
        Mon, 09 Nov 2026 09:38:56 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0157b707sm2522005e9.0.2026.11.09.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:38:54 -0800 (PST)
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
Subject: Re: [PATCH 01/17] dt-bindings: arm: qcom-soc: Add Halliday
Date: Mon,  9 Nov 2026 17:38:37 +0000
Message-ID: <20261109173837.2084788-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <78a88d4d-11af-40c1-b063-b6a4d4298ecd@kernel.org>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com> <20261109-halliday-dts-v1-1-289114ab8197@gmail.com> <78a88d4d-11af-40c1-b063-b6a4d4298ecd@kernel.org>
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

On 09/11/2026 09:25, Krzysztof Kozlowski wrote:
> This should be squashed with patch #15. Also, there is no benefit in
> organizing patches within patchset where patches to the SAME subsystem
> are split all over. #1 and #2 targets SoC, then there is a break and
> again we are at SoC at #15.

Thanks, I'll squash it into #15 and keep the SoC patches together in v2.

Stanislav
