Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB14134BD
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 13:49:27 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bba2318546so17463055ad.1
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 06:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690552166; x=1691156966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yA5Rdyi+U/tTPt+xKADvu1B0WUkRb1qkS1f7ee+yag=;
        b=PtG0Mbbq1U9JIZIrD6Dvi7EPetwTur65vuDe73wdXqOl8dVYbqWVx9xuQ4gDizSHJF
         3PiuMBToLlrUvxDUfVfIj9hzRbSI3bGs2F9H3RPJPdZDtZMVvC2hgqt0OR1Qdo97fSoF
         J9dJvKmKjljzcfWtCxHZb+btqMH0uuevKeyuPQoqPQX4h+1eGniXobMbeXk8Yw+ViMa3
         GAtvZ89SeHlYL6TrxITckqULfG6J5ygJnSDCn12BNByUdg2iWviWnZAcTXhlp1GcDu5I
         9plKBXUxdxcqT1nVO1QJY2/25HRKMc+XMhz6UxrH6nVsRW0X2cjVRtj3HAtkIF+mVXZX
         Gs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690552166; x=1691156966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yA5Rdyi+U/tTPt+xKADvu1B0WUkRb1qkS1f7ee+yag=;
        b=OUNPjQN+J0zKCULBYb5SKkY3L0WQWZD1a1IJkbVpm0v5WS8u8NAArYiDXlWd12+QnZ
         4SCfnHItKT4MdJ264FEbZ3K21II8eFbBwAE+3fK4rvEUMRbsfGxYlbS6ToU0DoP6jwt0
         Kj9n4KJCI0VElvKwBlxHt1CRFzZOhwOjAZJC+MiRl8XPLWM869bjIWegWuP6Izcb++DW
         XYaYUUhcwKS1g3l+kVkYQqIzo3wBZ9fuL2bH++An/xW0iaoA+p2ox/j8i+vv66WSaOny
         K6q263sToKtyKwndeu8pjYUTdyG9rcHCWjdyfIeA5R3+1Qg3iUbE+5TjGQ4ZVpKRUeAB
         cu2g==
X-Gm-Message-State: ABy/qLZYHx2wzeD/l5sufjLJ4PtUjTNg76/Uw69rcx3d+oQexGXyN6KI
	nmkO6jFoAILIjBqGHxKK/Cj60A==
X-Google-Smtp-Source: APBJJlEogcOxu+0dLrmp3qjez2NCVV/vx8N5w3pztx4hMg/pv5tnng8bayyb99NaX/tXANorIBOMXQ==
X-Received: by 2002:a17:902:8698:b0:1b6:b805:5ae3 with SMTP id g24-20020a170902869800b001b6b8055ae3mr1554225plo.3.1690552166514;
        Fri, 28 Jul 2023 06:49:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902d3c900b001bb7b0a0372sm3561107plb.290.2023.07.28.06.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:49:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPNqO-001ate-RQ;
	Fri, 28 Jul 2023 10:49:24 -0300
Date: Fri, 28 Jul 2023 10:49:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 03/16] iommu/amd: Consolidate logic to allocate
 protection domain
Message-ID: <ZMPHZD0V2lQHMTBZ@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-4-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:35:56AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Move the logic into the common caller function to simplify the code.
> 
> No functional changes intended.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
