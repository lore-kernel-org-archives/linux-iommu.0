Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90766E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:21 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id ml1so10116351qvb.1
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hB/8CHaP3epa66ZDI7eIxcYHinx9lai7E+SzdR8JK34=;
        b=DH5wOpdpiHaFFXY8TAT3JRecX64XiPNxiR/CcG1LrVu07Readvn0PWViKgBmDA60Pb
         UBITk9aWlYro2ikNI4WmLJPOCXwQOqtprdUB0CzoJZ72kknTQx9o/RitCRSffQDxQ5Q6
         VTZyKVoIHd28mrFZHIQl9dz1uLmu560sdtEcQWDtP1q9dt0hIGQCuqCTjE9fttuhjONt
         0HIT34gX8eS66xaVSIttBxYAN/YQSf5UtfsLj6aZ6r0xFgT3C7geS9uBf8xzXOro8Ch1
         QuB8O5yFa+P3URJ5XpTXammfwNsUv1UpGQMU/vjO4KV44uIZqk+ZBhqofvaHP1BLFOQP
         ilEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hB/8CHaP3epa66ZDI7eIxcYHinx9lai7E+SzdR8JK34=;
        b=XE/tZ+nLZnf1e11CgHwJiZz4rqP20VzNqirKZ/ztA2XrWkeVEd1jjgMOLq4MG/ppZc
         I2XgYVqV/INo3gRdhlIhnAQ9WY8f1kVS8Jhx4F4RTNhbrZS9NV89w2qMv2why5L+pdTk
         ChMBiuJcnr6AapOHeVS5CkBC3XPzAou8wpdBOe47hev/ID0dc1bJaE72MMqBURtMaojz
         vWUab/xW6RArkdSDwxsn4AeCpdZwK+kqakl9ZQPCGF1jh5L7Vt63p6wEYBex2QEfq0lo
         rxpRuIurFMnhlAfdM6rs5E+0AvjsXrwVgQQIG5NU/ByQcWiTJzysnFwk08wJ7kiDuOPK
         FXrg==
X-Gm-Message-State: ACgBeo3QEh7mvwUy+NJT9OMIKLls8BSzEydsG4/xNaVOq5o7TfM+DOY1
	uygzjAJ8XS58SQVPh5D3tjA=
X-Google-Smtp-Source: AA6agR4VzptNv0IdYnihlFGaNyhbElSt3SCLpuN9uI3qoIO24r77G7BDUS/ieSa0RDNa+EBnGiO84g==
X-Received: by 2002:a0c:c98a:0:b0:4ac:9f4b:efed with SMTP id b10-20020a0cc98a000000b004ac9f4befedmr14045129qvk.35.1663099100395;
        Tue, 13 Sep 2022 12:58:20 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:19 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	- <devicetree-spec@vger.kernel.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH 07/21] lib/show_mem.c: display MovableOnly
Date: Tue, 13 Sep 2022 12:54:54 -0700
Message-Id: <20220913195508.3511038-8-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for commit c78e93630d15 ("mm: do not walk all of
system memory during show_mem") indicates it "also corrects the
reporting of HighMem as HighMem/MovableOnly as ZONE_MOVABLE has
similar problems to HighMem with respect to lowmem/highmem
exhaustion."

Presuming the similar problems are with regard to the general
exclusion of kernel allocations from either zone, I believe it
makes sense to include all ZONE_MOVABLE memory even on systems
without HighMem.

To the extent that this was the intent of the original commit I
have included a "Fixes" tag, but it seems unnecessary to submit
to linux-stable.

Fixes: c78e93630d15 ("mm: do not walk all of system memory during show_mem")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 lib/show_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/show_mem.c b/lib/show_mem.c
index 1c26c14ffbb9..337c870a5e59 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -27,7 +27,7 @@ void show_mem(unsigned int filter, nodemask_t *nodemask)
 			total += zone->present_pages;
 			reserved += zone->present_pages - zone_managed_pages(zone);
 
-			if (is_highmem_idx(zoneid))
+			if (zoneid == ZONE_MOVABLE || is_highmem_idx(zoneid))
 				highmem += zone->present_pages;
 		}
 	}
-- 
2.25.1

