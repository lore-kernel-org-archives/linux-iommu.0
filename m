Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25A23EAAD
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873070; cv=pass; b=NlG+fIQbsLPJZdFpQ8yLiU9MqQgz2xH3mVgTXc4cu0X7act74DeODHA42e8K4xO8WUGW/woM3qrQ46trvnLrwSy7DkAA8U0lOD6lERcyTTY2Ky6bGbnyOVUFgoX1baazn03RCFpcCyM+2vbqi2CnqHd4IXcRDe9vKZS7iG0Hvzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873070; c=relaxed/simple;
	bh=OFD6NUQfqB5lbYiIMDtP4O+JDI3QL0PIMq1HidCRagY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L58CZIIfzdWrQnSSGLhMh15BX/mu9PDXM5YYkFRSJE6PEm156thL4W7RgOEDc558BpOGHzV8iZBN7gVLqahiXSz9vTFLDqrV76SgF7dbHC5/aHsPX1XivKO4G1hhnALXwaBPYNqBKt7ztdbWSYi8iWpsIZNg9RCatoD4akDFrZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxnHLloh; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxnHLloh"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3870c7479c6so37166201fa.3
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 10:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771873067; cv=none;
        d=google.com; s=arc-20240605;
        b=WRqcsjvCMbsYi6r8XC1BC1vc70MivMYP3Cdx88XJfAvkJIKcMwvj1pxeyeEmByRbAA
         93xUkBuOl/25vGg7rwjPL+izcO/X5Kg7Ys1+pUyqkcxwW2WAP93at4KgYY7/YCRPpPPA
         91OaLF83NIsJ39YEKeH0OMECxdBLq8wV4qQcorQ2487Lv67JxuruChC9N68wWhc391jA
         vljbkFEU5X8p9qpLFls5Ql8thOWJueTzVRVBrz9LBp1AjP9T6ni6jvWekyENK9mAwTF7
         3ZGSKI61kPInlieV2tcQY/trx5Q7KpC+Pe7J2/Eno7gobtpwFs8oOD7oIxciP3QuBNYy
         sQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f/DOHd9CpHSCbT+LNTCI9j3eLuodht0W+GmwsJ9Rdho=;
        fh=blEf7yN2z828WOHy1+cgP6+Xm4lnwBNKnVg7KgLDnKw=;
        b=cLtje23J0iBLcweoVTX/2VgGNolsysbtRs+/+LKZ93P9peF4AIAISjpjqQqAATU2ma
         +bLt99OxaTVQkgU1leLRa1qtkN27qtlrgpATd9GTYR4EKZu/CPCznhGjOH2Apb0BYu/L
         sS1sg1uD0PcVkBxqjLeTFzfS6Czxw2+cH/cm5AfmVuejt+aRJAhaAF9G9V2Lxm2MGtfh
         YbEl/utfgZsiepU6pMFfAhx/yyD27NDvgaXeAoc5b7kLom/eNklopaHWTj3lUPoJiKW+
         6cZGY5/RK6uKi2PJdwkkwWqagIbfrLKYwZVCEJYzSjLlAzLnRgdb1vYpDucfIqrXFThp
         5RGw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771873067; x=1772477867; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/DOHd9CpHSCbT+LNTCI9j3eLuodht0W+GmwsJ9Rdho=;
        b=JxnHLlohkYWHz6lPDeL+9RhhPzySfubL0wVvCSjM02krNvg8Rsix3Te+izcjOz7XFY
         cKK0p7/T5Xo1PHJGspFsj8H2xGKaL6xhkUnluCh8fAvCWk2oaUySP1p9qbGsOyQCo/Jr
         MXRT4PzvhWfab0lhkw+JN2iJIe75+S30Q0W8cynsB+TKZB119317Jiib8BBCl90K93v+
         gZ72zIOG+XtWUjZFbwJ4381eHCYk4R56JeGge82hCon5PyfAwib2t7fW75A4feK0LL6t
         potBXKEby+IAr8SyuLBXLvFmak9xTn8TxVxsfph9/X9Rli/F4/GEROsH34SwpxpiDfdo
         OOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873067; x=1772477867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/DOHd9CpHSCbT+LNTCI9j3eLuodht0W+GmwsJ9Rdho=;
        b=M1YBcryuDnCgx8vQbQjBHjFy/YWZUAm1ryB4rqX6JATbpHKyJBjRNORyXog31C9kzZ
         wXCJ/Bt/aIBz07Iw9OckeDe+jPphZEn9cy6tg4/ngrgutb2eaiPmeuORVVePUkpS+bd1
         mmz2c6RO0fsl9niLyNuJKMR9E1aY/GjxVS5SXxemZmbzmn8LfELvvlBVJVOhwUzioth/
         /9EM1bL95Bj3ZY/Glo42b7cL5MGQJ6DM93NNfMFLZwWq01tToN9lYQrnYR22aii+VAMC
         YMG0nfEz9PePPkqwbzQAOXOlnZfw7q2ugT3m5xp3NrNoEU3Pu4hdVAEYki0WLz58rvrX
         +rBA==
X-Forwarded-Encrypted: i=1; AJvYcCUImqb1tsJFXE8q2oJOOFwoy7MOH9RMkevLnL28NRTf9X/UWGPRSbBLYzklzl9xhCM6925gqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLtLWLGqGg/juRDehspXSbGeRnbUqj8Ng1JeLw1/9Gl1NwVuY3
	OIqlDB2IQFUeBVJitPWcwE2jqoGYp3OTvicpJgoI+6/F6WU0EvQcVV+elufGrT9nWAq/BJ8YZP1
	uuy5jlu3fULvAvh1rwY+vEpQoQ22M7fURzZ6T0MzG
X-Gm-Gg: ATEYQzwCXh6gD2+1V052itjnS2AfaNSHOPz9TCkMt+5UhGxmdt1i3PJI5y/rjVb3vjK
	Jy6skWmlO51fHecBeq0ef+y8g9Duq24Xx4/Ry2ZYhBHKYROnDFuvLqoHLtXoWq6u4HDo/cBv+iL
	6MXT8U8W0PCv+UdyWw/7OVdXOTb7aZI6Me+WJsL/kh7bdFlzA2h16R7KFgY5r1YTSLatwKIpkdu
	ijJXJd4z6JsaZlbWYHnUYHl0v+TfyCA3NzFTWxFSeuuSxyxPi1IsD1UCq2g4mbN72GG9GFQLqwt
	A80f3GYmAvJddHMJ5A==
X-Received: by 2002:a05:651c:41c7:b0:383:1b4b:c2c8 with SMTP id
 38308e7fff4ca-389a5e8e30bmr24927701fa.41.1771873066594; Mon, 23 Feb 2026
 10:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251210181417.3677674-1-rananta@google.com> <20251210181417.3677674-7-rananta@google.com>
 <aUSNoBzvybi24SUD@google.com> <CAJHc60zAB8pyc7=ca=eOf+SEEvnZ3JxVEnZoOtgj+mX1GQiALw@mail.gmail.com>
 <aYUQ_HkDJU9kjsUl@google.com>
In-Reply-To: <aYUQ_HkDJU9kjsUl@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 23 Feb 2026 10:57:18 -0800
X-Gm-Features: AaiRm51xsX0sj5UKMqLZlpyRZUJezvA_WLsNNCIJwPOLAaI4oJzjAEfrZMVWw2o
Message-ID: <CALzav=fBjW5zN+oOc61ZB69N1dRPFEuYJH=YsD9jYmqwXkKeAA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] vfio: selftests: Add tests to validate SR-IOV UAPI
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 1:52=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
> On 2026-01-06 11:47 AM, Raghavendra Rao Ananta wrote:
> > On Thu, Dec 18, 2025 at 3:26=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > > [  574.857650][T27935] BUG: kernel NULL pointer dereference, address:=
 0000000000000008
...
> > > [  575.009753][T27935] Call Trace:
> > > [  575.012919][T27935]  <TASK>
> > > [  575.015730][T27935]  intel_iommu_probe_device+0x4c9/0x7b0
> > > [  575.021153][T27935]  __iommu_probe_device+0x101/0x4c0
> > > [  575.026231][T27935]  iommu_bus_notifier+0x37/0x100
> > > [  575.031046][T27935]  blocking_notifier_call_chain+0x53/0xd0
> > > [  575.036634][T27935]  bus_notify+0x99/0xc0
> > > [  575.040666][T27935]  device_add+0x252/0x470
> > > [  575.044872][T27935]  pci_device_add+0x414/0x5c0
> > > [  575.049429][T27935]  pci_iov_add_virtfn+0x2f2/0x3e0
> > > [  575.054326][T27935]  sriov_add_vfs+0x33/0x70
> > > [  575.058613][T27935]  sriov_enable+0x2fc/0x490
> > > [  575.062992][T27935]  vfio_pci_core_sriov_configure+0x16c/0x210
> > > [  575.068843][T27935]  sriov_numvfs_store+0xc4/0x190
> > > [  575.073652][T27935]  kernfs_fop_write_iter+0xfe/0x180
> > > [  575.078724][T27935]  vfs_write+0x2d0/0x430
> > > [  575.082846][T27935]  ksys_write+0x7f/0x100
> > > [  575.086965][T27935]  do_syscall_64+0x6f/0x940
> > > [  575.091339][T27935]  ? arch_exit_to_user_mode_prepare+0x9/0xb0
> > > [  575.097193][T27935]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> I think this is a use-after-free.

Fix proposed here:
https://lore.kernel.org/linux-pci/20260223184017.688212-1-dmatlack@google.c=
om/
