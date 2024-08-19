Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2614B07A
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039817; cv=none; b=Pn1W3DvkXU3A486xlmctynuKOYOTxlRzwIEG1oLcmRAQk3CDYoorpe/rc9xeHu/oDemhb4FLlHz9MQboDN4DKORhV2HxXCgHhgMVu+rWEtSQKXnL4+qZqsKOiE5rKceIgK9YGrVs2SrMgLlWVeDOm9/jGCa8Y0InB7dhHKf68CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039817; c=relaxed/simple;
	bh=b2XP9qt4WiDnxVai+yZ3Q/QEPSSxZYo1oeVtpDg2Qeo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CbSMrDYh2asncSP8Ey+HPXSQa9swJV2ChrUhEb6macDnZc9U4TfAkcGkenSbFiiBYXme5+IaySkl3qVaRAD++oZwssAgMshn3wcwBe3Ikr0jujpUNnKjgpsxXU4tx11qGwTSBkxToFVM9aHqtIFXl96oneRGvTQfT3A9y+OSkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RDuUVpo9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RDuUVpo9"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-713eeb4e4bcso631985b3a.0
        for <iommu@lists.linux.dev>; Sun, 18 Aug 2024 20:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724039815; x=1724644615; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b2XP9qt4WiDnxVai+yZ3Q/QEPSSxZYo1oeVtpDg2Qeo=;
        b=RDuUVpo9ecS1b+jjM+8GBUlooaEPpLGJAjyCyb66H3uUk/gsd/8ZdLOZUbZCRA3/E4
         AHyQowzvpcI+FEOS6hPH7HVcDhK2bPOn84szfTI0anlz9qJRgs3arfr+iujFLovNY0rU
         ZjYviTy7ICQWPhvd3hejxe2Ev/mxlba3kqlYmJP5HSEs0Q1dOYZj1jJIs1AY/gTUusNv
         +ZB9qnNWWz9AvDn70krpvfjEYIvis6xeWwGapoiRA0eS/ODKaOLYCojpJCZJAqQnWAa2
         med+2V9y0SA2jxJTMbGcgRcddg1d6VYymaybOVVdFnEe5oElOTBDcjYxPB10iqxOidVx
         B/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724039815; x=1724644615;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2XP9qt4WiDnxVai+yZ3Q/QEPSSxZYo1oeVtpDg2Qeo=;
        b=DUp7Dic6jjD6wDD21EkrjgbkpuZY8yKZILoVWR0B2S2dEAyVy5Pw+zWpU2lHYKdfUi
         0J3qHHPUrHQvUrBGKnvGOY3e4m86rvceuaUMU7faeeW/Gq+7z4/aeqjrItLWiCkEiGkq
         7V8ncFHvO3TADaN6pclcOQgd9uQXpsiA0KdbmT5pJtUN7iQDt+LV3xwwVJ5Iata8iA21
         HiqERgrwzwOXfzNmDh++nF0GXkOu2U/xNhnuDUUzGp7Ng10oyoUj3PduldO4LxyoFzCZ
         eGzWD14Kq1A07EbYYDTrRy7D6LCOeT2RvQArZbrhvtU/G+eWxKdvoyygy+VHTheH5x+h
         F2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUy+4QlgwUn85mjPJ2SBL1G/Y36+eCZTPM5t0+VJ9YZMfEkxqns4HPlF6vEbjwAajXrBVeGwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeikLfQEeIFL3LYvFHJPnTFArH+rqCOR70r2KVkdtt1swnAXbw
	dBhZB126cRc0ZIaFUBe5IKyYKdLKNfDQLwzjiR5ta1u5J6ZiJ/c/jlCZYcscr8GFYKhop9uso/9
	R03XipPFWuhR71YkSNXavOZjBWzUFDdO57ANnvw==
X-Google-Smtp-Source: AGHT+IFRmeijuWgcIPUvZe5rDsbgHAprwbzoc9Fm+JAZIl1kHl+S6Lh8Zl5U6KX1nM3J1SaiRn5Awcetq43jZJrqJWI=
X-Received: by 2002:a05:6a21:3a81:b0:1be:d1bf:a371 with SMTP id
 adf61e73a8af0-1c9050477c9mr13184110637.33.1724039815234; Sun, 18 Aug 2024
 20:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 19 Aug 2024 11:56:44 +0800
Message-ID: <CAPYmKFsTcurrUiWqM8cFj+GgqfRiaLqPDGOTSE+RLyKJGSKE2g@mail.gmail.com>
Subject: Some feedbacks on RISC-V IOMMU driver
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	sunilvl@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com, baolu.lu@linux.intel.com, 
	Hangjing Li <lihangjing@bytedance.com>, Yongji Xie <xieyongji@bytedance.com>, 
	wangqian.rd@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hi Tomasz,

Thanks for your brilliant job on RISC-V IOMMU driver. It helps us a
lot for what we are doing. Below is our feedback on the existing
implementation[1].

1) Some IOMMU HW may only support 32-bit granularity access on its
control registers (even when the register is 8 byte length). Maybe it
is better to provide a 32-bit access method for 8 byte length
registers like what opensbi does on ACLINT MTIME register.

2) In the IOMMU fault queue handling procedure, I wonder whether it is
better to clear the fqmf/fqof bit first, and then clear the ipsr.fip
bit. Otherwise the ipsr.fip can not be cleared and a redundant
interrupt will be signaled.

Best regards!
Xu Lu

[1] https://lore.kernel.org/all/cover.1718388908.git.tjeznach@rivosinc.com/
