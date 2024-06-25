Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74E16A945;
	Tue, 25 Jun 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332427; cv=none; b=NHrvEXbibUd4G3azC5FZ/9osvmzWgNp6HR0tAsQD09kroep/GbqNDqE7HK94YpsQb+CM0C/P3HL4YV1FVsri8J/NB+HBGZ38kmS3Wh+I1aUjQM8RzR3f2XRWteqlFw2cssoYdqlNH9IKwEcBm26OEIjFHhZYUkF6TJy6WUIkvQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332427; c=relaxed/simple;
	bh=b6/vKsj/PibxcS/6bXxbHOv4LLMxUEm/FlwcfPbufZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i14H2o0YSD/DUcR76A/3iQSaxlFnhVOvmaNhnnHTpkt2jXScsxrrhomlgspszmUyKpfIghtD/WaWfPZsWhoqKnHg1ttaSyfLhCAJ+aI2zm16aBQNybWhiR5yQJWeAVpFGVZTluj6d5VgZLq7JbDjIz5fOx7hrBNdvOg2ZXLkX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec6635aa43so18643321fa.1;
        Tue, 25 Jun 2024 09:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719332422; x=1719937222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9MwUhJ3rsg2znZ8HeUs9/evcb9sqY2gLgQOBc97ax+M=;
        b=SsiZNkpJrx5iTTErsPy9BcL/KkGwBL5dV78TAuQ5D9BJrDSeLOxPI3pvhO4WUG0qE0
         iDmfvXuqqymhsYdH3G0N3TrHO44oPtXRuDEWZ/aJgnvGNLFaHa5OkXzZjUz6noYx4NFh
         SJM16nfWshgLrkMlFlq7viXQQ1SMFtgl3foWsIKa0P85K+XDpBbiiwOU4fkT/ub6I08a
         CQKehVqmKUPtOw+knX38gzvJLexVy/OkFS1qezWKuF0BFZcnt8WfgmYZMFBULgx6skVG
         /j48KETcYciMYkesJZu/PTxsfab1QpftOfQZOB/UMudAkIiPY0ns+RadlgTgmMv/mO88
         Co9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBND7ShRaPC06YoxGp7B0GRIyaNyP7a5QrPCrQCALoMJPh1e4KEtBBVKBY+hpPsEJamYeAhiaYUx/A2oC65+pUmXioUs9C+AXZIDxIIEPGnezazCE+yFnJ0/MVJXJ5uiLLNw==
X-Gm-Message-State: AOJu0Yw4EuSQABRJl3g9j9/70BPkroaYT0j7nquswijxv43F8dm7Dj/C
	EJMumgdWlly5CEG0NEf0wdoSJPAyhSB9ZCJIDjjo5nblf7nWFZXROFItwBza
X-Google-Smtp-Source: AGHT+IEBXB6y82h4uzfNKSCHuZT5ZjyNq4zEyJs5ZuMbKWANvnGxsREEBPdsraSvuNBHT/SR8pbBCw==
X-Received: by 2002:a2e:8ed0:0:b0:2ec:839c:b659 with SMTP id 38308e7fff4ca-2ec839d37a2mr3795211fa.41.1719332421770;
        Tue, 25 Jun 2024 09:20:21 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec56001d2fsm9049381fa.65.2024.06.25.09.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 09:20:21 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec6635aa43so18642621fa.1;
        Tue, 25 Jun 2024 09:20:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgUSiIlsHS2zQjhMQSGIjG0XwcMY8ekINQpbgPGy2tB4HDM0jVxMm1Fhe0+EtLgooNx+sxyAQsbp1h2XkrV/LiymP9PNAo9w4Sbkz85+bM+Ld+xPUiDxyYc9BVe4egPDAmaw==
X-Received: by 2002:a2e:b0f3:0:b0:2ec:5785:ee94 with SMTP id
 38308e7fff4ca-2ec579fefd8mr53735441fa.52.1719332420352; Tue, 25 Jun 2024
 09:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240616224056.29159-1-andre.przywara@arm.com> <ZnqyDLMzND_qJiOl@8bytes.org>
In-Reply-To: <ZnqyDLMzND_qJiOl@8bytes.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 26 Jun 2024 00:20:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v64M_trcaXzef6=rbWZY-r_sv=bvoHngUeDVWjx+AXTy7g@mail.gmail.com>
Message-ID: <CAGb2v64M_trcaXzef6=rbWZY-r_sv=bvoHngUeDVWjx+AXTy7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] iommu: sun50i: Add Allwinner H616 support
To: Joerg Roedel <joro@8bytes.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>, 
	Philippe Simons <simons.philippe@gmail.com>, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joerg,

On Tue, Jun 25, 2024 at 8:03=E2=80=AFPM Joerg Roedel <joro@8bytes.org> wrot=
e:
>
> On Sun, Jun 16, 2024 at 11:40:51PM +0100, Andre Przywara wrote:
> >  .../bindings/iommu/allwinner,sun50i-h6-iommu.yaml |  7 ++++++-
> >  arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi    |  9 +++++++++
> >  drivers/iommu/sun50i-iommu.c                      | 15 +++++++++++++--
> >  3 files changed, 28 insertions(+), 3 deletions(-)
>
> Applied, thanks.

Could you back out the last patch? I'd like to take it through the sunxi
tree, which already has other H616 device tree patches.


Thanks
ChenYu
