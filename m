Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094013;
	b=P+p0+poUCv8+q+yAluxYE9Kgz5BT5dIUfTW6ECaCaerget6DIjV969JyMPuoIr8U1Ta/
	 D5qYm0u/qH148gYy42x9BqJWml1Jbz3gM2x1VfCLEcvEsml+NiJY7KPWAHRH43jiepuuS
	 zg9iVGGWB+09oyMxvpBDccXE9IyqyKHGRbE/zlpp3Y3jqzxtiRFk9ULVPQ4KXuvxDw+cq
	 /QFcTPhhiX9ORDUEKEFTzk4JgVDHa5kTsFYW1OZ+U2RB3vLHvABI3lbFoLHwkpo+NSSeD
	 IlI21cVl4vnmghSveD7486NtOlDKMQREsbssUsCaWHNi6MPsCguKGonbqH7OYAG2o7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ia0GHjhj17aGyvrjUWwCw5HBsXsim8pYjVRtdPA8MUI=;
	b=YkgqRt8T2hNZpnZjcUqINqEnbFylNjOBJe5xelHqiRy2QC0frl4yK17tgnJPH1Bt0eNH
	 bWZP+ZTBWFCmYIuzbe8oE229KvA50pUxUD32DncYC1z+W0PThhGVT2gfFX4tdg0sOxw3N
	 rNWCvqgzHaJN5ezSk6L23xHUXbngh6v0jBbwBMpng1rjEfDlge7kd9IW9vbz+yolKXQj5
	 bJEFL/JtoFXBN0QgX2DcL9K3j3Z4LsOXZ3wLG/6ix/T44+k6ESDQRJgHMqO318DVGqAh9
	 74r6aMPH+laiCHZTA7L13EjKwvr0TlC1NBgiSfRbP50pcZ5GHkK8qfd39sQdpT3wqHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NzVwuAqI;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4D60A2602
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E4D60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NzVwuAqI
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49d05d51553so15734545e9.2
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 05:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795094012; x=1795698812; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ia0GHjhj17aGyvrjUWwCw5HBsXsim8pYjVRtdPA8MUI=;
        b=NzVwuAqITc7ifnp8/T35/9XAcyXXURN8nE7AQHThwO9JM0IV0qylukenXWyiGuWd6Y
         mwFCsCE4WQdSM8LJ0zaXz27ZkGJGJuMYYWjoxM8HfF3YTkC/kRcXWjACxEzXEAd7KNxA
         7Ct/CBbN6ImBcr9Cutu932B76MuEC+/7bPC/2XHw9hPHX7ziT5WlgwfTQ27twDcrd7rF
         /rfdBqqhrOjLuKiA3gTFK9pMretmWTFXp8DgOPuk9YnTIfWz2S/UTS3SMNDKw0t53hgs
         apcUl+4xscxxQ+nEEy+Y6RWTVRdO5Y+JdmXAGC6Jb2f53owh17dc0nE2MMY7JtzYtKSl
         GYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094012; x=1795698812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ia0GHjhj17aGyvrjUWwCw5HBsXsim8pYjVRtdPA8MUI=;
        b=xr+fOOx12r4KRnXFtdZK+5cNL7QhzBxREeoxgmKUy+99uNb8ln2i04hIcz5Wr/F1+z
         tmOsKMbEhyzBqVQgOp77XuftftGvLcMrAGf14yek5freNdx0l2XsgCkTwAsmlons2f5h
         P8gYpb+WY0fAE+aBrrLsq6LnQ5r4u4W6KcHU8I2hu5f9TeLFOa9P8YUYkIdzAlIhSmPl
         OYQ1nv3ZFLNQcfNLx0k68g28zcKF3nut85PDhxq1HEeodj1yx7cHKbYgzi0zPpvr1ldr
         zWiJ0/bTcm2xTRSDdX5t759BU3QAkWXjPG1L2TBiZg8ZGHK3mzbtsac8i67mswAwtTPJ
         nCNQ==
X-Forwarded-Encrypted: i=1; AL+hErHUEtG2b+F5BXX/cyVFOhaGKXGTTPqdWTWu83iC94wiBZt45MO3AiKACcbU0kUilkYuR3tj6A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+fu68eP9yZspaXbQq6QanpXijsZ9lr3Ss/JUl9dZmZ1ZVcvBSh
	gVzSnzzwEXqwBcRuansfIFf1Ovz7VG2Lj/bZVr94dHX+ijTF2VEq/MU2
X-Gm-Gg: AYBFou0jKRVQmTVA9yO9zcvGUzI18gYw8mJdYgNGEfxm+A/V+F9LSejIUPkNfr8TdEz
	yKDSDYNyhlxljNuDf8JGa/zX4afIJAxkwGsckcrG087ybpDo54CeXevf178TQue/f5d5gs1WVVb
	rrKnOH+ogbnSDb2gbNtF8c6JBP334VXBINZhfTw0pRAiONcPcVCthDgOfcQsQjCL3jxqdsw4i0I
	oufYtbj9hQk63AM/hsClQ0Z7vBveZEHFBZIZcxDspFRpJ+uJ0TUC1q7VR1u0l2OQNKBnP3mDvWu
	iK4U4N59DPuEqBG3tyjv5s8JmbzDJkPdiuAzd+9aWir/VlWuau4c5oHEm0iIAseA3iVporEfl9U
	pTgaetPHVBl6Hte/baGJpMtTQg050NnyLnxh4qwFoYuKHY4Lp3or/sIVWhf0tNVd2nHaOGPSk1W
	BnnZeKnbD4gKncN/cU27Eao1aitUvfLhvZZOomoNImUQmlDYdVUuNVsWbZlbGhptRNHrN1ejRIW
	hMnbXOeoU1B7CqeeFsK8Fi5UrUKNTVfOJ3BeMDXY9PEVrfYe1dd6P3eyUnhuMso/onFstEliHHI
	YoItrCBn9KJy+XE7a8dsudY3TV9aoQegibBK
X-Received: by 2002:a05:600c:354b:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb7da3a1bcmr117516075e9.26.1795094011855;
        Thu, 19 Nov 2026 05:13:31 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:477f:ff00:c2fd:f9b8:4971:d270])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e5edf5sm18258045e9.4.2026.11.19.05.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:13:31 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: ailiop@suse.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH v2 1/2] dma-debug: Skip debugfs registration when uninitialized
Date: Thu, 19 Nov 2026 15:13:24 +0200
Message-ID: <91e9fa52ed35754f62c7fdecfad266a7213d4602.1795093513.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795093513.git.thnkslprpt@gmail.com>
References: <cover.1795093513.git.thnkslprpt@gmail.com>
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

dma_debug_init() returns without initializing the hash buckets when DMA
API debugging is disabled at boot. dma_debug_fs_init() still registers
the debugfs files, allowing a read of dma-api/dump to traverse an
uninitialized list and dereference NULL.

Skip debugfs registration unless dma_debug_initialized is set. Keep
the files available if debugging disables itself after initialization,
so previously recorded mappings remain accessible.

Fixes: 173735c346c4 ("dma-debug: fix debugfs initialization order")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
v2:
- check dma_debug_initialized before registering the debugfs
  files instead of guarding both dump functions

 kernel/dma/debug.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 36c1f7cbb2ae..6e554dcfc9b9 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -839,7 +839,12 @@ static const struct file_operations filter_fops = {
 
 static int __init dma_debug_fs_init(void)
 {
-	struct dentry *dentry = debugfs_create_dir("dma-api", NULL);
+	struct dentry *dentry;
+
+	if (!dma_debug_initialized)
+		return 0;
+
+	dentry = debugfs_create_dir("dma-api", NULL);
 
 	debugfs_create_bool("disabled", 0444, dentry, &global_disable);
 	debugfs_create_u32("error_count", 0444, dentry, &error_count);
-- 
2.43.0

