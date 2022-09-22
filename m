Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC32CA2
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 18:52:25 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id l65so10174227pfl.8
        for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Il1n+p4EYijj6sMX+qTskkavLcV+LCxu/c4N5YGuAz8=;
        b=2K4/5gRHOw+nUVM6Q0jlqIaxrwXepL/8XbhbHtaGBxUIxiEIS3jSiRB6a7G3n4aX6s
         SwqblsFwJZxCUCnK6vPdKIBm071K9yD7o5Ib4nKbD99l37gftYjkjNaGV+IxZA6X/uKM
         cdlmS3FOvAtL0IkjVAJv5Bek2QUSSS4BKxgie8P7lpntt8PNNj/fnzzWqmdQm/gQCH7X
         IQg+s4k6vKpnvJQo8IqtyHl0jsLDhBMCh8BI0zDCSdBbIAt0ssXBR9ezhs+WckhQkvED
         QVavzuyE+YzR1ebk7P7YMDYh//duMfSjordbUO7Clid1RNVbpBbarVwzqT4Nxy8jKmaQ
         EI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Il1n+p4EYijj6sMX+qTskkavLcV+LCxu/c4N5YGuAz8=;
        b=0+Gc4+LzKlzrarN7RxNlDs4+TAIwIVN7ICSzz6mWS4Bf/9Ae8Q8YIRe1pLiaD81VLB
         8SN4xrkkC7jKcO2xYgeI441DvI84WnKyj1CZQo8aH9GJtPCZqvAIAU87Nxpf+pwo+pBc
         FLadmApagNgNw+IuEaeb8jJeW2RPSvH+bys5ONlBUTa3pfUY09H9Ff/yq+HDlKW6DnQP
         Cg6HLYObg3rShwm2wXSXjwv0KJIcCOyZ5PtsOfLVr6v0CoZJf12Dbk58Mt4cIqtqtPk7
         7kBwGmAlMg6UjWOFDL67DKzO6MmV/wuxs+QGfP/iTMvPTo1oTVs4t/9xvbaBB1MlB4TF
         DBmg==
X-Gm-Message-State: ACrzQf1UpOdZBrD5aUZAxrtbj7klGLn71FlQIgQIdlOURCraua66L8CC
	RQ9jxU04vxw0En99TiEiM2fvEw==
X-Google-Smtp-Source: AMsMyM5GN8+12qE4fTmSo6QHNROyAl191fsN/T0krzY3LYnwrkSKgfbUNjXRj5Vy9FjgBJd23x040A==
X-Received: by 2002:a63:5a5e:0:b0:434:b739:206f with SMTP id k30-20020a635a5e000000b00434b739206fmr4188149pgm.82.1663872745268;
        Thu, 22 Sep 2022 11:52:25 -0700 (PDT)
Received: from [10.255.231.119] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001754fa42065sm4441763plk.143.2022.09.22.11.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:52:24 -0700 (PDT)
Message-ID: <db791538-0af2-b7c0-986a-6a9492d0495e@bytedance.com>
Date: Fri, 23 Sep 2022 02:52:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [RESEND PATCH v3] iommu/iova: Optimize alloc_iova with
 rbtree_augmented
To: joro@8bytes.org, will@kernel.org
Cc: wangjie125@huawei.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 haifeng.zhao@linux.intel.com, john.garry@huawei.com
References: <20220922183114.15135-1-zhangpeng.00@bytedance.com>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20220922183114.15135-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

Compared with v2, v3 mainly updated the commit message,
and set the upper limit when scanning the linked list.

In the normal case, the performance of this algorithm
is almost the same as before. In extreme cases, this
algorithm is much better than before. And this algorithm
does not bring additional memory overhead.

Comments welcome.

Thanks.
Peng
