Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA947F
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 02:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692843549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjyrJuiuyw5/c+ULlykdTnAo9m0wv1wzEmUNte99zG8=;
	b=NcsW9QDrW73YmarPyuFtp66UOmAYW/17eXlMlBzcKX56ESmtOD5ynhuFook86PhgN3J1ym
	eB+fjTd474xsFIEkJsf4CUZUhbQtzsb08YdQqbT0ldNutjvSR9niG8vtgB3JxB1PmcqtU4
	IvbEm0X+g9/6T172CEeWVBPugKW4fcc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-mCb_f1o6Pga1JoZT1Ie7bA-1; Wed, 23 Aug 2023 22:19:07 -0400
X-MC-Unique: mCb_f1o6Pga1JoZT1Ie7bA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6491907dba4so3678616d6.1
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 19:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692843547; x=1693448347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjyrJuiuyw5/c+ULlykdTnAo9m0wv1wzEmUNte99zG8=;
        b=CMhPAatrQbrisLy/DsydNSaTatMGpjz5d8DqLMrXDFXbL8Qt98mDELZ1NRQyagDz4V
         Ewd4ovIw5sMrJw55pHduWfL+mprMr+ug1qwUfbGZEfMbgPakcLRWMUCtAryR8TWYb2I5
         MZLUQQhO6y0CMr9foaAsnRkKjXYMBQ+av4HW0vPBSB7RvHD+un3F/LZTNsIDA9ewgZta
         usk4TdTGH6TwAOI/V7K15kopkUCS5ONOrl19mDhGx7RJPSFFcZT12ambrljMaGGWmY/L
         XH1w9N/4gzHlGq2v+SPabiLhIiKJOQoZLK58fPT4w6ysn78LZjx+cQjuTZrTGM/bscS6
         Dyzw==
X-Gm-Message-State: AOJu0Yxowzj0tbRopHsOeXuVR3tbYAQuMR3UQXkWzeHR2ws3AJgtSSK2
	JZQsona1n58NJHawiJMWAV87btXwFYIefRM3ZRB3GLkmX3FSSo5RGGCZ1adKFjqi0J5KDjXBgeW
	c87AT9MvGU8GMbl4=
X-Received: by 2002:a0c:c247:0:b0:647:18f8:36eb with SMTP id w7-20020a0cc247000000b0064718f836ebmr19657842qvh.27.1692843547223;
        Wed, 23 Aug 2023 19:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsAyQTN7E+yf8zdrnxg92Q7QB9sk70F7PZ9o/b1wFxrUeryV9zDHBgM3QH+yCkPUuUWW3DSQ==
X-Received: by 2002:a0c:c247:0:b0:647:18f8:36eb with SMTP id w7-20020a0cc247000000b0064718f836ebmr19657827qvh.27.1692843547000;
        Wed, 23 Aug 2023 19:19:07 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id d25-20020a0caa19000000b0062629cbff11sm5022757qvb.11.2023.08.23.19.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 19:19:06 -0700 (PDT)
Date: Wed, 23 Aug 2023 19:19:05 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 13/14] iommu/amd: Enable device ATS/PASID/PRI
 capabilities independently
Message-ID: <vk34wbtpm35qd66k2o4srkt6ypfxl4yk4acbqohxurz7hovmb4@pdkstw62ctes>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-14-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104227.706997-14-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:42:26AM +0000, Vasant Hegde wrote:
> Introduce helper functions to enable/disable device ATS/PASID/PRI
> capabilities independently along with the new pasid_enabled and
> pri_enabled variables in struct iommu_dev_data to keep track,
> which allows attach_device() and detach_device() to be simplified.
> 
> Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

