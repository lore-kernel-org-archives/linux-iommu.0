Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDF28EB
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 14:21:50 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id h192so2570615pgc.4
        for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2Nx0BOBB6ekdm1U7bh3Zno30OffMdY3lMdwn3cLPcc=;
        b=PKJY/ZqW6QWjUEvVKvlgmRXCPCKacIUVkYU5gyGwsmqSq3O7KRGzo0mBEGeWO7+8ho
         1hy30InZQVN1m/ELaQQE/bv8C/p7Fo8PQCf77qX2gP6NF+rzQqiRHVvl53gljwNgfLG3
         U4a7pLdloEnAW1lmnlhsARkHq2IW3K3AT9bqgDADEHNqQq7k7WW+LamIPr46IU5x03Z5
         Tf9rcx1tqWQxZWoPzNlt7PglTDNI3fXN1g6QgQQengyaHVeSWOlwxZeBWJHqyKw914XR
         tTtfafREtkDf/9PoKWw69uiZK/eubDtoNFDC5X7Vd8rNWMuJZdCkMcgOv7mQuQ5V9pnt
         B1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2Nx0BOBB6ekdm1U7bh3Zno30OffMdY3lMdwn3cLPcc=;
        b=EsxX5Wi2f6smhvwziZbBPm/BqX4K7RcSZH5VzxIZ7S1aRBX5JAnSW+78d0qs0HhtDv
         YYqZynPCNB1HT080vXcvrN6mWaO9ANJN11zAEGwoqfvvAj3qCI0OYp8KXnTSoWQjZItH
         jJa1b7+H75EXESJvsCo7cdL+jxlhDzo1ujnua0mrX2i9c7zXC64usrf752QQyPt3Oqba
         xcz+fUl3dLtGFdDKlDX9+83TgCkkexyXZoM1+xdXRoiT2m3UlqdmHpYOEbE9x1yRm8FQ
         O3dDCh1bj8XjGJeapLb188/D9nOcPrf3qklDY/IE0DSM9tcrIHlQh+SnWkQLC9zWolOv
         MI1g==
X-Gm-Message-State: AJIora/FCL4tH200qxWMAjOGFAAfovu6PQZud8lAN/aLmW65wg4GoN8j
	OTZfSpelWTIAMpCMDnNUFWPXGQ==
X-Google-Smtp-Source: AGRyM1sGZQHqM4vAQ0rT8G3P/TII0MhrjWaVdriD1m7/7FZqm+K2uqzjEL70ZsJ7071YrCWkg3B9PA==
X-Received: by 2002:a63:8c5e:0:b0:40c:95c6:7069 with SMTP id q30-20020a638c5e000000b0040c95c67069mr12361332pgn.148.1656080510066;
        Fri, 24 Jun 2022 07:21:50 -0700 (PDT)
Received: from localhost.localdomain ([199.101.192.196])
        by smtp.gmail.com with ESMTPSA id jd12-20020a170903260c00b0016a15842cf5sm1868877plb.121.2022.06.24.07.21.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2022 07:21:49 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	jean-philippe <jean-philippe@linaro.org>,
	Wangzhou <wangzhou1@hisilicon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: acc@openeuler.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	iommu@lists.linux.dev,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Yang Shen <shenyang39@huawei.com>
Subject: [PATCH v2 1/2] uacce: Handle parent driver module removal
Date: Fri, 24 Jun 2022 22:21:21 +0800
Message-Id: <20220624142122.30528-2-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624142122.30528-1-zhangfei.gao@linaro.org>
References: <20220624142122.30528-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change cdev owner to parent driver owner, which blocks rmmod parent
driver module once fd is opened.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 281c54003edc..f82f2dd30e76 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -484,7 +484,7 @@ int uacce_register(struct uacce_device *uacce)
 		return -ENOMEM;
 
 	uacce->cdev->ops = &uacce_fops;
-	uacce->cdev->owner = THIS_MODULE;
+	uacce->cdev->owner = uacce->parent->driver->owner;
 
 	return cdev_device_add(uacce->cdev, &uacce->dev);
 }
-- 
2.36.1

