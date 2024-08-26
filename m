Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB4C12DD88
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656616; cv=none; b=gOFsutBJxN1P8jLfRiV3ptfsnr3luHW1ni5lWcMBjrOehJ0aGFe+W1QYY8h0QPLFQ+nHzwkK85vC4ZGDc+o8QLupToU/JUa0/DlJj6WsKQWdSxA8+gJvAMtxtScVu57V7enu79ZyI4ikats/E2owXNn+WOdzPZukRlt7gNnp2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656616; c=relaxed/simple;
	bh=HP374hzQKt1PoMnLVLHbgO5xbnjTW90EAECCpEBd9MY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NbTOzOqYdvqFAXxSNAZ1q0QrxnZB0lzSEDdEB9HwQkmM3V9ZrXdRJxfesvgc/t6YdNVFR6LuPlb5WMau5kWtfBrXhCbTd93CVn9CTVKF/K1J2bpntaai/K1gLkGnPmndrBl6Vmta83hKSA31lWthpM437AwBD4Wnw1k2l3Bk7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yO8ZpADO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yO8ZpADO"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03623b24ddso7143417276.1
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 00:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724656614; x=1725261414; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIcgUoBTp9GuGTx+59sM7fDXSn2WoTkdtpOjFEdC9AM=;
        b=yO8ZpADO6UeR/Pc6XmnHxgRZ5NvQLgh7qVj2zwi3Zo+BcT5GdLhTZcqtdVA1QF2cJU
         vRRoRDjEAM2f5EUpj1LEQw+OZ9Dbh4rJNwpE7ACrD70KKfqbrrzLGEZ8RcajglUWOQoD
         /eMCjSr9jZFqrXKWnPikfjVX5MsQxGKg7BMOAINO9I8mZ+HRbz/9kWjH7Lt/rAM/qefL
         aPYjB6Du1JL5WQ1DKdm+U50WyXvPZD1w84TjmCR3tVMnedIg4K5Bzb8dttLZDTFB9USz
         G2TIEqYSO3Zyne3FRjn11jdb88OFTU1aVXOEX/N7jm/j6wD7zyMZZPUfOx8MgW223TU/
         RTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724656614; x=1725261414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIcgUoBTp9GuGTx+59sM7fDXSn2WoTkdtpOjFEdC9AM=;
        b=WX9dJRZoqJbINAJmDwHiOOXKGR6hgPMU22h5QdV5HB+LYkQUwabLEEa3yDJ7wLkkIO
         maH3NmvJiAoJx26CdK8oKELjwJdT5yOyzUchdguzebw9nEzXiz1LBSTLzkZ8liQjHuqS
         BZWSrze2WW6CXK1NoQaEPp4f9nKtXPBuK1LfqzMhNp1c+0CcPgeUqDa8bsU214c0F0k4
         hXr0nFCNSgnsAOlMwUYQajtLK4HXhtV/aLqIC9mBZQ3Ns/0NYEX3BHtaRzT6WagTDyEM
         Qnqgx1TBBQUWF+sUsRPNddcw7hgJ/YHTgMp7dnrN67YbcrtAQ2END0JCD5igvjSaR4/7
         Jwnw==
X-Forwarded-Encrypted: i=1; AJvYcCUJrPjjhaeMeD/VQfGyjcs2ItrvnWk2iur8m5Rl29aV/06xbZjO+TiwlHyrFAsEUDie3kWKsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YycQND1Wgo6U4djCaiMsZ0aPtSl430pR/hvr6jPpVf1PblIPo4F
	zS8u/qMl9qgqOJFHhH06xogtHv36sTeIPocFQ3a7GBEZM7W08N0vc7btMoKzZxlpOJKKAiyCDbY
	06jlYnQ2JJ8nKVFbj5w==
X-Google-Smtp-Source: AGHT+IHrlol7Anpnd920uxfnTbedTgfOoLRdg3g5Rtafipisfy+CH2cN56NbbUf6MkXF303FuBbETzycPNKV+61W
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a25:ad5d:0:b0:e16:50d2:3d36 with SMTP
 id 3f1490d57ef6-e17a86208demr247806276.7.1724656613663; Mon, 26 Aug 2024
 00:16:53 -0700 (PDT)
Date: Mon, 26 Aug 2024 07:16:38 +0000
In-Reply-To: <20240826071641.2691374-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240826071641.2691374-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826071641.2691374-2-manojvishy@google.com>
Subject: [PATCH v1 1/4] iommu: Add IOMMU_SYS_CACHE flag for system cache control
From: Manoj Vishwanathan <manojvishy@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>, 
	linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Dillow <dillow@google.com>, Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

This flag indicates whether the associated page should be cached in the
system's cache hierarchy.

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 include/linux/iommu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 04cbdae0052e..ca895c83c24f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -31,6 +31,12 @@
  */
 #define IOMMU_PRIV	(1 << 5)
 
+/*
+ * Flag to indicate whether the associated page should be cached in the
+ * system's cache hierarchy.
+ */
+#define IOMMU_SYS_CACHE (1 << 6)
+
 struct iommu_ops;
 struct iommu_group;
 struct bus_type;
-- 
2.46.0.295.g3b9ea8a38a-goog

