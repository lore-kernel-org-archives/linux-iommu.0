Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9314011;
	Thu, 20 Jul 2023 23:19:03 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6682909acadso912404b3a.3;
        Thu, 20 Jul 2023 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689895143; x=1690499943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibwR2n2ofWT45eqyn7NdkOyxsAPd/bEJkQ0/gWWZPag=;
        b=lXzYCfCVbZ0XFYr4h1U2cA+eanuunlakdjkGeq0zjbSuUw92kuJhjFPvqvehuVM/MR
         d6dOtACrgZmq8zypv+uqPq27NBSop8KuKAXQi67hPm6KDQofw6Yw0FXh6k9v2DvsE86X
         +nczzNvFdpB+JoZriycHeOUDYK3ot62KqY8Vl2sKo6vyYx+5c7vKJ3uH2W5qhIrVkqbC
         FZTbUZVOgEAoGKoluTWSJ2gVKi4phOzNoClt0OAILWaUHGMYWP4KBtxtGvbNjSQ9RwnI
         LkM4RtiLcmFhEMj+9v5MKT+ezh7OeqI+otg//ZyvMXzGEBxQ4MIUm67RjBehPHBgORLM
         avow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689895143; x=1690499943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibwR2n2ofWT45eqyn7NdkOyxsAPd/bEJkQ0/gWWZPag=;
        b=Zf2xXrP0/wwK95ZYF0Eg34KFId+wni3t3Or2uo2KJLygamYHFasu8wtSXXxC3I8fvA
         Dg61wpeGpYbiOQVpaDg7JJm/601a/zHsvTt62ft1+MHneUj3qet8//ozlqBs9YAuzEeI
         tIyej+cofdoCyCYtN6JeGJvTM1OtVwclVgF0CbJE4DdloiRimppnj+b6PjDLpiGMAiom
         +mS9h82GSEUZ8TJMzD94Zpa/+jkVjK9Hry/5UEerRTjTD1Qi1IBjNWtZutwUAd5X3ydn
         /6pjxNlXOFLGDaE24uFMyIqnCZDs5UmCxMiHg9E1/HErTWPJZJfoZqnTeT8RHIvR1ETi
         zEjQ==
X-Gm-Message-State: ABy/qLbjJ0qvLjDw/B8Rhw+4t4Y67uzr2kyugbQWW5kCb3gdEWboS+mC
	sAf76CY3uYWheZL8Jbohq/E=
X-Google-Smtp-Source: APBJJlFUvtKV9g3xN8yZiX1eceYAxHrBp30rIaSA9fDoBvJ552sVhZUdbrWXiZ8RM+whGFBzTee4pQ==
X-Received: by 2002:a05:6a00:814:b0:668:7292:b2c2 with SMTP id m20-20020a056a00081400b006687292b2c2mr321769pfk.2.1689895143276;
        Thu, 20 Jul 2023 16:19:03 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-98-231.dynamic-ip.hinet.net. [36.228.98.231])
        by smtp.gmail.com with ESMTPSA id k17-20020aa78211000000b00682562bf477sm1708783pfi.82.2023.07.20.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 16:19:02 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: sven@svenpeter.dev
Cc: alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marcan@marcan.st,
	minhuadotchen@gmail.com,
	robin.murphy@arm.com,
	will@kernel.org
Subject: Re: [PATCH] iommu/apple-dart: mark apple_dart_pm_ops static
Date: Fri, 21 Jul 2023 07:18:59 +0800
Message-Id: <20230720231859.3699-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f176c331-f8cf-4a44-8ada-7d9c958b17ca@app.fastmail.com>
References: <f176c331-f8cf-4a44-8ada-7d9c958b17ca@app.fastmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sven,

>On Thu, Jul 20, 2023, at 00:20, Min-Hua Chen wrote:
>> This patch fixes the following sprse warning:
>
>typo: sparse

thanks for catching this.

>>
>> drivers/iommu/apple-dart.c:1279:1: sparse: warning: symbol 
>> 'apple_dart_pm_ops' was not declared. Should it be static?
>>
>> No functional change intended.
>>
>> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
>> ---
>
>Acked-by: Sven Peter <sven@svenpeter.dev>

I'll submit v2 with your Acked-by tag.

thanks,
Min-Hua

>Thanks,
>
>
>Sven

