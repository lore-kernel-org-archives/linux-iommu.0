Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4952DFF06
	for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175906; cv=none; b=fMX6X/N/nUy/q3LKsPd6Sdq1+fZOmDirzJsmyPcP9stgSI2gQfuEHDmWCyVFHQ9jCm3G46zyBeFmqIGHxz/GtU7AqsaSavSyJHkRQc6VWnyw6s32HmtHX0Yf0KxEdYnfeVpf+X5ISiJ/gQIwkMUn5mtDPMb2H1y5FLP8IDhKbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175906; c=relaxed/simple;
	bh=hqAmW2+tkDQoBFUTnquUpaKj3CzkKyd3cuJ8lhWF2fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXUJ/+1uOT6yUIAPMx2X5CLek+4N2dA3itk7w0YPE5Mdj0AKl4hmPY6iWknScDZk3I4IrnwYWF25c3CH6U/BUP8CzwWMRz6xkjnIf9CLD+XHyyTHDT+p2Lud3RUwXZxitUJ/eYFCeqjWT8BnBYKajcpUGpim7FwpLqNHzq1sIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ON1YBUnc; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ON1YBUnc"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d098f7bd77so614012985a.0
        for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750175903; x=1750780703; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QVoUfdHdJ48HnCFe+0ux01ldLUN4WiVyX0euOzInBM=;
        b=ON1YBUncutwB9tp6nMsEg8NV9W6THtc1a2kX84M5GtPtFjQIWnXaaed9NCEo2akDWr
         /tp7rGUcE1r8nIg6h++uZyH/6T92vCZrKdOnsCYLlMaCX0P5Bh6GLDuJ+itWxKx58pYt
         vE1cvJ+6Ga4RSSVwbT1w32Qa5gsOqek3R5R5g/DB0J+HUGl68iX/jWlCjH7GBQhNig3W
         gvkFw7MvYayu10t0+GHrOmThkuS/4OBSJ0cRF+wEoneD8RSYhYpJYA2ZEOwkmcJPBwWX
         0DRn7BlHXiLZs96lVo9PILcPkcrahfax8C4oCvk6gB8d7OFUZClzbb5BfSFyB/Uj3kuX
         mBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175903; x=1750780703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QVoUfdHdJ48HnCFe+0ux01ldLUN4WiVyX0euOzInBM=;
        b=w0Qre8RJ0v28lWdx3uu0VXF/4NxN0rOgGTjD4F4yAR+jDdEUN/UQGD7Pdc2477dVu2
         IqBymlJiiiZX4Zkpjz9M4zW4Xc4FmNkeanoOuZ58ftZUtH20LP7tp7QQa2ziSJPh/q58
         fcrJ8dh2OzlIDZhqYXRqSybswWEARVtCWA7pFwqHCw93hVXx1qBNmhZRmSWc1hj7SFRU
         xNrTcnXUMbHeJfyGbULhY8uCPQKnsKbcITaTahp/jasMzeLY+QPn4i/9mAz5PWnn0Px1
         nJ+jwi9rXb/GOBuiiC0Q0GqtvuBK60uSluA/pz41eGxcd5cwqA0TdudsFw7eCqHNixhl
         UbFw==
X-Forwarded-Encrypted: i=1; AJvYcCUB6k5Jd7Wyz9PU9GEU7+cYTGLmrqK/4JCwyMONIVfMr4pmVje241yt4yj+MJmHv9SSYIbQhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiPWu4sDjCwElFhhzNnvG7sI12//6G4LDCcTwwrELk5rXGJ08s
	2jPu+geyyybQ334Vei7xjdiQ9fTA/LJtVjTp/hZD8bkqV6/CdJljGGEghnbIyY/TiQs=
X-Gm-Gg: ASbGncsDqvHK4xdPrQNZtWV8RsuidmHxahi7arA2onafJLlnFqsnD1MMReWXsA+DQDQ
	jQa3P17JapEKZGfWQC8lmGSDAtjirTTTznxRZ7zs6qwtqyStae6CpUsF9eEPcuublu5b8nkIe2t
	aPaTapMM32Z456XMPaPUxj/mq2er3zHPuNGCsULqmMTzrfYxgPZnPVev/Lz7muInBkrEcJ7B9v2
	J5+M4vdbXjkhJYceNktiAUHuwarek8dzKpizRYkhB9rQufs4yPWZ2Qs47LTntVUGHjXpHu7mbpg
	Y9Bo4mJd9fHQ0Iz8/VN6WdZafJ4gRscNadx644asgp/KhVSTkJTCcGq0nngxP+dgd5c0Ccq95/a
	NqIzR+EyuMpal0iD3RrnmGHIAic1ur+kbTYKsWQ==
X-Google-Smtp-Source: AGHT+IGQBUFbF+tPc3zGviUG0wR17BWPg+rb3PkSRtQpO74uvfm4fcaKBtbG84+832ByxCugbO/j+w==
X-Received: by 2002:a05:620a:44c5:b0:7d3:d14a:38aa with SMTP id af79cd13be357-7d3e07649b8mr472642785a.16.1750175903195;
        Tue, 17 Jun 2025 08:58:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8e0535csm664773285a.41.2025.06.17.08.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:58:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRYha-00000006Wgi-0qrY;
	Tue, 17 Jun 2025 12:58:22 -0300
Date: Tue, 17 Jun 2025 12:58:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 5/5] media: verisilicon: Flush IOMMU before decoding a
 frame
Message-ID: <20250617155822.GE1376515@ziepe.ca>
References: <20250616145607.116639-1-benjamin.gaignard@collabora.com>
 <20250616145607.116639-6-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616145607.116639-6-benjamin.gaignard@collabora.com>

On Mon, Jun 16, 2025 at 04:55:53PM +0200, Benjamin Gaignard wrote:
> Flush the IOMMU mapping before decoding a frame to ensure that all memory
> translations are properly applied.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

This is a really big red flag.

iommu translations are supposed to be controlled by the iommu driver
and should be flushed as part of the iommu map/unmap flows. It should
never be necessary to do something like this.

Jason
