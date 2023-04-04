Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD947C
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 11:57:34 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so33713981pjb.0
        for <iommu@lists.linux.dev>; Tue, 04 Apr 2023 04:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680609454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CTwFcHS/8yOZBWKFlMTZaPkkZCliD1k8JEi+Gd6s3c=;
        b=C1tDZMEihkEQL+ZSeKLYJQFSsL0mNqr8WR2abugowOfpazV3XDbvl1tiEu4ve5LQQ8
         CAVfecYY6QmtqG8HHPmrFjiWNmD3BgrcTxXx7dWfZWkp3PISrAcNI45XQElB7LOMrTlx
         JSHpWcDR9PZ88n8Kv9dD2gOxzoKKStHqLD2NQU64aKDtcGp3noU8/Fg/6p8eh8HN2Rw9
         GHJ+cdKP6BcvmDMrDGrF76dlBaTp/tHunp5I3SkOLqjO930f0P8z8wqciDCt6RAh2wML
         DZZm7p1N7Y4I+aJ/T821M2gsk6eizSMtRebFtcPVDNoz0TGOWFv2jdGQQdCiLufIxN3+
         2ePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CTwFcHS/8yOZBWKFlMTZaPkkZCliD1k8JEi+Gd6s3c=;
        b=uQQqv4yRjtAbE24/0klRpgz3e/Mh5R/1ZY9lttXmeBgFPlHWONTQVRMOKPVZNQW5LI
         1NedtVbyD4hywH6EgeFJyPzdWsRZBWwxQqOARh6qc23zwJ1Ri/5K+soO3MWxGwN0mUSw
         dVKU/Jsm67rlwV4g4JmZwvtHfA0uxoz9gOUutvSbaNU+BFq7QWNY+IydLEhGJ20XslRj
         SX4oH+WDcR2FVeCgW+JH6icy/XSxmpxaoHIzL9zM1PTRo3ni59S0EO7dsPhWwzesK8sU
         gQh2LJjCzvYICAPRbzZYc/Hb3Dnz3IKGaJsZ5Q6ctOkQ6Hmot7bJEX9LLXqKSWA1iyeB
         NX/g==
X-Gm-Message-State: AAQBX9eGKrEvc4ZrvbiLvT2uOVmLG9Pib0HQDVxUwn3r90urcvZu5+93
	TgBwGdpj7MsZcIax3wi9Cwsy2w==
X-Google-Smtp-Source: AKy350aD0ufDEk6dm7Sf4cDwh2C8kxgP0F4iRIpac8/dPOMgE7oTDjcBAONiRvEN+BQFuLKLu7saVg==
X-Received: by 2002:a17:902:e2d3:b0:1a2:1922:985b with SMTP id l19-20020a170902e2d300b001a21922985bmr2001300plc.59.1680609453932;
        Tue, 04 Apr 2023 04:57:33 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902b11200b001a216d44440sm8218246plr.200.2023.04.04.04.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:57:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pjfI3-006WXe-J0;
	Tue, 04 Apr 2023 08:57:31 -0300
Date: Tue, 4 Apr 2023 08:57:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tom Rix <trix@redhat.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest: set varaiable mock_iommu_device
 storage-class-specifier to static
Message-ID: <ZCwQqzrg6EL7tgdM@ziepe.ca>
References: <20230404002317.1912530-1-trix@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404002317.1912530-1-trix@redhat.com>

On Mon, Apr 03, 2023 at 08:23:17PM -0400, Tom Rix wrote:
> smatch reports
> drivers/iommu/iommufd/selftest.c:295:21: warning: symbol
>   'mock_iommu_device' was not declared. Should it be static?
> 
> This variable is only used in one file so it should be static.
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I applied this

Jason
