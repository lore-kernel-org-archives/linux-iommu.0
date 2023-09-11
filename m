Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D364432
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:41:09 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6556d05a55fso23848446d6.3
        for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 05:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694436069; x=1695040869; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oSVHEbu4qz1dzQzbes7Fwb0hsR2PcXZ/e/1zdR8Gxjw=;
        b=Dpo9kbSTJxDxt9ZjrnvnmxpRn4DxGo+KzJ6VyQtG3QbRrklGFJIzMR1WmQ0JMBKGmQ
         c8GJSJYXRmQMUNpzNkH58TN+7FHKumeYfcnKSCksvG85eHqs+2DtP6LUC65qBQKdWAUc
         4NMctKOiPIPEr5tv98F39mlEPZehDStoZYZzh0BAidYM1fJF2AAdD5+KljjjiS55W+w6
         NP4dWWbM44mjWUWMyo1qCpkhk/Y3hkvgfErg3ClLrbHOHznV0SZNDnDyeAomOZ2UImIi
         5crjbGj56OdtsveBffrHOemWg2plpdcOArYC8pAuqQNVq4WMMgNxg3q9YB6AGKTmKBHp
         ujoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694436069; x=1695040869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSVHEbu4qz1dzQzbes7Fwb0hsR2PcXZ/e/1zdR8Gxjw=;
        b=CZ23y3gT2y1nR0IjrQ+jd379LsCGe/xu+P6hWJ+gT4A1eiCfF7x6Sf8w2bOwJ5BjCi
         cMzbiJZGjxdaueJYC9xUQL1DkpUjyvQK5pJKdz23Y72FncbXoldSxQl1gyTiPvXwwygS
         bELaVVyVDEOeK1nMHR5hHBU0KhDiGKpSu4hHOSuzNBA3uBfSa3mKFf5GUpJtL+0cC+6/
         jpU84bU45bg/xmio+0clMISmJxnlmkwwKnkaxx4mkT47QXR4veR/r47Xu+bTlQKm6Ehc
         FxtevE9pQBmxJw220dHf4j+lX5LpCTMTyr+iMRdAcd5FF414eXhYecpbEg7mNSQq1y3x
         Kqvg==
X-Gm-Message-State: AOJu0YxQ2BkObQrvMaD3gmIUuJrubVej+hKsQmQiQ+n7yxJ1y//vAkM8
	rWy71boXmg3faYFiOxPcDUmF1g==
X-Google-Smtp-Source: AGHT+IHU0VXm8gwrPeOgBRdL4Q5P/++Qiz2JgUZq3DjOz2XD7EaxOM686nn9xoIcEqTjP16E4GiFfg==
X-Received: by 2002:a05:6214:5004:b0:63f:7c62:63dd with SMTP id jo4-20020a056214500400b0063f7c6263ddmr10958644qvb.46.1694436069057;
        Mon, 11 Sep 2023 05:41:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id f17-20020a05620a15b100b0076f21383b6csm2489763qkk.112.2023.09.11.05.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 05:41:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qfgDz-001XjM-O0;
	Mon, 11 Sep 2023 09:41:07 -0300
Date: Mon, 11 Sep 2023 09:41:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 03/10] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <ZP8K40ASDPAcp+/X@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-4-vasant.hegde@amd.com>
 <ZOYXoMPBQZ5KK9IJ@ziepe.ca>
 <fc17e0fb-e712-824f-93f9-f9edf5707395@amd.com>
 <ZO93WJnhxl+sC9zA@ziepe.ca>
 <d64d8066-7cee-46c6-2403-76eaa969fe53@amd.com>
 <ZPcejmNW153rcRFA@ziepe.ca>
 <38845842-d535-b621-1e6b-16d8db52a1bb@amd.com>
 <ZPdv8P4zTNJODcXD@ziepe.ca>
 <14ab1dbd-26f1-3935-65d7-1d1835cb062d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ab1dbd-26f1-3935-65d7-1d1835cb062d@amd.com>

On Mon, Sep 11, 2023 at 05:46:39PM +0530, Vasant Hegde wrote:
> Jason,
> 
> On 9/5/2023 11:44 PM, Jason Gunthorpe wrote:
> > On Tue, Sep 05, 2023 at 08:09:39PM +0530, Vasant Hegde wrote:
> >>>>   - set_dev_pasid() will check the compatibility and bind device/pasid only if
> >>>> its compatibility. In AMD case we will check against protection domain. Ex:
> >>>>  If we have two devices (devA and devB) in two different protection domain then:
> >>>>    set_dev_pasid(sva_domain, devA, pasidX) - SUCCESS
> >>>>    set_dev_pasid(sva_domain, devB, pasidX) - Compatibility check fail
> >>
> >> Here I expect it to fails as devB is in different protection domain. From
> >> invalidation point of view, devA and devB are not compatible. Hence I think it
> >> should fail binding.
> > 
> > No, that isn't the best thing to do - you could do this, but it will
> > be more inefficient.
> 
> What inefficiency are you referring? Allocating extra SVA domain -OR- mmu
> notifier getting called for each SVA domain -OR- something else?

Primarily multiple mmu notifiers is not so great

> Then I am wondering why not just create single SVA domain for a PASID and let
> individual driver handle underneath requirement like target invalidation? Am I
> missing here?

domains are not connected to PASIDs - PASID is part of the attachment.

We want drivers to support one domain per IOPTE table and allow all
possible combinations of compatible attachments.

> > We have use cases to share a KVM page table with PRI.
> > 
> > Google apparently has some usecase since they are fixing it in ARM.
> > 
> > Besides that, it is the IOMMU API, drivers have to implement it, you
> > don't get to pick and choose.
> 
> Is there any documentation on the mentioned use case and the
> required IOMMU API because this is new to me. I would like to
> understand things better before making the change in AMD IOMMU
> driver.

Just the API definitions we have been working toward and the
dicussions on the list.

It is not a complex concept, UNMANAGED paging domains need to support
PRI and PASID.

> > You are not going to get SVA without also properly doing all
> > infrastructure to enable paging and unmanaged - I won't support
> > another shortcut hackjob for SVA that needs unwinding like ARM has.
> 
> The goal of this series is to introduce the SVA support for AMD IOMMU driver.
> 
> So far we have been accommodating all the review comments.
>   - Dropping iommu_v2 module before getting SVA
>   - Reworking SVA top of Tina's series
>   - Reworking IOPF on top of Baolu's IOPF enhancement

If you would prefer to have a more stable base to work on then wait a
few months until ARM and Intel drviers are fully fixed. Otherwise you
are going to have to keep pace with the advancing work.

> Adding PASID support for the unmanaged domain is a new requirement
> and not relevant to this series.

It is not. It is what the iommu API is designed to do, ARM got
grandfathered in with their half implementation because it already
existed. New drivers must implement the API properly and not take
shortcuts.

> It will also require a considerable amount of changes
> in AMD IOMMU driver that we need to further investigate to better
> understand.

Exactly. I do not want to see new drivers follow down the path of
ARM at exctly the same time we are trying to fix ARM to work properly!
This undermines all the progress we are making! The API has been
defined, please follow it!

On ARM unwinding the bad design without breaking SVA is proving very
hard after the fact. You even say it will be hard on AMD, so NO, do it
right to start with.

Every single thing you need to implement to support SVA is also needed
to support generic PRI+PASID. The request here is to layer the code
correctly so that the PASID and PRI bits are not linked to SVA.

You don't need to *test* PRI+PASID but you do need to layer the code
correctly so that it is trivial to implement.

Jason
