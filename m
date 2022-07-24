Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B418D33C3
	for <iommu@lists.linux.dev>; Sun, 24 Jul 2022 14:59:50 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id ku18so8227508pjb.2
        for <iommu@lists.linux.dev>; Sun, 24 Jul 2022 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xk8QcPITCD7zASInOLa1R0RXzqRXOUwelC1gE/1VxyQ=;
        b=fAiepUxK9sA5DHnLfCj/TTTTGGSmd2m9+OxyFBa/JXmjDXjvRJRTkIHYf8+IyXU2s7
         W1mFhcDj9aed4LSxZ1TmZ+0vZcBGb86C0PT0HZ6IgDBXz2VULXSLqSvYIsLHyE6y4xOq
         /JKdESHnpNg+eRJ2VqzkVs6RjmJUGmcmdVyOUE3MYSiowchwAuY9inpmGVB5hMW9zz8u
         ChzTN0f1d1pFHdsRu6LdBJT4eTrFSUZCMkv6HmDupDcU9Wqd+w/0uymEbFZOnL12YEDb
         5Ozki9IMj0emcV6pQu8vQt95nCbIJgIFXRFwA9BmRaWPPZ+EzltBXdSvBU/1aYxaIUMa
         XFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xk8QcPITCD7zASInOLa1R0RXzqRXOUwelC1gE/1VxyQ=;
        b=t6GU1kQp6riK4IxP10khE/K66lklzUGGcwprBJFv4QuEfxoJdZ3KeCgMAW0txOYGcI
         lVui2SlDF2/yJ4v9hAS/QOdStjcqchNCFG677bOsVewg/tB5rKaoZAhfq3x+MtjcqZ9l
         YAVKI9PSjybDRuuOoO629/7KEflvA5OpvXZHJtqGfWk6vWeUS9T05Zoxm/7l94iV371V
         MF5EYnDnDCFhw7J7zxkWs5VaX+WgRefE5x8JJ9tqC6vrcNFWr4ZYlFs4mKaX+TZ5VPVb
         6TseYdDyCPWZeRUBIYDONZCTZj2tyHHwwfJ8K/JV5QGocwPhfhbzdw0jAWeYjvl78zy5
         fMhQ==
X-Gm-Message-State: AJIora8g/l0sOB9F9PPy3/Kv0rQevIJJkjz8jq+HS0ZH+k1CKLVGZe5s
	+UL8gpap1R5EeP+QU8MmgE8=
X-Google-Smtp-Source: AGRyM1vihI8jIMhLCAgyF58n4D21NvM8f0l7z09f9iCuH5Q7OA5NkCQZV6bc80jT4wquK62eNbfPcw==
X-Received: by 2002:a17:903:3283:b0:16d:43f8:d971 with SMTP id jh3-20020a170903328300b0016d43f8d971mr7791901plb.171.1658674790006;
        Sun, 24 Jul 2022 07:59:50 -0700 (PDT)
Received: from biggie.. ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b0016c500fb7bcsm7360900plg.140.2022.07.24.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 07:59:49 -0700 (PDT)
From: Gautam Menghani <gautammenghani201@gmail.com>
To: chenxiang66@hisilicon.com,
	shuah@kernel.org,
	liaoyu15@huawei.com
Cc: Gautam Menghani <gautammenghani201@gmail.com>,
	song.bao.hua@hisilicon.com,
	tiantao6@hisilicon.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests/dma: Add a .gitignore file containing name of executable
Date: Sun, 24 Jul 2022 20:29:31 +0530
Message-Id: <20220724145931.32556-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma tests in kselftests are missing a .gitignore file, which leads
to the dma_map_benchmark executable file showing up in "git status".
This patch adds a .gitignore file containing the executable name.

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 tools/testing/selftests/dma/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/dma/.gitignore

diff --git a/tools/testing/selftests/dma/.gitignore b/tools/testing/selftests/dma/.gitignore
new file mode 100644
index 000000000000..668e2f8be2f7
--- /dev/null
+++ b/tools/testing/selftests/dma/.gitignore
@@ -0,0 +1 @@
+dma_map_benchmark
-- 
2.34.1

