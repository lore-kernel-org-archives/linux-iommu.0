Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCD15AC0
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 17:53:58 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6b9b4a1211fso1348411a34.0
        for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689357238; x=1691949238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qM4OQlhVRt1WjAaK0dOAYfxc9ydCayeNS8uqIx0WY8=;
        b=hofPtE7gxdhMCkPF2c0S9ZJpQ3qChRlTMkcrh34AaywXf3bA7gmBP2NlNIq8ujOZR2
         f9UIgr4ssZCRyB969V26dYrKV+cpwTvDKvqG8F0ywKSTGIE6IH4tPro4P6hKzfQR9DFL
         EWCs50XO4MBcIYNxuRXluxuy7Q9jaYmnS/u3MFW1GyrdLcVlwskcD8Qzu5qQBfShqZOM
         aGfF/66Jt0pUJ1qCzkk3V/3mbaIIQe78XdxmeeQglFhhjy/49oYriEqqxZSuIZdu250a
         d4J42e/e0GzjksnNF48UZ2Av95Cs3hw5TIH3MLC4brkqKycBIQ26U9N3XLho0igr9Uu4
         vRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357238; x=1691949238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qM4OQlhVRt1WjAaK0dOAYfxc9ydCayeNS8uqIx0WY8=;
        b=MZnr2b6mHCpEEVUMxLQRWGOrKxgDSHPqjUrG88B8Z5pE7PFJi4nUEUtAlZSIzI++k/
         HC43zvK38Acmm2UcE2v5OqrGROby3R3pX13wBVH3QOpWT5VlRqC2Wbb4hXAfLjDH6t05
         kHErRgdS99YLLM57e48tkbxams/F9MjcWhZ1nEGdAx1R8htGkdS3JPk7QCdo9H9MxJTK
         WQswyrFvGtXN+SxCyOUS831Byj+L/WW37yOWAotkYCIfyZkZek1As687fgWtUcbR2n2S
         Hc9HAmokEFQ1DS3MOmY1b3zCrVMxkHXCuNtwZ2yfdH7op1mXLK+eWhuJ6YLa6F0Lr0nr
         W4dg==
X-Gm-Message-State: ABy/qLaxnbqPW1NyEVwemz3F8Y8WfeVL4Oh/n0PA+GAvrpDk1nu1+9UX
	Wbo39Msw9M99TYtrPtrojFpTVA==
X-Google-Smtp-Source: APBJJlHqSHmPIv9HuEvRSWZF6x8BxlxfDeSFwxhu5ab27MnTuEI5jnYuoxkTzgSCdLTatEv5YW58Ww==
X-Received: by 2002:a9d:6847:0:b0:6b9:70c9:e1c8 with SMTP id c7-20020a9d6847000000b006b970c9e1c8mr5560602oto.5.1689357237824;
        Fri, 14 Jul 2023 10:53:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w10-20020a63a74a000000b0055b61cd99a1sm7841793pgo.81.2023.07.14.10.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:53:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qKMzL-0018e1-K0;
	Fri, 14 Jul 2023 14:53:55 -0300
Date: Fri, 14 Jul 2023 14:53:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 00/21] iommu/amd: Preparation for SVA Support (Part 1 of
 2)
Message-ID: <ZLGLs8B+07fU0Scc@ziepe.ca>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>

On Wed, Jul 12, 2023 at 02:14:55PM +0000, Vasant Hegde wrote:
> This is part 1 of the 2-part series to introduce Share Virtual Address
> (SVA) support, which focuses on cleaning up and refactoring the existing
> code in preparation for subsequent series.
> 
> It contains the following enhancements:
> 
> * Patch 1 - 7:
>   Clean up and refactoring. No functional changes.
> 
> * Patch 8 - 11:
>   Miscellaneous improvements.
> 
> * Patch 12 - 15:
>   Introduce new set of AMD IOMMU protection domain flags, which simplifies
>   domain manangements.
> 
> * Patch 16 - 21:
>   Modify logic to independently enable PCI capabilities (ATS/PASID/PRI)
>   for devices. This allows more flexibility in preparation for SVA and
>   IOPF supports.

I don't know alot about the AMD driver, but these all seemed like a
pretty good movement in the right direction.

I hope part 2 removes all EXPORT_SYMBOL's from the AMD driver :)

Jason
