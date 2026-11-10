Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322062;
	b=nIMGJupMbjd6qLQjQN159O/vXbsyd+Z3E+j6YXymC5U+5Xnt5Btetk6MLigCLgnHT5XQ
	 dyBxGjnwUxjmqb0Y6aL4tM4n2SQ3DwbCMb7bLLCdNdsOd6KggSJTfpJkK2C9JUR+AOTk7
	 MM30VhljqT2qqftFOliNYMBoYL8vPJbU6uMKCHivPh5HpGyG3sW6+eMRavylY0e3o/Q50
	 43stjCak/100A/ynUZHIo9QknkShbjntFs+NczIl7FaxIN/izebNgBJqYF/5dVMMe7CPP
	 jwU5IWCweB0VUhQoMpxuwqetM4XHRr1J4qsssM4GoRefJUBF/GEFYNR2bNQArjbnxRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ZFEAJe5RSOFhQbOQqwNvxFPxejburOXhpBzwnwwZqdo=;
	b=W7wTc+KC+8Vy8QvpaczAWxzh3hTykyhas5VtW9BMTJiLsOrg2p3wijnY0CS5+4aRYjzr
	 PAN5Tfh5/4lh3UcoIGG/HLyXcjxPbEIBefricZJUbS2fwWv43oEkFW00qlrcb7YkXN0BM
	 eWv/ElwH9mC/SeeZAQ+Y06ECLtTw4nOatqQwCps5Hsq1kocPssS5m19Qq9ILTQPV+vmNc
	 SQEYyN6Ln7WGTbNKtkQDMPJN8NLmuvbyBEd0iW29u3QloQZFORk77NRXsrP/NmvWaR4we
	 fUlPxLq88fJ0P4RmAhCZWc6xlrt/Buq4qQ4Hl2zEIFS8m89foFWz3QjF//s18/7Pkig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UnlnATDt;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3635560A2614
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 14:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3635560A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UnlnATDt
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2e14babc8so1203534137.2
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 06:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794322061; x=1794926861; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZFEAJe5RSOFhQbOQqwNvxFPxejburOXhpBzwnwwZqdo=;
        b=UnlnATDtPHdvCzldCvkxBcmvYqTOx3hAuIRFM2ms5GWBfUet33ZsXhBSZc2k447X30
         4AsESnj2o5ATywOetxo93wRnlkpDu2jQqEZ+0hxk6pXRpvZvISgJVLEYYEI/vtm87sw0
         11h5x05XUPRWClZUUmyqQJURmmD97CLpx/MchfnY0WUU9kXwCW0ZpHeayTQTgnHR8xKb
         SdUEMjSM9dXe/KQpDBDq+PS8C1FLZjIuF0QDK52VTMPvgmXAYqnoWXGQOyMUfnNsPBAx
         GS9xVA7l92Fwz1/W4rKw0481CZ09B7XJYpnpC3vG/lbGLFicwET2wuO/wSxGhr9Ac01M
         KWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322061; x=1794926861;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFEAJe5RSOFhQbOQqwNvxFPxejburOXhpBzwnwwZqdo=;
        b=U7h/hnqDQldtvzwU3ao5oUf27pkjo8Y3YNRlWdsO+FIBM//VLJaWoVGVAXPB+wGSC0
         k+UVHN3SJ+J47OjPNZP8cmagZTK16xhBSZ82FmmGq1UZiIBMzxXAJYaHXYgb8zeRXmXr
         kDZyk8Ew9jdf86N+tHTEQAcrdsZfc6LkoUUPnVVfvmw8kfHeJ5/GLniEeOgSgZQ9UecA
         CVMpRhFO6w5DWIYD815dv+BZ4NfRPiuoqf8XIusAzSkcSxTWnn6FKs6MPpz/ZI4WlIqY
         5AtGMmPYamIO3yJF9ymtWwztZR7BY+P4csZa8LMGJiSdjHVvPfFRBOIJN85BeQlfbGtM
         AzPw==
X-Forwarded-Encrypted: i=1; AL+hErH3U2vRB9utZgxMRKDj6eqmNhPKEQIL5/jB8mWFOjP/tD0o2BCr1khEvDI6+xxE4WNN32dfjg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9gewh6HhVejHI59Q+q0+P3DmHm+JHjzySCB6xNiOAB/ufLcu7Z
	DxSUmfWN1tvIC7V8jEzLasmf1am6nBVGPPN3WE/+6HwX/EM1ZGfKFr6eEccviIL9tpE=
X-Gm-Gg: AYBFou0aeEdhhEZT/Rs8l5TjgoVE9Iky4jmCqyyQPPDmYVyTdZyj4fbzaJLYUJ828/B
	sarViqm9F0V3fhltrGrUjWDz24qelryMh+Y7V7GMDz4pd77BLpGC0yqQg14fwkxR58OVqNB/8Ov
	CBi6QH2hItWULnIBybqp7guhFMJdMjoZKknmuddXGauQDWn2koNgjzO9W8a9eLkZTP/UHs7nlOH
	cZzqRP/HfqUN5bLToWxHGoT7vDgXBR/+Fi+4E1xkc/6x3oWR9Vyys8y6thGW/XN846RfFUFBIx/
	UpAlRiHKqGc3D5nAqliAYVU4bvbKGTQS9xM29lyRX11AfNSRtu94y3Tuegx9va8TjjpH2ajKSQW
	KZJf4VIVUMWqlFH4KttOHyPiA/QM4fs+kgPB+XQo988u2Pk8mcOaYBJbEjxah8LTPD8aCfYMkBC
	xxY46OPmi89jdDGalfU5Lu1r/mfw6f0q7yedzKVgP8PJEwVX2LTyplaa7dLROAZPpyLrx7V7Sna
	ndmqxYYCFrR6HYalLywSfKeDj+0EQkJGSY4vglKxW78hIMYqwIr33lZ+miLmbY0Y3mb2igO//Xs
	dJu33nioN2a9IZuYgKtG2VFDoQnoHAjC3VwDgL8R6Br6Rq1638t/yP6F6BV72anN/TpXZsWBlGd
	egyHWUHSUS+hHfTE22HpvweeBt/QBLuz05X4Z1I1PLm0d9pQ=
X-Received: by 2002:a67:e706:0:b0:7cc:26a8:e716 with SMTP id ada2fe7eead31-7d301c2b6b9mr1064638137.18.1794322061210;
        Tue, 10 Nov 2026 06:47:41 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c2003b37csm1895903241.6.2026.11.10.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:47:40 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 04/19] liveupdate: Reference struct luo_file_set_ser
 via serialized pointer
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, 
 will@kernel.org, David Matlack <dmatlack@google.com>, 
 Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, 
 loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, 
 baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
 oupton@kernel.org, alex@shazbot.org, gle.com@google.com, 
 pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, 
 kevin.tian@intel.com, joro@8bytes.org, kvmarm@lists.linux.dev, 
 linux-pci@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
 kexec@lists.infradead.org, kvm@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261110050202.529473-5-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-5-tarunsahu@google.com>
Date: Tue, 10 Nov 2026 09:47:35 -0500
Message-Id: <179432205559.2329176.7688399969919556416.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=791;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=qYrWWLSjrMyi3btEEyRhgD14ybrNmyQeqN8ETOUOvP4=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8y6LmPCnN2SrnZCSda58BBnTZsMnjk7g+kA/g
 6Wo/AVJiseJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavMuiwAKCRC7dyhM23N6
 3qrED/9liUyRUpQr+Sv1ioZ2pUvLcetyB+2JoLxaB/0UYYNHqDXpwWtEHhSP3eAYwEET2WAzSzb
 cINjQ0UdR20OJBBxpWT+3R6jrxl6smFx5lA1+CtzCdBONdl5NiW3+NITRy2Ip//vGFZKdNjWFk/
 5Y0ii3L7iz6hVXT9R9y6mqGOo2TBCSa84xWnOGrVJ8ijAnCqgOeAMhmqVN+rkl/dWCvzMcCFZZP
 AYRuSxmCQaOa9GxsOttPL5pX10r/UbwioXQZu/aJ6RcG+ql2liIZFv1+3mcSyInleN3SlnUZOVi
 inOQM3Yp2D1a6ekPH7F6Uzb45X4qnnJ8DSfO2LkVSWgmzzpsKuXUePJ8Pe0a7FfO9mUYj5Fp9wg
 IxfJUyigWzzPN0aOcgePZcZBT4fLUlw+zQV3UGnfTiTzevMagmFWU2+B/s0Zt7u6TidXvFQsMFI
 6ZlD5aySuQGLYM3+UdGdp96SY6FEGgvqmSCG63zPbq7Y2WqSBl153diBep17zLt4CJ8n3Fd+YrU
 E2rPF9GR7k6MT1Qc2tSSvCCk+cTjcDt4Fm3op7Z6LrxP3BQDFa0Fh2afBgG5mCHbK8fSxd2uggj
 NuHbXeBNgQpe1vKYQQd97AUSoFlymseer2cfqgpdkxtIZwGdPAYPchrVuPHKx6mZDNkSz6VZZ49
 k5DwAzPXt9kz4Og==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Tue, 10 Nov 2026 05:01:47 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> struct luo_session_ser currently embeds struct luo_file_set_ser directly
> by value. Embedding struct luo_file_set_ser couples the session layout's
> size and field offsets to struct luo_file_set_ser, preventing either
> structure from appending fields independently across kexec.
> 
> Convert struct luo_session_ser to hold a DECLARE_KHOSER_PTR pointer to
> struct luo_file_set_ser instead of embedding it by value. Reserve space
> for both structures in each session block-set entry, placing struct
> luo_file_set_ser immediately after struct luo_session_ser, and bump
> LUO_ABI_COMPATIBLE from luo-v5 to luo-v6.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha

