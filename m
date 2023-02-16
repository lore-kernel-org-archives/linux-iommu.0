Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2E133DC
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 11:03:06 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id i18so1663912pli.3
        for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 03:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZesZ6O765cPopeyel8yKHxm28ifXaTYkteY+hv+F5nc=;
        b=qS79uQP9tK+tFDTR4rZ8X8fvvYzODLZ0MAjR1P8T9m5/aN9U666FR8fOvLZvU62KJb
         /Jfl9dje7cd9iRjTruRqe4QlKUAXLaDj1aUw/6QPtPzOXi7EKfYClzLoby+LSCZFiP/4
         BdpjKSekvIMkDkRfWhXX6Iu9Xz4RxfiMqEplcVKJzYe31xN6N9LR0HiP5gUT6LiN9sSf
         RZZGKWXR9Y3qvHMdxku6/0pdm0uvgHRyDKK0ANaNsWuiWR9zztzvMT8CRGuapbGOEhRE
         oGM08PJfHk1gUgYL+4CQ/zWP5nlZAsdkg1vyP3rCxI+t1JYrIyrmf9FO9kjIFXiAfkwM
         rcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZesZ6O765cPopeyel8yKHxm28ifXaTYkteY+hv+F5nc=;
        b=3XvMO1hV25vqTmq3xFbLSRD+6QooMXkZtCTRqcEyAI0fqMG80rbMcotl8AsEu0mw7T
         jXG5iIGl0agxXbGCwf4WtHqk8Xzh3RKHZG3EGrXV5FrvfoPvq5i943J4LaLKvi4WluDu
         Oev0KvF2j2WNDhauOa08ZsoOqUf7rhXqaSyKBxFL1u4zXDTQMChwNGEG0l1EvFGmRxcs
         PbQu3mYfVH5v00Lq9yqSpRC1YzsgTy/SMxCnFvCPEQcw9d4u05GrluXOFUe8WHF+J/4p
         WvxgJ0/F/D9zn54A2eL4Ad7xP9saSoxb6ciV8ESsUGZ7hOUbglbeKR6uuodcVzf5uoHX
         coYw==
X-Gm-Message-State: AO0yUKUmS9P8udkR3y86swN0glG8vXUORQplhdOTU9Y6WGo4qqx6fiZw
	SkKW/PN/cSCzUnX3T2fkqg1O3w==
X-Google-Smtp-Source: AK7set9k7mN5Id553IfFvspFJotRYHTYjINaH96bAFxRYOjdEylLggakRhZbMS+bcDU4VTQNFrKMXg==
X-Received: by 2002:a17:902:f68f:b0:19a:6b03:c375 with SMTP id l15-20020a170902f68f00b0019a6b03c375mr6909254plg.0.1676545386135;
        Thu, 16 Feb 2023 03:03:06 -0800 (PST)
Received: from [10.90.35.114] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ff0f00b00198f1de408csm1018874plj.268.2023.02.16.03.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:03:05 -0800 (PST)
Message-ID: <65da1862-364b-9500-4be7-a463a12e6a7f@bytedance.com>
Date: Thu, 16 Feb 2023 19:02:59 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] iommu: Avoid softlockup and rcu stall in
 fq_flush_timeout().
To: Hillf Danton <hdanton@sina.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Li Bin <huawei.libin@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>,
 Yang Yingliang <yangyingliang@huawei.com>
References: <20230216084902.1486-1-hdanton@sina.com>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230216084902.1486-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/2/16 16:49, Hillf Danton 写道:
> On Thu, 16 Feb 2023 15:11:48 +0800 Peng Zhang <zhangpeng.00@bytedance.com>
>> There is softlockup under fio pressure test with smmu enabled:
>> watchdog: BUG: soft lockup - CPU#81 stuck for 22s!  [swapper/81:0]
> 
> What is your kernel version?
Rcu stall occurs in kernel version 5.4.
The test where the softlockup happened was not done by me, so I don't 
know the kernel version.
However, it is the same as the code logic of fq_flush_timeout in the 
mainline kernel.

>> This is because the timer callback fq_flush_timeout may run more than
>> 10ms, and timer may be processed continuously in the softirq so trigger
>> softlockup and rcu stall. We can use work to deal with fq_ring_free for
>> each cpu which may take long time, that to avoid triggering softlockup
>> and rcu stall.
>>
>> This patch is modified from the patch[1] of openEuler.
> 
> Because of a timer hog observed on your system with 128 CPUs for instance
> does it make any sense to ask Peter to apply the patch for his 2-CPU box?
What is 2-CPU box?
