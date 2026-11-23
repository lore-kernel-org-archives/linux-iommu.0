Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409394;
	b=JdAW1SAY83TI78k2edCga08ah9hXTGJ3WM3QMUtFzQsNuCUqKCTaOEQNLP2GGMAh9QIL
	 rlvul51gxKxD5iT1LTN2XyP3EbT3LzWDdw7mkchlXdOFNxaJTUyAO7l9eOlX8xZ0s+6rE
	 ddeMlLslX+LLH9HXLZKdN+COVPp2DJEhDWruIpJuJgsmQzYmc8pNoT8ykPVOGQXsE/+aI
	 nHg2GY7KHLQ3vcZXZPfOyZa/WToodZH8DtRC9Qkiyi473huhBUUmuGGiHVATKe3PxTwKZ
	 Ece9DAtUajpK+zgmcnoL1U5lhtPSBW9PogROEeUb/o3d6xQCk+xPbH5CfUPfOB3CDwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QJ9P3eG42e4bDinmt+GHSW0t1NFwPEsKAAiRCi2d2wo=;
	b=ASgMlriu34j6M/IkEyPKwa/lLd8+Le71wUTB4/YbaQ06lprhmlqsnUgvGjFcBNX0U8ZS
	 4RUlhNbeQ/b1ozPC1nThh0qYR2OyhmwRbVSt1aaNBXx52PM9duM9dkadjZW4WNzS03rCN
	 AgMyrPEu6ud/3FStyRZ1ijBqcsxUbB3jq7zFV9+MXvQCeSqj9xCGpAjehvnNNlPLvDhdV
	 T5SpMpbxBFpky4U/qSf4OD3YLCeN6jF0tgA1s+eJDTvnlE2DvGfXuvWsJoZzPO6fhlRht
	 aYG0TZLb0ctwipG2PXDNOiaz3RTwSP82rIuU3w9LGlFRN88Faerx1LGHtrECN4v6hqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mz7fGYjg;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF7E606A32A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF7E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mz7fGYjg
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b41e8c1ac0so4337048a91.2
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409393; x=1796014193; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJ9P3eG42e4bDinmt+GHSW0t1NFwPEsKAAiRCi2d2wo=;
        b=mz7fGYjgnGooHSywhVvQZumTnpPx2TvzuJz6Dq9pT1sf8JNFOXYBbieQTD2OWjDihv
         HE8lell+f0mVVWWmjQYlx+ex97QIQHNK0Ccc850CtpJeqX077r44F5h1mI2vcCyZnAxi
         9I1D9KxU7wK77MSmnIFrtKWT8pe6YM+wvRnZY0cRps1kdsJZ4VhIld1MQ4Mls28Qn8cr
         lLVT0vad8Lt1/f2rG4w/wa4Zdbljx43CmYjMiC5Pb0EattK1k4RdECro1YziCl+6DYP7
         vUPp+QEknz5BeWmTZbv4IVxaEK+9Gl4kQyQMiZ4IP6YEt8W6Y3gT4+JwFqq6ZNiT7zhE
         lyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409393; x=1796014193;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJ9P3eG42e4bDinmt+GHSW0t1NFwPEsKAAiRCi2d2wo=;
        b=ROPAFlDRJFEjZETzNSdbqnplcw/0ZF4P7rWFjp/mKigVBoQZwBNquaZL+8zkydxC6e
         L+fMQtRnQUF5g3TnyosbpzDt/orslLukNUCZZpsAqvd9x98j8+HP+nJ7lyUmuCFEKM6r
         3Cs/hFg35RaW+ITB7GXRFaCmcxl/iZwN/mk/q3e4DiWIvolx5d3vL78Yj8z4/VfElHDY
         VKx/thNr9Y9mQQGXbGiI0di2UFqj83gID8pA1WFGDP++6pZ7UkzDc3qr2xNvmD9J5hll
         XqTmebTw1eMpHb0C5Zrzog21txvfsznbwQMBIus+caD/Hhv9gfzk9XduyN+tQS+hq9jd
         qNaw==
X-Forwarded-Encrypted: i=1; AL+hErE032zP+OdL8dsVULC9W9AYs5FH5F6SSBRjHNtVRC4DH1yrA/qF3eh8xqzaXzIDXYtPDp2n+g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8iPlq1jTNtifziaWRJa80Xj0MpD6iRUvd0wNJNJtUKDfqmNL7n
	3tBFcHeEqQ7Sr1b9jFKPWePtxauvhtX0hGeFK57ffGse60/NS9GEb46vu/RZ0NxHBYmQgcw0p5H
	j4tor1wlLRt7Aww==
X-Received: from pjbgc18.prod.google.com ([2002:a17:90b:3112:b0:3b4:1ec8:4e4d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b:b0:3ab:e588:c2a8 with SMTP id 98e67ed59e1d1-3b41c9ba0e4mr8778659a91.64.1795409392721;
 Sun, 22 Nov 2026 20:49:52 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:32 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-2-skhawaja@google.com>
Subject: [PATCH v8 01/18] liveupdate: Export symbols needed by modules
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Vipin Sharma <vipinsh@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, David Matlack <dmatlack@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Export liveupdate_register_file_handler() and
liveupdate_unregister_file_handler() so live update file handlers can
be registered from modules. iommufd uses them in a subsequent commit,
and it can be built as a module.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
[skhawaja: reworded the commit message for iommufd]
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/liveupdate/luo_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a39992da504f..dac7a1c4590d 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -931,6 +931,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	up_write(&luo_register_rwlock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
 
 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
@@ -948,6 +949,7 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	luo_flb_unregister_all(fh);
 	list_del(&ACCESS_PRIVATE(fh, list));
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
 
 /**
  * liveupdate_get_token_outgoing - Get the token for a preserved file.
-- 
2.56.1.809.ga0b61035b5-goog

