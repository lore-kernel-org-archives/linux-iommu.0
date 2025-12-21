Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B164207A0B
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766281399; cv=none; b=dxXHrAQ5ZlcfEkaKtMvL3AxX8uYD/7aOlOwQHEgqxnFsCok54YXJfYgPivKLhk36CMotRspUTqMtx4DLCBEGXmWQRu0dZn0W4U5inPwr0fj9fiHHRHSaPVfSUFjsyGRudYGvXGXZlpkd0NyPY8zU8tSTHZ0ddvGS1Yz+zy2PMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766281399; c=relaxed/simple;
	bh=9RiGqegA+I06hOdZVhqRmVQPuiaovCLQJvml01CovCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUSmttDoStCHjP+uzl2ffxLXVuRxjw7mu4Xh2wWUITGaBQnW0AlebnnZRnCRaxkxQJblcQ1GPMi5UUhK+c99G/e9kQ5BWrDor+lk/77D+/4qp8sff9AahZfJn1k65qiuYe5i77R4hv6awkKNTGTqN9WCzQEqK/WpX4VhlbATaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UJu2tr6/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJu2tr6/"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso3597138a12.0
        for <iommu@lists.linux.dev>; Sat, 20 Dec 2025 17:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766281396; x=1766886196; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQloxxqbMq59HRml2naqXd5o6tDHZgoJwROCKxXlYAs=;
        b=UJu2tr6/R9kUY5RCF5YlfHaENL8vE6M7IUoxNskMW5DFmJwXKyigD0pqVb7CtOFjPU
         QfISAEEAtFxWDdcDgCSOQfOKnR63y+DxLodWRFKTdB0p6vveY+ohnPHS5Lo/lxVAEAru
         a2yum7Kp1GC67TN9wyIZZsMfRbq7Fvj0o/RaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766281396; x=1766886196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQloxxqbMq59HRml2naqXd5o6tDHZgoJwROCKxXlYAs=;
        b=SR/eQHIahXZSDLuretN4QuEYlAGTkJFBM0Uz/2ogSmu1+V0vR+aWXQUeG6oz3LbtaM
         ipUhnhL67sg/9myblOM16hznG5jMDyTbALbW7EdYddhL96f6XN5ABvkPPiTJ6M5BAULE
         r+CJe4erqC9r13OPAvx9YLEnBEQVVkyhhCRsMrzEhvihJSNLs2tgnCPe08vIWgBHPQGa
         SeOxL6gHKm9aPyU/BjjmcerJum+ip0TewBFBkTN9OI3SMpl6hSiW+9tRy4G4Q2Yr4Uxu
         j3f2pqglwa9kv4NQYJfZBW61yo25Xa0BYcx5nKH2Eiu7/dRxDImsqH2o0EyZbvByJxXW
         57Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXuHcGqZtTGjiCbOaRkvHOxB5dDMpUiGlYGSMPIQf8zkTKPoQNdj6baxfCUWetvlAuf80gJtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfpXIiHfXuk560Tm2t6lh9Q/vSpkMsRPHZyMqtVZQlB42wiCDg
	BKvKnMtz+bYAXlIZRuoxLE5p8tNDqZ+dD8tvcbHiKOfEZmCDUjkpegNZRkdlLc7icw==
X-Gm-Gg: AY/fxX7lbRe76/ixSakaRZu6czzrqxwTuIaeRXTYgVWVyViZQVfDSVwf6LOVSt/b9Ib
	m/PRP2b40OEKIHKLgH1R1PczPsLkNthc0UY6mviXDp2Rn+K3tauQQBkt3YyjGy5wuuMpSBWgJOp
	X0K2MtmMdJrccF0wgV7Yl+zbuPnuahN0MRKLcbpURWomK+h1LWKT5yLdoecWP/9F1sZwp7zCP50
	BN2kBKGn1v/IzbSFbE8hMgjOQz3fCS1QjdSMeztKI8caMnldkeSsKkGugs5aHu/2+dQcix+opm8
	rfEkXchKrZ4qfKxxbTy1+BGQF9CkqhChmfuqus3huCL7szOnVARfnHzPSm02rzBUuZnMC83f348
	llYbtx7T9+Tv9h4feMn7p81XhGdCzPgjPS0NIHGje4ywB08vCE0fMxnr56ovJ6YSZltj8k48KOe
	bUmGdPGISGzMNarSFSK5UvzYrvUlhiHg==
X-Google-Smtp-Source: AGHT+IE6mMRclKAr1rYh6yhTZWqrpVE1fjTnJAOiLMa5n/4qjlrNROGwi5MSihG5EECAzufaISb6qA==
X-Received: by 2002:a05:6402:350e:b0:649:afbf:ce4c with SMTP id 4fb4d7f45d1cf-64b8ea60cf2mr6239796a12.3.1766281396039;
        Sat, 20 Dec 2025 17:43:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:4cc9:1698:dce5:4976])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494cd7sm6035057a12.16.2025.12.20.17.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 17:43:15 -0800 (PST)
From: Dmytro Maluka <dmaluka@chromium.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH 2/2] iommu/vt-d: Use WRITE_ONCE for setting root table entries
Date: Sun, 21 Dec 2025 02:43:02 +0100
Message-ID: <20251221014302.17738-3-dmaluka@chromium.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251221014302.17738-1-dmaluka@chromium.org>
References: <20251221014302.17738-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like context table entries in the previous patch, root table entries may
also be set up at runtime, when DMA translation is already enabled (e.g.
due to a device hotplug). So to stay on the safe side, use WRITE_ONCE
when setting a root table entry, to prevent the compiler from doing
store tearing which could result in setting the present bit earlier than
the context table address bits.

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 134302fbcd92..fe4d0d210a5f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -374,7 +374,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 
 		__iommu_flush_cache(iommu, (void *)context, CONTEXT_SIZE);
 		phy_addr = virt_to_phys((void *)context);
-		*entry = phy_addr | 1;
+		WRITE_ONCE(*entry, phy_addr | 1);
 		__iommu_flush_cache(iommu, entry, sizeof(*entry));
 	}
 	return &context[devfn];
-- 
2.47.3

