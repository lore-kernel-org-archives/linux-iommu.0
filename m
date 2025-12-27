Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B5324B24
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858262; cv=none; b=BpUELP4PyxLL+wc447vg0eB1M/BWgSUPcUPWON7yI4XFFCmhaWR+u798Xj62em91sBss4uS9gf3bfFrPI9p5FBk9C3DkETaY3s+1YrN1D2RQxrJ9fh6EcftjPKJT0Z/QbipVRPh/uYXr9sHnAgwMGQOVsIUYPW4vjRpOwXJr2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858262; c=relaxed/simple;
	bh=5h5xv8JEqyQ2WZncLcxSn4irfw3Qz69HP6DNd+oeRJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCeMqA9UdUTUagbaLGr1Vd2uasx83juPZT+E3h3jdhbLpSXmef8k03hnfE3kVCJ3gnkHko+BwzfxWgLOG9oUtvH2PQQackc6+DnEjE5yaJZ55zVULZ2qJzfmLIQ/Lz0ETjZVnWnLhxn5jul6aJOMTUC8hRPto3+C3ZtaHGzv00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S4WC6/lk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S4WC6/lk"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso10401204a12.2
        for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 09:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766858259; x=1767463059; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqBEXRWCaC1M7CZubzNbffExnes1O47kmw4dXZQnW3Q=;
        b=S4WC6/lkrh7pQs9tRTT1YQW4KsyrqBxwTrrKmK0FrELrGukZKsd107Hppj1RiOLxCE
         O04Lc4tuxvaoIEBQYav0I/xcRxqED/qADoJLJlhc9rIu4Mx+goa2GefLh3rTkZWUjW1q
         oQ2+g4v/Ga4T/dRcdUM14s8sGxJ4TbIljVGrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766858259; x=1767463059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FqBEXRWCaC1M7CZubzNbffExnes1O47kmw4dXZQnW3Q=;
        b=va4zl+xelXGq7pV7Shqg2ssj3zkqOBJoXbtRPxJcrrfda9A0l6KY1NgEoMJp8DGmRS
         84OoC/YQDuF65Pk7kgtO5jMcRMAPmpL0jUqSv1pVXISpvygbS/fzVHDXIF+SGkuDe5RR
         JAMYltySeVOPENI5sZHzfrW9fWz8mxHpSFmgLRuq+e10/VQRVn6wgVCZLhELeboY/X5N
         MxE/wuV4ZvD6QkGA1c6hsI6PMjYKBnLz6lPpcWAzvP8W/00jJnI73ZM9jpfACbdBGO7A
         9yW5nzfNwX5y4SeSZXBdZGf4nqZcCyQvtMPlHn89l1ISjA15VDV0xXK5WOxR5B/8w2uQ
         T7fw==
X-Forwarded-Encrypted: i=1; AJvYcCXdE5CQdqeVyG3/Ze/KLw181nJzAIJUOXpYFTKiY2pjZrpIEoSjJ5EkOndVp7RJETPlOLi4Kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQO5enjJzJ0DQqBvpJb4vdbFqHxk3XV3po+fXHld28SEWgC6g/
	ICNanlJMWBCSjNQOsq4haKIUme9g0C3QtZX6ufz4H2P+Pl7L8X0uhtF3b+NpCNP4wg==
X-Gm-Gg: AY/fxX69NS916dZFWQ/RcRwvHVF/H3p4r04lbSvXQ7JGk/GQlx4m2329/nKubCDmwFb
	sXFbeHOqcyJVVvO6N/9jTc48MRL6jWmy5kI6z6sS3OKzpg+6x7+EhgBL2LJn0m+7gVkifDCUH6u
	zTYF6rf2hH+eU1a2AqVZVUCMBbep9UAKUehTaYPsjPgu5jRh8CM13FqV+qcaUK04dd3/WM5a7jj
	jksuypd1opx0DvhiBZVZ7W+Zpnd8ygLYzux+lomNICW7FazaUIB5rfBBtWoOZVJNajr91mMb7nQ
	bZxTVAiJA6JoNSvjipe8/mlztKlEVnsP09q+6XTFGtS+ikTzbVdED/5I9GbX0K2g3WiJlO++SIb
	Dq4BPr8q0ttZh55p0mw9RrMTgCYt29uSvQgarqqJXooa/vfdqVtpn5bFsSlO5Cacy/CXlR5fHpE
	REOG+rLudg/4aOeTAeSJlZQuy97kSfDQ==
X-Google-Smtp-Source: AGHT+IHK6STg6BDB2X6G72rDgUtuf6fD4jZFsFZf9R3HxE49kfZlB1Fg4cAQYG6AyvYRR+Ir/Dy3gw==
X-Received: by 2002:a17:907:6d12:b0:b76:bcf5:a388 with SMTP id a640c23a62f3a-b8037198f0cmr2774524966b.50.1766858259112;
        Sat, 27 Dec 2025 09:57:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a31b:20c3:6680:3d12:d2ea:4ee0:347a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de1421sm2793889166b.41.2025.12.27.09.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 09:57:38 -0800 (PST)
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
Subject: [PATCH v2 1/5] iommu/vt-d: Sanitize set bits in pasid_set_bits()
Date: Sat, 27 Dec 2025 18:57:24 +0100
Message-ID: <20251227175728.4358-2-dmaluka@chromium.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251227175728.4358-1-dmaluka@chromium.org>
References: <20251227175728.4358-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting PASID entry bits via pasid_set_*() helpers, apply the
specified mask to the specified bits to be set, as a safety measure
in case the caller accidentally passes a value that exceeds the
specified mask. Also warn if that happens.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/iommu/intel/pasid.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index b4c85242dc79..39acd3efa3ab 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -113,8 +113,10 @@ static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
 {
 	u64 old;
 
+	WARN_ON_ONCE(bits & ~mask);
+
 	old = READ_ONCE(*ptr);
-	WRITE_ONCE(*ptr, (old & ~mask) | bits);
+	WRITE_ONCE(*ptr, (old & ~mask) | (bits & mask));
 }
 
 static inline u64 pasid_get_bits(u64 *ptr)
-- 
2.47.3

