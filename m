Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49E4435
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:59:21 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-770ef334b4fso1553585a.1
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694537960; x=1695142760; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b43DkijhwRzWi1Lu8xEeqpX+hqqlHukkGcJzB5lL5YM=;
        b=Tv4Pj/Jk+uUk6Sse5lnGfWAo1Fi1bCsuSv3I1JZHBi+BNtUy+r5Wl283UsicJJ3wT+
         E/NjFs3I0Nr6ytA+Sz17IeBh9Qz7BaKp04Or6FS5xMv4+bMEZQIpdep9a/M6kh6NGS5L
         uL1IhV0ve66lB+0qOG59m6B2uo+N+UgEbiFwUrHEsn+ZKoCrqMv47Ae0DM2QgwmtTwLl
         2sob4MtFTGble4fuseEtPpHvYeJCbT78/a4St8w5tEP6MyLpPwIS+p48YjXcPz13IApD
         T482yzyw+jM5bsL4se0GI8OTX1KekBvVjFzh2HMGvzwy9Y8es1heSpIgBknvi5D2MX0M
         J9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694537960; x=1695142760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b43DkijhwRzWi1Lu8xEeqpX+hqqlHukkGcJzB5lL5YM=;
        b=Npy4icjRjxJ8Fxkna7bqPXO7irNnz94uZXZt5YkHuOjlmozhH7d7ItZoqzKptlHcTq
         Pp8czjDdQxhvVYhmNYpdBXipheurQ6CNvt9feQN5CsIFm/6yWw4EZXPCXCqfOie80xDv
         MSgPcAzVWl/N8G0Xadt32HhNRAbJb+/4e/MQDVXBoMGq5S8cOLQbksGT+p+ODx2KkrGD
         /m2arhBanrv82ehlBd20j4NgNtQo4yL0J2+T6HQd3J5Oz0tSADm+W7ZVGXuFnciBK9qB
         aLXSV8j11XdwIbN17wC/Q61XDamCy0k1w7kWRQI61Uzu7pCilYibnFBc3DTPem+nOEE5
         EOww==
X-Gm-Message-State: AOJu0Yzj0jPNyqVGtUz37SONzM1XbyMd6ot344gUo+8b4svaJtQ5Sbnd
	UpPKXgDuzOc9TkaP3vXCs+aRsg==
X-Google-Smtp-Source: AGHT+IGPfqTdWy/vELbc4QECCkxfDKuG3F6/F2HOxz6EwUlnwEzaJKKE7jh1xIDJAv2z0QeBV0TCtQ==
X-Received: by 2002:a05:620a:4151:b0:76e:4df3:1dcd with SMTP id k17-20020a05620a415100b0076e4df31dcdmr358012qko.11.1694537960655;
        Tue, 12 Sep 2023 09:59:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id pa32-20020a05620a832000b007671b599cf5sm3321621qkn.40.2023.09.12.09.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:59:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qg6jP-002Fgs-Lt;
	Tue, 12 Sep 2023 13:59:19 -0300
Date: Tue, 12 Sep 2023 13:59:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 07/11] iommu/amd: Define per-IOMMU iopf_queue
Message-ID: <ZQCY5wyo7WDTz16P@ziepe.ca>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911121046.1025732-8-vasant.hegde@amd.com>

On Mon, Sep 11, 2023 at 12:10:42PM +0000, Vasant Hegde wrote:
> +
> +/**************************************************************
> + *
> + * IOPF handling stuff
> + */
> +
> +/* Setup per-IOMMU IOPF queue if not exist. */
> +int amd_iommu_iopf_init(struct amd_iommu *iommu)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	raw_spin_lock_irqsave(&iommu->lock, flags);

Dare I ask why this is a raw spinlock??

You could also do this when the first PRI domain is attached and save
a bit of memory..

Jason
