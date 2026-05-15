Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4783EEADC
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879689; cv=none; b=SnztIesfwh3aXvH3JRxH94Sdo/1BE4yRuidsp0SW8rQYT2uU6rW/xxggehPY4rnQuZKPMJIXqEpZIz/Dxc0z5+kM0m/7qBgYarMQO8o1Ou0KAM8CWnZ+5fofMi2/nPN9Vt2wK2BCTTpBwvK6w2OHG35kYuuxpIr6WX6iNqMVjcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879689; c=relaxed/simple;
	bh=YM/w2wtPzdX3RmdPxAtDTeVwrQxqc/8DXfB4OKpz4wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqhAX5wKgJZMKB98MGSbKZYVw+nbLk7HpyQgLodr7kdCSZeazNagjVWZyQthe6cjt2RArHY6Nq0EXYb3+KfEsy/dIFVdvlqt9zXlgaUkOvQJDWrMBNhUScI5Yvr91/F1GGgX8ucn873/2vT82upmkkZlxYzwX+7ZKK0op/lMHT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiGOVn5m; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiGOVn5m"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so1350286eec.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879687; x=1779484487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LfQsLm4zjgCBkokqW/LNO8kguAx5+WYTFTmZDrk46E=;
        b=qiGOVn5mJbhEp/sEaGE1dJWUjZiqEdzCJzbeTA0QaBK/9Ydo42DXiYpxkFlw8v0jsT
         8SmfI8g6/AlBFNjtwB5tf/RxsJsGIDuFqEiQZ+i7y9euGpJ0pQAjI6lWGYj9O82+ZrUs
         jB6pJIPMd0gVNJRybXtEcBL347wqCFBv8caR49CMxA8by0i2St2w+wtrqEp6Sy8FO2Pn
         sf1jOCfyBBWCJbk9KuPfZyrO+XPBM8Qzgg415xyiNffmbLTIIRa7ykI6CQHH9dRuj9r7
         LlEhb/KESAgosJmaR/M58cGAhNdSYiZsqE5PSLMY20j4y3GT8zGk4fB0Nv6YE8RxVovW
         kYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879687; x=1779484487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LfQsLm4zjgCBkokqW/LNO8kguAx5+WYTFTmZDrk46E=;
        b=rgCfh4GOzj5TLk+qPoRslrUzXOessXDfsvWuJ25PYV9HeWzvcGrgc4Oq1Js/6jJDQ3
         yoVwZ0ULH55JpOTzXWdvS5IG6Y9kOqGZYKSms1ihL8ufTORTYmlvQ01uDY5xV6reG7GX
         /avHtLEMLjR8blEMLdgEqrCJGe23nir7iZKtuGj5n1FqY5l44aA/Sdl1boiVqiXJhflm
         Mn9S0Kh7BC5OzXkOG7k2DJYLsjSXt3MC6j5QtMBGKnhdpW8QZ9+tqa2bqMCechESfXHH
         gaPXEhxBAnUG2pu5F/MyTU4qlwCXOvck3pTey2iySqPUB946oSKE1hfZJk4Q2de7LkOj
         A8kg==
X-Forwarded-Encrypted: i=1; AFNElJ/KcpNfbuNU6mrq496S1sPHe36VfOdHolOodBOstVxlxsk1xz7cc4bGyD7xuGxoRP7EGUU8zw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFB7cFVc5RUP8L+DTj90woe/gjdT+o0+YUQPJSdHgaYpBOuleO
	DZf/VQbO3kRlQOa3zwObQXp/4kg4QUmEf4ufgA1Vf2vzlTEER1jZNtZL
X-Gm-Gg: Acq92OE6NeuX/Kexp58jfDucm9w8sbKGoXDLBcaiOPLObMq9lScQxXV3fd6BafNew8Y
	h+E0XbA7uv6IDTYmBiuAAgvZil7lv1rqrEyDWBTJNWwvyFZ4feDUGD7BDIdO8mDWpPAykzP6Bor
	C7fqbmGSBYW4n5YQBqyQ1loBltqfLI7dB+hnz8j1/3ql25cia7HG/VBF5znuydJ0zo3qPIyTB9P
	amK4IxjBqDbYPPIozXzr1IfPkGeB22eJx6V1BoW2Xi6t1FP7cHYbYhFByKWNDmToTUfWUUeMuAh
	oN9b5wNQU7rkycbVRI/jzEqWfwlCMuVthYAc13qk1h+yqds8EKpBknQaafE4/CMicFTktT0G5rE
	rraedA0T1lON7/0SYdJsxao/f1c+XpFUcOCKTl90nETWbg1IDDC6jocoJF9P2dNNXS6WIvthTTa
	b0pMo54hd4V0va8YrK2oClqisNjBuKWUI=
X-Received: by 2002:a05:7300:a907:b0:2f0:c8b5:3dc7 with SMTP id 5a478bee46e88-30398680c36mr2863934eec.22.1778879686973;
        Fri, 15 May 2026 14:14:46 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6c3sm9740068eec.19.2026.05.15.14.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:46 -0700 (PDT)
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
Subject: [PATCH v16 12/38] tpm/tpm_tis: Address positive localities in tpm_tis_request_locality()
Date: Fri, 15 May 2026 14:13:44 -0700
Message-ID: <20260515211410.31440-13-ross.philipson@gmail.com>
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

Validate that the input locality is within the correct range, as specified
by TCG standards, and increase the locality count also for the positive
localities.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 1fbb74a565f4..70aba05f4ee1 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -179,7 +179,8 @@ static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
 	mutex_lock(&priv->locality_count_mutex);
-	priv->locality_count--;
+	if (priv->locality_count > 0)
+		priv->locality_count--;
 	if (priv->locality_count == 0)
 		__tpm_tis_relinquish_locality(priv, l);
 	mutex_unlock(&priv->locality_count_mutex);
@@ -233,10 +234,16 @@ static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int ret = 0;
 
+	if (l < 0 || l > TPM_MAX_LOCALITY) {
+		dev_warn(&chip->dev, "%s: failed to request unknown locality: %d\n",
+			 __func__, l);
+		return -EINVAL;
+	}
+
 	mutex_lock(&priv->locality_count_mutex);
 	if (priv->locality_count == 0)
 		ret = __tpm_tis_request_locality(chip, l);
-	if (!ret)
+	if (ret >= 0)
 		priv->locality_count++;
 	mutex_unlock(&priv->locality_count_mutex);
 	return ret;
-- 
2.47.3

