Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA3436D502
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716931; cv=none; b=WmpxqFOwLF5jga1cWnitC3DrYRdhgNKNWRZgyaAJXwTy7m12QkRXfY8dZecY4Pfd1udIa84YRoky8spsdRHux5nb8OJ7UN3bb9vci0Kwo+I7c5JleAVzGYwZHjR8KlNOJJri1wCmCqAUiM1J99QFc0v5RrlbtlnBBWB9zHJiv7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716931; c=relaxed/simple;
	bh=I0Bv4gnqy6lfo71k0UiPvPPB9o4hXkmDsca3zjfsDUM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hgvXaPBdPdIc/KnhrZuVMUaXMT95fst5ju1EWPOXh3iWuWJ+6sTO6aXmVpbgKhZU9yXBlMp8cVw3as4jC6XTF0LLkBPWa0YZLPIuTQy0EQs50EHFWLRVEKm5Ks/+vWSyYM3vENT8frr2rlJZnMfIjepKP0gNyBHwVpA/TVQ+Fmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RTkoXwGQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTkoXwGQ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b72cbc24637so319533466b.0
        for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 01:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763716925; x=1764321725; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fc4Yy5Q4jGdfB/k2hW8Vi7yiCJn266doHTkByIQ2hDY=;
        b=RTkoXwGQJ3C5l2vX8sRSZWlCDesn2eR6VjDb4HoiiiUwZkUp5KnJRNYHt+RmN30SHd
         5/DDNaR9qpp5VCpcm7HiyWTV8acLS14g7NZid+1ASS7pVHRgFvHgKYXTWYfnvTDrverd
         /1S3Y1L3aedbuBBgOeZS2E3uAQ4qHsoF5Lv1Tg/yz3AtEhlMHxzYQf3zZ9AbKzuHncML
         r1GJGvcWRN6BpTSjHBo6fjR5VIwfG+puSW2e7aNNzP+P1wJZ6beInPorIUvC2eunt3Ag
         EjMJV7/fUArPhDH7ARZv225bmz/w+QneNmvYmfkF6CMWGlYQs5L0Cvgpj9u5w2ABjE1P
         iKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763716925; x=1764321725;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fc4Yy5Q4jGdfB/k2hW8Vi7yiCJn266doHTkByIQ2hDY=;
        b=dvz5ccQEF3uNk0mL1Pay4Si15JQ09FYf9G3Q1uizcbNrcOx/sO1AznDqlj62ZW6DxJ
         +YBZBR9C6L0W3Sgjtz8DULUfKKMZ5JFNnTOqAyFf5kA/l//UFxm4wU9WJD26/uarh7av
         79+RoHm1PuL4Gbytn9OMBooHmxCw2J1yznZBdX7epIqHJMcGEYp+LYolzVqjHnLwWA2y
         Mz7BkGKTKvEjYlXDwq+s5fuY4DJJ1nhbWCYykFhq4jJL+BVx71DH9KFMc7Qwh0yCITe2
         kH54aJg0BVOwwSwA42BC0wrPZ+EpnwDTyoamAIj0Gb6t4/7tjdx/Va2MN+XdPNf4Seer
         tg4w==
X-Gm-Message-State: AOJu0YzgXy+XkeUEsi+CYfkCMrOk9GBVbYa2nIrpycibx5s4QYdOC66A
	gDZwpmgUe4vpRhISaaR5Xe76HUoi9jzLPmq6GcHZd2ovda2CjK88BOAfUliPzmELuFZT7gtkeZW
	rw/O+
X-Gm-Gg: ASbGncvA8s/GHP8ORxRGE3SfZZASwl8H0UgnYWD1mTiDG/cQs3I0K6eyX0rZ+H/h4B9
	kQlmqILpf/bKMfQVSXEqaPsmvrFbrR1HONpYn6UgIYC4/MDhsQ/l02HGI+OwaNs6TUvlzbA5zwi
	elVidOTERWpNWezDttt85sPHHKP3IZyigOGCF+PoPYYBfHIWZHcNm1Ba3IX4JXGxmD8qarisRDu
	ff6XiJJXmQm3xJOGs4zyCnDGGENxrhE/szZ0XralDENe8lsOADpwknFqxaqU0GbAoZBPbbaPi4v
	KHD3YzpRhPSrIfo7qUxHvwwfgkev3F4WYMdMQnNz7PCbZ5d7rb9UgxgQA+ba6SrNm56kC/bkehB
	/JFWOPurr1AJK2v0c67a+GW+r6Sm9R4R/7KKTnxe6xnrCENS7empqO5oQpkluW0Y69teJwq+hsj
	KR1aRXcv67hCj5LT/b
X-Google-Smtp-Source: AGHT+IFEtolwjZ4NXU5zUgP7qtE1sFSHAtqzBIYj5YQo85DRGFS3ekZdDQHsiMhuDDgnyn+syGLeOg==
X-Received: by 2002:a17:907:7292:b0:b70:b077:b94b with SMTP id a640c23a62f3a-b7671a7c4a8mr167202066b.43.1763716925485;
        Fri, 21 Nov 2025 01:22:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7654cf0435sm414260066b.4.2025.11.21.01.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:22:05 -0800 (PST)
Date: Fri, 21 Nov 2025 12:22:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev
Subject: [bug report] iommupt: Add map_pages op
Message-ID: <aSAvOn2fgvmF0WYD@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jason Gunthorpe,

Commit dcd6a011a8d5 ("iommupt: Add map_pages op") from Nov 4, 2025
(linux-next), leads to the following Smatch static checker warning:

	drivers/iommu/generic_pt/fmt/../iommu_pt.h:701 increase_top()
	warn: missing unwind goto?

drivers/iommu/generic_pt/fmt/../iommu_pt.h
    665 static int increase_top(struct pt_iommu *iommu_table, struct pt_range *range,
    666                         struct pt_iommu_map_args *map)
    667 {
    668         struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
    669         struct pt_common *common = common_from_iommu(iommu_table);
    670         uintptr_t top_of_table = READ_ONCE(common->top_of_table);
    671         uintptr_t new_top_of_table = top_of_table;
    672         struct pt_table_p *table_mem;
    673         unsigned int new_level;
    674         spinlock_t *domain_lock;
    675         unsigned long flags;
    676         int ret;
    677 
    678         while (true) {
    679                 struct pt_range top_range =
    680                         _pt_top_range(common, new_top_of_table);
    681                 struct pt_state pts = pt_init_top(&top_range);
    682 
    683                 top_range.va = range->va;
    684                 top_range.last_va = range->last_va;
    685 
    686                 if (!pt_check_range(&top_range) && map->leaf_level <= pts.level)
    687                         break;
    688 
    689                 pts.level++;
    690                 if (pts.level > PT_MAX_TOP_LEVEL ||
    691                     pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2) {
    692                         ret = -ERANGE;
    693                         goto err_free;
    694                 }
    695 
    696                 new_level = pts.level;
    697                 table_mem =
    698                         table_alloc_top(common, _pt_top_set(NULL, pts.level),
    699                                         map->attrs.gfp, ALLOC_DEFER_COHERENT_FLUSH);
    700                 if (IS_ERR(table_mem))
--> 701                         return PTR_ERR(table_mem);

goto err_free?  Although, why do we need to call
iommu_pages_stop_incoherent_list() when that isn't started

    702                 iommu_pages_list_add(&free_list, table_mem);
    703 
    704                 /* The new table links to the lower table always at index 0 */
    705                 top_range.va = 0;
    706                 top_range.top_level = new_level;
    707                 pts.table_lower = pts.table;
    708                 pts.table = table_mem;
    709                 pt_load_single_entry(&pts);
    710                 PT_WARN_ON(pts.index != 0);
    711                 pt_install_table(&pts, virt_to_phys(pts.table_lower),
    712                                  &map->attrs);
    713                 new_top_of_table = _pt_top_set(pts.table, pts.level);
    714         }
    715 
    716         /*
    717          * Avoid double flushing, flush it once after all pt_install_table()
    718          */
    719         if (pt_feature(common, PT_FEAT_DMA_INCOHERENT)) {
    720                 ret = iommu_pages_start_incoherent_list(
    721                         &free_list, iommu_table->iommu_device);

until here.

    722                 if (ret)
    723                         goto err_free;
    724         }
    725 
    726         /*
    727          * top_of_table is write locked by the spinlock, but readers can use
    728          * READ_ONCE() to get the value. Since we encode both the level and the
    729          * pointer in one quanta the lockless reader will always see something
    730          * valid. The HW must be updated to the new level under the spinlock
    731          * before top_of_table is updated so that concurrent readers don't map
    732          * into the new level until it is fully functional. If another thread
    733          * already updated it while we were working then throw everything away
    734          * and try again.
    735          */
    736         domain_lock = iommu_table->driver_ops->get_top_lock(iommu_table);
    737         spin_lock_irqsave(domain_lock, flags);
    738         if (common->top_of_table != top_of_table) {
    739                 spin_unlock_irqrestore(domain_lock, flags);
    740                 ret = -EAGAIN;
    741                 goto err_free;
    742         }
    743 
    744         /*
    745          * We do not issue any flushes for change_top on the expectation that
    746          * any walk cache will not become a problem by adding another layer to
    747          * the tree. Misses will rewalk from the updated top pointer, hits
    748          * continue to be correct. Negative caching is fine too since all the
    749          * new IOVA added by the new top is non-present.
    750          */
    751         iommu_table->driver_ops->change_top(
    752                 iommu_table, virt_to_phys(table_mem), new_level);
    753         WRITE_ONCE(common->top_of_table, new_top_of_table);
    754         spin_unlock_irqrestore(domain_lock, flags);
    755         return 0;
    756 
    757 err_free:
    758         if (pt_feature(common, PT_FEAT_DMA_INCOHERENT))
    759                 iommu_pages_stop_incoherent_list(&free_list,
    760                                                  iommu_table->iommu_device);
    761         iommu_put_pages_list(&free_list);
    762         return ret;
    763 }

regards,
dan carpenter
