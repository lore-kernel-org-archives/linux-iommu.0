Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE71D0F5A
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186103; cv=none; b=YWzT9XtNf0ugfT6nZ2jOc3eNrL9j/tNkgvcl1nMliy8bq/Zpu6Z1WAVn3GhJhtknDgYH+IWgka0xJvBMOB9BzHhRfTlT2bfi2lSDEwJPWdPbyKCmGt+yEmb2Nnub4/Y0RFVr0v6WHd3k3/E3H9GkQeiUw8pA/Rk/hJRjnpJXTuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186103; c=relaxed/simple;
	bh=BRu6GncHBsrUtLwaenq3e6kyzHxEBuj1aoQm+Ttaojk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmPmA/FfRrTgjOmrN+DElyMwKkKyz9KYMD70mhtPnKlvv791t/co1qDB72/q1HUM8Jt0/shO9zLMTzu2uMIS2Ld9gnfJUwEBSuf1i10B+O7Tz6BdIQ0z+uLvUJD1vksfD6eMClzqU+h/FKIXn5M1A4G0SltWrX0GvrgWNLVz9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N0qBv1+V; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N0qBv1+V"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476ab588f32so34729051cf.2
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743186098; x=1743790898; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRu6GncHBsrUtLwaenq3e6kyzHxEBuj1aoQm+Ttaojk=;
        b=N0qBv1+VBc0p8ZjAIBdjR5N8GVCLZ2Qs44n4uEzVbyfiKz0TR1543KoL4pN3APRU69
         gSedabGGxDR2LRcLRvZYCxQp9RXFjlGkMpUSDyZTq+jgcaP3oYPa3TLKIw2/leesX2n6
         wjuESnlextJsAqCAP2eAsLBqcTME+ILsAOWDG21uxI66kA/Bo4tWvvTB9L/G253FVKIn
         2bHu/CaCAh7a7FQOFrd28LH605W1fcVQSMfSbNmMk+YgCOqSX4JFpO/A2LYR3zNxRC8v
         YKwPjGRLb+urj8YvKZoG8db13l0vmLNTBNOXfRYmmt25b6dptZB9f6w2oIfKNwf0Kn2J
         t1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743186098; x=1743790898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRu6GncHBsrUtLwaenq3e6kyzHxEBuj1aoQm+Ttaojk=;
        b=muwRHo/aSXqNQOHMNcL7oeQ83lQX1MiX6gJ1jkpmAuBsjHrLhDPmJ+PmJLVYVo1mH0
         2IeYbugafcw39cG/XyAQFPOIikwKuSFk/V7w2op3TAZRTtMopb0CPu/prNA9igHKZFcV
         PUEE8TOTrcr7obLSQkIdAl4viwe10AMw9nz8OeBFa/zSPD/UHMH90tvVLWBrB3egAN4J
         eN4ZQj5ViCsZ9/tpqD/8CvFuzzZtspVd331noa2LgGs6yx65SIKxeN/U/kYkX0qq7joF
         Joo95zv//9A8ooEHf+1M1EiRXuoA+AOCo2EEuh37cxbSyOESWNConCPM5bxjGD6V0A3H
         ulJA==
X-Forwarded-Encrypted: i=1; AJvYcCUV6mMd1qxZQ8WRDJAjzeehpvh5KB1GJSpDroOHwt213VlcQp36ak12cc1jMjlh2aS58ytkXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyntVoMO+KNOP8a2DjeMMRnVkW4OIXNUiwOcDC7QUK07DIknnRn
	b01tH8yl/xnFN0/JIdqi/VXkAj9Eap7qBk5XgBHBA5nu0QtPrnYkJWUzMfVufg8=
X-Gm-Gg: ASbGncuD4uOl8mwNLv1Z3oFeF7Rxct/Z55XbtyhsttqwFdtSuQvE7b53+8WLvZlzbhQ
	8dtzhfl1IaRyWE4wEH2zdhw+bMsaKBhbpqifxmExvfTXFSjTVDIVFEGZmpYlyY9a9bYCrl35nbW
	JqHK57mH9/SSSkLyRaBvZcWiDMiF+/D9oK3a904TMzMvKx60MLNISmfLdE9cEznnYcjAt2JSp4x
	VyzRJg0ecq9PgWoV2fEHsY1uQRHjLtLYtLEK9CHBBvGBumqETVWzasUKiVt7hxwIkELyHLky8XS
	kGhEOqUeORwrdrLyZ+wPvpKXrADdzj2ytizH4BiYeBo4iva5UHnCgtwMQU+y+wGiM/hLlWzJf1r
	3ydgKn5hSajJ3UZKlINqZbkU=
X-Google-Smtp-Source: AGHT+IELmdhFbkL5W3KYRO2T421tNYk3s4vgaVkxTzv27i2+QnOi/XJdiv1xAOyOeYOAP+8wpmAiVQ==
X-Received: by 2002:a05:622a:1821:b0:476:8f90:b5d9 with SMTP id d75a77b69052e-477e4ae50c3mr4123251cf.5.1743186098267;
        Fri, 28 Mar 2025 11:21:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4778317b422sm14154691cf.49.2025.03.28.11.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 11:21:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tyEKm-00000000h20-2UIY;
	Fri, 28 Mar 2025 15:21:36 -0300
Date: Fri, 28 Mar 2025 15:21:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20250328182136.GA161236@ziepe.ca>
References: <20250319115730.GC10600@ziepe.ca>
 <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>
 <Z9yV8KsdXnZg1Ppo@google.com>
 <Z911UT59UnDzRymF@google.com>
 <63806834-a0a1-41e0-9cca-60087b460f78@arm.com>
 <Z-GYKyBi78tHw8Lx@google.com>
 <Z-WKlZMBDTJDSfd4@google.com>
 <Z-ZoHdfgyaZoqJkm@google.com>
 <20250328131844.GC20836@ziepe.ca>
 <Z-a7dF9HPGteVVCp@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-a7dF9HPGteVVCp@google.com>

On Fri, Mar 28, 2025 at 03:08:36PM +0000, Pranjal Shrivastava wrote:

> I like the idea of a flag telling us if the implementation boots with
> GBPA.Abort = 0 but I'm unsure of how the iommu driver would understand
> what attachments are insecure (or even if we'd wanna add that kind of
> intelligence in the drivers)

I suspect we can reasonably add a domain flag that is set by vfio and
the pci untrusted paths.

Jason
