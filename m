Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF341DED3
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431458; cv=pass; b=UC6enQp12lrcKOtG8KKTGiFb96cDY9noefddQAlEho+VbUtOCRP66BUzsqqZ47esYTrGtc68HKp1waj/vgEqD8y+1PNaTK+NEiUpKEWQqqIpjW+XCe+/z6otxNeGymO8bU+S0aoc3ynR0ktfAHcvcrdeVOV4il+MtrNbKjPZ7bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431458; c=relaxed/simple;
	bh=YxxW/DgyJ8n8X4s2Jk8Sgjq3BzhWt1t3dn+FQ+NVOBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIAW867UF/nR2FcqhIpN0YFjpL9ZaSqDvVUNS8E/O3xliRCAfI6i1nlfXaw6HL0NHTdcUSyEXaAlIpyu+fsD+x1S3xBdDKasamccDQJqyGZll0gYHRjEMAW+SREcZz4D/hT3mjhYPiLz7YAeotZxW5QhzO3EsXlhlBBPzLlwovo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt+q14YF; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt+q14YF"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6651bc57458so2712505d50.2
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 06:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783431456; cv=none;
        d=google.com; s=arc-20260327;
        b=aq4rPaos5OF44bMfpg0jGNL3vrYrSIkqbCbF5qGMab2hRgfLF26JA7D6JldliEW2RA
         BZir3jIR7JTVAyiB5H47cPYYmQc3M0yD5fMmliISPCvtcYGoRpbKXvl56YMNQM2yTcJd
         xLwmdQGciDjMV0mWHkrlfYVQyWD1rZMBv6b8iEGNO8rpKSH4RGawPoSc9vwQ17H0dey4
         pDOTY3evTEIqY7r6BKASeUXdasVNhhoeP4CUt1twRx0/hut4976n8KfZKdQmS++vhcx9
         5uz1x2/ZtqYYyq14JT8gGHg/eOaR6Bjn+UTioJy31l6JNELFMggVtlhZVXbwOa5VGudo
         8OjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YxxW/DgyJ8n8X4s2Jk8Sgjq3BzhWt1t3dn+FQ+NVOBM=;
        fh=rnA2N6eMHKOPEz0WvLMMHR44XrGJBCB6p0RLgkBGVBo=;
        b=O2eCkDH+2Bcqgri6Warx3dvrSHgBGmbD82A0muVS2TnuvFvgSlwlrkfvO34lImMakZ
         8xaqY6TIolGm6t39rNVZEyKhJRRcjcaRx/EWJ/jEi0G1GCnrKbpFJM/pDVYxF25xqO4Z
         0BD5RNZsSQsuFI37aWW32+YMuLzqxVii76Gk3FigDC3rTGxwRQuE0RfDFkX4KiHSu2gh
         wSjA1iGwZiANao6xBj1q1ecyM7+1c7s65tFvFJdsiq1OaA1l1niyy4Mdfv0UXgNmC0un
         dtwHJT0iWRFCKenJzOTWKrgxRmJuqVvfvgb3RbnjwbIOGcbEJ+IpMWvGmG1V1OGqbeyX
         97TQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783431456; x=1784036256; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxxW/DgyJ8n8X4s2Jk8Sgjq3BzhWt1t3dn+FQ+NVOBM=;
        b=Nt+q14YFMuMIZ19UOYtl7cIsg0xf+WYgJazPnHaPZXCo0x3OqqXIqszDXRKXizhDfY
         rDQDaSlcMybGQQhdwQDlmaPv+K/el1/Y5gybtssYE88XfwDw4G+mX1H71tP67pnaHuet
         tht+pAd8cl4D46M82seYTll9SGdFpFizuAvubfNzfvjFZPLLLoDqp5rnEcaG2ATyBFSZ
         OnuUOyyLdjVOcjKr223su3PgOIzPAnLuGhFLs7oDVOPsuv8uL5M6ZtCkWm+MJv3zY3Di
         pw4RgmZyHQUOOhmTxwRjAIdx/15S6GYFKIpZwAerXsD83VfRrAZ3CauEdkeQDdVLtMAe
         o6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431456; x=1784036256;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YxxW/DgyJ8n8X4s2Jk8Sgjq3BzhWt1t3dn+FQ+NVOBM=;
        b=VhCeFoC+734o0Pn9bZOW0RF/LEs9bSidAplMQtdkXUW/5iVXZGkaK4eVIVLQ0WXUwd
         zfxDSSlnEvQSWojmDPbWw8SpQDDMs2cKkkOEQY09Y4reCMtF1NShRJBBnE6OSMJF5GIp
         44pJ/1thfmjyLEJk0xe3UICnHoIkrX/MN2psgXdX/XklCv23XJtF3NznrBW/1VCsV+Xo
         7ZcbtWlC1Cn3iR8p23qviVq9fkNZu5/RmRarGBUpvDqzPqQTQ7jBOMmGHL4j4BsN132/
         yNRdjPUzHIhBL8qKa73KvJQKEV3etZ85HZY7Mb07cK7fzwQAdzAsLK9hSVWNKXcFCI1Z
         79dA==
X-Forwarded-Encrypted: i=1; AHgh+RqAufk6wNO9YQmeIC+SLWH82/IoATCkmuXUaXl4v1QAyDUEb4im7a78aFQDcln4a+WFdbzpwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywe2GR7TQ/kSJIdnET2gxhWJJv8fkYATk919OK9BfKTXz1nSgUB
	9MdFSFV8bIYkdJ7KIxftiBfUTr3xRqFAW5iYgIEJL3d866MVQozUX3+TPiba07Q+dT3S+GbDaUw
	1AncWrOjERQAKk3MQQp138MuSiaDcoKY=
X-Gm-Gg: AfdE7clHqQxWuhu+KlTjchwy0yaS9cyma4z7Ob2x3jfsr8kbVQLKy9sP+CAhD8J+atI
	F5zvkFDzd/RTKbtvgzuX6eOZYcm6RUtOH5UDVPdo1tE+nagpzdP6i/+i72ZTrllxYPR46IwNvR8
	PPYao/8Mb15zvRxyC1s//gGs6KdVoFYznupyx23NV9vkTyDfnl5o8jpiUVT2+0c1FRnCWS38DI1
	ijbzG7Cke48vxuGpvfM/IRp47k8ZceAC6t3hmP0bdBcsdGq9W6emDi55I4Ib8ypq8MGyhqoptX8
	WhfRnJHT2pV73om3Idj6eavWBrmjTM2pPGvwlFMzv0hiC+u1tuld8QRkxKn+YA==
X-Received: by 2002:a05:690e:440f:b0:664:ae6a:ef6 with SMTP id
 956f58d0204a3-6677fe09239mr3207984d50.84.1783431455985; Tue, 07 Jul 2026
 06:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-8-506d936a1707@gmail.com> <a0cee001-7bca-438a-943b-da28528e7df7@gmail.com>
In-Reply-To: <a0cee001-7bca-438a-943b-da28528e7df7@gmail.com>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Tue, 7 Jul 2026 23:37:24 +1000
X-Gm-Features: AVVi8Cc2ZFlYzV97xsPmmL_XYaVoOo2UdWECw6a41ntBKVYGFTDcsFEpeCIlldE
Message-ID: <CANpmGNusmx8NQEu2x07rX-yd33XA9TJR_ZogFVXexAmw+7qq9A@mail.gmail.com>
Subject: Re: [PATCH 08/10] HID: apple: Add DockChannel HID transport driver
To: Julian Braha <julianbraha@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Julian,

[...]
> APPLE_DOCKCHANNEL_HID has a duplicate dependency on HID,
> since you put the import for this file inside of 'if HID..endif',
> and then also gave it a 'depends on HID'.
>

Thank you for picking it up and letting me know!

I will correct it in v2, which I am planning on sending later this week, or
potentially on the weekend if I get busy.

Thanks again,
Michael
