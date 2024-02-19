Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7DE572
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341152; cv=none; b=DTB1hhEtmkDeM1bV0AAtRlw/2tsblCczdX//nt2EXnd1/gqCo/774Xq0lQPgnedo22V72jxoRuIAc6sh2SPAxIBGIHtnrLIFu4WOdKDthrKoxJhkVqpCE5YJbd8/mKu9LMWIP7/Hyhz8R4RDbgb7qrV+puv6+9b0vW98d4vzlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341152; c=relaxed/simple;
	bh=wtUXsOPdRcR9ceMZSYyVlPOgSE3YKBQ5v6cj1iovINY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBFK33bFvO/3BEWeZtQVkmr2KKvXHCsbeu58kX1EGmL1K82A5Ji4F6U5ZKOg9BNY0WdHrcJYelcvNJ2gCfIdIpdqAS9qF5KpPpJDym22+gjiVbgNtzsq4sMRZ96ag1kQkA2bT/mOqnJQdhIE7Y12D9QF287OwywnvY+arV1Nbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iIa+hv3I; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIa+hv3I"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6083befe2a7so7066857b3.0
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 03:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708341150; x=1708945950; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtUXsOPdRcR9ceMZSYyVlPOgSE3YKBQ5v6cj1iovINY=;
        b=iIa+hv3IKLtpHOrrWXVP/YOGl1KrEh85wNZD7vw1SP6zsg2sudb73wJtbnlSUAUCiK
         L5PvUar0HyT+dAO9ykCibO65C3jhfGwDdQIbAPxQ7zlRLU2FDJ7mgwXznWSHCMTm1ckU
         4rTLwTCu0VEIKBlhjqRJi2oyRM5HF6MJD8oSVLdEaxNnCSVA4MF28bslC71Ry+XOI5vu
         M50xzhnqUZ2LQ1cmyxWLxMHL1QQf4EnDsYxj0jTeZGGyvOJhrKGaFBL8chEEdUyS98bu
         9/fbPPA+m1OdpNk/ncdcwQHI8bW5vo4qBW6/dlicZxjxDYYkp2/+J8Im86c/QIbq5yui
         wn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708341150; x=1708945950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtUXsOPdRcR9ceMZSYyVlPOgSE3YKBQ5v6cj1iovINY=;
        b=Yz85zDEKuji1jLlOBguIaIwVVahNCNo7cwwH0fgku7UmcIq9SPEMVMjdwHbrmvRpJ6
         iI1/EegYrp8zq0rmIhaLu1MN36y97BFplfmb8hOaE1UqykS0daKv14js6IBt9VZMKMAf
         uWL/ueyyCUBKnh7k4cCNIM1fzbVSK0yql7Bi4RDRETOPPAMkX1ZEUCdy+gpifj1Jbb0T
         V9ZP0+MRVPp6/0ZeHF9PiyejmXOBVpwLznQF1d9yyCClielJX5CDAPEegDPDMs0etDLt
         TGfIuz8foVo7F+KvIZe2/cvZXHmsAJ/8IVvihSrFlr8nMRRpr5k7HDhishW9ZmplUgwI
         tZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnb/x80Q53M+9IlAcM+YkSQSn4TjkI815HN8CMIMJMwGJ2DPB3z+0EblQG3p6G+o57zbEcTBW0QvY5wvhDSvcLJQVmNJc=
X-Gm-Message-State: AOJu0YzxML6Rd/mHMywPW3nFgreEhRMAFtt2UEcPxzOtrg69s6N8R8mB
	/w/CV0GOZq8QoFL6LeiUkncssJzw2sY85kv6a7Dqcmz2m1fUWIJshJnxQx6MWr1bFmhfK3VkUH9
	03zQGqvp0qgfLJ9NdzceomVyzTKbC9Lxd6RdE
X-Google-Smtp-Source: AGHT+IFULDqCDrcjS4TprptID6BJoQo2zNTcSGt/cTpMvyAWR54MLnD28lbpdsUa7q87zM7LGe1fXbZHWfZP+xtxH2U=
X-Received: by 2002:a0d:cb0e:0:b0:607:ce8d:8839 with SMTP id
 n14-20020a0dcb0e000000b00607ce8d8839mr11569382ywd.25.1708341149610; Mon, 19
 Feb 2024 03:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com> <20240213055426.GA22451@lst.de>
In-Reply-To: <20240213055426.GA22451@lst.de>
From: Howard Yen <howardyen@google.com>
Date: Mon, 19 Feb 2024 19:12:18 +0800
Message-ID: <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:54=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Feb 08, 2024 at 03:28:05PM +0000, Howard Yen wrote:
> > Add support for multiple coherent rmems per device.
>
> Why?

I tried to upload the patch to support multiple coherent rmems per device
because in some system, the primary memory space for the device might
be limited, so that add multiple coherent rmems support per device to satis=
fy
the scenario.

--=20
Regards,

Howard
