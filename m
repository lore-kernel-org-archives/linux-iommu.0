Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FEE189912;
	Mon, 12 May 2025 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747052222; cv=none; b=Li9Mct8iDrvF7OssELwM28Ndz8L9bq7kvDQBdMicvgnIypvl3mko1HXT6Pvf+i34YSl4sGUUX5Oup7ixhaSXxrWfxlswA7X4OE/HhKg2rX3Ho6J59qBwdu/muPnxToQbm4KnWuS6Wgka/p7XVFrhAvbCuT6Ytb78T/h/6mN+Jug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747052222; c=relaxed/simple;
	bh=mcT9W2XpGug/PF9XnYH8hrSTEA26BaaYyG5vLPJwSyk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AogndMfxWzSYlhpXnuWA+PtvtQio16UuEP1Z4HTkh/sZ9XFezH0ikbxKXXPp1n8xJuwjrIV/IgRI9P24GJtX/BGgm+A1S3i6neI+ZBgfzcpPT9y1LY0uMU8gwSGV9tFpgozlD6l/2sYa7gKcLR3qxCOYV/U4r/5c7A2HzhJQHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzismtoB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzismtoB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7426c44e014so607163b3a.3;
        Mon, 12 May 2025 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747052220; x=1747657020; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UT8FxHYTuZLnDZ/LUAeiM7+DFqtM+z3h97KfeLVmQsw=;
        b=EzismtoBg43CpGV81gmLGAOdAeT+XUFGTvfzQqBjkPrZwA4Vfgu/IvLl7qQ18hQMky
         GPG+t9ByRQp7msbMEj8uC/PZwfSeKmQUHUuXxN6OnJbLGcc7JepugialtvyXuNOPBom9
         eXEjqGcJCkNCvwky+viPQ5ZAyJ1EbVslouNe5u30FBSRkXsvyd0OEUYL5SMLUDtfHKMc
         726c8BfW+0gpVqXdDmgCbXi0jI07l9epBCaZ3afF3Dcoy5mhyO1b/0U8xSrOohVF232P
         vBmNFenSma9UDMDqgiUSmfXnWvWVtQzVxwdNcF2tBSEcxLgHaMwJO4oBCFnG/+m0Ewbu
         qTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747052220; x=1747657020;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UT8FxHYTuZLnDZ/LUAeiM7+DFqtM+z3h97KfeLVmQsw=;
        b=RGXpMPb6FExyJqSaEFL4/nKEVzoFdFspp4AWjd1AONG29z+02SepXrSI8ky6Vf9A4z
         gcQwBJSZfU6GnzaLJZ1zsd7rNtZGbqoDTRzGYzSjphr3iuzkx7oU8sraMCU/1kNyHrII
         6VtMAJD2drXdaMk3MsUJ96x7W8P+uDQsOSnXf1OLwbQwEUWCCZES0w0Vp2JyXvNQ4l+q
         QlWgrTKHM+cKTDtAdTht2segpZEKWzjN39OP5pqrX2FM8+/Q5maxWioTQ35GX5USpnfP
         dVCAMl2j70rdO56J+ACf+Z0LbD1Wd9c3G+V7G/FHVHUf0xIupyxmRSOYgrrSeAM4sQRy
         YbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9zLK3cd4AfE6H+mY/NkvbDS2BsKJpLLAk0lzjCKjxwRxvgNc5ASkQ2fiKmmWeTy/n7M/iOw==@lists.linux.dev, AJvYcCVXtSHvmsQI6h23ify/kmjOuIRsZFkHYYpxayXKbvuH5fT50pgeIKTDqh1hRwAKhL2FX57oWJ8sfhqDKSc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwhxTx7e5eIsgS2SKUVTunS9GsIFwkWLF3PWYzguXPWbEWRBEE8
	xAiCP1iuVyjOlBB0hkoV10ejr55BzUx+990Du49ZKphUxIzplLJQ
X-Gm-Gg: ASbGnct300C6CMo7RBNCjnAne2JnOhfKEuMcenRXkvu8KJh3GYsWMYU2orBFcnHa/XR
	Sf8IrIFzqIxuEo41iRNkfYLU2R/yrnEAHlVmmMlT/KhcRMiUUfg1U1k6puauqVQqb2jNcmnLGYM
	o5+pURxcg2CgUiiUGtFZgFU4vUy0XVKjehouCZPNsx5G9xhgiUN7h/dtNBhiHsiu9y7I//N3qlS
	opfVx/nFYXOplqqF/YleeiVob6W7SR/FHpsFJxQtlABlMXGFCLsFCALNPEKM1iNi1aCk6kGiPvH
	a1yXZJJqcfJukw+5tBe0Erv7u/Cg/PHv2OF1OiCiR7kKsauFNEIRbt4ZwYTGCFjb6luTX9yOcj7
	dW3qkTA==
X-Google-Smtp-Source: AGHT+IFlczZni4OBHuq4O/Qf3oTFzY2BdnjnEHkE4dmq/Vo7gt0d2DyGDIXpH0W7lsUp0iC1OeuuxQ==
X-Received: by 2002:a05:6a00:17a7:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-7423bc1d336mr19378195b3a.4.1747052220490;
        Mon, 12 May 2025 05:17:00 -0700 (PDT)
Received: from localhost (58x12x133x161.ap58.ftth.ucom.ne.jp. [58.12.133.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a3d3e9sm5865409b3a.125.2025.05.12.05.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 05:17:00 -0700 (PDT)
Date: Mon, 12 May 2025 21:16:53 +0900
Message-ID: <eke7v7q6vxai.wl-kobarity@gmail.com>
From: kobarity <kobarity@gmail.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Aditya Garg <gargaditya08@live.com>,	Berkel =?ISO-8859-1?Q?J=F6rg?=
 <joerg.berkel@bfh.ch>,	Robin Murphy <robin.murphy@arm.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,	"lukas@wunner.de"
 <lukas@wunner.de>,	David Woodhouse <dwmw2@infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,	Joerg Roedel
 <joro@8bytes.org>,	Will Deacon <will@kernel.org>
Subject: Re: [REGRESSION] applespi from 6.12 onwards
In-Reply-To: <089b2370-23e4-4a22-bf57-886e46247a1f@linux.intel.com>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
	<PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
	<f1b41874-1535-4457-9747-eee3d816091a@arm.com>
	<PN3PR01MB959764E908600CD45169348CB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<c0bbfcc8-1275-43de-be40-acb8f2653359@bfh.ch>
	<PN3PR01MB959708DEEA1567DD38447D5AB895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<eke7wmanw9xq.wl-kobarity@gmail.com>
	<089b2370-23e4-4a22-bf57-886e46247a1f@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/31.0.50 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Baolu Lu wrote:
> On 5/11/25 21:31, kobarity wrote:
> >=20
> > Hi
> >=20
> > I'm also experiencing this problem on my MacBookPro14,3.
> >=20
> > Aditya Garg wrote:
> >>=20
> >> Hi J=F6rg
> >>=20
> >> Can you test the kernel here to see if this fixes your issue:
> >>=20
> >> https://github.com/t2linux/T2-Debian-and-Ubuntu-Kernel/actions/runs/14=
944200356
> >>=20
> >> Alternatively you can try compiling your own kernel with this patch:
> >>=20
> >> https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jgg@=
nvidia.com/
> >=20
> > As far as I have tried, this patch did not solve the problem.
> >=20
> > By bisecting, I found that this problem was introduced by commit
> > 2031c469f816 ("iommu/vt-d: Add support for static identity domain").
> > In fact, since this commit, it will panic at startup.  This panic was
> > fixed by commit 6e02a277f1db ("iommu/vt-d: Fix incorrect
> > pci_for_each_dma_alias() for non-PCI devices").  So I applied commit
> > 6e02a277f1db on commit 2031c469f816 and confirmed that the keyboard
> > and touchpad is not working.
>=20
> Have you tried to apply commit 64f792981e35 ("iommu/vt-d: Remove device
> comparison in context_setup_pass_through_cb")?

Yes, I tried it on yesterday's master branch, including commit
64f792981e35.

- Keyboard/Touchpad NOT working:
  - No patches
  - With patch in https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_v=
td_ss_wo_jgg@nvidia.com/
- Keyboard/Touchpad working:
  - With my workaround patch
