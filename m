Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856343976A4
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321665; cv=none; b=dk0xkfw+rkaSkOkqkMyXvgWtE4UwHdML1e8n1q8lOSbcsBxQWP6icWCOcd+PCpzLBvDkAMgIGFrvvDtRhke5WqDDpMn4HNb90W6Nws7o/GnMoMtCjOcUt/h6XjGQVkpWnCuStfqeT+5dBujl8u2bRMmGAXzWgMreGGD9prcDt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321665; c=relaxed/simple;
	bh=pHaT0UF2+/TYyEtU2KWnSTLxajZpJo3t4LkID/vIQT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dAkMB5j8XZoC7pT3oiB3IE3IATbVnvlvFMLbfF+1Ks4k7RzbS6mdbKIppBntJxXG2zU3tFPe1Plbr0XvJycTufNsFNofEC//gfDGecuSRtGJMQY4EEuoeSFyWLsrCAj98pS2B+ealcLBCh1e24XQipFM/75D/etZoyVmEmp/R7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hh9Tk6oy; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hh9Tk6oy"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4784d0fb9cfso1309965f8f.2
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 00:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783321654; x=1783926454; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KUrzbaJQC6Xrx/utKgCBD6Z3BLENLPOFpin94j9wAk=;
        b=hh9Tk6oy2I0ECnUPRq4B7dXLAH8yj1mRWou0QifqyJdkTzOHKVeXiXQZWZ4tuXpBdn
         xgo0fRbm1O4nsg6FDa6XvH6SUGwUyvvNHuCLXTgCj2Pi0ND8geqh9pVv2hs3zCod68wN
         a03oYyiVdyPwW8Dh4smyBd1zWICU0EzG3cghZcTVSJXc6de+oSc2XP01WPGzUJ3LK8VF
         jM0sXuGV/OyJrBhfNQFH7qJc48eLsf0RlnHOws+7gbCPwFs898vaQNFUmje9WvW1rMXZ
         QgIUFnuC+w2dlJG5x5jBwJ1vJjq2UCA5veET7KDu85pGTTCw2UpRRjf2E2IM9wndROCp
         Y3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783321654; x=1783926454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KUrzbaJQC6Xrx/utKgCBD6Z3BLENLPOFpin94j9wAk=;
        b=BFtUDbIWbbkV2c2vcK57ChLvrAwDcRxxhgRX5AVxw801mrd1R8LOWGoDtvYjzY0rOP
         eyOy8Z8HL4/m/xa1BmRoJxe6hGz10P4kCgFaksWiPV5nXG6Kd1C0i0JVapwkfwRxpbcD
         5q6hpfxued2jg0zGAT97iQr0h3oQFhV9pBY31hiW60Uka5BHJWb2KNxqTL4++a/94mBR
         sCe/Z3Ipp50pDyb+pYUKGygZLhKYNhRe060udZU9sTUZMw+lpd4C3OJXMPOWOTOv57+5
         6iZwWzvxe5wA0iW4gkuSgxCCNC+gSIcU3atDommsA0jIa943t/898NSLEXpYJ870VCvp
         TIog==
X-Forwarded-Encrypted: i=1; AHgh+RqFVA0RtdczPMSkqdr7HZCDmr93L2tO2qm3IkANig/YRhFJzw+ViqHaCZI3O3ePGWgVMoMtLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPuXCTOnls9+Wg3M1fKdb4yzgdvkNU29eqcRFWU+G/tO8M3oR7
	OHJN9uVRXgT4gNJxu1pt7mCTM/IY7s3vZo3xw4UgOa2mJFPAGmu/yNyD3AbDdPZXodrCwo/SiEw
	Uc0XX/o7CsijDl88eBg==
X-Received: from wrbfq16.prod.google.com ([2002:a05:6000:2a10:b0:46e:e0c2:b4c3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:299c:10b0:46f:7127:9f70 with SMTP id ffacd0b85a97d-47aaabde0aemr6910526f8f.18.1783321653615;
 Mon, 06 Jul 2026 00:07:33 -0700 (PDT)
Date: Mon, 6 Jul 2026 07:07:32 +0000
In-Reply-To: <20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com>
Message-ID: <aktUNAUerQ7rHN1F@google.com>
Subject: Re: [PATCH v3] rust: iommu: add device lifetime to IoPageTable
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, iommu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samitolvanen@google.com, 
	laura.nao@collabora.com, boris.brezillon@collabora.com, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 03, 2026 at 05:28:44PM -0700, Deborah Brouwer wrote:
> Currently, using a raw IoPageTable is unsafe because the returned
> IoPageTable is not tied to the device driver binding lifetime.
> 
> Since device drivers now receive a lifetime parameter <'bound>
> representing the interval during which a device driver is bound to its bus
> device, add a lifetime parameter to IoPageTable. This ensures that
> the returned IoPageTable cannot outlive the bus device binding.
> 
> Also remove the option to create a page table as a device resource since
> currently Devres is not compatible with resources that have a lifetime
> parameter. This option can be restored once the lifetime-aware
> wrapper for devres is available and if a use-case appears for it.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
