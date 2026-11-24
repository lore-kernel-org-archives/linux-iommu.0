Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542011;
	b=C6ydjbqqRSY/573Pcrs9w/z2cTWMdAXaCwQhXcLuT7jjksmAeEY/B44PI0X7fgxfttR4
	 SCfOdRIDSxoUABfi/y84mdDNCHL/GZ5U7rpj4PnWFhAggFlsJP/GCXu43LAHxOW5hhqT2
	 chOuWqwVmg18WLl2pkvEAQvWS0TXEb2atfaObEPGvl1IroPtF6txJ+lL4O+/lKH/KBBBq
	 e3v55pAKKGRldLDFWHvEnF0pUhpCKnXgZkZEGUX6VwPJQ6zdPs5tLTISocQIgysNB/TIY
	 BdLukMTi4mazKIGfKihpCvT7geBkLN2q0dleNRKdR9RI/2pQxz8QQz/Dw8DhC9nuEPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=miqMkDmR7uPJ+RMX/Y388NkwoGQvWXSbN62ZuELGneA=;
	b=Ko/+0oRLP9cYagZ4PcO/5a1Ze7RmW5Uqd0yHWFKfjvcidFnLv4DseDC3/IWG2Hvp8JKK
	 jQDZqE48469rVrUvUQx+tZdV7WO+5CMEfHNL7Z23mx2+TsExzDm2vyG1Jtam0WRFwTwuB
	 8nfrdAasnilamHt1UTB9zVfqMqV1pNj3Yqj2l+Ece6xGd/LNKeFwDVBuw0zu8sEttHaMt
	 8v8L15E+/OuCwko3/v1MiugHv031/bbd2FvLnf3hESziEf3SKk5n1zMAbEh8Pl4i/kjqb
	 CGAY6OFJt+YQsBLQEoZ7/jxCmq+54lMMO1On26tr7QLMz7ascBWrdunzXlWpwde8LbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m0Oryv5Y;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55566606A321
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 17:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55566606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m0Oryv5Y
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f048bc09d7so212505ad.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795542011; x=1796146811; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=miqMkDmR7uPJ+RMX/Y388NkwoGQvWXSbN62ZuELGneA=;
        b=m0Oryv5Y+/rU9fcjsg44A7vr6HalyxIiHRLQ5LY3M6Owgp6e+xQbD0TY6RDhn70hYh
         oYX2kCFwmLTW2EHEdLsieeWK2BVGIRvvjRUTXSMwkJqiPz3F5+t1GV1EstVTmmLe7oWf
         GycYVfYbDr5uoNA/neuAFkT5+tgKKVi3Hoa17Z4T+LH8YpvtiD27wXE432jO3D3NqDUI
         AqUfMlV7fZfL+zWe7DnCNGmGjLnmOCSZnpPudRFQdWmDDgBnx6GCFce6ZDGXkxM5fGuM
         79eTPX+oX5veb+8AC2ti1MPgoFy86QByyqYCpTUQ4O2zp9F/hDsjuTBnU5U3y8/iCgjF
         2H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542011; x=1796146811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miqMkDmR7uPJ+RMX/Y388NkwoGQvWXSbN62ZuELGneA=;
        b=XojkYJUWiHgiL9LjqIYOjX3nJGSpbpW/kpKCRNG34+OaD6saduaUkP1zE6ClzkwF9H
         6rkff03yLblWFPjBgh2YHOZTqp0BLaoo3fiqz5BD48lp/akSbqI0RjOBM/t2dTEPAj6Y
         UWfANEKQMW2MLsflP4SJq0FoY+8sMk8eOdxrOl14Qu/OAwldLOegyifePHxsRE99otnO
         MQSGO2njMkulONdC7oOAzch/9YHi0qaMNfMe/EQPFNskWioYzOBsEYNneNE6yupDASeD
         ESBGfgCIgN/DXtNB4Osw7oJwl//JPdxoW2R4RKLrwKjiHcFT839ezpYl+cZXSZ8L/rmA
         ZRqw==
X-Forwarded-Encrypted: i=1; AL+hErGIralg9RpAAMlksykBCDYzJPTfwWS2i51bTAEuwevyNP8j/0qCpg/ME4aJLUoinyU1Z7/vOA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8H4Zv+KaJHwW9DkWKniZHo/gMezNb/oc4etdMYFr0071esLNlA
	3tw0Kd3inlJnsLUcjgXCw8aeJPlhqvFVO91PBFvi9Eu0+zgKBLuhm+YfJaxwZKuS4A==
X-Gm-Gg: AZFdTZeE7Vz4Xj+dt+jc+SQK3DvS1jvj2hq++MW52cVSISaZKcyY7nAdFz9hP7EsMMn
	7MJTFCm9woFZFsMjU88RE+qH8fbEqjK5AJG05zbc3dLPA01esY5aIroEtkPiSdqBVox4gs26zvX
	/mGgbunRk0F68gLVRy08E9ENKG4G1yidKNNxHjrzqyU2w2DDl2/SjbocGUw8O8IALLhFSvy41p6
	nYsx1L1pTSUm5uzO1H43mpJJTzpSCBH0GA+MzcosBryuiKF6CjN5P1MnTB4hkiAQlHo66kTIsiv
	kB28C37AuoTsEfvmKstOnqX0fPx91id1D/iR3UrI2W5OEzUd2iOqTw/t1FiGNJP1qD+kh6WtQPB
	7ywaKe+nvZK0POBNCCRGLgAFzgNIllJXj0ZR1tY3leXsjn23nqaZh9XAwEGeYWNX+9mOKGZwMHt
	/jVUE7yNKdsc4olrlZyi7hD07BTXmvvLVmUjprrqj+M8Yf3C7Cxr8RKoLnSeR3YH5HOqAtf7Hvi
	EsoTxs9m3BPWJpfDgfwZjTApitcYVShkD6Ft9LhvfWwlng2X/qdKYwa5pZPkNAlnbBHQ1AIH79D
	UEDgGdtf1kPzrHW5aLn4A93t1DGfLMFdZ1Ew0JP2EPihnl053C+pCCzFwAHbGPpvqQC/N4aGFhf
	ryi8wjQ/6BICRYYNM2aq7bQ==
X-Received: by 2002:a17:903:19e3:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2f066708a17mr12958045ad.15.1795542010063;
        Tue, 24 Nov 2026 09:40:10 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f122548sm72700355ad.66.2026.11.24.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:40:09 -0800 (PST)
Date: Tue, 24 Nov 2026 17:40:05 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v8 05/18] iommu: Implement IOMMU domain preservation
Message-ID: <awXL2cLfpbowuO0m@google.com>
References: <20261123044949.3610702-1-skhawaja@google.com>
 <20261123044949.3610702-6-skhawaja@google.com>
 <ngjof224lsvn3aamehaaowcsk6lyrypjw7uidwwbxxpzot53t6@462wqwsp65bw>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ngjof224lsvn3aamehaaowcsk6lyrypjw7uidwwbxxpzot53t6@462wqwsp65bw>

On Tue, Nov 24, 2026 at 05:23:18AM +0000, Ankit Soni wrote:
>On Mon, Nov 23, 2026 at 04:49:36AM +0000, Samiullah Khawaja wrote:
>> Add IOMMU domain preserve and unpreserve APIs that can be used to
>> preserve an IOMMU domain across liveupdate. These APIs use the iommupt
>> preserve and unpreserve ops of the domain to perform the respective live
>> update operations.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> Reviewed-by: Pranjal Shrivastava <praan@google.com>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>
>Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Thanks,
Sami
