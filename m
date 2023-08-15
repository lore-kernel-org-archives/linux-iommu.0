Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0114276
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 18:34:44 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-26934bc3059so4643365a91.1
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692124483; x=1692729283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=li5k3Hs0+0byLdMPKt+r/8LUjk8rWpsT+bqtF4+SCkk=;
        b=bHcQCUK61Lgs9PTc/CnalqLhq4b33DZsnhi80/oC21tNzOQDCRZn+Ws40xDMV9NNuU
         e/eyp83IEug+w1542mdy3saDMaj6NOen4+IGga0Bq0UETrl4g5wOOekaX11iTwNMVszl
         RXlYYPmVx/OWkIscmW5pr2/Ae+3uu0PA36YpnfswmhLJROz2j/If/VlBVOV9S2sbi8h6
         07xTsvI5H7YnGsoKKf9vbLUVw4qvBwpU4L5VW5V46NG+dPDVSs7q+rGW0TGeKcabe6lm
         w72LbJeOSnFecSN2PsX6AsnjFZlW30vdHtNX2ShyiaRskwinVfO+nsQgBcR6Br0pYMF1
         k8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124483; x=1692729283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li5k3Hs0+0byLdMPKt+r/8LUjk8rWpsT+bqtF4+SCkk=;
        b=P3wkEY6rP/8h+VGGC78b0eAeRSMe0PRQfEX88C7hAlQgcb9lw262aBuWro4BUx/OkH
         icceUCm5zbf2pTKUChrzqtLUkLCoh91V5qOeaWL5Gnif+fmQPxXeVrsqnKLhGBVu3yyY
         G/xz+7a0nj/UxEkBgCuoHp399+8wEKTYz1hwJMmjsCsEa5mN9Dc1yYyuF0BcJOcsH2+4
         ZeNy0F3jY73OU+aW7bqlImFcilo02eI4cB687f1MdLRdprMU/R6GvWpVizqm/M6Ft0QC
         sl+xrW6s98bOSrRHfTiQF06QqKlrJQKUynUx9JVf00JqvGa71Fjs+97/yUegZX4TEWoc
         bAAw==
X-Gm-Message-State: AOJu0YwmMsxzQ6UF+n8OjCNp1QV9Mp7igH3FHBOUSErX2kx6zWnMJ0tU
	9XB4Nc/dTZAWgsLXGHswSdVAVg==
X-Google-Smtp-Source: AGHT+IER+RbWODjiz3R11DgVY0H6SkGLqL+bQBFACBgoQeCs9fLvVMpMuPMlczaspMKwhl1JaWdW2g==
X-Received: by 2002:a17:90a:b790:b0:268:535f:7c15 with SMTP id m16-20020a17090ab79000b00268535f7c15mr3478184pjr.0.1692124483570;
        Tue, 15 Aug 2023 11:34:43 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q1-20020a63bc01000000b00565eb4fa8d1sm457969pge.16.2023.08.15.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:34:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVysL-007hkb-Nj;
	Tue, 15 Aug 2023 15:34:41 -0300
Date: Tue, 15 Aug 2023 15:34:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 12/14] iommu/amd: Introduce iommu_dev_data.flags to
 track device capabilities
Message-ID: <ZNvFQU+OxRIt79C0@ziepe.ca>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815102202.565012-13-vasant.hegde@amd.com>

On Tue, Aug 15, 2023 at 10:22:00AM +0000, Vasant Hegde wrote:
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

One change per patch..

But it looks OK

Jason
