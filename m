Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878018;
	b=oQ6ztzvF08Jz2SAiPAi1VOH3Bx/EABjwMrOmMmg07CeZYbkOk5SeYWyCWt7g7sHfPVZ9
	 Ga/szLQ9ckTdD3dGZO9q8a4ZjOKxPquQznsVsRoSMM8/so6/OB1U/fJPpcjmWyM3u5GET
	 9JNuvSWJ0EloP9WmVrFqXV9OPPk4dF6EHqvVIxqSo22qzvBCMgkW0Z8HuRBpl00E3oZN+
	 0j1f9Qrx0r0ZxeHXj3/iDvc3RpS8do+lHUOE6wEgA1xy8SxntPbVIu9jd1zwedterdu1T
	 XzqKy5fSkeqNt9j1WjckpbFux1fVK8tvHQX6ixgGR21yzUtBC9Aodlrk428ve7Q7eOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878018;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=36R25mXjEI1BZreL5T+Gg3jV6ucWsTmY01D2Wafq+n0=;
	b=LPwK/1lsghTZ6c1YkwbN5nxvxK+OYJMgUMUaBrUvK5xnzmMxT0HwVEpq7TR+7t21II1l
	 029fLHarhgJ+aZyf2ndSDUA0yrRY2wXy7cXAS9xkqwIkTufm4a5LGDKpXo/b3OqRjIMb7
	 DViARQHxsoEVgpHxv7cb/kJizXSPxAU/m4v960Io1HLzaEb6tMAmKQgb4WA8xgNSgfHrR
	 WigeVuJMHskDMggYZ92lto5cezE98nP2w0iFyLOofhVsULVJCZz9yQN/MqivnUarrVwxh
	 nNpW5VJVi5U6oqNC2Khm+hh1t94Fz6JyXAH3cKgzDYh39318tIIkd9zPnVuLlkM13ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=In3FF0gK;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5B606A31C
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 01:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2F5B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=In3FF0gK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=In3FF0gKq7VaJg5JMjHaoNScy65we6/YZu8oXQpu1t9hUG1hVaN+OnoM5j9KckxTVc87yOEtr9ZgN
	 Cu1bR6V6ckqesj8X1iR7IxnGG3QES/2YkvByb3Jneh6wcm+GcNk24grrv81F7YyI+qMpf7BZBimpqx
	 CL4UUTuer52vHeVM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86afbaa3ed37-a3253;
	Tue, 17 Nov 2026 09:13:34 +0800 (CST)
X-RM-TRANSID:2ee86afbaa3ed37-a3253
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86afbaa3dbe9-05c8c;
	Tue, 17 Nov 2026 09:13:34 +0800 (CST)
X-RM-TRANSID:2ee86afbaa3dbe9-05c8c
From: Jiahao Xu <xujiahao@cmss.chinamobile.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com,
	Jiahao Xu <xujiahao@cmss.chinamobile.com>
Subject: Re: [PATCH] iommufd: reject mapping an iommufd file into an IOAS
Date: Tue, 17 Nov 2026 09:13:33 +0800
Message-ID: <20261117091333.399547-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <20261116134920.GK2532299@ziepe.ca>
References: <20261114004101.GE2532299@ziepe.ca> <20261116113808.560717-1-xujiahao@cmss.chinamobile.com> <20261116134920.GK2532299@ziepe.ca>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> And how do you let dmabuf go through?

It does not reach the check, dma-bufs are taken by the branch above it.
dma_buf_get() only succeeds for a dma-buf fd:

	file = fget(fd);
	if (!file)
		return ERR_PTR(-EBADF);
	if (!is_dma_buf_file(file)) {
		fput(file);
		return ERR_PTR(-EINVAL);
	}

so with a dma-buf fd iopt_map_file_pages() goes through
iopt_alloc_dmabuf_pages() and the else branch with fget() is not entered
at all.  iopt_pages keeps pages->dmabuf there, with type
IOPT_ADDRESS_DMABUF, and never a struct file, so dma-buf mappings are
unchanged.

The shmem/hugetlb test is not a new restriction either.  The file branch
already ends in memfd_pin_folios() when the pages get pinned

	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
				   nfolios, &offset);

and memfd_pin_folios() rejects anything that is not shmem or file-hugetlb
with -EINVAL.  The check only moves that rejection to before
iopt_alloc_file_pages() takes the reference, which is the one thing the
leak needs.  A v2 doing exactly that compiles and passes checkpatch, I
have it ready to send if you are happy with the shape.


