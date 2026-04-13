Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC728314C
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096688; cv=none; b=tP6u5flqAG0moWvc2jY00aKlu6AzY2gVQlAmZljUs2NX9mqj6UT3U1zqQ4xN9/C4Bdv+gTGS020tFO+NF5eWBww/05jTBYnQDz9WFF+IGq04E07Z9mUHe5l7+rhMTrhkKyPZLlrI4dKH2wJcE8TmYSbqlBDG4VxpTnD89j0J2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096688; c=relaxed/simple;
	bh=0+aEo6g21+mDwpsOYPVua1ixp0m5RsYOM5Hdjnj5Nag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSWvbvU56NdIwdXROrBhXOFGa7mx6hbV+PPNl4NlJorTAmFTAG1tUKeyVwGdbA6lTuIXK/k6KHBD4M/NUBza1Uesl+iUVCfuwOCXeNI1xd0c7MkAR5QgGzfB27+N0Kp4SuTHwaqMP3N/3M684PxH21v7xvubmHSIqwip+k4BHp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IjXIkMcQ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IjXIkMcQ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a032383008so51304966d6.1
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776096686; x=1776701486; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B66qnCfZuTZvYHAq9XoYo1sQPpTobN+iPDeo3QnFTCM=;
        b=IjXIkMcQhGDI+dvauYdlRGPaTGy6cu005Ug43PlQTKM3p0YykMwclFybOgf5kz0xju
         iQMKMsGmDElHQsXomSc7vhJTwtL0Osk8LtvZraaHTb7DMvWMXmVaSahZFR34gHdJROPC
         I+nf0I3nQQUcn9zRgo13N7XU49b6D7J4npW11gwrGkblK9E5G/mbG+LbW4APIDbMUqzn
         YngzLHro2qaem3KIR0RmS/Dr1x7DptYoH7ZDjKFzuIw8JLU7VZGguclYxD2ggLXiyi5C
         9ce9GTOdq++MRbjJ6TOdeVPxnejP1l4QRHg9YJdzOjb0fCvhAd24/Z0FPIrOIvDFa2R7
         Lz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776096686; x=1776701486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B66qnCfZuTZvYHAq9XoYo1sQPpTobN+iPDeo3QnFTCM=;
        b=Dj9rHv1wkYuVhtPnxkdmf+8ywdz4Q2Nr/+w22/Cb95pVHziX3nHn4YldCIHP2BtdqF
         Q+HgTGaEFPTyA8iy6k+x84frQMDOqQpMAeo8EXFUjLyPoE2pPgr2XUQ7NIVVm5zR1xxr
         iqS9Enh7i9TlqoMV73UZbhq8WVn0XD6vbHpkNy1v27jDOFc7yt5V9lKvZ0oSVxacUNa7
         ZEzRwhyUvjm6nh7uCdrD7zcBlFAVCUorDYDdUnVnJDnhXXRmnZpZOPzHNm+BwMC2FrRK
         0obYcqOm9cMjU1nIlP/JxmdC0PaY89v9zunB74xybIQO+J136w3wLNim6hwESmnFAiSK
         O+jw==
X-Gm-Message-State: AOJu0YxiyY7pYJhKnDGKj+Z2t+hmvEN48iSIg8K8hXw2PBxDP90Whfrv
	26BOn4rZxLC9OI1B+SiOfWyMcdC5Lykg3sOKZgPiVa45q+G3LXI5XpBZ1q3NemyxdLs=
X-Gm-Gg: AeBDiesq0UmgyQ7OLNppQIcZ2nMyvfLIm1vWcTmfcQauO4hV6AEFkC9MncuxyMEcz/I
	3ECTSaiLDUhFsbgiAKKKco4CmTu5FOZrbTLX5CqN6c0RoHlDKVaNxGfjXdR9eicZhPpQVNeSyPY
	+cJKNvhCsOBeu9y4TGdAVq45rULBQnjSY02nJwtwDJpZSGwM/JNIHzvf11ILWubukdxgE4TyXrI
	DmXnV1ZzXFs8/AlTunVYtbOYw0tS9mOpP3j76fgwLLip3P/Iba9qOvvAwz4++Kksm5Eq4oVfdSH
	++DwCNtbxJV+2871Omh2dRLLNFLugKkos8APMNTXiRG/+N6+d6A8IRehob5AqG3Bb+r54wurtN3
	+MKLL9GZp35PajlZbSSR6D1lLtpYbAfEqWEv2P+C/kK/Mbl+A1102pzSFKu3ce7wnqUHVPJAI2h
	s6bZWzPm7yDthXR8IVx9HvNdtni9O9hsu40OR35BYjUjtIFyN3gax2LuTe3kUQGLbtATXUc/8Lx
	jdCKNxqR/rAW25+
X-Received: by 2002:a05:6214:449e:b0:89c:d424:aceb with SMTP id 6a1803df08f44-8ac8641cf44mr205493686d6.31.1776096686549;
        Mon, 13 Apr 2026 09:11:26 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849e35afsm125548836d6.3.2026.04.13.09.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:11:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCJsj-00000005QA8-0eVh;
	Mon, 13 Apr 2026 13:11:25 -0300
Date: Mon, 13 Apr 2026 13:11:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] iommu_pt: Fix pgsize_bitmap calculation in
 get_info for smaller vasz's
Message-ID: <20260413161125.GN3694781@ziepe.ca>
References: <cover.1776075533.git.Ankit.Soni@amd.com>
 <eb325bcc51b7e5ce98ade6e5838137285738bd9f.1776075533.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb325bcc51b7e5ce98ade6e5838137285738bd9f.1776075533.git.Ankit.Soni@amd.com>

On Mon, Apr 13, 2026 at 02:45:18PM +0000, Ankit Soni wrote:
> To properly enforce the domain VA limit, clamp pgsize_bitmap using the
> requested max_vasz_lg2 in get_info().
> Apply the same VA limit as get_info() in the kunit possible_sizes test so
> assertions stay consistent with the domain bitmap.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h         |  8 ++++++--
>  drivers/iommu/generic_pt/kunit_generic_pt.h | 10 +++++++---
>  2 files changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
