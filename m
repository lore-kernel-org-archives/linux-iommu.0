Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EAF2EEE97
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783123086; cv=pass; b=StAiKiqscqcDEH5vKIWdojfK/tSErUvi7MOBEevDpG9WivteA+Mc75qXnaKrU73hY1l0ajUBOhM75kCR7TXb6RTJSZ83XMWIZ6fyBNabNyZbXd8M/AlFnjzlq6HC5pIaDFNd/4QnIPFpgTKj5pE8IJVgtySAhrLLA6aIeBGHaCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783123086; c=relaxed/simple;
	bh=YQ+X501MghrEVofZ2SAk2Wa5039EFXy0WkKm9555T8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDq0+fwZOyDnA+XBrl5gGf9v4g+qc24dXh5zKkgL5Azyyj0DLYhz4IbthBgrBpsx3V3o1COfpeN1NUVVEj9qObk6+dlApeZk5W2EVvaIUDsGroLNIqXcBct6fRSoZ6B/NqEzC+FS7MGP6Alrew0siYju5d0C65AeAW9LKY2FTok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b=Pf+FZ1RU; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="Pf+FZ1RU"
ARC-Seal: i=1; a=rsa-sha256; t=1783123078; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K4o6MJdk0T9SnDurVUxo6/Zx5EQvU+1TKSRYYC6Dp/kQJ5S0y9jlRW9LpIIOQSuFWyt/8uMPUFzDpHo+Hh2h7RGIj3aCxfnZmd/NuFZnHoeqQV2QZhf6HcA/fl2e36UyzbOvHzLPFZz9c2W35GQSZNUAu+7OG0YSACvIGVD0ZPc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783123078; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pkNn60HGLoPRSr47oGxvz0YSz8B7GXQgqYIHxYxFFoQ=; 
	b=YAmfGXIoPOicrwnWpeZDOxqoIp8IEgJ+X66ZDd4UX3LLrp5QD8mA2PSjUJsaOrLi+eC4ijc2+bXg6s4osL3kAVJrrVm0OCdLxoHfgAlMqaPZdXzaB6tB9RUdF+FrUOi0/1ThWflDOWhpc2hzBOfYhnhPjPRicx4R96YCVWKLaqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
	dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783123078;
	s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=pkNn60HGLoPRSr47oGxvz0YSz8B7GXQgqYIHxYxFFoQ=;
	b=Pf+FZ1RUt+dbTOUxTFMtwdW3sFnYQdxCuCg8Wc2PkeQHTgKjWaqkPWvzujrdx7Lv
	sk9cbc8EUlJImAFUlilkuABDNXxXYgScJWnqsbE1qOcgYhghfiJbhlUPSiEbAVPqSzD
	d1XVNJbm6auBQZZS0R3vr3fJcJGZtqKCZEtvW2Wo=
Received: by mx.zohomail.com with SMTPS id 1783123076065196.91040273304702;
	Fri, 3 Jul 2026 16:57:56 -0700 (PDT)
Date: Fri, 3 Jul 2026 16:57:55 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	iommu@lists.linux.dev, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, laura.nao@collabora.com,
	boris.brezillon@collabora.com, daniel.almeida@collabora.com,
	samitolvanen@google.com
Subject: Re: [PATCH v2] rust: iommu: add device lifetime to IoPageTable
Message-ID: <akhMg3ffloOO19PC@um790>
References: <20260703-pgtable_lt_b4-v2-1-f14da6d4106d@collabora.com>
 <DJP6UGQMBAXD.1UHYDZXIF88ZD@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJP6UGQMBAXD.1UHYDZXIF88ZD@kernel.org>

On Fri, Jul 03, 2026 at 09:37:53PM +0200, Danilo Krummrich wrote:
> On Fri Jul 3, 2026 at 8:52 PM CEST, Deborah Brouwer wrote:
> > +impl<'bound, F: IoPageTableFmt> IoPageTable<'bound, F> {
> 
> We settled on the convention to only call a lifetime 'bound when it actually
> described the entire bound scope. This might be shorter lived, so maybe just 'a.

Ack.

> 
> > +    // TODO: Provide the option to return `IoPageTable` as a device resource
> > +    // when DevresLt is available.
> 
> I'd drop this comment, we only really need it once there's a justified use-case,
> or do you have something in mind already?

Sure, I will drop the comment. I don't have a particular use case in mind.
Tyr will own the page table through its VM data, so with the lifetime tied
to the bound device there is no need for Tyr to use devres.

