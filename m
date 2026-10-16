Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E02379998
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179643; cv=none; b=RnBtOrRKPWMyj5ZTIik2ZzqqHeFt2I+RWabhjOHEFVr2QNrq7Z+4rf+gARIM9YMVWybXQfFLjk9NER0Q257pDNk5xCBqYxE7/bjTcbSmTHcMWRMJ3OMjj49aiTEd4FA7trEL+5sN3WpTelNIn+UKR8wQS7SSQYHci75meCoDPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179643; c=relaxed/simple;
	bh=xXQUv4FgmNf0JJMpp6ecZtgviJ+BWlmyvg/p6z47y0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xg8CzAvlP768rjm0bFP1EiZzndVXLmtJCBdLXD4Ju6eE1/5O79Inf0ad27BPxy01yc72qpZ+XpMvU+49GMNSzasPIxbYTEVF8bUwhozzZ35eCU+g/9VyGWd8FtG8PpKy04qET6dDJawMt/TWXfbvH5SMONE0k18zDsnaaZDU5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMmY9exb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMmY9exb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso4231095e9.0
        for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792179640; x=1792784440; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMRRI5bEPrjeiE8Y1aI7MLDO6J4IuqM4URq6dJXpjo8=;
        b=AMmY9exbLY1oWMlIXqtj5bEB3Ek17+OyswDjDdPDcfvtEwQrK8a0Mg6j/zUYtedg5V
         6RcTzZvdb/ad8XBEA0aJ1kmbTn3Vb1OXmxvPxrW8w7NYef1Avs/ECvOUqpNDtt3icfUm
         QdLhLc8Iph7/gHtTGUUMFasw9oiAgr7zmhWf1nDM6fwX6hxCVoFr2aOYosj7mcNWhmFW
         oFT2knuHr9xaY8It/FyD5fBITjm/shwSXkR9j8jNkupVW99i4Fn4HVb4LfnEIQdLxMJi
         ESPQ/e/V8H6HpA+3l9UV2X9RYZ8HS5NJBsDVG7sI8Nbg6zHmfWyk39N5BD/+nWSn5BW0
         tsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179640; x=1792784440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMRRI5bEPrjeiE8Y1aI7MLDO6J4IuqM4URq6dJXpjo8=;
        b=UfyHfrJDAwjtK0xkk4NSA2XoQv4t2yRBqfUkxxk7qB6OgY6XYa9RE2NhkoBsBv7lWp
         8k7ZXIGDuhdvNUj7hLLbjKN/JL39CJEJRn3V7j7VmVICx8MgOY8FSf4dy27XbBFbu8h6
         pe58C1Va0+2F0XcBuQGAT9otgImp23nPSEdg6lWd4pt7DeUm+u6VCAIxN8hqEq1w7RJa
         seoXfeJJcr70NaeqjQqoGurwtsAyPM694Fn2NmeNhV0EQgCCsaik1z47s8gdbHRUcZJ1
         NcSb/dLo9MY3pzLbCXcoaDe/MOFG/b5HYXfRKUugmq+PS4rMY7XqQlnHNIDtUL2p46RV
         7V1A==
X-Forwarded-Encrypted: i=1; AKwUvByORIbs6PMo3Kq1Ag8cadxcJJDrl+8J7fL/JI7CZh4pBQM5f4JX91iYlnxADfBuYCRfPCZF+Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYIMWM0BjGDnWuLTYpCd6vwyf3kKkfbVCkzN/0m1UwQSTT6qoNEw
	x5JSUvOEtBIzjXpIPx5g8pxZ3DVPdSIZitHZlVnvnQDwJiwWfPypPYSu
X-Gm-Gg: AYBFou3buotroB4oppW1TVEIRVSZg1P+gzXxNtIxeaAyqHlxeIH7PEvvmDmdfGChMpy
	qwoezUQZZJ7px7zJiBzo3eORbiLYNFqA9cvBiLjj4h7F606wAB0BL04oyh70S3GVDL6qqRFFD0j
	nrzNca/JUUtMRgUqTPFvIuQBeASOeMMUs7vgFEFvWKIeu/ZreNNUx9sX+H1UlPRsF8uSo0UozfK
	metLQ2fEnX23WuixMifF3mlEv72H87YvQmFoJBeVgLonKtknINHyBDr+aID6rQPpkN+FCoQslLt
	yxKundAkiEn3lPaDpqCUphaenrTWCYMPqZsCfZJT6AUPTLWheK6UDd/QBWZV3mNC7IKeR0eRjHa
	op0kTJj+GUAgg8RKpFKtO6x8RKo7/0P/FQzwce8MYNAxJbSr8xQnV2WwTk0vjXTIrKKA71CUFth
	A2PwQgBBbrEkRucNb6//d0G1DsqBjcYWY/DVn+OS7xHHoEmUJNqYixdzQHaTQvl5LoFEhwjtaFR
	6UVU82lIK7bXJqzuO1l8mk4gom+sa2jtAYJ6nmAa9SlbZDAU9k3ma9ZGw+GIg2YPxmrNMIK81HT
	KBNwG6xZKzVsHv6CBw/Wwys71QLsfoY66aG9DGW5fUosjGjVxX9R6rMVmN8ox3CqqJExiYwofvh
	TznjAtbPyKs4S
X-Received: by 2002:a05:600c:a102:b0:4a1:bc14:224b with SMTP id 5b1f17b1804b1-4a1c66b37cfmr83617395e9.10.1792179639973;
        Fri, 16 Oct 2026 12:40:39 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a951-9501-1471-d90c-a21f-9dd7.310.pool.telefonica.de. [2a02:3100:a951:9501:1471:d90c:a21f:9dd7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5038b8sm7026413f8f.48.2026.10.16.12.40.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 12:40:38 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 23/26] iommufd: Use the PAL mapping type instead of a vfio function
Date: Fri, 16 Oct 2026 21:40:22 +0200
Message-Id: <20261016194022.62065-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <23-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com> <23-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Feb 17, 2026 at 08:11:54PM -0400, Jason Gunthorpe wrote:
> +		dma_resv_lock(dmabuf->resv, NULL);
> +		if (pages->dmabuf.exp_phys)
> +			dma_buf_pal_unmap_phys(pages->dmabuf.attach,
> +					       pages->dmabuf.exp_phys);
> +		dma_resv_unlock(dmabuf->resv);
> +
>  		dma_buf_detach(dmabuf, pages->dmabuf.attach);

exp_phys remains non-NULL after dma_buf_pal_unmap_phys() frees it. A
move notification after dma_resv_unlock() and before dma_buf_detach()
therefore reaches iopt_revoke_notify() and frees it again.

A test hook forced that ordering on the posted series. The one-page
IOMMUFD selftest unmap on arm64 QEMU with KASAN reports:

  BUG: KASAN: double-free in iommufd_dma_pal_unmap_phys+0x14/0x20

The first free is in iopt_release_pages(). The second is through
dma_buf_move_notify() -> iopt_revoke_notify().

Clearing exp_phys before dropping the reservation lock makes the same test
complete without a KASAN report.

Karl
