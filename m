Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004866;
	b=vjKmXW9jn2Cx2+2oMqmIUCouGkRnmir1Fowineh2QcmykUErUuB0xoZstqofMKp7/J7P
	 5z8EEkDM6+16/wQtdEUkj0qL1yeGRjcpajSV+2oC7zeViUM9RqBsC2KRHbJqFJrd/j7zR
	 twIW4l84X0XmFq6tJgOHiK6YR9btYpEfy4zXFb5vMZU3KRP75vrNbhrmiu7YC+L31Kn78
	 +lQwSej/4omukKJTdKZIUGuuUf7FZ05dowBJlsB8u+o2jI0n2VEvgOER56e/3omDpnm2A
	 10mIsPshNmjl+xbKHp3IcO4e6j9a7m8FVdsF1RRhFWAUrBaBdMOAn2GbWpH0MWKy/jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Q5C/iHN7Lmzj8RXtCSxUA965C7B7NlmPdCiPikMVO9w=;
	b=IkOpM7/jHITgQq7NqmlevnUrVWNi+/t3LsXvkmcq2Ji5wK44liUKka+pxOWX4QV/cX7R
	 /H2MYqLeAcVjo9TpBqJjt9msDNmnOmMLI9xKcHYYx7DkBYujxSVa+pu+qTNHTm9fOfQyv
	 0MF93TSVzzriuI40nyRsXVtcOv4Dg0oDi/fM4ymGjeYcywJ090eSuE0DFSmym8FalzT59
	 PFYEfaQC3j8zup/x9f5madY1ICgzhjQqubTUhusjcslLa51ttFMsE8jJxfA2r5A+RBU0E
	 KPKGDlEKkatRkAOGdKPLpLKrCdyFh2v6sSAyY2EYTPIkyNMIo1BWfaaxTdpkZ90RAjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=U2O1h4Am;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5EF606A32A
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 12:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D5EF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=U2O1h4Am
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e46e449e8so556013f8f.3
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 04:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795004864; x=1795609664; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q5C/iHN7Lmzj8RXtCSxUA965C7B7NlmPdCiPikMVO9w=;
        b=U2O1h4AmKTM8AguP7vjfBKgbKflXQOJpqvUBcShC+7n6qO0pYIkE40j246gHr2hCPF
         6DpzirYhy2fMJuKegcyERgFHAOcKtBVR9UJ2OFoOP32MzuYy12KIywVO17hKOm4lDu84
         I3n5HBRqbgaaXInCFDhdi3SlKnKm4/YCa9K2u66Qc6xuqyfeMP2SQkBYuX6aUlyCOoSk
         tZVw6UI0+zvweDLXOwz16B47cUKE1oNDtpLrX43FhcZ7KCZEcVcqIxm6frxe9LVVYwPd
         3eOrcaCImwHfeLve/nMhOrjpeuHvVfKJvZ3fQa36tLCXPIu0Ene7mtHMNxsJt7mTyb0y
         6e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795004864; x=1795609664;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5C/iHN7Lmzj8RXtCSxUA965C7B7NlmPdCiPikMVO9w=;
        b=y4nyZiwj62TjbABdERnCFJU56vqUyZKhfnXbAGHNIHgU5XoWsR2vdh5o0Zr2/FEPc6
         FC707jzaPDVKXIf4/kdXAI+NLA+Pf1eK1YkZJBg8KSE2C0wOmN+u8QfJDBKycArPn5QE
         i7pe9lUf+Z8uPB9CA2+taoJRuSY+Dp6SBCz59JXLBB2Pzhcfs//GKYy9F2lAJsXvS89T
         yEjEZVTytmH88xRLXCa7BujwDJPseEAPPDWVc0Uip6OvuppDLpyy7nsJaIJJmoDsHPez
         Z5MH4EkPZmth0xLqYdc8tDrLLbWxzjpZbyaCTozGMUd1YSXAvdU7qYlHZs9BDjKb8rIg
         /N0g==
X-Forwarded-Encrypted: i=1; AL+hErGWSZfLDWiyarydKxWaGdyiJwBnbnu123MbhHznZoCVC/aceWuPdYApX2+H4HqhOtGL8tIdyw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/eqkNfXmkpd3vto7FTmya/5HDD4yYFhQY30zxvd2EAjaunaZmk
	r1klSZc/OOr+L4ImCboJzxuip2gqDpFLfpnVsjH5PpsypjHi1wdrT81mCKCaSf2eIdI=
X-Gm-Gg: AZFdTZfi7eXUmqEbjt6Mk/8cyHUq+XhhXT0ZHPGDRUZSerpIAAT8B2zm5C2vJCfRMHY
	kuFUrZC31N1cHUC+l/nnXiDLw4BiZkiMEPcqe0oVPhU46HhC9CJbXf1OEWbSSxBP1SiGT97VSuR
	as4fHi+rs4eO0J8stQCv1qab++wXsNNxwSYDBZXCDY3OY/zLNaAvUtTXAPT30IzTBcCBLXts2cE
	VJHJdiupko1yxgl7D9wmfTWJyT1Eq8ID3uPkDdnwRD/HA3ifNENW+REIbKO8bId+nyMNnVdP/b0
	BdIA+Jb2sGoxUkbytDr3W/OPQXGOly7zPnprQfkilZAOMgxxE+uRYgXRESviZ0NzGYnBB+7Ua47
	By4O283cXvaxAnTk5HVJ5IKG01VBHVIBolTlIqHbqU+hJyrxXrTdBCRjOo3kJDXJWJioqxjSzib
	jsfEpefFuZdpiT+WUxXMzjknhi2Js9RjkjEjwIOwahvbp9nTvd1qiGHJ4L/XFUb4iOcM3U+xXGZ
	BnlJbCM+bCdcl4AuDXa2vasMm9n7tXvdEKDSePAbsj/DcGN2YzGMuo44kWvxEZvq/nC61c1C1uN
	n6xF2W8LMXAG83scX2ODSYKk0Lv4wJJ5IIrMRjLgXBRrtW2cq64zXdjnUmeTFwMJM73QLGcP91u
	LZg==
X-Received: by 2002:a5d:4f10:0:b0:49c:fde4:1af5 with SMTP id ffacd0b85a97d-4a63bbc41c8mr4416511f8f.54.1795004864445;
        Wed, 18 Nov 2026 04:27:44 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c3a7sm4875705f8f.9.2026.11.18.04.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 04:27:43 -0800 (PST)
Message-ID: <f91804a6-39bc-4a86-b24e-9588327e092e@baylibre.com>
Date: Wed, 18 Nov 2026 12:27:41 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Drake <ddrake@baylibre.com>
Subject: Re: [PATCH v17 04/12] accel/rocket: let the core suspend after a
 reset
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <2afd051e37b8dd4f10e347a3537b0086973d554c.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <2afd051e37b8dd4f10e347a3537b0086973d554c.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14/11/2026 03:05, Jiaxing Hu wrote:
> The earlier test on the ROCK 4D was done on the v15 code: the job after a
> timeout went from all 128 channels wrong to all 128 correct.
> 
> Repeated resets were triggered with a 2 ms job timeout.
> 
> v15 (put, then reset): tested twice; both times the board hung within the
> same second as the first batch of job timeouts, with nothing printed.
> 
> v16 (reset, then put): tested four times; the board never hung.
> 
> So moving pm_runtime_put_autosuspend() after rocket_core_reset() avoids
> the board hanging during a reset.

These sentences (history of the patch series) are commentary rather than
commit message material, they should go after the ---.
See Commentary section in submitting-patches.rst



