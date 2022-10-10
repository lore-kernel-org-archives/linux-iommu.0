Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A455A4A0D
	for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 18:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665428264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=H4dEUyv/GvCvxwPuE1Ie3nHYJS0AqpfIYFkaqAHSeuo=;
	b=OE6iDra1Yed66f4kI5aeVSVAV3OEEMcCrZqBRvIMfcU/RbJAwEv5/1EPa2Mqh3JWvCL1tj
	pZwoqS3zmVCPr6kHuFwfBnSEw8oFTD4dQupLbztYJb/DQvLKHXwdiqVnqO3+AjHpVezIgO
	q/YcukLRK9i5OVUs8UCOfNJdFhMISk4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-N9lxr0jvPGiru354eu_KtQ-1; Mon, 10 Oct 2022 14:57:43 -0400
X-MC-Unique: N9lxr0jvPGiru354eu_KtQ-1
Received: by mail-oi1-f198.google.com with SMTP id j186-20020aca3cc3000000b003542949670eso5461798oia.6
        for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 11:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4dEUyv/GvCvxwPuE1Ie3nHYJS0AqpfIYFkaqAHSeuo=;
        b=69onmF8Zh5a2uI84K+eiG7Sjo3rn7CrsDwkbOLdngY//i9zBhyh+L2B1GKlUdWkCWX
         m32Yb8DX4Sk86/r6p1c3t86zmDfHYZ1y8fOtAWbRbUCniG3ziA7ZAS8trAKRf4+zNhUd
         FIZzvTFZB0E7031c+RPwBAPnQNTu0Dx31r7tDpzellNLlCcBcr5Od2pqoEjtsgGOgwEC
         tIKGeVyU1I5IdY0o/3cNAJ59yA4CnzwQs+kgsLDOl6Bgbnh0Sjaltz5cs9RaBufYW77d
         XDibttSEJw6Smy4lWTVk9GBsLTnh25qKiRiIUAm7WXzVojaXSfeXN5hEeVD9Ug1p8+oQ
         HMQw==
X-Gm-Message-State: ACrzQf3VTy2cbdP47au+qW08I9sulbVOggvOXkgdFo6OUgA9GSsxyTkA
	jcKHw91ZXP2IJUjiJ5lSt5tCAITux7bw3h4qcVOjUUOc46quBrjcRW5FVk0boeP4MzAyhS7raBH
	bM8i6lyjWsdXRCwk=
X-Received: by 2002:a05:6870:a9a0:b0:12b:45b6:80e1 with SMTP id ep32-20020a056870a9a000b0012b45b680e1mr16577367oab.209.1665428261311;
        Mon, 10 Oct 2022 11:57:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7C9JHqJuNrM8W7+RXHF7LmED4/MlJ8xMRXffGkYhrIzx6UVWlsYjFqQf0d7gpMSh3AOcEVEQ==
X-Received: by 2002:a05:6870:a9a0:b0:12b:45b6:80e1 with SMTP id ep32-20020a056870a9a000b0012b45b680e1mr16577359oab.209.1665428261137;
        Mon, 10 Oct 2022 11:57:41 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s63-20020acac242000000b0035173c2fddasm4579112oif.51.2022.10.10.11.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:57:40 -0700 (PDT)
Date: Mon, 10 Oct 2022 11:57:39 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Issue seen since commit f5ff79fddf0e ("dma-mapping: remove
 CONFIG_DMA_REMAP")
Message-ID: <20221010185739.vgw27m7fpmftly3q@cantor>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been looking at an odd issue that shows up with commit
f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP").  What is being
seen is the bnx2fc driver calling dma_free_coherent(), and eventually
hits the BUG_ON() in vunmap().  bnx2fc_free_session_resc() does a
spin_lock_bh() around the dma_free_coherent() calls, and looking at
preempt.h that will trigger in_interrupt() to return positive, so that
makes sense. The really odd part is this only happens with the
shutdown of the kernel after a system install. Reboots after that do not
hit the BUG_ON() in vunmap().

I still need to grab a system and try to see what it is doing on the
subsequent shutdowns, because it seems to me that any time
bnx2fc_free_session_resc() is called it will end up there, unless the
allocs are not coming from vmalloc() in the later boots. Between the
comments in dma_free_attrs(), and preempt.h, dma_free_coherent()
shouldn't be called under a spin_lock_bh(), yes? I think the comments
in dma_free_attrs() might be out of date with commit f5ff79fddf0e
("dma-mapping: remove CONFIG_DMA_REMAP") in place since now it is more
general that you can land in vunmap(). Also, should that WARN_ON() in
dma_free_attrs() trigger as well for the BH disabled case?

It was also reproduced with a 6.0-rc5 kernel build[1].

Regards,
Jerry


[1] https://koji.fedoraproject.org/koji/buildinfo?buildID=2061881

