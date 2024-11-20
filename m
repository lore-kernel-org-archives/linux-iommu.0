Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ADA33C5
	for <iommu@lists.linux.dev>; Wed, 20 Nov 2024 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732077959; cv=none; b=tce/o1R8kMJeL8iKSzeZUfUQrr3Nq917+yvMPYaP7nQwRSpV0a8jl+E1ztb7tqYKV8Du5HglNv6h7fMDl6jgSgdXI4npIF+pYhkBTcL4r5y38ENpMqBOdFmTjX5EObTLa8zbz++FbD1MHYHmBs79cJ36aoNBRixt3cBqtNMqZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732077959; c=relaxed/simple;
	bh=cUEYy6QxCe5hjSVK24Tv/W+zxVCuOv/5fGdZRlQpf9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXpZvCCwrG0wZkGU1w8kinzkQotMwxK4JAPXYFnYGuacHO5kIIumAcu8ElD9lPOE3brVS9uQ4FSkFh70Pi8oP2D6kpUliJBBrlNrE3UReenRiOioqVOYqKYHSAEzuT6gEC2NTXwus+Cv3yNnXxl3xTXWjgrEDELuAEbfQt4Ji8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7YC1yiN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7YC1yiN"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so20342a12.0
        for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 20:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732077956; x=1732682756; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGepnykSGpIv9+bsJZEohcfna6tjmt1LTZnrFhCTwPc=;
        b=F7YC1yiN50/HAkdfiMLxNu03DzmgD8xgdhmVOy9payKh3+W7KgeFxr1RiFHeMI1ngs
         x7VDtNQck48H0A2GCNvfej71sSospDXbUK5h3UTvTc0JtVWxFxaBX77n0fhEkgIbIpZq
         8all1dlI91bV2WmXRonbwc5uYCWi/RuGYuPD1sWMa0uKsoVBL6HO7yenaxp1jxJM380k
         aH6X06DTbYW1GoA6E7lIOuEm3t5iksxmfLqynJlrDh+EklHD901Y35nV1hqrTOVHsKKU
         1vY3OfKtzykIzyHUQJT4OJb1dHc5Z9Tvcs/rxMVw7oP0Y5pXae8TH0AflYa0gmGwBMB8
         CDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732077956; x=1732682756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGepnykSGpIv9+bsJZEohcfna6tjmt1LTZnrFhCTwPc=;
        b=QL4ivzjKKdyi+jAv+zxj4FsV+frmIJAkaW7SYKYZ30Sx2n83h6GSHfCPbVJqOHlaM+
         BsY+V/zvQkwz8ROg3yxg/DHoGGUWxj1Ut6SlACuF1BYerthxc3uqANcYmPFOhmy5Oskz
         EEp/2aQp9mXGzLrGlsxL3BRsE0yVKcQWakWHlg6ypqwlopFEGcKKnBqkAOIXSk6pC8vX
         J32Wbp+VBqh9LkHyRfMoPWNZx3A+Zd0w9JSneRtEUKie5kK9c6fWSoXhIMLxScGfZj8V
         xagL5Z7IBvmAOhr+zHHtczOgJtKS2QVKqcKuLtMrgDdmrTGJjAzi1ssFUYBXWRWhGMMB
         Mdow==
X-Forwarded-Encrypted: i=1; AJvYcCXNeaULDFT4bNj0B049v3QH996+D3BmuTkxy92P+DfyPuJI+K9Al087nhmLMxW9xXK7dju3CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoftZw82W/g/kfRG4p4qsg91po+m9JahnRt0alVqi66uIk51v+
	eNHTwCMQvU3KvLAlgCJb01GGBmm2N6PYEytqfPZuqqls0cOV0Mfql0bZn308OROPY+JUuUWnp6n
	J0zgdMz+o2nqrzbbY74XEvxxplhc9hrjTf4pY
X-Gm-Gg: ASbGncvSDOxwM8nxsP49zwASjE+V6NlVJxwUMQunng8Tl5yGC0ADgY6oSagDP5yLp+9
	PuZwajHjB4AWtPYUv6h9S2vgp9ksQb49bXrsNYMVqU2VLLJVq+lVRJd/qhMwjYVqnqQ==
X-Google-Smtp-Source: AGHT+IHFJDwAT0Fpv/ZYl174V15i78ZNzLHsJzIwfVnwBs5kertezGrb/rcV1Acts9NxivL4O/3m0rHtIHRblSMI+Tg=
X-Received: by 2002:aa7:c895:0:b0:5cf:f899:5490 with SMTP id
 4fb4d7f45d1cf-5cff89960admr11710a12.7.1732077955925; Tue, 19 Nov 2024
 20:45:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241112083018.1662104-1-praan@google.com>
In-Reply-To: <20241112083018.1662104-1-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 19 Nov 2024 20:45:44 -0800
Message-ID: <CAE2F3rBqPF_POHSdeRahgd+ew9tD37iq6S8M=9Sj0Br6pe5e5Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] iommu/arm-smmu-v3: Parse out event records
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:30=E2=80=AFAM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> Enhance the arm-smmu-v3 driver to parse out useful information from
> event records into a structure for better event handling & logging.

Hi Pranjal,

Thank you for putting this together.

>
> Some sample events, powered by QEMU:

> 4. Translation Fault:
>
> [    7.586428] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received:
> [    7.587012] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000010
> [    7.587504] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
> [    7.587986] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
> [    7.588745] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
> [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received: F_TRA=
NSLATION
> [    7.589219]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0
> [    7.589219]  iova 0xfffff040 ipa 0x0
> [    7.589219]  Unpriv | Data | Write | S1 | Input address caused fault
> [    7.589219]  STAG: 0x0

I find that "Event 0x10" is redundant and recommend removing it. Maybe
print just "Event F_TRANSLATION"

Not printing the prefix "arm-smmu-v3 arm-smmu-v3.0.auto:" on
subsequent lines appears to be inconsistent with how the raw event
bits are dumped. Also, I typically run a command like "grep
'arm-smmu-v3 arm-smmu-v3.0.auto' uart.log" while I'm developing smmu
driver code, and with the proposed change, the grep command wouldn't
print most of the event details, because they are not prefixed by
"arm-smmu-v3 arm-smmu-v3.0.auto"

The words "client", "sid" and "ssid" are followed by a colon (":") but
iova and ipa are not.

Can you put everything up to and including iova on the first line and
the rest on the second line?
