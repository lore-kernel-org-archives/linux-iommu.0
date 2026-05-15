Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD503ECBDA
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879675; cv=none; b=mqbUfYODQLK4Oq786uziIsJ2T0vREuhqFSzJupBGTpgmLGIsTVBeSjJZWdK1Jyval/BhGnH9HMBzZMzNzNzOlcKkNEuNmI3YhREyNWc8b4VszfN+3zhdzSgu2rBdlL68bhdWMK+B85/dudMAHeyjZZZxrDbmIfDnIVaQbq1dkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879675; c=relaxed/simple;
	bh=tgSnXEl/4HoRNelt6PM6wKCfW7tff83XdCqIyzj9aek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABB2LK91FspTnEVKbBRzbNPCBtN9x2XucZuu3wzTr8VWY9l82DtEkYVhwSKIs7VuFlaeX7UlWEL/BE1K1NotXAXUFyPNqZVTGdUbFLvAP8rZbh1My2j2FddWslUvU2bxeFMuHbwXb0pLaJJJrGC1AtLxpgh4U1k0u5b/HDf6K2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWM4Gqj5; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWM4Gqj5"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3025d725a05so923699eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879670; x=1779484470; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsy43cKdjjquhJVv3pJ2fPEZtWZ9VhRxjDQaQqinW+s=;
        b=rWM4Gqj5OBBWhyvcnJUL6cBxA1tji6HX3Mx+SixT33JBJB+dtAIuwbK5J1J5epJyve
         hiiTfXo7YLWjwEgIs+z2a3WYvRnc3Ej1Pk8DokawVioKqxPyjqi46JEq8w+GaHhpNpC4
         S42/3Gou5R+CXd0CMOmqTf+4mUpKt5P+37tQ2Tm5oi/RD9BdJraU3yOxMekPkdlvVJ0c
         o2OqpFQRKe2YFt0PIa8CBA3V+BTGS3tM0bR9gL4H7cMgw7MUSih/YpiHlhPGYLwqwI+y
         AzCL1NV3qZm8nf5n88ujelTE2gqmMr2iyL5ZOZDzK1Y16e82REmi5+Ql1jCrueJtr09L
         VesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879670; x=1779484470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsy43cKdjjquhJVv3pJ2fPEZtWZ9VhRxjDQaQqinW+s=;
        b=TxCEWt59uPz9a1vXkDeMp9ViuLR6IU5XI63MlGLr0YGl7ev9x78pm4JhMsrZH9kKTE
         ndOhYdJ7XaBZptgF82gqxYByTx61fTcP5NxgLXpeL2mw48D6D3HAC/BAJo+ummrS2+9a
         JCUgse+rnDsc0Vcrwi+lIosHjRQnFVLu3Y/znBT5SGiDrqp74qoZMXryKyBnsRc0MFYm
         vJ2Ipsw48wJ5s+CrcgHkz5xutYGzkc6+L0akK6jX376Lhty21fcu/aSgL4d5bKNF4W+T
         RZXo5l3V7ZRbwQalzuu+gZYy+wxap/eu+EryJDphAnMflLj9rBqXyKs1XKAlty9Km040
         9UPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Ys3pM60HfZ2rqRPuLObe3l+i7m4RgzzrUrAHNsG16FRmYpTpwQJuTUqLRf0CrU9BdmdsiFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2IkO6cARE8bGbziTcAgQl8RIkJtFqlA2tzKEV5D6IHBdxElD+
	/eFlWogJ7aXQnId7vhVv80nLxg/gfKFbcSkzN1r1rtmIyvqt/GOWcJqg
X-Gm-Gg: Acq92OFJijtpxlU5sS94wln8qL3PKLJT8d/vqhCTd+OvkZdpFTTf1ULTnE03oR4bfnJ
	o+H+BYlycgGZ4m4pmgjVOChSx/evorxV7y0jyrZRDcCvVEiJwPA9kDp8Eh+vQSTew+m8u5id4/V
	EhPDDTnWmjvNoDcyP2K78jFpzZuz9BlmKG3aCG8XHBJXsQQ4WqzgE3OaA14dUHeeHVAWuG7R6Or
	uIjotBHiFb7VxDqI2FD5Dh0HnuGLg87p7ZBIynYoJCZpvNTfPWWWxuZnB5Jt/wqmYB+I+W09bB7
	yFkBO8frYSaN4sr83/aTnEUVvo2VUNTv2pPbm6O/pSoBDo1xQ3z19IbC69Y5KDVz6OZkUq4xgIp
	bRShOhWBS/MewDMMHDAqmUz3tRm50WRIVEdXANTtYXouyNXcVfWSoq1gt2U73//hBGsc2IAhdu7
	kRk5QkoENmnG1qj3hlO+yOM0yg/Kfy+RM=
X-Received: by 2002:a05:7300:e6c4:b0:2ff:c84d:44d2 with SMTP id 5a478bee46e88-3039815cae2mr2917959eec.12.1778879669685;
        Fri, 15 May 2026 14:14:29 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b3cb2sm10323215eec.30.2026.05.15.14.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:29 -0700 (PDT)
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
Subject: [PATCH v16 06/38] tpm: Remove main TPM header from TPM event log header
Date: Fri, 15 May 2026 14:13:38 -0700
Message-ID: <20260515211410.31440-7-ross.philipson@gmail.com>
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

From: Alec Brown <alec.r.brown@oracle.com>

Allow the TPM event log functionality to be used without including
the main TPM driver definitions.

Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/tpm_eventlog.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 891368e82558..367b70ecc4b1 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -3,7 +3,9 @@
 #ifndef __LINUX_TPM_EVENTLOG_H__
 #define __LINUX_TPM_EVENTLOG_H__
 
-#include <linux/tpm.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/tpm_command.h>
 
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
-- 
2.47.3

