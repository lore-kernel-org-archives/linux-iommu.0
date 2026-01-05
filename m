Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFED26F28A
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767640454; cv=none; b=NAuQtqIrcf/tgFMnB93sKGuRvQ7vylmD+YAY7Jpjj/DOZ+XCHSRV+JFsue6AuGt4AQj7Bi0HT8LPDKukiYOed5w9sUu3YaYH1vi0KExe8zbkxK7rtBz9gCq8oJNp5LGmRdxGa6wjAoFHHhfQzCSHEeqPCUQcuqH3uH75SKX/HdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767640454; c=relaxed/simple;
	bh=ul2ueOWD9ZAtL/qYauZWtLZooVV3kGhrh3pRiOfLxCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYzFSQeh7BylkKVDpBBr99bezF1YFBUvXy16gzEY8BKmZ5zVh+mDckGvUsHSqxfjjZ2m6+BoHl+HJwoMTZ6roYgXgJtS2xscpWANYCAD2gVk9OrSSc+KtUE5v8/KvjCf9EolwPbUmvOZCXWYakLsRNkKMztJPt0dVmQeDEhsBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gKnpYRSF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gKnpYRSF"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a3d2f3299so2075626d6.2
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767640451; x=1768245251; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcjnxUC4GelYtzVMvZRDcHlwB9IPTGzncUyDq2R5G4Y=;
        b=gKnpYRSFbVjMxMwgBtVQRcIR12ZHb3jgsnOtP6i8h31BzgaUzdsrrMXCOOW5M/9vz6
         NemTSE46unCd+E8iv/TPbelb1BvDdF6AWMWJuDMZZaqczy9XLyqP82jpMJ7go1TH0s8q
         yEi+AcRFhvpdsOIlNdR5CXDrRxt5xXPO/NkaqpISHa/zQdX+DMgio6szsf8xZCJLEdyr
         cgb1HfSXoAOuXoDABmqicS0Fj8iOiyGRfmI/V+rQlqa4qfP2bcOvlD/mLOxbh0m7Iznp
         0grosaMl+WB6BvejKKQ+nIw9bthBY5ZIanOEMs/YQ22RpEbrOjt6gG9X9dsCxcmqtCAV
         l8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767640451; x=1768245251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcjnxUC4GelYtzVMvZRDcHlwB9IPTGzncUyDq2R5G4Y=;
        b=F8S7K9yWp7P1HkzI5qMy1VCobbQEJNXqgMTaghdipWLGwDs33jhOPYUD5fggYpDiKr
         Q9yGxNoJa0IC8RZ+jBR9gsWzMCEo1gF3uH55BuL1cecTZ8XONpWj+OeSaqalz6ri8TbV
         digDHUoy9nmKexYRFxkgf1JWkTP8ln1uJ6Q542H/otCYrVdSgctAFcKHCfhRUkEAHd0P
         ec+j+P/6+mTk0RzeY/uCtyuW7GuScimPkWhLy6G4PuypYkYP1ZjAd3y4YqOn8p0F758I
         G7f1u+qyaczRWiA8Lh16D4tDb9q+/CCrE7pqandbJMfRvHOtTjVmDjYU1ZFECCuActCZ
         jhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9nmBZ5FAD4fQ/Uq8k4jwkkMfAdHL4C3YOYgYMCWvZEejMHJKOrER7kPh1Z600t1DQhOHEfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZl2Ek0s6798tmAQGLBEZMW83+6MZc1kBOX+1OTCzRxoXuYEBO
	B40g0Kiv3JfhMhtI0goYGlPaWFvv04upwiJiH4urTBHgk8LpTY8RMk07MyP3RDHE0Zs=
X-Gm-Gg: AY/fxX7tB0a0NVr2DskGmxzxhgm66dV89hmrlYBYRSrlCygk8RPyz83hYz8oLQmQC06
	62N3CVXOVfUXMkv9aQMrkaOvdm9h5gFqJq2yLBEhqBJGFB5VdZL/SMDACf8FpEG3z99lzWtaqmx
	g8LqwBX16JdUFYKNvWp4zC0NnuAqTky5ZWbyr5DnigYnyeT4p7WmZpwVI+hg/WIROMLFa+EB5N4
	DrrYByIhpI54ytsBhjq41pnbY36kmCvRbbr6gK303SFR9sgS1e/xkRWnb+GDSeSYiC7OLS/NKOo
	puJqmGd773xqoluL6tSXQQubRgt3L2j9AZdrHt1dyFXWhgC5jymsfMegGs7yCxTS9snB33cR2vK
	fqrgoFNfIFz0bKqPjlvtlY/8L7h9DSd+7H+9XJhz7BADgpYmfh6w+fS6JL6w8Jrk5wUi3Oe4FQI
	fmgPd2S3VUnom9NCrxgcqBd7tVSARW9ZiXKVFDkHVkYYrahJirSKtUWv6H8NiNWOo63u0=
X-Google-Smtp-Source: AGHT+IGGz+r7GSwottkbn37VK1UpazcbcuA+jtTfQHMfUUK0yeBPZEuAwBQdyVOFBVWI6v+xu6TU0w==
X-Received: by 2002:a05:6214:2e45:b0:890:738f:b171 with SMTP id 6a1803df08f44-89075f52b42mr8572166d6.71.1767640451341;
        Mon, 05 Jan 2026 11:14:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89075557adesm4736926d6.40.2026.01.05.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 11:14:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcq1q-00000001Cir-1EgS;
	Mon, 05 Jan 2026 15:14:10 -0400
Date: Mon, 5 Jan 2026 15:14:10 -0400
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
Message-ID: <20260105191410.GJ125261@ziepe.ca>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
 <aVwI_SHHGPl0xndu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVwI_SHHGPl0xndu@google.com>

On Mon, Jan 05, 2026 at 07:54:53PM +0100, Dmytro Maluka wrote:
> > Like AMD and ARM build the new PASID entry on the stack and then it
> > should be copied to the DMA'able memory in a way that is consistent
> > with the HW's atomicity granual, paying attention not to 'tear' it.
> 
> As I understand, the "consistent with the HW's atomicity granual, paying
> attention not to 'tear' it" part is already fulfilled for PASID entries
> (and with this series, for context entries as well):
> 
> static inline void pasid_set_bits(u64 *ptr, u64 mask, u64 bits)
> {
> 	u64 old;
> 
> 	old = READ_ONCE(*ptr);
> 	WRITE_ONCE(*ptr, (old & ~mask) | bits);
> }
> 
> I've been assuming it's ok to manipulate other bits in place as long as
> we take care to only do that while the present bit it cleared (i.e.
> while the entry is ignored by hardware)?

If these are only done while non-present then the only issue is
missing a barrier before setting present, that should be a one line
patch, no?

> So IIUC the only problem with this approach is the redundancy: we do
> this READ_ONCE+WRITE_ONCE for each invididual field in a PASID entry.

You don't need READ_ONCE if there isn't another thread concurrently
writing, and WRITE_ONCE is pointless if the HW is promising not to
read it due to non-present.

> So while I agree it would be more more natural to build whole entries,
> and the existing way looks strange and not the most efficient, I'm
> wondering if it is causing any actual correctness issues (apart from
> those addressed by this series).

It prevents doing the replace operation, which is a correctness issue
for VMs.

Jason
