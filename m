Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5334AB14
	for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806847; cv=none; b=k5vd6Y6d0nkOZT70rxPYHHMCecVlyVqao/9Q/LGcgVyRQKKg1GhbLrqX5NsCyvvJ/mACH8iuvzyoblM4bh04x1s0vy+iF9kWx6+qpef83FjBYFmsKMwftlhN0ISjwz7sWRgGEcqDJtfpzfwfkFdnUYLtk4cQSCh0rnQmNyLgpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806847; c=relaxed/simple;
	bh=vLP4m8ubY62ddowshnJEYGhNc+fB41I1n0umGIUlXAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=m4FBg17YWfPy0kvfnKLuP9PpWHKi0P1ft4CI4PkSNiXHJiCNxyLphhfenM4JJudMTJBRojT9NUOoLKmQcB0oFZycmXHUsiI+1KEwQXLXxfHbPU/QpSyPgII8qIdPIpNwGA9DTA/YpgMzzq0y7knxUvCJfei8X5U7E9yI0SGIX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTMr6Gx8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTMr6Gx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
	b=UTMr6Gx80u/MdHhmb0nX9KR9K1Y9mBBNZdMhmiTyizUXmPVAka1kPbgfHeSrj+xq5AU449
	31vHiecKeLgib3giSO/EvygS+/4G6YvCO+CVyrFduoeJdrdAMNjkmPmttA0i9gEeMyzGSB
	6GKlHo3EyWP+28+KQHE1pqIN/h3+5rA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-GL53CnwSNHagcW7-zuEYNw-1; Thu, 21 Aug 2025 16:07:23 -0400
X-MC-Unique: GL53CnwSNHagcW7-zuEYNw-1
X-Mimecast-MFC-AGG-ID: GL53CnwSNHagcW7-zuEYNw_1755806842
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0b6466so9581205e9.2
        for <iommu@lists.linux.dev>; Thu, 21 Aug 2025 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806842; x=1756411642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOl+Pd7m6DQCTUATshUDhXjEbKNtUx8aQQ0CVjE/d9w=;
        b=H4/ATb8W9CAUdPrsEo1OXO6tmqOuq+eXigf/UZzxpEHH2FkVloO0mj648HTx27QYWZ
         KEjWHUvLYkb2A5QdRi+2D7c86Lq3s9/SMeIh9Rtq1fw2rC2PZk0tjYBE1BpHU9Nc8OY7
         MUxo22Og869+1Q1tbs2jZc9AdoBY5pxr/4z4+TuKfTG5467EiGT/XS5EX8NgdgHxVh+l
         frgRji6oB1eafdCu9g1oSnLmOJxEx7HeKaganDlnasFzikCXZpE6N/3dqrrZmcvwixSd
         1IaoLmNCyQsWpoJ/re5vdLF3dWILwlbX5ltzbVtRb/ZN3N3leH3XRyfVUrsSIk1+rI79
         tYgg==
X-Forwarded-Encrypted: i=1; AJvYcCXK7RMzGVvafzt0H7k1KZB8L1X67APujvZtofebYGVADmY+LOKSXSV8BtnRUUinpHp5BaPGCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcYIxLOw7h4HvNHB1VyjZVZ58r9ZmxMWOfRgHaFhLPsYyFQKI4
	J+hpIaJszV+EI+TBZ7eek0SFQ5/Ld4ekmQfTZSbxAWEUgYQZ/hopGlHV/jp17BtjIXoAtIT7NOO
	79yFqOsdfligTc+DEcDMeSI2zv0ObD+8SYBTcGFPVttchtS1DIpjV4oDu
X-Gm-Gg: ASbGncugp8XioUohYt63Xn4sdIenAupFe5DbPOSEIGVaHSrzYuDlYfFqIuDwZiwWaMt
	jTHsBwdgIO+c2PSvIxZ2ju5s1tgvrlrdDSbczSgr8r/XknhSm3+Xjr+JvOmN7vU+CgS6zRQYxOD
	qWoYrZWGtJ+qpTw0Q2XKkjThqtULExeOpV6U1cF84Xv/spn+o3Cvoc7DePxRJy7qmlIexNk0yfG
	4KB7RaB8rGfRvhp7iFMpUJ7jf7UX25wzQJiyBumMmFSwuSpfft6WCGMCRkatrlcuajt4j3G752z
	iFBtXSxbhGBsJw07Cq33L9C0vj7xWag9lt+hA4EzKa8QlGTlZX9l6TrelBEYfMwI1gJR+emihSl
	7hXmK/mAemdI9Qn6kUI36ww==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412415e9.14.1755806841668;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtBnzBdejX2oNj8vG9iZBZKJew+pPrkGWxHzVnhFEnb5RkXIsj+cBFTtJrIXnzr/4lYhSU+w==
X-Received: by 2002:a05:600c:1993:b0:456:e39:ec1a with SMTP id 5b1f17b1804b1-45b517ad4a9mr2412295e9.14.1755806841198;
        Thu, 21 Aug 2025 13:07:21 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dc00a8sm10960275e9.1.2025.08.21.13.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:20 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 05/35] wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config
Date: Thu, 21 Aug 2025 22:06:31 +0200
Message-ID: <20250821200701.1329277-6-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UPAOrH9MZO0j5iw0i7oe5UD3UfDQVHF4utb2tEOb-iQ_1755806842
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's no longer user-selectable (and the default was already "y"), so
let's just drop it.

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/wireguard/qemu/kernel.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 0a5381717e9f4..1149289f4b30f 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -48,7 +48,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_FUTEX=y
 CONFIG_SHMEM=y
 CONFIG_SLUB=y
-CONFIG_SPARSEMEM_VMEMMAP=y
 CONFIG_SMP=y
 CONFIG_SCHED_SMT=y
 CONFIG_SCHED_MC=y
-- 
2.50.1

