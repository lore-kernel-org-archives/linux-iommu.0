Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830E13D2A9
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473619; cv=none; b=VWmaAnxoNqty3raDdqbvu0gfr271MWIqteqVQcZL0vLUBmpLupDPFQtN0Vvi0UqHslLSy8mbNbNz8oGnlxnjz52oGRhnFW7A2BRagbuWFMBlv8dbw6erjmhMtYM+GDur2fBLoo+gpvUCFH4WhjXQw5tX7ZbRXRndsYZvvA5VBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473619; c=relaxed/simple;
	bh=bJcXbdXi/bBMjFx84WzwakUtCeMe/SHb2HmqPvKtDhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdxyMVBgw/+doUtE+sosOCVUoeN3xuq8QQXd1Zkn613x+Wsu1tpXKYcrDg+sSe3RjEDDTfYpaapHLycSf3qf+PeEcCYCr7gvBoW9X9826wF2g6Z73A/8Zg0g1S+PbrRkhTK+KAX4X+VymNnTw9SWMa2Yp+CeBKIbIk1rCfFHw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AyruBao+; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AyruBao+"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so41868301fa.1
        for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726473600; x=1727078400; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qudf2MQ3UZQreuuw4+jXlv16vEaaWx0V0RrDsu0g1yU=;
        b=AyruBao+O1CknW6sJluxrpneHyGFRj8oWoukGjkKmiLU5uU559MX4pmGuKnIrWUgIq
         tK7LChIsZe2VtTEMuRW1blP6PN3SykAkDeecm8Vgu3z59iv+eTWfxzVd5/fxACtynkoy
         3P16N/HxBtGgKYcVkWwt3RVyLu5+2wvGFyV/BsSxmPkiCuzGUqJFutJ4zV4BSV5x24rp
         A6haqeEjWB+geB5sA8Af/U/GRtcGwAimWTLpsHzSmerO0YraFI+ZECCqJ8IgvzeC881k
         6mmU+DnTrjoL9JzsDXFdwd7Py7gcNUiVQTgHFGSeDueV0iR//5Oa4ODGgejxKoNv4qd2
         xktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726473600; x=1727078400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qudf2MQ3UZQreuuw4+jXlv16vEaaWx0V0RrDsu0g1yU=;
        b=fOXSdspK+JNYhW1ZYTbbo4DkKxxnKYvvqWAcqIT/RIZFIQdJZZOVDku8nnnnB0iSE6
         U24rDfSDlU70qtOFAm9NSdXEBBV25g+3MJ5v0icEvHAA7RJMrHbSOKsSloga3kQV7DXe
         QstNBo2Xij5ZpFX+9rnbnqwZJMNDu4dOiewsiClZDGBxi5R/CeqssjnwjGFLpKLI7RRj
         jhkBAJb/s6sqj7HbUXXmAoU+1GKdIFcWQq1m7rBqh7TUlwj1H4IM4YnqCR+7+P7eJdAw
         Izij39wC413r7fAnCMO9Av4tx4PFwrCpT8Fn9/bAB40sQjl3WkLs+es/473W4ug7UVyO
         cszQ==
X-Forwarded-Encrypted: i=1; AJvYcCXugMZBIkYfgDzkMKBvVAD+i4E0RdERNCVrSDLzR5fGDoXoVlXXuzlo3tc9MAkekqfrRuOrOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFBDQ/oDnqUIbRyWhnpYdUeysoUMxGRLG5c222adPaAZcZ/UTP
	koJ+ffH6ARHAT4h3Uz/wM66eO/izm/0hQsltLmGlqKApfCJLlh044zsI+H7WkQ==
X-Google-Smtp-Source: AGHT+IHdIkWMQR3aesRlGasdjYBJwe3tel2LE9D2ZWT2mM68cxw2NsWVmqtGdan6xXJwpw0uQcQ4aA==
X-Received: by 2002:a2e:611:0:b0:2f3:cd4e:b929 with SMTP id 38308e7fff4ca-2f787f1cbe0mr55700981fa.34.1726473599876;
        Mon, 16 Sep 2024 00:59:59 -0700 (PDT)
Received: from [10.9.6.216] (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e1fsm2395943a12.72.2024.09.16.00.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 00:59:59 -0700 (PDT)
Message-ID: <d0075562-6a21-4a87-b7f5-854f09c0743a@suse.com>
Date: Mon, 16 Sep 2024 09:59:59 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] xen/swiotlb: fix allocated size
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-3-jgross@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20240916064748.18071-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.09.2024 08:47, Juergen Gross wrote:
> The allocated size in xen_swiotlb_alloc_coherent() and
> xen_swiotlb_free_coherent() is calculated wrong for the case of
> XEN_PAGE_SIZE not matching PAGE_SIZE. Fix that.
> 
> Fixes: 7250f422da04 ("xen-swiotlb: use actually allocated size on check physical continuous")
> Reported-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -147,7 +147,7 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
>  	void *ret;
>  
>  	/* Align the allocation to the Xen page size */
> -	size = 1UL << (order + XEN_PAGE_SHIFT);
> +	size = ALIGN(size, XEN_PAGE_SIZE);

The way you're doing it has further positive effects, as the size
is now also no longer needlessly over-aligned. May want mentioning
in the description. Hope of course is that no-one came to rely on
the up-to-next-power-of-2 allocation anywhere (which of course
would be a bug there, yet might end in a perceived regression).

Jan
