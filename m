Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185712904
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 13:06:44 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso23251943pjb.3
        for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680268004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14bpLXKhsGbcNPJuXxXGVYE6w75UYQ85KK15RjcJ7NM=;
        b=J+rhCmXUXYpIA9Z4hqSg12/qcx1JRwMtRVYOyRG1oZdWSz28BP+6taWx8MpvgyPCkf
         z/4Z1gf3ifZu7a+4JHaMc4GEF4BFvsIPuMIIEjj7U/NR98vHHqiGmtXWHjfeSfoPCU5I
         XIrr9MIr/8N20eLT8RwMJWWWLhiqofH7bkjLfIEthvekHDWWhDw7n66g3vOaxfXRkSSV
         wlPfMDe8Qqp9RxBouFY0LbY2ZpW40dfnn3/eAb6CV+6MUCjbw8MmCUw6Plpk27E0kH9Q
         u5jK2hElNCL/LH6xv2ZSmQ1M54Fp4Paq3bqNEn7EtFfObQDHipQTMyqs2vTX0L1U/+Ys
         7EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680268004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=14bpLXKhsGbcNPJuXxXGVYE6w75UYQ85KK15RjcJ7NM=;
        b=WZ5MhnK/TtM5E4NXYVHWhJ0kf2uV1Mvsdwvea62PdYGGwHwRIBbut5Zefv7UP1gQO6
         aCAMn+uZC0ADmg89CrxJcuSCJtQGHL2BXMRJLgRQiDp/eLwkSE29GxshaAPFwEm8IDA2
         o/JjUi+hG0cOUtlJfznxj6ja6WEIVR1ndur/GAF6iSLSWPulSuNl0qdkUkK6srull89F
         nL4SQYHn81QQqG9ZDs7WsNcWq5GSQcYHf/MnoB4CuTsl6PU8QcaAk9wm/8a57RXf+5Rz
         0DLMmIOEXEZef0WvpuCyJ8G066wgXYVFvWJ6q1YoE2DxuU8QMlRWr/Zl25F9imQXngSG
         KAsA==
X-Gm-Message-State: AAQBX9dcCKkZaWQfzTYQIVOJ/a3FnSh2j7w2fFu1H8hy8sDQORfq9XJY
	vhVpatcUIa+hw4fbUS4RNWo=
X-Google-Smtp-Source: AKy350btzesFQdGHg0HNraW7MNdqEP2cgp0ZyzibFgofLQwudP9lvC9SJrYkNOkcOtLGChmUI7NE8w==
X-Received: by 2002:a17:90a:e7cf:b0:23e:f855:79ed with SMTP id kb15-20020a17090ae7cf00b0023ef85579edmr29725179pjb.28.1680268004333;
        Fri, 31 Mar 2023 06:06:44 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-236.three.co.id. [223.255.225.236])
        by smtp.gmail.com with ESMTPSA id gz21-20020a17090b0ed500b0023f355a0bb5sm1465269pjb.14.2023.03.31.06.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 06:06:44 -0700 (PDT)
Message-ID: <730b79b3-5adb-c8a2-8eb5-8790860fc1a3@gmail.com>
Date: Fri, 31 Mar 2023 20:06:37 +0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC v1 1/4] dma-mapping: introduce the DMA_ATTR_MAY_SLEEP
 attribute
To: Petr Tesarik <petrtesarik@huaweicloud.com>,
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Kim Phillips <kim.phillips@amd.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com>
 <ea0646e0e63380bb8595fbac81c23aeca30feae9.1679309810.git.petr.tesarik.ext@huawei.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ea0646e0e63380bb8595fbac81c23aeca30feae9.1679309810.git.petr.tesarik.ext@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/23 19:28, Petr Tesarik wrote:
> +
> +DMA_ATTR_MAY_SLEEP
> +------------------
> +
> +This tells the DMA-mapping subsystem that it is allowed to sleep. For example,
> +if mapping needs a bounce buffer, software IO TLB may use CMA for the
> +allocation if this flag is given.
> +
> +This attribute is not used for dma_alloc_* functions. Instead, the provided
                                  dma_alloc_\* (escape wildcard in order to
                                                not confuse Sphinx for emphasis).
> +GFP flags are used to determine whether the allocation may sleep.

Otherwise the doc LGTM.

-- 
An old man doll... just what I always wanted! - Clara

