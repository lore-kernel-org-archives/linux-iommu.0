Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDA82309A3
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697984; cv=none; b=b3BLtdDLEszin2LtCReVavCTI5KbuZPG+lsinszNRnhucPSn92IxXdrZ67r5tCx1LtaHHEbvb7b0eowzDPTws/TUYzu1dYyjRHF8A6hVJB13mCSnPHB57pEy8f4YwvJWCxlXw9/GOulztFYYFjnHXro2JejrOgkv8NqXHoc7xFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697984; c=relaxed/simple;
	bh=VrMyULN9yRhX0362jZvsXqzL/blFpYThDTo1AkO/c30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9MvKPOHO8lASXYiEqgkbOoNseYXmimB80+Qnj4/eYxg+1ZdkuunPl9VxmFUWfRykdue9zl4qpaNFYIEFHp1cE/WLCH4XPkW2KSdr+yzzoFKVpA2h2Z9MFnHuYzPSFf4Cnr5Ta4FHymzo/4OHwnpgGGwO7U+m7RnkcdXOdK94YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pwj+w1am; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwj+w1am"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30761be8fa8so17921051fa.2
        for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740697981; x=1741302781; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmkybCOSFne6yK3kY+Du84AtHtcKYiWZlsF8gbRhEyU=;
        b=pwj+w1amDy1zUo5sDb/jAdo/zOtvIM863+6U5Xf0JAfOK8onSGKuRRmVFbVCVwILL6
         ba6QyRk6WGE+8At0HFdNP883HdsCRDaQmRgvgUfL+f6dfMDXw+QD8vI9CH0rBmy+Rflv
         h5JSlnTvPOkgbyy7SxB4TzbfbNxCrIPovA+kzzNigTFcJlLrJ5NO9oanXr3t7AIQlSMY
         RmwMED/ZoZLQcXrcpCHnGEOiin446apxNp9II7QD08nF05GW2OANK2OI/JnKtts+sfgb
         SJdiIvS6VK8tk/jvLs2ryxGoF63vSzEymbAVxZYbL94R0srXFDbcvkdz+GE3fjV3yhn8
         6jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697981; x=1741302781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmkybCOSFne6yK3kY+Du84AtHtcKYiWZlsF8gbRhEyU=;
        b=vmvt3YbV6JqQsYQJCHG3zUmzhUwFONqwGGc9nzEMTKe1m/+QdlGYaI6f83JljIKa2g
         elRkVtP1rEfdGUYJYM5ewnIFjEEhG1J8sZXI+ltwxzCee0bAvxMunEoY7Lu2PnpF8J9L
         DiWnZfiBE/VUbOQlQendYGFg8S1XVkuI0wT2JJeaArwPuCi9ztzKN9KEmrPqidtdYm7i
         3yUExrpFJqK/6xphIExV4H2EroVmsL3sOqYcGxEfQroE9EpYAhO2wtjsBnSrBHs8+0XK
         Wr0afJ9fEpGpHQz9ZMq31MSoj8HDh3H40PpaS4C1jpPA6Ftp3lP9KO+LzEK08DZZw3oA
         bODw==
X-Forwarded-Encrypted: i=1; AJvYcCUq6iq2qxSmo5GAUo8YzD3/l1+IQv2RQiwuKcM7TOJvuU3UqeXzP8ekOvnv+cwnYKUZb4kt/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBxYBDLygYx1ga39yeGLdqG2IrZ3fWaMw5FUylkJmEcJjyioj8
	etXRCWDWU8Gj5d+2NHN+Ng+w9mvoiw3EkDkuEm3N/cIgmL1Lj34xg7S47tawIfodO0TopbvDxGs
	kRZjzjFBtouNFLt5WbjkvBLf/xShJC0NwiNuEIw==
X-Gm-Gg: ASbGncsEA92Xdb7k9TqnhtIWBlcYO/q4aqV7N8gCfZ7GmH7VjXcaYSd50NEtr5QZssS
	mL4aRrFa0Vy6UE6Fwf6V8Kdpk0Cilhwg1z9GnoSOVbVk93GCSOM22hunFkUD/rFC1LmYNsotEOD
	t4f/r5IU0=
X-Google-Smtp-Source: AGHT+IHLcUchRQ5RHejMZKQOgPdGa2RgldlYInULBrGmDbyHiaxGOnJDGcYbTPdwNuvGN5wuzKGCGgT0iWuzwLntJq0=
X-Received: by 2002:ac2:4e0e:0:b0:545:2fa9:8cf5 with SMTP id
 2adb3069b0e04-5494c354e58mr578980e87.49.1740697980909; Thu, 27 Feb 2025
 15:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com> <20250221-rmv_return-v1-15-cc8dff275827@quicinc.com>
In-Reply-To: <20250221-rmv_return-v1-15-cc8dff275827@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 00:12:48 +0100
X-Gm-Features: AQ5f1Jra6Y1TNly1NYmSkFPtENvNIwlGHtsux17X3bXg-g3qhlo7h9G9hMQoxr8
Message-ID: <CACRpkdZV4EHGxYrX77FgsZvPrHohCEixXX6dkEoVSYSsaAzbYg@mail.gmail.com>
Subject: Re: [PATCH *-next 15/18] mfd: db8500-prcmu: Remove needless return in
 three void APIs
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Lee Jones <lee@kernel.org>, Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu <zijun_hu@icloud.com>, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:03=E2=80=AFPM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:

> Remove needless 'return' in the following void APIs:
>
>  prcmu_early_init()
>  prcmu_system_reset()
>  prcmu_modem_reset()
>
> Since both the API and callee involved are void functions.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
