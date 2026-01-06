Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2DC8E6
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767658463; cv=none; b=Dm4/GeoKUCjs2IXp+ncLDIQLnmjhJM8P4RlGyOREiFcWqIRx4hJ9G8NXTLg1F37cF1EIBUoEwnXIaXAn9AX06XSZX6salTnooESVqbuFHkm8d/JugpPQtEqeQJpE8OtgJU0qPmo7TObqMlJrIq5HdphJdgj+oU6/zeyHHfR0YX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767658463; c=relaxed/simple;
	bh=b9lFoeDY8olxyEXpwLlktvYkltXiyo1BHzt/SQDhd+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kciGrROnNb65mZgf349dP1bXjr2ngLhAeKRAAaQGyS+vSywBBOOFNc5iJZZp1oFyL9G//z1OSmucM3fa1LI/puVHNJ4Gx+oFeFy0hQvaVMmD61tY6i1+lQFqcH5rU9K2jYCz2jInr6f0roxLfzykwk8igjaANcRLFmiCHvN0U7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q4nRHgus; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q4nRHgus"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b29ff9d18cso40653685a.3
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 16:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767658460; x=1768263260; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSNcjy3Y/FZ4D5uoQBIr5R72qyzUWwhSqvqfkqMWju8=;
        b=Q4nRHgusXzA/h2olxcOtx0iR/o2Lbqt5G9/OBuZIh3+vtJ/eb/+ftA+a84rw1roME9
         +nTx/C6xZOJgX01O0fv3falIuCViMd6GFRmblV+hAY545oGfZckH6oM3U5jslxlkKurW
         M4GZ0MmR+RUPYs4dqcewmZxZYLmA2D7DzgKFaTQ4LEfDoRwUOC8PyBikGoxhPL+liCA4
         6so48AUOJr+t4HloyafwyNOeEz4Zt8ydysqkWVReTrK+glBM2DMphLfIYjb6edfZ4Av7
         BUCL3ZaOzFgchMM9pWe7vWzVC5oT8yw6TeJjeMX5+YcIKljH8IftgvP2HBZz+fC78VuH
         pANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767658460; x=1768263260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSNcjy3Y/FZ4D5uoQBIr5R72qyzUWwhSqvqfkqMWju8=;
        b=nmWlo6AukyNGm/mqFS7+Am8TZBATCtGQOgyfdGoBbL7m5+k2VyGl7equez9SCFeILb
         OhzPfP7VbRmtI+t8SQoIFngDfoxIkZFCmKfHL+ArBwHBS3kqtE2ZXlSxjabBVv4GmC3P
         a1VIDSM+uUjtvy2eFCubZHQfI7PM6tf9J+8XFu7Z0F6IesTsnovuRbd9Pc1mPAcGhdew
         iwc29+s3PRbuAG4NfV/oMHJy+PMfpUcgoeCkop/Ya3J/XLz6JiJbngW3Mepte23YVshu
         u3toHyzDglRUbTuPqBHRlhSZS/2CRQbilCAxKrZH0PviuS6xg5jjlLSLnX/0x5YiY6po
         F0ug==
X-Forwarded-Encrypted: i=1; AJvYcCXTk0VBikCXQByeRxoNFUStKof3NR9YUHd7zOrHkHPfwKuaFfp5ITMLJl5ZKK+nx661EjPP3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZDJjKf1UPXxg44KxPhor4DZve9nnX4DueGSZmfa0vr8VFkvLz
	Ct8q194RS3QbzEenaymySd3bysy+HGplinSFTn8olfUQdCyxVKaru5QQEXOrsCvnsag=
X-Gm-Gg: AY/fxX6qvLLS0zJGAVAo5a4vf6F1Bh78paocD0h/dVjiXymq0e5Qr8uM6w+4r1WRcry
	aHgcTuylNet1/6upYVrmPHMzO02U/RIaO1DXnStGuVWfEsyMbTeKkczriscSzGSsomn47gPwMvY
	b1oe9eQeJl9T8declQEht8kbdb/KFV6VIv8QEqOeCNg6VUmwQdZR1A6ppqYhFp+3MnWdjtDyD4y
	qOUyL5c3KBpjWvfz7CFpb7Z4RjlGxsl9EhfYxJUIgoKo/ZFoi8QCgXUYehua/Vf2qFzpHeWFG8L
	Wv/PZMhUC4qRIE+tO4B7Dk1wZXgKuAFW9nrm3w4o3IW0JbujrRnIp2D07pLhqfPwcxAuBCcAEfB
	F5qBjTuxkYRHE7yhiDTdIQWKdrqZFKXiOH793o49fcyRqxYSDGvF5+JlnYAwuwDSYkWa/huUzkf
	VGMy8W0YXQ+qI3GwBkVv8m2pzfAji+J6S6W+fbxtZjqSuop+XxgDerzxtbqfshVeS1Zek=
X-Google-Smtp-Source: AGHT+IG8Jv6SVythwUh/KYIASi9egaGsgxjk07jj42spcPEjuxCqcunvlaHdxLVqgxgUNkgQETmlNw==
X-Received: by 2002:a05:620a:2804:b0:84d:c10c:e42b with SMTP id af79cd13be357-8c37eb372d3mr210367785a.17.1767658459934;
        Mon, 05 Jan 2026 16:14:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4bc1e7sm60549685a.21.2026.01.05.16.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:14:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcuiI-00000001EGE-05sB;
	Mon, 05 Jan 2026 20:14:18 -0400
Date: Mon, 5 Jan 2026 20:14:18 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Message-ID: <20260106001418.GK125261@ziepe.ca>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
 <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca>
 <aVwZkFQ-iQ7OHMi2@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVwZkFQ-iQ7OHMi2@google.com>

On Mon, Jan 05, 2026 at 09:05:36PM +0100, Dmytro Maluka wrote:
> > and WRITE_ONCE is pointless if the HW is promising not to
> > read it due to non-present.
> 
> As long as we use a barrier. And IIUC vice versa, if we use WRITE_ONCE
> for any updates, a barrier is not necessary (on x86). And WRITE_ONCE for
> any updates (for PASID entries) is what was already done before this
> series.

That is an x86 ism and it shouldn't be needlessly leaked into drivers.
As this is not performance it should have the portable flow:

   WRITE_ONCE(non-present)
   dma_wmb()
   <cmd to flush caches>

   [..]
   <writes to the entry>

   dma_wmb()
   WRITE_ONCE(present)

So, it seems to me like all you need here is the one line to add the
dma_wmb() prior to setting present.

> Although, perhaps even with a barrier, WRITE_ONCE is still desirable to
> prevent the compiler from doing strange but legal things that involve
> transiently setting and then clearing the present bit behind our back?
> (Not that I'm aware of any compilers doing that, but I'm no compiler
> expert.)

You do have to write once the present bit, but not the others. The
dma_wmb() will make sure the HW cannot observe other states when it
observes present.

Jason
