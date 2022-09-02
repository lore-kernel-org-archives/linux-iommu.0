Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EBD10E5
	for <iommu@lists.linux.dev>; Fri,  2 Sep 2022 03:31:01 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id l3so607367plb.10
        for <iommu@lists.linux.dev>; Thu, 01 Sep 2022 20:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=shz1MJujjzqiNwugBIDcBsPwYPc3SVzREMOMkqsy7Mk=;
        b=w8zTqe7jLtPspiEBjz+Fy4fnP6CRLP/1zB1TYddtfRvPRf6HmPkOhDjjui66WN2vsl
         5IjdUYxKnnoMusvxY/mOH9TD6PkP0ZcdcNPwGreeU6bbLuIBySqYMjVzFdaEv0V86kHy
         pRzBdIR3YkpGmIYlHpQDxZhmRZ72RRgFTm51BCNCOvy5ir+Mv2OIiiNBEEtYNav77mUF
         mbHV4wPilqz1NqoKMoWYS9n2nLpkfXWHCOkA/MkS5si5zhMesHK7y5M6S0/swB5oGNJp
         Vho54MFRdGsDtTej4LYmrHru82H6nWe9gB2JJQhofQYoZ/Tj2mO1Q5xsj0DzIRYpaQd7
         /r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=shz1MJujjzqiNwugBIDcBsPwYPc3SVzREMOMkqsy7Mk=;
        b=73Rj1t7Wrs1oNeSGjnlgmhvXqlHBq73gnNtNj5IYw7X813SK73B/BoEqyGHTqUWmxC
         vaXoKC1g2vD+JnSLDktaPpp0XtaQzeDVEEu9nY10QIMa3tUlMKBSEcsVbCzegxgAtpdR
         kLsahvpffqNmfs1ovPpf1aHfbgmB2f8YaOI7XJ4HQGA5KNleMdVh0EKvrOo703qRhZyR
         UZTUIvycg4DI9Xfa/O2LIzl3R4GKYKgqqo62gI6Ry+wNkZB0VPVV+fF29w96di7BBQ9m
         PrB8EGYnOu+J+EEamzqb2QbLuuT9Y1UeT7qhBE+4YkIHBpldn6hFhxUQ/aAlYbYhT6ck
         DUog==
X-Gm-Message-State: ACgBeo2hVMTXyLEJScJbvtzicgoP6cE2ZWc3o3ff+InMBmKWRPx1/wcP
	avTagQZrdT+vbfUMM7DGeLxvpg==
X-Google-Smtp-Source: AA6agR5WowK59aA98UXhJCFNoaxgGwDjHSg3E1dHsTvjRo7r8QRvQblDqSuZDdJ0+myL45NwJuKEsQ==
X-Received: by 2002:a17:90a:4d8d:b0:1fa:9cc6:3408 with SMTP id m13-20020a17090a4d8d00b001fa9cc63408mr2434860pjh.245.1662089460803;
        Thu, 01 Sep 2022 20:31:00 -0700 (PDT)
Received: from [10.255.237.132] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090a1f8d00b001f510175984sm4090447pja.41.2022.09.01.20.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 20:31:00 -0700 (PDT)
Message-ID: <4a62a93c-683a-0515-2033-26c59b3b6f20@bytedance.com>
Date: Fri, 2 Sep 2022 11:30:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.0
Subject: Re: [PATCH v2] iommu/iova: Optimize alloc_iova with rbtree_augmented
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, xieyongji@bytedance.com,
 Ethan Zhao <haifeng.zhao@linux.intel.com>
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
 <06c215c6-cbae-d6b9-312c-6535e51a3128@linux.intel.com>
 <486fcde8-e9f5-e40c-db5d-fd3ade59b267@bytedance.com>
 <a2479500-479a-22ef-3bd2-90606a26a35e@linux.intel.com>
 <4527c925-076b-a477-4ff8-697d75f16761@bytedance.com>
 <1351998d-4fd7-dffb-c1fa-a0b1ca759123@huawei.com>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <1351998d-4fd7-dffb-c1fa-a0b1ca759123@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> If you really have a performance issue with alloc_iova_fast() -> 
> alloc_iova() then I suggest that you consider trying to use 
> dma_opt_mapping_size() to teach the DMA engine driver to not create 
> requests whose overall size exceeds to the rcache limit.

Yes. But I don't think it essentially solves the problem.
A library for users should run stably ant it shouldn't hold
the spinlock for a long time in some cases. It can even be
said to be a bug.

Like this:
[Wed May 25 05:27:59 2022] watchdog: BUG: soft lockup - CPU#58
stuck for 23s!
[Wed May 25 05:27:59 2022] Call Trace:
[Wed May 25 05:27:59 2022]  alloc_iova+0xf2/0x140
[Wed May 25 05:27:59 2022]  alloc_iova_fast+0x56/0x251

Now we avoid this problem with iommu=pt, but it didn't solve the problem.

Thanks,
Peng
