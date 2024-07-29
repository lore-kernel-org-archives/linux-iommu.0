Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E018A95A
	for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284670; cv=none; b=fDnpMJkhibE4kbRG3JxAZxhF2RRhaWsYibmRyE8G9T/Pm7j8J49d94nNDLbmRtuQkoi4BPE3Y1BUTPS5sRtARSuV9srINAvMFOpcRXcOPKuTD7LzkDyb0fkb62Fkdut+vO7P3dqkRLj17NT3RwpkLSL6TbJxhouwIqErfEw8zJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284670; c=relaxed/simple;
	bh=rdtey877Tkd/46YFhZ1VoOmDbFw/LnCm8ZrWiClZ/Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqlYSHsmAzNKwWel9J6t1n1HoDm+/mlODjn1EWYbB2Qme4b2wH27CTTRiEyKmWSC52cP8CXkqhwymhP9s0mHE6G4SOgy7NE+h5kZ3bbrpJOoZhN65W/iNp6/qFWDXN808bn5yT4yTqS2rBqnHl0DO3yafj385BxVQe88zQxOyhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=1KnqB2No; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="1KnqB2No"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52fc4388a64so6602737e87.1
        for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1722284666; x=1722889466; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdtey877Tkd/46YFhZ1VoOmDbFw/LnCm8ZrWiClZ/Uc=;
        b=1KnqB2Nocip81502iaRe3PbJ7H/eNaAVEjSmG8eXQ76uRRKjOhgf/dboFjkc19mj2b
         uClK/92zt0f9g85YCbjkVddAZxl08kMOYDi4vKjstX5KsRn1wxNXJ6yDkX3FsdfT04ty
         52G9ZxapMc8AwcaMqtfOTCfnqkUL0iF0qzG04nmCCPUXmloQITEHk7hJvFZ1zC7bu0UW
         EjkgWrMo8wGI0meaJnDpsLAiDaRU3HeWzgwN20ae16G2vNM8yvZjt9gMrlN3bYK1lnOH
         JtRUKS0RS5F94KJOHCc47vVJhGKVQIWdyTev4dcJxnlwKL1EEe6T9SN78AwVtnYiHqmw
         cjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722284666; x=1722889466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdtey877Tkd/46YFhZ1VoOmDbFw/LnCm8ZrWiClZ/Uc=;
        b=oOQNBcyKvEUBhDPTtrCmvqdozUVhkISlzTC5hIgEpMAMKwFkJdQeVXGyIiM/klXMQQ
         uACpCRp71MLlw6Cb1tvHbZXTM/NF/jdVcbJxzUTrzJZG+hYcz6hskf1IS8Wd/G9usMRF
         eYJPcv+IEGXAEDwTPA0ZFKzZcBoCkElZAUgMIdIcQAWj+xKF3MWUGHEsqrpWasEghzv4
         X7vlYeFljFpZkHZkpR6+Qw2ESkbbBHlIUeucxQ3O1LMGt96CzRTf4PPl309g6W9sP9DB
         cnjHLYrMFQdI9A2t9/gw2rQpapX45NpvqjS6ZSSIKKZa1vE+8C7nCBYMvKX+WMZn/BF3
         bgBg==
X-Forwarded-Encrypted: i=1; AJvYcCX26YESE/GyM8PYwbr6UigaWY7RdlcH0jAcyfrlHO+Tmpu7fB6la2v2SSjufHtku9fa1Ob7rifwWAaU7o5FdH3XyhjcoRU=
X-Gm-Message-State: AOJu0YxEc6JvsSo4iMoplJo1kP/OuUv2HCv/azkWrf+NxO7NoK5P8grH
	MrQDCeCuKjgYboKaREvJWAD1FeFo+hTFVqvT9gEtBHNMuqkNbNWJHOdRPO8FJJTpUUfdnp/RjRo
	FiqljEt3kwr1UTfbYlBl40f8uPEz+Q4ZSixptAg==
X-Google-Smtp-Source: AGHT+IEOZr+HLd9MQ7+mXaujoCZMSeDtg1O5d6zpUpb59H/Z0WdC+L2shVJzjomOtwk8xRjMMtxTnNpKgm8KKoVbBtI=
X-Received: by 2002:a05:6512:3ba9:b0:52c:859c:91dd with SMTP id
 2adb3069b0e04-5309b270551mr6262249e87.5.1722284665710; Mon, 29 Jul 2024
 13:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <b3ae8239-4e75-4ff0-b722-dda0b940a5fb@freebox.fr>
In-Reply-To: <b3ae8239-4e75-4ff0-b722-dda0b940a5fb@freebox.fr>
From: Pierre-Hugues Husson <phhusson@freebox.fr>
Date: Mon, 29 Jul 2024 22:24:14 +0200
Message-ID: <CAPYYAFO+Y_Xd5zti3coc239y+wFP_NfZXMr+EWbj2OV9F6aK6w@mail.gmail.com>
Subject: Re: Firmware / Hypervisor / TZ kills Linux for touching at context
 bank registers
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Rob Clark <robdclark@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	MSM <linux-arm-msm@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Arnaud Vrac <avrac@freebox.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 6:40=E2=80=AFPM Marc Gonzalez <mgonzalez@freebox.fr=
> wrote:
>
> In my specific case, we just need to avoid using CB 12,
> because it is reserved by the FW under Linux.

Additionally, the way the vendor kernel handles that is by removing
the reset-on-probe ,
and by checking the state of each context bank on-boot.
So it creates on Linux boot a list of used context banks to never use.
This doesn't sound ideal because modprobe-rmmod loops could leak
context banks, but I think it's a reasonable behavior, as long as it's
gated with a device-tree flag.

Alternatively the way AngeloGioacchino did it (by hard-coding the CB)
could be kept as-is, but with a small tweak to help developers:
When doing the resets, log which CBs were in setup/valid state, so the
next developer hitting this issue has some pointers as to what to look
for.

Regards,
