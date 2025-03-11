Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FE1A5BA4
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715390; cv=none; b=iJuxU9bPSLrk6xOzvNKTnleJE7tl15JRgNiMY9giK4L+OxFAHZ9kU6PKy8xT+r8o53yLAR1NXRJxShYVeFEB+3l2vPciFGOcnHmDUK23PjVu7DdkFvkKuNLO0gY1vruhgoBYHVHnnrVJLFdWgN0o5Ev39qboVtawqmFkDHRggNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715390; c=relaxed/simple;
	bh=7EWHV9dXU2kG/xafKevv9SzG5SSqBdCFZI3L654ZQDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akNAphviCeS2Zw0ZHoboeF34RIosxeP2uiq2MlwFNbY6BtHnOEBAJrDKvRMTTN4FSfkURX4hP6S/RAf2sG5EcpHvsG8vhMp3R4YkEInaCi5Gv8SbROqAOJusPSjeSjKsanXc+yYcfuP2ADXTAuCj0ZCFm7YNyaaCJuZHlOL5u2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/BNLiix; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/BNLiix"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-549b12ad16eso250081e87.0
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715385; x=1742320185; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE3/EOD24kfqjSTHkaz9KRGvlEanB1hF966k3hECCPg=;
        b=l/BNLiix57GOffpI6MXGqcWIto4s1MhjSmlM8MxZPDJ9lFFb9kwdQrLnAhh0uRM1Ft
         AtzfplX5Eltw1qkm8qzW1k93CQMfIF23FmJRPls4DZ5mDTNSvECWLYH8Lj9Blvw2CgV3
         DzC3ulccXHpP1qtQkcKkoztR6Cq46VX7GQjNKAzMsdame9uzMUozV3R+4MW/PO6KPYF3
         QVWlF5ij45sxW2uzzxNbybDsoxQhH9URx11taA2Scmygtl/aHuG4LeDGGN5YILAOfELt
         1+kVX9lA2hHdJMzFqxMcB5JAA8gC+ADu9KbDr4M/Tb+M+eVNT90rfz2zdEd+15f31Z5i
         YSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715385; x=1742320185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE3/EOD24kfqjSTHkaz9KRGvlEanB1hF966k3hECCPg=;
        b=CEeRG9Drl0oROpN6QpFlNcF56ADiHewu6RvYtNHUeGXf5IR/tQDtOgty5jTY/tuuSb
         sTNYb5QIH1wuyH8FD5qileXKgdFjijZ417SGORHAW2lvCzGHqqMwUysZ0MPQjLeARc1a
         y3WotC5c9v6K+LCSfCtKEKklMnQpsCQ6Rmhoiy40gez3gtggUgnCt44vFg8kOss0ctch
         GC4k65gbA0VmNCjwwVkX10SjX919zIKTFy57X4UYAAMMvLNxswhoCHC97axRtFk3k0Co
         vI6Hmfn0OaIsZPwxNa4+NBi+Xc8beHdWQo1tMYJf4TLrTw+zr/97kzH8bLyS6Iqr7MGz
         3aiw==
X-Forwarded-Encrypted: i=1; AJvYcCXuQOcEfQUo+GviSOQWhLrKeCsvAf+si78uEbWoHk81o442XtnxCNSJF0UsjRfKWD0mGmR1UQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaYF1CDAcgavm3zTIz3wuLm5Jj8UY3woimf02LV0z+1XUldpiq
	B1YubgVj0Iy8TrdNDqy/5lflxzlfgoGWxcQgH4+X1c4n0hPH6zJI/B3RgQ==
X-Gm-Gg: ASbGncs2uzxk9/AzNSUQuXjeeejFn9T6I/zlS+3WKO9Ftld0I6RoVSCNIzsZxPWzEXb
	hClIedtdmsx3eYFXKyrkHxDsLmcGSkqZscOh8UMlCUY4yEGk0BKlSHzgIp70THBcGlDMcfru/V5
	w4Vh2gHamHEmvYeSEst5VhMOYqjeynICXNkJ5RWy/x5EikR3zVIoeBhUpHFY7WV4AHvadL6z51d
	zzWhENDs/zqejZ2n1FRsK4BxS7n0GgDrPxxq7DsyC3/GWHozg/U7RwB2/WKhcX1kVsOJstbachg
	ooBKBza/volNJ8Zx2n4ZpSxgznmDRoztSYXjnfAW57R6ZNhv/tUMxr44726qw2AqiIofPgV7bBI
	SbxnsXfODauXNpKUQS7LlAtS1X/piP4vA
X-Google-Smtp-Source: AGHT+IGAyUBhOmkhRgWqS1zJpRcgVl0qeyUZAsqD0gOXKF15WXOwyBkdzw+4J241mavqQWmTSCZjWg==
X-Received: by 2002:a05:6512:3c98:b0:545:1104:617d with SMTP id 2adb3069b0e04-54990e2bd34mr6096644e87.11.1741715385113;
        Tue, 11 Mar 2025 10:49:45 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:44 -0700 (PDT)
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
Subject: [PATCH v14 01/11] rust: error: Add EOVERFLOW
Date: Tue, 11 Mar 2025 19:47:57 +0200
Message-ID: <20250311174930.2348813-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
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

