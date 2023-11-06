Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC629420
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OukJQitm"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-41ccd38eaa5so39277391cf.0
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 09:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699291831; x=1699896631; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RDtlqSw/Pe1WsD+xspeZn2r1NHjxIVGrKxNu3Y86d9E=;
        b=OukJQitmfQ0zlQmAWMkWqWq5aTtJLgft8P2toZE0lc2RNcGGT/K4/DmxaZvNlIAQq6
         4oCZCULhofUYaC8kjXqGaWla8TpU9aMQNgaiIyQSSVXXuJ4HROUVOgPyK0wpVDYCHreo
         oBhH7nAcJR3FWbNuk7e7FioEe9YgmNy5lpIM29NADAMvfWEnvfDzlqcFw7ZQ9VXJ+3iu
         buK9m7cECo3cAtS79j2/sQzQvARpXd/AFVEnzlir2u2xHExJtURH/QxnfhLZDTY5p2KY
         k63yrp0VecuF9AMVNw44j3dZxETXdc+y5EK1Z7x6K28gIYRuPNzGFaHVMX3QbPYSuO6z
         BhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699291831; x=1699896631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDtlqSw/Pe1WsD+xspeZn2r1NHjxIVGrKxNu3Y86d9E=;
        b=suxK0es4AO+2pclDDui1mK8ZPE1Qv95UIOzHhR0Oc36tQm6a0EWYFyB0tsGQyr2FFv
         YSgKhMomeQ2gMHyUIWu/CqhLnCSDu+8lEKoMEGAt5MkUgRzsTj5PNKS+PldC0WRJ3hWH
         nCL15kuSD4ZDg62tbeI+USFGWEyFv7nir/TUHuQsJm+ODcCA7UlaGRS/jvNov5HRvI/z
         QZfcqZ6p6fAUeRZxMwnB0Dm8gR82mY6s73X14mZKhBm288Q4v5acKK2MUJY0ELx9bw4d
         06zO3qRuvxK22qmaH7e+X3CoIPng6becxtZbRu2beS/i3QsRUea821RQTIjpYJRYzVJC
         mmQg==
X-Gm-Message-State: AOJu0Yycnq3Z9/o9Q9GPKjMTt1/vuIWcGEaS9jRzyR3AIeaKPxOylH1e
	e+cj/abSAWE1XNw/SkmD2rcHkaWiwQiUfx+4oHQ=
X-Google-Smtp-Source: AGHT+IFHB6rkpX/WkOnkK8KJ/YQFI8klVzVQhFQcODqAauVfrS+6BjqpaTWjSXIGpX6c5tCzbw6cwg==
X-Received: by 2002:ac8:7d83:0:b0:412:3d25:9019 with SMTP id c3-20020ac87d83000000b004123d259019mr240156qtd.6.1699291831371;
        Mon, 06 Nov 2023 09:30:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id z7-20020ac875c7000000b0041b7f007546sm3558457qtq.82.2023.11.06.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:30:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r03Qj-001P96-Ti;
	Mon, 06 Nov 2023 13:30:29 -0400
Date: Mon, 6 Nov 2023 13:30:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 11/13] iommu/amd: Refactor protection_domain helper
 functions
Message-ID: <20231106173029.GN4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151652.6008-12-vasant.hegde@amd.com>

On Fri, Oct 13, 2023 at 03:16:50PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> To removes the code to setup GCR3 table, and only handle domain
> create / destroy, since GCR3 is no longer part of a domain.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>c
