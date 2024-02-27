Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B241249EB
	for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058229; cv=none; b=kAA2YWl5cvrPjntH2XSsVs/2k7Gciz111FabdSu8ZgldXBcspRcBzBBhs6S+dkXXwl1HGt37oZytJW1vKEftGuISuLmIu0LBx00HMIZNuHovx1CLSXstmxRpY33DTIVysdGLE6iai/OTbqVA3PYwJWeZMMdOkothX2w8SnrKjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058229; c=relaxed/simple;
	bh=wXeL6xRn84YW+yVox2D0U7SPKqNkdMbmGVqHUOm4hqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjXNIub1ojYGycLzAbJQbbmnKjMINAW6x1pGY2Al/ZZajGBZAqLYbywFHKAKYLyXVNtyMx6giexUZCQ1FFetxX4hElFMH2mLAT63Q3sahS96CYOzsh7nQhPqvEirHDmO/chwbk4Mz/ZzhqK3WhV07R+ARm65iEnNUi8A+UresL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwubNOPe; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwubNOPe"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso5185781a12.2
        for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058226; x=1709663026; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXeL6xRn84YW+yVox2D0U7SPKqNkdMbmGVqHUOm4hqY=;
        b=XwubNOPelT5joSKNI+HypTjqeqBEmWL2zqFILoANqN2ZON9DoJxX7LS/MiL4vhMFWs
         0CbfSjl3wm4Pz0rLCkeihmSo7TKM8TDyzwNXrZyX8QFLonUKbzFEKTMYjWo24CsT1nc3
         WBu/34SDGhrZp43L45341w4yVLlYckS1S3nmghj09SybkVZ6ka0SB2HzMNZ/ZZ6pv2Bq
         pCXlXDYxPL2J20eIlx32ouzIbi0JUZ0huD+Ojlb3Kx0R8HVjWQAA0Zktge1XO8DAqiFh
         O7lKtSgghu/GEGfcNDVlw+1ZdM1GJFQ+bzgELpaGkeA18ag+oiQ9DLNliiSGvGZHS0nB
         3NoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058226; x=1709663026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXeL6xRn84YW+yVox2D0U7SPKqNkdMbmGVqHUOm4hqY=;
        b=LMzS4ypY1CV0kzfQiVX2Fo8wPlLd6l2/9ZNUlTSItfrP8BhGKv80mTHvH6K7XlhGaj
         19iXNeYFXGCRHdMTyo0Vj7CW+cDLXOEh5sm02hIx/k6GSJlNmrDFwRilhJDHyoGIww/Z
         bcLKZNN1boNi/ajweKmZuQop3PveqRP/gCKBKjVUN7vech/zNOFPpRuwcRr+sbVzdAfR
         oiRkZKpUzDSy5i2dZSFx4bv4MCny2M0EcVFS+pHZIg3EdCUNAKDynEU2Ajx14JYWMhsc
         QarzVUiM+ElURpH8iKNzjSQUFILI92cZP1h/iTK5Mn6WUUWjZLNnvReUaFtXOSQoOC1S
         9DJA==
X-Forwarded-Encrypted: i=1; AJvYcCWs5nkcTWG9FBxhpzcb0GcS370Q0OrP3PednXzVZkriP1I1y2CXOZAGOQm+RcPCeDUp+hDCi/JN/DdVDaCYtEFcZbOi3Xo=
X-Gm-Message-State: AOJu0YzKBlE2KLAkmxYFKc7TXkUaduf6lTsKTR4sr4QDxtzEmGgcIxtE
	Bsp5Q7ARgD2yPGKuBTqxeC+ov2YnjXQCDHlA/VGtqydC0spdgZ2SctMNKBOsCYWpL+77yJfy4//
	rUGhuzbB7ocZ0+OI6JUUcxZbg0C0=
X-Google-Smtp-Source: AGHT+IGrAmqMg8fWhmS7yIJja0CR7J8G/1TxTj98sEPqZYocLYGLvz+cuN3UIYHjYR7ZvhzVbIV4LoTflOXek003zkA=
X-Received: by 2002:a17:906:1e93:b0:a3f:6942:a213 with SMTP id
 e19-20020a1709061e9300b00a3f6942a213mr7010301ejj.32.1709058226431; Tue, 27
 Feb 2024 10:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240207143825.986-1-lukas.bulwahn@gmail.com> <20240227154424.GB15319@lst.de>
In-Reply-To: <20240227154424.GB15319@lst.de>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Tue, 27 Feb 2024 19:23:36 +0100
Message-ID: <CAKXUXMxctfDVt=+UHNrFfQFMhRitiQVQ1DBu-X0gtuM-WZYJgA@mail.gmail.com>
Subject: Re: [PATCH] dma-contiguous: remove debug code to removed CONFIG_CMA_DEBUG
To: Christoph Hellwig <hch@lst.de>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:44=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Thanks,
>
> added to the dma-mapping for-next branch.
>

Christoph, please drop this patch in your for-next branch if possible.

Andrew has picked this patch already and squashed it together with the
commit "mm/cma: drop CONFIG_CMA_DEBUG" in the mm tree. So, you do not
need to add it anymore.

Lukas
