Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836963;
	b=aBLfeK6qPGaf9Zs7BWqIIWYPZ6nwyrDPyWf0jCEXHmT1HxeZwJ1YQrtoOa/r7209wGXz
	 YIk7ScNxaVWcXi2yQB4ysR9iDUhI4L7TOa/x9RfSgj8CMPfDko0IZJg9v0W3UPkRQClhI
	 HO98lhI0DLiag3FZf481BOvUjFpkfu1oDek1n8SVmYHqQdUVjABYUIhz+THas+5Olc+7e
	 jJ4gr3O8XjyzX0EqsRRiI61ecRlNDoE30eOhpcpemc9MmZbK6Y5rinH7/79zgej+XpBAx
	 Gc8C7IE6gC3wTHm+MxwqypoexVDbTEhhX2/e5LXBOiHgcmBslUIqY8powL0Z93iQPMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HsBOAvHt4DPYJf9JK1qI+m0zGVz1UopZeMnslAsrQqc=;
	b=Na/S09OpCHS0OdRniKsfmgW+4xtB0kb7kuJzipgLrKRO0KbtI2y8NEWTO+4LoZBtTiO0
	 KclsLu4wFArBjT4vf5vwXbM5UIIof+oK5OdwwI8l1HUdV0fhU+QM9ZBVCb8NEm9gh4Odk
	 zz7TuF2iBg/+0Z3fD6T24N8+iqyD8BcYpwWvGVRgSWjXoB1EwYuEKf3omwAW+AUlnT85W
	 USaMjHQdgvL/rbhZIZhRDUnLggtMbddQnK5kUY7h3YJWU1RdMwoSkc2S4+DrwjqZ3dKkO
	 evSr2JQuMI7iUc0n7If9QOcRQLwZhuqvcqsgiO53ILhgvAstR66OxJAkXySI266OsWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hZylgQir;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D8C606A89C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12D8C606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hZylgQir
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-94937a33cfbso379506385a.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 05:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794836962; x=1795441762; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HsBOAvHt4DPYJf9JK1qI+m0zGVz1UopZeMnslAsrQqc=;
        b=hZylgQir7nUTGMwWgJ9fWXyWTyEkkrjfmb0m9SCS3xsWAFaTJJftU2v712JJKiKv17
         Rsb+TFvUU92/rUCYTAaTiVfwYpOwIdwqJA+cFdmLvfDLtA4MuIIkr1sgxJvt3DoYjyVw
         83+UeG8fPcOguW5/BRYZy36y8DJMM/0bnHyWX41TQlCAT45Qj5D5NIz7WjkrP+eJaVQr
         KBanjcio+NPswVEK1xx+5tj6uHdDDX5eZ4K119+TbhRQX3xSIMehhkKPKOjth2S6Xq7A
         cL/r4fbDKB6pugr+Zu7Iirru2LH2HqvQa+EQXSTfHCPaXPO9hRHIgomOd2bHAdsM5bGF
         oJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836962; x=1795441762;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HsBOAvHt4DPYJf9JK1qI+m0zGVz1UopZeMnslAsrQqc=;
        b=JlCwgooqi9IMisN8Oideimxhhv5G1LcZNJoS//KGEog+deNxCsEtzDS5xIYhEefos1
         YCgAgvaZVmr9kQkt7R7k/TLRXVHvJ+SqfHbCzWHwVdv579aRoAKkQLqZyDcb9W+GYsuS
         nME5iw+ZdbwH8V0Tj52RX9qzTKK5/ezARb9dq/a3PKWkIlpsBxzDzdmyPssdvzVy+Hx8
         7g+wGj8JH417g3ezTM3wcQmzWdxOueM251x7eC05yWZmXjku4vw3UBHkziWflxw6rubl
         8pJmqtcuLNnAPtwsJ55+/ZQ2ADw5qBrYVegap2/2fTQBn04DiXuTaQ65jSuJ4uhv0a1k
         G8zA==
X-Forwarded-Encrypted: i=1; AL+hErFH/quSaOWG7liaSf853eSjowBW0Yvu+T3sebqytCxcRvxHBYuxrjcKRMcr7Sbo0AfpcqeZdw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+1/HxKb2h6Na9RLZ8ujraylybRqajAlK7MApkBFc7ps3fBphjC
	EJq46Qp2vgJCGCXgnCwI49UKkbK+MvIWm88Z/tWYYxSg8dcUdin6tu3qIPMPY4Qrkx8=
X-Gm-Gg: AYBFou3GAh57ABMjQlX+roegMXDLJmBFiKs7b4wAOlXZ3nmDvzq4fRXfXcUMz7iMQ77
	W98+JlOooEUWsnityXlmzjsKS4gyZ+pT4+xLET8h5r7ykQZ5Kk9fRHaZXdicbh3C0USV9rOdiF7
	GYHunOgS6OAT5wvGopAQs2Q5hQU8FsWiV5CfAg/1C1UoM57qY5hQLSzSkHvoYBABjxNpeGMYmmT
	NsKDXrfCCYKVHDuLpPQAPT8tnEHqAcXSByQrtfvmJjVyRsi/t13ld9a+7oYI4lkDHrgvilL547i
	4U+eMvSfmwsT2B1/RPIT9RZBwTatyig4qHg1g81Qk/v3JSEB9WPfmMlzR5FeSsYQ1PTEEEndlWQ
	52Uocyy0RWwfSRlbuk/q7N1a94bRfzbAySRIsXECx0iUTnCrWONsGL5SNknCka1ZBt3zsc14mpF
	6JHRBMnw6+Q2NlWdbjJZOkiXXxwyh4Gymagmob0P9VIpqp+QgXT3xqWl3Rz8xmfbmUl7jqNyDGi
	Mn1H8j6PCTN/7nbX6SeuR48xp8VPbsOqdMj8H/lQOZIR9EF1lKPDQakAF9cpAe8Btt5Yr2byHc5
	K5O/8g==
X-Received: by 2002:a05:620a:4155:b0:947:7691:731c with SMTP id af79cd13be357-9494bccb8d1mr1678517685a.65.1794836961959;
        Mon, 16 Nov 2026 05:49:21 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9496bfb7fa0sm512919585a.34.2026.11.16.05.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:49:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSx5E-00000009OXj-2xNY;
	Mon, 16 Nov 2026 09:49:20 -0400
Date: Mon, 16 Nov 2026 09:49:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
Subject: Re: [PATCH] iommufd: reject mapping an iommufd file into an IOAS
Message-ID: <20261116134920.GK2532299@ziepe.ca>
References: <20261112105945.285526-1-xujiahao@cmss.chinamobile.com>
 <20261114004101.GE2532299@ziepe.ca>
 <20261116113808.560717-1-xujiahao@cmss.chinamobile.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116113808.560717-1-xujiahao@cmss.chinamobile.com>

On Mon, Nov 16, 2026 at 11:38:08AM +0800, Jiahao Xu wrote:
> Agreed -- the blocklist is the wrong direction.  A vfio device fd bound to
> this iommufd holds an iommufd_ctx reference of its own, so it reaches the
> same cycle, and any other fd type that can own an iommufd_ctx would too.
> 
> The reversal looks doable with what mm already enforces.  memfd_pin_folios()
> accepts only these two kinds of file:
> 
> 	if (!shmem_file(memfd) && !is_file_hugepages(memfd))
> 		return -EINVAL;

And how do you let dmabuf go through?

Jason
