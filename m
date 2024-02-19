Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E11F941
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708321501; cv=none; b=rwUgvkqIy4tiAmk6Q/5EX4I61MhBKECJWI8ULXRB382LjP5FJCn3D/xGMbkePJmq2gHotlqePo531XSVodAORlJvviTH5Xj4tCjHEVa+FAeLv7gGA1mjJM4AnyDvRYjFY8WSkWFctxTIgzKzhUyK9V3RSGsfQDj+Ui/SF+HqAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708321501; c=relaxed/simple;
	bh=OJ/7gh6BxJ5xH1hakE6NVsUnvxSnxDqUZPLl7n5aWsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/+aLjaAbKhlzeDu2VqaCtKI3Aal0np37jAzaAv/c5Hg7bgNTqcv3lr4DD3sT72LbTd2rtNSFW4qE9E//LislG8kByGMUQERAjv8Wyr3bpkvKlY0jM0zGHQORh6kxB/fDEtx0pjX9igx3QZb0QnmE78QWlz7sCgWnb8D9KErdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eo+q+Gll; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eo+q+Gll"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso63835e9.1
        for <iommu@lists.linux.dev>; Sun, 18 Feb 2024 21:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708321498; x=1708926298; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ/7gh6BxJ5xH1hakE6NVsUnvxSnxDqUZPLl7n5aWsM=;
        b=Eo+q+GllZJF3dmxBphBybNjHEFv3g76bP4NL41fL3KZIph0mRCFr2eGrBUtZdsvgAC
         v9Y87sRHSuEdT0u22IYg4olcJljlSSdmRU9Cqe8wHdsH8eRNJfS7VOFA54Tg1TferMYs
         eahf6oQ156VJ/y919bMk664Ghtq9apzYtKEycPN133Q0MumFoULXyHnlc+cOI8JksrSo
         I0wPqAF30BftzmnwTYaPaKW3SlMW5zdOnxLpDKqmdEsl+lrn67B/6nx9tESig2tHhkxs
         D40wmHSYMKYRkfbcQx3XvEUl//nLnevHd/DSwQDAgJMun+SNmxIjnLjHgDsgoaUaBzre
         c9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708321498; x=1708926298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ/7gh6BxJ5xH1hakE6NVsUnvxSnxDqUZPLl7n5aWsM=;
        b=JCv1rmt2Jf3EDlfl07/+PtCD3tAL0Ml+6G9gq0nSZcZ+6V50vFW2ACDu0VJEYBMyqy
         FgFnrCryZFh/eTJDBDw2UrbmS6CstrScKECjb11Alc3FXtwFopH9XEOPGWN27ndy89Fm
         FZX5C7C3N8RsQ4mGqlUx6RaEnDvb+hw+vQUM6MApMUw481s7mlvxWaF803UL9D1ZU845
         dgg39MgIDih2leG/FxEPHMIXvc2r9ldTWD6QkBGUIQUdmQn3ZJi83XKTmv+slC6z0/2s
         gqkPVUa3nfmzeEh5qUqTJHHYb/cxX7ark9gEwDf8mD3840mLTK662sddil2+SkDcnrEU
         coOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV760lmTRYkHi6/jTqeVf4+nfJyLFxNhHv06sJ7tUPoPZZ/CVxphGPLCAGuiu/pxCGiSLEHezhIhndHTnaMfI+Yck2OVy8=
X-Gm-Message-State: AOJu0YyKZRo+vFI+9Wo/4W5KczW5IE0hT2BpTS3atP1/bagjKrozsxHQ
	L8UZlrO0gSWoxwcKK3mtSGP0lF5Uyl+atU9dPM4ALUsa2Zq+zrwoTMwSRq3b9GPxbfYuzZ/TY4A
	7sdR3XT14wrq1VEmHD80GlnX5bOrKm7YXWWAz
X-Google-Smtp-Source: AGHT+IGWLQQ2GC773uxMPABnGURWWInWGHbiOz1QQvI4PiJ37j/Kp9b1Mh8sarYZOkO+ogysMCcTy/S0eb5rjQNn56k=
X-Received: by 2002:a05:600c:6029:b0:412:60b0:25c8 with SMTP id
 az41-20020a05600c602900b0041260b025c8mr157816wmb.0.1708321498239; Sun, 18 Feb
 2024 21:44:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240218050224.33426-1-niliqiang.io@gmail.com>
In-Reply-To: <20240218050224.33426-1-niliqiang.io@gmail.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sun, 18 Feb 2024 21:44:47 -0800
Message-ID: <CAE2F3rA1Lb_ayrLQTw+urtNSMoBg9q6CmcSsP7_dZwbfiYygsw@mail.gmail.com>
Subject: Re: [PATCH] drivers/iommu: Ensure that the queue base address is
 successfully written during SMMU initialization.
To: "ni.liqiang" <niliqiang.io@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, "jin . qi" <jin.qi@zte.com.cn>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 9:02=E2=80=AFPM ni.liqiang <niliqiang.io@gmail.com>=
 wrote:
> If there are no memory barriers, how can we ensure this order?

 The SMMU registers are accessed using Device-nGnRE attributes. It is
my understanding that, for Device-nGnRE, the Arm architecture requires
that writes to the same peripheral arrive at the endpoint in program
order.
