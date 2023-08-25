Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613A9101CA
	for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692982504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w+kuzpbbgam9B45lp1NOAHkhMMTQTFbfFGLvI71Il4Q=;
	b=Ep9QNxU1zEafnEg5ZDk0BtIoDJvwewIw572faeqrBrUtR1kEq8I8fQWZ9rx+tm/k0zr/sO
	gsD6cJBrMOPdXCOmwUMo9yRUl63FDx8N1Cz7Nlb5k3lldpfy8utfvbXIGcBiAr8accNhSS
	4hq1qBM8MLJ1+8ekJ5B0X7vHquXqXFE=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-B0JTPVKbP7e_8OmeK8FGXg-1; Fri, 25 Aug 2023 12:55:03 -0400
X-MC-Unique: B0JTPVKbP7e_8OmeK8FGXg-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-79a068ccf5cso385435241.2
        for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 09:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692982502; x=1693587302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+kuzpbbgam9B45lp1NOAHkhMMTQTFbfFGLvI71Il4Q=;
        b=flomsC1kU0YEJFG8XPsavhq9OQJuFo0JsY7plbxm702Jr8iye1KSjHwws/UiJYnMEQ
         70dLqWKQpRL06GwUCTMbwWfynxE0vdNfNHJzTYD4MOkrxzD4QUeOco3kBHiuAylKyxRV
         j1imkPOLhvy7Tg/a+z9lIiAon+vQrJIDNWp+usvpc1La9XTGB0ARPvqi5XQ+YQeVS7ct
         +A4M283qHuS/3kdt9RBY9RV8nN0qfyOYhnzQoX/Y6UR1B4l7TQt2xzdYwcMjhPdmsV/a
         u2kHYJXtJPAZa3JuuptGiDZgaokvBm9QcJQBcrYhyfIAcOLwZNgFvRpCcXab3KyKHe9w
         OBzw==
X-Gm-Message-State: AOJu0YyhwVRgIS11zfm8/V0JrHEmyrjmP0p5xtxSZpitQcAVuW5k5ozF
	o1xF1NkCyTplkCYveDwbIENHT3wX2r38NO4AcUvn2f59MYd9T6LMMlg3NXg59yGE8BjP/YrowaA
	Le8gqFsLujv/I5XI=
X-Received: by 2002:a67:fb88:0:b0:44e:9d4f:1ffb with SMTP id n8-20020a67fb88000000b0044e9d4f1ffbmr4661581vsr.11.1692982502503;
        Fri, 25 Aug 2023 09:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJHUcXGtBB0jsSsUCaYK4Ywqg+0sSZuvf61wthRYX4YE+f077r/a3H5gRwGIIX2XhPhD1/Pg==
X-Received: by 2002:a67:fb88:0:b0:44e:9d4f:1ffb with SMTP id n8-20020a67fb88000000b0044e9d4f1ffbmr4661566vsr.11.1692982502304;
        Fri, 25 Aug 2023 09:55:02 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id n6-20020a0ce486000000b006490a9946b6sm656091qvl.119.2023.08.25.09.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 09:55:01 -0700 (PDT)
Date: Fri, 25 Aug 2023 09:55:00 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, zhangzekun11@huawei.com, john.g.garry@oracle.com, 
	dheerajkumar.srivastava@amd.com
Subject: Re: [PATCH v2 1/2] iommu/iova: Make the rcache depot scale better
Message-ID: <ob2tqg6amvr3ozxdrjtotc6gpfzlyvftncu7jw7zgau6qso6rx@h33gsipsnmuc>
References: <cover.1692641204.git.robin.murphy@arm.com>
 <fe7beab68167c4d86e770eb309985dfd3905bd8b.1692641204.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fe7beab68167c4d86e770eb309985dfd3905bd8b.1692641204.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 07:22:51PM +0100, Robin Murphy wrote:
> The algorithm in the original paper specifies the storage of full
> magazines in the depot as an unbounded list rather than a fixed-size
> array. It turns out to be pretty straightforward to do this in our
> implementation with no significant loss of efficiency. This allows
> the depot to scale up to the working set sizes of larger systems,
> while also potentially saving some memory on smaller ones too.
> 
> Since this involves touching struct iova_magazine with the requisite
> care, we may as well reinforce the comment with a proper assertion too.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

