Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE6612EA
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766284; cv=none; b=UuiKrtXY719ZME9NJDlYfSu+LtgWqCOj/eMv7FsIGD5Eea/K01MT9q/hm6tTs9sPxmQiKnoMwSHm647nCoCWFOLuWNHJPvaniQbcHCZVO2vtXIg4pfJ2vYNOPy3ztmpiFA6egMo/E+0k0o1M1o7BjKx7HfJXItCXuLdFTKMEcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766284; c=relaxed/simple;
	bh=vEMPM/EH6Okz3t25IkSZi1WRRqu1MVzESQkdYhAZwy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRfxcK62LHvncB+YjthrcJPm2zrSKew7jt4+47V88TY70gACeUz7hsqtQRAk9OEz/Y3zqrHAS6TnTGSH0xvHMHIsK+afjf/tAPjAiV2iTlA2iRrpAp0CRvH/8D0WJlAS8f8QXvaWAvF+vQXwNHIyFgw3ZmOQUmulmBkFMfUoVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kiPlyceY; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiPlyceY"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c495ba558so3314126d6.3
        for <iommu@lists.linux.dev>; Wed, 31 Jan 2024 21:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706766282; x=1707371082; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmok2g8b5tWvpbsX9cLmWQHlMF1xII4qzBeVlpsQ4mQ=;
        b=kiPlyceYIM5lIARcZ7JbYOR2MGqttOdJr6HKOBRzFVJLWc7RVAwpKzfU0i3e/iknrp
         wDjj8VqMRxzFzs2rO/bXqoSmgRjv9J0MUDwPVhiklqf/AbgqPb0EvO+uxvMWpBPil3gT
         JadJ4q70Mq9NDrjnofIsm8rsGpXsu8CDm5YPawqfpoOTj+UnoL5ic7PpfC+d4fnhBkkb
         PPsTAlxRWTSUwdUyRro1WdZFz5RIcqN/8zgmhIrVzaMp5CqwRYsxozU644QP7MbMYc+V
         uiniAwC0eZiu7hZyIC5tgypEbn41T1+w02CKKSrnXhJmxm92V9DGdSunDPAWB299ePFr
         lU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706766282; x=1707371082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmok2g8b5tWvpbsX9cLmWQHlMF1xII4qzBeVlpsQ4mQ=;
        b=hv1GE0L0I2mvNwq274ZEtUPfrKl/zeBv/KDib2emFvh4TJi2qPzUJfHjP9Z4mstoPc
         73Sw3Tf5O0kYT6GTscJldorRLVj84IJO6VXD0RV/HZmf+w9zyQ/kF7+3Mc0A8Yl8dBPU
         xICPiCtazN5XpC8w00RrVsPFFKYOgSNBmyiRkvafmQzQUdDeUtm5Un3b0OwL5hizBUNH
         LSq5e9JOJBvE7XjahxXXtjsRtPmZC5r2MP6jM0PeANJniqTTJudWMPCJ0RI1CtfNl/42
         mU7tK5djp3FLhW2CLS8SjXYtDXmNcgbRvUqFr4UweJq0sB32JlCrnZVOit557pr2XzNv
         kspA==
X-Gm-Message-State: AOJu0YwS0zRoY25w+up9siqe7XqntyKEOKXK6XZq1uU3IBLfbeec+5qD
	aIiusgZCwhbVQPXuvcMsEa6+jLyqh4JdA2C0w1SIWtDAOZuXDVeE7eyTFcrb0GWqZLzr3DgZ26/
	WZIv2/5P4nUQj9N7GYLD7ttRxLBJfc+Fx48+z
X-Google-Smtp-Source: AGHT+IHVvumo0DfD1PcCVlzlBND2HO0YlBAKMh0ymb7ulOnj4hcNNN1Lnv/Ngc1/yQN/cM+UWlxHcXe5s2sVnvXBr4U=
X-Received: by 2002:a05:6214:d87:b0:681:77d9:c405 with SMTP id
 e7-20020a0562140d8700b0068177d9c405mr3957939qve.33.1706766281534; Wed, 31 Jan
 2024 21:44:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com> <a06f9b81-38c1-4be8-9d07-6db31530741e@intel.com>
In-Reply-To: <a06f9b81-38c1-4be8-9d07-6db31530741e@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 1 Feb 2024 11:14:28 +0530
Message-ID: <CAGtprH8HhCVvjARm3ZuHu04uxAENOLa--kHQhRtAfSz+4-23kg@mail.gmail.com>
Subject: Re: [RFC V1 0/5] x86: CVMs: Align memory conversions to 2M granularity
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	rientjes@google.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com, 
	pgonda@google.com, michael.roth@amd.com, kirill@shutemov.name, 
	thomas.lendacky@amd.com, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de, 
	m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:23=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> There's a bunch of code in the kernel for TDX and SEV guests.  How much
> of it uses the "CVM" nomenclature?

Right, I see that "CoCo VMs" is a more accepted term in the kernel
codebase so far, will update the references in the next version.

>
> What do you do when you need to dynamically scale up the SWIOTLB size
> and can't allocate a 2M page?  I guess you're saying here that you'd
> rather run with a too-small 2M pool than a large-enough mixed 4k/2M pool.

I am not yet certain how to ensure 2M page is always available/made
available at runtime for CoCo VMs. Few options that I can think of:
1) Reserve additional memory for CMA allocations to satisfy runtime
requests of 2M allocations.
2) Pre-reserve SWIOTLB to a safe value just like it's done today and
not rely on dynamic scaling.

Any suggestions are welcome.

>
> I also had a really hard time parsing through the problem statement and
> solution here.  I'd really suggest cleaning up the problem statement and
> more clearly differentiating the host and guest sides in the description.

Thanks for taking a look at this series. I will reword the description
in the next version. The goal basically is to ensure private and
shared memory regions are always huge page aligned.
