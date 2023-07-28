Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C111CA9
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:13:07 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-267f870e6ffso1280052a91.0
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690553587; x=1691158387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BO/cmQ8O+YIqsnCmz6u6NOuuwacLXRFlAX6hGi8rzB0=;
        b=dbSPdn4UuQN2OmHZa6nVs1VmpTLtQ0qyrxhw2V9tG+4xMwS1M9+G3/7p7kQNpHuLik
         ecJII/Gc4HmfHEfQYruZ3M6DFZt8Xmhh3uWKMmimTYC1vhMm0qHuANHVP3pwCrb6byx+
         e/rslG/fLXQm9wFCKiufpSuFXvQxZiMlizwElPZOrK1hOHKBoELItvYNlkYSHtmiUHW1
         ufUSRgr3ncex3a4AH2aQyLlBPgEog/hJZdaTLmM/53Y7XrwwOYCV61FeVvWxLK2lTXKV
         0ey5fmMtPPgKdR9AsceO0ErN3s51rDl4vqv7I0dBzViJ23RzJfNn1KaN/8AzoDPErkcf
         2Xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553587; x=1691158387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO/cmQ8O+YIqsnCmz6u6NOuuwacLXRFlAX6hGi8rzB0=;
        b=RXiSL8EsWZy7xJvDalp9DSptlswHHDfVDEsI6tiHRsM7EAqiTYFdYeAeaWjsxUjd/E
         9Mn+zs/u3IesDSD+dNrZkupfpenK6LC4CdrfL4ZTkNkF1NjoBvMSdSAWwuaAKM2pdDhC
         zEpLal8PvLMVBxwguK53demOSaMvyOmbB7hhU89jcc0Xf6l/fohnOdCnRxmhkhRhNYPg
         i+cXpD5/Yp4TtkqC20d9Cx668ZGfnxJ/lsoSE2/bO6hUWooCDjac4tDROiM5tT60h0e5
         IuNupok1cJzYZvqkoWYFWMh643CK+OGLQSZyXDlNmLWjmkWwvhgzYc8bN77S1oVZ45/q
         G1mA==
X-Gm-Message-State: ABy/qLaQutl8ULHVm6w6HE5axdUq6+UYuxAZdo2tCIIzE8oihiC5pWxn
	oM/3KfUdMWPpQ4+6Zf9eWYB+vA==
X-Google-Smtp-Source: APBJJlG1O5tSGskTmaSzUdwyqYs2/A27PoIkCENrYYPdeeBCFHQ5f/EicxbIjb/RWFFslFk9q/gQ/w==
X-Received: by 2002:a17:90b:234a:b0:267:f758:15d4 with SMTP id ms10-20020a17090b234a00b00267f75815d4mr1351012pjb.48.1690553587353;
        Fri, 28 Jul 2023 07:13:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090ab88e00b00263987a50fcsm4265855pjr.22.2023.07.28.07.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:13:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPODJ-001bcx-KK;
	Fri, 28 Jul 2023 11:13:05 -0300
Date: Fri, 28 Jul 2023 11:13:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 09/16] iommu/amd: Miscellaneous clean up when free
 domain
Message-ID: <ZMPM8Vdo974Du14a@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-10-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:36:02AM +0000, Vasant Hegde wrote:

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index f5a05779573f..a0b0deb6fbcb 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2037,12 +2037,13 @@ void amd_iommu_domain_update(struct protection_domain *domain)
>   *
>   *****************************************************************************/
>  
> +/* Must be called with domain->lock held */

Don't write locking assertions in comments. Put a
lockdep_assert_held() at the top of the function.

Jason
