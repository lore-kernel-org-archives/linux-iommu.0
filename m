Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411D31E8A5
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297476; cv=none; b=UHh0YvZiIJGdRizCeW+PmElebFOfhrcN0N0vfHLFG4OlK9Q3EEyzX/DcaiElWT46IU0FNOHbJFLU2U9OSCq2ATCVa1t5cP/+tWZW06OW1aFK4Qf/DkSZCwnXWbbln4q8ZZXEspQ4gQs2TjDN9dBdEgvXcy4NRokU6qt6r0nvdAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297476; c=relaxed/simple;
	bh=jcgRaanW9qH9mr+Sv4w77DNE6nNUSLNEVq5bL0EhAq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyMqGzpvRAeJUt7PXp8UFkTWPXGSNeg6kWi+e/lWbjQ0PsEUGPFABEjMIW85h3XSQI2j6Rho8vyPGoP/jKGnTMnC+A4FAqKG9TR6yuZdj3mJt2WKVGmqvP7U2tTlhi3G6iz43tp3Gf9Ec4j8qOahsMpDVXqeeJenvYGvdqY1BBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgKKOEQz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgKKOEQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758297474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aM1my6NJjtlki0BZEqbhHHnBmfD25BQlwJZ8Tn+vp3c=;
	b=JgKKOEQzQl3aJ2ABNBsAjeHRafg57wqIm3Yg0Ja6YLdPre+TrS/n4gOnMIrx6qG+Ff/orj
	pE7ubsIcvSjdefUNCa1x0myc6Kl1Lz4yELLoqzkxboNijogi+kUNz9iCV9ObI1mdoHyhva
	l+TJgOuJ7XNJcD03X7JQgVm4h0foHPo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-47Swo6e9OJmB6uvU0TaOHw-1; Fri, 19 Sep 2025 11:57:48 -0400
X-MC-Unique: 47Swo6e9OJmB6uvU0TaOHw-1
X-Mimecast-MFC-AGG-ID: 47Swo6e9OJmB6uvU0TaOHw_1758297467
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-40b911746f0so5288205ab.0
        for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 08:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297467; x=1758902267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aM1my6NJjtlki0BZEqbhHHnBmfD25BQlwJZ8Tn+vp3c=;
        b=TXNjE67zrmbIDy8KfTBVzLh9Znm6tiho83L0k90rXqAPIiAsDimoS42gvpOuLAswh8
         xlJ++Yu9I7xcyjWPhsVNr6oI0XtKIhZHmzZL+aDAIUTMP6QyxIppWJWhVghDXejSiOaf
         zdxCoT2X6uwMGp0wUm7yUw8+mo4IMuj+VK+Pp2fKu+JymhNKgbWULyS7Vdvv3YQi22mm
         4frAe08eAvW47nI1qxJfOj4FGQwOr1vUUx603tMqcQtlrGJDZVNvMyXWtZHPmvd8g1/L
         bM2s34WylxCQvwI41rRKcclS5BSCyasRNlfbizbWi5ydzbpo65QZkCiyQ+4QOYodLsFN
         En1g==
X-Forwarded-Encrypted: i=1; AJvYcCWYwhN/zxvDNJv239/vACwBlaJijJoBYb6zD+/lMPLQ2kPKeMflGtOdRkbzHHvrKok4zK4GkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzucv+cL5gy52x76sU6m1Q3B1HkYqjAuEDiKP5t/AhHM7QH1/yX
	F3XDjJMCzGPP8dAzKKvd6vowKphLq6lTjvXFIV/V9YTyFnKF9I7m7H00qcV2goga44C2LflOPuq
	yiCko1n0sV6dtC9VqBS4UuH1KVkfzWjKKdN+81LP0bM1babHUnC/gzAr6
X-Gm-Gg: ASbGncvf8npZ9zK577UO3hfsV18Cy5bFC5mlk1zuFEtW9Em+NK+Wp8bKnxMgYOKkj7I
	zeMqwcbKwb/p3/htq/AHKyYM23sIuvGVpzwoO6dqdcOG3FikKToD6w0BYjQXMcVSr6YbYlcTT/S
	79Otbb3Ao6bR3ErIXegByBUvUyoOw7ZBD/bs/CBelKPWnSv1XmyrdA2Eqy1b7LhbRyVurtH1AmJ
	cBXPiCYti4vwzOTlpRZZgEYz57BT/Oz+ZDSGVDtPB/neAUYAe8B9QnodPmKclr4+bToy0vzD1Qu
	8pvuIprQuxVOIjNuUhvQOORwCZJZ3FlRZt8FZNEeZlk=
X-Received: by 2002:a05:6e02:1845:b0:423:fea2:584a with SMTP id e9e14a558f8ab-42481979b04mr21894725ab.3.1758297467350;
        Fri, 19 Sep 2025 08:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3kKvBSX9JHZGnWAdCW/3QH1TzYJQzZYSAISEqZ847cNL+IsLLiA4SVKmwkv0UjgNX2yNcRA==
X-Received: by 2002:a05:6e02:1845:b0:423:fea2:584a with SMTP id e9e14a558f8ab-42481979b04mr21894495ab.3.1758297466785;
        Fri, 19 Sep 2025 08:57:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244a36b076sm23232495ab.1.2025.09.19.08.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:57:45 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:57:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Mastro <amastro@fb.com>, Kevin Tian <kevin.tian@intel.com>, Bjorn
 Helgaas <bhelgaas@google.com>, David Reiss <dreiss@meta.com>, Joerg Roedel
 <joro@8bytes.org>, Keith Busch <kbusch@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Li Zhe <lizhe.67@bytedance.com>, Mahmoud Adam
 <mngyadam@amazon.de>, Philipp Stanner <pstanner@redhat.com>, Robin Murphy
 <robin.murphy@arm.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, Will
 Deacon <will@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [TECH TOPIC] vfio, iommufd: Enabling user space drivers to vend
 more granular access to client processes
Message-ID: <20250919095743.482a00cd.alex.williamson@redhat.com>
In-Reply-To: <20250918225739.GS1326709@ziepe.ca>
References: <20250918214425.2677057-1-amastro@fb.com>
	<20250918225739.GS1326709@ziepe.ca>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q3VPvt406ED4_UYVJ-Qs5Xplwl0Fd8rGfBRyMJPwtcE_1758297467
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 19:57:39 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> What I've been thinking is if the vending process could "dup" the FD
> and permanently attach a BPF program to the new FD that sits right
> after ioctl. The BPF program would inspect each ioctl when it is
> issued and enforce whatever policy the vending process wants.

Promising idea.

> What would give me alot of pause is your proposal where we effectively
> have the kernel enforce some arbitary policy, and I know from
> experience there will be endless asks for more and more policy
> options.

Definitely.  Also, is this at all considering the work that's gone into
vfio-user?  The long running USD sounds a lot like a vfio-user server,
where if we're using vfio-user's socket interface we'd have a lot of
opportunity to implement policy there and dma-bufs might be a means to
expose direct, restricted access.  Thanks,

Alex

