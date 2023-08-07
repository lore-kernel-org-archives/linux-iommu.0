Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68399DF71
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 12:21:49 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-40c72caec5cso427971cf.0
        for <iommu@lists.linux.dev>; Mon, 07 Aug 2023 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691410908; x=1692015708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnwColYSZ3XmSl1bpZo/azPZh2FDVfUZk9ZS2ZdZQHY=;
        b=TrBQ8VPQMcf/qpu2cHmg21VlDcAedV3vTdiRn3i0+Z++5MnVbbmZt2LwsiaF8hPGeH
         S8aXQS1y6/nOEpe9yDnv3Jw4ELm+BRTP0vl+/21Sdys1mEuq3TEjkaSulf04pqlGiDbI
         QmtJ495Kx3G4Sb4NbEymFF5Ny0MX98J63MfNBAWb30Ya0/3o1i92Aq5MdRd+sNBFK4YA
         iduJ2jcZblqno1jApMd9ilSc8wACQPn8UQ3CYPgS79qVgnF0E0muO8KJ+UmOSkH36ysT
         2yd9A11hfvrWcHtcl42lHUc6ya7iFw2mn8JxqCu6mbG0p8ptJaetacngcT32umAi7zT+
         8EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410908; x=1692015708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnwColYSZ3XmSl1bpZo/azPZh2FDVfUZk9ZS2ZdZQHY=;
        b=UfkM1FWFkQRUR2sjUhll2XJPmXu/sOl129lg0KkE4gvwL67YLJaHdg7J3wzSdtIfFP
         n1yDerKFxOef4yeOxWyIVuNAl2oXaSS7VbxmGH2tZrmcoUbl7Y40rn94Q+DrbY44GMuO
         M3VvGj/1v0ajJ7LZJ62GFmaf4U3Ok+TcVJQuhP5hHLVw4PVfJ5t1OViKnAWg8NAYS9BF
         W9jRGMZAthk2k7MokgEUexhAi5yGgnlMvLGAeE2AMeHhql6kfJ3yNOL4gr20ZUM0rJoH
         dpRNuKQAgCKFuMJiZgwbNGCAbkg9r7+DWh31edqGhgWoJhk6I+rXvF9F4SIGOL+KT5s5
         c4dQ==
X-Gm-Message-State: AOJu0Yx0FRwO/Y2HI88SxcM5vmz38ciWaoAcNAd7TePxO0GXr8T7hkJH
	4IZ8XRVRMXkCeCLvji4aMkTR1aDIXL5O3EXQYVlLlA==
X-Google-Smtp-Source: AGHT+IEMLGULSlVZult/2Q3+afbrOjHWrJzvVVPqLYP1dw+AFfKzXE4tHKlAfTJFU/sZEnAsMyMyNJU3jhfdP2K/sgI=
X-Received: by 2002:a05:622a:1891:b0:403:b6ff:c0b with SMTP id
 v17-20020a05622a189100b00403b6ff0c0bmr395515qtc.6.1691410908040; Mon, 07 Aug
 2023 05:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com> <20230803003234.v4.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
 <ZM2Ki7MDsNLkBEQ9@Asurada-Nvidia>
In-Reply-To: <ZM2Ki7MDsNLkBEQ9@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 7 Aug 2023 20:21:12 +0800
Message-ID: <CAKHBV27vPc0mS14oz8nAbrm+bVKeMmtYt5YVU_abkFZEuqmN=A@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd table
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, robin.murphy@arm.com, 
	jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 5, 2023 at 7:32=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> w=
rote:
> It'd be nicer to spare a few more lines here -- something like
> this yet feel free to rephrase:

Yeah you're right, this commit message was pretty sparse. Will update.

> And btw, you should probably put your Signed-off-by at the end
> the commit log, i.e. behind "Reviewed-by", meaning you created/
> updated the commit, and then signed it off.
>
> Nicolin

Ah, thanks for the tip, will do as well :) .
