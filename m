Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555177C
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 03:56:06 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id q9so4677816pgq.8
        for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=GdtwTg+D4nT/COBO+AtXOA77edWo+Q4jHVx++0FwAms=;
        b=FYfeDqRO1LSKwsqgAJWNsoPNtSEldUC0H6Ro/IRHBojFppptOvg700LJYDphc720Lu
         AwGdP0+LbUMOsefRSU3lQgmM9wOLWZ3VYPaN3gqn9wBfS2ZD2cejdEOr4MeqxGvDf+Fu
         MNaU0py2W+vFxOgPqL3L+zUlwaplUHzUk84JxSTKMOcPSeLhTt8sfTLtxmZgE4BdQV/r
         4bwoXdNf2FR0aVg0biV43c1zCtfEUS7DPQXH6jAFr2c6gjmC6aq0EewQCFd47pN2R5d2
         VbW+u542DJjTJpvQviZWm4k8nXoEQpQH2eeWBDjn6LBPHfAVdMGPP8F0Nd50vYNie5cD
         IJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=GdtwTg+D4nT/COBO+AtXOA77edWo+Q4jHVx++0FwAms=;
        b=jVQRPY6xPwqqKaDDstkqCNPx02AVa6gnszrBwZH4McXjDn8IyFbrOVsGQWKAzM/+lF
         4L+sNK4ZuL+wOEziXSO7PVOtPayKDXJ8YAQqx7884hbHgCA8aIy747EaSc1BS0mpMQ93
         +CrkXUtoNGSFKhIp2Tg4MOQn4Sfxw5lS2U79RXwx8hja0O5qAU5WOouqeijoLD/k5Oj2
         tFX9CSK8SwWZ++sE5i/kTOsdghackDkJW+FlZDI/0PU4Fcl46/tK+3RaZ4xLzRPd9hgh
         +cdvGt9MLWGVf05tYBNuTjFfzKEthMBKq6TGqWXUmLG7Isk6RkQC5KUFPmg2PY0156L6
         FD8Q==
X-Gm-Message-State: ACrzQf1UImo4QLn6HMbWrJRZ4wTIRndDE8JiF8RA9zw/b/Htn/Rz/ZCs
	Zo8lNotvF26O5JXse00S8H/neg==
X-Google-Smtp-Source: AMsMyM7jK+7f/QgumLk3HUuCmU3usUyavWCyyZrAZ2qV4NLFFk8ZX3rgB3gpYH/3bRun7nZ7Lvpqdw==
X-Received: by 2002:a63:b64:0:b0:439:8143:c184 with SMTP id a36-20020a630b64000000b004398143c184mr22774576pgl.22.1663732565567;
        Tue, 20 Sep 2022 20:56:05 -0700 (PDT)
Received: from [10.255.231.119] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id z9-20020a62d109000000b0053e794e66fcsm773263pfg.107.2022.09.20.20.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 20:56:05 -0700 (PDT)
Message-ID: <bdcf9676-7846-1f14-1dd1-80cb9dcb0794@bytedance.com>
Date: Wed, 21 Sep 2022 11:55:59 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v2] iommu/iova: Optimize alloc_iova with rbtree_augmented
To: "wangjie (L)" <wangjie125@huawei.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, haifeng.zhao@linux.intel.com, john.garry@huawei.com
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
 <42909903-5b6c-efe8-9ed3-3ac012f1a421@huawei.com>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <42909903-5b6c-efe8-9ed3-3ac012f1a421@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> This patch seems to solve the performance issues i have.  Currently my 
> nic's rx performance is unstable in large-capacity scenarios. I applied 
> this patch to 5.19 rc4 and tested 8 times rx performance in these 
> scenes. Here are test results, "before" row is the result of 5.19 rc4. 
> "after" row means 5.19 rc4 with this patch, the unit is Mbits/s
> 
>      1    2    3    4    5    6    7    8
> before    55430    76701    84194    77560    88292    90106    87770    
> 77273
> after    92770    92767    92792    92764    92742    92696    92781    
> 92756
> 
> Obviously, after using this patch, the performance is stable.

Thank you for your test. Can you add a "Tested-by" token?
I plan to update the commit message in the next version.
