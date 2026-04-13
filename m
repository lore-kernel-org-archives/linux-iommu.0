Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003C33EB17
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100503; cv=pass; b=LQlBwpA7dHS02pxV/N3KHYaNMD0S1x16U3GEx/enIzAdC/espfAQz1uH1EglVp/zFNmh78maIAw69YZ4iKJaa6L7yqGwAuqRhHTBGPABC00XXigk+AvRDO0sd/XKkwyXbzPlVpIhGcSwxH6pkSeRGyjh1GvzzmRjjINJQM7n294=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100503; c=relaxed/simple;
	bh=mJqI8FaBpCq6Q8my/gjI9enGPGsVFf6sqA8FvAAq50g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpWgKyXhH7k0Ont9flAJABcq0W1Ur38g132WmIvgOOgnRXCGosLdPiRcvyYYc+twLsvoM2Ttx2he2nCnVdWQe+gXZ18obkQWBgL3CTVmZn38c34EBwch976KZpghh+51SIPMakBpQNZrf2lFZ6uhmnorXVRja6RjdmU5Alw6Cmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=C3qb5FF7; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="C3qb5FF7"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a74765703so39368157b3.3
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 10:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776100501; cv=none;
        d=google.com; s=arc-20240605;
        b=QGqHuv1Fma1nGegmiXcbR/fydAGz4QJQkAHZnDklMQDhn1CJu/yj9rYF4sHOeeXmwG
         /Eg+e7M6pJHmdP1PrYtvtdGGueJBxFk4qwgXR0lc0QVgCFtNIykf0aXovzqDInLaKDPv
         QRzsGiuQiaCBRC/M90elfhUT0cbmUQ7G8z2CWutiYNGoSrEoAaNwsDB6/jiA8yGcZRip
         61Wp6LChi3wEh2WDPNoHMgnUKAAEMuPhcv1kZTLlfGrKWv7mnLNBi7wH0lGE8Z031exl
         /yhOXjp/LesiiY7rhz0nvnaGJakic3IVz2EQKzUK8K+VARYHy+B3qchUtIS7HibmgAS5
         VNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5BELIkiCypTZxDmr5+xtV7esxMT0E1Vw9Qw7kOi8Vz8=;
        fh=imLfJRP1LT8niSwCbttXq7/yQPr97kCQdixU7Szy9qs=;
        b=huz2k7XggKBXSzD5SF2rnLjubSo8CUn4+Vfbx6ZWI21GmpdiJktZ/xk2Z2VspBpmOs
         zD06K5sG0bIQBzQnlh2dD6mbLAhSHCtEfWswSDUOQHMvu+93Uu0gIkHEtWAiZeMR6kaP
         mg22jGtLW52BWGcse/zTbXXTnIK0ql5dLHyLn7FCmFPrRGlt4IUMwhiqnmbB5CPPNWkf
         N5K4qzrjsNGwdlgQGRYKYy4xyhcOoidaKoUdsT8ALrV3LzwhB+pC6XIuwqF3OFWMoJMy
         gVOz7yQSMP7/pdBuQHuEe+d98pc66RyUWB04nSjOhKRmt+9l7qrdOrlIj/FNcV1A1dXD
         ixnQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1776100501; x=1776705301; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BELIkiCypTZxDmr5+xtV7esxMT0E1Vw9Qw7kOi8Vz8=;
        b=C3qb5FF7cXwcsxIUXKvhVx6E88hUMH0utTK7D2FK0CuP8hKB1HrK8srYJAsR0eUDJJ
         AicJo75oCqBX5Kfh4tZI9ZEGgGslb0RC6UpbZJ7hjfivmvXmcwj1EZ8n46B7xWZb+wnE
         FS5Wf4eSWBEPVQgu/iuXaILfO8Pra7hMYoS4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100501; x=1776705301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BELIkiCypTZxDmr5+xtV7esxMT0E1Vw9Qw7kOi8Vz8=;
        b=o6jKe231wm7qNEOz0NkQvFSWmwXUhulcqktQ4FZLKkoo+VDEYMOdZljCcTIpuTaAmJ
         /PGi7OXIbT2uMO0jCHGm045wGSWgNIQRfWUsjIcGJ/D7//86eqThuIdbwDk+m3ur4Kti
         RWuZZAEAjXuj77uJN8noPLSX3H0ESlslvPjl8gkLn3I0NuYUflDspg2t6DxeLQqKbpae
         bvsVt49N0ZIkO5DVZH/EMZPMXDnyqn99EMxeh9EA9fmhowA3gxlPt9dLu2H6w1UXuyeI
         343E+LxDTEK25oyZUmWAG3aDzLojet1m5eJ0g4P3QjIjEvcp8a2Q1KhTsW9ZpKjUSuAP
         s6gA==
X-Forwarded-Encrypted: i=1; AFNElJ95SWrvxu9F6cD5KyuhTPF4lCRMQfsBtDka9dOwq7l9SJ52YnHPwyea65CoyQAk71uOjpGWYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzV0KcUstYEGTtrlOQa/1wZNgRrMvme11ky2cQM6TlV+zkyuXGU
	NxW2LY8HoA58TqSqU2g+KqO4ZwUcN2fUNcqoYLgiMtz/xsnX38toKymTwWm27hZAvBzeMaJnv25
	ymowsCzsZmlM+HMgCKAYltt1JSDUd2W6c4QcCtGCYZQ==
X-Gm-Gg: AeBDieuSRF+xoFNa6PTKB5HbQ7IXCNcZkg3cHddO8e+mLunKhluoEha2l3EbVlcykib
	TPKN2Uq057B2KJpMKL8Q9hq2K5dF5hto6rQ3YaZmyPqacmE7L/5TS0pwGaznJq3U7rgmzGwqquH
	Nhgckq5I4SSuZLPVZxd1vi8NQDPRZhyLAIiBx11io2cPcmsHPheCwNs1MwBQM43pu8Q0Nr/dQ/N
	aF3+YEdINQw8elP0xZwQ6a5k925KSj7/ADCkJ+jkBNop6r6qF25OpkDzspXkaPoxQKZJ3jznKVo
	kzclzw9+Sc2rWL0yLt5BPB9tTP08Alk4Kpj5t1jT3xdpSKJXZzW4Nlf3tlsmAmpkef+6IV7Mbve
	hSVCi6L5NygfssdfebhAIb58aAwPdCo2kZiGSPnYyqaLEIL97D62NUF46nNiz/ps=
X-Received: by 2002:a05:690c:6d84:b0:7b3:3a49:73b with SMTP id
 00721157ae682-7b33a492a9bmr44979817b3.25.1776100501093; Mon, 13 Apr 2026
 10:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAJpGJSR4r_ds1JOjmkqHtsBPyxu8GntoeW08Sk5RNQPmgi+tg@mail.gmail.com>
 <20260411130354.GG3694781@ziepe.ca>
In-Reply-To: <20260411130354.GG3694781@ziepe.ca>
From: Sina Hassani <sina@openai.com>
Date: Mon, 13 Apr 2026 10:14:50 -0700
X-Gm-Features: AQROBzDB9pPQWsjdy6qpC4ePls9wmfXy8CWLdDAZ17Sw34wtz0EFUiM2ReyPXW0
Message-ID: <CAAJpGJTE5MLh7w+uq1LExwLBJWNLMqhhLRFQb867X_CoqtV5Sw@mail.gmail.com>
Subject: Re: [PATCH v4] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jason.

On Sat, Apr 11, 2026 at 6:03=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Apr 10, 2026 at 11:32:44AM -0700, Sina Hassani wrote:
> > Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the l=
oop
> > body when getting to the more expensive unmap operations. This is fine =
on
> > its own except the loop condition is based on the first area that match=
es
> > the unmap address range. If a concurrent call to map picks an area that=
 was
> > unmapped in the previous iterations, this loop will try to mistakenly u=
nmap
> > them.
> >
> > How to reproduce: I was able to reproduce this by having one userspace
> > thread mapping buffers and passing them to another thread that unmaps
> > them. The problem easily shows up as ebusy errors if you use single pag=
e
> > mappings.
> >
> > The fix: A simple fix that I implemented here is to advance the start
> > pointer after we unmap an area. That way we are only looking at the
> > IOVA range that is mapped and hence guaranteed to not have any overlaps
> > in each iteration.
> >
> > Test: I tested this against the repro mentioned above and it works fine=
.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sina Hassani <sina@openai.com>
> > ---
> >  drivers/iommu/iommufd/io_pagetable.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> The patch is corrupted but I fixed it up by hand and applied it
>
> Thanks,
> Jason
