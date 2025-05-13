Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC928D8EF;
	Tue, 13 May 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747138142; cv=none; b=alECWtMceMXnpp8B0CiUpRqLOkQTiTTADJrHcICuevMRr3dStbt59WI3GdtiWAqDNyFDYT4FmsweAky4k6KytjH8Dve1ea/Pu9ksQh8qNWcjF45uI/sDkt/fyDBK8j5L0PmVmP1wbHPc0gTvyMK0QjUIrHR/3SO7B/c6RwIIWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747138142; c=relaxed/simple;
	bh=2XUeh0Z5eCrhfaTA1VOhp1BRJwhiEmiLDGJ1gReitKc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqoeIXaRiS2ObBFwWN5ntMc/vey9+lyfsjdmHZFVmT6D8AITpsijTSPoanG/I2aBgWlwA3ORaLsHTQaIslJhlrbutSR2ibwSGiN55lCUsfgFr4MEUXZTquQUbuVnDsLZvcQbhY+DZuu9md+Mwfw152w4g5AQGlIv221mJw2JXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/wSBMs/; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/wSBMs/"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7415d28381dso4537661b3a.1;
        Tue, 13 May 2025 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747138140; x=1747742940; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C+fiwMr4DtCBa0BKgRSBqKM/6GNS1IOnhbc+D2U/YPs=;
        b=O/wSBMs/kn1puNsw+0Z7qe9KUfbHrW+86R3siI1fXmiOTAbV+/Etgv1G6am4MWdTDe
         OFndDxgnKbEVq1dixjJl+g3oect72sO0R4filTzHvNY3qLBCxMx7oLyvjBe27Zs8QznL
         09py1196RJgNfC/hpJPEgZr5KRglFpBPoUabtyFVuc4F6VpKUvN93cx13q+5aHBd2Jhc
         X1sEt1xjk7z0bp4rjC2J9KlZA3CHOsNYzsG6kIoecp/6I5pjsjcLNWtXkYBL4rHVTvE3
         GWzZ+2ZK88uSWrJ57lx5fM7SUj1FGQ/OEhBrR10lFMpYlEIRBZunum4Q8+xJjIkixLvF
         aXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747138140; x=1747742940;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+fiwMr4DtCBa0BKgRSBqKM/6GNS1IOnhbc+D2U/YPs=;
        b=occobj9Q2r8oBeUG3n0Zk0+91iaMjflDg3FqGNOLtTUWAJQrBCMcpT4flOmtgpfvJn
         cNrc1m8Yp7r/UhIZAgxlMue1aw/XrE5ZnLcTxzoInCPtykBWQghJtihQybUyf6SMn0fM
         D8gWtmntIg01ThvSxXCd2P3uVCJ1uGnCRS2yEFxO35g690YKD6wWli8xGYs4e4x1CRy+
         IBv/Hgc9V13Lh6tmVQaTSsfczwKwNUuWaaXuzuT7cOSgWPng4+khcrD0mc/+VOV9Xus3
         fMuTHr1AehUlIMObqBcJi2Zb3BxE96TiLCS6Z20rsSo1/CZ2ZNuLLN/DPpD6WYbosTum
         IhvA==
X-Forwarded-Encrypted: i=1; AJvYcCWXXGuqm7mdNEcCklq6hj4nCf+jCq4WKnPlPA3oYeRvkrEfpg6ctWkHE5NQLAGltVuGMhBd009OUGjxAAM=@lists.linux.dev, AJvYcCXV7yyIIxuifwod/g25FHLjOEwz8vbKc3tyQ017/SwzPIAuh7sgLzM+wEMKwY8OdATHIGqz/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YylzuNGPcAVhEcw4eVVxhHpJJM/lpAGGlc+RygPqOp1qAaGv5k5
	f3QhpHuxmqgnbc/8nNXuVu81u01ySqFXBnPHIAvsS5IV8Islfnfg
X-Gm-Gg: ASbGncvL8kQzCiaMbkkluFuJx6PQcHT0YSYs1tHKJrr297MA7vhkCukvo4K8fcu1x1z
	3co6+phWxeQUGURJsvbfPJlKr5DivMymV84l8ORqHEpvjWVf8xclafUt0lf/loPLgRh6UUXYv/0
	xN5EdEph7rdTGxdALPFsXmeR4fnI+FSIVe/3vZJo64UGe6FieMSafBFKyaTN4hBUpCxK/QeskBw
	LtiwMVyRyj1ORDx9/yjUvCpnSckascWZJJPZa7jCrK7Ghw2eR0IPCOWj4hK5/NzvUHjgyrM1APx
	T99VWauZI1s/Lrs79+5Y32YPskR38j3lpjGxaXFzOSCaCQ3jXhTDS0hshKfo7zatZZy68t0Qu93
	wXFFZdA==
X-Google-Smtp-Source: AGHT+IHJGLfjYB82MfeuCRiDY5iuey+WzblyJnDvkjQRynwrBn6xgBlO/6J7o/bSCimJvfFnIprkHA==
X-Received: by 2002:a05:6a21:3416:b0:1f5:55b7:1bb4 with SMTP id adf61e73a8af0-215abb0b768mr24877844637.11.1747138139597;
        Tue, 13 May 2025 05:08:59 -0700 (PDT)
Received: from localhost (58x12x133x161.ap58.ftth.ucom.ne.jp. [58.12.133.161])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2349ec816esm7161049a12.22.2025.05.13.05.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 05:08:59 -0700 (PDT)
Date: Tue, 13 May 2025 21:08:52 +0900
Message-ID: <eke7tt5oww4r.wl-kobarity@gmail.com>
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
In-Reply-To: <5d760ba9-031f-469b-96e0-a171b7142f88@linux.intel.com>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
	<PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
	<f1b41874-1535-4457-9747-eee3d816091a@arm.com>
	<PN3PR01MB959764E908600CD45169348CB88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<c0bbfcc8-1275-43de-be40-acb8f2653359@bfh.ch>
	<PN3PR01MB959708DEEA1567DD38447D5AB895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<eke7wmanw9xq.wl-kobarity@gmail.com>
	<089b2370-23e4-4a22-bf57-886e46247a1f@linux.intel.com>
	<eke7v7q6vxai.wl-kobarity@gmail.com>
	<5d760ba9-031f-469b-96e0-a171b7142f88@linux.intel.com>
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
> On 5/12/25 20:16, kobarity wrote:
> > Baolu Lu wrote:
> >> On 5/11/25 21:31, kobarity wrote:
> >>>=20
> >>> Hi
> >>>=20
> >>> I'm also experiencing this problem on my MacBookPro14,3.
> >>>=20
> >>> Aditya Garg wrote:
> >>>>=20
> >>>> Hi J=F6rg
> >>>>=20
> >>>> Can you test the kernel here to see if this fixes your issue:
> >>>>=20
> >>>> https://github.com/t2linux/T2-Debian-and-Ubuntu-Kernel/actions/runs/=
14944200356
> >>>>=20
> >>>> Alternatively you can try compiling your own kernel with this patch:
> >>>>=20
> >>>> https://lore.kernel.org/all/0-v1-c26553717e90+65f-iommu_vtd_ss_wo_jg=
g@nvidia.com/
> >>>=20
> >>> As far as I have tried, this patch did not solve the problem.
> >>>=20
> >>> By bisecting, I found that this problem was introduced by commit
> >>> 2031c469f816 ("iommu/vt-d: Add support for static identity domain").
> >>> In fact, since this commit, it will panic at startup.  This panic was
> >>> fixed by commit 6e02a277f1db ("iommu/vt-d: Fix incorrect
> >>> pci_for_each_dma_alias() for non-PCI devices").  So I applied commit
> >>> 6e02a277f1db on commit 2031c469f816 and confirmed that the keyboard
> >>> and touchpad is not working.
> >>=20
> >> Have you tried to apply commit 64f792981e35 ("iommu/vt-d: Remove device
> >> comparison in context_setup_pass_through_cb")?
> >=20
> > Yes, I tried it on yesterday's master branch, including commit
> > 64f792981e35.
> >=20
> > - Keyboard/Touchpad NOT working:
> >    - No patches
> >    - With patch in https://lore.kernel.org/all/0-v1-c26553717e90+65f-io=
mmu_vtd_ss_wo_jgg@nvidia.com/
> > - Keyboard/Touchpad working:
> >    - With my workaround patch
>=20
> Okay, thanks! Can you please try below change? I also attached a diff
> file in the attachment for your convenience.

Thanks!  The keyboard and touchpad now work with this patch.  I tested
it with the same master branch as before (commit 3ce9925823c7).
