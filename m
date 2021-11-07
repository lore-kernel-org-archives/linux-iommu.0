Return-Path: <SRS0=5Ucf=P3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72244C433EF
	for <iommu@archiver.kernel.org>; Mon,  8 Nov 2021 03:08:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F069061242
	for <iommu@archiver.kernel.org>; Mon,  8 Nov 2021 03:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F069061242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8874540260;
	Mon,  8 Nov 2021 03:08:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NYfp2EpebwLm; Mon,  8 Nov 2021 03:08:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 45676400CD;
	Mon,  8 Nov 2021 03:08:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A918C0019;
	Mon,  8 Nov 2021 03:08:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3369BC000E
 for <iommu@lists.linux-foundation.org>; Sun,  7 Nov 2021 22:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 222C740256
 for <iommu@lists.linux-foundation.org>; Sun,  7 Nov 2021 22:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BD60Jb2im2DE for <iommu@lists.linux-foundation.org>;
 Sun,  7 Nov 2021 22:53:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E080A40255
 for <iommu@lists.linux-foundation.org>; Sun,  7 Nov 2021 22:53:38 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 b5-20020a9d60c5000000b0055c6349ff22so12047669otk.13
 for <iommu@lists.linux-foundation.org>; Sun, 07 Nov 2021 14:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :content-transfer-encoding;
 bh=jm4HkC4WuEFuj0T0GbogyNYTH9ILCYVGsH89yM0+sVY=;
 b=un0ROogmycQPFx5MqbulloXygKairZ+6ICrLoIPL2vYLlsh789nazo6Hsv2mzEp9si
 KxsA2GvDQwJ1CyowwYEETVMYITQwhBWuAm3qQK4mf1aJAaNttM9T7LG0qRfer46RBS73
 4agnUB02PckB5CFsfjvJFJbR34Uuy1nZK8Pqn/daNB8SX5IJA/LGNmzDxi4IMbeDlyiK
 TECXtEA50ld1oexOL7TBN9Rkd/sqAN3UJjwQPu1x4ILChGrpIuyJicdLF0ScWXMNEW+v
 taJxAHI4D5Aw0ZUbUtiFlVenJMm3qLYvN3Q9ImTAHcDBa2oDSkdy0pWNwOOGrtIghQM+
 BDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=jm4HkC4WuEFuj0T0GbogyNYTH9ILCYVGsH89yM0+sVY=;
 b=6oFltVVExmJpkx5+Z3YH/VFuPWPCuCdNDqyjCExKEkB6WldwSszwtawV8VGrKpFKfX
 x5707y8lgyxy8i+vwzfgrGlsb9M0zruCsTK55YKUCiwwnjVVklfKWP16gch+4J4y3OGA
 7GXjGJXB2bEE8KJF06eitENxL+Rp4EHIe6+sg+PKmWkhIQtRK4SpKIfRhjgG8dxArWiG
 wRQvh+eFsRvb4iVBN7sbfjd8BlzoKsLeksztP/NhatVl0EkjlhfFQbDUwDoCWcsqK6Vm
 Q0yX44eKzZgUs7xcwmKKVumGxHg4mXD7djEFry6w0MtrfZWONUo3gpzkUaKHAKWBItWL
 InAw==
X-Gm-Message-State: AOAM530/xKCVVPSIIwlZl//BlvETDM5jqbWMwih0k2duOo5aEYVYUrbG
 jK5JUPPDssgA78ePRwvQzw9hlA==
X-Google-Smtp-Source: ABdhPJysbhbn4/+ndMMNZXqbf3gQjWDNDbQttUiUK/XLCQDWvKwg4RdzkreaUtPvwYgM+hv/FRLoRw==
X-Received: by 2002:a9d:2f42:: with SMTP id h60mr10652072otb.159.1636325617800; 
 Sun, 07 Nov 2021 14:53:37 -0800 (PST)
Received: from fedora ([187.64.134.142])
 by smtp.gmail.com with ESMTPSA id r22sm1841169oij.36.2021.11.07.14.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Nov 2021 14:53:37 -0800 (PST)
Date: Sun, 7 Nov 2021 19:53:32 -0300
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 will@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Subject: [PATCH] iommu/vt-d: Remove unused dma_to_mm_pfn function
Message-ID: <YYhY7GqlrcTZlzuA@fedora>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 08 Nov 2021 03:08:11 +0000
Cc: iommu@lists.linux-foundation.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org
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
From: =?iso-8859-1?Q?Ma=EDra?= Canal via iommu
 <iommu@lists.linux-foundation.org>
Reply-To: =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Remove dma_to_buf_pfn function, which is not used in the codebase.

This was pointed by clang with the following warning:

drivers/iommu/intel/iommu.c:136:29: warning: unused function
'dma_to_mm_pfn' [-Wunused-function]
static inline unsigned long dma_to_mm_pfn(unsigned long dma_pfn)
                            ^

Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>
---
 drivers/iommu/intel/iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0bde0c8b4126..35300b5b69f7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -133,11 +133,6 @@ static inline unsigned long lvl_to_nr_pages(unsigned i=
nt lvl)
 =

 /* VT-d pages must always be _smaller_ than MM pages. Otherwise things
    are never going to work. */
-static inline unsigned long dma_to_mm_pfn(unsigned long dma_pfn)
-{
-	return dma_pfn >> (PAGE_SHIFT - VTD_PAGE_SHIFT);
-}
-
 static inline unsigned long mm_to_dma_pfn(unsigned long mm_pfn)
 {
 	return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
-- =

2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
