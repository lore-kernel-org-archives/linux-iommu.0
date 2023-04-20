Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385ED17C9
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 01:20:59 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1a68f2345c5so5174715ad.2
        for <iommu@lists.linux.dev>; Wed, 19 Apr 2023 18:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1681953658; x=1684545658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4G5iWqKHJxSwy7otSWqpSuJ4dkrcHpp9DjCuFqdPcQY=;
        b=KWU6Wr7W5q3DKWLLWNmK6ZyKqVd2rPC0hnoYICe2t+1X8DY0H9nUFkR2viDWBr58RX
         EFvIL2sJdung7OVxMyhsJqZnFWsOEjY9Sr4yIj8artWZiyGfhqNbPApHePStm9l9ApGQ
         cvorrbMkpR5pUnKpftJHpZQSSEsD8HqeldV+6Htjw1U+7qpbky9YZhextzkwY+jZNsJW
         x0pk5dybTVlomkWojCBaDtIQkVeYaBwq82VVY0tAt2RO/L05DzsAChurxgmXgYlqY686
         UdDQAr3/m/Qg518urdcsP5bAig9chfg28QbRUSaJ75ps5AxXi0kUBn5RutJ4T0CPTwSB
         ptYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681953658; x=1684545658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4G5iWqKHJxSwy7otSWqpSuJ4dkrcHpp9DjCuFqdPcQY=;
        b=jf0IYrlOUC8eZGgf2+s6mtLjLGYboy8xVrNwsWTYAngmFvUu9TND5nwJ+x+W9Q4819
         ZsWXbn4UfzQBH0y/IzIcf6t3jzp0L2aWofl6Gxoi6nNR/AXws7v9je+X3/rlxrmhuFbW
         g6ZNZl6y6mRvZ3CVlmZIKm3yu9BYz8b6kX6Yuq01751xYdTy/3cdEum7DUU4ZbcQPwXJ
         ovRDlS5223WKqi7+F2OrAUO0hAeKfk9Y2kpkbnyh8ypphgLXdWXNeU3rcvj2mEQPqAKT
         d+mte43hGqku1Zx1xoKi/oYquvwYfvk0McsPRTBYFWLojxdcdLGPLZxZTIjU4k2LjPlG
         glFQ==
X-Gm-Message-State: AAQBX9e7bs2FOs0vVwKlzE3ajLrucYEochoor5Ki3a61mPF1x2nY6JlY
	/O2j+xQexqPM7GciUyZwd2t4xw==
X-Google-Smtp-Source: AKy350ZJIwb6ogd/xuutAw2a7aGiiUiBrw7rALqHxk96YbsZ7SlYDNQaxrgnH+xpiVJuGH8p4QQ9VA==
X-Received: by 2002:a17:902:d48f:b0:1a9:2cbd:d24b with SMTP id c15-20020a170902d48f00b001a92cbdd24bmr1036074plg.50.1681953658588;
        Wed, 19 Apr 2023 18:20:58 -0700 (PDT)
Received: from [10.213.103.179] ([157.82.194.11])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902728100b001a6b02659c0sm75066pll.159.2023.04.19.18.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 18:20:58 -0700 (PDT)
Message-ID: <c59f4a01-16fd-0ab0-622e-614b253059a5@daynix.com>
Date: Thu, 20 Apr 2023 10:20:55 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, eric.auger@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev
References: <20230414150744.562456-1-jean-philippe@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230414150744.562456-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/04/15 0:07, Jean-Philippe Brucker wrote:
> When an endpoint is released, for example a PCIe VF is disabled or a
> function hot-unplugged, it should be detached from its domain. Send a
> DETACH request.
> 
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Thanks for the prompt fix. This indeed fixed my workload.

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
