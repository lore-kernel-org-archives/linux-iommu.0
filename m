Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676C29AC
	for <iommu@lists.linux.dev>; Fri, 26 Aug 2022 10:28:44 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id p18so1228003plr.8
        for <iommu@lists.linux.dev>; Fri, 26 Aug 2022 03:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=U+isRkpz8Ia+KyvGxBChAGkeQyWJ1PdeEmG8QHIxQpk=;
        b=pmBmgmW6EfkwZCVXRrd/3HA6KvtfblbnSTnHdQZDx+GMtiyR1hGQ7xPetBexTzKs5M
         q1f6sdE6hPF7/fGmb9GYhXDcLi3XkRLxiGKbr4KZYCwzTARQUXF4wzep/izfhZnwDIWa
         irpkvVj4LPC9sQzZN1u8t7m28pEaAlH+0T29kbSB2dLPMEyW13Pf83YnPcwUC1hqd187
         GFnnb+3Lq1ZO1fB80zJxP2RLX3pJTBwUuGYAZi4MyVV/fvXTPX4eWGiyIteqMb02ldze
         sWU4qnNNgWO0cI4qzWPvQ8IBtgbHzx5EMVacC/GHn4o1DYM5oCrfMk5wBduhQiFmv7cO
         gZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=U+isRkpz8Ia+KyvGxBChAGkeQyWJ1PdeEmG8QHIxQpk=;
        b=mwNzmH9YRE46ao7VbnR+tyxK9RhnBcSSvbFoN95NvGjcaeAahcTq9KG8ciVJLB8AdT
         YAUalepMp9AD0H4/WUdxcsWR5c9YI1v/53/JAyv36losjY6043mABH/a4wt1mZsrYJ4y
         gctiovrkKOmS/U/MbNWrOJ5IPYmSFkuV1kjL2tj1nr2/Wyg//uIyzWdNEvCWIUC4iWuM
         r+DxwLuzaE8RrfhBGe1L2EUGZdNcqSxAJ5Mhycv7YeMYeVPltvsUWXokADFJGFoNScr3
         3vjuCGRK3bDdOMNxFGvAI8n3kTx6H/dmCXjvRwMBkhg+pzrULkHhNvehjD5iG3AJ+HBo
         6g1Q==
X-Gm-Message-State: ACgBeo2cJ1Z2Cm9ZKYcWM0CEQhNkabNY5dEib8bm3hW26OkRzCP30kvC
	kgHMqPrHVMg1aYH3CcU9mtGn4w==
X-Google-Smtp-Source: AA6agR6RGF84krP3Bh3Fyw/2zGy4J9zwPYJxbanC7aL9i06l9ZENZAKzD9HHfAt1KWbFF28C4cwrEA==
X-Received: by 2002:a17:90b:1e49:b0:1f5:1dbf:4c3a with SMTP id pi9-20020a17090b1e4900b001f51dbf4c3amr3809604pjb.232.1661509723959;
        Fri, 26 Aug 2022 03:28:43 -0700 (PDT)
Received: from [10.71.59.90] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id x187-20020a6263c4000000b0052dc12cded3sm1300821pfb.196.2022.08.26.03.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:28:43 -0700 (PDT)
Message-ID: <4527c925-076b-a477-4ff8-697d75f16761@bytedance.com>
Date: Fri, 26 Aug 2022 18:28:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: [PATCH v2] iommu/iova: Optimize alloc_iova with rbtree_augmented
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, joro@8bytes.org,
 will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, robin.murphy@arm.com
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
 <06c215c6-cbae-d6b9-312c-6535e51a3128@linux.intel.com>
 <486fcde8-e9f5-e40c-db5d-fd3ade59b267@bytedance.com>
 <a2479500-479a-22ef-3bd2-90606a26a35e@linux.intel.com>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <a2479500-479a-22ef-3bd2-90606a26a35e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> Though only 3-4 drivers use alloc_iova() directly, in my understanding
> 
> your test has simulated the worst case, rcache doesn't work at all,
> 
> "alloc_iova" +“remove_iova” number looks great for worst case.

There is another case, when the size to allocate greater to 2^5, even if 
alloc_iova_fast() is used, alloc_iova() will always be called because 
the maximum iova size that rcache supports to allocate is 32.
IOVA_RANGE_CACHE_MAX_SIZE specifies the maximum size.

Thanks,

Peng
