Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990703CB2CC
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143340; cv=none; b=EM1z8c6uHMOlIhlRyaHfu39sGC26kI0VPvmLvKwG4Lg1ROP9yfXrWzMMRd0oiNPIucsJlm2csb0kHAannmDc7LBnAV8dXtR+Z2AIMql1hiVT7SvHa7rbc1ltoVyqeP0tBdRWcLyTBTGLzvd3e1O6yjEYLi7TacNpx+wGp8knj7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143340; c=relaxed/simple;
	bh=9KXUHzooZ6A4y0KMRUZR+/Wvmg2ePvw6LkNmcJ3n8rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNrytEQ6Cv47hOkMSlbE4WPc3yynqllMkufdAD5fcryi8SatTWymib/8eUEjT3OhjBGH3t4nTTMRs1bMcHoxDdm2R7UrMNwTTE7T04MSuGEQf0iKO4vxeVu72/BX+1B4P47GSN0IgQXpxItJJigZN6DakWNXN8zOjwKUKy9AgRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tfam00kY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tfam00kY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782143338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9KXUHzooZ6A4y0KMRUZR+/Wvmg2ePvw6LkNmcJ3n8rM=;
	b=Tfam00kYfJiVV2RmoqKOvI//mix3kAyee1+5XvsXPLRT64Hu9x6/Nal9IEmFwawGNEGcXJ
	Zv76RSuqzXwjKg5euQC0HzHRNuOrRZj72s+Rk/6oCZFSH6lKr67vkVwIBVzeUaISx2ySQt
	mT4Sz3bertQMGu/C6820tL7mMnNESfg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-dkMOqnfLMuOb5xrk4zIGpA-1; Mon, 22 Jun 2026 11:48:55 -0400
X-MC-Unique: dkMOqnfLMuOb5xrk4zIGpA-1
X-Mimecast-MFC-AGG-ID: dkMOqnfLMuOb5xrk4zIGpA_1782143334
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6a0f79bf1c0so2266051eaf.0
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 08:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143334; x=1782748134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KXUHzooZ6A4y0KMRUZR+/Wvmg2ePvw6LkNmcJ3n8rM=;
        b=QlsKQTH7XTORawF8jmeH0gtwdAP04Km+MvRDxi/O+6WP2rm8hB04bwXNYFi5jY38oR
         rlqiyvJ5WtcOnOg7fj5BJcbnJzB9cKfxRFQSWiEXVgxQ3UsF96McJPfdowAhz6VTU+NB
         aymHt4twWv8rn1vTzrG3fIIrlUpoS5x+ZYBr0+M+L8gQPiAQotnVdzpHCBZmw6Q+gvOn
         5+XfDvFljj79RWN8hBSRVrbORTcHTw5tMBDQvEBoybvtCb98AbNJCsoIVLUu4R1q6TQ4
         6ZCiIn9t1HqvbOo+PCaofJtYThTnSwlxsun2yIaz7CGJbHwtXlier+e7WDHjMmazi5pk
         WdUg==
X-Forwarded-Encrypted: i=1; AFNElJ/7PkmxaW9OJFxtJnBYUTpOt3rpMQop8YMI4OWhhP+NHNUymFrNQpTPIk9EFzDRu9Rl6QXLbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv/qoiKullCun8asJeRoy724P4hTt2e1epwqY4Q8UfbyWY8DAq
	3jERA+P3jiYGBXFSNGgybCSjl0Anhm9jO0HzlABoSYoDSz0HjI8w/4ZY0PKrCL4G5b1AUFK4GWd
	NwPp69KZeV+uGu8BFnQFLyMj2uOhOiM1Oxr3ekuv6U2nbDSVH2ZxIMFcGrQy+ztcDkCdyWRCarN
	R/aFckMV2aGL6omXTSXXPhHuXakZxn9cI=
X-Gm-Gg: AfdE7cnylQ0CpTachh9cHSVSADrsXNRo3vVHwO2SKgpO9HJZWI8rV4csBEejqR7vFxE
	Dsz9SNTNoOzKYIuYu2t3COf8DmlEDDWXa7wgKsiBYiF9hrYyQWOgvomkZJE+swgmxcY677QfVHs
	a5pwmgT61DOyyypRfH/EFRaTO7KwYrBsq60UJMyOzq2IF2QTEtlISsPbbiQqUD5hfbJdQSfpTlm
	QeOiBCbmYJcASffxCnhAi+fdoYx
X-Received: by 2002:a05:6820:8108:b0:69e:3c79:6e7c with SMTP id 006d021491bc7-6a0d8992909mr12978963eaf.46.1782143334525;
        Mon, 22 Jun 2026 08:48:54 -0700 (PDT)
X-Received: by 2002:a05:6820:8108:b0:69e:3c79:6e7c with SMTP id
 006d021491bc7-6a0d8992909mr12978928eaf.46.1782143334005; Mon, 22 Jun 2026
 08:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260430014817.2006885-1-desnesn@redhat.com> <20260503071749.6abda137.michal.pecio@gmail.com>
 <CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
 <20260503213111.117db3a1.michal.pecio@gmail.com> <20260504093118.615ff480.michal.pecio@gmail.com>
 <20260518083339.507e24bd.michal.pecio@gmail.com> <CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
 <20260522110328.0d3eecd8.michal.pecio@gmail.com> <CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
 <20260523022944.59799d83.michal.pecio@gmail.com> <CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
 <20260523102815.5c05c70a.michal.pecio@gmail.com> <CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
 <20260527103221.7f8b15b0.michal.pecio@gmail.com> <CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXaFbd=ySXf8E5A@mail.gmail.com>
 <CACaw+ewuPm-eOACKX3Ux0UwJBRSftoBm7H+rxE2Z9E7KzWb5ew@mail.gmail.com> <e9472b38-4a91-44b5-b75e-dc7abd23793d@linux.intel.com>
In-Reply-To: <e9472b38-4a91-44b5-b75e-dc7abd23793d@linux.intel.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Mon, 22 Jun 2026 12:48:42 -0300
X-Gm-Features: AVVi8CcAlAvfkd2ErCnICSEvqW5Np5KqWlEvhK2rTPgdX5mT-Gkc_TQT0VvBDf8
Message-ID: <CACaw+ewAk_fs7gw83kRJ=Gj9oSPLMru-txtbPohAttZEyn0qvg@mail.gmail.com>
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command timeout
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Michal Pecio <michal.pecio@gmail.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org, 
	iommu@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iPh4DaRG6ndJNf958vFvq5_xPbwUdWpGqu6MpvJDX2w_1782143334
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello Baolu,

> >> To IOMMU maintainers: should I send this patch to the iommu mailing
> >> list and move the discussion there?
>
> Yes, absolutely. The iommu mailing list is the right place to discuss
> bugs and fixes, so please go ahead.
>
> > I meant as a new submission to IOMMU maling list, since this started
> > in xHCI at the usb mailing list.
> > Of course, that is if nobody has any comments or objections to the patch.

Sure, just submitted this RFC as a new submission in the IOMMU mailing list.

Thanks Michal and Baolu,

Desnes

