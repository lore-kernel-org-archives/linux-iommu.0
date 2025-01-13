Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2AF240221
	for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785354; cv=none; b=FV9qBX9e2X+DRFeYjkZp8QWjhj+CsNV+iENW3rbpsH0c+IQdiqqm+B6+vS1GotDFCdKnLeu4iLuCn5pzUDAvl/qgNVik756fR6FxaW+3IPk0+/tCSzpRPxM54JiGWlSL8PGqV8r+2v8YMSV4FOlDgw5HwKInH+w1MVFGwozPofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785354; c=relaxed/simple;
	bh=N6oGsVDXTz5YZotXLQU0Nv9iMnfaBqCIK2D9veUOWUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDXN4PFx4cvRoZe4V3NwyF02jlEAsAAn/r7qbbbxkHrvH0884Hw6kLi3TOOd9Gjn72STU4Z8hFu4CVpP81EN7d/w+V1yz8IoeytdDB3DaSt30LjxiJHPrEdSDlE6nHevkq2BsFPkRgbY0t6Le9KFM+aEZy9jDsUXCUqIeH1nuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RpyIrEC/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RpyIrEC/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6f0afda3fso463105085a.2
        for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 08:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1736785352; x=1737390152; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9Y1wAhknpKwAL+LxZwAdihxQFCeEbr4gwAfjxkCAMU=;
        b=RpyIrEC/ygeNztjMnNgfbwS715a9rwjhQ+JxH1sudYwep6Uof0f2RZM7nPe6oTzGJ1
         78G4Nlp9chDcK1tvbOq7nk8cmoZ/rQqEpoYEYEGD3WgjklsZeh+siW5kmXuEKMviCb92
         q7PgHe6X3+iuaRUcjgzFc7eLR0k7kcheBD9NlHHNrgE5J/NxeST5CQiXABASOAPeWVe1
         eqW/2WyPSbZIYG+cOOU3SYLn12lZXY4iOENqhqJ2jz9pcNGDTsu7spebnVdYHSuhAdJ2
         F8EIKiXEE6mN6Bhfhft4gO002XhqRrtAFkpBmrfyVQYitbftKs5sVNXGVlN7p5bwqbm2
         tyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736785352; x=1737390152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9Y1wAhknpKwAL+LxZwAdihxQFCeEbr4gwAfjxkCAMU=;
        b=lPjEcXuxChSnDm7M3rk/tCBSK+5llNQ6PURfMsgSui/HHXQE6st00trzjwyx1CN0y1
         37b9beKj+r/zM54zCo9gCJ9LOordluAqSoQlr4lLlvT1L1osTH073DPPoHa4FEcyjVHR
         oNa9I/AGzGMx13POeTB/I0Qdzstc2GC1KdDSI9Wx+8qdxojZAMonOkqw5Pe8Wd7Mp7n5
         5Sipscods9g3iErpplmL1SOdx6k8zFNBCoIUhBM81Hk/R8GvpO6XA3We16RttiB110i4
         0q8mSj4NHaKWtdPPxY3ojBDX1ALM5PGnoo86doFVPkfbp8xeqRz55s04eRnBuia0e/8l
         lY3w==
X-Forwarded-Encrypted: i=1; AJvYcCVa/FfX3x0QB9wVzvi+CUrmZpf7JBHrpRv0cVdPs67N+kwzOFZhm+gf3wyDD+j+orB2BYzfwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyY77/IW3F62MA9/pLgh6IfeQTmTJvWwOQVBfCqYT/2qZW7TjP1
	zb6pShWkf8S47tj1i25Bq+gBQrjTOP5pzl0+D7l0PgH8koyerIXkAxylH9yty+c=
X-Gm-Gg: ASbGnctos57CyagEQQESiEkrRXUFKxkUKXKzBD+iCgL7c18BfZ0PenCvtOsZccI6Hmx
	MCJIPv+b4Dbwss+0hqMH4WJnWKMQEWP5gOA+ce51x/Kw8bGxQt6qgMrdodn8ZDdu6X/7F73y9lH
	0lZ5yRJFZNYSfyI1AALQG2mHPPJaxLWEYarLqRXEJwF/v4JrL7sUXcHV1+SahMlFbQc4B2Io526
	zkoCw+ZpTWQFJV2XIl70VMblgSVfTH21E65mf4wbZ48L2wzhXp0WPyCo8X25oQlRJgPs9QaOhl6
	9a/ouYnk/FRoipfw4BotZbSzK2WtEw==
X-Google-Smtp-Source: AGHT+IGuPCT1ln2n6Nf8zD9iikzUE0mYU2iIb13AOtbY5Dv0pUxewWhp2L+gz1DvUWP8tgnL3zljhQ==
X-Received: by 2002:a05:620a:29c4:b0:7ac:dfed:65ee with SMTP id af79cd13be357-7bcd96e5ffamr3235887885a.3.1736785351877;
        Mon, 13 Jan 2025 08:22:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3502aeesm507130485a.77.2025.01.13.08.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:22:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tXNCw-00000002FfS-2OXQ;
	Mon, 13 Jan 2025 12:22:30 -0400
Date: Mon, 13 Jan 2025 12:22:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Qasim Ijaz <qasdev00@gmail.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Fix shift-out-of-bounds in
 iova_bitmap_offset_to_index()
Message-ID: <20250113162230.GH26854@ziepe.ca>
References: <Z4O4Du0WN95aP5Qs@qasdev.system>
 <670871da-eae7-4052-abc0-92f90e869790@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670871da-eae7-4052-abc0-92f90e869790@oracle.com>

On Mon, Jan 13, 2025 at 12:00:29PM +0000, Joao Martins wrote:
> On 12/01/2025 12:39, Qasim Ijaz wrote:
> > This patch resolves a UBSAN shift-out-of-bounds issue in 
> 
> Avoid the 'this patch' e.g. Resolve a UBSAN shift-out-of-bonds (...)
> 
> The Subject component part could also be a bit more specific e.g.
> 
> iommufd/iova_bitmap: Fix shift-out-of-bounds in iova_bitmap_offset_to_index()
> 
> > iova_bitmap_offset_to_index() where shifting the constant "1" (of type int) 
> > by bitmap->mapped.pgshift (an unsigned long value) could result in undefined behavior. 
> > 
> > The constant "1" defaults to a 32-bit "int", and when "pgshift" exceeds 31 (e.g., pgshift = 63)
> > the shift operation overflows, as the result cannot be represented in a 32-bit type.
> > 
> > To resolve this, the constant is updated to "1UL", promoting it to an unsigned long type 
> > to match the operand's type.
> > 
> > Reported-by: syzbot <syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com>
> > Closes: https://syzkaller.appspot.com/bug?extid=85992ace37d5b7b51635
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> 
> With those two nits:
> 
> 	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

It needs a fixes line too

Jason
