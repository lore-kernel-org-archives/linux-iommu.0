Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413DF2DC764
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768554537; cv=pass; b=c8WN7oRDTxCdLMOBnVjIPCq+IXQrtefXyYO0J8YVu6ZleyCctS2gRcTwWwKf9is+S3wSKN3hGIMkbuQKDA4mdLxRYaQV2VD6Hy9V0dlakrzwoAu9gK+s+PaLX9xCtsTJQP3G6FEh7bEzwJKwX75SkZwkSPnRit6ZIeNzMeul3Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768554537; c=relaxed/simple;
	bh=uV5ai8+6EC+pJzLYQZ3fFgNGH9Y3bcfVxId6H0sX3yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXvX6FIyeHUbn3aeD37I3sB7cEkHeGIwhUFKiqvKGPFO7DcxwyKNElNnbETCD0E/kz66GFOF0AHlQMnX9acll3Ndz8O5pQv7cK9fxHKWm2zycliw3T1O16Y6/+mR6bTS6dHU0Z2DoPk9Ms4fhH5TX4zXeVVX5Oc26PzQemg3Ib8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jy187yrp; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jy187yrp"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50299648ae9so307111cf.1
        for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 01:08:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768554535; cv=none;
        d=google.com; s=arc-20240605;
        b=ccTFLamiq9vASqRl1qgcY7S/CZN+cvaiy7tS7hm48UWVEEfRPiXUtLQx/Hc4I8Qpy0
         WXm1LDFbuN9CunmSMut7WT1LI/4VpF7q0icTEnIPkbFCD2TdQKmYVwPFDTmBfKo2GjRW
         A6NlKlm2PTr5SbRsu1UHcn9hFUPjaKaZEkkak9b8O1omcYk2U+E54KVIJHHfM/211T5p
         m7AF43S7glSrRfpcuoxFXKo6lrX1EmOpurRynmmqWu9l0NOChuN4MDy2zq0cDgmhmR0K
         AaEPaqJMXYQIA6aInTlGD66t+LtyjjFxp/a5KP6TIhTH3PCoAgMoBtySKsP9bnzLsAlo
         jjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RcimFNxoQuk1GUtLKJNj8zegx2jcra7sXFZBTJ6wuhQ=;
        fh=l958m7z/s5A7xBOLHjiAe01JZXjsojDkoOFJdRnFiAU=;
        b=TIISbFftPyNmqsKs+NPBIglhc6d37qrMgeSCtH+7wuyOEL6uFIasczb8sxbwijxhcH
         LisLHrCDnaxuNAhWcfyitp8KUjUBJJXjXnYvj3D2L3EfMSSHrdenkJswqtHCZo1WqtkG
         OhTJI5KeURhPaY3iHCYHiT7a7rnLaaadIRGtiAQdivCmmWWJroXHCB+Im/Sc7IAc3wFR
         PAuuzfX6W8+Om9/d/fLfNfOXFBRqKWwc+udJjz4RdMYGst2oXcgUTKbznVog/HJnVFWy
         cAE52iRDPX0eoVJDUeryeqP1rkgkVJCLeyiXUSLBakzlaHhAvdDRW0Ht2ssz+TrF46LL
         Jksw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768554535; x=1769159335; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcimFNxoQuk1GUtLKJNj8zegx2jcra7sXFZBTJ6wuhQ=;
        b=Jy187yrpheyguGY/RcBTXYtSdJLyW/MFLmtM4Zd9lsTqkYV/4X+ep2hmhFB7FMkK+J
         mVK+CrQqBs/CYB0EhwbSZUldAUQdvxQRdjtByYg6QHwJe0hxVXKcSyiQjUut/5uIdehD
         3syjOzKC2TJHaO3tYyxeILNF7hzcaD42EGwks4MpToeZDngOy25IYcJydeULlmW60ZsU
         1TuHTd1m/vq3DJ99T1SlbV5bhwwJsPgVBaLlBQsHZTBveYVHxci+tkBVFez19H4ObciK
         UzvHaZoXw9B82iNz+DXO8092HRglSG8CHqRXu0OlCPJTxmhqL5bHe3IyYGqtYN+1u4rj
         oH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768554535; x=1769159335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RcimFNxoQuk1GUtLKJNj8zegx2jcra7sXFZBTJ6wuhQ=;
        b=g/YpXMAYmctEUaSBNl04lI4sTvhFsLeTJHVH5I6uTPpDnecPkfwuTqkZVUR1EYNvZg
         Qt/Z+ysPCeqKXPWeXwfLdVBDzO/8SrLb6PIvg9GyMDJxwqpGx/d2MZEuteswzguidH4d
         LqZDI3zIdpWjLnUyb7Dqfq4K0PUVRvGDRYgpwxapRLxOj6/hDfd+zjRwlBEZXT/7Hr2J
         3NHValZDsjQnRB/qdjLT6Ndw2py5+EYByzH1Jzhk8BEtZ6yFL85L7J6jidPpd8HZdBo1
         l1shij1ppGRMHsrqNhvXCXOyrf6A8zt0RFPI5op8QbudbZixieyE4dVOGwMLxBtjrOKn
         0aYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWITKw0DuQ401f70E7pOYHIrtKEtqLDA9iQGqahok0GGLEwZEto5mO1mAQInZ18J20SS3O1WA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbBVlQzpgZl+HMe4K0Vyf1i46iV5MltQlHyGqImMNocSJBYCb7
	J+fXbxGFxver/+Nj5/CiBTkvyTW/l00o00DFTFeiSMwx4orw1KiiOvaoZIu3XQ4erZKa21uWGZr
	M1rDIRfdfEZc6tkRVIrjjqbPlu2tIO1hHPT3QoBT1
X-Gm-Gg: AY/fxX6+VFTCuHXBTRTLjEUOt4MvyKfkA5KzQzFf2kGOw5IolWxNqVw7E9Lr8JQc9Ye
	8praSsTqv347jEjAPjHQdd2apNZ3bw45pqwOGb0zN6/Y1V9IIfW3ui63YEMm3Z6O9+HD0IMEaGz
	8P3Kc7Eh9tdehAfnQvY/+XfIey/TpWazBl2k3f86pviNIKhQwxCNs74eEPC/zmLl+C9aDoaIwcC
	LLngyOORUUE7cwvDczQCmvvGFi88dQTQgBTnPDwm4YiLwJrk5MguhoSG930dyPl+OHqZQs=
X-Received: by 2002:a05:622a:1aa0:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-502a2386e05mr553561cf.8.1768554534866; Fri, 16 Jan 2026
 01:08:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260114164322.787125-1-smostafa@google.com> <f3ab0156-3d7c-470d-9c1e-922195ea27af@linux.intel.com>
In-Reply-To: <f3ab0156-3d7c-470d-9c1e-922195ea27af@linux.intel.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Fri, 16 Jan 2026 09:08:42 +0000
X-Gm-Features: AZwV_QiM8_AWnP4if6nM9uRrMx7z-1pq157-8TMrLaAscPdc1UVyRJ2GSwTSnA8
Message-ID: <CAFgf54rVPaUgbouXWQkczCyFQvXkrei_x6FYY6n1X5NkSSwYfA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com, 
	rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry I was travelling all day yesterday. I see Jorg hasn't done the
pull request yet, so I was hoping we can still change it.
But I can send the fix separately also.

Thanks,
Mostafa



On Thu, Jan 15, 2026 at 6:15=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 1/15/26 00:43, Mostafa Saleh wrote:
> > Changes in v7:
> > v6:https://lore.kernel.org/linux-iommu/20260109171805.901995-1-
> > smostafa@google.com/
> > - Add a new function page_ext_get_phys() and use it instead of
> >    pfn_valid() + phys_to_page().
> > - Drop R-bs on patch 4.
>
> This series has been applied. If you have any further fixups, it's
> better to submit them as follow-up patches.
>
> Thanks,
> baolu
