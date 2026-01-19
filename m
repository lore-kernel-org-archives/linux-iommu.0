Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB201311C06
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839868; cv=none; b=QsCp52478A0aIB68rMxRjnoDgDOS0pOVFbUaNSHWRESz/xSBLNCcV4Gsr90tRQL/u/iOVIWv2pE+ai82+EfC8W6k5nH+l1xXgo5pTWhBugX0bQAGsqBjhjaIr9e+AaO6bKIC7fZJules0IKVDrywgyIFu72YDvTPeKLbGLDWr/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839868; c=relaxed/simple;
	bh=y4swwYbPI6raB2hvkPRsghll5RR/RHHzFup3OVrjU1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFnL5xfCr7MY4xdRV/xyLsmzxzG0B4nDkdCkwH538LWo7R4Tv6eAgdpfJ56lr6ufjtGkpZ6pk6Qo0BRJMTLWPZXU7/SrgRvpaGQ1rKgKL+0Sd/9ffmJWvBWNVGlXGp42tsDAP9ucn5076nwIONQlasn+8PAkBAnxcecJxWKIJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CislqUfv; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CislqUfv"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c5386f1c9fso687811185a.1
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768839866; x=1769444666; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCRrpohPCspJo8o5qWVDG1aTKo63AMTSXJRpwyKl02I=;
        b=CislqUfv34gE7OcRNtPj3BcVW6YbJ1IahbGjSqddNvqzBlUmZ2AZf+rf6oCmEF+R1e
         Bgh/TR/vsdEhb7HgVAa4gWL5DhQpJRGGuJkB/mmiWbVJbH+WbjWqbGWe6PipWj46ktCo
         Kocd3I7h43y+c2lv5iT4RBi686qNiJhhZU2GA3fG99/WYSqKWZgZ6TcD2OyBgndKLRsB
         qIFyn6/SD8z9ablKh21TYjygyLKtn2fp6+sSqKL4eD8KTgLUnLCTL+qANUWWgPaQfSYL
         872+zOrwW0S8mviwVD2eBh6J+DtBqPwIZ9nIxMP+95yiYFKC0fmXCYgw2X7p+oBG5pDD
         775A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768839866; x=1769444666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCRrpohPCspJo8o5qWVDG1aTKo63AMTSXJRpwyKl02I=;
        b=IwIHF+hYzyZ9sp/Y799O6pCW0OBwK8PDDDn7Rhk13/Uoy+63C0uuwVvpQxlwn9Al+n
         UOLqTFI9mhgewM8Zt2/FmY1OYAcB4TUCmd3EDZFuf+UoEhJM7NJS71e/jLTPjVYCVQDm
         dlrbaRn4Stx1vLJ9D0eGqkJUxk/mmNuei4HVG6eU/2QJPA6VuAijAmjBNI/637tRyYiw
         f2HzMYHctCznmdeJwFcibF9ppp85PoVpiiFA/vLNM5RCehQKfPzVvRdfQ5mwpME3xMpR
         0ToiiXrkbfs5UIA+HKDR7+8PpEaRe/OV/tAP9+DO6SSrJH4pPZdRFEDOnsAmbKEi5jrx
         hsrg==
X-Forwarded-Encrypted: i=1; AJvYcCXcFuuntW7dO3AzKHK2erZh7uC+ibxbFZrns3L6V+5MZys4+KlEZpdIoEadvv0K8R5j9ulZcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpUOZHn3I6i2/Obyf7/y0ox7TSdY4BQFGjiRhn5WhTYp9N+ieU
	Z0FbVKnNjN1YwGFDCQppvZfTfCfCDg4LkJuZ4vYlSFwqx7K8e0QNacGzTby9Bmd8u+Y=
X-Gm-Gg: AY/fxX50TxWfCvxzaT/ITfSjbEYiqsWH3ECnxFh7K26LYtiWCtUMKgG2R+Ze6zMYxwJ
	CfenSUkVgmFUpq5K3nd0wLKUXRlnCCY+42fiVOyHUGzSX8feQ+IeFIK4HaTNDZK2VI8FLaTENiF
	J5xvGfLTRmsLyPZtsdiMEW3JFXubXK6tjQorEiryBp27o10+DObfOfGtMMhyQwTxY5rbp1bCVr7
	oHdqH8D+bCNdy6RA1RpW16D7C8TX6GRqt5KSVvMQTeyGAtjWh4owhF8gkVYLXYz45YLeCy6KhiX
	5oend5t9xyTD6S4X4LCB9CpPNiSxnIO7s+63IAi9va+K1ZNoGGq0CME1MhctP6njKqbqtGFAbXM
	wpV6K2D6d7u35JVxwEaA9A5fWFO+t/luZORIFdLLv1cLkmQz2PymMpuEP3+vdq9LEIPgtc277PL
	GyH1QHqZjFq+mkX/D2VhPLKnoBRmv5f5yEs42HbXd7htt7SJFUrHAn2hAgTBiowF7Z64A=
X-Received: by 2002:a05:620a:2a02:b0:8c5:33bf:5252 with SMTP id af79cd13be357-8c6a6963403mr1445548485a.70.1768839865634;
        Mon, 19 Jan 2026 08:24:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a724a484sm800372485a.33.2026.01.19.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:24:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhs3E-00000005I0S-2Krj;
	Mon, 19 Jan 2026 12:24:24 -0400
Date: Mon, 19 Jan 2026 12:24:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dma-buf: document revoke mechanism to invalidate
 shared buffers
Message-ID: <20260119162424.GE961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <f115c91bbc9c6087d8b32917b9e24e3363a91f33.camel@linux.intel.com>
 <20260119075229.GE13201@unreal>
 <9112a605d2ee382e83b84b50c052dd9e4a79a364.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9112a605d2ee382e83b84b50c052dd9e4a79a364.camel@linux.intel.com>

On Mon, Jan 19, 2026 at 10:27:00AM +0100, Thomas Hellström wrote:
> this sounds like it's not just undocumented but also in some cases
> unimplemented. The xe driver for one doesn't expect move_notify() to be
> called on pinned buffers, so if that is indeed going to be part of the
> dma-buf protocol,  wouldn't support for that need to be advertised by
> the importer?

Can you clarify this?

I don't see xe's importer calling dma_buf_pin() or dma_buf_attach()
outside of tests? It's importer implements a fully functional looking
dynamic attach with move_notify()?

I see the exporer is checking for pinned and then not calling
move_notify - is that what you mean?

When I looked through all the importers only RDMA obviously didn't
support move_notify on pinned buffers.

Jason
