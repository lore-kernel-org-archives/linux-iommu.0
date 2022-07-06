Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E87C
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 19:28:50 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id he28so19688801qtb.13
        for <iommu@lists.linux.dev>; Wed, 06 Jul 2022 12:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=u+7X3QYC3rX8DXnJctGF9cxN8tdSlB8cUEi2Elli9qQ=;
        b=AcPxc8/HSOCbzA4UoiHznfSvpkW/mgd1l99h7fYxN4IZo76mYD3NsIsUkYhX6AeLx6
         EjcRg5P8Gc6JbzNqa1JKYAMmoF+tC1223wF3snnSNcic5L9bm37dn/zPZ/payKurpBb5
         oZF056QXhvZVj0pAkXpLjpQvM7SlWIAvVwYUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=u+7X3QYC3rX8DXnJctGF9cxN8tdSlB8cUEi2Elli9qQ=;
        b=AQB1QxTt4S9vaeZo+USdp5GY5zyyXJ81cX+WPy+uks2t77FbbRUW7F+B6joWNMlVMb
         qpOnsXmWRjDbI3x+/zNGOl9pZXe3SyJvDSkFZZqPbKS+Mca4xrls+nIqjFKFrmn6b9//
         2W13kWeSgcsXuYIGMwrZvVVYj5rU188LFITKQ6e8KwWfwwftROfRpd5RJpTVeCOO7+x5
         XC8j19uNjrl3FiBL4TWAGH+xU0J60apEcW4GLczTX6ztB4+33qRlM9GPAH/kov2GpBPk
         bjwYfCG4JwLaZ1UCD50DyzS7+Q13Bh5j64bmKfj8wXf7t+/gDjX/wFbtQCK0i0z9yQWh
         UVwQ==
X-Gm-Message-State: AJIora/gJcIVtKPS8ySdnZ8r0Px7SWzQevHN4JCB6bRFj61FoFcWQ3E0
	qK3bSgQVvOG67/LfmFwajkbtISk7GSDgog==
X-Google-Smtp-Source: AGRyM1ssnNkY9/YDgI4vwnmHo7TUuwDvehPuU578tphqsnRmL652kQz71s2bxUgg/Zy+KBu8qerQGg==
X-Received: by 2002:ac8:5f09:0:b0:31e:9704:dfab with SMTP id x9-20020ac85f09000000b0031e9704dfabmr277501qta.375.1657135728597;
        Wed, 06 Jul 2022 12:28:48 -0700 (PDT)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a0bca00b006af0ce13499sm30393978qki.115.2022.07.06.12.28.47
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:28:48 -0700 (PDT)
Date: Wed, 6 Jul 2022 15:28:46 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: iommu@lists.linux.dev
Subject: Test archive at new address
Message-ID: <20220706192846.d437mu4wojuyyxox@nitro.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello:

This is a test message to check that it properly makes its way through
https://lore.kernel.org/linux-iommu/.

Please ignore.

-Konstantin
