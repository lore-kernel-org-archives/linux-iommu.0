Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CFD30F946
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503206; cv=none; b=JgB0Ro9X+XWCZ9xDffCAR74nu8AVTqHlqL098RgoeYy3ab1cs8ZoAHXHoLeqiPUOxp8yBVYgwuoCyV8aeQ+nK8YddkLgrpsVf7rJ+FDqyh0XpEIjgOu1FEurlWFopRJjYN4ISPvUkuvL67fasE58gXwsxF41nnVC5cKzpbl7dsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503206; c=relaxed/simple;
	bh=0sXmLwNMlYc0PbllYPcwc9yuoEtGcI4ex2Sbk6FXq8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz/f/QRvAiLzPlFhwe/ghxQ6tG4vwdhmIQRGDejOJWpivtNco31g6+9PutP8eBGZtD197QE+GZ1KqAdewpCv55OlPRg+oE+mKKls0BOy3u9QRzfTcMO+ZoV0et2DhOa6MDHCGHJ+QBjkqiuOXeWymXIewz2/mII/9H43Y/kxl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ4chTLK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ4chTLK"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso728176a12.1
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 00:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762503202; x=1763108002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PabJINhtTz14DvOSYG0veNaIdLnYHWjqpt4UhSeU28c=;
        b=eZ4chTLKZJOm3g84CKQcHAGKQUmyKPQzqiMfVfUhsSspZb5RzBvCDOcaB7Ai+iIF9t
         HReVP7zGcEwAlpK4PE/ELNsrQXcFGV3XUZkxG3rDC/hF98sfIAQhIq0OjQmUUmUPqVKq
         1JUYLXUmKnVNz7YfU37K5QQ2kyibJorpEt/gSIk5b+UYeZ39YLkAGXWEgIDA6FLDFJ4k
         FFezN3k/KpGy5GGZzBIeaB8S1jVaEj4q8Wb1MiaxGC36TCLhZcnCq8k0dCud9E5G7qzS
         aTjWm1ytD9f9JwHLBcIbseKqJnA4gfhrKTO0TvyhQBbQf2qKV64gbtolxBF01ut2CTzM
         F30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503202; x=1763108002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PabJINhtTz14DvOSYG0veNaIdLnYHWjqpt4UhSeU28c=;
        b=UZCwDN1l/guU0kpHFHtN+ygXGfBVP8D1ibm4lIMjIZPCZpy3LkD0te7semPbgDPQV7
         bLXrjQ0YF6u3JXT8Lvd1gNlq18yFdUBin0Zy5yfMFDXKZFTw62OoohrxlEEim+Xg9LE7
         9VCNVzTNTex5ViTcyHQWTQ89d12dwSWL/K4s9kfUkxUxKsDXnsstjulVruJnFTHRk5vk
         REJzlBFItaVTdUYiXb2PnpPaKJIf8z37IQkvj0mnEOyrfkqcECFV64KIcmESgQB/GmeB
         37S+90Xgc17jg/EFp9/EzWe0JyTSthNCHv+DJTR9zzowku5PpKyt56KdlBs8nR4TUC9V
         H3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYICxhm15AkRMOT7vdzRts7z/VoiYyCC2yODsWV83yEs3JxmD/xdHWDU2L+M6bc+/BefbiuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YybQg8sFVMpXmMuchRvgx2xlU6DYEJiVyfTQfu9PX8BEtezFkk3
	U6yTorQuihFLOHQi0LoGki6Jp+9f2XAMQ6YUFBueQ1jeP+4N3llIHMcn
X-Gm-Gg: ASbGncsSnytSpgT60S4pemfEivLHAp1E7BuujB5+R7Hzv1B/e8cOvZLEWX5MX/aVqt8
	90m8AIqww0ByStyaSwiKv/mVvMDUXFhOP2bJWPw/GqHTD7kUmi1fh5Bjc3NPNCuIvB4srbDdXkT
	x6RvtQWjxY1ccy2JN0L5Rix+HbIRUpjh6Sb474RZea+kYme7uIJXWD/1TEhlY1OJg4BwEqMxx90
	LXAQouwknNbNB/f1rsoR7x2RCbp+PqQiWDy5GpOaDMtWM2/KuIMIb9i5tovBmfww192mpUl8/0M
	bSOxOKSbC0LZyXH8iX9qAsefChdlelmOIO6p5s49orWU46k0rwhETrwcR8fj5mw9WujL2i5VO3v
	I9Chl+P2Hq9isMea+g4sXSunoYbmjdnOaObOOVkUc0lwuCA7A5H/QNI4gMcTp2NVYSgtcz0eSjQ
	Ab
X-Google-Smtp-Source: AGHT+IH8lIVBGU6qZcWj9lXhl2uY6I1BfrQTXsj7jZaaMXy9BNwAH/WaMBWywYg8F8rsMUMO09NxnA==
X-Received: by 2002:a05:6402:5352:10b0:640:998e:4471 with SMTP id 4fb4d7f45d1cf-64146d18bb6mr550756a12.5.1762503202010;
        Fri, 07 Nov 2025 00:13:22 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862697sm3641613a12.25.2025.11.07.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:13:20 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 032C042439DF; Fri, 07 Nov 2025 15:13:12 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 1/2] Documentation: genpt: Don't use code block marker before iommu_amdv1.c include listing
Date: Fri,  7 Nov 2025 15:13:00 +0700
Message-ID: <20251107081300.13033-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107081300.13033-2-bagasdotme@gmail.com>
References: <20251107081300.13033-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1631; i=bagasdotme@gmail.com; h=from:subject; bh=0sXmLwNMlYc0PbllYPcwc9yuoEtGcI4ex2Sbk6FXq8o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJm8K/RqNyVdu5D741ms3OR9ByJeGHXMYO4M15mjVd7zX frZn3lnO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRwL+MDL1NZW6RbP46j7Z9 +cT8asYt5y311mXrQ59Zzdka4nLS5wjD/7KTUmlc95YK67orqgrIZ8xnYhHx2dcg2Tb9/9Izd3k XsgMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warning when merging iommu tree:

Documentation/driver-api/generic_pt.rst:32: WARNING: Literal block expected; none found. [docutils]

This is because of duplicate double colon code block markers: one after
generic_pt/fmt/iommu_amdv1.c and the one in its preceding paragraph. The
resulting htmldocs, however, only marks the include listing (after the
former) up as it should be.

Drop the latter to fix the warning.

Fixes: ab0b572847ac ("genpt: Add Documentation/ files")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/generic_pt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
index 210d1229aa1c1f..7a9ca9f2878d4f 100644
--- a/Documentation/driver-api/generic_pt.rst
+++ b/Documentation/driver-api/generic_pt.rst
@@ -27,7 +27,7 @@ compiled into a per-format IOMMU operations kernel module.
 For this to work the .c file for each compilation unit will include both the
 format headers and the generic code for the implementation. For instance in an
 implementation compilation unit the headers would normally be included as
-follows::
+follows:
 
 generic_pt/fmt/iommu_amdv1.c::
 
-- 
An old man doll... just what I always wanted! - Clara

