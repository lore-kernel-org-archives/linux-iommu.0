Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA21EB5FD
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589318; cv=none; b=seNLBf0bLM6Or1csaOJcgzOvFGHb5ExgUqNVBCcf5xh5kgjyqYDU2IzLXjqALzmO1sfOu8iYeIZ1pks0ch3DL72dx2+WtzsYJgscK1+CK1laQoAMqaLDfwHc1rIwmxLtv20zlofTPaJaE9v3v0QAvVtuiKd8Gv2+tkVBaPKEMAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589318; c=relaxed/simple;
	bh=h4sw0wQtemO1qmX+7Fh6qkhcSpjaUw8b8y2d1XyuhgA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvP/CLU4d1/0/MCJBPX7GjQDQii/HN7YTrdJOsCVD99t4Kg/qmlZG59zYbp5/Wl7s7m+7cPIyGpaH+C2c58uhH8nqj1COaNIzFG31tvu23xH/PRV6hN+Hxtz1GVvWWSA1yK/tywzizwM/JApZFGyUPnijEdaP3afANMGWf/Fc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJdJ3exd; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJdJ3exd"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e1b11859a7so9922186d6.1
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742589316; x=1743194116; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrBEkpu60bCrmGKM5/a3BWaVmBhrw8nH6PBXojnyxOY=;
        b=YJdJ3exdrfcicqTOIq5k7PZ4qeW8nsqh1VUBbFQqvR5p4FT4mRq7C8otND1kMk2FV6
         fVBOubNmrVrzXiEiJ+eiRfbfU6vGddwCBwHg6VK+Sb2Za+vQXQUF8RkRY9mlxtKQwgfo
         7FOgtlFDWvafIi8CuER5TZo8Ycc/DqDs1nJUWcF7GmGFKPhWSLCY0U6Ru7/1B0C0fDOJ
         1/evkxY83GTKWJch9GRrUkmotW43hFPzcDJRjELnfH6XXoOohsZKqBFF2ZiZvAx4zvbi
         5GCsP0xs6IIkaq7lc96yuwoH7inG5MXLmWaX7/l6vTJBP4HCOZ8c/Ax2afg3qytkZdEg
         DDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589316; x=1743194116;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrBEkpu60bCrmGKM5/a3BWaVmBhrw8nH6PBXojnyxOY=;
        b=WpUfvZh5GxKOmkGm7wr7+6EF8N3/I4RaqNLKw3CTio6wZ1efYxP48GHRqBbd2Mq1iu
         /Z2qGIE61grBkhYot93cnNZ0g/TzTcWumawhEE3I7OCwOnCCii3FwGWGrlUtWWV8/C3a
         arIXgipIJ3BmXZtmrukW+h1xc1BVus42pXdpK2K6059t2aMFlmW5ByKN7SeNAHuIwpcK
         KiTciWHJXQJOsgbqDsc6dmNJr7J0FBkxhWr08afOlSofVrDR2G7kxXL2jbZYPRU/VrLF
         l5sTjmGWvTVzNeI4Ou1p9AHB0iWYPI+HDsSR33Bn5hL2j8RjjIfF+kxExgWkpc6PRi4b
         LD9g==
X-Forwarded-Encrypted: i=1; AJvYcCUF9XCMjh9VqHT9adXntzcgSPo28u8aqJbTQYMsU+SAQlQjlFDrXHIHBdJFj6gF9oFcllsLKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzD4oc63gCil4CZN2ECd1MayjfQ1UB6Oyvdn845mUY0gwFoqw3W
	aAafUL1S7yVqUP4/+Zvlnk2Udi+dOIzr1M1zhmgYV4lC7GZeenHu
X-Gm-Gg: ASbGncvDA/S21iPDeyIQHUNrdOedwWMaFeCdwCSMd5EChc8d2rzwmig+QsONEnQGRSL
	yMGO4zOFNuJmN+g1qkg7yuHeWhShGIgXKBq9hMB+9DcJahGwxqyONxhhxOwGnt2d03hsQq8uuwH
	v8Vioau+2Rk+jA8OZhQwKj8ZqwU+rQx3PcWSPlYsSk+ngiWFWgNjFCghp9uqgsAbHqIgsa5sXkl
	xXz5HxNZyLZgRmhFV+Dmk2ixTxRIdQ9veRF+a5rj6dA8d+jherOCfLmQxXN9CUr83HYBZdodEFV
	A7g+A6f46qzXi91Aio14aDNWHuTIU4VL1fH38Q4sUxueuezue/HTaLZCXo4X19lfg0zHuqE3D+j
	OBnrxRpjvhsX5Di+Du1hCzrEsZfjXq/M6Bt8=
X-Google-Smtp-Source: AGHT+IFteF0LVW82XPr7Bi8OGspyWiFAmnMcFic+fmEubgaNnMeFcMexlPO0YoI5x1XPcLecagGtQg==
X-Received: by 2002:ad4:5c82:0:b0:6e8:9e9c:d212 with SMTP id 6a1803df08f44-6eb3f1a40f3mr78258286d6.0.1742589315386;
        Fri, 21 Mar 2025 13:35:15 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efdc1b1sm14812276d6.110.2025.03.21.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:35:14 -0700 (PDT)
Message-ID: <67ddcd82.050a0220.28d3cb.7630@mx.google.com>
X-Google-Original-Message-ID: <Z93NgKC6Flr_AiqP@winterfell.>
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3FE561200043;
	Fri, 21 Mar 2025 16:35:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Mar 2025 16:35:14 -0400
X-ME-Sender: <xms:gs3dZxr_WutHJLxmKOcGxMkfRkF3VRvjodgQ0tfJs1tTUNcol1qqvw>
    <xme:gs3dZzoW3vYEcqPS7g_TEKy8k9wg9QQ4DmXedEmCJWJeC2TUc6SIexwgtr4yVnpOu
    eq0PyYxLBJTbNXzrA>
X-ME-Received: <xmr:gs3dZ-PqX2UD6oK6m9diyOV53s4O409aSAl7-Rn8lcELBBdbOfXj0ObM1jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeeuffffvefhleduvdevuddtudeivdeiiedv
    ffeigeethffgveffgfeltdfhveekueenucffohhmrghinheptghpuhgprgguughrshdrrg
    hsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoheprggsughivghlrdhjrghn
    uhhlghhuvgesghhmrghilhdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinh
    hugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrrghl
    mhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegurghkrheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhm
    pdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhho
    rhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:gs3dZ85gBv_70Qyz2opHiafrm8KOhFcKR3npaZ0eewRTaAYIT5G3Mg>
    <xmx:gs3dZw4Q3G5MkzG8E4R3SLd1nbU2pOjBAvZ9UERrUA5kL1Yk0X4BAg>
    <xmx:gs3dZ0gG7lv4g3f06ZBYIOjPwSZW6qoj5Pvhd7o_Wot3irAQJ3qMKg>
    <xmx:gs3dZy7u-qqDRu5ujOW0pnbZ6IvQAvuXZWf5JMfUSjhBlXeMp3eHFw>
    <xmx:gs3dZ3KK7b24sapOURPO6HZMIF0hW30evzUi-q-02twgKBq66BwlMCTN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 16:35:13 -0400 (EDT)
Date: Fri, 21 Mar 2025 13:35:12 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
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
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-3-abdiel.janulgue@gmail.com>
 <20250321182539.GP126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321182539.GP126678@ziepe.ca>

On Fri, Mar 21, 2025 at 03:25:39PM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 11, 2025 at 07:47:58PM +0200, Abdiel Janulgue wrote:
> > +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
> > +    dev: ARef<Device>,
> > +    dma_handle: bindings::dma_addr_t,
> > +    count: usize,
> > +    cpu_addr: *mut T,
> > +    dma_attrs: Attrs,
> > +}
> 
> I'd like to point out how memory wasteful this is from what real
> drivers are doing today when they use the coherent API. Let's compare
> against SMMUv3's use for the CD table..
> 
> This would be the code in arm_smmu_alloc_cd_ptr()
> 
> It is making a 2 level radix tree.
> 
> The cpu_addr is stored in a linear array of pointers:
> 
> 			struct arm_smmu_cdtab_l2 **l2ptrs;
> 
> The dma_addr is encoded into the HW data structure itself:
> 
> 		arm_smmu_write_cd_l1_desc(&cd_table->l2.l1tab[idx],
> 						  l2ptr_dma);
> 
> The size of the allocation is fixed size:
> 			*l2ptr = dma_alloc_coherent(smmu->dev, sizeof(**l2ptr),
>                                                                 ^^^^^^^^^^^^
> 						    &l2ptr_dma, GFP_KERNEL);
> 
> It doesn't need a struct device pointer or reference because this uses
> the usual kernel 'fence' reasoning for destruction.
> 
> It doesn't even use dma_attrs. (why is this in a long term struct?)
> 
> So, smmu manages to do this with a single array of 8 bytes/entry to shadow
> the CPU pointer, and recovers the dma_addr from the HW data structure:
> 
> 			dma_free_coherent(smmu->dev,
> 					  sizeof(*cd_table->l2.l2ptrs[i]),
> 					  cd_table->l2.l2ptrs[i],
> 					  arm_smmu_cd_l1_get_desc(&cd_table->l2.l1tab[i]));
> 
> Basically, it was designed to be very memory efficient.
> 
> If we imagine driving the same HW in rust the array storing the CPU
> pointer would have to expand to 40 bytes/entry to hold every
> CoherentAllocation. This means rust would need a new high order memory
> allocation to hold the CoherentAllocation memory array!
> 

Thanks for the example, it seems to me that your case needs a

    pub struct CoherentAllocationVec<T: AsBytes + FromBytes> {
        dev: ARef<Device>,
        cpu_addrs: KVec<(*mut T, bindings::dma_addr_t)>,
        dma_attrs: Attrs,
    }

of course, we can get rid of `bindings::dma_addr_t` if there is a
method:

    impl<T: ...> CoherentAllocationVec<T> {
        pub fn get_dma_handle(&self, idx: usize) -> bindings::dma_addr_t { 
	    ...
	    // probably only availabe for a particular T or Vec.
	}
    }

    // and drop of `CoherentAllocationVec` will be:

    impl<T: ...> Drop for CoherentAllocationVec<T> {
        fn drop(&mut self) {
            for (i, cpu_addr) in self.cpu_addrs.as_slice().iter().enumerate() {
	    	dma_free_coherent_attr(self.dev.as_raw(),
		                       core::mem::size_of::<T>(),
				       cpu_addr,
				       self.get_dma_handle(i),
				       self.attrs);
	    }
	    ...
	}
    }

Then we have:

    pub struct CoherentAllocationVec<T: AsBytes + FromBytes> {
        dev: ARef<Device>,
        cpu_addrs: KVec<*mut T>,
        dma_attrs: Attrs,
    }

And we can make `dma_attrs` a const of the type:

    pub struct CoherentAllocationVec<T: AsBytes + FromBytes, const ATTRS: Attrs = Attrs(0)> {
        dev: ARef<Device>,
        cpu_addr: KVec<*mut T>,
    }

As for getting rid of the `dev` pointer, the struct arm_smmu_device has
a pointer to struct device as well, so it's all about how to organize
the fields, at very least, you could do:

    pub struct ArmSmmuDevice {
        // avoid using an ARef<Device> here since we already has it in
	// cdtable.

        cdtable: CoherentAllocationVec<arm_smmu_cdtab_l2>,
	...,
    }

and whenever you need to get a pointer/reference to the device, you can
get it from:

    .cdtable.dev

it may not be the best organization of the fields, but we will see the
real Rust use for a better design.

Regards,
Boqun

> Jason
