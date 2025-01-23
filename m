Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830620E009
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629034; cv=none; b=mQEQ4ILrLZivsZq9YsI4prITX9sIDA88auuU4XDnd71c21aXuiqq0ZvZUgmvdraBteM+dj6NLE8+cfExwmCi2lczwguBe3WmVCJTlvb6ykpRGVy/k4XF/VNwvvoJsfGlH+DBVUUMpTXCK5URNGM8RBuC0cN8Wn4P6URjLH9ikBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629034; c=relaxed/simple;
	bh=7y/5voRRl3iVEWd8dd9FMx/aIm3fFsPYaagWFci7DeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqbFWkSNnyPKLWAV7e3h68SmDnQngWrVU2w8S2n6FKBeao36M0H7SJRgLXmhOW8ft86ySfVJZ8diNPXS8djptvP1nEZfyiV4av+T9fTpoiUJushMf76lTZ7QbjHtEtPs5oA1STD7mkOVNYkuE4p2NhGFS/0Jsk1w7u95H9KK7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxkS4NDB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxkS4NDB"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e384e3481so732346e87.2
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 02:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737629031; x=1738233831; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsTWX9yoQTMgLsmI/WJU+pLJbUvjBW8MdXlesjuHNQQ=;
        b=OxkS4NDBhiQI450Kh3CTrXD+z1jULXTqvR1ZofkCW5TqMlqgONLKyQSMKbaI6XLq/Q
         kGmXU6Gjk+Mgmv0YXLy/tteBZh3OztRT+9s9Y8I35RSjOME3+Hbe7wl3mv2fQJZq0XoP
         dwOu280Hm26C5EUoA/IxlHokVG4t4xhcAQr6homO4991THrsKRAL7aDvz2WeoqbRZNxY
         heyEYsqpxhEn7FnSBxhWrzbg55EbVKLLgwfBgp/w/jHdfW6PSg2pIG4MQg7GW0lZGtfW
         VTcmi1elLSvgbJtr6E+H3fqATIjrsWLddBt0Fi55X6eQb5L5Qok+dCczTh79bMm0NxcB
         XNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737629031; x=1738233831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsTWX9yoQTMgLsmI/WJU+pLJbUvjBW8MdXlesjuHNQQ=;
        b=O4XOuqIhyCJYW+6nntxGZh409hjmIjmS+YaTY7ZoMRBaImgichXr4Syf1yUR2J7hMD
         Ae4HAjUXvHs0yOg9uY8M5rYZJxqBG60/5s/Ouq1iJU56kp6RQTFmNXgJbE+x8JpmgTrb
         Bz/a0S5lxMQuSyUYDTwRj50CXomvnTYYNbeHgSuuFNl6PMbuRn0YUg/lvpdhIFKeHYSj
         ZAdiIfQPuXhMcpzPmvXaazvDNhQTvyE5ez9K5V/lwvkonHooywuifbh7wD8yl8cTodkm
         nX8Eg/TW7rAIMtppxbgHlRNL8EM69VD3SAJ5Hq87Ngbg0qyJqtnr2N2jMg4dk4TdTnYM
         FvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2ROboCjYw3TbTavIIcaUPvq/HPaTqcZ1Oo3ql4Bo0laLUeIHiWrm+Uj5cFe0kmINshlt3ug==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKxTM2LA71UlJMwWIPR+LnUY1huu9o+22S9X3XyXHusVcHi3gA
	BKU5VgG38HWML/XT1Q5v4d2HPVLsaMcLhrMzU76l4ML4OLH7b4TM
X-Gm-Gg: ASbGncsJjhyz/FPqJIaK9WuuYrwyTVK9rRdKg5IYTQxmIeUPadx7FDBr65tmmWnvsoV
	72iPlJDaxVCJtMM9hUImrxlaH6opL7jh3Nr18ZcXAO51rSvPe3KswO7nLqhGBx1VkgGKq9cgAVl
	4LkVF5aOjcHPrON8n+I5MfqrTWOOPYSYCgbTWW3jOz2Ihgt9O9X1H0yu/R/L68TvVy+9mz5m8R0
	v6NLzqmL2WupYGvQoxFA/InT7zBj2vZ6lZmPfI7D1xwO34IPxN8X0ZEUJFV+dXYyvEeOnPxIX2+
	lcUGcvtNE3xOM+WXNQwx4DE4euSaK5kZE6UENK1lFRIur/VtYH0=
X-Google-Smtp-Source: AGHT+IHnDXq/rQt9rvIEwMH/Qu1x3vMN4D/Sfbrtt3HCkRjO/okvdPh6Tg6yj0BiKhp7C2EH/cOaNw==
X-Received: by 2002:a05:6512:3d2:b0:542:1b63:2e78 with SMTP id 2adb3069b0e04-5439c216b34mr5857889e87.2.1737629031044;
        Thu, 23 Jan 2025 02:43:51 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af0ea8esm2579873e87.80.2025.01.23.02.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 02:43:49 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v11 1/3] rust: error: Add EOVERFLOW
Date: Thu, 23 Jan 2025 12:42:57 +0200
Message-ID: <20250123104333.1340512-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial addition for missing EOVERFLOW error. This is used by a
subsequent patch that might require returning EOVERFLOW as a result
of `checked_mul`.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index f6ecf09cb65f..1e510181432c 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -64,6 +64,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");
-- 
2.43.0

