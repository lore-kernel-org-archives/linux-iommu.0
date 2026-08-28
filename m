Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC84045D5E2
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927751; cv=none; b=MWu4varutjtZ6Mqs17ODl6dY/NUcwguWOXwXLn6adbTKd+OY/5+AdS3KykkAK8I+oXkQaRHpamPJJ5OnP6qY8emvYiisdIOkSxhU2E9zW8Kuk7W1l8NKz29mjgIRGcMpFKxyuPgHDFnzDg7VOCqX7cIEAkNl3AjmRuz/xIotIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927751; c=relaxed/simple;
	bh=b7h8dV9oHVBHfBv6mxuKsP2hyM8HHn6hEleZHSArLSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHVGtgjYE+VIvllxM6hHbgCccQSHkhdsY3afsWQWcxYiLNlZ8MR5fLAIgNGglkQO2ybfQphvXsUqhDwKqYZQ5e+PoOZWXyFZ7AhfXCyBRk239wu0m48b8nNQxVcyrdXZ9RyUZxcBnSOca0+lCZ8gRIXD5KrUkw06bdvyrIZ+mN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jzD4hmCL; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jzD4hmCL"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-936cda0e3fbso93088985a.3
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787927748; x=1788532548; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1CA/dtHk3Ua/1jrmqIIittu4ca0gllo+cVF1m+itAJ8=;
        b=jzD4hmCLeRz06vnl7NmXW61ijH28F+N5mL8OoPnQVIA8tQwTcxQN5XslodLkLTLiXs
         7G3GIsGeoxJVYa/ZMZDfGKmwS3bbO1J2sQNthgrVYLWZRP1Pn3D/NbWMzKyCRhj1HL2L
         yCDg2q9xm2bXkEvoimLnp19Csdzu9puiwudA+yk8C1XzUnlK8ZtiI2MHuPpPG8NK0m9P
         wqM41XtxoOtIkRNTV4qW/7vEje0BALX88MEzzBaRKOZrA81tB1T9g3f+Xhas0qHPeNjd
         EKwrCk7LKz7b/aB196r8AIxlxqM3Y2q5n4rR9pi23PICEVQHI0tnXiNWbYCie+tqYf+H
         ZoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927748; x=1788532548;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CA/dtHk3Ua/1jrmqIIittu4ca0gllo+cVF1m+itAJ8=;
        b=dNfGjNrqskfKyB1ggb1VcLK32mQXowYheobvov67NHH98M2jW0gJHGDfHovPTOmUIc
         4qnSUi8hGAEFBufsDngRcctllAX1CCzo3Wa3JPO4boSgY7WzxGEEDsuwktd+wCOrUjFB
         NHw9flGaSCx4rBVSXL1Ygcb0bxnDLANBAus5fY0WbNoz5wqZN0R1jWNt2cNR8XcdkbIm
         Yt/jY/LSuCfLBJe1Amv1GCQGTn4E3ga4IOlaGvmlTUwpZrWU7uIIWgzQeU1refNDzt8z
         o/+R4QATPl30xyGvvXDMS4zCoAQnKi64WvVc/TvP4IcDw72fo9RTap9xK9Jsqm5DhY+x
         zWig==
X-Forwarded-Encrypted: i=1; AHgh+Rpos1Sr2vIWDz/RvEc60rsuF+KUpnVcV4XifPA65T1+B7l0MoUqWEpn1591rY56bvvMu/P4BQ==@lists.linux.dev
X-Gm-Message-State: AFuF++m4YGgN0tS6MAUCu8W/nL0VixjPTL5saPz4lkTbV7/ztgTh1vPT
	E/W50tyPA5m/XGqp8zOI4Z4Dfb1TTnK9g5pNoMS9Ibj+S9BfbuFUq6d2/SsdYIeRo6g=
X-Gm-Gg: AR+sD12KBzjms/2IgaP65pukY8nOlpZg02vFFCsC3PYUOeh8h8YL3WuAWQvnUhLEibm
	mepiHjKr35KI6/wzSNyFNmvjOPb3sEL2Ka5nNcfo8nNGntvc4tfp/YB558ta24miW36DaJs6nR+
	bMynfq2zlvjiWW/tRHSRYWMKBtnqYM1Tmma0lZOobLdh3GnjU0Sm1BguYfqQl0WGJj5oV/LsHi4
	5uq20iZiWzRK8yKnZHT5tGkCInzRkMnc+VAZbLhou6UraD2WZtxM8ISNogaDdTvaMs3xTL+7NF7
	/4ctvkqYERFZfBrfeB+OIgH0bV62I0q5M27hKxJCfywNTqPaD0HnLULqlElxaEBU5RnMOIzkjWR
	xrl9b29/NM+1MAkX2l4hDyf/F1DCNTxCFP7lGnrdRNzA08kvZzdI9aFFJiWpo1sCusm9pQihlZb
	HK8D2Wq/wYoz++je9dHkhMMaR4umK0TkCpF3XYzLWtaT6G+QRb1K4DKrorkvpj4PNCm41iepHcM
	x5bbc7W9cRuIH93d4rYG1qIPRazROwFqiVj944nD3s/Fw==
X-Received: by 2002:a05:620a:a0a:b0:92e:6637:da8 with SMTP id af79cd13be357-939138ffc3dmr615678585a.28.1787927748313;
        Fri, 28 Aug 2026 07:35:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm157064785a.10.2026.08.28.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:35:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wzxgI-0000000HRQV-3Jl4;
	Fri, 28 Aug 2026 11:35:46 -0300
Date: Fri, 28 Aug 2026 11:35:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <20260828143546.GC3769797@ziepe.ca>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
 <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
 <apBso6So7UqwR3AX@google.com>
 <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb7052d7-51fa-42e0-9eb5-ba4743956688@linux.intel.com>

On Fri, Aug 28, 2026 at 09:55:18AM +0800, Baolu Lu wrote:
> That looks reasonable to me. I have no concerns about keeping ATS
> enabled on preserved devices across kexec reboot, as long as the
> software state is synchronized in the new kernel.

The new kernel should issue an ATC flush when it changes away from the
inherented domain.

> By the way, is disabling ATS an option? 

No, many devices require ATS.

It is not that ATS and PRI are coupled, there are good reasons to do
ATS to pinned memory too.

PRI is a PITA, I continue to think PRI through the iommu was a
mistake. Devices that have device-specific PRI handling are fine
because that all lives in the VM. Devices relying on SMMU PRI
forwarding must also somehow not loose any PRI events across the kexec
and must ultimately inject all of them into the VM.

> The current design already requires disabling PCI/PRI during kexec,
> right? 

That is also not OK, but there certainly is a useful universe of VMs
that might pretend to use PRI but actually only use device specific
fault delivery.

So ignoring PRI for the moment is possibly OK. Someone using this
should understand what VM shapes thay are making and if that
limitation is OK.

Jason
