Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3A246BB7
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676077; cv=none; b=FbBuASQjPryHq1PMEj6GnZC4ImAXzgQGphdoUmDVDP6P43QVg7jCtcsbIvqfDSrlPhAxbLbOy8gAKlrCVLn/djRe25u7V5xcr6L81QNkApUI6fGHWwVVcq0poys/9Erez34EVIHUtDmn4POcfYUVzD2nDk80nZZPa3Eu3wpL220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676077; c=relaxed/simple;
	bh=t9cGAC1V8k6SxfXrsLQjmHsOU+fuaxnp8/UHtdTovTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzliiktCKwJEhg0cUjfthr8c2o/jogOTAuaS6AxQXElZlCARzV85K7cceikHbE49azLK4nDZKw6o3A+8dhW9Mmvate2p8jWtPnJMmzgQZprhd1zLiS20D0MkrNWGLPvchk223xnKJ9KhGszlVhdY1TgUYIIftnVyWZE1LntOTHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nwCuiEhP; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nwCuiEhP"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e28058c18cso11211705ab.0
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752676074; x=1753280874; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptfKV/lWd5XKyT6rmwDogz+72ly7gZepKQSMRpdWixE=;
        b=nwCuiEhPrdOIWlBqhIQ1+fF5IYfzmO/vvtYZv2qkbFQGTX/13BKCwbzq3jno+P12i0
         GMQhyT6Cg6IdqOjmynupbO/09JrNwDXj3EfBapIt0BQeQd56QQ9IN24qVGay0+4JfuLn
         excj7Wj8cUVYryDCicMS3bLSldGzx5cW/xrpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676075; x=1753280875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptfKV/lWd5XKyT6rmwDogz+72ly7gZepKQSMRpdWixE=;
        b=xMimW77QZ0ZSSiQ7T30e8nBDjMLNA7mFt7ye0X0JCVxR28mQ6ATYH5L1bFtxmtLUoL
         v+NmnyBYyXSTo89CpI0lPHI9DlJQX3bTLW0mzs3S23sbF2nXCqMvhlqvde+r9gbIfxDU
         Eer1yJlacq4NcEIyCvym/EGAqkWarj//wfrdI4m4RbnHRsiAYR9/XezwMReX3AG77vCU
         AOjHB8/7UMNhu7yWifqSh7lpyCOIz3pNodaZugLZx39AYrUZjqlis7lbeaIaOsqh9zah
         tpXVR3ihDbbNAEErNLLj4EFoF0GQeXzKystlg/sTJzGdK3wfGeGTX1GN0td7M4Tj8o50
         5KnA==
X-Forwarded-Encrypted: i=1; AJvYcCV9QXTicOi6KVfsuROw+nYcIdbTo1UP9ElvJm+FCO/WxzZQBtg06wHp7rkIK/eG4Ekp/qSwfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiENJwImY8RFwgkTeiWV2ui9hi4YSJlUSSlXH3PRFDxhsZsGOY
	ACOAxVACvCGSI9uMsZE8bweDvBouzSCbWKfAvmjsuWfVwejL9ccLiiXT6w6fzdlgAXSdNsC9v0L
	KGlU=
X-Gm-Gg: ASbGncvuOYTMixA/N0umcOyNgMrovxYWBuxvPu1QxqitWDhg6uUW8w304jneMqh4W4q
	bKaGGwx7cM1+zGOY4HLzMSU6Pdt2CVO/IvEMZJCjN2UFubHN8yO2eebtWUPQWLOlW6AZs9Pwviu
	YW+vTVcpmJsZY05FPpe/16BFxlrDIzPaXPLc9nqtYCYnCNzI0jSWJ9x56rPsjf1bniuQ56ZWit3
	NJYeeHWw+DAX9VLqiEva2J1xbx850SNg/6z01sCpiLmP3zDFCdA1li2wtVX3ISg/wIaEAHQMBtR
	S9KRzlzy2wcVvgoRkHjPVyfWieZTu9mNM+FCC6nWi1QL9376GecW9YN9bMgwOc2vXzG3/YoF5TD
	70QnafJ4boDwumOorxXdv0JvocLVrXfktUwBEpjAMViwlWhTcGv95ys9FWlRyjbOEtqW9ceNC
X-Google-Smtp-Source: AGHT+IF7Qb58z7TtQnJQiUcVRGk3NrFtdV9YB3P63Pntp6kElFTyQXaswfywsCPnpA2S9k4/4riX5g==
X-Received: by 2002:a05:6e02:2288:b0:3df:47f1:bdb9 with SMTP id e9e14a558f8ab-3e282e8d3b9mr30107275ab.18.1752676074497;
        Wed, 16 Jul 2025 07:27:54 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24611c669sm43919975ab.13.2025.07.16.07.27.45
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:27:54 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-87afea355deso290639f.0
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:27:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVP33NglULCFsYDlgnE3ELwpj7BvtgI7lo9fng3eJ40W6qEP4v5XmMNPhdv6w3DtEKapv8dWA==@lists.linux.dev
X-Received: by 2002:a17:90b:3c4b:b0:311:fde5:c4be with SMTP id
 98e67ed59e1d1-31c9f45c8e9mr3962513a91.35.1752675732176; Wed, 16 Jul 2025
 07:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250716-topic-goodnight_cheza-v2-0-6fa8d3261813@oss.qualcomm.com>
 <20250716-topic-goodnight_cheza-v2-4-6fa8d3261813@oss.qualcomm.com>
In-Reply-To: <20250716-topic-goodnight_cheza-v2-4-6fa8d3261813@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Jul 2025 07:22:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VnE0kUk58GxmfwwZ7eP-9xe1Hqv8n9y2tHkiMK3nwFGQ@mail.gmail.com>
X-Gm-Features: Ac12FXz8ywMx4qZ-nfHra53TjelQ0XaS7lSbI5YSdJlI09vDJzDmVP6OfgYR9ro
Message-ID: <CAD=FV=VnE0kUk58GxmfwwZ7eP-9xe1Hqv8n9y2tHkiMK3nwFGQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Remove sdm845-cheza device trees
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
> Cheza was a prototype board, used for developing Snapdragon platform
> support on ChromeOS.
>
> Since almost none are left in existence, and none are left in use, the
> device trees for that family of devices are being removed.
>
> Clean up the maintainers entry with it.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
