Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876583ECBEE
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879678; cv=none; b=s73D9WuXG4KqQb6FUKXOIiKQXNpJQYQWr77NQfpyPuQ1D0ZqSB97SONnf7O6ukEpW9zhpX8e5Xjuygz5IacPxTs5wvBKjZLOZDdgW/XDAImWEwN/jmXMbfyMeYOWA8BKKv5wUdI8IPGO2WnL6M7ctK56DeMa/DwRlUGi7OYXNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879678; c=relaxed/simple;
	bh=53lrliy0YE81pqMpILWMlkkyv1qPCSWN//0gQcdAdOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bqn8wYsXwOn0FuE+BG3DWWNEYcSN2aQhmAgiYXnzuK90QwfzxyomDL/ham4JFsqj/pg8EfaDlQ5/qb9xSqovmNVsF4Fv0LiRnzNpDm+cOEFntb+vF5Jv9Lcyma+xymvXMvc00Q1QvIKDihzPLi5vXksmaOoDFNrW8/39GksFBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuZuXeif; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuZuXeif"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-132830d8281so946497c88.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879676; x=1779484476; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaLNJCVWymRzHzAosL0l4Cb63oV8tVc7xKx597eZEkQ=;
        b=RuZuXeifw0sUIKgV8/vVjqvlgU984vfmIp+C7Tpjrsz+t+qyElLeTOk0TXH1RnMDA/
         /EGiknH1hrSDYjf57kiRDRinnM2+lJo1aKejuT+e9z9XXGLUu/sUCzHy1FtnO28L2z97
         TfROROFRFmZd73fnJMa8eHl6+NoQq+VnzWmdUJhqFc2EKB/jvV6ekRiTFYSkImhxBfyk
         vng4CpTvGdmEGChGZn83dvGi5KPqeQiMVC6nxX943hb32h51FDMlk48srzlHzpCW4ykT
         aqTNOBwwu/GjAWVZaN55SzkWIrLD/ydjqw/5XQbwJgSRdz65JKeDdwAQ8d2BvKJzjVJV
         jAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879676; x=1779484476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zaLNJCVWymRzHzAosL0l4Cb63oV8tVc7xKx597eZEkQ=;
        b=mtrBMKsUM1tUcNEDUJvFiHWgNNErw3PHuzZMUJ/WvwL1VaS4jg8ngq7nY42v5hNcdC
         7p3sDfF3A3xWyrGMempVzg9hkooSEhUggzHyCO7tOfH+HksaEbsUb19b6QkIT3fSOCeU
         56oppOOmxf1x8Z5nfgJ1vP8tuqL25GwpXMr20esLjIgyXRFSB5j0/sxouhAobytRIY//
         S3nfqdF/6dhfrGFwHSlRATdiG7BnhPUBEzLRowHtSPfFKGhKrtfXPsRCgZhJlULbr/kw
         jtWmht+E+DZ1ldusrd9W7h9E0HrMob/0q8B1EinKI3w57MvYy/ptSsMxBLFMp2mQCyST
         XmRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ErWmrGUV5mkAA1mBA+HhsfR+Lg6WW6TOC73/trsaHGhlq5R4HaRctbyYamcwgZT5/o4lRZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywly1P7LM3tMykZSGYgPUbVets0KAV9QPDaqxDrjjUrx2+EBGvy
	vqDg8LbP7/9donCMQFG34JnMYD/YUd1RDppB7FoqFmdPExX/mYFyO3HS
X-Gm-Gg: Acq92OFguHWcs+CeLp+M8/7Naze6Q0S7t8+AG5gUa0IwgUzU9NbcwCZwDCn5hW5YzO3
	CoFAyEDfmaSm4kJSB5uTsb3c87GTdT7Ahye2gXu13zxqk7BJB5Qe8vaxAW551lmLKaT4JqaoapE
	bDc9UeHNvy5zHxHIcqZVa+5Wq7xWUvzhqWPEhSrcSJb7JUFIy+Sjy5wVkjO7ZgYL/VpSPxvVEZK
	lyQmSWzmSyba/whmYaKEAO8DdU2asw4frafO22FU/495EWJg64O6JP2RD3tw4KWqyWw+JvaLLZM
	eo+mY4w6URt++3brojtYNQOVa0t+bGGm8UGrnySAAslxPdM8S/goRlERAoo+QlsenE4rHbqvVz4
	4kFzovMp9Ll0Y3tW+mP2z9+mOZXfYmAcDwJwmunYGJCF9gIyOz8zyrpVbPrAw/0EOF5qyEY7Fd7
	Vm+Imv9CASz5yCdrLkytzZasCS9FN95+g=
X-Received: by 2002:a05:7022:6b9a:b0:12d:de3e:86aa with SMTP id a92af1059eb24-13505642857mr2505039c88.40.1778879675567;
        Fri, 15 May 2026 14:14:35 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm11242540c88.12.2026.05.15.14.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:35 -0700 (PDT)
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
Subject: [PATCH v16 08/38] tpm-buf: Remove chip parameter from tpm_buf_append_handle()
Date: Fri, 15 May 2026 14:13:40 -0700
Message-ID: <20260515211410.31440-9-ross.philipson@gmail.com>
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

Remove the TPM driver chip parameter from the function
tpm_buf_append_handle(). The chip parameter is only for error logging
which can be done with other facilities like WARN().

Message-ID: <20260125192526.782202-11-jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-buf.c       | 9 ++++++---
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 include/linux/tpm.h              | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 61833b4d81f0..99811809a72a 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -146,17 +146,20 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
 
 /**
  * tpm_buf_append_handle() - Add a handle
- * @chip:	&tpm_chip instance
  * @buf:	&tpm_buf instance
  * @handle:	a TPM object handle
  *
  * Add a handle to the buffer, and increase the count tracking the number of
  * handles in the command buffer. Works only for command buffers.
  */
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle)
 {
+	if (buf->flags & TPM_BUF_INVALID)
+		return;
+
 	if (buf->flags & TPM_BUF_TPM2B) {
-		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
+		WARN(1, "tpm-buf: invalid type: TPM2B\n");
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 1fa3e8a43c79..c9dc35b57687 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -198,7 +198,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		}
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
-		tpm_buf_append_handle(chip, &buf, pcr_idx);
+		tpm_buf_append_handle(&buf, pcr_idx);
 		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3b1cf1ca0420..eb67ae14ad73 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -257,7 +257,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_handle(chip, buf, handle);
+		tpm_buf_append_handle(buf, handle);
 		return 0;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3c6a5bcc138a..b357f8971d03 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -235,7 +235,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.47.3

