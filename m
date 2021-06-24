Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5448BC49EA5
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 17:18:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A28B613EE
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 17:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A28B613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFBE583E2F;
	Thu, 24 Jun 2021 17:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sJRWpRwfVk3l; Thu, 24 Jun 2021 17:18:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9498883E2D;
	Thu, 24 Jun 2021 17:18:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E984C001A;
	Thu, 24 Jun 2021 17:18:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32CA2C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 17:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17E66400AC
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 17:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tHKbZiuGD_Nx for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 17:18:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F25841632
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 17:18:27 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id k6so5726636pfk.12
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 10:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IsTJoDNngEMlkAn/n6JPF2A0qmwgdP70DkZ0WXOjNOY=;
 b=YxZMzszw+nsXLPhGNhV2myye4gK/wRHBlmjreXJlWAVzJm0ZFytYlX9Rhu7tXDdANy
 XP1z9XjdXqim9N+/fnHAr0XwqqNu+9bp2809pZLHqN7ql8Lr5NEoIcZuY3dcG8iAoXf+
 A/rp72coTwhCjbCFAAXwSsCuz5cEkE50kotnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IsTJoDNngEMlkAn/n6JPF2A0qmwgdP70DkZ0WXOjNOY=;
 b=aOWspEQgEpV3iQw0Q7X0Nrk74UjBQAjtObRGjIPjPbQOfDkVB7ttvbdgAB1xcRXD2O
 AdmDjpYfqfAElpTynvgZxonZP72APxwA5V6lj+fnrVzVv1ZksZUalWgAfN6YKsfRgeCv
 WAENkY2guv+fwSy3eNDCSPnU836R/aH9IIoEhUfKlLij0hQGnkrnJmWFvvWdw8Rw3Y0B
 9/l7zCWe8Pzj/b17XBENxZgHinDLIpcmiFEpdxfQlkZYaNdS53UDFRwC+ik/X0eQ1H4x
 rsdylciuWQ+sKLpDNKnvlV0eLpHlZPhpZDUFXmU8QFr33WInKKYz84KWj6bjdWpbSaNi
 WyCQ==
X-Gm-Message-State: AOAM532+GnCVLhhDsnuocMz82VbGdkFyKWXsqSzyeEja5ZC1oFHL4XNU
 9hQIFtWqq5WODrOLy5mtJ1Yf6g==
X-Google-Smtp-Source: ABdhPJwajpWmjQoylie1eDc67SDX5JHn0tkLIkBmw0/8N+zayKuUy7HrB9/qTrgy2P3lRFk7RypkmA==
X-Received: by 2002:a63:ee11:: with SMTP id e17mr5579673pgi.323.1624555106903; 
 Thu, 24 Jun 2021 10:18:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:201:fd74:62bc:19e3:a43b])
 by smtp.gmail.com with ESMTPSA id z9sm3365960pfa.2.2021.06.24.10.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 10:18:26 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
 adrian.hunter@intel.com, bhelgaas@google.com
Subject: [PATCH v2 1/3] iommu: Add per-domain strictness and combine with the
 global default
Date: Thu, 24 Jun 2021 10:17:57 -0700
Message-Id: <20210624101557.v2.1.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210624171759.4125094-1-dianders@chromium.org>
References: <20210624171759.4125094-1-dianders@chromium.org>
MIME-Version: 1.0
Cc: linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 joel@joelfernandes.org, rajatja@google.com, robdclark@chromium.org,
 saravanak@google.com, Jonathan Corbet <corbet@lwn.net>,
 quic_c_gdjako@quicinc.com, linux-pci@vger.kernel.org, vbadigan@codeaurora.org,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-arm-msm@vger.kernel.org,
 sonnyrao@chromium.org, Vlastimil Babka <vbabka@suse.cz>,
 Randy Dunlap <rdunlap@infradead.org>, linux-mmc@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Strictness has the semantic of being a per-domain property. This is
why iommu_get_dma_strict() takes a "struct iommu_domain" as a
parameter. Let's add knowledge to the "struct iommu_domain" so we can
know whether we'd like each domain to be strict.

In this patch nothing sets the per-domain strictness, it just paves
the way for future patches to do so.

Prior to this patch we could only affect strictness at a global
level. We'll still honor the global strictness level if it has been
explicitly set and it's stricter than the one requested per-domain.

NOTE: it's even more obvious that iommu_set_dma_strict() and
iommu_get_dma_strict() are non-symmetric after this change. However,
they have always been asymmetric by design [0].

The function iommu_get_dma_strict() should now make it super obvious
where strictness comes from and who overides who. Though the function
changed a bunch to make the logic clearer, the only two new rules
should be:
* Devices can force strictness for themselves, overriding the cmdline
  "iommu.strict=0" or a call to iommu_set_dma_strict(false)).
* Devices can request non-strictness for themselves, assuming there
  was no cmdline "iommu.strict=1" or a call to
  iommu_set_dma_strict(true).

[0] https://lore.kernel.org/r/a023af85-5060-0a3c-4648-b00f8b8c0430@arm.com/

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch clearly will cause conflicts if John Garry's patches [1]
land before it. It shouldn't be too hard to rebase,
though. Essentially with John's patches it'll be impossible for what's
called `cmdline_dma_strict` in my patch to be "default". It'll
probably make sense to rearrange the logic/names a bit though just to
make things clearer.

[1] https://lore.kernel.org/r/1624016058-189713-1-git-send-email-john.garry@huawei.com/

Changes in v2:
- No longer based on changes adding strictness to "struct device"
- Updated kernel-parameters docs.

 .../admin-guide/kernel-parameters.txt         |  5 ++-
 drivers/iommu/iommu.c                         | 43 +++++++++++++++----
 include/linux/iommu.h                         |  7 +++
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..7675fd79f9a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1995,9 +1995,12 @@
 			  throughput at the cost of reduced device isolation.
 			  Will fall back to strict mode if not supported by
 			  the relevant IOMMU driver.
-			1 - Strict mode (default).
+			1 - Strict mode.
 			  DMA unmap operations invalidate IOMMU hardware TLBs
 			  synchronously.
+			NOTE: if "iommu.strict" is not specified in the command
+			line then it's up to the system to try to determine the
+			proper strictness.
 
 	iommu.passthrough=
 			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df5..7943d2105b2f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,7 +29,8 @@ static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
 static unsigned int iommu_def_domain_type __read_mostly;
-static bool iommu_dma_strict __read_mostly = true;
+static enum iommu_strictness cmdline_dma_strict __read_mostly;
+static enum iommu_strictness driver_dma_strict __read_mostly;
 static u32 iommu_cmd_line __read_mostly;
 
 struct iommu_group {
@@ -69,7 +70,6 @@ static const char * const iommu_group_resv_type_string[] = {
 };
 
 #define IOMMU_CMD_LINE_DMA_API		BIT(0)
-#define IOMMU_CMD_LINE_STRICT		BIT(1)
 
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
@@ -334,27 +334,52 @@ static int __init iommu_set_def_domain_type(char *str)
 }
 early_param("iommu.passthrough", iommu_set_def_domain_type);
 
+static inline enum iommu_strictness bool_to_strictness(bool strict)
+{
+	return strict ? IOMMU_STRICT : IOMMU_NOT_STRICT;
+}
+
 static int __init iommu_dma_setup(char *str)
 {
-	int ret = kstrtobool(str, &iommu_dma_strict);
+	bool strict;
+	int ret = kstrtobool(str, &strict);
 
 	if (!ret)
-		iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
+		cmdline_dma_strict = bool_to_strictness(strict);
 	return ret;
 }
 early_param("iommu.strict", iommu_dma_setup);
 
 void iommu_set_dma_strict(bool strict)
 {
-	if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
-		iommu_dma_strict = strict;
+	/*
+	 * Valid transitions:
+	 * - DEFAULT -> NON_STRICT
+	 * - DEFAULT -> STRICT
+	 * - NON_STRICT -> STRICT
+	 *
+	 * Everything else is ignored.
+	 */
+	if (driver_dma_strict != IOMMU_STRICT)
+		driver_dma_strict = bool_to_strictness(strict);
 }
 
 bool iommu_get_dma_strict(struct iommu_domain *domain)
 {
-	/* only allow lazy flushing for DMA domains */
-	if (domain->type == IOMMU_DOMAIN_DMA)
-		return iommu_dma_strict;
+	/* Non-DMA domains or anyone forcing it to strict makes it strict */
+	if (domain->type != IOMMU_DOMAIN_DMA ||
+	    cmdline_dma_strict == IOMMU_STRICT ||
+	    driver_dma_strict == IOMMU_STRICT ||
+	    domain->strictness == IOMMU_STRICT)
+		return true;
+
+	/* Anyone requesting non-strict (if no forces) makes it non-strict */
+	if (cmdline_dma_strict == IOMMU_NOT_STRICT ||
+	    driver_dma_strict == IOMMU_NOT_STRICT ||
+	    domain->strictness == IOMMU_NOT_STRICT)
+		return false;
+
+	/* Nobody said anything, so it's strict by default */
 	return true;
 }
 EXPORT_SYMBOL_GPL(iommu_get_dma_strict);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..2e172059c931 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -79,8 +79,15 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API)
 
+enum iommu_strictness {
+	IOMMU_DEFAULT_STRICTNESS = 0,	/* zero-init ends up at default */
+	IOMMU_NOT_STRICT,
+	IOMMU_STRICT,
+};
+
 struct iommu_domain {
 	unsigned type;
+	enum iommu_strictness strictness;
 	const struct iommu_ops *ops;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	iommu_fault_handler_t handler;
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
