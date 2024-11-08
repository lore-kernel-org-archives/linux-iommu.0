Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0D91D9A47
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053314; cv=none; b=Eiy7lj0XkcPaJMNWnX76aT+Bg/Xa1zNl04Y351HHIzUpbmGYrZ6Ub4OEi60AeKUtHjGeOGIZHai2VE9N8tJT4YbRHa6uh0x0Nuyw2U9M3xYUFH4bAllKoVnqW9YynoeWV7mkg2efHpHJpNE+/JgrdTLSNZlW1zMr2Ipk4vvaZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053314; c=relaxed/simple;
	bh=X564kijAujdsjjH0ORI4+g4gIz95ERPYBq8cJzyP8DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pa1ex0B17pVhkua23YOrx7eEqe+aipJBQ4lwHaB2E6Ui0D2TQqjmIkfsT5bVo6ITN0lSFf3qqhW9q9IuFsmB5UnkrOHeO5bd2H+OfQq0rg23GRBEoYSZ0nUy1YqAVMh6XPDEqCMpVnA/4paS/Q407n0HgYlsMtqICk4Oe4gJAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fs7JRBBl; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fs7JRBBl"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so27895861fa.1
        for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731053311; x=1731658111; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X564kijAujdsjjH0ORI4+g4gIz95ERPYBq8cJzyP8DY=;
        b=Fs7JRBBlaKJeHzNCorBBa1pyeRBrfrzO2tblwckQZFGO5qq6Q1w4lDeodQVcj7qP4R
         TQkVK0TOcJNPOF1OP2NoajK5vKYr8NwGK1HHOHTjBvl2/f1hJWI4AYl/malxzSKGa8oj
         d/2Zpa3U899CsHOXGa4q3ZzFIK/q3nAodDQMViqxs/PWyDsM0QbSH8l8NNisGWQS6bq6
         gloWUo0poNCiYGuIBv7xYFf1mL0dJh2Onz/F7InsxHYs0o//4z9gKX808bPnIge0hQui
         jYLuFgZnzvywDZy4xntztYJZley2NYkqMcrgZAElBxlMWuKTsMVH2A1aBTSvXPzmuoQx
         HOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053311; x=1731658111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X564kijAujdsjjH0ORI4+g4gIz95ERPYBq8cJzyP8DY=;
        b=UrKuNZ4EoMUkss1gHBS5FEykdH6DAh6XGFLxUEU/TilrHXgROGw4ywq1DllM2fVnwH
         xIWujk7KOYBRSLlWxQ9yYto5z+Hc55hEnrhmjzTjJDo+OFWp4JQVv4rRoSYJXq7vTycT
         jthRKrEpXz+kuCOm2STpDRXhN84QYPIeSws2MSfKCcO07F/nOJYpe4RZg1g0P/QLGzgh
         mkcdqifgX9MVwc3YP2jqDgZj8qo7Mg5BZoJgVYKHJCOopJzldmDoXm2fkrkBGZgDMQFl
         aQTU05bGDoDmrFSxQuocPQ20WzS6C8wQ0SFw0I2lSBmbCZX40vCi9BV+i5VsWGkWXKjz
         fqug==
X-Forwarded-Encrypted: i=1; AJvYcCVoAQl9TxAIGLU4LmKnrxIV3Ko0rMdCmukW7actm2azfgH0XfoPp134pyGvmw8IAg4gTF27qA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVmzBrTjrb0k/rKRW1SO1wqvuQAn5lni2X8MlnUiuGsYqKSKsy
	RQ5x//Cv7qC0knJf+Lc5LfsBIxlRLn50krCUDm53NpnBWsXX7MOexI/6wwFeo4TtBPeCTOT0mfp
	vJEz36/B6D/HXYD4y31g+8N8MrFnzqB3UKyVNEQ==
X-Google-Smtp-Source: AGHT+IHDMtC5ejvi+6P/FwbMQP1yLzs4dvzuAfHzOLWut4QZAFsV0vqXGWBvtrbNy55PKvK+RsMl0V/8jbQgCQMUUQM=
X-Received: by 2002:a2e:be22:0:b0:2f7:6062:a0a9 with SMTP id
 38308e7fff4ca-2ff20963c8dmr4983211fa.7.1731053310923; Fri, 08 Nov 2024
 00:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org> <20241031-msm8917-v2-3-8a075faa89b1@mainlining.org>
In-Reply-To: <20241031-msm8917-v2-3-8a075faa89b1@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:08:20 +0100
Message-ID: <CACRpkdaWEc8=5CdBMuGdfcSzneR+ODrVvyw8pOFv-6++_JUzqQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] dt-bindings: pinctrl: qcom,pmic-mpp: Document
 PM8937 compatible
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
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:19=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> Document the Device Tree binding for PM8937 MPPs.
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied for v6.13.

Yours,
Linus Walleij
