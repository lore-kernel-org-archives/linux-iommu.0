Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157343ECBE9
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879661; cv=none; b=q9Bs15GYmM15IONKgoFrpWl4cndytJ0FKPzhTvR7HN5Ty9xMFM/kNmmqj02jn217wRVVfDNqDzYBskSTTs9xVKwQm/KshJ5p06yu/Uv2mKBSHU/CpuKIpgQ/iYuqhrE8FOMsftBRGucAExCj7/0lHKCEDr8RWwDhtzdarUccTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879661; c=relaxed/simple;
	bh=SggoenfzsCsY+pb4Ek78lCUJ5LNnpYbdU37TQ8AdKSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf2V9OgsM5SeWBMebVABto58btcqT4+X1TDGYjiSLO0oL5O2k05ExSTymV3mfSk9KV/nJUK+d3bXjSdgV8r1L1iQGiXe1/mXdq85x6LPkuCj+vcjL//AfZuXLgAJksEktMg47ROZl/g95AIOtBaC9Ra/kaWoLGR5pp4SakObisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LntWzs+6; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LntWzs+6"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30246cfd41aso1507622eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879658; x=1779484458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv+Nw7PPpS+EKWG0VbfKgMCfu5HHf7cWkQjqPeveVJA=;
        b=LntWzs+6V2iTOsYlNTyQtN3tukQboA0ybbe5xUau6b3k6sE1+eo6B7lrzGvpfDdOk3
         6KgfGtDWkmVv9TXZBWp9oLNEBuPGnmxM2cCoSDlkkgA2hyKSc40OxZ8VpBIG406ZV6pq
         Np23uKjKpXloK77QbK49AM0k+xZhcOSQfg+OHpOa9ypHlWEe4h2YX2pZ/KqF7e6Ftna/
         oWK+wStHU0TRrd0LsK7pJC7TiywPIN2RxGKxSYTWNoXqHT4MpUlDio6BThXc8tsS/Dnw
         tKKi9AQcjMTiixzHBCXUMYIvcKVFtN8NlfhkXI1/SLQN6P6tOAwA8q7O7D9ZGiJisUdR
         QL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879658; x=1779484458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nv+Nw7PPpS+EKWG0VbfKgMCfu5HHf7cWkQjqPeveVJA=;
        b=cW9qeSEXQEFW/iyV/Dr+W0YGi1Ttvn7+Llt9LO0pVrrHhZVSaMlbr32z99YVI3nwP5
         RAUw8B6KPGnFjK57gs3kRM90WPMYYA1Ak4MDM3rGun584FmxH+DKTmTLJ78aFZBbzlrn
         9BLmr5z3F2Sq4AFpHWRWqck9KVOHcnUZUyGRlGXqAXMovtx4xVH9Sz5+thDAZHLUHIkC
         6uyViUUkPvZQLGCcaCjzmSItGw2tWZjgUbM4Aehbjm7ofU9kb2qVXfRPkOyw6CTmEfeX
         FLVMlB2Zst+Xu3DFuygRJDY4zgUZem9t62j4mMoSGDi772frkYRbANBMTB6op3j5ImxQ
         UIZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8tz8KXh8zJKnI32aLQutj/P7Am//DkXVmgdVu6cxM4cSsuZPt0t3xueOJ+LLHr+F0DXczYcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuJrbM3Ts0MPmDlmjFl2cK5F+hXxaIQTABmMGU7/KKzE+1z+oL
	/762zCloMnxscRyIiRJ4gDF0XDGMtQvtVVfkJ2usMrmnpz91FreTwxDw
X-Gm-Gg: Acq92OGEXmyx6mftJ1Zgpk5bP/aqawtGZ28NFKP1zzEm+jw/yhEO5lGa57dE/LFX4GS
	+lL/UE0rinSBJ+7GhJKT/isPXC//5EgmYRZJMavwmE9weE7HhMZUuJNAdpq9g7OyRV9j+8wWMnr
	KS+CFHQbJoGU8v6XPzqxpg32fZcVAWYbAaoamDw3yDup5LvdfvmAYYyVsGHhV18kRBwkMsrZ5qM
	qFMHUDbuL2YHk3gD2bRMpAQd+PzWSwQx52r2LcB7JRQZxLkv9ckor29SN+ituR1BhKS+gZjbX6a
	yeLT7r9zXwSEpFpheNfP+YMChdQc9F3oOOdJHSRAnnGhfBPoh1R+m5/mb3nrsi9s9wtXFtwomnZ
	leVSNTO0jGbDv0ewKh4dIG2JvCZ6pGL87YfOVUMPPKP4AP37/LzK6TbCsi4JuMRGZdvO6eixWRA
	LrfzRd7KabhM7pAaTfuO4AMO0W66FGxxpeKOVkX56rdQ==
X-Received: by 2002:a05:7300:e6c6:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-303982b11bbmr2831503eec.11.1778879658197;
        Fri, 15 May 2026 14:14:18 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302977a9474sm8153511eec.25.2026.05.15.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:17 -0700 (PDT)
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
Subject: [PATCH v16 02/38] tpm: Move TPM1 specific definitions to the command header
Date: Fri, 15 May 2026 14:13:34 -0700
Message-ID: <20260515211410.31440-3-ross.philipson@gmail.com>
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

Gather all the TPM1 definitions and structures in the internal header
file drivers/char/tpm/tpm.h into the command header. In addition, bring
in the single RNG structure from tpm-interface.c.

The definitions moved to these files correspond to the TCG specification
for TPM 1 family:

TPM 1.2 Main Specification
 -  https://trustedcomputinggroup.org/resource/tpm-main-specification/

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Co-developed-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm.h      | 102 --------------------------------
 drivers/char/tpm/tpm1-cmd.c |   5 --
 include/linux/tpm_command.h | 115 ++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 107 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 87d68ddf270a..043d78a9617a 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -52,105 +52,9 @@ enum tpm_addr {
 	TPM_ADDR = 0x4E,
 };
 
-#define TPM_WARN_RETRY          0x800
-#define TPM_WARN_DOING_SELFTEST 0x802
-#define TPM_ERR_DEACTIVATED     0x6
-#define TPM_ERR_DISABLED        0x7
-#define TPM_ERR_FAILEDSELFTEST  0x1C
-#define TPM_ERR_INVALID_POSTINIT 38
-
-#define TPM_TAG_RQU_COMMAND 193
-
 /* TPM2 specific constants. */
 #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
 
-struct	stclear_flags_t {
-	__be16	tag;
-	u8	deactivated;
-	u8	disableForceClear;
-	u8	physicalPresence;
-	u8	physicalPresenceLock;
-	u8	bGlobalLock;
-} __packed;
-
-struct tpm1_version {
-	u8 major;
-	u8 minor;
-	u8 rev_major;
-	u8 rev_minor;
-} __packed;
-
-struct tpm1_version2 {
-	__be16 tag;
-	struct tpm1_version version;
-} __packed;
-
-struct	timeout_t {
-	__be32	a;
-	__be32	b;
-	__be32	c;
-	__be32	d;
-} __packed;
-
-struct duration_t {
-	__be32	tpm_short;
-	__be32	tpm_medium;
-	__be32	tpm_long;
-} __packed;
-
-struct permanent_flags_t {
-	__be16	tag;
-	u8	disable;
-	u8	ownership;
-	u8	deactivated;
-	u8	readPubek;
-	u8	disableOwnerClear;
-	u8	allowMaintenance;
-	u8	physicalPresenceLifetimeLock;
-	u8	physicalPresenceHWEnable;
-	u8	physicalPresenceCMDEnable;
-	u8	CEKPUsed;
-	u8	TPMpost;
-	u8	TPMpostLock;
-	u8	FIPS;
-	u8	operator;
-	u8	enableRevokeEK;
-	u8	nvLocked;
-	u8	readSRKPub;
-	u8	tpmEstablished;
-	u8	maintenanceDone;
-	u8	disableFullDALogicInfo;
-} __packed;
-
-typedef union {
-	struct	permanent_flags_t perm_flags;
-	struct	stclear_flags_t	stclear_flags;
-	__u8	owned;
-	__be32	num_pcrs;
-	struct tpm1_version version1;
-	struct tpm1_version2 version2;
-	__be32	manufacturer_id;
-	struct timeout_t  timeout;
-	struct duration_t duration;
-} cap_t;
-
-enum tpm_capabilities {
-	TPM_CAP_FLAG = 4,
-	TPM_CAP_PROP = 5,
-	TPM_CAP_VERSION_1_1 = 0x06,
-	TPM_CAP_VERSION_1_2 = 0x1A,
-};
-
-enum tpm_sub_capabilities {
-	TPM_CAP_PROP_PCR = 0x101,
-	TPM_CAP_PROP_MANUFACTURER = 0x103,
-	TPM_CAP_FLAG_PERM = 0x108,
-	TPM_CAP_FLAG_VOL = 0x109,
-	TPM_CAP_PROP_OWNER = 0x111,
-	TPM_CAP_PROP_TIS_TIMEOUT = 0x115,
-	TPM_CAP_PROP_TIS_DURATION = 0x120,
-};
-
 enum tpm2_pt_props {
 	TPM2_PT_NONE = 0x00000000,
 	TPM2_PT_GROUP = 0x00000100,
@@ -225,12 +129,6 @@ enum tpm2_pt_props {
 	TPM2_PT_AUDIT_COUNTER_1 = TPM2_PT_VAR + 20,
 };
 
-/* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
- * bytes, but 128 is still a relatively large number of random bytes and
- * anything much bigger causes users of struct tpm_cmd_t to start getting
- * compiler warnings about stack frame size. */
-#define TPM_MAX_RNG_DATA	128
-
 extern const struct class tpm_class;
 extern const struct class tpmrm_class;
 extern dev_t tpm_devt;
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 664ca1fff2e8..96f189b5fd6f 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -504,11 +504,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
 
-struct tpm1_get_random_out {
-	__be32 rng_data_len;
-	u8 rng_data[TPM_MAX_RNG_DATA];
-} __packed;
-
 /**
  * tpm1_get_random() - get random bytes from the TPM's RNG
  * @chip:	a &struct tpm_chip instance
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index 174b043d8bbc..30d01953a6f8 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -36,6 +36,121 @@ enum tpm_command_ordinals {
 	TPM_ORD_UNSEAL			= 24,
 };
 
+enum tpm_capabilities {
+	TPM_CAP_FLAG		= 4,
+	TPM_CAP_PROP		= 5,
+	TPM_CAP_VERSION_1_1	= 0x06,
+	TPM_CAP_VERSION_1_2	= 0x1A,
+};
+
+enum tpm_sub_capabilities {
+	TPM_CAP_PROP_PCR		= 0x101,
+	TPM_CAP_PROP_MANUFACTURER	= 0x103,
+	TPM_CAP_FLAG_PERM		= 0x108,
+	TPM_CAP_FLAG_VOL		= 0x109,
+	TPM_CAP_PROP_OWNER		= 0x111,
+	TPM_CAP_PROP_TIS_TIMEOUT	= 0x115,
+	TPM_CAP_PROP_TIS_DURATION	= 0x120,
+};
+
+/* Return Codes */
+enum tpm_return_codes {
+	TPM_BASE_MASK			= 0,
+	TPM_NON_FATAL_MASK		= 0x00000800,
+	TPM_SUCCESS			= TPM_BASE_MASK + 0,
+	TPM_ERR_DEACTIVATED		= TPM_BASE_MASK + 6,
+	TPM_ERR_DISABLED		= TPM_BASE_MASK + 7,
+	TPM_ERR_FAIL			= TPM_BASE_MASK + 9,
+	TPM_ERR_FAILEDSELFTEST		= TPM_BASE_MASK + 28,
+	TPM_ERR_INVALID_POSTINIT	= TPM_BASE_MASK + 38,
+	TPM_ERR_INVALID_FAMILY		= TPM_BASE_MASK + 55,
+	TPM_WARN_RETRY			= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 0,
+	TPM_WARN_DOING_SELFTEST		= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 2,
+};
+
+struct	stclear_flags_t {
+	__be16 tag;
+	u8 deactivated;
+	u8 disableForceClear;
+	u8 physicalPresence;
+	u8 physicalPresenceLock;
+	u8 bGlobalLock;
+} __packed;
+
+struct tpm1_version {
+	u8 major;
+	u8 minor;
+	u8 rev_major;
+	u8 rev_minor;
+} __packed;
+
+struct tpm1_version2 {
+	__be16 tag;
+	struct tpm1_version version;
+} __packed;
+
+struct	timeout_t {
+	__be32 a;
+	__be32 b;
+	__be32 c;
+	__be32 d;
+} __packed;
+
+struct duration_t {
+	__be32 tpm_short;
+	__be32 tpm_medium;
+	__be32 tpm_long;
+} __packed;
+
+struct permanent_flags_t {
+	__be16 tag;
+	u8 disable;
+	u8 ownership;
+	u8 deactivated;
+	u8 readPubek;
+	u8 disableOwnerClear;
+	u8 allowMaintenance;
+	u8 physicalPresenceLifetimeLock;
+	u8 physicalPresenceHWEnable;
+	u8 physicalPresenceCMDEnable;
+	u8 CEKPUsed;
+	u8 TPMpost;
+	u8 TPMpostLock;
+	u8 FIPS;
+	u8 operator;
+	u8 enableRevokeEK;
+	u8 nvLocked;
+	u8 readSRKPub;
+	u8 tpmEstablished;
+	u8 maintenanceDone;
+	u8 disableFullDALogicInfo;
+} __packed;
+
+typedef union {
+	struct permanent_flags_t perm_flags;
+	struct stclear_flags_t stclear_flags;
+	__u8 owned;
+	__be32 num_pcrs;
+	struct tpm1_version version1;
+	struct tpm1_version2 version2;
+	__be32 manufacturer_id;
+	struct timeout_t timeout;
+	struct duration_t duration;
+} cap_t;
+
+/*
+ * 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
+ * bytes, but 128 is still a relatively large number of random bytes and
+ * anything much bigger causes users of struct tpm_cmd_t to start getting
+ * compiler warnings about stack frame size.
+ */
+#define TPM_MAX_RNG_DATA		128
+
+struct tpm1_get_random_out {
+	__be32 rng_data_len;
+	u8 rng_data[TPM_MAX_RNG_DATA];
+} __packed;
+
 /* Other constants */
 #define SRKHANDLE                       0x40000000
 #define TPM_NONCE_SIZE                  20
-- 
2.47.3

