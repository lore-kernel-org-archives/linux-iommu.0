Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987362B
	for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 16:51:22 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-64b3ae681d1so5809126d6.0
        for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692377481; x=1692982281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5wHNvyc4kj4DIWzYiMbiyI+HCxaIUhJ8iQWDMldzHY=;
        b=Wij4oljWXswRlQaeUNTvsnjx/wtiwV9FJrNHwESFZmmM77ycUQ5M/bi0Y1QcP+3gi0
         0E8qV+F7rqoMYKF0J7sttGFY5odG5LXd+D+ThrmAbez5UYC6IklDm4tW+xbGUfddNuE+
         99cOqCqkbJMWni7XjoU96v+KG/LSLaKnD4B/TUzK2g1fhbfNJ93bzFpxuHeIH99P+vL/
         wqWYliqrXsgHYDUqX2QbuF6+VRULy/84KZj+Dy+3U8fEfT98POZKb0R1D5xjVKCoTizG
         GY6niSJ4zk7StCK1yoOOqfxg5jXUtjS6Su4I9xgx1gZSZI/37kgkvhS4qBvFhBOiG8nx
         QFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692377481; x=1692982281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5wHNvyc4kj4DIWzYiMbiyI+HCxaIUhJ8iQWDMldzHY=;
        b=NJoAgd2JIpXHvd24ManCgdJ1rmBm0tVUejo8VfbLSp0ahRzmyXI6gMrrl/i2BRUQ3K
         Q9dpXumYj312sUxGePl7vLFWoKf7/8Em1G62nLehmYTgyrAWr0FeSllLeOtbdiG0hulw
         OGb/vNWfvuS7x206bYrTfrcWbseQS8qDF2hX1ygDyi6CZ9nUcZQjo/5/2MO4CCp4ZdW5
         /c0AhC+CzJb3XdS4LNiczi3+TF+O8flk/+YA25jqvDpDQA1uT/Y6w4WGrFc4dgi5ANwa
         UKaIRKpfkmYityVp77Xf52EYXnALAdLUXMwlf6aUZGzjDLnUoUguar02flIhum9qxXiy
         YeVg==
X-Gm-Message-State: AOJu0Yzj3EzIHtQzf8yn9EbA9UiqMU1WUOAW9CIcuiLrwQ5YJ5VHkwLx
	T17BjFS5f070psKLwoz0RMUZgA==
X-Google-Smtp-Source: AGHT+IF/Wve8j/fmppTqTnBXO0hLo0dLJNLe8ziJKKNByZxGMh3nVZXI+R6vLF3ZCmKm1TiRHbCySQ==
X-Received: by 2002:ad4:4bc8:0:b0:647:21a8:19b2 with SMTP id l8-20020ad44bc8000000b0064721a819b2mr3064178qvw.19.1692377480949;
        Fri, 18 Aug 2023 09:51:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a19-20020a0cb353000000b0064aa51f9978sm803027qvf.115.2023.08.18.09.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:51:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qX2gx-00Acor-Nt;
	Fri, 18 Aug 2023 13:51:19 -0300
Date: Fri, 18 Aug 2023 13:51:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com
Subject: Re: [PATCH -next] iommufd/selftest: fix unregister device
Message-ID: <ZN+hh+MvH9yQNACH@ziepe.ca>
References: <20230816081318.1232865-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816081318.1232865-1-yangyingliang@huawei.com>

On Wed, Aug 16, 2023 at 04:13:18PM +0800, Yang Yingliang wrote:
> It should call platform_device_unregister() instead of
> platform_device_del() to unregister the device.
> 
> Fixes: 23a1b46f15d5 ("iommufd/selftest: Make the mock iommu driver into a real driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

Jason
