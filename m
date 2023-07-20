Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A792FA35
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 17:49:35 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b8b4749013so7884295ad.2
        for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689875375; x=1690480175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8yROjrlp1PPFH0to9KuHuG8CxyzdAeh3ld6lplKCpw=;
        b=fyS7XMJPOaTP42oTe22seQohWF8aMbOeiPkaE4J2rWqXd1fUC0RtFqF+vTZPIJmLNL
         ri3EdeoE1FnRx13n5l+ni8jjeBnGqlLcaqfa1g4UteZwo7zVvXz2VCqdEf4edxKk0Lmp
         W24+7P6VC8EKDRSLRTzjFybQKN16HrMn+ukzGKtFc5+Q9gZIrIKaewXZXAFyEKYdK5F5
         gcp+xF0dnH6zhzNovfCSS4QhbIUL1na8WmipAbtF3FF/YRpO6YXrF1YjoeZtuG4Z7mNA
         fxflv1CyeRy/DmOw1Hm9chGK0mBPDP7svtXQYfW1EWYsP8X4JECAT43UnDtGkdcO4TgN
         L/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689875375; x=1690480175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8yROjrlp1PPFH0to9KuHuG8CxyzdAeh3ld6lplKCpw=;
        b=cencPsgoev16N0uqKshQXYQRHXToAgA0Z+3tIjOEWGJMkmNJB8S0X0z5wovDNuL43w
         cmCTMMv5b2Wrq5BHXdMJbpPH1YuCG9SxJpUNcR6TXzeFpUrrHElGfkGTiZVcyf1SI9UW
         OSBvoG1KGm1gaYmw5+i6VASC2CdmI0iWB9kzANbkssMGuefl+poct9h/Tam/peOD52eH
         9jIh2t9b9+oulfsvC/C3YB17kwwxwTLN4PCjDL+h+XZJuV5PWoHmgyzCqmI5CQ0RkDn8
         xnM2RyyWwhko0KTJ9MVC+xttj6EeVX/n7N48xef1UqqvcINcY7Ob9jUaNRaJO5gamEH6
         hF9Q==
X-Gm-Message-State: ABy/qLZkNyy1BD82r9vpZ36kdF0y9o58gpqdre2FR77i3BJ1jz7D+NNa
	f7rj7kUXAZLS8La/1Rz5CtkeC28M8e0Nre0U4P1Gfg==
X-Google-Smtp-Source: APBJJlEznZxAu+zz9Hq/h2JamBEIRqdk1o93ouW8Qs8XupLnxLYmEqfyZR8bRDDrnYiuby2sGUoNd8RNY4w9bloJSpg=
X-Received: by 2002:a17:902:a415:b0:1b3:f8db:6f0c with SMTP id
 p21-20020a170902a41500b001b3f8db6f0cmr94423plq.58.1689875375330; Thu, 20 Jul
 2023 10:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <d766f11f-45a6-9d47-3bfb-b3632a0b0f0b@linux.intel.com>
In-Reply-To: <d766f11f-45a6-9d47-3bfb-b3632a0b0f0b@linux.intel.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Thu, 20 Jul 2023 10:49:24 -0700
Message-ID: <CAH2o1u4Y5R16QQsed4TuKKiv6ir+uWB98A3Z5adBaF8pPLQ5Eg@mail.gmail.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 6:18=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2023/7/20 3:33, Tomasz Jeznach wrote:
> > Enables message or wire signal interrupts for PCIe and platforms device=
s.
>
> If this patch could be divided into multiple small patches, each
> logically doing one specific thing, it will help people better review
> the code.
>

ack. I've got a similar comment regarding this patch already.
I will split and add more notes to the commit message. Thanks.


> Best regards,
> baolu
>


regards,
- Tomasz
