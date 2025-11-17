Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72C323F439
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394259; cv=none; b=RPspjvE5It1bzSjetYD6ODLQU8BT1DS4JW7pBT/Nedal3cYVsrgfY9okdMjiOIy5PqH3AJzdIG3K+H3xDfoPQIGd1acSMTzgCSNBcNsYrMJKfNwq4tXmdfdnBlGNdbO37RVluy/f7WBcZTPVng8rT85mdF3a8NUnaKHuiSsCrBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394259; c=relaxed/simple;
	bh=GakGLx3BRYbnpcXKQqj2rxUbKKiFxYQ8pO9cOSBXY70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuw5rr1AjO3KzTh71J9AaQyV3MZw9qhbxVAgKMLG2kzadGdzNj10evoKo4U87IbVE5U9uQv9/XDUiG712m68Kdkm41weg2gQbToUFqfzJfaQCPn+5Cx2iOCcx5T5FFQpIpz+6RyjMrxzAv8gUU05zQgr8Xo330qHRaauhuA+3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdD/xWKL; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdD/xWKL"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-43470d98f77so18887105ab.2
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 07:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763394257; x=1763999057; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GakGLx3BRYbnpcXKQqj2rxUbKKiFxYQ8pO9cOSBXY70=;
        b=HdD/xWKLsTKqwndg8Zqj5c3cFnIhY5YX+TYCFAdR4MDZw3TMvI88YdnA+wzF60nlIO
         o2r/4xP+YXClS1d7bUwbui91Jz3X+k/WlQzkihe1bG+OCXii7X8pdcXu3oE/LtUl1Mj9
         HcjSHXv9fL0paPO8FPkiG4GP5IgzlEjNA/8wskZOCBvVetaDXFy9X3OiEp7j7jzj/tbR
         f7bl6I1yiXuUrul6fndoX7LV3AKsYL4KHc4p4rbsbpL3sxkaq/CXXKXRT+uXyRFnhbFD
         WhB3VGB0MruI3Qd8SIqRdBgrtxxVdkEHbc7BjvM0MzWBWSztFFqfzPm7A6M9Pkp4QQpP
         qPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763394257; x=1763999057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GakGLx3BRYbnpcXKQqj2rxUbKKiFxYQ8pO9cOSBXY70=;
        b=rLgxDBUwl5C/TADTWZVDDAj53HQ27J20Ru9IPFRJOOnEM3lUjjb87XDJITAC26T/mG
         A6XQkpeh/GnFbYdTfUGJfjnqqJGgoQpiRC33Et9GgxTntvk8GoEH/OlHm8fCo2KRikci
         Q5NSNRP7iDu/3svNvwn1RKD9Smo/PPQ2fJ6OYwKiIsCv9jKEX6tuWjtHSab4vrT31KVl
         dp170bpVq1DxGEIz7kXgbvkpd+IQJt1gz9ci+KUmMdtzytfXA53Rm+R1agCjRWHSHgw3
         qYBLryqXQ15ZsoCTUmOigdP/DaAFtY8WRubArXTOadh8i7DB0jaB1UKOJ4JspU49WnLd
         HXmA==
X-Forwarded-Encrypted: i=1; AJvYcCVjE6bkK4XKgob89rko9q+peMXHfsvgyJ21bLzOuxT5qRxCyUEH9hCCaUpGOM1FFGlzNc6EGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywg9Q+Bf68aFiCXgsi2SnrwnTjDLWi5eG2g3MfiQ2oodwurdcKM
	/M1uqbguJZQtYr/ZVEMaTO9OCsSfp4XCfIdYWsFjm62b3DKbnb4mdcd48m8y5E9RWpVVKnyHs3s
	B59SC9WfZLixw7K8i+yvH1kcE2EmPbDg=
X-Gm-Gg: ASbGncv2XDpLYDI0y6LCS1AYjZqnNPtkTaV/sK5y6q/ADSIFmE97GRGFVIqamULjRBE
	dmkBo8DRL24siitP+/TAeGUc0b7pYHXDh3Ce0AJ9D/aKSrFHTFEGxho1hi+XkVFbc/JvW7d9LNb
	7ypriJA3UMy021E4IbIjRLWAgSAa1qe6JtN4w6GXdP8p6viXP68Q8Zdbi6FXFM5P330vokGfHGQ
	FZn2EPMSorwIjUoA2BQc9y13Iv3tGIu0QlcH8hYghXipMU6cQvVSbW7K+UQxcmfkTrSEGs=
X-Google-Smtp-Source: AGHT+IFbdBdmra1r1MTAuYm3h2YFina8VK1yyiL7rlrlzpAiB2tUYzJNKmJeOBR2QgET/eNSGZvdZJ+H1CdvND+9bDs=
X-Received: by 2002:a05:6e02:1808:b0:434:74a6:48f1 with SMTP id
 e9e14a558f8ab-4348c94f0b1mr136903685ab.27.1763394257015; Mon, 17 Nov 2025
 07:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
 <20251114-kaana-gpu-support-v3-3-92300c7ec8ff@oss.qualcomm.com> <ff634b09-c28c-47d0-a57f-6203755cedb6@oss.qualcomm.com>
In-Reply-To: <ff634b09-c28c-47d0-a57f-6203755cedb6@oss.qualcomm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 17 Nov 2025 07:44:05 -0800
X-Gm-Features: AWmQ_bmyUIznEYyCXfUeRMdsertmn-wYkkRaXSqTVS6sR8e15JC5caO5D32ua0k
Message-ID: <CAF6AEGv9OVHBDF+XVNRr+ZtWijs+MDNUgw9zg0HbebuCQbHcZg@mail.gmail.com>
Subject: Re: [PATCH v3 03/20] drm/msm/a6xx: Skip dumping SCRATCH registers
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sean Paul <sean@poorly.run>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jonathan Marek <jonathan@marek.ca>, 
	Jordan Crouse <jordan@cosmicpenguin.net>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Rob Clark <rob.clark@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 6:00=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 11/14/25 12:29 AM, Akhil P Oommen wrote:
> > Crashdec doesn't require SCRATCH registers anymore for a6xx and newer
> > architectures. So skip dumping them during recovery.
> >
> > Suggested-by: Rob Clark <rob.clark@oss.qualcomm.com>
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > ---
>
> Looks like this changed in:
>
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/95104707f189b2e1b06c855=
b563c1203b33da354

Crashdec finding estimated hang location based on CP registers dates
back prior to importing that code into mesa ~5yrs ago, fwiw.. and was
improved over the years to better handle IB prefetch since then.
Fwiw.

It does mean for gen8 we are going to need a CPU based fallback to
crashdumper to make smmu fault devcoredumps useful (since now
crashdumper is needed to capture CP regs), but we need that anyways.

BR,
-R

> and needs_seqno is never true now?
>
> Konrad
