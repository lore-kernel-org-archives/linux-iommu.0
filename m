Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD977F
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 02:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692843042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KSYESjWEiNbg/Ww5PNz+iJIOwo6YpTdcr5a1DFt8t84=;
	b=VThBtCT2TXciP9vZx5ckmAnEzYHjTP+dUqQL4VLAcmyP0+7zy1fT5YnaD7+ajTOUht/tfR
	MFUhoeyF9X80sQJl5xBKHgo64Ikd/f9puOW5Xr+Y3dv+0Fvc2unJDqfZRE+cOP3ywqZe90
	26VTI6unudpDZt/3+tyRBROgrvQvvhc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-FsvTvsN6NQuObfLi3c-79g-1; Wed, 23 Aug 2023 22:10:41 -0400
X-MC-Unique: FsvTvsN6NQuObfLi3c-79g-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-410f0988ea6so14547001cf.3
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 19:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692843040; x=1693447840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSYESjWEiNbg/Ww5PNz+iJIOwo6YpTdcr5a1DFt8t84=;
        b=inLEi2ZzTIGgRP1sLptQExV4CF+Rbz75TtuKvgl0zGaGtB9oUqEmKB6kjxKOlfxIZF
         ZWKQQNLJOsH5/rfiSamt0UbzAYiINMlwBvTp814ka6uGemNv20RmfON6Ygm0ngj2xj0N
         bUj/uw7W7jVhI+SVejgUocSL7DsLfnkdZ79rRdQMCvKTFysQ4Bbl6J+hKdn3M6z9gZ0R
         TxgtadUC7oEVpxzZMhhPVxob16v/dAoK48O+9OiIct8wBQ2+gH5mvLGENK7DrUu84a3k
         QhM31ohZLOg58oZQI0LJ//7oN+f65rmDTbEBLVdCKR80Zp2QNHQf7LFQTAV/xNB3A8gc
         pLAQ==
X-Gm-Message-State: AOJu0YyeCkwbmFaguonyc15Cdfxy7cQNZotcrWbYyUhPypzQ3k5OlpSb
	8UqEpob4MJIn1ILOlt8H3hV6u7bBLCAQbFYiyZkFn1JXy2il+8X93/yvyJJI9mcGynl+KAuB99o
	HFGhaDxLz+gwYJdyc0sDoO5M=
X-Received: by 2002:a05:622a:1454:b0:410:9b0f:e68a with SMTP id v20-20020a05622a145400b004109b0fe68amr12398345qtx.65.1692843040526;
        Wed, 23 Aug 2023 19:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYHDtEhUyZCRD/qwKBPVhM2PG3wG8RCzsiZHXjUAvV2p6ytmno1Pj/cJM9ENHtLHRP2gFaHQ==
X-Received: by 2002:a05:622a:1454:b0:410:9b0f:e68a with SMTP id v20-20020a05622a145400b004109b0fe68amr12398332qtx.65.1692843040308;
        Wed, 23 Aug 2023 19:10:40 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z9-20020a0cf009000000b0064bdd4239f3sm4596260qvk.126.2023.08.23.19.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 19:10:39 -0700 (PDT)
Date: Wed, 23 Aug 2023 19:10:38 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v5 12/14] iommu/amd: Introduce iommu_dev_data.flags to
 track device capabilities
Message-ID: <lo5ff7x4dcl27lebiaupb337cjncrsxatruavtb4onbwkldu3u@ylkqyaslvsz7>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104227.706997-13-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:42:25AM +0000, Vasant Hegde wrote:
> Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
> ATS, PRI, and PASID capabilities. But these capabilities can be enabled
> independently (except PRI requires ATS support). Hence, replace
> the iommu_v2 variable with a flags variable, which keep track of the device
> capabilities.
> 
> From commit 9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability
> with all VFs"), device PRI/PASID is shared between PF and any associated
> VFs. Hence use pci_pri_supported() and pci_pasid_features() instead of
> pci_find_ext_capability() to check device PRI/PASID support.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

