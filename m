Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0823D7FF
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648649; cv=none; b=ee6ag7Yp96KV+lXHSUZNEmwTZjyKCJTa/qoeUIphOv8X+9aOsLRN1XwNM3bXPPY2eUTvNO7tKWB9KMntuADsMQTleOBvApV//Enxd8PyKllf2SbbMTf3z1O+yxJAWsyrVl9I/EAjABuwHG+T2UujZ0uKxLqAZTMW4uQ3+3Fl2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648649; c=relaxed/simple;
	bh=5WraoSFUp6ajvbI3o5JH4FWFS36gY332T+fZ2BSIiD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYUbDTnSdy/H43M+evf2i0UmR8oeQN1Hz/OFulspdvBstO9Uui31t7smwxsBR9skvrcW6X4gEsPS3xCMaUR1HRnJ4/XdlGiIxSICSiEv+roGBjhDddn6BXFKfw3YCAFtBEt51SA1ljTgnUyvywOq1HoIROVx/NsazynI3Plu/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMSAE/uk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMSAE/uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758648646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFNQwbdODcls1yBrLTyCkOTsxOyxsNLxzpt49nq+oT4=;
	b=IMSAE/ukwgqc7iPO/pa0aMx7byi9JIwj35xAZv2Vthnk9tXxsT6NeacpIv3L9o3ONmLXaW
	sEkMN/ABvJURerQV68uJE6i3lFtF6fu+rsJR3bcFxTAt6tlZxMYJ/al/aGo5IQq6oEYAoN
	5nCPDnyMlXvCEtSr9TV0YSsqUJX89V0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-GO5kt5ZvMIyNM4n-6iqFBQ-1; Tue, 23 Sep 2025 13:30:45 -0400
X-MC-Unique: GO5kt5ZvMIyNM4n-6iqFBQ-1
X-Mimecast-MFC-AGG-ID: GO5kt5ZvMIyNM4n-6iqFBQ_1758648645
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4258981d664so516325ab.3
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 10:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758648645; x=1759253445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFNQwbdODcls1yBrLTyCkOTsxOyxsNLxzpt49nq+oT4=;
        b=LRnKvKKxWc7/eLBeK4kxAo+2oFjoLN+l5ZwMQqQWBMTecVXpDmjRiTj3UClYPSAqBO
         eCwF8IocrLruzlKSpfqaVQLcRTBfzFWsV8KAKgZ6sJOkGsQkRjTFO/7uJaKhKlch0wkg
         4CQUc/vLjyMeGGZK+7IRnIIEB/bZNu+/1vcW0Bde+ya6Y2AbWr+Jm8NWtxElcvnNSfH4
         0VAcMqOSCUNzYjI354UiiGLA7Eo+5mllPcf1Gb6T9wfbZcs1Lj2YNIBPsDzH+upWP/br
         Vi51wuKCgM7zQlAyV1HkoQ2gFMFPgNQYLkBFyyc4H6xr6rarkWPM8aLAvh+hVL7X426/
         NY6g==
X-Forwarded-Encrypted: i=1; AJvYcCW6z1VwgWC6LQOtuqyf7iEprlkYiCFwu75emKUow3ocjcCxKFLfPBMX0+xENSB7Qe/7TkfPjA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/Afvol8yLUjWfFu3Re7lD28cs3CCc1VrchZQc45Ca004p8k3s
	Kpn0DDzLeOY5emBLQ/aalUewLvTC7nwS32kpxfdG+Y7QJw44uf0/1JBjBDYjiTpzhced2yP5tX3
	iQQrb9ajErtmEcFpgyQQAKyHM76FJ7gxmzyGjRvY3yDkNlLBr+r6R5WFp
X-Gm-Gg: ASbGncsyCXqXUM3EO77LkNLuFPO1xGVxwqaGQkyyXfk28w8trtY0m23pUl1Iwa0jnEz
	PCb6f3P+nvwq/9+wGS+9VZbX8eTT8hwxeqP5kryDg4XnoTuH2RAftqBYwZPCuvJjmZqTmTEDS7k
	VGQIg3GiF2+JPYfQgZR0qI1YdltWt+xjChxoLGJLgGrNLTQEFHZ9iXz+RFNq+4ngFVlmaYGLAHQ
	caJQLmOVQWUfE63CeAYMlmw8eVF60iwHBqO+A6suG1Ipxfn2hF4HdI6TP0SemnyMStDLOUKV/6C
	JNhI2YGzTxulxyZiPdCzNv4KrnyAqfp1dbNiuZ5FVqE=
X-Received: by 2002:a05:6e02:164d:b0:400:7d06:dd6d with SMTP id e9e14a558f8ab-42581e09c50mr18780895ab.1.1758648644605;
        Tue, 23 Sep 2025 10:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNobmhXZYu8wcE6bAQtE0C6wCF0m0+GFNpZFLyv2Bpb6JP547FE77pkIiIGw0EG9S0P84Gyw==
X-Received: by 2002:a05:6e02:164d:b0:400:7d06:dd6d with SMTP id e9e14a558f8ab-42581e09c50mr18780695ab.1.1758648644175;
        Tue, 23 Sep 2025 10:30:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-566127693e0sm275326173.30.2025.09.23.10.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:30:43 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:30:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/P2PDMA: Refactor to separate core P2P
 functionality from memory allocation
Message-ID: <20250923113041.38bee711.alex.williamson@redhat.com>
In-Reply-To: <20250923150414.GA2608121@nvidia.com>
References: <cover.1757589589.git.leon@kernel.org>
	<1e2cb89ea76a92949d06a804e3ab97478e7cacbb.1757589589.git.leon@kernel.org>
	<20250922150032.3e3da410.alex.williamson@redhat.com>
	<20250923150414.GA2608121@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iPYC8MBY2TjzKlFFKBpFIdnNmt3jYA9ezrE7A0irLTQ_1758648645
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 12:04:14 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 22, 2025 at 03:00:32PM -0600, Alex Williamson wrote:
> > But then later in patch 8/ and again in 10/ why exactly do we cache
> > the provider on the vfio_pci_core_device rather than ask for it on
> > demand from the p2pdma?  
> 
> It makes the most sense if the P2P is activated once during probe(),
> it is just a cheap memory allocation, so no reason not to.
> 
> If you try to do it on-demand then it will require more locking.

I'm only wondering about splitting to an "initialize/setup" function
where providers for each BAR are setup, and a "get provider" interface,
which doesn't really seem to be a hot path anyway.  Batching could
still be done to setup all BAR providers at once.

However, the setup isn't really once per probe(), even in the case of a
new driver probing we re-use the previously setup providers.  Doesn't
that introduce a problem that the provider bus_offset can be stale if
something like a BAR resize has occurred between drivers?

Possibly the providers should be setup in PCI core, a re-init triggered
for resource updates, and the driver interface is only to get the
provider.  Thanks,

Alex

