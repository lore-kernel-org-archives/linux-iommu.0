Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8C29E110
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636725; cv=none; b=ooca8nU319+rPXPM3TIFjTfAj651mRk+QARRLkI+PieBp2y7kPWIs/jWenahLW0o5tTGVnMaQJK5ElWDLO7w+Y/S5ee7UTCJruMEWeDNFl/g3KeqMuf/YW6eyEGkb7FOxXbjxqA2sO3ak/fyRWeDCFm/1MxdPbdRRthg+Flly7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636725; c=relaxed/simple;
	bh=OCb3A1WFzV0w5ZbO/H402vOffTteqscuLBNvsEalcXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKK5eNIcgO/6BmKDpeI6zomMgERE7QvdYd+1GqBOW1YLBR0zmAZgPEqY6fL8aqD0a8M3RUQb5f1Vj3rQUajJow8t9V8RedavRbK/h52SVqWVw45b93LlPl4tSotnu+4P6cCiDaQVEzMq2kHMauAHphNK/aQ51SvOKJzRJZnA5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oMDmfLAJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oMDmfLAJ"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b2d6df99c5so223915685a.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 10:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767636722; x=1768241522; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNoRn5xn2oaDC2IYtqhOSxgeOL9snP+iopTS7Mlk9mY=;
        b=oMDmfLAJrnrgDsv02Ao9W4QQbd8euPAEO41viyqKPrdsvR0tg4E7YKvm4dn7XPtWzQ
         yxGlWVgmHWWOi6sE4NznAv1uFUhdkMWyYP96/N878bUPCWevr59gORjoe3ljIk3GNITj
         HB6QGLUbScazcujbKsXlcl6am9erCm1h0GCHLEDRIFTGn7v5I2XBXMZmaKJvM3nb1c1T
         qzCINHBM/EVZ1kd6qTTrHTE6wi2LOqPPGqe4rXBk1tUnzt7AWDDemuErpWFUhXLwbziu
         9hFBZ/3mgFRKjWtgnxnPM75TNnhSsgpAfgmV+QVBwLS93KZWJRgTdwvs4pJRmydcr9wB
         yGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767636722; x=1768241522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNoRn5xn2oaDC2IYtqhOSxgeOL9snP+iopTS7Mlk9mY=;
        b=ETp7UEEMZPa3W6jDdSb38ilvFb7zbfq6nP0eFP2YaZ0jb1Ev785d4dWPFsJy5Vi1r5
         KU5t/wen4xQyUdoi6/QsNe1nYe9GFkOp4hlQKOi8lyyQJTg6Og7zHUyj+ULor8nj2pEN
         EnKrBYAIRF10Jn0BbnBm1AwSILrXUyhBwluO8EbgBnHH2aHXoyFM2eUovCNZxkOhvByp
         ammyxThJiwIwVik5T3eVF7rto3FpWDR66V0ijuruJkUFDj9QiMDY5Lj3C/LEmdV1ZY+l
         aRV9IsG7VajsSSEEPIpE0eW0u2jBtCvSoF+ddjM8RzNplLzGk4qwclV+9q0qiHbcgXVf
         d5rw==
X-Forwarded-Encrypted: i=1; AJvYcCWs+waJbYD3L5WvVbS7FU0fEq6abILk2oiVeqGtI2nCFzDQ5QInsaxEkHQ2yYnDvXMX5KeAwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyimLxz6JXJ5YTARP5d2QD6m2w2QEAsmpOtKrNAud/zuAHWTKD6
	k7n3UhQ37Ibh6cfHrcy3XBNGh5lWerY8eMjPMdPN/AxPlcu130gHGNt/WWkUVTXSU+o=
X-Gm-Gg: AY/fxX5BnnC/Wpmaff0pUKTA4/0mLPvWsE/SD4SGnGGQThSKiUzn1sY50+t2miLcjA2
	mCRXWcayjMY1JR1TTsL2PSGCQqbzVcXZW4AF9Oa4YAN73+DdOrHFSHLhGDhy8JxrHmzwjMwh10C
	5hJUvekjR22YCNl4JxGzMk7kJeMVPIaEvkORUZx0cCpY/HCoDBgmp8h/b5FtuYtXV91dOk3H7fZ
	SNbKMDv3DqeWGeU89Kb0Vs7wa8UCnrud4hHg70zgLa3JyAKR3ObdhVo+RB2hbW4z21iH3u/g/Zb
	x1TSkNaW4PjHb1CQCGQHSIzK58jKSgS6pV5iuHhKavRtluoYOw7RetpacVYTBA/lzDTjdAW8asK
	jP1UP2OI7xyW7AP1WBw/3iyyn2IDAQsHy3Hg+EXkxOScGw1YaB2lJ/w9IlDP3Xpgvnnr+VsjSOQ
	Af7kJNuB7mp9NPpU+B1ieX+6EG/LS3HfxaUFAA25IUNan3psYBWRDn0lKgoWr9ZhD9x53yppU67
	yVT3Q==
X-Google-Smtp-Source: AGHT+IG3qj9OottVfFav2AogQtpKbbanpaAujF7w0LodjQe+bZqnAMPWgOXRjmlvmo/4kgErrL/wuw==
X-Received: by 2002:ac8:5f09:0:b0:4ff:519c:f478 with SMTP id d75a77b69052e-4ffa83bc599mr1094121cf.1.1767636722055;
        Mon, 05 Jan 2026 10:12:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa7056f18sm3363511cf.1.2026.01.05.10.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:12:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcp3g-00000001BhV-2dYQ;
	Mon, 05 Jan 2026 14:12:00 -0400
Date: Mon, 5 Jan 2026 14:12:00 -0400
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
Message-ID: <20260105181200.GH125261@ziepe.ca>
References: <20251227175728.4358-1-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227175728.4358-1-dmaluka@chromium.org>

On Sat, Dec 27, 2025 at 06:57:23PM +0100, Dmytro Maluka wrote:
> As discussed in [1], we don't currently prevent the compiler from
> reordering memory writes when updating context entries, which is
> potentially dangerous, as it may cause setting the present bit (i.e.
> enabling DMA translation for the given device) before finishing setting
> up other bits in the context entry (and thus creating a time window when
> a DMA from the device may result in an unpredicted behavior).
> 
> Fix this in the same way as how this is already addressed for PASID
> entries, i.e. by using READ_ONCE/WRITE_ONCE in the helpers used for
> setting individual bits in context entries, so that memory writes done
> by those helpers are ordered in relation to each other (plus, prevent
> load/store tearing and so on).
> 
> While at it, similarly paranoidally fix updating root entries as well:
> use WRITE_ONCE to make sure that the present bit is set atomically
> together with the context table address bits, not before them.

The PASID entries should not be manipulated 'livel' in a haphazard way
like this in the first place!

Like AMD and ARM build the new PASID entry on the stack and then it
should be copied to the DMA'able memory in a way that is consistent
with the HW's atomicity granual, paying attention not to 'tear' it.

This manipulate-in-place is just asking for trouble, and can never
support replace or full viommu requirements.. :\

So while it is perhaps an improvement to do this work, it would be
better to fix the root cause issue if someone has time..

Jason
