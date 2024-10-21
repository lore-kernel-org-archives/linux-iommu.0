Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18430197A99
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492178; cv=none; b=E2du7JrPzJgdwSLHus9DslOVLmsM3OF7isMYwZeiz6M5tRkiaCqTgropLROP+l8ieithihxYxWeyHLoSb82Z9/6LyCXV/j8n4EsNbChJ/FeUaGwObKmaOgH+CFmM+1Gk1SQV1GL2TnTJk0xkBEeaWqXTUEq9W/z6NXr8nQtelRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492178; c=relaxed/simple;
	bh=uSDXD9qc3rcIQG1OKc9jvvZnyYfPrweqJqB1/Ptudw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHVEJ/sEi7a4WYSI63KlRYIPiseh2d69OBvOpCZLNnF7wPlJBBX6Io35bYdRKi+JJJd+uGFs80CKVDfeDNYo52mMoGDikCcUGQ8lWGtb1JmoqtZM2iwZbBunc7+BHiLoSNkQk3bUSO0XWLHXc5hMh0c4F+cKDO6v+81oGEyBeus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJB12hye; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJB12hye"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so861455ab.0
        for <iommu@lists.linux.dev>; Sun, 20 Oct 2024 23:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729492176; x=1730096976; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8va/CzwSDenfm0+tO2z3jyOqJT+6h4/TE3bcS+sJtw=;
        b=WJB12hyei8xD0O+mDF0WxQZQsJrJ14BSEbIzFMBnVDoIRQ1kpUrpKqjKYhexwLDT0G
         AOrECoFa9muYe+eG17ZGvdYxXlWLt4ijLyXWhcCUqD5O2/HxfuI8ay2MOIpYITfNZBWC
         Bl9XXJSKzUhmXNzab6eRaPbg32vOvTv83yxxJl2toToAv2WRH0X1Wcs1GdUX4K4OdAgq
         DuDwdymlEFX7VX/6tdp+jUzpDPrO7oQVYp47gb6FG5uCCmMAa8scvoxW0L7ejJ0m1UFu
         DkAsHHTPLsEcLFRfL+/Hhin08YxItcpnYt+94SMS+vOT/oWTuJLWTz3TFl7DYw2t3DyF
         ZGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729492176; x=1730096976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8va/CzwSDenfm0+tO2z3jyOqJT+6h4/TE3bcS+sJtw=;
        b=StEtmCvBtbyoYvvPauBfRqLdfie+qFwC/mn+TYrooHgWvWh6OdFNCx2a+WmcHnfnvB
         15YB36oIEgPoIkH/JihpySI+I1HUiXWgRai99+shrNb1HHo1jEQFimp64Av6nMC+MT7M
         lqVoBIAlrZ5vqhCiyJeHIjPPfjedvs+NJeIKvPvCJCZQjPY+jXi2cbSa5w/PB7Qjrswt
         AZ21OHu7amy/l60jexDaW+XjSNuBN8nz5GYfQZTxKEiu6GazaPAr+2UUkEmHEAWBvzZm
         3v/MpWT+PLnaYvazDvjOfY/j6wqnaATjEyQt0oKXyBJ+F7aNPwTsZdW6QusQkyGx4yZa
         a9ig==
X-Forwarded-Encrypted: i=1; AJvYcCWo/1l2EG/B128n/zH8avpPkkFCSVXPXGX8mr0Xa0FzxvZ2iVR0W/qYnN+HHjlM59QtPqLxrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAuFut9QTURPEi6yxWd/Kh4SKgTwVzXB+sRP3/hsmiAK7gtZhW
	yu0X5asOPoYGCzls8XQU5j61WfKIsGzQ9Tl7uJwI0UYfFPaQzdVor24n4M4+9Q==
X-Google-Smtp-Source: AGHT+IFCOmaHfxFcTJtpEv2UihW9ufPetYGpS3V+Uo+caimA7DZdIAnnqHxAPxde3TVVUTtmBf55rQ==
X-Received: by 2002:a05:6e02:1a06:b0:3a3:632e:efed with SMTP id e9e14a558f8ab-3a3f9524aefmr6999405ab.26.1729492175903;
        Sun, 20 Oct 2024 23:29:35 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab638c5sm2247460a12.55.2024.10.20.23.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 23:29:35 -0700 (PDT)
Date: Mon, 21 Oct 2024 06:29:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <ZxX0yLF6A492vMGO@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <ZxMUOfH7GoY71FxD@Asurada-Nvidia>
 <ZxM63MvPZLwboTk5@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxM63MvPZLwboTk5@Asurada-Nvidia>

On Fri, Oct 18, 2024 at 09:51:40PM -0700, Nicolin Chen wrote:
> On Fri, Oct 18, 2024 at 07:06:49PM -0700, Nicolin Chen wrote:
> > > +                       put_device(evt.dev);
> > 
> > then, here it puts unconditionally.
> > 
> > Maybe we do need a memset(0) to the event, then here
> >                         if (evet.dev)
> >                                 put_device(evt.dev);
> 
> Oh, put_device does that already. So we are fine here. Pls ignore.

Yes. Ack.

> 
> With the other two nits, it looks good to me,
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Nicolin

Thanks
Pranjal
