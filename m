Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8E3A9D94
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285213; cv=none; b=m8PC7AvHu7+9TGi6+4HQm4cWwRY7wqIGq4ZThZ/8m4efHh5FHS9keg8T4PP+3J+4+YMleIN6BncISKxNOvDjb8cuXF35NiYBOvy06m+4tMtJe/TX5PlW+Q1P/YiaKHztXvIFSxYSk6a8Y0jtaqyHf7lzYwEU/b1ZlcXJZ/F+OXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285213; c=relaxed/simple;
	bh=2DVz8sU5u+XeNKZ8cGlG1d5F3wppAWJgrSJCeDVWwak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbTDJRIuDLQCJD5uG+I7udwGSkbp7VPYhy6Lk8EiBOISgO6SpuCJMoWUz2kIUP9Df97OEc9DwX7QIcJ2J1o2pbhTauUDHi23yqiCYaeFgwHrTfCUPZbfQmac0bCqTiKv4jL998YXTXFaZvwARYKdg0lj0+yh4sCRz+NNGS4uMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z48n/5E4; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z48n/5E4"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-517b1f2c668so11677661cf.2
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781285211; x=1781890011; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JMTz3P3M5+mhONvRFA54PklFy7T+a9IZVqRwd4AHnpM=;
        b=Z48n/5E43CPM5tpiPG5M2YhPonf9u3j3L+owB8KNK4x5/83uqDWx28w/M/3a8lQ2vI
         ASYfXQHoUWtuSU/fboaY9mkHzrs28xfl9b4DGc+qq1Rv23zuVCVEeD8tVYVQ/rZBFPIr
         j1DKFI889fpOM7pEi7lZJKdaml6ij3wDeKY4fzDS20JOC0kRdq8nA5ZRK/fIcc8cC3cE
         Lppzf1eov2pQHTDDqSLxYPZEIN71B0EOjnXyDCQO4dagpmeh2wavyKkfQAO9sjUUQCrz
         J5lONl27o8R1M5ihIhImAZXZDGKs+dsojyQLbYBkn9J9NNv9TzeLKgGja4tHmbHpMpZd
         oOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285211; x=1781890011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMTz3P3M5+mhONvRFA54PklFy7T+a9IZVqRwd4AHnpM=;
        b=cxLTVAETu0CYboxa+dwOzO01ZMoeJeMMcJl/ErTIz+qUzT4wJM0BYKDNwF5G40IZe1
         R3lQATC5BdT5/cQ/eqdkebtlOttibsMv1IIM5q9Wnt4kLV1ileBngvKx+RfzCxEtRSQK
         PsxjvJyEXJu8GvuaWGsjVxBi79HzDmLffDm8fnLT42SqzNtkgb7iVLw9SOm+gX9D7eNt
         R/F4KSC6jpE5fssM9wIRieVh+hdLj9McpLj6+Eese7ipdgjk1luWWKOxRwmOOsdXTSSf
         1tTmoj8G3U3Dxuv1PNloCNQWTQQxoHBpOp49IOzhfjdV+LjnEn0E0iQpS6ll56W8QTQ3
         XU0g==
X-Forwarded-Encrypted: i=1; AFNElJ/0Rzc0gI/L+PB1dG4AqU/m+QQxAO3J4KUALTiCttKLjA3Ocv4P9NE4eQO82ip77Ag6LVoeig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPPInk2RBmFva+CtyS6zq3uj+YfzPXvFyPd/ICPuI/QB+sn/5K
	iGNhKNtZVHlbXqr2I4VvujkZKNejGwRd9AU1EL+258YWUDJHVSskiipVN0ZsZA+25BQh2e7jms+
	qMwpq
X-Gm-Gg: Acq92OHgr6eGPiBRxRUgL+3yAIL2sntG92zOOf6x2oowdRFED9y/f4+Gt+mFZG6aDEb
	T91hNqITbKWMr/CRZCkJoHUt9WeC0jQt9K5P/H0RsCFfDrOiUkS8LGiv6Y/M9IOAQydw8/hoZp3
	MPoP2hLkEBNvMXwSvM+beB3NFeCRBq1Qrq0FlTiKS77ZCxLVSTx8903ed6sfrpctxg4D8DO4R3v
	kjGfaRjlgA5AJoEa9LLbZuodteIgoASKuGUAP2XnhlzqyfIm3guBuJXYIod13oplY/WWH4yqy4M
	jhy3NnukQYy5sTAKqZyT7bhtvL7wTvPF+N3lmFAWQ6HXbBKUQPAqW9xYFRsXoIUcLFKEKclwaLz
	OAZCSnyD0R4qfhJnccIYP5d1PG99AcxeBN+wJlZP3I1B/nrTTovRTioAJnTw0OMHFLH6Yuvoxct
	ONzIHdfKr5FW/pV2iv4W8Eqr6WDn+VNNNL7PjlJH7HVtn9m2qWltKWmyvZU2DCEfJwSOsRg997i
	8om2Q==
X-Received: by 2002:a05:622a:8d0f:b0:517:84f3:6908 with SMTP id d75a77b69052e-517fe4d6cbcmr47908311cf.32.1781285210450;
        Fri, 12 Jun 2026 10:26:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30240ad56sm28412346d6.22.2026.06.12.10.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:26:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wY5eb-000000089XQ-1dYe;
	Fri, 12 Jun 2026 14:26:49 -0300
Date: Fri, 12 Jun 2026 14:26:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	m.szyprowski@samsung.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, vikash.garodia@oss.qualcomm.com,
	dikshita.agarwal@oss.qualcomm.com
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
Message-ID: <20260612172649.GM1066031@ziepe.ca>
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
 <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
 <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>

On Wed, Jun 10, 2026 at 07:57:50PM +0530, Vishnu Reddy wrote:

>   +--------------------------------------------------+
>   |                  VPU Hardware                    |
>   |                                                  |
>   |  +------------+   SID-0   IOVA: 600MB - 3500MB   |
>   |  |  Block 0   |                                  |
>   |  +------------+                                  |
>   |                                                  |
>   |  +------------+   SID-1   IOVA: 0MB  - 3500MB    |
>   |  |  Block 1   |                                  |
>   |  +------------+                                  |
>   |                                                  |
>   |  +------------+   SID-2   IOVA: 16MB - 600MB     |
>   |  |  Block 2   |                                  |
>   |  +------------+                                  |
>   +--------------------------------------------------+
> 
> Each Stream ID maps to a distinct IOMMU context bank, and each context
> bank enforces a different IOVA range.

I think Robin is saying you have to describe your HW properly in
device tree. In Linux a single struct device should not own multiple
*different* IOMMU contexts.

So your DT should describe all those blocks as unique DT nodes with
the proper dma ranges and related data so they can do DMA
correctly. Then the parent device has to assemble itself from that
collection of struct devices.

> These are synthetic child devices created at runtime and do not have their
> own of_node. Inheriting the parent of_node might not be the correct way.

Why would you create child devices at runtime? Linux doesn't really
have a good way to create a fully DMA capable struct device at runtime
without a DT backing description. The fact you immediately hit API
problems like this is a big clue :)

Jason
