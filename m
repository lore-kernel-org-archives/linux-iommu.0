Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E113633F
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020718; cv=none; b=Vzk/nBlyb8nT418p4bQuZpm1tf9QvuyBVUC+8IM/cSwmO/2ciHKFa0F7WUcJeuZ7xY8cGJwbq/XbzYUtGypAeKwX0or1E9IGasuGcIAdIKUhYvqpiirRsTrbpV0DWj88iedOFPJZw4BotFs/CsryGK9EWgDIHWm8o92codmSGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020718; c=relaxed/simple;
	bh=tPVRUhMWVkJ9PxP6Ur4tVUym6qpBliVYGzde6Kl4v1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GissViOEmrYyK/89InT3ElVHyMuEqJBhjXQZ1CyngiXd76Tt5tq1ANHywXQ3c+T2OVCyjN5rDD4JNSG7fBCf6KZ9cqXlSwnsx+U+4xKmquTzIL1YTrf+MaQchtXMio5AAA5i6QfpRCM3HvOYYbODhe0bG3fOsSVM4rRU5ZzHTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7SyhWP6; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7SyhWP6"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bef9b04adso3103061fa.1
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743020715; x=1743625515; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0fdi3IrtkqEcFmhvSbSZiTssjNUGS4pwIMBoAoOEqo=;
        b=Z7SyhWP6dCTlVA0IFQSPf7pmjcUZkp49qb6uuRK3H9NaQYq5ZWqypK5ylGhxjTjJyU
         uH3V/JbmNeHaApOaOu8eLB1JL4IXq8d9mxmmXtdsuk98J3s+9xdRHM/s3NldREWieGlI
         v2Yd/FaKZ/BX7FDrAEVLffUscCpXLopOUR66kQJDIHc7E5l0V8GAgmE8W3rYB8yqT8K1
         G6UHWTX6q2iF1dChkVzJUxSG+zlVTrMvOfYLGs4d2yfz3GffYCb2MogDwsEfwRzWbVKK
         +ZcKwJ83I2YaOQGMyWMAc4xD2cgBIvY5OPAm8xsKqi1w9mt6kH4rbj9NW/q5IvnXbax3
         /JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743020715; x=1743625515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0fdi3IrtkqEcFmhvSbSZiTssjNUGS4pwIMBoAoOEqo=;
        b=j0WiKXX8u1SQIVpW0UlH0hkjhuScfwBanffJ7y7tNNyfln+KlV+tixorRPrRT3BeMy
         v6wk99RSPjuXPZ/Wf+jPEozpT6JqMaYcv7Y7qAoOgtzAmXLLICzE1veEIazkReoLxSUT
         S9foP7AkumgCkSj69dJJzyZEKl6NHRqGUbcDfgm4i6Gn2+ymw13Og9oAVPjDS5GRw9GO
         AHEIJsivZFnK3uFTQ5am/KEAff3UifEYD4v5BezqS8Gv2ZxvTbfZAC2M8c9AmiiF7cZG
         yhdWSqHTOm8n3CTXbT/8E5MA88rM33Qe/nczAqNnxCOQm1j4Xn50m//cxLRezl25yuo+
         Aahw==
X-Forwarded-Encrypted: i=1; AJvYcCXcSCtp59McvLzvKo752RIa6OKkNLObrFYjXo6IFNlH3AH9pXjgDfliFjAGZkviXOkB+rsEkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxx2FVHOgAwr83tEp7nYyt8Q6mIWyT979HFhYYbr+WlVW63TL4N
	xwpgO2W5T5+KOe82tu4mWyKCvgnzZBAvytN5VFccu/MIQqd/70nV
X-Gm-Gg: ASbGncuoxJkRr7Uq2ga8y0EtSJA8z5ao6gx0gMQFWCcq6GCS62rvYnyrTiai7iJEPfy
	Af2HAxZaW5jaMcBmItm+IA0pkukPAZX4ni70vt9AcWpIkugjkMXsQk5gpSE75m7KGcXjoXRRdkI
	8ph3V3V5XnMJ4xpdvyQY3auKOTWrJDDByJozNacTvse4zU5XwptSdoXunAQcxTgjs71Xjhf/53R
	+CB1nF8VqGgNIEllEydNAhog8YfuX8OujROaBuyi757NdxIPWD4EUhgUEMguLooRDI4Rv53bbxr
	tMSZztZY2qcvZ6sHaBzx9VY0Nc33SZACuHFHQiWw7+Lr5fNL+NdwLWyipbr/U9Owy5vDvH2EdHs
	KkEf5XL/gDVK04k8pbRTEiLj6jKapM2zm
X-Google-Smtp-Source: AGHT+IFdOlY6bZJtugWwu4+7VhGr8RibxS/MBz2jzdvvu1DKGb190DlRGml6NCw91lHqsWPMebtLEQ==
X-Received: by 2002:a2e:a99a:0:b0:30b:c96a:775 with SMTP id 38308e7fff4ca-30dc5dce21emr5104141fa.14.1743020714870;
        Wed, 26 Mar 2025 13:25:14 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d8f398asm22753641fa.72.2025.03.26.13.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 13:25:13 -0700 (PDT)
Message-ID: <fdc54cf6-5574-4061-a90e-81bd9e2f2be1@gmail.com>
Date: Wed, 26 Mar 2025 22:25:11 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Additional fixes for dma coherent allocator
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: a.hindborg@kernel.org, ojeda@kernel.org,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 "open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]"
 <rust-for-linux@vger.kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
 <CANiq72n6X5gV2rGB=TEw0jPdiw7mT79bdEOXHP30j=mRk92_NQ@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CANiq72n6X5gV2rGB=TEw0jPdiw7mT79bdEOXHP30j=mRk92_NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Miguel,

On 26/03/2025 22:18, Miguel Ojeda wrote:
> On Wed, Mar 26, 2025 at 9:13 PM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> Additional fixups to improve the documentation and make the read/write
>> macros return Result as suggested by Andreas Hindborg as well as support
>> for reading and writing large blocks of data.
> 
> As far as I can tell, these seem improvements more than fixes -- so
> can they go through the normal process for the next cycle?
> 
Sure! I'm totally fine with it.

Regards,
Abdiel
