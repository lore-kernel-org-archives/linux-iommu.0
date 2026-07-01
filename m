Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8E25A357
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914493; cv=pass; b=cO6u1S1dO3Q5usegH3O8RCzHa0Wp8/jYadYhulTqeqt4sG8yG5tVXQXR7wUVWmWms3d+mpmtZSBDDTmryUSGKjbVhq1xH0fO0q6Bo2PYb1bffUtessDT7KocXtKLwhDMUzPbNd9qO30HVu4H36frS7D/FwN26eIRYIS/B4JyuZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914493; c=relaxed/simple;
	bh=eVUZ4embWnOBiS9PgKFrner9THwK3cnX7ndZCKBqzJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEaQPK0BAi0+8PPGLVMdbetBL2bjMVJV9mHRPS61mCZMr28mSkv7PMpdx0M8Yr/miDfuFPmw191T9NWgPo88NvdH5bPRodd66XNgmKxIwi+wiAa3F9Mwx1/PtFGL1k/zvPjx1wk9fA70JPvZrNyECW+tt3S1OY8zgcxFTIgXKQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3aZM6Lu; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3aZM6Lu"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664b2c00e12so996287d50.2
        for <iommu@lists.linux.dev>; Wed, 01 Jul 2026 07:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782914491; cv=none;
        d=google.com; s=arc-20260327;
        b=QFM84dmL3ul+ZPca8u7TMgblxqSK6Fg8BbJmJ5/J28IhoIR1f0j/4/fFbhH1iVTG8x
         Mfu9PDZeRzJj2o4Dffg6VekIc6CYboy8kAS4Uov/SQxhjb3qdLx+HkcN3cE9Y3iQuteW
         7v3t0JblDoyrM0pi0RNCnBcSLqk9o/uiIgySTVzSglYIf5hCJ38JPsk/jUVuWgmLOtLo
         izq02eCs8qG2iUCwhbAfrMXCUgoe/LBfABxKYTLYEgTHksD39IdCeLXrBWzLFuUbHxNG
         ueqftLa2rzwoE/ALPiIatYWxOd2UHgFouujLigPXF4xmP1ssycmwdkDyt1em0ueVEJYt
         XtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVUZ4embWnOBiS9PgKFrner9THwK3cnX7ndZCKBqzJ8=;
        fh=toa79SWVpcRkVqKw9fLr1ZEKVUcipHZvxoiAtP5YH9o=;
        b=kfDlSwwxSOfaXGQTVxUPN66WQQP60YLoj6NEwBiGyqb6FviTfCQe1BQTl8rWygosuS
         xT8ZfGMYL4uLj8r3Qwh4YktIxn8FfmOAvCst3g7HzaYiaLlJ1UrLkG5RrS0ld+FMEKJI
         ByFvxHzMmk0sLxKgNnpTCHyrhvMCuv+Oynn+UXE089Atg4NYKTi7RPqhs6EDWc21+vyz
         FGY/hAYBLODkdlr2uf+tflTauRKj4aNNI4NjeYgNnm40EQmOBmnpjEiwDnB21is0cF0P
         UDDqwe+bq+AZzM5e/2KMoDapoHTKpJi6alkUsPRGtJITUopQfvdMKae73q/IqnGXJG66
         ddJw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782914491; x=1783519291; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVUZ4embWnOBiS9PgKFrner9THwK3cnX7ndZCKBqzJ8=;
        b=p3aZM6LuYjLJLtNISufQiH9KL6we981zudOU++K043CAoyx4BOPpf2nFaMIl1SZXHF
         6mwlVKJojLZFNajpfjZkdHIWxlF8RJidwngZDLWfJPYxCGb9dvvV6I7HSJWyZdXn0uvO
         dfoyMNcVQ17q1NrHspW9Fp7Qnj+Dwb4EYSbEEmI3HH/7r6CnVTp/6wHegI/VUMFGcLAs
         sHEKY/P5MrhyJSo1SdPTtYwFe3hs3yRzsztDzTclBihz+1tEYeP7QeAge2gQOiRiSRl4
         eBS6pj8+WzbIFLbM3Cem2ij0tymhogwo4W3pN4XPGFokwTuiwoAsMV8NUXIjs4c0VfD6
         Cruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914491; x=1783519291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVUZ4embWnOBiS9PgKFrner9THwK3cnX7ndZCKBqzJ8=;
        b=rOpwVS6TiChe7UCajbsm6pUX2WYrF6uEoKnDPECKsJn9bHx421O6HQJveEgy3QNXWB
         +14fJXckv9O1ICde7f5FvEedYvifYC4aLlg1WyMMBA66fojYpHspc6FjdRERkjPfUOcF
         e8O6zrSJSqn9RoXAToTyBOOwu1Ydur0bFUrWtWbMGbZYUNXJuzEGetC77h/qW3HeEwMI
         /97bSVPoDehKJCmYfdtRcVxh7U3Z1dEmFTJPja7RejcWzwud7MRhsgdVL5fRuzTcwW+f
         YuwfdjuHvF1Wd89+xqzaPT9qsL/KYdyGa3Ukaci5E0qvb2NLM5lvUrWfzmhJGVMfxqRV
         vDlg==
X-Forwarded-Encrypted: i=1; AHgh+Rpv442krqya7beHFoDuTFVyxdFtdXBdxnJM4FnRloqbu9oEQOHC6wCAt3gfZK8XYgSUHnbYTA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8AhNpvcXlLXhQhzaWB5XC49LtHI7qa753vSvUbSDtn7+knkPT
	pzxxS45ED4t97SH40oRFUmDVvQ5xekAmWpyKYq7hvol2/QksY/N4fycuZ0x/2Q/lXnqTWUgfsTL
	v2oxTX16uHan1HLg8Ju4dSWZncie7ois=
X-Gm-Gg: AfdE7ckQ6c3L/ISiO7sX5c4zn7bRbZvchAdKcbZUuIMY0eBd15CxvKICRm/LwwJu+uI
	Rre3QTdPtGdVts1CIH6WLJOoVdiSfEuww9BNgQwzsSoMji9tstpuQ5sFwmr7o8jYUwhemYeSsg8
	3hi5ZSIO20TTpiGIJOImfkKayw5jC3ZCNygOGMu6HJGDg4fqQR1D7Qsq7D279v32CmU3QsTqD54
	5Tx4MObRkIcHDu90zSEAhk64IhAKIOAv2Q+Sryh6emuOsikAlu+qsyFkPdOru/y4SwpG6ATKGhh
	FOHB4A1lwiuk6qhe3GoPc/67nl+FQQ+IGuHy2vpNL4yaCSvtoL0C3W5vkBLI/A==
X-Received: by 2002:a05:690e:b88:b0:664:ae03:5251 with SMTP id
 956f58d0204a3-66591634413mr801390d50.2.1782914491125; Wed, 01 Jul 2026
 07:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-7-506d936a1707@gmail.com> <B22C8EFD-DEDE-49C1-AD8E-BAEB5C91B6A6@chaosmail.tech>
In-Reply-To: <B22C8EFD-DEDE-49C1-AD8E-BAEB5C91B6A6@chaosmail.tech>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Thu, 2 Jul 2026 00:01:19 +1000
X-Gm-Features: AVVi8CdUm7TRIKQUnleOwtMjaxBDCbjz3iJPuSJcM6iQODX-JToqKlxvunuUfag
Message-ID: <CANpmGNuoS+AK6yOo-S8Z7M9LbOqZXUN8Sgv46L_y=OYnU_orXA@mail.gmail.com>
Subject: Re: [PATCH 07/10] HID: apple: Add support for DockChannel HID keyboards
To: Sasha Finkelstein <k@chaosmail.tech>
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
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 11:41=E2=80=AFPM Sasha Finkelstein <k@chaosmail.tec=
h> wrote:
[...]
> It looks like this section is duplicated in the following commit (8).
> Is that correct?
>
Yes, it is duplicated, thank you for the pick up. I moved the fixup to
the transport layer driver (in the following commit 8), which works
better, but must have forgotten to delete it here.

I will correct this in v2.

Thank you again!
