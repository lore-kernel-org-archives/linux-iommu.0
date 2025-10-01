Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2D23BCE4
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299380; cv=none; b=Bv9bnKsKDpoCJ6g2aawymQ0noSmiGs44ShJJysGBb1kcsF3raidYrpO8TwloI1qcetxc0fmy+EQe0JAFsL9O3oAHBLlt/CL5G7VZHZPpABwBHKmCQOHfOfdHMsFHfoegxQ6V4c8lbi3H1wwxVZb3VKnoQlBl1gVwsBjcYdzwhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299380; c=relaxed/simple;
	bh=EsZHnwMiJYPfidoSqF4cLJPZLMaFXC7b5B5xbjHh7PY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTIRxQWllGx90kttpnm7+rolyRROvHnkbvX6sMau5aS52mz2/LyqVOd+1b/mJ60TR2naCQBrWaXpC1K7A4kthXbXh+Qnq4p59rGVUyHPpqpjfMEZV6aJ1w9YnY9WJBkwEKzN9Ebyle1uvLYuvzVZQfantVQTwteCdj8xppjepV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SFWnFxV7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SFWnFxV7"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fe4a1d872so1348947a12.0
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759299377; x=1759904177; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2mgRUvHIwDUBa1m0CHFDPXrUsPClCypgfwL+/TQDD4=;
        b=SFWnFxV7V3HQFw/Tl6BgVYrPIA3upFaV9WMaE6GBWq57AqBU4IanksU/vp+SiJB6UP
         p40k4djYH4d2shZ0OLNf2Bm5Nep65LoQTkCS15wjUdo/O9/VeLmhhCfkmqetz8Qvtnxm
         PgGKNPSIYl1C6mXC4B69yWflSNj58r+EGXGOiaksibA/nM2qtuM683WSmx7jc7lzyBdb
         px4WgvMte/8OcWKDJ6efvbsfUCTyTnVNnlANm+gO/UwOcRfLlxioogH5b0bJ2taojuhz
         Qmvl7a0r0jUAR3S/9bCdCO+Cvd5KGvAPy3Yj0zjqt0v5KZLRB562QpQiF54QJke2ctQ0
         Z22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299377; x=1759904177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2mgRUvHIwDUBa1m0CHFDPXrUsPClCypgfwL+/TQDD4=;
        b=JRw+pApxiJgzWF2tZN2kWYDzFO5OpAw3JVZy2/JnQe5hQkHRK8MV+mP7u+k8cRMGfw
         ruvBEpDgPUYvBgs3GXvNGWUZ+sii4zAQdo9A4ghcYWdpRgyk6xY4RHPkUYQ4YkgiKtg2
         Obg5+TAYvWPCChLlHydjperBoLSDMUjYM32qudZXva71KNKk1kHi7robPvNVSUqOh/T8
         VyNiWl7NYw4POM8psseOZaLI5gqLj/IfDxGmya7bC3hokas/omk/3N9D5zXHehIjEUpM
         gHG6vGbQ9hU5l42Jnh/nMV6/K6YA8hUX28vZnRglaV4H1quVd838rXqCRn3IskQSxVup
         CYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxxjtRFhdEP5/cHhBHzYQ8sP2B7+9J8sJJRDOhmey57hzrRiS9lgIaWnM5pgrdZn30Io/yKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyW8FJiKMoHv7x19xlPazze0oDhf5n9fz1Fe2r4u5IFDzd6c0NH
	EIgYp5GimSIgQHgfY2lO5hM85R3SDXR43/t7blBKK0EnwfGutTvkhkM5F5cY2Ukxnsg=
X-Gm-Gg: ASbGncskNfemmkP+AhnT6SucCws0slJD9a3pkOTgrjsatIGPNrW1N1Cb2NARoGGRob1
	7mHts/sqT6suVQ8FmQ54sYvsO7M6R9EEdV6riqFdrg8ePmIGay+he9fr8I0TibS7RDg13YUEW2N
	kv4/kA36QmHUeIw9DY3bc/SpPZtVe0H82DByYuz9oPNP3Gb1MYIIXy5CKVZHtowRORW6X6eXvUQ
	s35KZnScisPG3RVkuCV2qc6MoXcUk0DGVW+f5H/uu7sj7fp7uc0m0Y1vAShPgbI9KQ/dhdnoWEh
	OUJA7Ho2LI5xhTglDEHA7GR/R5pBcTia1wfK8saASKevFk8dT5owW1nwT9fQDVmGFQABe7wsTkr
	XZ9+QZIi1NJCCEdy2frrQnDjLer0iBJsetT+BTheT/4sbXjq8+GYZ8KVogLNqc+kiQxkreIgLNI
	DS8X1Uyr1SgKEaxhemLCOwjQVWsd8aOVzqgJLpXMan74Y/H13cKjZr
X-Google-Smtp-Source: AGHT+IFQWcwToJXtlmVcxmZdWqb+p7usl4TzaktlGgv885VDmhxQ95bwd+azkuh9E8Say4Z2rE5kaw==
X-Received: by 2002:a05:6402:348a:b0:634:cc8a:5428 with SMTP id 4fb4d7f45d1cf-63678c4357dmr1386965a12.2.1759299376749;
        Tue, 30 Sep 2025 23:16:16 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634c4b96ff6sm8623357a12.46.2025.09.30.23.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:16:16 -0700 (PDT)
Date: Wed, 1 Oct 2025 08:16:05 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Anderson <sean.anderson@linux.dev>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix direction in dma_alloc direction
 traces
Message-ID: <20251001081605.4f86a6cf@mordecai.tesarici.cz>
In-Reply-To: <20251001061028.412258-1-ptesarik@suse.com>
References: <20251001061028.412258-1-ptesarik@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Cc: stable@vger.kernel.org

(One day, I'll finally remember, I promise.)

Petr T

On Wed,  1 Oct 2025 08:10:28 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> Set __entry->dir to the actual "dir" parameter of all trace events
> in dma_alloc_class. This struct member was left uninitialized by
> mistake.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")
> ---
>  include/trace/events/dma.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index d8ddc27b6a7c8..945fcbaae77e9 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -134,6 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
>  		__entry->dma_addr = dma_addr;
>  		__entry->size = size;
>  		__entry->flags = flags;
> +		__entry->dir = dir;
>  		__entry->attrs = attrs;
>  	),
>  

