Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02D51F178
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:51:58 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-56c4c4e822eso3919776eaf.3
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691509917; x=1692114717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dieaelpb8cf/6AdAr55brJLG0Fs7WA3oHuASbb8g8uo=;
        b=BCKw7ZrJMJ5MHsmDYog5mQgyCUwaSji5cJHw2USlykKfA4X2T3W3pMH4AwEF43KJUi
         W7n8991MYx5wvMjeSIzjT76IyRabzAj5hLXCYWK+hVMFhZGX2KH1O1ruSuRoGjv/LT4D
         PFE5QMvf597ZJHS26OPUZEpK4WsE1OG5onLkKP0RYxlKoKXBc/OG7YgsqHjtDpzWgyE4
         c1sYrelS8xJQcsSSeFucvr43wnlmLNuWD7qgm9P/OKc4lbBzk4isQmA88WnPxmsCzV6P
         S+GJn+hVbbG6qi2rci7aG/nHoYL8gfhdBnqmKU+ttUmHuqUeXwLWBRMKgEauVo0OONIY
         PuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509917; x=1692114717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dieaelpb8cf/6AdAr55brJLG0Fs7WA3oHuASbb8g8uo=;
        b=H72cpE/+tZQSSisFtQBiErv0Y4aYhtdj1f2uMWA0ntS4XiuNUG5EtZRBq9fO+Wqz+i
         YI9Tu+NybVerIwQMQGQYCXvlNi/7oL9ksyo5BbFvlz23UaEDO7mlKoaUodXOU0oArct0
         Otr0mGic5mGYEHTEnVpQu6qSMFhvonKeYH9lq1uoQjnrXSwu8TbVPnZSj+Bhk2h6v3ch
         SDuazGlvrDiBHvU4vGhiH+WhvK5CmaH0sntra8PuNhIOgebPgWWRNutJMYwzSJ4C7Cbg
         +6NKruTWsI/LSGpGRKtuqDt1iuxfLYGn02Hcva9S5UbBIDDIRwL7LqlA+9W/cJ0Z3fH8
         Kjjg==
X-Gm-Message-State: AOJu0YzgcsrP/5DUmnAKOcdsgI3EBpJ8rzsjJl7Bb0cn2CAakyoIioRP
	gwYaDlVLsxED/Mu/Gn7e91W3qg==
X-Google-Smtp-Source: AGHT+IHOLR/6AJ/L+tYp5qv/PCcELgHRoF+5lD1CE7PN/rkM+c7EIiGOaUmFZyIwhRd6mKbtzmGoBg==
X-Received: by 2002:a05:6358:7e46:b0:139:5a46:ea7e with SMTP id p6-20020a0563587e4600b001395a46ea7emr7567393rwm.28.1691509917687;
        Tue, 08 Aug 2023 08:51:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x25-20020ac84a19000000b0040ff234b9c4sm3418384qtq.25.2023.08.08.08.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:51:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTP00-004dUE-O2;
	Tue, 08 Aug 2023 12:51:56 -0300
Date: Tue, 8 Aug 2023 12:51:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 10/11] iommu/amd/iommu_v2: Add support to switch default
 domain to SVA mode
Message-ID: <ZNJknPzjAssHAnKq@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808100232.5977-11-vasant.hegde@amd.com>

On Tue, Aug 08, 2023 at 10:02:31AM +0000, Vasant Hegde wrote:
> Current iommu_v2 module allocates a secondary domain every time a
> device driver calls amd_iommu_init_device(). Then it detaches all
> devices in the group from the default domain, and reattaches to the
> new domain. Finally it configures V2API mode.
> 
> Previous patch added support to switch same domain to SVA mode. Use
> these new interfaces to enable SVA mode.
> 
> Note that even with this change, PASID is managed by device driver. This
> imposes restriction where there can be only one SVA enabled device per
> IOMMU group (same as current behaviour).
> 
> Finally remove unused functions.
> 
> Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  2 --
>  drivers/iommu/amd/iommu.c     | 37 ----------------------
>  drivers/iommu/amd/iommu_v2.c  | 59 +++++++----------------------------
>  3 files changed, 12 insertions(+), 86 deletions(-)

I'm glad to see this code go, but my remarks are basically the same as
the last patch

amd_iommu_init_device() should force the kernel owned GCR3 table, not
mess with domains.

Basically all it should do is get a ref on the GCR3 table. A ref may
already exist if the GCR3 is already being used by a v2 RID domain.

Jason
