Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73ED3ED126
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879666; cv=none; b=jFKzcQBbKqkJVWz2qCFzPC4jo94BsGirquB9NosJgEWend4/bg3vDNViDWGix18dvkW8VPOVuNLNHiPm7t0uC6sSRcBdxz9fptvBZ3nZ8Z/PwbdpvZPoX2pwDtEvjzbc9F70T7pkrhbnGYvncok0o8JQp80kOEocFiw1vrxX/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879666; c=relaxed/simple;
	bh=msNEhWQcSwNE6T7QnFoUfFfSSSD/YmuJUa2h6PeyfBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sp011peRjVjczfUwSUKXowuvMx8EFP+6VLk1/RxD/jDtwMPz0sGnzOoi1qcZ/ivx6TJsZNviTmpR4g5qR7065ikKKj/LqMchWh7myhYYtZlg1p2Nw5KpZbM9hIUH9O3jnrsa0YAjz5Z+YLh/FsmPnTgZCCf3W1vWT0HL5i7DQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqZU70e5; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqZU70e5"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-134ac81c445so953062c88.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879664; x=1779484464; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFmz/IKFkr+yHkTTECqlvzt5xXCg9R4f8VRlkTmPQhI=;
        b=mqZU70e5RxvoJ4LiYnaGJmHqGc0q2afyEAjLehOFoIOeGqDKFGbP6I6MVpe5hkSLp7
         PrjgXEXFUqOJfRlHLl3vg3pVxLGWOcLD2qxeqB+hbsq34zT4bw7aqDqIKeNw+5RF6xUD
         Xc74g53YyiLxqDvPZhtbo425MV2v5YQgJG/nBabLgXTDRIqHy8i1GbBWL79I7rf7idiq
         H/RT4TZEUe5E9AgXBQIjg2B3S0OyB9ZjGn/Yd61ceMuRYmREahJwZHGgfPUOYKP38jwO
         Lyk1jqU47RAbP5+YJ8NZt7rY+oG3OWmAzKI18EpEbhGIUA2OAjRs26FfTzE1H6juS3Lk
         3q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879664; x=1779484464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFmz/IKFkr+yHkTTECqlvzt5xXCg9R4f8VRlkTmPQhI=;
        b=TgCiozQK0oEgAm+jXn7p9ffxi+TB/sWfT6eGQnMBefVSefref2nwY5RqJO7ZOsxL7r
         pHEgymUE3lL1KGUHgnoKFKFjOLSmRUPdwYp5zOg26WH+eBwv2bTdbJlr6dKoNy4wJ3ao
         hSyfAE5MuN9lIXFNQN2InWhqICQFpSwlZoHxd9xeN3OoUjtt0lLk+Y+k64VF24o5wrky
         qvE0BNWF1XlbEItJ23D4fNYiEJC0ZXq6bohgBhxvGpLqHpnPEWKvHPHkXhV+/8hF45id
         IN7YOC/6NKDUK0R3iijvRKeISvCl5HoEY2Io5eZrCYu7u6xqYPyy/b0Rzgu335k4Beoe
         whJA==
X-Forwarded-Encrypted: i=1; AFNElJ9OZYVzKyWIYL48pr7yA79F45+3MYnh7kFTrmXruM++7O6zpD6MZRZ5r7vegWufUMvfT1Yagw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz1UXPxBu+8efpjy98xJGPUYY06WCzIgHMHKDM1EIbojCObY4i
	fba/6tOvYkaDqQw8U64q3AD8lwpyfjBDpHcTQwXTS2xQ7yuFTV38jCuS
X-Gm-Gg: Acq92OHOTPzcMA0bQp5+7oWjf9ugmxVUM75F1Mjzg3FvCKG35g5Q8VuWPTc0fzSSiic
	z83RBIjIVCY0+Wbqq3CzdYSnpCFbRZYdPO5jQt1oA1DORTqaoH5J5WcBEGAsJG1UMuwCi4vX/jl
	18YxQU8NwtPJUEIXS3DFVun/RzI/pNj00vdfsYEEDAC/GUAIfTzomAPVC9lbQmxxLIUI8W3YNdN
	UeJPhgSmhdOlDJuTyib9quMPDfOpyE1iJKzz5KfedlPOo5a4celicGTxxMaM5HGgJsrOgWATRby
	vuVFRjyffY1lLzxKm3kwYsbqkDuzddPV12S5yFaFKxSxEY43SL8sf0IkAXxk01mKqj+mjuIU1+k
	Lc5u78AXUqezTFJK+3DGjc7Oys0csv6BfDMTqiJfwXNvBHeFps4wxbfeb5JPxmh/kvWpojJ6fAU
	w+otXAAN5QO78/yimv/SJsXzd1J8uQ6nU=
X-Received: by 2002:a05:7022:4582:b0:132:5db9:27af with SMTP id a92af1059eb24-13504a49ademr2695477c88.35.1778879663897;
        Fri, 15 May 2026 14:14:23 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb93f3sm11145075c88.3.2026.05.15.14.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:23 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 04/38] tpm: Move TPM common base definitions to the command header
Date: Fri, 15 May 2026 14:13:36 -0700
Message-ID: <20260515211410.31440-5-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are top level definitions shared by both TPM 1 and 2
family chips. This includes core definitions like TPM localities,
common crypto algorithm IDs, and the base TPM command header.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/tpm.h         | 50 +--------------------
 include/linux/tpm_command.h | 89 +++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 49 deletions(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8551b24c2bff..3630b2ea6aef 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -27,49 +27,12 @@
 
 #include <linux/tpm_command.h>
 
-#define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
-
-#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
-#define TPM2_MAX_PCR_BANKS	8
-
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
 /* opaque structure, holds auth session parameters like the session key */
 struct tpm2_auth;
 
-/* if you add a new hash to this, increment TPM_MAX_HASHES below */
-enum tpm_algorithms {
-	TPM_ALG_ERROR		= 0x0000,
-	TPM_ALG_SHA1		= 0x0004,
-	TPM_ALG_AES		= 0x0006,
-	TPM_ALG_KEYEDHASH	= 0x0008,
-	TPM_ALG_SHA256		= 0x000B,
-	TPM_ALG_SHA384		= 0x000C,
-	TPM_ALG_SHA512		= 0x000D,
-	TPM_ALG_NULL		= 0x0010,
-	TPM_ALG_SM3_256		= 0x0012,
-	TPM_ALG_ECC		= 0x0023,
-	TPM_ALG_CFB		= 0x0043,
-};
-
-/*
- * maximum number of hashing algorithms a TPM can have.  This is
- * basically a count of every hash in tpm_algorithms above
- */
-#define TPM_MAX_HASHES	5
-
-struct tpm_digest {
-	u16 alg_id;
-	u8 digest[TPM2_MAX_DIGEST_SIZE];
-} __packed;
-
-struct tpm_bank_info {
-	u16 alg_id;
-	u16 digest_size;
-	u16 crypto_id;
-};
-
 enum TPM_OPS_FLAGS {
 	TPM_OPS_AUTO_STARTUP = BIT(0),
 };
@@ -127,7 +90,7 @@ struct tpm_chip_seqops {
 	const struct seq_operations *seqops;
 };
 
-/* fixed define for the curve we use which is NIST_P256 */
+/* Fixed define for the curve we use which is NIST_P256 */
 #define EC_PT_SZ	32
 
 /*
@@ -209,8 +172,6 @@ struct tpm_chip {
 #endif
 };
 
-#define TPM_HEADER_SIZE		10
-
 static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
 {
 	return handle >> 24;
@@ -239,15 +200,6 @@ enum tpm_chip_flags {
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
-struct tpm_header {
-	__be16 tag;
-	__be32 length;
-	union {
-		__be32 ordinal;
-		__be32 return_code;
-	};
-} __packed;
-
 enum tpm_buf_flags {
 	/* the capacity exceeded: */
 	TPM_BUF_OVERFLOW	= BIT(0),
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index 9dd903dd6b5c..96edebd9610f 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -427,4 +427,93 @@ struct tpm2_context {
 	__be16 blob_size;
 } __packed;
 
+/*
+ * == TPM Common Defs ==
+ */
+
+#define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
+#define TPM_BUFSIZE		4096
+
+/*
+ * SHA-512 is, as of today, the largest digest in the TCG algorithm repository.
+ */
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+
+/*
+ * A TPM name digest i.e., TPMT_HA, is a concatenation of TPM_ALG_ID of the
+ * name algorithm and hash of TPMT_PUBLIC.
+ */
+#define TPM2_MAX_NAME_SIZE	(TPM2_MAX_DIGEST_SIZE + 2)
+
+/*
+ * Fixed define for the size of a name.  This is actually HASHALG size
+ * plus 2, so 32 for SHA256
+ */
+#define TPM2_NULL_NAME_SIZE	34
+
+/*
+ * The maximum number of PCR banks.
+ */
+#define TPM2_MAX_PCR_BANKS	8
+
+/* If you add a new hash to this, increment TPM_MAX_HASHES below */
+enum tpm_algorithms {
+	TPM_ALG_ERROR		= 0x0000,
+	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_AES		= 0x0006,
+	TPM_ALG_KEYEDHASH	= 0x0008,
+	TPM_ALG_SHA256		= 0x000B,
+	TPM_ALG_SHA384		= 0x000C,
+	TPM_ALG_SHA512		= 0x000D,
+	TPM_ALG_NULL		= 0x0010,
+	TPM_ALG_SM3_256		= 0x0012,
+	TPM_ALG_ECC		= 0x0023,
+	TPM_ALG_CFB		= 0x0043,
+};
+
+/*
+ * The locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+enum tpm_localities {
+	TPM_LOCALITY_0		= 0, /* Static RTM */
+	TPM_LOCALITY_1		= 1, /* Dynamic OS */
+	TPM_LOCALITY_2		= 2, /* DRTM Environment */
+	TPM_LOCALITY_3		= 3, /* Aux Components */
+	TPM_LOCALITY_4		= 4, /* CPU DRTM Establishment */
+	TPM_MAX_LOCALITY	= TPM_LOCALITY_4
+};
+
+/*
+ * Structure to represent active PCR algorithm banks usable by the
+ * TPM chip.
+ */
+struct tpm_bank_info {
+	u16 alg_id;
+	u16 digest_size;
+	u16 crypto_id;
+};
+
+/*
+ * Maximum number of hashing algorithms a TPM can have.  This is
+ * basically a count of every hash in tpm_algorithms above
+ */
+#define TPM_MAX_HASHES		5
+
+struct tpm_digest {
+	u16 alg_id;
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
+} __packed;
+
+#define TPM_HEADER_SIZE		10
+
+struct tpm_header {
+	__be16 tag;
+	__be32 length;
+	union {
+		__be32 ordinal;
+		__be32 return_code;
+	};
+} __packed;
+
 #endif
-- 
2.47.3

