Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF921A239D
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339200; cv=none; b=nyGyNd4VKeQalNAhXeXTO9DC1CZs4M5TKBpxCS2dayoE1Ac7HguCH2L3eZkbsuuXqoYzibtKuJVtjFxvwF0M+b4Nl0pbCcZzmYmWN/uDi6lomf/fMoK2WS6HGLN7afaf5yLoiIA/P70j6qTf4x00j8Swb/XesK/K8pqTIDmDF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339200; c=relaxed/simple;
	bh=5KYg9/0yJZNBhIV0w7CJaMYU/vNi2eZZd1DkVtRdQQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sL0OTWuG+cqERc3HsUo6iz4K2nWi4+DUf0pYSzkmhK5k23uwLSLFnj42vMpopETGsjVD5cPpAHg/jdWJ9UkCxifM9ZTyktqOrangIC+SRROODFeE7bOb3TVJTScGSjkQ2Tpb5c0h2kRWQZj/Rpeo9v2kMDZAIsCpkFrJxxsebzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOtPzhyW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOtPzhyW"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-540215984f0so17210084e87.1
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 04:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736339197; x=1736943997; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0gfeN+SuCgEzLzAVq2P0LR/0PNaBIiceVwqkkIzMjw=;
        b=NOtPzhyWoooShze9dafwZA9LpoDXf7PqbPH7cnspLqh6AhG5/k+a/RyJKNrKMM3yHP
         /iYdw8JOaIsavN+sXC78CAjkHUc5jcWrQ1aVnrmn7MfqSn/cmSRrGcm53ljPzhN0Ekfa
         6uD5Ov3B6AYpWYAq5EaxUHD8mHTRO19iUT7AFRGX1NPQHmIxoCly9UXEbzW40+fVmPoN
         /xj0W3NdIhmyeYFOOYQvOFBp31V78P1zH04QCPav8NBtHL7u3yrcKDa3w2h+Zjbx4WVe
         WEX3HQ0bMEBa/wdepUdol06uVKgrEO/ff/740VMYiBAosHw9oUMHro/pkUZ9NEuOnGRv
         Oalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736339197; x=1736943997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0gfeN+SuCgEzLzAVq2P0LR/0PNaBIiceVwqkkIzMjw=;
        b=suA1SU4SV2IiP5+DfCNy9DVHnFD7sjMBy07WYPySL7vURF0OfPNu8Q77oAsYEz+J64
         qGRvyn/U+qmna6k0eI1gsgf7hMICCYy8ELHm4SQrbBOnhxZ++iBB+MCR57OhX2WePUMi
         BOw+iibYabrS2CrD7Ov6PWgYBuyrcVvQPu+oAOlBp1H13FfJlAkXcAaxILNE5Dw/BSp1
         b8Xa3i11rt52qEYAHTT0BO2s2I4xvsefqb7HktT2Dbg21VD/bbhEjL5Fy8m642dhI0uI
         ETweSLY76VpPgDcbS8YTrVmR5wq8tCxvrgH+sfAqykorKSqVlNTaYj29x1EXoPglGR4g
         wz8A==
X-Forwarded-Encrypted: i=1; AJvYcCVsfzhdoRfRMiuLayHgMv4DKEAmMMQxmiEQ1HgyOH1e7XbNeMAM6/qFogy7p+Gt69SWIAVJzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDBCcNV7T09JbTH78GqHAKfrH8AlieCi9PT9XY76oniItzSMwA
	LwYUEzZpgAzl66ZdWwjO64W88bBqZhopVeM1zdDAGzBGhzokK7GK
X-Gm-Gg: ASbGncsgaeVuRNqIVk2EuU3y2ypt5ZFO/2H4v0ee1pbgC8HU3K+v4WfDW8VmlrlpFqD
	j/bNq8fCudbgHHTZ2+0OvjUvrf1verFJToa5htWpIR7Pf5GfkoHIw/qNPR9B3QE0NavBOiahwf4
	wRQneWO8ESiiaCHw0wgmo7WhyKgRIKcarRiYJjDfi/VkXm/MGd6XBcwiowpA9GNmruCfCaQjbK2
	YdAoobxUawFRLZUiY4WlTc3slSxLZmSaX0obQJLpdK2prtosK8cnn8Hu0trneRB8LlvIkdGN62g
	HvJqraKtYVmchBeJXK4TUaIr1jQ=
X-Google-Smtp-Source: AGHT+IHvQlmIb7RLno4uHBOmUskv+F4p+BSpZBj6A8Ym0/fvkduXlIkPMZ4yidM7h8v5qd/h576RyQ==
X-Received: by 2002:a05:6512:3da9:b0:53f:f074:801c with SMTP id 2adb3069b0e04-54284815c7dmr808380e87.41.1736339196661;
        Wed, 08 Jan 2025 04:26:36 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223813692sm5397107e87.125.2025.01.08.04.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 04:26:35 -0800 (PST)
Message-ID: <0af017a8-8796-4552-aa16-bf2735f7b4ac@gmail.com>
Date: Wed, 8 Jan 2025 14:26:34 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
 <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
 <7c8e84e7-a212-445f-bc4e-ef65dae7fb29@gmail.com> <87ikrflxxg.fsf@kernel.org>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <87ikrflxxg.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andreas,

On 19/12/2024 13:22, Andreas Hindborg wrote:
> If you include the `Allocator` trait and the `Pool` it would make my
> life a lot easier when rebasing nvme. For now I'm just going to use out
> of tree patches that include the dma pool.
> 
> If you do not have a user for dma pool, maybe just include the
> `Allocator` trait and indicate that it is there to support other dma
> allocators in the future?
> 
> 

Would it be okay with you to have the basic functionality merged first? 
Once this is done, I will send up a follow-up patch that would then 
include the allocator trait and the pool.

Thanks!

Cheers,
Abdiel
