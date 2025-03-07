Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA7216391
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345725; cv=none; b=njgYaEP+RRFAzf0F6Hr/sirZnrYvmIoiDzaoB6zgRxCSPOZGHDQrOlbeX5Rl1GyZ/7A/fr7hEuDMUlp/mpSQgHcU3K43tInO7ayeNcIE85oHNyYDVIv+pkDVgDeydDrujXp4uZi1v9dKI3qvsVhDeEbGTH9iHWrykWHS3DQ34UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345725; c=relaxed/simple;
	bh=nWi1w82ZlChughw2atxEeA1HOxW2EcSlkpcjamzBmkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6eSk19BPgLi1fGUhdcyCdRHzv7p5l9o7R369VfWsaHbwpMfQ46EwZ+1mud6LjkM2SOuHTxiWPcgcep9jbgzfKR3zHJJvi19CSoX8qIwxdGPuCseIJmLRdXS+OVrLhKg2SIx4AzGWqyX5MngYegosf+EN2TpYOP4y68qqPG6wSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE0uMQ8S; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE0uMQ8S"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30762598511so18904661fa.0
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345722; x=1741950522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZBUDcLiga65o3ONmY3eoTnwBjqCQOBm6Uo217lnuaM=;
        b=HE0uMQ8SWzBhYEmh3UUAEvqFx8adddQfBXxkEDQVXpE0+CtwysJcX95WKxKMf7LFIR
         CGjo4TECqa0ediAoIHu1MEdgI5nIIEoUMrP7cXiE1nHNhYlwJ6LWhEzuHuyTEAFPDBQP
         n7rZbZrs6XODKvJglyc0q8J5897X+z9rJH+8wGIY0n1D5/v4iB0O+nfAKkTvghxOxWc2
         uAprujy9c+hzJ31GYXCN50ULO1oMAiMrIAHSovNZrI9sWhN5Wgs8YcGvmHTepSJAI2gv
         HtJZpTA0hrSr6HfFk59rTKXFOAZuKlfxzhqnjDjP1sIWKHUM5ioPi7l99V9dXMSl9isP
         upwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345722; x=1741950522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZBUDcLiga65o3ONmY3eoTnwBjqCQOBm6Uo217lnuaM=;
        b=oxpSzO+k0RRGZti5Fgs48XldsYZm19G+T135hBBxc44wK1v3K9kx+DPugLY27DfFWX
         ucpIOz33f0OT5x6o3LvFWH/n/ERdCQ46OzRDcgbgUxdPNttj1JAxPi0NsExXJ7Yq0guj
         eniO8LpGwa1notBxnSH3e0qqreTj1GB65stiKsU+GXp5PLXG0+dxh1SeacmQYfbfNT+3
         ZMeA/Xvn0tYmT9pDtqKqYxR/5ERQIP3Pd5/cwJcJfZTyV0+70VlODLqGeZONwIZCvtdC
         RquIZBcJ5BYrT+l0zhP3jf68GLCmxZH49ipgzyjmxEIvVDbXo+YxRbpEcqx7RqkrNuEE
         CyZw==
X-Forwarded-Encrypted: i=1; AJvYcCXrUhWc95ukUPtWYSyNXnS8F9+4PWD7yiBy8g+SzXv/0DYGf4B+I/uxjMSsliq7cQTc8S7wxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzPnb/7JaSr6u6M0mwHkwylXosyNd2J2XCKrBHkYPxVWKVOlHl
	Yqt5n64U+vSrkRmk1VISCvDQ0MMRwlQ6Bys13YeUJjbn1ciUYJ+9
X-Gm-Gg: ASbGnctN8KOd7M1d3To8FPEQ8MKNPAd3yOaSpniTEbuygRjSR4HDFRkcMjNVLcqYq6h
	PPp1wbuxzOK5DHdpff0YROAjJiewXHxYK+tD6KC6mJ2opmJiDnYNF3L+vHceGqhnP01W8CqJwoS
	+/RSslWSspbqHG4Kj+oHu6+YxXrPRhEYNWD3d4JX0lnHZVxfqLMPpRHgzEXgdYFr31CsRxqEs8R
	YgyowKCw71TbtMCtG/GA4xdVoHAhzRhKs3+30l3vVjFzpkmlUIjYq2C08HKaJd6P7dddoamrDNF
	nLcoj7XQXi4IYfZ1ZosrBlBymaqD9TUF1o6K8qmrWA54DgY9ySA3LZ0E61kd6+/KzaSrr/pisfh
	oz8snKBEmzYjRqbqxpti3vA==
X-Google-Smtp-Source: AGHT+IH0pmG5mntX/CHSlfv4qG5i5KqvwH+6uqJ1o8DOk4THqW5aC9xKMtC/IYhgCK730wYpu9WZGg==
X-Received: by 2002:a05:6512:39d4:b0:549:39d8:51ef with SMTP id 2adb3069b0e04-54990e29b80mr1027667e87.6.1741345721906;
        Fri, 07 Mar 2025 03:08:41 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:40 -0800 (PST)
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
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Subject: [PATCH v13 3/7] rust: pci: impl AsMut<Device> for pci::Device
Date: Fri,  7 Mar 2025 13:06:20 +0200
Message-ID: <20250307110821.1703422-4-abdiel.janulgue@gmail.com>
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

From: Danilo Krummrich <dakr@kernel.org>

Some device methods require mutable references, since they change the
underlying struct device without lock protection.

Hence, make it possible to retrieve a mutable reference to a Device from
a mutable pci::Device.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4c98b5b9aa1e..141430dac2d5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -432,3 +432,14 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+impl AsMut<device::Device> for Device {
+    fn as_mut(&mut self) -> &mut device::Device {
+        // SAFETY:
+        // - `self.0.as_raw()` is valid by the type invariant of `device::Device`,
+        // - `struct device` is embedded in `struct pci_dev`, hence it is safe to give out a
+        //    mutable reference for `device::Device` if we have a mutable reference to the
+        //    corresponding `pci::Device`.
+        unsafe { &mut *self.0.as_raw().cast() }
+    }
+}
-- 
2.43.0

