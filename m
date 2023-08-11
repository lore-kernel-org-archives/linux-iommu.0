Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E61CCA3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 23:50:40 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-76ad8892d49so186930985a.1
        for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691797840; x=1692402640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OaQrVTuStuUjw6cZXbNGJeGCKQwxNk+a8Exp1Wh3PLY=;
        b=jev0Yj+tEUo0FZzzEOpLveh5pEE+4caGuoIO9FtQJtz5c7Kjc3AskcZhbtBjysQIiX
         bSVpK2BXSNgJJFhedS5d/CQtI4YgurFjoNM8QzbynD/d7hSPPavPKhUQ+szxvd1exaVE
         ohbSmxhlOGH22OYHhQFAzJ/38UmM22UhjPcHjvSBRsyTl20jt3BgumxxwyAUpxs+VrH9
         I9sfg181AW7Ai731BSTga3nZGtGnEN/63poTnL0VEdsTuHUzFpHQp7lITlytZAQPJ2y3
         0ngmhMjlSzfTiVWret0z4yCmCp5lW2bJHgtJGj7nD+g3kBD9VTL+JMdz6KG+HDJ2VcPr
         AYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691797840; x=1692402640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaQrVTuStuUjw6cZXbNGJeGCKQwxNk+a8Exp1Wh3PLY=;
        b=iQZqsoP48j2fiAu4GAd1uI0d9HpAElOGq5ppREQt+8COf8JHDwxF0t3NqBXu70M3Go
         FbE2Xf69Yz7ZkebIsxb93RIgYEDfi97VxB7Zpwibg1ve2PxDOcdOJnK0GFIYCLbDHObF
         pgXGx5E7USRsb2a5lyMf7svQNVDxN9t4f/q80zlO/ZKXyBAzrBqeIF3wdhW1GZSrmuh5
         Fl3HFk3quhK9xTKzZAORCcwWa4HrqcoT2hJCZrjRbZLn5KWVT/jghjmW6Vr8GVEQPEGZ
         H/3/hPxXBfBCk0ll/kgJBypJ6vSSPdWiGvu5glat6987vBDYBQhDpm/Ig++RAPMB7KfE
         EwlA==
X-Gm-Message-State: AOJu0Yzsrzb9U4xNXSgKwRbsntGNi9GyA20o4GrKireb/2FCtF8aJdrP
	TeyE9h8XWjr4d/+uVNNQ4mpppA==
X-Google-Smtp-Source: AGHT+IEF21vi2ivTQNaatH91ar7xfBMbRW45zwAfLfgVrFDR3JnatyohfleoIv/p7iahCY8WMR4V5Q==
X-Received: by 2002:a05:620a:1992:b0:767:e04c:8d6e with SMTP id bm18-20020a05620a199200b00767e04c8d6emr4457603qkb.51.1691797839918;
        Fri, 11 Aug 2023 16:50:39 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p6-20020a05620a132600b00767660afed5sm1507313qkj.99.2023.08.11.16.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:50:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUbtu-005Wbz-7s;
	Fri, 11 Aug 2023 20:50:38 -0300
Date: Fri, 11 Aug 2023 20:50:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 06/11] iommu/amd: Refactor helper function for attaching
 / detaching device
Message-ID: <ZNbJTiolSya/3/Nu@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-7-vasant.hegde@amd.com>
 <ZNJhw8RRvJZ+R61y@ziepe.ca>
 <f08fc678-0bff-1e3a-302d-f673c952462d@amd.com>
 <ZNY1ligeAdFmILoT@ziepe.ca>
 <36a5f7ad-7d67-a818-2b0d-366722592887@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a5f7ad-7d67-a818-2b0d-366722592887@amd.com>

On Fri, Aug 11, 2023 at 10:20:56PM +0530, Vasant Hegde wrote:

> Our hardware is capable to boot with either V1 or V2 page table. By default
> driver decides what is the best mode.
> But if user wants he has a flexibility to choose V1 vs V2 page table. In that
> mode we will adhere to user provided option and all devices will be put in that
> mode.

There is no valid reason for the user to override the kernel. If we do
this for AMD we have to do it for every single driver that supports
two formats. It makes no sense

Jason
