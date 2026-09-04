Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4E48094F
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523863; cv=none; b=QfGOZWeIXEm6oQXSbLLRn6/zp6tRDq+QT4XOXZ6NJGY/PUFvGDuRBcqc6U95IILTVaHfkdHDI95XLtcIybNTJp/8vDOhEjOXH/ZkROe5DkSKILm+yXkIxAHJvp3tMnu5/d7/0Nh2iwOMJMWSXwW8qMBJLjGF9N6UgyU1wX+1URU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523863; c=relaxed/simple;
	bh=Pq3cl7yQ2QNaCZJt/nNrvJhW6CeSfRnWOXTi3RilZFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrRlkn6Ss2eBObsHz1pMV20/xcH5dNA+ZkpbyduZd7ruSNBBSiJS2y5jc/iPoPcLkCa670rotQL5NlIMxhq5yaCN9qS+bYYwf6mYoLcG6EpRid0Yd27WB4yMacUTUMxb1ahjVriw02PDN0yDx0PMRdJpC0kFBZ/jSzmU4yMvEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQED4JE7; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQED4JE7"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b145a9623fso401189eaf.3
        for <iommu@lists.linux.dev>; Fri, 04 Sep 2026 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523860; x=1789128660; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hRdr8GJ/+SsuQYeXKm29acq0jkmVX3isHirCcw8TxR0=;
        b=IQED4JE7FVMFu+Fny3qQcS3Xl/SbBmy/oCgTkWgdfQ4zfRA4TUvNMyJcIgPa+IOOFh
         8FA/mtgyfNEdWXwdEmpms8LJQnB+cS9omGday536kGNCZgE3AQQ/SDXYOmgt7XNNPb5B
         qTHmr5qHowIJcFscv0DSqqdBPcluiU5i0SUpQVWfXuucGQBSzEgitzJ8gE32F3Wj/nap
         3cvV8xWKCIpQcNqvL2cj9UX3vzP2jjG8xfyj4LfMhX2B0x36Kfs5bik+Zj5aY8IG84v8
         Gkt1xSHEJRJ72turD5TCRTVnHzXzG79dwmuG2QikWwBG9mnHbvA4TiuXQtnEPmYrVicj
         Y83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523860; x=1789128660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hRdr8GJ/+SsuQYeXKm29acq0jkmVX3isHirCcw8TxR0=;
        b=WjBGZHddbGc4cz2yB+/MhrT/5X97ao7hwt9tGgUtliQb6qrRgqylxbdyCQed1hLCs+
         YxJ5al2fs8ZAHGyfnaIFoAKamYr1v0d7oEuBWkbCyRzpak5h53B/csuBrqQuITs7yGJe
         awEuic5A3T1me3atPMuupNytQu440iwwdt6FaMFcLp6Stnmgp+CDHKXLDLRKEYga9N74
         FXXJBxZs/6ho/A1ia1iAMslX6QbGudfw7qbg3BFW2D65nRtk7YFnVJI7vFbzOPR8GlQC
         Dy1D7zYsbrsUYIaCN9J6Uvj+ApNxuqCdGxweSrUOIvicHhRTyfXzGxr9hIwX41AFcnCB
         V8AA==
X-Forwarded-Encrypted: i=1; AKwUvBzat9RE8EVq7vBym1shINiFW501haaKn4WS6DWGTqivWnsIg9/hiY5T0MWhkYTBNg7FFQY2VQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lJh5cD83kUYRLMXYhpPaiN0+h6RwoBGvn3WXqRkCSySd1h0pf6
	b89roDjOjvj6KUj9hdd8tOC00cjFMg431/c3kgv3Zok6KRkN1KzTMrpR
X-Gm-Gg: AYBFou0J3VFkJq3TEFSubLB8Fnd/vlAhmg8Fc4e+rdwm8+lykCgOxJ2pxSeTvnsVDAc
	twqEslp48TpWiaTnrIoH7Bv+XDQLOYi1hDf1+gCC3x8FoN3gsyEXQXdEQ2krinlLqGATgpmS1T3
	3wH38ZHRkc/KjrkMMOehrE752kEPdrTdhGhNisX+9P6HPznN3w3YzJRmrmHIris00FB0GjZiDw4
	27HYhlSwA0At2DbGAOmLSMwOdzALhTVSiorOuuSD4iW+TKJr+7hiJueeCU1HO8qfWJtALBTahr+
	DdYL/6VV/7S8fwt11tg1oe/Cy5pR92Jcyoja9soggEIfSKDAOw2QD7+L4x8hoGWCYfecOlS1IaG
	olqs83qrG1yyImHuCfj/ib2NIYP4SwEElEI6uvuzT2vNekNx7zH0tzALso30epWU9W75YQaZJ7n
	FwGnBKycbU5PSQNqOkmMbAiuB1qB66QK41gv4gCjWvQRCT3qSDcChe9x632IstlQ6yUs7VMpASV
	jW4r0nMqOtog2Bu0i01pAuxwXI=
X-Received: by 2002:a4a:ee1a:0:b0:6b1:4b76:1c18 with SMTP id 006d021491bc7-6b6fd7d85d4mr3858206eaf.24.1788523860068;
        Fri, 04 Sep 2026 05:11:00 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm6461237eec.13.2026.09.04.05.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:10:59 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH 2/2] iommu: fix repeated word 'have' in comment
Date: Fri,  4 Sep 2026 17:40:44 +0530
Message-ID: <20260904121047.21701-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904121047.21701-1-hemanth.selam@gmail.com>
References: <20260904121047.21701-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'have', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/iommu/iommu-pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
index 3bab175d8557..0c469b9dd185 100644
--- a/drivers/iommu/iommu-pages.c
+++ b/drivers/iommu/iommu-pages.c
@@ -104,7 +104,7 @@ static void __iommu_free_desc(struct ioptdesc *iopt)
  * iommu_free_pages - free pages
  * @virt: virtual address of the page to be freed.
  *
- * The page must have have been allocated by iommu_alloc_pages_node_sz()
+ * The page must have been allocated by iommu_alloc_pages_node_sz()
  */
 void iommu_free_pages(void *virt)
 {
-- 
2.48.1

