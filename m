Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8123CD
	for <iommu@lists.linux.dev>; Thu, 21 Jul 2022 21:03:49 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-31e9b1be83eso6138087b3.8
        for <iommu@lists.linux.dev>; Thu, 21 Jul 2022 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MypyzVZSccI/RyC46qp75Pb6XbMOH7vgHkqe/QUNPpo=;
        b=KGtiU3I1Yc2pPQ93b0InIC/VuuUUJbgRueIy0lePqllWiicPtHn7WKGz0btmVyk0nL
         aiESAnSPgMdxVpNrNxbm8kN8yCAVFNVcjTpucSpHAYSE/4g3cr+7PvvOcDS1S/WmdJX8
         1bAqIFb2pMUyuw6gH0P1UUR/bm+CYAqThTW+X12OC8EDQmew8lKXHz7R0gD25EtoIkQ4
         VUvy5J9eTKnl+OkrVTcPVKnTp4mJQs4yS7PHVCUCOqpffTDGby2D0gsUmTEr2m/Xa5Po
         7vSYyhpqZm4I52h3zF/v83BM8hHyPkWdvLqXeTCg1iWszKpT9akPaMxriel8j+qa6vNa
         3/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MypyzVZSccI/RyC46qp75Pb6XbMOH7vgHkqe/QUNPpo=;
        b=wKaWJtNqGC4ts22UUtg7JiyBWWMUGLsYP6pqCKXLi8bdLMKS5N+3m89Lfup5t8eK/U
         Yd3hyi2I/2iZqYhg1/p8zi8X8Wl1Y9sO0CmloFi0Tn18bleQbot0MAAZambUkg27ZYRl
         4QLsUxzn+kzZYzgndW01PBvhsJ7sQWEqF6UX3WgDHLYoemm/bcWlkWFlpaTvIZb4YE2Z
         neemR0UCOx1mgm60fDsN+8Nb47P3WVB7jLUo5semKuAi5Ro2rg+98Ra+c4dRcWu26lKF
         ZWt7g407cj+gcJVI0GJ/aeMbdWegzPxs1eptRSoYXnPqw+p9GSNUd9s0MfTTqUYYx8W+
         Hbkg==
X-Gm-Message-State: AJIora9fIJamFVk0Zuqxjj0ewpLRNfP6JO+bL5+sAFIhBwhyWk6dG3w3
	wibwiFOD9XCKGyzmhL1SwoOrLX7eNC0vIXKa+A==
X-Google-Smtp-Source: AGRyM1sxwUS7zWxfuhFmDg/oyvsoaf1Wwexumse7I9VvtS1d218Qh2nHKoK4HZcdCT8xWr/B9mnpWLyMLY0auVLITw==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:21e:d672:5a6a:420e])
 (user=justinstitt job=sendgmr) by 2002:a25:bd42:0:b0:670:be21:78a5 with SMTP
 id p2-20020a25bd42000000b00670be2178a5mr460245ybm.478.1658437428335; Thu, 21
 Jul 2022 14:03:48 -0700 (PDT)
Date: Thu, 21 Jul 2022 14:03:31 -0700
Message-Id: <20220721210331.4012015-1-justinstitt@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH] drivers: iommu: fix clang -wformat warning
From: Justin Stitt <justinstitt@google.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>, Robin Murphy <robin.murphy@arm.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"

When building with Clang we encounter the following warning:
| drivers/iommu/msm_iommu.c:603:6: error: format specifies type 'unsigned
| short' but the argument has type 'int' [-Werror,-Wformat] sid);

`sid` is an int, use the proper format specifier `%x`.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Reported by Nathan here:
https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/

 drivers/iommu/msm_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 428919a474c1..6a24aa804ea3 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -599,7 +599,7 @@ static int insert_iommu_master(struct device *dev,
 
 	for (sid = 0; sid < master->num_mids; sid++)
 		if (master->mids[sid] == spec->args[0]) {
-			dev_warn(dev, "Stream ID 0x%hx repeated; ignoring\n",
+			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
 				 sid);
 			return 0;
 		}
-- 
2.37.1.359.gd136c6c3e2-goog

