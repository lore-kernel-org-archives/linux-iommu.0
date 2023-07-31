Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC14182A7
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 12:03:38 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-686c06b806cso3022393b3a.2
        for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690805017; x=1691409817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7uuseNEJBf1t6gDmjVMEKFtFhJMsgCCc8Ace2qY0NE=;
        b=JoFG+NJ97JXKzRsGeFP3ZQ7c8Su9Q65Lgq6oAgknm92He2r9qKgtShi/I++MJ+tpBD
         L5UQZjdobIQWdd+hEQp+5z3ic+glt2UIjlRBdTPHzSj5Gdui7bCB8evF3FUEUt+gfRaU
         NATz9OAL379qW7MmxoGWs69KkmDlZ/RN6ZikZygZLwrEWtf3qj3MAiY8SZGr+pexPu5/
         MD1jZHvizeOs0Vjlakk48QQNGAahTXMmw18D+ze6GmxE6TclZo0z8WK+Vwm02r5BdQba
         aG7R+WwLgZ7Kjt9xhWhB6fLXQ7nUhjdROqFnWgpA2mI23sjnd1d1NySC9lTmSbjRwhEK
         wjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805017; x=1691409817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7uuseNEJBf1t6gDmjVMEKFtFhJMsgCCc8Ace2qY0NE=;
        b=TlYjauHcVnPwKAwlSK/Ed/RX65FI/NhqoOy9lkQXLnk8FqNwaCvB8hPNMn0dD84hzl
         NhNyPhYby+h0O7wCr0LoH8Cye1MyR3Eekc3McW1Je3lDnjXV4lR5G7b4Rhb+4BmccmVd
         eO2GEt6jOJkuMkuMz7Lv+6Ac5MqcvqJNseuvO0IdSbQwhTU4coCqKFtuXNrYBK5pR/30
         KAtXgAao3pKaXhVXgJMMXM+dQM5fPR9UwsAYyuMzRW5cVPgUonpzZhqg6CfgSwtGN/zO
         6/v4DeGyCD0FyPFy3Fv+2dDC+5Ofuw4tU0/r1DtnyQWKoYZOluVfkNgSguDy1yhLaVQ3
         BugQ==
X-Gm-Message-State: ABy/qLbMha1H5LvK5uOWua8rsLMsGlYIwdt/qGwO5UfBjPNzqYZWBGj4
	DdYqAiNtIqtti8rBWEbAd5hEgA==
X-Google-Smtp-Source: APBJJlExpu1t+c42fw0lELXLsMfHZmmhLyi5SxjEcMIFhv7UlY30I8G5Ywr7EDCbVKHNLMdjfRandg==
X-Received: by 2002:a05:6a21:32a3:b0:104:ad71:f080 with SMTP id yt35-20020a056a2132a300b00104ad71f080mr11072612pzb.34.1690805017526;
        Mon, 31 Jul 2023 05:03:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x6-20020aa784c6000000b0067f2f7eccdcsm5458563pfn.193.2023.07.31.05.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:03:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qQRcb-002EiV-Vs;
	Mon, 31 Jul 2023 09:03:33 -0300
Date: Mon, 31 Jul 2023 09:03:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 04/16] iommu/amd: Refactor protection domain
 allocation code
Message-ID: <ZMejFaxk1wLIUeAb@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-5-vasant.hegde@amd.com>
 <ZMPIaG9IktvVqbI1@ziepe.ca>
 <5c079520-f538-5894-d987-e8e0688979d2@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c079520-f538-5894-d987-e8e0688979d2@amd.com>

On Mon, Jul 31, 2023 at 12:00:02PM +0530, Vasant Hegde wrote:

> >> +		pgtable = amd_iommu_pgtable;
> >> +		break;
> >> +	/*
> >> +	 * Force IOMMU v1 page table when allocating
> >> +	 * domain for pass-through devices.
> >> +	 */
> >> +	case IOMMU_DOMAIN_UNMANAGED:
> >> +		pgtable = AMD_IOMMU_V1;
> >> +		break;
> > 
> > I've been wondering why this was done, it really should not be
> > done. Unmanaged and DMA should be the same. The driver should pick the
> > one with the highest performance.
> 
> This is to make sure in guest we can use V2 page table.

Upstream does not support that anyhow, so why is this in the mainline
kernel?

Jason
