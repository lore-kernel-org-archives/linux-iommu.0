Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4D4D8CE
	for <iommu@lists.linux.dev>; Sat, 28 Jun 2025 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751099775; cv=none; b=JBKcn6N8a7mYjo98rG7MkN2a1RCSmN3/4uMfqWJKrrijXu04nUQGvqukXhbEv9dI7WEYQNmi9EddHKtqJTVIOSWsFRNadO6SO0kE6r4HjBnttjiKoX66LXyt0GyntxL2TwBa4g/xmrkjroOMYl1Y66Le9Vz4oLN6WTXocIHxi6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751099775; c=relaxed/simple;
	bh=vV7RonoZBLqtd8bEVhpmeCAo/58cisOUaArojO7SZkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVVBK0iLWrJnSHfYfBoylCQq7npZsTixYvDR9dwWIB4qYgG+5klVB/aeFJQQRGujCoHjgIfNkd2+Q2xQhcE3mara0wufoWQLaOo5CcPQR9vDVOR69Wt5yw0rz6loxrBhnaJ5bY23njgLfY2O8aAbKkeXqOOvXBO2PFrIGD7wTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sqKXmulG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sqKXmulG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6070a8f99ffso442472a12.3
        for <iommu@lists.linux.dev>; Sat, 28 Jun 2025 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751099772; x=1751704572; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2rH9BlYUujAtn0szsEikQz+xplSeERMbYhhICLQkcGk=;
        b=sqKXmulGBXaGt7Cv7s8Qk93a5ZpkCrMMbTeBwlbRS91SuuGIj4NnrkzOQbgE9BJzWn
         BAKsziv8aBbeugLQvw2W70NtX+L/5B2iSwjiYF65lmhqbzN7byTW2AkWSpuNAOIahaH3
         FmejEOXXZtR0ifLC8h7VvUGsluUbhAUxzfENuZF9XUtP51fVXZMayFN7orSKyTzHHlcf
         8xv7Bve0SW3ntfDmNfeWHxnVk+NajM8PgnBgPbK/trwrN4/VuSCYigfyaWceZoFaQB4P
         8RWYjOvZDfVlHN5s/SVHgQV2sAEovxEZLuG8ceM/JoSMcvoLl8DPA7SpyT5RMAhJwByu
         004g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751099772; x=1751704572;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rH9BlYUujAtn0szsEikQz+xplSeERMbYhhICLQkcGk=;
        b=hOJIfV1D5E0jMrBYiUn4fI9JJnSZOvedwKgvSHXIVus8s8iNqwZgHtJvJF5JkvrKo/
         uTzifZA7WbwHmojVhdNuzTxzYiCZXzmCLrY5DWX8Wtbq3KLeioL9Gk5mgaNJQtxgnhs+
         3TSSIW3fnHbxIkRQZ4+JmQZOU78fCrWpAt4ZuITPEpjcSwXhFFTcGsR4bz+eooRy14PM
         bu7rfHL0hW78S6XWgfu1x48GKHvj4OB2CaxspiFJmr9I32j9ytS+UO61cfa0RsOTuE2a
         VB9s53SFOS/klGJnQEvcCxJg0cKVxELTUcHtSE4tJEkSbF+dpcULh9EgUYbLCbc4ROv1
         fCUg==
X-Gm-Message-State: AOJu0Yxa+LGhFtgnBgqa0pW1GD10BTcv/gVakHhWVYyi22ocgSiuEPLn
	bDWH9GQWn0nOkpkwMLIZC0haObvfu3me6SG2T7A5CCFjXOJQJlnGIURoGaJwlevH/hw=
X-Gm-Gg: ASbGncu0FmfUUpwTXIHusqAB3F3p6h1XbBn8A6lMduDjvHyOm0rDmLuOPGHSe7sx1Ud
	TkFwsFgeowuyyAclnksK4iwJdVBh9Xjpbj6yHG5SeF6PNvk5rCRPvCWucnTaZw7yXfEJnFAmGa1
	0vbMyPCylq9fQ7k1Tv4hxVmokx4xbozeEnxEXJ4TmonJnDKdarqXphbwtiNfDfqaLxcK5Zt0PWS
	6u3zvhZIeQPyaDD6AJl4C/S5LcPLs1KVA/eZ9RP+STWf8rFIDP14Fq4LhiQD/HIxOCwyCLVkua/
	tqvyYZquUTgfYQyl5FaQEPJSo0K3UCGATkjDKp2QJ4vPCrtFa1gICiISKJFbNKcH3pqmNseuOQj
	77rAVLFush6sELE0=
X-Google-Smtp-Source: AGHT+IEC95YGQTUZplG6mM1XnXrpcmt1FOskC/y/jwxAHjVTucahWCeAyjJhBLY/WgD8AnFYJNssQQ==
X-Received: by 2002:a17:907:940c:b0:ade:328a:95d1 with SMTP id a640c23a62f3a-ae36aa096b6mr69794866b.10.1751099772128;
        Sat, 28 Jun 2025 01:36:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363aff6sm277044866b.19.2025.06.28.01.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 01:36:11 -0700 (PDT)
Message-ID: <47937e98-c6b0-45f9-b610-cd2754f9e861@linaro.org>
Date: Sat, 28 Jun 2025 10:36:09 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/mediatek-v1: Tidy up probe_finalize
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com
References: <7c78149504900bc6c98a9c48f4418934b72d89ac.1751036478.git.robin.murphy@arm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <7c78149504900bc6c98a9c48f4418934b72d89ac.1751036478.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/2025 17:07, Robin Murphy wrote:
> Krzysztof points out that although the driver now supports COMPILE_TEST
> for other architectures, it does not build cleanly with W=1 where the
> stubbed-out ARM API can lead to an unused variable warning.
> 
> Since this is effectively the correct intent of the code in such cases,
> mark it as __maybe_unused, tidying up some cruft in the process.
> 
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Since I'd already got as far as thinking this through, I figure I may
> as well save Krzysztof the trouble of rewriting it :)

Sure, thanks!

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
