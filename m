Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6170814
	for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655526; cv=none; b=UfdS42SJiSM35VNR3WUqy9XcNXxK70Fce/lKzxknUBPHwBfs8Ijmx/Iecd4tsWXoUth7b6GgvdM8LvXkl4e+MGgIl34o3r7HF0asTuqAgrwlaubAPUp78GqgCkVG6FMkc96xS2Me748RMVPgGfyNtvegJHvTL8MbAT9xbQJvox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655526; c=relaxed/simple;
	bh=pD2wyVS9S4hK5ior0MWTs+rsfRGHshMDbPlBWECXKi0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=m0b6mqbKd2F3nkMcfGzJE6RehKU/imMX1KOxfbGgMlkqma7mIfZunaeZuCEfRRcBL+GriDhqb/lOPalDXcjvwpbKGAK0vnMxf4si+rXyP52NF9M9xZywYWZmig19YEheqjSxR+QiC6AxT3EHO5/KnuKqoEk5ayjRbh3U06R2aIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2463xee; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2463xee"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c0eb94ac3so10540633a12.2
        for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761655523; x=1762260323; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pD2wyVS9S4hK5ior0MWTs+rsfRGHshMDbPlBWECXKi0=;
        b=G2463xeexdffB4OBxNMTKoM9NKpW4tyrpMf0hWqgtDit7JuOkaYF0K5VgoTQAQOkpg
         cjxl5mnESoFS1UZuFevF9jo6NfMe+523bSL4PJ77QNCkIYPmkDCywYBVFbGNds91wGwW
         PIYQvY+LarJtYyy0D2NKgcNkkrMyHVdimDFtThanjsKyIDuvpTYgc7VbO968ZYAvLkTL
         s05zoU+2NxfTDGbqKlD7TMookxK6X5RBOWzqtX0fHIURWlaCyH9VULVSHEY4UFXq7jaW
         UQl4UwHB7hSo3ezdq07taoEUF+FqDaaVu9+sUgPR4pgqAkqrwbkLE0mlFFYLv5FQ1DB2
         tO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761655523; x=1762260323;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pD2wyVS9S4hK5ior0MWTs+rsfRGHshMDbPlBWECXKi0=;
        b=OiTXkqUJuYx0gtBkimxWFiKQdLGddUaninQT6d8y+M88iQnQOPJUoaD06nSydi9eZr
         ARoxppxPYJwgTuGtukQ96+sW8qC2KtYctX0Qu7FWJRwAeFbSVwX1brZy1jmUl0Do6ThK
         cRtZbMg9v9fs4i2i88O4a2d/Maiae7FFLHwXhYFn8d/KJ3eb07eh/2BKiMrP9XFjzt8h
         Xf8ad0mhVC540ear3BHYpH6g5Fm5YtH2QTZDVzNIEOzegCiSojN6r3nZXDj7YzQqBFTT
         df+7NrVqpwqbM4ricQj4uCA+FlyyeECCt/jgZO7BV2VKd7XbvOEROwRxvcde9HG5jQFh
         Gvuw==
X-Gm-Message-State: AOJu0YzeWf4gpo8RmlihCwkvdf1QehBbpMm84LMB2qf77z8QZAbWNV/3
	z+QC40WYhaV+pqv8sFvPwIv6ORQFI2LyEdUz8lvkAIIbxAngbrMri5B2bo0a1W6wkMv310dGBeI
	nWk3tAJaVH/sKTFLPvVwEP7FzwaeDFYw=
X-Gm-Gg: ASbGncuisFGPPicgzb3anj+N5uDUWXnBkrvu2FX3morc1GAmSHTKbUc8iExn471+4ec
	fbykFSYXKiLTPofIwvUnCjy+zgkSqWSfvnSRkkuQkb1GkXjuxQTQ+CcN4yCrSDz0teskRzEyukj
	bVh7yXIgX4XOFxtSxof0ykBFX6S6xjw7IX8WoS97alyY5RecoEOXn15d17CE53Drki1hugd39AL
	XGKUQirHClqILZR2yV9lunoy7uRBPVXxH9t7TNfSNMwovHwKjbR6mqhjs+6
X-Google-Smtp-Source: AGHT+IH46MShUzaMMndH4fBGSeQ86Y0UMqWKRy0Hg7cZyNdRcf5CVne0a9e3jLaxdSu07hi1Yzy4mqs89mWqzsQWrpM=
X-Received: by 2002:a05:6402:4415:b0:63c:215e:4377 with SMTP id
 4fb4d7f45d1cf-63ed8162202mr3154546a12.24.1761655522954; Tue, 28 Oct 2025
 05:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: zhang bruce <brucezhang5337@gmail.com>
Date: Tue, 28 Oct 2025 20:45:10 +0800
X-Gm-Features: AWmQ_bmrlCUJIPjAUhRmm6nODZ5mR7spZp0Ws6NHFBtOyRurdDxQOgzJ7Nf7mjw
Message-ID: <CAJZPk7T0K51zBKNNQXw2qx9OYrPa8BJ6jQTvOM-YrxwBndPbzQ@mail.gmail.com>
Subject: Question about IOMMU and streaming DMA
To: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, chenglingfei22s@ict.ac.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

The driver invokes the dma_sync_single_for_cpu API to access the
current state of the dma_buffer data.
However, dma_sync_sync_single_for_cpu does not unmap the IOMMU
mapping. In this case, while the
driver is reading the dma_buffer data, can the device still modify the
data concurrently?

If the IOMMU mapping remains valid, how is the ownership of the buffer
transferred from the device to the CPU [1]?

[1]https://lwn.net/Articles/75780/

Best regards!
