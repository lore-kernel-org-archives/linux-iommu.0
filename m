Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800379;
	b=HqVV+bFuXuRIs05L+s3yQBWOityl9vvOue9kE1MWs8OhHn6eREkTJhDwqxDfb1LoCyf6
	 4jfWPcX67S1pEhXky/5iE2Y8+0DxE5Zd1LXdg0Jjj7c0aBeJGSapXNMI+WMPzhDwzWZ40
	 f2Dbk5dZf9Dh23TtZ7Pj6YG2Pp9rR4ua+ZRvNZwArmZzhG5D8oLm+ahNpUHO4GX0FoUA/
	 PNLlEQ1WPpiHXHvUKiuuRE2t9Sul9mcZ2lE1MASmABn2saUbo2CvgUUpiig+9hd3FyrjY
	 xM55ZlqgUQv98zmdnYdLPLLvNZEhOzequfktPfhS/ZDc0wYoqGsvnU4hvvDdkeBX8TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800379;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a9sgY1wDyH66YNK2sLW2XkmwV0xTgSVD7ewg5AAoqtk=;
	b=fqrw0h6FE2WWQvY/VGGmgbutGffhQv2kMybfnEb8lrH0BdQZjc7iW7ML0OsBLUj1jJu9
	 zaIqxrTwWRezkt1wLzaGpS9WPIVfAk8Y+xfOyuNQNJCzsvFjCgSpCPJBKBrMvdNAkgA0h
	 ELTPpHUpk5L6DViYcyQMYyZuX+r9sZJZmAJkyvapgwJ+StjZfxizBpyII1gkN/0WiOHH7
	 FK8huoedzUdAeCJ6D1THysSKCWtNkqgjryxSluvQp0jq5fkzN1qW82ToeAbpLs0NZkdlA
	 n6Un9exAPElelo1/uRqubQrCwiGTpr2zgt4fACreIBcgVwrNiDVOi8LSwG0hcxdG1vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=meTtckta;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F163606A31C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 03:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F163606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=meTtckta
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=meTtckta5LEDNUUu7pe/VZYZUdmdBPNgl9BfBapZXzEET8xILaDqpLVCBhgHM4bo7FvY+rTP5RpSQ
	 odo+IOhkVuQYlF6JRg8SBNV/nS1BjdrM6qWy/Fc6Dh460L51+MLj9kALRgreRBZa1AaRu+IKuhHZ61
	 hWEujT4m5TuCjJl8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76afa7af770a-fc3e2;
	Mon, 16 Nov 2026 11:39:35 +0800 (CST)
X-RM-TRANSID:2ee76afa7af770a-fc3e2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16afa7af5540-7b4d5;
	Mon, 16 Nov 2026 11:39:35 +0800 (CST)
X-RM-TRANSID:2ee16afa7af5540-7b4d5
From: Jiahao Xu <xujiahao@cmss.chinamobile.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com,
	Jiahao Xu <xujiahao@cmss.chinamobile.com>
Subject: Re: [PATCH] iommufd: reject mapping an iommufd file into an IOAS
Date: Mon, 16 Nov 2026 11:38:08 +0800
Message-ID: <20261116113808.560717-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <20261114004101.GE2532299@ziepe.ca>
References: <20261112105945.285526-1-xujiahao@cmss.chinamobile.com> <20261114004101.GE2532299@ziepe.ca>
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

Agreed -- the blocklist is the wrong direction.  A vfio device fd bound to
this iommufd holds an iommufd_ctx reference of its own, so it reaches the
same cycle, and any other fd type that can own an iommufd_ctx would too.

The reversal looks doable with what mm already enforces.  memfd_pin_folios()
accepts only these two kinds of file:

	if (!shmem_file(memfd) && !is_file_hugepages(memfd))
		return -EINVAL;

and both predicates are inline helpers, so iopt_map_file_pages() can apply
the same test before the reference is taken:

	if (!shmem_file(file) && !is_file_hugepages(file)) {
		fput(file);
		return -EINVAL;
	}

with <linux/shmem_fs.h> and <linux/hugetlb.h> added to io_pagetable.c.
With that in place iopt_pages can only ever hold exactly the two kinds of
file memfd_pin_folios() is able to pin, every fd that owns an iommufd_ctx
(iommufd itself, vfio, ...) is rejected before iopt_alloc_file_pages()
runs get_file(), and the dma-buf case stays on its own branch untouched.

That is one file and about six added lines, and it makes the
iommufd_ctx_from_file() check in what I sent unnecessary.

Shall I send v2 in that form, or would you rather see the validation
somewhere else?


