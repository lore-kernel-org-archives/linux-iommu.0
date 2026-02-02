Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B43563F7
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073227; cv=pass; b=H+9atWtkthlnVqeZgKmt701tgqcIvcrVeFLkUS5YZG3/cpwoS5lgO2iBOR+t16m/2QAVxjkqtrijFl4n2INm/ItPLMIiwE1g3JoAu3SS7xm6h5Ylms1FHQ3BSlYeB1krAIUsywziT0BjYVayuT6sgzOjbz0fz2yZQjnE9FXF9VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073227; c=relaxed/simple;
	bh=9AzK+os/lgSg1CiRrO+I0MUKa7EQTWNrJKALfvzLWx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMh4cGqLMzgulz+UHUHWxoUtSrUO2uuZK4XfEHoVMUIsjNuSd4l7C2uog4OURXZpnh+Qp3dwhmj0OlFd3UKY8JePch2CiSXf3wweyH/3LrI9amQNUN0bJQi3yHhjwxsPS9+sqRodsI/5JjYJWYIxYBzX+r24+XkzeiDDrI8+BDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dee5je0I; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dee5je0I"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014b5d8551so68671cf.0
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 15:00:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770073225; cv=none;
        d=google.com; s=arc-20240605;
        b=jp49e9dEDdXxsMvmoU0u5ZB5n0LAxMVOP9x9E4E6vKDDsHGi2+2+qYdwP1K4gq8Or/
         gEY/F9XDlIiUtPkDSXTHU8+cbp0nzjQMx/SyfUmge69a9Q32KPtfT0FAd1HF81S/05XM
         xp/MQIWOjf5h0eclb2hb23abc4AdU/LdxhzIKsr/URORGqWnBM4ecsIhkcE5OqnlZcXG
         QL3FgwBrrs+36YlxYHo6J9qnj+p92A9APeRogNucUTr1x9hoL76EtUkT0OzPFj/8i3b4
         qdl/7c2aABwEqXsFieQ9jolfKMh1nGfq4Dhjo1HZ+MOxN7UIPNwNngOsnqcF1C8KuBg4
         NLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pidlYzygBXsl2eN3/OZt5dOCVpR9+38WSAxJRCkM3ys=;
        fh=xNGBVmtuItDU5dRSGEGXbiHONoCyBOdYOdrHZ2kpbc4=;
        b=ALkXyCFw/Rz58J5VU+svIyykrtJ29RnxyRQ0e+0hXIZsqob79P9eO5DPq4dU7Cl6Hx
         Az5wVThQHFBy0GZKlLJRnye2llrbZPNHhxYIbdaMVS2hnG3GoU+LGnchbColk0hJShUB
         k10hH4483QjOzQ4VX2JEQs+n9AcQKjAcVCqaXZSqE5CQVJAokDAke43WB0350LAGgWV4
         NCHzdqulYY07MmJQxq1MANKIEbsj202u435K+7LtW91A3wrwVKkB0nbNQFWtxUXxAxse
         zBUkleQQOZY5CGTvxyky6pDFCZ13i61yFqNa0Z/qAJ105m5/aLwETPvLDMfye/lArLoy
         pwMg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770073225; x=1770678025; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pidlYzygBXsl2eN3/OZt5dOCVpR9+38WSAxJRCkM3ys=;
        b=Dee5je0Iy+xNwDMBLeUSQMU9HSE2XUStbPzNUYc5YHoW8gbWBXWYPaz9np+9+dHoG1
         +0ev0J35HCHVrlB84TBNbTtMKY7xJO9Kfyn7AXcvEe6JxNYGI4/uWa1ePrz+BL+l2xik
         jVb5rRwSJejARQWnZ39ep3uwureSHSyyBdavP09jf94ivfn6gSfjE1DbnD4EpZA104P8
         y1ZNYVFcAnLQXTwyKCQXEh2QSr/ptoDrQHILisrJsE1JiBYMBNJh6pmpKCv8LjSVwXtA
         uAJRXuMZEfl1Xe/yLqVTqUiLpCqnJSrxH9GbJM4/B9KD1dkra8HaEYa8PkihL2+cwpM8
         lBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770073225; x=1770678025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pidlYzygBXsl2eN3/OZt5dOCVpR9+38WSAxJRCkM3ys=;
        b=h65UwyL+sMeBTANZmkCJRGSvjH1dg7XKrQmnJefmYfyGgbYu9+g5VcKd6t1oxQgAfv
         K5gA9HyxDcVo3QeMEMbkv2sAnpnp8kisgbiizK8MdwlOFgwXu+YlpovEnIUX+e+adjiq
         SKa1taSS6ALeRGjlwknykiaLhYvU3lILGS1+aMRQiUgti1obAXHp6Y4QF+bTPoYs7P+w
         5rqpkVniI6Gkcvz/X9+339u2ulgV1BXsIHXz6KIgZagPLwXW640Q1SItsJVuP2AKcukY
         3q5jNrGSU/P4ekmto83Y8AWR/HBqbD/Vo+M5WTNRwyWdK0gMaHgzMTbiOmJhxx6Afw93
         acfg==
X-Forwarded-Encrypted: i=1; AJvYcCUOatt3S/Db1hrooE7LP2vjFycXXa3wAlL52dRapXSPOsG1RPSJAPcRmqxzg+3YCJBwuKGzfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVCDWSGQTCKBwveGK1DWbwzV7wUtTKC0UIVCOYiRBOphyD7hkI
	oBlKWJng15qWBZmaaYUo4iIUVvYe3BW605PUA1irHTmxGCErMmMWbtTZkBRbk5KXe29aWs65Loo
	pdUDLdsAFV2tMcNlxcueuft9DC0L4711bsB8i6N23
X-Gm-Gg: AZuq6aJBu4yqrTpZx3WJwIoDxkX4OnyruSQm3zPGXMbnDwSErx5E9SlFuMH2Cs9Ryr7
	HPHHGyS5YRH75eJDcxdzXr7FHnNF8IRxR9LZkslDzpfWHYsC9BXtSzp3HTvP3fU/jOoXvEK6hPB
	quo4QrYc1d4CmE3IA59j5gPUbtm4b44BOF0wfdfPDEJEXx71X5ChRBEbdzfhs15AhYtURx12i7m
	xwbA/FE+lWvYCr8IdEka0xFpq51VhUsfXWBvEcvqKcwK1CRXHTfxwyVEFN9jBqmXX9lpjpbn4ze
	RYqHKyRKD5K8OgdRZMOezzRycw==
X-Received: by 2002:ac8:584a:0:b0:503:2d8f:4cd9 with SMTP id
 d75a77b69052e-5060a24f407mr3796721cf.16.1770073224683; Mon, 02 Feb 2026
 15:00:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com> <20260128195943.GY1641016@ziepe.ca>
 <CAAywjhRXwRD7rmZ2DjN2roDMvWCV2772KhM2hox5RE8Prt4nxw@mail.gmail.com> <aYEpHBYxlQxhXrwl@google.com>
In-Reply-To: <aYEpHBYxlQxhXrwl@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 2 Feb 2026 15:00:12 -0800
X-Gm-Features: AZwV_QhLkCbQ7NI8BtH2-_H0kOWcUJfEx3pMqdWvoRmFoEQipvrVTCX9IKISJFE
Message-ID: <CAAywjhQBS1xCSJeTK-X1ThbAfJ4zW3Kwe7me2Nwt3dmGCEfWEQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/32] Add live update state preservation
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 2:45=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2026-01-28 05:11 PM, Samiullah Khawaja wrote:
> > On Wed, Jan 28, 2026 at 11:59=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> > > On Tue, Dec 02, 2025 at 11:02:30PM +0000, Samiullah Khawaja wrote:
>
> > > Start off by just making the successor kernel fail to accept any
> > > drivers at all because the iommu_domain was preserved. ie restore the
> > > domain and set it as the default_domain and then fail in
> > > iommu_device_use_default_domain() and related functions.
> >
> > Right. In this model, the device would remain unusable after
> > liveupdate as you cannot do session finish. So the only way to recover
> > would be to do a proper reboot. But I think this is a great
> > intermediate step.
>
> This will break the new selftest vfio_pci_liveupdate_kexec_test that is
> added in the vfio cdev series:
>
>   https://lore.kernel.org/kvm/20260129212510.967611-19-dmatlack@google.co=
m/
>   https://lore.kernel.org/kvm/20260129212510.967611-23-dmatlack@google.co=
m/

Yes. the test will fail to bind with the new iommufd. I will send a
patch with modifications to the test.
>
> And having to reboot a machine back to life after every Live Update will
> be a painful for everyone working on VFIO, PCI, and IOMMU Live Update
> support.
>
> I agree with wanting to do incremental steps, but can we target that the
> intial iommufd series supports an e2e scenario that doesn't leave the
> host (or its devices) in an unusable state?

Agreed. In that case, I can send a couple of extra patches with phase
1 to restore iommufd and discard the iommu domain on finish if it has
no attachments.
