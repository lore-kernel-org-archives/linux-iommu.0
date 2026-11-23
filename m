Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445513;
	b=B1eP3ICBzzTbY1R4tSqgkQ6W3J0X0audpfwXvr9N3SU+obBqIigl5KIy15sXGVVwXLe6
	 NswMcNvYpS9DNmdLiPHpayRHfK1QS+AI5rhb/6aYLHzXWbjdtOjAV8xjmbG/oZweSkr/S
	 CvdtGybCQl0oaKoBZS4Mly+OPmfpzCWXEAw8p1wEHHJkSNsefuRSqdgNZIY6vmjklKeEe
	 OjAnZeqS8JKWm1T7RiuhLgnZVncx3s8mPZYfkP4o7UlWc9nbxjbgnZ3LAlIeck2l8Ylqd
	 qSnHNc6eGhXOK0dkqPWlEktsCUrtlgZRr8ZxqmekVHqOHeBt0u2gU4uZ1AuyhOnBE6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+GN86u7V5KEYiAKLCr5npZj411oise1PYGQMCZVT/c8=;
	b=OEDr4t/EHSP1hZoS6EUHawdfOgeGTMbk8rCBJg3gwrsCfZQy4Q9sbhFBBQwJX9Jt79h3
	 1itkZy4lpuQZNbEe9BkV81SQLogX8OgOMH4bgDahgor38phQPPHuRWqd70CfNGUHcP3NP
	 xZXTatWbTXKGFDAlXcS0a6yN1hpEZhd1Kc+CO/Ea+Cwh6cPddRFaPX5wPSz8zB7UkU25U
	 74s5hRYgCCxpr9P9OaJOtXvDEaWZA4YESw3etP+neol4l/ztQDGmxBKHOvcHo6bFJ12lU
	 Nem2jyxJedmaRn075ewZht0JzHWxgVBlEsU8VgZcdqbjWts9Dw0X7vngrkwOs9FVUEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VZZjMsN2;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069C606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 14:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D069C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VZZjMsN2
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-55c5b6584ceso25950631cf.2
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 06:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795445512; x=1796050312; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+GN86u7V5KEYiAKLCr5npZj411oise1PYGQMCZVT/c8=;
        b=VZZjMsN2YJHpoFA+/GAeuM4iZYbpjz/49ckK5DH+vKoUNNJHizeKEGLTZ1rjZIfeM1
         0IKgXq1Z29A+UQEmzWPrc/Ge7yJRCubdGpdskFAu0qjLk1vMdgZpQe3x7sfzWcldu9Qa
         /Zz3U3W/OtVi+orLD0MPfmKmum/TEowFluyJctJI+5cAaIacyeAmi1VlFKJad95u52je
         JgQU0b9kzIS6YJA1qLC3oHpx9MM0mHlRXQmbYOZvqm6lMhTrKo4JODosm1cilDwGf36q
         V+t9wbh/pgHccoaC0n3KUluwwbUZI9g/fRSFdyYKgd19x6pJNTx2WbicfBg1kYP7mGeE
         4B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445512; x=1796050312;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GN86u7V5KEYiAKLCr5npZj411oise1PYGQMCZVT/c8=;
        b=vczR5tDge1TQt4/GE8uO1DxXFWwVvde4MUMmI5tYWzuLVBk2zZGMfXD/2caIYOcGCD
         JDBes8Rr0DYbsP8H9GGYKG7tPzqZHZ8MX72YfycPazBWZJuKxrzPrvNQe/TB+TUxlweu
         tRrTuC5tYiJSVtSNeCuZ9njPyohROJGTU9E/2s6IBuNC6534nU8eFopjswrFm0iFMpi1
         MZWdoCNmm2TsNFr2vHQovHoq5RemXfDyLyLNN35uBfa7gYFo287FKeZWxsflkfw1c2VT
         DpnIkk7UAcXgdbNm0M+mKh4AMMybufjPg8kQ9ziXwfgwCuwE0giXugqq/cULOWwoI7pm
         9DjA==
X-Forwarded-Encrypted: i=1; AL+hErFmkZpyLakxAdl4w5BH/NXxadveSU8mduTq7W3pTndVROpy8GCzvNqDgZzryidL6UYSb2PaYA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9XkJ+H/S23KIgpP7h9bN0AFaNU8ncrESo+ys9LaM2Ead2sZj87
	9QFkZcqqx0lIlGZ05xlbidehGI/2hQPJu6m2GKJIN/VYswHELmfPRUwJEeJNuoP+Phw=
X-Gm-Gg: AZFdTZdgHm+6sQNJyXEDGN6paP7Beu3RqMSyDv+CiEtHzHKgorah52aMisBqZdP1NKZ
	TmOutBgYUj6DGlGsChCRZ/c63vzXRwnfXyBi/fxkG9g74eN/nxWCjWgJWHQtSpPthxN1HMuZlcG
	a2oSspgxB5w9GHH9Q18lFMoZDhvtjRAyCIrTSFvx4UzqrBbeaFKbuTJycV602Abmi8x66ObmI2u
	wRI91RHbHmJEYSxu8vftvO4omE85DLV5ibF9FpXb9FGNfE/PEVvvXBkvcSSXkFqGJ/FrdtSbaku
	NtzIkn72bUbdtBdqlR7D5j7RSY2y3tw28XvEy8Cr4Z/zGzZ1/a/LSBlUbbvZ0+HoQBhuwrurexL
	xUU0c7E7JAPj5QBv9C0oqcamkGhSe0A1kSg7Nj1Vai0A32G1ESB5oIOc7wU8GRmaP5sxyFr/V28
	RsbBwu2HcfuUvG6vdRfnF4Ix1QLd6EXRMHxHVqFom6lKzsRAMdbeU2EiNEYkfOGVdjP730i/bbJ
	FbkPSDkgQhTjTqIlT5TAyZrsYihgJ1jEAfyV7LY/2q6fb35Lb9NXmiRtmo3gy0WQGNwyFO7zvWV
	dXdY3CRYycwXAlJGAY3jpExx0TiJk4UVcZmgB4czbdppOtvYMITqVUW13CmbLOpW6lHCfHCLIk6
	0XM4=
X-Received: by 2002:ac8:5fc6:0:b0:55d:13c7:c232 with SMTP id d75a77b69052e-55d76a2daddmr203711001cf.51.1795445511671;
        Mon, 23 Nov 2026 06:51:51 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d784517casm100548991cf.3.2026.11.23.06.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:51:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVVOY-00000000qxm-1NQh;
	Mon, 23 Nov 2026 10:51:50 -0400
Date: Mon, 23 Nov 2026 10:51:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Qing Zhang <diasyzhangqing@gmail.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	Tal Zussman <tz2294@columbia.edu>, linux-kernel@vger.kernel.org,
	syzbot+fe84fc6a684e0beb86e2@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] iommu: Fix dev_iommu leak on mock fwspec initialization
 failure
Message-ID: <20261123145150.GA179082@ziepe.ca>
References: <6ae402bb.0c1d3ab6.e3d48.006d.GAE@google.com>
 <20261107140000.1-1-diasyzhangqing@gmail.com>
 <awQGCKf4UGKO1bjw@8bytes.org>
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
In-Reply-To: <awQGCKf4UGKO1bjw@8bytes.org>

On Mon, Nov 23, 2026 at 10:23:32AM +0100, Joerg Roedel (AMD) wrote:
> On Sat, Nov 07, 2026 at 10:00:00PM +0800, Qing Zhang wrote:
> >  drivers/iommu/iommu.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Applied, thanks.

I took the other version of this in the iommufd tree

https://patch.msgid.link/20261106-iommufd-folio-dirty-v2-1-3f0b0be58c4b@columbia.edu

Jason
