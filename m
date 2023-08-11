Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841D63B3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 13:17:58 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so1407777b3a.1
        for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691759878; x=1692364678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SF6chnxhiowSc0FlKF2oC3SpXqaWv0JaoAiCVR9Eq0=;
        b=lkvg5OQvY3X4rAv73rJNReLcMVfgniW2K18oan9z6AScgytA+oLFNNC6PBBBAysSfp
         5soMOc6lnxJcuCJ68cn3Ay3kCdyl31sGNHmgcRc2SZh2RQNzSl0M+MUieI2sf2BqQp5E
         oVXUZk3IXR6jxWr56zqIjb/HWhY432wHNi+gRZOqJszVWjRW5ShPeEkzDQ+kYYMHsUFg
         YDDF5ap68jlzUSjIdW3esmERIRR3ByI+bzlg/PBU39B0o119jepkVa0Mv9WGsPyVWMCZ
         1iTviAeIgPuPZhsUbwwzKosoPOF1Fjxosb8Ajl1qW6f4v4LdByedTLwvC8sOQQOn1afo
         LVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759878; x=1692364678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SF6chnxhiowSc0FlKF2oC3SpXqaWv0JaoAiCVR9Eq0=;
        b=VvUgaDap0/q1r4GrsJ7891UntdFuF58uBVgXA7EaSGULztnChVophwSYI3Z+o5dKg6
         J22JF0uLy2TAXg8McnnKSNd20U1p9xn5ZU8i8EZJ72Xzd2a9MCwgFADI9RqDrGAj0YLR
         qVujGb678aSqY9mTMp58XHpfEZdpFSFYo+5DRFDP/zA1eA+TL2WjlQYZH03WGja4C23V
         ShJjhvwUNM1pmcxDtZxUHn1PbZISzM+lmNr+8bh16RXZatFIRx1+sev+4iHC0D9c/pPP
         WFnXDtYanf786pQBRO98uYdpMNzXy9OCxHmEXkizzm9YpudOCbAp12OJivenvYbbL0Vh
         aohg==
X-Gm-Message-State: AOJu0YwNt6HZUsQiBkqz2NVhOPTKcBHev3bqPfUwEE1/8H2WC2X2Vasm
	lWLayV3VHCM4vk33vcXhPFkfEw==
X-Google-Smtp-Source: AGHT+IFf+6WM9Q9LeRuWJtmoTkO4p2FK3uNAAFh5AIE4jx5tkY0qg/J9X4RQzk9xew/RgzCqAteLcw==
X-Received: by 2002:a05:6a00:2807:b0:67a:72d5:3365 with SMTP id bl7-20020a056a00280700b0067a72d53365mr6020928pfb.6.1691759877841;
        Fri, 11 Aug 2023 06:17:57 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id m130-20020a633f88000000b00551df489590sm3253436pga.12.2023.08.11.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:17:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUS1b-005R3m-NS;
	Fri, 11 Aug 2023 10:17:55 -0300
Date: Fri, 11 Aug 2023 10:17:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 09/11] iommu/amd: Introduce helper functions for AMD
 IOMMU v2 driver
Message-ID: <ZNY1A6e5S80heWoj@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-10-vasant.hegde@amd.com>
 <ZNJj9ljbIM842lEh@ziepe.ca>
 <c5572a08-42b4-c778-b6ce-21fe44190ec6@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5572a08-42b4-c778-b6ce-21fe44190ec6@amd.com>

On Thu, Aug 10, 2023 at 06:34:46PM -0700, Suthikulpanit, Suravee wrote:

> Supporting the IOMMU v2API adds complication on how IOMMU domain for v2 page
> table is managed due to several restrictions, and it is conflicting with the
> upcoming SVA support.
> 
> Since this patch targeting v6.6 is dropping IOMMUv2 support:
> 
> [PATCH V2 4/5] drm/amdkfd: drop IOMMUv2 support
> (https://www.spinics.net/lists/amd-gfx/msg96082.html)
> 
> Subsequently, we will go ahead and remove the AMD IOMMU v2 driver since
> there is no in-kernel dependencies. This should simplify the domain
> management, and should be easier to introduce the SVA support afterward.
> 
> We will rework this series and send out v2 shortly.

Oh wow that is great news. Lets go forward on that basis.

Please make sure the AMD driver has zero EXPORT_SYMBOL's in it after
the above is applied

Thanks,
Jason
