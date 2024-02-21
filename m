Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73801128366
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544470; cv=none; b=PA7GrhBhV4urW0GmNfEADsPDubkdJS7ImdHmUnfYf0FUpZ7S+apC8rUYdxaU6ZL5WwSyGSIizk9adUg8/fbZo4TUc89FLGc4AKmLY8nMPG2QtAYg5jeOucBOJzyAq3+UfQFozpdkTispvnJKJz8aXmembFxs8sXnotUsXq4e068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544470; c=relaxed/simple;
	bh=Z0uieU1Hw2qDymgn+R30jj728IuRbiBIVd6A3QTsoEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NXf1CZBe7U49o3+/7ve+tcQObkxReQ2ibv+4MeiuqB7Ma4klPeYzxTtGrLeDm/atjxxuWIRjdWyqcpcwjWvMDGjnpG/2fJ3U/G86mfJ7TMbFExDGFv3mvXZemhBLulCRCrsQ7pGrlp/JFp4nXtW5kK+sKlrd2Aoh9pRIQh2r6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BusIx7c6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BusIx7c6"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608575317f8so43594467b3.3
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 11:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544467; x=1709149267; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=14sostfgXdBtkigrgclSIrhsv4NljUYVKVXEohyvFzI=;
        b=BusIx7c6zMDjAMmIa0YpMTAnQb31lQVbxbcNQZ4FKhm/dGCrHV8FGSNgweAwYxP+0r
         Da9RByxg91NO+2NX45vKuuDHzrkkYx25ULF+6JC4FGzrLh9wOO/dREyowIMDAl290vKr
         Vz3Oo89HIFSOcCZXys+sMbHhE6ZQ4kqIkcp4LtAUdgE+uAornCLJ6/+ijDCwfV5vbGSO
         Of4TABhPr3nb9pHuVeGnP21EZH8L3jjDo4oYcnfBCl1PA4T4Wbe4qCf8fI11CpMAZE7D
         /ybsxcMkjaJjjGJ70bRF8iPI/ZumsCg8Y9UzERvvErDHiCM9/xalcFgG4Ih9WrbcZwoo
         FxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544467; x=1709149267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14sostfgXdBtkigrgclSIrhsv4NljUYVKVXEohyvFzI=;
        b=kXERPmF1dRs6/UB4YcJlb7fk9osHzXQ0smP9rjJbVOy9rxGC4X3IdueiL3KIeSXjyY
         C8ApHpdj03JxC/cFxz148Hl8GTl86Jc3rmQlDciF7ebCm29+/CVgk1Sl+SZc5Ii2NR1b
         mzAbGT8ygI2qJtk0XcnWGaA8SsCQhx55KaZvfPbc1Mt89ekhptOaraTvxo+boAcDj0BZ
         T0Q1p/AY0KpsCu0ZGARyzy8psQTIdTKsC73oVV4FIzAUfOgaDq6vO7DZ1ZFb8EIRjifW
         txDpGPKdPp1KBX65bOyY2UsQtqv6iOlq4q4hmztSsSd01DmeH+5vUnLe1StvVa5KfCn3
         FcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU72ItNNdvcxH/zE2kFwHnBOcw4xjGmu9E/6jRMBZRap1gpMVwH98cMh1o5rR6SrvV4gp22yRs1TIJQCBVeQYRge1j1zqI=
X-Gm-Message-State: AOJu0Yw518yVO2LLSxiGg2pEbOn/lMW1HfJAr7sRKDEtojEglbSWdBrT
	UbN/lf+fvP5FBv8yTEh7a5O2BoNNMrC37wgjMQGh7LCoAgTqX3fb3Z7MLTWActA2l9teGVCN/5k
	cew==
X-Google-Smtp-Source: AGHT+IEg8J3/Tgw3rQ0HmvocmCN1KEaF26PclNShE/JXdkinKLyGnMcr7oBUIgKaZkEgV9b6wmo43w0h+Rc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:4c2:b0:dcc:4785:b51e with SMTP id
 v2-20020a05690204c200b00dcc4785b51emr10314ybs.12.1708544467498; Wed, 21 Feb
 2024 11:41:07 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:18 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-6-surenb@google.com>
Subject: [PATCH v4 05/36] fs: Convert alloc_inode_sb() to a macro
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

We're introducing alloc tagging, which tracks memory allocations by
callsite. Converting alloc_inode_sb() to a macro means allocations will
be tracked by its caller, which is a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 023f37c60709..08d8246399c3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3010,11 +3010,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
  * This must be used for allocating filesystems specific inodes to set
  * up the inode reclaim context correctly.
  */
-static inline void *
-alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
-{
-	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
-}
+#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
-- 
2.44.0.rc0.258.g7320e95886-goog

