Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D984A36
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653954; cv=none; b=l+tIcowCN3xkYuQp7qCakqHJ6rKeeFx5ftumIw+uNpVvJV+AO4/d2hM6UzxkVemF6L8bLth26TeDSKWyQzPWelR3Vd46jrEd67m1cOc1tZDTffn0yM7wyZjL1sYDl+Cn0Mvnaiq4SIwd21ZJ0UvObyv0jUCCoJK087JCt5ck1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653954; c=relaxed/simple;
	bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYihFLetYaLzozlPcwHQUIMGejz3TnEwq1wRnRJtxbYICUpWhDEoINlHk4vGRZ75GNwkzWE8JSKwqgLsvcuLYozTN+N8awni1GP7NYudWIeLwBuRttuzstmny3Lc+x9BzELp3SEchUoCVNzTCWX91SfKUE4zyirWDi0p2uHYiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6kGQxY4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6kGQxY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
	b=E6kGQxY4xYiApSOlxL+UwCD068R0rgW2rO3CvvjD0WWae/XH95I5/A3nD01OT3+h0l+NkD
	QNOTW9GQ9Pt3Ocp3hGp60v3xX2RNiyAByuxWXnGSMz0pwOf/pgt/rfjZikGNGfdNq8KN5O
	X0QK3iumZ6bIojjfODaFgcI3atBhU/k=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-bUGa94Y6Op6811rhfLD1yA-1; Mon, 26 Aug 2024 02:32:31 -0400
X-MC-Unique: bUGa94Y6Op6811rhfLD1yA-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-498d3dfe83aso1371549137.0
        for <iommu@lists.linux.dev>; Sun, 25 Aug 2024 23:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653951; x=1725258751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
        b=lJRfjPRFBWhaaGYIScO2o/XT988qdnD5Y6SEvqFx6Phc9rbBXveQWjAX0EvNGVUz7Q
         KXwgWJqiYHdd1dQszbyFIcMZNJE0ZWmDJrKxjdNZPZ7n8zpTE5cjT5tDiSJprRJS27Av
         2RZ7DR6Qfqhu7ZqekgTOn6FCwFjMYRBsyUFkoEA7yxxHdfhMWP1N4Va/FWr+i7cMBSsf
         xE/rR87tXb7ixM9nKPavmR5t0lCrYKA6pQ6NP+GAXAobGUVgqZllDF0CmNICN31s+bRw
         K3U1KT4JOrk7WMDaKH4HRjyeECsccxDXq7ec2wNlcfHPwhiKDcarXz54YNtKVmdECbVu
         dTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcDeA5zFmf7xs5Ead+8gFYNjsoUqpjt5Alv/1Je8Nd5/m33CLsDB22EW2LZ5O8Bbz0Gqvxyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxAD0/jBUpX/cZULuiDa2IKCqUewxu9KG22VHLqb70yyDywv3G
	ckT2iyG9GxgdRcvFHWk2gN/hlVaLhl4Nb4DqeIwy+97rLrDbOAEadQB/YgBjUptWhqIGlDmqXmu
	JEYLfgf7/iK5GsBljoc/a9c7PBwGavDc/fHHF3AdLNdahvUewFmlXSUdKoGiNNYc+hzqaddXMKR
	04/1SmIPJYEagl9AEmWoL97VryOgE=
X-Received: by 2002:a05:6102:3f0f:b0:498:cca9:8b3 with SMTP id ada2fe7eead31-498f4768d98mr6498544137.31.1724653950682;
        Sun, 25 Aug 2024 23:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwydcuFOVlgtFmwjWlxiF2u2xtiMO6UvY+/x7l/PEgUFs/udwBSaHF5gxdau0K58G8iWDDv631otNdoDoL8Rg=
X-Received: by 2002:a05:6102:3f0f:b0:498:cca9:8b3 with SMTP id
 ada2fe7eead31-498f4768d98mr6498530137.31.1724653950260; Sun, 25 Aug 2024
 23:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240824035817.1163502-1-hch@lst.de> <CACGkMEsK8k=yX2ZytMJQhdZi4PS9-7KLUYmf2oGLu-UvNEYzug@mail.gmail.com>
 <CACGkMEu83MjTpkSS1mX02ar8RNDc5T4bsd4kkGHYhkH7LZY-wA@mail.gmail.com> <20240826063002.GA30266@lst.de>
In-Reply-To: <20240826063002.GA30266@lst.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:32:15 +0800
Message-ID: <CACGkMEvB20-iwNKepBdJBNAvxN-5+MduxnX6XDbPFsVA4hNz5A@mail.gmail.com>
Subject: Re: clearly mark DMA_OPS support as an architecture feasture
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, iommu@lists.linux.dev, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-media@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 2:30=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Aug 26, 2024 at 02:27:27PM +0800, Jason Wang wrote:
> > Actually I meant, we can extend the virtio_config_ops to allow mapping
> > ops there, then simulator and VDUSE can hook the map ops there.
>
> From a quick glance that feels like the right layer of abstraction,
> although the config part of the name feels wrong at that point.

Right, or we could have a dedicated map_ops instead of trying to use
virtio_config_ops.

Thanks

>

