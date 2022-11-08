Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13692CA2
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 03:44:04 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id 78so12281635pgb.13
        for <iommu@lists.linux.dev>; Mon, 07 Nov 2022 19:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMCLCyI3hZtXF/+wItazbuWkV+QYGcAifqVubozLyYk=;
        b=BnmvNHqflPwI9phHciUytWQTJwsRTtkj1KxnJYIX5lR5H5tIpZirFCGFhlecvSdaDQ
         DtNJd08ijF3C1W3zc3VN9aJaMrIEpro5RWUC45o+ZQZFcs4gQ8kShX9aalf5RbJgCl/s
         dgTEZ7rbSs5OE6D4MrtYd+bZ+gyHLRtlJ45JzINtF2XxIeQt0Gi5UA2+6+1uVq0HNwrm
         6KBuzMyYgAJpAl//WRopmWM+zVE3X9yNG9jpe8ptmHh/oAPhAa4VlKpOfteUekT60v8/
         XkquNNQ92Xc3QTDieBy3hpF+rUv/flI4Wk2n/iPbJ+Diut741TTUzDB+VBXkAIaGQAe/
         RzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wMCLCyI3hZtXF/+wItazbuWkV+QYGcAifqVubozLyYk=;
        b=YaOPZikA+9Pcair446UftUXpXV/19k0BiwfxRd0P7buK0HxEdhY/4qTjbrYhIHDBl8
         zQ1ug56uS38Nllfa2GlowJTCxOzO7W95UNmHshOxuZDhKkW/xK/qrfeVfyMDqzv7vlAR
         WZ9SDw3cEV11h/Lrs2hf4iL44E5AKA2/EC3wyfsUswri/gxJzIXW5YRph5R1fmYqAbEZ
         ViwT/eFdO8wgb4LqdlvKMLpbiS0e+VBlX1IJmpBl80gHGSKn/5XiVauhspArBavtlrIz
         H8B9RWL1IeHa9bYBhju4FzwiuOW0FuWHPHp7lwqNPr/oqRqXinTIo4k7JRxpc7m1fgSP
         OeIw==
X-Gm-Message-State: ACrzQf2d/u98pkytYmClt9QJkZmyJvooLU+P/kViUR70YlIDAWBPC43h
	UU//Ke+mkDq6fLwGf8S+o7vj4g==
X-Google-Smtp-Source: AMsMyM64W3vwEqO4HBVkCyFiuyZ8dDJNvWAYn7dEYV00PWb7kBu4s9Z7y7BjOmJa7I//9YQ9IICJ8g==
X-Received: by 2002:a05:6a00:a15:b0:56e:9b2b:60dd with SMTP id p21-20020a056a000a1500b0056e9b2b60ddmr19672290pfh.35.1667879044094;
        Mon, 07 Nov 2022 19:44:04 -0800 (PST)
Received: from [10.255.232.252] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a12ca00b0020dda7efe61sm6934662pjg.5.2022.11.07.19.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 19:44:03 -0800 (PST)
Message-ID: <0689cf4d-adaa-c783-98e8-ffbe73291ae1@bytedance.com>
Date: Tue, 8 Nov 2022 11:43:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH v3] iommu/iova: Optimize alloc_iova with
 rbtree_augmented
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
Cc: wangjie125@huawei.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, haifeng.zhao@linux.intel.com,
 john.garry@huawei.com
References: <20220922183114.15135-1-zhangpeng.00@bytedance.com>
 <4a1d000e-e051-5972-bacc-d785ceeed879@arm.com>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <4a1d000e-e051-5972-bacc-d785ceeed879@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> https://lore.kernel.org/linux-iommu/2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com/
I don't think this method solves the problem, because sometimes it's 
just that the allocation is very slow, it's not that it can't be allocated.

This is a test of the performance improvement of the network card by 
this patch:
https://lore.kernel.org/lkml/42909903-5b6c-efe8-9ed3-3ac012f1a421@huawei.com/
At least this optimization makes sense.

The only downside of this optimization is that it is more complex, if 
you think it is difficult to maintain it, I can help maintain it.

Thanks,
Peng.

