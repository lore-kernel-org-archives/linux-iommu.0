Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771157;
	b=08/nNDq5FbgXMe+9XaStZ6MWfo8org0dHxb8aPNGXh4YhU++e+U0l72P3y3/8LXWzH1q
	 j4QkTffHRK2QPptfb38HBvX1rccglyMUVbXKhEfgz4HDatPb+xwJwRIe5l526hJNdY6Qa
	 Ft/SM1SewHds+9yMckoBGTDUYVHJqw03loTsDzOKJUQUVpEisPfdD/mOEWIWapB4hGCGN
	 n1ystSjDMaeEEewSQ8UPL9mu30OQpfpNyV4jq9rJAuQ67OhNKQt7e3ZCWLyKDeqWHV4N7
	 hWmgHCUcNpYUmpgvn5ZVlPs3CYkKezfwE8i2hzYPe67ei3fe0eb8bcFRKLLyFqHqcKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
	b=1JhAIY3+gOqKrOXgxe/duVzSzvfKTrDwwX5MyitlH3g9fIu6pI0MBB2IivTw8X3nW0v7
	 Exs1XmPxjDzmhKnS6MQUqQ/O7f2SyrX2x75gy1OrxgEKFY9IiD3i/vgmNrskjqAaWQZu7
	 gdItEl/wsK97tuY2HI9+TBCOzcjLwY0u8JhsrAB1p85j9ZueaxZukYWuOpbQbxgZQPITE
	 jeoaWzhS2yVUNkPUa2RbZezpR7NBv9QM6WIGf+H0sM8ww/tiDU3kkpGrK9q5pnDnzTz2r
	 N0neGX6VL5WpKRWuYHR1Fh31XFN+fIy0tj5unh5qD5ifRqlrqwNRiqa7WzXr0l7AEWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Epbo06Az;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5C606A323
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 15:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84A5C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Epbo06Az
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5365d26ccbdso11362671cf.0
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792771155; x=1793375955; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
        b=Epbo06AzNnLHnCoLRTNr+m+AUE5mnZPeIWCGJT8ngi5l/QQyfkzi4YV4lbzB3cKbKV
         BLvb48pUMPgR1acjlmu/OxvQ8poCpmG+nhL4TL1yuD0C1jbY4NNrHgAWT967PK7a+s36
         DLQH+mjRKkwuzGSdlCVtaSP5RFguvEt4EKl90hQjAlv8Or6ErsBZqUL6kJ0SguHxKbIT
         VrhK2JG8Lwea0g9wWh2DXh6FOLu8qVvGntyeldoKIfKxZy4vNubi4dIUyAFFKz4ATtAz
         QsNXUfVjpkAn08pkpgfpXTZEh5bBu0KUqmPcwvvyRwCXFE1t+/3Bn1p8zqt0DGxX2nex
         f0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792771155; x=1793375955;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfip9nPMyQ6NKHGpF7rQvQFL04olz8IZl5yoz+w1jok=;
        b=kcli1Viy5dyBBLH3II+rInx3Byo/a5w52hv0h2nPT0ZXGCI8o5rZThKqs1NBXWdC+j
         WwDC4SXxG/rzRMwpiZDpZwTjSsPyHQRLy3xPx38PVh45WuyqxIzriVjo3Qnk+L1iDaH0
         o4BVU8GQrQj/aEEqaSj9OzbZo0hrOsPXtT+ZwaN1OekEaslCYOtzaAruvR02rImmpHNK
         6COp+CZWLALI64YB8ftk2HFgbgAwlr3cGFFkAVku5bfSWxUFY1g12E+7Vt6njK3gHo2H
         E1iO2CwETUodjb7KE96LQFZMiAinqLlu3P01J5UF9dG78961CwilNoRvYC3G+kU7siFv
         utBw==
X-Forwarded-Encrypted: i=1; AKwUvBxAo3DtEYWY5Q3bVogM7nA+qIf33BoeJoNpk6mPDYbmkA9Xb+doRqVtTsvrvkEU+SIyZHE2rg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLW0UEjpaYgkQFd0S5iBrTVRQkIvMILGO+gtJj8llpTXHArnTc3
	AeZuj3nfXorLObYjwuTBUgpPJIkj4+5D2ei1ymMZzmDIjuayuYL3qRwbC+NomNjQYAA=
X-Gm-Gg: AYBFou2aUAQIp/Jc/L7fcib5gI7t7uhP3hutlLFMDlaZFrnZ6EPKuOFGPGpb9YwbyXU
	lfZhusywVdmg9u0ogLWevEV25RvjOz4pGyjkqcLEXxKrPw1Goe5M5AsxlO+2zUf0mn3w69EFHx6
	2lPOYTQnqiOwAMgGYQ65cXuQPxsXs4qyRlJQqStDlZMwkfBxga37jwoPl9K5ihRjDBbGw/piJRM
	APRO1/nUjxE/7387qcXz5HkWTRIcRZdaO6h86YwyLgsZsBAuns0yLptTCG4QM1nrtca/Ea4K1/W
	YBp3xzIVY8nF90P+GFEfDl2AXFINMkUyWRclAXRRCENJdkjMHNQtnENaTKS+gBoeZ7lO52rOS0Y
	jOaGsHHqIQfrnVAEp5pihA0WyJQrSZmE6Fi4asc7QRCT2jRW4hhSfrBKkQgKWS9KTJYjer0D59F
	9MbuVwrDDq0IAAPg87WFlMT7htPATxwpAa/+eaC1E0ILlcLkBFU2drMjsJypcIOaV29jWD6rFTU
	5AFJB7Bm9ZXT9hu03B/Z0w6JhCA4vA2gxKXGrfrEbAuPnptWoA2bRQLnrConcjQllhlVgO15u3G
	UybF7NINS9zEZvgLp0dy6JnzrNKgRfQ06HuV5g==
X-Received: by 2002:a05:622a:a0e:b0:535:859c:b6ff with SMTP id d75a77b69052e-536c24e2452mr39136051cf.20.1792771155235;
        Fri, 23 Oct 2026 08:59:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53836c78f67sm656181cf.27.2026.10.23.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:59:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKHfm-0000000Go19-0EMi;
	Fri, 23 Oct 2026 12:59:14 -0300
Date: Fri, 23 Oct 2026 12:59:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261023155914.GK3977851@ziepe.ca>
References: <20261007063227.GC7822@unreal>
 <20261007204045.GA783967@bhelgaas>
 <20261009174301.GC11438@unreal>
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
In-Reply-To: <20261009174301.GC11438@unreal>

On Fri, Oct 09, 2026 at 08:43:01PM +0300, Leon Romanovsky wrote:
> On Wed, Oct 07, 2026 at 03:40:45PM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 07, 2026 at 09:32:27AM +0300, Leon Romanovsky wrote:
> > > On Tue, Oct 06, 2026 at 03:49:47PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Oct 01, 2026 at 02:55:10PM +0300, Leon Romanovsky wrote:
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > pci_bridge_has_acs_redir() treats Request and Completion Redirect as
> > > > > interchangeable. On asymmetric fabrics, a control for only the reverse TLP
> > > > > direction can unnecessarily force P2PDMA through the host bridge.
> > > > 
> > > > Does "the reverse TLP direction" refer to Completions?
> > > 
> > > In general, the P2P code treats TLPs flowing from device A to device B the
> > > same as TLPs flowing from device B to device A.
> > > 
> > > However, in the context of this commit message, yes: completions flow in the
> > > opposite direction from the device's perspective.
> > 
> > And I guess asymmetric fabrics must mean fabrics where Request
> > Redirect and Completion Redirect are not set the same way?
> 
> Yes, in some of our systems, deviceA to deviceB is going through
> different route than deviceB to deviceA.

It is a little more subtle, I think practical systems try very hard to
avoid that since many host bridges do not like seeing only half of an
exchange.

What we end up with is Relaxed Ordering and Strict Ordering take
different flows in the fabric.

> > But I asked about ordering because it sounds like this patch expects
> > to encounter asymmetric fabrics where Request Redirect and Completion
> > Redirect may not be set the same way, and the spec implies that
> > asymmetry may result in ordering violations.
> 
> My guess is that the hardware and system architects have ensured this
> doesn't happen. At least, I haven't received any complaints about this
> series during internal testing.

Yes, the ACS combination is selected to avoid ordering issues

Jason
