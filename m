Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7E1C5D44
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675726; cv=none; b=Nwbgd+6FcWt4kO2j5yxvU/oUSPfd+np3W35bWsKb89o6hbCl4GtUsv72vePpZzFbbjyEPRAnVYwhi05x6CsMEsoBy9+Kw3SORoX9zPUXnyYsAR6/FlDGld2BrNx7zWN0oIzo0u94LK2oJndhMWJ+cOVLLwuFc1JpRbZwxptKeOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675726; c=relaxed/simple;
	bh=qaZ1U+EgInwMaLZWb6rGxEaSX9h3KvSTvEqAi3ZlncE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+8fk4UwvcEIyU67scGZEIoCKu9UvYMzWxYJQhN4vTx2cUwnO4MfQklY+xxDFkJgFNzaOgSXI/BXAuw/F1KJkEuugeicl93DcImyPTb0UKptQeHNt0ZSavIhM9Z6Jaof7QC0BiYNqC2ht6JY/dsk5eQ8muU+g20CGb07+FE/prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oLZAcIid; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oLZAcIid"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23c8a5053c2so64180415ad.1
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752675724; x=1753280524; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz5RRhyfwITv33oCf/7iVVV0cKwknfvfP+MVHktAv/o=;
        b=oLZAcIidcaFMEnUawsu37CH5MR8cfzNOg42hlGbudQKED1LBFd2EA0i2gW9gk5EjLp
         o2A5zL9aq/26FhN/pgKP2jFDS+/Of3lKeuAZWCJM1BBJM7xZbW3QFbw6cj0tZBGHQY04
         cDzD/w6b5j7IgnHRwI4Xz2yXkPIO4NRvv12WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675724; x=1753280524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz5RRhyfwITv33oCf/7iVVV0cKwknfvfP+MVHktAv/o=;
        b=H3bictDUF3oiNemjc6RgWVSCO19DLV6/xSvmUow1asCvsvi4om5EZrksMhuFxxAAqN
         +MWGYJcZHZAqKBjILGPQvulCll9DFV01N7BXraFj8Mh9TWvJ1tACAaJCjEAIuarPz2cE
         QFY/liEu+xvB7mRwkslK1v9y+LSWgAWRsJL5yBzav3yz+noK9sh3jWJHtSOpU05EpRmD
         5rNCfOrhJ2rkRhlP1XUrS2JN/u/Vx6cLzg7tR+jyVPUzbB3KddLO6CT/cFr83fNMnM72
         Hi+wn4bEtYHeUDtCGEZ1eyiQtsuNLkchsXkbev+mtrZ7xvBvrEYBmCOIItBAvigMDoUe
         EekQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAEQwroeX1X+YGt+W+rUJvt0ibebUZjpTRbd7Pv/WHLpYiJ+Re8JI+EJdyoTRTlL4ymzDxQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBtgKunVF7e0uW1t7r7dzNGwFTr0eitPPrRGcjj3aYdlx++3xJ
	zrrwyFBTxWmjmh4dH0SzpjnqeYXoGbPzDSCUQhXckmKbckSM9CQ+GXfpiqBhN1/EHU0QZaP4hiP
	VOeg=
X-Gm-Gg: ASbGncseWUgy81oKwQ9ViTb12nous3qBtDGE73zJ4CRs6mzT9C/4bj7+BnORzEJdQcd
	oJ289Q923NrYz3qHDeWR2A1E4Cj0cSxW0hFa+oeqJN3BTvDYsBLjRbUIUBJAuLTuN52Z+1mFjfC
	6cZGCMuO83bVxe/jIy47sBPlnQORMqpbgV/ypx72NcyCnw7wR3dzT6uUhsV736O0V1+5SowI33r
	aBDWN4oZ2mNG9LD3FnebXk4vqwxFEcaIkwQb65SrghdzKLu7qMJb1IQH3fnaJtC4zI+BjBVnpwy
	Jisqmfqp0R7IkcuZoo86pkLZtnB8v9GhMMXITUe2hCs+G27eJ9ADnyvxWO3WOyQXz2YlP6zC5kE
	iMPWxC82VQPOPb/e3YWkObM7ZXc+kJz7BPn5u+Y2hHgID57E9ewrLgLRVh8t/7g==
X-Google-Smtp-Source: AGHT+IHzyb0t5yoYMJ7A3djo+PQt7SxHsdbBTX1GoGWU424cJn1ZOidIR+G+Cu1k0lPVsDqlT31ewQ==
X-Received: by 2002:a17:903:3c6c:b0:235:f51f:c9e4 with SMTP id d9443c01a7336-23e24f49430mr56159845ad.12.1752675724326;
        Wed, 16 Jul 2025 07:22:04 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com. [209.85.216.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435d42dsm129204075ad.233.2025.07.16.07.21.53
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:22:02 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so5592925a91.1
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:21:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSmumK1omgBuOg05B2XhEZ1WmFcp/cQxv685Y5+5t6n3h5Mzl3RMpMs+Sx21S4o6jaDTIBnA==@lists.linux.dev
X-Received: by 2002:a17:90b:1646:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-31c9e77cfe5mr4368025a91.26.1752675712704; Wed, 16 Jul 2025
 07:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250716-topic-goodnight_cheza-v2-0-6fa8d3261813@oss.qualcomm.com>
 <20250716-topic-goodnight_cheza-v2-2-6fa8d3261813@oss.qualcomm.com>
In-Reply-To: <20250716-topic-goodnight_cheza-v2-2-6fa8d3261813@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Jul 2025 07:21:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wj=J0-3rpjEsdLzgHzY3nXw0CWaCTHfbkNnu5H=VCPgQ@mail.gmail.com>
X-Gm-Features: Ac12FXzTw0wKAIsfrwSNsVdCEfNSNshL9d8ykTsLQev02btB00hc45WqX4Wa3pM
Message-ID: <CAD=FV=Wj=J0-3rpjEsdLzgHzY3nXw0CWaCTHfbkNnu5H=VCPgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: qcom: Remove sdm845-cheza
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robin.clark@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 16, 2025 at 3:16=E2=80=AFAM 'Konrad Dybcio' via
cros-qcom-dts-watchers <cros-qcom-dts-watchers@chromium.org> wrote:
>
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Cheza was a prototype board, used mainly by the ChromeOS folks.
>
> Almost no working devices are known to exist, and the small amount of
> remaining ones are not in use anymore.
>
> Remove the compatible strings reserved for it, as, quite frankly, Cheza
> is no more.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
