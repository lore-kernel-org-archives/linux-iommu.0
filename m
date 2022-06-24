Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3F28EB
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 14:21:44 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id 184so2533736pga.12
        for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gm1rQOK+mtphDI8kcI6bqB/QE5aGOSJgtL/42BhKW1s=;
        b=jUJmsfuxsGmBkBlz8uoOMKBsh5zii0b6kyo4UGtUZtRcVP/eQ62xEqx1yp+p9r2RBb
         u2iemCnlN5ab8kxb5/SqFbREuliur6+AHpIegfg+WDqRPMdn047nR2F7NvlJhsvd1PMD
         Y5WC0N1Lbcblf5BCO/LdQbFvxSpDg+1smsR2CBnsJqNZdMAgEj4e838L8oT8mGOPmTrp
         abBOMbDW5GPx6tR5LeTLMpQw5SPhBt4gz6b1Xf2A1hZj5JKu5TKfU85dfIvDQ2af6wua
         LLQMBgNXpWRRKmKC+cs1pvDP3w5oNoUw37bUO/t020HI4hc/1v4OYMkFXJ5eULRlVHI5
         IYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gm1rQOK+mtphDI8kcI6bqB/QE5aGOSJgtL/42BhKW1s=;
        b=Vv36p7T6x0FQKPMY9uXwDlYeAXQYptv4+FzZLpSEO5K/8iDSaz0ymS/hX0BfcohHbU
         j4XfF5WJ9bILpFkJs/Yg/LF6T40KMiSdzYZF4yqQYyT9Pjyq/ZkfIH+MqY3vXjVqIXqK
         5jd7Hawx06na1Dlh0H/PCEPphsWXEGhCYjPglaEPmWmx9dE3UIshGZQaN39gcUXeGptS
         8QSz6ucdmJbd6105CEN+7hXg6YGZXxIZgIHCKGIHEr9phQMuuA3EfpOEygA7goCDXwfV
         RLG+4Ov/1UWBnu9efXiy26rqskB7+kco9qD3WdqZ2RcGOcGLCgDpRi6rFyw6M9KQw1cH
         JWtg==
X-Gm-Message-State: AJIora90I1bspfZWtnZvUJRt4LxzxFENavKEfecC5iD0ueFvMzwgqzD5
	nmNyHWEz8N58ZFZKRnOha57HFA==
X-Google-Smtp-Source: AGRyM1vPxxwcqwbRahhD3wqTdZ41SZk38shzdGTT2AP7tkKnWCBBlZm8B6XghK3eFpJ0wOG6xCzgsg==
X-Received: by 2002:a65:6c10:0:b0:380:437a:c154 with SMTP id y16-20020a656c10000000b00380437ac154mr11854740pgu.549.1656080504253;
        Fri, 24 Jun 2022 07:21:44 -0700 (PDT)
Received: from localhost.localdomain ([199.101.192.196])
        by smtp.gmail.com with ESMTPSA id jd12-20020a170903260c00b0016a15842cf5sm1868877plb.121.2022.06.24.07.21.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2022 07:21:44 -0700 (PDT)
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
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 0/2] fix uacce concurrency issue of uacce_remove
Date: Fri, 24 Jun 2022 22:21:20 +0800
Message-Id: <20220624142122.30528-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When uacce is working, uacce parent module can be rmmod, parent
device can also be removed anytime, which may cause concurrency issues.
Here solve the concurrency issue.

Jean-Philippe Brucker (1):
  uacce: Handle parent device removal

Zhangfei Gao (1):
  uacce: Handle parent driver module removal

 drivers/misc/uacce/uacce.c | 135 ++++++++++++++++++++++++-------------
 include/linux/uacce.h      |   6 +-
 2 files changed, 92 insertions(+), 49 deletions(-)

-- 
2.36.1

