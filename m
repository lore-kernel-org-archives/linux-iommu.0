Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429F24BD1A
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299045; cv=none; b=Y0mtjuWC3M97bbJfDvNgmXq3xA+zK+tqtMfxqs8gq9/lEh2In5Pin04Xf+fY4KoFGzcJ/vECe5bZ2lj8GZgraU1M6SReo+sGIPoHyQjtpflxMNtz5yIsksLsjzhKuq6MFStZGrsoiCx0dtg+14AY3ycWjIqRs0ueXprn7MQTpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299045; c=relaxed/simple;
	bh=dd8tAMAvunlHBs2TbfV6XdzIsVPgnLl/i4lwLZiiVVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ss6uREHt2oKhmqBBZOgemvaTAClUvdbpw/ykkrllJkUq/MnwGxsYRrUK42Ehi3VyWMJzB0ICYOG4uXgWtS8on/udNVqO+VuXVzogbddKWLeJMjiB7VQxDavEkUrPGw/YeVwVtNqzbaRfolPdDYRvQ8O+Kt0R992ipAcaEQXEWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Voq32GSQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Voq32GSQ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-634beb1a884so1055511a12.3
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 23:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759299042; x=1759903842; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96lBuGyGNqGdmWvV/PJjpenC1fPHuudOMddkc9JukfQ=;
        b=Voq32GSQegn6AJFufMy0Zy0AkhcfbVNHNkBFeubdgDCkDXi5heNCf3vhFsPUiY1S8S
         Go6DB5E/RMQ9zIfqDBmVNAmC/4wYjaxxKqg03LnoKmgNDYk81vCeb8KvqHAZEqPcrpIo
         Y6LgYAlXe0iLJLTqYgS+LQot+2Rif4WPOq78Ab5I92tE2pCzokJKu42YPLbf7xib3r5d
         /qM59R4Z1f7rKJHQHipbMNu5CaHXc/KyWQ3cEVgHH/dhzdqXM3tjFkrCtz4hny56WO70
         u0Du8s1jIil17lDFqj085H2ETKho459rCTQoCiW+BW1X+L+HuHiEF3mkMpVOPzZZCVsv
         JXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299042; x=1759903842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96lBuGyGNqGdmWvV/PJjpenC1fPHuudOMddkc9JukfQ=;
        b=O+JwQ7hjAksG5CSPIFLi/VzX3t0WM6usmeRTFXyGDcIO0Ep655ggd12JKQiueJ9mmF
         mJAh3ylhWGCRahlGy/sEG3nmWhgsQY6u43yu/q0wa1rcy5tun5NhrRzfSS2bCeHd5q1j
         os6t8d5OZnRQds8lDFxDF9PXv3gkcQC4UPRnKnURoIUpWom8zZ2Ry99ozXGSL8fUZKE5
         oShxtwfSrmbBPisXcRKn8ue7kh4YLs/uJOxMyQCuKFnOVj+NrTT+BHEqQvD0joFMBAIy
         O5IvHYVXQktdHn3k85MV2iflqVlwO7ah4Dpq8BDdH8vHg4Hr9eCMl759B+WwRph/mktS
         0sbw==
X-Forwarded-Encrypted: i=1; AJvYcCUW8eue2bYRy4dNJsxFzgY3VMTN/RE+1382e1wKpcfpHFBqeC+88tfQB80W1UDHyFG+Okq5jA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo0qLqeGTDuuuXoip5jdbBL41PErAJUeDSehpc3Tx92O4YNhv2
	b0at2Xb0e7HFXTgymNp422uQ8me3IMByV29whbTNTohXGFh3HH1eFp/5hcJ34Lw5Uxo=
X-Gm-Gg: ASbGncverDd2WNWi2QQ59DATXytpzOnnADAoYE2rCGvapbbcWNvWgHziBhPPxHRmvMy
	JXSCqgnujdNKjLZPX0Lhw7K67EhYSgbIvYheiO+6d6VEEsrXWb7klHZDMTpA/iJ1+anPmRNp4xG
	C6kR0LAcnePcJ1hylm5cQ+1NDQtcdWESj1szXxFOyLfAnLV9tBNO1omq5OTdkTvdKoBfBWj11iL
	FnXQZra1sjbDHg6CEfFwxmkI1dGuhoX4lktd5gYvHLIQIcqn5qn4wZxVCaRWmkroJYPtXQDKcKv
	UlEDJJOt4LHlJMdkv7iQ6emWlG6uLQ+ksahQwhN6H8u/W0TeewLKiYIW2rHmdMCkoepWNS4h8kC
	EHh+oye9qCcPbWsK1sdtBYk4FZ0/dstAaJP2rvMtowjOhCp/WSona/0hmP2iZ7TpCsZELrUEhgV
	HpNbcXayzTSunIzBGGsu7X4owrSrnRLQ1U2KryjQ==
X-Google-Smtp-Source: AGHT+IHt6fDP7kqpTGubIfHOuw2BR4PvD5qV97YMPv7HNHGrcP6MVN59nJX/Qk5316ImtAkfWPzuaQ==
X-Received: by 2002:a17:907:868a:b0:b41:1160:a3ef with SMTP id a640c23a62f3a-b46eb7aa04cmr150622166b.10.1759299041854;
        Tue, 30 Sep 2025 23:10:41 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b353efa46b2sm1288658966b.24.2025.09.30.23.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:10:41 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] dma-mapping: fix direction in dma_alloc direction traces
Date: Wed,  1 Oct 2025 08:10:28 +0200
Message-ID: <20251001061028.412258-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set __entry->dir to the actual "dir" parameter of all trace events
in dma_alloc_class. This struct member was left uninitialized by
mistake.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")
---
 include/trace/events/dma.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index d8ddc27b6a7c8..945fcbaae77e9 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -134,6 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
 		__entry->dma_addr = dma_addr;
 		__entry->size = size;
 		__entry->flags = flags;
+		__entry->dir = dir;
 		__entry->attrs = attrs;
 	),
 
-- 
2.51.0

