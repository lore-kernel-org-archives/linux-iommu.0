Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DB1D2F55
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053350; cv=none; b=L+xuoAg5wDXDiqfMRKXN8k1k/x4dtO5ei9yQ/7lRIRshca3MG7osdwbldFUTNkNUlVNs1TFYQXcI9CXw+vYfzBWtdQ/C4yI6668R250J1TzsZ5Af4rosPekobyqnxAxE0dxYlgHO7qlQSE4+VaILykkgWmUHm7hTsOrYXxs9c1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053350; c=relaxed/simple;
	bh=G9Z7xx9wUle37htzOFI0joTWlzfhv2aXAeez5YH7IZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHv+FCrIKVw+09Sah2ZDAUvABAdOaV4eVRu/tKh5wUMtQ1p+ReXwtFOG6pn/6JG7l+BllAk6WLS5R9ufkThQXI3R/YiQZRSaPC8Dhceu6UBE+U/MfSTpNahHYo21qJkdJ3DnUONYEcYDAgjMGTRqF1e+MGYeQdK5v5+Tow8prF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O32F7+la; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O32F7+la"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c913aso3032550e87.1
        for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 00:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731053345; x=1731658145; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9Z7xx9wUle37htzOFI0joTWlzfhv2aXAeez5YH7IZg=;
        b=O32F7+lanKYqK6PLoJhLTznOMhLQqanKDQmT0p/s8l6IuiUy8y0y8zlCTP3ZfRsROt
         mlkUzvMBGz9w608n4DG4QOaXYN3UU39FrbuLU8z22MxPIGiPAmV1gwlN7esI4c9ZFTLT
         qPUDWbYBKq73Y5Vgsuno9z9eGHKrQsd6GFBwuuRCuk915mds/+4adkAHE29q3qIVihX/
         qgC6Yq926lP5FgIiEjWZrBHJyv5TNgay69+DXZxC7bqVqJe8KgYk9xspoRHSWv1B52lq
         Up5anpLGDlRfLLi01QG7bNouHMRBxoKa/P0t1Wq6gGw1Kbo4MimFbiK6DX8hRZ4sRUpu
         rGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053345; x=1731658145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9Z7xx9wUle37htzOFI0joTWlzfhv2aXAeez5YH7IZg=;
        b=PSL736heaPhI7HgkRhW3AiLZin5F4ok4+YagBLcDbITrUN/iJ1V3iX5goOheszaiXI
         uyKs6gh6v6CntowDmn1J0P0hYqo+7lxS0hBUaiBUr+Dnqsdw6J1f3yMKbHA3BveSpqBv
         wJDvU5YoI2r717XJGGgyMFmyu96UopjxRUsDEjxedtgcYLIzKqiRCFRX63FYDRNT2zxU
         arussxAx7aJaGnPuKIqDW1IJiU99zkw76Wu1yO5NQ2jloaiChV2QLUnGBJCxmX5qH+57
         nTafKbRDo5+m57ktEj9Ci9ibOSTLskJBg7MNAbUJupMyDmrVNHRrRS1TmV+/KasimEUh
         x6LA==
X-Forwarded-Encrypted: i=1; AJvYcCVvsB0ef2ffoNzE9Rq9Gx5z8pRrUZYu0eUxBaK+lO3FaGA1OTqRsCPoz5WOkJVDS7t8rYTtlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMXu68Y8UsBQYhvXY5j/VSOAOqluPnV00aJh8BUOVecwPGzxyN
	jqpt6uv6S5QoBdWO0kdrXVX5mcIx/RSdvuyr/Vr3VDWfLtlw4Nen5Yhg5Wzi53d7Jycjw/bgwzf
	7MYPV5x1223Jheci0yxUoCD/sgoZrUoYXjekEBw==
X-Google-Smtp-Source: AGHT+IF0UB7o0vuS6Bty4AeOnjqYdCjSMRlYLH8+QDSVbXDnav7cLaan9vUhNYyE5wm0llxN2dvFNKermU2/At8KL/Y=
X-Received: by 2002:a05:651c:b06:b0:2fa:cc86:f217 with SMTP id
 38308e7fff4ca-2ff20307f42mr8533711fa.35.1731053345351; Fri, 08 Nov 2024
 00:09:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org> <20241031-msm8917-v2-4-8a075faa89b1@mainlining.org>
In-Reply-To: <20241031-msm8917-v2-4-8a075faa89b1@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:08:54 +0100
Message-ID: <CACRpkdZ8YFfpqmgoahXBk9b88CGKm6Ny0Am4vvUf1ekUz0bEng@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] pinctrl: qcom: spmi-mpp: Add PM8937 compatible
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:19=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> The PM8937 provides 4 MPPs.
> Add a compatible to support them.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied for v6.13.

Yours,
Linus Walleij
