Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00AC1A5BA4
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716832; cv=none; b=VdtLkaTCafOmOMNa15Cg/Frar0TKuQwp46u0OCUZBU0N9B3amIKQTrvMrQwF55WneNS/ArPdTaR17p9kadqbjos9OQs/RxwsxoDjSQcibl0WzztjLDQ86Joykw2p/K6+TAyRrP3KITPbzFPT3rCYCkIDJFHnOnn/UuHCT2si4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716832; c=relaxed/simple;
	bh=9m9qnAFjRPZmuEIFsmWAz+dfmmyZZkKzpyFeZwHGM8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwjK5mP7C42BzRG+Go2mZ+S5/gJT/Rer4F1G4tdpOgpsHRoKdwfCxwlpICNUJYjZMbEhKCtmMK7CUeZIcO7CbVM/TW1uSiKDrpGbqpRSMK+ULSnrl2en8siqYJon2DBQfmiiPDmKwoI49A9JDeafF/O82AOGd8RMM67e0bDn34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RruVZN3q; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RruVZN3q"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c24ae82de4so640330985a.1
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741716830; x=1742321630; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDEhMmQUxmOxo689QhSb5GTtdGxxmyO1TdT2sutKhIU=;
        b=RruVZN3q1igZmVobtexVTHggVPwfobbS14+Bm3WwFEqvMAkcYstfHMGWyq/qD7sEfj
         vBQcx7FXwkMLfZO5ovk0TewthSu6zE9ZZCr0CHGSJmDgJSDPNfSanHnRmeIRgQsfZ308
         Y1uudNgYFqPY1tp/v/CAVGlw9xBJTy4/7SVk5lrGxEUfJgxdZX1vJVvsF8WG3I/yNUPr
         R/h9b4l/c0dCl92iReeNulaRqovHfHTdBPadJCh/Ur60rLeCUGwLnas4CH551dTCZcFx
         CczmEEqRNPwM6RxuwQ2ajfpvn74C6pi5793UFUD4Kqt0B/XpwQwqWCdExsrkjF05gtnl
         XrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716830; x=1742321630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDEhMmQUxmOxo689QhSb5GTtdGxxmyO1TdT2sutKhIU=;
        b=EfFlerx2yesIt7dktPIkTpq5KsZW3Vyh/O8q71b8JiNsgzBLk1Vd6OVip4YQuqsLyQ
         PGmiIyiChbWnXXgZWa/tBjyQMb6Bes6VsgQ4A/D86QLLA5/cN30l7bZkQvDMVcn0tVh+
         TqrTox2k/glRf+l58qrktTmf+GKlqX7J8OlYQDBhguP0Y5MjoQzRHpsCPAYGOCU1id7j
         +TWHGiHLVCq3ug6DubAVST+o37uXcLJ/hPffdwBJya+shNL4PIG/X7Xm0NFxOdBrrRCD
         0IwQYfAB6vlBS4rUGwVz1tJm57tqKpY8pg1WT5Z2AaeWGMr7lr61xFlbXex9IHqEgOC+
         r5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyPcikGRhVMABZT/M4xGd4UXLwXCAer1GChEojwf44R1Dx9is3dtuESyeetTt9hxj78JiL5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqGa6xjHxOWcLSpJo5XdR3JU6Q7a66LcsK7N9CnU2enJze7l2C
	/c9mKsr9cBbuREF/COyoVmPR7KTr2wAKQZmodwWqOfBjAt4LAvVi
X-Gm-Gg: ASbGncvh/FmHhslExaLiZsWU3Ka5OgOj/NLEI3ADIthEDqZWDM2qY4kGpe5RwVKdRfu
	Af3zBIhNth4a9khSAIFr29fPXDk/THr/TysCCB4HAkdsCdyyPyeECrnjh5WjWmQQEnvwB/7kaM2
	ZasExdBvAqmtQkJ0FhOeOI9R7Atulb9GEmcgRAkU1tSIfjoJJF3gkQrF/NXsaN0oqoMbUp2KVRU
	kzsgGKsj6hNp8Ye7G42yZCtGzGgDbjYJ/zW2HqU44XWbMk6ApCtTNatDye1TCqk4QSs3Um5A3IB
	z31Wj9JFqNwpEpRQFbOil3FL4dyyOJ0nTrJRz2WIououXhXtRwyfRzFZSnpeXK5rHQ6Xc1RXNbd
	g7B1Ihr/wfUJ58H8rI39luoiaWAtPczQwTic=
X-Google-Smtp-Source: AGHT+IGV5qUTHMkgjUEPn2/eKhIVvHOorUKXCES2+LeLdAqsZ2U/IXaPlqtaVS6mO9jhfs6UoSNQZA==
X-Received: by 2002:a05:620a:24c5:b0:7c5:5ebc:392f with SMTP id af79cd13be357-7c55ebc39a6mr561247785a.0.1741716829592;
        Tue, 11 Mar 2025 11:13:49 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c55b4ab89esm231025685a.17.2025.03.11.11.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:13:49 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 55633120006E;
	Tue, 11 Mar 2025 14:13:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 11 Mar 2025 14:13:48 -0400
X-ME-Sender: <xms:XH3QZ6R6dlme6g7Si5SkgC8t4r6U4nUwYNlVmZLBGT66fXLYZIGnVg>
    <xme:XH3QZ_yrxxibrMYWi29hxXWQxENgZ6Q7SDQc3kwBgfDE6Isq6Qip8r0Yppb8QT9gy
    0xmddFzDon9EDAzyg>
X-ME-Received: <xmr:XH3QZ336OP3qiqC1URlPz1CqrIMayero0mrcd2EfAHDYRmyY-PNEFpAq3hE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvghiuggrse
    gtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtth
    hopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgvuggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:XH3QZ2BhbphbYZK7sD9DZqF2ODhUZ5dJU0uI_WxbwrlR54Cur3j96Q>
    <xmx:XH3QZzh6P1MioxmPF4eQk3IQV1yBy1F8Swe-dFJ2SF9xhbmzI_sWSA>
    <xmx:XH3QZyr2Wzbxs6MH3Zgzfpf9V2VdL0e7NZgy8P_fDl504ETVY9Lyvw>
    <xmx:XH3QZ2gdp5GF4QtBYta1qj1aY85Jd9HHhbn69y69ysm8lsUVn3DuLg>
    <xmx:XH3QZyTCI30w-PDqu9Wk4GpK6UAVgeiVtbArRsWdU9ER4cw_2m6VYV_k>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 14:13:47 -0400 (EDT)
Date: Tue, 11 Mar 2025 11:12:24 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v14 02/11] rust: add dma coherent allocator abstraction.
Message-ID: <Z9B9CNRatBtyAO8Q@boqun-archlinux>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311174930.2348813-3-abdiel.janulgue@gmail.com>

On Tue, Mar 11, 2025 at 07:47:58PM +0200, Abdiel Janulgue wrote:
[...]
> +    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
> +    /// validated beforehand.
> +    ///
> +    /// Public but hidden since it should only be used from [`dma_read`] macro.
> +    #[doc(hidden)]
> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
> +        // SAFETY: By the safety requirements field is valid.
> +        unsafe { field.read_volatile() }

I agree with Andreas that we should document the exception of usage on
{read,write}_volatile() here. How about:

When dealing with a potential race from a hardware or code outside
kernel (e.g. user-space program), we need that read and write on a valid
memory are not UBs. Currently {read,write}_volatile() are used for this,
and the rationale behind is that they should generate the same code as
READ_ONCE() and WRITE_ONCE() which kernel already relies on to avoid UBs
on data races. Note that the usage of {read,write}_volatile() is limited
to this particular case, they cannot be used to emit the UBs caused by
racing between two kernel functions nor do they provide atomicity.

Thoughts? One problem is that I don't know where to put this document
:-( Any suggestion?

Regards,
Boqun

> +    }
> +
> +    /// Writes a value to `field` and ensures that its type is [`AsBytes`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// This must be called from the [`dma_write`] macro which ensures that the `field` pointer is
> +    /// validated beforehand.
> +    ///
> +    /// Public but hidden since it should only be used from [`dma_write`] macro.
> +    #[doc(hidden)]
> +    pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: F) {
> +        // SAFETY: By the safety requirements field is valid.
> +        unsafe { field.write_volatile(val) }
> +    }
> +}
[...]
