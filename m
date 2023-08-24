Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350497E
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 22:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692917332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYojfkCeMW1kSDc4xyD853iDzb+b8vkJJzJI0yua3eM=;
	b=hQfqm6KnluXxcm2aq7YYkNWkcJ2VvvezDxNaE1+fjqF53DwMU1VnA2aLDvtYkiGYMqI6Jv
	hE/mMVkcGfKkJORAXWfFyuSCWbyTVUHGzFhdYV2O8nGndsp85GRA9c5j6MlMFcE2+cp0XC
	uPUZLNyWISm8WzQlnDVdAsNB3OmdlWo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-7mKq-3IRNWmlgrsEk7v6fg-1; Thu, 24 Aug 2023 18:48:48 -0400
X-MC-Unique: 7mKq-3IRNWmlgrsEk7v6fg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40ff89fcb76so3351971cf.2
        for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 15:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692917328; x=1693522128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYojfkCeMW1kSDc4xyD853iDzb+b8vkJJzJI0yua3eM=;
        b=D96Va+PHQi/I0WiRsrqy3FjZqJ/+Jm9yBHpyea5BwjqbdMNn1/S0NHlVRsgLDBdbBM
         VrgmyWTdf28kJypRn+26Owace0R//pPJgfsPdKxik3fFo/D7dBqb8DRftRzF/vmMPLd+
         krP8QWMwwiA4eDB2saG+4/wn0+/NEMJlm2dhrEw9qbZQnFE/qCrLr/2uiBP7p+qT0ZXb
         jtkJ8neTPJlNNjZUPCJPujF5J5jtYkydZNS6EQWVHebHqnvajbv1HgObQ8BLkjBYcC/j
         BxTB9kCRVlavzqHNgMvfLxOSlcKfDPZJ9GQcdbPFAXR1nX0GIS56AJPekHtGH2XLzyXu
         b9Ew==
X-Gm-Message-State: AOJu0YwfyjU2djwOh/t8hLKJOvXyWZzkrZZuVsuIxDz2n6Q2hGjzxB7N
	sgnHG26EC+ge2MKJJhbx12KWVhK4PBPzxwVKlnHZ2q1Gi4BUXHBqOGHjJ6Tb6fiaWvp6AWRsPcD
	SyDhgFe14jn7jdPc=
X-Received: by 2002:a05:622a:1ba7:b0:403:a91f:893d with SMTP id bp39-20020a05622a1ba700b00403a91f893dmr24722157qtb.26.1692917328070;
        Thu, 24 Aug 2023 15:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3HrBByd8C0V7qrezkv/zQqa8fPtZQZ5Wwv6kZjuDY5wLmQa7QuV+cVeHh3FWS/ZTcznSJ5g==
X-Received: by 2002:a05:622a:1ba7:b0:403:a91f:893d with SMTP id bp39-20020a05622a1ba700b00403a91f893dmr24722151qtb.26.1692917327870;
        Thu, 24 Aug 2023 15:48:47 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id cm19-20020a05622a251300b0040ff6194ef3sm140967qtb.70.2023.08.24.15.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:48:47 -0700 (PDT)
Date: Thu, 24 Aug 2023 15:48:45 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Robin Murphy <robin.murphy@arm.com>, 
	Takashi Iwai <tiwai@suse.de>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 5/5] Revert "iommu: Fix false ownership failure on AMD
 systems with PASID activated"
Message-ID: <y7bcqc25x3uyl36v6jv4dtaepfzaunlzglbreg4jymgw5ntzku@sttkvft4qwcr>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
 <20230821104956.707235-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104956.707235-6-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:49:56AM +0000, Vasant Hegde wrote:
> This reverts commit 2380f1e8195ef612deea1dc7a3d611c5d2b9b56a.
> 
> Previous patch deprecated AMD iommu_v2 module. Hence its safe to
> revert this workaround.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/iommu.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 

Minor thing, but is the deprecate the correct term to use here and in
the cover letter since the series removes the iommu_v2 module
completely?

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

