Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395DA2D640D
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346976; cv=none; b=nBvmLKGizZypAun9/dLSC9mIAEBRS4mOqBrICxb3K0BjyvwJCUo9xjjICrO9fAw20XYhb9Hx9A76AMa7iFVpF8qI7DMJBzgobiQLUu0ZtrVMtBy3PmZs1nYIh87r9CbewmenhvOZfCAl/PIJkSdHBks3ndzi+Gq7ZVEUNJYFaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346976; c=relaxed/simple;
	bh=DiDU5kDNSMZr+Mxe770JushwLa5d5oXzQtjmkdtoPJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WptOBMYoKNkuQzpv3ddegGI8YBLUj/754Iua3SdG/t6Bzhmw9uRpke5mM37wiclJIBYIVri208EQb7B0WjV/Xc+QmKa9ui3k3v4u+cRue4RE8+G2Dm7ByC/oQ8Nr9xZ0ICuiCpHQWEmTqGJoVnQ/keI16So7ju+jIOSkzEdPFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cXOLIh7m; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cXOLIh7m"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-85cee530df9so26981685a.3
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759346974; x=1759951774; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DiDU5kDNSMZr+Mxe770JushwLa5d5oXzQtjmkdtoPJ0=;
        b=cXOLIh7mQR5r7TH4ZaNh7kbieo86mpNRVr2viWm0HMbATjJ7uTVfJ8TnCQTAny3qKh
         d4N2omnBrWRZYpOKIevSClzLJvr2j5rLnSXODUGiWbrSdyxd+biUVKh4oG+4TR45DgRB
         qP4efDe+7wr9M3B0v08ut9MAj9M5S4jbJLknWQ9AwCyp8NoNRQWnYXHwvmsx1jPinPq8
         eHWL0hDMxU0xrDY/33e8kCbEkeiDziaLgIulJAPK57cvzTcwpot0QlZKon9mRm9X1UDV
         SGw+2YKY2CJErI3X4eMVv3d09/NqUVjFWvNjgT9jfeX2d8LlISZXat/qhWrxAjxOrKrM
         edAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346974; x=1759951774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiDU5kDNSMZr+Mxe770JushwLa5d5oXzQtjmkdtoPJ0=;
        b=vJInG3VAhJ4EJtYJwwsqoWR3sE2KozRWY/pStWYJBgkCVJim2dSyjr4ZLVegnn4z4r
         UD2/pZYNWZ36RnxuuEP5DvvrbctOy+73Gy6utwzP1I+okqatUsa6rtthFSOtPrJhAegs
         GMWOUtr8fLUVWuAjg6CGqlQV7W4m0zf81/MqhKJSEhTtwbDNS55ue59a5QS7ni/5Gzax
         2qNoP5YhqZBEeHNBqYerODgVIoFRwm1zjN547YO3STOGC5gUdsk4E3XD1IYb3GuwINEy
         MYI0jB0NomSERuvmxWcDtk+iOAR6unF+RCIdhhMAUU1Sa0UPwOROnTJE56kt8l8kzTL2
         k2xg==
X-Forwarded-Encrypted: i=1; AJvYcCUr6zxJzhkXQop4XljyVP6cXhkEzPIF9FkgjVHQe+jRgN43m/k7W8Y2NrjLf9fguHRclLCb0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze9TnHixb9V1m+Vvvxth1E7pMitpsimpSAnHlkWpupL5MJdXpS
	6VcGRj8o/VhBpc6OjnLyNv2m6+sXcWrIK5xutuX4KmgWG+6uE7OhSeNZ1jZMaTMiKSJBrSVzwLc
	sHoKiBF9lNLzHQELv0gSgD9rqVa7OaaSKsLuPsBe/Zg==
X-Gm-Gg: ASbGncuPVShsPHDKrZUof8v6YA5HJ5Jb31gGUcbrbSVP60TkiH1wrJgTWPIlNp6vR3Z
	rlBpe3RyPRZ0HZEN12ECJzLoo5B3yAzjjm8pCOrMqh10ZpfirP5rLONn6l2LWOONj68mk44/6Ar
	Lo5gR+6WEmi8t5AvkZJ2ViEXsULyjcAyu5ftqKsZmBN3VTul76KTBXnLmAoNLvKy5LoSvLa4nC+
	D5T6NAkPwx7jNlqANnOs4X1nPHYPjFAtP84xXA=
X-Google-Smtp-Source: AGHT+IHLfUtJRDbSEiqp3HI8RohV/rxnmgmEUMJROYiapU6sPgPZbCtMF1schxAdaren0qy9DIa6IJf+JD4Oi5EVlp8=
X-Received: by 2002:a05:620a:46a5:b0:813:6c7:4517 with SMTP id
 af79cd13be357-87373014d2amr691418385a.38.1759346973949; Wed, 01 Oct 2025
 12:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
In-Reply-To: <20251001114742.GV2695987@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 1 Oct 2025 15:28:56 -0400
X-Gm-Features: AS18NWAgzH0R_qApV1olEBzdsQ5SwFOWeLqmballrV_7tsox0MHuJnbyv7tMWY8
Message-ID: <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

> > 3. On FINISH, the IOMMU core updates the context entries of preserved
> > devices to point to the new domain.
>
> No, finish should never do anything on the restore path, IMHO. User
> should directly attach the newly created HWPT when it is ready.

But, finish is our indicator that a particular session (VM) is out of
blackout, and now we are free to do slow things, such as
re-allocating/recreating page tables. Why start it before a VM is out
of blackout?
