Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338C3F44C8
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879695; cv=none; b=X812hnuM8slAGE58kePamT23+4LO7q3BQaST88a6Hm41szAJdbQn1WDf+fBJm2uIGadfzMsE1yZfxNbiIrXTs+vN5Mnw7+CSjv7r1HvDjpYamNIlY7uFu6co0hnLPv9upTFDWr20O20fAcFmZQXBeB7Vt5xLnjyStn9b+FOB6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879695; c=relaxed/simple;
	bh=1PNKH8ntc5kC54kp2fuFbfDzJKv8jvUIR3tksHCBOAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXAca/5ewln0nKi/7ReYRYCRMiuN7IZ3Ea8oFimgiN+veXpB+i55NoQaiJfaxzPl5y3i6qoi3GsAZy8XP5GEG9Qy2ARdNG7uSTmnspkNDKWfrigDdZCraRrg4XGECUlCM930gq8yG8Mjx2hY0qR50ChNZ231X0bh3BAu4aJoNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0w2xCsW; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0w2xCsW"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-132c338a537so1026649c88.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879693; x=1779484493; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Web2s5uVg47aYyCtELeKAMQeYbkPbYPk/ttB5U3wMg=;
        b=R0w2xCsWaw05/ZogFAIh1EESmzcGzZkKelierv1wMHbYQT4guVBFjg1opAoJSl0UyN
         PLliKkIBafZWi5DLZfqUoqvTKP4BTqNEmG5NkM0CdCt61cLln/BKwQAjfugxHWdFHe96
         OW/3bicTGyhjE4GzDOezp8k3RlskFCIhSHQQUkJzlLb7yHbuT/YiXcaWJOELs2iMyzkl
         LvnAVQTnH30grqy9vtaVfjOsYT77XosO48BuY0cS5u66+Lw6Es56vaS8xoaztDwS8b0/
         7/EhCVGdI9fzFRwWKypOY4S12f+C8PpbUvu4oKoVHTbsEw0azGEEMXZwZc+8dcfdIPC4
         7opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879693; x=1779484493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Web2s5uVg47aYyCtELeKAMQeYbkPbYPk/ttB5U3wMg=;
        b=AzS6YW8IBLvAQ/zJaHVsl0q8ySqIh/RUlX2DZCgucdsZgMbT4WZIrUX+snhAa2NRtx
         DlC1C019oIAiM75QKe1S71V9Tn834+VLgDsDruVY/audZdLi4gZETsUSVR9roZe3yp7i
         c9pQY+PMp7e1YhPEIvTOtgql60W9ja7JfBw3xVlzzXctyNag8sbNauQBlKy3Yq5P7VY7
         Hfcpv4tvszUUTCIG0gveETBTnBU42e6BO9lFZTh+5dcyzHDSSKDHr2jui3EGtlRad3wg
         CxVnRlRH7wyHb2X255f3DuYwzBAy0BAG1DVcop26/9EC8DVzCts0mD8ZHHyt9h7S2gKu
         vrIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/078rZwlmkS7VkLe54FXFruytmuX8/gPoWWXCmwx8gp2L+rH8jdkc22sCUCOa+9wrew/ILHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/OxnfcD5QZg2aoyju4BBHuhzroJXxBTfl5nOG2xV7oOs5zVK9
	r+mGNzzVVRcgIP+XBoaYkzJGJUZtWiJMlb50mX9XCALnJHIjjruVBoSz
X-Gm-Gg: Acq92OH4mGhKIFu8omJ9Zc+HhVxIjmAYLTfuXmQgeqTT5HA0R5cqTKN6I84AmXpZILS
	muz+NAqOZljKOgj/T5W+JZMtZZUyocUuqnBbVNyga60ttkPtVH3cher9ALLH9d8CiaIEDZPEYEo
	Lhto8V2xvSmqJwG6b7tX/ztTrpbBHj7AH5dEMR/RgcHUTVr4dF1oIr8GqVdmvWaJe5hoAJDUrje
	Nr/oIWtSkZiCDoRHCrb+lUM1fA9N+WE83O0KNk9QTL2pffQtHcDWyGziQvW0ByZU1Q4BebYzH+5
	PedE6yGncuByNuf8JBBYH2Uai+z14MZk4dMfx7RaiNUXuBgtzW2Vul6w9+9uM/PvAVYzdDpc0Wa
	gF9GzwXeFV4I0/6FHq46tPniK7iK1BVVagDo8LcEfysyKiss59bOVdM6f68avCZ2Zfb7B8Zt9gA
	O+COFgH4wkJ6RM6ZooEzF28iY/ON4/uDo=
X-Received: by 2002:a05:7022:79d:b0:12a:6abf:ab1c with SMTP id a92af1059eb24-134ffe943c0mr2448441c88.11.1778879692592;
        Fri, 15 May 2026 14:14:52 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc3490bcsm9740184c88.15.2026.05.15.14.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:52 -0700 (PDT)
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
Subject: [PATCH v16 14/38] tpm/sysfs: Show locality used by kernel
Date: Fri, 15 May 2026 14:13:46 -0700
Message-ID: <20260515211410.31440-15-ross.philipson@gmail.com>
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

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Expose the current locality used by the kernel TPM driver via
the sysfs interface.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index f5dcadb1ab3c..772c4ae67957 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -308,6 +308,14 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
+static ssize_t locality_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%u\n", chip->kernel_locality);
+}
+static DEVICE_ATTR_RO(locality);
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -335,6 +343,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_locality.attr,
 	NULL,
 };
 
@@ -343,6 +352,7 @@ static struct attribute *tpm2_dev_attrs[] = {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
+	&dev_attr_locality.attr,
 	NULL
 };
 
-- 
2.47.3

