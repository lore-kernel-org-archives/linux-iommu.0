Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423576;
	b=Efb0ZEkGWsWSTNkyfyaOMYplZ35c9MSOUhk+t7a+/I/par6V0Lv2EY4nRqFRp5sDPyAz
	 gZixzbOnGF9jqf46uXbnX2iSFTdae45IVpDjWyITAg6b11S7+nrtSwRKnhRSj6Ga4sma5
	 WikCohiGattOoUJSLvp/hk63GmYqlrhaCb4bRkk/LnOVqw+zz7kVvkvGEU1Q7jvXILrVY
	 F8MNFXE2bwREK9tNNyVfrbFZLZ105wlWQVXnjzDhkZc1OMdrYGA1Z2xJMMHkUslnjaHb5
	 rXZU6kIqg7svhSoa/WOQAJfUuz1dcyoUZSEqbN0LUwKeixV+hSxQ3MZIeeTClxxvJOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0+phg1j19BXrf86wyrJWSlSmJGcdhYdq8codoDOSGqo=;
	b=AViD0vWpkbxL/GaqZ7tQNoiiT8qDUNk/N0//Avmfuwnyo0BLEjid0zGo72obAelM9IVA
	 gJQZQeiwjbilL9p7+AMc92Jr7qQ8xx5euEnI629GJLf/MuZXYmM5rtwOVGYza7LuKZs5r
	 Es9mTrbfPRY3vmRxa6WPQeg8Ou9viVjcp7upxkKhSGH3Cm88TrqsL1hHqVdhdvI+iQsVX
	 w3TuQ3yclmWPPAIbFW38TwVXk97JnLfwpwnUQBmbhrENue6PHBApcwlNlI7pSIBR0++f5
	 PSAhBG3IQkFOpW8K76oJogV55geIivID3JpAnjMovCSblFWvLWMFDzaYRW5ilY1Pvmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0Ma/p2AS";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76141606A886
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 18:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76141606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Ma/p2AS
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso25328615e9.1
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 10:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794423575; x=1795028375; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0+phg1j19BXrf86wyrJWSlSmJGcdhYdq8codoDOSGqo=;
        b=0Ma/p2ASJKaeQtAK73mN9sTnMeq4gSzkJ3HC5DHMgQX8fRdKRPrByBJrvBVscKjNv2
         9mFtOdK5YgH2Wosz88SECsrnh1Dug9fwxpiysGetwupJev5rwn+W7JYkD5AgSbn9CLDO
         tS3DIMM3CPhbDC/H+L4VVOlxtNE429+Bb/ICTXvhpRcx7dVIbevwofJnyIpGyCtvFRad
         Y/xcbk5QMiJL2rdbNDg0klnVGi+tnm7tLFx0I5m1x0AvAhVFLcpzxzXhYYyWwjoNagNc
         y5/qLtMd5bgr1NfA6fXj6shBDXvXsdU7FTBxTcoClXaX75GJh8l+4qsGhgEr6jXmAcfw
         h2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423575; x=1795028375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0+phg1j19BXrf86wyrJWSlSmJGcdhYdq8codoDOSGqo=;
        b=vUpefPNjLM3w4tkM1QxaGhDFdAq1cKWk1D2tpiIbwGQ7BnuB9ACd+aG+MrS3tXq36u
         m7ixpPVlZGWLk7gmRmdhyjbUshAnKHG5dQcABJm+iKsderuqwz+5Ni7R7dNWMfKUee5G
         BSVzS2CdYueEFUAd/8xwsqnSKSDICT/Kan0E+M1lYKW0BIWx/xCyMq743aTqAQPO/oBm
         MU88NYYY4oxHhocf598P5Z13kbLta56Wh0lh916f3aOlzXfE6jKM5IPeMxmQttzwqjY7
         uI5HA9Ctu1MImXFjOskbefnHHGBXfd8frvbQQYfLrCyJjZLWESivJl7c9AQuM8t/mK2m
         oGMA==
X-Forwarded-Encrypted: i=1; AL+hErG1+1xbKXYRqOI9bcrf9ZdCIiQ0DVQNZSfCRGYR8/w6fFb8TLuEmkXxpXgJznTWgdSFmKThCg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+mjaMRUFjftlcfi8D+s0KVlPcnPEZzS07s/Ek4N9f3sj7qUPxq
	UqH2oz/eo10qA0RnX6GoP/jagTEZnSZ+AMyKN+N99kg1Q3qOBu4gRnuP
X-Gm-Gg: AYBFou2m38mP/cIsoW13wfhp7f3b8It6p+MhVJeBjCFQyoDAs54nTF2WU7I439xlLTs
	wx2/Dcd5f2HdToCaR6I9U6HJPoPLXGxgWcFwBORXtwl6SGDCqE1MLsq+EWgH9OSjjIBMFIhn8A4
	Vkf6VG6FXPr32UBrYu/D37AeIdYump/daxk78vd6aRr9/X0JztD63DATOhgANMujoQ0/TTrP+bG
	J+nEt4oYIab7i4I+9E88QQm6pBnuvcDelA4fmhAwggjvIpvj6OnFfo/mldLQSp9gwgwzb+UjCYK
	CLFlUeE9E0by+YlsVd713tIN5HRPhKA+qu0HdSaqO3sSURQs/0NOeE/0j0rRwVtTjrfsCATDSWP
	QFkRCiy02iropHEk+K85S+tqlNFNRly7cxlblR9ruXnTwuNryqOgKayQNtw7MIDUMt8lB7mmIls
	17QeVwghSXDhPxlafvPWM5L8H7q0tceLBHHGIYpifThL2pOlSaQAyG2/AyB87LDn6+ZSa7LMfrH
	GIUuwxutFNn1nSj4bHOnz6pqa4c5d26VHIKX/CwJXDMcFAcP/twkBPAB+V1m/xWEyw36SWuI6E0
	UgR+tms/rcBhFLEJ5ovua88uj92jvLdxBxIV062vL+JAWB2+gOKIiRFULf+1FMcPubbxoIRrlfP
	Mwm/7+3Dk3wIUkDnLGK3ceJ1mLbEWQYFCQaQ9oF4hADMeqQf7M/Rm+++hQqvuOIxIqg==
X-Received: by 2002:a05:600c:1986:b0:4a1:80d8:aed5 with SMTP id 5b1f17b1804b1-4ba0935d295mr60270305e9.6.1794423574703;
        Wed, 11 Nov 2026 10:59:34 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e265a0csm9161435e9.9.2026.11.11.10.59.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 10:59:34 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	nh-open-source@amazon.com
Subject: [PATCH 3/3] iommufd/selftest: Unmap areas that start inside a CPU page
Date: Wed, 11 Nov 2026 18:59:31 +0000
Message-ID: <20261111185931.94882-4-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111185931.94882-1-griffoul@gmail.com>
References: <20261111185931.94882-1-griffoul@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

On iommupt domains, iopt_area_unpin_domain() unmaps and collects PFNs
in one walk, which needs IOPTEs that line up with CPU pages. The mock
domain maps 2 KiB per IOPTE, so IOMMU_IOAS_MAP_FIXED_IOVA can place a
user address with a 2 KiB offset at a CPU page aligned IOVA. Such an
area must take the per-page read-back instead, or one of its pages
stays pinned.

Map a buffer at each MOCK_PAGE_SIZE offset in its first CPU page,
unmap it, and check that no page is left pinned.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 tools/testing/selftests/iommu/iommufd.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index ca2b35e9d443a..14c8a12a3bc17 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1890,6 +1890,36 @@ TEST_F(iommufd_mock_domain, all_aligns)
 		close(mfd);
 }
 
+/*
+ * Map memory that starts inside a CPU page at a CPU page aligned IOVA, which
+ * the mock domain's MOCK_PAGE_SIZE IOPTEs allow, then unmap it and check that
+ * every page is unpinned.
+ */
+TEST_F(iommufd_mock_domain, fixed_iova_offsets)
+{
+	size_t buf_size = self->mmap_buf_size;
+	size_t length = buf_size - PAGE_SIZE;
+	unsigned int start;
+	uint8_t *buf;
+
+	if (variant->file)
+		SKIP(return, "Skipping file variant, the test maps anonymous memory");
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	check_refs(buf, buf_size, 0);
+
+	for (start = 0; start < PAGE_SIZE; start += MOCK_PAGE_SIZE) {
+		test_ioctl_ioas_map_fixed(buf + start, length,
+					  MOCK_APERTURE_START);
+		check_mock_iova(buf + start, MOCK_APERTURE_START, length);
+		test_ioctl_ioas_unmap(MOCK_APERTURE_START, length);
+		check_refs(buf, buf_size, 0);
+	}
+	ASSERT_EQ(0, munmap(buf, buf_size));
+}
+
 TEST_F(iommufd_mock_domain, all_aligns_copy)
 {
 	size_t test_step = variant->hugepages ? self->mmap_buf_size / 16 :
-- 
2.47.3

