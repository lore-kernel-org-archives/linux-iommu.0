Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943962;
	b=FOuLRO/gPBKXwiQOWf97xmxvbA/pAofg9Zg68tCsDn9ZZgdgdkHoRv6Ny4hJRlC7dNAs
	 Fell44AdnjuF25UwL2MIxm/JqqyIoK0UAjJyfI5jURIUKJAasXYMCn/1A4ocpLph9gx4m
	 Deu6Iaj7R5y5VJ0IXSZynWXwRB9WPDlt75fk3xMjQN6bi5XGwGHoIVSmyO/xmP/8znJ0g
	 p/Qx0Z9tmuXUvW6HSEx+mQM6/IaDv3ewaknuM6WH4QXiAh2NAgw67tSplVhY3dUcdo/i3
	 yg0ransS+pjPHRxsda5e11ssUuAGaL7PVZVdDudmVzM2aNEJQfWYy/GdPPUaDyPah+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=sEdsgEuo8ODT+rI1rQ1WVM7pBhVs1i3Hp1pw+AHwR1c=;
	b=MarSYhW2P3N/f7zDOZ0aHDfQzAcQ5xmSS/+Q+S6zTWlRAHAVuA/0NKpWaR2mBd7F660t
	 kC9cDpO6/7yXV9VBSgJtnH4cQ+uGNxrbujARMolfsQeovTgco72UumpAmDGw6iBKWY2Zy
	 Wi8CiMm+VlgklQ4Yn6VSb6+7zMLX8hjZeyitVVyc0kYwW8wf9a3bNw8uOFd4oPFkkIoJ/
	 9fosep5j095a7ei3QwVsx7/8+KF4kkp8G40Qj4ff1lMh5+4XKEVnyVkmJV8FAt6iio0Mw
	 /550TCzctIGBfvlwyT2yYxWejYSVQOSzXTbjapk7A63gYm7uhECtSffDNhmGjMWQjgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iQoLjJS9;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D68D606A8BF
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D68D606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iQoLjJS9
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c50b170ec5aso4127366b.2
        for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 11:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794943960; x=1795548760; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sEdsgEuo8ODT+rI1rQ1WVM7pBhVs1i3Hp1pw+AHwR1c=;
        b=iQoLjJS9i2f4Uj8sVHhhKUaMhuDP2skNA3xeAwsisMDmhIN49DfIa2jNOvvYwY1Lad
         P0kdhYXYB2uc2LreH4MTswfLG/YW2ItV4RfY4Bwbkq273dG2j85FtFBdMPFeCUEajuJW
         PT5MZ7My0kE9J9P8VyV7H1a4GkMHPzqh2kGQ002s1c+QhmVIfVdiUCCueLf+3daEVGeL
         5xBq/OasDq4HCOqW4zyIbW6rjHKDBFTgeubf1ZjsCc7NBPvuahJI3LmKTVUOWBwpy8zI
         Muh7R8R50G8qgjbk3YC3t0yjFUJHXt3Ax6vGnq0cDrb5b7Vz8mKAMEZnU6UBI7Ko1P0a
         ykrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943960; x=1795548760;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sEdsgEuo8ODT+rI1rQ1WVM7pBhVs1i3Hp1pw+AHwR1c=;
        b=sKGqlAF5qatRO1p9VYO5aZm52QCLL7ADmyY6nxsVsRUsHor9/gBig6DpCThPnTI76g
         c4alrm3J4U0u6tcXTTC20P/CnloBkKdLqmlfgATnxziKk6KAkLAMQ3IRBlIjJ4Y4oWq+
         VDaVyShGj7oqBzWThwPuF66u4GPDeB8A5gjYx9XSJn7LU9Qum+6Jhy0MOF3wls/mgPZL
         SuoKNvWyzqr2GP+Y2pxp4i5fl1y3uDordJuXEPFSYZQQ4BWvj3TpbNUOr20K64JBfTz8
         E+4JYWGWVMwZkz65a+Cuz7nxjZKdTCzCjh59FPrwb3u8bVGvyWFUXOaXATA9MiiFlBRN
         jaZA==
X-Forwarded-Encrypted: i=1; AL+hErG+b3UwnKmxTvVOweSLAOitkSiPFcSny5dilQdwttAvk6IULsz+DoD/geshLLdl/rjv8+2Cjg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/sAeeTrYqRbXrKO3SYoGByWa+TeHddfcKNL3+JdyGIP8vRK+3E
	eGJdkaHQo1Z618LNAkAGsawsCzF3yuYfXgZmZwBIVHiXyPMx8OuVU4U689OtqVWtXdQOIAIePAb
	9mNran39U2OXzro0u7g==
X-Received: from ejeck9-n1.prod.google.com ([2002:a17:907:e1c9:10b0:c46:aa24:8716])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:72cf:b0:c2e:2252:6ddb with SMTP id a640c23a62f3a-c510e19b51dmr22046066b.10.1794943960151;
 Tue, 17 Nov 2026 11:32:40 -0800 (PST)
Date: Tue, 17 Nov 2026 19:32:21 +0000
In-Reply-To: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=fHxqvSNi6j+mg7W4SOrkydkocL0Pw6SV4czczy3ta6w=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/KvQUDExEsHiZ6Cbk1w6CzxYFmFSS4BSPnhEk
 MSLEGspzROJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCavyr0AAKCRAEWL7uWMY5
 Ro49EACB0ftf0GHD6NVKJk8qoRRSAA8NtLcQxD9TKYzGe5l1VQ2v/ZRDvNthAokzdRvaDp8M5PW
 1IvhSetFJ1EPRT9FlJXK2lAOTgNOjbV31SMgyfAeog3PyR/AAEA3mJegzv0uA8x2BFW2ftoq9ez
 ftvL5TL/kRzHs/YDi6niQqRXc3GlcM1r3KgpKlj0pw1CgsDeZsfeW4DA8zi20tZ0dVQy8k6SN74
 rnpMamiABEsq9czO0k0TAIo2PdqLkksEo7LJrATWxZZbSw91E7qLnu7xVAqb6VQqH8KVjDyFQ4L
 3D90Xoq/m9Rzqv9GUeIsTH+oGkRb3rFkj5NdcdOybMq8+orYHWW+qHORyYvOBdGdzy8ICUh66XI
 2O+Mez/FxA2cxniGl8lj6y0zYwl9OSQE+6w7sOXqEYHamldd+54o0hcZQIXUFNk3WaA8PnqKRFp
 agH5mLLhUCQo0e1DL5UHQxBjwRtmyqQZ44vAMgM8d4wFArAd38y2VLOKLic+hHzm7WcRo1p27P7
 gq6FHPM27S4LPzaN3Kl94tyFAKa4gt1bju+FU6AXnvDVFK+fY+Gs3Hf2GAH8Kyv5Xpmh0pFcwiV
 O4rKaY4DkUE50L1H+Gl6XcUjAkTinnrj9ZXxVMj4eaxEwyvrozh91m1ow3Ep9bEm3FNtth4J59R iniBlvdTGiEmd5A==
X-Mailer: b4 0.14.3
Message-ID: <20261117-tyr-remap-2mb-v1-4-2a8efd4c8180@google.com>
Subject: [PATCH 4/4] drm/tyr: vm: check the remaining length in pt_unmap()
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
	Deborah Brouwer <deborah.brouwer@collabora.com>, Sami Tolvanen <samitolvanen@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	"=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sami Tolvanen <samitolvanen@google.com>

pt_unmap() subtracts each unmapped chunk from the remaining length and
relies on unmap_pages() never unmapping more than it was asked to.

Check this subtraction and fail with EINVAL on underflow.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[aliceryhl: use safe casts instead of 'as']
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/tyr/vm.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index bcc864b17428..acbca552d133 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -41,6 +41,7 @@
         ARM64LPAES1, //
     },
     new_mutex,
+    num::casts::FromSafeCast,
     prelude::*,
     ptr::{
         Alignable,
@@ -1063,8 +1064,9 @@ fn pt_unmap(dev: &Device, pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>)
             return Err(EINVAL);
         }
 
-        bytes_left_to_unmap -= unmapped as u64;
-        iova += unmapped as u64;
+        let unmapped = u64::from_safe_cast(unmapped);
+        bytes_left_to_unmap = bytes_left_to_unmap.checked_sub(unmapped).ok_or(EINVAL)?;
+        iova += unmapped;
     }
 
     Ok(())

-- 
2.56.1.703.gf848ed807c-goog

