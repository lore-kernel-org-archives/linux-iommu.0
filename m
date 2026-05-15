Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428B3ED12C
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879678; cv=none; b=QkRH9lXg48Slidb9cUwGuVk/oFBAGQEw10a44cU8VnhXKJr52d7oLUF/vmFLUnlNJHHZT3JNkRv0RCzHXD0krIpoP5nC1g2Sl7TJmJCGVjw71iigI7C3ZOItg2/3UPbHRCjpsiL/4HfplclC+Zmec//kvtB/SjcvKkYPQZk2nnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879678; c=relaxed/simple;
	bh=WimTnPb5ErtUQ91diuLvqjTS3pHvP1bJ9GtZuSv1Bf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eatM1qgz8uqXsAGLO/e0P8gDgGufi3KkGEpibNW1MdsuRnyqkZL9Nnxs4/2oRUlNzReyMvwnMlOaatyiH6HKvgWzEt8LL4vCoJSC6/u2pY5L1hwf0tv5LhOWcJAqsvxrwHjAhn08bSXLkzdnJh+Vq02S2Bt0t3nJpTzWaYhdk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIjfbM8a; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIjfbM8a"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f33ae12f97so1053344eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879673; x=1779484473; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5U2oXqABMo/EXd3140iU8ar3y05m7m/a9rRtZzhgJM=;
        b=iIjfbM8al+Cs3i5IZV2K78o4126h3IvesYccYMeDK5VXJQJ8EAp+5v4zKfQ2WhLGzt
         FgQSk9cVhqvo0Ysv5uiKRNN7EaVVPf+b93DNLRffHZtIJbFF5Nv4+m50tn0419RV4Q1v
         x2MZIoSed93RGCa0Hg9v0TJMZddd0H33zzzBD/i5OMbNRCE3I0a+3aK5ggbRDeeLXZXv
         OTmLm/Mp1XWUfiiytSuJVkYIoxY0vbRfYDitpeL/Y/8fEtnRbwdVw0tXMY0UMg7VAfou
         hR/elprm8Rzx21kHvByYOsaopppDdUM6RGQH5mh3098nSFiRwEo0+rAVRsHpBLGgofpO
         4JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879673; x=1779484473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5U2oXqABMo/EXd3140iU8ar3y05m7m/a9rRtZzhgJM=;
        b=f2Q/IQjiTu5rWZObX7i861DdalijywJwRKOBlRXCkH1vu+C53sPkKcROD6DIy4X1Vq
         KaMMxrAjb+L4mH+mASPpLXppNPKpSq85pKU5z3Pdo9gpyqkhom2ZlF2bxJiMBqlb9sqV
         2AjhbZW8/JpshCpqs6qaKRKs1ppOuiRQMgafkfnNfKvy8pafTkXKgQNgVCG87h26s3i7
         UrBbZhtJaBfRwspEsE7/1v8AV54SIFU8GgVxuloTOu4/+1TPbXURiGduEVUNqyfsa++l
         zoQHWoE444vCAyndpAoCsl76uqZ82KnyMy5R892V9oNW7gD0F1QS7/0p9C6E80Fqc6oW
         SgCw==
X-Forwarded-Encrypted: i=1; AFNElJ/UUjUaYAhiqXkPlrNoYMRqlskHNXuSiURm1o2AOWvmAqtCuqYYE9uIGHNNrkDP0eQpCRsYjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YznMcIgZF0/+kPWDlmowJLzhcF2s6msF15HFaH6JBt4vzgr3liw
	NE77v+Z+4utrK0jCLnubxAfT5Wim5LtYElg6zIo5Sv+EfVr9kAB3PGJ5
X-Gm-Gg: Acq92OEvhTMvCZwm7Ob9KVbG1zcotCIt7AT8TPcjYp8ikzxLYeF7dwOa7QkJxKuUSjN
	YWLuB25H3vfugaMpws/IZ2EZowXWbE6v+v+4nBLbbBuS5aPkJRyqdXgSdpvmtFt0pHTjFXkFpoX
	9BaqQ0/MDXJNu0wr7WEt7nzeHm76dycRPtfn154iDwjajA5WYGIeQbk/J88mZT5qqzTqzeoA/DT
	pLM1UCileM9GNXK3S0n6yCxZtx95WN8Qa2v5xxdHPkL6UWRCSQzZlxPk0f4qSwa+9BqpyyQ7eDr
	1DACywEoQ+Ks9m2PIAYDlMbFkVN9KSuNRd2NBcPADxlB5oYGz5r/qfbgjbhdmLjBrMU6k/W/fk8
	SWqZ9QIYir5s6WuPm0cCrFzSeQ+oUTssdyH6L18yAYvu1KHnitSZIFPyRAQ0QK2eoIk510k5IOn
	WoSSBfIeqQkwVUeBtTSJIcx4E7dzppjJY=
X-Received: by 2002:a05:7300:b913:b0:2f4:3a9c:8193 with SMTP id 5a478bee46e88-3039862655amr2733579eec.16.1778879672589;
        Fri, 15 May 2026 14:14:32 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc8ddsm7829907eec.21.2026.05.15.14.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:32 -0700 (PDT)
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
Subject: [PATCH v16 07/38] tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
Date: Fri, 15 May 2026 14:13:39 -0700
Message-ID: <20260515211410.31440-8-ross.philipson@gmail.com>
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

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW into TPM_BUF_INVALID,
given that they are identical (the only difference being the associated
log messages).

In addition, add a missing TPM_BUF_INVALID check to tpm_buf_append_handle()
following the pattern from other functions in tpm-buf.c.

Message-ID: <20260125192526.782202-11-jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-buf.c                | 10 ++++------
 include/linux/tpm.h                       |  8 +++-----
 security/keys/trusted-keys/trusted_tpm2.c |  6 +++---
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 4c4f450630df..61833b4d81f0 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -103,13 +103,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
  */
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 {
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_OVERFLOW)
+	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	if ((buf->length + new_length) > PAGE_SIZE) {
 		WARN(1, "tpm_buf: write overflow\n");
-		buf->flags |= TPM_BUF_OVERFLOW;
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
@@ -176,14 +175,13 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
 {
 	off_t next_offset;
 
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	next_offset = *offset + count;
 	if (next_offset > buf->length) {
 		WARN(1, "tpm_buf: read out of boundary\n");
-		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3630b2ea6aef..3c6a5bcc138a 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -201,12 +201,10 @@ enum tpm_chip_flags {
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
 enum tpm_buf_flags {
-	/* the capacity exceeded: */
-	TPM_BUF_OVERFLOW	= BIT(0),
 	/* TPM2B format: */
-	TPM_BUF_TPM2B		= BIT(1),
-	/* read out of boundary: */
-	TPM_BUF_BOUNDARY_ERROR	= BIT(2),
+	TPM_BUF_TPM2B		= BIT(0),
+	/* The buffer is in invalid and unusable state: */
+	TPM_BUF_INVALID		= BIT(1),
 };
 
 /*
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 29d79c05ed6b..779a2e66ac20 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -312,7 +312,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	/* creation PCR */
 	tpm_buf_append_u32(&buf, 0);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
@@ -328,7 +328,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	blob_len = tpm_buf_read_u32(&buf, &offset);
-	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
+	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		goto out;
 	}
@@ -441,7 +441,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 
 	tpm_buf_append(&buf, blob, blob_len);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
-- 
2.47.3

