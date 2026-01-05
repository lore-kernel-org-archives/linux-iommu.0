Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591A314A70
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601395; cv=none; b=dODqFa1NRohC1mKHA8cAnCCk3P0V5LxPSGC32+1Xu0PrtTwbGxeGKSkW0IrgZymeY5dX1CQs4LC+a9Eg8Lv+/s52GdhKke90s+aJduURCE8fxUl1/hyf2d4f9KE6TMkYOdpflv3500SGPx9V8GdB0SU2xtQJrqEK8RiZoPhMR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601395; c=relaxed/simple;
	bh=3EF4beueqssYSrJr7jAiyWtRxi/ynmIi31SbgxtAbxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L+Mf2MQL1A4GTBlMGQSOYuKlbY38nAEYuDfzx9hDTzFXKF/Eh5USqSbmVOTqTtwE/wNTZOOaPLKurQBMPd6jxyV+hRgq7L5cXCXz7hWfNxPuVNh8z3bAmXnedI46f7lYqpq8ptJoNX3ufHL0ngFtP8xJJ1iPQWdPeic28Aj7eXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXScU0yU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXScU0yU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
	b=CXScU0yUsmYCDOQB5xcdy0Uho4lF1jibqQahcGQdTvyIccbDT2wuFdB11xq1JpPjGJzk/Y
	Bm9W8uHu4qIh+sUlesivb/ObpdYppppXs0HPLI4MgrPdyZRIyWvXJs/j1G1KjVt49LkFkq
	MRyJ+XzZN6fmEh2yyAUbYl88NlCkweA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-u7TQ_VZiNTSQdUL-rEqAEg-1; Mon, 05 Jan 2026 03:23:12 -0500
X-MC-Unique: u7TQ_VZiNTSQdUL-rEqAEg-1
X-Mimecast-MFC-AGG-ID: u7TQ_VZiNTSQdUL-rEqAEg_1767601391
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43101a351c7so11004976f8f.2
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601391; x=1768206191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
        b=UpiB1xmXLvITm1yHAltArsekW7sU4NoCSYxPSpqixLmnEtMo0gdI/yI+qzcUa/82yt
         wSIozn77LDv5/8hJy24ZGG55926kYJJtOmvI7gveAOJAYtz7keOJbBC1j6muaKmwgcGk
         8ZgDsSijiZw9RI4B2sg3kR7x7oHzxh9LkSjTmSbyLq/+yxR7eA3vm5MDunvF3o4u5Auz
         F++E91/51GmT4wFOl+Fpn9JeHP8B00mWl7IQ9/K/SxpV9GR63aKM/Cl+lvjbVr1vV3AK
         eUA4yupjM+ZyXuUEGaId0/1nzz9rALUdSzGCKoCFv3NGlccrqi1IY5eUbflznG/JcGuB
         rmcA==
X-Forwarded-Encrypted: i=1; AJvYcCWhZD+WQCJE8/Zoa74PBHFz99eRxaDMOdeG4wtNOQwWuOWb5uZw/yC1JefOMSeosQk9QBEY1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCHLKIxq1Pu7etc4bg+6XUbggZZQOhNiw7r4sZOr4LC3LQRvD4
	5w9sNJjTRDABbwClxeLL4xXWmGQ1Q0LVhPttJAkcWZyyBkRz7zevaN9EQA/+qs0qpKvcMETa7GI
	KG/jIjOOPxNCxLl2L9dCWDq/7bfaF+HRGo+Dgh5gogMk22ZO8KGQqsTnO
X-Gm-Gg: AY/fxX6aVDJH+YEygshmPjY8LO0vQZuQTXUiELXjkpaIpxiHzGAsDn3L0ldYzUkhlHE
	D3mXVklzvyKBaVO1YSpZiiQo4kCHdbgffB/JmfBY0x/0eoNhu9HShsE/kNK0eTdW/ctj6WZ0Skw
	KFBxV3Kh7aMKyns4joVwNmijHrUm/kqUT9XZy1RGdnhHLadChA/pxcXzAPEq7Vt4Brfd1FdZH/m
	Ii27cePW0fHwLSevsPbPPAGGLHPB/Vy+Mlbsg23VV+frhplySk3Lei1CSx3yKbJp6Af2XPbGd0F
	/0/qDQcQ5deuMWyTZT1iYWOjRABzEtO8k53nSSgEJaLr2SGUikfVeYsybBxnmhNpB0eCvupxbFT
	8TMcyo6QVCv+hbk+2GwOnZ+61FhSp+bemTw==
X-Received: by 2002:a05:6000:2c03:b0:42f:bbc6:edc1 with SMTP id ffacd0b85a97d-4324e4c1230mr54966721f8f.1.1767601390685;
        Mon, 05 Jan 2026 00:23:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwk1Ttr1N2m9x2GBHG1pWtih6zeyM7Sr9HAGjGkjK9L3/ihsrFeD/P27Wy0cj6YonFT6KolQ==
X-Received: by 2002:a05:6000:2c03:b0:42f:bbc6:edc1 with SMTP id ffacd0b85a97d-4324e4c1230mr54966659f8f.1.1767601390077;
        Mon, 05 Jan 2026 00:23:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm99604028f8f.35.2026.01.05.00.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:09 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 04/15] docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <0720b4be31c1b7a38edca67fd0c97983d2a56936.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dsCy3h3V4eVSX_oDOgu3wxqeW2lWAgES2DDArRzYo-0_1767601391
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Document DMA_ATTR_CPU_CACHE_CLEAN as implemented in the
previous patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-attributes.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 0bdc2be65e57..1d7bfad73b1c 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -148,3 +148,12 @@ DMA_ATTR_MMIO is appropriate.
 For architectures that require cache flushing for DMA coherence
 DMA_ATTR_MMIO will not perform any cache flushing. The address
 provided must never be mapped cacheable into the CPU.
+
+DMA_ATTR_CPU_CACHE_CLEAN
+------------------------
+
+This attribute indicates the CPU will not dirty any cacheline overlapping this
+DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
+multiple small buffers to safely share a cacheline without risk of data
+corruption, suppressing DMA debug warnings about overlapping mappings.
+All mappings sharing a cacheline should have this attribute.
-- 
MST

