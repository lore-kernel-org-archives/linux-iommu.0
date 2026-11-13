Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531548;
	b=4nTW1LYxtEypqCtkuBL3DDH/j4/OaJVr28iH41e7V7Iv+z5hVkhT716WOmaU2AhCkt+V
	 MTygIyb7RIsUiG/4zZc+QAXcCfU9xyGKWa/QoqGAY6m+tISCs5kh0jGrI104/nhoITZM+
	 FLUhioOP997k9Wxh1R0yC7ZMx/qPXUSvZWXVp08XvBB5sxanEUYh2nVt+sZtWF140kQ9Y
	 inaR4D/Zu2OttfOtXs2VvvcM0igruACJBWTjDsBgvA53LtTl77wTITnWPrLUmm1q6if6Z
	 rHaublK5DaAAxhOkduG7EgW1qAfyFM9BbOpsaAk7Lnk8Xw6sku5022xRC+beKSThRpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
	b=GiHv8mSxmXo9rbauFV+JqSeQ47Eug0tgAsOOCMeaxvB8EQSTuEjU8A841GcFuXZG06zs
	 Lfl2Z8vttGeNHGrzDQRpYf5CWgy6SvKakWn1fR6QQq3OMzonkNDEizgxkdXqhDDNPADVh
	 Cv9azwJT6VnHEnShM0xvpeaVgEmo59J3wB8WiQewZSMt/8asJcJRo5IBRFi3qyN2Q8Uqq
	 AOaByTUnihXpsjHlRiNy59bu2R3sOjJ3uo6P5nvKSHrjuttFTqov10VUindMapnIP4jSa
	 SG2kWJ1T9eTb25xTxO5VnFnS8FbhkQHMyzgePyE9ewBwtOh6bL1OlPzZwM99PTMa30A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CySTOoAw;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F73606A32E
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 00:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F73606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CySTOoAw
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1931ff67a29so52963c88.1
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 16:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794531546; x=1795136346; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
        b=CySTOoAwuXx2jGlxzqIwYEPk0DuLwbJWNjMQn/TNOAA3N1KlalDCuQxTwT4jTUJteS
         c05MoT+c8LK50TEvrNf0CcG5k0Ot8qnN2SrE3byarfUMEwHcatFLfdx3eMEaz1xc8ZXb
         sILUwY1EXPkirNahZcXNSWFlHfkHT6BvyyfvzsOTRyaTGXqvdK9Yvc4Rr4OyVgUspdxX
         XVYvGRKhmaM0FwXU0Z2hXY16WuY599YkHr6FcOkFRt1TKPUPPGtsPfjJeDOKWz/+JwRI
         cG+5j/qgY29GSZZO1BIQ6CvSwt14ABY54pJ+TQYAt6EnlQjFTV3aO4kLt+naettc+mZr
         roeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794531546; x=1795136346;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnHQLMcLsmKQJDyIGTt0mvQnh81+ZXOZVkzwKRQPLt0=;
        b=GP+C7ZqkR6Lcy/FZ/eYcoQXAc6RLqxrVxKKcCCGlBV+PPYvInnrdtS3cCHwuXYY3qM
         Rl6W0SAkrKblV3Tz/JEDW1lltc8bTOg3muspx5kVENn9RLF4+mIbjHmaaBoXG4ZfITYD
         fx1Ug7UxyzdnoQo1r7YGTiuGU0DASmbyvyLvNRzfxkXB5IbOrDpVDNyy/Zuzgg1K2+MM
         FM7GiRs4Gex1APRcVyqYgA6S6q2fHyvkOhKZy+mqjpPck6NJSvp6v6+pSjmGduushMzh
         g6OOZHJriIj31uQRzlfQBgG3QztDcArApuy9gbGfnB9J8e/zJatA2+4uqbNjvJDjo/IK
         3hpw==
X-Forwarded-Encrypted: i=1; AL+hErHculzRrbRqa9bpBm3WNzt8SQvGTIUi+3yXRSZBkR7a0VmeG+/j9Sl/Qk4Ql6JIWeQr5aqHUA==@lists.linux.dev
X-Gm-Message-State: APuU4Z//2XRAyteYyKFAu0V7FzZtCbqUOiqflNxyNeqRJBtdGb+jqQ0r
	Fwr/a+PYVXD41SWygKv1EZSK+yoCstEkjp4jhDDQKPlwVrVJX/LZqwxy
X-Gm-Gg: AYBFou2EnK7adiLpKNPFe1g3HSRH77FuJNitu+EVDoayvZ+6p6ydEn8eaa7z4dsbv9X
	a5pBUTV3xNWX37WkV1s4TXFyI3Q0Zb1dSQWGnBlMRBzUVttPXFOl1DBm9bdExcLBOGN1WPGUNwP
	XNZrsSXpItkefet8vIaFUeRmxXrgJyQr/VtwmtLgaHQfP7LFkjTx9oSEROkqbJqJiJ9GkbmR6Xg
	nr5JLUlqZY9zYMPkDJRz693u3LXb2jtQZI4OAMjy954BvjRWXcA5mwJMM8BB0xO3UltV5BE6JL4
	qRTuNI20Rndxgbe08HcT1PJ1jYaU/otghI7568Krtm1Q03iu2gukCSG/WMa9f/Itk6DjbwBLl3n
	QxliQGoa6FOgcKmwJLSAEUdpevmS187jkzGFz9Ai47UREBcWXzf8Uj2GwVTSY7ElEujeNoXMrYF
	ksYocDyr4bUiZRWDsAjKT99yDIeAgJn0T+sW71GmFCWzuQjLwnUkwfMCYsAT7qiwr2PpaQ6iSak
	2qW2nSnOwsmD0UZKNcok6ziWnyiD0C1whDgnBagggA8iq9+aiMVzO8YTtKldXtMtQyitdihDfVb
	rr1DEEwHC8kFJufcEr751/Fpid0hPRRL8PrOdV1irIXUvi8/EKzKAa3Ptmcf1MWbTqbgMF4=
X-Received: by 2002:a05:7023:a4b:20b0:149:1feb:6d9d with SMTP id a92af1059eb24-1b5030fb74emr1197809c88.19.1794531546379;
        Thu, 12 Nov 2026 16:59:06 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm2760431c88.8.2026.11.12.16.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:59:05 -0800 (PST)
Date: Thu, 12 Nov 2026 16:59:00 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: muzafferkadir@mainlining.org
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 10/11] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
Message-ID: <avZgzxJtnMceNQnJ@google.com>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
 <20261105-msm8952-initial-support-v8-10-311ae8e8f14b@mainlining.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-msm8952-initial-support-v8-10-311ae8e8f14b@mainlining.org>

On Thu, Nov 05, 2026 at 01:54:14PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> GT970 works with GT911 driver, document it to be
> used with GT911 compatible.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Applied, thank you.

-- 
Dmitry
