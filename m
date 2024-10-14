Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42041384BF
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892703; cv=none; b=SOcd5hel/h2RgmquARTdcKi/8XaKUGTB8n+rvrjRxYxHAhIilLzFN/0xMa2fB0QPRWvVj1sr9p7PlPqSbhZ660Iswl+/ODJtuNhxyAyW9BFc9fJ0ByQkvrkwmmUybf8sqO/3/kq7I960YVwvD6e5y+LEdEIdSNIHrCl4jQTVV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892703; c=relaxed/simple;
	bh=okUCVxZQmNBCZOnwLzSniC5oceCmOwUWK0e9RpAsbxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEsEf4lKJpzwj/e/GfkgESHa7CVfhyu+r7F2RFTRhshiSgJ4/pkKH0RHBs0P2jMudROWTOq4Psy9winZFd5ae1CRKbfYaarOHYo4+QTYokL0QSo0URSES3fpgcNRvr6ccLK5apQ29lVMMXjdjg20Q2wmSyYs0zVpNkjAmpLey60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQ6BGJAy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQ6BGJAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728892700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBWYGh1L8mzLbunG0zkaPybO/VfGp8yc/5u12WiFxg0=;
	b=KQ6BGJAySse2WPJWEVU6t2J0k0aVTyiXa6RNp2wap4RwryfMHymEFY2UnJR4TOXVOfT/jY
	qeuYupdwY3phdTQ1FwueRB9dc/hUr80e0vKL0yKVy3E21KYvKKFdcJm4KX5KW8oKWakFk4
	jbSog5bYqZI+Dunyu34xmicZtMkp8hI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-gto0hQeUPoivTJQQlE95vQ-1; Mon,
 14 Oct 2024 03:58:19 -0400
X-MC-Unique: gto0hQeUPoivTJQQlE95vQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8893C1956080;
	Mon, 14 Oct 2024 07:58:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.128])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 523B519560AA;
	Mon, 14 Oct 2024 07:58:10 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:58:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>,
	Hamza Mahfooz <someguy@effective-light.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-raid@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [Report] annoyed dma debug warning "cacheline tracking EEXIST,
 overlapping mappings aren't supported"
Message-ID: <ZwzPDU5Lgt6MbpYt@fedora>
References: <ZwxzdWmYcBK27mUs@fedora>
 <426b5600-7489-43a7-8007-ac4d9dbc9aca@suse.de>
 <20241014074151.GA22419@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014074151.GA22419@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Oct 14, 2024 at 09:41:51AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 14, 2024 at 09:23:14AM +0200, Hannes Reinecke wrote:
> >> 3) some storage utilities
> >> - dm thin provisioning utility of thin_check
> >> - `dt`(https://github.com/RobinTMiller/dt)
> >>
> >> I looks like same user buffer is used in more than 1 dio.
> >>
> >> 4) some self cooked test code which does same thing with 1)
> >>
> >> In storage stack, the buffer provider is far away from the actual DMA
> >> controller operating code, which doesn't have the knowledge if
> >> DMA_ATTR_SKIP_CPU_SYNC should be set.
> >>
> >> And suggestions for avoiding this noise?
> >>
> > Can you check if this is the NULL page? Operations like 'discard' will 
> > create bios with several bvecs all pointing to the same NULL page.
> > That would be the most obvious culprit.
> 
> The only case I fully understand without looking into the details
> is raid1, and that will obviously map the same data multiple times

The other cases should be concurrent DIOs on same userspace buffer.


Thanks,
Ming

