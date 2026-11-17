Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794917999;
	b=Jo27Kvu2HSe7ujmDgqoSOoswjNq/hVeGbnt/7aSEV7qhEl2NUdBPVpnJYO49KaU4R5JU
	 Dtg9p7cLwZpwUjxvXNHCydXTDT2og83QZ2MkjSSak9pZT/Jx8/8H5WFfzMfVh6vWj2hnA
	 tCeRpfNkGcX4TmZhPMKmWvxDH91vlKjzOR8p5O04jQImc7JZJjO5/qqSGeoumjjKSY+S0
	 GNWosh7WqMNoBLgoCRwbqfIGJHnlxRaMlFTKMl5W41XY0peGCMCqQH+45/CtlF9WJoSV2
	 zw10x5LpDchl53BJIRkxm+hM7gxz/WeQGGFtJq2x0hSLoxEZnvJ0/Bqk2yUiOxMlZEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ZFVJi+i+sc9nYgluytKQGXSriWb6Sc1xPMl64Y6JsfM=;
	b=qwoDnuJEnM6lCo4jFormVREGK8CQ0X1/cUrsx4d8T4lIhukI6b3waKFmBkoFnCJgWc7n
	 ykwU8tAlyvaxwb6MTEQjOx4Z8CQZutN+mbTCBfcR5krcS0dxm0iNuyYlfcyzc9llUaKTN
	 Ri6LlN1sM9QPYPu2Vo9BB4FJCQPkfktP6kJnWwhYUgxNESumMg9+D+0z/IsH5dTP/4+Yi
	 J5HN17d75t2W/0D01FEq+DTYjn+DRersfTTbKYxxccFdP9Bd/oruS+BPwiAoR8iEVMvVq
	 hg+JjGULEt69ruLf4bjGn035HzOMdsdC3GkwiHuX5fcmqBM1BwIEzUsiBTxl33wPjFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gbg2yyyD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E5606A880
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 12:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C34E5606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gbg2yyyD
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so365009a12.1
        for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 04:19:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794917997; cv=none;
        d=google.com; s=arc-20260327;
        b=d1u1zn5XutZc6pK6/VdkensivcmCgN9PEdDr6gGgfG8Kdw4SwKqrYLOC1lHuzUKbYu
         4h/UJdAyFEOoiFdU1hy19v4PJCNGgqpVwxLPCaJ0AT1YDsRWNgM45Ay5GG8A392Mlqu9
         EBGxK1823FjG0tTlo28fj/h8OPeaMJK3qQRq9iE4lZ6dIWNmajPBS/p/azXPwCpJNnJG
         cqPlvYihq7TrPLU74XO5l3ruSa6RlFlZXFheUT3ePx0sm4qpD1pitARb+Ek5+vTvwy6M
         sNIyE/q6m9j/10piUkTMEdwW+BfJmK1VSKmxDLUrTqy/GL2QlJWGXbVtQ7+fSfBjNmDl
         07ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZFVJi+i+sc9nYgluytKQGXSriWb6Sc1xPMl64Y6JsfM=;
        fh=VpoIBkFfqyslHxgQQMiBNms4wwdiPCKR9MCfelvlnVQ=;
        b=Z4Tpp/Q5okBvoUSpwrGs1w2US+OTSTUeRVs+nffk9c0yVxJ+ndyL14fet8Od4m6sSW
         EOMT9uH84spmZGWHGwyN8OHLEFZnwPk0+zUuEWWmMhIN/lCUkfPppUdGt0np0GcWks+Y
         wqDfIUE4x5WczBq/bGL3jmcPsKL0zj+NVK8lUF818Izv4XsvAS906iuOhXlZquB8y0Va
         eT59V/cLgfczVipahRgAHkRd7myVphbi9WSweQcxh5OqkxXEE86eI6XqxQBZE2OLFoRJ
         rqUqDw4SOzCYhGtO/NEpBGRmX7nQ9VvAimy0LZTVu5Hou+LNql36DXZ/dzqtXipXR/9X
         93Sw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794917997; x=1795522797; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFVJi+i+sc9nYgluytKQGXSriWb6Sc1xPMl64Y6JsfM=;
        b=gbg2yyyDp9Hv9NpQSxZjIjPvJi4xZbOC6pdPVfmOoXwMrn5wP9EcRAkJLiW3rXc9FS
         UYNrKL7W5G1IXM4KGsoj1xs5aZAP/JV4CnhtSsjgSfpE11iMt0Wnthd72EQH5lrNdppM
         CFNE5z9OK8OdGB0T4A//txEr7VCro7zM7+8Z8WS55nrsxVnMio4PV8B+ebEvnHWZ9Uhu
         f/z9xUgJY0v4PSQDf2O0OiN9VNAWL2QMpnv50OXl8tyUH8RxmGxmaUV/wHrLZIYbP6bN
         YtaXx8fYeFv1K+XgejH4d6JCBSaPxUTXwRw7x3kc0z/KEyuZ186d5m4Cyf0pJxtbuvDS
         zX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794917997; x=1795522797;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZFVJi+i+sc9nYgluytKQGXSriWb6Sc1xPMl64Y6JsfM=;
        b=1HlqIopr9Ax1czTk6hEwskHAi7g6ElxmGP7SkFtbKGsScYpZ8z6TRnWZjen8AkHqdP
         rrdBa+zdPw/DJt+DlkSfcrWNWJ9GLwosMgaNvLCWw62RX7z+4wXt7rHk6StL7VnznlLg
         AMBtE03UKT/vLoKnA5a4F3Wi5rQQzei4XYnfUNhufHVy/r9OeRPQ8Zxszk9xOIhyQxOp
         tQski4WHAAYrndloLokjJy2cboKClDxXU7lD/vafiEi4cIG+f3u4vkrS3+rZpMTSco7D
         GDraeiBsTPykpIEisjS7sG3aBxQXmS3DV10bcUC6942W1eU7zI1YIJm0QkQDpwVMtFH0
         Y82A==
X-Forwarded-Encrypted: i=1; AL+hErHXkvVj+NXqjgOleIO7JCDElln7zaw8cZOQ7GU980GHZnBh5sGUCtC618JLBr2mifw3LyyoVg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+AuJkYdADBtsm5bzTW95mqoouxIMAS/yKcyyxHwYPZWBfFyddV
	FEDOYb8OlokkmY51BatgRHVXP/PE11gTWmuZ59vi7pZ0byEqX8D97RC+ishsEapLKs6C6E9d8zB
	FGC21mOPvItTi4ErhVBDZIBvXikNhBCTkO4vlG4FsWA==
X-Gm-Gg: AYBFou2JOVKLuRbGF54uOff4bLm14DAr9FjOVWpGR0MOv4XGdIbmOBO4cRIhag/KeCI
	yQxIH5AdoAmw9XHG76lsdzIsrZbcojMfQuzC+yCuYgmfzxy3VgpGs6ScEkUONaDE5oIt1agKjF3
	vLihVziI7OtHLoNbxXUaXwSqb2pNlG4o5xjKtngVDYoCISmtSBBP+kR9Rw+yqgvIpB5zJfZ/i1T
	rFSvO3O1SWohTLPXMBhofxiUhzsQiNMxm2MNgqVvFuiipd+zr8h2yedkk/px1alUEjqwdoW20vO
	4DhqJB6BsgCgapykx/ClxuU7p1XWLZVUSO08sQEC8f5fGQKWdtDbd7m0e83ug53PWBgMZwDhW2g
	UHhEVyHzWrmKtjZnuEF6cDZ9kLzncF49a8NS0MGnjfECYyqYLGG50bk0KsBWfl5eEgrOHhN8jvn
	YIIZseyBrNUto7nkGb
X-Received: by 2002:a05:6402:1ed5:b0:6b7:e861:8f50 with SMTP id
 4fb4d7f45d1cf-6b7e8619543mr6865668a12.37.1794917996838; Tue, 17 Nov 2026
 04:19:56 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261116-b4-iommu-passthrough-devs-v1-1-dc5b493f7551@linaro.org> <20261116174238.GC2299285@ziepe.ca>
In-Reply-To: <20261116174238.GC2299285@ziepe.ca>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 17 Nov 2026 12:19:45 +0000
X-Gm-Features: AclHuK_ulY4P51VnkuhR_K0XogE5A7oe02gNjInWa6kLbfDjJ1Wh2QAX_5471Bc
Message-ID: <CADrjBPpyhKcvdH=jxiGSN46SZoFahaBdH4fAQ5KEzRvH_C3AJA@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add iommu.passthrough_devs early command line parameter
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, Juan Yescas <jyescas@google.com>, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

Thanks for the review feedback.

On Mon, 16 Nov 2026 at 17:42, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Nov 16, 2026 at 05:37:45PM +0000, Peter Griffin wrote:
>
> > Instead, I propose handling this in the generic IOMMU core via a
> > kernel command-line parameter. This makes it available uniformly
> > across both Device Tree and ACPI systems and across all IOMMU drivers.
>
> Something like this could be useful, but also Leon's series will allow
> userspace to do it from the initrd too. IDK if that is more/less
> interesting to Android.

Could you point me to the series you are referring to? I want to be
sure I'm looking at the right patches :)

>
> >  static unsigned int iommu_def_domain_type __read_mostly;
> >  static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
> >  static u32 iommu_cmd_line __read_mostly;
> > +static char iommu_passthrough_devs[IOMMU_PASSTHROUGH_DEVS_MAX_LEN] __read_mostly;
>
> We can allocate memory at this point.. No need for a fixed array.

Will fix.

Thanks,

Peter
