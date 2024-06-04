Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4214AD20
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528153; cv=none; b=jkh+nU1ZbevTpuUAj0nnx3a29LhFlnfN3ZojOB9bi02hCYYFPlhBqMKMoZvthj+eHCVjT5Kol8b1+dmxyb/ls43MCnB7WZZBi+7lhY/K1H/MDt9zAeKr4cHfTxodc/q5t0YpCO8HXeSod6+YzSQiqZX1BY79uFXZp+bOY59x24k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528153; c=relaxed/simple;
	bh=XwKCIkqkYBEgl5ZLKvPLvvtSlpG35zCzFjQXlbOyGj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbt3kMyPUQCBfWEPlEi01WIXKLagShCnUQpaqmpsrrOJK7i73FJ45ng3DyipdYX6/gabSGTjFqzN/6OvXQIrR1ZqQwwV64WnTD30hRCwG/crln1BeU4+eG6dHm4dNo1uR/6r+UxkAyf64avC10hN5fZzwT5ODP9bN+8cJbNRtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qG28s1ea; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qG28s1ea"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so6596027a12.1
        for <iommu@lists.linux.dev>; Tue, 04 Jun 2024 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717528150; x=1718132950; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgB4DbGE6T1ikwhYmw4fa2hcF17RtM7yOsq39hT9I98=;
        b=qG28s1eaUgnNtQXe7PLXmukoayMnSTJWDDm6nHGH1rs2iknZWgV0al8HhXIYI/GsUv
         Nx+NplmfSa9lJRJAFyYSkVGsk1jnevH8ZYM6UDotB11WEY9cbEGxmpU/cQt7V5jklHJz
         S5H5Enyhr66nc8RjiOsnXKoG0PFMQfZCepfYt2g09xG24SFVnry7PCF4BY2O5r89nznP
         nAZAfsYDBLDaVXb/rIed+uFMRZV6pXSbTGNjC5xkYqOn0KsPBIW9xbhW9T8Vkrf+XNdP
         TjqKoClDPhjLNKTLQ2c2KYVZOSz4bGdmzw+OI9czCHXh/g9dNkiBYC3ri0sEqylsCPAW
         4FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717528150; x=1718132950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgB4DbGE6T1ikwhYmw4fa2hcF17RtM7yOsq39hT9I98=;
        b=EzCoWvpVwUkEUhjQp6gfmCm9ufAHcTOwYrQKhgUZHH3DF+LxmzTxuTeLAqzTiHVfK3
         zVcdx7RDLzbJCluCyx4ASVbaU0fAHHCcFoG7Y4TOQB71qeonBHgrvAEO/piFnaB5c1Hh
         48sSRcEfX8x6Dj2fqiR/kScrJNakHhWi/qUa2gbLXqRff0TNwTHym+mLUWXrzPpRGfET
         ql/1fqXdK0EUrr8IwfCX4n68u303IniFsmNqJcirF1t1oXBy/MTK+qPvK8tvvsuib9uN
         +7fKHu/VpZScuHMzZiWqiFwxWrQR1d3XsWgmT63ovTRItkH7sIQH5Pi/a1LBE8Jd4MC+
         UyrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfeLHTAQTbUFp3/XIgE37nNcAdjxK3iYnh6Tv/YLVwRUJpJAuO53eWxBu/j+1rla9qZWEO0K5SfhLlJv8D627Ja3ksHR4=
X-Gm-Message-State: AOJu0YyGYVM4+H42RCT34zKA7dAMAILFcuDqvkQNtWyI+lzQqeHakyMg
	sdjjISYJ8TksJd/RN9MeLsGrOlCcGYx72BJOHfANuPuJYGhAY18xkgTkpQl1bCM=
X-Google-Smtp-Source: AGHT+IHQGLFEtmqT9U+tp95hpWm2B8YC/v5PjnMpJnjq63cgYXkxFs635u1b0+F9sBKngRqYp/Xe5A==
X-Received: by 2002:a17:906:2a82:b0:a68:fafb:a16e with SMTP id a640c23a62f3a-a699f34ae75mr29653766b.4.1717528149569;
        Tue, 04 Jun 2024 12:09:09 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f8840bd9sm389463566b.20.2024.06.04.12.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 12:09:09 -0700 (PDT)
Date: Tue, 4 Jun 2024 22:09:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, jgg@nvidia.com,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Avoid uninitialized asid in case of
 error
Message-ID: <30b1fd0f-d43d-497d-b372-5218f7b4153b@moroto.mountain>
References: <20240604185218.2602058-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604185218.2602058-1-smostafa@google.com>

On Tue, Jun 04, 2024 at 06:52:18PM +0000, Mostafa Saleh wrote:
> A simple fix would be just to initialize the local variable to zero,
> this path will only be reached on the first attach to a domain where
> the CD is already initialized to zero.
> This avoids having to bloat the function with an error path.

Yep.  Since everyone automatically zeroes stack variables these days,
this patch doesn't have any impact on runtime at all.  It's free.  It
just silences warning.

regards,
dan carpenter

