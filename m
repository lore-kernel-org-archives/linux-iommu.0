Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F02153DF
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345720; cv=none; b=toANzzlIymiplixNQz1RIVIoIEP67OtCBl8DGuEoBrRK5wt/OmWhtZWnWlSkqK0wgHeZwI1FJ5ltawzrHcyTdFOJCZzXjAYSzyW77+8eB7P2J/8R+/9O+WWOcWKz1T51dFB1vkxlHQYOKRv8ucGtq0Ct1pqDPI3TWeSh6sc8sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345720; c=relaxed/simple;
	bh=7EWHV9dXU2kG/xafKevv9SzG5SSqBdCFZI3L654ZQDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJo0KycVdBYYMQm13ScGeJ/QQz/65ErtCvrYfiV0Ovu1xPP+SdkyFVm8qJKA0kiEkuuxS8u+YyicRvLi4P9LP2d+fE+2RmtbB1O0WtR5ir2qHd2PMvqzi7BNCtFvmsCk5kxPEU+ORveT1sOu4LNEQHPBJnwSwnX+6rV6b/FfMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxtpqFOj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxtpqFOj"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-549946c5346so351354e87.2
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 03:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345717; x=1741950517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE3/EOD24kfqjSTHkaz9KRGvlEanB1hF966k3hECCPg=;
        b=dxtpqFOjsFzlqh+UecrHZ9JAofs9XrcfMTjv/sUqw06QyXw7FLFpzL9Ai8xptDAojA
         cs0P7PJ42J9NnPOyX/bvm+3v+xO7FW5kao3/hvIEre/Xgxe0YmOM3HmDEQsAbL7tauoV
         aPOVtvSPW9mDrDaMUp8DfG/bjaSb0O142xuf/lUn3AjTxWNJrobi2tO5DJWft31slBi0
         z8XF1sC6E5GisSzlfSNRLWK4e5WGDnn9/xat3bzxYiVvQHcNRwPADFdJgREcJAdN7qJY
         lqnwcpzPKtlv0scdc9triL8bhZCL5J3oq+dJ7zX/Qo7HxtZQa+f3tTHRRGnATB++7Ppp
         6LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345717; x=1741950517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE3/EOD24kfqjSTHkaz9KRGvlEanB1hF966k3hECCPg=;
        b=pzobOlIZEEdzM3kMvKOt7Ct0hswynmpLpMy2JRNSbFFec+/iVyrSpybrxEyNpTQatU
         hq/VuKaodRKP3MuOOybviDrNQzH+dyq3dwUxT+Hcou+fCuKgX8aAm7Dy8xjJMuv0NHuW
         r9E28p1atR/k3KL8rJInc92p2v52URdvC1J6oWbdQ5uis+0mehUVICLbZSVOdiuGjohx
         DlZI+W4PtuHEbuL/y2EOKQJgplD3E1hEEdzt8aTV9/ybtkQZKGUNuBL0vfX2hCJPQmyH
         VPMmX4qLmM1499AXJ3AC7jSKiys5LbXptdZ5yzLLF+xABfFmayNycTBgHAYEPTUpRHzH
         FJaA==
X-Forwarded-Encrypted: i=1; AJvYcCVcVORcnZaOYbpimUiK68oMvR7jvgGWOEc24VsjFslBZ3vVS1z7tk/vTLdrLrhzz8INk9JL+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRtbcns0yj6yqlHfKI2KgBf+Q35sg0/7Ks7ePqIMWGkQ8BgSQ1
	ZIATg58ciYB9t4U9avW4fhWmPURtCQKQ8mCb/YmZNr3LjFsOaqnq
X-Gm-Gg: ASbGncv5SvWd7CivtQ8RZUuoKcmE+iYzMNZksZi2oY94EocOyEeZojUcaOYimjRdvcO
	PVMIAT9rBV2Gsn4U6ApSdddM2NgLkJGDKh/cWX17LDj0Hqkv8Bt4Q5FCz5v2/14HKqqTYJf1xLO
	g1BRtFkNGlapXoysoV3ZXrNNCDrCE54vSxwC46IlgIxN7abbzW0ExwAw/rMpH7SjouAawoFB8no
	vaDUFsTKCXP4OW0ScRrz1TcQpw/1RGlToUAJfiD9UBAROOaFdasy1khCkzbdgxn/VQEykYF59q3
	RUvY9p2qYp/de6Am4/WITZMy4/NmEPNPF98wAknQI/1Kf0Gvd5nWUXt19CjsQBc2ZKfxlQ9rdcz
	19ID9wWw539+NUblUYmUtSg==
X-Google-Smtp-Source: AGHT+IE08HRwi5zEAOrxjSmh0hF4NwG0alA2vND812imDj4F+QH8VbA/puyLUNVeEErub3tHh6+9Jw==
X-Received: by 2002:a05:6512:118a:b0:549:5b54:2c77 with SMTP id 2adb3069b0e04-54990eaa9e3mr941912e87.32.1741345716393;
        Fri, 07 Mar 2025 03:08:36 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:35 -0800 (PST)
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
Subject: [PATCH v13 1/7] rust: error: Add EOVERFLOW
Date: Fri,  7 Mar 2025 13:06:18 +0200
Message-ID: <20250307110821.1703422-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
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

