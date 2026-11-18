Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020036;
	b=kj2ITWalvUi/Ob2zsIY6Pop+oUPgW6EuQfpdiUmFJzcuB3uSoTJk7r8XxpsuIZSxGrAb
	 O8KH30eBWkuaeZeNu8KB5XbslxlXjoGG9ikqSI/4z3Cf+MqTYVQPICyP/6ot9ehXDiKx1
	 hG+QW1ClPyyqCea4Sf2HGGh02ChzPaEN8/8oLNsiPtPK/spT2AoIPtu6Hw0Ehi7Sc/V7V
	 9GJPnTHMNSDCdXLTpnZjSV9hF82T17/PzIH7q+LVMg2GIDuS+gBS5/2F2c0/HGAIiqZwE
	 AjSFKeB4dOsiYRkO2imXEkLz5is+VNuE1n3prNQ2xju2ls0/1ioeGebFBTPhDXdEnbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U+JDjr70NfmoYuAwDWLUcR7/Nq7waWVnmWm8ckIRrMA=;
	b=239Zhlz4Y0Seyim8uRtOsZXs2gT6VberW7Nb0DKaPIDUDKUXMbuNMY3HZlpxm7W1UHpE
	 VftQK6LzisYk3VaZXeG9mVqdS1Xt5yqX3fpwT0PedCFyqROhAX1eN/zPzcUg14hpaQ5U0
	 BFMrmoQomefdQaMCwBF9NGQ3uIwXJ8T+fM1gZB50v0yUF0qR8zpYdM5HsLMRANfFRFHpd
	 9HTDkxkNXOgePeUK9wneK9Ubk0PDncH7KOoprwhvoyY4dxHq+syd0+Q5CbCJlwjGm3TdH
	 HHP8qKVXyNk8KYMKsNOakJ1lknQc3gmTYD0lPNRVJCy6YcJPnED/62ydqYY4A/Rloow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vqd+PyEL;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3EE60A2601
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 16:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F3EE60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vqd+PyEL
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb609d9bf4so1660945e9.3
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795020034; x=1795624834; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U+JDjr70NfmoYuAwDWLUcR7/Nq7waWVnmWm8ckIRrMA=;
        b=vqd+PyELiPT3hAQTDPKfvO9Lh+sFfEBJZqjSuhles6o0Kx0lop6Z2ckFD7sspVzu4O
         Cqoyhdjm8ATtHBS+GP4hUy6irTPlqA2NMVaNboHntV+CCHTg0unBR5cCQtf+VrkxuklJ
         n97u9f2aj21VsLvMP56M0ctVcI3C9oAppznQwqIJx3fj24z9bZcaLu99Ph4Sm3eCAyo5
         KdUi8iU0kWq+8v785AfVWCrRfai5K63DTDX1lP8RxYXh+nDWVZWwHIRGqndpgb4AId64
         9gxmqspYx1PJsytrrjvIAaPpPfL13BQ3epQmcFlLEPpuezBJnXOwU9T/zG5Uzcx0T3Xy
         BvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795020034; x=1795624834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+JDjr70NfmoYuAwDWLUcR7/Nq7waWVnmWm8ckIRrMA=;
        b=YuPpJR6FwwoRAzjyAXwIWEBx/xrUTxY6R6uQq8TLrNWU/V37fCVALprKKM0bAFeFDh
         K44p/rju8K49s0owaQSUcDJCVjYBQ7A2JLROEy7fRxl6BqC8IMk5wtKeKjLw6gS+hCa6
         IfjpVP/TAC4kHMST1BpcecngCffAJReFp4l7+zVOOc1ec49rb5qe88Y5kF8mnvaVZCE1
         qveVX76Bn2wu2jtvnYEnXICJchRUEAIxF0kjuteH6adTYXui6Q/MS4Ist2i7LqyPW0RX
         /dfM2MQU8pLb1rVIMoIHOSqR/er65zQywljXcnelTEBJcmDhDP5Eczjrsos856JndG6I
         Z+rg==
X-Forwarded-Encrypted: i=1; AL+hErEAP86rjN8i8/P4VRlif9EJJDOJVIppNoLJUXqTTpfYjRdAUtegjO2eUskCGWH18xQuuiHSzA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8AAZ2MpvUpbcskSkJjBzWdjiT49mJzVAUqxFFnUQ9FxtgWiXDj
	qg/J8Vm2iWeAouY1y85FhBo6yM77D7G0+Sh7EzNfOqjJlqeEicseUBuG
X-Gm-Gg: AYBFou3TLYFEArKGjbHvn2icCfj/vBxu+Zx4kkBRS7yfcjlYYVuTotLZcperiRFZKxP
	o0hjOfKklnyTMQ+8MKHZMG/JdgHCneb3PJ6jZttXUIHaU3x9iRgRBVLrMKYLtvKIAq0SG/1JrIm
	jO687fMESrf8v5GeKnZOri6tRAurk0UIXvz3DTKT1EBxIj56jw165l3y6/bk3my9hKqI1P4NlXb
	DuePMzr6JhXQU3uvBlfkyKGX3493kcpYh1fsemlGtv3DzZthygKNdgqrxd+LINGbWFU8P3k1jcQ
	qkHeWyn89noAeJ9XBQt3UqsTT4K9Kx3J4RwTDhMTl4R8FcjG8ootKCRhs7iwSt+ugKzEAxZAqxi
	RqTregtZCJPj47Tt3SfoB5UPUfFaEnZ9NbtzDwsOJgtzn1RXaD6JMirVYshHRZqANTQ7nv/7zG2
	h1W16vueGFEyM8Bj694ddOxk7rD4erwe1JXGgyy2oBmJMjRJXNOlTA1P+1pmDFtyToUXzNq2sZb
	ucP0cabIcOu3SNz9vzO+XcK7qAoOKa+rT/hrQTTnnCex5psfHEGPGgFW9Yno/UbFmE7PpTMqVKM
	4P+v3J8sRbh/qdrN5uMOLXhtGUK3apH0QKzLtsk2XT2POnYU8488YtTSKFuykPxElKvvn61IIXu
	x0FxgyGU9LUWij61T
X-Received: by 2002:a05:600c:8012:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4bb7d7167d1mr54707545e9.1.1795020033418;
        Wed, 18 Nov 2026 08:40:33 -0800 (PST)
Received: from localhost.localdomain ([191.40.25.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8325b779sm623115e9.9.2026.11.18.08.40.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 08:40:32 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd: Unmap the failing batch before releasing its pins
Date: Thu, 19 Nov 2026 00:40:26 +0800
Message-ID: <20261118164026.54455-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iopt_area_fill_domains() maps the PFNs of one batch into every domain
and only then moves on to the next batch. If batch_to_domain() fails
for one domain after an earlier domain has already installed the batch,
the unwind path calls pfn_reader_release_pins() at the top of
out_unmap. That unpins the pages of the failing batch while the
domains that did install it still translate those IOVAs, and only the
loop below removes those mappings. For the duration of that loop a
device can DMA to a page that is no longer pinned, so it can be freed
and reused while the translation remains live.

The release also cannot simply be delayed to pfn_reader_destroy():
the last domain in the unwind loop is the only one that unpins, and
the unpin ends in update_unpinned(). When an earlier batch was fully
installed before the failure, pages->npinned still counts the pins
the reader holds, while pages->last_npinned still has its pre-fill
value, so update_unpinned() warns about npinned being above
last_npinned.

Release the pins inside the else branch of the last domain instead,
right before iopt_area_unfill_partial_domain(). No domain maps the
failing batch by then: the earlier domains were just unmapped by this
loop, the failing domain rolled back its partial mapping in
batch_to_domain(), and the later domains never installed the batch.
The release also precedes the last domain's unpin and its
update_unpinned(), so the pin accounting stays consistent. The
single-domain variant iopt_area_fill_domain() already unwinds in this
order.

Fixes: 8d160cd4d506 ("iommufd: Algorithms for PFN storage")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 2f6153108add..a99f4efbffd9 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1962,7 +1962,6 @@
 	return 0;
 
 out_unmap:
-	pfn_reader_release_pins(&pfns);
 	xa_for_each(&area->iopt->domains, unmap_index, domain) {
 		unsigned long end_index;
 
@@ -1982,6 +1981,18 @@
 					area, domain, iopt_area_index(area),
 					end_index - 1);
 		} else {
+			/*
+			 * The last domain is the only one that unpins, so the
+			 * reader's pins must be released before the unpin and
+			 * its update_unpinned(): npinned still counts them
+			 * while last_npinned predates the fill. No domain maps
+			 * the failing batch any more: the earlier domains
+			 * were just unmapped by this loop, the failing domain
+			 * rolled back its partial mapping in
+			 * batch_to_domain(), and the later domains never
+			 * installed it.
+			 */
+			pfn_reader_release_pins(&pfns);
 			iopt_area_unfill_partial_domain(area, pages, domain,
 							end_index);
 		}
-- 
2.54.0 (Apple Git-157)
