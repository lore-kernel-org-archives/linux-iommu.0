Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D28182CE
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 11:29:57 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-314417861b9so5628830f8f.0
        for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1689074996; x=1691666996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/uH1e+klm+zs24dqIEDW59pXBhAgUeRKnnXFqc/9+A=;
        b=lYWgFyrTqV7V50Rqrv0wKkxXfRDoiDGtZkuRMugcuCf67af9LOxtgfH0nWOFtigNMc
         DrfaT8Mvj7sGkb4jSwTK4MJgbxqwS7ZY56dhzHbB1c5eGZehDdX9Hhbv+UdYVja6K9LX
         t4uvMaHMJA7d8cihItub2AMOB6vdcD+DDcPAxfz2rhwbspP6Iyp6hKI6QN5pGFlMkQfd
         5nsKsyZ5P5NQ3k6+Z0u2MTneJib8PsdQmapy0cu5JiZTQs/aaKjdKpgIdl7zN+MezXOF
         56hqC7tQucuGfM5sYqTs+8tb9HU63zizqdW+gncLCZrdRNQzT1xPuuCny9rxTK9/1OtW
         7+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689074996; x=1691666996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/uH1e+klm+zs24dqIEDW59pXBhAgUeRKnnXFqc/9+A=;
        b=ffw2yafV+vzMMHNkgYB43Rm6YfCz4R0pxRfgkf4Srr5ORcb5dRvDX3yRd0Mr6dM5pf
         PPEWsYBJrJ7293YBTx7zYSDbp0nrcmaWsRfIX65WYQwyZSsYmvEcAwdDf/V2w6W8l3y5
         GsYBxBNz6E8ZcdVN3tcJDeWbZDsFw4ttvrXj8odWD6o3Y1vXAbwiwkXI65kOBRT/b0+F
         vvWN+UDhTsbSop36baHf0H+G/UBk04yKdo0G0M+/eCjadUSV7dnY15WdFCeLQAhBbymA
         23ZUcD57kFVbWnRxfEqVI2xVMX1khJ/ojP4DMLKvDaRMXrCl13JIRl7o86zJAdlREKHs
         yqSQ==
X-Gm-Message-State: ABy/qLb+0d3doFyXVl40l1sF40hBMkUqhKlyQOOjAIS3oe7UO48So7Hz
	McVoiNVGaYPA6hF1TrB5vAeMe5H9gJHgkJtU9zNm+A==
X-Google-Smtp-Source: APBJJlG2PB2BAfr3M6geuBK8xXTGts8Ybwpe5accke8vRMt2XdyjsumKhw0BHM58Mw1yeP9s30wXJa84TA80uJ22jPc=
X-Received: by 2002:a5d:490b:0:b0:314:4db:e0b2 with SMTP id
 x11-20020a5d490b000000b0031404dbe0b2mr14911973wrq.15.1689074995947; Tue, 11
 Jul 2023 04:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
 <20230426141520.0caf4386@meshulam.tesarici.cz> <2023042617-wobble-enlighten-9361@gregkh>
 <20230426144439.5674f8bc@meshulam.tesarici.cz> <20230509091635.27450bd9@meshulam.tesarici.cz>
 <2023050949-grueling-verify-a43b@gregkh> <CAHbf0-HY0-u4MwgU39b53hjOM+bWfGmOEYQuvHARjV+6j+O7Kg@mail.gmail.com>
 <20230711110325.2521472c@meshulam.tesarici.cz>
In-Reply-To: <20230711110325.2521472c@meshulam.tesarici.cz>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 11 Jul 2023 12:29:44 +0100
Message-ID: <CAHbf0-FjiOAMHjh-7D_6gvS+oHr2tGKJArnYu=0AKYHbD8Ntrw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB bounce buffers
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, Petr Tesarik <petrtesarik@huaweicloud.com>, 
	open list <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Jul 2023 at 10:03, Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wro=
te:
>
> On Mon, 10 Jul 2023 23:23:45 +0100
> Mike Lothian <mike@fireburn.co.uk> wrote:
>
> > Hi
> >
> > I was hoping this might land for 6.5-rc1, is there a new version that
> > might apply against 6.5?
>
> Yes, there is a v3, which is a complete rewrite based on feedback from
> various people on this mailing list:
>
> https://lore.kernel.org/linux-iommu/cover.1687859323.git.petr.tesarik.ext=
@huawei.com/T/
>
> Petr T
>


Patch 2 doesn't apply cleanly for me on 6.5-rc1
