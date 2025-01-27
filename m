Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342E17603F
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737975640; cv=pass; b=KvL5vdGoUnOXnRgi/X6YT3WsKIe2V1e2A53dnXYmdJ/gagZYB748qBgCZyanplFyYAVJxXj2oGeMOWEaZ/4f9m7sUkeyBYmLfaIUP+VbstTE1RQQGNC77eXSfYs3ObtdkrE+qSELZNTT4KpMEp/cSyhzUaYIcYFs7P5nsOe6YnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737975640; c=relaxed/simple;
	bh=nCMHsLDl+D8FchqihkwGosPil01YRZYR2nxccseVpWM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f2o6pKYDDFpplRwCt2va1YlU3/uXI9cAvR75OLkSnUF4lYQsBkCuf7gFDVB5S+alnHxZ1yCk9jnjhEscNBJJ9zZWCb3rKmhH9MV5JhcYlDpb0yhKvwvaSsqW4aS5y6AzsjzG9JkYLoit0vk7o88r3SfeOx3Kb71yCw2SQE+34dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=fTObuG/l; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="fTObuG/l"
ARC-Seal: i=1; a=rsa-sha256; t=1737975623; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OldoB/B0rXWdftLBu5NjZRLN67lnMemSzWbJN0S8i6qZBcmLkQMEvsZH//r/yvhISamjH7osdJzZcsT0HE9B7Nz+AHC+QoYqBe5Kta2yloS/+C00W7ieGJX/NzOkdie4VHejwKrf4yGFgg9hVca7Pw6FthauqVku5B7AFnPDVPI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737975623; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=s6558FbLkkVN/aQhTkZusIc6uAC5FkwD7xFZvJ8r8h0=; 
	b=WqaPLMSuLqulAwD7KCz37Rk6TQmOPeC/S1VDSL9X2SrjrPPy5TdQtpGLdSB2nHCMKcdbflKIjMLcNjWRkqWrREcjaK/82QS3ey+vE4/DnMefO/ezxjEbSjWg2Ou3riTtqFX2mPxAe6uVFxxiokua2/VOzxBMO2RaMVQ+EniZgTE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737975623;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=s6558FbLkkVN/aQhTkZusIc6uAC5FkwD7xFZvJ8r8h0=;
	b=fTObuG/lXsvyXJDTe9MKWs0ryfuNy4FlsUG1W4BSMxTC9H1ArO80vvN/hXMahMgS
	NtPZ2k7XV210MMfwK6i6bUf7hPskcp3pO2hdy6Ao4yuAMHmhj5/pqCzt5fendJkvexv
	j226X8rPJni5b258NHB00n8g7I/TniNDetNpb5vw=
Received: by mx.zohomail.com with SMTPS id 1737975604754450.37264027103924;
	Mon, 27 Jan 2025 03:00:04 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
Date: Mon, 27 Jan 2025 07:59:49 -0300
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org,
 dakr@kernel.org,
 robin.murphy@arm.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Transfer-Encoding: 7bit
Message-Id: <0E0FC88B-95C0-4DBE-B497-AF9101BACE70@collabora.com>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-ZohoMailClient: External


> 
> You were asked to rename this function because it returns a slice, but
> I wonder if it's better to take an `&mut [T]` argument and to have
> this function copy data into that argument. That way, we could make
> the function itself safe. Perhaps the actual copy needs to be
> volatile?
> 
> Well ... I understand that we did this previously and that we want to
> avoid it because it causes too much reading if T is a struct and we
> just want to read one of its fields. How about an API like this?
> 
> dma_read!(my_alloc[7].foo)
> 
> which expands to something that reads the value of the foo field of
> the 7th element, and
> 
> dma_write!(my_alloc[7].foo = 13);
> 
> That expands to something that writes 13 to field foo of the 7th element.
> 
> Thoughts? I'm proposing this to avoid going in circles between the
> same solutions.
> 
> Alice
> 


I think I missed something here. How is this any different from the *safe*
functions we currently have?

Anything that involves a copy is basically what we have already, although
your version seems to reduce the amount of data copied from sizeof(T) to
sizeof(T.field)?
