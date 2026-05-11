Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F4372EFF
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509856; cv=none; b=ZQHVJc19p6Vkcv/cytjryNAaL8bm1SeHsfekHyKht0nIy0OTz3Hsuv+0EEOSjv5XXmsNHNP2tOmdrloUJ42zfPHhUZsk6CXW21gjRaY+2gECMYx3/KxMkyCZV+je4xgdXCTqluQrc3LHJnU+pKw46jkMEUMgd5XjF358sk3mKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509856; c=relaxed/simple;
	bh=KyLuFEE+coaf/jJEo/cblEGq/QqRcgAQPejr03h+6d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiDnryRv+T8qC6/sYhZzV75b4I3Pks9Nqlv1LeGALe1c0OlFSEmWAf2SWFVYf5Pn4SZ3xLwWs60OTAkS/y2lsVudyhI9r1OEB/FFO0gIrPPgWNWHJSmLlhQk8irN95EuLZEqdH2eFGpKevICs+RQjijSJJRxYvQUUkCdhE9Cb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G9fgPA45; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G9fgPA45"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d6ab4476eso42016511cf.2
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778509854; x=1779114654; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1t4Q3YbgMx/6e1k8a1sHgBJ6iv/rwR+3bFc9xbIXC10=;
        b=G9fgPA45BGQqcyYUHh2py5G1KHsHVTk+Qq0WKde0tnShQU6J+GS8n1rKBeLH8kcd7E
         w+5i30Mfdv434UxMvO06usK6DpvKE7GIOmpENVB1XbhaKV1sVUwweS5rJvIev33cAKk7
         pE2axrqScDywdnZpyTs0o7OgWRGBO3vwi+RZE/8IQtAjc3HWAKvCcLFLeRWOxjSk8a5k
         MAjpT5tKqZmh8RcN/h5IkQbZTT0n6ABDI1dZ+ShQ1v8KXw4UDRaHYy78shQje4Z+2jy0
         noD6WWWpK+eyjM05TD/SHf6/W2JLHEAR6n00QqHd64kcLjWFxAcw4oOaN5nxDYLWMFsw
         4lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509854; x=1779114654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1t4Q3YbgMx/6e1k8a1sHgBJ6iv/rwR+3bFc9xbIXC10=;
        b=RhgxgMkfQkTGb9Cp1Xy8ApopBzcfDax54c+KxqadAmwpIlZGSGEWG8hKpwH4cNqx57
         a3rrj2uxlgNqG9nzTZdNMNuqeGBM4jeejwSfmYGBRfpYBdMSV4iEMtYt9jk2XqFY58lV
         pvobkz3LbPgXo3UVWjXCoZxpXZrrMgNBhSzKtyPPua9q8W6oz14VIWfW38LprEam0uhN
         1C/9QLZvuzlIwLE/vSS3bCheQOKu7a1giYd6HkJUrGB3bqxj2yAn10ie7PizlVH6C8Fu
         J3GBdfZWp8RP0gTrNLXBq2qiMEnYDjPtZmIL2tYmDZBGIEI4VXdQXt8aV+HfnhQcqWZg
         wK4w==
X-Forwarded-Encrypted: i=1; AFNElJ9igOGSR3gD32DKzMnQrJsVL+UhlRWMBBI8ztQ2+fnnO3TW8Gq0WHKuA1iEJMoMQxvrrOdR7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk6pFsnU92sYJnXMGTYpO8zpZL1mqhXvI9GIE3AsI/ttGFqzpr
	TLkECIoDjJRKpMxuwVRa7lj5rW3yILPngxnlTt4atxZxd7Dp80jdkkzOEGDXJq1UDBc=
X-Gm-Gg: Acq92OFSmlY1prAwQgGK+UwsGAlNgqMYSzlBGzX0IiOuTjZvHJACWqwtlcLHun9/iT+
	JRhGrSnIKf7S+zuMutLUQdFpBjVktdQcJq85RXYNCIDJ+YwttGLfIAxZ3nvofKzt/gyg0JOPIgN
	hvnz3pXte8ykeIv3IfXLNsf2woUJZEfbMb3ljK5ryKuFE92JRVzEOmS8XTfzPbCTw1U/Zk2AgbK
	KH6dJaImxNtzLp/LDMnef3spUOY3ER7ZPW1putCGgCaD7SIuS9MZW1f34IxdMQcPfm4c4vYTcsc
	dYiQgT8BRECm+Xa830GdnCa6TJfLrTGm0te+sxEOAES2+6MyKj0DJEBe5Z0egkqDRI/2bY67y+h
	1WWPkKuqAY5kqA1Dp+Z34JjbdVr5TAuZxy04czjk9z+qHSV5CnVidKPFKvhO7+mhdnxPRZtRS/0
	kSTUhh1lnO8FsQSNC26LgxNDY6oA84iLyIg73WcufCE1QX/KbH+gzVi/ZP8zMtyJ8spBTP74Fjz
	qBTuw==
X-Received: by 2002:a05:622a:d5:b0:50d:2a76:43c5 with SMTP id d75a77b69052e-514619de7e5mr335362441cf.2.1778509850538;
        Mon, 11 May 2026 07:30:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90525421cf.28.2026.05.11.07.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:30:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMRej-00000004oIk-12xC;
	Mon, 11 May 2026 11:30:49 -0300
Date: Mon, 11 May 2026 11:30:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 05/25] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <20260511143049.GR9285@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-6-smostafa@google.com>
 <20260501124716.GD6912@ziepe.ca>
 <afiODW2sVMeOj3Ag@google.com>
 <afoagb/wVBJD1IX+@ziepe.ca>
 <afofSPQbepd_fpom@google.com>
 <afsQTwO3eW+Ks2fe@ziepe.ca>
 <afxlufh3t3hRe4-G@google.com>
 <20260509233443.GK9285@ziepe.ca>
 <CAFgf54rJqq_bJONpx85p+uB68i1oVAGZW40aZA1ufid_5fqwQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgf54rJqq_bJONpx85p+uB68i1oVAGZW40aZA1ufid_5fqwQw@mail.gmail.com>

> > Copying a bunch of functions into a shared .c file exactly as it is,
> > then compiling the shared file with some #ifdef'ery at is going to be
> > long term better than trying to mangle the whole thing to avoid using
> > any of the core types and not directly share the code, IMHO.
> >
> 
> There isn't #ifdef'ery at the moment, that's what I was trying to
> avoid by introducing shared code.

Yeah, I think that may be a bad direction. Ultimately it feels like it
will be more burden to maintain this careful split, while some small
list of carefully selected #defines will let you reuse alot more with
no code changes and I think that is ultimately going to be better.

> What concerns me is how fragile that is, any change in the main struct
> can easily break the hypervisor, unlike if we have a clear shared code
> and defined API that is used by 2 entities.
> I will think more about this before v7 and see how intrusive it is.

IMHO so long as it is easy to include pkvm in the compilation I see no
issue with build testing the pkvm driver when working on smmuv3
driver. So I'm not worried about this, any breaks will be compile
breaks and can be delt with.

What I'd like is to minimize logic changes and maximimize re-use so
you don't have to make bad re-implementations. Like pkvm shouldn't be
building a weaker tlbi, it shouldn't have different logic for errata
and FEAT, it shouldn't be doing STE changes without the
hitless logic, etc, etc. All these things are easier to solve with
greater direct code re-use..

Thus I feel the trade of off 'use the code with no changed via
#define' is better than 'try to carefully cut away and avoid #define'

Jason
