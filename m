Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7C274FD1
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612024; cv=none; b=igVeTyTDW+SqLy7/Nzr5VaOslzOq1iexRmxTtY7hXlF1cB+GrKz+qKoe0S2SnhjdnxDOR859XfwO7DWMKINphlypgoUBAL5ahKVWrbvLMNgWZc/oJ++717xiqCfJAbXyve5bk3hx7z4OL+EcoKsP0mftEOe+POr+vEdgrcQBNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612024; c=relaxed/simple;
	bh=MgPfa4pKGE1SzEFbQCeqHMYKqdAxa7JEG0bUQwYux8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mRVRS5Aw0KkzwJ5lQVa4vumLftcO3CzF23/94I78NT8MSyUZskqOMfa61J2G6DPvrbOupCVYos/oSwvBvv1M8l90YGI2wNmehkECmQXp3pcB5AyS6wet4SkZh0tJ0ZU+4fgNRuTJy+xZ1igN0ECgmz/Jx3Ull4GuUeLCaZatiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYRk5EHT; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYRk5EHT"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-47d81cf0c4cso24722f8f.2
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783612021; x=1784216821; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ShG0iDDEU7To4XJxO6yX4MTZYqSurnuJSiTMgcIjD0=;
        b=MYRk5EHTFbkrgwToNNmMOXSH/FH9M7v+l72jJLMdjqvsHN///c8sMuB34yE4B5bSwN
         pXf36RLBEuVw/88OuysH4Eqz+K5gelwKbnBk5HBQGk87l8nCm9cWmPfbS5l4q6Iab6r9
         Rl6AjopxL9jPq5paYs+hAbgTTB8eyJQq4Wcl8yOAjUTyuVqa96WHd/SDyI4ze6DanaGA
         4SB7sq4NkMCjD8FekMYhfaR8vey+D29g4mrUZIkhD/7epi1s7onz3feX2F1mLH3+EUj1
         QuQDuzMRp7db2et5gD7jclJkOTRV/u9fgHlGL6f94j5FH89OnxkyfMq7veGhUB5Hy2fk
         9sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612021; x=1784216821;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ShG0iDDEU7To4XJxO6yX4MTZYqSurnuJSiTMgcIjD0=;
        b=c8uDRldgQPP5N6H1Tybtm2oaKfuUEyPZEik2zvKNqX525HZsyfl3Y7yUDb7SvpI8E/
         bFRDBEN85l6bQs4eWL+g2j2OExlgXCIw3yjpeEQig4MUE4PH9AEss1w2aJeUCedljrtl
         cEahulghVxBSuQ/nJIhxkIv2AvzILvWcPIZ8SJDdawGZ0bPrtT5FYwdntMZWCkK/nGOl
         o1O2U/5h4BvI5xPBys/qW9KC0T8NwbLl8K7mFGYCH5kQ+pxLL/66ZeNVIoXO8Ll7mOa2
         J2QW7Ou0vNCFiZRGJBWmTrMwBov7ZEdckzBrvOm59kXLr6quXxs/AHZb9+gug2Ybmnl2
         RPPA==
X-Forwarded-Encrypted: i=1; AHgh+RqL10mHzl9rtrODMtDgY0780a6fqXKQSoiQbJz2tRHZEcNt8HqUff39MdxuordJc9EFnL8IOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy//+5tiLc/dPWL2X65EqUvPhbgx0ORrkdarOaCEQwRrytJT0Zk
	2wGtHyBlmHhr9YS/syqzdgiJntK2GDSDw43XMhpGmscwbfzR2s7gbMoicN9qvnNfQiHN8vTiShH
	94/ms9xBF+QD05iTNDg==
X-Received: from wrs28.prod.google.com ([2002:a05:6000:65c:b0:44a:cfa:ca21])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2201:b0:465:ba53:a006 with SMTP id ffacd0b85a97d-47df07394efmr8123926f8f.23.1783612021018;
 Thu, 09 Jul 2026 08:47:01 -0700 (PDT)
Date: Thu, 9 Jul 2026 15:46:59 +0000
In-Reply-To: <20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com>
Message-ID: <ak_Cc7yylzGM6oEF@google.com>
Subject: Re: [PATCH v3] rust: iommu: add device lifetime to IoPageTable
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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

Joerg, this patch is a dependency for this other series:
https://lore.kernel.org/rust-for-linux/20260708-fw-boot-b4-v5-0-7792ab68e359@collabora.com

Would it be okay with you if I apply this patch via drm-rust-next
together with the thing it's a dependency of?

It cleanly merges together with 'rust: iommu: replace core::mem::zeroed
with Zeroable::zeroed' that you already picked up, so taking them
through separate trees will not lead to a merge conflict.

Alice
