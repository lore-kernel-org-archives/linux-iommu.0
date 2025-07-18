Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5E221287
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848045; cv=none; b=pDIPrDN9MAvwFTZqwfcJJsWeujcddrBrfNWNo/vjldzfn1rl3Ir5/LyQcaNJRJgLi6EIvUUTqqtyes9IYuGz79EyGsRCtbpMZbctl136hhbrax8oFPdwtuj4Vifbs3N2pQhLMB3F23YaNtPA7a7qzOOU2qFuvhHEjZafp6NEImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848045; c=relaxed/simple;
	bh=X2kw8wKIFchN7U6f3WRj7akA9iZyWVrco2+eQsNCM5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=algV06uxxRVswsJUZHHq5gi01moR52zYn/3/CdJBLSW9E4w80hTnKADcIgo7DefJw09b11vkZeLFzQc/4zmywT2J27sd915jyM38X3s9etzFjGcH0kmRWTQvx1Wxc3JjztdE/IXia0xoDL/G8HRhxC8ozpQJunfn5AKIUbRNVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jr/EkUvb; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jr/EkUvb"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab6e66ea68so27655081cf.1
        for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752848043; x=1753452843; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2kw8wKIFchN7U6f3WRj7akA9iZyWVrco2+eQsNCM5c=;
        b=jr/EkUvb7ROLAoKeV82KAEto298tVFXmebWl5KbSISa2sdfa5jbsitmko/Z5MsML/R
         HmyRWDyVDWcmNQAkAo7nQ+o6FHaTOmm4Y7BGD78+iMF0rk2gaxf0YFMbc3h2KC6j0mRR
         lKUIwcqEJa5IDo+OwrbJW/N6kUT6wnbTU/c7T7UxJRIi9aLvPYP5BA7RKKCxv9n8JXHl
         is0YiTxz8SEZ8LuymQxVWO61MpM9hI1/klmGxfkSxHpzX2GBpcBUJBB2HjKoqmioyjv5
         uy9n43LOlGGAB9edPh5wlxJxE4nN2FambiJtfqQYfYu4uFWnhvEuVS0+RNaGGERxvG+V
         xFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752848043; x=1753452843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2kw8wKIFchN7U6f3WRj7akA9iZyWVrco2+eQsNCM5c=;
        b=OuP3P9jpB5r+ARsFfaoYQPsJRY/bmaFC4aSFihzZgijxWptw47l11u5Ki29/wgbLXv
         3hjNKbzYP4kObvAJEA6hsj2LllIH6NCPM876T/GV2uzib4AK+DaHMKznKvtsAr2OHaWP
         5W41pl63XSzqliu+YlpYrKo9zNVMVkG2qtTYSKoRw1/5TJX/QBOMtLf71F2FzsX3KymT
         gUDvFSK5S/Ao1vl+yB+Q45ylLqGuUQUjzNqN38trAzZldOZZN5Y5V3M9szJBM+TxgvUT
         uWGp8BFg0CpGs9bOPZWlceyMQ7dWzlpQQlTp5QnVtzoQTX/KmXELxT3bSBHkLQtQ96SS
         fhLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlahQdFIMFTS2vz2R7X+4dRnXa1b+yWvk4AP3kc0iLXnqFoBFH/+dTyGATj0dQh96enyPgtA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw84wypY6pVrhbHQD/t5vdOv034++Rqt8UVbjjMI4bilHsZmaSM
	MRAYB5XgvUciMkGXUujSVPbY1k22vTAkkZzhCrJj2QCsUWEO6eIlPIFjOC7c92Gpefc=
X-Gm-Gg: ASbGncuY9Q9JzNRLbdvSfgUlU9/vePFSl6DaoZhw/xJbQoDOBwFaP1k1F2+n6iMKix3
	rC02ioMT551y+nW9nUdv/XpqKOORVg3gc/+BNjdxlzkL3HKgxIm1vPu6ZlwBX2ai4V0t2S6Dyby
	/s4bi+D01ckc8A+lpUiLbvXdNlCCJ5BaSi0mCowdyV5KtMBwAO5JNUPW3SwIioIC4mQaJ8Sgoqp
	TI56D5WK92ic/b0TMSsWGnGGkf7tQkwJu7P+uzuJ3+ec4687RwdnwEV/dGcRU7/aF/RacYNLFUW
	Y1VKb0B1bqv+1Phx8NDd0ot9hxS3LTh4ki0tGTB6+B5HtcBYhGV0ZtckcuM1gubBpx2CNcK/8tS
	+lzQztiMP/6n5GMODhPVgqSQhc3Px+31h/qqo6YLTg5J5PhZmF1Ohz5jpgX4H1o4G3wwvljRPDw
	==
X-Google-Smtp-Source: AGHT+IFxlNjnByJpGTyiiwdZo9i9Kku+QZgJ0vVJieheNkgXzQ9j9lwkrn0QWQUloNoVgHfjwg2tvg==
X-Received: by 2002:a05:622a:1a10:b0:4ab:95a7:71d5 with SMTP id d75a77b69052e-4aba3e9064amr110581641cf.55.1752848042697;
        Fri, 18 Jul 2025 07:14:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb49a0046sm7659811cf.25.2025.07.18.07.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:14:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uclqb-00000009zAp-11e0;
	Fri, 18 Jul 2025 11:14:01 -0300
Date: Fri, 18 Jul 2025 11:14:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v6 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250718141401.GD2206214@ziepe.ca>
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
 <20250710082450.125585-4-benjamin.gaignard@collabora.com>
 <aHTzPwTob8_5rtBS@willie-the-truck>
 <baa1fcde-f167-4a1b-afca-0a2957a688cc@collabora.com>
 <aHozv0NG1OBlAH6c@willie-the-truck>
 <b4169471-fcd0-4415-8281-c5bd722e5f2b@arm.com>
 <aHpQXy-bnwW56rCn@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHpQXy-bnwW56rCn@willie-the-truck>

On Fri, Jul 18, 2025 at 02:47:11PM +0100, Will Deacon wrote:

> Just because the existing drivers are a mess doesn't mean we should
> proliferate it!

If you want to insist on something here it should be for this driver
to use the new generic page table code I've written.

Otherwise I don't see the point in trying to improve this in some
lesser way.

If this had come in a years time I would probably insist on that, but
right now it isn't merged yet and it will still be a little bit before
people have time to review it.

Perhaps a compromise where Benjamin comes with an iommupt format
header that works for this and we can progress this series and be
ready to swap it out down the road?

Jason
