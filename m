Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957B1C290
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xsztx9ax"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67a959e3afaso11609446d6.2
        for <iommu@lists.linux.dev>; Fri, 08 Dec 2023 05:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702042826; x=1702647626; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8e2o0WXAr4ymK3d3VhrPB5sSWDppvhuD0Mr+xQ4HHM=;
        b=Xsztx9axZhpfTm4WSuDDN5FcEu+dKqfjmaKYirF9ke+v/4IVSvOzQ0j1nIneDfGxDB
         gbY1PHuI5aRK1emww5s+wxcoDiflNreqB3zckFVsxGVuAY2Cm9iMcPQ37z04WX0ht7ZM
         uVQvOikniE4d0tSUuVBG807RYx++zhpqMkye4p3v0Yw0K7Qk2+0GcgCIO09InDtDiHJr
         pGhQvjMa/jKnuczRnLLzIaHHnnKQLmSn0DexdgH6rhvcx4JxEY4sMdVesFQ/5ouCeSKi
         AMrFdEtNmUofj0RX6XzdWDiQX4Brt7KDLsEgqGvarvjoF1sjYD16wx548BQqIcarFthT
         invA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042826; x=1702647626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8e2o0WXAr4ymK3d3VhrPB5sSWDppvhuD0Mr+xQ4HHM=;
        b=B0w8gjXBTC812gOUK13htbGFWZ4dUxHb8egi3wLCnpo8Vo1XIKqqEocsDvJUzKsDYl
         +EFP9C08LQhhiZ35FpV70tfZk9uqMyvBAMifB0JonVWTSTsImQoziwHfxCx7Y5bs08eC
         U5lTQfZoLyApH00z8bt7L9OaXdBw6i4C9vDE0bAuq7rv65S00nGv5kgOVPj/9MbYZplc
         uPFfvjlAV7EiLL1m4uweIRq8v+uHpUtUKF+q5MN25ORIqM2Tgux34/hMJcssfjJ0o/2w
         mx0CCnN4fVo8tFutwFmpdvupbl7qsDUUpE085yNmToVqTxOxPlJaiSFUKYNOnnViU9HM
         nUAQ==
X-Gm-Message-State: AOJu0YyQcei7oDqU2rGtFOsK/JHFyvzlGIzmHlmvGbDWHBxoc22ZxDgA
	7SJ6yTaYxY/mIAn5oP9y7X35Rw==
X-Google-Smtp-Source: AGHT+IG+42h3wSDDnzyiUdmBDnnmwEZgxwWvJKW+1f6Wnxx1cI9jSsHp0wxIJsybMJwE+p1mPdNlxw==
X-Received: by 2002:ad4:57ac:0:b0:67a:9d24:5e95 with SMTP id g12-20020ad457ac000000b0067a9d245e95mr3820818qvx.31.1702042826613;
        Fri, 08 Dec 2023 05:40:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id lf10-20020a0562142cca00b0067c4b7ca239sm805168qvb.22.2023.12.08.05.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:40:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rBb5c-00C888-Tx;
	Fri, 08 Dec 2023 09:40:24 -0400
Date: Fri, 8 Dec 2023 09:40:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu: Set owner token to SVA domain
Message-ID: <20231208134024.GV1489931@ziepe.ca>
References: <20231208015314.320663-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208015314.320663-1-baolu.lu@linux.intel.com>

On Fri, Dec 08, 2023 at 09:53:14AM +0800, Lu Baolu wrote:
> Commit a9c362db3920 ("iommu: Validate that devices match domains") added
> an owner token to the iommu_domain. This token is checked during domain
> attachment to RID or PASID through the generic iommu interfaces.
> 
> The SVA domains are attached to PASIDs through those iommu interfaces.
> Therefore, they require the owner token to be set during allocation.
> Otherwise, they fail to attach.
> 
> Set the owner token for SVA domains.
> 
> Fixes: a9c362db3920 ("iommu: Validate that devices match domains")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
