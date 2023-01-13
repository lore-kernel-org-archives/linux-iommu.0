Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E912F2A
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 15:33:52 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id bp44so19417760qtb.0
        for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQI6vgm2xgQgpNNvT4RMcnXxKD+7fzh1MD+K+DhgarA=;
        b=Pprb2f4po0IpIe3vbwxVGZBmpybDrmTfJgxva2CmlvWg06Y3JUow3UHlg/AnmwW5Yq
         9V2roOs8bRBvWog3uX4ifMfUR1MYoGklXRENmhDRydxccS6F77l87cUw5kbAaUG7l6Jw
         43Lu0EjlNJa8GOjw1auSYr3r+sz/hCucHRRp3frAnRlmHpoToeAUyO4D1oOzEUiZxzVA
         8onmwupSPKS8LyGskdD7gRz8EG1i0YwmpeMrhMtaiix5TSfB5TiqzSohOmLyds5x6lrq
         IATThdQycbiUifH20/v1MuQuV4OQhUbQDL+OftLrDl73TWTdduBK3nQm9KSo/mXCeIdG
         Bvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQI6vgm2xgQgpNNvT4RMcnXxKD+7fzh1MD+K+DhgarA=;
        b=k98LGhV8i3MwPNR52HAQrBkXJIV4sb4OH7D3usPJZwmNswnYRNB82LmXZ0IHmloFpT
         9y/HHIiktA8cVu6CkwnsLplLDbDeUOryEquWo4r1zMV99/YbkG7MbaJcNQg+6ykv8/Lo
         sVHmI44YJZJygy3b2i/jN9PZuCbpvZ4YQORZ59yhjSwErhKA3SroZKyKDEAv2ydzTNKu
         AMksR/Z9p3cCbkcDTcsAl1/g5ADYucZpJyPCY764Yev7PQuYpLx/mCdA/KJ8Jfh1RKMc
         GJgEbdZzqZWFBbtLKtNxVASZXCe6Odc/Xexdp4jIQJR0C1jHMvoDjGqpAMDIybse7SVI
         UEXA==
X-Gm-Message-State: AFqh2kpOd9YMOsqV6zsZab+oX82QC1JKRuDAoB17zFUiURniMMQVX0S2
	z/BW4UEqLFQg74gd7VZYCgO7rw==
X-Google-Smtp-Source: AMrXdXuZR91ECSn7pKg9pvDh46I8W2eiRyV7xt40EsLkKPvmvLUjBdS0ALJVd/MI5RbEYttreGSglg==
X-Received: by 2002:ac8:41d9:0:b0:3a8:a8e:c0e0 with SMTP id o25-20020ac841d9000000b003a80a8ec0e0mr101344764qtm.8.1673624031141;
        Fri, 13 Jan 2023 07:33:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id d12-20020a05620a240c00b006fcc3858044sm13185779qkn.86.2023.01.13.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:33:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pGM3x-00AJkz-9M;
	Fri, 13 Jan 2023 11:33:49 -0400
Date: Fri, 13 Jan 2023 11:33:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, ashish.kalra@amd.com, thomas.lendacky@amd.com,
	vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Message-ID: <Y8F53dzdebKLTlOy@ziepe.ca>
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110143137.54517-2-suravee.suthikulpanit@amd.com>

On Tue, Jan 10, 2023 at 08:31:34AM -0600, Suravee Suthikulpanit wrote:
> Currently, to detect if a domain is enabled with VFIO support, the driver
> checks if the domain has devices attached and check if the domain type is
> IOMMU_DOMAIN_UNMANAGED.

NAK

If you need weird HW specific stuff like this then please implement it
properly in iommufd, not try and randomly guess what things need from
the domain type.

All this confidential computing stuff needs a comprehensive solution,
not some piecemeal mess. How can you even use a CC guest with VFIO in
the upstream kernel? Hmm?

Jason
