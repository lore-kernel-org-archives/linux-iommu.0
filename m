Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB6179956
	for <iommu@lists.linux.dev>; Fri, 26 Jul 2024 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992726; cv=none; b=bwZsotrMaBjWVWxi5PmdMMj849aHSRgpXtLrBAxBTKc8KDuZHPUXAIQaw46nP6aK6SWNl8UadJ7Tgr2sLFg5+ycrr+nXcjl+KoCj9jDcu/0SNIzihbwr8EJfgxh17eWJF4NGEAq23hM93ZL/f3/usrjHZYhyhDI2oxBSc8xhFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992726; c=relaxed/simple;
	bh=ckCyUrhBgaUj/zbznCBeQ3fcpP9VdQ8U2iRFPANaIoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJhZov1JEEPn/xEvPfakHhgCy3wDStM6/TNKi2kqSiNuCgV6DJK0GeFHMZJBr4L2SrTOdjEliTG42c7dhtIovuoDMrqinOcA9olZ+4e1M21ZUk73X+Hk00beYnPirXb+R8v/taHSvm4lGH7HbTJch1NLISba+cLqs13MyNEEwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cDp9ahyi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDp9ahyi"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7d26c2297eso134095066b.2
        for <iommu@lists.linux.dev>; Fri, 26 Jul 2024 04:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721992721; x=1722597521; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RSSre3AYsx9Ck3+Gf7pgOKZ6yzR7bvdD8OyLOsFucA=;
        b=cDp9ahyiVBSuhf0U7TiSOxOAn+SMUBFepuz/5tgJjf/nAEyh0JT7pYTyML0fNbzghA
         ukro+GWgaacWB/opeYI3BbMe2hzRFZB4Cgvaclek46tNygZ1KoGtz+xz8v7OrniywFEO
         xh4XS7BuLZQx49JxHKlGqEZ69xyOsYjHzDgv39UF3lY0H4Aflsgh+zeDrrJBzRRp/rL4
         +MZYh2vpb+VUplgimoXSAX/lNljReaCKJVPL0Zta62q+P6wzrOFZVLPdMiEAvagc5GwE
         HtsX4ShrqHJu3zwczFGXeehEGRGM8s2JBBPQr3vG1qzk3PB2Vo8FwuROOPZnNEz1Nj2T
         Ubpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721992721; x=1722597521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RSSre3AYsx9Ck3+Gf7pgOKZ6yzR7bvdD8OyLOsFucA=;
        b=ALLtLb8lxBENyaQJn2MHsUq3r8wSzRZKpBP6KfvNRzxRxngZ4q8ZCh9d03mPGmsEoG
         8PzCAV/WAmoSTzmhVLLsRQA5H2D/tyv6qY61EhXGLUbEvqSSJlPwZLN3FAUthvk1gLIq
         US/fsvP/E1H31h1d1BbtMtmh18LDgvQc4POkSB3lqZ/rJAlaKV7tYC4Y8eNl+Mys7p4+
         0m1bgMto89ECS5hFrhLAwEZdRgKCMsRUqlZNDj9YnYuwoWl8HZW7vYasB7BmmbvYhZhK
         jxoglkz02jWwNtPuA0CVsmYy7qpYj3aYPIGha4STYzcEmJuv5i38jKLO6YP2+35O2xSe
         bf4A==
X-Forwarded-Encrypted: i=1; AJvYcCWP7IMVhxd4+UIpDwTHb7Lu/kAzShhjdeFnPTFi0AnvyA80yA/L5xesTT9jI2sNIebOVSQkXljjpafVN5pYGYg7CkmOpCo=
X-Gm-Message-State: AOJu0Yx4zK08RyyjxhVJoSCkfUHV//k+VeClZAgYM8aek/1dKIOONvRG
	c/MMaXfhJKVJv2cWmPYWugJyKF+jrDgQON6lsuKnMAq01aDwHRmIAR9I022WbRY=
X-Google-Smtp-Source: AGHT+IGedxxg/izaM1e+VztqZWQWxkaWXqj8R3F912/FfkJgI46WkcgQ7+j+9WvvDIum0fdm0GHjIw==
X-Received: by 2002:a17:907:6d01:b0:a7a:a0c9:124e with SMTP id a640c23a62f3a-a7ac4daffe8mr483108366b.4.1721992720735;
        Fri, 26 Jul 2024 04:18:40 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab233aasm164703166b.8.2024.07.26.04.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:18:40 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Google-Original-From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 26 Jul 2024 13:18:23 +0200
Subject: [PATCH 1/3] mailmap: Add an entry for Konrad Dybcio
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-topic-konrad_email-v1-1-f94665da2919@kernel.org>
References: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
In-Reply-To: <20240726-topic-konrad_email-v1-0-f94665da2919@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721992717; l=857;
 i=konradybcio@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ckCyUrhBgaUj/zbznCBeQ3fcpP9VdQ8U2iRFPANaIoI=;
 b=CNtGakN4VUWxmqa0J8qCXm3ryhK2xBygjVnd3sLEs1hjjigxFk6KXgVO8RguVUgvC2vrvozQN
 0TFoswoCFN/Bf5JR+kUjCYQ/6OyAUzfDbdzncCFa0m34zezBQ43DbYf
X-Developer-Key: i=konradybcio@kernel.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Map my old addresses.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index e51d76df75c2..d189c6424697 100644
--- a/.mailmap
+++ b/.mailmap
@@ -353,6 +353,8 @@ Kenneth Westfield <quic_kwestfie@quicinc.com> <kwestfie@codeaurora.org>
 Kiran Gunda <quic_kgunda@quicinc.com> <kgunda@codeaurora.org>
 Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
 Kishon Vijay Abraham I <kishon@kernel.org> <kishon@ti.com>
+Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@linaro.org>
+Konrad Dybcio <konradybcio@kernel.org> <konrad.dybcio@somainline.org>
 Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
 Koushik <raghavendra.koushik@neterion.com>

-- 
2.45.2

