Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB07219A91
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742511956; cv=none; b=tZOBghAAaU6ZDZTRHY4hw0oeW76JtTx+y1X7C4AXeiycCWEFFKryK1/6Bgoe78Pboig8enN4aHoHJRqvQWQkmToIhhxZp/RQTuuLdgagcO+9Khx5b7ExMf7VTNPW/lhPk8E1usADBjVjwV5Z58nXEY2U3rCjLD7AmLgwwK8sPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742511956; c=relaxed/simple;
	bh=1B3WXtlxnKlZxkoLs8o8KnmugatMnzHta7UBG+GOZp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btlpODDMignnRQ+JD58uMVgAUCsK/XXPk6KL5Ou2tCfZmC3JbxMOyr50kEKSBpVj+j/SPrlF/o4CYEmZDyskf5oynLK0BYbSfiM5ktt+IUJRU9BFa5AO3lC+UgTdY2N/8EOxCgTJER4AUx/aXQV/uMX/T+UbfCjURJviB94n0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LhDFU2xD; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LhDFU2xD"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5b2472969so125832485a.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742511953; x=1743116753; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHAGU2mruLimRqu2Jm12EXLWpbzOUpJGKsKPU3LFGI0=;
        b=LhDFU2xDmzwkNgFLCTyYJwjo8SA05h0835DnUx+Pa6gitsP9QlZFd2scY5r03YgPE7
         Sn7M1Z9SkR4LT1Ipq34m3+nvXBqn3cvGMHKWUifJMnEga7j5k3ZPrEgY5csxPt/8ATiw
         sTDgMsxwpXJD6qlWViRt+7Mg0ED/N7E4Iludr3OqwIQ6Iz/8DiRtCKOHcYa6tmOgbmru
         /4dhnGXQuDuFv6DoUO3J9CUWPfuPEwhREJd4icWQDB5QioH9vf+bKagv7WXa3+Jf8uxo
         CfUXDXhsbYg/xDEiW3vmYoQe1NVvCPyRuPmO4nldjcMmYkqYkWW7fL8S/xxeebdSkQHO
         opGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742511953; x=1743116753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHAGU2mruLimRqu2Jm12EXLWpbzOUpJGKsKPU3LFGI0=;
        b=cBq7em+ZHOQ03eeTU13/KiJpzk838tNXcf8yjOU0pI99DR8JrhBLbFyTeJhiT6LN9q
         7do8cXBqI07ywszWVmv5lBz+OvbtrwgO3YpIPhd4RqMFdGFa5lZ1xmqHFe8UJVnynrhz
         2vpNq+OZ8psiV5qR7cnPqdRfwSoAfpfISFIX4oSsEFqY2oesjdm7/UiL8L5vQ8HvvPe0
         xa6BAk5x4iisTTKK90NCWXiZy2nN27I9kyhmO8MMKIuxbEo3mEYHWIbaasDiy+lDm/Uc
         r0guRV2KK9amcLvRJ6SYCmJJDBgsVaCZv6Gry0PkjSq/yAsBwGSr/YQ0CSZXH4GnILwD
         0H5w==
X-Forwarded-Encrypted: i=1; AJvYcCXXmuFjrCg4Kzy7x3O1yCd5h1La6z6vGdriExsEvEd/W5HMLU+YN0YcpSSEQl7qPJwD+xyJUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfuZqupFeQeTpDO6WiVw0Jz6Uu91qY7Wd61jPWjhYCDbHq7yLT
	vNQKJl8v4vmNzQGBiTw050mfdx+I3X3qZOTMH7ntVfLzEmzSU9JGeGQWq4DzrIo=
X-Gm-Gg: ASbGncsLTToDQXBFqwJaLfFAfZBpKA28PUVAAqwbUPuIC12bSwwkOrjkmNLXy/GYw75
	sESrwhrnX8d5Vxb8iJXWBq3zg7P51b7OYwlFbwKsXLnB5XP9VF6b+UxihrHaY/23Xo5dyJPw7Zs
	husjy/bVb7h5mYfLsAKcMJlI5lYfBrzBWdqj3QYL2R73bZfJP/uHKohRp1AShL0jrGvq2BPkKbH
	bPh566UAfWzaDMmJ4Kj35Ahqre57nKc/+Poqh9G7269JwwPa+Gj4UYm3tnbKzfEI+BSYdM8TegD
	F7OIh1jWzvvVIdsYCSiSz3TXXZM7NCLiWU08oMz6EH58ARnoD9PcGeWEZAUEt3i3J9Y3eX9IJmF
	29sGcfce5aw32/oVPv/U0pF0=
X-Google-Smtp-Source: AGHT+IGbgwgzQAhlzdVFgQtwB3qoKcyQWAJL0+xFdHQPRJQ9qszW8DeqMhOpZC7c8c529RIcDbeBBA==
X-Received: by 2002:a05:620a:4443:b0:7c5:5909:18d9 with SMTP id af79cd13be357-7c5ba15a850mr158887185a.5.1742511953396;
        Thu, 20 Mar 2025 16:05:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b93482d9sm43844885a.82.2025.03.20.16.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:05:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvOxT-00000000x3U-36ww;
	Thu, 20 Mar 2025 20:05:51 -0300
Date: Thu, 20 Mar 2025 20:05:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20250320230551.GL126678@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
 <Z9yWnBmOfeG-7rno@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9yWnBmOfeG-7rno@google.com>

On Thu, Mar 20, 2025 at 10:28:44PM +0000, Mostafa Saleh wrote:
> On Wed, Mar 19, 2025 at 04:46:09PM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 19, 2025 at 06:22:30PM +0000, Robin Murphy wrote:
> > > I don't see SVA and VFIO needing any special considerations, so it might
> > > just be the new vIOMMU stuff which may need to hold PM enabled for the
> > > lifetime of things exposed to userspace.
> > 
> > Are you expecting that the VFIO driver, and whatever driver is
> > managing the SVA will keep the power turned on as necessary then?
> > 
> > VFIO is not going to work if the SMMU power goes off unexpectedly
> > while the VFIO FD is open.
> > 
> > I suppose VFIO also can power off on-demand via userspace asking
> > it. In that case the VM would be co-operating.
> 
> I guess VFIO is tricky as there is a security boundary. In case the
> SMMUv3 wakes up with caches not clean, there is a window of time where
> the device is accessible from userspace with old (or garbage) TLBs.
> I see VFIO-platform always take a PM reference for the device at
> open(), but I am not sure how that works with VFIO-pci.

I think that is my prior remark, PM must either abort or translate
exactly as the domain contains. Never something weird/old/bypass.

If the HW isn't guaranteeing that then we have a bigger discussion
here about how to deal with the security issues that creates.

Jason
