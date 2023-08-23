Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C91FB35
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 22:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692831280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/TR5x9MoWbZhFzLAWapQ/JUjXQmpkE+GfMoXwoKMfQ=;
	b=A4n1vCdcIRHt12bzv1ppC+RuV9vqEpIGodazunYNzoEILDkEkm9g8gN7C5wtulRp+CAOwl
	jcs21138j+P8B5h5elK8NxnYIIP2Kl5wemTZMOKWY8S7fibkeE5t6fP4NcKcgEdIQREWF0
	umVqWJMA7yWisufj9/psaMbHJWbyi44=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-YqiuNKFRMESNsH8TEuS53Q-1; Wed, 23 Aug 2023 18:54:39 -0400
X-MC-Unique: YqiuNKFRMESNsH8TEuS53Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-64f412e568eso39094316d6.0
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 15:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692831279; x=1693436079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/TR5x9MoWbZhFzLAWapQ/JUjXQmpkE+GfMoXwoKMfQ=;
        b=FBYaRnOhDIY5e1R+TAsPphPVewivOGaLpuTKWPPXa6kRlO1B3BWMmGD5ZB1qgSic32
         gunzbrAsdAIc/NY2PapgzLsehFQgq5s+nJxvTQ7qD2ttul2zYOsEsTatII+143G0RPVE
         Aa85VPFRp2RefaEUKQ3IkMgEzxKIPo1EPyS8EJUcGWr6tdC6Mm1Q4PlmIbXxjEOD3dlH
         1ZIbuQSfFLJRYgq/XYF04XgLj6LNqOTPRDq/Q/vi4/fOfbZOElJNN/kWl8waj0v6KvQ6
         t7p2qPtUtqlNPt7lTqEPBAP3e7lxRzs6/DEjtNHzly9aLy4gkTfmOhJF2Ww2IwclxpF6
         1ung==
X-Gm-Message-State: AOJu0YxVJhndoU1JfGucm4xF6AI911dcXgKsgB2wGTC5gd2ZES/+eseq
	0hUtjPBEbEwi7MopS2Ry32Pa1Ode9GKxkg1FGGA8ph6mNfkZ6HKnzzbmmYoOC7Zs0wpe8wY3iDw
	ASqeEsii+VpuxhF8i4erx38Y=
X-Received: by 2002:a05:6214:3bc4:b0:64f:42f7:8452 with SMTP id ng4-20020a0562143bc400b0064f42f78452mr11267561qvb.40.1692831279150;
        Wed, 23 Aug 2023 15:54:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKGL7YvfStRFY1HNYsr5h9rORCwnH2zeQ9zqM2ErDXYP1Qm5vF0yzFOZC9TpoLYQBqVsE5yA==
X-Received: by 2002:a05:6214:3bc4:b0:64f:42f7:8452 with SMTP id ng4-20020a0562143bc400b0064f42f78452mr11267551qvb.40.1692831278947;
        Wed, 23 Aug 2023 15:54:38 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c17-20020a0cca11000000b0063cf9478fddsm407358qvk.128.2023.08.23.15.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 15:54:38 -0700 (PDT)
Date: Wed, 23 Aug 2023 15:54:37 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 10/14] iommu/amd: Rename ats related variables
Message-ID: <4dps3nps5qjytt2cakchwazh642gskdcx2lfde73gbwrhfqekk@6afqxdswov2u>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104227.706997-11-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:42:23AM +0000, Vasant Hegde wrote:
> Remove nested structure and make it as 'ats_{enable/qdep}'.
> Also convert 'dev_data.pri_tlp' to bit field.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  8 +++-----
>  drivers/iommu/amd/iommu.c           | 28 ++++++++++++++--------------
>  2 files changed, 17 insertions(+), 19 deletions(-)

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

