Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940ED3E488
	for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RTH8BuOP"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6d7e67c169cso654033a34.1
        for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700760267; x=1701365067; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tqnk639QwJR2HN0DY4K7GDFNmY8mOrL2nlsGyQw2mY=;
        b=RTH8BuOPXocxcwzIXdIiN3ty0FTx6PzmF22RhCknaEu0turlTocmRdhNz8O70XgGZs
         O0GClXYq0ohD8lJckYoqeqsQZwX5taPJ5GE5ETuYf35SFwequHtuvRXwb89DH7MYW1kT
         TnKixpb7WVfqDTkLV3zfYaLMw2VTuWtSJ4l1L0ol7vJiIpQmdDSbow9cv7y6yQwHmKIm
         GijBU76qVrKz19+cdLO5FbN12zzB47yoJd/h0RwajfVE+2BdmhB18gSoBJy7Uz6M4/Dw
         rEBC16jxiV0+K/c0sLAJQPRmAnD9AYHeq6Fpa23X9TspHdvE/kQ2RNxI0cvGY/ab+52I
         JTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700760267; x=1701365067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tqnk639QwJR2HN0DY4K7GDFNmY8mOrL2nlsGyQw2mY=;
        b=tZqAAn0h2+1l2+kH+WFBXhqHmxGGU9k0AI1XuIPmHgn+qfIDI3fIAGZFk3+vHHyWDY
         sTdbjedhK6p7oKCl2yP7Q+luEJ+MJDDK1ic6QkZxaSMK/oeRxykrw0cICDMewyT+/Pr3
         aBMptPbBlzRiXInXPOmDa5FiuIo55ZMjrivbjIzFxIeLBhbck+U8THyw+dPMLxn8eHJN
         APKJjx2K4p03ACwCpIkSig/R9cZN2kfGMFx9BjhA31SLSKesiBp8zL36Qun8yub0LuBI
         CtrUmqcpB8Ttl/u++rJpvZD9NL74JOuU27E7Mu2ptHd1qV09QzBDk1/5FvSr/MIiDsh6
         xvrA==
X-Gm-Message-State: AOJu0Yyc8udVTLzlzyBPSg7pBvznmpMc2TccROXoxnujzFCPyoSRb1wf
	MtYV20LBHYjfvcX2yaTcSRtCYA==
X-Google-Smtp-Source: AGHT+IGbhgT9vO87oYBilGbQgroK7jcZ/zlk2rsnkRYplhEz5MNw9ddi8oXuXjh0yOa10g6vVr4nsg==
X-Received: by 2002:a05:6870:5d87:b0:1f4:d9a6:d4ee with SMTP id fu7-20020a0568705d8700b001f4d9a6d4eemr8610280oab.12.1700760267571;
        Thu, 23 Nov 2023 09:24:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id hm4-20020a0568701b8400b001e9b02b00e9sm390661oab.22.2023.11.23.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:24:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r6DRC-001sOj-8g;
	Thu, 23 Nov 2023 13:24:26 -0400
Date: Thu, 23 Nov 2023 13:24:26 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 12/13] iommu/amd: Refactor GCR3 table helper functions
Message-ID: <20231123172426.GC432016@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-13-vasant.hegde@amd.com>
 <20231106174003.GP4634@ziepe.ca>
 <d905c553-964a-b15e-19f5-1be4896a7818@amd.com>
 <20231107133157.GZ4634@ziepe.ca>
 <73c7dd92-7aed-f5ce-db44-26b9f5c0876d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c7dd92-7aed-f5ce-db44-26b9f5c0876d@amd.com>

On Thu, Nov 23, 2023 at 10:53:23PM +0530, Vasant Hegde wrote:
> On 11/7/2023 7:01 PM, Jason Gunthorpe wrote:
> > On Tue, Nov 07, 2023 at 11:43:10AM +0530, Vasant Hegde wrote:
> >>> You should be moving to a direction where the ops->attach_dev does
> >>> exactly one update to the DTE. It loads the new correct value of the
> >>> DTE that attach_dev is asking to create. All this repeated touching of
> >>> the DTE during the attach_dev flow is sort of a functional bug, or at
> >>> least a sub-optimal implementation of the API.
> >>
> >> We are not touching DTE repeatedly. We do need to detach device (so touch DTE)
> >> and then attach device to domain (another touch).
> > 
> > Twice is repeatedly. Again look at how smmuv3 turned out, there is
> > exactly *ONE* DTE update per op callback.
> 
> I have fixed setup/free gcr3 table path. As mentioned I have added cleaning up
> do_attach/detach() path to TODO list. That will be outside this series.

Sure, I hope to look next week

Thanks,
Jason
