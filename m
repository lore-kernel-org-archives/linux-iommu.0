Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA4944F
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563484; cv=none; b=F+K9Gs71kf0BALPSkQGwgbrpr5fWbRoMaV6fE7Gph6h4LoO+q/ucnY0oqdn5MvWOtNoUwbFQndlgyGmhRid4cY3B6eOTE8lyEo/szSCSto7jeh/QEVLToynSUgB/Sui24o8NpBHaiAA9vCFucoJEt1TI+SJuv4oAUEDQNYgMc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563484; c=relaxed/simple;
	bh=3VGwOwFOdv4ZHiKqvtBCgZGw+M/cK4AH2km8xsUcbZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYsngU54hPhsSXeTAYiHSbMtUPl7jOpdbxcGShd8aXlHLGMDfGD49aoJQYTBSjM1is2w1IO7Ip3ye3gyYvVmD3BVhFVMiTTL9XpSBZo2BzgKeMoiZPcxX3zY2888oEWZbQtAt4osw/DsL+3lU2i8lrsDX/imJVy9lHhHsCqhldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R3qb229c; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R3qb229c"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-750c5378b96so2693755a34.0
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758563482; x=1759168282; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VGwOwFOdv4ZHiKqvtBCgZGw+M/cK4AH2km8xsUcbZE=;
        b=R3qb229cgz1I3X9MyC7r5cShQVyXt4oXI1Hsu3N+MtyTrk5kxIQDOIU3Zt1N19PxIB
         zCKYPsPWnPz20Y+TyVieyT3nQepmfDU+u3k8MUDJtv0sU6/oZLMfUv8GHzjVWbusfr0r
         NNbpMazT59MrmdwRNiGuTtQGQDn9GCTjF8hV0zxUrrgJlQxwEpcZCi7g2japTTVp7+Wa
         rdBcuaz6372O1HEip9emgn8uCz5GlZ23b1g94H4yKZ1vfMigUMtFzLSHd9hLOOfuNS1u
         spOAS+VQ/rcvLt/6WyHaZ2j1zKOTIlVIbVOjCmAMiWRTpWjPAIesvyvRmzRPumdfVfhA
         lfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563482; x=1759168282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VGwOwFOdv4ZHiKqvtBCgZGw+M/cK4AH2km8xsUcbZE=;
        b=fNxn5tLx9MUwUFuMKzO1gWamHIr1UDSIkthOMNvrc+8IWrwfDRRlv0w2mWn98Oo1P4
         vXLS550s+m52a4bnKrh3TFcI1t+HfkApi38ekkP+9K1xebM4lpCGI4bn1ciqwyW5q52B
         YjE2h7ZnHHr0WHgzqmmebuKpKZLOC55p1rpAHyzg9sZ/Ya/r4iu3kJc+62fjFnvRQXyB
         ljxTk68i/Przrsfu/Nz4pckrlhWc6DKaCFXx19vkUImM12qxQVmn1M8zbU84nYcraZN3
         6cpvHh4BdQUM+iR55oJhFPNmkQ0gwwYhB2uA82GjxYWBpg3zG+yqLeXtte7nPZQwwOjP
         Yt8A==
X-Forwarded-Encrypted: i=1; AJvYcCUjiyMkiE3stHO6rAYMyorLakj1rRTzNh6Na4maPWxOOS+iuZE/KI/0wfcGyP1mOwzTaaTVCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOcyLlfxuOX7/3/t1GcCgcPs/soAJ8H9ChGzb43eIi10Z8mLL0
	vtMmLKFaEF8PE8Ws9+V8pTVbFOkyw4A/nyeAqPQ6fhoGKXg/A13X1HAEJcICNT2vdxw=
X-Gm-Gg: ASbGncspneRjXkCTesgy6WIe/28Wxmjxp2mxk6NJOXTuhc2p7eaJS5GpId7FOtM/IbL
	dG99GoZDiTdUx6OT1hZd6H99CXycFyXMYhMgKcMuTF4BmkmooEANrzIOnAaugBgKQRjwd0QZbBL
	2nudy3FUY9dUnuMGKh4fBr13PKA6ABFSGq9rfybDORHWlwDZ6Wa8W01f8JscXYnjLOjYrxWTark
	GZc3sb7y6g9REzlwwFngLJSCJg4wzaCp9eGZiZ3svKcWTjJDsdrVWl0CccfqhuWN6ajHsUhRFQ0
	DWlRNV9bELzE3hbXBXOqXDvg2nyfF5skwrlJXxyjzoDMnvq67MrkPV8bO3UBbALyqP1lncJg
X-Google-Smtp-Source: AGHT+IHoHwbeHyipS7ya2jIOwlHRG1IiqAe3uqF6PSNYBEMqz7YnlEdpM+nslTojj0nGh1U+2X+yyQ==
X-Received: by 2002:a05:6830:82d4:b0:746:d682:c986 with SMTP id 46e09a7af769-76f7b5e0cd4mr7967212a34.17.1758563482035;
        Mon, 22 Sep 2025 10:51:22 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-77ee58e54c3sm2020597a34.2.2025.09.22.10.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:51:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v0kh6-0000000AlpO-2Gtc;
	Mon, 22 Sep 2025 14:51:20 -0300
Date: Mon, 22 Sep 2025 14:51:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Mastro <amastro@fb.com>
Cc: Mostafa Saleh <smostafa@google.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Keith Busch <kbusch@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, David Reiss <dreiss@meta.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	Li Zhe <lizhe.67@bytedance.com>, Mahmoud Adam <mngyadam@amazon.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [TECH TOPIC] vfio, iommufd: Enabling user space drivers to vend
 more granular access to client processes
Message-ID: <20250922175120.GA2547959@ziepe.ca>
References: <aNETcPELm72zlkwR@google.com>
 <20250922174630.3123741-1-amastro@fb.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922174630.3123741-1-amastro@fb.com>

On Mon, Sep 22, 2025 at 10:46:23AM -0700, Alex Mastro wrote:

> Following a dma_buf_ops.mmap, I suppose that revocation would mean:

I'd investigate adding some ioctl to the dmabuf fd to permanently
revoke it. The zapping/etc already has to be done just to get mmap in
the first place. The vending process would retain a FD on the dmabuf
and when it is time to revoke it then it can call the ioctl directly
on the fd to revoke.

Jason
