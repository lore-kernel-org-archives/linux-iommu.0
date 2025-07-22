Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC81DE4DB;
	Tue, 22 Jul 2025 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189620; cv=none; b=HSdfmZbGrxUZMSSeFOl37h7gq9s+oGZLweJWrJrhCq5KEyPRMA7ZwQpllWbmko/NmjZU/GC8pBFMnbgLurYIKTayxxnpvSfsVIGbN17c9EbhVeMvREYaoUKSgZoFOcORNnsiNZGaGwW/QkFG9o7/Ur4ew0zp0jXTci9QTeJb+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189620; c=relaxed/simple;
	bh=hilKGZUP7y5d1I7SUkMYXuUmhe9zt7HQf/8BUez4l/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peosrZ73yo/vtJRwO9FtrBMmAP2RtZArECbp5cef1EFbUyvILEIz9h5dvA1c2CxZ/rFJrjHuEdhxhZ11ksnKAEwUwUq2wBeeechJ1gLrIyBzQ+xe/1yeuK7D5MYxwGEdVl9NsO6UWqBOPopk2Te0+c/u2aqdqLUd7Us8expscd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVw+o1MY; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVw+o1MY"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab5aec969eso102101161cf.3;
        Tue, 22 Jul 2025 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753189617; x=1753794417; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wHXGkDCdTi/1FkvrPEpgEX+BFsQbleVdLRAj1y6UuUA=;
        b=KVw+o1MY4//7byXk530Ufrd7KGbkjHO896IQ+jIwsYq9bQxDis1ja//aUQVtjRwyzu
         5CbQ615JUnblQskeNZBKCu2Qm80JqZEFP7TdPdoOStqvGY+ASiVFxGluNwNzO7xkWc2P
         lJqYY47ZpPHoN01jRdCRQPFioIFIryVinn1E56Pki1pB9XzrSfPHg25hKTdr1S1Y6dfD
         eHLygxKZl9D5oXrYxRCtr/JiI9Va7w/O6FB+bd4CbYIBieIr5Ldjon737glpulWLWq3k
         Bsmnc2TqMjcNaZujCfGrzatkCJ0GPZ5vCifJIdCnyQFYq2+1Bx7TAoe4XGt0FCN56t3W
         2PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753189617; x=1753794417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHXGkDCdTi/1FkvrPEpgEX+BFsQbleVdLRAj1y6UuUA=;
        b=CdzznmLPk2xCbcn+Vsan6/EFNsPrR8wSUBxU1fkswy+DDisM1+rMUuEEEYDmZV2oby
         AC+HMz5nW0c1l1wnbEbwdUoxpn+8imvVUx8pXMFaXUWG5PHm2ua/Z2hbG9bsevmNPlco
         Z+Zzvsyis6lERLnw/ijagOb+LESkzd5rxoo2QZ1kUUpyXMNdVI9pyH15D14K1XePuiip
         DNr24Pf+V2anerjCumJtPPGtNMWzwgPpJOfQ6i4aLhw7VWSeQuqv+pD8Yvp35eBMk115
         ag3Ww0z17lP7XNM4kAQtOBxkPg0ZjAgkv6BIQaC3CCBceDk7URoRNBuuAB6iJr9fak9L
         1ZYA==
X-Forwarded-Encrypted: i=1; AJvYcCW8KPY+2BEXxJTxF0vky3yWp4wpHHCbCm6HwouKk3C78nOanjROeeuI9Ukk1tQYWAD0gRIrmxnKYxDO6M27ZTnbXfCTeks=@lists.linux.dev, AJvYcCXejUHZ0tmFMEDG/RjrNRJljpi+DzqQvDCaE+34vOgBpgaiGxiM7pr/vb3zZmKyKpkBAKzBHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHO4vjgpFYNKwQ1V9817NCiRgPfYX1/tqNOvkS63EAzOcv9C+t
	FxoiLcGYFulkCsw6bF+8Jfi6JRgzpda/iiXV1HfzckAJfYunPMDwSP/79LbTcUkReOU=
X-Gm-Gg: ASbGncvwaz0kGq3oeu9ck/EFasHajQdcBj0BSPNa6YV2Yve/n0qwtHiNJSLkMA6Pvxu
	e4CmFPgEN/JDW54++ddNlV/T66CosPaGEeVxEUlk1BPboq4x7Ia2kSzAziJ1biZ5JU2hA4+9Bm3
	9rwAsBqAUJAG2ehESN0q95R0Z6yes2OV3z8Dk3QIl0p/R8dKuCeV25cSgmvGKsN/JeFSXGz72kj
	ZXIpkXhpzVFbhZa15t9R1/TmOyyrzGw0DflDK9O9MOKGxVupSc4NOspM7oldmFVaLPEfqP5uxNq
	A7BScJz506V7aZYoth8m339gDgkQV93d+tBTWfaJ8rMLtvluJ2zZ0sWygCtGODt/cYU6qYnP9gi
	iYCwPVgFkwWwj9rk4A8LYPg==
X-Google-Smtp-Source: AGHT+IF6IjDqyjw6zDnG3oxKNR+WfveKAXP2vd7OChY+/7yqNei8ee7Mwd/9T8BjrslIPwUvBnIohw==
X-Received: by 2002:ac8:7d82:0:b0:4ab:62cc:971b with SMTP id d75a77b69052e-4abb2cab50amr310328961cf.17.1753189617109;
        Tue, 22 Jul 2025 06:06:57 -0700 (PDT)
Received: from iman-pc.home ([142.186.9.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb49802efsm53977981cf.7.2025.07.22.06.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:06:56 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: [PATCH] iommu/vt-d: replace snprintf with scnprintf in dmar_latency_snapshot()
Date: Tue, 22 Jul 2025 09:11:17 -0400
Message-ID: <20250722131117.2739-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snprintf returns the number of bytes that would have been written,
not the number actually written to the buffer. When accumulating
the byte count with the return value of snprintf, this can cause
the offset to exceed the actual buffer size if truncation occurs.

The byte count is passed to seq_puts() in latency_show_one() with-
out checking for truncation.

Replace snprintf with scnprintf, ensuring the buffer offset stays
within bound.

Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
 drivers/iommu/intel/perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index adc4de6bb..cee4821f4 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 	memset(str, 0, size);
 
 	for (i = 0; i < COUNTS_NUM; i++)
-		bytes += snprintf(str + bytes, size - bytes,
+		bytes += scnprintf(str + bytes, size - bytes,
 				  "%s", latency_counter_names[i]);
 
 	spin_lock_irqsave(&latency_lock, flags);
@@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 		if (!dmar_latency_enabled(iommu, i))
 			continue;
 
-		bytes += snprintf(str + bytes, size - bytes,
+		bytes += scnprintf(str + bytes, size - bytes,
 				  "\n%s", latency_type_names[i]);
 
 		for (j = 0; j < COUNTS_NUM; j++) {
@@ -156,7 +156,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
 				break;
 			}
 
-			bytes += snprintf(str + bytes, size - bytes,
+			bytes += scnprintf(str + bytes, size - bytes,
 					  "%12lld", val);
 		}
 	}
-- 
2.50.1

