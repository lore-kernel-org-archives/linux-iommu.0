Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDFCC4320E
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 06:06:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB442610FF
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 06:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB442610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8807980E37;
	Wed, 18 Aug 2021 06:06:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WE3evUG1qJhB; Wed, 18 Aug 2021 06:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2791B80D65;
	Wed, 18 Aug 2021 06:06:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0830C0010;
	Wed, 18 Aug 2021 06:06:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9A12C000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 06:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85C0A402AC
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 06:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bOTsKPSH5em6 for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 06:05:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 903B04028A
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 06:05:58 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id g14so1064252pfm.1
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c3QYmodiWkXXXHnLZdw/pUaRbLmOUogtqxubemJOUWA=;
 b=USSHyqJVpQWy8ZMzwl4EbGadTiH3HWAD5GKcye1LyreXSczSehLAnTCXNNAfVEOX6u
 dbx790aQ5KW7gPDgQoMYSPQsAV043/8VAoFfABDnVXFQLnG8rP3OolrjSWEo9TPmmYPs
 NckpHz6JjgIw87sGZSzScnstmZ3DWQOuxHRNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c3QYmodiWkXXXHnLZdw/pUaRbLmOUogtqxubemJOUWA=;
 b=kUx9VoQl+zss+M1wVu+v11xVi938Dbuk7iwpU+h+Oir4DtN05+2MjoqEEFgOUYLX5t
 YjDaJKI55zDBS9hDpZIlkqineOwZwlE+05q1lskZYdh5iuXPzxpOPMpFYRqElu01mjMP
 6Df2xgMR6qpbtVCLQvgySCuJHy4DizSDQcE8tPXlfhe+MokOAPVGoO5hmxhXIR2FPPYU
 jAvTLJ/6Yj6Fz+2eXCBHmPxbeToEtCj75gZVoV8KJ50cCWnFSOjSTcIWcLqvNb/+TA2K
 AJ9aSJoUPOSvZqQIMXvPLZoedDRS5wptZv0qkgEkMdiFmOIOOl3iqrMniAxAUlDB2V3w
 5A1g==
X-Gm-Message-State: AOAM530KUepcJfmuOiF6TYbjbtzVPc+q2G3+w4aq4z8tg9oK3qy32D3b
 sxtMjsQ/ZDoqh451Yq6jvUdT5g==
X-Google-Smtp-Source: ABdhPJywRH9jCkWB+sdI8LV/t2Ou1DJCL47kcdyq5rETJ8QPkKXpqliLW+MKQDbreOWicfFnlLn7Kg==
X-Received: by 2002:a63:ef12:: with SMTP id u18mr7200850pgh.331.1629266758150; 
 Tue, 17 Aug 2021 23:05:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id c24sm5560285pgj.11.2021.08.17.23.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Aug 2021 23:05:57 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/63] iommu/amd: Use struct_group() for memcpy() region
Date: Tue, 17 Aug 2021 23:04:43 -0700
Message-Id: <20210818060533.3569517-14-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; h=from:subject;
 bh=20A/+PUHWtthTe8z3o3iWDN4Pea8VoPXFbZDABJx3xk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMgAqqlbIpZIBPs4khRtZS/Nl/a6SaswUJcEQdW
 lSBIpT+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjIAAKCRCJcvTf3G3AJjFlD/
 9d5SSKFk/Byob7i8UcCVOb7iPk8Hi2YrJmknzLO1KIxaNkvuyEARZbq6e4B+T+TPepPhntcPKBfOXP
 FzeN5FXWJBzVyGoIzNGiCPh2WjsSRI106tmAJhcdyZYmVBcyeyjdu/N1w4oKdYAk4K9v7zjJqZe47b
 FRaeQAjBKc+4h21NGRtTPZDzSgeXabFrYbQBwUnsITGiIKiRbOWCcDGh1aIZNv6BQVD4Fgpe9isZog
 0BCF6kfGofFSR3+EdUSEAaJY5GtmJoPQ5dltBc0m7OGIWYQaf0gwiedtUQd1gVD70DjbjWh3AlITFT
 Vf7P1sH6jk2mKWV2rZKVWibtUzQcLIXbdByJB+gXLflqIxjrUioE82UZxpX/cMIXbUJ+LVuXzllnFo
 8nL/lrsLyasmOQKMZ7Hfx+H9y1Qtsx4Yi9Gf/d+PO5Yq2sV2urkcsqTblr1O674nNzPnTn3PqKHyZd
 OXFfw5XKgJ15ZpYPMmqOBTwA+1lyh2ypbwGLGTnQJZurT9iDDKnxhukSUEE4UmEgYep9iej5UlVsg1
 cUbGoY51vQpCifPn0TF/vQv4ai8qMbObKYv7Xb/rqwe3jqgkYO7Xj97gKJUlXnAJ4bWiRMOFBvJI19
 zdGfqZsTlEqTMGHOWNFvVFBQcZYVfy0VfPzdZMvR916KpKjQPu9DSR2qCvyw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp;
 fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Cc: Kees Cook <keescook@chromium.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kbuild@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
 linux-wireless@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 clang-built-linux@googlegroups.com, iommu@lists.linux-foundation.org,
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>
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

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Use struct_group() in struct ivhd_entry around members ext and hidh, so
they can be referenced together. This will allow memcpy() and sizeof()
to more easily reason about sizes, improve readability, and avoid future
warnings about writing beyond the end of ext.

"pahole" shows no size nor member offset changes to struct ivhd_entry.
"objdump -d" shows no object code changes.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iommu/amd/init.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index bdcf167b4afe..70506d6175e9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -121,8 +121,10 @@ struct ivhd_entry {
 	u8 type;
 	u16 devid;
 	u8 flags;
-	u32 ext;
-	u32 hidh;
+	struct_group(ext_hid,
+		u32 ext;
+		u32 hidh;
+	);
 	u64 cid;
 	u8 uidf;
 	u8 uidl;
@@ -1377,7 +1379,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				break;
 			}
 
-			memcpy(hid, (u8 *)(&e->ext), ACPIHID_HID_LEN - 1);
+			BUILD_BUG_ON(sizeof(e->ext_hid) != ACPIHID_HID_LEN - 1);
+			memcpy(hid, &e->ext_hid, ACPIHID_HID_LEN - 1);
 			hid[ACPIHID_HID_LEN - 1] = '\0';
 
 			if (!(*hid)) {
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
