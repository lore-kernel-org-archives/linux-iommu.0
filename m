Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2352FD671
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450941; cv=none; b=aSmZUT4q92HLVHo8LVdd5kCIwmcVAjmIpDIn7U6cXKeEydr8tZPko7bdUaxRt0mkK4wUlhop29BhnZeGtUnaQ5yItjcqFMdJPlL+ZrwqvK8MCJ9/0X+ovCd+z9FjxAhzUt1F90hw+Uv2VhS38IJwielQ3TbOaVIbOC1xkWfYt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450941; c=relaxed/simple;
	bh=TMVa/eYnu2PAcL60U/LLvP7A6wKy6iTHkd1FndddO14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CjY2Dh5sU/2C1bSN5rgK1urbx1/G2rfgo74m0QIcOhYt0Ghwhujk/V7/y0RSRC8R0zEtz79+BONQ3PBzLy0Cm/qeYahW616yxR0rkUU1dM2JvYEwec1/jE9B/wkI8XheVm8huSXb2XLP55sj8uRCTaCb5amlw1aYMakB1iwsAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pf63IXzZ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pf63IXzZ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so4178949f8f.2
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 23:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763450937; x=1764055737; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcBIpB4Lw+Go5nNz/YIS3ZtjYcofF1wFlG2s7LQLJAY=;
        b=Pf63IXzZB8zmiEhsXahvXXL+R012vPGkEtngDmhouC8Ve4iPoolB3nENEYvq6os+IE
         nJCYxQokSmmfusXKh3W7t8AzqXl7y9Glcdd2J2zIRxkPaN0ThNDiNXyqg3nFIFySyHcC
         XdVyDB1yXokFT2y07Lvak6fvFr8HZpQaBixjkjLX+QFtNN8DFjQf+CqqUfnX6xBiq7qK
         wgk8O2uaYd6PpUBKCL3a7aQ6jvRKVWMOIXuGx4XP9t/sibOly4kmiAuzj+oCvEnGHu1R
         Q3/pv7GYjMRQfNPUmn20BJjnfXk4a1s9hiQvWdN/IsA3g84++PXGyEqtjXZxf9pM8klT
         PlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763450937; x=1764055737;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcBIpB4Lw+Go5nNz/YIS3ZtjYcofF1wFlG2s7LQLJAY=;
        b=XDzFpeiD/MoercibbgJIbYThlOk7NrjcbbnWsSUoxcwBQcWbe+/QmHZIU67qjtCUT3
         byxDLc11pkrrWUd5ICxBT8E6qPijUnCZuHgpcNNYTKQ4p0EFuZTDW2TKTpngszQuREx6
         n9S2Lf/tsUIm2H/kzMv3jNWQ5IvOEVNHGMh//y8BKavJ7JgvVCrB+PNWeE9hqKt5QbLW
         4buGOo38zdGOpJd+qpzIl96w/An/m6VJsgJbCAAdBQfs91dhsHe3AzNC05BygdBXNmHl
         2gyTcyk6y8zPrmlmiykbm+NwMgwHsdq6ruNi2agelXx92z0s3825XD0qSatR0azLqvsB
         6iTA==
X-Gm-Message-State: AOJu0YwuX2ii7ijbLWlXmhmRU749wwrWv8u0rCgppLoJ7i2q4kjiYH15
	YaAIW+PJuivb4iOHBNN+gNlLZ2/yc5HG/vILey8fh9q4EiybR35YL/UNV5QdMLa7aw0=
X-Gm-Gg: ASbGncsJT/JaBiT7q9Is5ZmVODB1pYcQeZ6qOmFqa5la/OLxRV+OMSK4NdCWI6NdrjN
	tSlFp21ijB0CXnkLOee6NdZ77vb91dxn20V1O+pZJSYB1PE7ozQ634YCj6xFejUlNnW7nSzfJtk
	TBPuoRda1V31524hnfXPGlSHxsRkJ1xOAF0qj2QMNsXTus2d+6/LyDa/aLcE62H68VpMN6g5ryS
	UFfJ7vEGspGw6RsPH8lbJMUElIldyoNfrDbYEtlQw/O/Ofn6gV/04Stqbx2SY7k6Pv8JnPPvXgj
	SV2LweJA9NlZ39OuAXkKX5rUUIKzHrjrUz+yu8qWAN+s9bBGkyVAKhAB4hcBK9G79BhNlXNW6Ho
	mRBjP+rpoed0yo26RROypBxs6hmgQonssTcT4+l+g32Wylib3Nwm/g3BSuWwE65hpwFsekDvJcg
	qt6aaVtqc8JxRqHo2f
X-Google-Smtp-Source: AGHT+IGP/bmCkqXnQglGLv241YWQEY0OFeAidugrcsfM9u/CquIcXj24ZM1KFQl/uV3Cg1k5VyB0IQ==
X-Received: by 2002:a05:6000:4024:b0:42b:392f:450b with SMTP id ffacd0b85a97d-42b59372181mr14714934f8f.36.1763450937186;
        Mon, 17 Nov 2025 23:28:57 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42b53e84a4fsm30347626f8f.11.2025.11.17.23.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:28:56 -0800 (PST)
Date: Tue, 18 Nov 2025 10:28:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev
Subject: [bug report] iommupt: Add map_pages op
Message-ID: <aRwgNW9PiW2j-Qwo@stanley.mountain>
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

	drivers/iommu/generic_pt/fmt/../iommu_pt.h:752 increase_top()
	error: uninitialized symbol 'new_level'.

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

Smatch worries that we could break on the first iteration.  I don't
know if that's possible.

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
    701                         return PTR_ERR(table_mem);
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
--> 752                 iommu_table, virt_to_phys(table_mem), new_level);
                                                              ^^^^^^^^^

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
