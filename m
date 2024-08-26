Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F8524C
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681163; cv=none; b=SLgotf1RPLJ1NVtHh/QwhBKgKnSec2h3toU4NbOdoSycIOBIuPim2q1QRl5apCRWmu2ZwiNiwoqyELM4Ro0qnZj4GVGuoNfT2pb3WZS0mkmyos5Q4KL+X6FvJbNAwT2uq1+lG3Ida5YZ/d0anpoGG0gqiVLGcALvEXFVzuU31U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681163; c=relaxed/simple;
	bh=RIDwIR+2Rx9D5RHR1S20zfCpZr4QXOrWH/qKh3d3piI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qua/a1ZI6JFTdEELm15oa//qSVm9Yveas9pd4O14ZxGpQrBTuV2PRqZifke+j/c19oT3kBHu1edk/IL+ktGNmx5gmyn9w0QT9yQsPCnsIsNXfHpozFCutVIP33qGK1qwpd+VUx8BXNZCZw0B54MB81u1tQ5G/+04b05JXTFMqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zo16r6jh; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zo16r6jh"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf6606363fso23628236d6.3
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724681159; x=1725285959; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9WhmiaSBnitzHla03ty0244NTX239qMpOZBKbSMJZCM=;
        b=Zo16r6jh4c4/y88C72Zydh2X26UGCo+tt8OYXWJp/7bavteG+lEA4YOvbKylykMtAO
         2QNyx9TJz6iFp5jTw3qIyu9gaE7/Oclqw3UWUvrXjYa8v3gajJmmXrPdPtAinwlakC/y
         OCTsJAEaCrY0q1Gqtml/jK4oJfS07jBiIHHiqAk6Za02YOwEsjEtjIl+GiYDujTxM/b4
         CX2FdnSX8mJ7YcS2tY5vTVgAlCyOiAZ5rQS6G0OZnKRFGZgXpxg+PI7ZRy7MGI+zixNl
         hg5/JS6trrqwZs6U8aWtsnshg59+9jRkBrr4zA5RDQ3nK0MdxhXkT+pnOFSvq1rp503H
         Qufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681159; x=1725285959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WhmiaSBnitzHla03ty0244NTX239qMpOZBKbSMJZCM=;
        b=eG50nsRxszpfhyl43ORc4rPzW4/bImtQA7kJEgYmGMlACjcCJ3L9F1XPfeqggSKxxu
         Ll4PCY3W3QAwVd8gjln+fkXDUbb9mQD3FBkh/riMH5bpiixdWyFOrAm7C4KnwAYhuIgC
         mwgsSyOzVUbIHnjFoB4MsXlLJiIO6wrCqCdBl31OAb7jc9MnNJ5xNY8isv6YpMuVcQ8C
         wIiP1ulayvXpHKon1PAB1MRH21yypzK549Lr2kTxKi1U16viHxIS00t6xxtSECxg6Qle
         Iy1RCPvQuk2lD+0uopQU3oy45S5cCjWV0FY21FUIH4rjdVHcpZPBc6DMr9OMsWxnSAb+
         7g4g==
X-Forwarded-Encrypted: i=1; AJvYcCWovdJKPR6mqI1eIsAHc2GGYikdlxIoXDmyB11j/UAwCwI81zn43wkxXoB5nJ1sX/xuKxCBTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtWTmbw2JSfAjyBqUf0o+AguNDLlVyKETpgeDglXEMiIt3b7eo
	ITKORWyahciUbpl45dihP277/DSe0WIe3cXrFFqlO8/3HLzicj7yOVyI5FIvvbU=
X-Google-Smtp-Source: AGHT+IHTFNEwi8Tgl5mNGmRza2dJvvg6NJOxBP7ZRRcTgGYGS4YXyziMSVzhUNWK6bum0ImXxbrC/w==
X-Received: by 2002:a05:6214:4a8c:b0:6bf:960e:3d84 with SMTP id 6a1803df08f44-6c16dcbf642mr136210126d6.40.1724681159148;
        Mon, 26 Aug 2024 07:05:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d52a68sm46958906d6.44.2024.08.26.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:05:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1siaM2-00BycP-4x;
	Mon, 26 Aug 2024 11:05:58 -0300
Date: Mon, 26 Aug 2024 11:05:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Klaus Jensen <its@irrelevant.dk>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Joel Granados <j.granados@samsung.com>,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 2/6] iommu: Make IOMMU_IOPF selectable in
 Kconfig
Message-ID: <20240826140558.GJ3468552@ziepe.ca>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
 <20240826-iopf-for-all-v1-2-59174e6a7528@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-iopf-for-all-v1-2-59174e6a7528@samsung.com>

On Mon, Aug 26, 2024 at 01:40:28PM +0200, Klaus Jensen wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> IOMMU_IOPF is no longer selectable through INTEL_IOMMU_SVM effectively
> severing their relation and allowing them to be used independently.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  drivers/iommu/Kconfig       | 2 +-
>  drivers/iommu/intel/Kconfig | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index a82f10054aec..d3ee8a0ad4a6 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -164,7 +164,7 @@ config IOMMU_SVA
>  	bool
>  
>  config IOMMU_IOPF
> -	bool
> +	bool "Enable IO page fault in IOMMU"


Currently IOMMU_IOPF indicates that the driver wants to consume the
library functions around IOPF, it is not a user selectable because any
driver that links to those functions should have them working. If you
want to make the core driver use them then the select should be moved
from the SVM sub config to the core driver config.

If you want to change IOMMU_IOPF to a user configurable then it should
have a full help text and all the kconfig places touching it should be
turned into

  depends IOMMU_IOPF

Ie you can't enable any drivers SVA kconfig without also picking
IOMMU_IOPF.

This is doing neither fully.. Pick one :)

Jason
