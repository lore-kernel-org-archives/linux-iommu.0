Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E541EC2
	for <iommu@lists.linux.dev>; Fri, 19 Jan 2024 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625559; cv=none; b=P657l4TzDTFBpwT88AMFI43xFpjpukysJwAoBHbS0z0PQZFMv7yxewXFtgoB1sR+oODWJzBbiou5nsnJs67lb4qDNpZRQYxOnDi2W3Z+3ZApaXP/WrzH/HYR/aSd+eRycRX91ZNHXuJ2MaPU6UDjMjD2k6eD8N5N9HmlewpwQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625559; c=relaxed/simple;
	bh=PkyL9kPj4Rmx4AQjC/j654aCNR8JQmTLIY+FPsN7SM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpNFsBOCFe6QlwUZ8LU7oAICnwl5yfk54yTJXbUgfz6FP4djbPONVhXrsFYZAxcI9mcZfDKWGZfju6ORcCuhLuNmwgoS8lKs3LJ79VSvB/jE0DcEYg2il65Ye+NSpPTLEqQINoeFi+GQlqz7KsRybSXEvQZ/RcTK9dsIEL13O1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=boK31MMV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="boK31MMV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e884ac5c8so2585745e9.2
        for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 16:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705625555; x=1706230355; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H61ilH2n5k1xI8w1q2NilzT5SPyyPAjMQ5rem1ZRbqI=;
        b=boK31MMV96MSob07YgaUCrjkUaJfPduVDWiR2q4gi/X306wq81kOCQ/I8fPCvLztw0
         TrgdGvWBl28y2T5ZG/3Q6BClxlurwSGkGk3WOKfqUQKM+AGSp5SQzpA+yJBmiQLhyS2A
         sZ+sqDndlNCc5aD2UjzCJ73Sb7L9tK2pOQNEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625555; x=1706230355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H61ilH2n5k1xI8w1q2NilzT5SPyyPAjMQ5rem1ZRbqI=;
        b=tlWm0H/UkB80+LYW49DbdbFQzexCzZqIcdWvld8HUX/J8fce0M0CgoMzPnq1eW7M3M
         GKgmMVe2Lq3hFzfkuZTBxkJ3SdEzwim8rFawM6SJ6tOdBCauuRh6x9FrZNJtu0WovpNO
         jE8RPVs3FVi8MqhYHbY7RfKax7LdIr82sL9DgUdKjSGJ6MFaf41ALJyzN5JepJbAu/2h
         BuhQiuZJbUMkLvMq0oLFR2gRnpCDKr4Fh0Tb9Ozq6nBdsm/aSA0qeLCfiMZODZf3vfjD
         oGcXIDokxc097zV7GEOXw9gBtf+4tqKRp/9dlNy/IvC1CiOwsz4Z7xA5tBDzS1WE11iJ
         bQCQ==
X-Gm-Message-State: AOJu0Yz1yqy8k+OZvimUxtHKkgu16AbFy8L+mgrZxsKZpeBw3UgQk2zu
	gCO3uiWzIIXbGAFBLzhFbpiZmKN8C0Soujg1sw4LVwRVHN/yCBbm9FdWUIJ1qGVFyvcrCz7s/UL
	QIyk=
X-Google-Smtp-Source: AGHT+IGGzojT4yjiCnJAIOrd86amLHx11iU+dBlE7isocYkbsV1zUPbAd9/c8erK4j87fK3MhLtbnw==
X-Received: by 2002:a05:600c:1d20:b0:40d:5a41:52e with SMTP id l32-20020a05600c1d2000b0040d5a41052emr459728wms.161.1705625555209;
        Thu, 18 Jan 2024 16:52:35 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id hy7-20020a1709068a6700b00a280944f775sm9681824ejc.153.2024.01.18.16.52.34
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:52:34 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e800461baso2566965e9.3
        for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 16:52:34 -0800 (PST)
X-Received: by 2002:a05:600c:2d8a:b0:40e:423c:954d with SMTP id
 i10-20020a05600c2d8a00b0040e423c954dmr456581wmg.276.1705625554320; Thu, 18
 Jan 2024 16:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZajTpGRSCJkhPEKk@infradead.org>
In-Reply-To: <ZajTpGRSCJkhPEKk@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jan 2024 16:52:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj18aK9-4yydL=T8WtwEKW2S78U5e=9YA+O4VCxYZopLw@mail.gmail.com>
Message-ID: <CAHk-=wj18aK9-4yydL=T8WtwEKW2S78U5e=9YA+O4VCxYZopLw@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.8
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 23:30, Christoph Hellwig <hch@infradead.org> wrote:
>
> are available in the Git repository at:
>
>   git.infradead.org:public_git/dma-mapping.git tags/dma-mapping-6.8-2024-01-18

Yeah, that doesn't work at all.  Please fix your scripts to use the
proper public facing side like

   git://git.infradead.org/users/hch/dma-mapping tags/dma-mapping-6.8-2024-01-18

instead of the ssh address you use to upload there.

I've pulled from the proper place, but please don't make me do that
for all your pulls.

In fact, this is the first time this happened, so you must have
changed some workflow for the worse..

             Linus
