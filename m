Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51941221FC3
	for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452889; cv=none; b=B8J/uyI7Om/d1AHtrkyg7z3Koq1NXTivD1fz/ejm18LK7i6f1jt80kc6Gnnb2GyGOY+pm1Jd20QrpMq3Z+AFeqYgSP+jxlw90S1crKJVSTyS4V7I+LwAm/bxrqr9713gsc6kh+EzrTgGPmtGXnTUG0r6Qh49NRGexY7qYQS22kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452889; c=relaxed/simple;
	bh=rNyAWlp56eBFvy36oX5YiZlPyIt11W/cxbD2Iyf2S4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PZn+Z7AWO/DIbI9Q0X44j2ETZjgCKiap+JTXwb2G4OXe5379y1XrB+wm4egpohxLjZNtMe3N+9yFyO7/aZgFZNmuG7YQTufof1n3ijp2+2hVlRk+kYVwe4HR8evH+3VYDpngRBNurAiizBOC8S7KcUUIiWEDe9wff74i6LSHZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=iKmdSCRc; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="iKmdSCRc"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso4223977a12.0
        for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753452886; x=1754057686; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSkJyTrv6R3uiwv3q2J4zn3hDj1JQ7Rtyl+OeDRudNc=;
        b=iKmdSCRclyPtniW5AQXHdbCySijRip1ZkZ2G8JC7wgwjQD+iKTi83dwLKbSEqoE7II
         SrVUto1I++Xe40kmYwYQpEcgLHaeLF3Quy5FfRnCuOZpY69VC0URIorPRqZWKhu7Et6s
         DDGysggyCpOc2lBgbdP4b0S6bDF1rNQp1qgc2xbw2lDOu1gRIr5i5K6q6rw6hkcsYidz
         44UuZSQVhTEjqJUZNTkJfDo2gJKlJTqeaNj8ToEdwrNmRXobcSNNOorUdbuoXqdlMy5Q
         LRg3WVCkaeS3S0pMX5wTi/R30a45etENhiJcODNwG4NX7DS3ISTGeNkN2S1vimzM0rs8
         6FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452886; x=1754057686;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iSkJyTrv6R3uiwv3q2J4zn3hDj1JQ7Rtyl+OeDRudNc=;
        b=o32ibk6QKE9Nhoi1Hd3uJBPVVB7blSnnk/hjFQV3lMvmcoGjF3jlmTlDwmBJUrNl25
         NXV1r1Xn3MH9/RW0kjrjNRiznR6+K6VobWpLoXzFse/J5DSX15oXjtUIrutfnJvTkYfk
         kcy6lJbdDR5Go6gEk3RqCiyi1U9P+QojW/sp51d+97iqug8GE6z902nOMQm1vT2hpKzJ
         r0wqkJEf6jSqIk2PPFUhM7VUpFvdeMrx3JeaLxmZZYmM1lrvxlCCSfhAq5U4qQ8KUs6T
         2l8c2ZtYwUpFJG9TA85l5JQGU8zBAgacKj4CRKT7RUqLtC9BJdnz1ZQk05H8G95NoAgd
         CLdA==
X-Forwarded-Encrypted: i=1; AJvYcCUZwT/yobqklU6u1iuNE1RP0yvdZIpGumU56+3KKORdxmljMrbSNsQm7Okjgq2Tfvj1fNfRVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLFoX+1R6iM7D5sJ97aNGhv/WHfJZUiP5htiyHaffIg81uI1+m
	TTba+3qwQbMQ5vcdnIqPM/K5fG2V7FzSqokp1SD6nDhPcVTSeUQRxNDky+cf9cu3mHk=
X-Gm-Gg: ASbGnctt5s3bcg26MxdJUZVEoBdUQCfnaK/rAAcso/50XO0wRDBSyls4q7QZMnMCyq8
	XkxLx3Rmx8v9smpbPI2/t5gbalJugj+ftLAvRRxrZxQmkvCkjUxz3af6tiwv4V+xjLqHduVf8aU
	rDRPu70mqC1Hmd+Sg9qhPddSgRHFg4zz1Pn7JgIJhknl8J8Uie8AbPD07AO7w6IxOjaTilmNDJP
	5vpVWR0fv6D2ODnuB92AVBy0PPi2wuL+NCmgyVyCTAZvQOzKtnIxWYziEwwIvvZ6Epvw27UvV+a
	8ElXqe+h08iRV3PUemNSvFSeK4RqHJWHjLDuO/cg8Snqb3hXs/Ts0OCOzAllFk736mFG6rCu6bL
	eteylDnqh7WNe7ON2v4GM2PGqXtDwFmM7OOFQ5C+an9DDZT2YkPpXDuwYEVphiMaBNCw=
X-Google-Smtp-Source: AGHT+IGz463msOz8qJcurxvgKtRb5VKMVkS2t8llkd59+2lECxEEVtdl6gBW3cfbqM7OYO38KYCWFg==
X-Received: by 2002:a05:6402:3595:b0:604:e440:1d0b with SMTP id 4fb4d7f45d1cf-614f1a88810mr1744941a12.4.1753452885513;
        Fri, 25 Jul 2025 07:14:45 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614d907a40csm1635236a12.15.2025.07.25.07.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 07:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 16:14:44 +0200
Message-Id: <DBL766O111UP.1IBG5Q30DCEQS@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 06/14] dt-bindings: mailbox: qcom-ipcc: document the
 SM7635 Inter-Processor Communication Controller
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Will Deacon"
 <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Vinod Koul" <vkoul@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Robert Marko"
 <robimarko@gmail.com>, "Das Srinagesh" <quic_gurus@quicinc.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Amit Kucheria" <amitk@kernel.org>, "Thara Gopinath"
 <thara.gopinath@gmail.com>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
 <20250625-sm7635-fp6-initial-v1-6-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-6-d9cd322eac1b@fairphone.com>

Hi Jassi,

On Wed Jun 25, 2025 at 11:23 AM CEST, Luca Weiss wrote:
> Document the Inter-Processor Communication Controller on the SM7635 Platf=
orm.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

I see you picked up this patch[0], but "qcom,sm7635-ipcc" should be
dropped. Only "qcom,milos-ipcc" from v2 should land.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?id=3D872798f61d8bfea857e54aa17baa7b0d3ee24b65

Regards
Luca

> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/D=
ocumentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> index f69c0ec5d19d3dd726a42d86f8a77433267fdf28..6e86ec36a82254ebd73c3067d=
e495795c36c6bee 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> @@ -34,6 +34,7 @@ properties:
>            - qcom,sdx75-ipcc
>            - qcom,sm6350-ipcc
>            - qcom,sm6375-ipcc
> +          - qcom,sm7635-ipcc
>            - qcom,sm8250-ipcc
>            - qcom,sm8350-ipcc
>            - qcom,sm8450-ipcc

